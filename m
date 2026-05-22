Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B40234A3BF
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439343; cv=none; b=cNWgqZ1W1AA7JXc08WcYqAd+sP+vhDZQMJ6+XYKn7w4hh4K28e/5/KFAPvaNWbwNFJorVvfY9X6i1+3F5t3wYYhEBP+m4zTtaNFEWl9soB/mSuZiG7Qm6h9/W4vk0iUnLw6HdpjE1Z7zATfQdyo1V9hwQrFQB5LBYmkvlvZ4yOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439343; c=relaxed/simple;
	bh=VhIZY79QbiBRM6aNil0Rz5yp3sdQpcwNIB0p5c/IqB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Urrq+ROE1v4aMw7CzBODuMojEN7nfNwtxwtHPRtmokpPSsyXVsJHVvyIGeWwejwnbWF+yYdSoz9yeUd1NGv7VfPtqkfO2GYMVQQIpskis9Om6p8Zl99GsygADyVahgXG+Jvz2GjlCl8GcPCIlpEEhPj+OyR5btHqdUi7LrRirA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1pcDjLX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1pcDjLX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE0B1F00A3D;
	Fri, 22 May 2026 08:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779439342;
	bh=K7woSUmQ1qkgC+Tygx9BmDg4D+1VwHe1oVWIu66eemk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H1pcDjLXoDj9p0ctuglQNc0j5WKtVAOIoP8JQgQpG1Qyf2908+BSlKXg5wzvgz4Kd
	 tgI8oC+O4A2OhdOb8ngwhYn5ExTRbqrbJTZEHayTbR9La6o7DsM3LPeizCDGbNiQyM
	 FUZ8dq6hTIBfkKd5Xo7AZu9BZLKfUcqDSWFeHmdupFaLuLC5HTEdnxYaTOxiF9ZDAh
	 JMb9HR0evoPSoX+CQ7Si+jJm4G6itYMZAQrxqEiOT9YRtRuzgkPnYz83ACe0ruJatd
	 GIyH2PF2n93RGPKNCVWuR6ovZQ47KHYUOV3gZvG6J9AGxxdff8rh+v/WUUbn5fR/rT
	 0eKUkjsFZ+qlQ==
Date: Fri, 22 May 2026 09:42:18 +0100
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dave Ertman <david.m.ertman@intel.com>
Subject: Re: [PATCH iwl-net] ice: fix LAG recipe to profile association
Message-ID: <20260522084218.GI1506108@horms.kernel.org>
References: <20260519112041.125907-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519112041.125907-1-marcin.szycik@linux.intel.com>

On Tue, May 19, 2026 at 01:20:41PM +0200, Marcin Szycik wrote:
> ice_init_lag() associates recipes to profiles, assuming that Link
> Aggregation-related profiles will always have profile ID lower than 70
> (ICE_PROFID_IPV6_GTPU_IPV6_TCP_INNER). This value seems arbitrary and
> might not always be valid for some versions of DDP package, i.e. LAG
> profiles may have profile ID greater than 70. This would lead to
> misconfigured switch and LAG not working properly.
> 
> Fix it by checking up to maximum profile ID.
> 
> Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Dave Ertman <david.m.ertman@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

I notice that there is an AI review of this patch available on sashiko.dev.
However, I believe that flags a pre-existing problem that is orthogonal to
this patch. o I do no think that review should block progress of this
patch but rather be looked at in the context of possible follow-up.
