Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED843F08F
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725599; cv=none; b=l2m6nBvNMFn6JbOI55u+Or/V2E1zYvbxyPcuOCRt+FflFfWi7ArMHUsxDazu44BAfBLd08CSEfRG0TQ0F/RSaSIIdvrhCG/+zp58FLB+QaCpjm9i2ls9qNBAXl9LAv9HdqJ4N9IFwZm5tVuB3o9ThQCKP7+WhjtR0skD90gk9T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725599; c=relaxed/simple;
	bh=Ah+HpZKfJRLcEAV9WsvdW3BhbyK36TwEm+aAqaUEp1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h32TgZU8whQGahQQ5vCBoOrl/HQpd2jf/yle2HmIi4xDsif+EERGZ0kW+o+NXsKWkjoQ/1+zLwV5+hkitUdMMNIZn1C6RfOVLZ+/KXym2hxRXVuPceE2aW1iwC6GrXqAPDaz6Qi8RXE6O5pZTouw1PjVFI0hfS70PWUUQ4EO/xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4SdalIs; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4SdalIs"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c264788fd58so78666766b.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 02:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789725592; x=1790330392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mYKndkjI/RjT1U+TjeldxMYaMxagatd1Lyv0wl6mHW8=;
        b=O4SdalIsKHKtn2vaesfxWuiGOtQ5IM1+QJV8Yljidx2qs1mtcUUfrZTDJ6cP0HrRYS
         stlBF7uqeATcS4bJ2grO6gvAap5BBXBoOBOzIf6vY4SKsuUlmHfVnXh8WQG6wUeXJAu2
         x2aNvPDJPDuQ8vzi/WIUbRu6EfIncls/L88iHaYD9zBQmoxWd2ej/i/g5928+Joy13Ze
         iIng2zERHK2R4amY80+esh3Rh/gn7e1cTbTiM5/GH9PVx4pl7GGncd41c4htOtLXRu1S
         McLC9xnYAy2NmHQD4TtPM7iFHL579cnBqYbvlDjUDqeFidqQ1Jzky4JiQ5MKIyqT0Xt8
         tfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789725592; x=1790330392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mYKndkjI/RjT1U+TjeldxMYaMxagatd1Lyv0wl6mHW8=;
        b=z9jyN1Tzd11sruDmrgBIE1zSskCMBfLYihgjxDdPCNM8yCO8IjrJO9Cnox+hhgkhOr
         Z36iuZTG1oV4TlfedX9UfHc5VRwvoHcPdWkEmYxRX3WH0RMEDI+Pm8/Bq2VysqxmADe7
         6mLNZ4ycTfbKg5V9GATMyTH19YJPIJZSiepoBRsKQz5H8M3Dr5ow6RAi/eWKkJClhMMF
         SB1aFt3u9oG3DmL44ma90gt+j7BDYh/7IAfZVRdSduTQkfutG/CD4CZ2MzQ9VvmcLfi/
         Pj2EdP36uidQE800nC1JRnPQr4XVQ9gEio/CeRYr93gbFEBp0v+lJS5MNfaOUJYODYB5
         hYxA==
X-Forwarded-Encrypted: i=1; AKwUvBwdPqyQBbS3MnpeH3FYaTxoFgn0XmPu30Fs10V6n6VRoMvz9OF6H7V75xPsLH3Xnbc+zwZJkw0=@vger.kernel.org
X-Gm-Message-State: AFuF++neYl1mm8h3jCUbCyRTymjqjXVn9Wczs34b0kvx3n7ddXnyxEJd
	X6iBOLdo7mdk9gw50L4juNXCr9GSOm/h+SijRhtX6Qys+aF1WTR9YXTZ
X-Gm-Gg: AYBFou2e1fBnoS+vHeUuUttUJCDGynetWOcuvbIhBuFhWdfHQkndQXVf3wTagm/OdwL
	zSPEhtvjuHEFyyZyVcc0RO1w1gC1UqCJDNghUZDCCKhb6holzDLFKNZ8tZ9h0EoJup+kxEva81e
	/Ka+3PqlGNzHE+0+zFBt/lrxPuUnkE1VqQGy6CS6WfXj/saruar4xanaV6xkvMqn1R+a+/ofOaf
	7shxkf5mNDwFe8bHhxCrV+2jFq3utrMnfq5d8TLileijjMy6f8Pp1AOL+ywpqz6FJtkjTBfz4Aw
	sjWFsB/zmQnalh+oS7auEyMKkKscL/TWVJJ6/vF1iSaf+uUEwDTsHbjrSv2g8RseFZUAcwTR4vF
	mXI3oPhv6zm7NZOa2Fp8mDgVkGdrsuzG8/BlRtl0y5fQ2mWAbWAgKpvqpcbrWJ02DSceet3Fpep
	+7xQEdbY6l8tPjCFAiQZkEo5AdcBRmKc3E1qco2D30rvYk1pJNufYo9jF2oD/hkqDeWkW9b71z8
	qsUjRFMJDqlGeasWCzZEgxp/2hXjkppdfhEp33JNdri1eL1muVoWNUu
X-Received: by 2002:a17:907:7286:b0:c25:c954:faf2 with SMTP id a640c23a62f3a-c2a159ae00cmr198378466b.21.1789725592083;
        Fri, 18 Sep 2026 02:59:52 -0700 (PDT)
Received: from BERSOARE-M-K4D5.cisco.com ([2603:5004:20a0:100a:561b:120d:754d:a140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a1bbc6a99sm38313166b.59.2026.09.18.02.59.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 18 Sep 2026 02:59:51 -0700 (PDT)
From: Bernardo Soares <bsoares.it@gmail.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	Vlad Buslov <vladbu@nvidia.com>,
	Bernardo Soares <bsoares.it@gmail.com>
Subject: [PATCH net v4 2/2] net/mlx5: Bridge, don't fail unlink of untracked/unsupported peer ports
Date: Fri, 18 Sep 2026 10:59:31 +0100
Message-ID: <20260918095931.29792-3-bsoares.it@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260918095931.29792-1-bsoares.it@gmail.com>
References: <20260918095931.29792-1-bsoares.it@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx5_esw_bridge_vport_unlink() returns -EINVAL when the port isn't
tracked by this instance's br_offloads. This is reachable on a sibling
instance that registered its notifier after the port was already
enslaved: it never saw the NETDEV_CHANGEUPPER link event, so
peer_link() never created a peer port for it, but it does see the
later unlink event and fails. Return 0 instead, and give
mlx5_esw_bridge_vport_peer_unlink() the same merged_eswitch capability
guard peer_link() already has, since without it peer_link() likewise
never creates a port to unlink.

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

