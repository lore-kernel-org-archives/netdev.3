Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F304A0910;
	Tue,  8 Sep 2026 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858770; cv=none; b=Rd00+8qHLgBaXfaDZ3QloyRFTINgKTnymWZA6lD54kBnyI7PWtX+dTliXNMHKZY4tPHlVM6sYtcmSF1fLYzpm+d7jXbgUx5CHPQIw2XvB+bZzXZB185cer3be4tTr89VGHnllhDparpykCcZyn+bVXpo09FN43iH+ucaX1NdFpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858770; c=relaxed/simple;
	bh=5KSjFDdfPDhsCtXNDbc+d28OvtF65VgObPEUTNhvrbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+BhxIWkiypRg6hf4gaWRicAlBPNBe1iaxX0SlpcebB+YyEhm1l3dY6a8K6lCj6ySmcMKnq4WLey/5O1mU+jl0XCWWehS9KdyppyZVdqJAIj1WUpZhKQY8hYfedbuFdOfoZLryQGVZkql00kZvYi8UuRulosz2henbIjIgREeII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89C01F00A3A;
	Tue,  8 Sep 2026 09:12:48 +0000 (UTC)
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3rsU-00000001HWH-0VlQ;
	Tue, 08 Sep 2026 11:12:30 +0200
Date: Tue, 8 Sep 2026 11:12:30 +0200
From: Johan Hovold <johan@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Chas Williams <3chas3@gmail.com>, Duncan Sands <duncan.sands@free.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	accessrunner-general@lists.sourceforge.net,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/4] USB: replace page allocator calls with kmalloc()
Message-ID: <ap_Rfkrp73Ify53T@hovoldconsulting.com>
References: <20260830-usb-v1-0-aa349c302246@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830-usb-v1-0-aa349c302246@kernel.org>

On Sun, Aug 30, 2026 at 11:10:36AM +0300, Mike Rapoport (Microsoft) wrote:
> This is a (small) part of larger work of replacing page allocator calls
> with kmalloc.

> Mike Rapoport (Microsoft) (4):
>       USB: usbfs: replace __get_free_page() with kmalloc()
>       USB: cxacru: replace __get_free_page() with kmalloc()
>       USB: speedtch: replace __get_free_page() with kmalloc()

>       USB: serial: wwan: replace __get_free_page() with kmalloc()

I have applied the USB serial one now, thanks.

>  drivers/usb/atm/cxacru.c      | 16 ++++++++--------
>  drivers/usb/atm/speedtch.c    |  4 ++--
>  drivers/usb/core/devio.c      |  4 ++--
>  drivers/usb/serial/usb_wwan.c |  6 +++---
>  4 files changed, 15 insertions(+), 15 deletions(-)

Johan
