Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792529602;
	b=BennO3DIjwurS8Byth0LRkDNJSFS5mGH4xadMW47L2KU8aMITmG5jHPPtYHbSzl+eJCt
	 1qO3Qgl0jWF92EDdUq9r/QzYXWm4x/SWaWLFriovOl67P0im5EAv7bmcOn/8DFslS5lAp
	 yDOpbXsQIald4rNVfD0sN3U3GN7D+HIq7Qjymeaq5yvri/Lgx9G8iQ4g6qF106yQAt0M5
	 34cY/Dpbyvf9r9wEZ1ZiP++2kT1dVevxMwt/NqDKmPcFzImzs34drEUXvtVHNSlrd+g1x
	 LmTJSy6WNn+JEqr+D9NXBuyU/R18PvJs620uBWlY+4dCEjNcW221p+Ax//PD71ky/yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529602;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fLQPyZNKQPhltfb8QjbLH6GiiK70H5pcOSO0dY3JeC8=;
	b=Yoz0C4vBVSi70+v8OG551yBQOJ7K89PHV13LeLxTRrCIDaYqsBBQr3kYL0AL9WJFlcQb
	 89UdZ6Zwx2HN+/EbWSUkt0JASO3itnLdKVa6UDNkyge0OleyYGKrpETtVkiyaEHyukq7D
	 3Y9uMWHsoACDHWj7fEYOA0s8ZfLj9uxuWPuw5o8t8/9gRBRguz6TuuFH/4cyHCnOBIIQc
	 wfTUbWEgj3ZzVijccmkKnpbduNeHSVTQx6BwErh36sqqk0az9rjbDJRBDgUqGHyF9YWKz
	 gR5mwzjg9QKgRgDvzwTzqcdeSuITsj/aKZSOaNAFkM1YOH6QRIyO04cBTA/cwme3TSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZiVDGH/q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C9C606A319;
	Tue, 20 Oct 2026 20:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiVDGH/q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15831F000C9;
	Tue, 20 Oct 2026 20:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792529602;
	bh=fLQPyZNKQPhltfb8QjbLH6GiiK70H5pcOSO0dY3JeC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZiVDGH/qgbA6MPW2SFLOcaeSO3h33sIn4htawp1MNSG8QzdpkQHv0bJPvDTXgEbH9
	 OrENY9zavE2QkXyJwShRZf8cMhX3Gc2lZ9BK6JK9m6GGW29G8wVXy7TkjiPmffZC0i
	 Lz2ce30reDQGclIexXoDh3slnayl9V84kpfwhEeM0tqjYm7DmcmWfArkAp/6vTwFKe
	 8FsblU4kXgMi/rI2g9T+z84vc/8jXw6vLjvtkg+s7zQIpI2/wUWRgOjYk/93h/vCXm
	 sv1N110esZJ6wbuAHXuymIpY927/ATqT+7PVYmHViHlQm7Cu/zKk9dzasL0mLJ+Ih0
	 r34a2d6wUwxSA==
Date: Tue, 20 Oct 2026 13:53:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sinfo@kernel.org
Cc: Wei Tao <taowei@kylinos.cn>, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/sched: cls_fw: allow filter replace without
 re-specifying mask
Message-ID: <20261020135321.21517b1d@kernel.org>
In-Reply-To: <179194621915.160550.4770507189079039972@kernel.org>
References: <20261014024548.37874-1-taowei@kylinos.cn>
	<179194621915.160550.4770507189079039972@kernel.org>
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

On Wed, 14 Oct 2026 02:50:19 +0000 netdev-bot+sinfo@kernel.org wrote:
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

You are expected to reply to these questions. If this is an LLM-based
report please be more considerate of maintainer's time. If you actually
use this feature please include the response to the question above in
the commit message and repost. The repost should not carry a Fixes
tag, it's not a real bug.
-- 
pw-bot: cr
