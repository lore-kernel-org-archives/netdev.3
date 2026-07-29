Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4393D4112
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785363536; cv=none; b=MC7ZvKl2+l1Huq36BKszllPlvSEdsKT929UVndqUah1LpUewQe3H8AlKYQLrFoFJzztW0EIG0ef7I7Ft65qKrXuBvLdEzQEI/IxbsnetKLc5kKIeb3PEs6nuCS9sYRGtPVD6DIGRPzEY/8txshAqZZodSxxLvfeS8RgZEbzRvhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785363536; c=relaxed/simple;
	bh=eWDj3kkPBFHQfyTEjMW902qILN3TU2T9Zq2jz1SA9nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1+DdBmZu9LtyJSiZTUDHb4diiAjXAb8+Vd1hCWilZTKBmhdPSl6FXli0AbEYhLLa63ACxDn+st8F0axxYxb9itpYlBZvSIMuigxrWtvnZ77RrMg+9WHRXlTvbL/pgeF2DkjXMM745TFvsOynQqb6LKflAUmGDAsO/yrlGmd6Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=XmPFkB1m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SiQ7qrm4; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="XmPFkB1m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SiQ7qrm4"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 55CFE1D0033A;
	Wed, 29 Jul 2026 18:18:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 29 Jul 2026 18:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1785363534; x=
	1785449934; bh=q7pte3tk23ZD+tvkYa9GrmKRYW53b1N7+AJyYvzvjS4=; b=X
	mPFkB1m0yS+4VZb2xQaOvpYGL3F1wNlk+pIDGpGLDtZszAjopLuyLzg14LZCvvIV
	cROreRRBUaHhkq5wfQdeWbeQ4AvzKlj5p3L+fliU+rpgPVGkaBHZeC99O1PBLtcV
	TtNr3CKivVgQ6w5HbOFRMeL3CG6PsGscVu7y42CVdhe6KZFGiYhztt16NflbGzK4
	LI6W6psU1F8pI0BDWd5MmWPYOKo0WG2HnjmvbP7cwHTzS7PSeA1hPw67e9gMVOjB
	pkNi++J1Zp2mDJMnFu63PEr8rMrKxBDYlhynO6tOifG4yFg3vaO8WddjCbWAXVtI
	5wcak1GoFYe9UccZX045w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1785363534; x=1785449934; bh=q
	7pte3tk23ZD+tvkYa9GrmKRYW53b1N7+AJyYvzvjS4=; b=SiQ7qrm4nuRORpUWI
	1TvC6VimbLoeC1Z5QDcyXY3Kea5f1xxw9qO6pa5EGvLYisJwr8R6dQkiirgrAdfw
	8XkKkhj9RsSdS3NZzWcRv3xysG261DujSOsQGYdVsWICHTJAl5l4pMW6D/nTxhTm
	Z55K9hC4wkMdoaOzBKrXvmkkEqG+6/XaNGENwBd73sMcg76XvJsN2pYJLNFQrEBE
	hVVtvlYKLTNJqZYPWcsM7bAMo1p/Gxhi6jL/Z2LCdZ4t+oQUZGp+dGHalb+Tm1x3
	8AWx7SXb1eUq4uM/FiUpSnyLLzbyRITarV4ocZT81WNs6kOajo6tpxrLFB8qn/HP
	8i/zw==
X-ME-Sender: <xms:TnxqatY2OajW76J4daUidAShfEGeDe9z7Qntph0qKpxjSsvOQ7QcPQ>
    <xme:TnxqarSDFUT7YtAbZR1KvxU3PYE8rTlq5C2GvqGTT41qXtO7n_dku5vbCSJm4u9WL
    lnxaeQ8yAFWZQD_YnODL_EqHLe2PKnfL32NXqR96EfovBAMYlQyDUT5>
