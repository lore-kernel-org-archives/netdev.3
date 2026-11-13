Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794542608;
	b=CQR7K0ea80B5dCM+9ehPAVmeBTdDhl83QMVLK5vBr5DW3v/7o9AK7y4eG7zvTR1KCAe5
	 oAtT5c6gkmontAkHlUN2kUkKFv3OuhWeMofE5lJ44PW7jhgIA5S8hfBvBODDPYFuE1AZ8
	 am4Z1hKDILrB7FTH6CaHqAS6n09uWV1HzOwoEH8UyvTd89aRfFg7T71vuPK88NfdFo5Be
	 RValNAhhmPxfWj4wQuOzx7rQKtZKPBHO2utRekpYyjSW/Hc9H8N6/QH6TMo3RA+JGMUrm
	 QOOhGkkAOz6SiUfTy2wOlajYDq0yk/vckqBlFGQdRCXj8nFB0z8L1HwEKAA3KGtjl7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794542608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h3VfCHvLvqBO4sImZGoV5l6BeIrK2r9kHf+KVVKvjY8=;
	b=ebWQ81AP8IacYs5ORpHT3VM9Cuxxn1DGq/gqxEZIbXfp5krThJZKmtTO5PiH5RuGNiBR
	 OUuRA6ihqicZkk8qMoR6XPgAmyQ+q3qSSOO7GpKeEr6fMemZAbUsIGD82S/wt4lCcxYd2
	 k7Dyy9ExiMdSZ5YIpVb2z4gs5fBynECJqfrzUAlfynpGwOr4HoqGdeWfRDkjARiOaKaqk
	 /U11JQYG+qdc0ZFrrTq2d19qSO22dbBS09PA2cpsE11wJtP1feK15XB3mBrUFcD1leHFB
	 R5We9RLX2o1Fr0VTrGX+vvQMABhFiXW4X8X5gpSydbQ2LwNhBwBwvRa+5Z2cWqP+/Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vHwZtRru;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2E5606A31C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 04:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A2E5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vHwZtRru
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91befbcad6dso10813716d6.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794542607; x=1795147407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h3VfCHvLvqBO4sImZGoV5l6BeIrK2r9kHf+KVVKvjY8=;
        b=vHwZtRruk+RPcP4KnyJvGie743X+cb87JYRyMRIztxJcSvzuMGOg2/QY+mafApaTKY
         WZGKPjjzdXPJ6L8lamwekoV/8UeypJJtGuzE3HKrUSNgpZEYOPqL+zhOxQuo3ihjpIvF
         CDgcnEf4pWI1kXbDbUkwLfbFB14yAGtXx2LYcHTK2HtcnYvkBI8fqev/iKw+F8noMYTx
         oOWuym4pWtANXjlM37wyRJ98J3uuRRJ0/eCqrKgDEXt5tPgMgpYyi6Pw0nRkrgNN4DQb
         v2FVbTAEgF/RLYmTxDAsUV72yuxQbZj7Xen9gafXdKTXG1J7HG7OziCMfo6M6s0fbKHq
         y82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794542607; x=1795147407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h3VfCHvLvqBO4sImZGoV5l6BeIrK2r9kHf+KVVKvjY8=;
        b=ksCa6M23n/ShcKYeBxfy8UVIdzQmNg9cQ6W8P8d+RLzmlrHzlBcCqgRHKj++1Y3I5g
         CxJCOB7xJhTCEjfAQMSFmonBjhLRJxf++/mGkuQwB8xGURjPChCyTwY0V1Bs27DlXzTz
         OedE2ljWQvJUP29j0fGaK6AyLVwCl94d9OMaROiIxSsrABVJxPI/vL2tZOSyhf0GZ3W7
         wfisli+Ind4Q6XGSkPN0/4UARCeGQccR3vkP0jqgm50ppc6Xq1yIGE4NwQOAtdqlHT1V
         T4+QHewgpjM5n+VSEpy5b/KTpB28E3cCuu10wmNgbatrRnNfwcLd4qcB1McKiTyksILJ
         +9mQ==
X-Forwarded-Encrypted: i=1; AL+hErHC41QTC9lSdSlQ7wqibscCu+l9xnpjnnRxubQybKNFLZhasi0xXJkplIVGvfo9ws9cezoqHcU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9P3QD+G9NIYisEYB/Fq3KTAxjc9ukquN4JjDMcSPyELoe23abE
	mVJBPqIkzvJEAEBlQ8ZndGhbkDzavHDLkorVELaUJPuAtBOoW6OWNJ3F
