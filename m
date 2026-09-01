Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B930642C510;
	Tue,  1 Sep 2026 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276362; cv=none; b=RbeyWp0/QDT6MhR43KdkPVecFDFMJWNzrI+LhlnMh/9TtEWuAkrgqHQ0r+fKbtPBjs9bAg9ryUA6vrLJwgvXJAl+ZmbpTYexftuM96CxDKKvoXxdtZNDmsXHEbwBW3DGoPvXOFsOhk0dkOgv25UV41f4WowqBb5KMKFdNe/99Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276362; c=relaxed/simple;
	bh=PzNlY+by+eDKCG/gwwF8fl6eXncwrhWOt0N3k65Vymk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PREVBmPR7JOSsfruRoHEcN+4FrJqWES8We7WIS3VMCP8uqjT5MkebKW9ny/xTQGSrGGa5YPvWOmHKaHIX0nk4OL62W4HzyapW5Tq7FnadrPIWdpuj5QphERxF7IAXEpl4FQ7qqolBEUR8V/ReVZm+2bholC068gM/ZyK/PA856Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzmY0u5C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzmY0u5C"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7233BC2BCFB;
	Tue,  1 Sep 2026 15:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788276362;
	bh=PzNlY+by+eDKCG/gwwF8fl6eXncwrhWOt0N3k65Vymk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qzmY0u5CfTJeQMWCFoBYZQ3bRr1JxQiVT0fFnmcR/UFB7PKcol8rt1W3MwOmJXPFl
	 9H+fstjEzemBHWba4Qy3mZrCAbm+uJ27xB/rYukRqTcy97MXIb0xoqekEvqL6kXvAQ
	 2PjJt/5QdHeD8KNELAWEcH+D8k1enhlJ5MeVVvDuQdeqfK9UOufwge9C4vv37XCViW
	 keAsYelFvmqkX929yoR4fiCjEQb0NgyxzDaU43XGOBbvl9trRdhgPNxgTRbi3VOPb2
	 7cfpNRx+XLKYII6smTGbPR432AHx2oOTmrYSt55hw2v0WaDC/wDyKG917/lTAdJOY1
	 DKlda076WzlRA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B26C61DD6;
	Tue,  1 Sep 2026 15:26:02 +0000 (UTC)
From: Kyle Hendry via B4 Relay <devnull+khendry.reliablecontrols.com@kernel.org>
Date: Tue, 01 Sep 2026 08:25:14 -0700
Subject: [PATCH v2 2/2] net: pcs: rzn1-miic: Verify port number from dtb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-rzn1-miic-fix-array-v2-2-3e907049e770@reliablecontrols.com>
References: <20260901-rzn1-miic-fix-array-v2-0-3e907049e770@reliablecontrols.com>
In-Reply-To: <20260901-rzn1-miic-fix-array-v2-0-3e907049e770@reliablecontrols.com>
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hendry <khendry@reliablecontrols.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788276361; l=849;
 i=khendry@reliablecontrols.com; s=20260813; h=from:subject:message-id;
 bh=MhdDRNQknn2In7ONbA9ybldet9EPrQ6NvlgOYYQTM4g=;
 b=PDONzxbysOXtFlP/eLhwwV0o5qxPXT3oW1m5JDIuv5AbKKGB+X1XTBDh6CfwYbmjNLDQ2/0qW
 2EZLXU1tUwIBmldJn5youpLenDxmqqBHjHT+JMIYlfdW7n7m0xssT6p
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
 drivers/net/pcs/pcs-rzn1-miic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index c50b65d064fa..ebd73ed63896 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -692,6 +692,11 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
 		if (of_property_read_u32(conv, "reg", &port))
 			continue;
 
+		if (port < miic->of_data->miic_port_start || port > miic->of_data->miic_port_max) {
+			dev_err(miic->dev, "Port number out of range: %d\n", port);
+			continue;
+		}
+
 		if (of_property_read_u32(conv, "renesas,miic-input", &conf))
 			continue;
 

-- 
2.43.0


