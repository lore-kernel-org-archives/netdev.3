Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618910;
	b=G+p8FjNS7NUmt9ZhZ3ZAU8Q8RZp8Z9m6yXkPUMSqG9+nCKW5IBdhxkLKb0hP9rpEzKEd
	 Lwg8PSIVgwv6gTdGY7sLeq0rMVRmdwEBuQgm92qQg57iqV1azOA5TsTlCjS+zCDZRtH2m
	 U/K7qHKV0vYEYCxudqOerP+tMkLo7uIW5rZGounPcjqH3R957B8qXeJzSrKsv9DfJQnrV
	 Fxqcf047K57RB9NfFbGKMu9tFkPPKe+ECaNMJdQDPytarXxgRxAFX59jVH8FAvoQZ5UBI
	 H7FiDZd26QiIi0u/c0q/Yqol8PcQSR8zDC3x+/pgB31Z3Gjw/bWn53g64CJQFXqcNUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618910;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YcJKx5QjhCq2F4Lf8K68pRsrfOT/9E6/xL2RKmyc43U=;
	b=TSVVh+1pzQGzXqFZCrJDQywitkLYbVeMme9Bmz0s5tEgppC7/3/VOG7FgJ5XIcGpKvUV
	 mt3R77EtYceXatN31YIeG8UYlyN7RHfYiWp+TLUXPKdVXDY6qgY5yDoOZeD3F4dK+RpVY
	 6+ewyMZX81jN2sCkdHIbNgnu9k2XkMZWv0s4+RMnSvWH/qP0jswBcdNsgyiHgLfPjof+g
	 DmzHgeWH9tVQw1EQhJNfuVOiyKwkDPlgpXeTOJkrrHFAlrNoAKorkBeAmcqWZPab5Osfk
	 NhG1fixYHk0d3Pl+63Z2fg3Ep6/1Dx9Wc4wUQec5TnvvfChMWXW5d8XEczsF42GJ4ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=KEJYyOrk;
	arc=none smtp.remote-ip=162.62.57.87
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B4760A2615
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 11:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57B4760A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=KEJYyOrk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793618899; bh=YcJKx5QjhCq2F4Lf8K68pRsrfOT/9E6/xL2RKmyc43U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KEJYyOrkA4wD9gwLm0/5AhCcwOp7/cPCp7638Fj7quM3BKtTgnv1HchFYi9hYDQvl
	 11fvKcubnutNUCdMH5ZIsH+Lt6pqcTw/8xXqGih+Hx/DcgGkqJ9iLKpeN6QZCMLDfV
	 uhQ+GSZ4boMH14yKa2z00Jg5CLBXxLf/GIgMrbuI=
Received: from CRASHEDROM.localdomain ([117.147.101.47])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 70D9DAA4; Mon, 02 Nov 2026 19:28:13 +0800
X-QQ-mid: xmsmtpt1793618895txlydwajs
Message-ID: <tencent_B29BE3462A7EF2A8561B6A7C05E857FDBE05@qq.com>
X-QQ-XMAILINFO: OQac6g2KrvnWgOXK9UfU6VB4SARp0k0jNXUK9OCSI+UQ/QHk6NJqgiDAU1V7f/
	 kUp5owkRkQiAbIILCFe2cUadYmSGB5DAEFRgdthkZcGvbyr6qaJjUddG+o12mx/QfIGaMBardbTh
	 WUyYnNgsBFf9/vJE/MrZCxTu+rjJ/Y1qt7A0Qgf5ZBCg7kgZ1t7vFK64zVCi6mFL2lOmMoCJiDyv
	 X7gw0zGkB+DQIsUi1G9sGHUIXtMj9QN53qEYRu7OvOFMZyNNYsKf8uAuGZElqO9W9iKxWgibBAmn
	 bzYDC+gWJvEDUOU+6cRjpI6BxUmryn5EyNZ6wthGm+JQoesQtOs390jtM8o7J3ZSh7VKXaYYfIWZ
	 66QNTShOTk0ybJXGawshUxPoCrZzzFkp0reFqQXT7is8UdG4ZBzXZ+thBB5aHV6gfN1v+33ioOIP
	 6N+N3pj3E4JCsQPCegcsa1U5imreNQlWYpqOsH95mGilPYOMyYqqGenl1Eo7dR2EA0SMarax3txE
	 7ydPgZbQ7ObahI0BhzmA5RIdMD2CY6cx60jXQ6wg0nqbuR/C0AVUmIAqEUnLE5kjG+HntxEAd/MX
	 NNKEUb5H/83RAalUug1Jmw27AH0GR0Qf2+IYgUK0h94H2qmXE/ni9pJql5GkD0o/wpZqNNE5I1KP
	 mVg1MS5xi4AIlo8wvB1UAjyjfpZSMK5I4Hr2bvM1+r5vzkYIJecpyKQAx77ji8tIRLdXKg9KwElU
	 PDEFTbPbKk9DYIZOl0hDtx4oM9VSxcz7mfR80E+f9FTUW7mwmS3LAe6HLd3hXasoVYjlQKgiIwBO
	 BYI9rgMp3urfCmxIPWLFa680ruiX30+BIzLLG6gyWRvj8R8ArwUanoUav/V867F5UfZEEKPg2p0A
	 FBGLFLX8lXLqMzJ6wYPIBMmD9ui1yNdmst1aCYtzTAmKlzDPI2C066GT2Sb1Llt2iXADwwu0YV5w
	 ZC1CZiaspKW01G0m79WlwgYbBr0Y7bLvXHSGXVB4pXIXR3TyYiUdHJgUZEaQ7UTfPUeJxyIeDgAY
	 h1GDRep5PNBCbvqC5bJORSW1HKHNsahAgPDrKgCgaBEqlvlUfv2OSTxd14rtqOjpuwW3EgnA==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Chengyu Liu <19290937@qq.com>
