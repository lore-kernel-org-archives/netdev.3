Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793319803;
	b=RWaM2vRx3kLGFrcR7nne0Dp9jf/HEv5sDx+9wXRFSwK0NS+7fbqye2SGJGRkTaiHNBP6
	 zSEynzt8ssFBVNpUcOP/5w/1wfrg0w5zbDDlV71Bgqr8MiegZLQSxZYOfjvMooQnrUVPE
	 7SPVmlhabIfB9HorL4ZM+tzzWzvqD/kpO75FL9SWg4pIzo4KUAn8KxguMqPZ0+R3RD87r
	 /2vibz0uBRLdMlOWWlLYsumOtjQ2eJT93ZE/gD65RkAuUzMwRQTu6wXbu6mw5VrorxSAl
	 j8K16Rh8i0wTVSycn+VDNjz69DQhdoYbNTbMMk0qGQAOJBaRpT1PI4m3cNP5qYHvXwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793319803;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+NfimRk2GYnku3/wifGqwhcMFbQKhofA3PCyZ8KRFLg=;
	b=y+h1/i8/M5mf8DSEvHlNGqPFJybuyi+n0lG8OS+QupfEpwYZnzqNUz/N5jixfk8/N+IB
	 miw1QGsrenSKGtIr+yTRCuOC3IpcXwmZOaj87Fvgp5Vt0qGti8QXXI2mvxVGKEf/8ChRg
	 BFsyQ9cv7Q0BDjsaBQjCtKAgkqELra3vk5Aqbvj99uSB0SbSdCnBJIEwXOQhfwM1JI6+W
	 rJKJVY98QjeA+TSMofBS2GMyi1gXkG+I/Uu0t2VMZ64CHfRmPm7hzgvPt2jVHpFzfOBFI
	 IJs2pp37i0tudNOP1D8EaXARPx4s4GClJ8B6V2mEL/h3xHh8Oj8cgiMX6whrz0whNCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ypsC157I;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33D606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 00:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C33D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ypsC157I
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e20edd106so124521f8f.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 17:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793319801; x=1793924601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+NfimRk2GYnku3/wifGqwhcMFbQKhofA3PCyZ8KRFLg=;
        b=ypsC157I+v7buErUok30TBiMODRXmt0y64VItSaKUENFC534TAfGzo2OHFZgJmXpwc
         L9kRGPgyzBwdMo/O7Idj5K2oybXz418/96NL6mvw/0f02q4KmR0ACKymwGkg0VR1sK0l
         x0wzJBDeOvbt7evJA5Odgu1gFVbJRNHXAodaadMy/gMC9F5lm+HQCUcxIi2iCXYAbq8/
         k1WnX1L2j/7cClcqb9BTvinAQRSIx8wizdwUQkL5lXW+Rlu5PwBwLPae07RnC1v77LAt
         Td7bjzE/7MQ0RZzXwLBskmvr6E+VWZiCZxQfZVtlenHW992yTqB75FefpYt1zPMJa8T5
         4ZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793319801; x=1793924601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+NfimRk2GYnku3/wifGqwhcMFbQKhofA3PCyZ8KRFLg=;
        b=Yc/mrSMCbouNKilJZMHAtT4fP7U+s5nf7ig7hsiLEBgN/8GD4QPDfv7wf49HfftFyo
         EM0i8VvJHT+RhlIglGys8u7UFqS+8I2Ycw9s5b1dgy1IfNXY6sd3gCfrZuRRDWXSD1Qw
         88lojye8VuPbeUr926PMOKNU9A3lOK+qpiZpPIYTU18odg0sUgI2Ymg35k/6ilKWwAFu
         KDpmJN+QkvPVrAKprwGfAmagOB3/yM410OQg9gnv+ON5BocQ/O7RGxH+9QeA2jvE13YS
         KbslBSKJteholvjMkH7cmHgJX8WdhVk2MK0Hz0KrqSS7NEIBdy2CBuT82ebWQ+jWXnRn
         76Vw==
X-Forwarded-Encrypted: i=1; AKwUvBwYM02IMyAgcfrNZRcxrsH/C4JARTsulA3C0S7aTW97acAVVp3iE2zTN4MIscFTyK5ME7R4jGo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpUFXaVbjIMgR/3e+ptjTfMFnyy1RDVgMYE8F+Cvh4IIPpWGRV
	T0ROOuZ1IAPh9mSBaDHLLQNTFieD79IDeSGqjz3fy84gqnZbE0su55HX
