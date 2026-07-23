Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C42743D4E0
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 19:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834129; cv=none; b=ZQNg8DOGotDE1uG7j7bg9B0qlddMVRH7a1WFMwR92VOY1nKm+2zoSuOP9pm1bYbLhJqS78FYLCrgOSCyM1x9CeCOyw9c7l3DDs1EfsKFsMTppWPPp5RchFFQE0Om1lW3TzDz/3KAnfMm6pXG13CqbyvWtoRP48qDg7Dq9FDuH3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834129; c=relaxed/simple;
	bh=pbHOj3ag0M1Vaq7tQcjLwy8qohdr4R6dy/QJHyKBdsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mprfZGK8v27bZ1c7fJ7/Cyn4CXCorZIuAjgfp/7kM3ErtpV78DJ/sMpPuYVXiZ6d30DlSr0J4ZE7pzTMgBjDBzZ35ZUX3hjAMYeJxHWbJJKlEHQA4tqjiFzc3+djdsckh9Xu3ISQYqb4Aj65E6QjcIyzo9iasVv30YSW3yodQ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=KG1PojD0; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="KG1PojD0"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbb662575d3so619295a12.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 12:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784834119; x=1785438919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PBXF0i3GwHrICUbzY58TjNV6kLvUrfghJLdMx5boL90=;
        b=KG1PojD0GtKDUCk9EtCaJHSKQyl1OnXSsRFcc+kZRJ5WEUEhDKfQbfTQ6bAhfUIUAq
         piqi1H05mDkWzXDnHDE705avXmp1+CEUYp+zdRb+O8gKq9k7FO3tyL0zgxELyftFupae
         SX9Eq9xDhuM2cusoQyYvXWbMwlCsdz0D1GaqUm2mu4c8GsWOyFK7rM7NtrnFcH1KFMqI
         2yoT/gLfexlKa5+LHayBaLOh2AQp8ZpoFwA8s5Tu4rBImFMgh2QOmKYgVy5CXvimP4/f
         qTvIU3Ss+DMpE6zdmRVEzi0iMTWJEpS5oWlK4RI/wsjHryBEWUidSEaoyfS+TmgzXaEU
         Pong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784834119; x=1785438919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PBXF0i3GwHrICUbzY58TjNV6kLvUrfghJLdMx5boL90=;
        b=jSpZHANAHvu8jxPW3jwlCFR377iknz4LeekVn+bt0pbPOypUiVaHXxVz+k9Oi3l5fC
         b6fScv5adyFUE+1/ZRmL0GMTAxsoa/eWI2QSFn9Eh0TPE24+HSMzH4Ms2aLGA7kEMHVM
         TD8CnHY2mnqLSAZhbfU/ND5veeVUKCHKrLaN5gOt+VFugRVLi9lQTp0GaaHX5/Ct4dKJ
         n6FT6yyGQDBcMD+q5TIdvHytWumkfOJBFti8Rs8js2smtMtnjuWLPxBW4grpSQGlhej5
         CTJ1rMpdUYiWD0Hk6gNGhXGFzVgPAokg+9W0fkmXO3LQYXLvvqWzDb42orrh7FimsRqf
         mG4w==
X-Gm-Message-State: AOJu0YxG0ejOqlYLw1VOxurto6NTe8KOJw1yw6wbueB/zWx0suxJJxWj
	xmELh/KNhevRxJlD9HPO0uWlmhZD8rE3yCAnpfGcfwcZUpvFHzAwoZSKxC7riVIEKHx6PLx1hLz
	f6CbL
X-Gm-Gg: AR+sD10OuD6B0E/Fo5ATxoqEyCCIdGnfxEaLVraU8MuUPX6ieDLWB5un9nZUL2MdRZv
	NcjToqfnJ1ck0GraTNTZNCXTe3nBB9AaEIi9zMmQpQYUb+CktDqp2hNDUzPFvVHyM5edwoR1Pq7
	VDc3G42oJJzaUzAMtrc7/vM7BPcFZ0ps8crB/oDfY/wUTtcxQM8gdxG6a5OVLg8YcnZ9FdD+ZSq
	aEEitz7AVdSfBqV8nIAjWIqK9A1P6W1Qkg6cK/RY17fWFu0CW8qbhHeBfWXSUTdo5oIo6UhhuPO
	F4nA2FOFu02V0hlmWejTJ1WGNsqIgVtqbJf7u27RZsXPfKdD+6j1DWle9Ge3S30fa3lTZpyVCD+
	7pn9Zeed+/2kTCDRp3Ee+/ZUdt3ENQcEOjQU1kmWISvDDCerwaOzuioIRBgGBavbdKTmUQ9TNwr
	aIuk0iFo7f2Y7wv95cWX1R4PPKITnu0wX4euNGeLXT
