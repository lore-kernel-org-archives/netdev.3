Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5E549B5C3;
	Fri,  9 Oct 2026 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791551392; cv=none; b=mldSXbB26tlnIY+cEC2DxWR0ojWSUWOL6IEOsPhc1YVblvgThFNP3S+7Qzij9sLgb8zBK/7LuhvZxKl2YGR+FIh6N+3KqpnYkquzFTm4T5IOhBVB9mLByRHjnL8xXdCut4AOU4DMbijrPg79mFZ8K/5efuqfZgsoBC68uSVyFEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791551392; c=relaxed/simple;
	bh=Gkfjb3oXzSXu2jkZh4iyfJzd3EgbuVt3H3vV5J6iCB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXWTCz7+LZi02TV8e4isXR7kowWYVMjKo9n/COWRV8wQmJBIYCVuodXxVjciJvThL98VlRqxr/c3IygK8z8bXZ5MmuzUG+sdY5DzJ3SUBusKFRBWMJaaYb5HERAPL9X9cTjLFmSyMH+UFS883SZxajPZEKUVGAAxNby8za0ynEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCQjhnwD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCQjhnwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D851F000FF;
	Fri,  9 Oct 2026 13:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791551390;
	bh=jf99WYUZ2O6JpzKHFQeF5M82mqTlQhLAytBup7eO+u4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UCQjhnwDaPHUxCDt5Av6x/T7ePXacI9aujq+Uhpub7n5e+2Bft4ly/g9YqoC25WtN
	 LezsQYSsk4vP02YsHg+xxc2D4BlvNT1z5Fihj9D8jpQV7M5a1WkfR/Vorncqtd3cWC
	 GBTFdJPbwzA2koPhC+8GONU1JR74CqiQ42ks0QC5pwXo+Rcxh9gv9/LrRvw2voWoc2
	 V2QrSyfyQNn9l2NgWUVjlnQb2SlkbOvqXjgBGN5IjNVwnvJQU4RnuiA2lZO0LynlcT
	 oM4nQIOT1ullKkfRrtLSkFvRJ07hQFNf7+/O+fU/9F76pTCdzeOFq7p9h2bhiCMqIV
	 5TZtDF3f/MBWQ==
Date: Fri, 9 Oct 2026 14:09:46 +0100
From: Simon Horman <horms@kernel.org>
To: Shashank Mohan Jain <jain.sm@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Tal Gilboa <talgi@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net] lib/dim: fix 32-bit overflow of epms in
 dim_calc_stats()
Message-ID: <20261009130946.GB83879@horms.kernel.org>
References: <20261005014411.78626-1-jain.sm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005014411.78626-1-jain.sm@gmail.com>

On Mon, Oct 05, 2026 at 07:14:11AM +0530, Shashank Mohan Jain wrote:
> Commit 0843b2389064 ("lib/dim: fix 32-bit overflow in dim_calc_stats()
> rates") moved the packet, byte and completion rates in dim_calc_stats()
> to 64-bit arithmetic, but left the event rate as
> 
> 	DIV_ROUND_UP(DIM_NEVENTS * USEC_PER_MSEC, delta_us)
> 
> DIV_ROUND_UP() computes (64000 + delta_us - 1) / delta_us. On 32-bit
> architectures that sum is done in a 32-bit unsigned long and wraps for
> delta_us >= 4294903297, the last 64 ms of the u32 microsecond range
> that the function is meant to cover ("u32 holds up to 71 minutes").
> epms then becomes 0 instead of 1.
> 
> net_dim() and rdma_dim() only wait for DIM_NEVENTS events before they
> call dim_calc_stats(), with no time limit, so on an almost idle
> interface a window can last that long. With epms == 0, cpe_ratio is
> set to 0, net_dim_stats_compare() returns DIM_STATS_BETTER instead of
> DIM_STATS_SAME when bpms and ppms did not change significantly, and
> rdma_dim_stats_compare() compares a cpe_ratio of 0. The algorithm can
> then step to another moderation profile based on a wrong rate.
> 
> Compute epms with DIV_ROUND_UP_ULL() as well. The result does not
> change on 64-bit, or on 32-bit for windows shorter than 4294903297 us.
> 
> The issue was found by the Sashiko AI review of the original patch
> (see the Closes: link). The fix and the test were written with an LLM
> assistant. The dim KUnit suite computed the expected epms with the same
> DIV_ROUND_UP() expression as dim_calc_stats(), so it could not catch
> this; it now uses explicit expected values and gains two cases with
> delta_us of 4294903297 and U32_MAX. Without the fix both new cases fail
> on UML i386 and on qemu i386 (epms 0, expected 1) and pass on UML and
> qemu x86_64; with the fix all 10 dim cases pass on all four.
> 
> Fixes: 0843b2389064 ("lib/dim: fix 32-bit overflow in dim_calc_stats() rates")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927051743.71460-1-jain.sm@gmail.com
> Assisted-by: LLM
> Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

