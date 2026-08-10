Received: from sender-op-o11.zoho.eu (sender-op-o11.zoho.eu [136.143.169.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12867081A
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786342627; cv=pass; b=RBO95GzoT6+WZI/2qZgSwhvQrleJXiBnbOi4+8ZC7DzN7caewqRrCL+smwruhOk6VwTrS168brX/TLtRz46y6MD+aCABK73IECxrn/el/6QwZdAbz75stA4Bx7ZxtvUDvFYH1Cn//6zDfrDKJBIdpu6+kxDE7JYQjZ8+lEzSGH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786342627; c=relaxed/simple;
	bh=EbqO2IPJ+kWymDkkXpLZhgYoGGdsuW6I9JN6vXgEPB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o5jy0XGSrf+Ry6wTt9J5X4sqhTt6HbP2deilbVEvMyRaDQN4ZEZpjVGLiAA6QF+DNtdIPYuh/zFbDv4tsCuQmfWwmItSwxvrSHd2iHwLLAZ1Emi1+y9XQJNvU3H7Eb6uKxBF+kE3zFqB/RZJFc+i3YYya6YMjc6cq0LHUtwqNPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kempniu.pl; spf=pass smtp.mailfrom=kempniu.pl; dkim=pass (1024-bit key) header.d=kempniu.pl header.i=kernel@kempniu.pl header.b=N2fO7XN7; arc=pass smtp.client-ip=136.143.169.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kempniu.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kempniu.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kempniu.pl header.i=kernel@kempniu.pl header.b="N2fO7XN7"
ARC-Seal: i=1; a=rsa-sha256; t=1786342590; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ZDbLIOq4KnvgR6AFAkLIjGwdip0mHxbaImrhEu0fROL9N1mmR5MxueDLgiyYDikCQJm39eBmbUgifldl9QyVMsmprYZ9u7ArhvaW6cJV0zcNGmNx4PNT/378WH99FkQgnTdJLUCwBij007pVqvifm3aVN7iQQ1bZd00oPuRmAk4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786342590; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Hvd8rWDn/9IkybD/Ou3YB8z8+tLH3CK9WGf92NYfFLY=; 
	b=T7OkC0LCZTIzgDOegzskIuL+meNu68n8G9zhQxCdusRBDJOB+y08NlBLQcmGjQ458s68SJ68whFqVB/qDpEekBk0hTE6KDz6gwy2DXD5tAo0U7fy4dmvH4oKOOhQ9Pu98kybHQXqPjEz4w0c+blx18Hec6z51KpaqJE0RdXFKWc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=kempniu.pl;
	spf=pass  smtp.mailfrom=kernel@kempniu.pl;
	dmarc=pass header.from=<kernel@kempniu.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786342590;
	s=zmail; d=kempniu.pl; i=kernel@kempniu.pl;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Hvd8rWDn/9IkybD/Ou3YB8z8+tLH3CK9WGf92NYfFLY=;
	b=N2fO7XN70hhH8c/5ecfD3amrlfpDBuAXEEMF0dgjB7uMoMqROd+SfIrq58PcaZ0H
	XoUUFkq63mekXb3WsaaE3W0XUfhilcj2Hs2aRkb53FD3eyspSM6s6vyxcLom7m75Wwi
	HbrAj/tZ33gm3FlmgjOClu+MWY7p1qAnKv19SWWs=
Received: by mx.zoho.eu with SMTPS id 1786342589464656.4039236454545;
	Mon, 10 Aug 2026 08:16:29 +0200 (CEST)
From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: dsa: qca8k: Disable mgmt Ethernet for qca8327
Date: Mon, 10 Aug 2026 08:15:53 +0200
Message-ID: <20260810061612.23745-1-kernel@kempniu.pl>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

While the qca8327 switch appears to support in-band mgmt Ethernet,
prolonged use of that protocol (e.g. for polling link state) makes the
device unstable: within minutes, ports randomly go down and no traffic
is forwarded anymore.  The same issues do not occur when MDIO is used
exclusively, so ensure mgmt Ethernet is not used on the qca8327.

Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
I came across this while migrating an AR9344-based router with a QCA8327
rev. 4 switch to a DSA-aware driver.  This glitch is a pain in the neck
to troubleshoot any further as it occurs randomly, anywhere between a
minute to an hour after the switch is set up; traffic load exerted on
the switch does not seem to matter as the problem can be triggered on a
virtually idle device.  Previously working links are reported as going
down (one by one, not all at once), even though port LEDs still blink;
no traffic is forwarded; reloading qca8k does not alleviate the problem,
only power cycling seems to help.  Nothing like this happens when only
MDIO is used.  However, qca8k currently only uses MDIO as a fallback.  I
figured that simpler is better and that mgmt Ethernet should simply be
disabled for the qca8327, but I would be happy to work on some
configurable solution if that would be preferable.

 drivers/net/dsa/qca/qca8k-8xxx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 4c928983b8623..1d90a23aba6bb 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -160,6 +160,11 @@ qca8k_set_page(struct qca8k_priv *priv, u16 page)
 	return 0;
 }
 
+static bool qca8k_mgmt_eth_disabled(const struct qca8k_priv *priv)
+{
+	return priv->switch_id == QCA8K_ID_QCA8327;
+}
+
 static void qca8k_rw_reg_ack_handler(struct dsa_switch *ds, struct sk_buff *skb)
 {
 	struct qca8k_mgmt_eth_data *mgmt_eth_data;
@@ -316,6 +321,9 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 	bool ack;
 	int ret;
 
+	if (qca8k_mgmt_eth_disabled(priv))
+		return -ENXIO;
+
 	skb = qca8k_alloc_mdio_header(MDIO_READ, reg, NULL,
 				      QCA8K_ETHERNET_MDIO_PRIORITY, len);
 	if (!skb)
@@ -368,6 +376,9 @@ static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 	bool ack;
 	int ret;
 
+	if (qca8k_mgmt_eth_disabled(priv))
+		return -ENXIO;
+
 	skb = qca8k_alloc_mdio_header(MDIO_WRITE, reg, val,
 				      QCA8K_ETHERNET_MDIO_PRIORITY, len);
 	if (!skb)
@@ -630,6 +641,9 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	int ret, ret1;
 	bool ack;
 
+	if (qca8k_mgmt_eth_disabled(priv))
+		return -ENXIO;
+
 	if (regnum >= QCA8K_MDIO_MASTER_MAX_REG)
 		return -EINVAL;
 
-- 
2.55.0

