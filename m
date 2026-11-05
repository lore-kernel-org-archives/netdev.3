Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793842942;
	b=BkW0fhvVI4w9P5ELUydfd3Fg2zjpriX4rtzf2FcL2xQyyJUjn8RbkpEDJu3ixo8bMlw2
	 e/wMRsOXflxhM2VXTzhdgz7MzYHNLsC2xztA3rnc+hcMbfTD+WWaD6tiM4xRXeBUvBaB2
	 cvM6K0Fii2FvvHPjKoeAodkOKEFEiWN9OF8alH6ezTS1LGTf+IzA92sviHTK9Uh+gDuEs
	 LhB50a77yrDcT4Sjo+42xDVxdIZ55bTMBWH1RvKvM6ux9v9RBCb1GzkpICd50TdEJNw3Z
	 iPfnfZI3uIAUvX/C5QLoxC2txnChKt3kJE3goRJ3AZF6r5zbTz/bYB98qfXuZUmFukQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793842942;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=UN3g6X4eDPLqTYr3FiQiqpTRKdyzOqBdu51H2N7Y9uw=;
	b=SDtidb1BCjLqAh8SBqCdyjmxapAMcGT2xKkKx81mNLW7bwKFIweUs95skfQQqcqfu8+L
	 53Twm9zZqoyXYESTCAz2/4gXxFx4Qprfx36RKkO6p2HhcuM8D6HRDKMOFprFkJ+n1Kzzz
	 8saXWW2MtOBbT0B7Mo0kqitTnQepEtwiFkg/SidWNzYJjtzKdgJY+DZHLWMReScZXa+73
	 r/Kg3hEwNOmE7MmCA6j785ZWYkB1kZG0hBu8sZkCGunuS33yVDLwLWNyfA5ouPMcu6fmd
	 cnOPQHuNi33DAShOHF30LwULzlXrREcJBiaMLRENTESeweFSR/kW5giE3D6LnfOvpYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=EEz3Lx0n;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22666606A31B;
	Thu,  5 Nov 2026 01:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22666606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=EEz3Lx0n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=EEz3Lx0nkYb2pxQOydoa9uVTi909AQNU2kVEEwYZ2Di718lHK2omD0sydJLJw8yiFbrO31DoNErvk
	 monR4L6GiKElk6QJA/Nurkt5Bbszt05KmyLbfWcHmZAle7304XK4BGlSlDlDwiIf2y7lUg8lzejd3U
	 zN+xn5dp9V4uaAfw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26aebdee135b-dcd33;
	Thu, 05 Nov 2026 09:41:54 +0800 (CST)
X-RM-TRANSID:2ee26aebdee135b-dcd33
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from dsh.local (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66aebdee193f-34e23;
	Thu, 05 Nov 2026 09:41:54 +0800 (CST)
X-RM-TRANSID:2ee66aebdee193f-34e23
From: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, edumazet@kernel.org, pabeni@redhat.com, nichen@iscas.ac.cn, linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: ethernet: adi: adin1110: mask the RX IRQ of the port being stopped
Date: Thu, 05 Nov 2026 09:41:53 +0800
Message-ID: <20261104-adin1110-net-stop-v2-1-yuehongwu@cmss.chinamobile.com>
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

Found by code review while comparing the bit mapping against
adin1110_port_rx_ready().  I do not have access to ADIN1110 or ADIN2111
hardware, so this was only compile-tested (CONFIG_ADIN1110=m, x86_64),
not exercised on a device.

Fixes: bc93e19d088b ("net: ethernet: adi: Add ADIN1110 support")
Signed-off-by: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
---
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



