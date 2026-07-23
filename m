Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3473A6B8D
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 19:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834125; cv=none; b=bO7KnzP/1+CJuT0BGLyKJKCtOQTskdYh/A0VnymcVv1KOapLxKSRfjXCvzo1t5005alJmdQHhN5kFxdZbw2QBpsuWh8BVIJuXfxsc0ouVaaywdAtu3Oc9/fxA4dkG2Jufx/+ej8w0PQ6LlEgltx2zazIk8C0IMv8pzyPqcazKfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834125; c=relaxed/simple;
	bh=luMNcnUbZM+5defFt9RtbR+uyTtBYcUn60zh/5e5yAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHiB9UlPws51HGNxU1LtmqodLLkbxf+buO3ADlf1U6/komyU7NI6Inzc5yTeW+pBLyTgbUPuG/6NCOy4Yh+asHCi77hWdTcID83Y0aUJhn+L/PXpJnw5qn8hL2+Eh4r3IPvaHLhUlJQ6TdPove4+33vYGhM4s2RZ64VLcncS5so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=ss9UMtV2; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="ss9UMtV2"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbb662575d3so619287a12.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 12:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784834118; x=1785438918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pmgtpi2prtTvQLvgA2fHr34hLJU7H0M/S8gh39eDxLY=;
        b=ss9UMtV2CB0rXXVCAPTm3sLEd5kzH0iAI93VmDMfozoWn9QXtrG1LAGHwHv05Israh
         Fm7L79HOhH9Ahq4G1m3ps9GzXDVoTPH6QFrzvzQCE7Kt0EoCM86dCBsseiZny9UNigBZ
         GiHOfEgyCRC/5v3T+GqFuaZMxjwtuXB94NLkHzXtMNsvvTavKckoh82tBpgXd+X5Qrfy
         1AnWYesDgcx9CBuGL6LWWxm7KFxy1ilfE5XoowSVD0PBr9ZitHzxI8spXbQaLlklfrCO
         /VVI82yiZGDH0z740ydOaTRDmvOTx9Ni0JreIzSv3sp4y7HNzUDctPTs+wYOVr+LOHnw
         KPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784834118; x=1785438918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pmgtpi2prtTvQLvgA2fHr34hLJU7H0M/S8gh39eDxLY=;
        b=YqSqAtSrpp24M9sSK65tDvWvyeMfr6/WwxFOJ7Net40NGErPwlaf2VUyegbSml9r7T
         t0wmA+mM+McoV6+VpPNsDmQaN9f27vqiFeOzFCDtbUlyjutPtfpdFWpQbhBas6ShaByd
         +Ra/NJ7FKn0D7ce8fAQ98vbDByQj6eoeS7pTQK6zPZuck9lz8mkJuW9gV/f/e0XQxt+D
         cvSziwt0RlgGtWUD/LQzEDOg18sXV67RUNoBoRvLmp16lrYrKsFFNjn6dH1sL8D3EguV
         EUe2RLJK7gnwq3u8mjVuVCpAmBB/S5lf3wQeS9En7J2wqT7EABdXndgT1fI1Bxgi2i+T
         n5dg==
X-Gm-Message-State: AOJu0Yw4/4Jb4TkpEFK1hrRJX/ACzjtwD4AHyDP446KZqgxd3TZIb1k9
	DJYjOsKhQ577jcCLpyuYXm0vSKhEd9Jge1wMs3Bp6B1vsmBeC6HMF4hnTE2qcKP+YD9/W/vL3Th
	SQ+Li
X-Gm-Gg: AR+sD106oFSW/98TkGWVNnEnEtLXXV9c+gZaQQVHQa6ZnRFWTNNxIHwd3nXABVwpIJC
	NR7DqMg8dOeIntmcTtYEQPMvMyGGkplPB/XnCnB6B+PBXu+UsXdmqzPH/lrj2fx612L1Jb00xZE
	/C+wPzr4R44MoyMrmleNnKSbo8xLxK1mAgu1uXxykMhhTx5p0PdA7zoGhsc6kKIOoN2vE6BunQ4
	0BtJbNBt25ondd+JoHbsbx54f35OwwaDGcJF8FD+ETSE3bEk9IoyO8pd4DmDOl+bfWowgtkGUV5
	9iu5aaeQ+m7Pxvl7fy3630MIbcisb/Fa294PAHQwvyby+U53GOY5iKwrFr3GoZZxLbfdXCP/eK2
	as+dKYATxzqtbKd+9xDGVOEdafQW70CuF4LRzfR9ahktaBA8m6VdENVgIDeGukqx4F9xxldvR9U
	NwoJYh+qezYJhhiLvBkFNfdtXV+9vj9Kun9QfeVpy2
X-Received: by 2002:a05:6a21:7a45:b0:3c3:6c90:65b3 with SMTP id adf61e73a8af0-3c44b2ae0e1mr5130754637.65.1784834117842;
        Thu, 23 Jul 2026 12:15:17 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3149198adabsm11843090eec.8.2026.07.23.12.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:15:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 2/3] ip, tc: print hex attributes with print_hexstring
Date: Thu, 23 Jul 2026 12:11:39 -0700
Message-ID: <20260723191511.216182-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723191511.216182-1-stephen@networkplumber.org>
References: <20260723191511.216182-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the callers that dump a binary attribute straight to output
over to print_hexstring(). This drops the per-site scratch buffer and,
for phys_port_id and phys_switch_id, fixes truncation of keys wider
than 31 bytes: a 32-byte netdevsim switch id previously printed only
62 of its 64 hex characters because it did not fit SPRINT_BUF.

No change to output for keys that already fit.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/ipaddress.c   | 19 ++++++-------------
 ip/ipmacsec.c    |  7 ++-----
 lib/bpf_legacy.c |  6 ++----
 tc/f_bpf.c       |  8 +++-----
 tc/m_action.c    |  9 +++------
 tc/m_bpf.c       |  9 +++------
 6 files changed, 19 insertions(+), 39 deletions(-)

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

