Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359698;
	b=KTcSVAWKapnzOFBLhuTLfAkr+FgOB9k/JKxDLn1t3jaiaSn7wCY1xQZjO08PzyI956NM
	 72shUiMl5DAlaYWpmQWCnK5amkXM5f6OUYb5KvkGbWPOmOXpHs8Cu3FnOWoIv5NGIp2ZT
	 DB22Zd6SisQSA3OWVVVh65Fdvx1NwEGsBrW7EZkjIa15DQIY9UGgd8vDeezKeD+0TBg7m
	 d7a+L7Zy9enmVqbgT0XgS6RJjmcZKRjAIHRsruLgUXqU50vczwZ7DWYpXwLCAncf2hNeW
	 3b6oER7Zo1xd8V+UhMcBdMxnj3Sx1wOOP0UGM5QNAYJyp4Sqm7z+XHnS/yvNEdwU7Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359698;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4T6fesm/yy7GI9hHZt0RtFpy5ZPlpuadqyFpzbE8GAU=;
	b=HHG4IHAM2vMhP3rFe7nhef7CrjiE/Kh8uHHxUV5aeOdgRIY8DxN+I22aJtKQGq9Nqf09
	 W7ewkHygrQ3wZ7apXx1a8H0rz6Z0X8jIU+nxr/UZizWq7gU2WgIff2NqZROmzEri9H4Nf
	 fV4egyvoGgRI1zOYGcXFSkGv8AghZyS3IAhQ3UVIU+dXOmzcNn5rvqGTfps9EkQ6k7LKi
	 Ry/qAAIZltvCCyVSbqQxtyvbTKL821mb4zKlFJx+WO9UFI6dgGZwmagWF1l2tEk5vnwnR
	 dm6rSv/P7qUJss3fOGWr91r6JI67kt4N3o6sbVO/FHKsgPRTp9sswCnmylmnWtSzPHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=CZI3SB6J;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224D3606A31C;
	Wed, 11 Nov 2026 01:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 224D3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=CZI3SB6J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=CZI3SB6JupLoyWJEuf2qUFMGdj4Rg4N77opugHGfDuSA5Nmayj97JbFlkDMqdgz8/oqIbtzgdMOTW
	 BGz1neqHebARWk0lTFANRkpCl+wGLYnMapdNuB6d8JgP3GK24qVO78B/tmOJzRIN5RRbTtuu61+KXQ
	 SYgUGTVzJX+7SDow=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86af3c18ce42-71f90;
	Wed, 11 Nov 2026 09:14:52 +0800 (CST)
X-RM-TRANSID:2ee86af3c18ce42-71f90
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from cmss.chinamobile.com (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66af3c18b86d-c8760;
	Wed, 11 Nov 2026 09:14:52 +0800 (CST)
X-RM-TRANSID:2ee66af3c18b86d-c8760
From: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Heiner Kallweit <hkallweit1@gmail.com>, Chen Ni <nichen@iscas.ac.cn>, "Alexandru Tachici" <alexandru.tachici@analog.com>, Lennart Franzen <lennart@lfdomain.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net v5] net: ethernet: adi: adin1110: mask the RX IRQ of the port being stopped
Date: Wed, 11 Nov 2026 10:30:00 +0800
Message-ID: <20261111-adin1110-net-stop-v5-1-yuehongwu@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

