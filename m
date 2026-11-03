Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.37.86.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708859;
	b=CAUBl81Nz88b3n+fSIhIWgif1SSPiwtJgpr07zb1XhPeS4Rwgzcim0F1nhu8jZraSbYF
	 a41IeIx+jpXRgXWS4Z4daqy5L6GaDWrpAypzxvP+CiP6I+zUdargsA7OuN1zn9+LU6Dsn
	 /Jl7ATWvNrIirNyyGPf5X2mc08RkVrkgPPVzxB1MQpKbsw9/Pf2m+gn0z5NdJb5oQYmjq
	 iGv8ajitVviRro+scnfPSEzQ9piuNipLzsJI1rHCoU7jFbVdd+rX/pIGMhU7un5iV7pak
	 9yfqBhHS07tw8GF6SyWCg2AuMtH0p9KvVNDUwlVRz1b/a7tVEo7vMRauLIVSnnB9Kyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708859;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Outbound-Client-TLS:X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=BNaycRNLZWtLP1ftbCrICm1IfFB4d8CT7ymfYq37TPg=;
	b=eecix/Y8P9H37Xw4fFe3qZQ5eAd8TXzR2O4ntZUNuh2qmRSgZk1i/Esbt9TR+01EEA7A
	 rcggl1dlxYnQGzd3HDy/ctS+Jhd+qaNWgJo16E+twWH3wSGrFAmGWSlGLNjg6ouHqtXNw
	 mT4Fusx2IChwMdJHfDDUsaWrp/MvT0yFTf1isvztPMueRLUvYnYraOxW9DnvrpjtXodsb
	 anNi0cVXVl23cIsj4rmpZcf8ipWGIYwxXnUNBOpCS90uqOuKn+cw8v0S3aqnhmJ9KEPhZ
	 i8+kidM2VIdeJEpWC0j9ytlnwemipwa0rkjtWKe2QWC28mEnE8b5CfM+XCHgWQpf3ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=fZTebrER;
	arc=none smtp.remote-ip=173.37.86.72
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B61606A32E
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47B61606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=fZTebrER
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1611; q=dns/txt;
  s=iport01; t=1793708859; x=1794918459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BNaycRNLZWtLP1ftbCrICm1IfFB4d8CT7ymfYq37TPg=;
  b=fZTebrERYbaYCnp5iH/L/8oLyqBVSZbwQOYx+kb93+mYKsjraIztw9kq
   VVmfgOTUU3mRNWRuR0y8HwcPhSthSJllJcMKrts9WbGtBhNBPULpX873n
   Kw7IfnAGQNpMmxPj5xj/Ywg3h4IZfnnCxuoyb60ATWiPtI1yl4/rcdXyh
   3whhQdxrOoBm3Pq+0gUb/65GoWV57+wAcH5jNtSDwtEpu4maBAU+0fGjY
   iUMLyyhsi2iHX44MtfLnXfNqAeB3CM5dw1yOkWO5yHOnQaXiouWJUPeqH
   ln5d+hWjsbNBYjOVop1gSnH9ZwURsptC2N8kucpUu17rEyFRdja72LFKx
   A==;
X-CSE-ConnectionGUID: 0+1j02ITTgCq8z1oX8RJNA==
X-CSE-MsgGUID: LBzBF34bSyCdtQBk9I7i6g==
X-IPAS-Result: =?us-ascii?q?A0AeBADd0elq/5X/Ja1aHgEBCxIMggULhCxDhSCRdIEWn?=
 =?us-ascii?q?QwUgWoPAQEBD1EEAQGFBQKOHAImNQgOAQIEAwIDAQEBAQEBAQEBAQEBCgEBB?=
 =?us-ascii?q?QEBAQIBBwWBDhOGXJATAgEDIw8BRhALGgImAgJWgxuCdQO7E3qBMoEB3kmBd?=
 =?us-ascii?q?BWBCi6FcoJtAYUDdoR9JxuBSUSBFYJzOD6EHwtmgw+CagSCIoEMiBqOeEgKe?=
 =?us-ascii?q?BwDWSwBVRMNCgsHBYElQwM1EioVI0sFLR2BIyEdFxEeWBsGBRIgKkFDW4ESg?=
 =?us-ascii?q?QddgSsoXQECH0YtFYF2AoJRgSNdAgFJQQ4HRVMJJUMSRyQiCBIJARMaLAqBG?=
 =?us-ascii?q?jU8CSY/FQxbCwgDGgUaJgIfCAILAgx0KBEQEx0eJC8FHCZAEBgNSBEsNxUZB?=
 =?us-ascii?q?D0BbgeUKQEPY1cMIBJEAXkaXx8cKZJjkkiBNYpDlRmEKYFnn3YaM4QElBiSV?=
 =?us-ascii?q?JkIpA5NhGmBaQE6gVkzGggbFYMjUhkP4H8mcQcCBw8CkgSBbQEB?=
