Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793273145;
	b=1NsmQ2d5u/IGccaeqXynJlqFF8PtXoXrVcQFWHnHaiRw60mN7CmYYwARy641ynN5I3D8
	 tg6WxdOiShJJM0z41E+atOU4NywZhFK9pXx3ytBa2Gw6rVfXaY695QLueuEOi0sQPxNaw
	 UadZF1rlK0uEw5vB2MTuV9WWx8kAQJQiFvuhfcznmxxlfGAh4MDKE1/vbcYQhkfzSscki
	 j/cFDYJ66T4oiXU0MV4Xb0gbVP1/RRAE3LOe/cTnB1FKQvvuUzIfOe0MEAa0UX8zOB8co
	 o0SHnL0tZ8YpKQidMV9/5R77g8ssifdAtCifgVDhl7n+vardYnJW6s8aFFCfwfKlMRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273145;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ksEbwxpIGOBnF1PGvlpnzjzh5x/d2KaJuWm6ofsQY70=;
	b=fEaIaTpZ89jURBusYjDQyDETecgbvXFATwb31MOCGSJ8K8rajaj3MFd0NNX18ElPn1d+
	 b/MxlnINni4Cjtpc/yP4UZtZE6UOXToyCQ5+iWHp557DEvWCfyvgF90tfpvuHdEmivod/
	 vS9k2h4Kv2fK83qp7to/oocHbXTmN7LZklFT/IeTDaqZhXujd4hQgKthGY9qI3WRkz4MX
	 SMnSNuyoRXo443+adNRMKHLvdKe6I635na+n7K+JNDbHHWsZOdEnzKXT+OfgcJNl9g7Uv
	 ndQqqqFD6scMpcOHMmy1tu+HYLTYV0f+X1g2yYR3pKMEi3gRZpsE8LFe1BCJ/tiDixA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=TvLxSLG6;
	arc=none smtp.remote-ip=203.205.221.240
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F612606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F612606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=TvLxSLG6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793273135;
	bh=ksEbwxpIGOBnF1PGvlpnzjzh5x/d2KaJuWm6ofsQY70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TvLxSLG6KlBbBrmQ/up+8lgoufKicX1WvztrZ4my47Q1/ww8TxFNxyrvbqkBxB8KB
	 prtkohem5v8gLCwaf+BlaSkeBpYEB6jrgWIdk+MLpB9B3W7QfU9irjCdo2kuuFp0W+
	 Iz9j0d7Tv6eIlvNz1nDsA1L46Xlfp3TdNmFeB/lw=
Received: from localhost.localdomain ([240e:3bb:302c:4eb1:9b:594b:9d4d:93e4])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 65DA727C; Thu, 29 Oct 2026 19:25:29 +0800
X-QQ-mid: xmsmtpt1793273133to5r1j8wc
Message-ID: <tencent_F5633A48A97A7D712B7DB98CE1950213C805@qq.com>
X-QQ-XMAILINFO: OeJ9zRfntlNPg0/m8hTcbrGr/N4bsSxGCkq+bh0wHHwDB7ldEu1s/dJmO93aPv
	 1utlOSm6voMnuFIvnt6aggqDGLE6fgkpahXp2MqQ1wd6dpv1/9qm2spaQM4W0R0lOyIFCS4BhT0I
	 OO+USpmqoFOqV0jlG0pf+wPREbz3GA0JL5QUkfnbQhSx3Z0A1IWekdl6eAbMR5eX113HTXxt1Npu
	 wNg78RuJ+8h3DvA3A1QnSHwTLmBPTOIbEtVje+lVT6PvBzB4BT4JxlHOfhBBMrDLY9jdFfvHQgKa
	 Cw+DKhZovGP2rco1TH29NFC3Q5v6k2BV01oZ/CwMSndqpsWhZrpD4ZwzNgdS5BnSjCh4emEcH2Yn
	 AcMXTm8dJhn0knTm0YsmuWVjPKP6AfGw7eOVk7N5zxE4S0aYYT62g4hFfPutujTwl0KaSoZ/2Ujo
	 tW4nloG5Z+JNVSqCZlN83fNlZDoRl+hL3RQrDi7cHU5SpNZvtR570e47BH4/r7O2oDP1RCAGTTSy
	 TO6KueVzPi7yfmcz5jb8mY5ZOx/edhP2K6KJ/enTfIlzBNuZi+M9XLm2tfyF/B52/70cjUs0Dr95
	 eZ9sUkTVDHMfs7tIB2vL5OAOS0n/hcTQTjliqMgs6b33o3o7EMo85hG+BZ78xUgzc/hs+w1IY3NK
	 V8X9eskux9XcQ8n87QGDgjnmNsxVA+DtcqVWDUxMf7cKmrc6MDj2RgDbLf3dtsLP4/7/LWzFv9UZ
	 kh6UjcH9b91Rhchnp5wtJ3C7YvUKMRvCpPC3ToJPMjQO4NPZWuASO6vv3ylEx3+PDobqgdroKV28
	 H9VENeGdGPu3nxxG+nVE+V8pbCEl2W9a8XowEmX6L2nZiN6ZtJPk+7vmr1pFxyssxC4VgTQQSd9p
	 uPsCvyoSOS3LqryF3TIKMFKdxSgzpXFCrmEJkWLzARJjmSm7coxaC3+RBpB94KglI8L0gElnMWxr
	 ESZTd+o+3uIypNNcWpob29dC1eIZa3kayzBwXqA3kT63ZQY6uXCZ6LPRpFFKYl5/XaUx6onIg4fz
	 zJS52S+W0siEBcwBBn7YliW16EZ40jaonYGm5Cq6S76e6UJMvyWZ/ZBWh6eFyPjL/NbJzm4A==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: daniel@makrotopia.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	johan@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v3 2/2] net: dsa: mxl862xx: validate the bridge id returned by BRIDGE_ALLOC
