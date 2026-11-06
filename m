Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793930599;
	b=UNk47fny5ZTYAx30wZshpUY2++5K2K/QvvvYL3JEEv6E8VpyExNcgE6PkGAEOaizwFb+
	 pt1l4xXVcK0JfXpa3ju8PtKhol0cJVup+vCJfDeTVHiHHp1KLbs5aP3hOOLq+kzptUL38
	 QBUPeb5kVKICnpmqI49Rnchfoc03M/d4VED9u16vCRB/l3qVxMdRgHkGJ8GUZG7/r0yy/
	 MIpYGfUO4DAbb2BAbaUuXlaicPf4W1wsh6fNdaY0VsZqb1Hit5CPjrhCk4zYxdMSkZJBz
	 Y7Ay9I0ln2bQqxsep7+gFPuhgHrA+GJU6AcCgtja/MAyMF9F2EBIxSYUhtv8X88RT9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930599;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=a5+XHx9VkmMYhdeQ2fq6mtWIZa8h3SwrC9yL/0CDbts=;
	b=qc96gG1UglocMUownRzeKJ86glxdLVy3inp+9B9RhGmHwOeQkSO3orL7bOQbRC1DLBIl
	 Oig/wzmFECOAGFICINxmw11lVjXG745kB4Ac5qvy+QVhm+DqwIxoB9MaoE75quIKQJwyx
	 CBTRUloooGeH18vtf4MuZfN03opxAy12kvU72OKO1LbiAAu2UdIQnUvOXWjY0Goft4E9o
	 EUkdgxX4IbvejGjAJsAg4MSpp3MoXDhjGh2jns5itvX9sCzPm1NZCEOb0/bAroh5/ki/K
	 3JQupgwLpvQDj+2NVL51wFl1cG2jC2F6DCkhEV+EleVrpX1FQM0942aDuvuBtszxahg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ppqx8sxJ;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A9C606A31B;
	Fri,  6 Nov 2026 02:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2A9C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ppqx8sxJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ppqx8sxJ8Y1oVubf3Xg5bguV+QMQxKmL+cCdlXzbu0LgBP86xeJ3+F7UTxJ2uAknIGRcpIL9bXeWi
	 pMyyWqk87dpvk62JNYUvKSGXZlggWNdgxSR8TqC4ijC0wLHPLg04zA3sbRXinwDTDpZZTrbE6SWs0F
	 INzD1jQm3raEDvMM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96aed35621f5-b01d6;
	Fri, 06 Nov 2026 10:03:14 +0800 (CST)
X-RM-TRANSID:2ee96aed35621f5-b01d6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from cmss.chinamobile.com (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16aed3561424-0d505;
	Fri, 06 Nov 2026 10:03:14 +0800 (CST)
X-RM-TRANSID:2ee16aed3561424-0d505
From: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, nuno.sa@analog.com, Heiner Kallweit <hkallweit1@gmail.com>, Chen Ni <nichen@iscas.ac.cn>, "Alexandru Tachici" <alexandru.tachici@analog.com>, Lennart Franzen <lennart@lfdomain.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net v3] net: ethernet: adi: adin1110: mask the RX IRQ of the port being stopped
Date: Fri, 06 Nov 2026 10:02:51 +0800
Message-ID: <20261106-adin1110-net-stop-v3-1-yuehongwu@cmss.chinamobile.com>
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
Content-Transfer-Encoding: 8bit

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

Found by code review while comparing the bit mapping against
adin1110_port_rx_ready().  I do not have access to ADIN1110 or ADIN2111
hardware, so this was only compile-tested (CONFIG_ADIN1110=m, x86_64),
not exercised on a device.

Fixes: bc93e19d088b ("net: ethernet: adi: Add ADIN1110 support")
Signed-off-by: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
---
v2 -> v3: no code change.  Cc the ADI commit-signers that
get_maintainer.pl reports once a git history is available (Nuno Sa,
Heiner Kallweit, Chen Ni).  Thanks to Andrew Lunn for pointing out that
Nuno was missing.

v2:
- Cc the netdev maintainers, as flagged by the cc_maintainers CI check on v1.
- Explain how the issue was found and that the change was only compile-tested,
  no hardware access (netdev guideline for patches found by code review).
v1: https://lore.kernel.org/all/20261103-adin1110-net-stop-1-yuehongwu@cmss.chinamobile.com/

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



