Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872B43FE649;
	Fri, 12 Jun 2026 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283016; cv=none; b=OmxpSHi1uZhtCLOHHltNU24732z+OG6JRfmqObY1Wq79XdCm/CxgKCg8/W946cfEuTz65xlIhjh20Qzg+HgyfaadIhNDo5X+AcsNrtDkbBbKp7HUMFzgdFPTzcO0sL8ymJIaKPkRKSgBstWlvSO0JIXKIZQONAcKXaB+fn1bi84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283016; c=relaxed/simple;
	bh=5SFHbzXmYeJOjeGP6n53U6/rRL3lm4sSKEGkK7NUnrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCesKj6Otf+NLLUGyveONOu76Tm+h+BVjz8BHq812s+u0ZPepGEZ0KMQe/9j0uLZK8FRfYP1tcWOh1Z7DKnDY+vyv0Ol067WYtveUijZ2tV8X9PCWlWW69wZK80CTqDkZDt65Xw+Ie/bOqPy/kycrBy2j4p6XN4o4IdZFjitFBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYtBWOv+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYtBWOv+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3C71F000E9;
	Fri, 12 Jun 2026 16:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781283015;
	bh=5SFHbzXmYeJOjeGP6n53U6/rRL3lm4sSKEGkK7NUnrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HYtBWOv+FJenMPLWr7AzvR2JoJdLD9JJZm2xF9uFvX22gOaJ7NnB81Z/xsGrWlFjO
	 dPJc3I/zFisn430Zi8ynhRgdJSlnA/8w+ZcjD4D2vbdALeb5nBqqnN2owciH8ZCGfC
	 PPLYDEhp7WIVnoQcE4SydXc6pZDqEBeMJ8oL5NniJIhzmpULI/quIWxYdIl3/3uB2p
	 gqZbu2r6M28fF8O5V4Kzh6cV4DQQg4SiNKmM1Rv726fUIy5fv8SNm+D+Py/Qk8bL9/
	 x+Go1k4tWNvZcNsZUpb3t7hs1wvI8iLM4ELTn7g/aNAoZui0aud1RS1LkECeLU8kjo
	 5ZZWhKXWH2IYg==
Date: Fri, 12 Jun 2026 17:50:10 +0100
From: Simon Horman <horms@kernel.org>
To: angelayucode@gmail.com
Cc: dsahern@kernel.or, blair.steven@alliedtelesis.co.nz,
	carl.smith@alliedtelesis.co.nz, linux-kernel@vger.kernel.org,
	angela.yu@alliedtelesis.co.nz, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] [PATCH] l2tp: fix IPv6 xmit frag failure for
 oversized non-GSO packets
Message-ID: <20260612165010.GH671640@horms.kernel.org>
References: <20260610223557.2765487-1-angela.yu@alliedtelesis.co.nz>
 <20260612164213.694784-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612164213.694784-2-horms@kernel.org>

On Fri, Jun 12, 2026 at 05:42:14PM +0100, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev

Sorry, I forgot to update the boilerplate above.
This AI-generated review is actually from
https://netdev-ai.bots.linux.dev/sashiko/

...
