Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF3E5221D2;
	Wed, 14 Oct 2026 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992022; cv=none; b=BquoD4pMLhvHgmqosNv2uS7LVkMDcWkScDaUa1DMo+Rbio8CPei+GHfkbr8d0FswWjBCB5NuaPsVKqsPsZMl1ikTMOLDI8k1FQHlXxNK5+SEdEg3LJjsrcoHiv56abDXEifVsNBmW/N4lJSabf8xKsL7/shU6BZ1GeVqu8gT6cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992022; c=relaxed/simple;
	bh=mCzFXLETsN+vfmSxRdcufoaEoveqY9nl4uYUnNCGmQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UHuvq3t86fXqXdMy/08eUWl6Hlgmq2s2byv48do2fgAMOX6DU/PIsughideEO/3Pj/EPVqSjVhShhlNjZiUJNanofwOoy54gTbbLh6eTLSvCekkv3rLFyXDme4cn3CW5FYp6FfbdtXO1K3sglE0YHViOihyzsl28Z2Maq22fsGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBw6gf8U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBw6gf8U"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4E77C2BCC7;
	Wed, 14 Oct 2026 15:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791992021;
	bh=mCzFXLETsN+vfmSxRdcufoaEoveqY9nl4uYUnNCGmQ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oBw6gf8U6gQTGUMJlLN6vO8UzW7PSRb1ti5oEZgE1svFchvE2gvYiTY/yGLOxUp7t
	 IzN4vW2SqyE9BFjruos8WcLfex+73AV52llWSGwCSETD0XXs34Z4bJZBvFuXSdmFWG
	 iHs6Eec6j4eZ0MKPFwOax6QOHvdZQciY12OeraBSXaurfB4F0SQBd0MBHCuXZriWYA
	 RkoiSqOCERfYChCUoPjHlRUwJwaNcmBjn/dA+teXUAX+ugWo7oWpjBRbnhWAlQ2ITe
	 RvTHaHjhB/WncCBUxgijXCWX/sgOKPg37tI4VJQOBdy2a/UQxfp1hifXsqN3udyu4z
	 WcG5VG9ub2esw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820F9CC6B29;
	Wed, 14 Oct 2026 15:33:41 +0000 (UTC)
From: Kyle Hendry via B4 Relay <devnull+khendry.reliablecontrols.com@kernel.org>
Date: Wed, 14 Oct 2026 08:32:37 -0700
Subject: [PATCH net-next v4 1/2] net: pcs: rzn1-miic: Update port numbering
 for RZ/T2H
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-miic-validate-dtb-v3-v4-1-b7da71b3a106@reliablecontrols.com>
References: <20261014-miic-validate-dtb-v3-v4-0-b7da71b3a106@reliablecontrols.com>
In-Reply-To: <20261014-miic-validate-dtb-v3-v4-0-b7da71b3a106@reliablecontrols.com>
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hendry <khendry@reliablecontrols.com>, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791992021; l=3420;
 i=khendry@reliablecontrols.com; s=20260813; h=from:subject:message-id;
 bh=NbAhI/930UTKOHE1+KiQcIf4bFDLOz50/D7XQzywphU=;
 b=YJZwhw1N9i08o1HJNveHFRMf1fvUUTPq0YhmUirjWvd3QS8iYftyvznPKQRdV4KxbbEEabmUZ
 VfFz+Ztu7HGA+SVmPg8xxN+Z/A6ZgdIgEjldRc+4qovlcBU5H7MuSI/
X-Developer-Key: i=khendry@reliablecontrols.com; a=ed25519;
 pk=gbK6oghz3qBlBiaGCsEzALLOtj5VklmsuolHQNhDV5M=
X-Endpoint-Received: by B4 Relay for khendry@reliablecontrols.com/20260813
 with auth_id=946
X-Original-From: Kyle Hendry <khendry@reliablecontrols.com>
Reply-To: khendry@reliablecontrols.com

From: Kyle Hendry <khendry@reliablecontrols.com>

The port numbers on the RZ/T2H are documented as 0 to 3. Update the info
structure and change the member name to miic_port_last to be more accurate.

This value was being used as the number of miic registers when setting
default values. Add logic to get the total port count and loop over that.

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
---
 drivers/net/pcs/pcs-rzn1-miic.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index 3aa513467060..31716241b58f 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -222,7 +222,7 @@ enum miic_type {
  * @index_to_string: String representations of the index values
  * @index_to_string_count: Number of entries in the index_to_string array
  * @miic_port_start: MIIC port start number
- * @miic_port_max: Maximum MIIC supported
+ * @miic_port_last: MIIC port last number
  * @sw_mode_mask: Switch mode mask
  * @reset_ids: Reset names array
  * @reset_count: Number of entries in the reset_ids array
@@ -240,7 +240,7 @@ struct miic_of_data {
 	const char * const *index_to_string;
 	u8 index_to_string_count;
 	u8 miic_port_start;
-	u8 miic_port_max;
+	u8 miic_port_last;
 	u8 sw_mode_mask;
 	const char * const *reset_ids;
 	u8 reset_count;
@@ -485,7 +485,7 @@ struct phylink_pcs *miic_create(struct device *dev, struct device_node *np)
 
 	miic = platform_get_drvdata(pdev);
 	of_data = miic->of_data;
-	if (port > of_data->miic_port_max || port < of_data->miic_port_start) {
+	if (port > of_data->miic_port_last || port < of_data->miic_port_start) {
 		put_device(&pdev->dev);
 		return ERR_PTR(-EINVAL);
 	}
@@ -523,6 +523,7 @@ EXPORT_SYMBOL(miic_destroy);
 static int miic_init_hw(struct miic *miic, u32 cfg_mode)
 {
 	u8 sw_mode_mask = miic->of_data->sw_mode_mask;
+	int num_ports;
 	int port;
 
 	/* Unlock write access to accessory registers (cf datasheet). If this
@@ -538,7 +539,10 @@ static int miic_init_hw(struct miic *miic, u32 cfg_mode)
 	miic_reg_writel(miic, MIIC_MODCTRL,
 			((cfg_mode << __ffs(sw_mode_mask)) & sw_mode_mask));
 
-	for (port = 0; port < miic->of_data->miic_port_max; port++) {
+	num_ports = miic->of_data->miic_port_last -
+		miic->of_data->miic_port_start + 1;
+
+	for (port = 0; port < num_ports; port++) {
 		miic_converter_enable(miic, port, 0);
 		/* Disable speed/duplex control from these registers, datasheet
 		 * says switch registers should be used to setup switch port
@@ -825,7 +829,7 @@ static struct miic_of_data rzn1_miic_of_data = {
 	.index_to_string = index_to_string,
 	.index_to_string_count = ARRAY_SIZE(index_to_string),
 	.miic_port_start = 1,
-	.miic_port_max = 5,
+	.miic_port_last = 5,
 	.sw_mode_mask = GENMASK(4, 0),
 	.init_unlock_lock_regs = true,
 	.miic_write = miic_reg_writel_unlocked,
@@ -841,7 +845,7 @@ static struct miic_of_data rzt2h_miic_of_data = {
 	.index_to_string = rzt2h_index_to_string,
 	.index_to_string_count = ARRAY_SIZE(rzt2h_index_to_string),
 	.miic_port_start = 0,
-	.miic_port_max = 4,
+	.miic_port_last = 3,
 	.sw_mode_mask = GENMASK(2, 0),
 	.reset_ids = rzt2h_reset_ids,
 	.reset_count = ARRAY_SIZE(rzt2h_reset_ids),

-- 
2.43.0


