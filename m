Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793603519;
	b=nTwJwElIp4c0hXficWJLcMucaGDEqdKW3uyiYCigKtFAvVczBOXmyZlCBW1AOtbK9RGk
	 TFTx6e9HIGdcVBMDhsZXe1ot+aTZxqrowsWgS5hJH+z2ooCG1t3H7HM1LIpCXFw11OfHR
	 msrwUgXYzd4JC/o+OZfj5BSsKEVkzIe2HaWfzyCjgwDe/0tTKS9JJ4G9cT8dZ4dtPK8Fa
	 7/CxkdGktb3UBfbZnYcjD3jvx6x6hS96Z/94ILQpOD8zqmsrrMlzSGFxgGxR3jwGrhnk8
	 JCN7DDQ0KGufgYDDoqfkfrqPOAqXCZcwcg9qus47kObow6seKI2W/1mpzG+udGItWpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oXutaZ4BMILwaNtgFl+rxqGSEtMF1Ey4CTcPPNws+30=;
	b=yHlhSZxWOrzxCIMKI8OED9974A6sCeGwm/XuvA/T3TznrBU3B2+bai0/nN8bikt2VrDj
	 kZKLwP1HUp3K2dhKlET69VfufZUHu6veMBn8sBxLC+RDxyF4MWgGAbKrlRdmVo/ud0m50
	 ZBAeMlz0IKnqJg9NWwzHOQxF6WjGBqnWotsJQ8sbK+UvNvCuCSy3AOJTlABEAd5482oq4
	 xYv53z96ii4IpU5Avof8O3m3RNJVzPhCpmrG9viVT9oy8I5btR7FPKCH25fZx9RknpooC
	 JuWfCIeWSQKvKjQz/syV6Hs2UWcf53tf2pdfEN4WCDLj607lHAFcfDbFg8Yns0LCCig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ibwl4zS+;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039EA606A339
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 039EA606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ibwl4zS+
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a070781f63so974977b3a.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793603506; x=1794208306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oXutaZ4BMILwaNtgFl+rxqGSEtMF1Ey4CTcPPNws+30=;
        b=Ibwl4zS+0C9odUW5UmG49+17UpcUcCKiK3yfd0AFEZE8/aTCH9ytbd1iHHybTc7scb
         /lEsd/LZdmUMfSNFm6GFPO+9sP8OugWLIrbQ/urSERbxK8Q+Yq42ns+qFDs1JpSQmmD1
         gziz75qlfR93bvOcKn2rjh+kMQkDnZ3b44WGENZh3NmxFtzH1sTTauVgkuht0VmPNzWQ
         cLo3nKT2Lb8WBMdXNPXSUc7bfZ1n68RApf2pg+foD3Rrn45OMJH7ayrKIOQ9oTmJf8wO
         57dmYImxhjzUO5ED/FZxA6ffC3ymHGRgICZes3jtfvG3OY1epJ8m5BgawOP1JFjxbBPv
         7Gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793603506; x=1794208306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oXutaZ4BMILwaNtgFl+rxqGSEtMF1Ey4CTcPPNws+30=;
        b=pJljZbx4gRXUL9u57wEfbl0KDi0AVD4vczjXQpWNAM4G2YbUz1G4X+8H3ABP92wRa8
         cDCg0Rc/quWMJj2R3bB/tUJTsM67p356emye/TUOgekW14EutK66ollF5lW3dEPDeZW3
         BYAJSS5HEnJkJSObWFojN9mzJ8cIxcxUwmUbh8JXgNCcrxaa4/YoxuXlL8Lk7uM/YjJt
         m2DNIrzkrAZdLgQjwwBFu7PHdvwy7Bnv0OSLtq18J3S8QOB8zCTMZ93ZJtejNIbwpSQB
         JRfekOOBpPLasoczk3fUyZrxnxIAZ5cnVHx3M3UaFc2NPsbEHTeJfZzKY6qB7aRQyvgy
         msAg==