X-Gm-Gg: AYBFou3XbvDxn+CPguLBYbBJblwsh6DuOaboxWJVk/BVuD3EwKwPM2+p1sMAqzrh0kK
	DZgVFMqFKZKAHWkTthy3iCSPwG8tlLqClFPBnmRSou+NxdS2QiD2JoM7JWdimuu7g4cgzKH+UaT
	O9IcFBR1YjNV3vZ772kqt99+mv2QUqkaRUZWHBKgtZ1XaE6I0yC6/vHFGIQHIX+ev8xSXRHwH0a
	i+R8+1xa5J4fR5CrRlClXkthAOX79mjYmQ6BpKo2cPFXJVbttoWsfaMIZK8XT/HU0PUGNbdUC5j
	ZeHnxkSrz6ND3YnZtV3jsIp+QC+h2CAAtJfMnbspPtE+e0GLxDOHfPUVCRIrSsPk5b9+2ID2AZC
	hzqbjrl+9PbE0n8dfDRrSUZpLjh0np/Oe1lrHDu0wCCLhwkjtQgborp4o1/vghO+iKYfNLfPUwD
	IbF4lM3gelQFBdQi2SPpKFgGhqKU2aThFcHtUnrFmOzeE2YoY5AXIl2zlBn08JOhp6RbNnVrHdD
	RBnlmKb4rT2mnSlJqGL9/C96F/eAIY+0wFf51uX7wGpnxusvX2CproHiPbXvrz56t6RcVj3rdU7
	gYGMuRL0bYRe1VKcHjYSjgUTPyiU90+bjq2OrSDzrBhdj0mQXKOrZ3N6HfsvBI5iWxWJyk6/xqM
	R2wRTGJwmt8z43UuuOTsZTDhvUL8J1GmAShJalfUvqJwkJ+hprDRHyqGukaLn
X-Received: by 2002:a05:6000:2211:b0:48e:6419:ddf2 with SMTP id ffacd0b85a97d-48e6e2e76bcmr1859407f8f.17.1793319800920;
        Thu, 29 Oct 2026 17:23:20 -0700 (PDT)
Received: from SD.cable.virginm.net (cpc117822-heme13-2-0-cust760.9-1.cable.virginm.net. [81.111.210.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b728ddsm69596f8f.9.2026.10.29.17.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 17:23:20 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Alex Vesker <valex@mellanox.com>,
	Erez Shitrit <erezsh@mellanox.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/mlx5: IPOIB, Fix QPN lookup race
Date: Fri, 30 Oct 2026 00:22:14 +0000
Message-ID: <20261030002241.8508-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
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

mlx5i_pkey_get_netdev() reads the QPN hash table without ht_lock,
while mlx5i_pkey_del_qpn() removes entries under that lock and then
frees them.

PKEY child interfaces share the parent's RX resources, so RX lookups
can overlap child removal and access a freed entry. A lookup for
another QPN in the same bucket can also be affected.

Hold ht_lock during lookup and save node->netdev before unlocking.

Fixes: 7e7f4780c340 ("net/mlx5e: IPoIB, Use hash-table to map between QPN to child netdev")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c   | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c
index 4120afd097c3..6c24ae8e7662 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c
@@ -126,13 +126,17 @@ int mlx5i_pkey_del_qpn(struct net_device *netdev, u32 qpn)
 struct net_device *mlx5i_pkey_get_netdev(struct net_device *netdev, u32 qpn)
 {
 	struct mlx5i_priv *ipriv = netdev_priv(netdev);
+	struct mlx5i_pkey_qpn_ht *ht = ipriv->qpn_htbl;
+	struct net_device *result = NULL;
 	struct qpn_to_netdev *node;
 
-	node = mlx5i_find_qpn_to_netdev_node(ipriv->qpn_htbl->buckets, qpn);
-	if (!node)
-		return NULL;
+	spin_lock_bh(&ht->ht_lock);
+	node = mlx5i_find_qpn_to_netdev_node(ht->buckets, qpn);
+	if (node)
+		result = node->netdev;
+	spin_unlock_bh(&ht->ht_lock);
 
-	return node->netdev;
+	return result;
 }
 
 static int mlx5i_pkey_open(struct net_device *netdev);
-- 
2.43.0

