Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8242A82
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785081012; cv=none; b=eJA/flQoXen+ZNWHkZVpRGnfQyuvc0axUqIK9lbXd4JJjnIO0U6GglyJKJLu1XhIO0QC0SQS75XIJIVA9FKsuqyBEHTrR+0f2S4kIUoNX66UE7OKmOgdX/llcin555JzBbU+UirCV5q/hjcPFNGweyWU+ZgwZ25fzNQETKGr2Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785081012; c=relaxed/simple;
	bh=spvhm0DO7OY7iN0RlgVm4IRRGSE4g/bwvgU51jyRZ2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X0sK/7ovbtbRNDjXpi47qO+caQ+XlLZ/WzSjbS4FBRsNmmsbNwy30a7zvnAqzjtlIUUe9vCfUbICws2AcQs/xHJIteZobg+s+MPSm8FA81L4Xo2ON9VSi3e3ux35fe9mBsht0H2aVjwMcnbqP3GCjQ7PexXyjOZCmFcsUT7miY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=q0fF0tdU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="q0fF0tdU"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso21980725ad.1
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 08:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785081010; x=1785685810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BzkBWT3sb73Kmu+fyQhtG+qbpN8xCzdXm+ZDdHsT0UY=;
        b=q0fF0tdUiB7awPfEZxDRTev5B36ZE73CxPYgHAK9tBWDTer3tX7a4loHCeHGj8ZPFm
         2bwuXL2mkVle3RYksi4RQN9MFrEI4f1kIj3P+8xIsAYBs62uAfIlXJc0rZAELSrazlYD
         XjdavvihlyIGNLfW9ktQloI+8rGwq3RqCZzCOdZ2xP1QLqLC2DGMLbuEEMm1ZArvnqyV
         7Io3xOoRb2x6xD9nyvWne7IGoBA92CivZaRz9UUFNi+zSm3WG5oeupxdJw0Hdw+bThPJ
         O2y9DxbFPFtU0coLuauPdtE2o0r5Z4OLnKit8YYvzJJSJ1N5xbZ9hhpUv/25sujKO8Ly
         v5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785081010; x=1785685810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BzkBWT3sb73Kmu+fyQhtG+qbpN8xCzdXm+ZDdHsT0UY=;
        b=gNRr9LaaY6m1E3eJbzL9vVO1fhcme9CucGj2sJwWQtv9/w2WOnN+6ZU6ObEg8PX0dM
         oZSWpas/K8CxLcbObYQNjLHAczYpB7r/nHS6uw4yGWKuBgfy8+1TjzkiJ9rPrc/Fixt3
         6eHeYbbOJ0ZUELAChd15KyLYQthIt5cyxQFLwxnp35XQIMzx+oDbujo0yDsUIhjqTf1W
         3OdAko/IMbOR7aZtl5g4uvU7W8G8p3oFd52Z9jytK3l7hmTOGshnnEajEjPYiFzgFqHg
         DrWupfUNh3eVzMBjPpY3po0pim1FchtFNIiWp1AogpxIxPkzb3jE3nVk5HkHoepvWDjC
         IJZQ==
X-Gm-Message-State: AOJu0Yy2JLNXJQHeFu4F8DfKteqIskxi65eFqrANJZ58o+hsb2MHl0/l
	Oigw2Btl69eDM8h+ViDaE1DcO7QzX2FW6Bn0kx7sVyGHo3RPE06fG8WOJQR361QzC6USXeJpXND
	+rUYg
X-Gm-Gg: AR+sD12VQBdQs3xgk86jRLj5NdwJhR3LQ2CR+XQPHWahzoU4SZdV/OfDz59FDF8oias
	1BVWOPs5HY0HsbO+IRFaGWO1jrmIIisyhfpoF+Hu5Q9yZgc3Ju0iNpVG2cmCOGfQT7CW2lrwJc0
	Yv0DkyxRRMQhV+GjgK9FNpbYpboe76au7ZWvpdDUn6nCtTeaD2tXg3a31TqqFhE0f6CT5+v69/K
	jOkp/DRHGoPXS3JwF2nl6+0rltJihBttgMts+KGy5A3Lrd+GR/fGJGWDoL7ILYTveXLU0IbHoNn
	/zJ7q6QUgTsvNOw1AGox+zjiZdEfL9YtKIk7uBgYdBrdX7KlIqjsbxBX8rWEAcqLOrFaxrilx5d
	knCLlgNJPy8QJIleooyKnspYnGmb/KJhr3YbFnlVCL6D23/8i/13Y9gQC/UDaP5BjqwJdCNH1cz
	IhgczGkiGHe0lUDAU3Q/MvbqYnB3YKauuw5UHLpyfz
X-Received: by 2002:a17:903:1aa7:b0:2ca:10c6:f69b with SMTP id d9443c01a7336-2cfde790447mr50788525ad.5.1785081009928;
        Sun, 26 Jul 2026 08:50:09 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc549b11sm23512962eec.18.2026.07.26.08.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 08:50:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 v3] add print_hexstring helper