adin1110_net_stop() programs the RX-ready interrupt mask of the wrong
port: it uses ADIN2111_RX_RDY_IRQ (the second port's bit) when stopping
port 0 and ADIN1110_RX_RDY_IRQ (the first port's bit) when stopping
port 1, while adin1110_port_rx_ready() uses the opposite mapping, port 0
-> ADIN1110_RX_RDY and port 1 -> ADIN2111_P2_RX_RDY.

The port being stopped therefore keeps its own RX interrupt enabled while
the peer's is masked.  On ADIN2111 that stalls RX on the peer port; on
ADIN1110 the RX interrupt is never masked at all.  As the interrupt is
level triggered and adin1110_read_frames() skips the FIFO while
netif_oper_up() is false, the stopped port also keeps re-raising its
interrupt with nobody draining the FIFO.

Swap the two bits so that the port being stopped masks its own interrupt.

adin1110_net_open() rewrites the whole IMASK1 register and, on ADIN2111,
always includes ADIN2111_RX_RDY_IRQ, so opening one port also re-enables
the RX-ready interrupt of a peer port that is still down and undoes the
mask just programmed by its stop.  Only keep the peer port's bit enabled
while that port is running; the write stays absolute, so the bit is still
included when the peer is up.

A port's RX-ready IRQ is now enabled only while that port is open: the
peer's bit is never re-enabled for a stopped port.  IMASK1 is written in
exactly two places, adin1110_net_open() and adin1110_net_stop(), both
under priv->lock, and both compute the mask from the state of the two
ports.  priv->irq_mask keeps its previous value and meaning (the STATUS1
write-one-to-clear mask), so the status clearing is unchanged.
Single-port ADIN1110 is unchanged.

Found by code review while comparing the bit mapping against
adin1110_port_rx_ready().  I do not have access to ADIN1110 or ADIN2111
hardware, so this was only compile-tested (CONFIG_ADIN1110=m and =y, gcc,
W=1, full kernel builds), not exercised on a device.

Fixes: bc93e19d088b ("net: ethernet: adi: Add ADIN1110 support")
Signed-off-by: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
---
v5:
- Repost as a new thread, as requested by Jakub Kicinski: the netdev CI
  could not parse the v4 mail.  No code change.
v4:
- Also keep a stopped peer port's RX-ready IRQ masked in
  adin1110_net_open(), whose absolute IMASK1 write re-enabled the
  interrupt of a port that is still down and undid the stop mask.
  Reported by Sashiko (netdev bot) as an incomplete fix.
- Did not carry the Reviewed-by from v3, as adin1110_net_open() is
  changed as well; a Tested-by from ADI on real hardware would be
  welcome.
v3: no code change.  Cc the ADI commit-signers that get_maintainer.pl
reports once a git history is available (Nuno Sa, Heiner Kallweit,
Chen Ni).  Thanks to Andrew Lunn for pointing out that Nuno was missing.
v2:
- Cc the netdev maintainers, as flagged by cc_maintainers on v1.
- Explain how the issue was found and that it was only compile-tested.
v1: https://lore.kernel.org/all/20261103-adin1110-net-stop-1-yuehongwu@cmss.chinamobile.com/

 drivers/net/ethernet/adi/adin1110.c | 25 +++-----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index 53fac3d..c41fad7 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -885,6 +885,7 @@ static int adin1110_net_open(struct net_device *net_dev)
 {
 	struct adin1110_port_priv *port_priv = netdev_priv(net_dev);
 	struct adin1110_priv *priv = port_priv->priv;
+	u32 common, own, peer, irq_mask;
 	u32 val;
 	int ret;
 
@@ -895,12 +896,24 @@ static int adin1110_net_open(struct net_device *net_dev)
 	if (ret < 0)
 		goto out;
 
-	val = ADIN1110_TX_RDY_IRQ | ADIN1110_RX_RDY_IRQ | ADIN1110_SPI_ERR_IRQ;
-	if (priv->cfg->id == ADIN2111_MAC)
-		val |= ADIN2111_RX_RDY_IRQ;
+	common = ADIN1110_TX_RDY_IRQ | ADIN1110_SPI_ERR_IRQ;
+	own = !port_priv->nr ? ADIN1110_RX_RDY_IRQ : ADIN2111_RX_RDY_IRQ;
+	peer = !port_priv->nr ? ADIN2111_RX_RDY_IRQ : ADIN1110_RX_RDY_IRQ;
 
-	priv->irq_mask = val;
-	ret = adin1110_write_reg(priv, ADIN1110_IMASK1, ~val);
+	/*
+	 * The write below is absolute, so only keep the peer port's
+	 * RX-ready IRQ enabled while that port is running; a stopped peer
+	 * must stay masked until it is opened again.
+	 */
+	irq_mask = common | own;
+	priv->irq_mask = common | ADIN1110_RX_RDY_IRQ;
+	if (priv->cfg->id == ADIN2111_MAC) {
+		priv->irq_mask |= ADIN2111_RX_RDY_IRQ;
+		if (netif_running(priv->ports[!port_priv->nr]->netdev))
+			irq_mask |= peer;
+	}
+
+	ret = adin1110_write_reg(priv, ADIN1110_IMASK1, ~irq_mask);
 	if (ret < 0) {
 		netdev_err(net_dev, "Failed to enable chip IRQs: %d\n", ret);
 		goto out;
@@ -945,7 +958,7 @@ static int adin1110_net_stop(struct net_device *net_dev)
 	u32 mask;
 	int ret;
 
-	mask = !port_priv->nr ? ADIN2111_RX_RDY_IRQ : ADIN1110_RX_RDY_IRQ;
+	mask = !port_priv->nr ? ADIN1110_RX_RDY_IRQ : ADIN2111_RX_RDY_IRQ;
 
 	/* Disable RX RDY IRQs */
 	mutex_lock(&priv->lock);



