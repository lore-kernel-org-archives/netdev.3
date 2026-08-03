Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2506C3B05AA
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788270; cv=none; b=eJAERUATMsidk4/m4Q80WkXDZIEXRr+adlcZLAi7we3BEqc793dgFKK+BrENgM32n3xJagVQqW46R3evkC6c8xwWAF8IWWr5CGdYnfc0xSt0FSk6KfvdzdOpn1iPKi5qkKLg8W9DNAAvqfwZSUC8OJdrp8XX8FOYa0qLeJimX6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788270; c=relaxed/simple;
	bh=5I/tSxviojv3fiQmkexFSr3+wjyG09NrO9LpP899mE8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QiJS9FkUBRpFWCz+XUw8S2vN4M4z7yD+yMEi7U/SxRL1tme4qFY4ZcUfXJdyj2P6tyckwi2fX9Jb85fO/DxHQiPPlMWWjku8q7IRTooAzgmQLPwMYC3uVsXwdEgeJ2xPo5k1hIeJhsXss0y9wMsynovpfQMXeUwJLb5v0p9OVK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ICVZia5f; arc=none smtp.client-ip=209.85.222.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICVZia5f"
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9772e18c186so3632149241.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 13:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785788267; x=1786393067; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dxLh0Si8XbYFI0YXi0oKUPTXA5UlSt2whO2ADj2/Lto=;
        b=ICVZia5f8fHEjbO240nwPOIkq3u2uW09s2qXWFMWb3LiBctoD1vK58/PIoNjLSODdv
         fI1/8nitLSP4v0qzqixFBR8cZCtRHD5UwgVl/DFLY6164fx4sFjh0efIYiYXCobRDiap
         H4b/daPTD3PsAJsLy+eITJAVj3QPmOyRyAXEgYHUezWjDIx8tPUE/Y3GhotyMIRp7UnC
         ogvCcknLZPpEdpW7I56WIVhwCzGYYgdQqpJfEo9J3lxfmvcGIenj26klHI4r2FkUVNFj
         ZjJXdq0f29+HIgkQ4XVgF76t6X7Iamld6Lz6YpdE+hGZEmORN20pAzw7oGyGoWFwfY7r
         rX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785788267; x=1786393067;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dxLh0Si8XbYFI0YXi0oKUPTXA5UlSt2whO2ADj2/Lto=;
        b=SSYHAHUdlXW30kFIbPCQFspW0gS9rIMrHhUDXAf8qV8IBsDL0mR9CZrwDHFlARW3z8
         liOOjezoOZ3TTIB28QurkseDM4QqtRpQxj7g4yXqqMT7dxjx46+uTvAiRUqEvJtznS3c
         sra5jKZQC2vJDe5ce3SMNHfwuZP+UWTS3e+d2gv+oy7prO3BuugqtzpNLEnoolxMEeg2
         J/p90031nhG5LVVc12qqOxXJUxlO9qtfucg3hz1ZUL11SWdVXR3wtT1Cml6hrcar1S8D
         s/TsJrCoEYXfZBAFjWKpJ6e8ZLIYvxDPWrV2Fuo7uVMPQg1LSRzG2IpQ+tYib+jcf/1d
         oF0g==
X-Forwarded-Encrypted: i=1; AHgh+Rq1e/vPYXNi7XUlTNK4c6mP3U2IOJZCWR8yFUQ5BUxNducXsRVeCYxyLXzXqK6/bchjo7DA0q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYfXYVK8LNFr/JI3W8wmE2HaQzoIQUe9KGxX/aK/DmOkGZpaJP
	3l6yXgomASU++zX5qLz/7hfjoU88F+EIv4f+ua3FlWg4RbBXwlLcQpl6tHG86DycdbjJaiuivfJ
	TmX1Ej1rWQjy7a6FzZ9VJNPskEA==
