Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631728;
	b=iC02AD+RG2/U/OzMIReuziL2ZbopjEl60U3OnpScYTCNz+cwyU+72yrTE9HvP2ffy910
	 lXX+skbHmgVy8k0HldrAxllvY3T71w+mYPcbUWdQEXzZa2le4zTzC6kVW2taqeIIqZQIk
	 V/35QVLzC9y0pPQEi9GOE2ivX9+3AxJPkOm+Begvkv6/zddocUx2zZ6Q1dqCajN9gpMj/
	 hFs0WKgWsLDCeQdWmbV+WZSEwCiwTzrk52KjFUsqWXuMLmELgTS3MA6gMvCXtxOLWbl9f
	 nnBWkN+e960z0EaHGjd0EDaDk1zdxzYNZHAT2a6uX09kZE2qMfkjaFw++O1BlJVCWxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vMjwo8cmw5PTMuLBYGwQtehcqEVVHRxZCPBH9RAmfLM=;
	b=FpNEBc2R6+rLAi+M6HA52BsnGfZjqH69aRn9tTGHnMTH1HlX0sP1fnLFte+RfUANF3F1
	 R3pKlI2GIft9VKaO1IvGolY0owP99t5FTdL16r9wG40KXSxSK6Z0bG+11lyOni0NQzJB6
	 4QLkMZL8hFa9QpBCEk4lcuYHFl36+JhMTfn6O5qlfdC4h7wPLLbznawxVIP0//+BCGtAX
	 qemgdboDvRjgglb6fGuELHCKPXvtLEKm2kFQobeWjBL/U2vmi2stbodit5XI74IXSRT/0
	 v1wi4nRDIY5RXv2sOdhDXjMGYKpbBPlo0np8K2TM99kw/hw47qp8hRVZpay8N8uQ5LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xwxnj0DD;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBD760A382A
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EBD760A382A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xwxnj0DD
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-18cdcfc05ffso3524274c88.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 07:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793631727; x=1794236527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vMjwo8cmw5PTMuLBYGwQtehcqEVVHRxZCPBH9RAmfLM=;
        b=xwxnj0DD1DKAFVLGNqn/LX/iHKyCUG5RpZ06KLrANvWczMx7mNH3POOJaQTlSKKzRX
         cZokFQKAXKVzNglOBI+mQ4XVUBXTw3W0475HWABkQPnUVW1CHwj5YTChR68ZEugPnfvV
         VR7yyicuAN3XPeGZ8SHMJtyfpwb1LLZSI3s+OVfQd/VHWnC/0G3nYNVyrxSnGZpDVkry
         O1qqcfiVmZjs2LNHitVY20/0RrsRk0HpKvjncr6ifd6OwHirJ4jFSDXYiULwnPsLuvUX
         5MbjirEj6mMVPT6QVtRrDz3RXhx558Mz5K4uQlOzS1WbBAOylrFf7qch6ZcRJMh+w1G2
         O24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793631727; x=1794236527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vMjwo8cmw5PTMuLBYGwQtehcqEVVHRxZCPBH9RAmfLM=;
        b=K3qm6y9CsBbvHBjNF238L1RyJTCc00Fsq0kPz1JxJtCM26/Xzef0Laz61/dFfsdaIJ
         rpVhj40LIEZfOcc44zqKHQJTGCgIHHyu5bf6fK2uktjBjDRho7RNM9YVCjCrx03kGDMT
         nqkwzKJWXuDn49SYExb+ZunRLm+xI3fdYjtlNnyZHcAigutJKiAUyGwm7OpoCLOfrPey
         3MBhycZuV0TZO5rU0bCXt+e+s1NHbVbu7SRhAnEjIN3loBC9IWlnSlVAIS5b9amNlJjX
         MNqoCR7R/g0yK2nA1rMxrG0Lm5un/ICJA9eO4Pix+k85+04op5mblb90VNG5eSlpG3tQ
         OIkw==
X-Forwarded-Encrypted: i=1; AKwUvBwsCJ58oBS7xqJrx49BVDARduWdoivEe0vBwytB41jN1oovjhyTCIK6K4bspH9K2lHqNxCAYjM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVvqp2AmAdFqNY65cXKieW8s/vZqXbOIJSk6uRuQfTr6DpBcZi
	l8xrO4/pinEFX7591jQrXOQyW/VUckDE4oZtGnRCj1V+lS0+Pze1AV0r
