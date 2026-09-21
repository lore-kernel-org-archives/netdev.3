Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A343C4AD7F6
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003057; cv=none; b=QzRMFumzoNbu4sJCfyqeImtUDkb0qWP8LlGqCKK/SSBJXG0n6jSC5Mg+wt4kSBjodYugv0gyp3V7hBM96I+v+b3zJHJBEGNqHAchZ6Y1vwgzPnYM6WG6HuwV6qpqCrDkT6aw+ujvMOsHnKrs2gm20Tp1Rnb7D3+CJc0BVIoyuGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003057; c=relaxed/simple;
	bh=Q5DQrV6wCRd9j4ACFQtYHYxajNh14Ils+TVuZ5PXgjE=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=AwIK8K/T99xBbjDscFwxVK6Dw4epaWAfhphdgFX9JUOvLFYt4tktzAtZYhXqLtqML0/WPlmB2eTV0SsHKAtXHABRsCfTgqSz1m6RG2npVtnXDTdX5hBnX2lGsc1on91skoFpHwRzxN7dbztzjHceSqg+PDL+Td08ZSgPIjm9J1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=KfEBmNLv; arc=none smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="KfEBmNLv"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6aa053900f5so5192226a12.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1790003050; x=1790607850; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pY1Z4qUnZ6AIdG7/om3HA6RhxPz19td5vIz7lNhHWNw=;
        b=KfEBmNLvMqlPRGn5eG0fVz6DW7hE7aOXcmFyR9mqIWOmI2aT5cNRnfxjCiyJGXpJ8I
         58H4pv69kAFqu0rLDd/MB6DF8MpQD4ptBQvYB1HlhF6rhfOxMJ9GsH549QaM8ZfTJnUs
         BEVL9PBkm0VLakCtXHV0WYZt60Hqq6EEhb86Z6NfVmhx/Y2CI8ROrMLksV2JzPNNvrAC
         isEcwIXGPNuiSUwZ0QQ8Riooq1jdCNfRrpM7365pAnn/wWG9P9nwOkFLjuz6bjZKFvSZ
         /VWc0KnZUULLHOx5BHY5AH6Nc+LCq3dmKxb4b+wkuH9IArPYYON6sk9IygeApPcnzkZK
         AeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790003050; x=1790607850;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pY1Z4qUnZ6AIdG7/om3HA6RhxPz19td5vIz7lNhHWNw=;
        b=j1oHK0X2lLD6BlrdIRJm0x33wPd9UxDf2tHDBZ9IiSCHttuKSlm7WRV3d6XXzfz/I4
         iTgxQ32D7enZ5CPmpyM4ui5PYO7pXnjzWCebTZ12m6PLq+4DPwdRtLYZ/60guevq+pin
         UO3czVNw+ylkM0GyPU80xL10nHrkF3H9qBmHZYuJh1gfsMANYaUA3hoFVBuDJSRSjk/u
         WD/XCoaRXw94ro1EDqJ4ULEzua5q1S5kR2pxQwfeGe2VE/slyELuarRxdZcaa//VVzVr
         1qian7qFoF3GW83JtbrzwgfZmqX5mpkzfVhrlVi9sGDP69ozp/kKDh112ko88d6I/FtG
         gPnw==
X-Gm-Message-State: AFuF++mzVpMFNL+St8a2nndvmimaeOau/+W+uDuFeFXEfLkxVMZ0Xm7d
	c35xwGILJCSss8/1uhNrZrI056uQ7bhRZCojastWcJ/aY/Z9dM8pvKyWUBB7VhK/ffBCqhr5CZm
	UllBgpierYw==
X-Gm-Gg: AYBFou0brnQSNkmq/Bgixmp3bTsOnulZU/ePBjDFQBxyf5ly74famNhJWT+u1Yt6PRo
	lKNOgxGRY6WQQmZNXX0luIrcMz7O4YPaXgQLWHuPv/IEb33TFBMiKCxu1708Wf/dIBNyMi76aRc
	zbn33TYc1/qb8fxVAQ4vlbSwRhS3D3j5JXPHe42s3rHbJpR4FO9S5KyqOj9Amh1Wutpybh8sSKD
	+X0n7KmPs8v91IWJp11fArc9ljMXQsGKQH3pIP5IJIHVa3AcJ8aBZAOHvjFsbJMXCZy9bB5VuJP
	4bjatAwbj9rNEolf2Sr6ShCIlmxmVnriyM2yQciP0IgMJbcIttla0D4OFyfWU0J9XPnKsq3aSoP
	KJZHGtaf+NKDpDDsEIOi0dRshAm9ZoeZZugemY4tTvb/k7DNDAVuQ4q3wKmVLTEWAZr7U9usPxx
	KkYf4VlVWuyfq+DBglsIMtiJBwrx3rlMx9WYh7pgwiEvTTEnw+U1QYeSB39jrAvBp9fKgO4ZF1l
	0NHAeelN5x5Qm2WvORHCHrlWlkrUMGf9kI+YO3Xi2x0z+Y/VZ4sImxc
