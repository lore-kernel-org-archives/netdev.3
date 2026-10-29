Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793273146;
	b=jKB48X+8bOdZyhgEhITFuhXa17VFVwEwxF2W8l96n6ybMRJxR/CRPc/6fUR9u/KcBgHp
	 SWf+mibzspWvmQ7K2Ex84esEUANCRqBi5V4ogTnnAVcIFMnxPLBM+eh07OfHSCzZ6mszU
	 Yt8p5u9tuRmg+X0F1OEGcpbGScV+T91P06cp0mnVApuPv2+rLc0WoRS/hVRR/NHAw3o5p
	 pxlynOOiRnbyl6RU98Ulv3GP5PjJWXg/X1UEeThYpEtXl/X4r4KcrNRUT9SkrbXzIj2Sy
	 nrB4wpg+avSRLurlYIVNxvzIfUeN7SqLAO8UC9WVQ+K6Ml18DZAnPLWpeLzj7WKv8zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273146;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Zmpvpv5AziW/jsJVHh5ej1EELzXwiOShgDeV454QDo4=;
	b=tl53lFgpqBAg/4lPrl7ubs0F3UGb8DxGgv6Pbxa+DLlFleCUOScUv9sC7smXW6TSi4dJ
	 SBmBF60Yc4ZXv00AQSEAtDkv/zrk7/UBb6+nPwvnLzQDIzrIFNo8vDpNsaMgSXZ/MVzsz
	 p/S/sovocbjt3sH7MvmhiFoG8ioO1CC+VUqPHChZ4P0ZFiZmDf2RXV+bEkNWKD9+tJjHG
	 mPv01KwPNDUDEKVAw1qUkCos5ZvfR1ut1i0wVzqww8LnZ27vCOYeq27AxYUd/2kYzAS74
	 TRockkC9e543gnMzK7uIEPjMmlCw0Pvzuj77Q2bZGJw2eshgRflCjJgb6jA9Ohz1bTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=KKr8PZSP;
	arc=none smtp.remote-ip=162.62.57.137
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A9606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 345A9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=KKr8PZSP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793273134;
	bh=Zmpvpv5AziW/jsJVHh5ej1EELzXwiOShgDeV454QDo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KKr8PZSPSfjZH4sJ8qUwv1OO4wVtHcglWg7aW2LDO7V4aNUyjrhc1k+QZ+Il8v9S6
	 6Rr7CUk7/zDmDGqz2FsQfmS4hlJfc4bM29p3700YrC+4ee+/H/RcNvxRhEWyC+JAas
	 o589dRp79NzVooDSPQopqlBYtTCO37w3BQZy4Nr8=
Received: from localhost.localdomain ([240e:3bb:302c:4eb1:9b:594b:9d4d:93e4])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 65DA727C; Thu, 29 Oct 2026 19:25:29 +0800
X-QQ-mid: xmsmtpt1793273132t6ydkkukq
Message-ID: <tencent_1AD6B5B7C296D319F828A281A2A65B95D609@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uBu+vAz7Hn2h/EL1LsJ58MpGyhOeVYrg/Oa96OhtqqafVvkj01S
	 mmZJpUy3TFE2rq+LUQN+Tof8b7W20E8jWxu2k2vCBFKWtx3zCZI2Y7HFfprO47Qp8VwQeCBcs9mu
	 5ppj/uTy43XMItLDxVowY9ItfTFkfApyeNsWKmVjly152ZVKyK31mSL57l4BOxsejnwIW+ZPzIVn
	 YQKDSvqy3PwZoQKezx8E9OmgMfdMmH8e6d5h8PquswEz9dtvJGkzXi1iKpGtceK2n82Y7GsFy0T2
	 oo5TMUUj0kS42A7lnO0DiBKOMLCKaVMyFrKNS8701Hwj5Cj82JUC1ZcmWdH83EW09JptBDQDtBAa
	 6JXjl7SphkgyJ2ZD1MfEzNEQ64BqKUIRo+7SlS9SsF08UNdCyc8VkGkTFTszwa+3hRVjT5puFGCa
	 8+OzOGa5zjeX2X/IhCArV0nrcMDLJwAeeH7m10qxb7jSGjOSlZe+zikdsHwmid34r5FMq/pASCbV
	 WGuIvzBpluWG015zKUa34Oz6gb4dfsEwVV8fRDGloFvInTRaWOD7BgZrDm2eE7TIMq/eNYpwzQbq
	 ITHR2X+9fL6g77A8d4maeTPkFs6879GGRjkX8fBLQATDGRfo6O8/O64UMu/9I2UyWM76/b6SUk7n
	 P06f7asIrgTnwBE3t3KW71MDNy0E+VVaXpqoLbKjeMXdrUKPLHXeeJblwDXd6xHjv2KKY4ReI/cZ
	 LzTnpRPBPm5peg17viRjoycXUayrKFvNRvfhTZZc732jFkCIAuAw9aKXbDr9g29IkyJgc5Ff0CK/
	 HbcjCQ1mD9agl2hL9EUXknoJpyCoAHCrgVh7tlg0YJUfQXR/CSX3yz7g5AhkzuxpPHQQdf4PCa4o
	 3dsD8a7heC4KsTyaVlkL2/jSrnDHrVEoNJ70FjcZ5fl92L08XyQeo5rDOR9feNaMiLV/16LvLOxB
	 ZsEfek17dGEkF+3xIiEuyGBYFChcw2QuPsMfTEh8c5Lj+0MdbN5A7ZTK8NcctfHGKVtww17ouLmT
	 qxBBSq7HuoLkAmoCZ3Jk7i0XPnxwk=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: daniel@makrotopia.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	johan@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v3 1/2] net: dsa: mxl862xx: bound FDB dump walk with a read limit
Date: Thu, 29 Oct 2026 19:25:27 +0800
X-OQ-MSGID: <20261029112528.56652-2-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261029112528.56652-1-memoriaru@foxmail.com>
References: <tencent_6030CC520C02054D1B2925AEEF6FA92DC30A@qq.com>
 <20261029112528.56652-1-memoriaru@foxmail.com>
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

