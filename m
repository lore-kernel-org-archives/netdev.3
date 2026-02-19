Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9D932D0E3
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771541019; cv=none; b=DFB8xRm6Dd2TO/6qbUon3knVPzMLR0PymiufqClJtrZ0c9VSG8ibSTIfgRCAgcJddEhOq+go4XEc8Y4DTcqOzNVMTrcfWRmOLEERaN7iVMtDWCj9QtMbEXFMafP1tzELiPZUnZ1g8aYgxC+SqdWaOD6wtU74plyg202K/fM/UAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771541019; c=relaxed/simple;
	bh=3tONbSfpNRAjht6NBVP4o8UywEVtyVOU0wD/jRxJqr0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GbTfyIoiMITJ7gxvj+hfnvvVn8K2V4DEjdyshxM0Awc/iXjB+Ecj8TBeKwiDxzBuOU4RUZoz9hFySosGnyGviSh9ld9SLIHpHRadOLXKhHYTpoRn67OYhN8C5sxRVFycv8uhD4CdnRtIUAtle7FmwjuuM7JtlBEx9tmHh2pB5vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcZUmn03; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcZUmn03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C71C4CEF7;
	Thu, 19 Feb 2026 22:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771541019;
	bh=3tONbSfpNRAjht6NBVP4o8UywEVtyVOU0wD/jRxJqr0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bcZUmn03TQUTEYQsWzkl9M5r+rmXMrNnin/tc11xFwJ90RqiVjwh2iVHcjQ/HChu0
	 3S1u+v9WBrYn9F6inqNtleNdmMPxK4tpvLSi/dO+AiDE9a8RdsrINkcAVqw6QmyC9/
	 Lhe/+lP3nS96eq7fooD7PRBCBL1ZSjQJGZt3MaSOZUfy+0noQ/651FHvN9lYU3jmV4
	 3UV3Fbgi/RHVhNZU52dp+uGNN7dXMGJs0oI3kg4j8JwStwLgk+GEuQPpLf7OJltLeR
	 o081xxSpUQ0nUj7FB5zdIg+YRJxWTCSHXXytD6irixvxRaMidzKkXpZsVRwo/U4BE6
	 YuHJzodPK8aew==
Date: Thu, 19 Feb 2026 14:43:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ingo Rohloff <ingo.rohloff@lauterbach.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 netdev@vger.kernel.org
Subject: Re: [PATCH] net: macb: fix race condition in TX queue
 initialization
Message-ID: <20260219144338.50e8bb73@kernel.org>
In-Reply-To: <20260218104325.28381-1-ingo.rohloff@lauterbach.com>
References: <20260218104325.28381-1-ingo.rohloff@lauterbach.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Feb 2026 11:43:25 +0100 Ingo Rohloff wrote:
> Commit bf9cf80cab81e ("net: macb: Fix tx/rx malfunction after phy link
> down and up") initializes queue->tx_head and queue->tx_tail to zero
> without holding queue->tx_ptr_lock.

That commit does look quite buggy, but I'm not sure whether the fix is
effective. netif_tx_start_all_queues() and netif_tx_stop_all_queues()
do not take locks or wait for anything either. I don't see how they can
provide us with synchronization guarantees. Of course if we start with
queues stopped - the _chances_ of concurrent xmit and link_up are much
lower, but if the link happens to flap rapidly while xmit is happening
we're back to the same race.

Should we take queue->tx_ptr_lock in link_up, appropriately?
The patch you posted looks like a common sense improvement, so we can
apply it as well. But the fix should be locking and fixing whatever
questionable dark arts the link_up handler is performing on the queues
(we are resetting the pointers without freeing outstanding skbs!?).

When you repost please make sure to include a Fixes tag on the fix.
-- 
pw-bot: cr
