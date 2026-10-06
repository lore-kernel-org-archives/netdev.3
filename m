Received: from 17.mo583.mail-out.ovh.net (17.mo583.mail-out.ovh.net [46.105.56.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB993BCD17
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.56.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296243; cv=none; b=Lv9hU2v4yNW3OQajSwLhz/Knqc0Nd3Fr4k1DsT/UkcGFOV6TNDtsQt/9uvLmx2bu5YnmahW0In0RfCO2UA0QJ/3U1bZYvrZuk+cnFVvlNVWg3CC/hp83tbef1sSCc08/5u5OEh8tXoPHhygKNka6Ea6FeMlD2qxJmuX93AQlvvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296243; c=relaxed/simple;
	bh=rb2BzlRoguhH0x2DJqZd9W6s7BpPwPvkPjSjwAGRIFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q++czAxC9QPDfW1SywBeyqZSJfIdztIxhnffxDUFU84laq0XwLJD4nxZmRFJyRQaKXd9fRe7ttTvT0hfqun3Xdh+Zt+/shBg6qblg47UpzfVtnU6b1u5yzKttvgmRRIsWFRiinDdi2gPOYJOI8VHTVBdWDGxS0xUzyyc6pLEBSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armadeus.com; spf=pass smtp.mailfrom=armadeus.com; dkim=pass (2048-bit key) header.d=armadeus.com header.i=@armadeus.com header.b=qwXyxSVC; arc=none smtp.client-ip=46.105.56.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armadeus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armadeus.com header.i=@armadeus.com header.b="qwXyxSVC"
Received: from director2.ghost.mail-out.ovh.net (unknown [10.109.231.137])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4hzbvg73cNz5y9m
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 13:00:15 +0000 (UTC)
Received: from ghost-submission-c7b579475-9hkk9 (unknown [10.110.164.11])
	by director2.ghost.mail-out.ovh.net (Postfix) with ESMTPS id B04CCC077E;
	Tue,  6 Oct 2026 13:00:15 +0000 (UTC)
Received: from armadeus.com ([37.59.142.111])
	by ghost-submission-c7b579475-9hkk9 with ESMTPSA
	id bUOXHN/wxGrQxCEAaPDjVg
	(envelope-from <sebastien.royen@armadeus.com>); Tue, 06 Oct 2026 13:00:15 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-111S00576d3690f-83d4-4753-894d-aa616fdcf9de,
                    00DBEBCA2080E92057B1718008C39CF3BF911D1E) smtp.auth=sebastien.royen@armadeus.com
X-OVh-ClientIp:88.175.232.176
From: Sebastien Royen <sebastien.royen@armadeus.com>
To: Woojung Huh <woojung.huh@microchip.com>
Cc: netdev@vger.kernel.org,
	Sebastien Royen <sebastien.royen@armadeus.com>
Subject: [PATCH net] net: dsa: microchip: fix KSZ8765 fiber detection
Date: Tue,  6 Oct 2026 15:00:06 +0200
Message-ID: <20261006130006.134847-1-sebastien.royen@armadeus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 17356591491558552628
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE1sDgPdOBGN02tLPHmfM+2pn7ViY3fQrQwplPLoWXUd2rMv0xw2rvcHpo4qS9WjWSHsET6fkeBzSpa/3yjP+ehiwolquLOa2TBmQhPPI/RfBBCkHjzTkT66i6xYTtnS2MDl85IucLRyMJ6PHAkD4oF5ht6ewCNCEQzDwR6wZQOkzTEa8IcR2Bues5TZg/nyvUCDkTjiNyvt40RX2I21zm+JHw3fm0a4Wn3RjlE39OrcRNUjAJexpIUyVNqsIj/TP7gegqaRR/BCqrupOC3yIULaqvBazZM5/V1hXIBYVjoY8PqctjelIe2HocWmDz7yVvpM5smYN6+kADWXojuDKaJr+XkzDUbWjSFUMgow1ahrYlTkwQQHnBYTA/j5xRFxO3hfCpT3fL5OpXdcNUaYxiVVkcEOK4pSa0N6Sp38HEER+LRE6tCnPskOHAZofimiAEHs93OirdjDor/skd5h5T6/+B0umgfKA3mXmWGt8+8LoeKHBKC9D3qbg02js7o9F4wqLWsDntLUeNWuUWJfwHFdakhmIDYByK9hPo8Np1SXVNCt2cveJ+KSDLqcPcpOUUFxTWtZiXgBVKJ4M4NZV/NB1a+OoN802YUJ2tZeVf6P5w9M3zeFDSvPqRdos9C1cCNs5hATiG8cQ3FvvH/8iddrTcqiQfToeLHmxsFm72TVg
DKIM-Signature: a=rsa-sha256; bh=RTQwJbEDbMmGS8q2OKkGFT+lsynyuh5HwSRXwHrd+10=;
 c=relaxed/relaxed; d=armadeus.com; h=From; s=ovhmo103079-selector1;
 t=1791291616; v=1;
 b=qwXyxSVCVDevSosmFT89rfhWEuPNxi4Ijt37WGB3uHJjKVrdpKg4YM2zIv9S1v2MBSqp5mFE
 1qO2eLh6upKuWHMs4K2KwccKgMDCnXKrVt0ftTUJd79fvVfpHa1iT7KMhvklNhobeoE+1t/0UDY
 nXj2LXNVb6yM0rcSE7jmwAav+6eYteZ+ROOGTefJjnuA+H+qqQCmJlXBWfequJCnAW2nPoa7eiT
 OJjI65USzuD5QcxgCqGrwdY03mL6kP/TgpNCXi+bfrWxpeLx8Gojlcio7LbBCN4uiUxMFjya3A/
 +M7tYpuKetlOjJO9W3ae0pKpQim5Q66qwLVFoauySJnkA==

The KSZ8765 is similar to the KSZ8795 but has two fiber ports.

KSZ8_PORT_STATUS_0 is used to detect fiber mode. It is currently
defined as 0x08, which is the Global Control 6 MIB Control register
and has bit 7 defined as Flush Counter.

Set KSZ8_PORT_STATUS_0 to 0x18, which is the Port 1 Status 0 register
where bit 7 is the Fiber Mode bit.

Signed-off-by: Sebastien Royen <sebastien.royen@armadeus.com>
---
 drivers/net/dsa/microchip/ksz_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index cbe98494578c..f6104f714a8d 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -853,7 +853,7 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 #define KSZ88_FAMILY_ID			0x88
 #define KSZ8895_FAMILY_ID		0x95
 
-#define KSZ8_PORT_STATUS_0		0x08
+#define KSZ8_PORT_STATUS_0		0x18
 #define KSZ8_PORT_FIBER_MODE		BIT(7)
 
 #define SW_CHIP_ID_M			GENMASK(7, 4)
-- 
2.43.0

