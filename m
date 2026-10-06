Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C16649E5E6
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303849; cv=none; b=WPHs+rjqFuvOA0VdMhBXRmLTIon+vALZmw68aF20oAGh8zjEo2GWiYQ3lHKcv5P2m59mxZfJiuV9O3ieA5nAeG/ZuuPk7IK5wNyax1/iXXkPZdnptom9bKnEcPNPWK9LvNI1DCqce1wA88Ef+Xr1DezesJou+Y9ZWVIopFoomv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303849; c=relaxed/simple;
	bh=RcbvBXG/6lrsdkpqL8g9IxIvet2V3+6WRbvHO5gAYgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/Tq3f0nI2evnorf/Sw2/JMhxAhNLAu54Ba6jb4NL5RrS/Vkku7S0FLhn9hF/f7NKIXqCl6tj5vcWxbSjJhrqCGH1XhP30P8Cpny5uFao5he2PzjY3MitUc5fXSowel7EeBwMAJ0dVveAt5V7Fg8DSkIuv8oDAsbVicLoK6R7Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h3gxBz3D; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h3gxBz3D"
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-93e63ee7b4cso64595485a.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 09:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791303843; x=1791908643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8p9gZ6dHUeXfr9Ect+sOuLZTX6uktr9z7PwXXUBPJY=;
        b=h6lthJBqueiOiS/B7Vp2MWL3/QkUOYefJls0modJlE7L9cMLv+TvUlT140T5oQtJcd
         w89idLNhnObwdlbAWgpC12/7UoYsuk05NNKsktVjTi7thBNUWJY0T/Iq1Yi92D6M4vhY
         WHQSXV5xZ/7wFxOL3KNkZumjoQtRcTEMrRDN5/CC2+QCH0zk7V6NtVabj1yE8ee2pEOY
         Wi1xs6gwyY8NS7kuHhTjjthOVP+LPFQvi64hpJoH4g68CZXGPEUFftVazOedY+o+IePx
         6c5w4mfn0FnD2//rL+8IK0dvRgjU6oI6bTmjY4xCCVGFS7a31wjxHCJTvSXMmu6vmFOA
         ZvSQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXeMLgHOYIWvDOn9OUMa58qYcme5ZDWkuYAoLXdnUzVQcf2882LCEEvyx0Y6I7cEKr+X7pV9c=@vger.kernel.org
X-Gm-Message-State: AFuF++kSWwd/aVncy4Cdv27qucAAf/ddqgj/XYgHttlmrMlyysmX5JRG
	n6J4lpzRw0d+XtTkbLR0Bqsr90KgBHZnPiOE2yqaW/GJncm6TidK0O8UcO0I2xX0MKHGz36QSK5
	FROj1nG1xhJ/IUJQ70d8bpd3idCjEZvSSHndPAO5iqb/2kpEq8Yk7uXKBgCGjwI9TCcSyth73Wt
	H5W71BDgsBuLw7LYI2K9fney3qBiT5k+7laDTIUbf0W1a6MVh+HxTpuR5m6AYhThQiYFHlEXa0F
	bAtaUBTQAwP
X-Gm-Gg: AYBFou3klLN747SWxflgu7l1qvcvgM89xvSu6a2T78TUB0Sk1+bBrwlmcdhKhS0YY4z
	PqE8DfBOOuq8G+qtP0P7LxbWeIeSUa75ZhL9AFWcptwgsqDq4PG4/JRfRXXhqZ2mACwuWh1Hy/b
	1xpoLWKHpOw4gGh4eqyxx67ik58D1SH8FfU4XAolDWdb23XG7J7vLK4yT5Q5XS0ftFnTSZuZqAG
	oYnB6+LtVpBobS3TJaaQKH+aqYMY8E1vNlw2B/f1h+FKWs3GfRoVWh+iD/ypKGtx+Uz0CoBa5Lh
	zL5IRINn60ffOPz6sw8cHNGWpR9O6zmXc04bV8T1ce4dGrWn5VZBmnNFPQJpw5kXeM3hVgOrHdW
	uryTUdfdn/EasxhvBWHlz4hasYMAXeX/ouhU0t/7cPmMgecxSZNnuyuym+b7dh66qDtJpTwndoP
	q4YtVKL3ynMNQK0lt+bX/Y/x97m3TtvkBYrg==
X-Received: by 2002:a05:620a:2705:b0:93e:646c:9138 with SMTP id af79cd13be357-93e8f359779mr350634185a.26.1791303842311;
        Tue, 06 Oct 2026 09:24:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93cca29a552sm482859085a.7.2026.10.06.09.24.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2026 09:24:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-53397b6e05aso58563421cf.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 09:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791303841; x=1791908641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F8p9gZ6dHUeXfr9Ect+sOuLZTX6uktr9z7PwXXUBPJY=;
        b=h3gxBz3D6k97B+mQI3Oex6nh50F8IZvF7hZoEmLHknu9f77Hi3+guupWPYkngMZxe+
         1ezv2YEWoepQziuvDsbVvqJ2EXGC4oFG9ud8p1q5KLxzC+22DtaW23c6WzhadgTAOVbN
         NHRGIGTprNn+kvTlynKT16c82xbEQ8Q0ksO0E=
