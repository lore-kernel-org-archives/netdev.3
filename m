Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B98F45517B;
	Fri, 25 Sep 2026 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340874; cv=none; b=J9fr+u8tkU3GDtDXSjL1Y8se3bCjlVQBsWl22PU9tWAa7AwUJwJ7dULAvT22oPj+sgp8dzs9zmqJXeY7nL2bd9jZAk2JnJR9j74+Rtsz16yRLvy13jcGgx70LowsjmTnUq5GHvnWn0xVS4rvsGm/Jb/leCmFPu+D0RpLs0mUmrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340874; c=relaxed/simple;
	bh=TsBlZG09gavLdrMCDbHDKY20CD2rEAaAnPkuLkqN8yI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DkK22tLjnfW4lEvEejjeOzzk55A6y7kBCQt35z+bDamSQVa2BO/HbX3yJujD1vNUz0gUauO1yMGgfAUuqF4mDDZC87bEGYfb/yFd4pjTX9uTmmgamKBuI431XJSxGKs3owP4DzQJ8ThX8r2xvIYVjD8sJmy9QrZd7Nk1vW119yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4Me0D7J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4Me0D7J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D341F000FF;
	Fri, 25 Sep 2026 12:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790340872;
	bh=TsBlZG09gavLdrMCDbHDKY20CD2rEAaAnPkuLkqN8yI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=g4Me0D7JZLPIJCjaZH516iuzIlCooQGw7Q5GZJj4W36Mf8SUM9hxee7PNMzvB6+jI
	 PDRG3o9fH2T0+x2DY0xPu9qaVKMhZh+3yFMadGVFn/iUonaTL+zckkV9ZWmbwmNPr+
	 yfydtAHeIcu25IN1rJtr+F5c1aV1bNjzJmamcz80Xtv/5xsiKMLx3Sc4OF9jUmx9t6
	 OEPOu7NHVtC4fZCNbDVDpLdWkvd5J2DOhcEsn5WIZEBZFMLdX4PhpS/h7nElg0lpWO
	 lCncSQCPmU1lPZjXa5xwVHA8JOkAco9HCc+afnxFLwl5K9SElxYomLXm7MGKYLXv4M
	 Ul/yYiQSFZ8oQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Duyck <alexanderduyck@fb.com>, Jakub Kicinski
 <kuba@kernel.org>, kernel-team@meta.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell
 King <linux@armlinux.org.uk>, netdev@vger.kernel.org, Mohsin Bashir
 <mohsin.bashr@gmail.com>, "Mike Marciniszyn (Meta)"
 <mike.marciniszyn@gmail.com>, Simon Horman <horms@kernel.org>, Mina
 Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org, Sashiko
 <netdev-bot+sashiko@kernel.org>
Subject: Re: [PATCH net v2] eth: fbnic: Keep real queue counts synchronized
In-Reply-To: <arYutH9Mvn3OzR8-@gmail.com>
References: <20260924191817.1843726-1-bjorn@kernel.org>
 <arYutH9Mvn3OzR8-@gmail.com>
Date: Fri, 25 Sep 2026 14:54:30 +0200
Message-ID: <874ifdpk3d.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Breno!

Thanks for having a look!

Breno Leitao <leitao@debian.org> writes:

> Hello Bj=C3=B6rn,
>
> On Thu, Sep 24, 2026 at 09:18:15PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> If resume gets fewer vectors than the configured
>> layout needs, fail with -ENOSPC rather than silently change the queue
>> configuration and its bindings. The netdev then stays detached until a
>> later recovery or a device reprobe.
>
> I am a bit surprised that I is better to get the device permanetly
> disconnected other than just getting it running with fewer queues on
> resume.

What's the queue selection policy?

 - Memory providers and AF_XDP=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20
 - RSS indirection and contexts=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20
 - ntuple rules=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
 - Queue leases=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20

> What is reprobing it later?

Nothing does it automatically. The netdev stays detached until a later
suspend/resume gets enough vectors, or until someone rebinds the driver.
A rebind resets the channels and drops the memory-provider bindings
anyway *shrug*.

This only happens when resume gets fewer MSI-X vectors than the
configured layout uses, for example when CPUs were offlined after the
channels were set.

...*is* this a real issue, or mostly theoretical?


Enjoy the weekend!
Bj=C3=B6rn
