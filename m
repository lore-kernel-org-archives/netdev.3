Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B43A6EEC
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857281; cv=none; b=BW6g2gRgv2ggD3oNVjn33IM1FIditEfBr41C6KCY26zj4rk+BpfKQ0nWWWMdkWXqCbcWRsFW/4Itoys0OHzcD6+4Cnk/LoVRLwi8AqPGWmqYJSsBfoMsvIL3h5XigqvOtUNnXgRlNVG5APhCP5ONrOJj1wmFXYAV/xAgMVAkcqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857281; c=relaxed/simple;
	bh=NoYLQ/BarOSRXyrwHUkedHUpGCwMk3EDs6vhrDTQqbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tslgaGfQ98DqzuZxbNkdcPKIP9owKhpfAoZiMzaA6OR/Cfzf0fYqitWCfXgjKRV5DHM72QoZnLhY7JnqkIG5QoqCQ5Im1/4xrMHbEtvYQf2rNMQNkWaW+7buVjCZY7LrczkNN2mfmk5yUHEdP/5dFDlyNe0iG2f29cPOi8ZvkXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eppMT/VO; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eppMT/VO"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-86868f7707dso899866b3a.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 15:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789857280; x=1790462080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NjNrC87GI6r/hyASC6W4vHpCo4NDAOckP9GbczGyTro=;
        b=eppMT/VOKo+W8aU07XFPg+4/Yle1FNoJ7ea2FoWVslBUdRo3g8Cy8fbImqFP9KfDin
         2OXQ8HnPwp4V4UhrioLDm2Uz7bprb0MOk05bf+KWMCvjcdZ1x/bV3GPs0N3rhU44gF5E
         K6tAfyv3xz5yJOyg7ihUag8Od7BrEmXoxsSmuqj7mRoShGms5JDAfiFnI67YfXA/SOhT
         +wy7MHta+u7GGMRBuTeheqS0Ib8UufECdM/XaQd1rvjI/tnVy+3JItCKhUh9DuACkfIa
         4Vk0wG0Wg9EsxLbhn3CD3ucq3APqNa11oE9+nugwZ9ECg94J9lcVRfp1l/PSpLDw3HTJ
         QznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789857280; x=1790462080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NjNrC87GI6r/hyASC6W4vHpCo4NDAOckP9GbczGyTro=;
        b=srtlFMrAWMIPzTJiSdECFd3AmViZF2zbeusc/gQiMvubSLaVQxExABXPvwPiXZ5Hvi
         7V7IU3J6XfO1XyTiFg5biKH91FG9ACuPB//sVKvKH3/7V0ONQKn7c2WpXv+8pCQ4Xam6
         kKDbdhvzx+iVMWKSlOYKFyIcH5X5ebwHWIcMdoLNAK5VoKRWLndzAkL2T8mIxo5RVcil
         uhDVATO94erR4H4ZWp3W9ZepU2tfGFghBXJdrXtqhV/wP8FB0EPz1LpN/HC7B/DmLo2f
         spwss474IeOGkt7w8aqWHmoF4IzRXtG7ydKq2sKId7MTo2H9YXQLB8ILChkYy/pRtUt3
         F2fw==
X-Forwarded-Encrypted: i=1; AKwUvBxJ5Wxic4sPHdt5pEf5tCs4EankW2IP3X/W1CElPzDUB9CdqWklo9tosQvqticUCDjiHW1U9U4=@vger.kernel.org
X-Gm-Message-State: AFuF++ms7uhg03mIA3IBfFbv/MENOgkLfzilbC0EltT+6+4dBG4p71AM
	tJ0ESxC6k7iZWumec/b4ytHv2jMKrz1DlvFT5XdQmaB1WqwkraWjnzVl