X-Received: by 2002:a05:6a21:1519:b0:3c4:1c9f:d91 with SMTP id adf61e73a8af0-3c44b247352mr4975047637.59.1784834118678;
        Thu, 23 Jul 2026 12:15:18 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3149198adabsm11843090eec.8.2026.07.23.12.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:15:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 3/3] tc: build ct label strings with hexstring_alloc
Date: Thu, 23 Jul 2026 12:11:40 -0700
Message-ID: <20260723191511.216182-4-stephen@networkplumber.org>
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

flower_print_ct_label() and ct_print_labels() formatted the key and
optional mask into a fixed on-stack buffer with manual pointer
arithmetic, relying on hexstring_n2a() not to overrun it. Build the
"key/mask" string with hexstring_alloc() and asprintf() instead, which
sizes to the data and drops the open-coded offset handling.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/f_flower.c | 25 ++++++++++++++-----------
 tc/m_ct.c     | 24 ++++++++++++++----------
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/tc/f_flower.c b/tc/f_flower.c
index 6fc2c6a1..d6844282 100644
--- a/tc/f_flower.c
+++ b/tc/f_flower.c
@@ -2619,18 +2619,15 @@ static void flower_print_ct_label(struct rtattr *attr,
 {
 	const unsigned char *str;
 	bool print_mask = false;
+	char *key, *out;
 	int data_len, i;
-	char out[128];
-	char *p;
 
 	if (!attr)
 		return;
 
 	data_len = RTA_PAYLOAD(attr);
-	hexstring_n2a(RTA_DATA(attr), data_len, out, sizeof(out));
-	p = out + data_len*2;
+	key = hexstring_alloc(RTA_DATA(attr), data_len);
 
-	data_len = RTA_PAYLOAD(attr);
 	str = RTA_DATA(mask_attr);
 	if (data_len != 16)
 		print_mask = true;
@@ -2638,16 +2635,22 @@ static void flower_print_ct_label(struct rtattr *attr,
 		if (str[i] != 0xff)
 			print_mask = true;
 	}
+
 	if (print_mask) {
-		*p++ = '/';
-		hexstring_n2a(RTA_DATA(mask_attr), data_len, p,
-			      sizeof(out)-(p-out));
-		p += data_len*2;
+		char *mask = hexstring_alloc(RTA_DATA(mask_attr), data_len);
+
+		if (asprintf(&out, "%s/%s", key, mask) < 0)
+			out = NULL;
+		free(mask);
+		free(key);
+	} else {
+		out = key;
 	}
-	*p = '\0';
 
 	print_nl();
-	print_string(PRINT_ANY, "ct_label", "  ct_label %s", out);
+	print_string(PRINT_ANY, "ct_label", "  ct_label %s", out ? : "");
+
+	free(out);
 }
 
 static void flower_print_ct_zone(struct rtattr *attr,
diff --git a/tc/m_ct.c b/tc/m_ct.c
index e549cb9c..e5eebbda 100644
--- a/tc/m_ct.c
+++ b/tc/m_ct.c
@@ -443,17 +443,15 @@ static void ct_print_labels(struct rtattr *attr,
 {
 	const unsigned char *str;
 	bool print_mask = false;
-	char out[256], *p;
+	char *key, *out;
 	int data_len, i;
 
 	if (!attr)
 		return;
 
 	data_len = RTA_PAYLOAD(attr);
-	hexstring_n2a(RTA_DATA(attr), data_len, out, sizeof(out));
-	p = out + data_len*2;
+	key = hexstring_alloc(RTA_DATA(attr), data_len);
 
-	data_len = RTA_PAYLOAD(attr);
 	str = RTA_DATA(mask_attr);
 	if (data_len != 16)
 		print_mask = true;
@@ -461,15 +459,21 @@ static void ct_print_labels(struct rtattr *attr,
 		if (str[i] != 0xff)
 			print_mask = true;
 	}
+
 	if (print_mask) {
-		*p++ = '/';
-		hexstring_n2a(RTA_DATA(mask_attr), data_len, p,
-			      sizeof(out)-(p-out));
-		p += data_len*2;
+		char *mask = hexstring_alloc(RTA_DATA(mask_attr), data_len);
+
+		if (asprintf(&out, "%s/%s", key, mask) < 0)
+			out = NULL;
+		free(mask);
+		free(key);
+	} else {
+		out = key;
 	}
-	*p = '\0';
 
-	print_string(PRINT_ANY, "label", " label %s", out);
+	print_string(PRINT_ANY, "label", " label %s", out ? : "");
+
+	free(out);
 }
 
 static void ct_print_helper(struct rtattr *family, struct rtattr *proto, struct rtattr *name)
-- 
2.53.0

