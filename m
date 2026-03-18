Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C903E9F6A;
	Wed, 18 Mar 2026 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849858; cv=none; b=ax0DJ50cbLE8pVeO8Y/BfOEu849thBBYQcHav3ueAjqn+5zrwQhGaNSn0VI8EbFs64IW2+hFRvpPl6Z/178gCl2297P4pnbM0Q9b2V4pg0UY/BymD/aa8f8RseAXU0nnQlfolYnqGMCQs8UQ+u3v9O7qc61iPbmUVUzKEq8YXtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849858; c=relaxed/simple;
	bh=yjO2r9KwYfBUKNhH3DDu8JGuNNH/qW91k2iO/LJnRro=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HRjdsS3B4Nt3nnxnouiA295ygtKBqhgYD7mfQd0OAEQNNUoX7yAE7NVRUi6YfBBiW2hJ/ILrd7dIaLqI30awh2T0unPQAuBtfKqU8fM3R7imfMeUcMJ8pG8owmKV0Sd4UWHtdLqJYHGMiVQHfYdjiB+OccEiLY47RIqaqlOSZtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=uR6oVDxh; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="uR6oVDxh"
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id ADBD7A11F8;
	Wed, 18 Mar 2026 16:56:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=UYS/DBBmpnsZlO739SFHOH1umx3IRYBpT4W55lXOXhU=; b=
	uR6oVDxh/34f4bUwrcjPrNoMkRGHyqHIqaaoF2Bi4nOsKuOpEpGsQP9QqbvQmTl5
	sVWNchBYdlEcUQHuQEGtjTnITDFwQ5mVScdVlCBW7Wo2sm52uCAroyQGI7UdVSfD
	IgB8jK7FAW4lPtKHi+hgm3VtDp+ZaqSqhwTSRDk9Vf3ryju2hcn4VJ22w0uQlrvN
	azx0GuGg4ftHvbMvBhAi+b3AvGFhVZ/a8RLIr1STBOXkAAfZjf9Ja/fJrMt0s144
	Iaeu9C6VuxnzJ5KvuVGs5B7uPFQqHR3p20u6f5fJqeflBmtoSt/qpEZdM3JpDDyp
	o3r5lIrYkNe1J/fKZy5zdDXDisU6uznOVmmU4j+D6HIV1SF4ovOtKroX7MUqxkmT
	F7baXm2/LaQApjJRB89DKqgi2gm1HuamLkzqkBiqW3zLNC2I45amg+WeI/g697mm
	pnae6NCJ9NsdnT6qMm0ObpsDZq3VQ6hzwmcgY+E09QyWa1xCwaVavEgZT9hJn/y+
	T+Vs8Davis2tucXr3w+1ZSterFudpJMSO8qRXXnuWfNHFcwHnOHZRtmm25DUjXVG
	5FPVsmIv7Xo4Rw8y6Qj9XIYVljNPbaMV1glwtUNTNzSYopu5m5DeVBAtajspsUJI
	oYbCm7tIess7EFEb6rwUfV81QCgo1irEv4+hNSOrdSw=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, "Clark
 Wang" <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?=
	<csokas.bence@prolan.hu>, Frank Li <Frank.Li@nxp.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>, <imx@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net 1/1] net: fec: fix the PTP periodic output sysfs interface
Date: Wed, 18 Mar 2026 16:56:15 +0100
Message-ID: <e2518c8f932fd9da6754b5ab5cc892ed58a0c1db.1773849293.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1773849382;VERSION=8008;MC=1535064331;ID=91592;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD5150627264

The PPS channel selection was incorrectly implemented in the orginal
commit (see fixes). The sysfs interface uses a logical channel index,
and rejects channel numbers greater than zero (n_per_out is 1).
See: period_store() in drivers/ptp/ptp_sysfs.c

On the other hand, the FEC PTP driver was expecting the hardware
channel number, making the periodic output unusable from the sysfs
interface, with the exception of channel 0.

Fix the FEC PTP driver to match the logical channel number of the
sysfs interface.

Fixes: bf8ca67e2167 ("net: fec: refactor PPS channel configuration")

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
 drivers/net/ethernet/freescale/fec_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 7f6b574320716..c1af81002b8fa 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -534,7 +534,7 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 		if (rq->perout.flags)
 			return -EOPNOTSUPP;
 
-		if (rq->perout.index != fep->pps_channel)
+		if (rq->perout.index != 0)
 			return -EOPNOTSUPP;
 
 		period.tv_sec = rq->perout.period.sec;
-- 
2.39.5


