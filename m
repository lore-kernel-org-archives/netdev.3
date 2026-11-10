Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281108;
	b=KCs92XkGNRT7nDpkk6XCX5shyNdaurxMWabTSOBDh7MutQ2tvtaYO4kG1NmOUxKPtuem
	 PmobXNsnu5YF9nonioq0F/SFgZokXHopWOZG8mIDx80HMlz5URsjfDUdKePBcE5TWAwzE
	 o5PGaJym1NPTiaWk29+HWW2c8PX4aWkn+CJihNsU29UFND1h9pbrNN5/BbRWjQLpZu5bQ
	 cI9gIPDHf2VQlwsp+4mMmgBKh+lN5o7dVB78i7oVQZnFSvD9GVKjds626V075fgjXkKWZ
	 WHnvQzvkK0nYAS0c2pa0lliFJjDhh94q8R43Bl0Ffr1LIhn7roN53JE/q1WArNsyhew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281108;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=KNSTVPHPWtuLm7l0lnCFcdMK9ibF44zHiEa73A+7LCo=;
	b=EEYIA3OodkBUnYd+y2aXN6r8AiSpoOVO/vALTUoM6Fl0j6hKcIv+cKfmwZRiyDXlB3Nq
	 cMl3HDOYfq+8JQSCGTtzsMa9qo3X3SIcWPoGj/i90K/5Xv+OdV+RZJCt2xwyhu6uH8NYO
	 Fk1X7jX69XQVeVCplwn9+l7JmWahauwN1uhwuGLCWOxQkoejBA3msjC/cZXPedKw+5GVr
	 qWDPFsmXPaZ5W3NOOiiWlgxTw+82phnOXlTOWGxxvOtSSGlknLrp9pXPYY/zk5j/4LXzz
	 rxmL5391RcRO5qRKQfuXLFIfSjtgLNAGXsoSW4Lqg+BUdwFNEJ550a++uwvlmJ+xKvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=XHfAbu2+;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0EA60A2623;
	Tue, 10 Nov 2026 03:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB0EA60A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=XHfAbu2+
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AA3OJ2f8884546, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1794281059; bh=KNSTVPHPWtuLm7l0lnCFcdMK9ibF44zHiEa73A+7LCo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=XHfAbu2+rLqf5Qa9wTeERuZbaBtRzHslZe3prc4JBN/rsoCFrDG9ZGGsW0wrIdYAh
	 smsT+L/yxCnZDjyMkbYNajMZkhapPxaffK8t5JcUFC3E7e7ZfdZ3a5PttFK+ZubaMk
	 zeiR7BnIpMmR3SM814KX7msuwwZNIBW3q7tUNatv8plJMfAFkCxLNvfcH4bX+mEZn9
	 mEPwsYOfPeAEppwO4Pcnay8RoOvKSmGuvWuttPHRvnwpZpUzZjT5AyZByj5dvuOyQB
	 UPhHj18FAs+e8guezlLa03mdja3QFN0TU3WQWe9UrxWKV3HtFSHVl4sXlIv+G5ALB9
	 49jmQqJop7aEg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AA3OJ2f8884546
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Nov 2026 11:24:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 11:24:18 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 11:24:18 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>, <mail@birger-koblitz.de>
Subject: [PATCH net-next v8 02/11] r8152: add rtl8157_unload() for RTL8157 and RTL8159
Date: Tue, 10 Nov 2026 11:24:07 +0800
Message-ID: <20261110032416.16968-3-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110032416.16968-1-nic_swsd@realtek.com>
References: <20261110032416.16968-1-nic_swsd@realtek.com>
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
Content-Type: text/plain

RTL8157 and RTL8159 used rtl8153_unload(), which disables power cut
with r8153_power_cut_en(). Per the datasheet they need
r8157_power_cut_en(), which r8156_init() already calls for them.

Add rtl8157_unload() for them, and move the Interrupt Mitigation
disable that rtl8153_unload() gated on "version >= RTL_VER_16" into
it unconditionally.

Fixes: fd3c7d080df5 ("r8152: Add support for the RTL8157 hardware")
Fixes: ad2a55b63b41 ("r8152: Add support for the RTL8159 chip")
Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index d00cc911ae135..bb4106f238a3a 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9696,11 +9696,6 @@ static void rtl8153_unload(struct r8152 *tp)
 		return;
 
 	r8153_power_cut_en(tp, false);
-
-	if (tp->version >= RTL_VER_16) {
-		/* Disable Interrupt Mitigation */
-		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04, BIT(0) | BIT(1) | BIT(2) | BIT(7));
-	}
 }
 
 static void rtl8153b_unload(struct r8152 *tp)
@@ -9711,6 +9706,16 @@ static void rtl8153b_unload(struct r8152 *tp)
 	r8153b_power_cut_en(tp, false);
 }
 
+static void rtl8157_unload(struct r8152 *tp)
+{
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		return;
+
+	r8157_power_cut_en(tp, false);
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04,
+			  BIT(0) | BIT(1) | BIT(2) | BIT(7));
+}
+
 static int r8152_desc_init(struct r8152 *tp)
 {
 	tp->rx_desc.size = sizeof(struct rx_desc);
@@ -9889,7 +9894,7 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->disable		= rtl8153_disable;
 		ops->up			= rtl8156_up;
 		ops->down		= rtl8156_down;
-		ops->unload		= rtl8153_unload;
+		ops->unload		= rtl8157_unload;
 		ops->eee_get		= r8153_get_eee;
 		ops->eee_set		= r8152_set_eee;
 		ops->in_nway		= rtl8153_in_nway;
@@ -9911,7 +9916,7 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->disable		= rtl8153_disable;
 		ops->up			= rtl8156_up;
 		ops->down		= rtl8156_down;
-		ops->unload		= rtl8153_unload;
+		ops->unload		= rtl8157_unload;
 		ops->eee_get		= r8153_get_eee;
 		ops->eee_set		= r8152_set_eee;
 		ops->in_nway		= rtl8153_in_nway;
-- 
2.34.1

