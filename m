Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8061F394788;
	Sun, 27 Sep 2026 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790505884; cv=none; b=hlv93mp0HwbFRMZCqt3Dhk6gWEzY8gcePi4gz4mn7FLQR9iq3cwjiQYiv+j2BlCtXThs4Cuz1ejVrkETEgtHD5ZGD6vQN+N0MFfqw5XI8FEa+5DmDG2KSih86EEb9F0jcmD9p/t5EgJAoA9ayyxGlzcZGL05qZLer1lMM1IdliQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790505884; c=relaxed/simple;
	bh=Q5mXUt58evfl/8mKdI4C8LiTDK3/zcUjhhe30gFLHgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXAoXXk7OQ35DZfMYLnjBlmV/UTzuzzBCxLudKOuvXQc5dUVGJdQCPQ+skm9MAwiI9SbhwUumjRqurvBFnM252INMGmab0wctN2dUurEfBJAn27SZ9wCcYHptbrFyBiebPgQ4oKrdH7qMzeEdziK4JL8DtEF5jcpJntWwwaTtx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVRndsL0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVRndsL0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB081F000FF;
	Sun, 27 Sep 2026 10:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790505883;
	bh=aUIxs8vI7iNpPio0a0auBa+6IQi4XtLMZVN/iigHDEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SVRndsL0fSsghp/HLNGfzJGZ40EEI4lau1sovCMrHPr/pTFjjNMdMR0PC6N4H2R+1
	 wGlfcTdbuUnn7tZm1dlFij+kOododPWtT3ExxRIC8KI5uWyI2cJcsqfIr0uRsj61iV
	 eqTEwlMWM8XRto32Y8lFn/ofglTyfCAUKG3H4Mpp0oT9J9ETW+gC9Hb3Arc6JtAZ1c
	 7lDaa9v5X4h6UgrquvfC4HjIuezWdIajrGzpn86LWBLzvt6yGgGiBKQ5EpHKgzGrzO
	 0Ju6rywwwJBCmgXZOPTUstwBn7o9K00nuMU3jvL5+a8SrKsrIy1BYIqK1Uk36MoL7E
	 WPygofGKXpS1g==
Date: Sun, 27 Sep 2026 11:44:38 +0100
From: Simon Horman <horms@kernel.org>
To: Subrat Pandey <subratp@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, sbhatta@marvell.com, rkannoth@marvell.com,
	gakula@marvell.com, sgoutham@marvell.com
Subject: Re: [PATCH net v7 0/2] octeontx2: Misc fixes for RVU drivers
Message-ID: <20260927104438.GE13925@horms.kernel.org>
References: <20260922102149.2078168-1-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922102149.2078168-1-subratp@marvell.com>

On Tue, Sep 22, 2026 at 03:51:47PM +0530, Subrat Pandey wrote:
> A few independent fixes for the Marvell OcteonTX2 (RVU AF/PF) drivers:
> 
>  - Fix aura/CQ BPID assignment under CONFIG_DCB, which assumed
>    queue_to_pfc_map was always allocated (not true for SDP VFs).
>  - Fix the SC resource cleanup loop that iterated over secy.max
>    instead of sc.max.
> 
> Changes in v7:
>  - v6: https://lore.kernel.org/all/20260910062657.3712256-1-subratp@marvell.com/
>  - patch 1: NULL check for queue_to_pfc_map in otx2_get_bpid_idx().
>  - patch 2: Reword commit message.

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

