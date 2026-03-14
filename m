Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7139618B0F
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773453560; cv=none; b=DRLRD5R1ltEEOUdRaayjN0p2KMDMOMe9eDNAfUZ4+xFKt6y3UL1WIvelpXfP+vysvED00G0dayZjOfqviq8c+l9XYL0ryLEFIJYL+tRPD8MWzrCycRldzTakY/tOhho40qG1cXz9t7ryyLsxWcknBMfwTbNYaTgNCNcUX7QyokA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773453560; c=relaxed/simple;
	bh=TkEiK8u4A6qih/zE4OzcfrE1BbterY8K0kLpvTgbR6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAv38KtkDvqDA0Yy+llWePb9oc66NQEOItxnL1nltGkid8swZrkFfXkV2KGrnaewrjQr2dz9debdH17b1WCuk3hmUaPxNRj66H7JE8uorJf+WbuU+VfsTe9JObKQLrU7570Je+9WY7dLITY99qRjT2Dl5QUA1dME5pe62htptmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thTnhupw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thTnhupw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6D9C19421;
	Sat, 14 Mar 2026 01:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773453560;
	bh=TkEiK8u4A6qih/zE4OzcfrE1BbterY8K0kLpvTgbR6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=thTnhupwWmst8gNruZfiXgK6Zc1CG5g04u1flPrezudkhse29dat7vO7A7mqaQ29h
	 V1bzNxsAP1xvYy0lai9QuMxBlL+sgQN8YXmTGTGjqYrYtKdFv1E/P1W/LbZQ1a7TV9
	 IfNT6WUcuwEAZWS7kLoIC6jOk34wzvtKYaoXlACA9DKbrMvWoWQmeYVZ733FFIuVNr
	 2AOEr9thiy+s7S5P/YPL6CdVxNVgPJcjrFkdFuNYvvcFEcx/k1giWZROP/X3mmomfg
	 cVABUSDUglmP6AlHQoF9RfC8wBvaQnFIQ1u6T78EhKu8YqjTh/3zxynTLS5Zfm18Sy
	 RVBIyY7qInT8g==
Date: Fri, 13 Mar 2026 18:59:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, Russell King
 <rmk+kernel@armlinux.org.uk>, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next] net: phy: vitesse: add inband caps and
 configuration
Message-ID: <20260313185918.74ba4168@kernel.org>
In-Reply-To: <20260313-unloving-ambiguous-a6f492db06a9@spud>
References: <E1w082O-0000000ChNc-1wDz@rmk-PC.armlinux.org.uk>
	<177336361104.619871.8288889004999699479.git-patchwork-notify@kernel.org>
	<20260313-unloving-ambiguous-a6f492db06a9@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Mar 2026 09:50:09 +0000 Conor Dooley wrote:
> > Here is the summary with links:
> >   - [net-next] net: phy: vitesse: add inband caps and configuration
> >     https://git.kernel.org/netdev/net-next/c/6e263aadbaf2  
> 
> Hmm, should this have been done? Charles proposed a different patch in
> this thread that got posted here: abMa8e_2fjRkeOix@shell.armlinux.org.uk
> It seems to have less chance for impacting other ethernet controller
> drivers negatively.

Sorry, we've been getting 150 patches a day this week.
A bit hard to keep track. If y'all could please post
a necessary follow up I'd appreciate.
