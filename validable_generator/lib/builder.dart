import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/builders/enum_extract_builder.dart';
import 'src/generators/validation_constraint_generator.dart';
import 'src/generators/validation_repository_generator.dart';

/// validationConstraintBuilder
Builder validationConstraintBuilder(BuilderOptions builderOptions) {
  return LibraryBuilder(ValidationConstraintGenerator(),
      generatedExtension: '.constraints.dart');
}

/// validationRepositoryBuilder
Builder validationRepositoryBuilder(BuilderOptions builderOptions) =>
    LibraryBuilder(ValidationRepositoryGenerator(),
        generatedExtension: '.repository.dart');

/// enumExtractBuilder
Builder enumExtractBuilder(BuilderOptions builderOptions) =>
    EnumExtractBuilder();

/// temporaryFileCleanup
PostProcessBuilder temporaryFileCleanup(BuilderOptions builderOptions) =>
    FileDeletingBuilder(
      const [
        '.enum_extractor.dart',
      ],
      isEnabled: builderOptions.config['enabled'] as bool? ?? false,
    );
