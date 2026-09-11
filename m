Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DEC457E55
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145772; cv=none; b=jmXM6a+PRy9jn2bDawwOwbeHxSJOsEwZq7SdLqHUoq3O2K5yZwALO5Y+muhzB/w0PGhvQ++YxE0D9gLgHNqLyXIj1V2Tk95ZkqIeF5IlgcH4Sa5Q86AJk2LljTDUrUuLL/eFhFbVAIFgrpjWdjKNt1x3oDEWByUVIHPCbYOeBR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145772; c=relaxed/simple;
	bh=vRiscmD/OdhpeVE8/qkDkOl3IjX4BoBnJZAT6q+NNe0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2abETtzR8d6P9VVsdx8dJzinXax8KTQjStE2mFwP3QBWJbBeIL8/Nk92O7y4rHL5Njkvg5oVYHdxP/WE3hk6z24Hf+ZadkPJArmwzJSEMMUoHog9CODEPMBqDlZWL/bKuaiskhejKw8PlLEjh94sDDbnKIDRlxSvdxU1+FjjvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVDNkId4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVDNkId4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CEB1F000FF;
	Fri, 11 Sep 2026 16:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789145771;
	bh=cAOXb7qhIq41yioL6pt4QjCvwD5SX2w0/KFd+4/OEKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SVDNkId4FFCNDp+vnY3hw+1ceZ6J9WiEIHdlPJjysAS+0VLXBW+XdrmPe5S78BuIL
	 YXiI/yAYUSNvjAQKtXPBLLCepgiCd0wq/LT8fqUCP+Xr8qO+c/18mv1VsEfOdXPMvH
	 PWxUPrphGCWdBcwXvhyQ3iDeabP8NFD3OOQKLCYQYCoYEFafJDDcpfEz7CrvksM1Bt
	 5rO4WW30rVu9JRtsFBObpobUcw6Mn2sdPDel3G66XVNaNdEXsV4/c0EIlBMnRHAd+Y
	 aH6lJqyTPcuqXAi21au6r4Blp5ZlYN5wzWs+sKIgEtCJd4P4XmNCjTY//kDuB5qIf9
	 TaGYu1JMYDnPA==
Date: Fri, 11 Sep 2026 09:56:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Michal Schmidt
 <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Subject: Re: [PATCH net v3 0/5] ice: fix stats array overflow via proper
 realloc
Message-ID: <20260911095610.73a17e0e@kernel.org>
In-Reply-To: <20260911095237.243ab37b@kernel.org>
References: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
	<20260911095237.243ab37b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 09:52:37 -0700 Jakub Kicinski wrote:
> On Fri, 11 Sep 2026 13:26:15 +0200 Przemek Kitszel wrote:
> > Fix OOB access to the stats arrays.  
> 
> I'm going to assume you mean this for iwl-net, there are already 15
> patches from Tony in the queue for net.

FWIW at a glance LGTM code-wise, there are some kdoc warnings tho
