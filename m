Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE423939C1
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621892; cv=none; b=bvC0Yz1mkOa8aALmQ4lpQhtrpb3fWHxJVJfUdiPghaYafxlrlJlO7Q9jivbJtOSDd2zPbAhud/57h1PfAqBnSFv3KrwaSsDCkcax7igKxHczLu7BUh2CDP6aB+MGaocXpSpL/yt5CA21KEOTezPH7kTKW0kLC/vSh/lfZ7KVorA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621892; c=relaxed/simple;
	bh=/YVCNIGz0E8NAzNg6WZPt6Cw/tmas5sDdCq4GWEUar0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lgEvP8XQdOezUvSnp+Th9YGhETsD7bRvebkQIYGtbDs1H5Xgdd1v9LshjTDPtS4DRZONRuAfkWapS3g/b+8dMTz00gKoEjHrTMRYvx9el1b9TgDH1qINH3angDL7tfzj9bDuwnOo4eR3AUtSPQdxkMucVFrCK0gysI7kz5Y7Kp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZ3cYz8j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZ3cYz8j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425591F00A3A;
	Tue, 21 Jul 2026 08:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784621891;
	bh=5fAmN1wm+fc2DlkfkuPJnbULK/e19T3qnW9ZEUbd77g=;
	h=From:Date:Subject:To:Cc;
	b=VZ3cYz8jcjHMSJWy3HOPxVkgjenEYmdiUBdTZiq0+cxXvZgXGpQw5DE5MQIVm18zp
	 vdB0Omd9/YbDL6CLbgmBO5QhPrdRE02hBnL6c3gK4a3qa3fMm/98BziXRc6oRhM13D
	 ohKmzPfK320WiVjj4sh1KJ50RZPuKc+mXTUfpm8hrpmoe3djx+CXaaRLlA+YZkkDDN
	 B4odi5b87cJ2nZkNhOutS7l/sblGwwKIe+Ve1O7oJ0yWv7Sp3VpFTJrNVC5fKn1Q88
	 Ts7XNewuVN57oLre3FFzPhJ2NyjZtQrgb+kTYBjkR20LeyOWT8eqUKuryjTJDXP3GS
	 fDop007gsEM5g==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 21 Jul 2026 10:18:07 +0200
Subject: [PATCH net-next v2] net: dsa: realtek: rtl8366rb: Fix up port
 isolation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-rtl8366rb-fixes-v2-1-24464bd1efa4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNQQ6CMBBFr0JmbU07GARX3sOwoHWAKmnJtBIM4
 e4WWJpZ/fz/5i0QiC0FuGULME02WO9SwFMGpm9cR8I+UwaUWMirRMFxKPOiYC1aO1MQTZW3Za7
 IYHOBRI1Me5GgBziKwtEcoT6a8NEvMnF7uG17G6Ln7y6f1E4cHqX+PJMS6VBXqKSWxtD9TexoO
 HvuoF7X9QcOSZf8ywAAAA==
X-Change-ID: 20260702-rtl8366rb-fixes-a93f831ec2a4
To: =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2

Sashiko reports that we incorrectly disable isolation in the setup
loop while what we want to do is to enable it.

Enable it by setting all isolation bits in the isolation mask.

Fix up the comments so it is clear what is going on, including a
missing word in the helper function.

Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://sashiko.dev/#/patchset/20260630-rtl8366rb-improvements-v2-0-05eb9d6a37f5%40kernel.org
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v2:
- Properly fix the issue by setting all isolation bits to 1.
- Link to v1: https://patch.msgid.link/20260711-rtl8366rb-fixes-v1-1-12b9210b0cce@kernel.org
---
 drivers/net/dsa/realtek/rtl8366rb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index d2fa8ff6a5d0..6d5a6e7bc5f1 100644
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
+						   RTL8366RB_PORT_ISO_PORTS_MASK);
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

