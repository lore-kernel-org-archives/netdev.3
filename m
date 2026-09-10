Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A984718C6;
	Thu, 10 Sep 2026 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078794; cv=none; b=gwrElNV7osg1GP/MZ4QE4Xmt+yrQASfjGOGbDCd0DLkxH49jtDKgAzhKP26BFKK8NlaiQDZ/Qd72UgQnidaNgHzJsEmXiXMdjxCSyVqijfnDa7qd8sROMgZo7Cbssk/3IvTM8DY8b3gHu3+JzAPS4jnwGQDrBtkRywqsfIbqKfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078794; c=relaxed/simple;
	bh=92SoVv7TfxrFFZLu/7aM+Ig16jRWvHIVrK4F79FlPXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcPk1WGs21dNwey9tMrPADQ7edJ0yZJDx9qBvsRzU6PqEfoTeiWgDGDhTaSD3DyngVnjKHni3WiRUwQT59YSTho7qSffxZrZDMJDOLi+F+wbvAk5lcnvy5ziHtIH3a64e4OackyGfhUw8Lj4id8R9WxT6MFgAW4EQeDpnKgd1Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=do33mMtk; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="do33mMtk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789078778;
	bh=92SoVv7TfxrFFZLu/7aM+Ig16jRWvHIVrK4F79FlPXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=do33mMtkU4b1/lxXxSJzOPCSqty2hp7lKl3oWsq9Wb5aPW9PmCPbikOoC4TB0RtIi
	 pyOFQI9ZNun7hz5P/cOT1woihZcbvgd2sgJf7VtIxi5/fNUoPDS+87UgTevD5IQVN4
	 smopC9ZPgKscOZAlj+0IXA/v3Adfrymi4uFW1H2WerkzgnHlvruXU9PJSU9KkYqpzC
	 f6l7UwZCGK+r4hfmjvMGRdDMQp5AgmTI6OoSRiUpO8F73aZFUOzd14AcodYbjvMnxF
	 q0HeBdWe+n6NT+fC4aQl+hlhQZ7LTR48XL4rQEkCbuLidxmkRIDKqte8qWeMHc51s4
	 RCKPhcHaFyukw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 464CC60113;
	Thu, 10 Sep 2026 22:19:38 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 5BA68202052; Thu, 10 Sep 2026 22:17:36 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Greg Thelen <gthelen@google.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"Matthieu Baerts (Netdev Foundation)" <matttbe@kernel.org>,
	"Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Heng Guo <heng.guo@windriver.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 3/8] tools: ynl: add C-based YNL linter
Date: Thu, 10 Sep 2026 22:17:23 +0000
Message-ID: <20260910221733.1021864-4-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910221733.1021864-1-ast@fiberby.net>
References: <20260910221733.1021864-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Validate that structures described in YNL match their C counterpart,
currently focused on enums.

The aim is to protect against uAPI regressions, and the linter
output should be easy to digest in NIPA.

Building and execution happens in the following steps:

1) ynl_gen_c.py is used to generate C data structures.
   Example: make -C tools/net/ynl/generated rt-link-linter.c

2) gen-h.sh generates a header file with LINTER_HAS_* defines.
   Example: make -C tools/net/ynl/generated rt-link-linter.h

3) Build linter program.
   Example: make -C tools/net/ynl/generated rt-link-linter

4) Execute linter and report findings (if any).
   Example: make -C tools/net/ynl/generated rt-link-lint

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 tools/net/ynl/generated/.gitignore |   3 +
 tools/net/ynl/generated/Makefile   |  27 ++++-
 tools/net/ynl/linter/gen-h.sh      |  23 +++++
 tools/net/ynl/linter/linter.h      | 152 +++++++++++++++++++++++++++++
 tools/net/ynl/pyynl/ynl_gen_c.py   |  72 +++++++++++---
 5 files changed, 261 insertions(+), 16 deletions(-)
 create mode 100755 tools/net/ynl/linter/gen-h.sh
 create mode 100644 tools/net/ynl/linter/linter.h

