Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348AD36BCC2
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773960615; cv=none; b=UzooDovHKzUwP0c0axBew/GcJFSC8VgYbncBDRfuWmLrAiLI8vZxoI3hAyXvu8T4dkEIgx/LIj6LDA6EiCZU/2+DqKU+frme6eMOpqilqMEkmwn7zlzQfHInfQqJvdZsq2WeSvtAy7AVODZwujiYOikDW+LuoughddM2GF0URk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773960615; c=relaxed/simple;
	bh=pbGu83igKhIFm6HKPrOhoTws5QZavAF4F+5XsTGi16E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AtnSs9fP5AkgGf5dRfbCQm8AuJ259DX1Uur8t3yjqOUYbOZvyFFUPAznqZ364X/xzUFuqiU8NNg+X0zwZId3BlevLWBRLUMfEJ6+79908Y/SayLlEAE59hknZaLhQCVlFzygEIGrLVs2xYKTkzTQ/j4eLwwKsizPeZnJtZh/4zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uf5CAMcv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uf5CAMcv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7040C19424;
	Thu, 19 Mar 2026 22:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773960614;
	bh=pbGu83igKhIFm6HKPrOhoTws5QZavAF4F+5XsTGi16E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uf5CAMcvKkQHwwNBCt8UXfXNBRbWgwbyypnxWbtuHHtOjen1dHPS1ghe3iIimBWz2
	 IGCU436tj85/hig2W0vwHHZzwi3f0GvNl+2Zmk4844y72joSpX5stTZuVOtgDL/8w6
	 WUUieYhdgngwv/OuHIGhdXFeGxGQx7IFt5LqqgUXj8M4974XYUQEKVy/fZE/yY97NQ
	 Qg7/6IUDwoJVRoiHbb1Ekm61OrbApgxvYg7Hvw+drVwMWj6y5Fzw2AJJbqY7q6gAB6
	 rGF2x/K0m/kct9v9c8VoWWlFZqXycTvAyqDLeQ32fuObF3f/0O1Q95SzD7tsrw+GW8
	 oqP3E/yx4JLAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F6739302F6;
	Thu, 19 Mar 2026 22:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ionic: fix persistent MAC address override on PF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177396060554.1838217.6467445863157712340.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 22:50:05 +0000
References: <20260317170806.35390-1-mheib@redhat.com>
In-Reply-To: <20260317170806.35390-1-mheib@redhat.com>
To: mohammad heib <mheib@redhat.com>
Cc: netdev@vger.kernel.org, mohamed@pensando.io, brett.creeley@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sln@onemain.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Mar 2026 19:08:06 +0200 you wrote:
> From: Mohammad Heib <mheib@redhat.com>
> 
> The use of IONIC_CMD_LIF_SETATTR in the MAC address update path causes
> the ionic firmware to update the LIF's identity in its persistent state.
> Since the firmware state is maintained across host warm boots and driver
> reloads, any MAC change on the Physical Function (PF) becomes "sticky.
> 
> [...]

Here is the summary with links:
  - [net] ionic: fix persistent MAC address override on PF
    https://git.kernel.org/netdev/net/c/cbcb3cfcdc43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


