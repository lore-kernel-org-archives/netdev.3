Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607B4227B8E
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887927; cv=none; b=WE7Qmxg5hJRULTZiyeosIL0unaqP3EB0KDINfQsY538Naq+CgLLvkRDavVUT1CJcBLyQKIbiPV4DMx9G3pNnH8gLsveA+yjVfmM/yNvkeySEpUvcF6yndqYpE55G4wFoM3R5F74+jCsu76gCIwvNq06fS772UCHSR+oDyP8JD5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887927; c=relaxed/simple;
	bh=r4FsRjexr7euX5Evdy6lwtnQlBtsUD/pdbU33VZqjEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KCA8XAgEbp78Yc8LPNpPqAgohqF+cw8NSLHZw3kTp34gNL8m4TznEUz5wREKzEZwSUqnjci24sU7vMP13rlQqR2uiJSGiqexRz3l9kH8mW5ecovu07TldsJoo+knWgeSwDS7sik/rwM9v7rilEunKS2l8edAR1oXnzjGXc15vPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=DdGhZq48; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uTP3hr/T; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="DdGhZq48";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uTP3hr/T"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DAD827A01C6;
	Mon, 23 Feb 2026 18:05:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 23 Feb 2026 18:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1771887922; x=1771974322; bh=F9O0wyEhxx
	HdXT2qujtccl4sgZztF+dAcMsW47bsric=; b=DdGhZq48IIWEIqu6muKw1jARi7
	PIVh1ud9y2vtmxgd5qWOgI3qATsCECv370iLyxB9ub51kZx5PRYB8qwJP922iilF
	1cHlBxRzveDf8HZSb0NgO41Bj5/0DQmKeauybf4S4p596+PQeLFd1LIjj15QY9/N
	Fspkuz26fzWSIRzaneLIrDT+7nSLRhMqOFejtGb8CTY6lk+M6NXx5gumvCeAft/q
	SQZI4nxYSCyHoKF7DPvej/zIQXbzymNR1ysHQGDcWmVwGEK9Wl5YInALXsD/J1mF
	v5lm2TiwoTWObQMLDkXIKjmGhg2oky8RrkRpF7hrOwVGYmoqgPGoSEwK7Ang==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771887922; x=1771974322; bh=F9O0wyEhxxHdXT2qujtccl4sgZztF+dAcMs
	W47bsric=; b=uTP3hr/Tx9V9tHEFCaOgpIKmJE2F5/IlAry36rax1CCGeNWw5oj
	RGNxTLrls8SkCu4C5GKPRyty3jfT+hxmda2sWHppGLbbG+KkRXptLtQG5Jjduz7q
	0qczHsZFQ3RprYwq/v/OZ9g9rq+NbPH4k8dIDKbas0YNJ9f2dRAgDzlqjSCqz8yS
	09ojfiWd5FMsgIpIKDoKF9/WiHGxIWVZ6tCKgvhv1+3JiyO57PzmH/JOF+jTzd1g
	NsPWegXwLK0NmjWFiTuVuWkQ1Meq/84PO4CcD6+y2UN2IaoFSkBeaNRJvCDJwDP+
	lbXwVgiwBCpjiRLDqIa8WwBgNcTIcXVftQQ==
X-ME-Sender: <xms:Md2cadd9Y6iS_O8e8exq3MSUW2IYkIUNUTWk3198fi2v74IBnJpEug>
    <xme:Md2caWoMNtjvnnigeJ_rO22WCZOAPPhMGaDb5GsE9OmKsstsLn7pBNMGGqKNObpUf
    NHI8EIyf6C5hl4QuTOmekpAkjZ3sZ4DXTJL4ubwHNU2gLN9OqSKXpY>
X-ME-Received: <xmr:Md2caaCYzYOlfD7gskV609Ji1JN8UEABH66wpwNDUbRbVaqfm2Fya1zbRxn9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepjedtuefgffekjeefheekieeivdejhedvudffveefteeuffehgeettedvhfff
    veffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    gusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgvthdr
    tghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrgh
    drrghupdhrtghpthhtohepshgusehquhgvrghshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:Md2cabaiVmTWOfJl_CaAavI0ywAQILwEw8zuEH5J9z1_tZJR8uhNUQ>
    <xmx:Md2caV5e7QXpLdnwIJ9ij7sQxWVKyI53okP09sPb0Vn17T4aWs5w0Q>
    <xmx:Md2caUbMItFdWYuAp-FXkdO0JuwAoD87AdtAYUxnfmZ07h6XVywiWA>
    <xmx:Md2cacia9YiNfAHM2csExXQoFNGXaAVmuN7GnbVOXDjU3EecEWl2Ug>
    <xmx:Mt2cadSLuObmseg0r_GqmljFLkFHAaBLbc0EdS8CyqEYDe-3IwsDgR7B>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 18:05:20 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec 0/4] xfrm: misc bugfixes
Date: Tue, 24 Feb 2026 00:05:10 +0100
Message-ID: <cover.1771876412.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches fix a few small bugs in IPsec.

Sabrina Dubroca (4):
  xfrm: add missing extack for XFRMA_SA_PCPU in add_acquire and allocspi
  xfrm: fix the condition on x->pcpu_num in xfrm_sa_len
  xfrm: call xdo_dev_state_delete during state update
  esp: fix skb leak with espintcp and async crypto

 net/ipv4/esp4.c       | 9 ++++++---
 net/ipv6/esp6.c       | 9 ++++++---
 net/xfrm/xfrm_state.c | 1 +
 net/xfrm/xfrm_user.c  | 7 +++++--
 4 files changed, 18 insertions(+), 8 deletions(-)

-- 
2.51.2