Date: Thu, 29 Oct 2026 19:25:28 +0800
X-OQ-MSGID: <20261029112528.56652-3-memoriaru@foxmail.com>
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

mxl862xx_allocate_bridge() only checks the transport status and
returns the firmware-supplied bridge id verbatim. Three protocol
violations slip through:

- id 0 is reserved ("not used for historic reasons") and doubles as
  the "not allocated" value in priv->bridges[] and priv->ports[].fid,
  so a port or bridge configured with it looks unallocated: later
  joins allocate again and FDB/MDB lookups fail with -ENOENT. It also
  collides with MXL862XX_DEFAULT_BRIDGE (the CPU port), merging the
  port's filtering domain with the CPU port's.
- the API documents INVALID_HANDLE for failed allocations without
  defining its value; the MaxLinear GSW API uses 0xffff, so reject
  that value as well.
- duplicate ids collapse the FID isolation of two domains: FDB and
  MDB entries are matched by FID, VID and MAC, so deleting an entry
  in one domain can remove an entry belonging to the other.

Firmware that follows the API never returns these values; the checks
only guard against firmware that breaks it.

Fixes: 340bdf984613c4a9 ("net: dsa: mxl862xx: implement bridge offloading")
Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
---
 drivers/net/dsa/mxl862xx/mxl862xx.c | 37 ++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index 37e8c18f1..d8d58f280 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -589,16 +589,51 @@ static int mxl862xx_vf_alloc(struct mxl862xx_priv *priv,
 	return mxl862xx_vf_entry_discard(priv, vf->block_id, 0);
 }
 
+/* Firmware bridge ids are stored in priv->bridges[] (bridged ports)
+ * and priv->ports[].fid (standalone ports, which also allocate one),
+ * so a fresh allocation must not collide with either.
+ */
+static bool mxl862xx_bridge_id_in_use(struct mxl862xx_priv *priv, u16 id)
+{
+	int i;
+
+	for (i = 0; i <= MXL862XX_MAX_BRIDGES; i++)
+		if (priv->bridges[i] == id)
+			return true;
+
+	for (i = 0; i < MXL862XX_MAX_PORTS; i++)
+		if (priv->ports[i].fid == id)
+			return true;
+
+	return false;
+}
+
 static int mxl862xx_allocate_bridge(struct mxl862xx_priv *priv)
 {
 	struct mxl862xx_bridge_alloc br_alloc = {};
+	u16 id;
 	int ret;
 
 	ret = MXL862XX_API_READ(priv, MXL862XX_BRIDGE_ALLOC, br_alloc);
 	if (ret)
 		return ret;
 
-	return le16_to_cpu(br_alloc.bridge_id);
+	id = le16_to_cpu(br_alloc.bridge_id);
+
+	/* The API reserves id 0 ("not used for historic reasons"), which
+	 * also doubles as the "not allocated" value in priv->bridges[]
+	 * and priv->ports[].fid, and collides with
+	 * MXL862XX_DEFAULT_BRIDGE (the CPU port). It documents
+	 * INVALID_HANDLE for failed allocations without defining its
+	 * value; the MaxLinear GSW API uses 0xffff, so reject that too.
+	 * A duplicate id would collapse the FID isolation of two domains
+	 * (FDB and MDB entries are matched by FID, VID and MAC).
+	 * Firmware that follows the API never returns these values.
+	 */
+	if (!id || id == 0xffff || mxl862xx_bridge_id_in_use(priv, id))
+		return -EIO;
+
+	return id;
 }
 
 static void mxl862xx_free_bridge(struct dsa_switch *ds,
-- 
2.39.5 (Apple Git-154)

