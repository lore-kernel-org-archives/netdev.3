Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF2D379989;
	Tue,  1 Sep 2026 05:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788239267; cv=none; b=VyASugx8SHFF+bdqjk+PTtvsNfaxoqcVMtmOVrUw4x2f7GA1U499rEvbLXSbmC8w1omrVoERlFFXjGv36gwecBX2Zaklrv5Q8OMO+UwtmAbw8K4E6DEFm4sbIFl199EjAB3Ab3uPdp49REsGqCaz5gIEmbvxeQX6LTrHKn8CCts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788239267; c=relaxed/simple;
	bh=x5NKW2Iopwwx6bIbfF/bJ/VyAJm8pFaTAq9rg8iGH+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GJuw26qOs/fULJhb2XNEqecnRUEM2HgD8VtZ3kzcmFL5EBYnn4upGR//c2xuEY+bBQLS436jBTSkVUGi8O6k3kzaTy5yvkEJyKud1ZACoZZW8lvsPInpiW777PoB3Sw0/UAfk+WC0B9C9FpntBOBjv9YX+xaXYXep1heTUwhO3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=fTPgeZBT; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="fTPgeZBT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1788239199;
	bh=cy18hRXmqoQUSyWYrrantqEfb3DvB1PMV1O3Lz+8ad4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fTPgeZBTq6etZxPZDpSW8WyV9sn7ianpes+FfPVNQwaaJl9KNDi6uveD1UzZgVpk6
	 hp1SJ4jotHKYcSattym7lPyZkf3b8xGQG6m2YSAgyFl2qlTDSSo/DrOULhnqiwZ77l
	 VCiGSO9xhdfw949WjBkIO07aaNsN/TMjUBu86hO4=
X-QQ-mid: zesmtpsz9t1788239181tb68da59d
X-QQ-Originating-IP: L6KVDYyUgpHnn/XOPry+9aUzLe7Ad2cOa1u8NJOD2xw=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 01 Sep 2026 13:06:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16674903376900110173
EX-QQ-RecipientCnt: 12
From: raoxu <raoxu@uniontech.com>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	raoxu@uniontech.com,
	maciej.fijalkowski@intel.com,
	kuniyu@google.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: usb: ipheth: stop RX URB on ndo_stop
Date: Tue,  1 Sep 2026 13:06:04 +0800
Message-ID: <351B4C70CB12AE0F+20260901050604.2523039-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NvKPgl6nhXeJ6stP+pOD7JTeAt0mdm7me5W5+b+SOjlDLwuDxl+WW37v
	BdHZOTyZ6VzRMl3l9c8tGY9lZcfIah3778mP6kMtmtAJNwmiLrMxGDWeND0vx2OW3OY4uI2
	XlZMfeAofHiNxEidd2/hMdNzQaH99niUVnjmys4V8bOkmTAZB+YT7XAqSW5UfE75RyXo+zu
	nHOnWI1pW4F7n5MSCqsB2CotGqMLcEL3yDcinEa4bPaFXXRFd40SaOqCI5KPi/WBYTZNa14
	tg8v3X46wAWbbdOWbXH4UbO1D+kj7nTW/uQR/pfWk3Fe3ZKI2POa7Qt6ng98aXaFC0O6LE0
	nTLJju5XkDSSaEpkaSM/WbI/yFrCLERNzEe3j+bUxmEEARexYeRDCOwKRLZdqT/+0NXdfBA
	kQtg4WSTH8YzC0iV8hs9H/d2BLMw5RpVXDbP7M4NmfIcAVE7JWB48+6EbeUoaWQ//2C2fgR
	OwpkDQJCqtMdsqSY0iHM6X7Bbehjgz8wSEih5DTXwGrowvffaJLkpEKDBFYhAlg+aUcPZWh
	+pTxF0dKNJspW712gXtvewwol8KIQigp92K19Wq5+Ri9OuxBiM1rYlaewqCO4mRSZ/PHBmX
	YvmeV5/HySpTJ/8KIN/JAzslREr8CkRIEEQd1vSbEYITNUP17bq5VObHqmxfyvvOVu6J8Z4
	/0Fo62CWA/0qpn5Uho4yrJiP37NMsLlQFzvQ+CJ6qddfWx7JEgZ16ZWJw+BYfnDpckH23nQ
	GG+qbj76Cqv2rwzK+sEEpXX/BYTtfmLn8Tz/Omw2YpFUZHOSBAgwJz+efCCqcfgTDXCQ8WI
	t+vuiw8IPPvfIVBpLL2JZifRXQHOJFA0+iO03zX3kkHkRIntZJVN85lFrzTCU8JRCIrA/WM
	6beuxaWyr9EJVSUPqzPZPRH1kHxFqJMpaB954pzLbyEqP5PD6RwROHwEZc3excWKwFnfEzy
	YIDn4qyp0b5EI+PQGhlTlLA0CQGQ4I03TkmG4gyxSsp+pucJ1Smc+uCn7A08SuGLxYDOBxD
	x/LkHafKgYMiGLLefdwFKb+6marhkOTwLZCv5FYW7NFKL0oL7j7+9QAAHtoKmY+iBW6R4ab
	uoegLjwPdb5
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

ipheth_open() submits the RX URB, and a successful RX completion
resubmits it from ipheth_rcvbulk_callback(). ipheth_close() stops the
netdev queue and disables the carrier work, but leaves the RX URB
running.

After an administrative link down, an already submitted RX URB can
therefore complete, pass received packets to the networking stack, and
submit itself again even though the interface has been stopped.

Stop the RX URB from ndo_stop. Do not kill the TX URB: packets in a
successfully submitted TX URB have already been accounted as transmitted,
so let an in-flight TX complete normally after the queue has been
stopped.

usb_kill_urb() waits for a pending RX completion to finish and prevents
the completion handler from successfully resubmitting the URB.

Fixes: a19259c3d589 ("drivers/net/usb: Add new driver ipheth")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
v2:
- Kill only the RX URB and leave an in-flight TX URB to complete
  normally, as pointed out by Oliver Neukum.

 drivers/net/usb/ipheth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 2b490114d232..6b90fe1e0e38 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -505,6 +505,7 @@ static int ipheth_close(struct net_device *net)
 	 * it, so that such a schedule_delayed_work() is a no-op.
 	 */
 	disable_delayed_work_sync(&dev->carrier_work);
+	usb_kill_urb(dev->rx_urb);
 	return 0;
 }
 
-- 
2.50.1