To: netdev@vger.kernel.org
Cc: khc@pm.waw.pl,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	Chengyu Liu <19290937@qq.com>
Subject: [PATCH net-next v2 1/2] hdlc_cisco: shut down the keepalive timer on ->detach
Date: Mon,  2 Nov 2026 19:28:06 +0800
X-OQ-MSGID: <20261102112807.1395951-2-19290937@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261102112807.1395951-1-19290937@qq.com>
References: <20261102112807.1395951-1-19290937@qq.com>
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

cisco_start() arms st->timer unconditionally and cisco_timer() re-arms
itself on every fire.  The only deletion lives in cisco_stop(), which is
unreachable on the protocol-detach path: detach_hdlc_protocol() calls
only ->detach() (never ->stop()) and then kfree()s hdlc->state.  The
cisco hdlc_proto has no ->detach at all, so unregistering an up cisco
device leaves the keepalive timer armed on top of freed memory; it fires
within one keepalive interval and cisco_timer() writes through the dead
cisco_state (st->lock, st->txseq++, cisco_keepalive_send()).

Add a ->detach callback that shuts the timer down permanently before the
state is freed, mirroring the CVE-2026-63803 ppp fix
(timer_shutdown_sync() in ppp_timer_release()).

Initialize the timer in cisco_ioctl() when the protocol is attached and
drop the timer_setup() from cisco_start(), so the timer is initialized
exactly once at attach time: attach_hdlc_protocol() uses kmalloc() (not
kzalloc), so st->timer is uninitialized garbage until the first
timer_setup() and ->detach() must never run timer_shutdown_sync() on it.

This bug was found by static analysis and confirmed with a KASAN
reproducer: slab-use-after-free write in __run_timer_base() within one
keepalive interval after rmmod of an up cisco HDLC device (allocated by
attach_hdlc_protocol() via cisco_ioctl(), freed by
detach_hdlc_protocol() via unregister_hdlc_device()).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Chengyu Liu <19290937@qq.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2: retarget to net-next and drop Cc: stable per maintainer guidance;
    no code change.  v1: https://lore.kernel.org/netdev/
 drivers/net/wan/hdlc_cisco.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wan/hdlc_cisco.c b/drivers/net/wan/hdlc_cisco.c
index bfc978b15b..2173d5c6d6 100644
--- a/drivers/net/wan/hdlc_cisco.c
+++ b/drivers/net/wan/hdlc_cisco.c
@@ -274,7 +274,6 @@ static void cisco_start(struct net_device *dev)
 	spin_unlock_irqrestore(&st->lock, flags);
 
 	st->dev = dev;
-	timer_setup(&st->timer, cisco_timer, 0);
 	st->timer.expires = jiffies + HZ; /* First poll after 1 s */
 	add_timer(&st->timer);
 }
@@ -293,9 +292,17 @@ static void cisco_stop(struct net_device *dev)
 	spin_unlock_irqrestore(&st->lock, flags);
 }
 
+static void cisco_detach(struct net_device *dev)
+{
+	struct cisco_state *st = state(dev_to_hdlc(dev));
+
+	timer_shutdown_sync(&st->timer);
+}
+
 static struct hdlc_proto proto = {
 	.start		= cisco_start,
 	.stop		= cisco_stop,
+	.detach		= cisco_detach,
 	.type_trans	= cisco_type_trans,
 	.ioctl		= cisco_ioctl,
 	.netif_rx	= cisco_rx,
@@ -353,6 +360,7 @@ static int cisco_ioctl(struct net_device *dev, struct if_settings *ifs)
 
 		memcpy(&state(hdlc)->settings, &new_settings, size);
 		spin_lock_init(&state(hdlc)->lock);
+		timer_setup(&state(hdlc)->timer, cisco_timer, 0);
 		dev->header_ops = &cisco_header_ops;
 		dev->hard_header_len = sizeof(struct hdlc_header);
 		dev->type = ARPHRD_CISCO;
-- 
2.25.1

