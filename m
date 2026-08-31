Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1401544A416;
	Mon, 31 Aug 2026 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186299; cv=none; b=okAaBny2M+zoCMfQh67l2YFnlSw3QNykWjnmqOdHMQ4F8x7U3kHglHPuMwehkcmvyGZfcrfuO+u/NHmlO4ANSMWhp7wtTfaHoWlPBKevQTbLMWqjjpTmXzPH61lzMRw6ykEFXKG1rpLRBbJM9G/YOINBoDMngjNvwgVnaLk/o34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186299; c=relaxed/simple;
	bh=nviFf11pLuRvHWiXATvCzJhwHu5KlkUdaS4t0HhOFTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8bijtCmQCfblHzrD7rHIH24fGXbrQ3A9DhVVKhAzrR5pPtn0Fx6Jvn9K7Lgrly7k71yuTOoknrqbRopv4oQlHFa08lNYxJ7aRdBChIjUifDdN6HtVW7j8yZ9fMaBCc9RG5CHjHhZVqtxChf2W4+KtfIwg01LSjyZxC5rkHSQbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LITTDiu0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LITTDiu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5201F000E9;
	Mon, 31 Aug 2026 14:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788186297;
	bh=kN8VVuJjyCRIfJGd2CWhuOieF+fTB+JhsXqBxWFw1xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LITTDiu0TuhGMwuKMF4EXuPsKnjGbNXD03w0qkxXneBOu0Oe10rqqshgvKt1bkagg
	 2SiU7E2iSn5d158K4qcu8jAYR0b8GxPGeomms8nTm6p6TfxBBi9jTogLrej/XhKnmI
	 xHkGwjNTm3O8d5s/si0eRHDbveXkajHPlfcNAoe5eJqljzEKT5Q9YTIFrI7cKG9Kqn
	 C4EZc9ZL6Y82v89T5/YbMiIJozMIJ7w0J+7FJh0WxKknNBj8JaAFY5YbCUtJ01ZTA4
	 6JKoQy1jNjb1P4pVGo1xRiZ79kkLnWFuWz8qIMxy2UM6TLllD8pXB/29evc3afAq0X
	 CpFwtqwBDWCkg==
Date: Mon, 31 Aug 2026 17:24:50 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Chas Williams <3chas3@gmail.com>, Duncan Sands <duncan.sands@free.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	accessrunner-general@lists.sourceforge.net,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] USB: usbfs: replace __get_free_page() with kmalloc()
Message-ID: <apWOslh5BF-ISQ6f@kernel.org>
References: <20260830-usb-v1-0-aa349c302246@kernel.org>
 <20260830-usb-v1-1-aa349c302246@kernel.org>
 <ea165ff8-cda2-4fed-9354-1d14ac2d87ca@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea165ff8-cda2-4fed-9354-1d14ac2d87ca@suse.com>

On Mon, Aug 31, 2026 at 03:27:07PM +0200, Oliver Neukum wrote:
> On 30.08.26 10:10, Mike Rapoport (Microsoft) wrote:
> > do_proc_control() allocates a temporary buffer for the data stage of a
> > control transfer issued from userspace.
> > 
> > This buffer can be allocated with kmalloc() as there's nothing special
> > about it to go directly to the page allocator.
> 
> You are breaking the calculation. A page has a size of exactly
> PAGE_SIZE. A kmalloced object of PAGE_SIZE is larger. That is
> a bad idea.

What calculation does it break and why do you say that kmalloc(PAGE_SIZE)
gives you an object larger than PAGE_SIZE?
 
> 	Regards
> 		Oliver
> 

-- 
Sincerely yours,
Mike.
