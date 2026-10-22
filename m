Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699483;
	b=5ryrWNNNeZgrN14YskQWIE1Pf8zmmwtenugDKj24O9v3wUcDZp8k9LvZ6Wx1kzKRUYrx
	 ZQh2SMT8QIwpqFYpCycV/VLjEjJ1ya9WyqjDLeZV9cZcX6GmAWjsHybYHJUdtnoCowgUS
	 ZDLvQJDiB7Fba86PwTJ+N5Tfx1JOn2bqWXySnnkhau4DXIeiIYtNv3Zy86kVQ3soAJ8st
	 Q2TWyzi/Fg8hSb0JDQtkNiCYpUXCJsCswcxwGPAjqHKF/6OZm98y2NzKYSOng1YkrHjqS
	 enenwWt5YnNKtRBQPpFg//vRpCI0xyFvJOlT3H+0YeytCRICqlgcDnefJRuW7R9f7tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699483;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IO9u5k/OYFk9/P2FNBVACeRMH+w+ywxn6wO3M6NiCkI=;
	b=HgquLoExLNq9vj+aUK04x9trUyQ7+i+8cmEOmIRtzuyW2w5jHCPPV+DbURsznesBAAOD
	 rzoRKq5D4m+xEugBWMdzZf1jE7AJDy82pUpE2LnlOmLTY45ShQQmNw61Zlwei2ALL5GXy
	 YcdN/FpC1X0HHaViNgvYtLciSCGUM0LVF0/fEZS2QHZMEnrfwQVwkXZgQcVjWT/utrAiE
	 cpj4crveLm/ZBJ8/5YRHuQeca/zBNzGCVLzoUYJjAmJPYqOfC9LkfYdcKJTU8z4Isxjl/
	 tBmMBdlttbwQWR4dBaLZTach38pt7M58qSCyTOmziktoN0CUkNsXP/cdWIzGC5w8M0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=nsme4BNK;
	arc=none smtp.remote-ip=203.205.221.231
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC7C606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CC7C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=nsme4BNK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1792699479;
	bh=IO9u5k/OYFk9/P2FNBVACeRMH+w+ywxn6wO3M6NiCkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nsme4BNKf6Jpl3i2gtdwqpakzsTicfxGIop8bmdsatZ4s189qazlU0Ag27BCIx/zk
	 vn1OEyuRlisUkXuOiLzA85UsUZYqRCghvdXczKCdvH/1yP2iKCXLSAOjapvc8V7urw
	 QMzf9ZbDfIc/UQGsg+YmTxmzGrikr1GRKfB9miEw=
