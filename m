Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E2744683E
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519134; cv=none; b=GV7xV1DoqaEMzfvsURk0/uAy8ePSLUP8JYDPSRJ4m0bX8FTvuv+ex1obOpDgKJQk7V38F0vc+jPv6Zyv995TOBWaJpP5U/YtTvHkxsAUZ36DGKnm4JQJ0Ki8tp85rtJ0EhMQ3CvcSlDNaAVRSOLXr+N3ylHSuF+ZgyFJaLp+43o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519134; c=relaxed/simple;
	bh=WRG9UgShlNfxyLPPBnUHhlfjXfFCUHshugncnalnY60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7sUAguJCvDWKnonHpDRxPNPgBOo2+O0UlcopSgUH+nUZ+BwQuU7MhqaxuunL0+cLsrao+voj8QFEfbcVLn1mkuAgilYJaIi23sLT3eZyrARKBXAWV6/mFgr11k31QewrSlG3ud1jOgxqTTmhoS8bi2qZseNRGUvcn+O5Rv6nWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KEZ3OCHJ; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KEZ3OCHJ"
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-5bfa4c51c2aso395396e0c.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 03:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519131; x=1789123931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4T8JhJl+n0cUcmlbairws+PCdmkJbE8LYyhZ18WIdqw=;
        b=YZ+cwTdFx08h9U/jp2YBjcsbzQ3sfguJcwjsgOXiAuCjQnoT6QdG6leUgK2BNTCVBe
         bSgbUshs+FHpSc0n0XPo0Up9yHwbgfzh0EdaVfu5va9oqgnAnf20Ei32HipZWxg9aTc5
         oQ1PVSIb2daZ51m58SoX5Gn+y2VtDRJOwHl0qDUxvgJF27IREMAtWjhqB9Gq+LOI2OJM
         jKlaILzmJgIcq5Pnsx3MbknmhpqV+WmHg9SOqbDYoWh61sSTX64aT6mkltjkCuII+thF
         BVHpyjr/99PCs7M12ZAlVoC/2rYSDnz43iBN2Off6Oqtqj1Qgswnzz7r/cIoYEVJ09AD
         tGEA==
X-Gm-Message-State: AFuF++lClbLg50IRjN66NR06QOc0cz/Wt3l+VhlIFn8c0uXYvhVBnTil
	w4LBEZGfbysg5MVze1Mx4mniWB8qZwnE99AaQcKJRfmDLoadzWRGaF8LuLmgA1a9znC8/6mfqqo
	/9hjlF11fDeKgxTPcoGyQgOy4wwgyfS91o/kIv2tAE9P7K53++QFtjkQEmp1xfqkLFDAOEfFfxi
	2+ZOsJ6pINjJwShxGksUxWvXCXOscTzQd7Wfpqs0/gzwyOTANmfELPDphHbADKLub63DSIkozt5
	0bbjlF9O9Y0
X-Gm-Gg: AYBFou1xDEkJHWSxiFTC3zvSHn4yYeUTpKZGEfZ36NYUYkYFjij9nHuXhve8lZPKWw4
	VUy0wMieREa65yQFj/jMmMemU36Ux3Yf8mmyh9WlNBTxGPH5chfC28oJH6EJU3iMnn30miXkrn2
	w1Z75XPqAhdRZDLz6gOBCgQj1cItpCMNFgFxm8F5uxqzHeOy3K4s9NX3YpmjcpMmJryzQRPdLj4
	iJJ6Uz6ChR9UXIRidjIhzORaRgbmMDvd3jPYrTpg37i8FciVHpo9XfqVm3aSVVrqsSESF5QQsjX
	8Bsr/Qy2B2WZ33lmpqQG8tU+o3+t2Ie1sS5Idy76A7gBr/hqYceSZJ1DJ7JWSj0nqA1sJPYZTK6
	rhBl8vODDFiZkF9amyaXIzy08Bsz68lSNAYTWBzo3oTVEUMIK2pbhYtujB99Gwh693d701lBKAL
	IN9fbndRgbfhXiqsOy422ZI7UtMPaZPVOIyw==
X-Received: by 2002:a05:6122:4fa2:b0:5c7:c666:ec22 with SMTP id 71dfb90a1353d-5c7ed407509mr2068296e0c.6.1788519131242;
        Fri, 04 Sep 2026 03:52:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c7ecb9e4c9sm1018590e0c.4.2026.09.04.03.52.10
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2026 03:52:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2db0a41434bso16213215ad.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 03:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788519130; x=1789123930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4T8JhJl+n0cUcmlbairws+PCdmkJbE8LYyhZ18WIdqw=;
        b=KEZ3OCHJgsdO8DoRgYA0ZsLgUs4Kx22nxeJmcQPdYckPuecm92FRlHZ8mXY7PMXarg
         fer0gp8euIgc5cixgl2XDF+dy6DbUD5BPD1X3966kJ/oL/qmre4d+/6Y4zOGnlAIYLJN
         lnLqcDI5wd/4rkSNwReqzUnQrEoU4X3bspatc=
X-Received: by 2002:a17:903:1a8c:b0:2d8:d4d1:313d with SMTP id d9443c01a7336-2db1267bc0emr77507175ad.20.1788519129663;
        Fri, 04 Sep 2026 03:52:09 -0700 (PDT)
X-Received: by 2002:a17:903:1a8c:b0:2d8:d4d1:313d with SMTP id d9443c01a7336-2db1267bc0emr77506395ad.20.1788519129223;
        Fri, 04 Sep 2026 03:52:09 -0700 (PDT)
Received: from mgmt5.dhcp.broadcom.net ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534d0asm6171170eec.8.2026.09.04.03.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:52:08 -0700 (PDT)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Saswati Das <saswati.das@broadcom.com>,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Dharmender Garg <dharmender.garg@broadcom.com>
Subject: [PATCH 01/15] bnge: Add infrastructure support for RoCE MPC channels
Date: Fri,  4 Sep 2026 03:43:09 -0700
Message-ID: <20260904104328.763768-2-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260904104328.763768-1-siva.kallam@broadcom.com>
References: <20260904104328.763768-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Saswati Das <saswati.das@broadcom.com>

Add the initial L2 driver plumbing for RoCE MPC (PRIMATE channel)
support:

- Plumb BAR1 through to the RoCE auxiliary device info, alongside the
  existing BAR0, so the RoCE driver can reach the doorbell BAR.

This will be used by follow-on patches to issue RoCE commands over the
MPC channels to the firmware.

Signed-off-by: Saswati Das <saswati.das@broadcom.com>
Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_auxr.c | 1 +
 drivers/net/ethernet/broadcom/bnge/bnge_auxr.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
index 0955b488b6fe..87ae40eab592 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
@@ -181,6 +181,7 @@ static void bnge_set_auxr_dev_info(struct bnge_auxr_dev *auxr_dev,
 	auxr_dev->pf_port_id = bd->pf.port_id;
 	auxr_dev->en_state = bd->state;
 	auxr_dev->bar0 = bd->bar0;
+	auxr_dev->bar1 = bd->bar1;
 }
 
 void bnge_rdma_aux_device_add(struct bnge_dev *bd)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.h b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.h
index 6c5c15ef2b0a..13cb9289f5b8 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.h
@@ -46,6 +46,7 @@ struct bnge_auxr_dev {
 	struct net_device	*net;
 	struct pci_dev		*pdev;
 	void __iomem		*bar0;
+	void __iomem		*bar1;
 
 	struct bnge_msix_info	msix_info[BNGE_MAX_ROCE_MSIX];
 
-- 
2.43.5

