Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A9050B405
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988445; cv=pass; b=sJtZuO1bxpfUAYqkdMtqpO1PelbvQ+8k3jgQnEB+Bjn32x1Qk5sDhFMHDg+maj73oOBzLQQ5e9x/ONO+GF7T2+F98FJIdjyfM4pRr47Sgewqz/kxABoUmRCvP6ll26DkZvikdKTP0opLE1ZNcZaMN6z5CbteFKUMOpRlZBBl0SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988445; c=relaxed/simple;
	bh=XPCusZckG5tDFgGO54c98i30bonV2kv4WzXzdscstc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cbt+Mg5HNMkdtAD4H9PZFpuQHbCAqDdtzJPwgswUk/5Bn16pDQ53bM9BcUYm+QB5CB7nDGcg6T59lhwC6uTdOzi4l7Mph8s1d7RzUZotAB+C90UVnDsJ+cPyNuhbp68nbXluaU76rh8Kjg1XmPGbH9P6+4h8loB+ZhiuDR/bOFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=mLOgCIbJ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=P4J5NRiC; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="mLOgCIbJ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="P4J5NRiC"
ARC-Seal: i=1; a=rsa-sha256; t=1791988403; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CUAVPedGrxrgG4Ik4/NMRG0ywYEsI98LfEaJuJe4T550i5mwTqZk55U9tkk5mCcf0I
    dXhj4TrkiXW3lifuLpWkSTLDk8V7IFi+tlm71ArgXd1nqEjeDdRTPXpGWLqeENPMx4lR
    83V8vRR0JykMHEtLaT6btZAKfdsjzm3dqILvr8PR/UqJoOHg5L9ILs5PY6z+T6t9P2mf
    7RcE73A5rLhMw56imHFokKuy9qhaRvOLuFfjGg9M94xm5VwutyxGPB6i5gt7v03MC/fL
    4KQ6P915yxPswyJCBvLpeMdz5cOrCulRTS3tdO2VHrItv4mTt3TvbhMMOP1Jk0+RKZhW
    hrfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791988403;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=SennMH5OH96EpIVWq0T/bHqBK8OboTcQNxrKqdifmOM=;
    b=bl9RHCfwKsVWJeozNb10SXGYTSTUHpvsghTcxgSBa132U71b2u6RX4LoTtQ3OY3lBm
    aQyodQXFHnD839PKd7XwSbgUbk9Fpz8luK9eLKTu4oHk23Sxfs7JTFrY5l8N/TyYMpR4
    xN1EyiUYuSpGoPBE5SOTak3rmOuy+1XmUAJYEWgheqjCm+gjxCJdRqbpPvmubOF0VC6z
    YJfV8+6h95o74BdH/0v9TKsDfueH2cbXQJw3WiOZR/izX+VZrlldciY3c54A21wRndgZ
    ZVSbQHWyFVtwhsXiIYXzMNE+tbjE4AD9EOxyw/i72TNzC7/WW5T6EY8h6dETxeoivJq7
    TXYg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791988403;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=SennMH5OH96EpIVWq0T/bHqBK8OboTcQNxrKqdifmOM=;
    b=mLOgCIbJAMzfU63tJEwn7jgxxBF5aRjAvxgx53qvRHyEHDPpnFk2FEcjSf/MZaQPis
    yYlfiwkGzWmn/8Dqwa3CaiF4apU5b4+eLd0islAU8vGlRObMP9sUyPFZfQ9LrWJbSay6
    y/fdZr9ChfiPpW5j449oupxD7IuraT7wH4UD1IKim6tBmZDl1xfQfvbVFlEJQFxGNdBd
    jA6i7wjaBHHHny05q5L31WNfTQBeNgsxenfQJNDzKq0D7pogeoo+ea0NAEjpwK+h+u33
    nYwUvijtK4H6HelfQ+pex8ZTiedMDFpWC/uTqsrP5w4weZIzRg3OQ7C07rj++2sBaEue
    L69g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791988403;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=SennMH5OH96EpIVWq0T/bHqBK8OboTcQNxrKqdifmOM=;
    b=P4J5NRiCN82SNYi5tUQnF8faKB01GQA8CetLI85Yd2lBp+0a7aTH5NHZI8cqXMcq57
    v3zdseVd4KcisE+I2mDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29EEXMDdN
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 14 Oct 2026 16:33:22 +0200 (CEST)
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
Subject: [PATCH net v4] team: reject CAN, IEEE 802.15.4 and 6LoWPAN devices in team_port_add
Date: Wed, 14 Oct 2026 16:33:09 +0200
Message-ID: <20261014143309.284388-1-socketcan@hartkopp.net>
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

When the first port has a non-Ethernet type, team_setup_by_port()
copies port_dev->type to the team device while netdev_priv() of the
team device still holds a struct team. Several L2 stacks identify their
devices by dev->type alone and then access type specific data that the
team driver never sets up:

- CAN protocols rely on the CAN mid-layer private data (ml_priv)
- IEEE 802.15.4 code dereferences ieee802154_ptr and the mlme ops in
  ml_priv
- the 6LoWPAN netdev notifier writes through lowpan_dev(dev) on
  NETDEV_DOWN and reads it on NETDEV_UP/NETDEV_CHANGE

Enslaving such a device (e.g. vxcan, wpan0, lowpan0) therefore leads to
NULL pointer dereferences or to writes into struct team.

Reject ARPHRD_CAN, ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR and
ARPHRD_6LOWPAN devices in team_port_add(). The bonding driver has
rejected CAN devices since commit 8ba68464e478 ("bonding: refuse to
enslave CAN devices").

Link: https://lore.kernel.org/all/b58d98e0-8fe3-4e4e-b8a5-c1c7e647ccca@hartkopp.net/
Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
Assisted-by: Claude:deepseek-v4-pro
Signed-off-by: Jiale Yao <yaojiale02@163.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
v4: [Hartkopp] also reject ARPHRD_6LOWPAN as reported by Sashiko AI
    review, reworded commit message (bonding only rejects CAN)
v3: [Hartkopp] fixed indention and compilation as reported by kernel test robot
---
 drivers/net/team/team_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1223,10 +1223,21 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		netdev_err(dev, "Device %s is loopback device. Loopback devices can't be added as a team port\n",
 			   portname);
 		return -EINVAL;
 	}

+	if (port_dev->type == ARPHRD_CAN ||
+	    port_dev->type == ARPHRD_IEEE802154 ||
+	    port_dev->type == ARPHRD_IEEE802154_MONITOR ||
+	    port_dev->type == ARPHRD_6LOWPAN) {
+		NL_SET_ERR_MSG(extack,
+			       "CAN, IEEE 802.15.4 and 6LoWPAN devices can't be added as a team port");
+		netdev_err(dev, "Device %s is CAN, IEEE 802.15.4 or 6LoWPAN. These device types can't be added as a team port\n",
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

