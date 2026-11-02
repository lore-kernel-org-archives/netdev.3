Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793587163;
	b=hwhjl84PLTkR2xEVe380Xt+28b9YMxMoJDpeSn2j08kGir2bMiQ4nNpUrYdQIJoi5LCA
	 VRiGni4h7r6p5M3Gk6jnY8o6Jy8oS1FZo4esYMU/zLn106LmB1Dt1bqAD0qB3pX35l1w/
	 1K18a2jze6AxnONMlb869aXUy/Xb9nQO5tRMlY7lr9YdRVr5O4Fxdyvj0i1Jp0OnpK4kL
	 8zRAwRxa8wRlGLZ6EUMWXwZTDfNwBsUnf8JI0HQY75KlbKAY1rGzA9I7zVDycehAJ+k7R
	 9H8Rd4tTWkPfsbrp+4kL/W+ZuSg/VqajAfJlK1V1+jxWO0+sWZkTKGd036zQ8iiJ/gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793587163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KYYsPF3smfmDvFuVNAia89SV+iNatitTLTar5uvX6+M=;
	b=l/tFBKP0/5DPiCI6dSPEGQesFP4iYAkEf+WL86fYvX5EeM9FXyg5XyXEvg5T6RUL+0uj
	 +oZM7UI45DxrRFiyQRAIGFiM9xk1XxzHZW97Nxt0qRDsefo2UBPOh6+/Zbe6BuTuSDL/z
	 WArsFd+A/+BixkKtFVkAJqZWcBedGmdMUyXOwz1Jc8xoDru4STSU4+WBS+21B6bZw1T1H
	 Zc3gqPKkxw1sp+LZ+8qxc+awijQevJmza4hAaFn+A4klBIwDC73qcpSnGd28SbguPE7T5
	 AlR0Vuo/QIFvdezIz4P5Q27u8U1Iu4QjA3Dn9gTQ07lza0Vnm80bpN3Nr8INvqWZXUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bKWFUJFH;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA72606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 02:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DA72606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bKWFUJFH
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33fb4680717so3682894eec.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 18:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793587162; x=1794191962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KYYsPF3smfmDvFuVNAia89SV+iNatitTLTar5uvX6+M=;
        b=bKWFUJFHhIAMisXYjAxSuPuFkB+n1W5wt8aEbUVII2PSW2y8jTpq57TbJrC+v3c9wc
         Wqny9i/cQ4P83gSIwbCqLyAAMd9yt5EV1kyLL0wAlptB6EByiDq7yAJZC/0ZHRz4Cu8B
         MtYpKCOaI1+/LQdVApEBmMd+iOCQxMvhvRBhr6x1ZTu9i89HY9xc8lBWmQUnvKTA2Y3l
         Y0ZkladmKZFvjLw2WcA7VM99aHdBd+yMubSgx7JZu/SrQiFJtyPsBGZBvdDLsJsT05+m
         gKMFqopdrXaLQ1XWMb3WukH6dF8E1dDzVD7HDI5XEOX9+WIzIAfY9H9RdyPAwgSSW32I
         Eyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793587162; x=1794191962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KYYsPF3smfmDvFuVNAia89SV+iNatitTLTar5uvX6+M=;
        b=DRb3X/v/BBIrYunogp+hUZojb9sCz61pCm5U1bUQCmmAFENr/SHQkVDoE2e5wC8dyg
         mb8tXZARu7AV/HycwAQBDpAL10rTHOUaYvn6zyHHKmkuNlEAudgdLY0MozFOGPRXnnk5
         JyKh3RbQhQ/eI70v1yjYCxshvF472dp1mGHLdp3JwM91/3TPUpJm0fbJXbHocleAE7nF
         rZP49gNDecxje+O7dh4I/1p9Jiu+35eiej52KjSxx+mEtvabsi6+yWVyb9R2teAcwvCQ
         IxDo1XgWdWYWouGuOC0xsrhPtKv9CEh6zCsuhBrJcI/23EX4gKXtGfaclU56h9+iNaDM
         vuUg==
X-Forwarded-Encrypted: i=1; AKwUvByVcF21OV+7cI30Q4j3VWYIu9b1rrYfvRP7kWjb8C9VnG9wTRyF+r6L5/2xIMFXaaw6cwP48s4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wTxSWrE0tRpBDGNl664pCR9mI8t7IKW2/83gctqrKd7ABFQCN
	Fd30v9ey0DgzJ84+CmSEyGeyteu2tLxzJ0w/ShU15+b+XDrfbX+My701
