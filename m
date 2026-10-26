Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793047902;
	b=WBAmJ4xxzJE3rqKeyRCjLhUUBS8ULZbi0/q0Rlto5vE9mu6YuoSK5ZoUomijzLcRf+/N
	 uss1xmn2yGhc2d1taelkwmPyPIuQ/uX4vVobFbVmkapekes6NeaqDW8JJCOwqmSQkKRsU
	 eX4o5areBz+5/o7GJrwh9rfeCxLqbIyO3vbj6ZRChxyPsIH50EtRNhB8BtgRdoT5k0diQ
	 Uyhjevut056WIMnKOlqpjh7y/CfRIxlkzn5pmIQZziWWTRj47LPpGszXIIYuCZz0hZPp5
	 DXJ7RKYrUZZJSCSl0nPhHRn8aSJG0QlTrz+zjWYw+CqyWX9WLB1vTcH0pW/ZKZCfrUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793047902;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=r1M3c2X29G5dw3+XTwW3++4xLGGnFhenerO2Lc3EOGQ=;
	b=opdrFq2jR8wLR40/FKheX+otzl++SbQViV0y/6ghNjlQqeey+8GVXTmtJ3kxC8eWwIuw
	 e+xItTtIVAmv3Eg4g23zX5O96G0mFzhUTmZaiRglrnrwc8+jKRXFxatB0ouX7XNBGI7Sm
	 T+7cJt+urFHZhiqrMMCUbObZHNAwIWTw2ysIm22eRM2tiFdQ1a2Fhtxm1Y0p4dgLrHaIF
	 ppplQP6pVSz31BYhHVtJttJjUx0K8nErL0ATdWcDSEjGrplInmpWU3HiEQiq2gsElbwsp
	 FG+7qyRJsnFpP13/Qzzay2ed743tdsBTZz1nIHwRM0yRuOsThNU+fOQaG2ImlpfOZdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=martin.ostertag@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=qhhQjSoo;
	arc=none smtp.remote-ip=212.227.15.18
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429BD606A31A;
	Mon, 26 Oct 2026 20:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 429BD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=martin.ostertag@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=qhhQjSoo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1793047899; x=1793652699; i=martin.ostertag@gmx.de;
	bh=r1M3c2X29G5dw3+XTwW3++4xLGGnFhenerO2Lc3EOGQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qhhQjSoovNQX3YKqATDQZlM7BOp8uFON7ZSIYmAMjQXfEWOgKrhcH/nubJpv2VIH
	 VOgtwzoSDiQOgMVWP3fgNCVx7sYKU8S1YY43yXTXfjlZaCxdox2kRWZ2s4SwGWfgV
	 niw2pt0keH+gDy46AjEPGiSnErVy9mRz2L1+0oZsiBkQxJ2RAeLP0H4GF5c+l94ZX
	 T0f3oKUm5vYa4chGxB5EfpgXX55C4u8zHeqdKid73HAiSuv45htcIU06KpIBSIHdf
	 fRNgLZdPf1R+X1vhVaI5JHmWJJv57jsyeO30DuTHanLgM7VTlEW6tzutAN6i46XwJ
	 CxvKVS4Md4yFFdY0fg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgvrL-1we6Yo0pqv-00qLni; Mon, 26
 Oct 2026 21:51:39 +0100
Received: from perseus.lan (perseus.lan [192.168.2.182])
	by blackhole.local (Postfix) with ESMTP id A3379122;
	Mon, 26 Oct 2026 21:51:35 +0100 (CET)
From: Martin Ostertag <martin.ostertag@gmx.de>
To: Russell King <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Ostertag <martin.ostertag@gmx.de>
Subject: [PATCH net-next v2] net: sfp: add quirk for ZYXEL PMG3000-D20B
Date: Mon, 26 Oct 2026 21:50:58 +0100
Message-ID: <20261026205058.104746-1-martin.ostertag@gmx.de>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lv2ui/3FPfUCS5ksKxW4j4UaFIFIeHPDGwNnHokE60sczJGCWg8
 ZaWbdwSNsZ2+Iygh6gIytR4+EGMMYUn0zZHABDcs5FHDCPH2kvsiUnsLyKbkg+yYgWqv6uD
 C4P8OIJHO2yRDv/1dGiu538Nl/3JITACXnjFxfAo47xzIcGB0MYBC2QHwawYN+/dfI7+3wt
 uvb9oFrMPOzLwa8oAgaZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eGAxXou+vtg=;2NKVkPj3qXdGun8hsRdIDQGj/pb
 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

The ZYXEL PMG3000-D20B GPON SFP module reports LOS and TX_FAULT in a
way that prevents the SFP state machine from initialising it. Its
EEPROM also advertises autonegotiation support although the module does
not implement it, and the module needs about 60 seconds before it is
ready.

Ignore LOS and TX_FAULT, disable the advertised autonegotiation and use
T_START_UP_BAD_GPON as the wait time before the module is assumed to be
initialised.

Tested with a ZYXEL PMG3000-D20B in an SFP cage.

Signed-off-by: Martin Ostertag <martin.ostertag@gmx.de>
=2D--
v2:
- add sfp_fixup_long_wait() helper and use it instead of assigning
  module_t_wait directly
- document why module_t_start_up cannot be used for this module
v1: https://lore.kernel.org/netdev/20261026135757.100139-1-martin.ostertag=
@gmx.de/

 drivers/net/phy/sfp.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 85e57a1..fd10b85 100644
=2D-- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -371,6 +371,17 @@ static void sfp_fixup_long_startup(struct sfp *sfp)
 	sfp->module_t_start_up =3D T_START_UP_BAD_GPON;
 }
=20
+/*
+ * Some modules need a long time before they are ready, but keep
+ * TX_FAULT asserted. As TX_FAULT is ignored for those modules,
+ * module_t_start_up is not evaluated by the state machine, so use
+ * module_t_wait instead.
+ */
+static void sfp_fixup_long_wait(struct sfp *sfp)
+{
+	sfp->module_t_wait =3D T_START_UP_BAD_GPON;
+}
+
 static void sfp_fixup_ignore_los(struct sfp *sfp)
 {
 	/* This forces LOS to zero, so we ignore transitions */
@@ -472,6 +483,13 @@ static void sfp_fixup_potron(struct sfp *sfp)
 	sfp_fixup_ignore_hw(sfp, SFP_F_TX_FAULT | SFP_F_LOS);
 }
=20
+static void sfp_fixup_zyxel(struct sfp *sfp)
+{
+	/* The LOS and TX_FAULT signals are not usable on this module. */
+	sfp_fixup_ignore_tx_fault_and_los(sfp);
+	sfp_fixup_long_wait(sfp);
+}
+
 static void sfp_fixup_rollball_cc(struct sfp *sfp)
 {
 	sfp_fixup_rollball(sfp);
@@ -654,6 +672,10 @@ static const struct sfp_quirk sfp_quirks[] =3D {
 	SFP_QUIRK_F("XikeStor", "SKT-2.5G-100M", sfp_fixup_xikestor_2_5g),
=20
 	SFP_QUIRK_S("ZOERAX", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
+
+	/* The module advertises autonegotiation it does not support. */
+	SFP_QUIRK("ZYXEL", "PMG3000-D20B", sfp_quirk_disable_autoneg,
+		  sfp_fixup_zyxel),
 };
=20
 static size_t sfp_strlen(const char *str, size_t maxlen)
=2D-=20
2.56.0

