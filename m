Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E73D14EC73;
	Tue,  3 Mar 2026 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772497374; cv=none; b=FdrQlhgtn0ELxHz+vP6iHUBmc9PwvNB+IxKQzVW798u2QUv5IWgVFmQC+7TrNFtXUDci5GR7aN8oPTR9XzCqieZBFWFhnu8g+D0ePNn054Vu80AeWjiLyRw2a+oAnfSUYM21Y5og4mUI/jIjm7shqHhVyPPZq4xT2h4ubOZKTqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772497374; c=relaxed/simple;
	bh=fAHXYp2r3bJPizvrvjmdRZRYidtkZyUM69F1y4kVVXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDzumsgW/T4WYewCskfl+f91et/3lIDIMGHn4w6gRYYWPfGtyL5Hi+27PPrjgpwAX1sHeTnkvfgwnlrsQ0Zqy2fytYsiHk8Ts3ggOnnXUEmNrgj6btW7Jv+FCMmDXZr/zF15w/44ou+FzOAyla9D0OrvbA21sc3fJsFgnoHffCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgQeRtaA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgQeRtaA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15560C19423;
	Tue,  3 Mar 2026 00:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772497374;
	bh=fAHXYp2r3bJPizvrvjmdRZRYidtkZyUM69F1y4kVVXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rgQeRtaA4WA1WOjzSj0cpBWLaQdh5dTsmRX33aH1EzDWIsBXoPaVXlbJI+JGneRWd
	 IlCXUuVJucoNiiYRK83CTfUZt3U2oiTdaEv/T+rGzAT7b1Mn9wlI4DoGaaEEtZGdD/
	 efDrwLGhdBb6eVhPBC+gllZtrSQzWdznNyufNl+XoxtVZSAtFaVknF2cnw2AtQIe6s
	 cSucRR9yoezpv/llIPZjhCcXxSBjZCJGAO3lgHW60s2BOKVtN6iO3AT59i8bOUfw9p
	 x6g7DPT/dLpekGrZN6L9QF0gI5LrzfIusKCMsPQKjZMbg7h4rqA+4Y9wr5eNn+xasu
	 lhyJDR8zP6OEg==
Date: Mon, 2 Mar 2026 16:22:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Leon Hwang <leon.huangfu@shopee.com>, netdev@vger.kernel.org, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, David Ahern
 <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ij@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 kerneljasonxing@gmail.com, lance.yang@linux.dev, jiayuan.chen@linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next] tcp: Add net.ipv4.tcp_purge_receive_queue
 sysctl
Message-ID: <20260302162251.733b520e@kernel.org>
In-Reply-To: <f611be70-8280-44c8-86af-5866c0b302be@linux.dev>
References: <20260225074633.149590-1-leon.huangfu@shopee.com>
	<20260225174354.5a698ddb@kernel.org>
	<f611be70-8280-44c8-86af-5866c0b302be@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Mar 2026 17:55:59 +0800 Leon Hwang wrote:
> On 26/2/26 09:43, Jakub Kicinski wrote:
> > On Wed, 25 Feb 2026 15:46:33 +0800 Leon Hwang wrote:  
> >> Issue:
> >> When a TCP socket in the CLOSE_WAIT state receives a RST packet, the
> >> current implementation does not clear the socket's receive queue. This
> >> causes SKBs in the queue to remain allocated until the socket is
> >> explicitly closed by the application. As a consequence:
> >>
> >> 1. The page pool pages held by these SKBs are not released.  
> > 
> > On what kernel version and driver are you observing this?  
> 
> # uname -r
> 6.19.0-061900-generic
> 
> # ethtool -i eth0
> driver: mlx5_core
> version: 6.19.0-061900-generic
> firmware-version: 26.43.2566 (MT_0000000531)

Okay... this kernel + driver should just patiently wait for the page
pool to go away. 

What is the actual, end user problem that you're trying to solve?
A few kB of data waiting to be freed is not a huge problem..
