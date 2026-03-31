Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236172F9C37
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774996916; cv=none; b=p15tw5LcVywOU8Bhjdfph1OV4sl9hqycWFe9NOU9fGGeGk5XKwYpksJ9Ov/74FMYDZ8M4WQLEmOE3FKs2ziXaA3P7IqbEBg4+stgoD4nytAF6sctm3TINVCWAHuIUE0NfPoX/sk3e4QZ2l8qw8HsD9j1gEVy3dLJVQZa5pWXu8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774996916; c=relaxed/simple;
	bh=yJ7hUJmHZ9BD/NAgfc3y9DkZZw6ma2PdZTTlwvhtnuo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6D/9axD6S59zUS6CuZSuebw8rP2+ZLVpYet3OglNZR85hNRCIx24UefGDHQP1gctbbiqPc3mFGBijEYsqncaBnpPg4CsPEF3/alHXQdwYuEtyXHEOHk4ZN7AKKNrJRAfhYCz2OZ8XzJ7NmK/aQhuoFFfdosP/jv8L/Vh2eNPhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s90I5FAB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s90I5FAB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A90C19423;
	Tue, 31 Mar 2026 22:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774996915;
	bh=yJ7hUJmHZ9BD/NAgfc3y9DkZZw6ma2PdZTTlwvhtnuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s90I5FABWMfL1UHf1sBVOZSYM8qU3ebIL6DKE6OSqozVmfsECKiipM7xg7xCdgGh3
	 W/9As0Vh1GLoB0GVy8nRwu8n6WJY/dju8VoEZduHjP4mPRyzbUhM5tdSpoQwu1LWlW
	 PKU4nWjpSnKsImHPcaRRuFtfnNBsdjIS1hW+nF6//liyLcE00hNWchZf0eDRCZ4vEd
	 sJYFHfYpjc1OfGtRBBEWIu2JuSS6WQMxqvfxwfVqOY/TKSZ0XUi4td+NF68B6vSxXR
	 BnptvktWJcGaDy8jC84dpCA8tXDuObw2/+S+1EuJcgfnwQ54KkdswXVqCxiRrxFMis
	 jJF0xDr+g70lQ==
Date: Tue, 31 Mar 2026 15:41:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, Yiming Qian
 <yimingqian591@gmail.com>
Subject: Re: [PATCH net] ipv4: nexthop: allocate skb dynamically in
 rtm_get_nexthop()
Message-ID: <20260331154154.317437c4@kernel.org>
In-Reply-To: <3025cc67-ddbf-43f6-a313-602193979ace@suse.de>
References: <20260331115943.10404-1-fmancera@suse.de>
	<20260331103538.103e3778@kernel.org>
	<3025cc67-ddbf-43f6-a313-602193979ace@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 19:40:38 +0200 Fernando Fernandez Mancera wrote:
> thanks for sharing. As I replied to Eric this is the main reason why a 
> V2 is needed. There is also another bug I discovered while fixing this.
> When dumping the stats NHA_HW_STATS_ENABLE is being included twice per 
> group. I am fixing that in another patch that will be included on the V2 
> series.

If you remember -- please try to slap a pw-bot: cr on your own reply
when you notice that a follow up is needed, especially if the patch
is breaking selftests. We still lack automation to attribute failures 
and bad changes get stuck in the testing branch :(
