Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925014CDA2D
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789555682; cv=none; b=WIOwc6zHdrTzisT1b3Zr6t04RftlJtBY6YS8+CpykK0gWd6d6KRRNtE5p+KtGPGZYAxxpckZMrk8rxsROU67MNpwxqx4SCqlIHGY+/ynt0Id7L+pgO/lvzcTvtxsYfgEoqWLS9MqFJlXGipnQRYGl1FJFLyweff+lqHda8Rg4u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789555682; c=relaxed/simple;
	bh=8rRsPxSQTZuejfKfGh5V7gdvHB8gPJ5bA8QxQ6PHyrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lC9TsNVoVc2PX94eWRhHfPIdstE2FPaAGSppl8HGtpbzF+mk0B7LdYogoAA3bACtpEP18BGw6vy2A7ONAuCwuopqNP8YvpS3o84PGWC+NFpspqFWAzzel420L5/TwxWRkuA07LUxFfDzcZaZ7MMqpBhW4Ciyr3Loe1s0SMIwe7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oN/Hkid+; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oN/Hkid+"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f70553dso134573566b.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789555656; x=1790160456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rwn7/4yNI8MQk5jOJo0Kb8T34GrjmQfELgdUaLlOc+w=;
        b=oN/Hkid+xXAfg0U/eX2OSnCI1JOnGfS8PR6oMd2IpHOncXGAJ3w8ocCoQApasNvx0c
         OP8X7lbAXqabb0qP/o+cXzZuTJ6+11t/Ai2+r65LCOXA43V5dq+omb0C0HOio/eAJY2d
         jm26Q5+4kNnceAO0Zjk6rdgv5YFjoO09AyUFdhMNSmt975bl6pSF5A+QRtm50JvAxN9l
         RzQAo4AIY+dADDK20ChneMpZhK7LjIK2sLbugRBOmVmC43cpCej8Y96V6SsQ1JmwLQLh
         BgxzhGveUODAsBitejVAvH98jF07iTItob9hPyCiPMjCwHeyaep5XjQxXGNrwJDPiA2a
         AzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789555656; x=1790160456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rwn7/4yNI8MQk5jOJo0Kb8T34GrjmQfELgdUaLlOc+w=;
        b=au/C4j1F3Z9EzxUKG7YuLkwmmVK5rf3K5ZVh0TNUElfxodMaNeeOIfHdkUJU9s9z36
         Q7I105CHCuikpdSc3zKm5ocjBqTCi68/2D1gnmelKjtaIP49fwLbfH1A0GvfJfdRd5aO
         d/SrZVNziuGy7ZhSHOgm3noZmVrRZbIlvuYuFzcMSQS0GqXr/BW+NopM1RW17aKb4nXS
         XT11+Fqhrql2qogc30LRF3UT7Wl89OIFjGMw0/sMYEq5U6f2zRPkWzEdUJy/VaVqv/El
         smkv9ayIoL3Y2Ryg44wUTfv9ffiFSmtarlXiqqommDmXbyc/AH4DpanEJInzvEbNLGU1
         GPfg==
X-Forwarded-Encrypted: i=1; AKwUvByM8G0zxjwJfWQ6Ucn18AyEWwJEK0Xaz0A14qtqdwjzcaArNsW8KmXEWW4TpB3LomK5/6lBlec=@vger.kernel.org
X-Gm-Message-State: AFuF++nEFskxEP4SXc4M2xrTzBRCHJcNzeKn7Z/YASymTGsAH8q+Ru4R
	bJNnqej8ikilMy689cL69L11Og/3EtO11x5IeCsYPcX6stJY/kyBAgd/
