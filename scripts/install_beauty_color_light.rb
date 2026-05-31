#!/usr/bin/env ruby
# ROBOT

require 'fileutils'
require 'json'
require 'optparse'

SCRIPT_DIR = File.expand_path(__dir__)
REPO_ROOT = File.expand_path('..', SCRIPT_DIR)

SOURCES = {
  global_theme: File.join(
    REPO_ROOT,
    'Beauty Global Themes',
    'Beauty-Color-Light'
  ),
  plasma_theme: File.join(
    REPO_ROOT,
    'Beauty Plasma Themes',
    'Beauty-Color-Light-Plasma'
  ),
  aurorae_theme: File.join(
    REPO_ROOT,
    'Beauty Window Decorations',
    'Beauty-Color-Light'
  ),
  color_scheme: File.join(
    REPO_ROOT,
    'Beauty Color Schemes',
    'BeautyLight.colors'
  ),
  wallpaper_png: File.join(
    REPO_ROOT,
    'Beauty Wallpapers',
    'Beauty-Light.png'
  )
}.freeze

WALLPAPER_METADATA = {
  'KPlugin' => {
    'Id' => 'Beauty-Light',
    'License' => 'CC-BY-SA-4.0',
    'Name' => 'Beauty Light'
  },
  'X-KDE-PlasmaImageWallpaper-AccentColor' => {
    'Light' => '#5e81ac',
    'Dark' => '#5e81ac'
  }
}.freeze

THEME_NAMES = {
  global_theme: 'Beauty-Color-Light',
  plasma_theme: 'Beauty-Color-Light-Plasma',
  aurorae_theme: 'Beauty-Color-Light',
  color_scheme: 'BeautyLight.colors',
  wallpaper: 'Beauty-Light'
}.freeze

def ensure_sources!
  missing = SOURCES.select { |_key, path| !File.exist?(path) }
  return if missing.empty?

  details = missing.map { |key, path| "- #{key}: #{path}" }.join("\n")
  abort("Missing required source paths:\n#{details}")
end

def wallpaper_metadata_json
  JSON.pretty_generate(WALLPAPER_METADATA) + "\n"
end

def local_destinations(home)
  share = File.join(home, '.local', 'share')

  {
    global_theme_dir: File.join(share, 'plasma', 'look-and-feel'),
    plasma_theme_dir: File.join(share, 'plasma', 'desktoptheme'),
    aurorae_theme_dir: File.join(share, 'aurorae', 'themes'),
    color_scheme_dir: File.join(share, 'color-schemes'),
    wallpaper_dir: File.join(share, 'wallpapers')
  }
end

def install_local(home, dry_run: false)
  dest = local_destinations(home)

  puts "Installing Beauty Color Light locally to #{home}"

  mkdirs = dest.values
  if dry_run
    mkdirs.each { |dir| puts "+ mkdir -p #{dir}" }
  else
    FileUtils.mkdir_p(mkdirs)
  end

  copy_dir_local(
    SOURCES[:global_theme],
    File.join(dest[:global_theme_dir], THEME_NAMES[:global_theme]),
    dry_run: dry_run
  )
  copy_dir_local(
    SOURCES[:plasma_theme],
    File.join(dest[:plasma_theme_dir], THEME_NAMES[:plasma_theme]),
    dry_run: dry_run
  )
  copy_dir_local(
    SOURCES[:aurorae_theme],
    File.join(dest[:aurorae_theme_dir], THEME_NAMES[:aurorae_theme]),
    dry_run: dry_run
  )
  copy_file_local(
    SOURCES[:color_scheme],
    File.join(dest[:color_scheme_dir], THEME_NAMES[:color_scheme]),
    dry_run: dry_run
  )

  wallpaper_root = File.join(dest[:wallpaper_dir], THEME_NAMES[:wallpaper])
  wallpaper_image = File.join(wallpaper_root, 'contents', 'images', '1920x1080.png')
  wallpaper_metadata = File.join(wallpaper_root, 'metadata.json')

  if dry_run
    puts "+ mkdir -p #{File.dirname(wallpaper_image)}"
  else
    FileUtils.mkdir_p(File.dirname(wallpaper_image))
  end

  copy_file_local(SOURCES[:wallpaper_png], wallpaper_image, dry_run: dry_run)
  puts "+ write #{wallpaper_metadata}"
  File.write(wallpaper_metadata, wallpaper_metadata_json) unless dry_run
end

def uninstall_local(home, dry_run: false)
  dest = local_destinations(home)

  puts "Uninstalling Beauty Color Light from #{home}"

  removals = [
    File.join(dest[:global_theme_dir], THEME_NAMES[:global_theme]),
    File.join(dest[:plasma_theme_dir], THEME_NAMES[:plasma_theme]),
    File.join(dest[:aurorae_theme_dir], THEME_NAMES[:aurorae_theme]),
    File.join(dest[:color_scheme_dir], THEME_NAMES[:color_scheme]),
    File.join(dest[:wallpaper_dir], THEME_NAMES[:wallpaper])
  ]

  removals.each do |path|
    puts "+ remove #{path}"
    next if dry_run

    FileUtils.rm_rf(path)
  end
end

def copy_dir_local(src, dst, dry_run: false)
  puts "+ copy #{src} -> #{dst}"
  return if dry_run

  FileUtils.rm_rf(dst)
  FileUtils.mkdir_p(File.dirname(dst))
  FileUtils.cp_r(src, dst)
end

def copy_file_local(src, dst, dry_run: false)
  puts "+ copy #{src} -> #{dst}"
  return if dry_run

  FileUtils.mkdir_p(File.dirname(dst))
  FileUtils.cp(src, dst)
end

options = {
  action: :install,
  dry_run: false,
  home: File.expand_path('~')
}

parser = OptionParser.new do |opts|
  opts.banner = 'Usage: ruby scripts/install_beauty_color_light.rb ' \
                '[--install|--uninstall] [--home PATH] [--dry-run]'

  opts.on('--install', 'Install Beauty Color Light locally (default)') do
    options[:action] = :install
  end

  opts.on('--uninstall', 'Uninstall Beauty Color Light locally') do
    options[:action] = :uninstall
  end

  opts.on('--home PATH', 'Override local home directory') do |path|
    options[:home] = File.expand_path(path)
  end

  opts.on('--dry-run', 'Print planned actions without changing files') do
    options[:dry_run] = true
  end
end

parser.parse!
ensure_sources! if options[:action] == :install

case options[:action]
when :install
  install_local(options[:home], dry_run: options[:dry_run])
when :uninstall
  uninstall_local(options[:home], dry_run: options[:dry_run])
else
  abort("Unknown action: #{options[:action]}")
end

puts 'Beauty Color Light operation complete.'
