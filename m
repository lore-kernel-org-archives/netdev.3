Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC73318EDC;
	Wed, 25 Feb 2026 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026282; cv=none; b=c5tH3L1bfO1TXAD1ngsKwg6iEzHO6Y2a+wFoWyJJOfkEeqxYpsOF3+0VvgH74f8QeFirYQfPD6jVyv8Koevp01e5T6cYL8jG/Ck6rVKUs+W4J0HLJuSr2oNiOtrUhPPz0FqQ82xWvp5qjTtI8jQOfsdn5oqiwjpREHjimMYWKP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026282; c=relaxed/simple;
	bh=OJzjoBEqubXnBRh57ag53X0jKUQHDbdGl9/XoYMZAW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxyCQP5pEzp3QcHrKFgKA9w3cQQOXnWsN+FFlso/GKeoMkir4rbUCRZuqiTVshaAlxsO8mZ9sf5vP38bdgg5KrKJgxh+33OP/ei6hc9IXtGqiD52YTkIGywiPLYn7aIhDJtyFvKS2B0RMvRSXac7REowRsy5pg8wQFlXAlhWCN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd2TlK2q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd2TlK2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8E0C116D0;
	Wed, 25 Feb 2026 13:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772026281;
	bh=OJzjoBEqubXnBRh57ag53X0jKUQHDbdGl9/XoYMZAW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hd2TlK2qYNjpsG0g5WpjZ8EDD2xi9JdZyLPydgZzIC0FvPRZ+c758RhFAtsrJGPPI
	 H0FNP8gRQNCUzR6hQVYUrswOpEKC2qjeM0clrggT0hm59gJDeViVWYtyVRKcUgLS1N
	 RTabyD3x9SlavloA2bofYuE+HuO/wmI57TUsRtpjEpPt9FGskyX4kOb0LHUHohdpm1
	 e+eIFAVCzX1rqrofkNZjmJk18SRfO1ff9M5nFzBDHGR3kGmpJAxHdG/0n0PqvXAVnH
	 70tjKi2Hygx3QSmu8lkHUUuZwF7uNit/7SfZ/FcfN4j0YaceOQyU8HiduRT9fn4m0x
	 SW/JStA8stihw==
Date: Wed, 25 Feb 2026 13:31:17 +0000
From: Simon Horman <horms@kernel.org>
To: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] net: core: fix logical inconsistency in
 failover_slave_register()
Message-ID: <aZ75pXG8MdOVhzrK@horms.kernel.org>
References: <20260219090216.12884-1-zeeshanahmad022019@gmail.com>
 <aZbanQC5ci7yLqzj@horms.kernel.org>
 <CAPBWGpEzZk8oUqxD_N0mOqVw8p09Xidf7g0kfUnpm=gyZBqftQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPBWGpEzZk8oUqxD_N0mOqVw8p09Xidf7g0kfUnpm=gyZBqftQ@mail.gmail.com>

On Wed, Feb 25, 2026 at 03:04:25PM +0500, Zeeshan Ahmad wrote:
> Hi Simon,
> 
> Thank you for the detailed feedback.
> 
> On Thu, Feb 19, 2026 at 2:40 PM Simon Horman <horms@kernel.org> wrote:
> > It's not entirely clear to me what the behaviour should be if fops is
> > NULL, or indeed if fops can be NULL.
> 
> I've performed a deeper audit of the failover module and found that
> failover_register() currently allows a master instance to be registered
> with ops = NULL. This appears to be the root of the issue. However, I
> checked all current in-tree callers (e.g. net_failover.c) and confirmed
> they always pass valid ops. So while it practically doesn't happen
> today, the framework technically allows this inconsistent state.

Thanks. I did a not very deep audit before writing my previous email.
And my conclusion from that was the same as yours.

> 
> > So I think it would be best to do the same here - that is modify the
> > code around line 66 to make it conditional on fops not being NULL.
> > Otherwise, if fops is NULL then steps that would have been taken are
> > skipped.
> 
> Wouldn't skipping the rx_handler registration at line 66 lead to an
> inconsistent state? If we skip that hook but continue to link the slave
> to the master (line 75) and set the failover flags (line 83), the device
> might appear linked but the data path would remain unhooked. This
> concern is why I am leaning toward a more definitive "abort" if fops
> is missing.
> 
> > It is true that in those steps would never be reached and the kernel
> > would have panic'ed due to a NULL dereference on line 66. So maybe your
> > approach is better, perhaps with the addition of a WARN_ON_ONCE.
> 
> I agree that WARN_ON_ONCE(!fops) is the best way to handle this. It
> provides a clear signal to developers of a misconfiguration without
> allowing the kernel to panic.

Agree, that seems to be the best plan.

> Based on this, I will prepare a v2 targeting the 'net' tree. It will use
> the WARN_ON_ONCE check to both prevent the panic and abort the
> registration (returning NOTIFY_DONE) to prevent an inconsistent failover
> state.

Great, thanks.
