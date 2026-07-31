Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B9925B0B9
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 21:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785531972; cv=none; b=nIGh8tk7eVTDoxJ/1nXLFjBE+vB0bom9Gjk45pGavznEIo1vnqJ15hmImgh/Hh1MtaxhbHaA2/8XZl8Z/MAGnbeA5otCU1dn0SulVHvYeaKaqrkE5eXbBYBLGK8VYLsu+rRCnqdVKfs5UaDShlDATp/Vu4Qn9V2V6Qb4Of3/pC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785531972; c=relaxed/simple;
	bh=3PGtiKWC/V28D99T8ATguSQrDTN55rp7LHr//DvYCnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uTOs61oXnHMszoDnz9KLL2Ewux8XiZcaamcWio1q7qLMxWk581VQu4i7H/Z/xgf4b2QMlTzDeN2CCyyb34A9GHCt2CTrOm98IW6evhUFkSFDzwLJCkh8yp2/M7054bRLMJl1bgkL6d4kQvXIxVG8wCYv7k0OD8a17ViZ5cBQyQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kd2aH75v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kd2aH75v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F194D1F00AC4;
	Fri, 31 Jul 2026 21:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785531971;
	bh=Ookb340wSq0N8ioozrs5oHlc1ecYoSTQaylVdIcQHfU=;
	h=From:Date:Subject:To:Cc;
	b=kd2aH75vbbyIQI630g011DAsXCpMvKTih3dpY+msCE4ORCLZcvOhU6TdEfzaRIkBb
	 6MyijDlW/JxViRFjfEBCTIXR1Be428oE2VsWNPwGykMm9PZm6JR2IIxiFIby/p/aYl
	 JTJjvRhKFoi4u8JkTMq0BVP+zW6C0ei5S9alAxLj+tR3IUHx79H+Uyt0Oc3bwdY3tF
	 ecr3KMTZ2UaOAwvsemsszWqSWi7ovyvpra0xukV2bGCEtGzxhR/LKRoXRp/b6CKihj
	 HP6VGVDb1e3QcBab7rVZwQlS5nrGyW7kb4lP2JWxX6R5Wk7KsYOyS5eI/zpYIqX7ln
	 ZslZGg/3Fm5sA==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 31 Jul 2026 23:06:06 +0200
Subject: [PATCH net-next v4] net: dsa: realtek: rtl8366rb: Fix up port
 isolation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-rtl8366rb-fixes-v4-1-fbf0c95b829a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NQQ7CIBAF0KsY1mJggNa68h7GBeC0ooYawKbG9
 O4ibmpqZjWZ+e+/SMTgMJLd6kUCDi663udFrlfEnrXvkLpT3gkwqFjNgIZ024qqCoa2bsRIdSP
 areBoQUuSU/eA5ZBDB+IxUY9jIsfvJT7MBW36gJ/fs4upD89SPvCS+PZwvugZOM0DpgHODLMW9
 1cMHm+bPnSFH2AGwB8AMgBSVtKcOLZaLgAxB9QSEBlQtVK1EY3WWv0A0zS9AaaHHXxNAQAA
X-Change-ID: 20260702-rtl8366rb-fixes-a93f831ec2a4
To: =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2

Sashiko reports that we incorrectly disable isolation in the setup
loop while what we want to do is to enable it.

Enable it by unconditionally setting the enable bit 0 in
rtl8366rb_port_set_isolation() so a mask of 0 when passed in
will enable isolation and isolate from ALL ports.

Fix up the comments so it is clear what is going on, including a
missing word in the helper function.

Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://sashiko.dev/#/patchset/20260630-rtl8366rb-improvements-v2-0-05eb9d6a37f5%40kernel.org
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v4:
- Fix the bug by going back to passing 0 (disable forwarding
  to all ports) and just enforcing the enable bit so that
  isolation is turned on with all zeroes in the port mask.
- Link to v3: https://patch.msgid.link/20260725-rtl8366rb-fixes-v3-1-57557b39aaa5@kernel.org

Changes in v3:
- Fixup the erroneous shifted bitmask (I did not have my coffee...)
- Use GENMASK(ds->num_ports - 1, 0) top properly create a bitmask of
  all the ports, and isolate every port from every port.
- Link to v2: https://patch.msgid.link/20260721-rtl8366rb-fixes-v2-1-24464bd1efa4@kernel.org

Changes in v2:
- Properly fix the issue by setting all isolation bits to 1.
- Link to v1: https://patch.msgid.link/20260711-rtl8366rb-fixes-v1-1-12b9210b0cce@kernel.org
---
 drivers/net/dsa/realtek/rtl8366rb.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index d2fa8ff6a5d0..f11831b66de8 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -794,11 +794,10 @@ static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
 static int rtl8366rb_port_set_isolation(struct realtek_priv *priv, int port,
 					u32 mask)
 {
-	/* Bit 0 enables isolation so set this if we enable isolation
-	 * any of the ports an clear it if we disable on all of them.
+	/* Bit 0 enables isolation, the mask indicates allowed forwarding
+	 * ports
 	 */
-	if (mask)
-		mask = RTL8366RB_PORT_ISO_PORTS(mask) | RTL8366RB_PORT_ISO_EN;
+	mask = RTL8366RB_PORT_ISO_PORTS(mask) | RTL8366RB_PORT_ISO_EN;
 
 	return regmap_write(priv->map, RTL8366RB_PORT_ISO(port),
 			    mask);
@@ -974,7 +973,7 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 		if (!dsa_port_is_user(dp))
 			continue;
 
-		/* Forward only to the CPU */
+		/* Forward only to the CPU(s), isolate from all other ports */
 		ret = rtl8366rb_port_set_isolation(priv, dp->index, upports_mask);
 		if (ret)
 			return ret;

---
base-commit: 23dad2d088dfc82cae1f5a936f8ff7ffebb38dd9
change-id: 20260702-rtl8366rb-fixes-a93f831ec2a4

Best regards,
--  
Linus Walleij <linusw@kernel.org>

