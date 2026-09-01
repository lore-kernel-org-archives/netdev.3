Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394964A0F17
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290312; cv=none; b=XeSvbaBc23NLkVRkhetWP2vW69/nK5LcxXgzJEMsQxrCx24WyEzcUxTC/b82YvBWqO6+tzvXNBjQOtlPWZUq3ksx/iQ2+GoOnB5oSmiN95u6+k94C3/VE3KzduDlw8FxXAML/EoFl39Y+NrCYlTnsll4BAidqBb5fK0QMdNB8PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290312; c=relaxed/simple;
	bh=cT8ZEKHAT8Xn1sHTU5bkljeWfxPtFrQE4WQVZMOBlIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DECCFaJfFhfsINVVpBAx7WHwPyaZiD63qjrrSX6rcYloSSvZMo0cJmmDF0908elWeVG0jJFscxlHqfqY8P03ccNeG4jkAOF7jNgcbEmExKQwHCxoh2HSuA6d8Hv05R4tVCdHrRwqFT5Dwu1Vpg5hrI+59nAIpRZrPR0JaHvWDqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Cgjr5YKA; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Cgjr5YKA"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-398b3c37877so337187a91.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 12:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788290309; x=1788895109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VqNDSMrUN5Hnu4Er0j5df3BDuTddzqevbT40udGtjGk=;
        b=lL0p4R6MOsHcsIGQsCGJUmvfhNoSzgOzkL1y/cJ5I4gdH8OjHsbNmgbFt/vbzF7QfG
         ED02ckNJBCMan41TatQi2iu1srVomceSVCN2BwYja+byFSjToHe/liXeVyVvi1Ossa/V
         IRw6SKcedFqZELr+HQHBw1qixf+B7T0mhSC6yktaM0zAVDj2PHLSb9u/z2zEQ3YP3bJI
         FKQoagKll2XXl//ja6Ptz1micxbuaAWtGyIjrcTPzapF5s452BgMzVFgCdu0aEtIc++Q
         feWeShbveEmx0Gob3d3X+3jAe0CvNOJ0X7+x3KwYOeHyDENQ/XMuff7dnexVqvsYYD5v
         mTQg==
X-Gm-Message-State: AFuF++lO9MlxxUe+k+A9Hojgr1+3vDuEvcqGFYox/Qjdea0rYif75QIp
	4BORHSUbYzD8c6b/DmFGNFAgSc2xyrK0f3nma60kz7uRU+cRez8hACFB4a3mB2DNkgPnuV6/Alo
	/Bu/kTLYzqeGND6qMrW+cPrxmmlntkI4p40RZVosRzfsSITkBTE0hZIDcsqZS6icdVHDDKBf8IX
	zq6I9LPv3Li4cnCqam0v91FxeaRAPXTlVr9XsUY+04IcQokHzEQTtI653qT+SBo9BsAMSP4sPX+
	6Jt0HxAVmSjQ7L+oA==
X-Gm-Gg: AYBFou3TCoYKhAVLKeSmFQREHNnGiwssBxiLC9DAwpcGh1O3x5BHTnQstRZxXHFEwjQ
	2SWJzfkrwbZTEpVYcKoZ9zjConmNWc0/iWCp2ePwXcR5NQF5IASVOO8s2NZ6OHUwDXD5MLFXP1U
	YSBaO7pMjd1cfMjMKZyOWldZp+mtYPvo9smzNUwx7jjz/htq8WKt4jHcIJseLNTs3RepXoeHg9l
	N+vVJUTCdRrcKkuLCl+BeuS+5vu48ak6Q+zcEaNQIYGoZZyKaKdhqCHlhxrF6EqL4lOaRtDmIwM
	aULZy/g8IS8VzGhpUC9Zs2QpUN0M10y+niM/NAnv5mi5JB9xh4qiJM62CMQpV3Zq/G5Z51+umaQ
	CiW/mMHwSykRSfgNf74j3DsTNfSfIlEBSdXhJajbIOni71Dop6lWXu/LneUO4cvmkmm5H7iA28O
	PPPWvaRchN0yNKuL9Uh+DtPs4OGmbnG8E2nFDmwYDzCA==
X-Received: by 2002:a17:90a:fc45:b0:398:9beb:5c17 with SMTP id 98e67ed59e1d1-39ae8431d4fmr472367a91.18.1788290309239;
        Tue, 01 Sep 2026 12:18:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1430eb1bdcesm6327c88.5.2026.09.01.12.18.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2026 12:18:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso255349a91.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788290307; x=1788895107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VqNDSMrUN5Hnu4Er0j5df3BDuTddzqevbT40udGtjGk=;
        b=Cgjr5YKADieRgLJmSP1cYZrxOdBM+ODVUUcCzmjLaGMD6QrMKrSunfl+uj5nDblxLW
         aSQ8DltKqHi5ZtDolZG1lc6siKaPLIxQB/ZEuk0PH6CZ0lv/XGyAWE5J/ZzelDKhsq2z
         RKMqtu/iCal8BGFBHdTNpB8k5KojDCp291n9E=
X-Received: by 2002:a17:90a:d2c7:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-39ae82bbdc5mr475241a91.9.1788290307030;
        Tue, 01 Sep 2026 12:18:27 -0700 (PDT)
X-Received: by 2002:a17:90a:d2c7:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-39ae82bbdc5mr475159a91.9.1788290306517;
        Tue, 01 Sep 2026 12:18:26 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b79cf9sm186440eec.18.2026.09.01.12.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 12:18:25 -0700 (PDT)
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
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Dharmender Garg <dharmender.garg@broadcom.com>
Subject: [PATCH net-next 4/7] bnge: Drop obsolete bn->bnapi NULL checks in open/close paths
Date: Wed,  2 Sep 2026 00:47:25 +0530
Message-ID: <20260901191728.643212-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901191728.643212-1-bhargava.marreddy@broadcom.com>
References: <20260901191728.643212-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Since bn->bnapi is now allocated during probe in bnge_netdev_alloc() and
freed in bnge_netdev_free(), it remains non-NULL for the lifetime of the
open/close path helpers.

Remove the dead "if (!bn->bnapi)" guards in bnge_free_ring_stats(),
bnge_clear_bnapi_queues(), bnge_disable_int(), and bnge_hwrm_ring_free().

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index dcf04d391570..dc3d51f31e5e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -85,9 +85,6 @@ static void bnge_free_ring_stats(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
-	if (!bn->bnapi)
-		return;
-
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
@@ -1240,9 +1237,6 @@ static void bnge_clear_bnapi_queues(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
-	if (!bn->bnapi)
-		return;
-
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 		int j;
@@ -2371,9 +2365,6 @@ static void bnge_disable_int(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
-	if (!bn->bnapi)
-		return;
-
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 		struct bnge_nq_ring_info *nqr;
@@ -2565,9 +2556,6 @@ static void bnge_hwrm_ring_free(struct bnge_net *bn, bool close_path)
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
-	if (!bn->bnapi)
-		return;
-
 	for (i = 0; i < bd->tx_nr_rings; i++)
 		bnge_hwrm_tx_ring_free(bn, &bn->tx_ring[i], close_path);
 
-- 
2.47.3

