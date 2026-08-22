Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DF42D7380;
	Sat, 22 Aug 2026 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787427600; cv=none; b=HI2zAeT5SDMZsSoAHtuZVKNTuSyh8IcqFreZETwgExzY7v6k6h05dbsJnjXnS4hO1F3OP9J43WqkxlnDCKRg1er+vifWHRSA8LGmWGAu/+sA+sUzdlOuJEqqw3SLQxdpNIwlMZPj/kqFhQk22Pgy8Q68ZHVcuQ2zligLG2oCHh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787427600; c=relaxed/simple;
	bh=kfeC3NeJqTgRqfqBUjQMPtFbasJ7U0wyyatf7ASGPA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZVLi6T3094Hy0/1mu3LET6VtLk6FDLiQ0+G0Xi2GiF4jAH5IyAXCnoTxfKwBPdFowItih3vXCyez2QYrTJli1hZl0JfsgDUMZfAoPwjJ4+6QjxvHWs6hXPAo5z+I9ftKjjXPkkCnmkoFHSpQgdtrVJVtUIbN1QHV7DaRUYV8gxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMkXQeN0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMkXQeN0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7E01F000E9;
	Sat, 22 Aug 2026 19:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787427598;
	bh=0gB48hsM8D09oZOvTxdLmZqdRHCjQtDpRG3lj8gZTtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hMkXQeN0M8hMB8BY9EefEcoq8uJpsbWWicnfwCiU7E6xifvZyAaUm1JvTFpC6m5sV
	 OW3mzIh92ap+LYooShjCpBqLSGKd1P2e+WwUzt9GlyR3Q5HBdoYc2xf0glszhWUOIv
	 ZsCX6CWYa0f3rK/CrvQBldyuQ6iC9+klTQgpjCZ3ps7w2Xn25JzPRn4DVLlcIqImD8
	 BngC6C3F1s0RiU741bZeXWd+dCsuJWI1Z1FGpHLczeTJieNwHUaVMhs07e5gxBlGGP
	 DrO7YC11Tq8aMCFu5z+grOcMwpkj03Mf0xMSl/dXoTfXJMwh7xyN7hSbDNoflC1pcJ
	 iDdzu+8pis0OA==
Date: Sat, 22 Aug 2026 12:39:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, Simon Horman
 <horms@kernel.org>, Jens Axboe <axboe@kernel.dk>, Martin KaFai Lau
 <martin.lau@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, Christoph Hellwig
 <hch@lst.de>
Subject: Re: [PATCH net v2] net/socket: remove unused
 do_sock_{set,get}sockopt() exports
Message-ID: <20260822123957.694f2812@kernel.org>
In-Reply-To: <20260821-hch_not_export-v2-1-c62b62ec459f@debian.org>
References: <20260821-hch_not_export-v2-1-c62b62ec459f@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 01:28:32 -0700 Breno Leitao wrote:
> do_sock_setsockopt() and do_sock_getsockopt() have been exported since
> they were split out of the syscall handlers for io_uring to reuse.
> 
> io_uring is the only caller outside net/socket.c, and it is never
> modular: cmd_net.o is built under obj-$(CONFIG_NET), and both CONFIG_NET
> and CONFIG_IO_URING are bool. The declarations in <net/sock.h> are all
> it needs, so no module has ever been able to use these exports.

FTR I'd prefer this export (or something along these lines) to having 
to add individual helpers for every sockopt for in-kernel networking
socket users. Maybe other maintainers disagree.
