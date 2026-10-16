Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8826D5275BB
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175682; cv=none; b=ezeNYabXZ+kxqIgQHtv/6MCxWcoIslML99b9e8xfr5TOF6lYJjy8TpjlcQjryHerROWaQi6U5yuFtC1Fug6+FTMn5RGPKy4003bSx7CNSCIQ3zena4UAkTSrNl8VCizc9k+8miJ2Yfsyt6zXd76jkKz/2Gm4fuHE++a9PPe8e9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175682; c=relaxed/simple;
	bh=YiRXycP+uxr5mcJIhKdSbZ7fyW1m45tsXkxmS2az14k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTisteMpI3kVVtvYp4q3B1eEuMhdfgQpj6SUypdLfDebXRvz0IgGVMakqq83NjbguGEjI5E8YHWyhPmCoJm76Y8OPGQRYvX6hfbmhyDQQHBBCmmWs1UFxUn+yV4eSa5+6h6rPnLue0EKAh6Bfe8VGP9UVSTsSsUukkuMSj30csg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UtWL1Wya; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UtWL1Wya"
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so2167175e9.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 11:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792175679; x=1792780479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=58GjRrwKq9G+Uv/14ArS/PKw0G2GDmvFoq0TQkgySVU=;
        b=UtWL1Wya8C24ps6P0mJP0X4xo2GF0xf8fd+UDyn82AZM0bXYxm8K2i9F5e1mvMOcrq
         SqvcCSCf3P6lmI/Gtkf2sU7WakImiaT0Qm7aM6SK89BkkkB2/9h5VxSAheKcOoqaL1eK
         PF086vxBbmzIKJIUgedH1NCEkZBwecbYAs3WOJ6uMTsVmaVQBddH1hLykt1PSacowqkw
         6GOjkTg+J0xndHyE7UgwXNmqo92AEMUZl5zEpvp8wEn+oQZLVSJHHIm2oFiEvkV3bwx9
         4fhmG65Dm8i8JZChhp5AxlxUsiC8u5RnwsD1BVgNT54pdf4Iqi82u/1zk62YG/AshnQi
         a5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792175679; x=1792780479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=58GjRrwKq9G+Uv/14ArS/PKw0G2GDmvFoq0TQkgySVU=;
        b=JpZBjRZilR4pkAKkv5d38kT4NUyXm1fQsPdFlRPPNiEjVuf7t1eW8HpJ/RU5CNaU8U
         L3VQmdLiPoti7w5h7s3e0AvrqZN+Ex0qXG673klRAs9FvPTeykkSXdgUd7q518ku4BRR
         LFlqjaTkRYB4uVEp8cnBMQoC7sew9yKqlRbYeDKjNNSTI8wD8csOdyT7jSqWYdM3B86x
         GsESpPkcAGX0M3cFmeFRZQNph97jTruM0aIoCHyLs5AGVoCUS9S264iI72bloq3ntJcR
         m+9gPKnSnIaqows4AUSrYsGlvzfc2Id1rRFPmHhMoWtSVvnB26ii7qaLXmpedYJew7wn
         k5oA==
X-Forwarded-Encrypted: i=1; AKwUvBze7zDlDZD5Vc9mGStUsbNOyS+9zpdLwM9Z5TTiGnCNV5kB8/cKJhGFDxP6n6fxS9xJoRaOlS0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAfCYpRhcUrURpAgwnl3UT5rE4Kq6Ey69aQdLw3LaHmMid0dZS
	ltIFsX0LmiBnmAQlgy6PaWkBRrl4Jy70chQgUd4R1OSv4Xf2Gva66u41tqwwKglZAk7W5emdYOY
	Ym7ilMkXObL/aR5xaYFoUeAI/th802a+MMC8h
