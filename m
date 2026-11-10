Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334522;
	b=LYbtosXnCPt5PUmSLcwtbJXb/6TqmbFwv5/anz8GAL+bL4sbw795TUaVJXYgGz7qVOaA
	 lBRrT6vQnRTMY2Nhx/ooPY2srK5V+J6bm+pT4hmiGgadldQRtn4yRgApWCbeUGPV6mTag
	 gIM/6mHD2rogU2yAw4UKg4ZtoExPyJV/IfTcVGfNg0w82AqH9DnVlWAjAD7rHl3GNaDL0
	 gnQFZ71xk5m4QQHhWCSW1rxBIvLJ2KnOIXtzGreFhRGQtL1AWcXUUDcPga18RV9P8NRuX
	 0D2M8r8BomD5D3HgbYBBvOUi2873+Ngs09dYGdjkryS3lIx/TopbFFX2DX38twR0bUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334522;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=Pr4E+E+NmuRBG2khPZ6cKvhshAG8n8u6XIB4cHMpsUc=;
	b=4uxycQAa3CWyIuyvp6R9OAbq22UCE0mI0VZT3p50uN+XxpZM3ED0EuCntubIOpXg/xt2
	 nUwDgTiYQNREjg6Y60JeBlwiDCEV+e3+aXmBloVT2iB4nJROd5XaCDeDxvM6vUACA7FCC
	 22QlLMAtKSBlv3l9Y0CuPW5nbnsyOmjg+qvZYK6+j4X9pbgiRYjMy1CAxIaf2uOLrLDTd
	 9h8IbunYhpcT/XNWqqqzFha7xApsLIl/epaRa92mnCJNsBJtAVQ9LT7Ka0H0dHTW7ie+l
	 BZW+x4Z8Rt4qSnU0MwOOw5O1Dj93V5eNsDkKZmdoyk7lOX8UXOrzsUjmcdUmY287edQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="gSEO/3/w";
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D4606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 18:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F4D4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=gSEO/3/w
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3b0e61a4decso1768335a91.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794334522; x=1794939322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pr4E+E+NmuRBG2khPZ6cKvhshAG8n8u6XIB4cHMpsUc=;
        b=F41hGghpm7tzCAYr0PZywvxSMZlRIyXK3EX4klY3ZGERb6NILyvFjpwiL7bxaMOFuH
         euyYRzm3kJ80OOLoVGwSzFxIGxyb/gnaPMa0IijBNFgoYnq8H4GZCx7O2XC5bvadgEvh
         GXUUA1N6NFpyZ52YwooWV6DZ8U1VBT7e+VwMpExZ0Gdr7uqOh1+s5KzTw4CZdnpWKPhN
         +HEuN2NR51um9fQplB8msb5P7BEgIUSA4HD38tbwJcP6RFiVCUzznsnfFs5iFBN67vGQ
         3zsOlTaxlnp+dSw8qMfJ6YyhcZkKuihCdBw1oO/clIx3f/XQFg1HAAzmI4xbgyVZDs6/
         d6HQ==
X-Gm-Message-State: APuU4Z9qRJpsHlLW0aXeVSRlGkp2FUcW14TlzjIpM2YOOlcilEumtHXZ
	crl6zg2hCKrndi5kRh4ChmV0ZmSn2h/lqvbbytLS8NtajVk0fW4Sgb0oE2GQ63wFwG7pA/x7hKe
	oSwnxigWOo6OizvHJaoNBOz7q2cVDQYIaXhc6tptOYyvCBl3nA/C0D767vQHY2xzEK45F04Fm4O
	O9JMbiyANnP6AwBPpZu8TVCLdihFEank4VWShjyR/UmKNh6OFCAlpsy+bu/654CJlwoY6VHZqgH
	qzP+RcYNxs=
X-Gm-Gg: AYBFou1BjvPCev4RtPLU8Ul6fCv0SEWZQ/obFGeNMxp9sR2CNZH9IosNMSxyPzJ/2CJ
	39HXYKFLAfGA7/pJ9hZ6lrdp0+Ms80Ueol6Fucj329DDFUbsMFnjG4TTyg+JhxlTuz1fyGRCcLP
	U0UsFFc8ekMNtOu9JjEqBqXrPJ5v4IjG8nJXjCxjup7aHq2fTsr8D7lF1vzlOMOPX9NH6BYz1Q3
	O4I+VFCn+XVHMKIegejdaAxG7EPFzvvMHl1oR+6DZGYLuFIPg7wuhad+uBLE0pEfEAEIENpNyQ1
	K9yUkkapLBSerfsT+akudgz1lZjbHIDvl0oS+TzX88L70wOAMwGFYf5hspqIjmM8lvdfCIy/m0Y
	ck5lXtwqoaF+gY06KOqCf4TUCRae0KmgLtQE/vj9dTRfaELR7eNWtnftmhuyRAL5l3eotxJgl3o
	0z501wYs2JJOCMoaBbma+M9aQ7bo9IaLLfops=
