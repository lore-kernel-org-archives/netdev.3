Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409C32F60CC
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 01:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780881955; cv=none; b=J6NjGsGTHn4vR1nMQb98DmWTWoObZATEqKzEQm9gd3hpzolbpSztmcUliWdwbdpyzOObpMKDwaAk4higg5u4nyQ8z1xkus8KnCIYzA8aEcZ2ZTjUWJVEikNmT4UOrx2u2G4rOFHbzhOuelR9tfmI2J8um5QsM+0xzo9qGbjQdIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780881955; c=relaxed/simple;
	bh=sN1omTyXnnigNotHVc3GGtOQHzH/Ih5xwQyOnDATnA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OkD3Fx+vmT8Z+eJJ8K/GMe16bLWO8kZkHf6sosxO0WfJGPCNl/Rvvun7Wq0ALw6Xyhxp4C8S7bUwLKgQMeobMQQEZd8PG4O8Ef7iVV/130LIjKUAu9E6KN1s4RbzRITrKEfE8rXIsP/Y4yToV/ddw7ntGlzJtTQig47NtteL5t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bWCr0SZk; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bWCr0SZk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1780881946;
	bh=0RtRuX6Qw7AsqRudPWglNstsxLqPyoBPPmeFsv+QlOA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bWCr0SZk/P06iuKFs7mQ4x7hUbdN9twwIgbECG8qMe68luop05dBx8dCkVtiMGfnE
	 DdFIyHh7bB+6P1/fjuxp+U5lSqXTHN/boSgxiVlHjsgnt9L8+TXvf38CQO5T4j2bmT
	 YR3XROOOWBKieuTYvJzAcEPsB0GENQuChs5FYWO5+U4ZmA9iZ8DV8qpvJpBHGkgln9
	 LYUpeopba0K7gaZeQFjVsl7aG/V6wgN6eT82z8LboAWOa7slWTMaJeYmI76GAIi+Jg
	 TKjeZfVSXEJ24Np9mvJkWSPI2t7ZiyFK+M/qLd2GTSrzIh4MbnBYQlyP4W2UG92gdY
	 CCGf3HDmdT7/w==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 7AB1C60886; Mon,  8 Jun 2026 09:25:46 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 08 Jun 2026 09:25:41 +0800
Subject: [PATCH net v2 2/2] net: mctp: usb: don't fail mctp_usb_rx_queue on
 a deferred submission
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-dev-mctp-usb-rx-requeue-v2-2-29a3aa507609@codeconstruct.com.au>
References: <20260608-dev-mctp-usb-rx-requeue-v2-0-29a3aa507609@codeconstruct.com.au>
In-Reply-To: <20260608-dev-mctp-usb-rx-requeue-v2-0-29a3aa507609@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.16-dev

In the ndo_open path, a deferred queue open will report a failure, and
so the netdev will not be ndo_stop()ed, leaving us with the rx_retry
work potentially pending.

Don't report a deferred queue as an error, as we are still operational.
This means we use the ndo_stop() path for future cleanup, which handles
rx_retry_work cancellation.

Fixes: 0791c0327a6e ("net: mctp: Add MCTP USB transport driver")
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

