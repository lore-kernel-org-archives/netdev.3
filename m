Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573922;
	b=UTvzTlyg7XumO/xUSdLciSX9oVi78FpOqW0ba1bpO4QZtlyBjg7mtJBWz76bRU730B0j
	 q8rVos8S62RQtUw0X4hj5NO0sKsIhJK17VxcTfCM0jNKw+PjfBS/y3liiz/C9ukmpmVWx
	 UaSOaJta4vbtYSGPW2zq0pW7QQtL/itwrkjmzqUWMihI8xA7WHTA07tDQteYDcy1BgYFk
	 oPzOwd1nBl3NBPbbT6jcQS29zaMHxnGtjrWaINyLobosjFnpnx1TdZjVWms5Ncw58L1Ti
	 v2lw3Pf+yqw6+qT7JmweVpfEhix1dOmQMcDtZM1K2KOsJ2ZVHiZu7NEEsXMmSmHwY+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573922;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HoGTW3gc9Rq9B8/aEMn7cAx7SDpJrptD9i9Rqej6gbY=;
	b=PzxFpm0g7F1Rtz94RKpE7z8jBndDy6YzSsZQchL3Ioh3Vm3BCHd8vi646XZlt2qxZzY0
	 PfCB6gJGSeY9DmoCHVIQPpEIxA6zox5/t5uHl6maL0oQdQiFXadybuRyvcH7dXVL4XE2q
	 s1lBs55QRMY4L4R2BvpHo9Ip6qTA8sVC2NOsVQpfI+4+53iP3G+3t4Xwvuii5JDMlh6c/
	 5FgCL+2OSBKblZDRAOBHEMVJBRUA9aE306e3BRPUkKmkdGelETp4oacXfdwv2BZPTLMd4
	 IiexieHC9oq1yUkDJuXkPCNDL7YJP1nRN3DTcmBTrxcZ8mKUpq+1pxkhr9H48qa+ghA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=k+iKId++;
	arc=none smtp.remote-ip=203.205.221.231
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A42F606A327
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A42F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=k+iKId++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794573917;
	bh=HoGTW3gc9Rq9B8/aEMn7cAx7SDpJrptD9i9Rqej6gbY=;
	h=From:To:Cc:Subject:Date;
	b=k+iKId++VmmBg8wTjCZqW86iHSyLiEUen6piuYr3odewHwmNDsd4sprE0S43Y6HWx
	 PulXbGz0a8MDmyx+FbZQ4WrUZ4YT4jtdQOD6OUxKCPqA/4PWMZmt3TYd6nwlGK3rrl
	 tR92BXiPqN7QhfKjQcpkYosEEKfrEB1o/OpWDHlY=
Received: from localhost.localdomain ([240e:3bb:3033:7d41:3d43:876a:14ed:84bb])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id B48B4646; Fri, 13 Nov 2026 20:45:08 +0800
X-QQ-mid: xmsmtpt1794573908txnuao84w
Message-ID: <tencent_50548A0CA0A2E93225C5F5DD2DA865400607@qq.com>
X-QQ-XMAILINFO: MC6m07AaSFhrgbdkfdoApSPzEkMLO5PpNxzn2dBY9RluIJ1hd0ySbPf4yfKPif
	 7EcA/lQbDg6SMYb9Nk1KR+y25GqGoJcnUumc5n0/nEX8TDoOUqAw3ECe8+8hpW/ZV49c6XPkQxM0
	 ICk4QgtLuim1qr/8jxkT8dddbqnDr8WskWddsmtfDF6I+XUFzdLLSIuMD3rqoP06RVh7glfKQrTm
	 aqVvVqtsahVjy7Sho+ZxrrsvfsVOiML7eUZ8mF0UBXiZkoBV7Qa6jnzvuX8Dl8987guqYtSwiFjo
	 SQKJdhb1zWf7mQx3iwYVFM3Zcf0hkLP4lGCtxbBOPtaSxbs/AGzVNRGSjdezc1PnkmnjqAlPvs6E
	 OUv71Bn79m/15LJG9SlMH4tevFNyo5+GRBEJljs0QA6uRzkvjW4AkFeWQ583FUcVR+CInaIcebC5
	 TIh2oOXQp2W7+Rwiml14/DvghP8jP4J2xGi47+K3MXaw1+sneTsgqw1SVUg1Ad2PsiUnQb8lRJqx
	 i7J8yK+mpjYJozSImUcMQZmLwwZPvTiLtB7gp93AKABNW/aqgkrjOgxAKPKYFcTYZ+s4dX/9i7F1
	 X5MugFHfr4oXQuFD6H+N+mSVUhXiMjoRiS/HcetVlqo1SFyqL5DrqTjCQfHWfKS90gHOkCJ4TQnh
	 NYFP0mPiuDb5bMZ/644CukZIVEmnJPomGvqIdybo200xysclMqXUnTkj8pRo4NoQIFYVYufnIvUv
	 i/UjyU0FYX1NfdDS0wiKPOqmvDWiUsdPQ7dcZ5Gm3biZwyzHKdak+Le5xNQlOp3ATP5l0kLbh3yW
	 riZgIoNCcRGNZZAgynFoOSlhPOXog5g2PKEWXu4rWV4cqF1BKEGfy/Wd22geIQyUu6ocqzm8EkgZ
	 HsQZtyflUCIUAHEiTqpkB2FWXH4301oF0oCpVLjI/uyz0s8LUI187JnL1a75EISuTsg6XC/ONrD6
	 oEr6ArTDrNFIYc/osoQym3ae/pMRRGd04iWd7mNWQ3QTFR+nPEXOJnVPvnmBis0l+xck9XK7ffLR
	 9CxES+m/N2AKIW8Hvgm7wmSbrJKkupl69pVGn1/CwK800dWfAiEDT+bUppu/gILO9j1CYgGA==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: daniel@makrotopia.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	memoriaru@foxmail.com
Subject: [PATCH net] net: dsa: mxl862xx: bound FDB dump walk with a read limit
Date: Fri, 13 Nov 2026 20:45:08 +0800
X-OQ-MSGID: <20261113124508.30307-1-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
whose only exit is the device-reported "last" flag, holding RTNL for
the whole duration. Entries for other ports are skipped without
invoking the DSA callback, so the netlink dump buffer never fills and
the loop has no other way to terminate.

If the firmware crashes or misbehaves mid-walk and never sets the last
flag, the driver spins forever with RTNL held, blocking all netlink
configuration and stack operations on the system.

Bound the walk with a conservative read limit (16k, well above any
documented table size for this family) and return -EIO when it is
exceeded. The limit is checked after the "last" test so that a
correctly ended walk of a full table is not rejected: the walk needs
one read more than the number of entries it reports.

Not tested on real hardware; found by code inspection while auditing
the loop termination conditions.

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
+		 * above any documented table size for this family. Checked
+		 * after the "last" test so that a correctly ended walk of
+		 * a full table is not rejected; if the firmware dies or
+		 * misbehaves mid-walk this also stops us from spinning
+		 * forever with RTNL held.
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

