Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296855;
	b=KdIOkToEWxY3Qo6TxpExwAsPWUvvMSDnEMc0nAosbBBdtz1a6A0IrHsaFXj4Tb4ZsnT8
	 Yq8vhWWQKwynbNAtTZ7JZgoKzg/ijGeXGTItVE6umKCE3q1ZHTkeqVb48h5uIxihgxq95
	 w3uNKXOacUSyDmBx9r871SR6gK5300HPD8+bprfw8tOnxFbm6bDAlMOk8n+OqQKdEVNRq
	 0buZ38ABp7GM6+4gTayQK1FE1dUzRs2gbQbHlbOChAomyHHp0JjiJy5ZUzltrGuJF5XO+
	 2RB3gkDiffELYJX+BG76QrwSN/6HMbVJ2OlLrwHGvL0RkAJd/l6Jis3D/Q5/10eAc4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/3Sq2/ww2JZBxSThzLCnuhquAYjqFjF6zPeEOEIafZ0=;
	b=Hxk/CJwWzHTfcz5dOaREKNEdjrJxf4jfFKMIzDswEEvdHtTzF1qhzFQozjsHcpHgzJaa
	 hAAQumVRU8KnIiuLqQugsojArAkx2gD08i6o0AJASbpbKU50gDW8fYaWoa0pWd1ZEGNB8
	 9/hWnKk4/17q0FR8uX4mUwOUuIV2kw1XVzAqhHGRF1/Ch2Bn3jpcETXzlBhMa9/JIDqKf
	 2znTsZZdI7UCnEW+exDIcliYSlwP+L7Xo5Ne/00KhdcVdSJGDU47JPmwW/SPK5U7QWwHq
	 BfKFPLFuruO6pRORgJ8K34wCET4wf+McPvcOfdiIvFwtDuUH3PKLaCp+uMX1X2G/rIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=IwvAaQ3r;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761D5606A31A;
	Thu, 29 Oct 2026 18:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 761D5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=IwvAaQ3r
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jFsTx5bSKzlfvpy;
	Thu, 29 Oct 2026 18:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1793296848; x=1795888849; bh=/3Sq2/ww2JZBxSThzLCnuhquAYjqFjF6zPe
	EOEIafZ0=; b=IwvAaQ3rebFE3HXygOrKWFS/MgfQwGfhmzzznU4Fkpgei1kTNJQ
	+ZilDB+aYDyapohYzc9M1kPFpTtaZ7erpmdp5wzHLuSE1nrL9HBC0fyec0vj9eWz
	joYjnYc8S8+3xH7aeRMAnGG20W8pGZMaTbSuXEM12saSY2ut000AYO7+BfW+v1pI
	01RtMQ9elGYEaegAOmC0XrBspTbGqfVrDe2fILSa6x1/zOdweh7CgnJ9IpsOwBOM
	bgNpMIuQH1s7F9t7ijozDnElwi9oGxc1gBUcqSBFZWOl1mbKnMzw85Oit9d6RA0l
	TBzOTz9V2inKdKwh/ykZeSOffNPyZi8TSdQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id AzVGFzbamnp6; Thu, 29 Oct 2026 18:00:48 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jFsTq4D84zlfvq0;
	Thu, 29 Oct 2026 18:00:47 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>
Cc: Leo Yang <Leo-Yang@quantatw.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Leo Yang <leo.yang.sy0@gmail.com>
Subject: [PATCH v2] mctp i3c: Fix locking in an error path
Date: Thu, 29 Oct 2026 11:00:39 -0700
Message-ID: <71e0a880ffe7a83237e501b07884bf54343e76ca.1793296780.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If netdev_alloc_skb() fails, mctp_i3c_read() jumps to a label that
unlocks mi->lock although that mutex has not been locked yet. Fix this
by returning -ENOMEM directly. This bug has been detected by the Clang
thread-safety analyzer.

Cc: Leo Yang <Leo-Yang@quantatw.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>
Cc: netdev@vger.kernel.org
Fixes: 2d2d4f60ed26 ("mctp i3c: fix MCTP I3C driver multi-thread issue")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
v1 -> v2:
- Return -ENOMEM directly upon allocation failure instead of adding a
  free_skb label.

 drivers/net/mctp/mctp-i3c.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/mctp/mctp-i3c.c b/drivers/net/mctp/mctp-i3c.c
index 4e857dd5df64..5f225999d715 100644
--- a/drivers/net/mctp/mctp-i3c.c
+++ b/drivers/net/mctp/mctp-i3c.c
@@ -111,8 +111,7 @@ static int mctp_i3c_read(struct mctp_i3c_device *mi)
 			       mi->mrl + sizeof(struct mctp_i3c_internal_hdr));
 	if (!skb) {
 		stats->rx_dropped++;
-		rc =3D -ENOMEM;
-		goto err;
+		return -ENOMEM;
 	}
=20
 	skb->protocol =3D htons(ETH_P_MCTP);
