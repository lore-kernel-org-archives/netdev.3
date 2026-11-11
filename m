Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400602;
	b=GY4rjNd7v5xa14z1nhhW2jGiy1gst+L1m+y+nSFW6cAUzdqrKTp7bcKJ6VljedjJoK7W
	 8iMOkkRXTWFEfMLsHhxrJFslWElFDMiofsLOF4a7dyeja+WfTyDIrrQXc8SwHkF1iOB3+
	 zATQVjnc4RdID4gd2/7kUsTGbXNNqmTGexE17wgdKDttNI+J0gM/hruMLki5HYoiUrOOG
	 Qxs2PoQcpEdtibyedR3Ht4KWANCRMRds/Dt6WZf6oQ12ltdXsEb287GIBfQhOXRbYsuCw
	 qSWIAlu0t3O3psZKtMTU+WgMT0iOEyV86oYbROxICz5h94IZHmeHYDQl1b8b4c0bVeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400602;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=LBMMheIhoGr/SduKTJl33ibPzDkJy+WeraUVw3xelpQ=;
	b=Vkt+syS1OgiSN5jPtpkxrXyB/WPcm9/B2ZcqTIg+O0RtaHGmBwjB0UozwCpODdhYtKCT
	 j6W8JjA/N5czQl6uvwTbAEQF3Yr64ngoivSBbPLKE0Pl2wJ4Kyz/D0FTbxUyFljy1V8gd
	 KirT1D2uaZTiVyi68lg+9EdP0hq4K4RwtdsxfDSRxvTP9R4FmUG69WH4+OZ++2IRBcJXq
	 bPF8PWVFY6cvKAoL4S+Tse9MRQ32Njfafx0tHBtDKDAz/jbxk7gCUHVZxFqgvMY1ddv4Z
	 Gdr9lWL9YpMQdKJh9tdb+AzO86z0dDBfgRCtkOxJwBKLhJdYYxnZHrfL20FHr0TB8bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=f3wvJrUY;
	arc=none smtp.remote-ip=209.85.222.226
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9420606A324
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 12:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9420606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=f3wvJrUY
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-93f2f2edb19so253329185a.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 04:36:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794400601; x=1795005401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LBMMheIhoGr/SduKTJl33ibPzDkJy+WeraUVw3xelpQ=;
        b=2cE2BzRllV/GKmBKJCMWRlAulWJWXdW9+G+LspXRNhdWmSI26BPdeZPSflin459Qge
         t+/WDJtKLPsPtzkzOE0I0A9d66v2g8MhlIuwNn5s+7013yP7UAlvO7LwaCwPb9AZwn7g
         i4V+PBcYhReasXnt/txY2oqmJDkW7/26PmF3HJdVLjfOq3cM/+7u4loCPnj/el9u+EMV
         F3VsuoOBygES5M+WdTJ95CdBDgiyrMO8jMXK7tYwTnugcoG8mXvgQfHvaqCQ02Cj/DMG
         AKsdE1RGju4ZZT08lfTJ7Zsl2RZqKJSOS5tq4jOOZVgzgskyidEizy4Kom3HMoxOIYUM
         PlYw==
X-Forwarded-Encrypted: i=1; AL+hErGQdZ4JDjfvNYhMv549JVo1Lg0OQPQgqgVNLQl0m4f7+vO1nf7YaERTLxOw3KUpBTEuyS4+eEM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3JZgZ2TLyAK9o7TjK7q5Wxnnoa0fDHMpv2C/9mbyHT5KvsyTu
	JW3jmBvHJmTXdhlFcfzS09HFE9KELktHrKJQ0Q0q+T6VbEnZYS2+ih7rsWePAdkW0XgCGOLoY/L
	/DWjM2EwL8MnF8pILpj9D1WYuIJ6PowC1f/71SH3crlRpdP9x9WYmDZ+G6ZD9A/fqCXH8q5TvSP
	JsHcozvfGj+qz8YXL9ZZVb3iwanbvR3N4Jy+Q8XnL5YuRdtPuQii7Io3NrtkGZkn8+gO6EIziga
	xRABro+hri4PB+W
