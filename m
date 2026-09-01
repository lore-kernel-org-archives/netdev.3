Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D32253B0;
	Tue,  1 Sep 2026 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268916; cv=pass; b=BkBWaUQqTmoE4Gw/m07H15eFDJYLILguBMopSb1Grspue38BP+uTW2GEbP28j/LQuh/dvGaDlu0EfWEZfM4YqXU3Ud6DwZZ49QA5X+ebclN+93kDPOTENDrQ4K7mILNZr4NTdZ3Q/Q/TBERb/gKdsA9rHmtcSjdrvPWPKlLQFfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268916; c=relaxed/simple;
	bh=Idzz+qs8f5I+xqu9a7wEtufSLSZ3EedsBKyqg8tf084=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q8DvejFiPWKHbLVImMK7JkW9z9tcdLgsNLOcKpi/zUrG9LzLZpmNSYIdIuQmni0hv2S8l7ExGFTTrdCmvcoPrQNxNKwnybUaVy9cFmkDo3kJ9Hd9Y0tqCKPlO/fM36gn4C6wSKpe0ddXOPbpi/MhtUkuLnrvIOBC/tSwdaN7JPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=JonlzZNp; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="JonlzZNp"
Received: from mandelbrot.. (xdsl-83-150-90-33.nebulazone.fi [83.150.90.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hZ62h06q6z49QNp;
	Tue, 01 Sep 2026 16:21:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788268908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b3qERqGgzrD2T4aK1iBclz+AkDg1ZG2HnPrGpORQgtc=;
	b=JonlzZNpK6bkbw2AGi1UG8US+bXxlzBWn+qA515cevi+GFi+rwKC1v+DjQrm9K5x/euopk
	KSJSF4opgQLH4FD329cIGDEOOk5wihhFSld2kORzmAntwqu1MNd89RBKltfNIiWoaGeqoI
	t3TpA4k+FlvW+HmAAn+gctKdM2+/CMpMfSJuuuvQuEPFwMGL50XYxbmsMwLorWAd3X+vc4
	IamyUxLrjqSQwdzH9bZEbv+mMZiMtjZ05nY29R6kLVYEnOIEpOVL7alnSR5duAQJFrxLWI
	E4PR4VljSYTbLhLRyKcJSS0Ep4UiX/+WRyKRnZ22+N1wkxzeCzgO2ZiwyoND7Q==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788268908;
	b=g1Q0RN/8Ct3Z1jiLfzqRGk+g6utbX8NfMXCis+FpEE2OM9+Ds6uf+UQdIsGaC+8nSY6Oe2
	9D9NRSyf1da8Q3EGo4S3pa7jupBic3XPuCZgwzaQKwW3BoItW1FapuCumoKSTH2i/FTRel
	P485hyXA8D5AngQPVlZPK9ywWmJQXNknUxB5VV6zMKUZcBobdUExFvSxri3I+kXfCnuSaH
	ZKBoodu6Ri3wmLo0yWFfot3AlYmCA6udjv5krTjswrh06HFVNmqz1dM6gL7LIQML8OtnSc
	L9kUuCib1YOm3nsoDOQ++3maJ3jwdUz9kPBBjp9Wf0prK2EHWIe7QupWsK4Rfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788268908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b3qERqGgzrD2T4aK1iBclz+AkDg1ZG2HnPrGpORQgtc=;
	b=T9aH6uq+uMjqfzoYUbYIIuveW3WHdu7ISpcnKlZWtjcy1a5Z9zoV8hjINY45pr9afumTGj
	Opu+PFQFSJ03sBWNiCCGmDTebAIlg7DaPfV0ePe1W3wIn9ppSorlUnaTiRZf/CoVR02yub
	5EDwg1no+jI9k21vswvQDrAQsWM8uNjvyBjfWRuRraxYeI2bTuvX7sauzi6qFu/ELQG+yX
	5K6IzNYDg4HO/1yCEIzV305fv+nk5xL7mzESwa1jGdjfF8eJZI5nsbvTKbVltUxe7HiYTM
	boQS7E1xNWgeQ9n4btgI8CltPyxcvP1CT86cdVBq0L/l627aL/v84kjML+eLXw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jmtilli smtp.mailfrom=juha-matti.tilli@iki.fi
From: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
To: linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Andy Gross <agross@kernel.org>,
	Mihai Moldovan <ionic@ionic.de>,
	Denis Kenzior <denkenz@gmail.com>,
	Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 10/15] net: qrtr: Drop remote {NEW|DEL}_LOOKUP messages
Date: Tue,  1 Sep 2026 16:19:29 +0300
Message-Id: <20260901131934.225991-11-juha-matti.tilli@iki.fi>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
References: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Kenzior <denkenz@gmail.com>

These messages are explicitly filtered out by the in-kernel name
service (ns.c).  Filter them out even earlier to save some CPU cycles.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Andy Gross <agross@kernel.org>
Signed-off-by: Mihai Moldovan <ionic@ionic.de>
Signed-off-by: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
---
 net/qrtr/af_qrtr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index ccfa3ed33a996..c139786c56f39 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -621,6 +621,11 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
 	if (!size || size > len || len != ALIGN(size, 4) + hdrlen)
 		goto err;
 
+	/* Don't allow remote lookups */
+	if (cb->type == QRTR_TYPE_NEW_LOOKUP ||
+	    cb->type == QRTR_TYPE_DEL_LOOKUP)
+		goto err;
+
 	if ((cb->type == QRTR_TYPE_NEW_SERVER ||
 	     cb->type == QRTR_TYPE_RESUME_TX) &&
 	    size < sizeof(struct qrtr_ctrl_pkt))
-- 
2.34.1

