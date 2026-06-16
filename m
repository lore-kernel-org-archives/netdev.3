Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2051946DA;
	Tue, 16 Jun 2026 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781571338; cv=none; b=u30qXpvS4JhBY/SmztECIYw+AMg7vo+TDbDUaA7UvAJv2Ok6OmGMmTrd2CFzHFTCICzXG/uluIbj85kXmUTFtG2ciW7YtNir6QmEjSlAmmHVw/cVUJjg8zaPCl2/mffPjxcmd5jV4om8YiikvKcGp8vJ4Fqzqk41X3sronh+KAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781571338; c=relaxed/simple;
	bh=/BMQPdKy2mez2NWPXzQui/LvqSQYMnIqUUjhigjlpx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsI4DiwjRzO+c+PQQB0TW/AEs7PYYVufgTcnOJs/Ulf86Y92SIByt/ePeaAJGWwwDJ5GLWS8eBKhvfQIZqQHVDWsNZdQmIaIGZGSViyNB5laHgDWurVDPGpLGBJY98mDPasiLZmVLLfhqsMUAApGZOcUu8hcyo8oBbK7zOr8hbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKZ5AFQI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKZ5AFQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A1E1F000E9;
	Tue, 16 Jun 2026 00:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781571337;
	bh=lskkInW4j+QflVmCtofwVhf2RQet1ZyLYb6x5LBakeI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TKZ5AFQIoVK5NtSIBcKZ+XK4QNf3pRkYbRoMsoZ4iDboN3wkJk1jZTJ2kwEkojwK7
	 56Er+BG+jd3/RoIUW9OY1xeprE5dYvsQL1SQ6eAS5vtjFyMGB1ovOkPQOJgcbnDvwK
	 IDBFmXEP3upDgEU88CBoP68UJPtrnWeWEKyUHx9kaowOkG/8QRvagZ4QGNTGXS8CWI
	 ex8JjIgvxHy/JHluGsl+c2NhPsbxVYSOUSDFitNKbpJ1P2CzQrLjPgbQ0NTazsuIDa
	 shXnbiP1zAA9/68Ma1G129w2dlqiLw6AAA79KKtVgfdkclrrkwgVm7yaUqvNB+RqXl
	 2r9jLauRxnyEQ==
Date: Mon, 15 Jun 2026 17:55:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 geert@linux-m68k.org, chleroy@kernel.org, npiggin@gmail.com,
 mpe@ellerman.id.au, maddy@linux.ibm.com, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 0/2] appletalk: move the protocol out of tree
Message-ID: <20260615175535.5bc56cfc@kernel.org>
In-Reply-To: <c3789160609a10e232ba3e27c4b13adbb170956c.camel@physik.fu-berlin.de>
References: <20260615222935.947233-1-kuba@kernel.org>
	<c3789160609a10e232ba3e27c4b13adbb170956c.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 01:34:06 +0200 John Paul Adrian Glaubitz wrote:
> On Mon, 2026-06-15 at 15:29 -0700, Jakub Kicinski wrote:
> > This tiny series moves appletalk out of tree, to:
> > 
> >   https://github.com/linux-netdev/mod-orphan
> > 
> > Core maintainainers are unable to keep up with the rate of security
> > bug reports and fixes. Nobody seems to care about appletalk enough
> > to review the patches.  
> 
> Why would fixing these vulnerabilities be relevant? No one is going to
> expose an Apple Talk server to an untrusted network, are they? The same
> applies to hamradio and AX.25, they are all used by hobbyists in DMZ
> networks, so no one really cares about vulnerabilities in these protocols.
> 
> I find it sad that AI tools are basically used to shoot at the kernel
> to kill off features as some people are apparently getting scared by
> these AI reports and just nuke everything in a panic reaction as if it
> wouldn't just be possible to disable these protocols at compile time
> to reduce the attack surface.
> 
> > As Eric pointed out Mac OS dropped AppleTalk over a decade ago.  
> 
> That's not the point though. No one is going to use AppleTalk to network
> a Linux box to a modern macOS machine. The usefulness lies in hooking up
> a Linux box to a vintage Mac or other retro computer.
> 
> So far, one of the huge advantages of open source operating systems has
> always been that even niche use cases were supported and people could make
> use of old hardware by using open source operating systems over commercial
> offerings such as Windows or macOS.
> 
> With the advent of AI security reports, these niche use cases are more and
> more being killed off with the argument that a vulnerability in the harmradio
> code could pose a threat to a large SAP database running on a Linux enterprise
> distribution. However, if your enterprise distribution is enabling kernel
> features their customers aren't using and therefore enlarging the attack surface,
> it's more a problem of said enterprise distribution and not of these old and
> obscure network protocols.
> 
> I am trying my best to save as many classic features in the kernel as possible
> to enable retro computing but I am sometimes fearing that commercial interest
> in the kernel is taking over too much making my efforts harder every day.

We can complain about the AI slop til the cows comes home.
I don't like it, you don't like it. What difference does it make? 

If y'all have real solutions please share. Complaining about
"commercial interests" and "nuk[ing] everything in a panic reaction"
is not helpful.