diff --git a/tools/net/ynl/generated/.gitignore b/tools/net/ynl/generated/.gitignore
index 859a6fb446e1..20dd70cd709e 100644
--- a/tools/net/ynl/generated/.gitignore
+++ b/tools/net/ynl/generated/.gitignore
@@ -1,3 +1,6 @@
 *-user.c
 *-user.h
+*-linter.c
+*-linter.h
+*-linter
 *.rst
diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index 5a186349b5a8..bcf7f4556313 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -33,8 +33,9 @@ OBJS=$(patsubst %,%-user.o,${GENS})
 SPECS_PATHS=$(wildcard $(SPECS_DIR)/*.yaml)
 SPECS=$(patsubst $(SPECS_DIR)/%.yaml,%,${SPECS_PATHS})
 RSTS=$(patsubst %,%.rst,${SPECS})
+LINTS=$(patsubst %,%-lint,${SPECS})
 
-all: protos.a $(HDRS) $(SRCS) $(KHDRS) $(KSRCS) $(UAPI) $(RSTS)
+all: protos.a $(HDRS) $(SRCS) $(KHDRS) $(KSRCS) $(UAPI) $(RSTS) $(LINTS)
 
 protos.a: $(OBJS)
 	@echo -e "\tAR $@"
@@ -56,11 +57,29 @@ protos.a: $(OBJS)
 	@echo -e "\tGEN_RST $@"
 	@$(TOOL_RST) -o $@ -i $<
 
+%-linter.c: $(SPECS_DIR)/%.yaml $(TOOL) ../linter/linter.h
+	@echo -e "\tGEN $@"
+	@$(TOOL) --mode user --linter --spec $< -o $@ $(YNL_GEN_ARG_$*)
+
+%-linter.h: %-linter.c ../linter/gen-h.sh
+	@echo -e "\tGEN $@"
+	@../linter/gen-h.sh $(CFLAGS) $(CFLAGS_$*) < $< > $@
+
+%-linter: %-linter.c %-linter.h ../linter/linter.h
+	@echo -e "\tCC $@"
+	@$(CC) $(CFLAGS) $(CFLAGS_$*) -include $*-linter.h -o $@ $<
+
+%-lint: %-linter
+	@echo -e "\tLINT $@"
+	@./$< $*
+
+lint: $(LINTS)
+
 clean:
 	rm -f *.o
 
 distclean: clean
-	rm -f *.c *.h *.a *.rst
+	rm -f *.c *.h *.a *.rst *-linter
 
 regen:
 	@../ynl-regen.sh
@@ -68,7 +87,7 @@ regen:
 install-headers: $(HDRS)
 	@echo -e "\tINSTALL generated headers"
 	@$(INSTALL) -d $(DESTDIR)$(includedir)/ynl
-	@$(INSTALL) -m 0644 *.h $(DESTDIR)$(includedir)/ynl/
+	@$(INSTALL) -m 0644 $(KHDRS) $(DESTDIR)$(includedir)/ynl/
 
 install-rsts: $(RSTS)
 	@echo -e "\tINSTALL generated docs"
@@ -84,5 +103,5 @@ install-specs:
 
 install: install-headers install-rsts install-specs
 
-.PHONY: all clean distclean regen install install-headers install-rsts install-specs
+.PHONY: all clean distclean regen install install-headers install-rsts install-specs lint
 .DEFAULT_GOAL: all
diff --git a/tools/net/ynl/linter/gen-h.sh b/tools/net/ynl/linter/gen-h.sh
new file mode 100755
index 000000000000..247493600034
--- /dev/null
+++ b/tools/net/ynl/linter/gen-h.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# Usage: ./gen-h.sh $CFLAGS < in.c > out.h
+#
+# Extract valid symbols, and define that they are available. This is a
+# workaround, to avoid compile failures due to non-existent enum members.
+#
+# Capitalized keywords found in the preprocessor output, are mostly enum
+# members.
+#
+# As an example, existence of FOO can be checked with:
+#   #if defined(FOO) || defined(LINTER_HAS_FOO)
+# thus checking for FOO either as a macro or as an enum members.
+
+set -e
+
+echo '/* This is an auto-generated file */'
+grep '^#include <linux/' |
+	cpp -x c "$@" - |
+	grep -wo '[A-Z][A-Z0-9_]\+' |
+	sort | uniq |
+	sed -e 's/^/#define LINTER_HAS_/g'
diff --git a/tools/net/ynl/linter/linter.h b/tools/net/ynl/linter/linter.h
new file mode 100644
index 000000000000..0d1c28c9f214
--- /dev/null
+++ b/tools/net/ynl/linter/linter.h
@@ -0,0 +1,152 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <stdio.h>
+#include <stdbool.h>
+
+struct enum_kv {
+	const char *name;
+	const long long val;
+	const bool is_undef:1;
+};
+
+struct enum_entry {
+	const struct enum_kv ynl;
+	const struct enum_kv c;
+	const bool is_sentinal:1;
+};
+
+#define YNL_ENUM_ENTRY(YNL_NAME, C_NAME, YNL_VALUE) \
+	{ \
+		.ynl = { .name = YNL_NAME, .val = YNL_VALUE }, \
+		.c = { .name = #C_NAME, .val = C_NAME }, \
+	}
+
+#define YNL_ENUM_BAD_ENTRY(YNL_NAME, C_NAME, YNL_VALUE) \
+	{ \
+		.ynl = { .name = YNL_NAME, .val = YNL_VALUE }, \
+		.c = { .name = #C_NAME, .is_undef = true }, \
+	}
+
+#define YNL_ENUM_SENTINAL(C_NAME, YNL_VALUE) \
+	{ \
+		.ynl = { .name = "MAX", .val = YNL_VALUE }, \
+		.c = { .name = #C_NAME, .val = C_NAME }, \
+		.is_sentinal = true, \
+	}
+
+enum ynl_enum_type {
+	YNL_ENUM,
+	YNL_FLAGS,
+};
+
+struct enum_set {
+	const char *name;
+	const struct enum_entry *entry;
+	enum ynl_enum_type type;
+};
+
+struct linter_ctx {
+	int errors;
+	int warnings;
+	const char *name;
+};
+
+#define errf(fmt, ...) \
+	do { \
+		fprintf(stderr, "%s: ERROR: " fmt, ctx->name, __VA_ARGS__); \
+		ctx->errors++; \
+	} while (0)
+
+#define warnf(fmt, ...) \
+	do { \
+		fprintf(stderr, "%s: WARN: " fmt, ctx->name, __VA_ARGS__); \
+		ctx->warnings++; \
+	} while (0)
+
+static inline long long find_next_value(const struct enum_set *es,
+					const long long last_val)
+{
+	switch (es->type) {
+	case YNL_ENUM:
+		return last_val + 1;
+	case YNL_FLAGS:
+		return last_val << 1;
+	default:
+		/* unreachable */
+		abort();
+	}
+}
+
+static inline void lint_enum_entry(struct linter_ctx *ctx,
+				   const struct enum_set *es,
+				   const struct enum_entry *entry,
+				   long long *last_val, const int i,
+				   const int cnt)
+{
+	const long long val = entry->c.val;
+
+	if (i > 0 && val != *last_val && val != find_next_value(es, *last_val))
+		warnf("%s: Possible missing member before %s (%lld -> %lld)\n",
+		      es->name, entry->c.name, *last_val, val);
+	*last_val = entry->c.val;
+
+	if (i == cnt - 1 && strcmp(entry->ynl.name, "max") == 0)
+		errf("%s: Sentinal used in YNL spec\n", es->name);
+
+	if (entry->c.is_undef) {
+		errf("%s: %s: %s not found\n", es->name, entry->ynl.name,
+		     entry->c.name);
+		return;
+	}
+
+	if (entry->ynl.val == entry->c.val)
+		return;
+
+	if (entry->is_sentinal) {
+		if (es->type == YNL_ENUM && entry->ynl.val + 1 == entry->c.val)
+			return; /* eg. DEVCONF_MAX is the storage size */
+		warnf("%s: Sentinal mismatch: %lld != %lld (Last YNL != %s)\n",
+		      es->name, entry->ynl.val, entry->c.val, entry->c.name);
+	} else {
+		errf("%s: Value mismatch: %lld != %lld (%s != %s)\n", es->name,
+		     entry->ynl.val, entry->c.val, entry->ynl.name,
+		     entry->c.name);
+	}
+}
+
+static inline void lint_enum(struct linter_ctx *ctx, const struct enum_set *es)
+{
+	const struct enum_entry *entry = es->entry;
+	long long last_val;
+	int cnt = 0;
+	int i = 0;
+
+	while (entry->ynl.name) {
+		if (!entry->is_sentinal)
+			cnt++;
+		entry++;
+	}
+	entry = es->entry;
+
+	while (entry->ynl.name)
+		lint_enum_entry(ctx, es, entry++, &last_val, i++, cnt);
+}
+
+static inline int linter_run(const int argc, const char **argv,
+			     const struct enum_set *es)
+{
+	struct linter_ctx ctx = {
+		.name = argv[argc > 1 ? 1 : 0],
+	};
+
+	while (es->name) {
+		lint_enum(&ctx, es);
+		es++;
+	}
+
+	if (ctx.errors || ctx.warnings)
+		fprintf(stderr, "%s: Linter summary: %d errors, %d warnings\n",
+			ctx.name, ctx.errors, ctx.warnings);
+
+	return EXIT_SUCCESS;
+}
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 2b3483db1b60..5bbe3cba8f75 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1688,6 +1688,8 @@ class CodeWriter:
         self.close_out_file()
 
     def close_out_file(self):
+        if self._block_end:
+            self._out.write('\t' * self._ind + '}\n')
         if self._out == os.sys.stdout:
             return
         # Avoid modifying the file if contents didn't change
@@ -2084,6 +2086,30 @@ def put_enum_to_str(_family, cw, enum):
     _put_enum_to_str_helper(cw, enum.render_name, map_name, 'value', enum=enum)
 
 
+def put_enum_to_linter(family, cw, enum):
+    name_pfx = enum.get('name-prefix', f"{family.ident_name}-{enum['name']}-")
+    max_name = c_upper(name_pfx + 'max')
+    map_name = f'{enum.render_name}_entries'
+    cw.block_start(line=f"static const struct enum_entry {map_name}[] =")
+    val = 0
+    for entry in enum.entries.values():
+        val = entry.user_value()
+        c_name = entry.c_name
+        cw.p(f'#if defined({c_name}) || defined(LINTER_HAS_{c_name})')
+        cw.p(f'YNL_ENUM_ENTRY("{entry.name}", {c_name}, {val}),')
+        cw.p('#else')
+        cw.p(f'YNL_ENUM_BAD_ENTRY("{entry.name}", {c_name}, {val}),')
+        cw.p('#endif')
+    cw.p(f'#if defined({max_name}) || defined(LINTER_HAS_{max_name})')
+    cw.p(f'YNL_ENUM_SENTINAL({max_name}, {val}),')
+    cw.p('#endif')
+    cw.p('{},')
+    cw.block_end(line=';')
+    cw.nl()
+    enum_type = enum['type'].upper()
+    return f'{{"{enum.name}", &{map_name}[0], YNL_{enum_type}}},'
+
+
 def put_local_vars(struct):
     local_vars = []
     has_array = False
@@ -3462,6 +3488,7 @@ def main():
     parser.add_argument('--spec', dest='spec', type=str, required=True)
     parser.add_argument('--header', dest='header', action='store_true', default=None)
     parser.add_argument('--source', dest='header', action='store_false')
+    parser.add_argument('--linter', dest='linter', action='store_true')
     parser.add_argument('--user-header', nargs='+', default=[])
     parser.add_argument('--cmp-out', action='store_true', default=None,
                         help='Do not overwrite the output file if the new output is identical to the old')
@@ -3470,8 +3497,10 @@ def main():
     parser.add_argument('--function-prefix', dest='fn_prefix', type=str)
     args = parser.parse_args()
 
+    if args.linter:
+        args.header = False
     if args.header is None:
-        parser.error("--header or --source is required")
+        parser.error("--header, --source or --linter is required")
 
     exclude_ops = [re.compile(expr) for expr in args.exclude_op]
 
@@ -3494,17 +3523,19 @@ def main():
         cw.p(f'// SPDX-License-Identifier: {parsed.license}')
     cw.p("/* Do not edit directly, auto-generated from: */")
     cw.p(f"/*\t{spec_kernel} */")
-    cw.p(f"/* YNL-GEN {args.mode} {'header' if args.header else 'source'} */")
-    if args.exclude_op or args.user_header or args.fn_prefix:
-        line = ''
-        if args.user_header:
-            line += ' --user-header '.join([''] + args.user_header)
-        if args.exclude_op:
-            line += ' --exclude-op '.join([''] + args.exclude_op)
-        if args.fn_prefix:
-            line += f' --function-prefix {args.fn_prefix}'
-        cw.p(f'/* YNL-ARG{line} */')
-    cw.p('/* To regenerate run: tools/net/ynl/ynl-regen.sh */')
+    if not args.linter:
+        ynl_arg = 'header' if args.header else 'source'
+        cw.p(f"/* YNL-GEN {args.mode} {ynl_arg} */")
+        if args.exclude_op or args.user_header or args.fn_prefix:
+            line = ''
+            if args.user_header:
+                line += ' --user-header '.join([''] + args.user_header)
+            if args.exclude_op:
+                line += ' --exclude-op '.join([''] + args.exclude_op)
+            if args.fn_prefix:
+                line += f' --function-prefix {args.fn_prefix}'
+            cw.p(f'/* YNL-ARG{line} */')
+        cw.p('/* To regenerate run: tools/net/ynl/ynl-regen.sh */')
     cw.nl()
 
     if args.mode == 'uapi':
@@ -3539,6 +3570,8 @@ def main():
             cw.p('#include <linux/types.h>')
             if family_contains_bitfield32(parsed):
                 cw.p('#include <linux/netlink.h>')
+        elif args.linter:
+            cw.p('#include "../linter/linter.h"')
         else:
             cw.p(f'#include "{hdr_file}"')
             cw.p('#include "ynl.h"')
@@ -3690,6 +3723,21 @@ def main():
                     cw.nl()
                     print_wrapped_type(ri)
             cw.nl()
+        elif args.linter:
+            enum_sets = []
+            for name, const in parsed.consts.items():
+                if isinstance(const, EnumSet):
+                    enum_sets.append(put_enum_to_linter(parsed, cw, const))
+            cw.nl()
+            cw.block_start(line="static const struct enum_set enums[] =")
+            for enum_set in enum_sets:
+                cw.p(enum_set)
+            cw.p('{},')
+            cw.block_end(line=';')
+            cw.nl()
+            cw.write_func('int', 'main',
+                          args=['const int argc', 'const char **argv'],
+                          body=['return linter_run(argc, argv, &enums[0]);'])
         else:
             cw.p('/* Enums */')
             put_op_name(parsed, cw)
-- 
2.55.0

