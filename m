Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9411A0B15;
	Sun, 20 Sep 2026 03:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789875996; cv=none; b=YC1yDnBidRsEhv4G0VUZD5ytkho4rAWXA0UrYORxoCprDPIAVgyzbypCxS1kiqwPofFLWy+6KaYtdof7UGI5PBeYQot7LxFsnYGqjKUyM8iqqzQ8ikIuGwfy/RYBLiqko3DdxE5gMZtdn2lFp84NJcnEiS4AkXHrFBsWHL6Il6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789875996; c=relaxed/simple;
	bh=NdTPyd+LWM9Y309KiOHZPqBmJkd4QAG94GBiwayKs7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TFubF5YeVOLIlTYPm38ZXKU4Aa2WPE8kMPG6NQz7+3YbXzXdLAXitPVpFzqirmSVJxA30FlVAVxn8ICFo6b+PCN/uMR4Aa1rubgRcZNKpycIvkpGAn1W94hMTFNT0XUyux8YP/8j1unAIoHDE4fceWDTW9SzkhsqgdTSy/trD2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CUhSp25N; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CUhSp25N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=y7
	oZm9+z+hbgvMhdVdurGn/wJj516H0abb9OFKdrX3Y=; b=CUhSp25NjxeIffDmP+
	/N940LDPdGWYrEiVoaZATW3DdU3MW6tc0EN/j5BEZ1ZkIS5HgSjN3MNjvDGSNtw9
	HwrpjnRQfZjiZ/fjRW5xV42RVUsO6Os0Y8sTE3S/EgFDHfFEmnQHIoo5wRtWs+qe
	e4PR4UcEPlFT6gh2Cquebmz2A=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3f9H3Vq9qa4RSAQ--.43416S2;
	Sun, 20 Sep 2026 11:46:00 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	richardcochran@gmail.com,
	horms@kernel.org,
	hppiscas@163.com
Subject: [PATCH net v2] net: xscale: publish the IXP46x PTP OF module alias
Date: Sun, 20 Sep 2026 11:45:57 +0800
Message-ID: <20260920034557.17734-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD3f9H3Vq9qa4RSAQ--.43416S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFyUXryxAw1Dtw43ury8Krg_yoW8GrW5pa
	y7Ja47uF1vqF4rGan7Ca18uFy5WwsxJryj9a4UGw4ruryY9ryUXF1fKFWUu34jqrWrGryx
	tr1Yy3Z7CFs5Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR5GYXUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7hhaI2qvVviw0gAA3G

The IXP46x PTP driver matches intel,ixp46x-ptp-timer via its OF table,
but does not export that table. A module build therefore lacks the OF
alias used to automatically load the timer driver.

Export the existing table without changing the matching or probe logic.

The issue was found by our static-analysis tool.

Fixes: e9e506221b42 ("ixp4xx_eth: Probe the PTP module from the device tree")
Reviewed-by: Simon Horman <horms@kernel.org>
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Changes since v1:
https://lore.kernel.org/all/20260704122722.5715-1-pengpeng@iscas.ac.cn/
Rewrite the source-analysis explanation as requested by Jakub and
identify the PTP driver in the subject.

 drivers/net/ethernet/xscale/ptp_ixp46x.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/xscale/ptp_ixp46x.c b/drivers/net/ethernet/xscale/ptp_ixp46x.c
index 558c4f8d23f7..c805d1df5d4e 100644
--- a/drivers/net/ethernet/xscale/ptp_ixp46x.c
+++ b/drivers/net/ethernet/xscale/ptp_ixp46x.c
@@ -307,6 +307,7 @@ static const struct of_device_id ptp_ixp_match[] = {
 	},
 	{ },
 };
+MODULE_DEVICE_TABLE(of, ptp_ixp_match);
 
 static struct platform_driver ptp_ixp_driver = {
 	.driver = {

base-commit: 518e5b794c06c0f0eb40df3e202274a66202c137
-- 
2.50.1 (Apple Git-155)

