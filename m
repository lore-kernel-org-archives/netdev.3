Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E8BDDA9
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 01:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790213312; cv=none; b=qPwsLhL96Mlbw6sRxjCdcxDFQwblgQfxrmy3rt1P3bJp3Vq9O+8Ytj1+OG9xqtNWQEL4KccgfZN6+UcthcXtAhIP3iLSFX4LJIQKsmD5UNRXwPqKPJja+WP4HMX1VKKaDOpDK1x9BAKJpEeBXEMZUBO1rP1HCP7Zq8cL4+tatX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790213312; c=relaxed/simple;
	bh=t2wsMxixB2t7S8LcijtCH5DWugsQkbNBt9AfdiEfk4U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WP9t8fM1BY426mzSoNkK+T8fdpVxXaoI05O1zzWeT9ETBk1WFUbVrV2fdzcArFezo3OdmT/O9QN2cogWXF2uYZxpwABp+GwR8QBvCTGDvO3cG+qvTW+TyqLC+7OaNMUAhty/MY2x28U418io1BPTjkXeqfM7S51FYosgtraemto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+Evk614; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+Evk614"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DD91F000FF;
	Thu, 24 Sep 2026 01:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790213311;
	bh=aZ/8tijrU8ovjyvmsXLTzlz9IDvzxG/EvXt/iHkEbXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K+Evk614T3iZYLtb8S9lMH1b28M+XEvWbOYjzfjf1FokbYZ6aiyXZE+ohzrf3DoJC
	 lXSNNVplBJCyCQf8a/rHFuVn70iemxE5/yISoj2TWy7J7P2xRDkEPthBP2Gd/jz9CG
	 HvmRmLkA3ZYa8Va6SVHkLHx7xjVYpnSa63Ai5iVw80AA3/tvfgi2JeMLsZPZHdQ0Bg
	 r6WP+GL+LtIodGp6/RJxW+Wh091TekHljGV3RlWxJPqZP7DcQNaG+lmzhsqXC9Pken
	 3iQ38P5REuvHDQHI1lhMQqoHtiHPrjLFLGjDQAVmpI3y8swzq4pv/r1eT8rbfRd2EF
	 0jz8AvplSFcvA==
Date: Wed, 23 Sep 2026 18:28:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Myeonghun
 Pak <mhun512@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: ethernet: cortina: Use page_pool for
 Gemini RX buffers
Message-ID: <20260923182830.4f9ddc2a@kernel.org>
In-Reply-To: <20260920-gemini-ethernet-fixes-3-v1-0-3a2a50a83d89@kernel.org>
References: <20260920-gemini-ethernet-fixes-3-v1-0-3a2a50a83d89@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 22:48:50 +0200 Linus Walleij wrote:
> The Gemini ethernet has this really convoluted queue mechanism using
> a custom queue.
> 
> Move the Gemini RX buffer management to a parent-owned page_pool.

TBH sounds like weird piece of HW. IDK if we want to burden the generic
page pool code with weird, 20+ yo drivers+HW :/ Well, I know that 
I definitely don't, I don't know if others agree :)

Looks like AI has found plenty o'bugs.

Also, please never put Fixes tags from Linus's tree on net-next patches.
Either net or not a fix.
-- 
pw-bot: cr
