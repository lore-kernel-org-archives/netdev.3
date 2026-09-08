Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7D758F07E
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891495; cv=none; b=gL6EmdQp0gTm/hCeuqMOYzSW6rLDs0HopuLQ27Bl+b08xZsUYzvD/obNM/1WRmSxlMI/eoPLBEbQI63/Rdc0vrG7BAQnfUc+z2BAB6rtQFy2Id6wpVtNYCOE6YYhRaaGv+e9li2BKKS5bqLF1yFjrhgcU0x9Mjyd8JK/B56Orcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891495; c=relaxed/simple;
	bh=djo5yKX6IfxvUJfhcsOufrmLRwvOgrmjCKsvciG4XFk=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=qRfUKpP62WFx9ExplmFd9HoXBFKZcnDDDoipvQ5qgxS00J2X6W3Aur35umq9L1RkdWQx/BoLqOwYa7a6h9GW4AMl6H3uLT1FiNzF6L6g1E0eLWOjsBcb60ZbhLERB9z8RRcLn+incKtL2IUz9X4om5KfUCyDjjDHD9/Ez9EC99Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=jQL1MG+H; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="jQL1MG+H"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15e2dab83eso861460566b.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 11:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1788891488; x=1789496288; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/gIrDYrcRFL0UG1Ku9cpIdiffr0L0aeV9J+6pPKl758=;
        b=jQL1MG+HT9P/APXO4QjYG8PU3a1ZBz379SZy5UCuUt4DZbP0NCZEPNbetQiq+Lq774
         sMbr4K1cajZl7DXPE+8B6XwGSusbj7//uYi2RPGa5rsccc3Jh+oHGILDQRM7Pfd4Vvs7
         syJj1n3zuM+UKBP+xCHcx306/FEhyl1Ha/fjl9YUSGIzDwlimnlO0qIQPWPPu8e6HaUL
         zJbmEsy6ax8HaS3N/kQyEkQCCviuABu9h27//Od/CD7wntO3VSvC2j7tKS8x/n+Nu98I
         ipCESwjrQPfahXH59qmTtZ5E+Kr8ORKEOdA6mb+lSGnXDvELK1wN4mTiA0t7oDWeYdaL
         VLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788891488; x=1789496288;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/gIrDYrcRFL0UG1Ku9cpIdiffr0L0aeV9J+6pPKl758=;
        b=WgRmnLO37v+SoSA4DTQd3dxuECDyDbNfXqKvbFUqlEi2ed0b+S5yDOqiZsB/9QAmQs
         UmPGwWCrRYFitWmoD4FRHG/a6hLsTQjOu/26YPxnjqAbpMLzAeTwJEST1+85LYXYimhu
         nn+H5p0GuxfjDnhmvWiV67mXGVWFLnldGciSYhwLkqqiipU82vYi6fcLZBsq5Ly7Mugb
         yunzSjxqsb6F42bUcWDuuWxHS8hIbcJeHyYiVHFzPUNTBB/p2nAY9oIZysw1oR14HKxm
         F+6GnfC9MSr7T6SSZoNBEo1No0PJ8V79e6hCiyeLdeiNNitpBmBZJwHXDV22dVdxmSXx
         Je1w==
X-Gm-Message-State: AFuF++kcVIvG1TFGfJZHIPCwuJpcp8oSTyKNHTCdiQBnXh7QFRv/yjd0
	ZF9J3fgUSdmlfrzd/q/UA/IgMovcwEayCI9XSGnpxv1nuECaAKEbv/qWUZzur2mErSWgdUo7ARC
	Pydqd1iG1WA==
X-Gm-Gg: AYBFou08V7fHJHBfHY9oAs/PqFF6Bv0NEP02/64uraUoDJVHOUUOK1Xccfe5SW9DqkZ
	sWjd4/wbmPYuJ5hDHy4WBeWpYoqY35OImI08/8SdS5faLNZROE4jGRAZp5/AW8eNU+5HDTBbWDi
	/2FIxQx0FOAKfJrVFZN0d5wC7h8jGn4xxPS0PMeoVdvtKxI+1LvV8eHDkwSFJ+mPGNUnRSZXEwX
	0tWyKGLOt/cK10womw2Mcj4h30K0J0zZpU7ZRb9E9RD/29AwcD6EhDxY6LzrM+E5BaO5DCbIkij
	oShn9k+bx8cGX9PuUgJUlyBqNNDOnq9NTLkAkzvHx75ozKBuBaCOjXth0Dqjxs6NHfgd01BEqGy
	+l3sXsH2z1X6SgTR8j9McShcL2KX27oqprtIZkPRI70pxN+2y84aGb/mZR0IqO2jLQqv1HpWfFP
	zGwbLEE97kDjMT4L7G3066VKLXvCwgLoNqbxcz3OVZWXpwTxOUDuG8B37rMtdecVpSDANb3VhtU
	oyZMDNiQhUPGYmirrYppPlI+ri63aGKtiym46GQtEr4zyaX
