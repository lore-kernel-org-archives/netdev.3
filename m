Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B832F0C7E
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122908; cv=none; b=ckbVouFb6KsF3qZB/Pn0DXDBa4ZJBMDghbC5VXYXqPUcOdkrmV1d3xGKqEpTWTAji/JUr/DphmFL8/Py9ZubGZOURthnjKCu5dNxfIxNYqMeSO6QD7IzpTUgs6QD6ZeiFeut8eWimqO0ae6DpqTDCVsGbba5vCFR6TWRoVY9S0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122908; c=relaxed/simple;
	bh=tVA6IRR0o8U37RiU3llstxfeGmacG0ZAcG4wv6iAH4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qlnR8IhyXoVQ56sK0IDr4dVIEAJmVIlwOhjwp2kT4wb+x7jLOjVFc4dfPjHvbot9+qG4IPSyMOZNSxk2jl4dvQHoSxRQ44l7cMlZimOp24L2NawmsJ12Adkrmh2fQDXBNKWv+31GxdJMik5hTL7J+CUZhzlzwm95EB+KTZwBB+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZNhr+3cT; arc=none smtp.client-ip=209.85.222.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZNhr+3cT"
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9772e18c186so2773542241.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 10:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786122905; x=1786727705; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zE0phLEeKUGPeiZx0Mrx/rLdQt/0TheKE3tiM835xo8=;
        b=ZNhr+3cTd5UEyAb6whobnDer05CP7wK53ahh/aS407VRZgHnNgsuovRDn9dDC4iC4Q
         LxU/rRCBp+90jIyN8clH4HI6doSwl1InglsFoLb4YPwlbfu4lVF3j4GIywkcWAJDBmMl
         abZiEo+vtYTn+k6aKdQATFp8hMIBAgJBipLy4qkhXSaxiBSQEwbQZo0a8r6U3Qska0cO
         bmY0b0mpuO8Ro9ETUfUXjW7Q+LCJd7l/+ZfO9OotBV7X/ISAQR6kYwi92aQLxZZc/cOD
         CQ8w5BtBGcHkFiMfgdcfXeuhevHkY0jzEaFzaZhKQJ+w11fWqkyYt3wJ78ZU0xSmZqkf
         6Cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786122905; x=1786727705;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zE0phLEeKUGPeiZx0Mrx/rLdQt/0TheKE3tiM835xo8=;
        b=i+am6rWuPzWKyomRcE2tnHUo15Lx3oHh6Yjj6ewwEI3HEUyfoJQusANLan46+6VBg7
         0E4brJEzj20qejV8uvbyvIua576HxQgTy/URre67vd2JhH1Gvdsc+XxEKRYwtEwXPsg0
         WQfe3l9PeXTjTYRlVP1C7NwzotQ//bhaQ3Sz7dFGE5Vf8cJLdsRQdqtsxSvpVtw6SGjs
         TrzSue0jf4D6tDR9IuKm2DI1WSH+lLakWvBf+XsGuzEzL2uJVcFYmT+ALnqsxDByHkhC
         EIytZLzXp7DNiFtFBVKJUqpJO1skVWGlskvgNxcBJjndpav81bUOF4iNGaKfNacP/57u
         0E/g==
X-Forwarded-Encrypted: i=1; AHgh+RrSe/Ak7rHJlU0lMsax3TEgGCOCCbU7UclyxXHMfPfx1z0TEEAQseLUmgmkcaftpfiD818vYMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhDvWuRlr7opMkrAFmm1rbH6xrELDcn/KiTJI1gmI8m967+Epq
	O5iJyiSB6sqfCtBT458bTwoLyvOev+z+cJvLeAZwRwZ2KAqRiqNvyxRrVNDwn2zNIVz94rNREOf
	cR2rcwiODTmb/lXNEC5JW48BK6A==
