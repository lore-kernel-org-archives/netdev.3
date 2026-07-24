Received: from mailhub15-fb.kaspersky-labs.com (mailhub15-fb.kaspersky-labs.com [46.165.235.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928D54908B5
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.165.235.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896175; cv=none; b=BcVVUU0QbOV/71DwnivycMBXKNnACPivOLzhKsdSQiOQ6tCnP3naFvqzmxTP7DOXs9cI8ReIGszXO6s076dA2Ctdn/zctSTxWEN2To2/88L0PEEq1gc2VsYGL7VF4RjNwh9/wFn8wHaYYZNf+QVmf/Rwdz4qmLxbaZc21wm+zzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896175; c=relaxed/simple;
	bh=UhbQjvMQo0uJ6MIOWE5uBC4n4hLujytOl7CRJqNl0IY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cPpAe+oKYqvjypdwBCRb02oioE+2MeUi3ISSDAbMHcZEjV99ezn4anQTbpV9zfRqficLwDuAIp9lWF4vRWCPape8qKIutUhIz57IN1PYyPkVOY0baQelQrbWkLiqOM5TzvRbfz7cDNT1hVt6A6fDghv1BEvdj9tlMMv/3BkBCQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=Zk1G+u8q; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=HWiHCyqC; arc=none smtp.client-ip=46.165.235.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="Zk1G+u8q";
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="HWiHCyqC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1784895763;
	bh=4q7KoWuSKi/YldkaoLnG0pIBnVs8iJeEAHdJKQyj2Do=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Zk1G+u8qvZ+IQpxlOmkknLmdQzKRdGu7ln86aI7cQrUjqENXHVigY69Q/Hpq+DMhe
	 pxCGWMKnbWD+DKEojYBrAFOYC/rLNB+WxcpCu8tfsqF3xug7osHQmkAKDTf8ibtFC0
	 QhgotDbZ6LBx/F+Bm2VI54/a4FtpvFfSkfzXv6M+q+WeqRGIsL4toTRF6GVlxoP0Fj
	 GOta7I0F8XDDitbPVkcQqRzsXBieGnlqrtxv/RWHVd9aWEZEMqaC90wdMhOLJhjAk6
	 LOJC+xl9TWbrtv4SeIPgqFYWBupsyVcmcxV1SWyk92RbZatKmiolPh60RhsMKcE3Rf
	 WVoP0Y/GF0qNQ==
Received: from mailhub15-fb.kaspersky-labs.com (localhost [127.0.0.1])
	by mailhub15-fb.kaspersky-labs.com (Postfix) with ESMTP id 8A3AFA1278
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 15:22:43 +0300 (MSK)
Received: from mx15.kaspersky-labs.com (mx15.kaspersky-labs.com [46.165.235.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "mx15.kaspersky-labs.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub15-fb.kaspersky-labs.com (Postfix) with ESMTPS id 738F8A62E6
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 15:22:43 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1784895755;
	bh=4q7KoWuSKi/YldkaoLnG0pIBnVs8iJeEAHdJKQyj2Do=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=HWiHCyqCXyWdgEvvQ3hxpEBAEXxrYnhQOIhHh4pybioSs3yULmEOjBwbl54mkl86I
	 taxBlRojCAyjeMon/tLCD+fbfkB38FBPQtfXdmVRd8Hdy7T5rYTV2Fmqdy1mWOJCfI
	 SbCIQLfQe5VqQvYwa08hBmO5PRmj61W9Zz6dW2Yp1MTUmPYR+T798zi3olqlLZqrRG
	 ojaVX/ssXTnlA9LXNUP0T6kFKsPvB7htFzIxabBseb5HGSrZfc03FdG2HMVPGsEZ4I
	 c/iHujWPxQjhN5vyZC1CB926ZQXSVyOlgS79uXod/fmQEc0X/xCNegOxy6Z7p36qST
	 YFkgTOGWzlaXQ==
Received: from relay15.kaspersky-labs.com (localhost [127.0.0.1])
	by relay15.kaspersky-labs.com (Postfix) with ESMTP id AD451A1401;
	Fri, 24 Jul 2026 15:22:35 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub15.kaspersky-labs.com (Postfix) with ESMTPS id 836A9A0F5B;
	Fri, 24 Jul 2026 15:22:34 +0300 (MSK)
Received: from frolov-se.avp.ru (10.16.49.179) by HQMAILSRV1.avp.ru
 (10.64.57.51) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 24 Jul
 2026 15:22:33 +0300
From: <Sergey.V.Frolov@kaspersky.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <rkannoth@marvell.com>,
	<sbhatta@marvell.com>, <bbhushan2@marvell.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <Sergey.V.Frolov@kaspersky.com>
Subject: [PATCH net] net: octeontx2-pf: Fix UB in shift operation
Date: Fri, 24 Jul 2026 15:19:43 +0300
Message-ID: <20260724121941.2637908-1-Sergey.V.Frolov@kaspersky.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV4.avp.ru (10.64.57.54) To HQMAILSRV1.avp.ru
 (10.64.57.51)
X-KSE-ServerInfo: HQMAILSRV1.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 07/24/2026 12:12:04
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 204737 [Jul 24 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.22
X-KSE-AntiSpam-Info: Envelope from: Sergey.V.Frolov@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 113 0.3.113
 b83a27b0bdff87150e3aba5d24ea90b4a220db99
X-KSE-AntiSpam-Info: {Tracking_ml_letters}
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;kaspersky.com:7.1.1,5.0.1;frolov-se.avp.ru:7.1.1,5.0.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/24/2026 12:14:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/24/2026 10:39:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/07/24 09:25:00 #28514324
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

From: "Sergey.V.Frolov" <Sergey.V.Frolov@kaspersky.com>

In function otx2_get_egress_burst_cfg, when the parameter `burst` is
255 and the max mantissa is 255 (0xFFULL), `burst_exp` is set to
`ilog2(255) - 1`, which equals 6.

This results in an unsigned wrap-around when calculating
`(1ULL << (*burst_exp - 7))`, since `*burst_exp - 7` becomes -1,
which makes the shift operand 0xFFFFFFFF. This value is greater than
the width of the left operand.

According to standard 6.5.7 p.3:
"The type of the result is that of the promoted left operand.
If the value of the right operand is negative or is greater than
or equal to the width of the promoted left operand, the behavior
is undefined."

Add a check to handle cases where `*burst_exp` is less than 7.

Signed-off-by: Sergey.V.Frolov <Sergey.V.Frolov@kaspersky.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 40162b08014d..39bd73a214af 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -53,10 +53,15 @@ static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
 	if (burst) {
 		*burst_exp = ilog2(burst) ? ilog2(burst) - 1 : 0;
 		tmp = burst - rounddown_pow_of_two(burst);
-		if (burst < max_mantissa)
+		if (burst < max_mantissa) {
 			*burst_mantissa = tmp * 2;
-		else
-			*burst_mantissa = tmp / (1ULL << (*burst_exp - 7));
+		} else {
+			if (*burst_exp >= 7) {
+				*burst_mantissa = tmp / (1ULL << (*burst_exp - 7));
+			} else {
+				*burst_mantissa = tmp * (1ULL << (7 - *burst_exp));
+			}
+		}
 	} else {
 		*burst_exp = MAX_BURST_EXPONENT;
 		*burst_mantissa = max_mantissa;
-- 
2.34.1

