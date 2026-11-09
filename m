Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266992;
	b=K1LLMsjcyLgPKePHbo5PotcZIbJcO+OODEPZakx8xLMXTB/9zPbgc0+Z7bKWn0P2R2Te
	 ae2OCI97xhr6DVDqG7qbFr4Yi2x6/FydmeKYmJ2oAq6XBSjDm8pV7+RInlDvaMO4E5bwe
	 sx90wepZnWhHt7fBl0sWC1Y7dedpuO74gEC/I39Yu5UwGxnsKV0rCpOVX2y4GH8VYmisW
	 lEMldzrzvbe3fXONcTlVdGAUUncQz3ymqRlknR7U56qmJGpISwwIO3nDJ9BaGpVOyK4ha
	 2LpRPIEfLYmb9KI090DnRxJvUGGY2NuvXU4cfkA2OGjFOmtVw6lo8w4phbTsty/sBwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266992;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=hGY7SdMXqd8GDTXOY3teVBrqvVkE+aGkIkZBS3PPz4c=;
	b=3ifl7xTiY01QN7zq9tJzbvbuYXv5/pbNCSDMpdqCNC5v3lvWfX/qGBuamasZjHrlGmS/
	 JCjVS5gfFaAmJoLUsyOzlbtGMsRRKL2pgA921eanKgpdNnzbqwaH8ZDIAuaarr2pR9CEV
	 dGziyv5UvzGkDAxkNncJCgBKYWbKCfmFC+7epE+L664gcTFcVWnYBBVgWqs3Pz5wZu+BE
	 Dz68jabEuRNoZT3ZoGFxgcoZwPP0NVwK8QS4hw4eAa/17AuacCdf+RbLgCtoOm8feMsW/
	 gfsV/YlmKDTqJRhWH/UN0p/dpBSljg15A2LZh7IaVCJoZLKPBasQWig91pzQCiE3/pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=jblGhNPS;
	arc=none smtp.remote-ip=79.135.106.121
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB71606A332
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CB71606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=jblGhNPS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794266989; x=1794526189;
	bh=hGY7SdMXqd8GDTXOY3teVBrqvVkE+aGkIkZBS3PPz4c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jblGhNPSV/+x0ztQQQzXx7oBYf8YV+HRMkcxhqx1A5y7FYS50jIK7xpPU6uX9URHc
	 p0WxlFQTOpAv11QOIS1uCiFnMwirwNeTgtNQXeJMhbbNxdxvRKyHElJht4mwn9NAxe
	 HNbEYnAF0zV+eazZ8XrdfzA+W2ZZHCA3FCw1FxYEwPPhUOvt290M/6H2dNSAzCcMxV
	 9V1i2O8XFvCcgFxgonCmo8xbRQhXOjf5Rk8LUbdSIrYZbGQKHr/7M1MkCeth4YqDBr
	 bJVXaHRBh6Up+mgQPdsNR25nwOOdmlu922T/B8WY08oRSSDaNUdM+NDHJ33c6fDkCg
	 2Bop3YNTjkEtA==
Date: Mon, 09 Nov 2026 23:29:42 +0000
To: netdev-bot+sashiko@kernel.org
From: Noah Weinberger <NoahWeinberger2003@proton.me>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: sja1110: pull meta timestamps before reading them
Message-ID: <vR-5YjmFwE38XCIdmhVSSiNb3gCjNtWfogYP02_9WJ-nX1e_FpC-fefQxKI6132LyAq66BxO6Y0i3Mi5vkZoEE740ydFwXTO_ccEaayPS6k=@proton.me>
In-Reply-To: <179426666660.994134.10642884311879085983@kernel.org>
References: <mnJ9l2Ebi69wyTB5k6FBEnjRESb0SmEnlqwaQAOEJ1x5qRQJ3ZMVAdX7Bn9-yWEnQ0iv_3KLoI1yUVCc88IJOVGGow9rOyG6Y54sPMeW0zQ=@proton.me> <179426666660.994134.10642884311879085983@kernel.org>
Feedback-ID: 186545857:user:proton
X-Pm-Message-ID: 97320a67e324bcbe7192a8906259d898cc5cd010
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for the review. Please disregard this version of the patch. Sashiko =
identifies a possible stale buf pointer after the new pskb_may_pull() call =
if the skb head is reallocated. I haven't independently tested that finding=
.

Noah