X-Gm-Gg: AYBFou2/+oNLsez1A+bE0M6Frk28VWz0sHZ9MNwZWn2+9gWOrKzJPKl+8DwL+jm6/49
	oLEQlEMH3YQi1kRx02h11BeOFo0CCprxn72rCAx+V9I6xzZjUeAOlgkqzlYBz38E57NLdEgPlIS
	3poOaG3BcM1+QX1YPz/GjAJgStJIbwzzdkR+0JyhvpC8jnEnzE9eUJGhgS6iFNGDU1Zo5zp9T1Y
	8aa0mkUvD7KSH/LG5IR0RKayyBlLoovXVpbn9CJ/Nl8K+loY2Qx8n3prFHuBN1qFu8WKpHG5dHi
	OLCgxsoNgHYtcQAExtaksBn97uIhQ9vcdz7K1qpG8IvRPBJOswtPFUKjdEYZvc/QiKFv5+EFbPa
	Il9Q8xVkWBCaNvGY+PPgeYSzmf4OV/7PBFVh2vW5b2ge+yVIfTMoh0c9mH7jooQ1yK4sxBXZezz
	QW9oyTPUFqbro2cLhWyxSKLhq8fouBwT/qR7bSctfNViY/4qI5MmrOF4/DKPlpXkqOWNFeP5Pd4
	6+b7NQ6mc7S4PRNIbrdzcfYhZANuWKCT9/iUKnFZ9rcygvGKPI6TMR0X1ivvq9QuQPGj7Hh2TmE
	Ipl5E6dU/bq0cEpDbs2UkYxupjena5GRN7te3rJKlmV/KX3fBl3jSK/FcrnppDy2/BAzv8SIhrs
	Bh+apkrCaJkea/7v9FKd04sYLWKbVgT4ZpIZ3vHdehXZDbw==
X-Received: by 2002:a05:7300:cacb:b0:36a:3310:21a8 with SMTP id 5a478bee46e88-36a4238da58mr13728662eec.17.1793587162130;
        Sun, 01 Nov 2026 18:39:22 -0800 (PST)
Received: from l ([2603:8002:ea00:6800:4808:7aa2:ac97:30e9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42902649sm37008422eec.11.2026.11.01.18.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:39:21 -0800 (PST)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: Michal Kubecek <mkubecek@suse.cz>,
	netdev@vger.kernel.org
Cc: Dave Seddon <dave.seddon.ca@gmail.com>,
	Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH ethtool] netlink: require a value for hds-thresh and the TDR parameters
Date: Sun,  1 Nov 2026 18:39:19 -0800
Message-ID: <20261102023919.1472495-1-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.56.0
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

hds-thresh (-G) and first, last, step and pair (--cable-test-tdr) take
a value, but their parser entries leave min_argc at 0. Given as the
last word on the line, the value handler reads the NULL that ends argv
and the error message prints it:

  # ethtool -G eth0 hds-thresh
  ethtool (-G): invalid value '(null)' for parameter 'hds-thresh'
  # ethtool --cable-test-tdr eth0 first 1 last
  ethtool (--cable-test-tdr): invalid value '(null)' for parameter 'last'

Set min_argc to 1, as every other value-taking parameter does, so the
parser reports the missing value itself:

  # ethtool -G eth0 hds-thresh
  ethtool (-G): no value for parameter 'hds-thresh'

Only the message changes: the exit status was already 1 and no request
was sent.

Fixes: 66e5dcf295c0 ("ethtool: Add support for configuring hds-thresh")
Fixes: 9561db9b76f4 ("Add cable test TDR support")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
---
Checked by hand on a build of bae2dbd: all five parameters print the
"(null)" message before and "no value for parameter" after. make check
passes.

Claude found the issue while porting the code from C to Go, and drafted
the patch; I reviewed it and take responsibility for it.

 netlink/cable_test.c | 4 ++++
 netlink/rings.c      | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/netlink/cable_test.c b/netlink/cable_test.c
index fdb046e..648bf74 100644
--- a/netlink/cable_test.c
+++ b/netlink/cable_test.c
@@ -544,24 +544,28 @@ static const struct param_parser tdr_params[] = {
 		.type		= ETHTOOL_A_CABLE_TEST_TDR_CFG_FIRST,
 		.group		= ETHTOOL_A_CABLE_TEST_TDR_CFG,
 		.handler	= nl_parse_direct_m2cm,
+		.min_argc	= 1,
 	},
 	{
 		.arg		= "last",
 		.type		= ETHTOOL_A_CABLE_TEST_TDR_CFG_LAST,
 		.group		= ETHTOOL_A_CABLE_TEST_TDR_CFG,
 		.handler	= nl_parse_direct_m2cm,
+		.min_argc	= 1,
 	},
 	{
 		.arg		= "step",
 		.type		= ETHTOOL_A_CABLE_TEST_TDR_CFG_STEP,
 		.group		= ETHTOOL_A_CABLE_TEST_TDR_CFG,
 		.handler	= nl_parse_direct_m2cm,
+		.min_argc	= 1,
 	},
 	{
 		.arg		= "pair",
 		.type		= ETHTOOL_A_CABLE_TEST_TDR_CFG_PAIR,
 		.group		= ETHTOOL_A_CABLE_TEST_TDR_CFG,
 		.handler	= nl_parse_direct_u8,
+		.min_argc	= 1,
 	},
 	{}
 };
diff --git a/netlink/rings.c b/netlink/rings.c
index 5c695ab..22552df 100644
--- a/netlink/rings.c
+++ b/netlink/rings.c
@@ -202,7 +202,7 @@ static const struct param_parser sring_params[] = {
 		.arg		= "hds-thresh",
 		.type		= ETHTOOL_A_RINGS_HDS_THRESH,
 		.handler	= nl_parse_direct_u32,
-		.min_argc	= 0,
+		.min_argc	= 1,
 	},
 	{}
 };
-- 
2.56.0

