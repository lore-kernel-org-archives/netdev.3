Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940466;
	b=GE1R/9RvGi9T6XNLfPhfD9GlFh5AfTOMvSqrVKcjT52Gb9Y7QWf5DXRmlEH5bWcbXUiZ
	 dDLDl1Bl9go9DBHFdAc2pzs/jX7eNJLhCj0eK1eRH4ArZYwcFH1gjJ+mMGhgLrHwT6V/0
	 bPHhCmW2d0LYTr47/y64Rti74+LLssN6vNzUFZM71rYBvEr5P1NSU9K8j2LKIC4ffh0Sg
	 2xYEvpEmzP6a2X6V+31PoP8ZWnrCpK7prxSaEbLG2DOT13GvSt/kwsjA2f+0VDIl76NcC
	 EaY1DXhXsLmfDEyLa4QIXpC2pez+N+CrGzBX8IMpRMFoGhwYMJ037Zas5irT5Trgtqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940466;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DlJk8YkzI4Sc7IET8R0ZtA9MIi8qi8si9X/PTNgXjeg=;
	b=srxoN1FPu2hsOwz5p5+4HgpZ5NlbqKHbeHZif1eR+HhKIzh4Pb+7ZA1j58X/N7ICPRGJ
	 lYWOEjQIMGWvRzOqlQ6wWwCd5C9k6qYvj2vQNWLe0D/vYtJTYZW8ulyWZgFLEaqjl/MaC
	 Iavbw4hrFTZws/QViLgbLiLPPsMEtmydQmwJyVUrcs4mIkemQiOHD5SAD2eLTKzr2hWTW
	 XZ4ePJnAz9BgHB3tZZJb7EGc1sXjnkgX09Q6xLg/7QdxbKJSa+Ygk5C7WweWSpOOHEp3F
	 CCsookJ/aBqKr1wLah2OyJJcaWfkn7Hz+2H+JV+QQwI1C87imqqJvdKeCPhfQp0OtIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=zhokTpdL;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3617C606A31B;
	Fri,  6 Nov 2026 04:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3617C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=zhokTpdL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=zhokTpdLVF1Gruuw4w6n1bd7rTN74jHQ+QXghz1tcN4hy3n72GQR7wA1tapH9cu3XWxWU5y35clN9
	 exf0M/ucSe53kg9VCg0yffjbA90PzFVS7cdNl8/aivpFORMSUZSwM1JyCsTBWdR51K/jjikVyZ+mJh
	 Wgsh9NP0yUsjyWhc=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96aed5bedf2f-b1f2a;
	Fri, 06 Nov 2026 12:47:41 +0800 (CST)
X-RM-TRANSID:2ee96aed5bedf2f-b1f2a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [25.255.2.225] (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96aed5bea254-1245f;
	Fri, 06 Nov 2026 12:47:41 +0800 (CST)
X-RM-TRANSID:2ee96aed5bea254-1245f
From: xujiahao <xujiahao@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org,
	xujiahao <xujiahao@cmss.chinamobile.com>
Subject: [PATCH net-next] net: xgene: Fix the size of the IRQ name buffer
Date: Fri,  6 Nov 2026 12:44:21 +0800
Message-ID: <20261106044421.3461816-1-xujiahao@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xgene_enet_set_irq_name() composes the interrupt names as
"<netdev>-rx-txc", "<netdev>-rx-%d" and "<netdev>-txc-%d" into
ring->irq_name[], which is IRQ_ID_SIZE bytes.  A 15-character netdev
name plus "-txc-" and a full-range %d needs 31 bytes including the
terminator, so the names of long interfaces can be truncated, and gcc
reports it in a W=1 build:

  drivers/net/ethernet/apm/xgene/xgene_enet_main.c:888:66: warning: '-rx-txc' directive output may be truncated writing 7 bytes into a region of size between 1 and 16 [-Wformat-truncation=]
  drivers/net/ethernet/apm/xgene/xgene_enet_main.c:891:66: warning: '-rx-' directive output may be truncated writing 4 bytes into a region of size between 1 and 16 [-Wformat-truncation=]
  drivers/net/ethernet/apm/xgene/xgene_enet_main.c:898:58: warning: '-txc-' directive output may be truncated writing 5 bytes into a region of size between 1 and 16 [-Wformat-truncation=]

Size the name buffer to 32 bytes.  It is only ever read as a string, by
request_irq() and the interrupt logging, so nothing else changes.

Signed-off-by: xujiahao <xujiahao@cmss.chinamobile.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.h b/drivers/net/ethernet/apm/xgene/xgene_enet_main.h
index bce2c19e3..8eb97f6ed 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.h
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.h
@@ -71,7 +71,7 @@
 #define X2_START_BP_BUFNUM_1	0x20
 #define X2_START_RING_NUM_1	256
 
-#define IRQ_ID_SIZE		16
+#define IRQ_ID_SIZE		32
 
 #define PHY_POLL_LINK_ON	(10 * HZ)
 #define PHY_POLL_LINK_OFF	(PHY_POLL_LINK_ON / 5)
-- 
2.43.0



