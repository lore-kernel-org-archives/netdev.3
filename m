Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319B821CC71;
	Sun, 14 Jun 2026 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781395355; cv=none; b=mW/7ddtfHSX94cIjSai/resQkJH6kzPoYadbDn2ICwcPBNflLBu0L81YGpQoR56VNp/yFGk+gt7izv+JyenG1PFvrg5WOVMwQ/y48cKt/ccKKOUgCDOkIbyamehE324rZcRI/CLKDF2AMiLky1DiUwTxdcUJLwF+cmi7eKjiJR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781395355; c=relaxed/simple;
	bh=rvVzlOQ6y6wSQB0yE2XlFDy53K5ZdAVMXYRAJlb0Kvw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZgW439sX0ts39R084xwDuZBs4Sfk03xmD187AgAunDwBSkymMS0/n4lABb3ufieGzQemqqqjIevfXNrXgaQw/wASBtWz7Sf6PTnKkZz28jDn0g8EXa9hjjEHkGWySz6ND46hp2iOaCnU+UNCau+S9jPyEIwxcTeP1m0+iF4zmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8+/FBqh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8+/FBqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28741F000E9;
	Sun, 14 Jun 2026 00:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781395353;
	bh=4Yx3FPQz4iDZ2/ZoynPnkhrf+W8Z+yA2zAeY5Q1zQ0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q8+/FBqhnX7OmwVOyQzDIpOHoxepynz4tqpCn2VDn2Ei2HDLsKntXF7X0tTgNotI0
	 KdxxF8J5i/4FbHl3G4T+SVZuwjwEkcguBd3QIZuENPdeGemfuairBKQxxQ+Z2Cu/Ze
	 2gvx6x3/mCEk9oVmvetWeMMb77ZGle2gzSzhTY2s40jKYU8GcX9RqOUOCr3BqVu9Pu
	 GB3jRaqEkWkBW/Hiwz4iSKXibj5Qo/u7WUhyBTkijkVt1oTife4wvsoT65vjOsZdd8
	 mwW04iZdD0/Z0pxKPBuG/t846ke2Fn2iJz7AEMblW78Ado0/lTJCm0225F/BpQ+SVm
	 +Dc83xwlRqyAQ==
Date: Sat, 13 Jun 2026 17:02:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Jens Axboe
 <axboe@kernel.dk>, Yael Chemla <ychemla@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] netdev: expose io_uring rx_page_order
 order via netlink
Message-ID: <20260613170232.6f9e72ba@kernel.org>
In-Reply-To: <b581d253-135b-4c75-a50d-2049c6d6e249@nvidia.com>
References: <20260612211709.1456966-2-dtatulea@nvidia.com>
	<20260612211709.1456966-3-dtatulea@nvidia.com>
	<d0401fab-61c5-43e7-93ae-d4757433eb7a@gmail.com>
	<b581d253-135b-4c75-a50d-2049c6d6e249@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jun 2026 16:09:03 +0200 Dragos Tatulea wrote:
> On 13.06.26 11:53, Pavel Begunkov wrote:
> > On 6/12/26 22:17, Dragos Tatulea wrote:  
> >> This adds observability for the io_uring zcrx rx-buf-len configuration.  
> > 
> > It might be nicer to look it up in the queue, e.g. rxq->mp_params,
> > and make it a queue attribute instead of zcrx specific one. In either
> > case, no objections.
>   
> In io_pp_nl_fill() or in page_pool_nl_fill() as it was done in v1 for order?

It's fine. We decided to make the "page size" a memory provider
property, now we're going back to making it a queue level param? 
Like my RFC had that everyone hated so much? Sigh.
