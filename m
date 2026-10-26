Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020193;
	b=j5tse2tcR9ykHYPT25GYYP1uunjbjIX76GQenHemBywqqVbJINOrjla6PURb06W2s8b7
	 0KQERTOUIoB5R4uzUDcl89f29XsO8ksDqPSgMDpBPDrHaj78l2CCbnJZ741aZF8Hz5T+q
	 LRIECdUGuUQ76Pqu/IFqTV9xWDeXVVRydv5ZmYL1FZJRXk7zvERIgUGs/05qXcZ2rRw1f
	 bdQ3oUVepxoXh26msFQ4f71+u/UdoUrzDkIwAMqFW0j5+gdYsWFIIEl3MVEZTnIxIsur0
	 ZX0oGuXrQ5iwsiuiXwt+5JZUfG4ydO284lNxhUBMBJoWiyaJz6O1n5t0IjoEe2ZJ2wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020193;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=gp7VP+Sir6E2FHA7V5/S6LXflY3MgarH/fCbeQrsJrQ=;
	b=MlUoHBx5Oc2+mV6TOYgDWtxDMcNdwfogBHcAM+/ZCw23kVh2J65ZiWPVlJ4ww+UhNaVh
	 5FAG8mN1AGC6J8HaVDmYZgXcDRmVBewhKwj/sqDlrBUGR/tik15s1d0r99n7aFesw//AE
	 bXlBkF8910kxFdn2ETx1M/N/LG9ZkDwOHEd/vXWGlefnnZj6ESvJL3rxBKxrViMXu5KmU
	 o0twt36MVROnCPuULr4yrleCKrLEi0WtOixasnSTE8AvdKHUIGlswvp+S/oWmXQnThxts
	 fdbaXFwdIRgwc2cr9BCaYXuVELy4v10/QDLVRe0JuZCbzfRtZraKLeSCSxFAmb765KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=lEllKBMD;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=+4U4xjdp;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C894606A31A;
	Mon, 26 Oct 2026 13:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C894606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=lEllKBMD;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=+4U4xjdp
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793020190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gp7VP+Sir6E2FHA7V5/S6LXflY3MgarH/fCbeQrsJrQ=;
	b=lEllKBMD3j5AQU/ymi7dm7LBf39LKBdUW9xtN8TBEtZvAYnfcvwkqiztMVErHzfYYeuRng
	H8EV5vmChV19qJkho0qbv1IJo7kNjWDDEsAtJ9O5wY+rmB8KD/sdqc7xd3+Q6QZyAnCbmR
	ZH16OxpixeOqpqzRlxxJbNJP/xEmgkP2sH/0t356l0msaFNMunG8+NLRAX1jD+L+S1nQtf
	4pYh3iepK6ROHv/C+LEplHEcwkICKNeXFBlU8i+gLI7sLwKYqCx8iy20hn9cwlGw9g2CCL
	UAD0+p6GkozsR+0WlC8Iy1mbQINaCVc1nyxnrLfw7Ep6IvnB6+q0t/L74bGQYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793020190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gp7VP+Sir6E2FHA7V5/S6LXflY3MgarH/fCbeQrsJrQ=;
	b=+4U4xjdp9taVuECH0lINOoZa2iar2hBEGD++XtCM9eGKm7CGVdxYLsiGenWM4pnhlh07Sg
	YrXXmtV8pZ9UBwDg==
To: Breno Leitao <leitao@debian.org>, chris@chrisdown.name
Cc: Sam Crossley <samuelcrossley@gmail.com>, Thomas Gleixner
 <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Paolo Abeni <pabeni@redhat.com>, Randy Dunlap
 <rdunlap@infradead.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] netconsole: allow replaying the printk buffer
 on demand
In-Reply-To: <at84qygscue8crQi@gmail.com>
References: <20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com>
 <87fqxskdpl.fsf@jogness.linutronix.de> <at84qygscue8crQi@gmail.com>
Date: Mon, 26 Oct 2026 14:15:49 +0106
Message-ID: <87a4o0k3qa.fsf@jogness.linutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-26, Breno Leitao <leitao@debian.org> wrote:
>> In the per-console loglevel series Chris Down introduces [2]
>> /sys/class/console/ to sysfs. This is where we would put all the
>> upcoming per-console knobs. I would expect a replay trigger would fit
>> well there.
>
> That makes sense from a design perspective. Thanks for the direction.
>
> So the next step would be to add a basic /sys/class/console/, similar to
> [2], and put a `replay` entry in it. 
>
>
> That would be about three patches:
>
>   1. Create /sys/class/console/, similar to [2] but without any loglevel
>      handling. cdown can build on it when respinning the loglevel series.
>   2. Add the per-console replay helper, similar to [3].
>   3. Add the first entry (/sys/class/console/replay), which triggers the
>      helper from patch 2.
>
> Is that what you have in mind?

Yes. But perhaps someone else wants to provide some feedback about this?

John

>> [2] https://lore.kernel.org/lkml/84b8d91693e56f6026271bc40553bcb6657ab24d.1764272407.git.chris@chrisdown.name/
>
> [3] https://lore.kernel.org/all/20261024-netcons-replay-upstream-v1-1-9613f38496e5@gmail.com/
