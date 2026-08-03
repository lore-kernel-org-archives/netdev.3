Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3074D2C21E6
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 02:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785725254; cv=none; b=LRWDE2z/73Lk/rWw0CcdAeQNx07cJwaLOACEq42iqLYhk1RuLO3fAjOJm7lfW/9JWP6a13DCz4N036AgW0S8wz7o9lFbLUV2Zp1hXtmwmKW/iCbRTSpQ8H3QTD0IqcuiC1IbwxPEZgHWSWGJ7/GjHX6cxQjBnOxpl9MDWOynwVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785725254; c=relaxed/simple;
	bh=3XdvKgSyqkaQZvwiXr+QcNzqxOOPME0iYWuu0z44QBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZ2k6A3NdxC7PRjio7/Lt4hJP+q4iiZvE5aD2QXhKozLKiOU0uGzEu0D/c5eXH5thlBthQrnaIO810gnx8u3w4UbYAjCeylbhJXD23fDIYGjfG+/Veg6ZiWOrM9GeNG0+prUB6cc4kkqJf/IVq9lZIbe9/SSew8eM4Xkn4nqh4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=b/iYjVrS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="b/iYjVrS"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cfff5f88dbso32018325ad.3
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 19:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785725252; x=1786330052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2LhsYoE2aoDY26ySe/Zrhjmgh4wBG/9x4kdWBWPLDhE=;
        b=b/iYjVrSZfjMxh0Yim6ERsF7vvm95LPQB/T1h+PL7BsevQXtR3rTt1a7lP1mIEWmxy
         lcu/FAwcR8SjJMVfqWREt/M4b96q5cEmku9yoQQUwJWcE1CYeoemOyucae7LKCyLYher
         /umjHNGIyjEF8x9oehLEkD/14+7KBgy7X/TYKA5SZmkIh+oGgJ8uCD11Bomv3jhhSRPY
         QLUeZ+7pCLtYUaANI5bFmnZUK+6PB7Uuf+qDOScnBNVXaenP2fG7EP2+S4tJwxuXaUHQ
         4cJVGaG+PADcCmSLwfoQRE8T88brU4TjP0ylu7b9tv77vgCIEwbgC6E2I2HfNpFAvFE/
         7uvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785725252; x=1786330052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2LhsYoE2aoDY26ySe/Zrhjmgh4wBG/9x4kdWBWPLDhE=;
        b=RW8ONNTN03+N7ZmSAKK1yW/QOk+2t4/iv0p6zTXdgZyETCoOQC+NtmsA741kuoA26h
         gHStBRzSYWiUjvBkdXP91JWWgbPv/Ud1X6Y+X2+9mrLGsNg/gkyqhyBXY1rTtS23SwTp
         20fRPiiJmXYt5Z+HJclnNjFudwTyrUm9I2Fmh/ce2fQTS28fI9g3xLzZ0aMeuX7RHqVS
         X6+EUH1nDl0hEYb5gJhegus+6by+9aAH7aSyLGNFofDQ27BPt8STB9+tlQZbxNElOqDI
         eB0nm4xU4JWeWZRFJirezkYZ5tlZAp903GmyhvYqGxQFw1lBrDQADDENZGTlGQubvt+I
         0s/A==
X-Gm-Message-State: AOJu0YygpHcDK8LHO+upDXL8DUuE/FxRPbvURqDSUVISPTCmdHQcO2km
	L34q/e3s84wsYR7wyf/W7XdT0og2wyCqX+2YUxVuIK5tkM8UFSpgmCnp3YxaKAlTLXOqAuw/Vhz
	LnITXdJ1jFFkGvQ==
X-Gm-Gg: AR+sD11c1alcA3QRXwdqDiJnTFMIOzlBpoTz/xOVKlCu0Mvxjqm/fd96Xc4dMAyxL/z
	HygGJ7laQ8QrAHmZQTvajgslc0hEtH4EDyY60E58NF7+hi5GzjDjve6z5P12c9SOmWjt8tw4/+d
	l9P/PTQc8MhCJ1AcoZAPETcqwX+piVbEFXLZgnn77bpJ/anojICzP6qasItMPQyWRLTGjL+L9xu
	IrwkVmeHedadAgErZNw3ubdNWizxNtRViMAZqFmbGBoeT8yC1puD+gk45SEEFLnnOeAs5MC86VU
	ARCVfPRlfe56CBK4UKS07+3g5me/tbjNn9xzOyz7uX2W+9HzaQCueE2uw6duLltm7ICOQdHs+49
	9MBXqtNVP/oUTMFONY9aTPJrKlVsb3UcTZA3/5K0vCWzWBBRm692ymKc2bl1qR5f6WvI8IgcbUd
	oyy8xWr70KnpbySuBE2zFrzuwZN65JTtmmYWivNHazf+EtdnujuUyMgMdSndOGeJRYWd7vG/HZi
	w==
X-Received: by 2002:a17:903:2f4d:b0:2c9:97a8:8c19 with SMTP id d9443c01a7336-2d052474babmr83366195ad.44.1785725252408;
        Sun, 02 Aug 2026 19:47:32 -0700 (PDT)
Received: from Roxy.localdomain ([202.8.9.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0eb5a3sm30896585ad.46.2026.08.02.19.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 19:47:31 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	kafai@fb.com,
	joe@wand.net.nz,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] ipv6: orphan prefetched skb before ip6_mr_input
Date: Mon,  3 Aug 2026 10:47:10 +0800
Message-ID: <02db4590d0161e31a789dcdfa8d1be1a3212ec2e.1785724784.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785724784.git.zhilinz@nebusec.ai>
References: <cover.1785724784.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip6_rcv_core() keeps skb->sk alive when it was installed by early
demux with sock_pfree so later receive-side code can use the prefetched
socket under RCU. ip6_mc_input() breaks that assumption in the
deliver == false path by handing the original skb to ip6_mr_input(),
which can queue or forward it after the receive-side RCU section ends.

A UDPv6 early-demuxed multicast packet that is not locally deliverable
but still enters multicast forwarding can therefore carry a dangling
socket pointer into unresolved mroute cleanup and later hit
sock_pfree() after the matched socket has already been destroyed.

Orphan the original skb before giving it to ip6_mr_input() when there
is no local delivery. The deliver == true path already uses
skb_clone(), which clears skb->sk and the destructor state.

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/ipv6/ip6_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 8972863c93ee5..d332ec60f9150 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -622,6 +622,7 @@ int ip6_mc_input(struct sk_buff *skb)
 		if (deliver) {
 			skb2 = skb_clone(skb, GFP_ATOMIC);
 		} else {
+			skb_orphan(skb);
 			skb2 = skb;
 			skb = NULL;
 		}
-- 
2.43.0

