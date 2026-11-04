Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793828938;
	b=Ie7AZzDtCkgT2KWd+qebCozl2IedcCjQa9Hob8foXYCrS5mpcjOGjfpqDmS7dUebkjUS
	 2ydmpmh2sA8cmRjZHTGR7KCqW1rRRrkI4AgZOAhiih8IAt2pOsYD3b4phiIRKpAwaNvi6
	 6Bh7ThVlcJWRd3OK/IYJXVgNfX9oaqTykuk8Tl3mCpMfLEgaYF72ZAKXn1+rdJ/v4ugdr
	 oDwk8rfDW7sIzgKM7UWPd6geSI3AUA02MSyiIK9eVNvzE1tVaPOnrpzsQRWtSxysCtcoq
	 YsdGGHy0mLQjTlG5Gi/kzWQ3qA5vSR1F3AfifSfcGS6GxpFDV1XAhlGffJ68fwPVIEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KPbVAnSZTV2ONta40+7LabKIU1IxsrAw+RSEBw2Cavc=;
	b=Ziv0wIVVJopPjkd3WLkZVvwpArp8zKwlEu03Ie4bIeGymkAuj0fwCyFQkkBUN/0BBRPf
	 fEGt8chgjcSlyixAtet0LF8tOpUulKqwo3d+Krz/sJol5Nppw1Qb7l3zKaQt42griN3fb
	 SQScjeH8wPbxrVetYtnP2N45fx180Z7ZfiI3OVsT+qEv2PyssI2l8Jm9u4GNbYcmWZ9+h
	 AhBy9sWU3QXxOyHNySpfSGUM41YO4AqTuyo04Hp/neHIH4sv1cArEWZrjmTLmG+rIPA0f
	 1pEAe0820uigrI067g2KQ8RZFZbmCUZk0UGvqWjXz9oK1LeYSTAIJ/ndOz8WjquqZgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23BA607872C
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E23BA607872C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3adc4590de4so1060802a91.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 13:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793828936; x=1794433736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KPbVAnSZTV2ONta40+7LabKIU1IxsrAw+RSEBw2Cavc=;
        b=Nim01bO1d44nhi73e7Hrn/23eA27VjD0D075UpMclUPGn7hN43UUisjgYqsAWYTvAN
         GmUzwjVXIzN7gDSuxEv84DKzn3z3rNiSYAItLrRXG8D0op25K2vByeuYOyQ4NI1eAUZc
         6OAugqkzl8MvXk9uJHvUC7YUz0x3SdI0dfh/61cfRBPzCaAwcgIZp0DO1wzX4dWbBklu
         9NSQJj/dKZQxquHc5LiR5rLsthuTduIpBDcWxXsdl1Yl/2vtk/bIXsQn8XwkGOjy++0A
         pKA6PzWBklzGm0Uv/NePO+YMr2ZroVFmkXMzuVeVEkAmyDFLZdNSHrituwCqRtCB4EUW
         Fv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793828936; x=1794433736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KPbVAnSZTV2ONta40+7LabKIU1IxsrAw+RSEBw2Cavc=;
        b=lOS1KRC1BLQp/buhSQsUebbEP6D84fnVzDYyz3jzhIXveqUs/Ki4GEEsuub+k3+G4z
         NcW4OZwJbbCNAt/W9VCuNgEpFo1euCmcx6rzzAakyCwPh48xILZT1WMXyOtri3CmA9Ra
         7x6sAENSFVOaSNWm22scOEbHRPHLrLg/9+pZEdkkQP0kP9Qv5P0ziJSyPB8CAZfAfKBJ
         oS5slf3h49lAR4bzAZjAAA6bDQuxSxlyxDx5nCCqBkf7hra5E7ZXyg/zViQNgyq8CxEw
         wodnTOcngBHRzD747F/4fiR0R1wb0NczLANdXSABMWxDe2nJ/CzbmaA17hNhyUr12kjh
         NtYQ==
X-Gm-Message-State: APuU4Z8EVik3o5KsRQWLiJTx0abAsnPhl4kNe29uuN1uE0JnEhjqmIok
	33a3CiHxoV7q6hmJoaoush6WeKDmQY0h7mzMA7VxLv0rlS6IT4TpwoJmXtCjbt3h+B6E1p5wSDp
	JmTsdcdIdGrsMHYhKsAi1b0Sgr5btmPY/0oAP
X-Gm-Gg: AYBFou3xsupFMLXIun1euIAhQAMBJOi7fyCN2YBqBS7QenmpIb3ZY/SsebLUnN5BXWF
	2KWa/GTSip30+/S9O+ngAlgU+0eZyTAJKXTizFCKpcQTdOv5sGumF7EdEJTDRYSXoYKfAg9wT4K
	NkbJppp9eG6BU1kDMLCscuHKFEecI/L7OUr3cNjs536jlwFLb8In/V5K+Sng1U47xBiiN/NveSE
	TdBSyetSaNuGTM5l+HJ6nl0IaAdWUBG3ia1uJ76rvgi5nc/aBv3SSx1K/iYcR7tl8aabQl1kF2x
	2kj9HpG+Q8+LdR9yiLN5wedCm4dLUqmIVHnNhUZezghjg1k60o6bwKqi15eLmcE6dI7i1IUn9z+
	kCWIc+UMZcK53dRlBJUOfWIX6TuexQIzHlx0=
