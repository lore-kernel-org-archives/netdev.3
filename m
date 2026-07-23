Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AAC471D14;
	Thu, 23 Jul 2026 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811084; cv=none; b=mnANVUKDw84WRiOO1bT5y50NCv8OzdFOnPm1TwbJEhsDVVGhL5ihSDuo72ZecV6fW49AJOoztwtpmYEChufOlPPlLgJf/RpsXSACLHYjzwRfoHAlCVcVuSrrDuOWmhZ0sawipCyJzlUd1U6Eo8v8JQBwDFe8LY3O+ugBpeAbfpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811084; c=relaxed/simple;
	bh=jlAzOHs+rEj986blwMQ7jdXdsQsPiKBVoJ3nKBIOym8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdyOrKpNvu7lRrL+7Q6Iu1Gkk/eAcBJgjOPOJuOffZZatORJhQs67BzZmvnFrKF0tAT+rEDBMcox8IsyHDiQc9mC8VCA/vWz/FDMUrJnNDwi/k76iCgjHqLzL4jGIUYsU5ZTjIYDe+uw0JrdtZ3wp0FBMZoCk9e+8I6aS07yBs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70271F000E9;
	Thu, 23 Jul 2026 12:51:14 +0000 (UTC)
Date: Thu, 23 Jul 2026 13:51:11 +0100
From: Simon Horman <horms@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
	netdev@vger.kernel.org, larysa.zaremba@intel.com,
	przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com, michal.swiatkowski@linux.intel.com,
	emil.s.tantilov@intel.com, madhu.chittim@intel.com,
	joshua.a.hay@intel.com, jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com, jiri@resnulli.us, corbet@lwn.net,
	richardcochran@gmail.com, skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org, Bharath.r@intel.com
Subject: Re: [PATCH net-next v5 14/15] ixd: add the core initialization
Message-ID: <20260723125111.GI418547@horms.kernel.org>
References: <20260715180042.1972010-15-anthony.l.nguyen@intel.com>
 <20260722161836.544694-1-horms@kernel.org>
 <amHssLjVOoOz7FbB@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amHssLjVOoOz7FbB@boxer>

On Thu, Jul 23, 2026 at 12:28:00PM +0200, Maciej Fijalkowski wrote:
> On Wed, Jul 22, 2026 at 05:18:36PM +0100, Simon Horman wrote:
> 
> Simon,
> 
> Larysa already responded to Sashiko comments. Did you miss this?

Yes, I missed this. Sorry!

> Do you have a bot configured for that AI output forwarding?

No, I do not have a bot sending things to the ML on my behalf.
