Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8113C3F9F5C
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818399; cv=none; b=RSRWEArofXwU/bVTLh/1z38JedFeToMEyD2umzDE5evTSe2JC5okL9aESiFLuEFsCWmDBZI10N/ilnZdnugarpitcXXvq0Q6UkzvNIX/efZBWjwbXOKFovOqh1rPshgBki9wiw3/ET4IwcLCbZZ54dG8OOusiAcm+twYmHGeLQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818399; c=relaxed/simple;
	bh=Y6wEqE2aBmlLhrwG0GaAOGYINDlF/0Iupi1sNENpE2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I/2mTE0Dv/WIgEhy1xg2FcX38E1CD9xf5CtqjQopAwOjkT36NtlADaoenHL9duWqYZ7RR7j2vdpOzQW8jPs90Fcdv2mgwVy16iEVT2ZbMippac9uE+5Rif2yRnO2kRM5V4YC+a+9o9EgXnDplyes2uAsv7zJo8998G685Dnanj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCPEqwhs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCPEqwhs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BC91F000E9;
	Tue, 30 Jun 2026 11:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782818398;
	bh=xDEEGaIN1uZR83MvzuYLWvGy2/5sBNkkAGwMawkT3fc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FCPEqwhsnloI42mNuQzaGhJj+zwCUTVtRtcAq0m0JrbDlffwWFTFpsq1f37e/eotz
	 Q/KoEkD2Hf4g1BYdSYNU/dsOBHwFwbfBbraYlhONG8UrkyMBJTijAmKDqeKhZ/MXx4
	 gDYkv5HS6N5PR1RDwNYFliGv/Vs+zZfmEKcXPSi80u8UPSMRZC1yTQMxAUv27ICcbc
	 eRiGLcM2I3dEjeaSNgv/WjsEUNvBP47m3Q4jRSlAMMGPhhLF3PAf2XiFCdkIY8zyGI
	 NuxDaGAtkqOIJ9tSaayJGpCutH0e4pkzzMD6GHFOWU97ShhqlJkKx+nAZu6b6acGE6
	 pvurx2lv6XpfA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 30 Jun 2026 13:19:43 +0200
Subject: [PATCH net-next v2 3/5] net: dsa: realtek: rtl8366rb: Use DSA port
 iterators
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-rtl8366rb-improvements-v2-3-05eb9d6a37f5@kernel.org>
References: <20260630-rtl8366rb-improvements-v2-0-05eb9d6a37f5@kernel.org>
In-Reply-To: <20260630-rtl8366rb-improvements-v2-0-05eb9d6a37f5@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2

Instead of custom loops for intializing the ports (including the
CPU port) use the DSA helpers dsa_switch_for_each_port() and
dsa_switch_for_each_cpu_port() following the pattern in RTL8365MB by
accumulatong masks for the upstream and downstream ports.

This gives us similar enough code to the RTL8365MB that we
can start using more generic rtl83xx helpers.

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/rtl8366rb.c | 49 +++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 8b57ef3bf03a..64215a0d5d6d 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -824,7 +824,10 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
 	const struct rtl8366rb_jam_tbl_entry *jam_table;
+	u32 downports_mask = 0;
 	struct rtl8366rb *rb;
+	u32 upports_mask = 0;
+	struct dsa_port *dp;
 	u32 chip_ver = 0;
 	u32 chip_id = 0;
 	int jam_size;
@@ -895,17 +898,47 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
-	/* Isolate all user ports so they can only send packets to itself and the CPU port */
-	for (i = 0; i < RTL8366RB_PORT_NUM_CPU; i++) {
-		ret = rtl8366rb_port_set_isolation(priv, i, BIT(RTL8366RB_PORT_NUM_CPU));
+	/* Start with all ports blocked, including unused ports */
+	dsa_switch_for_each_port(dp, ds) {
+		/* Start with all ports completely isolated */
+		ret = rtl8366rb_port_set_isolation(priv, dp->index, 0);
+		if (ret)
+			return ret;
+
+		/* Collect CPU ports. If we support cascade switches, it should
+		 * also include the upstream DSA ports.
+		 */
+		if (!dsa_port_is_cpu(dp))
+			continue;
+
+		upports_mask |= BIT(dp->index);
+	}
+
+	/* Configure user ports */
+	dsa_switch_for_each_port(dp, ds) {
+		if (!dsa_port_is_user(dp))
+			continue;
+
+		/* Forward only to the CPU */
+		ret = rtl8366rb_port_set_isolation(priv, dp->index, upports_mask);
+		if (ret)
+			return ret;
+
+		/* If we support cascade switches, it should also include the
+		 * downstream DSA ports.
+		 */
+		downports_mask |= BIT(dp->index);
+	}
+
+	/* Configure CPU ports. If we support cascade switches, this will also
+	 * include DSA ports.
+	 */
+	dsa_switch_for_each_cpu_port(dp, ds) {
+		/* Forward to all user ports */
+		ret = rtl8366rb_port_set_isolation(priv, dp->index, downports_mask);
 		if (ret)
 			return ret;
 	}
-	/* CPU port can send packets to all ports */
-	ret = rtl8366rb_port_set_isolation(priv, RTL8366RB_PORT_NUM_CPU,
-					   dsa_user_ports(ds));
-	if (ret)
-		return ret;
 
 	/* Set up the "green ethernet" feature */
 	ret = rtl8366rb_jam_table(rtl8366rb_green_jam,

-- 
2.54.0

