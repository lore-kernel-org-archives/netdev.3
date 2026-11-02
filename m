Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645488;
	b=m/OXcH/7ako+imI/RUj1YQwv/2twWOtXz7Hifz4nAr9i6kYpo2azkFqLZBvAaPXRB8ny
	 y/LL3vc50PrQ1KNrmhpuWk+iypYK8Vx61xRAHdvXEKs6mTJi/hxoB7q5kuwn7oVPbdtbj
	 wGF22ubIiVlrUkpHEyludmr28JImlfrNSV5mtwEqseqd8oH8aBD9+Rktm6RlCMPgSGWwx
	 wynSvhYP3drTJC55n1jn9dr3g/N4l6TF9zgao4fLOxx+x+B+1rlOoUDXWG9nRVCgmA+8F
	 Fu60Gq7oMupiiclKcHrfgjchiQIsSYih43UBW2Q617HiGRjOPtv2r8AK3payuhInwuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SXPkWwMAg9cJscI73YNbUORrN9g22TD5t6FqXWJ2g0I=;
	b=AxFpP8xGB5QOo44/3R67D19BrtoP6jPCvE5lJHhotuZf7NeLrWQ9jdr3k31dsHljL0cR
	 XSN6Zs1mCrvgw+BetoXi7X8FLngp+pr2kI5XiOQn666zjdRMOcK+buDkammNrOZ/6hurZ
	 rfMMWBYATMrRGrHnx8NcSELW51/SJwOCs0wDiKOTEGeFimqex7Lc8Psmutm3sN6eve5Tl
	 oFWyy8uhnNNikyU+ni61mlYa0rce9853YdC0FlMFj8LM4IbsdXLx9rODpxTmNONuBaDNo
	 kvabfBMo0JbEISWeJQBw4nqbBkAg5PG5YTtI6dSXDfg7F/7t5NZBeOsFK19BbBxCpUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xwy9SS29;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3F6606A33B
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 18:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB3F6606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xwy9SS29
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so4768138eec.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 10:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793645487; x=1794250287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXPkWwMAg9cJscI73YNbUORrN9g22TD5t6FqXWJ2g0I=;
        b=Xwy9SS29jgEou+dtHJxG2mh+vdvuw1KUXNyxXXSW8PfNwGTSo7i9YXecDhA56dr1lI
         VQSkUm6nAz5GozRZAApeY0MphO/K9St6pAs8QBF9jFOHEMAwaosewndN+/0LrP7rg52g
         SXS3uzHWI6i1JGMp8+mlAsQDNuWLKIpDTPCPLIveVnZZGGdlsZ1NR6bT3OqzfivupdQS
         OQZ56tE3AJazLWr7q/ingbmrTaHQupqGJYGllg+RBvvLL4NpbsFU7swAqHLTP1lonGHR
         40HvjeguwHxvJBjUGKpbdUhMm0HR1G1F4hqIGlauL3C3MunhFAGAmmJfQNir5FbXvCsd
         aSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793645487; x=1794250287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SXPkWwMAg9cJscI73YNbUORrN9g22TD5t6FqXWJ2g0I=;
        b=pJmfYV3bkKw4JjBzJLwitiBnj2M9QEQDvKbmKooBDz4HbL30mr245/a2MyzXqFlJzt
         Cmn2UMF1KcXm/kSMK6bp0KdKChKimiL+mMF9JbdI6YP3ueDwvvXlwB3uQ+2rfJRcs0ud
         Bzx5p6cR64+T4CULqxbecgVBEbJBis4BRcSo/L3AB/tKcoKk9CaXFZ5VS1yXW5Q5rl7X
         J1IBMd2OPBzQk0FQE6kPjJ7knY5mt3KLRoK7pkh5OEE1XpvOUrtfOJnF4d1a0BaFHD20
         1UpzMIfEl7xiVez+lqPOHwGMSn0QcG6w4QlI6fh6rJwwMylUEd68fQzwgxvBN+lpZcW4
         zt1Q==
