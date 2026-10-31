Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793434708;
	b=0l/0ZzStxzLoSwO9NQFbUipW+SQjxuwIdxzMSFp8lM2wfBXhF6EZe264Cqj58R/8Mh0g
	 ctvtHkOJx6MPiMazrzwNkUldPf1m5OzQ5NUcA7yjav2IZZy6DKtQ9gd/76i2FKt2+VJED
	 Jfx9NB8vhcW8scVLEMmrjx20aNUkTudHrQdiZFwq0ycOXYrxAFeCzKnjqqEv6s6KDolvP
	 1lPoeL5dac6HtgNuSb7YHSrctzy6LmpdjpMtvTdHEbY6pRr6aYQlXcXZqnNN60u6n4ats
	 o8bQxQ6yUTJdgB/Gl9XTdUIPbzr50wnxd2/J8BrDXoOS1cCa124rz0MBCSi4TSKWqaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793434708;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Zmpvpv5AziW/jsJVHh5ej1EELzXwiOShgDeV454QDo4=;
	b=vXY3pOdtt0W0QBMnTyup9hfNaTza/d/pJR4wTZ5TUmeShNn1rnEsAXgV4nGx40aULbyL
	 IoWqfEmPurmTPAtHkEhhChjFtg9gJEVSlXkKueIY56x3+0VCM0voWHw7VS+5eHayp9/z+
	 DYw3jcZ7d0Yzyi/RjJQA3V49U2+5Ivgjq9x29g1tdsVE5jDuzPk3zCkZ+D7ryueU/QfEo
	 SsWG9yf10S6ymMvdEF2PkExIEp19CmHIZ2jpM2w0WtbqePaGNZ03UIM8/EsTLc3oKLSan
	 B9iNrJXkpEqCgOmpprXjEv2lfo1TADa7pLdhqHWAqFTJm5cBSWpOkhU6Hkpvwy300og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b="Js3Ysh2/";
	arc=none smtp.remote-ip=203.205.221.164
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218E4606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 08:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 218E4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=Js3Ysh2/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793434698;
	bh=Zmpvpv5AziW/jsJVHh5ej1EELzXwiOShgDeV454QDo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Js3Ysh2/9jqQWFURq6f9C+DIrQIcu12g/61Cjz+EhAwasklt4A/zUCa89Nx1blKYU
	 8ng6DBnT4eBfHkX2K9j+ZftGt9KLlvt1OsZa1YctNuVghUNJrfhEyyMc2yN4o9kOwJ
	 z59Rw+b7tKIZuSA0AW3fsJTc4h0VPGkDRP0Aw03U=
Received: from localhost.localdomain ([240e:3bb:302c:4eb1:751b:856d:f57c:9109])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 48E960B1; Sat, 31 Oct 2026 16:18:14 +0800
X-QQ-mid: xmsmtpt1793434696tvqfklnc0
Message-ID: <tencent_9AACA76E6D2CF7339050E800BD4E1329510A@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XSOcZStsqqv9vFFsHfIWLVxapdqiIUL8Afps6YeSGEpw7Jxr/2O
	 rf9g1A6y+bwqiiWoqEoy3CPKcWYnde5RtMMr8gfUTSDmlwK5/Gku5cXDyvpsHRYzHCxCzRP0Kr8z
	 al+92EAZukVd3RkbQ7omhS9Jw4Ig0r9Nm5Iak+7/v5zZZ6QZi4bJEezy4GssmUk3OPcDu/GFAyxz
	 KMnPnmrbhqYWbD8SuRRC00CbU1lDxAXkloUhc7rrEVcnNbmcgBKcqBJVdCAz4OjJGr+pIusA+qla
	 mwBEN2/8qofi/c7BRdCeg/WXt36/or9qgL4r2eP0twOsocH/z9O1PW+Qtxgv5ZvNPfxVCQ2XVSUW
	 48W2EnpOcFOcXajq8O0rXftiHHxzCMTtNh9dNSt3BObf8zms79LXKC4ounrK9J0oeumtacoajD/9
	 d/Q46lrbFsRkKk9sV6Y2pEks72nQiULZiBlr/Ddq6/bNIl8LFgjvayM8fI5OLB+gFQLZOVZIhcSl
	 UVo17NJs4iMyu1Cej8U92Z0VLDOswx6FVjoq9S6N8d/tbeo0ZPqYQS6GVyckhISLqH1Y7HjiL9zu
	 lcjFhYxYiDYJNKaR8MzNVjLgczd+S8Xv5DsdvuMjS7IbVHpeFazoR939lbBd8+JzAELas6iWAAOm
	 /iv/+5kiHVWEbLYPdwOPU9m51xUZQQGCGMtU/83hhfSMvSueTU2zuV1QPmnjGNrfgAg/nY9kMj8B
	 rnAA2g2+xTUCMjF/ClT84qo4t21/bSAp4s4bOi+sss/dx1wtLHKkJCH5T1fShBRn+c2M5vPPYwG/
	 LbSXdRTeq0SuGeV+w8+bqmM1+Egu+O1J4cMIlzrNth8a5FF+95Go0N3qaifjJoh8VMD4rAsviXWM
	 agCL5AhQFkB6iWDIKQ1ynkH/4k1Oteea7wJ7rUxi6whrNtyeid1U2EKlUSPOAom7o1MC8BsyeeDy
	 Y1zdARR5NnQs/R9zVsFmO3LPBWVKHMsevzlDQT9nv0TJATl6DfKinWdS2roloFtd96EJuocKcwPa
	 +1Hi/Mv6oUk+t5XOPyjtNvIev/RAceHYTAeN1XPcKQjGJwDm6S70FMuXvboZs=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: daniel@makrotopia.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	johan@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v4 1/3] net: dsa: mxl862xx: bound FDB dump walk with a read limit
