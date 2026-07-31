Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA913489878;
	Fri, 31 Jul 2026 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486337; cv=none; b=irmPVxjDUayQX3Gs+4Gyb1ksdQALPx1zVWyoqpuoIbgc9J+a/Udk/mm3eNDiKG4tALvMgPkaCwZaIOGeBfzQi5wGQ8ogaVVG+jsQ0oXcbkGUdKDOa5C2ZXILf1fcpfKTBFVjDhiZuSmGuygXROZUoW4JBtk9d/SX/+8APofheYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486337; c=relaxed/simple;
	bh=toQGT/zy1pItrcboI/TL/RRYM1uULt6AY9cmIRyJcZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uecW9wumwS+2j4cUwwIepIEBdWs6oDE/7R3fCti0uSVEjQpNy67vpGVvy1rdA2Qwh03HIu6+l/55OoO0En8jNBDEnXBBNhaGGHBF2VfC0qnoO7+rJuL+SMIKJz/oRvuWqGR6Sd4SRaQEnDejJFhyROKlbcRAkXoywVF6iPOGmIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3/dq3pJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3/dq3pJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B202F1F000E9;
	Fri, 31 Jul 2026 08:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785486332;
	bh=2jrNS/3BKn3yfUgnoF6T2QqsfjfKQsBmz4AL8EtE+YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R3/dq3pJJW7Wvs/1rk3w/7xsyZ73u7/LxlygJVeobUBwAHApTn7eq097IXWEEa3Et
	 KPEkG2R9TsmXaIu98DpsEmO7i6trQJLLHqWQJ5QJ8pwR/DcQsZZS43Qjmt2psygTIR
	 1okBWL4VhEvs1P0G45/tv/Hvce/2CM+Nc5wdpS3qVMvHIkX8BLVTUKOsZKmnZO1C73
	 PWEYu3/I8hxDPf3JQTmAikN4anYvB0WY4y12ZI0O5yaoVBV8/XWijf9W0oXPMbPrnE
	 aOA1a/7p40WOkhnGuaGKQSsrrote5XlkxO6hdhXSW5uSM2+ej7yxHv8TRXUa8eR2hX
	 QtI77yoMAgCnw==
Date: Fri, 31 Jul 2026 09:25:26 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	Satha Rao <skoteshwar@marvell.com>
Subject: Re: [PATCH v3 net-next] octeontx2-af: add new mbox to support sync
 cycle on rx path
Message-ID: <20260731082526.GF51943@horms.kernel.org>
References: <20260727101608.300290-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727101608.300290-1-rkannoth@marvell.com>

On Mon, Jul 27, 2026 at 03:46:08PM +0530, Ratheesh Kannoth wrote:
> From: Satha Rao <skoteshwar@marvell.com>
> 
> sync ensures that all packets that were in flight are flushed out to
> memory. This can be used to assist in the tearing down of an active RQ.
> 
> To complete disabling RQs or disabling SMQ and its SQs, LF software
> send mbox to AF to complete RX_SW_SYNC.
> 
> Both VF and PF and invoke this mbox.
> 
> Signed-off-by: Satha Rao <skoteshwar@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---
> v2 -> v3: Addressed Simon comments
> 	https://lore.kernel.org/netdev/20260715041239.2052888-1-rkannoth@marvell.com/
> v1 -> v2: https://lore.kernel.org/netdev/20260715041239.2052888-1-rkannoth@marvell.com/

Reviewed-by: Simon Horman <horms@kernel.org>

I see that Sashiko still flags a number of issues.
However, and while I don't believe they should block progress of this patch,
I would appreciate it if you could check over them.