Received: from localhost.localdomain ([180.165.29.111])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 12294C65; Fri, 23 Oct 2026 04:04:34 +0800
X-QQ-mid: xmsmtpt1792699476t22whrqw6
Message-ID: <tencent_A56873DA4A296F5D794B6A5989A180A21C05@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeirgbqXnSxhuEdtww6cyhLrWA83wyF4de8seqmz2/5wLmtaYWfo
	 /MzY06VRdnB+ioIyn59NP4NlTroGaKBFLVlWqqYwEsCdJvhhrR6JCN+8WuyVpuhR9LyDzunRPS0C
	 14SMRpKNEnsrPRreMXovXR1GT1IvkHx+TevNFX0zEmE8lNryjtOJA4BcnUiFlaS8RQuG5xlNTLY6
	 5AiUBlb5gVmBkJTyNDO4KQr/jjc3aRm8mkedh08IWr7OEnpT1Lc7cj97nO2ocMFU0CI2K75mW+03
	 00lvybY7sS1p9JmWdaGTGuEhwQv7P1lWHBq1Anc6VDA62pjPHZSuF65x0Yokk4KVSy8MRHY3o9qI
	 qqVnWIl9mPkev2XRinVokfA//OyWvKngdploq+uxteRu2DdGiw+vjmLxbsV2KUhEN3X1bXktJG1w
	 Uomg+M7LIXqBrEDZ/rmLVKI5yYwvJ8dE5L+qGyTNKU7Ra4S8X0pydW1Caj/3R54snQJdl6l2ywEJ
	 ft5MgRI0D0hfS0S4CIhyJtwtsYpwvkkbVT1hsTFfnyG1H6Wo+D70KNB/dWicUtyHTxhIM9amESu/
	 r7ycmV5sI/8WkuBP8eqd2FztnGmDbCbYL5KTi53Nc7PTPxGLGT8RU+E0/e92PZ2Jj+QnFkRlmqOf
	 lZs/X8HIv9yaJDACLSiYw4LTMIyerfFq/blToI7xT+Ag5R6dB7AWtTjCS5/9hCcZb4E8wNwmEGC1
	 kELaWe2Y+Ke5uP2kV5f5+BNrWz+xWCtYA/e1OUdcqoMT60WbCX0iKT6D56nS0+k+VvYd55WajVws
	 eb0YImgNdDWJxlAacBJDWZEjQO2kYYuk2QVzsO4Fr9fimRLWi6tp/HYfU1tnCvsuNVmOiacBCcUI
	 wpOWrObY9D4743uaW1X7a9lU/OuC8MtOKiCGpFG+v7RS2MlFi5YThwEZoSIu5Jl5CbCv8quy03BR
	 uO9CsIiMgH5SxrL3kJO6gWwmcPfq9DWF01ufHYrVBpFpW61+99Tkm5vzymSNySFJ3V7JWxIuId45
	 yI2oAaenHPGUgqQZqn
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: daniel@makrotopia.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	johan@kernel.org,
	kuba@kernel.org
Subject: [PATCH net 1/2] net: dsa: mxl862xx: bound FDB dump walk by table capacity
Date: Fri, 23 Oct 2026 04:04:33 +0800
X-OQ-MSGID: <20261022200434.80182-2-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261022200434.80182-1-memoriaru@foxmail.com>
References: <20261022200434.80182-1-memoriaru@foxmail.com>
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

The switch MAC table walk in mxl862xx_port_fdb_dump() only exits on the
device-controlled "last" flag. A device (or its firmware) that never
sets last=1 keeps the driver looping forever with RTNL held, and every
matching entry invokes the DSA callback, growing kernel memory without
bound.

The exact MAC table capacity is not part of the public driver API; bound
the walk by a conservative upper bound (16k entries, well above any
documented table size for this family) and return -EIO when exceeded.

Reported-by: memoriaru <memoriaru@foxmail.com>
Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
---
 drivers/net/dsa/mxl862xx/mxl862xx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index e05ad52..12cd407 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -1497,12 +1497,15 @@ static int mxl862xx_port_fdb_del(struct dsa_switch *ds, int port,
 	return ret;
 }
 
+#define MXL862XX_MAC_TABLE_FDB_SIZE 16384
+
 static int mxl862xx_port_fdb_dump(struct dsa_switch *ds, int port,
 				  dsa_fdb_dump_cb_t *cb, void *data)
 {
 	struct mxl862xx_mac_table_read param = { .initial = 1 };
 	struct mxl862xx_priv *priv = ds->priv;
 	u32 entry_port_id;
+	unsigned long count = 0;
 	int ret;
 
 	while (true) {
@@ -1510,6 +1513,16 @@ static int mxl862xx_port_fdb_dump(struct dsa_switch *ds, int port,
 		if (ret)
 			return ret;
 
+		/* The MAC table capacity is fixed by the device. A walk longer
+		 * than that means the device (or its firmware) is not
+		 * responding correctly; bail out instead of looping forever
+		 * with RTNL held.
+		 */
+		if (count++ >= MXL862XX_MAC_TABLE_FDB_SIZE) {
+			dev_err(ds->dev, "FDB dump exceeded table capacity\n");
+			return -EIO;
+		}
+
 		if (param.last)
 			break;
 
-- 
2.39.5 (Apple Git-154)

