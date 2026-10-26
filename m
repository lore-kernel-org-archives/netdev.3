Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015130;
	b=a8p1cVCkYzcEeYQoN/V896yLGpj0TvotY2YyW0QTVK7ACQDUFREpuA18K+nMNNUSkp4Z
	 jSC4kkJwzISIlBuMacNfc0ujSzovgyz/R6a9AkqDL6Q00xB9KgXqq28kin7hu+jDsQnQ1
	 ABJcCirgZ/56S20tYg+dPUCs/td5fq3MR9iv8vVofo674k358QRGUO4e892Lk9q7mVmTN
	 TmPXv3S8F+OpwXZQekvxLaqs9U99Mem1hVuiKkZW4QdfyG1O2PlKtyIcCNB7NP6av4LDe
	 d/bbGRJt4VX0N2Phle0BtoeFktQTRPvUaol/yybiIsdF/AsP5sEqo+O1BhIbOt6GSUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015130;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=4GBPkOJ1e/9LZha1WoEz3g+CVMBEHK4V97IQI0ow1S0=;
	b=DvKyYjGf+oGLa2TnhRxWy+Iq//eHlELs4OBlgSANUkU35uURaH/vjFn13mWDGCF+7UqL
	 0TGIeGF1BLHTETrvQkI3nDqVGa+vxrsxBRo4StiBs6ehyq+JdxYVjjBbTtzwRLI3/eiT2
	 00v3BvCXlRZgDCTp7VHG6ucBOQ00WaK1HSYIp+ayAi0a7IYCs/ckhps9ln+lIGE1nmPtW
	 V0OqjtHakckChKhojBpiNcCpt88cLkudyRWa1Wn20yoJSTlWPQjNcB2oxT02qC8w/koxQ
	 lG479gzvdLVU9z6o0Zy2tYhKuQCmLV9LY/c4m3rYd4vEDSUyw2EfKUGZNbwmcJbNKBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=er8kE+9q;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79AF606A321;
	Mon, 26 Oct 2026 11:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A79AF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=er8kE+9q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4GBPkOJ1e/9LZha1WoEz3g+CVMBEHK4V97IQI0ow1S0=; b=er8kE+9qbKNYXANxkVgY3/VCoO
	k5ST4alqnvRWYqOaThekjLUnR6vppK+VfONA7ajNJ3ncWDLtPvfrZ18m/khsse5HvWT+wzeudjhj1
	m2TOhWsLWa9eRCCuVtR7OGDPGzbDapCRqOF+PjtJ6QPNwT2/kftOJUqZFtp/Gs0eAGL6v0KeAtXJC
	Ac66iuPp57PV2V1zz1dzozQUgw4nXTJITZ/ww9/8gl/+vVQjzFMVN+VoQT+D9s9+KpyHwWGGHGvdk
	VwLHlYy8iSJt06zf69F0uwL5+rAu4fTlE/qP4a4eIAKaoe3n9QLr5ICI6uEtS0/qd0UhUPP6uc1BE
	MMTe7lGw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xLJ8R-000eZC-0Z;
	Mon, 26 Oct 2026 11:45:03 +0000
Date: Mon, 26 Oct 2026 04:44:57 -0700
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>, chris@chrisdown.name
Cc: Sam Crossley <samuelcrossley@gmail.com>, 
	Thomas Gleixner <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Paolo Abeni <pabeni@redhat.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] netconsole: allow replaying the printk buffer on
 demand
Message-ID: <at84qygscue8crQi@gmail.com>
References: <20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com>
 <87fqxskdpl.fsf@jogness.linutronix.de>
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
In-Reply-To: <87fqxskdpl.fsf@jogness.linutronix.de>
X-Debian-User: leitao

Hello John,

On Mon, Oct 26, 2026 at 10:40:14AM +0106, John Ogness wrote:
>
> In the per-console loglevel series Chris Down introduces [2]
> /sys/class/console/ to sysfs. This is where we would put all the
> upcoming per-console knobs. I would expect a replay trigger would fit
> well there.

That makes sense from a design perspective. Thanks for the direction.

So the next step would be to add a basic /sys/class/console/, similar to
[2], and put a `replay` entry in it. 


That would be about three patches:

  1. Create /sys/class/console/, similar to [2] but without any loglevel
     handling. cdown can build on it when respinning the loglevel series.
  2. Add the per-console replay helper, similar to [3].
  3. Add the first entry (/sys/class/console/replay), which triggers the
     helper from patch 2.

Is that what you have in mind?

Thanks,
--breno

> [2] https://lore.kernel.org/lkml/84b8d91693e56f6026271bc40553bcb6657ab24d.1764272407.git.chris@chrisdown.name/

[3] https://lore.kernel.org/all/20261024-netcons-replay-upstream-v1-1-9613f38496e5@gmail.com/
