Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE17B40928C
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661038; cv=none; b=pALoGArR6nEWXpPARptO8JT0DrA8gJRxfmjiUGSAM4HXB/S3xb6oBFrVJZuwgmOFOVj1v+sZxtwYLCy2YUOfdUUwbLyMmdB+xvfESIvpo6xdHIZVNUplcUucnYQ1gmItCJTKY3ItJfRhrJT6GBSO2jnTxhAcXaW90AHi2bKAoR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661038; c=relaxed/simple;
	bh=7E15n0js9QZelBYgn2+HLriyOTsgqUtG4Bq5WdnPPLE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jYy1dfv292P5tLok3zhZqAbHe0SYJi9ZjXHBFzFQCWolbLlhznzdNySO0bcLO8kIBwhXT3gVdvj2Ls47EEd27OE/or6qZ94fy+vWk2uueY/UKHkKqEbQ1IkBXGV0K0PqWeK3SGDqUrgQbSblH3J7snRJAS2GrZZr96aD1Ppc5mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzhVymRg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzhVymRg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C2F1F00A3E;
	Tue, 21 Jul 2026 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784661036;
	bh=M1dOCHxY1EMCz+VOzX73pgJJsh8dGqE85/PX8+ifiQQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YzhVymRgtwkZ7Q5ZRBtyNLTPR2EITC0ZihotfTNBvwmTtv/yRjwCSBBEVfA9vP2kY
	 d+F0A1AwLGlXaTk8nNXQtyOQLsFWHcW1fCCZfqfuxz++On99MNXHu0RKno8/2IyfQz
	 sio6ku3l97eiWH2z6EoRc8LDpBQgPzNu7dYialqyiIJOKWGkdRdzjJ4zwYyovkamlo
	 jPu8PYfGPcNJT4A6ThUoJSidt+/MqD3uoYSCVcnioBz3wmhnKUzOaYtfKRxgLckcdu
	 j1zog/pJe/5Td4cJ09AQIgA3xSFP7pYADbOeS4RD2tRcj2mnOv4D2QbCezEDctQFXb
	 5FLd7eZO9vrZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939C039253F6;
	Tue, 21 Jul 2026 19:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mailmap: update entry for Alice Mikityanska
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178466100615.967804.232377576889844738.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 19:10:06 +0000
References: <20260710234319.328687-1-alice.kernel@fastmail.im>
In-Reply-To: <20260710234319.328687-1-alice.kernel@fastmail.im>
To: Alice Mikityanska <alice.kernel@fastmail.im>
Cc: kuba@kernel.org, netdev@vger.kernel.org, maxtram95@gmail.com,
 alice@isovalent.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 11 Jul 2026 02:43:19 +0300 you wrote:
> Map all my corporate and old emails and update my name.
> 
> Signed-off-by: Alice Mikityanska <alice.kernel@fastmail.im>
> ---
>  .mailmap | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net] mailmap: update entry for Alice Mikityanska
    https://git.kernel.org/netdev/net/c/043c1f6d84f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


