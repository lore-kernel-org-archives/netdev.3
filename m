Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E795A3E3DB8
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759312; cv=none; b=OFd94H2M7Vj0Ojq5C8wJVeLqbpykNIxb4K82D8hEB6KXuZc0opbvNcXRBkCnZtw6MWns6BOUSTkZsa8jLgrjo19zXgVTgDEZEMcnVoEvjDPL2olk/+OlM9kzoz/foBCQUdcmcRtKd2W+gtytClESMhJP1+zehyPMT9PAP676XMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759312; c=relaxed/simple;
	bh=ENYO+xjFXlRfG3SuQmPDUAMD4xsJ9FpZfOzAGtfXXE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGbNhWMbqy5cHPcBwvoiiVSwK8CF7WZewot/rxykX8R8EyLc2C05DTsMekZ38MurvTJ8XUEFGB899run3VpuweFiCcJPI1J6qk1jrIm3ovNQqSKEIZpJc6P8BxRQwq2no09xNlDN+NQIrhadzalcMukTzZpZDGvouVwyYpw8lME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oyXYI+79; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyXYI+79"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1ab18b3e6so323618a12.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790759310; x=1791364110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/kjt4TmE3iVheGWNersMjTlVeAVs2bD3M3unGAHuM0I=;
        b=oyXYI+79o7NO0370fnCkUak67jZ9fXXrxSFt1YzHrlTXAI6kQuTZAtbDJY0+Wz5Bhd
         ZT+gPI/SicVtvrJ4UcLZxZfmsH38rtupgDWaM3Z3Jfqcr/+RGVxXAO9k3Sy6I6il0E1c
         y746R9o6TvYf0qTokPa1MucXoePbWrHjH9xtn53XU5cpUX3yiNIA/EhlbmJtlPN2XDaZ
         t+xY8PK65G6e158mj8aSTnc41/yCb1ywEklNRGy0gG3cAgNDxHzji7C/LxsBZ5qK1UFh
         r4lia5aHI744hU9nC2X+dqx9o81knxiIwQ0ET3/WEWphDCADXHUfmMKNAXhUTZCIKE1t
         Timg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790759310; x=1791364110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/kjt4TmE3iVheGWNersMjTlVeAVs2bD3M3unGAHuM0I=;
        b=BzEULzqapEr/CXa6i7BEu6zO2M/uYJlpiYtIfCFDqzzCKXpfRd16K7UUFQUAE660pZ
         lLUO3opgx5AqKJJmik+UDJBtcOPBeOendAmz/Ow+5/NVYzBlf28TZOQ7dGtAf6pkGDRU
         +V8cVzj1WrIlkNyTAGIXJUZJMb/xc/CB/2XKZdQtjdjoTUMsvlzdHpXMuqbU1k8hiuP+
         JMN6+4v1i2et4JOvWYLje8fUyDFGv74aBf0+asD8JPAd/H7YgH/Cw2WQxCG1unizpTQg
         614e1WsrsWxcWtSgfALVE+A19MzO7RJxoE5f5Jm7qim+7EvK4OmFC5fsxP1L6go5H3bw
         QGOQ==
X-Gm-Message-State: AFq9FYIPqAd85fAWxRMDZo4e3OEKvcHxwmw2hSizHBvyDLZ2YyJeWAv3
	SrdUvYKlP8CKSdQ29MHsqJgIE+ptEACyM/yuoSr+wVR/U/oQU+gaZW5TPvPc4Ru36lI=
X-Gm-Gg: AYBFou2gnA2BUxSoYXWHZdclWdZKlB3lO70lxgGnodpIy0RlVY0N0oyIK5tD3TqHL4H
	KVA0ypf7vUMckENtiCZ9A4OEZ0k6BkIStroDykRCxD9J0p4uKlfdLhrno1akm9qDV0yr0wgTAtC
	sOtPAr01EavbmkypY2YQb4hJ6mxn7qLC4t4K1TMyqgLPmQT7N2pujJcw0BsbFkhwsptSlRub0cv
	eypG4/dDrWXB2Zml9ASd9vsC/EWxfu7dZwhOS2nLYlY0LEb+jRMDJo7tkRM3JgrBS680pWOJaD9
	/CVzS6Pe5nQ39vOFKqbrQ0zjdoriU6m1W2wyBeHKo62NHTOtWdCeSN5Q8LnXIOCYPBJLFb4PPFf
	4JD8v9GejjdwPMNMWSWmMNVRNSiazzatwetqFbQUkYI3kj329KEBT2s76hfb4xIOHX4MF7c52wr
	P+ioO6iVldehW3/K358O4vvh9a9kIiDvCesAuOpytxMkSLtfZzYaQftEWiuCRLSGH4qy65i5hJk
	BylrC7DBur5IHmlBqkuYfISzTaTs+6pws2nOJBYGY7ww/A3D/o7sjob7QWjDg==
X-Received: by 2002:a17:90a:da8b:b0:3a4:9fcd:6189 with SMTP id 98e67ed59e1d1-3a4d11c7652mr1188749a91.2.1790759310046;
        Wed, 30 Sep 2026 02:08:30 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cac328c6sm2578059a91.12.2026.09.30.02.08.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 02:08:28 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Subject: [PATCH net 1/2] vti: fix tunnel device use-after-free across async crypto resumption
Date: Wed, 30 Sep 2026 17:08:11 +0800
Message-ID: <20260930090813.73901-2-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930090813.73901-1-q.h.hack.winter@gmail.com>
References: <20260930090813.73901-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vti_input() caches the tunnel pointer in the skb control buffer
without taking a device reference.  With async crypto, vti_rcv_cb()
runs from the crypto completion, after a possible device teardown, and
dereferences the freed tunnel device.  The rcu_read_lock() around the
callback cannot protect it, as the pointer was cached before the
deletion grace period.

Take a device reference while the pointer is cached and drop it in
vti_rcv_cb() after the last use.  An RTM_DELLINK on a VTI device with
pending async crypto now waits for the completion.

Fixes: df3893c176e9 ("vti: Update the ipv4 side to use it's own receive hook.")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/ipv4/ip_vti.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 3b80929994a0..9f44666139f8 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -63,6 +63,8 @@ static int vti_input(struct sk_buff *skb, int nexthdr, __be32 spi,
 
 		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = tunnel;
 
+		dev_hold(tunnel->dev);
+
 		if (update_skb_dev)
 			skb->dev = tunnel->dev;
 
@@ -109,10 +111,14 @@ static int vti_rcv_cb(struct sk_buff *skb, int err)
 
 	dev = tunnel->dev;
 
+	/* Drop the reference taken in vti_input().  -EINVAL/-EPERM make
+	 * xfrm_input() re-invoke us with err = -1 and drop it then.
+	 */
 	if (err) {
 		DEV_STATS_INC(dev, rx_errors);
 		DEV_STATS_INC(dev, rx_dropped);
 
+		dev_put(dev);
 		return 0;
 	}
 
@@ -141,6 +147,7 @@ static int vti_rcv_cb(struct sk_buff *skb, int err)
 	skb_scrub_packet(skb, !net_eq(tunnel->net, dev_net(skb->dev)));
 	skb->dev = dev;
 	dev_sw_netstats_rx_add(dev, skb->len);
+	dev_put(dev);
 
 	return 0;
 }
-- 
2.54.0 (Apple Git-157)

