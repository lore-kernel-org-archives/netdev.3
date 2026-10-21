Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566219;
	b=xF9i1brpIs2oLnEvMvZQw/4fqhoS6m94wHsGC4I6EHpSmxoa/ClYXcJLlNbpjSb5sPTu
	 ta499q0pn7t0cE/MESAFVSLt21WqNJ8WkEIEOywWxj9fZQ+rYhdny45X98EyZF4bEdfPH
	 L40peeQGBntKiVLSEBvJemKLFAR2nwE63BAbD/JM0K4A39N10bxP5mwTJPbBb39mjB6NW
	 ZR99sbREzvMTH6nZD1WdKqL1K4fxtHHlYU/2VeNPl8g0Diy6BZMakUKrNf2ZMbCtl+8iv
	 kfmrBKQudgJKv6J3RprH4HT5RJlWQnKh7W6OJIP4dMyxfv7Aj4WOe0nA+x6X8eYGriA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566219;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=G0JqV33vkTSX97xk3gUqIcjVCnQQRw+1koMj16mwjqCrznl2PPYVuyYQkP+eQHVoPsvW
	 z+WrSPdq2xfgtWcixLM8N6QIQqJxZy4vJtBDSa7RYjnbZnxzKwHVEIAEMbkw5x6t0o8QU
	 s42uwtOI/KtsKaXpV//bpinZz2U1vfIcXoUTNrVKCxnpi3waLge4E0WkTeQSFAbZ/ykfc
	 tCQtnrbKtVvhTMYBo1rsYmsYQg8A9JXJEPQ4HnjZQPTRQW8MzDylcKdGgqtnHqzvs/3j+
	 fvQCLMvvArZGtIq4QIWd2EDVWRMCNpk5q1uohmc/WFXTDM8huXJJrTE5ejr0BGKp0Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KIaS0g9m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3702606A31A;
	Wed, 21 Oct 2026 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KIaS0g9m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1271F000CF;
	Wed, 21 Oct 2026 07:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792566219;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KIaS0g9mdn5Rz+bmqqE44xQ8xaasrqmpDSmUeHq8wPx9qVPPx1tgnQWEcrLCRyvr+
	 jt9dD6sfLx5GvYGNbcKA3TfvA9+qa4LCY146xawlELijJdrkYZ0FihQ/adO6PAnpYS
	 5boiaNP8BKuIKd/+ep0/6mJXeXhvA61ydTNGGOJBH30N7oeToOjrbkcXIyeCg5HTcG
	 01L06t9uxW5zlL7sexlimgRn2KldwslZkzv4DzY/OoJYVvLQhdkzZwfFiXZBPLaL1n
	 yjSjtAGvTVGyXMFIZwgy9f6CpLjpKKG0PiAPHWurpxGlKfg3vmrdWtYCwh3w7ktKtf
	 x9S2leo8coSqg==
From: netdev-bot+sinfo@kernel.org
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Harald Welte <laforge@gnumonks.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] gtp: Require 'CAP_NET_ADMIN' when joining the gtp
 multicast group
Date: Wed, 21 Oct 2026 07:03:37 +0000
Message-ID: <179256621789.3290.7142786984430868325@kernel.org>
In-Reply-To: <20261021065750.2069795-1-anilkaushikwireless@gmail.com>
References: <20261021065750.2069795-1-anilkaushikwireless@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