X-Received: by 2002:a17:90b:1c87:b0:3b0:ab34:afc8 with SMTP id 98e67ed59e1d1-3b166cbf78fmr3522990a91.20.1794334521592;
        Tue, 10 Nov 2026 10:15:21 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b17e0dccfesm339691a91.4.2026.11.10.10.15.21
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2026 10:15:21 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-84fe2593525so3097231a34.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794334520; x=1794939320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pr4E+E+NmuRBG2khPZ6cKvhshAG8n8u6XIB4cHMpsUc=;
        b=gSEO/3/wIREwop5fb3KK7HsckTHMb5OUqGixWg3XewJWglM61cvLs5+ysls1slaYFp
         SE/A4ohoUTYGqBQEDNiL7Ayw+XwbdQ5vCM6I5RprTGdvMErf4Uo/erWYYni3NP6ZgIWI
         ulggDSZ61KweAgaBlpwfZRIg34SNlL2PD/naA=
X-Received: by 2002:a05:6a20:7483:b0:3e0:f8f3:ac70 with SMTP id adf61e73a8af0-3f18fd951edmr3482710637.61.1794333015963;
        Tue, 10 Nov 2026 09:50:15 -0800 (PST)
X-Received: by 2002:a05:6a20:7483:b0:3e0:f8f3:ac70 with SMTP id adf61e73a8af0-3f18fd951edmr3482680637.61.1794333015536;
        Tue, 10 Nov 2026 09:50:15 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm1241256b3a.0.2026.11.10.09.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:50:14 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	keegan.freyhof@broadcom.com
Subject: [PATCH net 2/2] bnxt_en: Wait for the PF in bnxt_resume()
Date: Tue, 10 Nov 2026 09:49:43 -0800
Message-ID: <20261110174943.2106347-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110174943.2106347-1-michael.chan@broadcom.com>
References: <20261110174943.2106347-1-michael.chan@broadcom.com>
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

From: Keegan Freyhof <keegan.freyhof@broadcom.com>

When bnxt_resume() is called on a VF with the PF running in the
same kernel, the initial FW message may timeout if the PF has not
been initialized.  Use the more appropriate bnxt_hwrm_poll() with
the silent flag to suppress warning messages and loop up to 10 times
if the error code warrants additional polling.  This initial polling
is done without the rtnl_lock() to allow the PF running in the same
kernel (which will also require the rtnl_lock) to finish its
initialization.

This fixes a failure found in the lab when running system hibernate
on a BCM57608 NIC with 64 VFs created.  The FW version is 238.1.59.0.

bnxt_en 0000:23:08.5 eno4v5: hwrm req_type 0x0 seq id 0xb0 error 0xa
bnxt_en 0000:23:08.5: PM: dpm_run_callback(): pci_pm_restore returns -19
bnxt_en 0000:23:08.5: PM: failed to restore async: error -19
bnxt_en 0000:23:08.3 eno4v3: hwrm req_type 0x0 seq id 0xb0 error 0xa
bnxt_en 0000:23:08.4 eno4v4: hwrm req_type 0x0 seq id 0xb0 error 0xa
bnxt_en 0000:23:08.7 eno4v7: hwrm req_type 0x0 seq id 0xb0 error 0xa
bnxt_en 0000:23:08.3: PM: dpm_run_callback(): pci_pm_restore returns -19
bnxt_en 0000:23:08.4: PM: dpm_run_callback(): pci_pm_restore returns -19

Tested on dual-port BCM57608 with 64 VFs on each port.  The polling
loop provides adequate margins.

Fixes: f65a2044a8c9 ("bnxt_en: Add suspend/resume callbacks.")
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 37 ++++++++++++++++++++---
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9d232d835758..03682d9182c6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17567,21 +17567,50 @@ static int bnxt_suspend(struct device *device)
 	return rc;
 }
 
+#define BNXT_RESUME_MAX_RETRY	10
+
 static int bnxt_resume(struct device *device)
 {
 	struct net_device *dev = dev_get_drvdata(device);
 	struct bnxt *bp = netdev_priv(dev);
-	int rc = 0;
+	int i, rc;
 
-	rtnl_lock();
-	netdev_lock(dev);
 	rc = pci_enable_device(bp->pdev);
 	if (rc) {
 		netdev_err(dev, "Cannot re-enable PCI device during resume, err = %d\n",
 			   rc);
-		goto resume_exit;
+		return rc;
 	}
 	pci_set_master(bp->pdev);
+	if (BNXT_VF(bp)) {
+		for (i = 0; i < BNXT_RESUME_MAX_RETRY; i++) {
+			rc = bnxt_hwrm_poll(bp);
+			if (rc != -EAGAIN && rc != -EBUSY && rc != -ECOMM)
+				break;
+
+			/* Wait briefly for -EAGAIN (FW busy), a bit longer for
+			 * -ECOMM (PF down) to allow the PF to fully initialize.
+			 * For -EBUSY, the message typically has timed out, so
+			 * try again immediately.
+			 */
+			if (i < BNXT_RESUME_MAX_RETRY - 1) {
+				if (rc == -EAGAIN)
+					msleep(250);
+				else if (rc == -ECOMM)
+					msleep(750);
+			}
+		}
+		if (rc) {
+			netdev_err(dev,
+				   "Firmware not responding during resume, rc = %d\n",
+				   rc);
+			return -ENODEV;
+		}
+	}
+
+	rtnl_lock();
+	netdev_lock(dev);
+
 	if (bnxt_hwrm_ver_get(bp)) {
 		rc = -ENODEV;
 		goto resume_exit;
-- 
2.51.0

