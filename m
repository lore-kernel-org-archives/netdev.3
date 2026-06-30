Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4584071E0
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817345; cv=none; b=TLXk08/BeJV0TNaRyAYGmoDn0mDfJKCyHX5wSvehZ0HUOaVIeiM4vMM78LL9Tn3IFxmo0aU5ahtdtRN063+TR4C9o2Xhhiebj5cdGOfzhRmzoGXdaNO+UetRIpbPCrp5F5eC6sPQQxB74qzGl2BPosbkSJA+kMis8SKLWOmOVzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817345; c=relaxed/simple;
	bh=l4DTzAgHPxhvW2gusDgE+0UeVs6H4ewTxAuzQ0FO/jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIuRrRJtp/zV6uzlrbGBUnMjmrtkR/pIl9Z5/vidBLWe0oy1+7rPM0fDA0tdI9ODYkfOFzrl8Z41PU9uKyhyHsKei+X26hnm1UB2hZ+0dMD92bGDeYRuvSEBqQzvLCsvMsutK8i1cKx4Rlwa5J21Jt0alnVW0QhtFRKl+fzZWGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rT48Z0NJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rT48Z0NJ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ca11143dbbso10108735ad.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782817344; x=1783422144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3R/tR4ScCUpju7FMZyh8+yuGH4uE1rv2T5rn90jmRLM=;
        b=rT48Z0NJCpyqbw5HWpb89HcGw7SfX2P2GjtHFe++aRT1XLRfJaTcc/3QvDiMswDNhJ
         73uLAX9qkbcJCOfLx4wCjepoOGOeQo1UKmixSLjORHXSju1j3OzQfMGo7luFxWuLqrNQ
         mYaRdpPr2TIIrolHtLcNn6kc8V5UWWmQvkZroTyr9lQ35Y94x8LpagD5Wzj7sh+hkr8+
         KlLBqp0AG8S9/jQ7YnXIhX5+yEcVttfIYlhVlw0TF6EttJDWavJHbfp6tRAT/JkqAkal
         dZV3hsbDXyh+96mOJI7LRomVp3zcvtTHuQGPtqN2zbS0BrQRKM5RCjGiETKJGqD7RYDX
         8oGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782817344; x=1783422144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3R/tR4ScCUpju7FMZyh8+yuGH4uE1rv2T5rn90jmRLM=;
        b=cRgFsV21FavUHTdLTeRFY7Tl0ttmxNAx9aW3E0ZkpsX7IxoRnXnVlZz0pD6gE62/2i
         KCdo4kH0kf3vzoZUXdzVAJbJnyHxwcd01btJvdsmfmfTcca9fWzkpHrVbbhpvAxxOPdb
         rDcLow5svyvsXHF/5gpuXOCRucIh2j/COz1dh3JWJdJ2GKGpTNiCvWADPL4JRQ01W9hn
         P5REhqsVM9RXUJ0INSlBSSvE5Y9U3nUt/Fp3V/tuNteUhNQhmka47kagh5m3whHhpoU2
         ZnKqRfldmeVlNHk8IQYEX48BUV55YB9R4sU5ty2teLBjCPLCW7c2AQoTvNpJaSDeTzKb
         zcBg==
X-Forwarded-Encrypted: i=1; AHgh+Ro99P/yNJiFT/LEYSdr01z/pjj8r5N07Kv5JL1kklP/0TPEJS0D85uYWB1PHi/WgJ/OYZxptVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydr77eoLQ5yjKrHwVGTt29CG7X4I+ZuUevYOJ3fAg+qmzJ79TL
	cHofZsxWSk0mlbpZmygsSNKqm2W/D9w43zhC06KaDikdyN2b08f8w0dD
X-Gm-Gg: AfdE7cmcnGDD2RL4Jw+SA/MTyZvOcctKBj7oa0RcP/gt7JtJCYMNy1zB7olBxL5p69n
	oHS/TVWqQ8quufVEv1tMeMMYShs5aI1b44xIOtUGcqDmmPyxUB8XUIMXU39PjVcX5I/FMUe28H9
	h5xNGx8MUryzThVKYGP4QLo+texK7neTlFMkewhFQN6kAnrAP2xlnUW76xVLW78//55dcvTtsag
	kwgYM2BzBsAVvdFtCdv9U7vN7Qd5M5WMlhdxAJz/1m5LFezoxieZRJEOwdg08k6cf4/CM8DKsNM
	EHtFwpdgMsbPIhmXV+rU9u572PBGdbGUnBGR7BubwdYgI4GmLNzIGNvjUmxRtR/roBPlowmKM1n
	LxJB0Ja/w4SfyQJPJoYwcCHipHMDewz8pBms/N84+rRXAFINXEy2FW1eszpDuyYM5ddwp4AcEsk
	ccVyqzsZNr/Elkv61eISVipoO4D+BVfA==
X-Received: by 2002:a17:903:46d0:b0:2c9:97a7:b1ec with SMTP id d9443c01a7336-2ca5a623ff8mr129935ad.43.1782817343702;
        Tue, 30 Jun 2026 04:02:23 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:ae0d:35d1:dac9:a0e9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37a701b5sm11455265ad.17.2026.06.30.04.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:02:22 -0700 (PDT)
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/3] net: ipv6: report multicast group user count
Date: Tue, 30 Jun 2026 20:02:06 +0900
Message-ID: <20260630110207.37841-3-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630110207.37841-1-sigefriedhyy@gmail.com>
References: <20260630110207.37841-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous patch added IFA_MC_USERS and emits it for IPv4 multicast
groups. Add the same snapshot attribute to IPv6 RTM_GETMULTICAST
replies and entry-lifecycle notifications, carrying
ifmcaddr6::mca_users.

This makes the multicast rtnetlink ABI symmetric across IPv4 and IPv6
and gives userspace the same user count that /proc/net/igmp6 exposes.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 net/ipv6/addrconf.c | 1 +
 net/ipv6/mcast.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index cbe681de3818..f1fe9ede1edb 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5264,6 +5264,7 @@ int inet6_fill_ifmcaddr(struct sk_buff *skb,
 
 	put_ifaddrmsg(nlh, 128, IFA_F_PERMANENT, scope, ifindex);
 	if (nla_put_in6_addr(skb, IFA_MULTICAST, &ifmca->mca_addr) < 0 ||
+	    nla_put_u32(skb, IFA_MC_USERS, READ_ONCE(ifmca->mca_users)) < 0 ||
 	    put_cacheinfo(skb, ifmca->mca_cstamp, READ_ONCE(ifmca->mca_tstamp),
 			  INFINITY_LIFE_TIME, INFINITY_LIFE_TIME) < 0) {
 		nlmsg_cancel(skb, nlh);
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 04b811b3be97..774f4c72a6fa 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -908,6 +908,7 @@ static void inet6_ifmcaddr_notify(struct net_device *dev,
 
 	skb = nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
 			nla_total_size(sizeof(struct in6_addr)) +
+			nla_total_size(sizeof(u32)) +
 			nla_total_size(sizeof(struct ifa_cacheinfo)),
 			GFP_KERNEL);
 	if (!skb)
-- 
2.43.0

