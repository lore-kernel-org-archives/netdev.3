Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D7F41168C
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376113; cv=none; b=b2X7kIKPJoyaviw9ahKlW6gfwEDrJJDxOD0vPWFLUmVuDyQzQDJP300bNLwT2D7+BCqqVbvFCAioVcu2sXq3fz3jHS9aVlZHtZbCVtgx+2tPdgzw+iUM3RNYpPYQDAdZbwlT0DK9jN5lOPSaywdJr75rFdyZ/A8qr6/NEIgJHhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376113; c=relaxed/simple;
	bh=IJyCKllunMMUhHfcw5OmNX0Wc6uDfl1qnkLw0LwVxg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7SzKpfkFHmrcCIz8ylDU8uSg+ITBjzzTLURTuyaW/sbcc8bddR3ZmwenVJYr5HT/mkHVriErIHkrR4E5Sz5GWLa7GEyYhy60oy0zqXoqoRoCj7PikCnpHTdnjpE6kAb4GFGHXsh5C/4caPnzjS8RG0Uu6F9OKwJTVbUrznFMX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIE+KBPP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIE+KBPP"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c20ce3c118aso352495066b.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 01:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789376103; x=1789980903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kSgf3ABCS/HTHGlHUul3ahtWnU5PdY9A7nkvg16f/yg=;
        b=hIE+KBPPhdEtOZDttXXUbe02zyH5ZknVMZevD7PD21w6gKD3wXKg+iG1MnRP15I2np
         XFA2lReGJyUBMeNUvQYiCV8v4grojvR7s4FodM5DYC0IAf2STFj+c1fEztUZW72OwQJh
         VZ6ib/7nOWupEZlVdyHkOtPT+z5BAjvHlsnuUgCVJBPbJP8jGjB3MGIQ0H5kxCwrmvS8
         La5JT+A7PrcnZillujtbpzEvV+VqJNTRxikd8AciOUDQ4spYGFZpYnmMd2cesMpgXssb
         2dYEoDVpwsbW9e0MWa4G8tSsTErPbbLy+YxPrWij3x5jEvuztC01V7Lv+9Q0AUPAjMW5
         2CzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376103; x=1789980903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kSgf3ABCS/HTHGlHUul3ahtWnU5PdY9A7nkvg16f/yg=;
        b=S+UbYsYiktFZ5DOocLtMWS0Q35fL6RTQflrZMK5FSmC60l3ZuNR5FKKBOVxBE4uakB
         VZMgCg9g9I/2Mf8KAM9TWjrbNpAUEtGRRv8aR7FMlz2ZYVjtj8epyaFBY3+6jgVyZwBe
         bOTfhl0pg7YriytdbNyKUXyTEbOP75IidATcXOEmsRIiNY3CfqAMz5xuQ9Upx+D14Pyl
         4Do87qnAkjxvtjs3/j6Z9Zc1zdcy84cntvSsac6220hydxSUrkSdbqzc/dVjD9MUiwAD
         LfLEweJAXymbOjBjaiO3ymDZTmd7wUxoj9RtBZPlEOZr6dvdpT4wiEfTsuqSp6ZLj5Ka
         dukg==
X-Forwarded-Encrypted: i=1; AKwUvBxnzK7lIzLmPKggrqL/C6bR2Wlb+5jAtub5qR6wFeHQji2fTet3lY5Quc5RPJZHbozBf3cPbvQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n2sACdM2LCDzFYrPFXiXtAFBoHSb0Mf8l8gaBCyodNqookYHSM
	cESNGSseIhYroVPU8sm8bKbXy8gFtJuKjmiZU2SpBHvP77gLAcv2BVKL
