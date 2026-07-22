Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3592043745E
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784752939; cv=none; b=K7uQOq/kqSfDx/MvpHJdlQOM7H4VCIxE2428Pg9usA9BEI/2q8kk8bzNGE52kP7Gfb9oMj+BvZYgVCywkbuZqwuksPASXIEWMv4wZsJ8zt4kgFhRu1ZiFlepbu8hqaWlwmOSnrBIgtLFBBda/ucRS+9ZKgUsEjO39IC509jKJQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784752939; c=relaxed/simple;
	bh=eWDj3kkPBFHQfyTEjMW902qILN3TU2T9Zq2jz1SA9nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDrNwSql+GxT76gg1WHEbmRCBQSO+ByMbPArHnDxLI6B/htSwJqXllgIzQwstQtRMuw+CtGM8iVzwP/uoSG5Mdm2qUvOxpSPo3COMjpHo7UwgzRnAZoohbdjuXqEpA3QmIWQc2rrE4CAPFlt+/YyYjMRs5zpuHvGbiTPyXxzlNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=NHCuue+i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jny3d8eY; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="NHCuue+i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jny3d8eY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6EE397A00C3;
	Wed, 22 Jul 2026 16:42:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 22 Jul 2026 16:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1784752937; x=
	1784839337; bh=q7pte3tk23ZD+tvkYa9GrmKRYW53b1N7+AJyYvzvjS4=; b=N
	HCuue+imGZjwNBORBCiB3Ov7xgFMl4uhNdE4exmmzzmqKKYAhmwypFhLLwADf8dE
	hdIg2qK+YaMqMR99fsBL1l8K0v532zTl7CQoAg7RYVgHlrfMiRp66LDgRcdKxmnu
	GXG+sNFBGUro7/EIA1IpQhLB5OLpwBNOyBaJQ2b+tBPOTbic8Znok78TI8lWUeWO
	vHHgYIjAcp1cfquM70Zo4W69TX9DWBOSAGvlviCtFCFUOuisiaEehFQi4CMbpH6U
	D76tetPm4NXblLHxuPwCdEzx0byRLMO4Iot4hqF1qqAUr1T0n1GNLNkmlV5XSnBx
	6SYKolRPquAl/b8bq7vHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784752937; x=1784839337; bh=q
	7pte3tk23ZD+tvkYa9GrmKRYW53b1N7+AJyYvzvjS4=; b=jny3d8eYLr3aKzQTM
	bQlqNvhWp16lnrxkT19yI/C7c9hIumrYGw4gnC8BFV9aHa5mUEAAnMZzqSfZjeuW
	ipsiILABXK3/CWMadPrzplHUKiNcbIe4L3JhDmp+Y/C9FC50YXpGS7w8slSFt1oZ
	le7k9hUy9aYU0VXapCsOlUeUv6aEHgRg6lmoBWyRvDP4tlBEmrUdVHmtakrrZQYt
	sH2ukilHX2oCBiTN5VKh7N0rkVvTzIF6kC7JcPqMaUQIxuhGrIn1SdEbBtw/O3Dn
	u9Mgizl+7c/rJs46ILbsxmnDaEKMfNHj82TArdfDDK9w2O20REIfDKD8L/QppW3I
	7dIEQ==
X-ME-Sender: <xms:KSthamXT57CTNQem9YxAIFAkA-9UC8cDY4l9KhRYGoY83oIXBUUhtQ>
    <xme:KSthapem6iyQzkyawsBHJXTG4FG-bU8FLNIzl_j-U0IFdurJ1e0OFh0MBF0eclLze
    IUB33oR1Pr9E6gBGIbwL6FAL9UnNnXRrWI9RZLI0knRbVAIm2VQ50j0>
X-ME-Received: <xmr:KSthaisr2xmeCS1lK0sYtd3w6jJ8WK7yFROD64XRiC7pHwxXN-OuF71ZgjabygGI8jtt4p1wYWSpmSzF5IWl2w>
X-ME-Proxy-Cause: dmFkZTElkBiwG5cIhOPJZ8aQ7X5cAdGPqZBNVDJCUNRy0mD9Oc/iqcQxNWQRTcVWxNeXeK
    hb9mo56V6acb1wu6pEODO1csMhIVfAurfOZMPNWy09rHnDjuuGiQDfMPUyhefHkcsZPJe2
    QDzpYB3UxcgUVIhu9WlP4w58PjwxegjsBXRyLZMwxik596AtZDOdsXNAXjPgVLBzhU02GA
    uZBPQ9pQLNio4heUffFko5NMQNOXT+MSEpF2OYZBbYeLH8/tpcCqBd/BzsEVtbeKr4o6bL
    znxDXK3nG8jddPlBMyzWw4jQEkaRCa6dbQkY4Z5XVuLTmS87+B/SQ0HOWCQIkXQJnCZtTX
    TfRPFxOGXhYNXQIdsn8WDxqvLgLBIKSj73hA0oOaeoA9dY3AnIYBUljw6fBUiuwKdny1Qz
    oZuQIzi6s1syRl2V4jdzQkXi9+Wo0UFAQ3dsTXnvvDXpXEswDqoqBzDmOOHTzTc+GdgEjA
    ChY2QlP9t2iEV76ObezpPOgyVECw7bTPBjGElE/wxaiCpTC+Vg7xTQlYNF5R2lwa8lUhfQ
    AJde+O8oIGTVP5/GODbeL2PYbi0QYbw8sFPSUykCuS9x2zQF6XuqnO2Dp04/by13q6PtLg
    doFVAzLYuZVm5gsWJgBHIxeuNH/OrtOI+N2/QAvk3/IPWqC8kQq/VwUFMhxA
X-ME-Proxy: <xmx:KSthao8tX4YBieBvQngj0Wc_tMCzp5zl4rO22mgHUzHuAQTZpGeRUg>
    <xmx:KSthat2cXvAvBCYeWoKdSCK_3vlOeUtSEE7ySmrv00ViILhtLQLscw>
    <xmx:KSthatCx756KYZ8qgZJbhP5gVWatZ-FQ-dCaFpBDohW9L3pBZiJxzQ>
    <xmx:KSthapfdyKdIK3gPO-hS6dyUqVWvV3dF6-qdbqiU9caNJmP4STkiow>
    <xmx:KSthamS9MkSNhzQhRAsWBucN-HAC8LmbtnnsZIEFA2R0Oht00D5jCjVl>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 16:42:16 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH net-next v3 1/6] selftests: net: fix get_refill_ring_size() to use its local variable
Date: Wed, 22 Jul 2026 15:39:45 -0500
Message-ID: <20260722203950.58550-2-juanlu@fastmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260722203950.58550-1-juanlu@fastmail.com>
References: <20260722203950.58550-1-juanlu@fastmail.com>
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

