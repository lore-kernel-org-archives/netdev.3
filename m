Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A098442FB3
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784228687; cv=none; b=KCeHAAkYK69AwT1dtLLPMPlNh+emKfOemQwnK6onLENOAyOF5CONRgyU1Ex7p6gMuGmtvRC7mvOLe9reJI3J/Ayv0x3uZph7TIUUsGRwZ8UItkdf7Cvm7QFYy4Dvhlkn3N82GWl7kB6Pcw9Vimls3G/gFIQGSbScTjOujsgKwtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784228687; c=relaxed/simple;
	bh=uwYEAAseGuiIqJKLvH0j4d0K5nxF8ikHm9QDZEG7tls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wf0Psi4YRRlBNg8xrgjqpTRPLBFkUbGy9sfTdjyGpqU7mAS1hw18GitaE0039FefDu0xw0W9tmqkK+1RLylmqO9ydmGcNQtbGBYSetqJ36ZpIxnVhRZ8cWH5SdcBUd7Ze35c74Vypbxpu/fNcy8nwTWti8esvuVDBQ0YS3E1v0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LT9FfxYb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT9FfxYb"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cae1a3a744so53496695ad.3
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784228685; x=1784833485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YtAAp1v2R1o5+64p5FOI9tTm+W9MNlFWebATHzuqp8E=;
        b=LT9FfxYbqvcXvyLrT3m0wi7RAdPsHoEIvDP3ISELJf1AyKZ9zIr1B1RjLjfoNetRgX
         mUI+KZDWlBvRq8TE/Kj2WAd+RL5rpR51UyO2nPrbzSBcCQQxNWnKIQZjjASi4c/zgEap
         r1YDBvDhv+nFPVrBtvQ2F8GWN2ilnc3xKKJMSmCcwvj465eVm10AqpiBR4pB8dIPvEDh
         /b2rIp4YaB1PBPDZKd5LC3HVo1iYJPcDPy/DvfnArmLOwGMXuZI0qhEw3p/Lxb9lS5/L
         D8pRJIYY4KyD72W7sPzCtTUg69Wz813VsuEW5yz1Da066V3Os+L0hHXkeDyMinR8jPPt
         IBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784228685; x=1784833485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YtAAp1v2R1o5+64p5FOI9tTm+W9MNlFWebATHzuqp8E=;
        b=e07+9eoIg7IUO4akdKIj0T0JcBNDNhoP7MIy9FfhtSXw9zPtoXDzFzuhZkw862QstE
         YgVmKB4GFs3FU+o3yDDDS7CxaMZRTTnjDay9vN8CsDG48uaoXVmTGTVlmc6rTSy3loiu
         S0D1grsQQukWvrg+Q168s9E0ynfvwxsMVtx9mUOfuvBZHA8QUTNxOIEXyHSQwsgnx8hp
         8BOwO5qnfOfoVohakqWZfxydj0dvqcQ/6PFCeiMcMT58EqaZR7PuJLGSghMrEPR0nZ2l
         ojDgTeR3xc6XEBzPNvQk9PEOZGJ8SIjqDh47RKVc1Fl/k6Nw9VXVltcA9HqfKrATieVg
         8J3A==
X-Forwarded-Encrypted: i=1; AHgh+Rqjx3c/NZ3Lc6G+9DovrlFA1PAg493i22nGB4DgQ8+VneU6eCxKkXbvX66PyctVBdble8hLYbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWSPOpmz50Ajlq1xd9iUI+8/TufN7TmCdx95PLphsFyZCxVPAu
	DMcmH6UTU8DBdxLPqdTSs7Qr7Rd9pv/i6gWGVeuwW6+xHC9hIz+yOkt1
X-Gm-Gg: AfdE7ckv75LBbwY2srADAjFGfH/BIhe1nH9xB5MQEcMrn533jybOn4NKEUoerRraaIH
	UlKVMrGo9I/1FADow8XogP55eVDEnCOjdR6tseIbZEtjvLhZMfVcPVswwwQcBsvSP7obN7u65Wv
	OoNaPHB9VY8/lcFZUyy9TvZSumObCEFELxO3ppSGMjhRL2luT3Wd49RCJM8juYePCdpayuU3a0Y
	d9x1yK651ODNxYvtS4N2kjsMzw3luj+EhtNcw5h7o1oJaw+dB2c98r10+GX0WvMv6V+jZ0h6rRF
	TQXDVoc+bh69cph5w5a+eMlACNxUZngq3lbOW448S5/eyDVue0cJ/mz5dmTsmcQplb/jfaTSTPw
	Tlxe0htHMeujjU1HN/JyveILmuMPGSAypGYDLM/lGZ61mUKHHTz94F3L+cyzdSxb+cc8Kyah9Px
	bO9xEu7BLa6cfpUglYFCFpUO5lUWVo6h88ZHDLkjaPXkTy4H8=
X-Received: by 2002:a05:6300:68cf:20b0:3c3:719d:dfe2 with SMTP id adf61e73a8af0-3c3719de4ffmr5648534637.36.1784228685396;
        Thu, 16 Jul 2026 12:04:45 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4341a37sm11580151c88.12.2026.07.16.12.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 12:04:44 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Hoang Huu Le <hoang.h.le@dektech.com.au>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v4 1/2] tipc: guard against empty list in tipc_node_xmit()
Date: Thu, 16 Jul 2026 12:02:04 -0700
Message-ID: <20260716190204.100895-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716190204.100895-2-bestswngs@gmail.com>
References: <20260716190204.100895-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tipc_node_xmit() passes @list to tipc_lxc_xmit(), which dereferences
buf_msg(skb_peek(list)) without checking, so an empty list causes a NULL
pointer dereference. named_distribute() can hand it an empty list when a
bulk allocation fails. tipc_link_xmit() was already guarded in commit
b77413446408 ("tipc: fix NULL deref in tipc_link_xmit()"); guard
tipc_node_xmit() itself so the tipc_lxc_xmit() path is covered too.

Fixes: f73b12812a3d ("tipc: improve throughput between nodes in netns")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/tipc/node.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 97aa970a0d83..fc241e7b0c1f 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1695,6 +1695,9 @@ int tipc_node_xmit(struct net *net, struct sk_buff_head *list,
 	int bearer_id;
 	int rc;
 
+	if (skb_queue_empty(list))
+		return 0;
+
 	if (in_own_node(net, dnode)) {
 		tipc_loopback_trace(net, list);
 		spin_lock_init(&list->lock);
-- 
2.43.0

