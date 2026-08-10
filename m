Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF1032F76D;
	Mon, 10 Aug 2026 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377435; cv=none; b=JIWkz1WifmJtdgJwLw+nehawFjB9+7DvTjkBCi0l2gsCPJDqqA4mO2A5j44VkQmsX5RM8opKKsiJkAwfRQzp2KAP86ExlT2xJHwlv+65r6SWPwgMOz/cAfGYkRCJLhXOQ1ViLgK4nKqydj9B/2Ud7ww/COdSOhMgVMlbPoEQnJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377435; c=relaxed/simple;
	bh=kHGKPJhC9uM0+PGeFLVkUZNw8pUvpNOVe5YtebaQGow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlXHVoL7cU13Yy5N8mQrU0E+6adPG7zYpGHGFgnGYR4xSXXuABTon4SmWHtbN2VuAEOByaTEo3vdqxZn0w4bB0oJ5MtbLN6LjMQjPbVibmuOPUKnAQ1ZZviQGx9J3zEdJB4yyBuBkzOaYMyoT00QceAX8UGm34dYhRQnPOfmvE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FZ8xWMdp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FZ8xWMdp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LXP69DgZsBhPLIDftgBYQMeZY65q4fXqNb+N+1nniuA=; b=FZ8xWMdp8ay2XNYrinFegvJE4B
	mRA+1r5KSjA+yG3tqXk7F+4VCtM4WgpQ6eZXtUHu9lQE/G8qaORaR6YzicwWZATwg2NzXWJX9j69P
	f0dTtw8rUGD05B1HSGc3kYU0FXFGRU3VWfSikCjlAEzjH89oQUOSC95t7MUYH35dl2FnEeBTgJCKD
	Bz3mcuzhfaSKD6T7kZV+z0F/1esPpT96zhd5M6PI94P2el1nHwx7KMH+GWGcuvoKhIiUgPKD1iFsd
	BVe10LgdX8aRDD2V6ZmBDw7Oy/YVGnMYBd/yQusW6hXXZ/KrKDuF9pD6ocvjOnnQpbUiQOLuxH9n4
	npFkD+bg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtSMk-0000000EiDr-2A2D;
	Mon, 10 Aug 2026 15:56:42 +0000
Date: Mon, 10 Aug 2026 16:56:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	dave.hansen@linux.intel.com, Liam.Howlett@oracle.com,
	david@kernel.org, shakeel.butt@linux.dev, vbabka@kernel.org,
	jannh@google.com, aliceryhl@google.com, arve@android.com,
	cmllamas@google.com, christian@brauner.io, tkjos@android.com,
	dsahern@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/5] mm: Make per-VMA locks available universally
Message-ID: <ann0urrWGUqQsHyq@casper.infradead.org>
References: <20260806200548.3124802-1-surenb@google.com>
 <20260806200548.3124802-2-surenb@google.com>
 <anmTYW8X6c9TgaO0@lucifer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anmTYW8X6c9TgaO0@lucifer>

On Mon, Aug 10, 2026 at 11:17:26AM +0100, Lorenzo Stoakes (ARM) wrote:
> And, in general, having consistent per-arch fault logic would be a good
> thing (TM) (and particularly - as Matthew intends to do - having shared
> code for this is a _really_ good idea, the duplication right now is
> horrible).
> 
> So perhaps Matthew could do this as part of his changes or you could follow
> up with changes to do that?
> 
> I think his work would be made easier by this being the same everywhere,
> however.

Yes, having per-VMA locks everywhere is kind of essential, so I was
planning on going second after this was merged.  Hence the careful
review ;-)

