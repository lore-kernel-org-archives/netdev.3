Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649FC481245;
	Tue, 18 Aug 2026 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071866; cv=none; b=qHe7vLM2Hwky4sM44TOQDCxx/b5CjP9VGBVnLG9v7ldZifhrJJa68Xl+djjWJgoUCdTk1oU+FaV71y0DG9NvJyINP3ElwqdCvkosckUUClbjIYwQiIMt1xyq4ZiGQLiSUc3FfScAdtvrEC99DOxW2hUsC2hWMvHqQ94M0Cd96qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071866; c=relaxed/simple;
	bh=iGDED60fwjOEPCtvOXu1KY3P4lRrxQVlQBUDxhVqkW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7uVD2IsI/N/GnMu4QJMdopw5PYa6nSL+Ks7R0VU+KhtQ2G2mbzS5J7PAxkp/qD0RBySQzsMFrINOToaYt81HsUw/YanX0bMgANFXEYca/20hFAhKQPxR8Io8gfYfLI1txIxsqCIuUFVnT1OfQTzlr0RUaU13O4HbAdE10PzR1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaH3LPvM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaH3LPvM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403AA1F000E9;
	Tue, 18 Aug 2026 16:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787071864;
	bh=ZJ3LkHC5+QZqddMK0I7szGAkSYiUs4RIPZdNAXFfVCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IaH3LPvM4eRLd6h4KP1EMwsm9BMwkrkH3QZp3ke/u6WZNPPBbui2rkNsfjjz0jIqV
	 J0ruPUgRtRfV3syrp8m0YZ4kxR5QJKX5YrNJv3s1qwy/P5UznLSkzLO82yvZbH0L1b
	 nVHtp9IgAmgY0nnHFM4umI6kRzC8MKoJqZVbOh4D0lEvh8q0ak+yk0KFWsuAH0iDRs
	 ge7P3FarBBiSI67hv7pTitwev6MtV//prTQWkjUS6uJ3TjpTJbCXHBWAPj65VlcObU
	 VpstoOFKKx5L+8d7PIBZ+IBophvzD3w2Yut8VR/TBctTLciVq6ZRaBGfcFzaDdL1nL
	 rIaaByxZL7+4A==
Date: Tue, 18 Aug 2026 09:51:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/7] netconsole: validate a target's IP
 address configuration
Message-ID: <20260818095103.7a7f4c51@kernel.org>
In-Reply-To: <20260814-netcons_ipv6-v3-0-bc0915e8c75f@gmail.com>
References: <20260814-netcons_ipv6-v3-0-bc0915e8c75f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 20:28:51 +0100 Gustavo Luiz Duarte wrote:
> This series adds two validations to the target configuration when the
> user tries to enable it: first whether remote_ip was set, and second
> whether local_ip and remote_ip address families match. Refuse to enable
> the target if any of those validations fail.
> 
> These validations are already done for the target passed on the
> command-line, so this aligns dynamic targets with the command-line
> behavior.
> 
> The first two patches replace the per-target 'ipv6' flag with a
> per-address 'family' field, which makes it easier to detect these error
> conditions. Patches 3 and 4 implement the actual validations.
> 
> Patches 5-7 are follow-ups from previous reviews: move inet_addr from
> netpoll.h into netconsole.c, show an unset address as an empty string
> rather than "0.0.0.0", document local_ip auto-selection.

LGTM, but feels to risky to merge during the merge window.
Since we're changing semantics we should let this sit in linux-next
for at least a week. Please repost in Sept.

BTW please carefully review clashiko feedback:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814-netcons_ipv6-v3-7-bc0915e8c75f@gmail.com
It marked as preexisting the problem of IP versions diverging but 
I think it's relevant (patch 2)?