X-Gm-Gg: AYBFou1EkKUlPhwlz8LGUv7vONgpDPA1IDpVNm9lzVKJGSyhRbOOlqLVyHw8gTEWg9/
	vYLa/Y1jDhaVs1ZnnA4DfT3qRYyd9ymj/Gave7lTV5CGAM4vhyNXaKLAmClisw2kx0CbE5K0G7d
	WeVElGeVNtNaRy0cCcfwg7qza5fc0UXq1MkNFF/gVQcfmXNknoLg2nBtHdMidiIItAGZ2GFIhch
	exQZzx8nBfBnkYL6CthZp/TM0CgfLdfHM/QOTtFxglILwY6gZRCJmdGzOs8a8SBZLN0ofL3hy1T
	SazqQJvbehh3+3z07YbXnk/V53edy3mEB8g5yLLc7RXshmGStwpBoFIER48DPZOQKbPLOzzfkAY
	dOXoZOBa+eo+5K6GpVMix35jeYRMs40DzIjDFWXSh7uD6clJ1pdvT3rI9b7vyag3VnhCQbeV3OZ
	GfDYjbH1Bi/kpd7uiTJ5vBem8aHQ+Djch2kzM=
X-Received: by 2002:a05:620a:1707:b0:93c:2c0e:7ac with SMTP id af79cd13be357-947b0054268mr298633985a.53.1794400600652;
        Wed, 11 Nov 2026 04:36:40 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-9479eff48d9sm56571585a.16.2026.11.11.04.36.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 04:36:40 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36fa5673fccso1701294eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 04:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794400599; x=1795005399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LBMMheIhoGr/SduKTJl33ibPzDkJy+WeraUVw3xelpQ=;
        b=f3wvJrUYAtlEAbeKSw+Hbty2osGgkayeW5wS+GLuDYRYVpM51ZzMfYP34GIcR8m8kn
         h7Lggnow7qCsDSMWAIndYXH4jwuqa9lc+o1y/1pjYf8m2Y2xvt3voO01SIP3RGX8XJDb
         I0c980oE5UMEpKXj3CGYH20jHKei0vSAmWPyQ=
X-Forwarded-Encrypted: i=1; AL+hErFKsZeZKbbMufBgx8Lbk02H5W/Asomqz0+tHlVyKFvdThSBZMnwWO1FOMWpQ+7Bs+3VpW/EoOQ=@vger.kernel.org
X-Received: by 2002:a05:7301:6199:20b0:375:be89:8a47 with SMTP id 5a478bee46e88-3768675fd28mr2994397eec.27.1794400598992;
        Wed, 11 Nov 2026 04:36:38 -0800 (PST)
X-Received: by 2002:a05:7301:6199:20b0:375:be89:8a47 with SMTP id 5a478bee46e88-3768675fd28mr2994358eec.27.1794400598132;
        Wed, 11 Nov 2026 04:36:38 -0800 (PST)
Received: from pc-hpe-top-git-sendmail-server.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375218c863csm15159947eec.28.2026.11.11.04.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:36:37 -0800 (PST)
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
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net v2 3/4] tg3: Skip querying for management FW when no NCSI present
Date: Wed, 11 Nov 2026 18:09:15 +0530
Message-ID: <20261111123917.910416-4-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261111123917.910416-1-pavan.chebbi@broadcom.com>
References: <20261111123917.910416-1-pavan.chebbi@broadcom.com>
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

On BCM5719/BCM5720, when the NCSI component is missing in the NVRAM,
driver should not assume that "DASH" management FW is running by
default. In this case if user runs ethtool -i command, invalid string
"DASH" and garbage DASH FW version is being displayed. However, the
5719/20 chipset cannot have any "DASH" management firmware running.

Hence skip querying the APE FW version registers and adding the "DASH"
string to the tp->fw_ver if NCSI is not present. Just report the
bootcode version.

This was seen by a user.  With this change, ethtool -i displays only the
bootcode version.

Fixes: ecc796486f0a ("tg3: Detect APE firmware types")
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 98338c0792e8..4becd1a0b009 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -16045,19 +16045,21 @@ static void tg3_probe_ncsi(struct tg3 *tp)
 
 static void tg3_read_dash_ver(struct tg3 *tp)
 {
-	int vlen;
-	u32 apedata;
 	char *fwtype;
-
-	apedata = tg3_ape_read32(tp, TG3_APE_FW_VERSION);
+	u32 apedata;
+	int vlen;
 
 	if (tg3_flag(tp, APE_HAS_NCSI))
 		fwtype = "NCSI";
 	else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_5725)
 		fwtype = "SMASH";
+	else if (tg3_asic_rev(tp) == ASIC_REV_5719 ||
+		 tg3_asic_rev(tp) == ASIC_REV_5720)
+		return;
 	else
 		fwtype = "DASH";
 
+	apedata = tg3_ape_read32(tp, TG3_APE_FW_VERSION);
 	vlen = strlen(tp->fw_ver);
 
 	snprintf(&tp->fw_ver[vlen], TG3_VER_SIZE - vlen, " %s v%d.%d.%d.%d",
-- 
2.52.0

