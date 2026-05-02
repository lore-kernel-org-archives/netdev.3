Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1383B28C874
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777683668; cv=none; b=H3+6HpdxJUvb+Y7oc2cTyfgxcRukqSIhX98ORIrF1eBeJYItu5Hv4QL2O7mK0eAz6I+EZnSGKs6zMKHZt170CefDOmwoR0AtTDB+FcCoE9NuXuOt9SoPNi14NvAHhow1tyWD/JRvvSMigzB5Z4/LnloWEHyT4EzEf5Kk+IUkS18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777683668; c=relaxed/simple;
	bh=6VxoKM+xTphV5Dzqikjy6BS2+apjk1/Pd+6jaI3/rDk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZZS9VIwNOeck5iNBHfO5H1rmTEvvIDGEpORjXAmQkkXiqrwpSNu6gQKzBU/Y0YbooZO18K9OY1zdmKZb4pV9iaRs7JfvnswVysTBwDoupzPPMCu3DXBBB++DXec1LPXmo1S/6aB4EZzbH8Wh1ZaXnSULOc6zltJnbBpcYUfQzYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdBb/Oez; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdBb/Oez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B349AC2BCB9;
	Sat,  2 May 2026 01:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777683667;
	bh=6VxoKM+xTphV5Dzqikjy6BS2+apjk1/Pd+6jaI3/rDk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KdBb/OezBkC3rFemJHFe2g2Bpkz5ODr6rF21oCUQkbNNxuFza8k4WMcuf9euYgUPJ
	 ro08CB4FyazyKTZyvgOnqdNYAiDvC083nyTMks6IRhbVTRgRv3S7uB6hhg1frqJkIf
	 3lBc2ViM7F4XlpeElxzZzOEBkR/E0gFgocjagrMLG4M3+UysKz+SZBh16LpAApm3Lj
	 y9cVOnpy5GBQjU+nazInwrEESY95rD+wjQ9j4QFNQLkcflQ3iDTioJX8A7QJA7JQ9G
	 J7o5/LeXOU9AHbEoqTUqTxXa9WRRJUvtseynqF2HKgvOncwS4eG5zQwHEmeLWNqpTo
	 yvn3BiKLBgSXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 03193380CEF5;
	Sat,  2 May 2026 01:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: configure QoS channel for HW
 accelerated flowtable traffic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177768362079.3679774.17100157322999621672.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 01:00:20 +0000
References: <20260430-airoha-ppe-qos-channel-v1-1-5ef9221e85c1@kernel.org>
In-Reply-To: <20260430-airoha-ppe-qos-channel-v1-1-5ef9221e85c1@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 10:47:38 +0200 you wrote:
> As done for the SW path, configure the QoS channel for HW accelerated
> traffic according to the user port index when forwarding to a DSA port,
> or rely on the GDM port identifier otherwise. This allows HTB shaping
> to be applied to HW accelerated traffic.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: configure QoS channel for HW accelerated flowtable traffic
    https://git.kernel.org/netdev/net-next/c/286efd34d1a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


