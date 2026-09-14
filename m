Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292EA48CD6D;
	Mon, 14 Sep 2026 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789404063; cv=none; b=gnOZoq4JIfKfeh4KpHn5DvC+EZLzw9NMLfE27ggV9YAWT7Sc98HfNbf/lBoXwLCf6Fgrvu4RhP0a6mjwtOQ00qzyqoGa38elGRJrZ4Rsrj5GikaPGeFeLZpiA+NGuVEmH8LE2gNfqkml3mhqffd1Du9uhU8sc8v7IshfhO+u6AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789404063; c=relaxed/simple;
	bh=KlHJnK4l0GL6mKiQ0QksbC/TmEnpv+GpBJpUvC8dG1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=goWvbrkc+KWd/AS6NvW9QkjGtmU0TEJZBjNk5ynNj+djEwxmIHS+NxRYAdtEuFOdPLtzJ6eOMaHhjXD4ABbIrUj2HRfjUx0qFPbTr/6Ebc7odSV5chhAJSjz2TJr2dyswsHsgO/YUeNsfj1akxy61QrRq0Cq4W9iZiQ4/8k2da4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEQmasCz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEQmasCz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D858C2BCF5;
	Mon, 14 Sep 2026 16:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789404062;
	bh=KlHJnK4l0GL6mKiQ0QksbC/TmEnpv+GpBJpUvC8dG1g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OEQmasCzQsn6+EFsDWJmIhY9eu3V+yqhz6gzYavFlyVP5x8sNdQ3yN8ZfyFSxp+Qi
	 FLdsOslTfhy/IWwR8DUE0LAwwULunDQeZWH/yOGtS18LgH5AKVdoyK8qHUeIxd4B4E
	 6q4Xoso5jgiz9446iV5jAO01JkfuhV7fkLmVvnWcw/ktntlnxJLR98XLpheV5sa1QE
	 jH5enSdx2/8MNIbL4NLZ78a85f45WNPpZcc6/aLkMnYOy72T0ekl6JTXl39jdlMXRq
	 clbGgCGmawUooZHOaDrj62rKyQytpkOSF4hujhHx4OKh5sRrgYEXnnEQaylTcjDYSC
	 L09QHt7J47X5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D92C88E6F;
	Mon, 14 Sep 2026 16:41:01 +0000 (UTC)
From: Kyle Hendry via B4 Relay <devnull+khendry.reliablecontrols.com@kernel.org>
Date: Mon, 14 Sep 2026 09:41:01 -0700
Subject: [PATCH v4 2/2] net: pcs: rzn1-miic: Verify port number from dtb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-rzn1-miic-fix-array-v4-2-069112feec86@reliablecontrols.com>
References: <20260914-rzn1-miic-fix-array-v4-0-069112feec86@reliablecontrols.com>
In-Reply-To: <20260914-rzn1-miic-fix-array-v4-0-069112feec86@reliablecontrols.com>
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hendry <khendry@reliablecontrols.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789404061; l=910;
 i=khendry@reliablecontrols.com; s=20260813; h=from:subject:message-id;
 bh=gR9n2wNMo/iMx5ArDsKUpiwBi7ZEib9TYLg7U6AV6BM=;
 b=EEMLgsCGJLg4SkTncIuLQ8I/sN407Z50po/zNnR0TPXme6UPqbtzob4P+skCXTWj2PwFS/D1j
 P7WYyP6t63gAGXiit701EQKn8j3bz6WHb3WhQH4X0KXuDuuDHE3O54K
X-Developer-Key: i=khendry@reliablecontrols.com; a=ed25519;
 pk=gbK6oghz3qBlBiaGCsEzALLOtj5VklmsuolHQNhDV5M=
X-Endpoint-Received: by B4 Relay for khendry@reliablecontrols.com/20260813
 with auth_id=946
X-Original-From: Kyle Hendry <khendry@reliablecontrols.com>
Reply-To: khendry@reliablecontrols.com

From: Kyle Hendry <khendry@reliablecontrols.com>

Add check to make sure port number is in range before writing
to dt_val array

Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
---
 drivers/net/pcs/pcs-rzn1-miic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index cb74861e823c..1bd95ddf9400 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -693,6 +693,14 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
 		if (of_property_read_u32(conv, "reg", &port))
 			continue;
 
+		if (port < miic->of_data->miic_port_start ||
+		    port > miic->of_data->miic_port_max) {
+			dev_err(miic->dev, "Port number out of range: %d\n", port);
+			of_node_put(conv);
+			kfree(dt_val);
+			return -EINVAL;
+		}
+
 		if (of_property_read_u32(conv, "renesas,miic-input", &conf))
 			continue;
 

-- 
2.43.0


