Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3CFCA52;
	Sat, 14 Mar 2026 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773516626; cv=none; b=sT03K8yZpN99jV+lSKlR3rF15awiNfvEye4Nl4WXf4jPgyx2LmooWxlVNPj1ht5Bch4P0woUv2GmZ19fTMjiNs1WiSiEQg6/ErUX/REUL8VZViTLCjY4HqpNdbSxUvpdcQjIlW5WoTO819+hfu/EkEW8mBZoE5iI3SRFdsIvtEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773516626; c=relaxed/simple;
	bh=NP3yDX6TTmPwo9gNyddq2g/G3iG+qUKfAPqrrzT+xKU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XpFbJQZe43PBlSkQsikbG78UN/BJ+hsK99XSDgLjvXVdfSZOPKulreUP+qmi7YJpZcCMB5pwMXAx2/60gmcl9L3HIgcHyWekjrejE/i9ZMIRRWZsG6P387hDLyqBNk3Oy6BPTU4ecT6KSN3qiB8vBq2LZDXzBW+6SL9Xv/G/lwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awA7/CRV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awA7/CRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74490C116C6;
	Sat, 14 Mar 2026 19:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773516626;
	bh=NP3yDX6TTmPwo9gNyddq2g/G3iG+qUKfAPqrrzT+xKU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=awA7/CRVhFBgmwdfaLaCIHiTfQx4G5sqI9ZJdD8AR64hhVNSCjesCBd9OwTblAlXH
	 /u8oRjZ5zN1TaZXhN+S0Bs9wIqxW9o7FRpRK6WPwzyTue6d2JlG3H9vUZx1GcDXIiG
	 QmOdyFagS/uY7RBED3waX4HoQvZA29MAKHt6LyFRCq8JVsRe9jXZXYtqjJKX0jXe6d
	 TGWFGXzG0yYCNNd1ELWsQY2UF4r1bWQ3XbKBNH5ABy7sCVPtp1ksIxnCwMvK4g9Nqg
	 oQcDSeJMyQb7XiwdmZJyYtxxjNIblo8tbGvVttavdEz3GRRrJyw0Gm5Evui/JFkQLe
	 qncn6f4cuXMRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1DA3808200;
	Sat, 14 Mar 2026 19:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 1/1 net-next] net: usb: cdc-ether: unify error handling
 in
 probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177351662029.1763199.5176772984928366532.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 19:30:20 +0000
References: <20260312084612.1469853-1-oneukum@suse.com>
In-Reply-To: <20260312084612.1469853-1-oneukum@suse.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Mar 2026 09:45:32 +0100 you wrote:
> usbnet_generic_cdc_bind() is duplicating the error handling
> multiple times. That is bad. Unify it with jumps.
> 
> V2: Update error logging with every cause a unique message
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> 
> [...]

Here is the summary with links:
  - [PATCHv2,1/1,net-next] net: usb: cdc-ether: unify error handling in probe
    https://git.kernel.org/netdev/net-next/c/a99f06e579a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


