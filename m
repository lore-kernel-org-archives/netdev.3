Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793704904;
	b=XMbCwFmw9UYlQf3UmscuI+B4P9IOGmAK3es67YdEYQqMdgoSOtH8FEGRf15Z4qVSElNr
	 oGYFiuHz3c/O+1LypzKgKap1yGyu8kvE7S9h5qn+Ua9m27oxH4f2TyvHMRYo+r10O6oJT
	 uOTaqfoJibO67RclYRv8RM0bavKIWCSNNLuPEXbAshPupHNkxR6O8SazlqHj2a3Fd838g
	 pCJeUwAtl7vdRbL+j/KLoaDc7+S9/fR6nP05yQcucVbdgwEtlo1DySf3Zel2IvRQjuIBX
	 ZC5aH0JKQl6JDpnPn4EELN5ENmbyUClNy0u0OvcboI/kxXrjYSKsEsnTUP5rjILH/3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704904;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=V34uxMVe9jDq8QPqJvTsPQf+9XAKFhb+6w+U11rwbYo=;
	b=Zrjx5ryEyLmhnHok7xIRt8HgKok70pUP/I/XC4dXDotCuB+Nx1kPYnUXm7yfg2SA1MeW
	 FVnZjX4MerjfH5lBM3IPLZjzxsR2Lb+39SDeZ82rFH2eEclho6Psq33vg2AVvsidveuPe
	 6WSLsKE34+oz5Upk4G7Qk4hZkAQe1/5bruA9M/0WDxyto9HQp0CqPHigOVIA7D8iFSKfq
	 Mpo+FXiE2CvX0R0BJwtUI/qcVZnm+CtwJASvjYa0RLpBNaUPwvoKt3KDQe0+lBhReDkYF
	 BCYCLeeAYgPn4jS8wbbcctXz7iVUlDqS7eD+bJYHhrngK/aj9kM956kNVx+JCmRgmYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPA70lQr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9412A606B113;
	Tue,  3 Nov 2026 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPA70lQr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793704904;
	b=jYR98kH9Tdp2vrF0l5/G4hqJz8evn54Fd4xEDgFjOAJB04KHsdRkxtfSXjriuVYu7BfJ
	 tuwHjRcgLU0BpXLjXbKESYJnajakfExQ5eIoJQWPS6oMgm6qjrfeGvL1sb+i8qqqb+5b5
	 dhjQ/Awns3sIER7rFqQUjdS+8RCQfCABs0COpP62Ll79AM3Er/qt8fKPWvJNe89jwxnC7
	 Tg9bukDlyyMDvtMOhF7ChCtcAsDiyuYeN6gfem4dyM4lnOxzNf9A3a7gtpGeqOjFxBdd6
	 XRz+hNCTRtnW68NncSu+PARhrnztuOvRdaNMXdiCaszFzrGiKy0jHvFjbzZIYSkRjOw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793704904;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=V34uxMVe9jDq8QPqJvTsPQf+9XAKFhb+6w+U11rwbYo=;
	b=oND9+sgGrwtEX0REFw1yapxkMKP3UxBwshIciA7pRZqXWOU0RI+M6OJuNey82lW98ocb
	 TwXlb8QL1USoi6yVtmfdBgsp/Cs8tf9K1CncJA/+1crAUJ82RCvl6eyhZGv+8VqxJL4yo
	 a8Wo4zmzJ8TbTI5LblO+1X99NOziGKzrXY0gbXWjCdhhHj/yklUfSCNmThBHFoYd/S1CX
	 qfQE0G4Z4nRtFm8NHvVoIUswrpqMnAQGZclOeP+rtxl3jC01sj4t8hlWhqgQ4vuEY5vJi
	 2dgh5uwitBW+WZ0M2qf3iTrtWCzDos7hYa5QpK9RqLAgrVVeNL75CCAKDVlfp+uYxOw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BE03B1F000C1;
	Tue,  3 Nov 2026 11:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704904;
	bh=V34uxMVe9jDq8QPqJvTsPQf+9XAKFhb+6w+U11rwbYo=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=FPA70lQrmZifFaDysXBryNGjWVhkZm2aPiUYSbw5uhlhZw/Y3QSoInooZKg+BYlQL
	 NZXq9IOvMg1FK5xyr3vrTeUeru/wooRenDM4FPVF97DXb18ceS96QG1z2nuAw3r2Vd
	 V7ostnvf+8em3i2MJelkn7yj5RElbC6bJQfaYr8Kuo3SAmRlmV/c/xKVu+eHVBsbgI
	 38fIGg0Rh78hYrRpkIBgerIjMndWJDeWKv56TZa0Nw+LjJeeqN8wJJwzUlk6QUcuD0
	 N83wWabZ/ME2X16CEMD36DkSjX1mKr8c6RUxaMk0nWGylrHBf2ToVg8MQjkl8KNbXm
	 xGLXTNOXTxJNQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1AA83468F0;
	Tue,  3 Nov 2026 11:21:43 +0000 (UTC)
