Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804D3A2571;
	Sun, 10 May 2026 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778428790; cv=none; b=eSm/nzfNuZ6GogDqQuSf04QZOSJRxNyzDxuzubgvEKH7wLxrKXiMasEFjza3uYaVx+fJYlgO4GqpRSV1GXGcVjdhXT/ODaI2di03ZU166db3hkdGoCciRomaFcXpeMEG06SRZHVQ8GZFy64W8UgwmsTrwzENFhdTvzMz+zB17N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778428790; c=relaxed/simple;
	bh=5b44R9A+1FqS91NncqFrxNHWtkWlDfsMpLqKYOx3rBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IvWoDE5kRFpZiqMdhfNvb/h8nqgdpKctj0gZqJYrTimY3S1kak58s1HBPdHP6p5rOXJ+STl+iPiRbXOHq+Tal42djbk81DHxuxfrg10TPhRvYwJocFh9Hk6yn0eLQBWup9U5KCQ1kz7L42+460qij2v7SSq56YBVdXAczvERzqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irXJtI1i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irXJtI1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5742DC2BCB8;
	Sun, 10 May 2026 15:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778428789;
	bh=5b44R9A+1FqS91NncqFrxNHWtkWlDfsMpLqKYOx3rBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=irXJtI1i54ty39NWHMs/sYfv6N3yN0v+vcbZfOVJdV2tsPVnC/CQoCeflsRulhy5o
	 XzRhkZEryqrA1WdA8nByaphgyA74ndROOqUftpMgpl2d6NAn8QDROP1dQFoEb5U5/+
	 O4GbaFko6ZWdADmwpKYqQfXQ46b2ck2HErMx//c4bwE+NtxjNTJiedEMYUYiRtIpgs
	 /3SGXPjIPQCmHK7jU6eu9arieFnsE+J2Zb/IcF7bpDlZkfMafrXpUkS5vHcEG9PiTv
	 nItkDYOL4z/kniuxOeGsF2XKu9LbYsxlUVJHdfkkEmI4jueB2xX/Jd5qXwhtmbG/ZH
	 Hue6gh6wsmCBA==
Date: Sun, 10 May 2026 08:59:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, linux-kernel@vger.kernel.org,
 macro@orcam.me.uk, netdev@vger.kernel.org
Subject: Re: MAINTAINERS: Add self for the 3c509 network driver
Message-ID: <20260510085948.396ed523@kernel.org>
In-Reply-To: <20260509230519.57607-2-enelsonmoore@gmail.com>
References: <177827761704.865600.12887598979033208728.git-patchwork-notify@kernel.org>
	<20260509230519.57607-2-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 May 2026 16:05:20 -0700 Ethan Nelson-Moore wrote:
> > This patch was applied to netdev/net.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:  
> [...]
> >   - MAINTAINERS: Add self for the 3c509 network driver  
> 
> Did you forget to revert the driver removal, or have you just not gotten
> around to it yet?

Heh, I only checked this file isn't already covered.
Did not expect someone could send a patch for a driver that doesn't
exist. 
