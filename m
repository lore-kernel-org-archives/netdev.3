Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0DA2E8897
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784358792; cv=none; b=DqutdPO07FnSNTQtOXS0jYPO4Rp78luWbR6KygeCghAL9rN4dD3LkWBEiF/WCiMoqLhSc3KEa9AP5dO55rsAkiN2SzmAEAtiQ/6k6Gy0iBuJNvwQ4AL4IrZbQ2xmmhSflOII30yHDsGP6sv6UXi9dW9mHzLp7rMSvDey16HrS3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784358792; c=relaxed/simple;
	bh=ct2Y5RRo+SptjAw24PGyuywLJAbN7uO+mC+s4HhzYpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZAGVf53Oh5khL9GnGD9de0kXrkla4A8fO9Ljh6m7m2P1domWtclw0TYzSlTm0pBm7x+lWv9qbZ+OmmlKwuc0UGsawfR2NzWurwB64kRYeqn3V8TzNvFHMFhptvrQg7B240VolNBQ2a8jGCde517kYWBZ/AJMgufgt2zFY48FxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8zUVxvd; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8zUVxvd"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8486672f03cso8562781b3a.0
        for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 00:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784358791; x=1784963591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lIVE2LKlzct84UOzkVO/U64LKkvncWsXRMQbztwwo3Q=;
        b=P8zUVxvdz7QHhQQEQ76Gc1Yxipbpn/AuK7UDSAfUEDeS7Fay07P5ZhhlQL2cThIBr/
         mDlVBmf41jwuxhvwcp4S1Z2p351NMpV4jFpDWOc7/P5p/Gg+/KrGnCZnjRIp/72bMBGt
         j++dwIHzY1t58Zq6DW7aseeEUO10ypKjxbP6ATb7MO/Qtd3FHeog9iEdrV6260Nq9Fz8
         FS/8rTAKyqoXHE4oG1tIuVnQZlKk7dVkWokDmBKIXowGS/MIs92WCj/pv6TXgGbZJERa
         ilzAblPY/J988zTEdsoUyxCLxVT0xwojgM2xKpRYnPdBLEYjibEf1t6d0k/0oKhaqhLH
         vorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784358791; x=1784963591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lIVE2LKlzct84UOzkVO/U64LKkvncWsXRMQbztwwo3Q=;
        b=M1rZmpbHSBmckXHh+3q4Pvts28BjfPdkpUpVmnIZ7MjB36o8fiyz6x2NJf2ToF8nSM
         HyIJ7AM2nYeRK7+z+MS1bbFZd90zqNyJv07aTfyKgOL3ktsCKR6vaWn0HlTAL+QQVlyz
         Z8HAvMgUpeLo04nNQ8UH4SAJL0fKfArDCIE6dNWBZ4LxlhMlNJhfD9GMrno6Z0WMXaZs
         cphGwtrGAOf3uJc1qBVrSe5GQr7s1jVXL9/VR3ofRsbD87DNAuv6o1mDzFSPuC3LFXQ+
         lH2IvE5Rw6lFyOYdaJK09H3ziTIJTMWI+DG3VQ5xdmbZCf8mLALF2GQXtioXG/54KWbP
         w1AQ==
X-Gm-Message-State: AOJu0YyjhdHBhOdAa2Wv4M0C5hM7LeRdxIO7gEjWtM8TVe5PUCMHMujd
	gG3VeuxlJ+ICV9XhmhetAdx5f28C0VbBqt3mTPZZSi19DVEGMdXMkFyRxEGAGYe+
X-Gm-Gg: AfdE7cngNTs9b3jkfj/c3nzf8sMOYcnV8yCylc3hnVG1FzMYVjHMwCB2lG0SpKOxjJb
	2eUCntb5KwOCctVTihkgbjc1lHF5fbfjfcd6QSE2Ya9QkSTXLHXlyNDm6oQ7uI7ojimu40IDi1K
	GDbdeoWyVSELBEK1NMWX5yEwbrJeoozEB/9IKClKpka2VCsqbwh+iZb7jzAkvnGTdHAYNZqzDpi
	K1KR+JTqHIsD/WCrpgJWilgWnPYa77eGpXgIw9QOWWC1LsNUwYh4VzwC4/sbKvwxLNFNIUL5bST
	sfM5nmjcglMAgc9f+b9a5kb5mDc9ZL0/gAIDlCkKgFoDYTXtjAKbaxsvtvLe+MyqLggTsjm8zCM
	+IfV7lTPXu3qRRwR2X/YPT55BGBXRZM/F34bIoHWSBZ0MQxn52wHtDSuzyBhssII3HWJrbHqVIF
	un/U57UWb18LYHQSgSpGcadw8jZRgBy38=
X-Received: by 2002:a05:6a00:348b:b0:848:8715:c2cd with SMTP id d2e1a72fcca58-84c2948b105mr6497710b3a.47.1784358790977;
        Sat, 18 Jul 2026 00:13:10 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([123.114.53.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2ad8b766sm2390754b3a.4.2026.07.18.00.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 00:13:10 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	sd@queasysnail.net,
	vega@nebusec.ai,
	roxy520tt@gmail.com,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] xfrm: drop ESP-in-TCP packets with no ingress device
Date: Sat, 18 Jul 2026 15:12:50 +0800
Message-ID: <0695ad081ad2abe6bab142be361ac4b52595fa6f.1784312563.git.roxy520tt@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784312563.git.roxy520tt@gmail.com>
References: <cover.1784312563.git.roxy520tt@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <roxy520tt@gmail.com>

ESP-in-TCP receives records through the TCP strparser. handle_esp()
restores skb->dev from the saved skb_iif before passing the packet into
the XFRM input path.

Queued TCP data can be processed after the original ingress device has
been removed, for example during veth or net namespace teardown. In that
case dev_get_by_index_rcu() returns NULL. The XFRM IPv4 and IPv6 input
paths both expect skb->dev to be valid while building the route lookup,
so queued ESP-in-TCP data can dereference a NULL device.

Drop the packet if the saved ingress device can no longer be resolved.
Such a packet can no longer be routed through the normal XFRM receive
path, and this preserves the existing behaviour for packets whose ingress
device still exists.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
Assisted-by: Codex:gpt-5.4
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
---
 net/xfrm/espintcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 374e1b964438..fc01ce89492a 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -37,6 +37,11 @@ static void handle_esp(struct sk_buff *skb, struct sock *sk)
 
 	rcu_read_lock();
 	skb->dev = dev_get_by_index_rcu(sock_net(sk), skb->skb_iif);
+	if (!skb->dev) {
+		XFRM_INC_STATS(sock_net(sk), LINUX_MIB_XFRMINERROR);
+		kfree_skb(skb);
+		goto out;
+	}
 	local_bh_disable();
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family == AF_INET6)
@@ -45,6 +50,7 @@ static void handle_esp(struct sk_buff *skb, struct sock *sk)
 #endif
 		xfrm4_rcv_encap(skb, IPPROTO_ESP, 0, TCP_ENCAP_ESPINTCP);
 	local_bh_enable();
+out:
 	rcu_read_unlock();
 }
 
-- 
2.43.0
