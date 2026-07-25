Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAE14908B1
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784987188; cv=none; b=AtgyWwwX9bCHhQ7RWBxcK2dyeoQprxZbZXiT2d/kBZqPVM3RJAZSIdkeUWTu1ILvrHlwjsUtz4a3hIWN0N4ytN1G3J+iYoKnJ/dGBocDqTPmgGFu9GK4lccNzISztCIUU3a8EmFWkRvnZG37m4yo+vxfsygi24O6Z2L9RvEFP6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784987188; c=relaxed/simple;
	bh=56KPPErOAZzICwpNGPxiNV+FjVyrTrel6EQh1LucW9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pR/lpCnQNBJyjBebHzgt2XGZaXu++LnR5o8FbEJ2ArtK7eL3W3TxiARvZeM6MonHvdZAyoRHWgC7Qkdue4Z883/4n/xsufzfL4Ek6wEtpvj+k/EZLN7rtzcCJ5dS8UyDX2LvQggtsqKlIYOnN3M8fx/TDh6weFhGgeudMCt2dVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDIUIkjx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDIUIkjx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00B91F000E9;
	Sat, 25 Jul 2026 13:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784987186;
	bh=sNMSN7jUAdSH9uPg1mWxmSSUoAJ+glyp27jMF3XKnlk=;
	h=From:Date:Subject:To:Cc;
	b=KDIUIkjxX4ojKhgEkSXmIMxwB+nYG68w5oGJT1TBlVPjXUvbxhaiIfxw8xvz7zE0c
	 qAs3YSsV/eEYULD0DrwnzcOdWET5IXwctzi9NxiBWcWq3FuZaEJn12hqXImVWPvi9g
	 F6fkSUI0kQwz3yfhVOmjDqubVYdTMjtm6CUAPaptaItjrynFC9wcrz9N97nxKZXBVu
	 ctX/TiqQUHZGzv7sPRTklGPUYBLjbi9e0+WQ2BmfNTDs3T35vZSC2auLjTL8K0G1A7
	 Lm0zeG+/pp/BzdPZz26hEb+5CVRlEFKaAPY/hss5ZLgLz88pFp7C06xv8IX87vVfhX
	 rVF68JawfEfrQ==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 25 Jul 2026 15:46:21 +0200
Subject: [PATCH net-next v3] net: dsa: realtek: rtl8366rb: Fix up port
 isolation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-rtl8366rb-fixes-v3-1-57557b39aaa5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ7CIBBFr9KwFgMDqa0r72FcAJ22qKEGsKlpe
 ncp3Wg0s/r589+bSUBvMZBjMROPow12cCmIXUFMr1yH1DYpE2BQsgMD6uO9EmXpNW3thIGqWrS
 V4GhASZJWD4+5SKMzcRipwymSy9aEp76iiStw/e1tiIN/ZfnI82LzcP7jGTlNB7oGzjQzBk839
 A7v+8F3GT/CBwD+ACABQMpS6oZjq+QXYFmWN0ybyBkMAQAA
X-Change-ID: 20260702-rtl8366rb-fixes-a93f831ec2a4
To: =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2

Sashiko reports that we incorrectly disable isolation in the setup
loop while what we want to do is to enable it.

Enable it by setting all isolation bits in the isolation mask
for all ports in the switch.

Fix up the comments so it is clear what is going on, including a
missing word in the helper function.

Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://sashiko.dev/#/patchset/20260630-rtl8366rb-improvements-v2-0-05eb9d6a37f5%40kernel.org
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v3:
- Fixup the erroneous shifted bitmask (I did not have my coffee...)
- Use GENMASK(ds->num_ports - 1, 0) top properly create a bitmask of
  all the ports, and isolate every port from every port.
- Link to v2: https://patch.msgid.link/20260721-rtl8366rb-fixes-v2-1-24464bd1efa4@kernel.org

Changes in v2:
- Properly fix the issue by setting all isolation bits to 1.
- Link to v1: https://patch.msgid.link/20260711-rtl8366rb-fixes-v1-1-12b9210b0cce@kernel.org
---
 drivers/net/dsa/realtek/rtl8366rb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index d2fa8ff6a5d0..61c30d2c6802 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -794,8 +794,8 @@ static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
 static int rtl8366rb_port_set_isolation(struct realtek_priv *priv, int port,
 					u32 mask)
 {
-	/* Bit 0 enables isolation so set this if we enable isolation
-	 * any of the ports an clear it if we disable on all of them.
+	/* Bit 0 enables isolation so set this if we enable isolation on
+	 * any of the ports and clear it if we disable on all of them.
 	 */
 	if (mask)
 		mask = RTL8366RB_PORT_ISO_PORTS(mask) | RTL8366RB_PORT_ISO_EN;
@@ -951,7 +951,8 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 		rtl8366rb_port_stp_state_set(ds, dp->index, BR_STATE_DISABLED);
 
 		/* Start with all ports completely isolated */
-		ret = rtl8366rb_port_set_isolation(priv, dp->index, 0);
+		ret = rtl8366rb_port_set_isolation(priv, dp->index,
+						   GENMASK(ds->num_ports - 1, 0));
 		if (ret)
 			return ret;
 
@@ -974,7 +975,7 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 		if (!dsa_port_is_user(dp))
 			continue;
 
-		/* Forward only to the CPU */
+		/* Forward only to the CPU, isolate from all other ports */
 		ret = rtl8366rb_port_set_isolation(priv, dp->index, upports_mask);
 		if (ret)
 			return ret;

---
base-commit: 23dad2d088dfc82cae1f5a936f8ff7ffebb38dd9
change-id: 20260702-rtl8366rb-fixes-a93f831ec2a4

Best regards,
--  
Linus Walleij <linusw@kernel.org>