X-Gm-Gg: AYBFou1Aqf1QtmGseb+IP+0USgSv2ivQPvvacFH5vRW1b50RbfSj/h/PY0osh/iwGzA
	68I6wcfJzsL3WnveoSv0OnROuycEkxwhcHM7PKo6J3OoJUt0TVOxzx+EdhNs19HsMEO59tUhqy2
	Bj8LdWcy2iV1H30BllKvKhnyKU2dax28TboWybrJ0YkicrQCUHxTbvaA6IhFacGErPF7kIPXXdK
	JcYgXr35pjBPEMHKpDC90WQ/sQknCrnHhdtYDLa6nLVhJ1DEErY56q1mKi9GA3koJunO62Hv2g+
	9mhNNgbfd4mwFglZi9n285GXdP/ypGtwyfpQoGwFbkbYZUZcEXX0a0e3F5/fYkr+GT88ujAUlVC
	P2jk8x/dweEQfmpmgHFQi3czYRPGMfsTnf12VtYtse+CCA+C5Mx67dzcNNsQLN869wbkgLkpnYD
	3YsvSrna7gqSLsgHZIpy7xcea7YFC09ayTG6O9S5EPR8bCOWzq29mpha7yhkTOV8oijxu+RveXl
	An/U5U6YUUE1Z9sauTPzfuPj0BNK0gPA22LlRg7+uQre+MUWl1qrDqXiMaVZOiRExbd
X-Received: by 2002:a17:907:970c:b0:c25:5a26:3787 with SMTP id a640c23a62f3a-c29a42f1e2dmr277217366b.8.1789376102419;
        Mon, 14 Sep 2026 01:55:02 -0700 (PDT)
Received: from BERSOARE-M-K4D5.cisco.com ([2603:5004:20a0:100c:4701:1ac4:1c21:4a1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29ad3e033asm101378466b.47.2026.09.14.01.55.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 01:55:01 -0700 (PDT)
From: Bernardo Soares <bsoares.it@gmail.com>
X-Google-Original-From: Bernardo Soares <bersoare@isovalent.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	Vlad Buslov <vladbu@nvidia.com>,
	Bernardo Soares <bersoare@isovalent.com>
Subject: [PATCH net v2 3/3] net/mlx5: Bridge, don't fail unlink of untracked/unsupported peer ports
Date: Mon, 14 Sep 2026 09:54:30 +0100
Message-ID: <20260914085430.18694-4-bersoare@isovalent.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260914085430.18694-1-bersoare@isovalent.com>
References: <dd3247a9-14d5-4866-a20e-b31d414ec1a1@nvidia.com>
 <20260914085430.18694-1-bersoare@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx5_esw_bridge_vport_unlink() returns -EINVAL when the port isn't
tracked by this instance's br_offloads, which is reachable in two
legitimate cases: a replayed/duplicate NETDEV_CHANGEUPPER unlink for a
port already cleaned up, or a peer-port unlink for a vport whose link
was never created because peer_link() skipped it. Return 0 instead in
both cases, and give mlx5_esw_bridge_vport_peer_unlink() the same
merged_eswitch capability guard peer_link() already has.

This also matters beyond the -EINVAL itself:
mlx5_esw_bridge_switchdev_port_event() runs on the per-netns
netdev_chain, and notifier_from_errno(-EINVAL) sets NOTIFY_STOP_MASK,
which call_netdevice_notifiers_info() checks to skip the global chain
entirely - so the old -EINVAL silently dropped the event for every
other listener on the system, including a sibling PF's own
bridge-offload instance, even though none of it was visible to user
space since __netdev_upper_dev_unlink() discards the return value.

Fixes: c358ea1741bc ("net/mlx5: Bridge, allow merged eswitch connectivity")
Signed-off-by: Bernardo Soares <bersoare@isovalent.com>
---
v2: new patch, addresses review comment on v1 asking whether the peer
    unlink path also needed changes. mlx5_esw_bridge_vport_peer_unlink()
    now mirrors mlx5_esw_bridge_vport_peer_link()'s merged_eswitch
    capability guard, and mlx5_esw_bridge_vport_unlink() treats an
    already-absent/untracked port as a no-op (return 0) instead of
    -EINVAL, which is reachable on a replayed or duplicate
    NETDEV_CHANGEUPPER unlink and was found while auditing the same
    code for the ownership-check gap raised on v1.
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