X-Received: by 2002:a17:90b:1845:b0:3a6:e99b:bbdb with SMTP id 98e67ed59e1d1-3ae8984de26mr12985605a91.50.1793828936151;
        Wed, 04 Nov 2026 13:48:56 -0800 (PST)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b094ced6a3sm816218a91.0.2026.11.04.13.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:48:56 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [IPv6:2620:125:9025:23::2ea])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 4A991402A7;
	Wed,  4 Nov 2026 14:48:55 -0700 (MST)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 45C60DC0D5B; Wed,  4 Nov 2026 14:48:55 -0700 (MST)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: Rishikesh Jethwani <rjethwani@purestorage.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alice Mikityanska <alice.kernel@fastmail.im>,
	Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@mellanox.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] tls: restrict device-down TX fallback to hardware TX sockets
Date: Wed,  4 Nov 2026 14:48:52 -0700
Message-ID: <20261104214853.659378-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
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

tls_device_down() installs tls_validate_xmit_skb_sw() on every socket
offloaded in either direction, but tls_sw_fallback() needs a hardware TX
context in priv_ctx_tx. An RX-only socket's NULL priv_ctx_tx crashes the
fallback on its next transmit, for instance after the device comes back
up:

  BUG: kernel NULL pointer dereference, address: 0000000000000008
  RIP: 0010:_raw_spin_lock_irqsave+0x31/0x60
   tls_sw_fallback+0x11b/0x450
   validate_xmit_skb.isra.0+0x14f/0x420
   __dev_queue_xmit+0x5e8/0xf30

A software-TX socket's tls_sw_context_tx would likewise be walked as a
hardware context.

Only install the fallback when tx_conf is TLS_HW. For that check to be
reliable, tls_set_device_offload() must publish the validator and
tx_conf before dropping device_offload_lock. Today it drops the lock
first, and do_tls_setsockopt_conf() sets tx_conf later, under lock_sock
only. A NETDEV_DOWN in that window sees TLS_BASE: with the new check it
would leave the hardware validator in place with ctx->netdev cleared,
and it already skips tls_dev_del(TX), leaking the driver TX context,
since the destructor only queues it while ctx->netdev is set. rx_conf
has the same window and leaks the driver RX context, as
tls_device_offload_cleanup_rx() skips tls_dev_del() once ctx->netdev is
NULL, so set it under the lock in tls_set_device_offload_rx() too.

Also do the switch in the first loop, under tls_device_lock. The second
loop runs after that lock is dropped, and its reference pins the
tls_context but not ctx->sk. A socket with only TX offloaded can be
closed meanwhile: tls_device_queue_ctx_destruction() drops its reference
and returns early, __sk_destruct() frees the socket, and the write lands
in freed SLAB_TYPESAFE_BY_RCU memory. A context whose refcount can still
be raised under tls_device_lock has not been through
tls_device_queue_ctx_destruction(), which takes that lock, so ctx->sk is
valid there. Later contexts now switch before earlier ones are torn
down, which the fallback allows.

The NULL dereference was reproduced on an RX-only socket, which now
survives an interface down/up cycle and keeps receiving TLS records. The
software-TX case, the setsockopt/NETDEV_DOWN races and the
use-after-free are from code inspection.

Fixes: c55dcdd435aa ("net/tls: Fix use-after-free after the TLS device goes down and up")
Fixes: 4799ac81e52a ("tls: Add rx inline crypto offload")
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_device.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 4cdfbb57ecff..8cfad667c43c 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1195,13 +1195,15 @@ int tls_set_device_offload(struct sock *sk)
 		goto release_lock;
 
 	tls_device_attach(ctx, sk, netdev);
-	up_read(&device_offload_lock);
 
 	/* following this assignment tls_is_skb_tx_device_offloaded
 	 * will return true and the context might be accessed
-	 * by the netdev's xmit function.
+	 * by the netdev's xmit function. Set it and tx_conf under
+	 * device_offload_lock so tls_device_down() sees both or neither.
 	 */
 	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
+	ctx->tx_conf = TLS_HW;
+	up_read(&device_offload_lock);
 	dev_put(netdev);
 
 	return 0;
@@ -1282,6 +1284,10 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 		goto free_sw_resources;
 
 	tls_device_attach(ctx, sk, netdev);
+	/* Set under device_offload_lock so tls_device_down() also
+	 * releases the driver RX context.
+	 */
+	ctx->rx_conf = TLS_HW;
 	up_read(&device_offload_lock);
 
 	dev_put(netdev);
@@ -1345,16 +1351,20 @@ static int tls_device_down(struct net_device *netdev)
 		    !refcount_inc_not_zero(&ctx->refcount))
 			continue;
 
+		/* Stop offloaded TX and switch to the fallback.
+		 * tls_is_skb_tx_device_offloaded will return false.
+		 * Only HW TX sockets have the context it needs. Do it under
+		 * tls_device_lock: the reference pins ctx, not ctx->sk.
+		 */
+		if (ctx->tx_conf == TLS_HW)
+			WRITE_ONCE(ctx->sk->sk_validate_xmit_skb,
+				   tls_validate_xmit_skb_sw);
+
 		list_move(&ctx->list, &list);
 	}
 	spin_unlock_irqrestore(&tls_device_lock, flags);
 
 	list_for_each_entry_safe(ctx, tmp, &list, list)	{
-		/* Stop offloaded TX and switch to the fallback.
-		 * tls_is_skb_tx_device_offloaded will return false.
-		 */
-		WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xmit_skb_sw);
-
 		/* Stop the RX and TX resync.
 		 * tls_dev_resync must not be called after tls_dev_del.
 		 */
-- 
2.50.1

