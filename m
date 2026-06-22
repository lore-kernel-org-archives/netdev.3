Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6A92DC78C
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782165367; cv=none; b=MO6sDWD0yQKV8pizxWiV6OXErkTcYSfbhE0O+IHZ4eN8ZgGf2rp3d1A91PRBTIrQGnHhylPmwPPYpeAGyB9Zchx1QytWrd48R1D+RK/zmGOYhqmBVtr4rVEe1u4fdG9gSHPzJn9UXemRQu7VS7sDYYpzHuUPQGN8V52p/ZF34S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782165367; c=relaxed/simple;
	bh=MhRnsPauROmUigkS4Ietp3Gci8EbN47PIQDXqtTi5Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/YENSxMpuEegFcPvZ/ODUayPYXexDbWaSxxt1jNcdQzE7yFg/nUaU4CB4EQrLZuqJshCBw8C+efn0+LJcbaox/yciFRSYWjOh+REU79AgyReHF7zBlw0wpWo/Gim8ZLmab2LFlDDQqcNOk+TGw0TuMmflR1yaB9rxfX5ebswQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEw0SkTT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEw0SkTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D651F000E9;
	Mon, 22 Jun 2026 21:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782165366;
	bh=fnp4Q8nhNaRHoYvnru7Wu60jtYd7ye9VqRc/LmL8nu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hEw0SkTTBwN8FVegJvFAMYUa+5e7BllR3KAO1P9Bku1InJux2qDu9Y3zt1t7Klmjy
	 +N8PlOZ6/iQtR1VHNME6Cr10z6ja71ezW7tb67Fm5zBCQ9/ZVPLzAZnh6zs0s6Ugu9
	 twpE2ij3OWMjd8F5UgZ+3tHPkndQ4l/hgSvRt2qULBiZUDqHBYwG8WUtOJTzLI5Me/
	 lMvEt5UI1fgDx/EtuZ4tZo6azTy4SIAxRzkh7T8DYrcVS9++EhBZXwliXDZefM2Et7
	 SZht5IxzJHegUFwogjPrk230E4A7Ox1Gsfrydbp4BLH9RJQJ9kUbfqhGI9t5yuCvAB
	 Rd3jcbcqfE5jQ==
Date: Mon, 22 Jun 2026 14:56:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev
 <netdev@vger.kernel.org>, Riana Tauro <riana.tauro@intel.com>
Subject: Re: building ynl afaics requires updating the UAPI headers first
Message-ID: <20260622145604.524949ec@kernel.org>
In-Reply-To: <f88cfe04-c817-4383-866b-530c5bc5bd95@leemhuis.info>
References: <ade91456-2f93-442c-b76c-28bd7157f074@leemhuis.info>
	<20260618170605.0e2e4dd4@kernel.org>
	<cec7685e-df12-4501-b851-9c8f7b8b06cb@leemhuis.info>
	<20260622090534.2af8ae9e@kernel.org>
	<f88cfe04-c817-4383-866b-530c5bc5bd95@leemhuis.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 18:33:29 +0200 Thorsten Leemhuis wrote:
> On 6/22/26 18:05, Jakub Kicinski wrote:
> > On Fri, 19 Jun 2026 09:28:47 +0200 Thorsten Leemhuis wrote:  
> >> On 6/19/26 02:06, Jakub Kicinski wrote:  
> >>> Can't repro for some reason, but we probably need something like 
> >>> commit 46e9b0224475abc to add the explicit include rule.    
> >>
> >> Thx for the pointer. So I guess you mean something like the below,
> >> which did the trick for me. Will submit this as properly, unless
> >> someone points out something stupid in it.  
>  [...]  
> 
> No, because the funny thing is: now I fail to reproduce it myself. And I
> don't know why, as 24h earlier when you had written "Can't repro for
> some reason" I had once more checked that I could trigger this by
> downgrading Fedora's kernel-headers package to a version from some weeks
> ago. Not sure what changed since then.
> 
> Want me to sent it nevertheless?

Yes, let's get it in place, it can't hurt AFAIU.
