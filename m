Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4B632E151;
	Sun, 22 Mar 2026 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774186055; cv=none; b=idKFaApCVLoBVCMOdEvB7j48BYhfEJKnr8tC779DPr/gE3eEWQio8VRmtgD5wLLIsEQJiLXwO974drX0Km3U8CFUpcmUGzzXM8FXvQC2aDfBflu6XrEmXXfd1jUQBzG5yopq12gOOkOqM5ubiakJp1pKxSBrp6FY2Vy5g3W5H8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774186055; c=relaxed/simple;
	bh=gfoTzRF8C7G3oOpaeXH4MVh5p91y6TCAcTPCHYauuPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4gPVzmSanrBbCADRiGv6KvaUH/7S7tXwZ5eEQ1HsevCRxoPYnUX97XWFwj9bmiAzhIgFowwfT9nLVTLMVEZHCl7EdM1df7bdWyBSoSXwCyzQB3dpd4ogL1cFgEoJzB28qdaFZCifH+J+UNW+3GYA3juD55UXhD1TWwxOmatYeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w4Iq1-00000000323-1knC;
	Sun, 22 Mar 2026 13:27:29 +0000
Date: Sun, 22 Mar 2026 13:27:26 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v2 2/2] net: dsa: mxl862xx: use RST_DATA to skip
 writing zero words
Message-ID: <d10bd6ad5df062d0da342c3e0d330550b3d2432b.1774185953.git.daniel@makrotopia.org>
References: <cover.1774185953.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774185953.git.daniel@makrotopia.org>

Issue the firmware's RST_DATA command before writing data payloads that
contain many zero words. RST_DATA zeroes both the firmware's internal
buffer and the MMD data registers in a single command, allowing the
driver to skip individual MDIO writes for zero-valued words. This
reduces bus traffic for the common case where API structs have many
unused or default-zero fields.

The optimization is applied when at least 5 zero words are found in the
payload, roughly the break-even point against the cost of the extra
RST_DATA command round-trip.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v2: no changes

 drivers/net/dsa/mxl862xx/mxl862xx-host.c | 38 ++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
index 0b7f8db318257..cadbdb590cf43 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
@@ -283,6 +283,17 @@ static int mxl862xx_get_data(struct mxl862xx_priv *priv, u16 words)
 				  MXL862XX_MMD_REG_DATA_MAX_SIZE * sizeof(u16));
 }
 
+static int mxl862xx_rst_data(struct mxl862xx_priv *priv)
+{
+	return mxl862xx_issue_cmd(priv, MMD_API_RST_DATA, 0);
+}
+
+/* Minimum number of zero words in the data payload before issuing a
+ * RST_DATA command is worthwhile.  RST_DATA costs one full command
+ * round-trip (~5 MDIO transactions), so the threshold must offset that.
+ */
+#define RST_DATA_THRESHOLD	5
+
 static int mxl862xx_send_cmd(struct mxl862xx_priv *priv, u16 cmd, u16 size,
 			     bool quiet)
 {
@@ -318,6 +329,8 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 		      u16 size, bool read, bool quiet)
 {
 	__le16 *data = _data;
+	bool use_rst = false;
+	unsigned int zeros;
 	int ret, cmd_ret;
 	u16 max, crc, i;
 
@@ -331,6 +344,24 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 	if (ret < 0)
 		goto out;
 
+	/* If the data contains enough zero words, issue RST_DATA to zero
+	 * both the firmware buffer and MMD registers, then skip writing
+	 * zero words individually.
+	 */
+	for (i = 0, zeros = 0; i < size / 2 && zeros < RST_DATA_THRESHOLD; i++)
+		if (!data[i])
+			zeros++;
+
+	if (zeros < RST_DATA_THRESHOLD && (size & 1) && !*(u8 *)&data[i])
+		zeros++;
+
+	if (zeros >= RST_DATA_THRESHOLD) {
+		ret = mxl862xx_rst_data(priv);
+		if (ret < 0)
+			goto out;
+		use_rst = true;
+	}
+
 	/* Compute CRC-16 over the data payload; written as an extra word
 	 * after the data so the firmware can verify the transfer.
 	 */
@@ -367,6 +398,13 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 			val = le16_to_cpu(data[i]);
 		}
 
+		/* After RST_DATA, skip zero data words as the registers
+		 * already contain zeros, but never skip the CRC word at the
+		 * final word.
+		 */
+		if (use_rst && i < max && val == 0)
+			continue;
+
 		ret = mxl862xx_reg_write(priv,
 					 MXL862XX_MMD_REG_DATA_FIRST + off,
 					 val);
-- 
2.53.0