X-Forwarded-Encrypted: i=1; AKwUvByvwuZzGG4QWDTYucxt+5WKiBdWMxEaRjZjCSgmtKQNN9z0vtTIf1qsVIfTfXUszshhyFqwAk4=@vger.kernel.org
X-Received: by 2002:a05:622a:312:b0:535:2283:20a3 with SMTP id d75a77b69052e-53566b24b6fmr31828991cf.33.1791303841412;
        Tue, 06 Oct 2026 09:24:01 -0700 (PDT)
X-Received: by 2002:a05:622a:312:b0:535:2283:20a3 with SMTP id d75a77b69052e-53566b24b6fmr31828551cf.33.1791303840787;
        Tue, 06 Oct 2026 09:24:00 -0700 (PDT)
Received: from mgmt5.dhcp.broadcom.net ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5356b860df8sm9020961cf.14.2026.10.06.09.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 09:24:00 -0700 (PDT)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: vikas.gupta@broadcom.com,
	ajit.khaparde@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Sachin Holla <sachin.holla@broadcom.com>,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Dharmender Garg <dharmender.garg@broadcom.com>
Subject: [net-next v2 3/3] bnge: reserve TX/completion rings for the RoCE MPC channel
Date: Tue,  6 Oct 2026 09:12:56 -0700
Message-ID: <20261006161256.1493672-4-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261006161256.1493672-1-siva.kallam@broadcom.com>
References: <20261006161256.1493672-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Sachin Holla <sachin.holla@broadcom.com>

When RoCE is enabled, the bng_re driver allocates its own TX/CQ rings
for the MPC control channel out of the same per-function FW ring pool.
Enhanced bnge_reserve_rings() to account for this extra ring count to
avoid pool overflow while allocating netdev rings.

Signed-off-by: Sachin Holla <sachin.holla@broadcom.com>
Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_resc.c    | 32 ++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index 4711dd4945ff..9dfb22b7c7c7 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -110,9 +110,24 @@ static u16 bnge_nqs_demand(struct bnge_dev *bd)
 	return bd->nq_nr_rings + bnge_aux_get_msix(bd);
 }
 
+static u16 bnge_tx_rings_demand(struct bnge_dev *bd)
+{
+	u16 tx_rings = bd->tx_nr_rings;
+
+	if (bnge_is_roce_en(bd))
+		tx_rings += 1; /* For MPC TX ring */
+
+	return tx_rings;
+}
+
 static u16 bnge_cprs_demand(struct bnge_dev *bd)
 {
-	return bd->tx_nr_rings + bd->rx_nr_rings;
+	u16 cprs = bd->tx_nr_rings + bd->rx_nr_rings;
+
+	if (bnge_is_roce_en(bd))
+		cprs += 1; /* For MPC CQ ring */
+
+	return cprs;
 }
 
 static u16 bnge_get_avail_msix(struct bnge_dev *bd, int num)
@@ -250,7 +265,7 @@ static bool bnge_need_reserve_rings(struct bnge_dev *bd)
 	u16 nqs = bnge_nqs_demand(bd);
 	u16 vnic;
 
-	if (hw_resc->resv_tx_rings != bd->tx_nr_rings)
+	if (hw_resc->resv_tx_rings != bnge_tx_rings_demand(bd))
 		return true;
 
 	vnic = bnge_get_total_vnics(bd, rx);
@@ -275,6 +290,7 @@ int bnge_reserve_rings(struct bnge_dev *bd)
 	u16 nq = bd->nq_nr_rings;
 	u16 aux_msix = 0;
 	bool sh = false;
+	u16 tx_demand;
 	u16 tx_cp;
 	int rc;
 
@@ -293,11 +309,12 @@ int bnge_reserve_rings(struct bnge_dev *bd)
 		hwr.nq = bnge_nqs_demand(bd);
 	}
 
-	hwr.tx = bd->tx_nr_rings;
+	tx_demand = bnge_tx_rings_demand(bd);
+	hwr.tx = tx_demand;
 	hwr.rx = bd->rx_nr_rings;
 	if (bd->flags & BNGE_EN_SHARED_CHNL)
 		sh = true;
-	hwr.cmpl = hwr.rx + hwr.tx;
+	hwr.cmpl = bnge_cprs_demand(bd);
 
 	hwr.vnic = bnge_get_total_vnics(bd, hwr.rx);
 
@@ -327,6 +344,13 @@ int bnge_reserve_rings(struct bnge_dev *bd)
 	if (hwr.stat > bnge_aux_get_stat_ctxs(bd))
 		hwr.stat -= bnge_aux_get_stat_ctxs(bd);
 	hwr.nq = min_t(u16, hwr.nq, hwr.stat);
+	/* Drop MPC TX ring from L2 TX ring count; it is owned by RoCE driver */
+	if (bnge_is_roce_en(bd)) {
+		if (hwr.tx >= tx_demand)
+			hwr.tx -= 1;
+		else
+			return -ENOMEM;
+	}
 
 	/* Adjust the rings */
 	rc = bnge_adjust_rings(bd, &rx_rings, &hwr.tx, hwr.nq, sh);
-- 
2.43.5

