Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116485;
	b=AyOsv7aeOTG2gpKtnzS1UHyd4xsDDyTOrAoAVaMkL7+QrQfYwfWAGI/g0bkIyxmFdXhe
	 LZbS+BcS2b241g+t5x4vdQGZBCQ1+BOoovsHS6uKeNjWlCa9gZlZtfCFIu5CJuFOrQgE9
	 /nqpqXPvqZ3Du86Hm25RBx1JkuyTjXQtmK+0j70mMjlGmxOACDSJ1sYD6FDsGxAvRtw1b
	 bUkdyKPb2LCqF7dR3Nc9olt8sdzRIipPnQteEUux6zEuJdxwwMK+mf1s1OZ2ysNG//aon
	 A67FIFrc3IIvfdv3tLFhpXo+UBYfbqHNbOztRhEITYjkhxzLceSYhZouJZmu4BMdCVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116485;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=9d7CkpNkhFpT/p+mmFEwEMDe8MN5hlU8W6VraSeQEx0=;
	b=JpfPJp6CR+pZNykqGFp+fZyBtrDBEbiIcMxNwDoWTDLQ0Et5hOGx5FM2tCckSH+CNrTg
	 CqXetq0bGv7Huy1Dt8zUCavUgWulb5LMLedrnCFFWjgH27hZJbOK451KT2FAQB0EbN3+s
	 9Qx8JEm6/Ykx8n8uke1Z5Chsms9Mkhv14+ziEWgi/Lx6EMYUL0cgn3qqMy4MpUZQw2A7z
	 QFCdeP+rdGWScC1MCQU1RXrIDQIxGhVmxhHWBSfx/833AeHdJRGPKvp7dm7RFsGckQgm+
	 2TC30w4Wi7OPvk6dFAfHycGlR8hVivzOs329mRqtQHQyhOhI/knStO2tNYZTdVUgEOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=hsgL9t6N;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7AD60A2607;
	Tue, 27 Oct 2026 15:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A7AD60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=hsgL9t6N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9d7CkpNkhFpT/p+mmFEwEMDe8MN5hlU8W6VraSeQEx0=; b=hsgL9t6N4NhDBmPcr0pHNiHWGU
	rugR3grg+segcnbDlY8Ttg8+hOmVAXacTi3pd5BTJITtyGaz7mCCRMdmzQey5cRAmNO+oRSWZGMqV
	1MknRS/jVF8Q9ae8fUviHfvlXwPGwE0XBlGyqKSEp5Gb+9Vm4nNAvDLlZ8alDJzv1q/7gWgUynb16
	QESxLhOjLy4P1tQ0gEOGrR4zqfXR7pk42lYXSP+Tqei90/L4T1GAenv9nVFJvqnCbrZiIWlmmAW/x
	cvYBjgdjZMWRxjff8541P7q/s1vUVNA+AATftGnzcwkXFjSz5w935VtO4/E3ZAWoNy1b2OO1cnOFX
	hLD+ZF6A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xLjVC-001ZUC-1F;
	Tue, 27 Oct 2026 15:54:18 +0000
Date: Tue, 27 Oct 2026 08:54:12 -0700
From: Breno Leitao <leitao@debian.org>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, chris@chrisdown.name, 
	Sam Crossley <samuelcrossley@gmail.com>, Thomas Gleixner <tglx@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Paolo Abeni <pabeni@redhat.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] netconsole: allow replaying the printk buffer on
 demand
Message-ID: <auDETo3ot3enCEv_@gmail.com>
References: <20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com>
 <87fqxskdpl.fsf@jogness.linutronix.de>
 <at84qygscue8crQi@gmail.com>
 <87a4o0k3qa.fsf@jogness.linutronix.de>
 <at9qgBucVm-QHnye@pathway.suse.cz>
 <87zew0ifpp.fsf@jogness.linutronix.de>
 <at-Ppa86sBw7mO8W@gmail.com>
 <auCraiuMZApQHiNA@pathway.suse.cz>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auCraiuMZApQHiNA@pathway.suse.cz>
X-Debian-User: leitao

On Tue, Oct 27, 2026 at 02:47:22PM +0100, Petr Mladek wrote:
> On Mon 2026-10-26 10:49:32, Breno Leitao wrote:
> > A bit of context on the use case from our side.
> > 
> > In an ideal world netconsole is enabled from early boot through the
> > kernel command line, but in some case this is impossible
> > (linux as bootloaders - ipxe/sd-stubs/etc).
> > 
> > The other way to setup netconsole is to create a new target at runtime
> > through configfs. Netconsole then only sends messages from the time the
> > target is enabled.
> > 
> > For this second case, I would like to replay the whole kernel log on
> > netconsole, such as previous messages. Something might have happened
> > before the target was enabled, and we want visibility into that.
> 
> Just to be sure that I understand it correctly. 
> 
> Is the netconsole registered before it gets functional, please?

Correct. The console is registered at module load time, in
init_netconsole(), before any target is created.

In other words, a single console is registered at module load, and the
netconsole targets are then handled under that same console.

> Is it possible to detect that the netconsole is not yet functional
> and when it could start working?
>
> I ask because there is the flag CON_PRINTBUFFER which should cause
> re-playing all messages on the console during registration.
> 
> A solution might be to delay the console registration until
> the netwok target is really working.

Yes, we can register the console when the target is enabled. However, I
think the user will need to choose whether the console is registered
with CON_PRINTBUFFER or not, since in some cases they only want messages
from the moment the target is enabled.

So we would probably need one console per netconsole target?

> Another solution might be to temporary block/disable the console
> until it gets operational. We already have console_suspend()/resume()
> API. But we might need something new to distinguish it from
> the system suspend/resume handling.

In that case, what happens to the console while it is suspended?

> > That said, the "per-console counter" might work as well, since it would
> > start as 0, thus, we know that netconsole target would be behind, and
> > try to replay? (not sure how yet)
> 
> This is what the console_try_replay_all() does. The only difference
> is that it resets the counter to the oldest available message,
> see __console_rewind_all(). It is just a small optimization
> when the ring buffer is already full and the oldest messages
> are gone.

Right, but that would apply to all consoles, while in our case we only
want to replay the log on a specific console (netconsole).

Thanks for the suggestions,
--breno