From: Hleb Shauchenka via B4 Relay <devnull+me.marleb.org@kernel.org>
Date: Tue, 03 Nov 2026 12:21:28 +0100
Subject: [PATCH net-next] net: phy: realtek: register hwmon thermal zones
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
Message-Id: <20261103-realtek-hwmon-tz-v1-1-e672723c58cb@marleb.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMTQ7CIBBGr9LM2omFRg1exbgAnJZROzWA2tj07
 oIu3/fzFkgUmRIcmwUivTjxJAXUpgEfrAyEfCkMutV7pdoOI9l7phuG9zgJ5g+ane4O1mjlegP
 l9ojU8/xTnkAoo9Cc4fxv0tNdyedqrFtnE6GLVnyo0RR5YNmOlgXW9QvB0NILnAAAAA==
X-Change-ID: 20261103-realtek-hwmon-tz-95237a921bf9
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hleb Shauchenka <me@marleb.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627; i=me@marleb.org;
 h=from:subject:message-id;
 bh=9hvSTTecMqQziEV6E78tCmsz2y2K7B9KUH/zpfgTUOU=;
 b=owJ4nJvAy8zAJTZJnM368y8lXsbTakkMWS8PH2PdqePhNNGyaVbYOdG5i/anTGac78htv0Z2+
 rqesmXPk3g6SlkYxLgYZMUUWTY1F4k+XRn91rV6TxbMHFYmkCEMXJwCMBG9Pob/WXPzrKy3R6RV
 SszQ1U08+kljzYc9X/T2a19Nt91jcjP8OcM/m7TpLDZb3n2ffDBDNMqb0+5teo8J/3aLOqXEz9/
 9JRg5AQg5RrQ=
X-Developer-Key: i=me@marleb.org; a=openpgp;
 fpr=B2837215E5A95BED457BBC6A9217063BF3FA220D
X-Endpoint-Received: by B4 Relay for me@marleb.org/default with
 auth_id=1394
X-Original-From: Hleb Shauchenka <me@marleb.org>
Reply-To: me@marleb.org
Content-Transfer-Encoding: 7bit

From: Hleb Shauchenka <me@marleb.org>

The Realtek PHY hwmon device exposes the PHY temperature, but its
channel info lacks HWMON_C_REGISTER_TZ, so the hwmon core does not
register the sensor with the thermal framework and device-tree
thermal zones that reference the PHY cannot bind.

Set the flag, as the Aquantia PHY driver does. This lets the RTL8261N
sensors on the Zyxel XGS1250-12 B1 drive the chassis fan through
thermal cooling maps.

Tested on a Zyxel XGS1250-12 B1 with OpenWrt's Linux 6.18.55: the
three PHY thermal zones register, and an emulated 85 C reading on one
of them (CONFIG_THERMAL_EMULATION) switches the fan on through the
existing 80 C trip and off again once cleared.

This patch was prepared with AI assistance (Claude Opus 5.5 and Sol
6.1), which also helped investigate the problem and run the tests on
my switch.

Signed-off-by: Hleb Shauchenka <me@marleb.org>
---
 drivers/net/phy/realtek/realtek_hwmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/realtek/realtek_hwmon.c b/drivers/net/phy/realtek/realtek_hwmon.c
index ac96e2d1e..e6235df28 100644
--- a/drivers/net/phy/realtek/realtek_hwmon.c
+++ b/drivers/net/phy/realtek/realtek_hwmon.c
@@ -51,6 +51,7 @@ static const struct hwmon_ops rtl822x_hwmon_ops = {
 };
 
 static const struct hwmon_channel_info * const rtl822x_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX),
 	NULL
 };

---
base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
change-id: 20261103-realtek-hwmon-tz-95237a921bf9

Best regards,
--  
Hleb Shauchenka <me@marleb.org>


