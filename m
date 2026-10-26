Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055554;
	b=KqerTW/je7HtXmKv/JDkN8c8XUs9mIDP4mOXIW0kktst/QY32h4+x4aROtqvtor4cX+C
	 ZkvCriDewYQ/5h7iqq3rGssruB2oanjujqt4DVXDP2mZ+JZC9Tbv33SX3k8iqFCwHNRXf
	 ESyuAihe8YURVx4mkXo9TCWNMHdSvYZmAZfrsDWF17PrEh8fbrr8iLvyaHirnP8m/mfdS
	 agXrvb4QVnF6fe80UmbhYMt6QsVsJquqzCMKi/V77oU/IH+QhV68wosh5yqsDlHIFH/vj
	 6WwpBKLTovrcPZnFcF37jh8OJQDZFeyk4xA7jHcHHk+lcPmNH0KNzazkaOzCeQwj+JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055554;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SGcZ0p0Zyc/qgb30VCtTMApdc3qA2Bq4A4P86F10eOg=;
	b=u2klOiQsKJJeNcKNvuejwYI4lSpnboYZ9UjArMpxH8zbSEXf2VgAPP8PH6NUdi6q7RfW
	 EHPZkhXi4N+7SmCJfJby2lZfVU76ruEPaIF7FUHZTKRp/Ex7zFZOtYoKtgHcsMwiNR8vC
	 TrNAPSVFWJIg1dpfOCy8e0UHKAgYLzM8GLBkoyOdoSD81Zr7XN+JvU3fTZbhHsYCQ5o6C
	 HyBSYzBxxG+S7gub8ue+qr8EJWG2XCNFKG4g3SA8iyb9SeL0gVuOwGfRSWRk0+9kIe5vc
	 lEzEZ0OyehbDFnreXdNI0nVUjqoadEBgcdi8qSWSyhGYOaIpIQMGT2DB9i1amIRvQlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOSOa8iE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42611606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOSOa8iE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216AB1F01825;
	Mon, 26 Oct 2026 22:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793055553;
	bh=SGcZ0p0Zyc/qgb30VCtTMApdc3qA2Bq4A4P86F10eOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oOSOa8iEro2ZIqz/xww7JKr7XmZk0yCuqqPdNKk14C+dqYol5m7BQJVaLZ0LfiZYT
	 TwwxLgISdW0m3QBYO1gWLgAmZbFo7tvPPMA5C9oDKpdYndE6v15IiS1NWUBLV/MK+p
	 W1k4LqMYxt6dFoGJc7IYNKKLGEvaFWv7OtszC8YmGrlIffwVyKqfDwt3HMbSuqQr9I
	 1ydoJdrSmskDpHurm93bcRcV1HE+FeBbhSzJpGBrjGmlMXy/qQWUiNtY8wNnlAp2aV
	 tab9S1fzav6ODDLPuMLZQYGxbYNLDwX//yvGsUAOHOa3dUyfotX0wNkwxbITxj87eN
	 ENdDCl6SqxLyw==
Date: Mon, 26 Oct 2026 15:59:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Demos Ra via B4 Relay <devnull+demosthenes.ra.gmail.com@kernel.org>
Cc: demosthenes.ra@gmail.com, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, netdev@vger.kernel.org, Sashiko
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH net 0/2] tools: ynl: generate code for rt-nexthop bucket
 notifications
Message-ID: <20261026155912.3f357085@kernel.org>
In-Reply-To: <20261025-ynl-ntf-bucket-v1-0-65aef308d62c@gmail.com>
References: <20261025-ynl-ntf-bucket-v1-0-65aef308d62c@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Oct 2026 00:13:54 +0700 Demos Ra via B4 Relay wrote:
> Commit 457dc9fefe9a ("netlink: specs: Add a spec for nexthops in
> rtnetlink") left newnexthopbucket-ntf out of the C code generation,
> because ynl-gen could not write a notification table entry for it.
> Sashiko pointed out that the generated library then fails at runtime
> when the kernel sends that notification to a subscribed socket.
> 
> Patch 1 lets ynl-gen handle a classic notification that no request
> matches. Patch 2 drops the exclusion.
> 
> 457dc9fefe9a was pulled in this merge window, hence net.

Unsupported functionality is not a bug. I suspect you just fed 
the Sashiko report to an LLM and posted the output.
-- 
pw-bot: defer
