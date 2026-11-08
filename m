Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794120782;
	b=VYVxkjvOS8zT0yILAKQpmw2mdq9v1RuJLBahwNz1+rGz5p/vflk7Ux0ePorgi3+rDswy
	 oVGXIDOzztM+/c8NzS0yH7zeFrKPH+hJKJW8MakhxLiKJyPINK92DFOXnYpHFjG/m+9/4
	 Xlhz55q450bCRMOQifEAbFk1mjl5c+eJuLSxvNZ0e2fNOQ6K5NwztqYFWVLO3S51A+LSL
	 moJZg+JbbTVVNi8he3wlGNigLWTldzyhP0QD55uDeX37KQLXnBwwW6W8ab6pEul/l/dyf
	 NVfgjVL6w0QCs2B1J72Zy1B60xvTpLE2sGW/B25E5ySoMQiObwMpFrGXJGuCbGqOm6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794120782;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=Evz3I6LRpPLttnyjUpSE785eEKCoczDe3Gc2UwvLma0=;
	b=snb6Z1QBZ11zi4ZyKN9drdARVDZaRan7oZSMYhIWtUt1OHbKwbKl/yk5n9BXC0N49jLZ
	 JThlxxfy0cozDO2SqobSrSKkKEuHMfXLOlSQCFGiJbccwqKbOwmKQ2ioujk/j5wgm9ent
	 N5rU1lKyfUTARtLRZ+Pnc8VH2cbntrvYcWZFcymBXcmr3ZMa7PH70m2jolVn2ONpAkYbx
	 qy9JRnhc4fT4CGypRkzUL0jbWvSwmvg+COgc2F6xUkNGnYrpPXguTW+xyt/a/9LB6KvRA
	 VPFjJ+pqbv7+KYTgemhF2cLth/XEGn1C9jQuZaJoPd4yvHbn5QiPE7U8WXbahVyz5pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Kj7R5BTR;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26AE606A31A
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 06:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F26AE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Kj7R5BTR
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so92544a12.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 22:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794120781; x=1794725581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Evz3I6LRpPLttnyjUpSE785eEKCoczDe3Gc2UwvLma0=;
        b=YknmkdP3xJ83kHHaV8MXgAIjlzaFAaEGbAVhdD/GGZjVLCExdr45Iv9toRzxoGtJRr
         n1ZUVNjW3Z6Waeq2elCWY8Txu9m/kEfmo2H0KTuoISef2O9cDtX4nljoLcbCHA6XGMob
         rQTh8Y6neVGBaqki4FZeLUZbbKo5GE0Kox52mbHczMam3ZhTsYdamG7ZzblDujZTa8Vy
         SVPDAxAOD11IVhvtrVQUjRlJ5C06pV2oMrLKzojdIt5MXz1BuHBOpELlY0dad2F/sLlV
         EhTdA5XSxU8543sORDyLZaDdgF1KU9RW3M9EuXXgSSk7PrpTjHKfymj4yfzrCWmx7+uK
         mxeQ==
X-Forwarded-Encrypted: i=1; AL+hErFgKduvgvVzqkJIM3d1ms1GS8LphbJHUelv5OTximJ4WW8qsnH8JhzmAsd6vf1V9rCFzJ8uWVA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LdI6XpJgXtUAJxRFXJD0qpQ+Z7nNTLHfdxebnMg/HFwdkGe+i
	GENy8PV9NySCJ4z+bpxLuTkF4BErE8t3kDcIvinXA8wkRnIeo1+H2cZ2QcBHGPQtxgMHXgIRE80
	eRoYexw7XrBqlcIU14pt4nwdzupWS9fgaD9R6bR5DnJc57Qny9vaDIN0aSrS6cquJBbrW3lzIF3
	b/xyzjxoWqT0h/C9a1gcQsGlFOun0t7NohvykqtRGjlOVhJ2S7Oc+qQpEePJQjdN0SVUVw+V4bj
	rFSfM1SbrSDUw==
X-Gm-Gg: AYBFou1wVZMr+QVRX0oVMcVRNyIDgbC/vt3lHaPrYJ/PIlCo/GQWh89ahwjrOOWx/pz
	uIewnliBiNEf5P0LtVpiTnsMPnezQVaCFkbm6juLMSit+Ci2Cs+gKDh1tR6RvDbtrMEXcRL8xq0
	/YDbiySXryAL/Htki6wS0i42Rg5ylY50HCbMvMCS4HKk/nT0GoV/F7akRlJUo9VUtayU2hW4kIr
	IQYYpfzH5x0VommbjWBUxu04VHMSXoJ1/b3TyBrx9WtqdUZ2cj4kv6Q7pgW1OTg7UPh/DhLPa6/
	5zUhsGbqytdrSu4t57h0YVkZ7riWlztp1oMfXZgm1IpDdsFgj0/23l33/UyCCUcdM93YoIfm+o9
	CXUtGYdY9ns0593Y/On2peteZVHk8AoCJWBHjuhKe5I5HeO15xKGYpkwDSiV1wQpiwlLIn9LZLN
	m428zfld24myzTOHE/U5vA/mQtfcmPtMnWOGU=