Date: Sat, 31 Oct 2026 16:18:11 +0800
X-OQ-MSGID: <20261031081813.64518-2-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261031081813.64518-1-memoriaru@foxmail.com>
References: <20261031081813.64518-1-memoriaru@foxmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Hewei <memoriaru@foxmail.com>

mxl862xx_port_fdb_dump() walks the MAC table in a while (true) loop
whose only exit is the device-controlled "last" flag. Entries whose
port id does not match the dumped port are skipped without invoking
the DSA callback, so the netlink dump buffer never fills either: a
device (or its firmware) that keeps answering with entries for other
ports and never sets last keeps the driver walking forever with RTNL
held.

The exact MAC table capacity is not part of the public driver API.
Use a conservative read limit (16k, well above any documented table
size for this family) and return -EIO when it is exceeded. The limit
is checked after the "last" test so that a correctly ended walk of a
full table is not rejected: the walk needs one read more than the
number of entries it reports.

Fixes: 340bdf984613c4a9 ("net: dsa: mxl862xx: implement bridge offloading")
Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
---
 drivers/net/dsa/mxl862xx/mxl862xx.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index e05ad52cd..37e8c18f1 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -30,6 +30,11 @@
  */
 #define MXL862XX_STATS_POLL_INTERVAL	(2 * HZ)
 
+/* Conservative bound for the MAC table read loop: the exact capacity is
+ * not part of the public driver API (see mxl862xx_port_fdb_dump()).
+ */
+#define MXL862XX_MAC_TABLE_WALK_LIMIT	16384
+
 struct mxl862xx_mib_desc {
 	unsigned int size;
 	unsigned int offset;
@@ -1503,6 +1508,7 @@ static int mxl862xx_port_fdb_dump(struct dsa_switch *ds, int port,
 	struct mxl862xx_mac_table_read param = { .initial = 1 };
 	struct mxl862xx_priv *priv = ds->priv;
 	u32 entry_port_id;
+	int count = 0;
 	int ret;
 
 	while (true) {
@@ -1513,6 +1519,22 @@ static int mxl862xx_port_fdb_dump(struct dsa_switch *ds, int port,
 		if (param.last)
 			break;
 
+		/* The exact MAC table capacity is not part of the public
+		 * driver API. Use a conservative read limit: 16k is well
+		 * above any documented table size for this family, while a
+		 * device that never sets last (or keeps answering with
+		 * entries for other ports, which never reach the callback)
+		 * would otherwise keep us walking forever with RTNL held.
+		 * Checked after the "last" test so that a correctly ended
+		 * walk of a full table is not rejected.
+		 */
+		if (count++ >= MXL862XX_MAC_TABLE_WALK_LIMIT) {
+			dev_err(ds->dev,
+				"FDB dump walk exceeded %d reads, aborting\n",
+				MXL862XX_MAC_TABLE_WALK_LIMIT);
+			return -EIO;
+		}
+
 		entry_port_id = le32_to_cpu(param.port_id);
 
 		if (entry_port_id == port) {
-- 
2.39.5 (Apple Git-154)

