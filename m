Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344745;
	b=fJGKLWyjb+/aunvQ6eFINQJoPbyAxS76xPlThy9Jo04Jp2ZUoEwhgZOp64hzpmzklP63
	 OR73T5x7lieOZTP5qDoY5UjA9jrW41vy4BxiUY6S9CogEBE/z4fu0eG3i9PZjV/Gru/2s
	 TAdcAZMd9cxX3VVjrx4leRMeyxhN41ArwL1ASyd0bO31bKKLkvOibRzwLlSACXTa1yaRS
	 VLxEeMrbcsExYl+pt2jq32sImbURHJYppsJjkFEhFCI7tgeDBTDOD9mqV1/lvKv22uh7A
	 yr4CY2jyhhBpo5V5GoNwCFbYLz16GydjmyoEvSJSzMdP0C5zlDajjgsd1d9GsB7bXUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WUZ++lOPZU77n13Tlx+PO5BBZRBL2APmrbLQHc5pOjI=;
	b=EVQAEDEmI1ntFLH00MC0JBFh3rixUf29SEp+2rxZqS9tDGJFrJ2OuLvb+X3CNpOphGLy
	 TRxo7BZVatW986nZkcGNlGjKr61gurP6fmii0eur4gLM1jJhkk4wZyfSNLrVKldMaJ2D+
	 0WrfibXz8jjvxA4eCXO1IaCb5GpMvotXjWJ6JbITkO4nEWgQCR4+LsE6RHavhhqdxNhAw
	 f8k+ji+SlQ4hf2nmPgCdH1SLFIOQiaYrtAs5HOEH+DqVIvSxFUiH2wmrCd8n+5FPdjT8E
	 P5ERZm04vT2Jn9/NRwBjcsy9lPoVly/omCczW+G5CoOlxrODCVduzIwGlX5St5+rxaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=vVpHrmCm;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35742606A33C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35742606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=vVpHrmCm
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3704d30b84fso3211343eec.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 13:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794344743; x=1794949543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WUZ++lOPZU77n13Tlx+PO5BBZRBL2APmrbLQHc5pOjI=;
        b=vVpHrmCmWx5r5rXOQTkRrZYXYl23aHiNapCjG3jtM27jYfmadp70qEWff0WeCWY/Vp
         57XEQ7UtEzcA0pnYWSk5wvzamxku+TBM8NV3JgHI4PsuoJtObWpiNnNsEK/nsTRrFelE
         8m3M7ARcjkC2jQeZ7Zst6Njkq3+R8o2gWsWUhljliETfvKRGypZiEMIMpyVatanwHdBU
         KZmaDFXfD/n2Ibq72A0vvzSiRJbSkq/fL1TMrVizL05XdHdopxRx7BRv6o2xnyU552C9
         9Sw2B6qT3jdlhWDCbuY5o04uZmDGm6jjBNMRc4xEFZEk4kgfMWH779XP8xyqdFx8zHHo
         KhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344743; x=1794949543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WUZ++lOPZU77n13Tlx+PO5BBZRBL2APmrbLQHc5pOjI=;
        b=wJXbcIs6iqR4vDxKwP6hpC0n4ZZ2AeInncBqy/n8C70L9G6apWRIU8o1zspGpquozi
         lulVaeTvS/cJJtSKsudb3xwtsm4aNxbkLr21T/Y8nf+jWUmLiRW0VeaO9i2x3pSQPVv6
         COaPdU4daLaTl7roJMEiE+r9404TpX1wa8O7q0pmPjPFPLoRmgCvBHBIvlllbbaGvT61
         LKrZAqMhQ/YbstavTB/lswYMgQuerrU3TwMBhatwGyrHHMiYT82eY6UdOvYhqhgfJfv+
         D8KLcgNhvba8StvLcGkLBwcv5vO3tvD7biAPOiAjcskbU0dKvXK0CTkXWKAPj+JCPIiW
         IH/A==
X-Gm-Message-State: APuU4Z+RWDJkEtExWW7/7GkTALlI8WD4xCxO/mpHqtjHMldXKpvrdkuO
	cJpRB2rEkwtC9PX6L8CrzfJwsO3BvSTX2/8UM78NtfQt5WGnR1jMwLKXNGITlxcSAkA=
