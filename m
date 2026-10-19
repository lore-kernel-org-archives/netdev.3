Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792425294;
	b=qF0Ffq8aSYBvIA2elRczgY0Vt1gPxDkbaiE/fKuWE8KnHQSkUgPIwB10fH+vUCiRopQB
	 /Y165bWfx1n8cHYMfNkSIUFZdOYZ2jK2wkq9AI+eWz8t88B0U4gnzV6jv75tDsF22tFMt
	 6dvD/+/fSsMknnUj5ht0oXjSi0mzuKw1OUuwo6YqXxr+CiUQiAxB+XCd+PUzHur7e288U
	 IQxkg8IGuwzFzVuIXddswhTgFClXiP1vxib023XWppN1VU3xKpnJwhj6FREQFqHuOLehR
	 mHOpOvwDr8Sc0y/iCtmi/SS8V+ufj/i8r2SLnlPpyFNRfGEbn5M+djcGUUJdBO7LidQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425294;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=Nnu0nVBwLrZHV65taNoT+uZ3ap97Y1DHuGewStl7BiM=;
	b=MaYrOgp78zP2Iyt6UOk6jD45GB8XBsl+qhUamIeM04DuhWMk94spgaPBdmQdGdeljY41
	 co24kFgrSE2tDnwCybU4yVznN68ZZkZ1HkbdnkSHFPtevhcugPTRdgBR/PC0JMnSSiStd
	 DYt3reMepLuWG1G8m2fw9v1bv6Pt6EnbgsR7S396sM2YYjstrxxgDqgxsejMC7a46ZIKA
	 jrNVjLppeBsbKfqdObnc3wAIY8ASkY3k3IViCtZc5VRQ8aCDP6hcVjJ9jOqEgNAslCryt
	 R1BEoFWnxM1NgrqwFYIJqaHxbVf4yD96ypskFbgpwacYJGA/qT6X0oYIdyxSV6AiE9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=jKrH84C4;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="eSO1TWq/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.170
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16692606C928
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 15:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16692606C928
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=jKrH84C4;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=eSO1TWq/
ARC-Seal: i=1; a=rsa-sha256; t=1792425253; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bd1f9XOSrrFJxFAMQWPmm+/6zssnm3Q9JFp46hbhKMe/W0DtTmnTI9jxEqFcZ/buEU
    wsfw6B8bEUPtVJWXGUAuCpO9bsNMCE+opPwaCOcIpCVRwailg8F7iYJLXweujTECvboR
    q5IKw1flxNzv+EN1kQ1NY1QglkRv2/Q0YPaq0b99GDkmy++25KrpqUH/GPIbJBVcyYEl
    MWyQo4lpaekQVb5o1kzisYf9lauli2lRsF8V4lc6lbqr3eWa5fCobGVV1qgsFKKQgWTL
    AI5yK+/SVeUUuU2xi5EkxDP0G4+kD+fzpjbxMvsRWh9XDWH9ISm/oZjuwexelOm2Gx7d
    7yqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792425253;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Nnu0nVBwLrZHV65taNoT+uZ3ap97Y1DHuGewStl7BiM=;
    b=exNwYQQ2DYnNiv6o6tAGl7n2zTpimaF4dnpgT5g6CZZyi2tlJiBcEj+t3MHJv5/s9W
    MpawjRd6y/BFAfB0rDm7a6I110LclrPbftB6FQvX1FeMePeQwVeCL3rq8+S0CjC9xgKn
    Ru2o2ohVFDgVGLMOZ6mPDtb58fA4mCu+RbCGU7oxNTFDOcd1nKfYINYuoK9g4ND/VjKP
    VTFVTiorqa07dwn5usO/oFGlw8+mn0oGeLyHFus8p+EzdpBoq7hW7gfGFvhL4pgK6UdD
    LbkYH/LO6h8SiQVR9ANqmcE67+kDbHblQTNq0gi5Vv8c0l8P7Bw3s6b3CLQt2hT84Bvk
    oqgA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792425253;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Nnu0nVBwLrZHV65taNoT+uZ3ap97Y1DHuGewStl7BiM=;
    b=jKrH84C4ccKQ3CtaaLqdUfJeXMr92JeoeDMsrXue90BSy4kg1LTYFsc7fJAvvFAnRn
    H1erBKvIYoaZWW6N/fF3ZtUJOlEoVF52n/rBTBCn5rHPMllYBnxyb7o4VPxPPkOP6u+P
    IoyqJAVeDI44W1WIOL0mLAYXcTB1a/SkYzfD02dx64233QSB1VO+55pbgWZ2rj2t6XOz
    XR/zZJQ7EaGQfFZj4deNM+9Qlifs3HoG9OzK34MbpsXLOHPRqB+ByZT5Y1lwhVNs+0Go
    l0rM+VH+Ci1YQg2RKtu5H69JoRpV8XSyiNS4Q94RnATeHHO9MRo1XKDrbVlErS8aG08i
    b/TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792425253;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Nnu0nVBwLrZHV65taNoT+uZ3ap97Y1DHuGewStl7BiM=;
    b=eSO1TWq/7J9+R/vkrhomarv04DodKTFDRMa6ZR+Pv2nNpiGRvKGw8haQ+1tUIcGCEo
    Om88i/FblMqz0dSdDXBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29JFsDXe9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Oct 2026 17:54:13 +0200 (CEST)
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
Subject: [PATCH net v5] team: reject CAN, IEEE 802.15.4 and 6LoWPAN devices in team_port_add
Date: Mon, 19 Oct 2026 17:54:07 +0200
Message-ID: <20261019155407.61487-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
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

This is the same problem that syzbot reported for the bonding driver
with a vxcan device enslaved to a bond master, which crashed in
can_rx_unregister() and was fixed by commit 8ba68464e478 ("bonding:
refuse to enslave CAN devices"). The team driver has the same gap.

Reject ARPHRD_CAN, ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR and
ARPHRD_6LOWPAN devices in team_port_add().

Link: https://lore.kernel.org/all/b58d98e0-8fe3-4e4e-b8a5-c1c7e647ccca@hartkopp.net/
Link: https://syzkaller.appspot.com/bug?extid=8ed98cbd0161632bce95 # bonding splat
Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
Assisted-by: Claude:deepseek-v4-pro
Signed-off-by: Jiale Yao <yaojiale02@163.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
v5: [Hartkopp] reference the syzbot report of the identical bonding problem
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