X-Received: from uah1.prod.google.com ([2002:a05:6130:5201:b0:976:fd5c:a3ca])
 (user=thaisonphan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:4495:b0:738:fd01:5b60 with SMTP id ada2fe7eead31-760e6ed51a6mr8410156137.3.1786122904854;
 Fri, 07 Aug 2026 10:15:04 -0700 (PDT)
Date: Fri,  7 Aug 2026 17:15:00 +0000
In-Reply-To: <20260807171500.7188-1-thaisonphan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807171500.7188-1-thaisonphan@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260807171500.7188-3-thaisonphan@google.com>
Subject: [PATCH v2 net-next 2/2] tools: ynl: check alloc fails in generated
 getter code
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

Generated YNL getter code does not check the return value of malloc() and
calloc() before passing the resulting pointer to memcpy(). This could lead
to a NULL pointer dereference on memory allocation failure.

Updated the C code generator to check for allocation failures and to return
an error code in getters.

Signed-off-by: Thaison Phan <thaisonphan@google.com>
---
v1 -> v2: Removed updates to allocation checks in setters as those can be
fixed in a separate patch. (Suggested by Jakub Kicinski)

v1:
https://lore.kernel.org/netdev/20260803201652.2752685-3-thaisonphan@google.com/

 tools/net/ynl/pyynl/ynl_gen_c.py | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 95502dbaec94..2b3483db1b60 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -526,8 +526,10 @@ class TypeString(Type):
 
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
@@ -582,8 +584,10 @@ class TypeBinary(Type):
 
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
@@ -601,11 +605,13 @@ class TypeBinaryStruct(TypeBinary):
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
@@ -631,9 +637,11 @@ class TypeBinaryScalarArray(TypeBinary):
 
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
@@ -2227,6 +2235,8 @@ def _multi_parse(ri, struct, init_lines, local_vars):
 
         ri.cw.block_start(line=f"if (n_{aspec.c_name})")
         ri.cw.p(f"dst->{aspec.c_name} = calloc(n_{aspec.c_name}, sizeof(*dst->{aspec.c_name}));")
+        ri.cw.p(f"if (!dst->{aspec.c_name})")
+        ri.cw.p("return YNL_PARSE_CB_ERROR;")
         ri.cw.p(f"dst->_count.{aspec.c_name} = n_{aspec.c_name};")
         ri.cw.p('i = 0;')
         if 'nested-attributes' in aspec:
@@ -2252,6 +2262,8 @@ def _multi_parse(ri, struct, init_lines, local_vars):
         aspec = struct[arg]
         ri.cw.block_start(line=f"if (n_{aspec.c_name})")
         ri.cw.p(f"dst->{aspec.c_name} = calloc(n_{aspec.c_name}, sizeof(*dst->{aspec.c_name}));")
+        ri.cw.p(f"if (!dst->{aspec.c_name})")
+        ri.cw.p("return YNL_PARSE_CB_ERROR;")
         ri.cw.p(f"dst->_count.{aspec.c_name} = n_{aspec.c_name};")
         ri.cw.p('i = 0;')
         if 'nested-attributes' in aspec:
@@ -2275,6 +2287,8 @@ def _multi_parse(ri, struct, init_lines, local_vars):
             ri.cw.nl()
             ri.cw.p('len = strnlen(ynl_attr_get_str(attr), ynl_attr_data_len(attr));')
             ri.cw.p(f'dst->{aspec.c_name}[i] = malloc(sizeof(struct ynl_string) + len + 1);')
+            ri.cw.p(f"if (!dst->{aspec.c_name}[i])")
+            ri.cw.p("return YNL_PARSE_CB_ERROR;")
             ri.cw.p(f"dst->{aspec.c_name}[i]->len = len;")
             ri.cw.p(f"memcpy(dst->{aspec.c_name}[i]->str, ynl_attr_get_str(attr), len);")
             ri.cw.p(f"dst->{aspec.c_name}[i]->str[len] = 0;")
@@ -2434,6 +2448,8 @@ def print_req(ri):
 
     if 'reply' in ri.op[ri.op_mode]:
         ri.cw.p('rsp = calloc(1, sizeof(*rsp));')
+        ri.cw.p('if (!rsp)')
+        ri.cw.p(f'return {ret_err};')
         ri.cw.p('yrs.yarg.data = rsp;')
         ri.cw.p(f"yrs.cb = {op_prefix(ri, 'reply')}_parse;")
         if ri.op.value is not None:
-- 
2.55.0.654.g21b8a5bc05-goog

