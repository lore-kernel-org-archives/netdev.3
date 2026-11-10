Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321807;
	b=rrmtP9oDnHSaD8YBUW3IfcRAvwDk5xwHD/mRPgOcgSuQyMIJV+c3a/dNMyEFfr+yw9ya
	 x3J75BBRo2lo3PW4b7QL14nOx24UT/R70grPoDyIRJJ1BZ3mKWMFqL5ronH9OWZFHZFGr
	 l8ydswoztz99+5nWEzuk0JH4XSjeVi/xK+7XpcYllayfBO6BsTWf4xxCRjINLfGzGtdf1
	 yuvsgcKuyhIgXldGOAadOf0rRqiMWwTGy5qdvjl7iQ9mHgpezNazVWc0ttwSDU2g66ZB5
	 GGI92P3+IEVgNWpfYAVzEsuyUXk8IE9HqYD2FdHc8jMkaiGnlKEMxS6u6Q20f2M8d/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mM3pdVJ3VXYsnpMOnpdPV3PZO6IU7YAVH5Ue5cX7ARE=;
	b=BRBpxJ+KvTL3HpE0VDXYNoM91qsb3nWTD5CSX27gZwMS0y/nALhmLkdRe5guyl5M0pCr
	 jHtO7C+VkH+qlgPz88MaiWu61BYaF3kLKfi92DEBLBBCnlfvkIZYiPnYszJawL7agiDoY
	 BnqOOjB8DdOCkvMAoVM52+fLg/o4I5z0bF+9NgfFKUxK2MrYfh7znaTO6tczprIc3ep0g
	 MDuku5nKGRZkB+1Q/KsiEuRBqobcTMhY7WgMdjaedj6FpQh1q3pJRjyTZy8PGLvlYHxB4
	 8czCUl1dRBGC+JEinJzJlrZveH2lsXoCN7sYOONx2RT5QEPE18W6EsnEIyyOSQzHNFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B0FXeJct;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F1060A2613
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69F1060A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B0FXeJct
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b5c3288e6cso894176b3a.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794321807; x=1794926607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mM3pdVJ3VXYsnpMOnpdPV3PZO6IU7YAVH5Ue5cX7ARE=;
        b=B0FXeJctmgOti0Zd6hNIfAW2U7FZxgcc6Np414mIz7g9aahzBQs0mnf1vyWKe5qbzJ
         aDXvPu/GbvkeEZxTSBILCRKbcMGz40jHvdqi1mhY+lPDFgyFw30X61JpfJGsn3mh8/TR
         HdgDtr8W0qTAPeJP45kZB1zeAXbuU6HHsRd1BNHzyo10MGhG3hi4XXndPwVV5X6dGk2w
         isisbx3J4gPtyy61p3udwG/UVXL6FB2OzHv7uck23mMevkJfNd4IE567KRWZBme33b1l
         Gl94qRAhoHihoOfcrfDFwwypN3hvmfjdp0e2hByJ9Zrn6LiuEeJuAOHXraIKWr1MpDPD
         AS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794321807; x=1794926607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mM3pdVJ3VXYsnpMOnpdPV3PZO6IU7YAVH5Ue5cX7ARE=;
        b=hUg537jQd44+pDYtVg5jvG+NtbY9hbof6+ccOy2AzPmYcUiYsLGMIpiebCxmU0tgMs
         Z019mu4vXsBY+85+W7ggECwUSs1CaMoep1AfOpmz79gCa+DoiSPygUk4AaoTqu36mady
         w1gdwbRqW6yzOSA+3f8+BuutRaBJnuWkPVcjbyzG6j1SD+Sz8e2d2eUI8CupFCZV9cmV
         vAQsrAxsSOoGmN++wohcC8Eg2rthk2edBI256znp5iUdA15fy4WBGEKSurWxhGYpZyyD
         fHg1+sT3aKCh7LXaM0EJM9u/AhCZkXwntGdJbOl+36Orbuz8W0p38BaU+ofR/qI5d//F
         dFdg==
