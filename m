Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470068;
	b=tAOG7ANhw5V8DJ2pzsAknraCJOPcx8NFR3NU/PmM44JXKJhJBa3T5Kf/9UvNQ5Fh3ofx
	 2zt/5b3ZY7SyZCwhfyHX7JtIQNCXAUrwxmlDt7SZd1yEHJmCAy1qe06JiXyn7HKTPNZw3
	 ExhGIVe2GWwymc/QZXJtg25fGvX/5IB4uqJqhiUmc5AS48jCu3IgrfA0a1T4bsSS22dWu
	 BM+hyRUnUTe2v18LI7G3Pe6QXdhz8fDcOWh0JPkTTnBTzU/X+PEsm4jsviliklhCwK8Zl
	 6IV3u2lKxTZY0pYVklJdhHf2UFyqxX0yftbHGMS68575/v1II6ftsQBoePPiMcMMCKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470068;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=xR0nrFMbMlujWxx3EIWeeaKuT3BBTWHLzWpOn49Q/b4=;
	b=gJQbiI0Oc8wvFBJXC5bXvInL3cgsUV9irVq4F3I0KcFBPMmnzjeyJOSGyCDVXohrx02v
	 incM2RCCCq+NqUEWCfrnHC4xLYMlZX72KlAo/E+dLnui5XUqqfJlnxyeDS46zqi38zVvm
	 M+TwwFUI3+oILDK6Gbih/NZ38BzN9cfkL0r8jix/V4ZPYAHz6mXtDIY41BehzeSegnn6j
	 eJkfRBu0nbmlg8latkkiVDrvPh0pGPYniQoRFA1WVIjYRHp0hw41XZb1dmwBD2vkeKcVI
	 BpAwBn5cw12LAMoxovuUggkeXqUVxyznNJaISi270VVT7FROPLuuc2uDpdaxOAFzB1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=nc6TvKQL;
	arc=none smtp.remote-ip=220.197.31.8
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B6A606A32A;
	Thu, 12 Nov 2026 07:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7B6A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=nc6TvKQL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=xR
	0nrFMbMlujWxx3EIWeeaKuT3BBTWHLzWpOn49Q/b4=; b=nc6TvKQLKJ6sag9nVo
	ZOuVY0lDtBDa8aksxPecRHLGnuG+VEX5H9dYsfXYE+OzFBLN/axEeR79U3UTe8tV
	mpsG57jq8m7QISOK1pA4+mWneYRl7/X2M88QNSIz8fmf5+Jxk4rQCgyoHOeK+0q0
	HUW5aoL/6uCwPxHCgIBgM/Y9c=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgDnxvhzcPVq2o9NDQ--.20313S2;
	Thu, 12 Nov 2026 15:53:25 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	rosenp@gmail.com,
	jacob.e.keller@intel.com,
	daniel.machon@microchip.com,
	chunkeey@gmail.com,
	kees+treewide@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH net] net: ibm: emac: attach the fixed-link PHY with of_phy_connect()
Date: Thu, 12 Nov 2026 15:53:21 +0800
Message-Id: <20261112075321.3903875-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:QCkvCgDnxvhzcPVq2o9NDQ--.20313S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw4DZr15ur4kuF1kCw1rWFg_yoWrJw4fpa
	y8WF93ZrykJF1fWF45Ary8AryYga1IyrZ3K340v39xu3s8Xry8AFW5tr4Yvw1Yya95ZF1Y
	qr47ua13uFs8ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYzuZUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlBVRKGr1cHXCLAAA3M

From: Linkui Xiao <xiaolinkui@kylinos.cn>

emac_init_phy() handles a "fixed-link" property by registering a fixed
PHY for the MAC's own OF node and then assigning net_device->phydev to
it by hand:

	res = of_phy_register_fixed_link(np);
	ndev->phydev = of_phy_find_device(np);
	if (res || !ndev->phydev)
		return res ? res : -EINVAL;
	emac_adjust_link(dev->ndev);
	put_device(&ndev->phydev->mdio.dev);

net_device->phydev is meant to be set by phy_attach_direct(), which is
what the of_phy_connect() helper reaches. Assigning it by hand skips
everything attach does: phydev->attached_dev stays NULL, no link change
handler is wired up, the PHY never enters the netdev's phy_link_topology,
and the put_device() drops the reference the driver just took, so the
phy_device is kept alive afterwards only by the fixed MDIO bus it is
registered on.

The missing topology entry is what prompted this. ethnl_req_get_phydev()
returns dev->phydev as-is when an ethtool netlink request carries no
phy-index, so ETHTOOL_MSG_PHY_GET on an EMAC port with a fixed-link finds
a phydev and then looks it up in a link_topo that was never allocated:

	struct phy_link_topology *topo = reply_data->dev->link_topo;
	pdn = xa_load(&topo->phys, phydev->phyindex);

which dereferences NULL in phy_prepare_data().

Every other phylib driver with fixed-link support registers the fixed PHY
and then passes the MAC's own OF node to of_phy_connect(): gianfar, fec,
davinci_emac and nixge all do it, and so does emac_dt_phy_connect() for
the phy-handle case. Do the same here. of_phy_connect() takes the attach
reference and drops the of_phy_find_device() one, so the explicit
put_device() goes away. emac_adjust_link() is still called once by hand
afterwards and the PHY state machine is still not started, because a
fixed link does not change. The rest of the driver already treats
dev->phy.address < 0 as "no PHY to poll" and never reaches
dev->phy.def->ops, so nothing else changes.

The hand assignment itself dates back to commit 08e39982ef64 ("net: emac:
fix fixed-link setup for the RTL8363SB switch"), but it only started
affecting the net_device when commit baab9de385a8 ("net: ibm: emac: use
netdev's phydev directly") moved the pointer from the driver private
dev->phy_dev into ndev->phydev, so that is the commit fixed here.

No in-tree DTS pairs "ibm,emac" with a "fixed-link" property, so this is
latent in mainline; it is out-of-tree users such as the Netgear WNDAP620
that hit it. There is no such hardware here, so the change is verified by
cross compilation and inspection only.

emac_remove() still does not call phy_disconnect(), which the phy-handle
path gets wrong today as well. That is left to a separate change.

Fixes: baab9de385a8 ("net: ibm: emac: use netdev's phydev directly")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/ibm/emac/core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 640618c..6e8b711 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -2674,11 +2674,14 @@ static int emac_init_phy(struct emac_instance *dev)
 				return res;
 
 			res = of_phy_register_fixed_link(np);
-			ndev->phydev = of_phy_find_device(np);
-			if (res || !ndev->phydev)
-				return res ? res : -EINVAL;
-			emac_adjust_link(dev->ndev);
-			put_device(&ndev->phydev->mdio.dev);
+			if (res)
+				return res;
+
+			if (!of_phy_connect(ndev, np, &emac_adjust_link, 0,
+					    dev->phy_mode))
+				return -EINVAL;
+
+			emac_adjust_link(ndev);
 		}
 		return 0;
 	}
-- 
2.25.1

