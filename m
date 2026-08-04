Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C333284B2F
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838247; cv=none; b=ZPJLbChXFdMIqw6konxxpviQZhc4spXIeWlNsmPH+Ysrw2NjgCo8fxb+zPL4jrIoLBl9vFi5iWWZFMmUJ57Fh/GlK8njymqmoZ2YcymQNv5WBm0JMsKIEtKD6ytDo3rAv4Dex3HQ6RS3ML5/1ouwU46fFXFD58R5nHZlq8Knj9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838247; c=relaxed/simple;
	bh=+xIVvbU7++sFxKZf836M9T4C55YapKXkTO5mClsb2u0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M6HZZKg6CjEtUPDM69D9jYBoVCY8KomSKy/BYC4SGQoTO86KOZ6Ko24kFUtB4Y/mAfdLfut2whdUH+mw4sRh2ndP06U18SKpq/TTeunf2nt4o4UfPW+DAPdc+gFOLiV+2NWpDwjXiXW00svz5E/99EUWAiagi2OHPK/xksw7V2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWQSTxbs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWQSTxbs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93BD1F000E9;
	Tue,  4 Aug 2026 10:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785838245;
	bh=kD9tyF89NnfoWOCKhjUwI6dp7OpA8CEKcQEUAvVR/EE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZWQSTxbsTunaLd4Il+5LP3g/nIcGNZbUMugpo6d8jW9lvA+a+lR7YeJDOC8SjCUi2
	 cduUA+gPmjcJNGrzDBwHzteucgg194koYcbxEZqeF4S5pCAZLzZ83HWHA7fcuB9m3m
	 /9I8M4KN2jo5nGVJ2jrhOdJ3HMch1Uw6u1HcnjxsE1+c8ioDYpAjkDpA6pXQyGT5SR
	 HzcFubN4sHHm38/I0RFQOsBAn91SoQg2tDDdqmo1XbWa3xSo0rht8PdHd9Vg796SPq
	 +5gSKKobfObL5Cq9+lJkysiFnLZVKZqrAf0YOpFM4SiHuA4xBR3W2PlrPpiSBzHFFX
	 VAIq+9VNGuq4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C693924FC7;
	Tue,  4 Aug 2026 10:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/1] packet: fix stale ring mode race
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178583820614.3079067.12649393810230740659.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 10:10:06 +0000
References: <cover.1785247446.git.zihanx@nebusec.ai>
In-Reply-To: <cover.1785247446.git.zihanx@nebusec.ai>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, vega@nebusec.ai

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 29 Jul 2026 09:16:52 +0000 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/packet/af_packet.c. The bug is
> reachable by a non-root user via user and net namespace, with
> CAP_NET_RAW in the target network namespace, through PACKET_RX_RING
> reconfiguration on an AF_PACKET socket.
> We've tested it, and it should not affect any other functionality.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] packet: synchronize pressure clearing with ring reconfiguration
    https://git.kernel.org/netdev/net/c/1a35da325cac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


