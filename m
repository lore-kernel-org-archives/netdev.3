Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F3253C3A4;
	Tue, 22 Sep 2026 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790076988; cv=none; b=Ds9X7jYc7UEM2k6P7njhCF7VQsaHngtZrm/NJiAlWzkIuneL/dFILEGTDWmP+Wcz2g8GwM2gX2XPLfO1GTuXeZd0peRrZD+I9fXQBnkfNBca8FtGpD8rIERQVajKKepOevJ9FPTiD5gdgiYVHQJ1L3UULr8CvQ+CzL8WFEAa7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790076988; c=relaxed/simple;
	bh=b40YJ0CTsIWQoAXPMUSssOdhOX6Y2Q6t3PopWF2VgwI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lVuumF5jma8q5KRuG5dhkwGv4bviYjH0QyUe5XoCtNl3WyymsKqAmvT1wU5pGyJqmr3GckQqOqPF4d7tZdVkjZWM2WhSHXAs6lCSAO2M3vnUsUjvBl1bf5iVjfawQAb7Wtss1tekd0h5fus0rrjTYRu7/rBGkX0FqbQx1ufGnoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn; spf=pass smtp.mailfrom=tju.edu.cn; dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b=PDfLCRep; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b="PDfLCRep"
Received: from tju.edu.cn (gy-adaptive-ssl-proxy-1-entmail-virt204.gy.ntes [183.242.150.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4eba2ff90;
	Tue, 22 Sep 2026 19:36:05 +0800 (GMT+08:00)
From: Yibo Tan <lhfff@tju.edu.cn>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] ptp: idt82p33: Stop PTP work producers before teardown
Date: Tue, 22 Sep 2026 19:36:01 +0800
Message-Id: <20260922113601.855416-1-lhfff@tju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c8e6d19603a1kunmf164422e8e576
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHhgdVhgaTUJLH0JDTB1NH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKQ0hVSU9JVUpOS1VCWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=PDfLCRep+aygcWqBhIejXVvt6suC80ilB9uXXVk0xS3piLis7itCvM5dHCKYHiKyMAmuyT58dOXGCjip5vYUBVqayZr4+SdjOb0qJaQCAU+CXKNvCqOu1mFjrSck5/wzux5T60EyyfRLJMnbSPr2zW7kZs96G5EhN9giiQOS8Bs=; c=relaxed/relaxed; s=default; d=tju.edu.cn; v=1;
	bh=8ud3IGLUL+wQPZjJosTcvwKRJRq5o4ZRyVtNoN15wO8=;
	h=date:mime-version:subject:message-id:from;

idt82p33_ptp_clock_unregister_all() cancels each channel's adjtime work
before unregistering its PTP clock. An adjustment callback already in
progress can schedule that work after cancellation returns. Device
removal then frees the channel while its delayed work remains queued,
causing a use-after-free.

Mark the device as stopping under its lock before draining work. Reject
new adjustment and EXTS requests, clear the EXTS polling mask, and
synchronously drain the EXTS and channel adjustment work before the
device storage is released.

With an i2c-stub device and kprobe-controlled callback timing, three
runs of the unmodified driver reported KASAN use-after-free after
unbind. Three runs with this change completed without a kernel
diagnostic. No physical IDT82P33 device was tested.

Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>
---
 drivers/ptp/ptp_idt82p33.c | 25 +++++++++++++++++++++----
 drivers/ptp/ptp_idt82p33.h |  1 +
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_idt82p33.c b/drivers/ptp/ptp_idt82p33.c
index f01c50dfa44e8..ffc2ec1fc4bed 100644
--- a/drivers/ptp/ptp_idt82p33.c
+++ b/drivers/ptp/ptp_idt82p33.c
@@ -918,6 +918,13 @@ static void idt82p33_ptp_clock_unregister_all(struct idt82p33 *idt82p33)
 	struct idt82p33_channel *channel;
 	u8 i;
 
+	mutex_lock(idt82p33->lock);
+	idt82p33->stopping = true;
+	idt82p33->extts_mask = 0;
+	mutex_unlock(idt82p33->lock);
+
+	cancel_delayed_work_sync(&idt82p33->extts_work);
+
 	for (i = 0; i < MAX_PHC_PLL; i++) {
 		channel = &idt82p33->channel[i];
 		cancel_delayed_work_sync(&channel->adjtime_work);
@@ -937,6 +944,10 @@ static int idt82p33_enable(struct ptp_clock_info *ptp,
 	int err = -EOPNOTSUPP;
 
 	mutex_lock(idt82p33->lock);
+	if (idt82p33->stopping) {
+		err = -ENODEV;
+		goto out;
+	}
 
 	switch (rq->type) {
 	case PTP_CLK_REQ_PEROUT:
@@ -958,6 +969,7 @@ static int idt82p33_enable(struct ptp_clock_info *ptp,
 		break;
 	}
 
+out:
 	mutex_unlock(idt82p33->lock);
 
 	if (err)
@@ -1044,11 +1056,14 @@ static int idt82p33_adjtime(struct ptp_clock_info *ptp, s64 delta_ns)
 		return -EBUSY;
 
 	mutex_lock(idt82p33->lock);
+	if (idt82p33->stopping) {
+		err = -ENODEV;
+		goto out;
+	}
 
 	if (abs(delta_ns) < phase_snap_threshold) {
 		err = idt82p33_start_ddco(channel, delta_ns);
-		mutex_unlock(idt82p33->lock);
-		return err;
+		goto out;
 	}
 
 	/* Use more accurate internal 1pps triggered write first */
@@ -1056,6 +1071,7 @@ static int idt82p33_adjtime(struct ptp_clock_info *ptp, s64 delta_ns)
 	if (err && delta_ns > IMMEDIATE_SNAP_THRESHOLD_NS)
 		err = _idt82p33_adjtime_immediate(channel, delta_ns);
 
+out:
 	mutex_unlock(idt82p33->lock);
 
 	if (err)
@@ -1342,6 +1358,8 @@ static void idt82p33_extts_check(struct work_struct *work)
 		return;
 
 	mutex_lock(idt82p33->lock);
+	if (idt82p33->stopping)
+		goto out;
 
 	for (i = 0; i < MAX_PHC_PLL; i++) {
 		mask = 1 << i;
@@ -1367,6 +1385,7 @@ static void idt82p33_extts_check(struct work_struct *work)
 		schedule_delayed_work(&idt82p33->extts_work,
 				      msecs_to_jiffies(EXTTS_PERIOD_MS));
 
+out:
 	mutex_unlock(idt82p33->lock);
 }
 
@@ -1442,8 +1461,6 @@ static void idt82p33_remove(struct platform_device *pdev)
 {
 	struct idt82p33 *idt82p33 = platform_get_drvdata(pdev);
 
-	cancel_delayed_work_sync(&idt82p33->extts_work);
-
 	idt82p33_ptp_clock_unregister_all(idt82p33);
 }
 
diff --git a/drivers/ptp/ptp_idt82p33.h b/drivers/ptp/ptp_idt82p33.h
index 6a63c14b6966b..b88c921adaa91 100644
--- a/drivers/ptp/ptp_idt82p33.h
+++ b/drivers/ptp/ptp_idt82p33.h
@@ -91,6 +91,7 @@ struct idt82p33 {
 	u8			extts_mask;
 	bool			extts_single_shot;
 	struct delayed_work	extts_work;
+	bool			stopping;
 	/* Remember the ptp channel to report extts */
 	struct idt82p33_channel	*event_channel[MAX_PHC_PLL];
 	/* Mutex to protect operations from being interrupted */
-- 
2.39.5

