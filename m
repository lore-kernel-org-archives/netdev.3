Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AAA36D50D
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666316; cv=none; b=mx41oXPrcXy4L9NPkRebw9Vu178q+r4uSChqxEpJ0J04LdYutng2YmS0jSZj4r28jl3F9Rp7RyMyM0EhtsVkSIZYQsOuvXh/VUxDMpaS1rcmDWVCzMH3NDqOOymvALQiXoPl1URN1q3vKEMcCDHIgjPktCOQF4oSe69pdRoY1v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666316; c=relaxed/simple;
	bh=xIiqdMh00RVZ//1yhgjnzcGH8q+zfBtqcxNthEe/Q/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I6FXIu9zf7igD5NX/qskaK6udUsiGDbM3OrGvkuycH20WJpFX5wdG+Rh/0ApBHkYYMj2eZZtlyKuRiu4vEhjexWDMnGEk4G5nLMiXh7/Ea9v7RHmmJ6PabZPGINPGWGjq9K3B6aTfY9N9lIZcLG3SHcm8MrZOEgYMIY4+o3P1zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jMTVD3pZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Snr4f2pC; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jMTVD3pZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Snr4f2pC"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 37BFF1400144;
	Wed,  8 Apr 2026 12:38:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 08 Apr 2026 12:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1775666314; x=1775752714; bh=GFyzQ2dNYVc9bn0VVNUHR
	XxAdIt/rlVuJGlr1iHqq3k=; b=jMTVD3pZFhPSm7S8i23liWaxU7C9et5m/BQmV
	cxriSH9LJ7ypucCDN4kal2qOGy0f2pmtzPEA+eIkw7UuGALZS9kSv62zMVD4cXcW
	XvL25pCAsnmVtM7TH5ydzLzFIIa/LM0D7ktZAyvuGp7Ji4y4SK7mNtihJVU5vsgr
	yBqVJveDxh/vpN5ipfPU2DkyPXJ7vNpgjFfH8UimM3L+LmUasvUJBT78lDBsKnHy
	SFJHmGMhGQa7LkcsUlalJrCkJpzI4xFI5w47fjJVJ1+xCNyT9fFf1BjkvXdSGDbb
	A8BqB6wkbeDVFOE6nYNb6sWU8mRJdLINS8Xcw6znHosHHn+sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775666314; x=1775752714; bh=GFyzQ2dNYVc9bn0VVNUHRXxAdIt/rlVuJGl
	r1iHqq3k=; b=Snr4f2pCk1BDVRt1a0lRmKRSEmGm6euTmrNrCj5Abrtg5kJyZ+A
	qThbFKgwSbTMom/CDc25ID3cfgwH9pZ9cuzduRxgS/SrAj4XUbWHCmUIp3Yzh3gg
	sUDZGS4O+aG661SotKgoThnZllR8jGUnO0PFOjh1aPa4mYvBygoFX3RcBrSG1aYy
	dAdVd/q2mdlC4sBVNAGXI9tmy1Klof2aYpphSvLGIDCnN6Dt4+udC/k/uoz5RFlL
	VGAlx4HQ1frhC0PwLhSED17a5n0lwWW0dl6YAemEKEGBmc4KPpEHPf6y0CCaeudj
	XdwLs2b5lLLNccbRBe3Hvdmp5LdKs9xYIkw==
X-ME-Sender: <xms:ioTWabYZUVbx4yMs7OOZh2DJipNPXT8lZLAoM0f6ZtdHBF1mYG5Edg>
    <xme:ioTWaQYW_f0bRmPepSqr52FEHPnRqOTtbnWm8MeXX17ZHYCr_L-bq1_UWV6RyjfoH
    KaMR1Sh6IiMNsdfSpObt0LfpsavxKZg1ON13vaxT1sW8WEhJLvT0Sg>
X-ME-Received: <xmr:ioTWabm6XDyIOtWyuKeyTe7kr8gI8wopoGjzwKBOPzyz_C1FmBxKCUmdg0esuPyMj5vWPmWqeGZVLrfHQCHsW-S4FjRFvcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
    enucfhrhhomheplfhurghnlhhuucfjvghrrhgvrhhouceojhhurghnlhhusehfrghsthhm
    rghilhdrtghomheqnecuggftrfgrthhtvghrnhepgeegffeiveegjefffeeikeeiheelvd
    eitdevteduiedtjeetteektdegueeiveehnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepjhhurghnlhhusehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvthgu
    vghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhurghnlhhusehfrg
    hsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:ioTWacz_o7vLnMkUlW9OjCe1tl9XoNDToJalhw9MgdTgdDFDXQOwKQ>
    <xmx:ioTWaZOve97mzgzgtfxtDPo0GqenUnG8l-3pnCr4sSUdjjmQRtW-vQ>
    <xmx:ioTWaQS_g81yi3skzr0ffweJyxCwcwRrxFpidU4M0owL9L1wiBEJ8Q>
    <xmx:ioTWaXaf-kn3Bb0rfTZSvuJKacBMyjMWHn7PvWfX7TdPiHgmnVHNuw>
    <xmx:ioTWaew6s-Th4c8-YCMHDhe8J6x0n4b2FlD8J8Xs2cU8zEIqhotMoowc>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 12:38:33 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: netdev@vger.kernel.org
Cc: Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH 0/5] selftests: net: add multithread and multiqueue support to iou-zcrx
Date: Wed,  8 Apr 2026 11:38:11 -0500
Message-ID: <20260408163816.2760-1-juanlu@fastmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add multithreaded support to the iou-zcrx selftest and a new
rss_multiqueue test variant that exercises multi-queue zero-copy
receive with per-port flow rule steering.

Juanlu Herrero (5):
  selftests: net: fix get_refill_ring_size() to use its local variable
  selftests: net: add multithread client support to iou-zcrx
  selftests: net: remove unused variable in process_recvzc()
  selftests: net: add multithread server support to iou-zcrx
  selftests: net: add rss_multiqueue test variant to iou-zcrx

 .../testing/selftests/drivers/net/hw/Makefile |   2 +-
 .../selftests/drivers/net/hw/iou-zcrx.c       | 361 ++++++++++++------
 .../selftests/drivers/net/hw/iou-zcrx.py      |  45 ++-
 3 files changed, 281 insertions(+), 127 deletions(-)

-- 
2.53.0