X-Received: by 2002:a17:907:d01:b0:c26:19de:913a with SMTP id a640c23a62f3a-c2619dea224mr1018894566b.45.1788891487697;
        Tue, 08 Sep 2026 11:18:07 -0700 (PDT)
Received: from smtpclient.apple (80.49.147.201.ipv4.supernova.orange.pl. [80.49.147.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4aa01dsm657092066b.15.2026.09.08.11.18.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2026 11:18:07 -0700 (PDT)
From: Norbert Szetei <norbert@doyensec.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net] net: clear stale traffic class mappings when num_tc
 shrinks
Message-Id: <16E3A318-5532-4B5E-8D03-86D21B463A2D@doyensec.com>
Date: Tue, 8 Sep 2026 20:17:54 +0200
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Kees Cook <kees@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 linux-kernel@vger.kernel.org
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)

Only the entries below dev->num_tc are valid in dev->tc_to_txq[], and
dev->prio_tc_map[] may only name classes below it. netdev_set_num_tc()
lowers dev->num_tc without touching either array.

netdev_txq_to_tc() walks all TC_MAX_QUEUE slots and
netdev_get_prio_tc_map() returns the entry as it stands, so a leftover
entry is handed out as a traffic class >=3D dev->num_tc. Taking that
class from netdev_txq_to_tc(), __netif_set_xps_queue() rejects only a
negative one and indexes an XPS map sized for dev->num_tc classes:

	tci =3D j * num_tc + tc;
	RCU_INIT_POINTER(new_dev_maps->attr_map[tci], map);

Any caller that lowers num_tc leaves such entries behind, and
mqprio_destroy() tears down with netdev_set_num_tc(dev, 0) rather than
netdev_reset_tc(). After mqprio with 8 classes then 1, tc_to_txq[1..7]
still describe txq 1..7. The splat is from an XPS write to txq 2:

  BUG: KASAN: slab-out-of-bounds in __netif_set_xps_queue+0x1eb9/0x2440
  Write of size 8 at addr ffff888110e978d8 by task xps_oob/573
   __netif_set_xps_queue+0x1eb9/0x2440
   xps_rxqs_store+0x24d/0x360
   netdev_queue_attr_store+0x61/0x90
  Allocated by task 573:
   __kmalloc_noprof+0x246/0x6c0
   __netif_set_xps_queue+0x8ca/0x2440
  The buggy address is located 0 bytes to the right of
   allocated 88-byte region [ffff888110e97880, ffff888110e978d8)

Clear the entries the new num_tc no longer covers, before publishing
num_tc so that a lockless reader cannot observe the new num_tc together
with the old mappings. For num_tc =3D=3D 0 this leaves the same state as
netdev_reset_tc().

Fixes: 184c449f91fe ("net: Add support for XPS with QoS via traffic =
classes")
Assisted-by: LLM
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
---
A follow-up for net-next can factor this into a helper shared with
netdev_reset_tc() and netdev_unbind_sb_channel().

I can share the reproducer on request.

 net/core/dev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index ecfbd72..e63e36a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3145,6 +3145,8 @@ EXPORT_SYMBOL(netdev_set_tc_queue);
=20
 int netdev_set_num_tc(struct net_device *dev, u8 num_tc)
 {
+	int i;
+
 	if (num_tc > TC_MAX_QUEUE)
 		return -EINVAL;
=20
@@ -3153,6 +3155,14 @@ int netdev_set_num_tc(struct net_device *dev, u8 =
num_tc)
 #endif
 	netdev_unbind_all_sb_channels(dev);
=20
+	/* Drop the mappings the new num_tc no longer covers. */
+	for (i =3D num_tc; i < TC_MAX_QUEUE; i++)
+		WRITE_ONCE(dev->tc_to_txq[i].combined, 0);
+	for (i =3D 0; i <=3D TC_BITMASK; i++) {
+		if (READ_ONCE(dev->prio_tc_map[i]) >=3D num_tc)
+			WRITE_ONCE(dev->prio_tc_map[i], 0);
+	}
+
 	WRITE_ONCE(dev->num_tc, num_tc);
 	return 0;
 }
--=20
2.55.0

