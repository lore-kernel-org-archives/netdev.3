Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216DB30F547;
	Wed, 20 May 2026 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290208; cv=none; b=GepzmBNi9Ct0N+8n4QeBE/xGEOpAv0hPWG+tK/rkE5cZcIkS95j4hHbRDyXpzd9R/wsLIK2UA9LDsC7SfOsnF9tsnE+EUiqQ1+3zp3cFojMoFsqaSWXu/0yzJzI6ixPCra73+f34RN0AXrAej32HEuiULbcu0hCFXZ6LZZv5xQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290208; c=relaxed/simple;
	bh=aZ5IZZoW0dBNQUdAcAhYjJx+cBXakC6q5BoauhT3H7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uiuswfLNsMeDxO5mB0dw3/QNqTcWCZm9fdoWvm/W7WqYV1pXgzD0/Li4WtckGWKjyZ65BFDqe5MLdQigZ+8tcd5Vtzah6GM7BdbzZTyQImyCAfdr1hRf0iHN85ygdBurVLlHA4KcDsZe2lkJcfd63ieLuJtzCcImrQF5ciZ0DDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lUIooypV; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lUIooypV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=8Z
	2AzXHUKT2H2omvy06BjkSlm4zeHIifUYtRGSXDfG4=; b=lUIooypVuewvsKTWtj
	LZclr9Ac+VMNEzUSeAQOxfVW1jTk+7R/bCaKbVSAJL8GlwtJPWD6VAo2BFlYPdZd
	Htnp7CQC1XRgddEIcynZmjakg5aO6QDkCnPr5p739nfEBCUYwYlp/muuYZrt2FUe
	xKu4cdV8kjXXGW0gUm3++yP98=
Received: from computer (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3_2JM0A1qNByPCQ--.11347S4;
	Wed, 20 May 2026 23:16:29 +0800 (CST)
From: weixiansen574 <weixiansen574@163.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	avinash.duduskar@gmail.com,
	linux-kernel@vger.kernel.org,
	weixiansen574 <weixiansen574@163.com>
Subject: [PATCH] net: sfp: add quirk for OEM 2.5G optical modules
Date: Wed, 20 May 2026 23:16:29 +0800
Message-ID: <20260520151629.905-1-weixiansen574@163.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_2JM0A1qNByPCQ--.11347S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1UWw45trykAF4kJw1kKrg_yoW8GF4UpF
	W5Cw1S9F93tF1Sya18Aw4DCFyrWa47AFyFgry2k3yruw45u3W8Z3WYqFyrtr1DZrs7GFWD
	GrsxGFyfAr90kr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRBc_-UUUUU=
X-CM-SenderInfo: xzhl5xpdqvv0qvxuqiywtou0bp/xtbC2w0l7GoN0E0WiAAA37

Some OEM-branded SFP modules are incorrectly detected as
1000Base-X and fail to establish link on 2.5G-capable ports.

These modules do not properly advertise 2500Base-X capability
in their EEPROM and require forcing the correct SerDes mode.

Add sfp_quirk_2500basex for:

  - OEM SFP-2.5G-LH20-A
  - OEM SFP-2.5G-LH03-B

Both modules report:

  Vendor name: OEM
  Vendor PN: SFP-2.5G-LH20-A / SFP-2.5G-LH03-B

Tested on OpenWrt with successful 2.5G link establishment.

Signed-off-by: weixiansen574 <weixiansen574@163.com>
---
 drivers/net/phy/sfp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index bd970f753..6f3213793 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -583,6 +583,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
+	SFP_QUIRK_S("OEM", "SFP-2.5G-LH20-A", sfp_quirk_2500basex),
+	SFP_QUIRK_S("OEM", "SFP-2.5G-LH03-B", sfp_quirk_2500basex),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
-- 
2.54.0.windows.1

