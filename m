Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C6447C107
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202727; cv=none; b=dHau38kLsVOhKz7PdGwSwbgXtPWlj9noKl+QVVgAO023+rFB5NDUN2nkR/pgDd3cpmBa1230nAfSrKpOYgIbIpGXT+vDWsYkwlBM6VxkfwRG3YQYzVLZqPY5MDWPHgTpnc2xhaQJv2kik2DQp7DNu7WVZHL4awaD9fmDG8ViUVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202727; c=relaxed/simple;
	bh=tXlWCd6YT9nX95cWZipWpujk/ckqI3uyEOqsUuochek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6Zd7wTKgIO0uEadPPO+lIhTDm7A2IfT5F2BwYvo24QZEGqtjlDDpnJCXumnUQ1+/I2UWvW6IcnBJiV4Z2G+lAj6GRtAM4etCtOdM9ppIVJGuA1ZVKzX6d7cAfxUZ0Q5oM21eOuBUCWjs2S+eZ2aTSXRLeFSblMaO+qLPZZ6hGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fjuPdCvX; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fjuPdCvX"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2e4b76cccafso1854075ad.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 05:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791202726; x=1791807526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m9YNZ++OX4IbuvtJ4f7tTPEhLK/nrx5xzhX+t6VKIeI=;
        b=Czjj5GebaS2fEEN1M8HCTbFZz72Jvpw4LMkcVcfhOgLqA/v/Cx3UztMdY9AiacOhfr
         MxNcsxAT7B7N3fJIgVm0ogcWrgbntL7DzEdFjhouA84VLYsTwYTvNO4Q3+tcofzq4Cmc
         zvi7bVojNBfKvI3xgrXQOSgT+FFpB4ZoYGXOA8eeZNEdfAcyrIqRf6rX3/agnMIAwLdB
         3Gcu5Xzuy5Lg28Q1QR/7F5SQSorgfHitOulQUIEDLYJSF/0bNbUzn1mNLwbiy3FeW04w
         Qtw+m/0z9ph955/uzwV86LQzy8+s8BeGO7YAcm4Ze68mTWDA+K+ktp1i0BsiJIgGue42
         ILew==
X-Gm-Message-State: AFq9FYKRV1zMEtmyUkQGkwrXaXIeaNerPKM7JdRPLd7PfqY4GoHktdMr
	uDL/4Mt6AmsjB2bInyzuUWtiMW7n5E9FphJu7DsGA8xrRLpw/diTvqKPSxUsv4B+EH93ObbmVmF
	e3ZmtBUwFMQmnTRlQT2DqeOi3sDPWEdTLPhErqbWfwvJ/CmpakeQ88OucHKCVqKApK1izlsG47F
	nh/4TsmPeBZPQPC9HzIEuajI+jXXLqBW91fQ1380pXgIL/WYroEl672zXvQFXqG04M1mynrHVph
	YUIsSF1WSachfEAIA==
X-Gm-Gg: AYBFou1+70QlAFuTKHaJrKUSZ77AuIYCcXt5B4mfOryC5CTocdKF6y3UhNR76nmKcBh
	VTbxFu7lpkA6YiUIK2/zIagIaUJ2GRjhN6QmOXlOZrn5/pvfbM1cij52/M3H2FQOr7MQQ7i4XA+
	MveL3P+QzNpAJHjtTqVUFIavfGwfhlVQNLWohf9mJjR8V7M79WgjSmhtk8wBx7B2RGlSgZ3GDZT
	KpU7QVC8GP1rJpwWp8ghqVfMJlixTgN/48QH6WYr3SewJw7jVOoE1eaT2KLMo7E2bQ05qDa5uj8
	RLvJreQjhLKnGkbOrp+MJkxAxkjiHQvlkelACnvMnK+TBDsUVjWH4EirVZIIyC8ODcVaDTnqWF1
	BsIVwhqPW4QrNZE6JESOADqlIQn/S461tMH78MQKSwzPZgeoPSYR+yXsPBrcR8Mea/j7b+cX/XX
	/nuNQ9YA2inHs6RoAkuQZ8oUtOrECuTHzxYNxpYZAs5A==
X-Received: by 2002:a17:90b:4e8b:b0:3a7:250:3853 with SMTP id 98e67ed59e1d1-3a702503b3emr6877057a91.23.1791202725698;
        Mon, 05 Oct 2026 05:18:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a6dd378095sm1481473a91.4.2026.10.05.05.18.45
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2026 05:18:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso3284149eec.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 05:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791202724; x=1791807524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m9YNZ++OX4IbuvtJ4f7tTPEhLK/nrx5xzhX+t6VKIeI=;
        b=fjuPdCvXAtVRGkYHSqHoSS/GqLkU78x+l7A26Qtf/+GmxYUipHAfMueM+5LRhkISSY
         TX7FNl2OKCLPjSRXEXjqv9jdP4gn8Q5o9yVHwYty/JKCMFcmHFgDp3Rp+suBv3mNSy49
         KRvL8SEXA4/34jvMD831jfpFvFftGJdP2HAkU=
X-Received: by 2002:a05:7300:e9c4:20b0:351:1e72:7470 with SMTP id 5a478bee46e88-3511e727a9cmr8206609eec.13.1791202723597;
        Mon, 05 Oct 2026 05:18:43 -0700 (PDT)
X-Received: by 2002:a05:7300:e9c4:20b0:351:1e72:7470 with SMTP id 5a478bee46e88-3511e727a9cmr8206572eec.13.1791202722907;
        Mon, 05 Oct 2026 05:18:42 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351272ceb02sm25687542eec.25.2026.10.05.05.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:18:42 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Dharmender Garg <dharmender.garg@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
Subject: [PATCH net 2/4] bnge: require NQ vectors beyond aux reservation
Date: Mon,  5 Oct 2026 17:47:02 +0530
Message-ID: <20261005121704.227866-3-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005121704.227866-1-bhargava.marreddy@broadcom.com>
References: <20261005121704.227866-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

If exactly aux_msix vectors are granted, probe continues with zero NQ
vectors. This leads to zero-sized allocations and out-of-bounds array
accesses during ring setup.

Require at least 'min' vectors beyond the aux reservation to ensure the
driver always has an NQ vector to work with.

Fixes: 18a975389fcc ("bng_en: Add irq allocation support")
Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Reviewed-by: Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_resc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index 4711dd4945ff..7c26943c5cb3 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -382,7 +382,7 @@ int bnge_alloc_irqs(struct bnge_dev *bd)
 	irqs_demand = pci_alloc_irq_vectors(bd->pdev, min, irqs_demand,
 					    PCI_IRQ_MSIX);
 	aux_msix = bnge_aux_get_msix(bd);
-	if (irqs_demand < 0 || irqs_demand < aux_msix) {
+	if (irqs_demand < 0 || irqs_demand < aux_msix + min) {
 		rc = -ENODEV;
 		goto err_free_irqs;
 	}
-- 
2.47.3

