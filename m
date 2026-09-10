Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AE03EC699;
	Thu, 10 Sep 2026 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033422; cv=none; b=GrNzZxLgJnQXbxeXhMpObpwiAc+juN4o/e60YmdQ6o2PfBSLDFf5cYLq138b455LPpr9Hng0uetOiWxQtcrzx87DwVZT0bKE2MAy/Fv31ACFcgw7U9ptUU5lE6BncyTb8/TpQbV6Sym8V3RdNttaIVP2ms0CiXq6fV6ztbWSnwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033422; c=relaxed/simple;
	bh=UG3zIlJFHuE/uuA2PSqt0yGiIkaLX31fTLNpnyKEybM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iz+mZ1msrImlqTEpNsEIwWa0r4njOAAdaGQ2Pe0orryg87/4RFj+sg2kmE9SFVzjXHGIB0kUP4jAthOw7l5jyjZyR+IVjsS5fRMPHIGHhsUzUuMJwr2Uc1HyHKgStHRoVTz1UFvv6GdsYk6A9LH2A7mC4sqJZzknqKvH/+d+rVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OStYmEbM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OStYmEbM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5882A1F0089A;
	Thu, 10 Sep 2026 09:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789033412;
	bh=3PSNJdkLgjx7CT1qGGyL/t9UShWonPTwXogriKQa38M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OStYmEbMF5iMPMurk4FL/GnmSA3SBm6EevBHo4284eG5UTUYarRAZt3eh3+wjDfsP
	 ++4SdbiaexWxQ1uMiUuY+1KJkrCpY8/voLq8f3lWsjS3qkQ+IwcgtamppJODh+sY8a
	 VwE4WwXWNKZcQ+zc2pKRLOwc7H7/WexY3Q99iQrgj2YKS2J/OzQ7+Ba+tX5UczaHAJ
	 X7TybGkPOnP+1Z6QPNV0N3K7zlks96HyHNU0yfYren9zpM2CQNVbODc60qyTHxHMHf
	 8Mtt5A/eptK+dWnOu4uzbWN5dTrS3589TsjJBGxg7XBsca9hw+zaRSiKW2AAGYQSad
	 NQWjWgBoKbgMg==
Date: Thu, 10 Sep 2026 10:43:28 +0100
From: Simon Horman <horms@kernel.org>
To: Ivy Lopez <skunkolee@gmail.com>
Cc: ionut@badula.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: starfire: fix ioaddr sign-extension
 causing ioremap() failure
Message-ID: <20260910094328.GR40544@horms.kernel.org>
References: <20260908124119.GW40544@horms.kernel.org>
 <20260909002829.224639-1-skunkolee@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909002829.224639-1-skunkolee@gmail.com>

On Tue, Sep 08, 2026 at 06:28:29PM -0600, Ivy Lopez wrote:
> ioaddr is declared as a signed long, but is assigned the result of
> pci_resource_start(), which returns an unsigned resource_size_t.
> On configurations where the BAR address has its high bit set, the
> value sign-extends when passed to ioremap(), producing a bogus
> 64-bit address and causing device probe to fail:
> 
>   ioremap: invalid physical address fffffffffe480000
>   starfire 0000:08:04.0: cannot Remap 0x80000 @ 0xfe480000, aborting
> 
> Change ioaddr to resource_size_t, matching both the return type of
> pci_resource_start() and the type ioremap() expects for its physical
> address argument, rather than unsigned long, which is not guaranteed
> to be wide enough on all configurations. Switch the associated error
> print to %pa accordingly.

Sorry for not noticing this earlier, but probably this should
have a Fixes tag. No need to repost just for this but I think
it should be:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=198035
> Signed-off-by: Ivy Lopez <skunkolee@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
> ---
> v2: use resource_size_t instead of unsigned long, and switch the
>     error print to %pa, per Simon Horman's review.
> v3: rebase against net-next, no content changes, per Simon Horman.

...
