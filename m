Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC093E7166;
	Mon, 24 Aug 2026 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561417; cv=none; b=hMJPRkzl4JJfKFQEhRM4rIOZ8irXmg8Z8ANFNzpZhH7ZS5MVY12LNA6RLViGoIJntzR20wR6hIVtBMelImxmRXKGpO9Yp1sCNT7KJvgKTceAAa5ntWCDEzJJSptoEhKYdqFlELbSEDks2jaxStAet2+dPn2qJsjFWB/TjIJJ6yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561417; c=relaxed/simple;
	bh=UDCnZH6SqZ8ZLoQt+7XeEDxEz5riWDzuukpb14YFURI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9GO/AJ0Dk0bAN2+lswG8mQSJUDDoRav1ltztI8cQk2oAwrJ2XGoVhtluPtfLBOLzE/vuOq4izfoRSV1/D8HPsqYnYl1znBpSpjPdUXXw+PLdGCPQ2Tsoj0ZhVCJMC1uamBGmx9HfZDAAXxwIjPGk3gxnngmjVScoOGQGML+mJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Ha3eRvV8; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Ha3eRvV8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=sdMDgUoc57rau3gVgSsFhWU4OgKainlasbVmH2X13N0=; b=Ha3eRvV8hYPrgJuPZcV/Ogez0A
	KxnuXqY600BMxWPgDpjtvtYjBWjksqW7SeBI0FwfzSScq6oAJUgipnj/JFk6uQ0tuMpZDo/3ghC+J
	82WPjT1V22W9QDL+SEaBODWcVeSbiJYoWght7G2YKZqMesoM0lsboRZsIHziXkT6zkmQItRsy/36O
	Csilgb1iRCfyPtP4ZNahZ0xKwbUUTjSFhbxCeFOrUD3iugXq1ExIuunfGtXX5VFu7JFOqPO7RozG3
	1J3VJ+evXs3CQBoyLVKOh2xx62m/q6fdS2OI91KnC8RXhVrPV03z6xnNJnkoye3rszE8BalS9jmrT
	AvanU2+A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wyQNY-00DXuI-0V;
	Mon, 24 Aug 2026 08:50:04 +0000
Date: Mon, 24 Aug 2026 01:49:59 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH net v2] net/socket: remove unused
 do_sock_{set,get}sockopt() exports
Message-ID: <aowDuGnk58kEwqO6@gmail.com>
References: <20260821-hch_not_export-v2-1-c62b62ec459f@debian.org>
 <20260822123957.694f2812@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260822123957.694f2812@kernel.org>
X-Debian-User: leitao

On Sat, Aug 22, 2026 at 12:39:57PM -0700, Jakub Kicinski wrote:
> On Fri, 21 Aug 2026 01:28:32 -0700 Breno Leitao wrote:
> > do_sock_setsockopt() and do_sock_getsockopt() have been exported since
> > they were split out of the syscall handlers for io_uring to reuse.
> > 
> > io_uring is the only caller outside net/socket.c, and it is never
> > modular: cmd_net.o is built under obj-$(CONFIG_NET), and both CONFIG_NET
> > and CONFIG_IO_URING are bool. The declarations in <net/sock.h> are all
> > it needs, so no module has ever been able to use these exports.
> 
> FTR I'd prefer this export (or something along these lines) to having 
> to add individual helpers for every sockopt for in-kernel networking
> socket users. Maybe other maintainers disagree.

Fair — you and Christoph disagree here, and the nvme-tcp series needs it
modular.

I'll park this until that settles. If we decide to keep it, I would
suggest we change it to EXPORT_SYMBOL_GPL, at least.

--
pw-bot: rejected
