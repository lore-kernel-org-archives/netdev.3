Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036991;
	b=w6FqrQn+2d3lsd6T1iyRQNxU54vMeEb04WOidA00XoUXlk1u7zBlMFr4B7iAg/4iD+il
	 yUXDMbeIO3rpNOKwbUZzs0M0zI2veDFCavNHXvuJej9TuRdHREUujZznpV6bmzBT45Eds
	 q9dAcW6qXE6c11t7X4CUKCrnWgnDA76AjviHWON2QkiwQAofUcO4S6ycJA+JOk8sseFwu
	 VyMfbjCJqURvflRLQef7H8tq8u1wIPX+TZFbrn2uUxLj6rGcu4hvR3zyxo4lNkz6MXmyn
	 vhpnez4GfZtUtldegM2AfBT+noca3UR7sT3q4ff8GZNV/wxHDF/YNgmvFqvOLrwKnaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036991;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=orD7g6UPcmdsNlJx2cAfXE0bvH+N2Z5uxr3hmHyDm+4=;
	b=nZ4EaCGN2PGvU+wg+oQD3x2WR4fBpcmVUhQCZbuk7/p4amAaKx3cFgPeAsHDbWoL11Re
	 SYt07+MXB02OaZedz/Ah1xyMdSH7oBXQVB/QgQ7Q+5HIhnxi7fneXSw3dIjXxCpHLyPGL
	 yraYaueDGsMAiBOUJ8UT1Gss6/B/VlmqFufkABbs0BjepLTpnv5v4jyRsKerBTyfKPubc
	 QgtIECRphPjrYLKiDC2q+sdPS8JgGAdgB+cEfuJ0MFuRLNyzuSpwY0b5Tl5u0521kwpVK
	 4aFVNrlMwiVrA6gP/b9N7a4IZI7nEJrn6w+HNC6MXGxRJ8sB0yfbh7yNkEeUpvXotSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=EQ3cwj6v;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077BB60A2616;
	Mon, 26 Oct 2026 17:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 077BB60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=EQ3cwj6v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=orD7g6UPcmdsNlJx2cAfXE0bvH+N2Z5uxr3hmHyDm+4=; b=EQ3cwj6vy6u0oKGJx6dBj5hNcm
	f2tqIQzKAicQW+pA6YhglvraStNdeG7SbjTBQBTIFj5NjwaYNnT7fe5Yc5P2FLDiv7tlcO/zc7WJL
	KzVkK1uLWVRjLK0qFh2qwJysSYdlt/zPigDwVqNOK57lzRuFGbv8r/LmkogqXinIS/nCFp1qOaLVH
	BNi5u3+bnF9Vwj15EcrmlBWYhw3tu2r2LwksKAa/WTZzha3BQKx88fSI0Ww0crnNXQgYl89Wt9p/S
	AUqOFn5fPjEvtPxRFmse/MaWe4UWbMUVNb+LSRaO7nivRu7w4+U9yajvotLwLkLTDECeaJZQM+U9z
	RX/SrIbQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xLOpF-000qtM-20;
	Mon, 26 Oct 2026 17:49:37 +0000
Date: Mon, 26 Oct 2026 10:49:32 -0700
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, chris@chrisdown.name, 
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
Message-ID: <at-Ppa86sBw7mO8W@gmail.com>
References: <20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com>
 <87fqxskdpl.fsf@jogness.linutronix.de>
 <at84qygscue8crQi@gmail.com>
 <87a4o0k3qa.fsf@jogness.linutronix.de>
 <at9qgBucVm-QHnye@pathway.suse.cz>
 <87zew0ifpp.fsf@jogness.linutronix.de>
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
In-Reply-To: <87zew0ifpp.fsf@jogness.linutronix.de>
X-Debian-User: leitao

On Mon, Oct 26, 2026 at 05:39:54PM +0106, John Ogness wrote:
> On 2026-10-26, Petr Mladek <pmladek@suse.com> wrote:
> > The "replay" approach looks like a big hammer. Many messages might get
> > duplicated, especially when the outage was small.
> >
> > A better solution might be to do not increment con->nbcon_seq
> > when the transmission failed. And try it later again.
> 
> Note that there was a time during the rework that we used to allow the
> console to return failure but decided it was too complicated [0].
> 
> The kthreads are setup to stay in their printing loop until the backlog
> is clear. Having a nice=-20 task busy-loop would be bad.
> 
> > con->write_thread() currently does not return anything. I believe that
> > it is partly a historical limit. Two problems come to my mind:
> >
> >    1. There used to be a global "console_seq" counter which was common
> >       for all console drivers. But we have a per-console counter since
> >       the commit a699449bb13b70b8bd1 ("printk: refactor and rework
> >       printing logic").
> >
> >    2. There has never been a try-later logic. But is should be easier
> >       to add it now. We have the kthreads. And even the legacy loop
> >       is able to break when there is not progress.
> 
> I suppose for only the write_thread() callback we could implement some
> sort of throttled retry if the console driver reports failure. But this
> is assuming console drivers can even detect if it successfully sent or
> not. The netconsole certainly has no method to _know_ if the UDP packet
> was received. And UARTs (asside from flow-control) also have no way to
> confirm that the other side received the data.
> 
> Breno and Sam simply want the user to trigger a replay of the full
> log. Essentially a sysrq-R but per-console. I think that is a reasonable
> request and certainly much easier than attempting some sort of
> transmission guarantee.

A bit of context on the use case from our side.

In an ideal world netconsole is enabled from early boot through the
kernel command line, but in some case this is impossible
(linux as bootloaders - ipxe/sd-stubs/etc).

The other way to setup netconsole is to create a new target at runtime
through configfs. Netconsole then only sends messages from the time the
target is enabled.

For this second case, I would like to replay the whole kernel log on
netconsole, such as previous messages. Something might have happened
before the target was enabled, and we want visibility into that.

That said, the "per-console counter" might work as well, since it would
start as 0, thus, we know that netconsole target would be behind, and
try to replay? (not sure how yet)

That said, one way or another might work for our purposes ?!

Thanks for the proposal and discussions,
--breno

