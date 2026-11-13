Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794604002;
	b=LEcWvf0WACkLyfWy95XoawnzgJQOQDCW6BTZpAoakB2JDXIpF811t8Z+iq/xg+c/EpPL
	 Q0hMKP1nj+l26T43BsMLemzsX3wf3d7mcy8bl5AvdnNysZ5DWj9h94TGMD8LTpJeehLZP
	 xaIv6qev1XOwgOxAimGeKk53q/FTP99rTG2lXtboIozIk5025mb+llO88+1oNwIwYG/Dg
	 U8uc1rYuonIpxfox4YsPl8XvzTI7mZzuH71Xhc897EZ8g3Ov/Xrtj2LD88LdaQGyBl8lS
	 ywNbbi4W5wdggDmzdrN6g+MscyB16mL0knfWRp65dIiTiTKu0TeK1H2FcRkOUBJgtwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604002;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wmM0UoGKZ7WqOCC0Wngrk9xRaWl7Etv16ThRosNIeD8=;
	b=Sejiz9LzZ1j+iIoXyg423LhH02t1qyU1sMmwRLRr+DAYz+HRO/IoQdmgtLGAj8iz3Hfx
	 H5Q2HS4Nuh69lVxWfyLOI9k6m6Lga5cHV3UVid1hI3jmKk2qGbb3oHWx7S3+catbkj9ai
	 K8vfGlMgroWx4RwWWDVa0Yk+0ivmssLzU1wYvdLO98MuXpWe5YV2DZM+Hym8qwUwtSoAM
	 YMLIOrER5uzSQYmle07bSIIhCsfQI/rhB2DexO13hzbrLiONqhMc+0LYPOPLWgFnK7EZA
	 MAozIh3+nWWjN6iWPiSVacpmQL8vAVxV0nZUH8rpEPRYh40tAg3PKZ+ERJ3PlSlT+vA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MOncbFNu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0576C606A336;
	Fri, 13 Nov 2026 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MOncbFNu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794604001;
	b=KyuYyqd+2L34yKtJ51k93Eo3w4B4pqSKKyXehGtPeyUJ/HDlyVYF/MtujmJlu+o4Wupg
	 SbOh/3L2YPGVapeiQ5Y8eZYHdwnemFfmqT90LrsBm1fUKrLirpntaeJg42cR9s/64HnvC
	 TG6uBKKzp+FU4Rz1uytNZ6RfOxVKniPoijd6Bw3/yWjou/pa8kv7/Gbvvs7swuh7pDPdQ
	 O+Tw0W/ktnvmH1WyZYDGiUist+dQ0YRByj3Wlx4Uh15M1yuI0NLjrjrU6Fr1aJ1L2FdXP
	 Q5F9wbhcc2LnLZ96g1kKm8qq3bNgJEgWXex6OdN0jpoPYqdpQ6qp85SvMmyBgCe+U6g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794604001;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wmM0UoGKZ7WqOCC0Wngrk9xRaWl7Etv16ThRosNIeD8=;
	b=HnABwL5boifJKAH81+XHWTlhAQHzBgiyWwFEFaBJDoMS1CpX7R21KRtXNImLpHh3YE4Z
	 98EFAMmmo2vZnMFpgsiOledhKFHOx9ZzoWsJ4aXUq92xFJ13r1uOaQYUoX65E3TSqk6RB
	 fPxCVyPQWlSuDKll2rcQlLhZtCXW0AosR8ypCRd8y66MB+X7v47hoM/69is09XJL6SiBA
	 bMAYoLwDLJS06KTnKhYIRvpghPUdiFqcb2Y/VVol0VPhhv3bPvg3hz8axNBS5Pq33Ikne
	 VflJ9ZjbR/9bGYrxhLtBDP/Gq+4wksv7UoBzjDuHNaNguJxDsGCuYOsVM9W037uu66g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E1C311F000C7;
	Fri, 13 Nov 2026 21:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604001;
	bh=wmM0UoGKZ7WqOCC0Wngrk9xRaWl7Etv16ThRosNIeD8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MOncbFNuGrElDPO2oYCzo6hYZVWru9LzVwkCmODzvQUPY1SlcQqHhshGgEWyJLKVM
	 5eMdkvala6QpwvBBXUBT9OviGpM1od9fH5xGH4RZU8PRwDfB+v/FNY9QrNWUk6vUz3
	 W+sEdNX0MwqTja1IcvN8JNl09IEgfhz47JUX9azIidg0FOqmNclLkhlt+NUgXsWzES
	 lJwwi+phTCDWTmaSLeadrdOqC9Cfpqy811G14tzcW3JslDuLew0zRlofSDDG/bSW6Y
	 ZC8aoXqINwME5KYXse5PQI/5FyTLgltjHvRiogbDunJTX2EsyYjpcFc6u0uA9tJ0W+
	 SthioBWri5XQQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7044249AFE;
	Fri, 13 Nov 2026 21:06:40 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Fri, 13 Nov 2026 21:06:37 +0000
