Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793044774;
	b=tx7s6erJAj/31pZdC4O3MdepspzxLC2urXRZ+p5HaGFIRB/CWSZ/i9Wy4McVwiMHQyM4
	 A9yKhLWGTaC8V5YVxQt6LouxrYbmME8Ti8itP4D2vokVnNLcLes4+A8/AfC7+qJcZgxVQ
	 JYOEAf1QIpET2fU1OCdk28j4OfArvSUwY4JPVwxlKEM9AIDzy1LnY92qaDnEZVbHwR/wT
	 CYJdMqQsxG58b/pVprwthyUHE5IsNQxfTbHXNtS3jWw1QhszHlgsY8kz9Wntge9Rd/aof
	 gHsxX5sUF/Q7NotE6nJIcIXFJ97HpsJ1cls+MhSXLmdHtYgl+9APrHG4qQDN99nLTvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793044774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=He4ybGCTXFtdd1Ylp4eCMHA5vOeDumlalP75v8zeP2E=;
	b=p4VmBbpHXC06VBKWQ7pfa+cTsIiiolfwMTQwz3uSInmBLySdJE5x/elSEEUfbHXF94rd
	 WBXZ1i3NTzM1frWLRjOECifUq8Z4N+qPnp/GU/I7jngrFdhmV/YPTtQf2bm/hNJsMySwJ
	 xmYukqTC3NCvqNJvTarGzcOcsYBMOvqiLwNbIitMRHNmbIJAISg3kdfTJ+jRd3Svc3lM0
	 OYCHBdENt8RF0epMh3votWdQ1Y6eWteih+atQal4aVpFVJI4zVXJJAwqKZaoghqUTa35i
	 IhiDdy//maHo9zu8bZDQUXkOnXGJn8E3wWXnppkAYwLLialA5rBOkuqXmeCTKLPE1jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Tm2c1gye;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2553606A31D;
	Mon, 26 Oct 2026 19:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2553606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Tm2c1gye
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jD4GF0XsTzlfvpc;
	Mon, 26 Oct 2026 19:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1793044768; x=1795636769; bh=He4ybGCTXFtdd1Ylp4eCMHA5vOeDumlalP7
	5v8zeP2E=; b=Tm2c1gyeGJBvojFlei1jLdPt33E7yCVVnShNqdypc1KnM7qn65j
	SzNJhOPxAcidDzUGJObUSPEpY71lp4BWLZAxAknpL8tfsaBWlGtDhc1TShGRJ49L
	kwOVEHdEWqwDSMRk3bKQnTkRa4ypz9SpnnDaQZ30RmL64MJi0ksqDsVpDwLWPjX0
	mo3Rs109WqYdokLArfdHg3mNwH1nf83nD84SKb+ilwBzZCtFK/BT4WS84UiICfDv
	p0v5BT43xwZEObgChwzFFBzYuhT3D41eB5ZAvzXo4g0YrSv9qZZUqglRrwKs4nTt
	fcJ8cJxG5hKxQPCPpevQOGyMXc1eyotUUPw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Ec3UpxLHqCzg; Mon, 26 Oct 2026 19:59:28 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jD4G73HMrzlfvpT;
	Mon, 26 Oct 2026 19:59:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Leo Yang <leo.yang.sy0@gmail.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Leo Yang <Leo-Yang@quantatw.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>
Subject: [PATCH net] mctp i3c: Fix locking in an error path
Date: Mon, 26 Oct 2026 12:59:19 -0700
Message-ID: <58aab766b8ce35d1a7ff38880853cedaec244bf1.1793044759.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
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
by jumping to a label that only frees the skb. This bug has been
detected by the Clang thread-safety analyzer.

Cc: Leo Yang <Leo-Yang@quantatw.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>
Cc: netdev@vger.kernel.org
Fixes: 2d2d4f60ed26 ("mctp i3c: fix MCTP I3C driver multi-thread issue")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/mctp/mctp-i3c.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mctp/mctp-i3c.c b/drivers/net/mctp/mctp-i3c.c
index 4e857dd5df64..59e7bf56fce3 100644
--- a/drivers/net/mctp/mctp-i3c.c
+++ b/drivers/net/mctp/mctp-i3c.c
@@ -112,7 +112,7 @@ static int mctp_i3c_read(struct mctp_i3c_device *mi)
 	if (!skb) {
 		stats->rx_dropped++;
 		rc =3D -ENOMEM;
-		goto err;
+		goto free_skb;
 	}
=20
 	skb->protocol =3D htons(ETH_P_MCTP);
@@ -170,8 +170,11 @@ static int mctp_i3c_read(struct mctp_i3c_device *mi)
=20
 	mutex_unlock(&mi->lock);
 	return 0;
+
 err:
 	mutex_unlock(&mi->lock);
+
+free_skb:
 	kfree_skb(skb);
 	return rc;
 }