X-Gm-Gg: AYBFou12YU1WqKp+M/N8/atuYumHzSxR0IThZrArpMnXazCA/xVuULRiIme2GKtKr3C
	XQuh4uAUXsL3+2FXORKRggTwviCI5Pm8b0pB/9Qux/OHIGXxsDthdts8xwK2KJcn/WugUHklo6/
	PYs1/r8tYKEj/4DBSXTH7b7H3Q0kroX8SzChlBcvVCa7+51uxAxYe3MhXmPpKaysqq3iWcn1dKa
	n60c5xLDjzj0arjFXav9w26viSrEPzpxJR58rUunen8R4A/5CYEb8iPVGxjGQ9eqyVWkRPIxRB7
	2jrjnDdYkENmBuLEvboK+QdoHzrB+Ml3rPzY2nqRpMhXH6vCwuGZHQzjEE0heDNKrJq7fxZQ107
	05BmKGy27gvDf3ozCGkHsJ3mqHLPg/2oAnImcMdS9+hLETrBxkqWXJQp6c3cBbOaR5d+OuSp47Q
	XrVy3XF0NJA0qqFs945CR6f9LDhubvX27ocE1QhvNcFz4hu1m3LFiN6DhawBuQWP/NRdShy+/uK
	BD2maT5CPJ3FWVtbL1CleKGhtmYcXrqt6wM9Qj+PUmOaFrNSA7LI1kanCggWe1EcMr0gXtXQlHP
	qdZPby/5E9qKGkwzF2cRKZxD364+lPBSeCL7BxUxpKDHLFAPpybuUnPvoM4rl6E5ex0mHMR3OGZ
	uvUQGZFQuzJfgbtdpadq4
X-Received: by 2002:a05:6214:850d:10b0:91c:60e8:a8ab with SMTP id 6a1803df08f44-91f241f6b64mr16509716d6.37.1794542607209;
        Thu, 12 Nov 2026 20:03:27 -0800 (PST)
Received: from linux.. ([8.34.174.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db49c5sm11193506d6.41.2026.11.12.20.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 20:03:26 -0800 (PST)
From: Changyul Lee <lcy8047@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Aya Levin <ayal@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH net] net/mlx5e: Hold sync_lock while resetting VXLAN ports
Date: Thu, 12 Nov 2026 23:03:23 -0500
Message-ID: <20261113040323.2090829-1-lcy8047@gmail.com>
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

mlx5_vxlan_reset_to_default() walks vxlan->htable without sync_lock
and calls mlx5_vxlan_del_port() for each user port. mlx5e_nic_disable()
and mlx5e_uplink_rep_disable() call it after rtnl_unlock(), so the
udp_tunnel_nic work can run mlx5e_vxlan_unset_port() at the same time.
If that removes and frees the entry saved as the next one in
hash_for_each_safe(), the walk then reads freed memory.

Hold sync_lock over the whole walk, and add __mlx5_vxlan_del_port() for
callers that already hold it.

Fixes: c5eb51adf06b ("net/mlx5e: Fix VXLAN synchronization after function reload")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---
Found with a static analysis tool we are developing.

Compile-tested only, with x86_64_defconfig plus MLX5_CORE_EN and W=1.

 .../ethernet/mellanox/mlx5/core/lib/vxlan.c   | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/vxlan.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/vxlan.c
index c2292cab4592..b953bbc4925c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/vxlan.c
@@ -121,25 +121,29 @@ int mlx5_vxlan_add_port(struct mlx5_vxlan *vxlan, u16 port)
 	return 0;
 }
 
-int mlx5_vxlan_del_port(struct mlx5_vxlan *vxlan, u16 port)
+static int __mlx5_vxlan_del_port(struct mlx5_vxlan *vxlan, u16 port)
 {
 	struct mlx5_vxlan_port *vxlanp;
-	int ret = 0;
 
-	mutex_lock(&vxlan->sync_lock);
+	lockdep_assert_held(&vxlan->sync_lock);
 
 	vxlanp = vxlan_lookup_port(vxlan, port);
-	if (WARN_ON(!vxlanp)) {
-		ret = -ENOENT;
-		goto out_unlock;
-	}
+	if (WARN_ON(!vxlanp))
+		return -ENOENT;
 
 	hash_del_rcu(&vxlanp->hlist);
 	synchronize_rcu();
 	mlx5_vxlan_core_del_port_cmd(vxlan->mdev, port);
 	kfree(vxlanp);
+	return 0;
+}
+
+int mlx5_vxlan_del_port(struct mlx5_vxlan *vxlan, u16 port)
+{
+	int ret;
 
-out_unlock:
+	mutex_lock(&vxlan->sync_lock);
+	ret = __mlx5_vxlan_del_port(vxlan, port);
 	mutex_unlock(&vxlan->sync_lock);
 	return ret;
 }
@@ -185,12 +189,14 @@ void mlx5_vxlan_reset_to_default(struct mlx5_vxlan *vxlan)
 	if (!mlx5_vxlan_allowed(vxlan))
 		return;
 
+	mutex_lock(&vxlan->sync_lock);
 	hash_for_each_safe(vxlan->htable, bkt, tmp, vxlanp, hlist) {
 		/* Don't delete default UDP port added by the HW.
 		 * Remove only user configured ports
 		 */
 		if (vxlanp->udp_port == IANA_VXLAN_UDP_PORT)
 			continue;
-		mlx5_vxlan_del_port(vxlan, vxlanp->udp_port);
+		__mlx5_vxlan_del_port(vxlan, vxlanp->udp_port);
 	}
+	mutex_unlock(&vxlan->sync_lock);
 }

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.43.0

