Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487066;
	b=G1jwlF36q1NYZegaioI9VyRb5ZQ8SjSEfoBkcE+fMQJyHdDaawR89CaMm515Qnq/aAi4
	 7DSeIlwFMAdmmZ0AACA2xsgtdPd+ecN7zwGgoiO708iLwK+Damz+mpTdJzc1yIQXLH/Q/
	 ShaOzQGKuJFFZwPx95QxUAmEXF+phSBNLn69hmjfKi+jTjkGoOpzTHGdLkBf0Iq8rQOy+
	 HUjZW8fopjq/mVGuCwq9EKcaiYvwIFb7tJD57UZxGFH56qs5UJ7ygGk2vk38TKC7w1kAS
	 c8u91ljCxZ9dSvbrv/z+Qdo6+kk7FGWTD3rTiaoZ+6T/4uJCZStLMZ01+LUPD4QptRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=de8BG82uU9McoGcWQ0uAl86Gt4M40mYxIglpyfUJuGQ=;
	b=bUw9WvABGr4glv+z3RjbcKLLsEG5yO6llsyfUQaa7SKJMbDcwLbOG3D0pmTSMPZkNDLx
	 TPI0sspzknB0XekcNcYVWQIlo8Zy8nTIHVM2d4JaG/iya7wtkeEMXtUef5Ha+Y+f18dvl
	 prTHh/hOELImF1g7T+xyjdvg6VCzIWLtapsBp53+/g24675mtMKqbim4QFIHvv01tm51o
	 JEOzuiIwiq2ZAX3IF4RiiZuFIXzG1qw579Ou85xNlaSA3owmfIPI04fQJKDO9oBLCsehv
	 alDrGi4khIQOAOL1rFDtjWR0bOZb1O43ullspvf7ROsWpt3DfY/Ukp/erqQYgvAxbcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ffroot.co.za;
	spf=pass smtp.mailfrom=ffroot.co.za;
	dkim=pass header.d=ffroot-co-za.20260707.gappssmtp.com header.i=@ffroot-co-za.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AQvkc716;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0635606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0635606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffroot.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ffroot.co.za
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ffroot-co-za.20260707.gappssmtp.com header.i=@ffroot-co-za.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AQvkc716
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-492f0a1b685so2873767f8f.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 04:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffroot-co-za.20260707.gappssmtp.com; s=20260707; t=1794487063; x=1795091863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=de8BG82uU9McoGcWQ0uAl86Gt4M40mYxIglpyfUJuGQ=;
        b=AQvkc716rYDt3SDKJK38SO/BRkqGX9RJMonoj/77P5wgbQb9BrET/b7bPNu0djcRFa
         t9fNgRksH/fSAcQN8bjp5gu3RSeTPoLPoa50IbGWlJ5lLAQB+YqhPyZ75La7HRd+AIwQ
         pKRF6EGWjmrkkI9EUw6scBdlZrwHMgRw2tbgG3xSn9QYehw9xkEndnZHp7qKwOMGTpeY
         rPJc2XgzJwDXGC5bpMrO4Dj9QZrnRwugnn1+UFitbf/MrzxYoXSeKUf9bCJdIH5rmm78
         Xo/ynPWKl46zaf7Xlu/H3/CKQyLQTao2D13j9/BLXZzPeGug77KQAe0TLi77UBAbJA1i
         pIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794487063; x=1795091863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=de8BG82uU9McoGcWQ0uAl86Gt4M40mYxIglpyfUJuGQ=;
        b=fq9iBl2r+vOYvHg4bbI+svUKgbo6Z4HmEZ64WjVSTPOZOGjbRnLbuBaLTqlUeaMBAe
         XuoGqHjvpsnbI7cx6SLxxXl/Adv59shSh83z2scjqgYjoorxSuyJkPAN+3hp7V5upuA3
         VOBhnCytJKUuc3oYRbgTGcktbvUOKR3t9lXJQXauBwGgDu1TK3zxP0L0jtfGrgon1U0g
         qPYhC2FztAUwy08Jfydhl4dt0c0mBcnGEiGOXzB3gGozSOXYaCeNJlOhqSqHG8uAKyPP
         3APBzFW2nU0y6bDHDHa9ck0e2RTsREmnzAV8xgXRkKOVlnoZjxV2VcYIOwAoMgwfjqAe
         Gqow==
X-Gm-Message-State: APuU4Z9Zi0RDEz5PLu3l+s6X7ZpxYRdWvsxB1YJfTR/FGC3BSLjujNg0
	5UAhVTgpADAxqOkS1wZZg2tuvPowN2+UPN2ZPl7HQV3MqbVtu2YTO9QBKYmz0DZ0K8hIkr6K/eH
	H73Fmow67lA==
