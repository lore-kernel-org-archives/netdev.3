Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922654825B1
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 05:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055067; cv=none; b=c+rMR0KTz/lh4vaLZUfny0HzXYSXBs90N+YaxieWELkSWa/PFgNN8kxQEnpaZeYovmEDAUshcjn6RQhUNCtU7GBpX3twwPPaQ+jhL8H8OpoVBhWRUgy80ftddcZaKt1ZXQvSGDY8jhqlXQs3iLGlqTQ9a/sT+1bihWYvBU5BiDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055067; c=relaxed/simple;
	bh=HMr+FTKSXdaAvtfbSzFFav/sQ1dYA/aUy2gruEkZvXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nz+LlvwGmRf4WRvPlfzrw8KF2qgZgd10yua6L1Iiunrv5j0DY/3CgXjhb7erx0OzFLbs7fAg2pAyhtQh/j9DK0GRXWsaJ5+2zMYN2JOxDoB6bSxq3M1gYfPb+RNuENlg3sQ6Ul7CPg+UVk/4/+RJzNqxFd4b/Exy9UowM+HdDJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bOpFBKQd; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bOpFBKQd"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-39e5fdc23deso1098579a91.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 22:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790055061; x=1790659861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6bjthBBm7uT2MkmTwxK/+W0UJNyCdyeJcyjZyefo08M=;
        b=KqnJnVoobLF1CdpMhpD8a8+m2e/c2DkQNbvYCYT+V6v2W25eYPZ828BRDtm+zzAbLd
         caYKghc4JlVKF/6GekK3aJ/bpjp9C1dzGRzfFwUCMPORtVD1aVQnodyY6y9v1HfoQhBX
         Cxkse85MOfrd6lFL9XUlc5Z/mV0VW1g+ZndGRTCIJAf+dDX/umeY6d77Vk7xu0TfSUx5
         yVi7MG0GrxJ5RtmuFgt51/J5hV+AOUWK6+jKVcPQiII5ivz19x+s4XSX9FGCN0Fh13J5
         PbgPtmUkVdlHDBN8BKxvX1OqkGcMbT4DcFaLPLcvQHWI5G8U7abL2QkS9XJ9PTsw2Nu0
         sj3A==
X-Gm-Message-State: AFuF++nPITQkFL0OiIuM/BehFmBfLoe5uz0AvsGZLrtLPmWqaCBWP0yR
	muH1aMazni607TWA3mx3Uq5DXWjJ+uNsItFrhAe4WnNHIDuTbTsYUv9rmPRQVLBACl4MxLwOALe
	a194Oi3eSzdUyEogqCDvnPJezPMIzfPSytx87rBkUBcMaXrRnre/HobQOFJtBj+hAiHCB52+bTN
	EpBePY1oxkA0qv6iU0hohHc9wtBF6zQKl2i5W2Wnb/MAhnQGxacAEvup0WWJ3xbgv0IZDPHvO3V
	VEJa5h/6F9AjwsAGA==
X-Gm-Gg: AYBFou21Usf5EuMVotxKouULiEFJjUAG4E6+xGXSekT9G6/xWiqATO+MLFEoAMjXfyb
	AcjwQh98nofDGO8JlSodmmlomzwUI7eZ+ljAqdmBWLUWGe3GkxWbeWS0sTDQ/t9eJ0Mv4MAiuGL
	filJ/PAXv1SACA7wLw9mFBdMB36VOFJQPFiC5Em6h5v23TV3xL3km0ThjJIC2dKBoHsF/TX8zUA
	lyqpgz5SAgniriekEPW26HIqkEFv6mQz8nXAfBnPWfdh1yGLsLsjbtDQqQIkNwqwx1wxkR1TZw6
	UdXLtTD2VMrobUKgc3fIlqdY7AR6Y1gEJAqZ87Bv6iFodNX+fR79GuUAjvk2ImS++V9yoo1fdMp
	TZ0QrfXiTXg2I/nW8GZ9LnolYIXBj827SmrLCOlYx7W7GbfIY4kruUxuluAtkrpSGaQFPyhXrVt
	vN0TG0JFRKHvXXVPBClGbiBLJX57gC46LbLxpeFmDHag==
X-Received: by 2002:a17:90b:4d08:b0:39e:6c69:34da with SMTP id 98e67ed59e1d1-3a0733258ccmr25197a91.62.1790055060847;
        Mon, 21 Sep 2026 22:31:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a06e5041d3sm456363a91.7.2026.09.21.22.31.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2026 22:31:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc7348bd56fso3230466a12.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 22:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790055059; x=1790659859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6bjthBBm7uT2MkmTwxK/+W0UJNyCdyeJcyjZyefo08M=;
        b=bOpFBKQdchqGQicyko/Cf1vPzTkhguGRYD6IRIwAKuDTJKl5McTbo3QzcIuVgr9AJ6
         oetlthpJMOAuRoRvaK5XHntxFmyAvz6z5GaCHywccBeKgCnTaueXioWi4uDQmgoBZ23C
         7g1xeuvlWR+1hO1bNQb8YZm3YNLR5YsIu4wTg=
X-Received: by 2002:a17:90b:3950:b0:39e:6a81:5a8f with SMTP id 98e67ed59e1d1-3a07328562fmr29266a91.35.1790055059049;
        Mon, 21 Sep 2026 22:30:59 -0700 (PDT)
X-Received: by 2002:a17:90b:3950:b0:39e:6a81:5a8f with SMTP id 98e67ed59e1d1-3a07328562fmr29239a91.35.1790055058553;
        Mon, 21 Sep 2026 22:30:58 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f29dc903sm2029025c88.3.2026.09.21.22.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 22:30:58 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/6] bnge: Drop obsolete bn->bnapi NULL checks in open/close paths
Date: Tue, 22 Sep 2026 10:59:02 +0530
Message-ID: <20260922052904.59237-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260922052904.59237-1-bhargava.marreddy@broadcom.com>
References: <20260922052904.59237-1-bhargava.marreddy@broadcom.com>
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
index 367109dad496..9e606fd1a580 100644
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
@@ -1247,9 +1244,6 @@ static void bnge_clear_bnapi_queues(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
-	if (!bn->bnapi)
-		return;
-
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 		int j;
@@ -2382,9 +2376,6 @@ static void bnge_disable_int(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
-	if (!bn->bnapi)
-		return;
-
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 		struct bnge_nq_ring_info *nqr;
@@ -2576,9 +2567,6 @@ static void bnge_hwrm_ring_free(struct bnge_net *bn, bool close_path)
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
-	if (!bn->bnapi)
-		return;
-
 	for (i = 0; i < bd->tx_nr_rings; i++)
 		bnge_hwrm_tx_ring_free(bn, &bn->tx_ring[i], close_path);
 
-- 
2.47.3

