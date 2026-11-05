Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869869;
	b=2lNGCG6U0IKGthdkl209drnad+LfoCReZN0ePZo+1o222L2NX3rX/HM9XUjdpMysBmAE
	 sBhXBrR9XFHjbUgLdh44/f6KcAY8L6dUVIqJFGMvCNJIBHzPwxmYqJ9fztzB4FXB0aBkf
	 NxRuFNqahWQVWnrL0hacoHY8SBxfv+SHOomukDhDLeP/679oYETQL8G6m1yZ85PNmO0Rp
	 P+9ZFxaHAl0I5JFx+lRk7n7xv3ud9q0PNCOGa24X9CVdviRfL+QLNvayxbfv1h9WIBM5Q
	 200SI8m8og48AbBfPrDK3Tu2yPgGBmcWer3gy15shccmsjP78wl45gf/qJZVLG+aeNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869869;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=A1RrU/JNgR1RP4YNG6owTJ8LvQxop52hPUkVC/V8M0k=;
	b=UI6ymqSK9pedRYtX4MzPe5W4svGIcJnroLAR7dOuY0LIotVKMTUiC84kgzneiZh8PQSA
	 nvhoYwDK/lqRCzQtA0gq2k6gaNv/xKaDd217C+LRjzfTP3K6EJJ+233tr73PviTolqf4m
	 QX/Dqdh2ewngfaB+nFQryxV/MuhvNmw2X+3bWi8tMr675dbI89twB4+KO4eJ8yBlQvUGE
	 dhGx+fct+ebewOWUCW+0zjR+FzNYXUUKLY/E7MmnJqsSEMJ2MLdFRS6YFotTyZFiDxK31
	 2lLjSR8XisCFuEZVzUPrnfv8guds6t6jqltgwB+LePJLu8FQaRnqS1TdMg8mwPWxjrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bIL7KRz+;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A1E606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 09:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33A1E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bIL7KRz+
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-ccca948203aso735072a12.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 01:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793869868; x=1794474668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A1RrU/JNgR1RP4YNG6owTJ8LvQxop52hPUkVC/V8M0k=;
        b=Z93gQdjopCzF8lPfPaZ3Rg1X3r4aZmOSVmWBoJjQMOzvN68zVSftbSm3zRQHzBqE5K
         8VQ3hAgEwi6iQEVt53Eez+KRXDsAUtLkbfqxhtUFM4ZIy4BDPuvghZi9LkzcxzgPxd3U
         spWV8Nm0NPXxS4lBJzoeCBjJMSYrn/OqDnq54sV5rL49aG/M4K00u1VDWHff39xWkUJD
         iT+rYdzcSaSLqz50Nx1U2NpSXeA3n8t7iiscBhC6AI4d12IRBuYrDJ35XGqqEi4R/FJH
         yYk8uascQsNK2QCJRFzuXxRdfKWDOtrl4Nt+LZn+RZ1/5JZkGwfXNXjrWJXHq1ZLF3V1
         UcBA==
X-Gm-Message-State: APuU4Z/mYC1lh4R+gZ9ChIWD4X0MpAQnvBV0WrBgNNV2TAZMDxUxYUAC
	quc884kt/Kbp98bZmKfyDGQil/Rzo3UMyl/wj9suT71578H9/qbNkqwvq1oYUbORHwVTzR5XLMW
	3Hb5ROdcQf7nvuJxoj2qiBVvTbjRFW07QyNNrJht1BzBj/Ehev5lWUc4CG53Ur2VRLU8BjFRVDI
	74WlZP7AD1DEfuR/r+SC1EBYy2WteQtkYGTh5RLvHN7DnvPO3JI4eh+qduVjHoB6cDG+rWmN3i8
	xnw0EseHw==
X-Gm-Gg: AYBFou0Og2EzeyQ9T9U1/CYaGYrBKa75D1uLAfp2wSIE0++dISsUp5rlv9BcrrYoEse
	SPBSrH7udLe45LD6UIADbcBHsGJVmGdUccIIfWxm3aAbiBFmm9TVM9rNxS5vm9yfWADuwHiBapm
	2GYfF2/KFAJQGbHdFVIT+P7RZZW+jNhcPiWR3o4rVh7kkVQoCxzfertiW3BhXMFunqI/CH0r/bW
	qNSDFl9c4jirqqxNUSk3PIHkDC8p54+2me0+qRpEw52TmVGeoFVIlOuM7dz/i2cop8fKQIq8NBZ
	CFT2Suhz70xKmjBL+mR1ALA9VWPSEwUmFRa71BMRMFE169ANwM/uuQhXuoCcwLIcx63N8XNPnnq
	6xS0ZsllGQ2Uk5wGr/JthK9w48hoEPCBodZSB1t1kDXz1acOCS2r7QmIFVwVMt9B2Z7E78CwXHY
	PcgUYsQyFTIWRz6lcR3eq/hHRt7ZIA/w+tsQ==
X-Received: by 2002:a17:90b:1a85:b0:3a4:967c:6947 with SMTP id 98e67ed59e1d1-3ae89736172mr15363267a91.21.1793869868442;
        Thu, 05 Nov 2026 01:11:08 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b0b93e8cf1sm1044216a91.8.2026.11.05.01.11.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:11:08 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5358515b4easo29191481cf.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 01:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793869867; x=1794474667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A1RrU/JNgR1RP4YNG6owTJ8LvQxop52hPUkVC/V8M0k=;
        b=bIL7KRz+CB5zZaQn3SPpePiCiGHLm5Cz9j6doZR37jEFXPbkuuG9VFxK2SsMtdQnZ7
         HadsXDW2vpMpwo4+6AC/Lqc7orADi+NnQh2q+tiRUdsEtSogjvdRQkI1qsrJ2/4Mc6O0
         ONZFbQ/dfZkoRrtFdgrigd7+WP+/rBimadE88=
X-Received: by 2002:a05:622a:2e87:b0:545:32db:e551 with SMTP id d75a77b69052e-54532eb38e8mr196110221cf.75.1793869867295;
        Thu, 05 Nov 2026 01:11:07 -0800 (PST)
X-Received: by 2002:a05:622a:2e87:b0:545:32db:e551 with SMTP id d75a77b69052e-54532eb38e8mr196110111cf.75.1793869866807;
        Thu, 05 Nov 2026 01:11:06 -0800 (PST)
Received: from mgmt5.dhcp.broadcom.net ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b100af507sm47298591cf.6.2026.11.05.01.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 01:11:06 -0800 (PST)
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
	vikas.gupta@broadcom.com,
	ajit.khaparde@broadcom.com,
	dharmender.garg@broadcom.com,
	sachin.holla@broadcom.com,
	Saswati Das <saswati.das@broadcom.com>,
	Siva Reddy Kallam <siva.kallam@broadcom.com>
Subject: [net-next v3 1/3] bnge: Pass BAR1 doorbell mapping to RoCE auxiliary device
Date: Thu,  5 Nov 2026 01:01:52 -0800
Message-ID: <20261105090154.1293846-2-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261105090154.1293846-1-siva.kallam@broadcom.com>
References: <20261105090154.1293846-1-siva.kallam@broadcom.com>
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

From: Saswati Das <saswati.das@broadcom.com>

Pass the L2 driver's BAR1 doorbell mapping to struct bnge_auxr_dev
alongside the existing BAR0 mapping.

This exposes the doorbell aperture base to the RoCE auxiliary device
so that the RDMA driver can access doorbell registers when configuring
firmware communication channels.

Signed-off-by: Saswati Das <saswati.das@broadcom.com>
Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
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

