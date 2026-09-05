Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A102C15BE
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 01:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788571287; cv=none; b=Ct1RVtAi+d6z7g1kMwXoc4V7wxG/NuBj7Go5vxC30Li+ULyUsy1xc7JoOZbU4TQjEF5Uw/z9ns8oO5pvJcSUnABc3SGBe5y9SFnEo6pi6ReFELhr4rqajeykBgkyiFs27+HPNwAXJJVuippfZ2fCecw97Qie4PorDuuY6eTaBhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788571287; c=relaxed/simple;
	bh=NmT5TKYCviA0TIjjwKSbETwPIzncC2zM9jl+T1J7HMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQgRdFdHw9HXfxG4qUTRYFHJkcWRjJRRKQD2+KKbFxKYqsyBLaMMpQgR5qCVHn5Hjqzk9/q7TfQ8T2kaf6z9CHROhDy7CNzRdH0RO2yuyhgKTCA56aUAvFzBv0/9tb4PUUIOMsTu1XrE8gakEybZSI5GLTwefAkPL2H2o6SIPdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTRvzstO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTRvzstO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831671F00A3D;
	Sat,  5 Sep 2026 01:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788571286;
	bh=zPdP1oTtvHN+Rxm/Ca63JGJZWr/PfmfGjdClVLNgnug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dTRvzstOoTWRlRiDKzFWsAlC3J3If53A2HxgLyVVMiE7TiPnnQ1WUXZcSKWtAfaL3
	 1AqyaPLG05S27FkPlU9K+ZDyK0P9WuwyFLjVcz6UlNgx05pgSFu5OGcuIDAzrnd2E+
	 Dc5z3+qvvw35Dyy1ITSXOEaORsbggG9SXc22ZRTNj3pWdQoCUxUjn5lDzugfJNLxkQ
	 tM7yN5KzGhO8jFOhvQWDihTmSNhR20UZ633HHb/h/luEXLB3z8eruGaU+G0sQu5qri
	 MDM188BSJltIx2No6fmzLTGZG1pDhOrBEF34EnqoH8aGJikmLL7QDh2ES3Fs68D/Ou
	 sVnjd8ceWY8KA==
Date: Fri, 4 Sep 2026 18:21:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: nikhil.rao@amd.com, netdev@vger.kernel.org, pabeni@redhat.com,
 brett.creeley@amd.com, eric.joyner@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com
Subject: Re: [PATCH net v3 2/3] pds_core: don't release PCI regions for VFs
 on reset
Message-ID: <20260904182126.03899afe@kernel.org>
In-Reply-To: <178857041070.219967.13178305658939860424@kernel.org>
References: <20260901044219.1361466-3-nikhil.rao@amd.com>
	<178857041070.219967.13178305658939860424@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 05 Sep 2026 01:06:50 +0000 netdev-bot+sashiko@kernel.org wrote:
> The new condition keys the release off the device type rather than off
> whether the driver currently holds the regions.  Can the PF still hit the
> same "Trying to free nonexistent resource" warning from __release_region()
> because pdsc_reset_prepare() runs twice per AER frozen-channel recovery
> with no pdsc_reset_done() in between?

seemed a bit orthogonal so I applied this patch as is