X-Forwarded-Encrypted: i=1; AL+hErF+58Mfu7qyMtu4MEamb3se8s+8hl8KSIlrdUD6+dnYjFtrr4Gh+vLm8XUuYvel2780ObwWn9w=@vger.kernel.org
X-Gm-Message-State: APuU4Z851a50HtS2OPltM+kn7ffOtu3Q0REQSi4AbFGi7/JMA//UCFNy
	7WT14VQKK4jq1wzL2FV4cjvWzPxsVVKH68NWGhIFPL9kIptR7ut9ZS25
X-Gm-Gg: AYBFou2nP6k6QGqh4cXfxS/0oHmqs4WXvrOMdwCxN+GKo4QizUgtS52ak19FJNi73Dk
	JwlMcBb5K4/g2in55dMUkRQUuSdpzWnL+VS+hErYvFoKfxM5L+WLCpu/gXvOljh1fxjhxpfNq6H
	dXXGOfMVUUHxqXYsope1S2SI4v+08I3XIIBXRbIHsKTgvcvFBAuLhPB7slJoDXMjLhJ9VZJMtXp
	H/9gq4R2BJC3/RRFslbl12US+8b08ALoal8xdLbheuRK1aMjol/TieKCfzYcmE6IMHMY2hqWqC3
	m90eLzbVqSOLkcpxTvL3KeSYRPpWil6H111iuRIMAwt9CFGfCeHOOKUnG1+g1ehduvM4QnYlHs9
	iourufpTR+wTOrl2HhbnXimbZ5NIkf8/tV3Q2quobHb5IIP4HNzLbyrd46eJ4Z2DFuvjZQa5BEr
	KlYYqDOF5Xr75tHFuumA93bbAzae6xdIxc66911CiWBwNPZkqhci+XGbD+dxvNyBgyBS5fzTfpx
	Pb/4EqmyFUeaE++enQBl0TWDbsuUAQO5itr7ZRyKjX7otZGqoV3mmA+4iusi+FRm/kYtQrO3DrS
	NhW+dWiz5Y+t5tziBRnlq4j3DLB64qeL1BjsQ0Qh959Y4A==
X-Received: by 2002:a05:6a00:3902:b0:8a0:5de3:a170 with SMTP id d2e1a72fcca58-8ba87929c4bmr3000140b3a.45.1794321806473;
        Tue, 10 Nov 2026 06:43:26 -0800 (PST)
Received: from asahi.tail4da9e3.ts.net ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de232csm1018049b3a.2.2026.11.10.06.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:43:24 -0800 (PST)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eyal Birger <eyal.birger@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH net] xfrm: reschedule NAT keepalive work for new states
Date: Tue, 10 Nov 2026 23:43:21 +0900
Message-ID: <20261110144321.94096-1-pocj8ur4in@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The per-net NAT keepalive work can already be pending for a state with a
long interval when a new state with a shorter interval is added.
schedule_delayed_work(..., 0) does not move the pending deadline, so the
new state's keepalive waits for the older state's deadline.

Use mod_delayed_work() for a newly added state to run the worker
immediately and recalculate the next deadline. Keep the existing
schedule_delayed_work() behavior when a state is deleted. States without
a keepalive interval still return early.

Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
---
An arm64 QEMU/KVM test of the immediate-reschedule change showed that a
new 2-second SA sent a keepalive immediately while the original kernel
sent none for five seconds. With a virtual NAT gateway, the original
mapping expired and a 9-second inbound UDP packet was lost; the changed
kernel retained the mapping and received it. A boot test of the final
patch confirmed an immediate keepalive for the new SA and no immediate
workqueue event or later keepalive for the deleted SA. An arm64 W=1
object build passed. No physical NAT device or ESP payload was tested.

 net/xfrm/xfrm_nat_keepalive.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
index 8ed30e6c263b66..6814f9063969ef 100644
--- a/net/xfrm/xfrm_nat_keepalive.c
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -288,7 +288,10 @@ void xfrm_nat_keepalive_state_updated(struct xfrm_state *x)
 		return;
 
 	net = xs_net(x);
-	schedule_delayed_work(&net->xfrm.nat_keepalive_work, 0);
+	if (x->km.state == XFRM_STATE_DEAD)
+		schedule_delayed_work(&net->xfrm.nat_keepalive_work, 0);
+	else
+		mod_delayed_work(system_wq, &net->xfrm.nat_keepalive_work, 0);
 }
 
 int __net_init xfrm_nat_keepalive_net_init(struct net *net)
