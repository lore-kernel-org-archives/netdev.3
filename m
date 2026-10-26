Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007260;
	b=aQiiNs+0G51iKImuYZBsWDrgYCvYrH4Q9GuFWGfTr2wWEEBv3Mr3O2hI7/P0Pv+a/Gis
	 tBcO4Ji34T5ZCF/7rfuOipO9VkRUxhBZyXvyBzWIWOrL73w2cW1cDrRSBoC/21QQxgC4Z
	 iiS5drvhPcg5dyU/L2ofkiQ3bWykYMc3Zt/VdDTroHnjLDvakQRYi/ijShmtlisbJ3LY2
	 1Rdr38R/2QiNq4bIAfVBlVCtFiqnhTy2HLNBUqC6h1T+2Oo/YD8IprvGkAC0xTpbgzbmk
	 C6WiCLFl9D+k5kxPDo/E6mCKdLdAcKfCtLpQFBx18+oRoSbikYdqd1P9O4Gxp7+A/8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007260;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=L1ymgsTx7zbrSnuGx/+j28LBgSYyFss7BFigmOxmN7E=;
	b=mkrSTjM4v3pg1o89en5cyDnfCAvnPfwWeKJ9isWGhLU2tyWeuFrVTnTOa29tIBYNCAhv
	 87X+YHuM+vMSao97bOfFZxTAXJZFOV1rBZ6FfDET4PGfj/BQj8LNQgMnHrGo+KeTpq4Sw
	 YpYr5ACSLYL2QcSZx/51yDTWbh3lEjrcs4LQB8Lz6hnyRrrxsuKQbpj+REVJnvcK7OKjQ
	 2xGW8i91wC3J5L6WfYtkXXH5q6dLGXamji3S6flmFuhBbK2DZFTBNvukei3W+oQdmzRUZ
	 5+cFVGEKJcY3AagVf6SaJ9vyk+OtR4LN+wbO1taGy6yJ3z/q4HXHUIKXg6vZsSwWiFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=MYPRHHnN;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="f488/DKx";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4F9606A31A;
	Mon, 26 Oct 2026 09:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F4F9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=MYPRHHnN;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=f488/DKx
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793007255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L1ymgsTx7zbrSnuGx/+j28LBgSYyFss7BFigmOxmN7E=;
	b=MYPRHHnNRJyIyZAafai3OlVck/LBfipmLsFd1uBV05RO43XUV9vlX1L7KaKLbW5y0XI5tD
	FEqmQwYvrq+JMR+6aSixRpCeyo3Wlda/oOOycEyc2JVaoe7yTZqLzNvbCN1W4y0P8+OKkW
	fgGXt45ndf4X2h404MVO2Inn+mTWE5VjJRTc6YXmXvp7VeTESYjSNwE+fv2tYh0RbV4uTl
	OHpt0sKjJG7HGTwJGIiCj2rysliDEEpt+wVUW9SzY+oq1u+c8G6M5jtvAovMC7AKSBxEFB
	FNTI5Sh43fUN0RvfDcLnXogl6uNCh8WjpDqL5sfmInhMtA/QbwiGbSeMUX+nPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793007255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L1ymgsTx7zbrSnuGx/+j28LBgSYyFss7BFigmOxmN7E=;
	b=f488/DKxBR+0unnvdDl0e1iGAmJYebfOUQ7iCvv3RB9d/iTAJr37dC5hD7a+lzIonlicXl
	iFRxa/k8nph947DA==
To: Sam Crossley <samuelcrossley@gmail.com>, Thomas Gleixner
 <tglx@kernel.org>, Breno Leitao <leitao@debian.org>, Petr Mladek
 <pmladek@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Paolo Abeni
 <pabeni@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Sam Crossley <samuelcrossley@gmail.com>
Subject: Re: [PATCH RFC 0/2] netconsole: allow replaying the printk buffer
 on demand
In-Reply-To: <20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com>
References: <20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com>
Date: Mon, 26 Oct 2026 10:40:14 +0106
Message-ID: <87fqxskdpl.fsf@jogness.linutronix.de>
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

On 2026-10-24, Sam Crossley <samuelcrossley@gmail.com> wrote:
> Netconsole only forwards records while an enabled target and its
> transport are available. A target enabled after boot, or one that was
> unreachable during a network outage, leaves a gap in the remote log that
> cannot currently be recovered.

This situation is no different than connecting a UART sometime after
boot, or having unplugged a serial cable temporarily during runtime.

> This adds a write-only "replay" attribute to the netconsole configfs
> subsystem that rewinds the netconsole consoles so the retained ring is
> re-sent.

I would prefer that we find a more general interface for this. One that
can apply to all consoles, not just netconsole.

We have a couple console features planned or in discussion: per-console
loglevels [0] and per-console unsafe dumping/ordering [1]. Both of these
are per-console, meaning they also involve the netconsole.

I think we need the netconsole to support a general console interface
rather than introducing netconsole-only knobs (particularly when such
features could be valid for any console).

In the per-console loglevel series Chris Down introduces [2]
/sys/class/console/ to sysfs. This is where we would put all the
upcoming per-console knobs. I would expect a replay trigger would fit
well there.

John Ogness

[0] https://lore.kernel.org/lkml/cover.1764272407.git.chris@chrisdown.name/
[1] https://lore.kernel.org/lkml/87bj8kkfwk.fsf@jogness.linutronix.de/
[2] https://lore.kernel.org/lkml/84b8d91693e56f6026271bc40553bcb6657ab24d.1764272407.git.chris@chrisdown.name/