Date: Sun, 26 Jul 2026 08:50:04 -0700
Message-ID: <20260726155004.75719-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hexstring_n2a() writes into a caller-supplied buffer and silently
truncates when it is too small: the loop stops once fewer than three
bytes remain and returns the partial string. Callers using a fixed
SPRINT_BUF therefore drop trailing bytes for keys wider than 31 bytes.

Add a new function print_hexstring() that formats and prints a binary
attribute in one call.

Convert the callers that dump a binary attribute straight to output
over to print_hexstring().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/json_print.h |  3 +++
 ip/ipaddress.c       | 19 ++++++-------------
 ip/ipmacsec.c        |  7 ++-----
 lib/bpf_legacy.c     |  6 ++----
 lib/json_print.c     | 13 +++++++++++++
 tc/f_bpf.c           |  8 +++-----
 tc/m_action.c        |  9 +++------
 tc/m_bpf.c           |  9 +++------
 8 files changed, 35 insertions(+), 39 deletions(-)

diff --git a/include/json_print.h b/include/json_print.h
index c0d6315f..6a458189 100644
--- a/include/json_print.h
+++ b/include/json_print.h
@@ -84,6 +84,9 @@ _PRINT_FUNC(float, double)
 _PRINT_FUNC(tv, const struct timeval *)
 #undef _PRINT_FUNC
 
+void print_hexstring(const char *key, const char *fmt,
+		     const __u8 *data, unsigned int len);
+
 #define _PRINT_NAME_VALUE_FUNC(type_name, type, format_char)		  \
 	void print_##type_name##_name_value(const char *name, type value) \
 
diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index 6017bc83..7e4cb77c 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -1263,22 +1263,15 @@ int print_linkinfo(struct nlmsghdr *n, void *arg)
 				     rta_getattr_str(tb[IFLA_PHYS_PORT_NAME]));
 
 		if (tb[IFLA_PHYS_PORT_ID]) {
-			print_string(PRINT_ANY,
-				     "phys_port_id",
-				     "portid %s ",
-				     hexstring_n2a(
-					     RTA_DATA(tb[IFLA_PHYS_PORT_ID]),
-					     RTA_PAYLOAD(tb[IFLA_PHYS_PORT_ID]),
-					     b1, sizeof(b1)));
+			print_hexstring("phys_port_id", "portid %s ",
+					RTA_DATA(tb[IFLA_PHYS_PORT_ID]),
+					RTA_PAYLOAD(tb[IFLA_PHYS_PORT_ID]));
 		}
 
 		if (tb[IFLA_PHYS_SWITCH_ID]) {
-			print_string(PRINT_ANY,
-				     "phys_switch_id",
-				     "switchid %s ",
-				     hexstring_n2a(RTA_DATA(tb[IFLA_PHYS_SWITCH_ID]),
-						   RTA_PAYLOAD(tb[IFLA_PHYS_SWITCH_ID]),
-						   b1, sizeof(b1)));
+			print_hexstring("phys_switch_id", "switchid %s ",
+					RTA_DATA(tb[IFLA_PHYS_SWITCH_ID]),
+					RTA_PAYLOAD(tb[IFLA_PHYS_SWITCH_ID]));
 		}
 
 		if (tb[IFLA_PARENT_DEV_BUS_NAME]) {
diff --git a/ip/ipmacsec.c b/ip/ipmacsec.c
index fc4c8631..1864ffd3 100644
--- a/ip/ipmacsec.c
+++ b/ip/ipmacsec.c
@@ -661,11 +661,8 @@ static void print_flag(struct rtattr *attrs[], const char *desc,
 
 static void print_key(struct rtattr *key)
 {
-	SPRINT_BUF(keyid);
-
-	print_string(PRINT_ANY, "key", " key %s\n",
-		     hexstring_n2a(RTA_DATA(key), RTA_PAYLOAD(key),
-				   keyid, sizeof(keyid)));
+	print_hexstring("key", " key %s\n",
+			RTA_DATA(key), RTA_PAYLOAD(key));
 }
 
 #define CIPHER_NAME_GCM_AES_128 "GCM-AES-128"
diff --git a/lib/bpf_legacy.c b/lib/bpf_legacy.c
index 50ca82c1..9d5fcf5f 100644
--- a/lib/bpf_legacy.c
+++ b/lib/bpf_legacy.c
@@ -176,7 +176,6 @@ int bpf_dump_prog_info(FILE *f, uint32_t id)
 	struct bpf_prog_info info = {};
 	uint32_t len = sizeof(info);
 	int fd, ret, dump_ok = 0;
-	SPRINT_BUF(tmp);
 
 	open_json_object("prog");
 	print_uint(PRINT_ANY, "id", "id %u ", id);
@@ -190,9 +189,8 @@ int bpf_dump_prog_info(FILE *f, uint32_t id)
 		int jited = !!info.jited_prog_len;
 
 		print_string(PRINT_ANY, "name", "name %s ", info.name);
-		print_string(PRINT_ANY, "tag", "tag %s ",
-			     hexstring_n2a(info.tag, sizeof(info.tag),
-					   tmp, sizeof(tmp)));
+		print_hexstring("tag", "tag %s ",
+				info.tag, sizeof(info.tag));
 		print_uint(PRINT_JSON, "jited", NULL, jited);
 		if (jited && !is_json_context())
 			fprintf(f, "jited ");
diff --git a/lib/json_print.c b/lib/json_print.c
index 810d496e..f604f265 100644
--- a/lib/json_print.c
+++ b/lib/json_print.c
@@ -179,6 +179,19 @@ int print_color_string(enum output_type type,
 	return ret;
 }
 
+/* Print binary data as a hex string. The buffer is sized to the input,
+ * so keys of any length are printed in full rather than truncated.
+ */
+void print_hexstring(const char *key, const char *fmt,
+		     const __u8 *data, unsigned int len)
+{
+	int blen = 2 * len + 1;
+	char buf[blen];
+
+	print_string(PRINT_ANY, key, fmt,
+		     hexstring_n2a(data, len, buf, blen));
+}
+
 /*
  * value's type is bool. When using this function in FP context you can't pass
  * a value to it, you will need to use "is_json_context()" to have different
diff --git a/tc/f_bpf.c b/tc/f_bpf.c
index 6dd75445..50fe01ca 100644
--- a/tc/f_bpf.c
+++ b/tc/f_bpf.c
@@ -241,11 +241,9 @@ static int bpf_print_opt(const struct filter_util *qu, FILE *f,
 	if (tb[TCA_BPF_ID])
 		dump_ok = bpf_dump_prog_info(f, rta_getattr_u32(tb[TCA_BPF_ID]));
 	if (!dump_ok && tb[TCA_BPF_TAG]) {
-		SPRINT_BUF(b);
-
-		print_string(PRINT_ANY, "tag", "tag %s ",
-			     hexstring_n2a(RTA_DATA(tb[TCA_BPF_TAG]),
-			     RTA_PAYLOAD(tb[TCA_BPF_TAG]), b, sizeof(b)));
+		print_hexstring("tag", "tag %s ",
+				RTA_DATA(tb[TCA_BPF_TAG]),
+				RTA_PAYLOAD(tb[TCA_BPF_TAG]));
 	}
 
 	if (tb[TCA_BPF_POLICE]) {
diff --git a/tc/m_action.c b/tc/m_action.c
index 6f79fdae..bbc8e6a6 100644
--- a/tc/m_action.c
+++ b/tc/m_action.c
@@ -401,12 +401,9 @@ static int tc_print_one_action(FILE *f, struct rtattr *arg, bool bind)
 		print_nl();
 	}
 	if (tb[TCA_ACT_COOKIE]) {
-		int strsz = RTA_PAYLOAD(tb[TCA_ACT_COOKIE]);
-		char b1[strsz * 2 + 1];
-
-		print_string(PRINT_ANY, "cookie", "\tcookie %s",
-			     hexstring_n2a(RTA_DATA(tb[TCA_ACT_COOKIE]),
-					   strsz, b1, sizeof(b1)));
+		print_hexstring("cookie", "\tcookie %s",
+				RTA_DATA(tb[TCA_ACT_COOKIE]),
+				RTA_PAYLOAD(tb[TCA_ACT_COOKIE]));
 		print_nl();
 	}
 	if (tb[TCA_ACT_FLAGS] || tb[TCA_ACT_IN_HW_COUNT]) {
diff --git a/tc/m_bpf.c b/tc/m_bpf.c
index a5de7da1..83b21b57 100644
--- a/tc/m_bpf.c
+++ b/tc/m_bpf.c
@@ -183,12 +183,9 @@ static int bpf_print_opt(const struct action_util *au, FILE *f, struct rtattr *a
 		d_ok = bpf_dump_prog_info(f,
 					  rta_getattr_u32(tb[TCA_ACT_BPF_ID]));
 	if (!d_ok && tb[TCA_ACT_BPF_TAG]) {
-		SPRINT_BUF(b);
-
-		print_string(PRINT_ANY, "tag", "tag %s ",
-			     hexstring_n2a(RTA_DATA(tb[TCA_ACT_BPF_TAG]),
-			     RTA_PAYLOAD(tb[TCA_ACT_BPF_TAG]),
-			     b, sizeof(b)));
+		print_hexstring("tag", "tag %s ",
+				RTA_DATA(tb[TCA_ACT_BPF_TAG]),
+				RTA_PAYLOAD(tb[TCA_ACT_BPF_TAG]));
 	}
 
 	print_action_control("default-action ", parm->action, _SL_);
-- 
2.53.0