X-ME-Received: <xmr:TnxqaoRef3ZU-QDwBwrjtRB_Hl4cJpX01Ncke0IMB1oEVjQQxuRpaoadyavP6ZRW867ANHAmRTPS9xr2rkUJ>
X-ME-Proxy-Cause: dmFkZTGYxrxOA2kX45FjE7uWqEUywGWHyDyBWaser44hAwDMI7rJ+0mpvuMoO5poBkjbAN
    aH3CsQ3LZCMu7NFu/0dJnJTDGw38j08D0bDmRjODkSV35yDvnTovlndu+6M21iwHBKZ8f2
    dlxokyeyx9aW+sx2aGuIgjtEskeNuIJ0u+C3A5epNRiNkvqpOySB16Nw7o8RUBTmtlf9S4
    C4vZovergqyIt9UTPPajW6CQsSxoPffB4/UAyQFOeDfXtOLCXWCBpBqN4hPTP7DXcOc9iN
    XpDV+g2WODVskwBYgMy96aTglqISzcxU2Hsj+qBq6+hkVmXvdwnpOX91vEGx1Ayp+aqmGY
    Z9FPgQU0IbalK1yYus+G3QuhXmqemVwGHDjF90ym72lQRdL36Zh8ErFCm5dn1kMD11qSVa
    VfrHoxkKXw0y4cE1PjlkngYOJB2Rb4/tWeeK4Ok+Mpfa/t2QZyDlhPuxBpeaEhNiV2wsmw
    d76muSzZ+hz73u1bT91ck4Exo9bMot0IR/G3f+XimA7XyFsq003As1gt6UxdYdisZh8rfo
    vT5+CVeJwkqOp4Z/ZUuJj8NkeIncTjZl1Ngo0N85kcPsCZHqMoQo7Vjr4nhB+H7+/T4UVh
    WVXQyHT/xvZ5iIdpm7YNU2keQ9mFXoHjmR1CaTv1dtBzjjFFAVaWSYrX3S0g
X-ME-Proxy: <xmx:TnxqanQAdwKNecIMk5tD_wJh5VCWdyCKd3pZ30A7c9egmCXXS6-wmg>
    <xmx:Tnxqal4mGS-PL0Ur5khZEy0Buj18aQ9tFHLK7G9xxAh3AHY_O6y1zQ>
    <xmx:Tnxqar0j0ozNNcVMll-8tz7ImO6DLwdey7I04MjGmYOdMM_kb_Yp8Q>
    <xmx:TnxqaoBNCvAAMpg2wQci1kCpq-V367V5Xcf0PA24tWATi1Jzm9TAoA>
    <xmx:TnxqapwDiN38WI8zFc2FsgQSBrRX5TDFM__AzURUMo8IU_5DMa6QRYQo>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 18:18:53 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH net-next v4 1/6] selftests: net: fix get_refill_ring_size() to use its local variable
Date: Wed, 29 Jul 2026 17:18:20 -0500
Message-ID: <20260729221825.42773-2-juanlu@fastmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260729221825.42773-1-juanlu@fastmail.com>
References: <20260729221825.42773-1-juanlu@fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for multi-threaded rss selftests, fix
get_refill_ring_size() to use its local `size` variable instead of
assigning to the file-global `ring_size`.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
 tools/testing/selftests/drivers/net/hw/iou-zcrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index f6a8fc5fac241..df6b622043438 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -132,10 +132,10 @@ static inline size_t get_refill_ring_size(unsigned int rq_entries)
 {
 	size_t size;
 
-	ring_size = rq_entries * sizeof(struct io_uring_zcrx_rqe);
+	size = rq_entries * sizeof(struct io_uring_zcrx_rqe);
 	/* add space for the header (head/tail/etc.) */
-	ring_size += page_size;
-	return ALIGN_UP(ring_size, page_size);
+	size += page_size;
+	return ALIGN_UP(size, page_size);
 }
 
 static void setup_zcrx(struct io_uring *ring)
-- 
2.53.0-Meta

