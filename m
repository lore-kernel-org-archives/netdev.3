Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D673BE16E
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786915729; cv=none; b=JylbWlHVlRt3GRW0lvS6eDRSctqPOZ62s86T63CoEs7FjF2EzdOri9MMhn4vsPYztS1tf+sKr62Y07DRrZ52OO7/wilMB7Q8KBwwx0np9VTR9ZzJ04v6hA6s1oMyaylUwP0k2kCgZjY3E2f9G5qDmton7ep6W/J9kbn2C4alLlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786915729; c=relaxed/simple;
	bh=vmIxoTgp5rXYjZdZndNXm3cLoC2gVg/UZ/rKhIyR3LU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BczQLr1nqDdBykgxNEDwRdB6C2iHNdQ88hXDRCFWcmpOUBW5cOWj9/MBJ1UcUIPo3iIR4Zjm7yR5RPcyRUL1EqI56x1mHdE2g9UHgNG6RYEEcb2zstQpgO9Vq/Mg21EFprYwWBowJaiYK2OPrisINrlS8DmlzFiWQF9K4xiC3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVlru5pW; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVlru5pW"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38101f85591so3408518a91.1
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 14:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786915728; x=1787520528; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fF53IEOcm9r8UrH8QRiLlfPiEelq6tdSUeYZh5gr9es=;
        b=DVlru5pWvatU3fVVu4TnesqmNtLJI8CyX/r7tMhWO1nUjeQR02Q0T6irT+cVmRDdzG
         M1XlCAbohjqmfOAb25+wRAr/lnWKN6dq9NV837pm5DysdFjNhw7iFqkQXim0a1f1Nncd
         wmadfQfBNg+gB7Os8iAidsXBFfSdU0gwz1sIUaoRZkQPy2+t+qd4GoWnPylUk4+R4Ypj
         bqh+H/8PIAZcpmJNQuL5ke9AfQ1os4WsO2OTm3QIRfw75y0Xqnw48dTiEx0DDfJZDAH0
         1pDXMTWHZlkboyG/KZkRqrAvJ2QGJj1aFLsHgOY/D5pgDapFNEx/mvIaKpIXBDr/FaoS
         6YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786915728; x=1787520528;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fF53IEOcm9r8UrH8QRiLlfPiEelq6tdSUeYZh5gr9es=;
        b=Zye+03MEhWJXOJ8M85ppaPbF4aSQ8NT7+HYbKW8A+qPHIZc8nPtrXFKrPe5JzneyrZ
         AIZT2I++FvnPUWrPM7CjAB2ZHVO8PhGjZM8yklRkC1J+FctBlOEdOgWl0xSkdRCJsCiK
         qVAEYpImlQuwGFbXeqjbuluqWu9vomD3UwAr17yn9dl6sJhipCiuqPvz9Jus/dm5O+at
         DvLY7YoGilx/2lgLD1XhVRE/tFtXvQZ99LYzkC04W4iAM2mfu50/MfB2itd32h+nOKx0
         1rxhhf+Y7rKczTyaK7GPHli7+NbaPOqIHCCsSVdBqLtFuGU1kqhSmWvJr7xU0u3IZe6O
         T4dQ==
X-Gm-Message-State: AOJu0Yy98XxYpbbrjoXgiZNdlABIjQ8KZ6sWwSmys79UmA8ezUvMOXIo
	VBjmbVNy7PkgkOjbPSL8dTtJuF0/t5Ffa6X8GdVLDYRErfTe0hsXV4oB
X-Gm-Gg: AR+sD12Y8KNUroX0rQfO4YVsXGSuuZP8aclJXrY6v6BWrx4fHPQbkEhnFwhwWEC8NMp
	iNRlPO85EbcjHOXiKSC0IMiYzn0AbDUnIG5uv3WDsbBpSpE6qZmddJRHKE1/YDC6G54VoHdvdvt
	juQzKh6DyVCQRJTkS5HmIPuZr/vU9ab7Bo19ELThGAlv7FwlIG6wjlpCLzXNZlbe6wHDXygzBUW
	mRCcly587kga+WrVQcpkoNMo4xRxd9KA1VfL1VdW43Ypkyy6bhXvKzaUbLZEMs2YnDxqWC5MajG
	pNwsvWtbXNlbKWxSQicq5xwZQYmQoDx5POgPSoimqryVC7s16KvYcIYRqK3zUV+pquGSdVUhp4A
	TqQ1/zhnNiu3yY12wTW2wfdDKexUTRlCkM+SbXTzwuO8f6U1L8Vb2XeImZ3QEAcoYCnJlbQBuZ5
	lmiqTXIfsSIcr1uARLLsc+NzWwKMTI6d1FmqUQRz/NLqyE4AmVth53PXOLYExouF81DDHZdriRd
	1t+Kzx2
X-Received: by 2002:a17:90b:33c1:b0:390:b3c5:e2c9 with SMTP id 98e67ed59e1d1-3933b0d5d31mr13369403a91.17.1786915727596;
        Sun, 16 Aug 2026 14:28:47 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e13744sm2389297a91.2.2026.08.16.14.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 14:28:47 -0700 (PDT)
Date: Mon, 17 Aug 2026 06:28:42 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, dsahern@kernel.org, 0x7f454c46@gmail.com,
	fruggeri@arista.com, noureddine@arista.com
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net] net/tcp-ao: fix use-after-free of current_key on
 reconnect to another peer
Message-ID: <aoIriv3pHDgII2YR@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tcp_inbound_ao_hash() is called before bh_lock_sock_nested() is taken,
with only rcu_read_lock() held. On the fast path for established
sockets, if the rnext_keyid sent by the peer differs from
current_key->sndid, the key the peer asked for is looked up and stored
in current_key. The lookup is inside the RCU read side, but current_key
outlives it.

When the socket is disconnected and connect() is called again for
another peer, tcp_ao_connect_init() unlinks every key that does not
match the new peer and frees it with call_rcu(). If current_key points
at such a key, it is cleared to NULL.

The fast path reads sk_state only once on entry, so a softirq that got
into it while the socket was still established can update current_key
after that loop has already run. The update is inside the RCU read side,
so it comes before the call_rcu() callback, and once the callback frees
the key, current_key is left pointing at freed memory.

The next transmission picks that pointer up in tcp_get_current_key().
tcp_ao_transmit_skb() then reads the traffic key from the freed object,
which is the use-after-free.

Wait for one grace period before unlinking, and only if a key is going
to be removed. By the time tcp_connect() runs the socket is already in
TCP_SYN_SENT, and TCP_AO_ESTABLISHED does not contain TCPF_SYN_SENT, so
a softirq entering after the wait cannot reach the fast path, and the
ones already in it have finished. The existing NULL handling in the loop
is then enough.

Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv4/tcp_ao.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index e4ec60a3349635..5094267447aee5 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1160,6 +1160,15 @@ void tcp_ao_connect_init(struct sock *sk)
 	l3index = l3mdev_master_ifindex_by_index(sock_net(sk),
 						 sk->sk_bound_dev_if);
 
+	hlist_for_each_entry(key, &ao_info->head, node) {
+		if (tcp_ao_key_cmp(key, l3index, addr, key->prefixlen,
+				   family, -1, -1)) {
+			/* pairs with tcp_inbound_ao_hash() */
+			synchronize_rcu();
+			break;
+		}
+	}
+
 	hlist_for_each_entry_safe(key, next, &ao_info->head, node) {
 		if (!tcp_ao_key_cmp(key, l3index, addr, key->prefixlen, family, -1, -1))
 			continue;
-- 
2.43.0