X-Gm-Gg: AYBFou2er2D5WdvGZ/vfdYiKeO55gSXp64ardt7g05Y9w7GY2l6IIcRxeORVqf5bOG5
	TkEnspb9/70s8tGZ2OHJfUan03YXrdJ3Ik8Cp0T8iHSs/njPMToOQC5mNouZJ5VxZZm0VPSCp+u
	ZmAigOrCYoVSJKqCfLajpYBFz4M1R1+hBR8P2pSJOWWZwlTgZCYYp1TpcS9Yn5fvtsvL3/9hFn6
	TUxTbOd9dD/5RRcdR24UZLvTNsppNGcZ3TRfRzVenktkHZ0qrfnsuzvWq3BJv9FyR26FK44Pc8t
	9RvjNDdg6iFW0xRoZAIA4dLMM+WOaZWayNbHGA7OoXWfoEepad1wRbqB6ZVe51CYpLRUboCZLFO
	wnct/qCjs6lrhn2LONzOwwgBc5Y/KQPRQGG+yLaSTSsWs7s3A2HNenER6zFLeomb+T5NwlSbRNE
	zfEZm8rR9ejd//NanyIwz/ZP1racu+IOvUppPucwSyTLCyuBCyyb0kY6oUBvkcvtVHEoOGz7E9K
	iAKVHUkerc7FQg7mCoFBU/G/+WsUnPawraPRBLXg7dPTsVhEf9g2XD2nqoSVJdXzsMAJJI7cywf
	KE+lKAb/4hCQByq15cRkaIXm0M6p08iNrAs3FwonplNl9C+i25YPvRRHjxv9eeB9XZjByMs=
X-Received: by 2002:a05:7300:51c3:b0:36e:d060:8bad with SMTP id 5a478bee46e88-3768385dc4fmr798043eec.5.1794344742492;
        Tue, 10 Nov 2026 13:05:42 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm10464097eec.17.2026.11.10.13.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:05:41 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH net v7 1/6] amt: stop receiving before amt_dev_stop() tears down its state
Date: Tue, 10 Nov 2026 21:05:32 +0000
Message-ID: <20261110210538.217936-2-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110210538.217936-1-omar@blockcast.net>
References: <20261110210538.217936-1-omar@blockcast.net>
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

amt_dev_stop() clears amt->sk and waits in synchronize_net(), but the
socket's sk_user_data still points at the device until
udp_tunnel_sock_release() clears it afterwards, and nothing waits for
readers then. An amt_rcv() that loads the pointer after the grace period
can still be running once amt_dev_stop() has cancelled event_wq and torn
down the relay's tunnels. A gateway can then queue a received
Advertisement or Membership Query on event_wq again, and a relay can
link a new tunnel from a Request and arm its gc_wq. Either work can then
run after the device has been freed.

Clear sk_user_data before the grace period, so synchronize_net() also
waits for every amt_rcv() that can still see the device. Once it is
NULL, amt_rcv() drops the packet and amt_err_lookup() ignores the ICMP
error.

The race is as old as amt_rcv(). From commit 3cf7203ca620 ("net/tunnel:
wait until all sk_user_data reader finish before releasing the sock")
until commit 72d3b9a4c2b1 ("udp_tunnel: Remove synchronize_rcu() in
udp_tunnel_sock_release()."), udp_tunnel_sock_release() waited for
those readers after clearing sk_user_data, which hid it. The wait was
removed because each tunnel driver frees its fast-path state only after
a grace period, but amt_rcv() does more than read that state: it queues
work and links tunnels that amt_dev_stop() must already have stopped.

Found by code inspection; not triggered.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Fixes: 72d3b9a4c2b1 ("udp_tunnel: Remove synchronize_rcu() in udp_tunnel_sock_release().")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 81d26ef82..3a703b79f 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3073,9 +3073,14 @@ static int amt_dev_stop(struct net_device *dev)
 	disable_delayed_work_sync(&amt->discovery_wq);
 	cancel_delayed_work_sync(&amt->secret_wq);
 
-	/* shutdown */
+	/* shutdown.  Detach the receive path as well, so that once the
+	 * grace period ends no amt_rcv() can still see the device and queue
+	 * work after the teardown below.
+	 */
 	sk = rtnl_dereference(amt->sk);
 	RCU_INIT_POINTER(amt->sk, NULL);
+	if (sk)
+		rcu_assign_sk_user_data(sk, NULL);
 	synchronize_net();
 	if (sk)
 		udp_tunnel_sock_release(sk);
-- 
2.43.0