X-Gm-Gg: AYBFou05Pj8P3yDBHbyw6g0kjdzv3nxNllo0BDWSsPMG7UMimhp0OlbH6PFh1iuAEcT
	tv7Ek/ocV4CjJJxzuVMHlF/mBpyxq1M3VjrpkaUW1ELQfYdkndqpQQqWuAvDQ8X+eeRsYDtQb4K
	LayYfvJKWycZafmDWmGn4VCvx9Gh2E6LECBAoW/C8Wb3OSqrii2JMUjgK/HJ9ycqwxp1IpD/h7w
	g944kjoxXLAQfKvVJCitOcyI2C2OO8Pw780LPXjfazA7VqhTACrOCu5R6y27yliPkKsNN5VWzIs
	PfWh4Ac0DhMuYPFobkMvJDixIN4XXaZbdUvuyPMaEimWO8ZYQykl7I0XI5ulKvmhtn1R1YUfe/3
	icgsestjpU+h0SrOxBudMASqVRSwXyS/sl7F07sgr5bzk/VoeFnpxxDyg51Li4FCtS2Vgwh/7cY
	NohLaIZc2KAk3OWrk+vvYp7BpPE63jB8f1xhQov44yoVl6piYxc0Ip0jAnXJXRr72RmC7WJZigq
	U24R7iScX+SECrslv41Fzw5hJ5UdWw7S/v9dnTwX0sm4WztDcLK5EMzvhGW9DhhD3E8lO3g2chp
	WKOwU5GYYw==
X-Received: by 2002:a05:6a00:b49:b0:871:b1b0:e495 with SMTP id d2e1a72fcca58-874dc4f31aemr10100311b3a.15.1789857279724;
        Sat, 19 Sep 2026 15:34:39 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a8dfe533sm1391208b3a.10.2026.09.19.15.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:34:39 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: paul@paul-moore.com,
	dhowells@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netlabel: calipso, x509: clean up ADDRSELECT on DOI removal and check AKID len
Date: Sat, 19 Sep 2026 22:34:38 +0000
Message-ID: <20260919223438.3883567-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two issues in netlabel CALIPSO and X.509 key parsing:

1. In netlbl_calipso_remove_cb() (net/netlabel/netlabel_calipso.c), also
   inspect NETLBL_NLTYPE_ADDRSELECT entries so IPv6 address-selected
   mappings referencing a removed CALIPSO DOI are removed.
2. In crypto/asymmetric_keys/x509_public_key.c, guard against zero-
   length signature/AKID fields before key matching.

Fixes: cb72d38211ea ("netlabel: Initial support for the CALIPSO netlink protocol.")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 25cf8ac7f257..5c9165a83f91 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -53,9 +53,11 @@ int x509_get_sig_params(struct x509_certificate *cert)
 
 	if (sig->algo_takes_data) {
 		/* The signature algorithm does whatever passes for hashing. */
-		sig->m = (u8 *)cert->tbs;
+		sig->m = kmemdup(cert->tbs, cert->tbs_size, GFP_KERNEL);
+		if (!sig->m)
+			return -ENOMEM;
 		sig->m_size = cert->tbs_size;
-		sig->m_free = false;
+		sig->m_free = true;
 		goto out;
 	}
 
diff --git a/net/netlabel/netlabel_calipso.c b/net/netlabel/netlabel_calipso.c
index e1efd888b4a2..3756193b1c49 100644
--- a/net/netlabel/netlabel_calipso.c
+++ b/net/netlabel/netlabel_calipso.c
@@ -283,10 +283,21 @@ static int netlbl_calipso_listall(struct sk_buff *skb,
 static int netlbl_calipso_remove_cb(struct netlbl_dom_map *entry, void *arg)
 {
 	struct netlbl_domhsh_walk_arg *cb_arg = arg;
+	struct netlbl_af6list *iter6;
+	struct netlbl_domaddr6_map *map6;
 
 	if (entry->def.type == NETLBL_NLTYPE_CALIPSO &&
 	    entry->def.calipso->doi == cb_arg->doi)
 		return netlbl_domhsh_remove_entry(entry, cb_arg->audit_info);
+	else if (entry->def.type == NETLBL_NLTYPE_ADDRSELECT) {
+		netlbl_af6list_foreach_rcu(iter6, &entry->def.addrsel->list6) {
+			map6 = netlbl_domhsh_addr6_entry(iter6);
+			if (map6->def.type == NETLBL_NLTYPE_CALIPSO &&
+			    map6->def.calipso->doi == cb_arg->doi)
+				return netlbl_domhsh_remove_entry(entry,
+								  cb_arg->audit_info);
+		}
+	}
 
 	return 0;
 }
