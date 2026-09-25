Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9614049CF39
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336355; cv=none; b=gqPtJlF6EY6JNck8vSJ2K0Sv6S5ecXaf4z2TnOD5EnzINEC7vKpvRPvY5SQ1xlxFmjVCMpB1XPp+qphaVm/fcDJrf1/ng/rAMPTzz0Y7wDeJAu30dW4+xj3+pr6vujo9NOa5wD1RqHcxrPw63kma8rXF5O8qvAoFxrWNOJir+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336355; c=relaxed/simple;
	bh=zN0UY+8k1ortZKtkmfbzKV6nHCMbJzFGk0htgycRxiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s9A/R3QZ/dLpNfDIUj8rA7K5C7aIkTU6RZ4zeiNEOY2lapu7ZEOa8gmAj6RrZ3PGYMzyGJWObXLqXlQF+RaqVmLbD0c+OIBR4+GBbRTdphjymrJHxjQN06iMZZwE+0FRz63LbLUpVcFvf+rjj1ZG3/cqQemMme0NwRENS6wVRwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VPHDULU2; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VPHDULU2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 51BC04E41073;
	Fri, 25 Sep 2026 11:39:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 254A96073B;
	Fri, 25 Sep 2026 11:39:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7068103295CE;
	Fri, 25 Sep 2026 13:39:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790336351; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dFU3AsKo8uDni0cB/LxcdlinhPNeWxbfnSnnMoF7gH4=;
	b=VPHDULU2lVaALJKjRFEJh52yXl5F6dwMN0nAnF0evoOuazRYVrXAwjxTD2NSFwd9x6bi0c
	A/rudKF6s5mmlbIKe5vPopYo0O/PP0l/FxtbO9dPc4dPYqkCE5Rbav9rxLYNy9BOMRDo0M
	RQl6FEK2Amrj7xuipv2DFo11y1x6DFPrPKIppXZ7ldPfIv+LruMAQTfWjcaXNXczS9DihR
	Rvf0Jj+oss+El2bwdZPUyi9SJRHYmksNXU/CiuMRWb0wevKS4jJB2iKmK2ExYdBxAZscPw
	vd209ZY8JgB1gHhR1wy21q460CwFhxP4YUTD9iB2L2fBRbnk/9O08ubOtsAncA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 25 Sep 2026 13:38:54 +0200
Subject: [PATCH net-next v4 08/11] net: dsa: microchip: extract prepare
 reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-ksz-perout-v4-8-d675bd21ce49@bootlin.com>
References: <20260925-ksz-perout-v4-0-d675bd21ce49@bootlin.com>
In-Reply-To: <20260925-ksz-perout-v4-0-d675bd21ce49@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The KSZ8463 supports periodic outputs but doesn't handle them in the same
way as the other KSZ switches. To add proper support for the KSZ8463, a
dedicated ksz8463_ptp_restart_perout() function needs to be created. This
function will use the same request initialization as the common
ksz_ptp_restart_perout() function.

Extract the inialization into a dedicated function so it can be used
later by the KSZ8463 support.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 4b57cf076bb4..b627062dbaad 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -793,11 +793,11 @@ static int ksz_ptp_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
 	return ret;
 }
 
-static int ksz_ptp_restart_perout(struct ksz_device *dev)
+static int ksz_ptp_prepare_restart_perout(struct ksz_device *dev,
+					  struct ptp_perout_request *request)
 {
 	struct ksz_ptp_data *ptp_data = &dev->ptp_data;
 	s64 now_ns, first_ns, period_ns, next_ns;
-	struct ptp_perout_request request;
 	struct timespec64 next;
 	struct timespec64 now;
 	struct timespec64 tmp;
@@ -833,10 +833,22 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
 
 	/* Restart periodic output signal */
 	next = ns_to_timespec64(next_ns);
-	memcpy(&request, &ptp_data->perout_request,
+	memcpy(request, &ptp_data->perout_request,
 	       sizeof(struct ptp_perout_request));
-	request.start.sec  = next.tv_sec;
-	request.start.nsec = next.tv_nsec;
+	request->start.sec  = next.tv_sec;
+	request->start.nsec = next.tv_nsec;
+
+	return 0;
+}
+
+static int ksz_ptp_restart_perout(struct ksz_device *dev)
+{
+	struct ptp_perout_request request;
+	int ret;
+
+	ret = ksz_ptp_prepare_restart_perout(dev, &request);
+	if (ret)
+		return ret;
 
 	return ksz_ptp_enable_perout(dev, &request, 1);
 }

-- 
2.55.0