IronPort-Data: A9a23:obczK64xaY/7c7HPpZQCeAxRtPvGchMFZxGqfqrLsTDasY5as4F+v
 mAXD2iAOq3eY2H9f9p2bt7g8UoE6sTczNFgTFFp/3pnZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa+1H1dOex9RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wo/KUzBHf/g2QqaztMsPrawP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eZc5B+L4tIF1y+
 tcBeCJUaSDTvcCQ6efuIgVsrpxLwMjDJogTvDRkiDreF/tjGMqFSKTR7tge1zA17ixMNa+BP
 IxCNnw1MUmGOkEeUrsUIMpWcOOAnXDjciZYq1K9rqss6G+Vxwt0uFToGIeJIYDSFZgJwC50o
 Eri1XbTLEpGPueO4jaZy1iv186QnH30Ddd6+LqQs6QCbEeo7mAaFhATfVeyv/S8jkmwR5RZJ
 lB80icisK075kG3ZtrwRRu1pDiDpBF0c9lNGeQS6wyXzKfQpQGDCQAsSDNdZNE48cUxWX8x3
 0SJntDuLT9iqruYTTSa7Lj8hTq0NTIYMiwEaDMIQBUt58Tlpsc4jnrnVt9pHai0psf4FTH53
 3aBqy1Wr7MekcIGyY2l8l3dxTGhvJ7ESkgy/Aq/Y46+xhlyaIjgY8mj7kLWqK8aao2YVVKG+
 nMDnqBy8dwzMH1ErwTVKM1lIV1jz6/t3OH06bK3I6Qcyg==
IronPort-HdrOrdr: A9a23:wqNp0avIytOo6pg0Vt37a2EO7skDUNV00zEX/kB9WHVpmwKj+/
 xG+85rsiMc6QxhPE3I9urvBEDtexnhHNtOkOos1NSZLWzbUQmTTb2KhLGKq1bd8m/Fh4xgPM
 xbHJSWZuecMbEDt6bHyTj9Nco8y9+a963tr+Lfw3BxCTxOUchbnmFE4sLxKDwPeOGAbqBJba
 ah2g==
X-Talos-CUID: 9a23:NPZLo2EoEYf74K/lqmI/txcWQpoETkHS526AMRa/OTZTapu8HAo=
X-Talos-MUID: 9a23:hH1nCwS9awsoqFzpRXTIriNIGpw06Z+/I0wRqL8F6ujbNHJ/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,193,1787011200"; 
   d="scan'208";a="543408546"
Received: from rcdn-l-core-12.cisco.com ([173.37.255.149])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Nov 2026 12:27:38 +0000
Received: from satishkh-l-mj0bbv6x.cisco.com (unknown [10.25.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-12.cisco.com (Postfix) with ESMTPS id 9D83318000301;
	Tue,  3 Nov 2026 12:27:37 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	sebaddel@cisco.com,
	aradhana@cisco.com,
	rfaucett@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net v4 1/2] enic: retain admin-channel DMA until queues stop
Date: Tue,  3 Nov 2026 04:27:31 -0800
Message-ID: <20261103122731.3607002-1-satishkh@cisco.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179364652343.3131.12378421260627827008@kernel.org>
References: <20261101-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v4-1-a7e209210453@cisco.com> <179364652343.3131.12378421260627827008@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.52];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.52, [10.25.129.52]
X-Outbound-Node: rcdn-l-core-12.cisco.com

Thanks for the review.

I agree that mbox_tx_poisoned does not represent an independent state in
this series. The field came from the follow-on SR-IOV mailbox-recovery
work, where a posted-send timeout must be distinguished while the admin
channel is still LIVE. In this two-patch fixes series, unresolved queue
ownership is already represented by admin_chan_state being QUARANTINED,
while mbox_send_disabled blocks new sends. V5 therefore removes
mbox_tx_poisoned. I will introduce that state with the follow-on recovery
patch that actually needs and consumes it.

I also agree that probe failure should make a final queue check after
ordinary teardown has had an opportunity to stop the queues. V5 runs
generic teardown and CMD_CLOSE before the final direct admin WQ/RQ
check in both probe unwind and removal. It releases the admin graph if
both queues have stopped and otherwise retains it.

I do not plan to treat an all-ones MMIO read or a recoverable PCI
channel-offline state as proof that DMA has stopped. Those observations
show that the queue registers are inaccessible, but do not establish
completion of previously issued DMA. V5 keeps the conservative
retention policy and documents it explicitly.

The failed-reset/reopen followed by a repeated datapath stop is a valid
pre-existing lifecycle issue. It is separate from admin DMA ownership,
so I will address it independently with fault injection at the
enic_open() failure points followed by administrative close and device
removal.

I have made these changes in V5 and will post the revision shortly.

pw-bot: cr
