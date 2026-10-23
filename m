Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788014;
	b=FiZPY5Q7WD1pLl+mFH8R7tKS14J0EMZiGMNE/JekEECeGRjsK77IEM9lBl0pb8mC2yZf
	 /xU58DN25ZLua9HmkfjDUOBD/o+4pL6i12UCyP5wIG2FU4oLgBQRosh2qzqW60+Zuox8Z
	 n2YyGyudcy/qbRLI69FvDGyoQ4HlBDJfFCjCGiErw2TKzJw3txB+rh5zL1KOKIIER1a6w
	 suWutbYNn/ApykNWnYvPwWp2Uo8ay+Fk2Qr4m3NJxvQuYn+0RoPTPns2uUqBSln9dlh6J
	 NHOb1cxeRBDBGtRig8vi8/qjceMkbeW7rs2mVY80BB+mkT5dk4SIUsW9sdgl0b+zfww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788014;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e7MC+SvhzJ5d4A+rWccbEYhTB7xMPiRUfnJj2LLRnR0=;
	b=XvG3+qhBAQX+THgLWGF1H7L3lmf708SrNSQrkaJfNxkOkH/Pz6cOVk3WwNP4OxYo71Hc
	 oTr/XaN6lijXc+vbe99I3M8tgbx9tCYRnLmxXla34l/PF1mBeqYGGFlj8yS5KQB1txOBl
	 E5aHlBK92iNrhQvW2x9kiknKwj5mAete0npV31HJmcFENzTo0/SLySE1GTQk+/dqdZ2u0
	 KRm6Z3+63MwSuiHnA/JSb0xoc8vf429ItCKGixy+Oq/FU3Mb2Gn02S6rr7Cwfj2/kKPCH
	 9jsyomn7ICEha4pWlftGcB5jwY+fZ4Yn7qoUoA/1dAAe6OyR8bYNIW2Ks8vkz5tL87Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=Nty4I+kt;
	arc=none smtp.remote-ip=43.163.128.48
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B0F606A31D
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 20:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4B0F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=Nty4I+kt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1792788010;
	bh=e7MC+SvhzJ5d4A+rWccbEYhTB7xMPiRUfnJj2LLRnR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nty4I+kt7Ox//7xriXtcabHGyLcMxw5x+GPUT6bo/NdUzOrmItIGqhk9D9Rc/b7dh
	 voknUSFffoN8wTZmbAZHBcW488/rbIfSzpDc3+9fbxqyrIOt0kJuH0U4FkD6O/08dX
	 rWauh38X+ohCxS8cTnqLcbnwL5/pTB8KxJn77OY8=
Received: from localhost.localdomain ([180.165.29.111])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id A069680F; Sat, 24 Oct 2026 04:40:06 +0800
X-QQ-mid: xmsmtpt1792788009t8zeod02o
Message-ID: <tencent_3DB6652906268A3AA099E978258675B1AD07@qq.com>
X-QQ-XMAILINFO: NSJPTvnisrLjSiZB0dcX5XsRyNgoOy9em17r+oQW0+9rfvvn1Sba/vYdDwbAxz
	 k5oFlYWsU7Vnr1n1uSdQcU5xSoSuQLJ1yov6G/HMUdSwesGPfRs7qo0EWWmuuVPs4xrRKpXAttW5
	 Kc1+1lCSWQuuglkqBBVg5Q93OSS7LcGbkdkJK9sKREYCfRPo9rXx6SEbhVUwjAlKb44d7jINcfZ5
	 bBZEERNKOaWxMvsUUq7Ua+xdzps/yJSlSaOAX+M+pCTWwhkibvujskCyrxifDRbSA9pJ/Ma36RrC
	 PjN1pRaMVDprm0JuKXzs0M0xRg8AtsHnOXkKjcSnkKcrj0y2SXHNrpe8rmpoo7pAN3afinOHZVsS
	 E9V1MgbEkFJXKFYxZEZwiGKxaMnQtM9z+Zvw6gv2Yq9TB1xr4JFiXiM0JSIs4s+ZtMDfUY+1aJ2k
	 47CQnSo4g4mfJjDp0OxQ4++jhRkAZN9qcMEjYK4iPgbEA69ckC7Sf2UYJfDyZrzH6i/rNnl0gdVi
	 pwNaJoOPhPHxiCl97Qmv801k0foI3GAKlrOfTLjSIas4+0/pr2Lkd/BLYolCKUpOwoCSacPX22PE
	 eZyM6kXvF4/gYlcmCMWAv5F3Q0SrFmoq/gIFjIskrBMHLtxMreu+6h/MyUUGdxov8WjalHQTIbsN
	 K+F1JSWrk2Ggg67My3tab5YfsHze30JbX38E5wYUOEwBpj+G1ud0v9CrPIxyEFCaI1reilriL+re
	 vEzP0dsiKEgrBnU1MyxvOWO8QR+oX8GqLUnG8obMwFP90JY2xfWM875ReGwDv8wHYPPw1nRK61Oz
	 lYBgygzivxKhv6txq1TuSgo85b2IKq2q1NiR2Rk/GHmkQpUuieVXJzErla0Tt1qrwj8fQ8hZ6EBM
	 T+WOiWVa5UGtn1yUlpux0MMXZVNTj8czFormBXDgEfL32EohZXK9gJDXlA/H7W+7MGTM3TtOeUPl
	 BH/3kMnd6v8Ua7fQ1keAAF+Xoebmx7wcjNlZ/LtdK12dqdtR8kJVy1rqk9V3cxIFouRglMz2I=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: daniel@makrotopia.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	johan@kernel.org,
	kuba@kernel.org
Subject: [PATCH net v2 2/2] net: dsa: mxl862xx: validate the bridge id returned by BRIDGE_ALLOC
Date: Sat, 24 Oct 2026 04:40:06 +0800
X-OQ-MSGID: <20261023204006.24923-3-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261023204006.24923-1-memoriaru@foxmail.com>
References: <20261023204006.24923-1-memoriaru@foxmail.com>
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
index fb5fbe5..a432709 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -584,16 +584,51 @@ static int mxl862xx_vf_alloc(struct mxl862xx_priv *priv,
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

