Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6310136494B;
	Wed, 16 Sep 2026 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572364; cv=none; b=Atizb+1QpIvGaL5VOzhOORSECCiZ3DwwLGTWSyMAGYwGklNMteYCkKi6OJrtDfTJI/mLFDwp901PLLOYVu1QV0HGQH5Ylwld7GA00Hli6A8zzBx9CPRSf7so5CMghhxKozaROBjuU0nMvweVQrnDfsxWSUtExpcswPvGhX8ByDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572364; c=relaxed/simple;
	bh=MW5vuYzITAvsFPghLqUxzbFZ7U+ZcFfESY8PyYgpBfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9kgDbfkFgjPwlcc3HNSY5DJsOkyo1uhCLeZUcBg2pIkA7ApgWgSlp1ZvGRYzjhjC3ScgOZSZjMhNEcZGeHwBqMrf0aWPteyXwcTOeihOo4Nt6wLJzoMNIT3ucDdDeZXsXbrgBHGyNEQrOJvdINUGPuO70kuAZaHY0DuJJ6jVrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=QDI/3veb; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="QDI/3veb"
Received: from LAPTOP-R01LEAQM.localdomain (unknown [186.210.28.117])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 60DF9120357;
	Wed, 16 Sep 2026 12:25:28 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1789572328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sp/8Y0GHB2KIHTY63kwEqsWWXYVutSd/ad2pUIc9qUQ=;
	b=QDI/3vebCvOALWqYQYRMB5ZELyAQr9VJxZWBovfdE3ff+ob9txA8nm+y2hERrtm7glttKx
	2GKIVOYToQ8DEyM4Jisx4vDEPBVTwuBqcmYpU6LlA5XP2FRN9AmzJymFIMPzR0qI5/tNXn
	vzV66cwfb5KjwYiEIZ+3JTp64endQg2NPL556uhCFsltsQ+jVmEs41pkDeCj6JBrl8EsD3
	FHrZ88RvKTDNyB+P/6str8LK63lnRsCax8BjQDBjl/DZlvidG/jSuxE41r2B124h7BjF0G
	TXpVEvBFoqUvLsoNw1gH7bZkY/yEIr9uNc2Er+ItlCylGqUW/HkXPy4+5nCueQ==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH net-next 2/3] r8169: propagate firmware access errors
Date: Wed, 16 Sep 2026 12:24:43 -0300
Message-ID: <20260916152444.167196-3-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916152444.167196-1-matheus.aalmeida@inf.ufrgs.br>
References: <20260916152444.167196-1-matheus.aalmeida@inf.ufrgs.br>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtl_fw_write_firmware() does not check errors returned from  fw_write()
and fw_read(), nor does it report failures to its caller.

Change rtl_fw_write_firmware() to return an int and propagate errors
from fw_write() and fw_read().

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 drivers/net/ethernet/realtek/r8169_firmware.c | 15 ++++++++++++---
 drivers/net/ethernet/realtek/r8169_firmware.h |  2 +-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_firmware.c b/drivers/net/ethernet/realtek/r8169_firmware.c
index 6dff3d947..645d510e6 100644
--- a/drivers/net/ethernet/realtek/r8169_firmware.c
+++ b/drivers/net/ethernet/realtek/r8169_firmware.c
@@ -137,7 +137,7 @@ static bool rtl_fw_data_ok(struct rtl_fw *rtl_fw)
 	return false;
 }
 
-void rtl_fw_write_firmware(struct rtl8169_private *tp, struct rtl_fw *rtl_fw)
+int rtl_fw_write_firmware(struct rtl8169_private *tp, struct rtl_fw *rtl_fw)
 {
 	struct rtl_fw_phy_action *pa = &rtl_fw->phy_action;
 	rtl_fw_write_t fw_write = rtl_fw->phy_write;
@@ -150,10 +150,13 @@ void rtl_fw_write_firmware(struct rtl8169_private *tp, struct rtl_fw *rtl_fw)
 		u32 data = action & 0x0000ffff;
 		u32 regno = (action & 0x0fff0000) >> 16;
 		enum rtl_fw_opcode opcode = action >> 28;
+		int rc;
 
 		switch (opcode) {
 		case PHY_READ:
 			predata = fw_read(tp, regno);
+			if (predata < 0)
+				return predata;
 			count++;
 			break;
 		case PHY_DATA_OR:
@@ -179,7 +182,9 @@ void rtl_fw_write_firmware(struct rtl8169_private *tp, struct rtl_fw *rtl_fw)
 			count = 0;
 			break;
 		case PHY_WRITE:
-			fw_write(tp, regno, data);
+			rc = fw_write(tp, regno, data);
+			if (rc < 0)
+				return rc;
 			break;
 		case PHY_READCOUNT_EQ_SKIP:
 			if (count == data)
@@ -194,7 +199,9 @@ void rtl_fw_write_firmware(struct rtl8169_private *tp, struct rtl_fw *rtl_fw)
 				index += regno;
 			break;
 		case PHY_WRITE_PREVIOUS:
-			fw_write(tp, regno, predata);
+			rc = fw_write(tp, regno, predata);
+			if (rc < 0)
+				return rc;
 			break;
 		case PHY_SKIPN:
 			index += regno;
@@ -204,6 +211,8 @@ void rtl_fw_write_firmware(struct rtl8169_private *tp, struct rtl_fw *rtl_fw)
 			break;
 		}
 	}
+
+	return 0;
 }
 
 void rtl_fw_release_firmware(struct rtl_fw *rtl_fw)
diff --git a/drivers/net/ethernet/realtek/r8169_firmware.h b/drivers/net/ethernet/realtek/r8169_firmware.h
index 1285a1c28..36c89bfda 100644
--- a/drivers/net/ethernet/realtek/r8169_firmware.h
+++ b/drivers/net/ethernet/realtek/r8169_firmware.h
@@ -36,4 +36,4 @@ struct rtl_fw {
 
 int rtl_fw_request_firmware(struct rtl_fw *rtl_fw);
 void rtl_fw_release_firmware(struct rtl_fw *rtl_fw);
-void rtl_fw_write_firmware(struct rtl8169_private *tp, struct rtl_fw *rtl_fw);
+int rtl_fw_write_firmware(struct rtl8169_private *tp, struct rtl_fw *rtl_fw);
-- 
2.43.0

