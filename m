Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7E7374E64
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202740; cv=none; b=OPt5Ny3s7pdSC9V4aelQ2BNUXDnLSdHa7V7K6Qw2VQMRIYRLnYxRJvjS+rMiHL29CfOGwgS201F8468VzzRE8+x2u835mhj0pFCwZ+li8YQ28lui3PCt5xnSlbXLvJT6s0LuD0CWpMj7wsowI7crM5/N0WaQL7b1TH4W2xXJmzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202740; c=relaxed/simple;
	bh=LwT8YD/0iQneScUmn7PmYzkkA+TpVxuKTz+5LjxFZ38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRDuhTyyMECkSEBmHbvHGtOt0tImsLp1nnu2/pokYLO0dlrV34LjFh7QWH6+TlbDcv2C3hi5F7nUdxVkPZcKP2XDWHye1Pj5obUxUxr26YPhXcWwrSirxwtHbHa9OoMLjI9MP7aQQHo2PZhu8bEDRsHXc9FcFn70kmI4RIPrX8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g4D7Jq1A; arc=none smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g4D7Jq1A"
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-66c7127a73dso71822d50.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 05:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791202738; x=1791807538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TrBS4PnotPAQvpTrqkrnkQqMR1v1OmiTLLbvti1RdcE=;
        b=FIvZCceMryiL7hkj5Nh79Qh9oTGl2ZBNNVIhKIoSvOXhS+FI2S2LSDUcBOIkbZ/loq
         OrHnmcDpKolGMT6pE8uUqKG0EG4HgduVTekO3NSjstNf8dmTW8ArKzUdBdRIs2EevFFl
         ssYmDKPvO6BbPoEDLL8wZaOt1QuC6i5VRorh0j5x6ZQmZ+VNbwVS09RIZtnuZNhlKlXM
         v1Foot6pFWS8AAL99/KNHFBR8TaM9T3ZCzXE9V0p6aF7Lwo+D2EqFsTJQYfoLLAGvgvR
         UlQfC/baWuwE7Egvtw0enjGNZKCoy9sHoPaytWDelZB+aYuwAWuBUWIKHZ/ZIwQvrFfX
         Rg/g==
X-Gm-Message-State: AFq9FYKRHdzQ8YB9cvtmuH1+H+jdWX31nGyS+fUadMMWK/OidtNoPNGf
	Dhglx+P7eXKExrHzTTPiufrEiWOWdeh68eLVDm78PrIyMsXUeJmmMagSOGxfn9cVmMHiF7BPaYF
	U+orOmOErmkTc2WoxWH/PklXCg68A9ETtMX1G51+eoP6cZC8KSQL+g+a9+Z9Tm0Oq7/Qbtcs4v2
	DrhP26VwaM3pdxUXbHncoKxxwUqfduR7jhtV7zrS/2Llx38l3llFoMo+XY8cOzxsZs1WzHMUaKo
	hEq/BWW+w6hKch1Rg==
X-Gm-Gg: AYBFou2hsrp9VI+O9cWuMDi2oaAp+hZVjhSA2aKeisIvcLT/HGgD02NSfMs4EEmbHio
	70iNf1PHFrDmqRzXMH/IqkiH6uLxKk20vqzugyNQ4aErhiF+mtWPeppRq3yKslN1iu40l0l/roS
	7K4wAR5QGeAnuXsy9yLl32ykC4G3fPAt0vFnZDXYaM+mnH7+oZBE3HxZZKcRrzT406oelh7di7u
	6YWrjFrhKeIUH5DUtAOk4wqNnAHV0X2C/A5Fqyc8n/QbGeICzJ7HPHjwJDbFA97QgBmgTQq6mFS
	a3UI6MlugM/9zde7UJ5rGhjMDEJn5N7WwIMUpdSY/fvoktKSDF3NhMzIfIu1PJzOyE9PKTkOQjK
	POggJaz5GJ0qB2wKFQP/fCCyEWNt0iv/S1P8T0FWTT51m2+qo6yhGSbaoDVyo8vHCSF7vyeU+zN
	OcQo/w4BqV6FngwlAzVV1GI2YOIZ2WtHDXWOZboALMZqWa
X-Received: by 2002:a05:690e:289:b0:676:9885:d29b with SMTP id 956f58d0204a3-677ac129f32mr2936050d50.88.1791202738103;
        Mon, 05 Oct 2026 05:18:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-677c1b42b9esm1250115d50.18.2026.10.05.05.18.57
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2026 05:18:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-313d1015161so5129797eec.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 05:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791202737; x=1791807537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TrBS4PnotPAQvpTrqkrnkQqMR1v1OmiTLLbvti1RdcE=;
        b=g4D7Jq1ARb0c+rSacECM5qM33MqgsSM5PgI2PtEfHCcHQXG5cz2J9YNSF+Sqq3nktp
         8wPALHbYE2zuO+M+tergobp2H54UcK+M1V/Fms5BdbRAFiLZHjrnLLC0ui2EtQWXTCkY
         5tqDVKR+u9wkYkbyPdvAZkHNbjjSZi5cTbVMc=
X-Received: by 2002:a05:7301:c005:b0:347:8d01:164f with SMTP id 5a478bee46e88-34f150a378amr13881952eec.19.1791202736849;
        Mon, 05 Oct 2026 05:18:56 -0700 (PDT)
X-Received: by 2002:a05:7301:c005:b0:347:8d01:164f with SMTP id 5a478bee46e88-34f150a378amr13881920eec.19.1791202736093;
        Mon, 05 Oct 2026 05:18:56 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351272ceb02sm25687542eec.25.2026.10.05.05.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:18:55 -0700 (PDT)
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
Subject: [PATCH net 4/4] bnge: clear bd->netdev on allocation failure
Date: Mon,  5 Oct 2026 17:47:04 +0530
Message-ID: <20261005121704.227866-5-bhargava.marreddy@broadcom.com>
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

If bnge_netdev_alloc() fails after storing the net_device pointer in
bd->netdev, it calls free_netdev() but leaves bd->netdev as a dangling
pointer.

Explicitly set bd->netdev to NULL on the error path to prevent potential
use-after-free or invalid pointer dereferences.

Fixes: 13a68c1ed754 ("bng_en: Add a network device")
Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Reviewed-by: Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index ca14d13fa3e9..7dbe853a5a47 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -3551,6 +3551,7 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	destroy_workqueue(bn->bnge_pf_wq);
 err_netdev:
 	free_netdev(netdev);
+	bd->netdev = NULL;
 	return rc;
 }
 
-- 
2.47.3

