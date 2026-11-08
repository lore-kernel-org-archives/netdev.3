Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794120788;
	b=XSum+6ONz3vQgOAYjlbwmJV2N/pZ8KwUGcVyH0RJRdgHgcZjUG6LnzVGkRkssq/kQ55u
	 ABI1ke99ePSIUQTz2Oupj1QKCK1brTm3wyuqQtPCEhtIgns0oz2bYUq5XbdOFnwGXnf1r
	 47YSbHCSg8P5XD9Hahw49W7wMY2JCIAZ3hG1XfvR49bFHoB8vvw6CWjY2B14+JgI3WO93
	 Do6zRfRUE6pIuZhTU+TN40UslpYrfTaUmHIUjioKGeTulV8ac7DK9q4dvmqxGU/bcjcVA
	 8PwOiboGp6vYX83dFkKEjI4taEIm0AP5wAUGUJw+fHm2IEbP+jiaHW+r53X2NzdCltQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794120788;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=pyBtVqP8NGRwts0i4gjQbcb31qjJWBl7WO9S1ZYG21k=;
	b=CerHRc5XaxsH6HyzA/5RL2YKZ1d780ufzb4Y5PPt9I8VkT0/8tJs/tuepzMqPOj8+vd8
	 X0rOpYjl/AOAokGiAsbirn4HktoWKFkGaHRgXbFR54s2LC+JIEjax9fdNxUlVNz0v1T4X
	 pxK8OMDKJEOyzXr9jClbVbeYByBDXYmMJRXfbUhU7kbUAfT0iL3laLdADXN9+Sq5PVeFD
	 tA37BsZdtThS4LQQYN1O6EACxt3HDKo7F+YF2p9DmWX0A2hFJnUxDzycFR0uUEzCzpz/U
	 sawiYcQobbHHO5TMo5VWGKFfjGVrV5XFNdZrsoqn4OpiG+oC68J/9rFOoF4j5vFBj/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=FkGQbpKR;
	arc=none smtp.remote-ip=209.85.160.98
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DE2606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 06:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19DE2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=FkGQbpKR
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-451a49abd8aso345083fac.3
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 22:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794120787; x=1794725587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pyBtVqP8NGRwts0i4gjQbcb31qjJWBl7WO9S1ZYG21k=;
        b=ggfjxf2L9nH7xtKfdTL9ZAs3tS/OBGisfKYm70g2jqzSN25DT4oL09Q01oRiMgBg2V
         opxABo1RYvcmQUnLdSkoVGrn79l0/aNudT6uiHGwtxhuAgXVoNad4ib0mPPdXF/iGmZr
         xhuECMim5cLM5ayRtvY7s0Nu+hF752CpZlsQgbjPm304H2wIrqipKr9fLlBEC1XXJj+e
         bhCa/6MDLB61MXjH3DGUtHDHbGnvFN08tMFspVE22FHP/nX5rBB8kUAO5yrMTCta79QT
         1vBfdLnH48k6bsI+wJcqu3EXDm90yjHUZUnMycXaJ09OrPyiGjtMtCDpfjNFpf4s3Yl3
         sSDw==
X-Forwarded-Encrypted: i=1; AL+hErEY+tfNLq+XdR7V+H28kI4lMJ3CO0JDzLPPV8r/IHnY5FikVP0p5LIWZv0yVYPri0xOuVwmYik=@vger.kernel.org
X-Gm-Message-State: APuU4Z9iwnle1ASdPxtBaPDWwXLzMYgBLXL7pe2lV7RV9tcC6efz7fyh
	b0jBAlJxlJRWI6uxPTxb0zj5i5Wk4G8dtMxROQuu+mow89MBlf17zBwRDB4XiJVYy+97XU7Zset
	HrIKxZBr2P/x4EasuftzrCFQuI5PNAP0Wfjabpz547zzRpRZsjBvPU3Jd5yl5X87NZznh58CTPe
	8aMB+LOAOF0kCAzuez3vdh78t5a/Sy4wqouQYPHTkqiyPevyemvm7KKFfu+fJieuwAXPs+35a4E
	3cnBuKdkKfKJQ==
X-Gm-Gg: AYBFou1URNYvNJYOH8eLgvVs9sXO0+O3vkk4I7CSvSD3iCMfUQNDGyfbRaHq/w3oVZK
	yp2I8sOj9pTGBDhqwAliAjFh/n5QjPvezhp8564eUur9bMC5FBDEqOtIHtmHuG+bThNnAVRwwJN
	SKdIE21eHBBwHvgwEI4FK81RRISc7VAeyINIhV76wW9MqwnayZEDRgjpP5CE0OJz33tlEQJktbq
	4/x+vfT0GVRSVoJiX0e/Q+vp7BCaAIXxhkqh6mVBu1LlVyaZ9nSf0hiY5u1JJ1zjNrgozJlUmWH
	yo0xK6loVCUP7O7LMS1kwqp2AtOV1Loodt6lLXbmPqdxyZj3uJ8W/dFARm1QQmvwDwPZMmqCVCF
	LoSYv+tR9NmpgGf7cYWDrP3smbTm1f/pG2quoIB/He50DGW46PYAa01cWg/GhZzHOcVh2rwsLWh
	OKd7VP/jLDbF/BeV0/+ovXEIgiB/z64ixjB3w=
X-Received: by 2002:a05:6870:8131:b0:48f:e0e5:a1f6 with SMTP id 586e51a60fabf-4adec8c5b8emr375129fac.42.1794120786557;
        Sat, 07 Nov 2026 22:53:06 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4ade6ae6bcdsm10508fac.33.2026.11.07.22.53.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2026 22:53:06 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1b0d864826cso523589c88.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 22:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794120785; x=1794725585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pyBtVqP8NGRwts0i4gjQbcb31qjJWBl7WO9S1ZYG21k=;
        b=FkGQbpKRSO8EzZ88ed5g6+mUmXe2/IIVI5nFKuCZDvRyopvzJNZCrWWjgEWmBCgol3
         EYVt9cCV/p7OqAAe5KqYJ3mPixhrNS8eVaSBfjRqTVW/HEaYYlh9miA2Gyt964NYJQR6
         hWy8khz/cIZUFFX34cabDE+6JuQ3AoNOOt3k4=
X-Forwarded-Encrypted: i=1; AKwUvBxQfMA5162YFAugwIl6yKtJDPWQCfcK0v+OUI0nTTF9/e1Hi8ISrQ78qvBd/ttg2lesARzk5FU=@vger.kernel.org
X-Received: by 2002:a05:701b:220d:b0:1a5:9abb:fdd7 with SMTP id a92af1059eb24-1b39fecbd9fmr1183174c88.9.1794120784687;
        Sat, 07 Nov 2026 22:53:04 -0800 (PST)
X-Received: by 2002:a05:701b:220d:b0:1a5:9abb:fdd7 with SMTP id a92af1059eb24-1b39fecbd9fmr1183143c88.9.1794120783779;
        Sat, 07 Nov 2026 22:53:03 -0800 (PST)
Received: from pc-hpe-top-git-sendmail-server.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755e8a27sm3497993c88.7.2026.11.07.22.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 22:53:02 -0800 (PST)
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
Subject: [PATCH net 3/4] tg3: Skip querying for management FW when no NCSI present
Date: Sun,  8 Nov 2026 12:25:25 +0530
Message-ID: <20261108065526.710152-4-pavan.chebbi@broadcom.com>
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
index e9b48e58fdd4..16f8368874e7 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -16029,19 +16029,21 @@ static void tg3_probe_ncsi(struct tg3 *tp)
 
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