X-Received: from vsts11.prod.google.com ([2002:a05:6102:370b:b0:738:a383:731])
 (user=thaisonphan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:b0f:b0:745:1c72:cf7f with SMTP id ada2fe7eead31-75b21b5f2b9mr8916605137.5.1785788266382;
 Mon, 03 Aug 2026 13:17:46 -0700 (PDT)
Date: Mon,  3 Aug 2026 20:16:52 +0000
In-Reply-To: <20260803201652.2752685-1-thaisonphan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803201652.2752685-1-thaisonphan@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803201652.2752685-3-thaisonphan@google.com>
Subject: [PATCH net-next 2/2] tools: ynl: check alloc fails in generated code
From: Thaison Phan <thaisonphan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	"David S . Miller " <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Fengyuan Gong <gfengyuan@google.com>, 
	Stan Iliev <stani@google.com>, 
	"=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?=" <ast@fiberby.net>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
	Thaison Phan <thaisonphan@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Generated YNL code does not check the return value of malloc() and calloc()
before passing the resulting pointer to memcpy(). This could lead to a NULL
pointer dereference on memory allocation failure.

Updated the C code generator to check for allocation failures and to return
an error code when applicable, or to return with no error code for a user
to check for a NULL in the field that allocation was attempted for.

Signed-off-by: Thaison Phan <thaisonphan@google.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 53 ++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 2fd68c738075..a323acdc42ba 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -526,16 +526,20 @@ class TypeString(Type):
 
     def _attr_get(self, ri, var):
         len_mem = var + '->_len.' + self.c_name
-        return [f"{len_mem} = len;",
-                f"{var}->{self.c_name} = malloc(len + 1);",
+        return [f"{var}->{self.c_name} = malloc(len + 1);",
+                f"if (!{var}->{self.c_name})",
+                "return YNL_PARSE_CB_ERROR;",
+                f"{len_mem} = len;",
                 f"memcpy({var}->{self.c_name}, ynl_attr_get_str(attr), len);",
                 f"{var}->{self.c_name}[len] = 0;"], \
                ['len = strnlen(ynl_attr_get_str(attr), ynl_attr_data_len(attr));'], \
                ['unsigned int len;']
 
     def _setter_lines(self, ri, member, presence):
-        return [f"{presence} = strlen({self.c_name});",
-                f"{member} = malloc({presence} + 1);",
+        return [f"{member} = malloc(strlen({self.c_name}) + 1);",
+                f"if (!{member})",
+                "return;",
+                f"{presence} = strlen({self.c_name});",
                 f'memcpy({member}, {self.c_name}, {presence});',
                 f'{member}[{presence}] = 0;']
 
@@ -582,15 +586,19 @@ class TypeBinary(Type):
 
     def _attr_get(self, ri, var):
         len_mem = var + '->_len.' + self.c_name
-        return [f"{len_mem} = len;",
-                f"{var}->{self.c_name} = malloc(len);",
+        return [f"{var}->{self.c_name} = malloc(len);",
+                f"if (!{var}->{self.c_name})",
+                "return YNL_PARSE_CB_ERROR;",
+                f"{len_mem} = len;",
                 f"memcpy({var}->{self.c_name}, ynl_attr_data(attr), len);"], \
                ['len = ynl_attr_data_len(attr);'], \
                ['unsigned int len;']
 
     def _setter_lines(self, ri, member, presence):
-        return [f"{presence} = len;",
-                f"{member} = malloc({presence});",
+        return [f"{member} = malloc(len);",
+                f"if (!{member})",
+                "return;",
+                f"{presence} = len;",
                 f'memcpy({member}, {self.c_name}, {presence});']
 
 
@@ -601,11 +609,13 @@ class TypeBinaryStruct(TypeBinary):
     def _attr_get(self, ri, var):
         struct_sz = 'sizeof(struct ' + c_lower(self.get("struct")) + ')'
         len_mem = var + '->_' + self.presence_type() + '.' + self.c_name
-        return [f"{len_mem} = len;",
-                f"if (len < {struct_sz})",
+        return [f"if (len < {struct_sz})",
                 f"{var}->{self.c_name} = calloc(1, {struct_sz});",
                 "else",
                 f"{var}->{self.c_name} = malloc(len);",
+                f"if (!{var}->{self.c_name})",
+                "return YNL_PARSE_CB_ERROR;",
+                f"{len_mem} = len;",
                 f"memcpy({var}->{self.c_name}, ynl_attr_data(attr), len);"], \
                ['len = ynl_attr_data_len(attr);'], \
                ['unsigned int len;']
@@ -631,18 +641,21 @@ class TypeBinaryScalarArray(TypeBinary):
 
     def _attr_get(self, ri, var):
         len_mem = var + '->_count.' + self.c_name
-        return [f"{len_mem} = len / sizeof(__{self.get('sub-type')});",
-                f"len = {len_mem} * sizeof(__{self.get('sub-type')});",
+        return [f"len = (len / sizeof(__{self.get('sub-type')})) * sizeof(__{self.get('sub-type')});",
                 f"{var}->{self.c_name} = malloc(len);",
+                f"if (!{var}->{self.c_name})",
+                "return YNL_PARSE_CB_ERROR;",
+                f"{len_mem} = len / sizeof(__{self.get('sub-type')});",
                 f"memcpy({var}->{self.c_name}, ynl_attr_data(attr), len);"], \
                ['len = ynl_attr_data_len(attr);'], \
                ['unsigned int len;']
 
     def _setter_lines(self, ri, member, presence):
-        return [f"{presence} = count;",
-                f"count *= sizeof(__{self.get('sub-type')});",
-                f"{member} = malloc(count);",
-                f'memcpy({member}, {self.c_name}, count);']
+        return [f"{member} = malloc(count * sizeof(__{self.get('sub-type')}));",
+                f"if (!{member})",
+                "return;",
+                f"{presence} = count;",
+                f'memcpy({member}, {self.c_name}, count * sizeof(__{self.get("sub-type")}));']
 
 
 class TypeBitfield32(Type):
@@ -2227,6 +2240,8 @@ def _multi_parse(ri, struct, init_lines, local_vars):
 
         ri.cw.block_start(line=f"if (n_{aspec.c_name})")
         ri.cw.p(f"dst->{aspec.c_name} = calloc(n_{aspec.c_name}, sizeof(*dst->{aspec.c_name}));")
+        ri.cw.p(f"if (!dst->{aspec.c_name})")
+        ri.cw.p("return YNL_PARSE_CB_ERROR;")
         ri.cw.p(f"dst->_count.{aspec.c_name} = n_{aspec.c_name};")
         ri.cw.p('i = 0;')
         if 'nested-attributes' in aspec:
@@ -2252,6 +2267,8 @@ def _multi_parse(ri, struct, init_lines, local_vars):
         aspec = struct[arg]
         ri.cw.block_start(line=f"if (n_{aspec.c_name})")
         ri.cw.p(f"dst->{aspec.c_name} = calloc(n_{aspec.c_name}, sizeof(*dst->{aspec.c_name}));")
+        ri.cw.p(f"if (!dst->{aspec.c_name})")
+        ri.cw.p("return YNL_PARSE_CB_ERROR;")
         ri.cw.p(f"dst->_count.{aspec.c_name} = n_{aspec.c_name};")
         ri.cw.p('i = 0;')
         if 'nested-attributes' in aspec:
@@ -2275,6 +2292,8 @@ def _multi_parse(ri, struct, init_lines, local_vars):
             ri.cw.nl()
             ri.cw.p('len = strnlen(ynl_attr_get_str(attr), ynl_attr_data_len(attr));')
             ri.cw.p(f'dst->{aspec.c_name}[i] = malloc(sizeof(struct ynl_string) + len + 1);')
+            ri.cw.p(f"if (!dst->{aspec.c_name}[i])")
+            ri.cw.p("return YNL_PARSE_CB_ERROR;")
             ri.cw.p(f"dst->{aspec.c_name}[i]->len = len;")
             ri.cw.p(f"memcpy(dst->{aspec.c_name}[i]->str, ynl_attr_get_str(attr), len);")
             ri.cw.p(f"dst->{aspec.c_name}[i]->str[len] = 0;")
@@ -2434,6 +2453,8 @@ def print_req(ri):
 
     if 'reply' in ri.op[ri.op_mode]:
         ri.cw.p('rsp = calloc(1, sizeof(*rsp));')
+        ri.cw.p('if (!rsp)')
+        ri.cw.p(f'return {ret_err};')
         ri.cw.p('yrs.yarg.data = rsp;')
         ri.cw.p(f"yrs.cb = {op_prefix(ri, 'reply')}_parse;")
         if ri.op.value is not None:
-- 
2.55.0.571.g244d577d93-goog

