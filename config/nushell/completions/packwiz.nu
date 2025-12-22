def "packwiz-slug-completer" [ctx: string] {
	let pins_only = ($ctx | split words | last) like 'unpin'
	let files: table<name: string, slug: string, pin: bool> = ls **/*.pw.toml | where name =~ '(resourcepacks|shaders|mods)' | each {
		open $in.name | insert slug { $in.name }
	} | select name slug pin?

	if $pins_only {
		$files | where pin | each { { value: $in.slug, description: $in.name } }
	} else {
		$files | each { { value: $in.slug, description: $in.name } }
	}
}

export extern "packwiz" [
	--cache: string              # The directory where packwiz will cache downloaded mods (default "/opt/buildhome/.cache/packwiz/cache")
	--config: string             # The config file to use (default "/opt/buildhome/.config/packwiz/.packwiz.toml")
	--meta-folder: string        # The folder in which new metadata files will be added, defaulting to a folder based on the category (mods, resourcepacks, etc; if the category is unknown the current directory is used)
	--meta-folder-base: string   # The base folder from which meta-folder will be resolved, defaulting to the current directory (so you can put all mods/etc in a subfolder while still using the default behaviour) (default ".")
	--pack-file: string          # The modpack metadata file to use (default "pack.toml")
  --yes(-y)                    # Accept all prompts with the default or "yes" option (non-interactive mode) - may pick unwanted options in search results
	--help(-h)                   # Help for packwiz
]

export extern "packwiz init" [
	--author: string             # The author of the modpack (omit to define interactively)
	--fabric-latest              # Automatically select the latest version of Fabric loader
	--fabric-version: string     # The Fabric loader version to use (omit to define interactively)
	--forge-latest               # Automatically select the latest version of Forge
	--forge-version: string      # The Forge version to use (omit to define interactively)
	--help(-h)                   # help for init
	--index-file: string         # The index file to use (default "index.toml")
	--latest(-l)                 # Automatically select the latest version of Minecraft
	--liteloader-latest          # Automatically select the latest version of LiteLoader
	--liteloader-version: string # The LiteLoader version to use (omit to define interactively)
	--mc-version: string         # The Minecraft version to use (omit to define interactively)
	--modloader: string          # The mod loader to use (omit to define interactively)
	--name: string               # The name of the modpack (omit to define interactively)
	--neoforge-latest            # Automatically select the latest version of NeoForge
	--neoforge-version: string   # The NeoForge version to use (omit to define interactively)
	--quilt-latest               # Automatically select the latest version of Quilt loader
	--quilt-version: string      # The Quilt loader version to use (omit to define interactively)
  --reinit(-r)                 # Recreate the pack file if it already exists, rather than exiting
  --snapshot(-s)               # Use the latest snapshot version with --latest
	--version: string            # The version of the modpack (omit to define interactively)

]

# Remove an external file from the modpack; equivalent to manually removing the file and running packwiz refresh
export extern "packwiz rm" [
	--help(-h)									 # Help for remove
	arg: string@packwiz-slug-completer # slug of project to remove
]

export extern "packwiz refresh" [ # Refresh the index file
	--build											 # Only has an effect in no-internal-hashes mode: generates internal hashes for distribution with packwiz-installer
	--help(-h)                   # Help for refresh
]

export extern "packwiz mr" [ # Manage modrinth-based mods
	--help(-h)                   # Help for modrinth
]

export extern "packwiz mr add" [ # Add a project from a Modrinth URL, slug/project ID or search
	...args: string              # [URL|slug|search]
	--help(-h)                   # Help for modrinth add
	--project-id: string         # The Modrinth project ID to use
	--version-filename: string   # The Modrinth version filename to use
	--version-id: string         # The Modrinth version ID to use
]

export extern "packwiz pin" [
	--help(-h)                   # Help for pin
	arg: string@packwiz-slug-completer # slug to pin
]
export extern "packwiz unpin" [
	--help(-h)                   # Help for unpin
	arg: string@packwiz-slug-completer # slug to unpin
]
