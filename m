Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531AC3DEFF1;
	Thu,  3 Sep 2026 06:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788416462; cv=none; b=qZIYCMVekYcq2E9zLkjQiWabqor84mj2MW8RrIS5J/165Ggn15FkQL3jI77TrkLJVTMCngjyuyBVUPHSekswkKStkWu+QShLjKGPEpSXMCo18rdE5BtDzsC/1FJ8+CSFVBB9n4dww0L+zq4ZjiI3cC/IRHPdU8l4CDugiHqQ+lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788416462; c=relaxed/simple;
	bh=8tbL9/bcgRdu4FrkoAyrRr281K1luwFxGh2zebP2dRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lr+LrBfEnJg3VIkN3BoeHShO9ulIRh4U9QDUBqwqYoiO4QDzMMr7GyS3P1vruGiLms+FVvp+HqYkusVuSeR8XDmBa/1rwPU57sPE725NRfqyhv4AlDvnggv3Ipxq2S8Ik+cmojZ5BViAGf0tTfvoDXzyGSPui8/+J+C4Li7g0rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcsyK+iw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcsyK+iw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CC61F000E9;
	Thu,  3 Sep 2026 06:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788416460;
	bh=ezvwsuD+u14PjNnoqia2u/ikHfD23PiSeMOTx59SyOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PcsyK+iwGOgKA+wkEdVujasyooSN/g8G/3SWmvA0aK4DTO4e5rebZ45LBNCBnw9WQ
	 zgdF3JXR9mDEJlDBnsRCsoy58th9rFL2q24kSyIJwApAqV6Py9etnC+qjumCE4KL5j
	 Y8Uj2XmA05pzcW8WRMx7Yjg279fUtFhmfRvB+yE0Q8lwcoo9yD+/iBkv24Se/dwTaW
	 9O1G44jOT6mBV7tLjQo1+GgfJdx0zZz+zqsrFO8BDnikpR1J8jyGGbKnRsnDi4lqZe
	 7XU3w9T2KJvuNuzykEf6UHanO8UkGXDzAEDRLgYrnZLNW93HV17ugmY3PcDRPPSEJE
	 SQ05bco5JpnRA==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x20ok-00000005jqX-0ZFU;
	Thu, 03 Sep 2026 08:20:58 +0200
Date: Thu, 3 Sep 2026 08:20:58 +0200
From: Johan Hovold <johan@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 3chas3@gmail.com, duncan.sands@free.fr,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	david@kernel.org, willy@infradead.org, vbabka@kernel.org,
	accessrunner-general@lists.sourceforge.net,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/4] USB: replace page allocator calls with kmalloc()
Message-ID: <apkRyoCr2dNI0bNS@hovoldconsulting.com>
References: <20260830-usb-v1-0-aa349c302246@kernel.org>
 <178840081114.3041656.13596134068099743678.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178840081114.3041656.13596134068099743678.git-patchwork-notify@kernel.org>

On Thu, Sep 03, 2026 at 02:00:11AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Sun, 30 Aug 2026 11:10:36 +0300 you wrote:
> > This is a (small) part of larger work of replacing page allocator calls
> > with kmalloc.
> > 
> > My initial intention a few month ago was to remove ugly casts [1], but then
> > willy pointed out that Linus objected to something like this [2] and it
> > looks like more than a decade old technical debt.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [1/4] USB: usbfs: replace __get_free_page() with kmalloc()
>     (no matching commit)
>   - [2/4] USB: cxacru: replace __get_free_page() with kmalloc()
>     https://git.kernel.org/netdev/net-next/c/a3b4826138d4
>   - [3/4] USB: speedtch: replace __get_free_page() with kmalloc()
>     https://git.kernel.org/netdev/net-next/c/534b18813974
>   - [4/4] USB: serial: wwan: replace __get_free_page() with kmalloc()
>     (no matching commit)

Why were these USB patches applies to net-next?

Johan
