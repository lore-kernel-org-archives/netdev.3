Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4822C11C4;
	Fri, 17 Jul 2026 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296092; cv=none; b=adJj2q7r8sFwtx3Y5o7tlQTfT28fQFtfHBXCdfN1cnwD8SArmufW4doKpLMxNSWHMinPJXKQX5qnHPMJKeA7CE+eofZXP02iBW1NiaPW32ix8anjGmkiRxxRr6Tx0DtQY8dO8OYDPGdHTmUsFXcbXJP1G6+4HUqFt8x862frfH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296092; c=relaxed/simple;
	bh=SDjLLjLjj/PY7dj+tDmmUJVM2sPanb6HqHVWg9VdznI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NClnlifL6JxUbSG4xpOYwLQJJSqCkVvMV6jykJhXWC2OAEDdNdtH2xXLVzI8c3MW9VMlamQJr9acaIxOhWXeGeJ5u/P0S1Th77Bs6wG4juVXcegPCz6GdKI8IO4F6flYQ67noZZJPXi01geF5rP4eJjlUUNBp3BDTRM5dJfag+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i5wS+SS9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i5wS+SS9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=IE/uhBfHarutxeKsGlFRc4pf5fz0ECUu1pnbHJvzzbg=; b=i5wS+SS99JRiIVgCgXJbu7Lx8+
	JO1r2mq7mWUsTp17zWs8UXsKrUNqavmcJfBP1YGf03CbAVsVYSzcry38abdDRghVcTMrZawjQOo4B
	TmGWM9POTKFC2oNYlPCRzhirmoai5P2wumjfzDKS1id8/IjKo4ZXjaKx7bP9ucXEtsB/KbOd142At
	jPqXC/tcHkdhyQ9NHPh7HaNU5hc8UqJU/8xFds3A+E659u6DPpq9gSZLns9wcsm5OTTrmN1VmgHAi
	VIU8VmBImXZP8hTSlEgskHnAJ92WTt9rOZpGT6PJ5IIcEVgNSFMw3umaYOznANxA0YJZ5e8Lzo0/t
	IRY4Pb0g==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkiuv-000000056zw-3SKZ;
	Fri, 17 Jul 2026 13:47:53 +0000
Date: Fri, 17 Jul 2026 14:47:53 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Usama Arif <usama.arif@linux.dev>, Breno Leitao <leitao@debian.org>,
	davem@davemloft.net, horms@kernel.org, kuba@kernel.org,
	kuniyu@google.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, willemb@google.com,
	shakeel.butt@linux.dev, hannes@cmpxchg.org, riel@surriel.com,
	kernel-team@meta.com
Subject: Re: [PATCH] net: use sync wakeups for socket error reports
Message-ID: <aloyifAWjpPlyja2@casper.infradead.org>
References: <20260708133815.3419465-1-usama.arif@linux.dev>
 <ak5rH-SWjiqR6MVe@gmail.com>
 <bc16e45e-32ef-45d8-99af-14f088733ab3@linux.dev>
 <CANn89iLc1Bv_wmKvr_9mtGRM3gL7kgoy2Prr2SgtHY4C=ZgfBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLc1Bv_wmKvr_9mtGRM3gL7kgoy2Prr2SgtHY4C=ZgfBg@mail.gmail.com>

On Wed, Jul 08, 2026 at 06:32:02PM +0200, Eric Dumazet wrote:
> On Wed, Jul 8, 2026 at 6:09 PM Usama Arif <usama.arif@linux.dev> wrote:
> > So the workload has SO_TIMESTAMPING enabled on its TCP sockets, and every
> > packet completion and every ACK triggers a timestamp delivery through the
> > error-queue path, which is why sock_def_error_report fires.
> 
> It seems we can not please everyone.
> 
> https://lore.kernel.org/netdev/20260526063650.952-1-xuewen.yan@unisoc.com/
> 
> Perhaps this SYNC heuristic should be a per-socket choice so that
> applications can decide what is best for them.

Instead of adding a new socket option, perhaps use SO_TIMESTAMPING to
decide whether to use sync or not?  There could be other socket options
which also report a high rate of "errors", but until those show up I
think just testing on this one socket option should be fine.
