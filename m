Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E905224B05
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 06:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789192882; cv=none; b=NF2bO6mYq8vdmSWgLKnikTEEXWVHovSbgEOEl8uyW9OIGeq2r3D4s6R/qAdKek0O2yOocx4JfoijNAdFmh9InczOSWLtTCUQikzJKckHRbRPEyFRHNXhyDzoyY7gZkzu6QJWnsOy7gT8ZuOpTlj3MrRQNqWNjA/EDZxPJjPQiOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789192882; c=relaxed/simple;
	bh=+mh6hCRv3jV8lG1bYtqlCdPgplm2V3taMDxvZ/qC59Q=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=R6vEd0ZV2gdn7s283EyHMrD2OOUfIhW71l5Pk8tdQDFkK1BwjU8BB9ASG2bJHY8ZT9Kz+OsHADQ9ew1G2gs1tztdwrrp4Tbmmik7u7qJrWflXi29WFppCoBfMYfD4c7/H/SLvxi0j/zTkgBZJ5U39wW6YLV15UFHKp9ANzmo+IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=SPCMFHJA; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="SPCMFHJA"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a99cd5115bso411422a12.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 23:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1789192879; x=1789797679; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jzx6evAcXzYbgCcZylnkVlQvDEuLCz2zM++yE3ascC8=;
        b=SPCMFHJALDbdLoYctOIPOlG7qcxpvOEO+fuR2h5XQlk36FcZMqPqYagrKgrbn0Mc9w
         LuVJGv9OTiKHOchMINpKzTyOuxQWZ5TGvNrzjVprIDUeclQCYAA3Wt7VTmliU/bNkfTA
         mqYYnNbEsTf8EuY/iyqxP0wRyWq7pmmjtcEA9o5g4Jpjfrk3eu7NaRQKFQBmwhcTmVWz
         PBoj9i002FLybpf2gipacNoT5f5YKA0AZCwpzydYrAUEXzco56rK+2BtVYOkPCGlKGZy
         XNXP366CpHUx1pYP6uT5cpwnPzd9rRDwPBqyUgFf6Agfu8Mk1LVF+vIxsvXC+hkBId4E
         8FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789192879; x=1789797679;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jzx6evAcXzYbgCcZylnkVlQvDEuLCz2zM++yE3ascC8=;
        b=RThG5m2k/0SZ4imPLV9VfuvMHMQ8CNKlob7w9sD/lXnw8VD3c9a6f0zd6bZuJ9uq7e
         LRtoyJ/fyVSvfdJsB8RFd3Pzu+7iFwgHSj9/6nu3Yb9OnLBHtuRrN2Yd58u2j1DJbAFm
         yDLczoKAwlxNzeLmG9ADV5waAdt2jA3957UO9QJU34HIExysnNUBE1PL6wK9VNFikusP
         q5BLjMM73erQsSi+fR6amS6GcnclDEdGlGV6oh/+HsJo50rlxXNsLr/In4YyNtBn7JL5
         LFQ7R1Qii3VoEC6vIbOAzu3zpWGKkzmhzBpZVB9wAHvkhXRfh7ttN9h6O0QJfk2n06pC
         AajA==
X-Gm-Message-State: AFuF++nYW2g3GCPqfg3HR7bY5M2OMvgpBR5fnLGY2c/jLVvXLhvItLAI
	Xb4y5Cpv4TpHeJlIWBuVp8YWuj4AY2xG3pKGPFUvg36TOWpIJyr6FrZ20/A3gly7o4cbkgNLkDY
	cE1iiMcUeXA==
X-Gm-Gg: AYBFou3FAVpBbE2BHFVnPKRsRpGygNkW+keY72sx4ftxkyxbfA6ewgZYmrYmKW7nwzY
	blsoZxLmikyiHy3lES45UPWvQ1KsQzFaau+V9MFkL4+itBT/l3flJ/7+6MoLwSf8/UKBN6TXYvq
	FV6G97pe8WNvEpnnqtMI403XWyB/nz8SbijCfgL99mi1otaAWpHpj3tzFzuqy+QM1OuA0RL9M0G
	y5JDp4jIcfPjELXTK76AmCcTH/o0bOPBHSAh2eN7MMVUvGsH2NREzA05rx29TKZFiIjTnxzSwe8
	vXnv6O9APaHOBNWh6g63IrfLJ4vcc7ex1ubmlSisi3IVHmrWQP+Bg95lPTeWbXg+rz1Zod95mXj
	j6EJuxxkIwvA05TY2ouk0RG8BQJYSN1+WeDQQmUAPjm9cdiNmXhYYxZKChHknZv1gZcg+X2pDNk
	bc8gJw+QqXLElww4aG4OE3Q1jtq2+VqoUNMa3tAgnjr6B6sMoOqhyi4qb31V6EQfx0sSNm+Dm54
	4qqinVkv18GgsnALCVuXFtDpc344lphjoCj95Ot5QCn0hU+jtb+LKs4o//7euc=
X-Received: by 2002:a17:907:94c6:b0:c15:f598:60c0 with SMTP id a640c23a62f3a-c2985700099mr87558266b.4.1789192878508;
        Fri, 11 Sep 2026 23:01:18 -0700 (PDT)
Received: from smtpclient.apple (80.49.147.201.ipv4.supernova.orange.pl. [80.49.147.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2966066b6asm156002966b.34.2026.09.11.23.01.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2026 23:01:17 -0700 (PDT)
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
Subject: [PATCH net v2] net: xps: reject an out of range traffic class
Message-Id: <CE030A45-D573-4310-8761-01431156F0D6@doyensec.com>
Date: Sat, 12 Sep 2026 08:01:06 +0200
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

Reject a class the map has no room for.

Fixes: 184c449f91fe ("net: Add support for XPS with QoS via traffic =
classes")
Assisted-by: LLM
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
---
v2:
  - bound the class in __netif_set_xps_queue() instead of clearing
    dev->tc_to_txq[]/dev->prio_tc_map[] in netdev_set_num_tc(), per the
    Sashiko review of v1
  - dropped the memory-ordering claim from the changelog
  - retitled
v1: =
https://lore.kernel.org/netdev/16E3A318-5532-4B5E-8D03-86D21B463A2D@doyens=
ec.com/

 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ecfbd72d5d1a..7e76860602e2 100644
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