X-Received: by 2002:a17:90b:3890:b0:3ac:6fcf:81a2 with SMTP id 98e67ed59e1d1-3b12d4b656cmr540220a91.57.1794120781192;
        Sat, 07 Nov 2026 22:53:01 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1278ae657sm1081690a91.4.2026.11.07.22.53.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2026 22:53:01 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1aa0fb7f157so315179c88.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 22:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794120779; x=1794725579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Evz3I6LRpPLttnyjUpSE785eEKCoczDe3Gc2UwvLma0=;
        b=Kj7R5BTRBiQrz5v3AhmHsXePe/fEGL4FFQGttl8IDv20T4h9zqmUbO4wTKo9J7bgoq
         BBY4LOUVDLh+tEPS2ZD+jSyjVFLy/2t5K4Oi6X6PvKLMVuHUcMxfvqMcBp3YDU74O/ek
         OhA/6Tf86UB4cdoJrpEpMxgyM4RpWLF1S94tA=
X-Forwarded-Encrypted: i=1; AKwUvBy085oPE2btsnIsYZeB2o27lXgoLc3PFlnbSLLb2ybOuUDGOheKNNpp2WC7IMPY+8KwSuEs5L4=@vger.kernel.org
X-Received: by 2002:a05:7022:ec17:b0:1ab:faad:cba with SMTP id a92af1059eb24-1b39fefeab3mr1384235c88.34.1794120779430;
        Sat, 07 Nov 2026 22:52:59 -0800 (PST)
X-Received: by 2002:a05:7022:ec17:b0:1ab:faad:cba with SMTP id a92af1059eb24-1b39fefeab3mr1384208c88.34.1794120778721;
        Sat, 07 Nov 2026 22:52:58 -0800 (PST)
Received: from pc-hpe-top-git-sendmail-server.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755e8a27sm3497993c88.7.2026.11.07.22.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 22:52:57 -0800 (PST)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: michael.chan@broadcom.com,
	kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 2/4] tg3: Select PLL clock when preparing for shutdown
Date: Sun,  8 Nov 2026 12:25:24 +0530
Message-ID: <20261108065526.710152-3-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261108065526.710152-1-pavan.chebbi@broadcom.com>
References: <20261108065526.710152-1-pavan.chebbi@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

When the 5720 was linked up at 1G, it may fail to wake up on a
single Magic packet.  This is a hardware issue, which can be avoided
by locking the PLL clock source before shutdown.

When preparing for power down with Wake-on-LAN enabled, if the link was
up at 1G, set CPMU_PLL_TLP_CLCK_SRC_NCSI_PLL in TG3_CPMU_PLL_CTRL_STAT,
so that the NCSI PLL locks on the TLP clock.  The setting is cleared on
the next chip reset.

This was reported by a user, who confirmed that this change fixes it.

Fixes: ba1f3c76d760 ("tg3: Enable 5720 support")
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 14 ++++++++++++++
 drivers/net/ethernet/broadcom/tg3.h |  6 +++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 2cf9d2ea069b..e9b48e58fdd4 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -4127,6 +4127,14 @@ static void tg3_power_down_prepare(struct tg3 *tp)
 	if (device_should_wake) {
 		u32 mac_mode;
 
+		if (tg3_asic_rev(tp) == ASIC_REV_5720 &&
+		    tp->link_config.active_speed == SPEED_1000) {
+			u32 val = tr32(TG3_CPMU_PLL_CTRL_STAT);
+
+			tw32(TG3_CPMU_PLL_CTRL_STAT,
+			     val | CPMU_PLL_TLP_CLCK_SRC_NCSI_PLL);
+		}
+
 		if (!(tp->phy_flags & TG3_PHYFLG_PHY_SERDES)) {
 			if (do_low_power &&
 			    !(tp->phy_flags & TG3_PHYFLG_IS_FET)) {
@@ -9394,6 +9402,12 @@ static int tg3_chip_reset(struct tg3 *tp)
 
 	tg3_restore_clk(tp);
 
+	if (tg3_asic_rev(tp) == ASIC_REV_5720) {
+		val = tr32(TG3_CPMU_PLL_CTRL_STAT);
+		tw32(TG3_CPMU_PLL_CTRL_STAT,
+		     val & ~CPMU_PLL_TLP_CLCK_SRC_NCSI_PLL);
+	}
+
 	/* Increase the core clock speed to fix tx timeout issue for 5762
 	 * with 100Mbps link speed.
 	 */
diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
index a9e7f88fa26d..631bacc515ab 100644
--- a/drivers/net/ethernet/broadcom/tg3.h
+++ b/drivers/net/ethernet/broadcom/tg3.h
@@ -1168,7 +1168,11 @@
 #define  CPMU_CLCK_STAT_MAC_CLCK_62_5	 0x00000000
 #define  CPMU_CLCK_STAT_MAC_CLCK_12_5	 0x00110000
 #define  CPMU_CLCK_STAT_MAC_CLCK_6_25	 0x00130000
-/* 0x3634 --> 0x365c unused */
+/* 0x3634 unused */
+
+#define TG3_CPMU_PLL_CTRL_STAT		0x00003638
+#define  CPMU_PLL_TLP_CLCK_SRC_NCSI_PLL	0x04000000
+/* 0x363c --> 0x365c unused */
 
 #define TG3_CPMU_MUTEX_REQ		0x0000365c
 #define  CPMU_MUTEX_REQ_DRIVER		 0x00001000
-- 
2.52.0

