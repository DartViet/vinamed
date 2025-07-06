import 'package:database_models/models/codes_data_models/dhs_model.dart';
import 'package:database_models/models/codes_data_models/fda_drug_model.dart';
import 'package:database_models/models/codes_data_models/icd10cm_model.dart';
import 'package:database_models/models/codes_data_models/icd10pcs_model.dart';
import 'package:database_models/models/codes_data_models/loinc_model.dart';
import 'package:database_models/models/variables/variables.dart';
import 'package:flutter/material.dart';
import 'package:ltdmed/widgets/code_search/code_search_viewmodel.dart';

class CodeSearch extends StatefulWidget {
  const CodeSearch({super.key});

  @override
  State<CodeSearch> createState() => _CodeSearchState();
}

class _CodeSearchState extends State<CodeSearch> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: CodeSearchViewmodel.instance,
      builder: (context, widget) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Row(
                spacing: 10,
                children: [
                  DropdownButton(
                    value: CodeSearchViewmodel.instance.selectedOption,
                    items:
                        CodeSearchViewmodel.instance.options.entries
                            .map((entry) => DropdownMenuItem<String>(value: entry.key, child: Text(entry.value)))
                            .toList(),
                    onChanged: (value) {
                      // Handle dropdown value change
                      CodeSearchViewmodel.instance.selectedOption = value ?? CodeSearchViewmodel.instance.selectedOption;
                      CodeSearchViewmodel.instance.clearnSearch();
                    },
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Search Code', border: OutlineInputBorder(), suffixIcon: Icon(Icons.search)),
                      onFieldSubmitted: (value) {
                        // Handle search query submission
                        CodeSearchViewmodel.instance.searchQuery = value;
                        CodeSearchViewmodel.instance.submitSearch();
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ListView.builder(
                itemCount: CodeSearchViewmodel.instance.searchResults.length,
                itemBuilder: (context, index) {
                  return listItemBuilder(context, index);
                },
              ),
            ),
            SizedBox(height: 60),
          ],
        );
      },
    );
  }

  Widget? listItemBuilder(BuildContext context, int index) {
    // This method can be used to build individual list items if needed
    if (CodeSearchViewmodel.instance.selectedOption == Variables.instance.icd10cm) {
      return getIcd10CmItem(index);
    } else if (CodeSearchViewmodel.instance.selectedOption == Variables.instance.icd10pcs) {
      return getIcd10PcsItem(index);
    } else if (CodeSearchViewmodel.instance.selectedOption == Variables.instance.dhs) {
      return getIcd10DhsItem(index);
    } else if (CodeSearchViewmodel.instance.selectedOption == Variables.instance.fdadrug) {
      return getFdaDrugItem(index);
    } else if (CodeSearchViewmodel.instance.selectedOption == Variables.instance.loinc) {
      return getLoincItem(index);
    } else {
      throw Exception('Unknown code type: ${CodeSearchViewmodel.instance.selectedOption}');
    }
  }

  ListTile getIcd10CmItem(int index) {
    final item = CodeSearchViewmodel.instance.searchResults[index];
    Icd10CmItemModel icd10CmItem = item as Icd10CmItemModel;
    // Example method to get ICD-10-CM item
    return ListTile(
      title: Text(icd10CmItem.descriptionEn),
      subtitle: Text(icd10CmItem.code),
      onTap: () {
        // Handle item tap
      },
    );
  }

  ListTile getIcd10PcsItem(int index) {
    final item = CodeSearchViewmodel.instance.searchResults[index];
    Icd10PcsItemModel icd10PcsItem = item as Icd10PcsItemModel;
    // Example method to get ICD-10-PCS item
    return ListTile(
      title: Text(icd10PcsItem.descriptionEn),
      subtitle: Text(icd10PcsItem.code),
      onTap: () {
        // Handle item tap
      },
    );
  }

  ListTile getIcd10DhsItem(int index) {
    final item = CodeSearchViewmodel.instance.searchResults[index];
    DhsModel icd10DhsItem = item as DhsModel;
    // Example method to get ICD-10-DHS item
    return ListTile(
      title: Text(icd10DhsItem.descriptionEn),
      subtitle: Text(icd10DhsItem.code),
      onTap: () {
        // Handle item tap
      },
    );
  }

  ListTile getFdaDrugItem(int index) {
    final item = CodeSearchViewmodel.instance.searchResults[index];
    // Assuming FdaDrugModel is defined in your models
    FdaDrugModel fdaDrugItem = item as FdaDrugModel;
    // Example method to get FDA Drug item
    return ListTile(
      title: Text('${fdaDrugItem.applNo} - ${fdaDrugItem.drugName} (${fdaDrugItem.referenceDrug})'),
      subtitle: Text(fdaDrugItem.activeIngredient),
      onTap: () {
        // Handle item tap
      },
    );
  }

  ListTile getLoincItem(int index) {
    final item = CodeSearchViewmodel.instance.searchResults[index];
    // Assuming LoincItemModel is defined in your models
    LoincItemModel loincItem = item as LoincItemModel;
    // Example method to get LOINC item
    return ListTile(
      title: Text(loincItem.component),
      subtitle: Text(loincItem.loincNum),
      onTap: () {
        // Handle item tap
      },
    );
  }
}
