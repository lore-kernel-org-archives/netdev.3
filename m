Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7380449B1A
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784761243; cv=none; b=dAMHovYpxJq33UV1tjUUX3L5VcHDw0usgtWo43+0hGjXqHEVH/my1FyCGrvpyeRyeRcCbpKAslvjVRzDwu9uIlWN7PJu5ku6Ew4EU2hszfFDHcpEIU2dIV67XQgDV35rKtAZXzDbmxtvy9iih8zrj54sUJriW7WTirgMuNSDoWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784761243; c=relaxed/simple;
	bh=INqukmZ8aZfP+I2HRL39PRE4jhggmv5V1EBBb5f/ZSc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W4y1Ok665Dyhr++nWDdCoMhivFO3U1+SKyICmwx9cqvIlUifWOgGdEL9+Aywwm+C8jo1I396R0zssxU//2Hf64Kka/ET9dR9UjLwHDP8icbai8orwXpYCTkn/cAxs9NZZfXi2JpBnXHJ86aKlXPJD0NfEiSFAOlGXXhPNiHwwNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi7kF0jT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi7kF0jT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B94A1F00A3A;
	Wed, 22 Jul 2026 23:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784761242;
	bh=0J4fuqe+Mkc/TsI0lA0/jf2QcR0dr0D4//kjUzardKc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Pi7kF0jTV6gLhKFUREfnKytVXMtXXqWQNKoZvlZq7N49auc7vIKL0oC/TzI1X7ytw
	 umGS19Sl5z3DFxN2s3jMc0BR6MM19nN8SIeJqm9wNWyn11wwSIeRLuPYchtkU2RWCn
	 lihVFdYlBBxmX6yMWJ2UsgDc2WtuVjYdOCRAhq5sGcqTOrdpQ/muaSNJKGpKchVX5W
	 mf2tbvFeDleAPD0yeqHPIHxxXcxDZDbUid8hp7vDFkDywYoHbPfkISPH1lY/wDgH4h
	 2+rhXP4tFXs4BBWhabxRyUb/WGT6sl0S/SsdUJM5EvpiF69S9zbzr2amt3pgXPqa6r
	 34452VT0xBgJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56945380CED9;
	Wed, 22 Jul 2026 23:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/2] seg6: add support for lookup attribute
 in
 SRv6 encap routes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178476121088.2053389.12322755825413389544.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 23:00:10 +0000
References: <20260712021155.7621-1-andrea.mayer@uniroma2.it>
In-Reply-To: <20260712021155.7621-1-andrea.mayer@uniroma2.it>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: dsahern@kernel.org, netdev@vger.kernel.org, stephen@networkplumber.org,
 nicolas.dichtel@6wind.com, stefano.salsano@uniroma2.it, ahabdels@cisco.com,
 paolo.lungaroni@uniroma2.it, justin.iurman@6wind.com,
 anthony.doeraene@uclouvain.be

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sun, 12 Jul 2026 04:11:53 +0200 you wrote:
> This series adds the optional "lookup" attribute to seg6 encap routes.
> It selects the FIB table used to look up the route for the first SID,
> that is the outer IPv6 destination of the encapsulated packet. The
> attribute accepts a table number or a table name.
> 
> Examples:
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/2] seg6: add support for lookup attribute in SRv6 encap routes
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=144c45b656ad
  - [iproute2-next,2/2] seg6: man: document the lookup attribute for SRv6 encap routes
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=ce0464ea1238

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


