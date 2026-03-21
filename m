Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38982848AA;
	Sat, 21 Mar 2026 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774083997; cv=none; b=TE7Q4jqXav61c8Ak9Qf7jnaiKTpD161P1W9NWB6falYPBvL/q42h8L9UE0WkQfVwJI+fuWWJzvoX4Exui61dbyRbosgh4O1yKvTjYiPLmVYZsR3MvA87bctsUlmqFdm9bCKRxllYAnmwXvxrz16xT8uqNn4dRrOyZYoFTQAXVxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774083997; c=relaxed/simple;
	bh=8lpzYSjh3SsKrBfqRegfKYD0LBEmBPnh2kQekcYt4dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxvPyj53KB6gLwVni/8jrmX+Yu+9xUUKLoUJhDJo4Uuz9l5NQEvvKJjGw1ZmovIrfrgluVP0mUt9y0QcS2kqWp6c3qSIRiZoq/9QP2sQVesWMiAb0Tlxo7f2YIWpE9g8VdNVOHN9T6xqolv4AEEHlQplvU9p2ID/14xi9E0OK7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JT/vAoLV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JT/vAoLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA22DC19421;
	Sat, 21 Mar 2026 09:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774083996;
	bh=8lpzYSjh3SsKrBfqRegfKYD0LBEmBPnh2kQekcYt4dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JT/vAoLVBseHPwAy9j53HGl+I4H9+EO3lRgwJQMHE0O0ZP9YrdW1nHzkrlnHqax1m
	 XaQC/P7PBqeqCCmy5R6xMYRx5G00EHzrTz6Qd4JHVYcX7ZSqJAGhMkbVCiEEVwdRAf
	 XkUAxUYi+QFMh9Tk02hg9Wr+3G7DVAJVnDXUOoD4cHI7XBH7fMui00FOSBywRcBSkf
	 L76LXM8pEIUCt8RMklwNeUhg5rEQF/Juy03qkLvpfGy634gwvWCukCUCBHb9dMkJ6w
	 cGkoxLCVsaUx1nZJg/c6adihN/sgX+hwr0rkgi/a3onYRxXNz1JOYTITbY0u9jewSu
	 EXEdbNHzPd8PA==
Date: Sat, 21 Mar 2026 09:06:31 +0000
From: Simon Horman <horms@kernel.org>
To: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Cc: vikas.gupta@broadcom.com, vsrama-krishna.nemani@broadcom.com,
	edumazet@google.com, ajit.khaparde@broadcom.com, kuba@kernel.org,
	netdev@vger.kernel.org, pavan.chebbi@broadcom.com,
	rajashekar.hudumula@broadcom.com, pabeni@redhat.com,
	davem@davemloft.net, michael.chan@broadcom.com,
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 10/10] bng_en: add support for ethtool -S
 stats display
Message-ID: <20260321090631.GQ74886@horms.kernel.org>
References: <20260319055124.1350670-11-vikas.gupta@broadcom.com>
 <20260320112717.2065386-3-horms@kernel.org>
 <CANXQDta9vL5t+mxeBCqF6rzSjytLJ6PiKkvdMiv7jdOuMCzajw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXQDta9vL5t+mxeBCqF6rzSjytLJ6PiKkvdMiv7jdOuMCzajw@mail.gmail.com>

On Sat, Mar 21, 2026 at 01:21:43AM +0530, Bhargava Chenna Marreddy wrote:
> > This isn't a bug, but Documentation/networking/statistics.rst flags a
> > potential concern about interface duplication. The patch adds per-queue
> > ring statistics (rxqN_ucast_packets, rxqN_mcast_packets,
> > rxqN_bcast_packets, rxqN_ucast_bytes, rxqN_mcast_bytes, rxqN_bcast_bytes,
> > and tx equivalents) to the ethtool -S interface.
> >
> > However, this driver already implements the standard per-queue statistics
> > API via netdev_stat_ops (bnge_get_queue_stats_rx and
> > bnge_get_queue_stats_tx in bnge_netdev.c). That interface exposes
> > per-queue packets and bytes through netlink, which is the designated
> > mechanism for per-queue counters.
> >
> > According to Documentation/networking/statistics.rst, per-queue stats
> > should use the standard netdev_stat_ops interface rather than ethtool -S.
> > The documentation states that drivers should avoid adding new counters to
> > ethtool -S for values that have a standard uAPI.
> >
> > While the ethtool -S stats provide a ucast/mcast/bcast breakdown not
> > directly available from the standard per-queue API (which aggregates to
> > total packets and bytes), this still represents duplication of the
> > fundamental per-queue packet and byte counters. Could these per-queue
> > stats be omitted from ethtool -S, keeping only the truly hardware-specific
> > stats like TPA, port-level, and priority stats that don't have a standard
> > interface?
> 
> Thanks, Simon.
> 
> These counters report unicast, multicast, and broadcast traffic
> separately. This
> granularity is missing from the standard per-queue API, but we find it
> essential for
> hardware-level debugging (e.g., multicast storms or verifying RSS
> steering logic).
> 
> Since this data is lost in the standard view, would it be acceptable
> to provide these
> via ethtool -S for better visibility?

Thanks for the explanation.

I do think it is something we could explore adding to standard statistics.
F.e. if we think it will be useful for other devices too. But perhaps
that is just me.

At any rate, I think the approach taken by this patch is fine given your
explanation.

...
