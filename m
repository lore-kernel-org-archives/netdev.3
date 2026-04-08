Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDD43A1E9B
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775665675; cv=none; b=kObLU2Z/jEjn6ttzFHSg8QS1luJMBane4gnfWYDwA5y5d1sPGGqhyaSxKR6RB5O07HHu6GbK4uwtPRcgc0bSSNee0qoVRgjdJvqUCnchVFt6+jx34h+KgTk64xuQvN1MIn51g/Tw/hfmy991tFd51GcmxugtCqYi3pRXptVIsdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775665675; c=relaxed/simple;
	bh=9Aj6Lw7cNs33pOaJ8kTW0W5iCQ1Qu6l87NcJHj4Zyes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5CuZfdOCkEEW0AOQ7i9R/GBLpqJc8Ny/ICE1YzqrEXF/5EoDlI/xpX8wxM5ddbeEoCoWfrn+ky1+t9+ItW3HlP3f/HSHUSql6PpM7d8dC01D8nTCGuFM4w1Rx4BC8I8kgVutIwXTZl7AdIrFk48S2nm3nah2F1QhAsHvOqaFm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmhIq463; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmhIq463"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367B5C19425;
	Wed,  8 Apr 2026 16:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775665675;
	bh=9Aj6Lw7cNs33pOaJ8kTW0W5iCQ1Qu6l87NcJHj4Zyes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hmhIq463mdAgSJJmPsbHuHN9fSnUReA8mAjepwiLZ5CjFFGlNDBVo6WpRRj/z4yDc
	 7NWVquzHt7uY6MAU5fcSFLMiM1Wc3CAjcMBu3aIdXyS+KL/A9iH4WlxqRHD5a38A2o
	 ojwsGYoTeWYYsl/TT1g8sctXqMaM1hBOUhVhRT+QAKDFawfWKSrcnYUK+XOYpWw5sz
	 AvwPVOEmapLQHL5wJpRVKDuyRjNuzb3BF+s4n6zWh6D6FuAYBHwvjrPs1lrxjVhpWH
	 +1v/8KHWV1uCnkJGI41+/xRY0OVw/cpFaKdZGikdE0au+HC2fp/ud4JJb6s+F+EVXm
	 RW9ugAOKVdhIA==
Date: Wed, 8 Apr 2026 17:27:49 +0100
From: Simon Horman <horms@kernel.org>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, milena.olech@intel.com,
	jacob.e.keller@intel.com, konstantin.ilichev@intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: fix read_dev_clk_lock
 spinlock init in idpf_ptp_init()
Message-ID: <20260408162749.GD469338@kernel.org>
References: <20260403153538.11516-1-emil.s.tantilov@intel.com>
 <20260407160241.470945-3-horms@kernel.org>
 <626f3619-499d-458e-8536-2cc30984656d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <626f3619-499d-458e-8536-2cc30984656d@intel.com>

On Tue, Apr 07, 2026 at 03:00:22PM -0700, Tantilov, Emil S wrote:
> 
> 
> On 4/7/2026 9:02 AM, Simon Horman wrote:
> > From: 'Simon Horman' <horms@kernel.org>
> > 
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> > 
> > Simon says: I don't agree with the regression characterisation made by
> > the AI review - I think this patch is good. But I do think the issues
> > flagged by the AI review warrant investigation.
> 
> The point of the change is to resolve the use of uninitialized spinlock. The
> questions below appear to be generated around that code, which would
> be out of scope for this patch, but I will address them anyway ...

Right, I agree with that general statement on the review: it muddles
up potential problems in nearby code, with problems introduced by
your patch (none seen).

I do thank you for analysing the problems raised. And I'll leave it up
to you to provide follow-up patches as you see fit.

For this patch, I think we are good.

Reviewed-by: Simon Horman <horms@kernel.org>
