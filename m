Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763CE31A062
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776444602; cv=none; b=YMAw7OYjEprmtXqdKvtw9V63/Vcov9xSNzE9gn6FPnWpxLWk3mGFGIlhsI05DJUBYT3yd1RBKSEsaVeFgu1HbJV6I5bYdN6malSeWz6tkwiQe0/8FyN99N/8lk+8P5bKqmEH+PsO5vnwIPcfeEZRYpIac07am7GUq8+qiU2paxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776444602; c=relaxed/simple;
	bh=HI571rSP9ouwxUicS8tqgNjZ2ZL67Z7wg1Xw2tHDKTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNB800b7d5InKzG3csY06fqdQqmAF10Js/OR+HA5BVS4pca63tkt4627Z5t2ZG1yViHVov/BsVS7fwDnvFAE1cSEAv1tpJavNLG0oi+9ML+/P1ijDEaQnOeHjE/3wHQDoJqqv1CIUPz+i5aK/XJKmitt9e2QINTt1JJNLFruh3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VzxJar4p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LwFOZKt6; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VzxJar4p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LwFOZKt6"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 90B761D001A4;
	Fri, 17 Apr 2026 12:49:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 17 Apr 2026 12:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1776444599; x=
	1776530999; bh=bCklhkxAQjvvNNzpQ8bOhNMmjds+vnsY86v3Hcfu+zQ=; b=V
	zxJar4pdQ6pWiOPHLyyS6TEVP/mtGtFim19vBayYlLLPui27voRpAMXOZ+X0+j5k
	DrMox3nIyDpTofXLejkqloTXqc6PhReEAyaKIx1/HFLjLa01J0D5SaozTzTU4rFJ
	9MfxTHCwSRSbJpwISIMCTBePrwsZesPr8A0rGut81GxRyerKL17uKF1yX9nVIzGw
	N7soDr8+93S/FbgD+tt0yjCQ5ykNW9D5ZPZF8OeHIxqGMZthIKz+fJiDW8s0hJEQ
	uw/2Jjp1jqpBDGq9qhh5WM2ILsq0dqqGPWV/LHLRQXLaU7b5pLM4pARFYrlrzzG/
	iNdY2CfHUauP9yUdKF+dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1776444599; x=1776530999; bh=b
	CklhkxAQjvvNNzpQ8bOhNMmjds+vnsY86v3Hcfu+zQ=; b=LwFOZKt6ChotOulDC
	VyT4ZrNKCjBWEwRVWH9Shin6RGZYIEAPoFoTSk1+YtJsilkd/PtFSLswF1X3RnOC
	DyOEwQEM/RMJrR+lQante784WXCEjthpq0nHFhGQj4jW2ZXoiLkydvpTuDdAKiVR
	b3QtrRfM/EL1aNd4tiIDk4kOiBBa4I+Nv1cEw0/4zNhlv0EtcFpLE4NuNkwgH+N+
	Lu8jm1I59DpdAH0r+lDBfTPQaQAFKvny7tMJ9+130QtvKW5quSwqU2VkgM+2N20H
	SSCe2YSS4cG9VWAFWJIuKKqhw+gu+6zHlqAGqujuJfPm2oL2Hf2as2JnBGAXyhWo
	UhE3w==
X-ME-Sender: <xms:t2TiaXumxLw7PKTK8spWJUn8NixQrxKLrLaWxHhXTI_LC08zolVJyw>
    <xme:t2TiaTBym56mYLzxId1Z0LAQlutXYPU02XW1IjKb5rmXP_at0s290U98ffMsAoG2w
    8jHaIDtw_SaRuM-elsd8SVeh29m18xI_stHAIjQZs8f768qzdf5_Pk>
X-ME-Received: <xmr:t2TiaXXMJu5IFkVZVMUj-tEPSghndXZBhLO1O2wREwHWs2p5VkmWbJvc_r6xHaGuQm46EzxB8eyWQAt_ELg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehtdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhurghnlhhuucfjvghrrhgvrhhouceojhhurghnlhhusehfrghs
    thhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepvefggfetgeehgfeiieffheeuff
    duudegveektefhudffhefgleduvdfghfegheeunecuffhomhgrihhnpehkvghrnhgvlhdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hjuhgrnhhluhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegufiesuggrvhhiugifvghirdhukhdprhgtph
    htthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    uhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhurghnlhhusehfrghsthhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:t2TiaZBhU-GyH1zsVgN1x_MsFdrvv01lrjXcBSKXPUOARX2i526Dtw>
    <xmx:t2TiaS84fvnNbPGHEI5CC7tCRvOC0QwD8AW_Y0xPh2lXEwh8dZV9TQ>
    <xmx:t2TiaYE5d7a1VBKdEGIlT1RkaNnZvoMYWsu2RrFxhGD0N0DNSt8NUA>
    <xmx:t2TiaYNIhspAvB-MrpZvKmbUFXrp7SNeOoyckrL8yIkb534sE32Ekw>
    <xmx:t2TiaSIQnl1TrEtUAwH3iOMLPeIt4wSbkwC-BGM52GRU5djd2EK80M2X>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 12:49:58 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: dw@davidwei.uk,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH v2 0/6] selftests: net: multithread + rss_multiqueue support for iou-zcrx
Date: Fri, 17 Apr 2026 09:49:46 -0700
Message-ID: <cover.1776444379.git.juanlu@fastmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408163816.2760-1-juanlu@fastmail.com>
References: <20260408163816.2760-1-juanlu@fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add multithread support to the iou-zcrx selftest, plus a new
rss_multiqueue Python variant that exercises multi-queue zero-copy
receive on a single listening socket with NAPI-ID-based dispatch.

v2:
 - merge iou-zcrx.c server changes, leaving iou-zcrx.py changes in the
   last patch (David)
 - Refactor server state into struct thread_ctx as a separate
   patch for a cleaner impl of the server side.
 - Rework server: main-thread epoll accepts an arbitrary number
   of connections; SO_INCOMING_NAPI_ID dispatches each to its worker.
   (David)
 - Drop unused thread_id field (David)
 - rss_multiqueue: use a single listening port with an RSS context
   spanning N queues; query NAPI IDs at runtime via netlink
   queue_get(); pass them to the binary via a new -n option

Link: https://lore.kernel.org/netdev/20260408163816.2760-1-juanlu@fastmail.com/

Juanlu Herrero (6):
  selftests: net: fix get_refill_ring_size() to use its local variable
  selftests: net: remove unused variable in process_recvzc()
  selftests: net: refactor server state into struct thread_ctx
  selftests: net: add multithread client support to iou-zcrx
  selftests: net: add multithread server support to iou-zcrx
  selftests: net: add rss_multiqueue test variant to iou-zcrx

 .../testing/selftests/drivers/net/hw/Makefile |   2 +-
 .../selftests/drivers/net/hw/iou-zcrx.c       | 379 ++++++++++++------
 .../selftests/drivers/net/hw/iou-zcrx.py      |  59 ++-
 3 files changed, 317 insertions(+), 123 deletions(-)

-- 
2.52.0

