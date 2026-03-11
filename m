Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBF336EABF
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773196830; cv=none; b=pM2XysPQHBWjz9awpTaDwBEbliWvJD475GbwbLWsJdHyHie3edfaEMxNB8w3D6tOIIdjJsR2TB11pd4zCiZVoV5aKhDUtcmmFfoTLV71vfvQz1UNNdccdJOVdYq60Tzx7ZOT5VhvnSu73/QkYC5dwic6/rhTag/H0ixCb/LTr4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773196830; c=relaxed/simple;
	bh=x+26bV6NB48NsGQivd9Gz+0slvnxHCiCsxeUf5KMzU4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M54se8m2pi5Njkx/jCQO705Nu++FnX4CAInSwu65/mQ2ZoCkVq5MvHQ3E0sXweobJHOQo/cWh0zXo+dh6S2KUm3GtGKCL20pkpGtkgnkCqlckCKWCNf5UK5nZCVF5sV8/JNRh4r+md3pQkSX0uGiUfyudHzLyw952lBePcPlemE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKgPKkc6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKgPKkc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83331C19423;
	Wed, 11 Mar 2026 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773196830;
	bh=x+26bV6NB48NsGQivd9Gz+0slvnxHCiCsxeUf5KMzU4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MKgPKkc6P1P/vK0QllPDRaptwebyfwc7Jx8BhZBDxcOaa6ebgm0zORN7TUZYgA7Bv
	 GzfuZik9M9UIXwiLeHS2CbQ1pAvBAcw+655jn2Mn4ZwYZ4tkyqmg0R/mHUfLecJVPb
	 KJmYmZKD9VEt7coNHc/5+Oo0wqqCeKFOYU3fJrYw01cars1p6QLpeAHrH3h+eZZ1rM
	 5loOzW01nR1zoSRkAeEizwWxP28VoJGVw8gIGC4vcrgEPJZtfbwX/LFFC85qgVjeJz
	 q/kuBImLUq+RXqNolcmbNxfIbqnKt3hhKPs5LsuDd9OwtlX7jHWp+Xy8e8d7dJ+TuB
	 pqFbGh7u8Kc+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDCE3808200;
	Wed, 11 Mar 2026 02:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ionic: Report additional media types from
 firmware
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177319682704.3014711.2482785792686293576.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 02:40:27 +0000
References: <20260306215634.64550-1-eric.joyner@amd.com>
In-Reply-To: <20260306215634.64550-1-eric.joyner@amd.com>
To: Eric Joyner <eric.joyner@amd.com>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 6 Mar 2026 13:56:34 -0800 you wrote:
> The device firmware supports reporting more media types than what was
> there in the past, so map these new media types to existing ethtool
> bits, which appears to be what other drivers do for media types that
> match speeds but not physical spec.
> 
> And while here, make a very small cleanup in ionic_get_link_ksettings()
> to remove some unnecessary code duplication.
> 
> [...]

Here is the summary with links:
  - [net-next] ionic: Report additional media types from firmware
    https://git.kernel.org/netdev/net-next/c/1f9cab56e79e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


