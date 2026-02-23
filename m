Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0A537997A
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883438; cv=none; b=e6Ulj9OP/oV5J3NwpuYKIjfp5yv5DzUuA50gaUVtyadOF2d8yufaGVCAuuS9w1Mb3s1ByvLO54V0eVoLSdVrSa9th67f4W7MsPKy9ARMVDt4H+NNDs1iBPevaIt2rD/aucUE/7yk/a1D64t2PsMue+fQqwmjHNl/2p0XqiC/ccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883438; c=relaxed/simple;
	bh=ejjkNyAsenyYPXT4SGcL2iR6nR3dDzwlXuJyhnIVKU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLX4eifmWL3lCIG7qGslzuRwUH7C2IxOf2bCRH4lMYzZUVPpKEv7KdNeEz3OlsyePB2TrsOnD0bB/B7OjnkMoFo6uKFy9pDsbqilXqpwS5Jr16aR/pq26moFWuqGoRxHVQpNojw5lE7LGQVtNoY9hzTlca3o2lmq0twQU0JxNnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=D0CQIfMT; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="D0CQIfMT"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKZKS65DQzlfddn;
	Mon, 23 Feb 2026 21:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1771883435; x=1774475436; bh=+j8Ao
	xbckmJCrE0rFA13B5cbwb7QLIwbSFnwUCB0UmI=; b=D0CQIfMTb4dyHtjpy/cQu
	ryrz21Hgavuja/8bnto95Pro5N7xpNw7pJDse+BsYU4Bc+LKnO9itNEGGxzNCLpt
	Gc89BBRRhUFrsF8IjSS3EQP5/Z/yWEsh+3yMR1jhvOIvowY+rM7ZUuOeeXGUD5Pj
	8buP8whRW7RLnzT0bHjX+cRWODeyLFsgJv4++UoNzPIN1Jc0l35T09dQZuxgXGmU
	f8up9v2rG2Pv6EGXSwWad+Vz6vcmHDd5htOpclkSGLYLOYqyFjda9aLME68i5JO2
	DV2rkW4i3u0XHyMt4RKERFv38CPQ7Wn1NxFWc7D2OTYbr/LHqBMx3aoTAvwpDRBk
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id H2voz6KcMb9f; Mon, 23 Feb 2026 21:50:35 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKZKP757HzlfgPY;
	Mon, 23 Feb 2026 21:50:33 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Leo Yang <Leo-Yang@quantatw.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	netdev@vger.kernel.org
Subject: [PATCH 22/62] mctp i3c: Fix locking in error paths
Date: Mon, 23 Feb 2026 13:49:10 -0800
Message-ID: <20260223214950.2153735-23-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To: <20260223214950.2153735-1-bvanassche@acm.org>
References: <20260223214950.2153735-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only unlock mi->lock if it has been locked. This bug has been detected by
the Clang thread-safety analyzer.

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
index 6d2bbae7477b..d4a29912c7e1 100644
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
