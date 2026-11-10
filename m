Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274997;
	b=xczRKDi8TObLX3lKuhNa8FfnrpGgQ9KIW1NHL2uSgPXyIlYM+3qawXyj4RvEwJW6hcZd
	 QOg7E4ZW3LrIwNabMAuzfMhngQUKBld6322R69Vrb05Mi1BCIj1TfWvlxLMfPiuU84kNw
	 VJtreYEMMFrLXLZP+hO/QC9YFEZsUX9EmJItEeBoFXAKijKioSHNk1A6u4nK/fv2CglrN
	 i0nBwACh5lG9L75WTTyFAAioJZJz+6A3bvC8gs2qXCULfQFKh7vu6wxlX8MUirXEyupx4
	 nhMilMKOaGSpvQ2x+zLJFpNFnrLJg3Ee+c3zzZf12H25BnQzzwaVyUDX1e8Q7iq2T7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qq24hhIrOv4Oa9z26yz4avSoOrJiFVC3JLDF/iUHN18=;
	b=q9IENiDthB+IpXMAYWcQfbTiDbWWMC7R4w+RUBHe7Dj5+r1MdIJf2r1zYyT73Cn7hRWS
	 n8e+xXF7RLVMlya+iSUYVMK9DsQcDLI8gxFWeTQcLfkYX1TxnYhZOnyUqXWTfP7X1lcW5
	 Vb1EnYHacD9N2FggLATVeMSoph4FPSJcH7HDMOD6+vD6W461KZa2MX0eoq6MSxmiVGXHl
	 clvnVmcfujNjd0bVsHTtPCzv+SvBxYjX1mnmNtx5APZmi/rV+mUdOSKhGsos17fNaFcgw
	 AMB9hbQ7oOuSYLkZucrLIODfOmMi7zmMYF2J5lvoDEItEIFQRTGI0h7t8aUqB2Y/ATg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K8W4nPDm;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E205606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 01:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E205606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K8W4nPDm
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33fb4680717so53083eec.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 17:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794274996; x=1794879796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qq24hhIrOv4Oa9z26yz4avSoOrJiFVC3JLDF/iUHN18=;
        b=K8W4nPDmmPq7/OZvmGfEHSR7I7Ei7VHcJOH5lrl92NMSFyr9ciqK7VJ/B6yIdNWhoM
         o45TuqUQal6ZLcjNrrdPkzXvKbBFgramOmD8eHR3AQjiDUm5761nYWOrGzDbRgIDbtUn
         0GxTGyd6UGifqPHUjbiQbnTHanUXUMQuZoTe4O0k+E34pWreygEhjkqAl2/WnMFalngp
         tRYzxdO60BT74aGEZ0SFIDdHZfBvQ1ksp7l37MNC0S2K2KgVL/w7ipkRH8yZmvrk7417
         soh9B80UjtxJltLKbfKHLBuMmPALmVUetLGo+/a0W7WttOaz/ZXYLcAEm1CMqRr5IEUM
         Earw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794274996; x=1794879796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qq24hhIrOv4Oa9z26yz4avSoOrJiFVC3JLDF/iUHN18=;
        b=RelispqANCN65l6Z62yj0deKtSshd7slu0PGnO70FPU0ShNhcUD7+iI1SFr367fwY3
         0CnYo3QLpYw2x2HJ+EHzBPiqDsumtcGR2X/xfpq4zqZxWMClxavVlszoWOqPLjArbQp0
         BlLMwB+KI3Fd1SFWy3DTM9YXHEh+8FV1F+zsDRn+8q1308JZcmDLo4hxLfubMfaO+NQm
         MHyDm4t8FanzVc/TrC2RXwU5SVTcOCPcUwXQGVP5PI/ymigr7P3tWd8KIDgbVUu/V8wr
         z2PQXCi77CL4ucsEysr4thOBxR0V82M1Xql7sCdA2C4eKhXdDfDQJkYTsJyLXUWKg9cf
         ayCw==
X-Gm-Message-State: APuU4Z/ldTMZsXYWgt9B4aK5oubLEuuej0Pih8jiKmjBTeCg3FqygBGW
	HSX9UcVks7nGfqjuhlJBT7sVYdA3GyodFB0rkBbVWdVaLV+7yycctysyboqFkTmH
