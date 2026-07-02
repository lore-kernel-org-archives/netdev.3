Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77083D413C
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783032650; cv=none; b=QTc2J6taBarzGgC67345NcSKE2CqNKlbauPZBHhM1uWAjZgR3vzS7Nyc/OpsVOTVObe115BYwAZ5z1f8WjNoFd0r+ABvvj46muwPzHuglnjiai0eUXk2L6K/bxn3RGZhJk17ZXWMEburjNshGaZm81FoMcKC3beQ7PV8kG0DrZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783032650; c=relaxed/simple;
	bh=yTn8jNEJZ16WhCPO6MhtwE8De7WBu4SrannR0RxvdnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X2MbC086xN9m+Y+kCTkalAxzZx8qcveradNb8/wYpxu4gNJYwiF1XaoH1z1/W9GwS5MytP0iqI56l/aFLy2e8BJ5/ArCPvyZRymEfbf4DZigZert/en8FwQKbPwerzHBXVjeCoUl9fCujOpGUxryAnLE/n4iF/tOtoQSp3mAMXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=hQcbVlqt; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="hQcbVlqt"
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EAD652C01D7;
	Fri,  3 Jul 2026 10:50:43 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1783032643;
	bh=M67UdirR4tnDWeRqKhwHbg0noAZSZV9RuNjbH19Ofqs=;
	h=From:To:Cc:Subject:Date:From;
	b=hQcbVlqt4I1oa0hU+SYglcnOtqvORNDy6R7H/OuBpXl1RidIfAG7mhnIHF8MKcgHT
	 8dwD9O28GIJgUSgJ3ckEA52nzvWvsCbD4IpaHryk9kCUDZ8MzASqrXRktg0VzvcCNe
	 59QZjVPQgj1jh241SrAg92ZVYQvPYqpYmOi2yy/u+w382EtoRJ3iqutIgiCg+m9Qv0
	 I3iJBtLHkEhjXd2o+pZ1MrIaubEDBis6eanStATqr6BmwAF7xnyQPXxqcfWPRM8HGN
	 xG4ue99xPcVazrXFL2fL0WJn3j2SnKL4nvct+LswseR6MFHP2Gj59wrxCUeR+BiWYI
	 1cia6dA74Yxaw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6a46eb430000>; Fri, 03 Jul 2026 10:50:43 +1200
Received: from benb-dl.ws.atlnz.lc (benb-dl.ws.atlnz.lc [10.33.12.28])
	by pat.atlnz.lc (Postfix) with ESMTP id C25C013EC4E;
	Fri,  3 Jul 2026 10:50:43 +1200 (NZST)
Received: by benb-dl.ws.atlnz.lc (Postfix, from userid 1869)
	id BA8128079B; Fri,  3 Jul 2026 10:50:43 +1200 (NZST)
From: Ben Brown <ben.brown@alliedtelesis.co.nz>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	Ben Brown <ben.brown@alliedtelesis.co.nz>
Subject: [PATCH] net: phy: marvell: Add soft reset for 88E1510
Date: Fri,  3 Jul 2026 10:50:34 +1200
Message-ID: <20260702225034.1062457-1-ben.brown@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=TI3mSEla c=1 sm=1 tr=0 ts=6a46eb43 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=RAioF0-LDSMA:10 a=8gEV1s-2vp2lfwrOOEkA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

When bringing down then up the link on a 88e1512 phy a link is not
getting established. This is because the phy is coming out of reset then
immediately getting configured. During configuration the page is
unsuccessfully updated causing writes to the wrong registers.

Add the soft reset function that does a reset then polling read waiting
for the phy to come back online, at which stage the page register can be
updated successfully.

This was tested on a 88E1512 phy, using ip link to bring up/down the
link.

Signed-off-by: Ben Brown <ben.brown@alliedtelesis.co.nz>
---
 drivers/net/phy/marvell.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 7a578b5aa2ed..1ae75141408a 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -3922,6 +3922,7 @@ static struct phy_driver marvell_drivers[] =3D {
 		.features =3D PHY_GBIT_FIBRE_FEATURES,
 		.flags =3D PHY_POLL_CABLE_TEST,
 		.probe =3D marvell_probe,
+		.soft_reset =3D genphy_soft_reset,
 		.config_init =3D m88e1510_config_init,
 		.config_aneg =3D m88e1510_config_aneg,
 		.read_status =3D marvell_read_status,
--=20
2.54.0

