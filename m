Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A40B399377
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880557; cv=pass; b=qIxboZUwYgHrJb0D12CCMvFizRSgdN6l1gN/ln3T4iULIPurh63hjqjh+u7ycYf4a345oYvF4rmhDv8XVEW9sqQwEeoGuS8it8CxtZL45HSEPi3FV0sryh95qZWOOUW+nPHKrZ2PSSjl1shQ6sBCNpQuueSjXktPCNcg0CxFeZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880557; c=relaxed/simple;
	bh=tUq+faLvGd94ea7QFL9y6TQnc+MjdXnLkZzR59MA/MU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lF9E+cLeFRjIKyXRiRo8+G5fRXmkiGW9QHK1Y+nU1kOJI2vGcCPqIDbPV/ZE6qaTU1n2zLU84zEjSJhdq7a6GSn3+0o6C9un4Vwt1/bdNOL8X6xXsuMGm1CiXzo60pDt8FlcI+NVLxLJ5l2VzH9FVjFDzVCHBBVTwlcLHptHufo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Cn5hCll0; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=3vbIJP0H; arc=pass smtp.client-ip=85.215.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Cn5hCll0";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="3vbIJP0H"
ARC-Seal: i=1; a=rsa-sha256; t=1791880529; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=L//W8rBwhOv5SuR1oH0N3XDjqbiZbFymgmLran1Bzn7Shui3sOKirchs8UtMPE/wfV
    xQFODdIbO2kMEBaUi/hYCn4yqF0RBuDNk0LP9/tTfh4LK/oZMJyohc7Iwiq2UMlEJfMA
    icSqfWfZbK1Etn456+aZFfkfXU0b5wBdYjie1tSBolKpfxFfByF9NpRWz6k6ymzs6JkK
    CzbSG/92WELYY3cHYbvTXsaZMRWXEOlHNAdrB3Qq5dKLY4sZ8q0ZXC+OMz2k82tAkYDA
    shQ8CsMZ8FVUvX/EdZZ2a3fa6EnHWQS5PY+8lbEAlPHLNPcToqj/uGIj3nOsHm66ZDXV
    N3XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791880529;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Ex1oU1Qb4IVkTpx/8k/Tlv3n+ya2mE8qBNQtFkTeZ/Q=;
    b=Ygr1R8FzchXGkFiCxW3sLPcsFesIjAU6J9iWALiw/loiCvOXGK8BfgEK0pMaQEH+ic
    j3fDxmv3Zs3AYaqcb0mkqEhuQ8p6k6w1RhLKrG8J97TkKEIYhJELZ4jauSG3mWYOa5Ce
    LzTpy50cHjQvhOIhCP0rZcadt9rAytaYFrG4mmI9IKbNp4pqAN3vm3qgbUWxF0worCvS
    e90KZ0ZQhn97En1+DvnFMElwdyDM37NLCPiONYW1J1ooI1kuP7pTCe49npwVKU4oDgWI
    UoFHwRIdJp/pSQrCJjNX9MSDukLV9eHVNWupRd0Sh3rTg8lbAq0Wl5AK2KsVHRENXndy
    QAfA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791880529;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Ex1oU1Qb4IVkTpx/8k/Tlv3n+ya2mE8qBNQtFkTeZ/Q=;
    b=Cn5hCll0e4qkeMndZDDvIAOkupL5LdihW7Iasy+713AzYHU+n7i80MOTPHya7JsmjQ
    Lwd6yTVhZTNkUxK3ka75p8hVKxJS8DDj71uwxoK4edQL8CrAMKpaiEpRAgWJiPVp37cU
    YWSqZOMZj3QaEMi6d7fNmuWtId+Ozh2O9vAsj1dleadzVorHZQqEqHi9tN73YW21w343
    u487WkePZ/baBemF/Gm9TxoUycThmYhkoVYjLcPciC1Y5VuummN7ZftdeVKJz/N9R5wr
    K/dePwohHhGp4gV7KDUiAgYWMb0oLFt3oiP4Pfo48KThrUDaGZTpjKB2PRsJgDESCYtF
    +QNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791880529;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Ex1oU1Qb4IVkTpx/8k/Tlv3n+ya2mE8qBNQtFkTeZ/Q=;
    b=3vbIJP0HIHe8evnJpddNU9oMJMQ7DqVCuIIMO4+xZhL0XqhtjS8t7WVBR+Om4hh+KI
    Q62QZM/2xt14MpYvAMBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29D8ZS4gi
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 13 Oct 2026 10:35:28 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiale Yao <yaojiale02@163.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v3] team: reject CAN and IEEE 802.15.4 devices in team_port_add
Date: Tue, 13 Oct 2026 10:35:23 +0200
Message-ID: <20261013083523.4728-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Jiale Yao <yaojiale02@163.com>

Enslaving a CAN or IEEE 802.15.4 device (e.g. vxcan, wpan0) to a
team master triggers a NULL pointer dereference because these
device types use different Layer 2 architectures from Ethernet and
the team driver never initializes their private mid-layer data
structures.

Reject ARPHRD_CAN, ARPHRD_IEEE802154, and ARPHRD_IEEE802154_MONITOR
devices in team_port_add(), mirroring the existing CAN check already
present in the bonding driver since commit 8ba68464e478 ("bonding:
refuse to enslave CAN devices").

Link: https://lore.kernel.org/all/b58d98e0-8fe3-4e4e-b8a5-c1c7e647ccca@hartkopp.net/
Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
Assisted-by: Claude:deepseek-v4-pro
Signed-off-by: Jiale Yao <yaojiale02@163.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
v3: [Hartkopp] fixed indention and compilation as reported by kernel test robot
---
 drivers/net/team/team_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ca75f08e3c59..5f1708c2a344 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1223,10 +1223,20 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		netdev_err(dev, "Device %s is loopback device. Loopback devices can't be added as a team port\n",
 			   portname);
 		return -EINVAL;
 	}
 
+	if (port_dev->type == ARPHRD_CAN ||
+	    port_dev->type == ARPHRD_IEEE802154 ||
+	    port_dev->type == ARPHRD_IEEE802154_MONITOR) {
+		NL_SET_ERR_MSG(extack,
+			       "CAN and IEEE 802.15.4 devices can't be added as a team port");
+		netdev_err(dev, "Device %s is CAN or IEEE 802.15.4. These device types can't be added as a team port\n",
+			   portname);
+		return -EINVAL;
+	}
+
 	if (netif_is_team_port(port_dev)) {
 		NL_SET_ERR_MSG(extack, "Device is already a port of a team device");
 		netdev_err(dev, "Device %s is already a port "
 				"of a team device\n", portname);
 		return -EBUSY;
-- 
2.53.0

