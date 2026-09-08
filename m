Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727BF3A7F4D
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 07:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852498; cv=none; b=BHuUN4xfLUYu81nVEa0fsvVBWkWJKl55b9SovdVgE+XOP783OvNXa0grpuhn+Vb7vCtYT8iVZpr82tLXBpkjmwUzLeptiqwByIvocKXGMc2Sa72PN80YfRk9fHBmshyqMLgp+Sed3erXtlyb7XZ2Gwzrl8gisHWHITTVCQigECc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852498; c=relaxed/simple;
	bh=j1+ZBVJmPVW03bJXf/56FabNKgWY7EFAGihdRcW3d0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s+/OXjTQ/tg9+PobRpOhs7DuO4L1bOk1b24bSvM0obLoFtMlu65Jeyunx6kDESM/3PHTvChfkrtSo0Ai6Q27Tw1PC1CMHCILvBcR+/7XC5OmZfGn+UtpZHhaoE6w0JEB1p6zx2E2cXhfT4CWDIKIaSRC8j2VBfpz4DrIsQiGSNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pHijxVVi; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pHijxVVi"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6D9904E4158C;
	Tue,  8 Sep 2026 07:28:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 42B3F603C4;
	Tue,  8 Sep 2026 07:28:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 796B111C7AF31;
	Tue,  8 Sep 2026 09:28:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788852494; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=B3aS/Mr7RC/ZOcg+EzhbjQUCCCKDV341PmBKKjmtwgs=;
	b=pHijxVViV01FntyIg0oGpspqOWrGGqbMNqX8g2/IFdwCHEAmX8YclOLhGY2TO3nJe0P1u3
	d78snXPGJ3jgt3ceKOyvYundfd4G7EoUtqdyxY54jNXNyR4NkSIlEA/AMC5aRqcXmhDF6M
	m+mwfSsEwZxfklbQIlnOiHzs1RazH3u8G2Obp2xPws//dpn0Q/1vsssiXWcBpRpA9gzIC8
	qsX4FNly0ewhtltcbDw09iNH4XQZOoXGHGCHILOb5k6L+2GnFzWy5RYWJKIZ+ixdTjPqJP
	/psBaowE/uX1EqToLsWJjUOj/kB9h+NOVc7N8SON3E6LACxTW640qFRvBLWBnw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 08 Sep 2026 09:27:47 +0200
Subject: [PATCH net-next v3 07/10] net: dsa: microchip: extract prepare
 reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ksz-perout-v3-7-6722a3f1ca75@bootlin.com>
References: <20260908-ksz-perout-v3-0-6722a3f1ca75@bootlin.com>
In-Reply-To: <20260908-ksz-perout-v3-0-6722a3f1ca75@bootlin.com>
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
 drivers/net/dsa/microchip/ksz_ptp.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 2f141df65eb0..e262bc7448f2 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -788,11 +788,11 @@ static int ksz_ptp_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
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
 	unsigned int count;
@@ -823,12 +823,24 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
 
 	/* Restart periodic output signal */
 	next = ns_to_timespec64(next_ns);
-	request.start.sec  = next.tv_sec;
-	request.start.nsec = next.tv_nsec;
-	request.period.sec  = ptp_data->perout_period.tv_sec;
-	request.period.nsec = ptp_data->perout_period.tv_nsec;
-	request.index = 0;
-	request.flags = 0;
+	request->start.sec  = next.tv_sec;
+	request->start.nsec = next.tv_nsec;
+	request->period.sec  = ptp_data->perout_period.tv_sec;
+	request->period.nsec = ptp_data->perout_period.tv_nsec;
+	request->index = 0;
+	request->flags = 0;
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

