Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32653A3827;
	Tue, 21 Apr 2026 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762182; cv=none; b=e/xGY3pj+enBewu913Az/KYXHfMOmaEO0wBB3RXDpMBhLxqm1G79YJT9J68wsb6V7M8uThOk6MR9EvB0q/1KAO5V6mvMqbk/gOI24sNrx6/RG7PKwdrF29Ut6XX1tpHh1GyByg82YeHpg6HuOc0o96AxzMEpKBSUUE/QaoFt4hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762182; c=relaxed/simple;
	bh=IEJ6LJnEjNWGmodZMyE/CMbkC0WeFWjPZXCMP+gk6s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXzWO0ZwPHDO243dwbjKCzQbdR5lTHJTjS0HzFV8Ymq/2SQVGDTuzUV8gZfYU40DfEqspUfZzva+I5eZrABf3CpDozP50usvVFCjdEWmvfZ4mKruPGBHfLOCoijMaSt+Q4VrHd+Z2coIABQv5YyjlgFuIIUDNWgdGw3USof+ySw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnewWg7W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnewWg7W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765E9C2BCB0;
	Tue, 21 Apr 2026 09:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776762182;
	bh=IEJ6LJnEjNWGmodZMyE/CMbkC0WeFWjPZXCMP+gk6s4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bnewWg7W3/r/Kjb34Nql+lE28RpJVx1afI7U0D99UBjTN1wp2NN30jql1O0453c0D
	 NFoVBA6S7RvR9pGxh/77ExoEs9T1sLUBbMxLW+MPc36qXBw31iC1waBnKSAWgyDViQ
	 HtEByGWAc+9Aen/GA5IkIZkcXc39d+M4QALGaDyyTf4Rynqhj7/ycvzjbYliZWhWZL
	 zGiEiICZt8crX+5PUdCd4qp4N2tPvAYdT1MY59PcVJyPmtpUHWAhfx0Gq4fG4SurWD
	 yUPSIaQimQ0io9qZkpvYxqYa1dQ+SpcqGe5O5vIyNzdPvjRJYPRvM4HmmH9Jdc8uYY
	 Iqu6m77CV2iug==
Date: Tue, 21 Apr 2026 10:02:54 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Mitch Williams <mitch.a.williams@intel.com>,
	Aaron Brown <aaron.f.brown@intel.com>,
	Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com
Subject: Re: [PATCH iwl-net v2 0/4] iavf: fix VLAN filter state machine races
Message-ID: <20260421090254.GW280379@horms.kernel.org>
References: <cover.1776426683.git.poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776426683.git.poros@redhat.com>

On Fri, Apr 17, 2026 at 04:29:41PM +0200, Petr Oros wrote:
> The iavf VLAN filter state machine has several design issues that lead
> to race conditions between userspace add/del calls and the watchdog
> task's virtchnl processing.  Filters can get lost or leak HW resources,
> especially during interface down/up cycles and namespace moves.

...

Hi Petr,

Sashiko has a bit to say about this patch.
I'd appreciate it if you could look over that.

In particular, the feedback on patches 2 and 3 may warrant
some updates to this patchset, while I think 4 is more
in the realm of possible future work.
