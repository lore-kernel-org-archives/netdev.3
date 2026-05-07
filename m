Received: from forward205a.mail.yandex.net (forward205a.mail.yandex.net [178.154.239.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB2B37475D;
	Thu,  7 May 2026 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778166195; cv=none; b=J6HuKwcWkMh3qIDYk/3IiSArH9Nte/8e8LWEw4msD5OZM9SXkvU5AGGWOM6ZFczLw9UgUQZlnHlYj0vxXKaKTnEzEcywZ4Shhb+cp6hS6fLiAKLk3AtotBfk9hq65vSrip9un7ghGImt6x/NkwiFO/+ClA2dAVPbC/MBRd9uPnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778166195; c=relaxed/simple;
	bh=iCcwHn3PwyBnBSZad+nWC2DF+AwUR6rNxGVyppWXBJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CoiAm/+2OwWLd2LFjx6DIrq2zBwAHo5cPtWv3RBwgzbtNDrf91bXsmjJTTwnu8W3jHVMw3NHHBkiHnKgE3oU/vbcHXHvGqCWUO53JdNk6AKv08InnmAy9jhOSOvOK2SVZnbFf5+s6vVf7MZoZR9aww9QoC7rlTrJkDrpibq7HRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=wAEReb+L; arc=none smtp.client-ip=178.154.239.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="wAEReb+L"
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward205a.mail.yandex.net (Yandex) with ESMTPS id 37107C438F;
	Thu, 07 May 2026 17:55:58 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:251b:0:640:cb7f:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id E769AC00A3;
	Thu, 07 May 2026 17:55:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net (smtp) with ESMTPSA id etGDd1BR6Os0-sxH9wjHG;
	Thu, 07 May 2026 17:55:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1778165749; bh=gBiLkkqLS1qi99jQalgMcLGIABwjmzVWsvCQuE6QxgA=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=wAEReb+LJ51rEjGaOWxY52rmq6fNaXfrgevXRMoh4nrQaN3lPSKVuP9CiRyxj9QVt
	 XLrbmiKcvlzicyG+SEUgQ3ouK1MOR/9MAez86k1ap3hmEMPLuntIkgAfdA4HgNsUEO
	 S7tZgzJMfnls3ggp4Rp3m6mAe9KJ4JSA1bYMnnBM=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kees@kernel.org,
	horms@kernel.org,
	bhelgaas@google.com,
	darinzon@amazon.com,
	Yuval.Mintz@qlogic.com,
	manish.chopra@qlogic.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net v2] qed: fix division by zero in qed_init_wfq_param when all vports are configured
Date: Thu,  7 May 2026 17:55:17 +0300
Message-ID: <20260507145520.23106-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qed_init_wfq_param(), variable non_requested_count can become zero
when the number of vports with the configured flag set (including the
current vport being configured) equals total num_vports. This happens
when configuring the last unconfigured vport or when re-configuring
an already configured vport.

The function then calculates left_rate_per_vp = total_left_rate /
non_requested_count, which causes division by zero.

Fix this by skipping the division when non_requested_count is zero.
In that case, there is no remaining bandwidth to distribute, so just
record the configuration for the current vport and return success.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: bcd197c81f63 ("qed: Add vport WFQ configuration APIs")
Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
Changes in v2:
- Return success instead of -EINVAL when non_requested_count is zero
- Add Fixes tag
- Clarify commit message: explain both scenarios that lead to non_requested_count == 0
---
 drivers/net/ethernet/qlogic/qed/qed_dev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index 42c6dcfb1f0f..dd75c47758e1 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -5103,6 +5103,13 @@ static int qed_init_wfq_param(struct qed_hwfn *p_hwfn,
 		return -EINVAL;
 	}
 
+	/* All vports are already or become configured, nothing to distribute */
+	if (non_requested_count == 0) {
+		p_hwfn->qm_info.wfq_data[vport_id].min_speed = req_rate;
+		p_hwfn->qm_info.wfq_data[vport_id].configured = true;
+		return 0;
+	}
+
 	total_left_rate	= min_pf_rate - total_req_min_rate;
 
 	left_rate_per_vp = total_left_rate / non_requested_count;
-- 
2.43.0