X-Gm-Gg: AYBFou2yVzA+7y3XPRPon6kCSBBEoNycht1KoaAzcZtBVAFDHI5QKbIL1GlKiaH6C7B
	N/eHi4GOGlFiw+kSBrzs59ZgrvIj/vrZF1ETL6tyMhY+7v4AKa8Sxsj/xVY8wM3hYL604K9K9tn
	4MyJFinI4d2lqJ0ED7MJhBo8wgQUXQP6ixj5PXKIIFms/0dP6RIQMdL7DlxBMJMpMtIFvk4ZGx1
	oWcjrtTnKJrdgqunjy4sGoQSMRPgn7AAryIqYeRxeIinVq70H0MkQuiYCkci2BaiHJXiyN5IIqT
	uyDYoYmCwZfmvf0yzMJjEZaZvq8DSIrWw5ITdllJwH164MAchJOYvXp04JNPzKmUrb4ZZkuYZGQ
	JL1bmgloeW5o526OjHPiwaTHUDhAV3M94Yx0yKHKkH7s45ax8E9pNS+lhf4aBwWJW+aGAOvyISv
	OYdcc8xUC6tnGIGMmMBk3eIoW0O3hFaDplAvlT4oKHxoYa1SJb8Llu52PmEduSW+qeDL1chxuij
	BI5LHjLIw/i1crXpZWUt7OYZcOMrPcF4dAtCCMg6nbjfEcUIZuQFX0EiG8tv3DnWY4PAeRp+GWC
	TomDfic2Kth6vvhO/CEUHJRbFi9+YDsKQ409ycS5NHNFBkfVh/9S
X-Received: by 2002:a05:6000:2906:b0:48f:d7cd:a5af with SMTP id ffacd0b85a97d-499c0a6173bmr10601985f8f.0.1794487063140;
        Thu, 12 Nov 2026 04:37:43 -0800 (PST)
Received: from localhost ([192.145.132.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365ccbccsm16837064f8f.44.2026.11.12.04.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:37:42 -0800 (PST)
From: Andrew Gaylard <ag@ffroot.co.za>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next] net: sunplus: also fix the byte order of 1c:50:1e MAC addresses
Date: Thu, 12 Nov 2026 14:37:38 +0200
Message-ID: <20261112123738.429728-1-ag@ffroot.co.za>
X-Mailer: git-send-email 2.53.0
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

The driver reverses a MAC address from the OTP when it finds the
Sunplus OUI fc:4b:bc at the wrong end. Newer SP7021 chips have
a different Sunplus OUI (1c:50:1e), possibly stored in the same
reversed order, which the driver does not recognise. If the reversed
address has the multicast bit set, the driver rejects it and uses a
random address; otherwise it uses the reversed address as it is.

Handle both these OUIs. An address that already starts with either OUI
is left as is.  On chips that used the reversed address, the interface
now gets the correct address, so configuration tied to the old address
(DHCP reservations, udev or networkd rules) will need updating.

Tested on chips that needed each of these OUIs to be reversed.

Signed-off-by: Andrew Gaylard <ag@ffroot.co.za>
---
 drivers/net/ethernet/sunplus/spl2sw_driver.c | 36 +++++++++++++++-----
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/sunplus/spl2sw_driver.c b/drivers/net/ethernet/sunplus/spl2sw_driver.c
index 5e0e4c9ecbb0..ab0318bc6f6c 100644
--- a/drivers/net/ethernet/sunplus/spl2sw_driver.c
+++ b/drivers/net/ethernet/sunplus/spl2sw_driver.c
@@ -203,18 +203,38 @@ static const struct net_device_ops netdev_ops = {
 	.ndo_tx_timeout = spl2sw_ethernet_tx_timeout,
 };
 
+static const u8 spl2sw_sunplus_ouis[][3] = {
+	{ 0xfc, 0x4b, 0xbc },
+	{ 0x1c, 0x50, 0x1e },
+};
+
 static void spl2sw_check_mac_vendor_id_and_convert(u8 *mac_addr)
 {
-	/* Byte order of MAC address of some samples are reversed.
-	 * Check vendor id and convert byte order if it is wrong.
-	 * OUI of Sunplus: fc:4b:bc
+	unsigned int i;
+
+	/* Some chips have the byte order of the MAC address reversed.
+	 * Check for Sunplus OUIs and fix the byte order if it is.
 	 */
-	if (mac_addr[5] == 0xfc && mac_addr[4] == 0x4b && mac_addr[3] == 0xbc &&
-	    (mac_addr[0] != 0xfc || mac_addr[1] != 0x4b || mac_addr[2] != 0xbc)) {
+	for (i = 0; i < ARRAY_SIZE(spl2sw_sunplus_ouis); i++) {
+		const u8 *oui = spl2sw_sunplus_ouis[i];
 
-		swap(mac_addr[0], mac_addr[5]);
-		swap(mac_addr[1], mac_addr[4]);
-		swap(mac_addr[2], mac_addr[3]);
+		if (mac_addr[0] == oui[0] &&
+		    mac_addr[1] == oui[1] &&
+		    mac_addr[2] == oui[2])
+			return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(spl2sw_sunplus_ouis); i++) {
+		const u8 *oui = spl2sw_sunplus_ouis[i];
+
+		if (mac_addr[5] == oui[0] &&
+		    mac_addr[4] == oui[1] &&
+		    mac_addr[3] == oui[2]) {
+			swap(mac_addr[0], mac_addr[5]);
+			swap(mac_addr[1], mac_addr[4]);
+			swap(mac_addr[2], mac_addr[3]);
+			return;
+		}
 	}
 }
 

base-commit: 676f3aace662fbbc180b3898b190a372fa2a516b
-- 
2.53.0