X-Gm-Gg: AYBFou22Ah1qX5NIyiOZpPyVW0Sgxvr/TLBx95Qx8o+vtzh0+fVigPRewdSuL7fIshI
	g4RcGN3chCgXZVq7pYvP8veqBXihiSwuaOMrpuI4DCp9CTDrMD0B6K2bxoty6BYLpjRQEKhas7d
	NcLrD+YdD28EIHKhHg+HNANnJgQr115MWrFrQkDk4UeNpt0YKIdKdZg82ViGw0wDEH3Gk9tliXE
	BddOKvZdWiz9ilXB+b+oFtCJlXq9AMJ00CkwqgdGJjShfP1aldAY2Civ11++3Wv1eu+dIypDyR6
	92Gy4U8iaOiIOlICaZ9mA5za9iWm1KNdIrb8JgQn6pY+WGTUYZUgy8vRKyck7zM0JGhv2eoN4F2
	gymqWu8gfSh5zqYzeb3HJyRwuxZu+FvW67aBbhO5q0l3DNiJQ67RqsNPkpAqBSa/yhjuOZR1yh8
	RNr83FD+jW8jKCzlUCocqfQ3FCL/33/k89yIjhTUyIWEfK/SdlUon60i3kFwNAdxRL8ZMXr2lla
	6fnt4Hlb2sdUAvi0JodvkXYLRWr50IoMbw45zS0917hkGHOZ56q3Ls5
X-Received: by 2002:a17:907:c49a:b0:c29:4b56:5a7e with SMTP id a640c23a62f3a-c29e52c8427mr123594066b.31.1789555656096;
        Wed, 16 Sep 2026 03:47:36 -0700 (PDT)
Received: from BERSOARE-M-K4D5.cisco.com ([2603:5004:20a0:100c:994b:30b9:46d9:46de])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de0851ebsm108520266b.4.2026.09.16.03.47.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Sep 2026 03:47:35 -0700 (PDT)
From: Bernardo Soares <bsoares.it@gmail.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	Vlad Buslov <vladbu@nvidia.com>,
	Bernardo Soares <bsoares.it@gmail.com>
Subject: [PATCH net v3 2/2] net/mlx5: Bridge, don't fail unlink of untracked/unsupported peer ports
Date: Wed, 16 Sep 2026 11:46:54 +0100
Message-ID: <20260916104654.31901-3-bsoares.it@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260916104654.31901-1-bsoares.it@gmail.com>
References: <20260916104654.31901-1-bsoares.it@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx5_esw_bridge_vport_unlink() returns -EINVAL when the port isn't
tracked by this instance's br_offloads, which is reachable in two
legitimate cases: a duplicate NETDEV_CHANGEUPPER unlink for a port
already cleaned up, or a peer-port unlink for a vport whose link was
never created because peer_link() skipped it. Return 0 instead in
both cases, and give mlx5_esw_bridge_vport_peer_unlink() the same
merged_eswitch capability guard peer_link() already has.

This also matters beyond the -EINVAL itself:
mlx5_esw_bridge_switchdev_port_event() runs on the per-netns
netdev_chain, and notifier_from_errno(-EINVAL) sets NOTIFY_STOP_MASK,
which call_netdevice_notifiers_info() checks to stop calling further
listeners on that chain - so the old -EINVAL silently dropped the
event for any listener registered later on the same chain, even
though none of it was visible to user space since
__netdev_upper_dev_unlink() discards the return value.

Fixes: c358ea1741bc ("net/mlx5: Bridge, allow merged eswitch connectivity")
Signed-off-by: Bernardo Soares <bsoares.it@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
index ac90ccda1272..b4cf3c5ac0dd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
@@ -1649,10 +1649,8 @@ int mlx5_esw_bridge_vport_unlink(struct net_device *br_netdev, u16 vport_num,
 	int err;
 
 	port = mlx5_esw_bridge_port_lookup(vport_num, esw_owner_vhca_id, br_offloads);
-	if (!port) {
-		NL_SET_ERR_MSG_MOD(extack, "Port is not attached to any bridge");
-		return -EINVAL;
-	}
+	if (!port)
+		return 0;
 	if (port->bridge->ifindex != br_netdev->ifindex) {
 		NL_SET_ERR_MSG_MOD(extack, "Port is attached to another bridge");
 		return -EINVAL;
@@ -1682,6 +1680,9 @@ int mlx5_esw_bridge_vport_peer_unlink(struct net_device *br_netdev, u16 vport_nu
 				      struct mlx5_esw_bridge_offloads *br_offloads,
 				      struct netlink_ext_ack *extack)
 {
+	if (!MLX5_CAP_ESW(br_offloads->esw->dev, merged_eswitch))
+		return 0;
+
 	return mlx5_esw_bridge_vport_unlink(br_netdev, vport_num, esw_owner_vhca_id, br_offloads,
 					    extack);
 }
-- 
2.43.0