Subject: [PATCH net v6 3/4] net: phy: stop postponing PHY interrupts when
 phy_suspend() fails
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-b4-phylib-mac-pm-irq-v3-v6-3-05af2503cb23@iav.lv>
References: <20261113-b4-phylib-mac-pm-irq-v3-v6-0-05af2503cb23@iav.lv>
In-Reply-To: <20261113-b4-phylib-mac-pm-irq-v3-v6-0-05af2503cb23@iav.lv>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Lukas Wunner <lukas@wunner.de>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Wei Fang <wei.fang@nxp.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
 Paul Barker <paul@pbarker.dev>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Doug Berger <opendmb@gmail.com>, 
 Thangaraj Samynathan <Thangaraj.S@microchip.com>, 
 Shenwei Wang <shenwei.wang@nxp.com>, 
 Haoning Cheng <Haoning.CHENG@cn.bosch.com>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2032; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=5VvbAr93FGmELOk5YU+LU+0e2l85PgvFDy/Bv6Z+ybI=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFnfq+8preMt/Pyy4Hnk/fmsp+vKI1cYBFXbZ3H2qtufe
 Tzh/MbgjlIWBjEuBlkxRZYJhzRuZSy5+tffw/wBzBxWJpAhDFycAjCRr6sYGe43mfCkVc57W2F/
 480FoZ8FUS9d1Fs2JF/583/ZhASeuNUM/6v3vHeJu/84e5W6eChDle+s7b7s7A/nSORdCJH56/h
 zMRcA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

When phy_suspend() fails in mdio_bus_phy_suspend(), irq_suspended
stays set and the state machine stays stopped: the PM core does not
resume a device whose suspend callback failed, and the next PHY
interrupt disables the line until the next resume.

Undo the postponing and restart the state machine when phy_suspend()
fails. Set suspended_by_mdio_bus only after phy_suspend() succeeds.
Set before it, the flag outlived a failed suspend, and in a later cycle
where mdio_bus_phy_may_suspend() returns false, mdio_bus_phy_resume()
ran phy_init_hw() and phy_resume() on a PHY that the MDIO bus had not
suspended.

Fixes: 1758bde2e4aa ("net: phy: Don't trigger state machine while in suspend")
Signed-off-by: Igor Velkov <iav@iav.lv>
---
Haoning Cheng's Tested-by on v5 is not carried: this patch no longer
changes the resume error path.
---
 drivers/net/phy/phy_device.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 573eb234dc79..39e232a3144a 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -367,6 +367,7 @@ static __maybe_unused void mdio_bus_phy_resume_irq(struct phy_device *phydev)
 static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 {
 	struct phy_device *phydev = to_phy_device(dev);
+	int ret;
 
 	if (phydev->mac_managed_pm)
 		return 0;
@@ -384,9 +385,20 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 	if (!mdio_bus_phy_may_suspend(phydev))
 		return 0;
 
+	ret = phy_suspend(phydev);
+	if (ret) {
+		/* The PM core skips the resume callback of a device whose
+		 * suspend callback failed.
+		 */
+		mdio_bus_phy_resume_irq(phydev);
+		if (phy_uses_state_machine(phydev))
+			phy_start_machine(phydev);
+		return ret;
+	}
+
 	phydev->suspended_by_mdio_bus = 1;
 
-	return phy_suspend(phydev);
+	return 0;
 }
 
 static __maybe_unused int mdio_bus_phy_resume(struct device *dev)

-- 
2.43.0


