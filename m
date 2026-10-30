Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354409;
	b=zI5AQy9BTQA5XxiPCQAjK4+OPBoegWR8RGyBI68zr6bsGDPIXTmGprTiMB+8axQtMd4h
	 W3j4ptCyfEAKjukhEGw2TEJoikRDxwG3myDy5rho0r/mm3OT+j66DVtnIuGK5QaJisM9X
	 j7sZghP1gw3xvJW1SSo+SC4BHn97qORBv5XZpt8SPmLKJVUPuxdUve5oyt6jYvoNkoMGh
	 QCukg5uSbJlYTmw7445KpDDcHlIVkBCRvutr3F5NpRCCSKqXc1Hl+NpwR3tPGJxLCe7KY
	 ZP4qwXQEw6pHLmTb9Ts4uoil/GNfC611r3/TdNqRfqQ1Z7tRENKUPpTHUXwrjwtbB6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354409;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=CK5jDSKCZff+wSi5cTNQhrxDZk3uYg8wCpUKhzVOEI88+RthVJC8D09e9esYMCPMi+rJ
	 wq/DtPxf7+/cROaS6gJI3SyZ0Et2OO1XODhawHDtVRNHZGBlY7zdUODMEUftvVPyilNjA
	 3yCDxMCnNm0sQV766qkT6fezNpI4rMhX9wZAhgyjqCW9YTdoVPvLtpvFrP8oJG+/52QiY
	 D/k0YkDfyOlzwIggUdZn57sWGop7xkuj6/u729ig63kqhqhEaHq+syOpPzIaa2A8rQucj
	 x3sQJvMSR89q1V6CeXrPJmN8ryJk2/cAgYptiojuFF9l5F0S7vA5f4FYwrhM+Tbsn2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZE568MS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C4606A337;
	Fri, 30 Oct 2026 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZE568MS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E478F1F000C1;
	Fri, 30 Oct 2026 10:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793354408;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mZE568MS+/JitDYe3nCwZYcMSQwJXkakWOj5Be3b14zEBuDjPMnFLjlTZkQMhS8jf
	 Aj+dNL+wrbeIOs6mxmU/V4PKx4H2z1Y2Tjn2QVBfg9K35MTQ72WKV5TvXaWUzVmgGH
	 MhRtLnhoXzAyomL2FPMHBKdpCJJsGMoB+4g/K4mkhQ8fWqLLFcF+dBW/0emqCb0fxy
	 3BjHv49494jed/p59X+7rWw6kpCk3cFeOBmZ4Xou3BEahEoBEAKCygBzCHVUcuKvCi
	 Q3tKn8kH84JeTfUl+a2C8xA/Cvo6BNZG8RBX5E2/nzFhdyVibbWd+0qPFq/jn7ZlU+
	 WKvX7ID3mj7HA==
From: netdev-bot+sinfo@kernel.org
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
 liuyonglong@huawei.com, chenhao418@huawei.com, yangshuaisong@h-partners.com,
 ningwei15@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH v3 net 0/4] net: hns3: fix multiple bugs in reset/error paths
Date: Fri, 30 Oct 2026 10:00:07 +0000
Message-ID: <179335440742.3327.601321525899480645@kernel.org>
In-Reply-To: <20261030095633.377289-1-shaojijie@huawei.com>
References: <20261030095633.377289-1-shaojijie@huawei.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
