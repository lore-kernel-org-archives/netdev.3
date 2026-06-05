Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0AB30E0F1
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644305; cv=none; b=qhwfoVg81sSWpIwUJESb6+j/L5GwtVG8ItYIgndL44/9HmQwWBmHStJkDK7Di+RH8GgWd78JCP8BCmPg2BxAm+XJqvKadABYAaZWFMTl3w5WM7hDT5TvzeQIQsDMjjSF4QxT5Ioc5Za7t3Q23sBKRHEvh5i5DOjiKHLYpIqeD28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644305; c=relaxed/simple;
	bh=y7hGNfYe/r38NTR187HMfPhOnjiEH3sU1UAsPHhwIa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jbUYm+11aUl69r75OJ7Su32ZlUUDIExV7gip2Z1dT+2oR+Yga/L2eXhPkDp0rRpGk78SrYPdHsiP77Fp30jHAmJ5hKGkXUCtFMEReVUBwSC6tt9MiFCjntwNqYeehB11e51wIVahlLdh3u4zTHP6DmXTbYCm/qkDTvQnI28FZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=PJBjQJFw; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="PJBjQJFw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1780644301;
	bh=QVG5OEVykWAvyDWfuv28vZptEqF5LhbKDk8XSMjsnfc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PJBjQJFwjefWI7qvSsmy0BSrgXyfh96kuL1gUqb42sqhJza1oQPhlNvT2Pxnm6aBM
	 9SzcOhe+o/zS0RqdKTbLOkVAtCDnNhq18/W9eBtgVP83rD0uJhmgetdf2BffBwqKAV
	 PF/VS0Zu0YdRLCy74S3kXqz72o2fNTWKQjJl1bpZAMQevKsuXvfgblkMkGvXwutj9s
	 5LNBcVA9iGaXgtHHWsRhmbNPhR0/nwigphSfZmIRsGR/QtwGfSUhLQsWJleIoiOEfI
	 Vf49uoX9elYyrtT+iQ6pmunf9YTrbaRQhMrcZW/RNVDPjGwjnlPbpmgZCoujHbkFZ6
	 M261uRm5Ec/mA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 5C7F165094; Fri,  5 Jun 2026 15:25:01 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 05 Jun 2026 15:24:15 +0800
Subject: [PATCH net 2/2] net: mctp: usb: don't fail mctp_usb_rx_queue on a
 deferred submission
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-dev-mctp-usb-rx-requeue-v1-2-b86993d01ac0@codeconstruct.com.au>
References: <20260605-dev-mctp-usb-rx-requeue-v1-0-b86993d01ac0@codeconstruct.com.au>
In-Reply-To: <20260605-dev-mctp-usb-rx-requeue-v1-0-b86993d01ac0@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>
X-Mailer: b4 0.16-dev

In the ndo_open path, a deferred queue open will report a failure, and
so the netdev will not be ndo_stop()ed, leaving us with the rx_retry
work potentially pending.

Don't report a deferred queue as an error, as we are still operational.
This means we use the ndo_stop() path for future cleanup, which handles
rx_retry_work cancellation.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index cf6f6a93a451..fade65f2f269 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -154,7 +154,7 @@ static int mctp_usb_rx_queue(struct mctp_usb *mctp_usb, gfp_t gfp)
 	if (!mctp_usb->rx_stopped)
 		schedule_delayed_work(&mctp_usb->rx_retry_work, RX_RETRY_DELAY);
 	spin_unlock_irqrestore(&mctp_usb->rx_lock, flags);
-	return rc;
+	return 0;
 }
 
 static void mctp_usb_in_complete(struct urb *urb)

-- 
2.47.3