X-Forwarded-Encrypted: i=1; AKwUvBz1ZLNEUztqf/rl7vzRIJANiWYH2tLwS0U1qW9dXMSuluU9JFWExBH1FWtzGeDgO47QWmjqpBc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2aLg09zLsiO/ah5Oig1xVW5mM+BpRfk4mfZylnguRhH+at5qX
	JR182NjDSmdmF4+24e1/9HVgk1WS+qLbtRActU0obhJmucOb57MBLfOx
X-Gm-Gg: AYBFou3IPo7wK3khEd/XPLn9BQF2et8MN3mr14338iEWSk7LQGEKeLr1SiPJb+XcUb8
	3q1aRl2zONHos9li9I8swH3kwcyesSbTfblnoYQ19gkyk9SdcWnWi5pS2OOlFk7yPwUcINGNGnt
	+LdmzHCFOOKywmBKTQuB+sCzICb2o3xz7pXLUqt+aalbxHcJAYEWdRhHwf1Ye1RWOhUr80kplF0
	7cZMaS+reNozRGjQwpGavmsnkM84S91ZS8LFX3a0E6gG33Qmigo8IxxxvuiI6+oQkjfmbz+199F
	4r5DywIGJT8Xp2HwyPUx9IVo3O+LT2httAPjnLJCuKotqNT3OFVFP8/x2wJW0BQ86+cOFUw1Lpj
	ZAHvIex9WO8j4CQJGWeatP/8FcwzFhNmLLumGkVQk9eVLY/QKivZwRWxclLhpnfqH8IKMiizLXY
	Dwbawekj6r+Xql2WTvXK27iXAQWAgvlPR+rTUDmZcQz4A3py3/fDp4AtOenR3EViMCEPRl8U/1d
	c0MZI83Fn7KACy5f22yjByf6A6RytEAq2AHwHYL5kP6XQmKlC+ApcNBGRqinTsvkVYU3Xdi3h19
	TojZzpT4/cDSg42OFhY0M9ZAgJ+C1CeJITgt7lVUYmqC7+yS5bGEz6DNdC2Ond1UzGzBPbs2Ou3
	1ej7ENi8wQyIkqT+3/cKs51wyB5keLLwtqiTv4ng5mpkbFg==
X-Received: by 2002:a05:7022:3f0a:b0:151:6e80:ba7e with SMTP id a92af1059eb24-1ac56c9ff26mr17469296c88.4.1793645485933;
        Mon, 02 Nov 2026 10:51:25 -0800 (PST)
Received: from l ([2603:8002:ea00:6800:4808:7aa2:ac97:30e9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm34625198c88.20.2026.11.02.10.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:51:25 -0800 (PST)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: Michal Kubecek <mkubecek@suse.cz>,
	netdev@vger.kernel.org
Cc: Dave Seddon <dave.seddon.ca@gmail.com>,
	Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH ethtool v2 2/2] netlink: cable_test: require a value for the TDR parameters
Date: Mon,  2 Nov 2026 10:51:21 -0800
Message-ID: <20261102185122.1357927-3-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102185122.1357927-1-dave.seddon.ca@gmail.com>
References: <20261102185122.1357927-1-dave.seddon.ca@gmail.com>
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

first, last, step and pair (--cable-test-tdr) take a value, but their
parser entries leave min_argc at 0. Given as the last word on the
line, the value handler reads the NULL that ends argv and the error
message prints it:

  # ethtool --cable-test-tdr eth0 first 1 last
  ethtool (--cable-test-tdr): invalid value '(null)' for parameter 'last'

Set min_argc to 1, as every other value-taking parameter does, so the
parser reports the missing value itself:

  # ethtool --cable-test-tdr eth0 first 1 last
  ethtool (--cable-test-tdr): no value for parameter 'last'

Only the message changes: the exit status was already 1 and no request
was sent.

Fixes: 9561db9b76f4 ("Add cable test TDR support")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
---
 netlink/cable_test.c | 4 ++++
 1 file changed, 4 insertions(+)

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
-- 
2.56.0

