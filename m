Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6DB44E651;
	Thu,  3 Sep 2026 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432886; cv=none; b=vD/CxwtckVvmbwzeW9EQWbFo0w5FWUElASjzjE3SpJG1rInChsO/A46un01//OC+TCoOu2tGqfAP8qL9y6Y6txH9ISC2HU1/2LB+ylHOUnj30u8x0umJ+KKYOfc4RPkaXM0jUxPN0h/Dif/FC38euryei6CwAtLXndOepg2jJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432886; c=relaxed/simple;
	bh=pXCKXNSXnJxqbVPsHWcNaHMxXYlIcjgCff7HLF0K7Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5HZNA3Om0ANeQliqNvjgG5rKk8fdoPWTXapBKHn3FVhHWC9G9t16403GIcG6tkGHazaHDknkBz1j3azRUfeXDES5SupSdzlLrEKnyOj+RWAPNW7MwAzt44NsUDkF4Dk7N5h3/z/RPimZRijBEw82US7EVn7Y/DasCnSA/X5CNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEYVSY1A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEYVSY1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93931F000E9;
	Thu,  3 Sep 2026 10:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788432884;
	bh=Yte+8LLHHjHRtJk2Wim31OWnwZFXKsPlPjw39cWebrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FEYVSY1A2Xn3I1xKM06H+6iDo+CONHwGUrieaf8YLTIr++gbZ/osX1XJBvIyQfVgS
	 5pG3pNip6KnKrx99j8e2oaxupXZWjgIqdQ6F3Wz24RDGrXbqC0EdgWiVp3UslPHcrk
	 uu9VMayxq9lhK6wcGnOxI7udRC1b7SsLnCHs9tz01qbC0lff43D55N2utRlitv5pFc
	 fZ4bjpQO8DdHg8AG1klb0Ora+nS9wqxH4yKtxoykH65y3LudBJKx/FZnJZQiZsY3Ot
	 piK0p6QgVo0uSP6e+s9iAajiKhBQcFTul614EjzoP1UVJbVTIHo8DrzxswovFhI09v
	 TOYQajtG33zew==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x255e-00000005wji-0O90;
	Thu, 03 Sep 2026 12:54:42 +0200
Date: Thu, 3 Sep 2026 12:54:42 +0200
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
Message-ID: <aplR8tmzndmg4kfq@hovoldconsulting.com>
References: <20260830-usb-v1-0-aa349c302246@kernel.org>
 <178840081114.3041656.13596134068099743678.git-patchwork-notify@kernel.org>
 <apkRyoCr2dNI0bNS@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apkRyoCr2dNI0bNS@hovoldconsulting.com>

On Thu, Sep 03, 2026 at 08:20:58AM +0200, Johan Hovold wrote:
> On Thu, Sep 03, 2026 at 02:00:11AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> > Hello:
> > 
> > This series was applied to netdev/net-next.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
> > 
> > On Sun, 30 Aug 2026 11:10:36 +0300 you wrote:
> > > This is a (small) part of larger work of replacing page allocator calls
> > > with kmalloc.
> > > 
> > > My initial intention a few month ago was to remove ugly casts [1], but then
> > > willy pointed out that Linus objected to something like this [2] and it
> > > looks like more than a decade old technical debt.
> > > 
> > > [...]
> > 
> > Here is the summary with links:
> >   - [1/4] USB: usbfs: replace __get_free_page() with kmalloc()
> >     (no matching commit)
> >   - [2/4] USB: cxacru: replace __get_free_page() with kmalloc()
> >     https://git.kernel.org/netdev/net-next/c/a3b4826138d4
> >   - [3/4] USB: speedtch: replace __get_free_page() with kmalloc()
> >     https://git.kernel.org/netdev/net-next/c/534b18813974
> >   - [4/4] USB: serial: wwan: replace __get_free_page() with kmalloc()
> >     (no matching commit)
> 
> Why were these USB patches applies to net-next?

I see now that it was only the ATM ones.

Sorry about the noise.
 
Johan