X-Gm-Gg: AYBFou2mNEyrF8dX/QhJe7imJhZdtmxWxlnNb7x3L7RHUdHYL1GjALkzpuiSsG90g2h
	wKeVmTyjBNzcGSXvnWeEFwmRz7Nrey7qMh6qxdYdVQO0/UaRBx4nkZT71XypfB1DMomlAb6JdwB
	jwcuU4MojjNt6JlDxPQj4nBJomnI1H1NoSFHo4pIrY5wFQq04fxJAO/2q1q/LIcF5CdaS5Wncnw
	q7bM9Y5AppKFHfvuTheK+Ep42bqcPPzi6W+i60/qt2r7PM3izqw7btIDmUa7mJbcfqWRij8hs0h
	V+vB7rMsoff7fLa3INqlqMQ5VE7eXPmQtSw9QYeFT7qwQDlDNOePFtfYTeqolkXqB2iVvExxloB
	b/Oi5lZ0kW+EzEEHn5ICsXFeQF7/ZVac62WpmIzfKRHqXU76kSpYWvSmf+A/CnkbR4ZZSjqBGPN
	fPqL8DYOqImkGbbYhRtosZgSIxJtRFfGxUZiKfX7F0VkYlnL4pFVK8NQJwCY+93Z3BjBKtpkcLv
	OdM2V2T+Zk/Z9ZUKGvETtunY3SaTuA/TlE6Qk1ASdxCiYfFP/BJbUygsBRnfrPXztAenUCUNBRW
	N4UWAeIsm5QpnVwaNsjDbWASxmTcSjswxjED3mUzFlrNNvfu/O4dmr7oPntfv04KQLwwb3GaAT3
	lakoJb0H2yemFfFc+TmW4jw2VmO23hQI6vPvuHeBwHD0PoJKdPGHs/1TGJQPktuAgOtGPrKzP08
	qeHp6bs3oLDNSMfXxJwBjgbVA=
X-Received: by 2002:a05:693c:20c7:10b0:35c:707b:acba with SMTP id 5a478bee46e88-3751c3461ecmr1500001eec.3.1794274996258;
        Mon, 09 Nov 2026 17:43:16 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306casm2021599eec.9.2026.11.09.17.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 17:43:15 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jeff@garzik.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] net: ibm: emac: fix MR0 write in emac_rx_enable()
Date: Mon,  9 Nov 2026 17:43:13 -0800
Message-ID: <20261110014313.1586633-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

When an asynchronous RX disable is still in progress, emac_rx_enable()
waits for MR0[RXI] with

	while (!(r = in_be32(&p->mr0) & EMAC_MR0_RXI) && n)

which assigns only the RXI bit to r, as & binds tighter than =. The
following write of r | EMAC_MR0_RXE then clears every other MR0 bit,
including TXE, and TX stays stopped until the watchdog resets the EMAC.

This path is taken when RX is restarted after an RX descriptor error.

Replace the open-coded loop with read_poll_timeout_atomic(), which
stores the full register value in r.

Fixes: 1d3bb996481e ("Device tree aware EMAC driver")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use read_poll_timeout_atomic
 drivers/net/ethernet/ibm/emac/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 1b95b4d5deff..0311131055f7 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -24,6 +24,7 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <linux/iopoll.h>
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/etherdevice.h>
@@ -248,12 +249,10 @@ static void emac_rx_enable(struct emac_instance *dev)
 	if (!(r & EMAC_MR0_RXE)) {
 		if (unlikely(!(r & EMAC_MR0_RXI))) {
 			/* Wait if previous async disable is still in progress */
-			int n = dev->stop_timeout;
-			while (!(r = in_be32(&p->mr0) & EMAC_MR0_RXI) && n) {
-				udelay(1);
-				--n;
-			}
-			if (unlikely(!n))
+			if (read_poll_timeout_atomic(in_be32, r,
+						     r & EMAC_MR0_RXI, 1,
+						     dev->stop_timeout, false,
+						     &p->mr0))
 				emac_report_timeout_error(dev,
 							  "RX disable timeout");
 		}
-- 
2.56.0