X-Gm-Gg: AYBFou0LGma7dXnmcXYyPnhIBxkwM1rMavChZ1cIOUKz1nsAgRu2PuMXs7IZItTH1wa
	0KI1OPNME8ylHRzQa5++8KfYkEIwdQvfdvpeiWENexSbrtItw/qj415xWkl+JPwYLkJlluJ1kKO
	mdsECSJEf8umu1iDH2aweZPhQojc2VgBGB3MKOrZUYimBWwygPc2/kWIf+jLnTiUc6B/itQeuu8
	GBZK4FlW/vD61lD/XLz22MliK2xpKrMDbdPSgnkuynrih69cs7VTZk53TCDxfnQ8Rft2rVSxH+7
	+V+KQ9T8xDyzsduY0IorZfUmmA2BJCy5bDpykQPI9hxwQCGTp1vNOhH2WABAYvchHD4ZpzKMXAI
	bnIzFlF56bCa/D6wqTfZD3QcdQaWbA075Ea8=
X-Received: by 2002:a05:600c:8709:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4a1d75e6f32mr14208145e9.5.1792175678824;
        Fri, 16 Oct 2026 11:34:38 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-4a1bd9b719csm23728875e9.5.2026.10.16.11.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 11:34:38 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [IPv6:2620:125:9025:23::2ea])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 70BCC4032F;
	Fri, 16 Oct 2026 12:34:37 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 6B5FFDC0D46; Fri, 16 Oct 2026 12:34:37 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Alice Mikityanska <alice.kernel@fastmail.im>,
	netdev@vger.kernel.org,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net] tls: restrict device-down TX fallback to hardware TX sockets
Date: Fri, 16 Oct 2026 12:34:35 -0600
Message-ID: <20261016183435.23382-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tls_device_down() visits sockets with hardware offload in either direction,
but installs tls_validate_xmit_skb_sw() even when TX is not offloaded. That
validator calls tls_sw_fallback(), which expects priv_ctx_tx to point to a
hardware TX context.

An RX-only TLS socket can still send plain TCP data after the device goes
down, and the validator stays installed after the device comes back up.
Its priv_ctx_tx is NULL, so the fallback crashes when fill_sg_in() tries
to take ctx->lock:

  BUG: kernel NULL pointer dereference, address: 0000000000000008
  #PF: supervisor write access in kernel mode
  RIP: 0010:_raw_spin_lock_irqsave+0x31/0x60
  Call Trace:
   <IRQ>
   tls_sw_fallback+0x11b/0x450
   validate_xmit_skb.isra.0+0x14f/0x420
   validate_xmit_skb_list+0x41/0x60
   sch_direct_xmit+0x11d/0x2d0
   __dev_queue_xmit+0x5e8/0xf30
   __neigh_update+0x354/0xcf0
   arp_process+0x252/0x800

A socket using software TLS for TX also lacks the hardware TX context
required by this validator; there, priv_ctx_tx points to a
tls_sw_context_tx instead.

Only install the TX fallback when tx_conf is TLS_HW. Leave the validator
unchanged for RX-only and software-TX sockets; tls_set_device_offload_rx()
never installs one, so they keep sending plain TCP data as before.

The NULL dereference above was reproduced on an RX-only socket.
With the fix, RX-only TLS sockets on two hosts survived an interface
down/up cycle and continued receiving TLS records and sending plain
TCP replies. The software-TX case was identified by code inspection only.

Fixes: c55dcdd435aa ("net/tls: Fix use-after-free after the TLS device goes down and up")
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f11d0528fc43..15ef6c3c0648 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1319,8 +1319,13 @@ static int tls_device_down(struct net_device *netdev)
 	list_for_each_entry_safe(ctx, tmp, &list, list)	{
 		/* Stop offloaded TX and switch to the fallback.
 		 * tls_is_skb_tx_device_offloaded will return false.
+		 * Only sockets with offloaded TX have the
+		 * tls_offload_context_tx the fallback needs; leave RX-only
+		 * and SW-TX sockets alone.
 		 */
-		WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xmit_skb_sw);
+		if (ctx->tx_conf == TLS_HW)
+			WRITE_ONCE(ctx->sk->sk_validate_xmit_skb,
+				   tls_validate_xmit_skb_sw);
 
 		/* Stop the RX and TX resync.
 		 * tls_dev_resync must not be called after tls_dev_del.
-- 
2.50.1