X-Gm-Gg: AYBFou3xViHgb2UePGpFEJ6Zc0qoeWaZq7Nb5fJDe3V3EprsEIIp/EsFjvgub5jv/En
	PZvGly0psWH8h/4j9o38Cu8hviQgt1/nxHVDW2dCDrMpf4ctuomyrXmTwy3JzfR2gpWhkPBRQTf
	oUc3Xv8tRttUk+Z2dqjt2KDVAt/ZxU1AVWOegAKqeZ1Gk9ZXyQIM3C1GYvggPBLFitBhGtibRIx
	c8ZlJNBV6XFJyeoD0nc8cViHEJgVh0bKqh64LHuHBqH+QS3xTuLHgDmYUZwsFqkV90AWvYqGtBI
	Ge5ZPi+lZPLyuPC6J/7U7D+sCtCIuOM+aTwwMu3idW5YpbJVjvOVcnI9Qh7U3BNrIRKHm2M62Iw
	4Ol4cmhadmWTE6YVLZOjNO5+piZQFOofYC49yYwdZaNydgfAYrQqBKGfGvf0TVmcV51M/fWqc+F
	Z19YVCzsdqzPR3etar5TKQo0hMrcchwEEYCC34s+1XR7EPtlZaiFHe/KZM8pKGHmZAqKjgXwe3v
	i4GRD/zwXLnXhdWiYBxdQ+lxmvfJWsjtxvMW2GS20nQWNF1S6Jap08QSVGjKMAePJnR+xw3sCFI
	pHl3J5BNp+6O+OxYDaevblWEj1e8pLz0HJul
X-Received: by 2002:a05:7022:92b:b0:1ab:fe29:5055 with SMTP id a92af1059eb24-1ac5bbb9041mr19879405c88.9.1793631727135;
        Mon, 02 Nov 2026 07:02:07 -0800 (PST)
Received: from xploitoverload ([2406:b400:f11:1bac:4040:640b:8a1:8629])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1a136537sm34406419c88.18.2026.11.02.07.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:01:59 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: andrew@lunn.ch
Cc: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Kalpesh Solanki <skalpesh942@gmail.com>
Subject: Re: [PATCH] ieee802154: nl-mac: validate device pointers before dereference
Date: Mon,  2 Nov 2026 20:31:00 +0530
Message-ID: <20261102150100.44615-1-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Hi Andrew,

Thank you for the thoughtful feedback and for digging into the git history.
Your point, together with the Sashiko AI review report on this patch, makes
the architectural picture very clear.

1. Analysis of Sashiko AI's findings:
Sashiko correctly pointed out that guarding only nl-mac.c is incomplete:
- net/ieee802154/nl-phy.c: ieee802154_del_iface() unconditionally reads
  dev->ieee802154_ptr->wpan_phy when dev->type == ARPHRD_IEEE802154.
- net/ieee802154/socket.c: ieee802154_get_dev(), dgram_sendmsg() calling
  wpan_dev_hard_header(), and ieee802154_rcv() / ieee802154_dgram_deliver()
  all unconditionally dereference dev->ieee802154_ptr.

As you noted, sprinkling NULL checks across every one of these sites in the
ieee802154 subsystem would just be papering over the real issue and hiding
bugs rather than solving the fundamental cause.

2. Audit of other struct net_device subsystem pointers:
I audited the other pointers you highlighted in struct net_device:
- ieee80211_ptr (CFG80211): cfg80211 does not rely on dev->type to infer
  wireless_dev; it uses dev->wireless_data or wdev backpointers, and tun.c
  does not set 802.11 types in tun_get_addr_len().
- dsa_ptr (NET_DSA): strictly managed by DSA slave allocations (ARPHRD_ETHER).
- tipc_ptr (TIPC): managed through explicit bearer enable/disable, not dev->type.
- mpls_ptr / mctp_ptr: managed via rtnl/subsystem netlink ops rather than
  arbitrary dev->type mapping.

ieee802154_ptr is unique because drivers/net/tun.c explicitly recognized
ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR in tun_get_addr_len(),
allowing TUNSETLINK to stamp dev->type = ARPHRD_IEEE802154 onto a TUN device
without ever initializing dev->ieee802154_ptr or wpan_dev. The entire
ieee802154 subsystem operates on the invariant that any net_device with
dev->type == ARPHRD_IEEE802154 is a genuine wpan device with valid
ieee802154_ptr.

3. Proposed resolution:
Setting ieee802154_ptr to dummy ops in TUN does not make sense because TUN
devices cannot function as 802.15.4 radios (no wpan_phy, no channels, no
PAN ID, no MLME). Virtual 802.15.4 interfaces are already properly provided
by mac802154_hwsim and fakelb.

Therefore, the cleanest and most robust fix is to disallow setting
ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR via TUNSETLINK in
drivers/net/tun.c (returning -EOPNOTSUPP or -EINVAL).

This single change:
- Closes the syzbot crash in nl-mac.c.
- Closes the crashes identified by Sashiko in nl-phy.c and socket.c.
- Preserves the invariant throughout net/ieee802154 that dev->type ==
  ARPHRD_IEEE802154 implies a valid dev->ieee802154_ptr.

Alexander, Stefan, Miquel: as IEEE 802.15.4 maintainers, could you please
confirm if there is any legitimate use case for a TUN device claiming to be
ARPHRD_IEEE802154?

If you agree with this direction, I will withdraw this patch and submit a v2
fixing it in drivers/net/tun.c instead.

Thanks,
Kalpesh

pw-bot: cr
