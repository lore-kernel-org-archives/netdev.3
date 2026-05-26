Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4A150997;
	Tue, 26 May 2026 05:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779774744; cv=none; b=Zrwuz12poSUEorkc3QxhcDXQBpZ5+uKkI0JdQcv+I5XGdpfrrjrDLMeotWKtUH8nsGdSG7SdZlwdbqLrq08tTsn4vXZhDv1rFW9IbBeYyGgiDSm81hRTw49spZ9onJ+rfZ7owtfkx/o4dnwXxGaktH3wOF08DvRlf2m7WTfUlJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779774744; c=relaxed/simple;
	bh=U6Uf8gD7jpIRXQOX34jo0SNl+xvkQ6aC8EQr/68qdQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HSEbd7095nGC74kbswmhQLnuOc/odqp5SIoyd8sq0O6tklMIp6S/tJkqAq4K0PWfjyqdhZK2gKl81Hi52KDg5zFIB6e9TjYj+Bk/7bzQD41fY8fZ8FENLOPJN51e7CF1qCkOvhOx47sH5AR+0/wFNERimeCOvXHcTCq1VWWsQBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=auzZ2kJG; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="auzZ2kJG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=E2
	bTdkxwgCOhmO5j4fNkWYF5jL+DpS/ehtig1jwq3Mc=; b=auzZ2kJG3zrbWI2fNP
	WvSHy+WnX0d/qJFDAAcCmtM5VBH3OwcUG6wLqc46t4OmWXLeQ96iZHanUXRdkfXP
	8Z1HmQSu+LD2rDzcCFV5T+CIC9U46cfUi05FPFUs7i9uBQNzkN1hEcKjfEG4fwYy
	xS1NgCVPzlGoz9DePetEJVgxI=
Received: from computer (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3_98BNRVqYPr3DA--.41794S4;
	Tue, 26 May 2026 13:52:02 +0800 (CST)
From: Wei Qisen <weixiansen574@163.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	avinash.duduskar@gmail.com,
	linux-kernel@vger.kernel.org,
	Wei Qisen <weixiansen574@163.com>
Subject: [PATCH v2] net: sfp: add quirk for OEM 2.5G optical modules
Date: Tue, 26 May 2026 13:52:06 +0800
Message-ID: <20260526055206.1750-1-weixiansen574@163.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_98BNRVqYPr3DA--.41794S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1UWw45tF1fCw1xJr4ruFg_yoW8Xr43pF
	W5Cwna9F93JF1Sya18AwsFkFyrWa42yFy0grWak3yruw45ua48Za4jqFyrtr1qvrs7Ga95
	KrsxGFyfArn0kF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRvD7sUUUUU=
X-CM-SenderInfo: xzhl5xpdqvv0qvxuqiywtou0bp/xtbC9wIt9GoVNQJ32wAA3I

Some OEM-branded SFP modules are incorrectly detected as
1000Base-X and fail to establish link on 2.5G-capable ports.

These modules do not properly advertise 2500Base-X capability
in their EEPROM and require forcing the correct SerDes mode.

Add sfp_quirk_2500basex for:

  - OEM SFP-2.5G-LH03-B
  - OEM SFP-2.5G-LH20-A

Both modules report:

  Vendor name: OEM
  Vendor PN: SFP-2.5G-LH03-B / SFP-2.5G-LH20-A

Tested on OpenWrt with successful 2.5G link establishment.

Signed-off-by: Wei Qisen <weixiansen574@163.com>

---

v2:
 - Use a proper real name in Signed-off-by
 - Sort quirk entries alphabetically
---
 drivers/net/phy/sfp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index bd970f753..7a865f69a 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -583,6 +583,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
+	SFP_QUIRK_S("OEM", "SFP-2.5G-LH03-B", sfp_quirk_2500basex),
+	SFP_QUIRK_S("OEM", "SFP-2.5G-LH20-A", sfp_quirk_2500basex),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
-- 
2.54.0.windows.1