X-Gm-Message-State: APuU4Z8UHXR0L4u/vUAPY2RNke/uLTA5GW8DNaO1cFQMbfMmOdhpOMIi
	bBU0g7piSpjRp/41919HDM2Fz1E2D99jcdM4qhXl131m+bXtKN7ueJpmmzG65E0y
X-Gm-Gg: AYBFou1aeRMgZ240oyYbkiXd76LEFq4pRJd/XPLaJcAJ68PFvUIHmXRqAz+WIQgybQZ
	z4WFFfc5WwWgMaopuGGasd8FYmtBcgArepmc1NGGqjOtp4YVf6ZbwuSBfczTrVCU6H+Xthdf1LF
	aPLRSE6ruo5e1YxO4IoY4+rbuzU/Zz0ysfuDnaG0K85q7Vz7qbsIYpWLYXAEj9eiscJHRXsGlbu
	k/TPRHP/MuDVrOkqldNevH9JmrM4a/j1XHDE1CkPJrqIqFUZQkXxUo5afEBZGInsdmwpLY6303z
	7KTMZ8f1tNZA8NwQmp51y6eU97Tm+bxMzOIPPeV/+XlZXEA23jDZ5KCMK+xGrUBRZ+RoIixRBEc
	hnRRUsErOxLRG4m5PEHVq9iCnHaT5ek1YqwOg7vSg0y2sAVXV2xVAwyv7aDJHv2+Qoma4ldddtA
	F8A+cKREKr16VzxTaVIuEEMx77M7i1l22/0uxcq5HmeWdYspQfQbgjf3K1ZE8eeoae5U3Uj3f3u
	e7auvE9QHxlSUh3IgAr5aBvHMDjy8/PH185TBAks0HhpQh92fF621yQ2wP+9tLRdYambBUmvzR1
	kloM8ojqyt+n14GyTP8Sz+Rb9mFHroqNJRXR+VyMzDEGPtnR5O6j
X-Received: by 2002:a05:6a00:94f4:b0:880:e4a7:b1aa with SMTP id d2e1a72fcca58-8a9bfaf8ce7mr7350735b3a.55.1793603506365;
        Sun, 01 Nov 2026 23:11:46 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8abab0c6c6esm1140566b3a.48.2026.11.01.23.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:11:46 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/4] net: dsa: motorcomm: Fix IPv4/IPv6 address key dispatch in flower
Date: Mon,  2 Nov 2026 15:11:14 +0800
Message-ID: <20261102071119.3435180-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102071119.3435180-1-mmyangfl@gmail.com>
References: <20261102071119.3435180-1-mmyangfl@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IPv4 and IPv6 address keys share the same storage in struct
flow_rule, so flow_rule_match_key() reports both as present whenever
either one is. As a result, IPv4 address rule may generated bogus IPv6
address bins, and vice versa.

Dispatch on control.addr_type like other DSA drivers do.

Fixes: 8eb9e7520b17 ("net: dsa: yt921x: Add ACL support")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/tc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
index 8835907366bf..5a4459507582 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -580,6 +580,7 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 	unsigned int udfs_cnt = 0;
 	unsigned int size = 0;
 	__be16 n_proto = 0;
+	u16 addr_type = 0;
 	u8 ip_proto = 0;
 	bool use_dport;
 	bool use_sport;
@@ -603,8 +604,15 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 		return -EOPNOTSUPP;
 	}
 
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL)) {
+		struct flow_match_control match;
+
+		flow_rule_match_control(rule, &match);
+		addr_type = match.key->addr_type;
+	}
+
 	/* Entries */
-	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
+	if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
 		struct flow_match_ipv4_addrs match;
 
 		flow_rule_match_ipv4_addrs(rule, &match);
@@ -630,7 +638,7 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 		}
 	}
 
-	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV6_ADDRS)) {
+	if (addr_type == FLOW_DISSECTOR_KEY_IPV6_ADDRS) {
 		struct flow_match_ipv6_addrs match;
 
 		flow_rule_match_ipv6_addrs(rule, &match);
-- 
2.53.0