X-Received: by 2002:a05:6402:50d0:b0:6a9:9873:d8d7 with SMTP id 4fb4d7f45d1cf-6aa577f54aemr7967175a12.13.1790003050001;
        Mon, 21 Sep 2026 08:04:10 -0700 (PDT)
Received: from smtpclient.apple (83.10.8.214.ipv4.supernova.orange.pl. [83.10.8.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67dbaf0esm4618047a12.15.2026.09.21.08.04.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2026 08:04:09 -0700 (PDT)
From: Norbert Szetei <norbert@doyensec.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: [PATCH net v3] net: xps: reject an out of range traffic class
Message-Id: <162DD16F-54C6-444A-9E09-0B8CB3D591F2@doyensec.com>
Date: Mon, 21 Sep 2026 17:03:57 +0200
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
X-Mailer: Apple Mail (2.3864.700.51.1.1)

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

attr_map[] holds nr_ids * num_tc entries and j runs over the ids named
in the mask, so a class that is not below num_tc pushes tci past the end
of the map for the last ids and the store overruns it.

Any caller that lowers num_tc leaves such entries behind, and
mqprio_destroy() tears down with netdev_set_num_tc(dev, 0) rather than
netdev_reset_tc(). After mqprio with 8 classes then 1, tc_to_txq[1..7]
still describe txq 1..7. The splat is from an XPS write to txq 2 on a
veth with 8 rx queues: attr_map[] has 8 * 1 entries, tci =3D j + 2, and
j =3D=3D 6 stores one past the end of the 88-byte map:

  BUG: KASAN: slab-out-of-bounds in __netif_set_xps_queue =
(net/core/dev.c:2954)
  Write of size 8 at addr ffff88813016bc58 by task xps_oob/634
   __netif_set_xps_queue (net/core/dev.c:2954)
   xps_rxqs_store (net/core/net-sysfs.c:1880)
   netdev_queue_attr_store (net/core/net-sysfs.c:1390)
  Allocated by task 634:
   __kmalloc_noprof (mm/slub.c:5439)
   __netif_set_xps_queue (net/core/dev.c:2937)
  The buggy address is located 0 bytes to the right of
   allocated 88-byte region [ffff88813016bc00, ffff88813016bc58)

Reject a class the map has no room for.

Fixes: 184c449f91fe ("net: Add support for XPS with QoS via traffic =
classes")
Assisted-by: LLM
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
---
v3:
  - stack trace decoded with scripts/decode_stacktrace.sh and the =
changelog
    now says how attr_map[] is overrun (Simon Horman)
  - no code change from v2
  - v2: =
https://lore.kernel.org/netdev/CE030A45-D573-4310-8761-01431156F0D6@doyens=
ec.com/

v2:
  - bound the class in __netif_set_xps_queue() instead of clearing
    dev->tc_to_txq[]/dev->prio_tc_map[] in netdev_set_num_tc(), per the
    Sashiko review of v1
  - dropped the memory-ordering claim from the changelog
  - retitled
  - v1: =
https://lore.kernel.org/netdev/16E3A318-5532-4B5E-8D03-86D21B463A2D@doyens=
ec.com/

 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c67900354fa6..0292a16e16c2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2901,7 +2901,7 @@ int __netif_set_xps_queue(struct net_device *dev, =
const unsigned long *mask,
 		dev =3D netdev_get_tx_queue(dev, index)->sb_dev ? : dev;
=20
 		tc =3D netdev_txq_to_tc(dev, index);
-		if (tc < 0)
+		if (tc < 0 || tc >=3D num_tc)
 			return -EINVAL;
 	}
=20
--=20
2.55.0

