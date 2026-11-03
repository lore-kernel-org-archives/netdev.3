Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706465;
	b=IinFw4BxOYmpcKJqiLMxx6RI5oYFRdJRWJbXjIMfSlcTvXsTyvXDbntwEfXtEAMq2CQH
	 ERZTbc/y9Vqga/d2IXuyVZcx6EIpjdYx8bGA+ISdA6h8BAZ9L6De+YcgxlYTsYjyg4jdh
	 FJJaYJJYCXpE5udcsP4hGOYvUTnxLM/WHWLq/pbBgc4mFQkR5XfV6uG1lHqEKbaHWb+gU
	 mG1ks/37d+QYve3CEh04R4ucys8aiiVE10XOgoH4CMrC1oQPOymD9GBr6TNGcvIHOiuDi
	 9RthQCeaFES0Ja9ejZclKYC2lnlpICFBm1WWisrxHVjInr54DZRh1RVrI24cUGd4K4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706465;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=XlQrV0jM2I1Oz+09ckZcYX5LumOapOvmzWdHtr6kyFY=;
	b=N+ZyG5RZM5mhefoauvmPHZTP2tzbc7mzJZW0cxGLkGiVTNrsxDGBxU0+tHXsGl7IjfzW
	 fWocXh7Yo3J2QI6TBmXs0v8HaNIs0wACKH5YOKKE2y8SlzDSbwVXcLRRLFQBKxJvqIxzd
	 1TTYfCxvOYz+vtM4QdAB0x3SDs4BdsyI9IDxf5fOi2JhgoIqFQzndx1FiZjuOaPyX6WIj
	 BB7IfzD9CEcDqQuaAcrqOBq3st7WzP0qIzJ2ybtbMXUZ3hIR4hoshSGF8Psg5LrKDtU0q
	 8npmUlSximBomLWulm7XR/L1uYgflQCes3+Zp7FFug428hbsTBRV/OuMzvU8jJY8Z4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=QuNOhR+N;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2936D606D803;
	Tue,  3 Nov 2026 11:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2936D606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=QuNOhR+N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=QuNOhR+Nh6fKqbTjrnE0zQRx6dNwmWFlVjrfJkZoJl9k2O1k7SMo5y8cZ5EhwUodVoaqpON43jke8
	 htLN3i3fYfAnxkuTxSejwOuQhRlb+P0MVUUmbkKD1n0f4KIjOINuaBGIDGQgut15zFXvv/9jN2ZPEO
	 IyqdiM9IAi23ZapY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96ae9c9d3f51-99e37;
	Tue, 03 Nov 2026 19:47:33 +0800 (CST)
X-RM-TRANSID:2ee96ae9c9d3f51-99e37
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from dsh.local (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16ae9c9d40d8-f93b9;
	Tue, 03 Nov 2026 19:47:33 +0800 (CST)
X-RM-TRANSID:2ee16ae9c9d40d8-f93b9
From: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: alexandru.tachici@analog.com, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ethernet: adi: adin1110: mask the RX IRQ of the port being stopped
Date: Tue, 03 Nov 2026 19:47:33 +0800
Message-ID: <20261103-adin1110-net-stop-1-yuehongwu@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.43.0

adin1110_net_stop() programs the RX-ready interrupt mask of the wrong
port: it uses ADIN2111_RX_RDY_IRQ (the second port's bit) when stopping
port 0 and ADIN1110_RX_RDY_IRQ (the first port's bit) when stopping
port 1, while adin1110_port_rx_ready() uses the opposite mapping, port 0
-> ADIN1110_RX_RDY and port 1 -> ADIN2111_P2_RX_RDY.

The port being stopped therefore keeps its own RX interrupt enabled
while the peer's is masked.  On ADIN2111 that stalls RX on the peer port;
on ADIN1110 the RX interrupt is never masked at all.  As the interrupt is
level triggered and adin1110_read_frames() skips the FIFO while
netif_oper_up() is false, the stopped port also keeps re-raising its
interrupt with nobody draining the FIFO.

Swap the two bits so the port being stopped masks its own interrupt.

Fixes: bc93e19d088b ("net: ethernet: adi: Add ADIN1110 support")
Signed-off-by: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
---
 drivers/net/ethernet/adi/adin1110.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index 53fac3d..abdc160 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -945,7 +945,7 @@ static int adin1110_net_stop(struct net_device *net_dev)
 	u32 mask;
 	int ret;
 
-	mask = !port_priv->nr ? ADIN2111_RX_RDY_IRQ : ADIN1110_RX_RDY_IRQ;
+	mask = !port_priv->nr ? ADIN1110_RX_RDY_IRQ : ADIN2111_RX_RDY_IRQ;
 
 	/* Disable RX RDY IRQs */
 	mutex_lock(&priv->lock);
-- 
2.43.0



