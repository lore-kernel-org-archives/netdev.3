Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C03659F1
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 03:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769658632; cv=none; b=RKsSCVgFhYoo0lTqOXdJQhtjf1PK/KfnrZ8SLwQi+BMlQ3qUuw2pOWxjO8vIGl+xD6oomh7p7VJBkbPCxDrlLaJFTVftuXy+luCrW5SBDFPXUpHy/I40Gbnsk8ZuN0Hwgq/557KT0qE+3V3TAueft+SMHifkhUcLD2G70m9D5us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769658632; c=relaxed/simple;
	bh=VVdO+crzD2uVFsO5lUBLphNTvHbTd4r93piNf4B1KPk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mL3VmGghJTHMA2e72AdXp6dOe8ir/KjXmOap+kM0u33vq+2bWtzP8e7Ud7jkzR9g+k/NfuFkUWd/AK3U4FazP50S7bv4cQD22M31/qCFBQsHjL1goLV/NyDm3UEn8U4kdTKj7sSRUgCfjcLthNRwlNL/YOnIA+92460qhV2sJzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZQjBGC3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZQjBGC3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97917C19422;
	Thu, 29 Jan 2026 03:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769658632;
	bh=VVdO+crzD2uVFsO5lUBLphNTvHbTd4r93piNf4B1KPk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IZQjBGC39q1PLec2vz9U8e+OhCogSBblHvoQZHsx3Xd6L10bXFfYWfIiLxBghwjay
	 W4BK/QeTwUXW9X3yhI2Q8XqPL9klZJCvqlyAdzVFxKfxogtq7ZvvYTPvN+B1ljTKmW
	 oD3jiJwdT6RaxMnzQemIgUOEdbjkOzPxl2GFK7tun3MAOP7Kg+olPvzAhjnL4AgtGn
	 kh1fZUhkqcPjZ0qC6pGS8HMwNWgm4bPpfqYp9QOKLJb/O8STq9tQCRluiHIDPUliTY
	 YXujdmhXmhjpT2NQh5qDGZAGuPSdpiAa8vEdGMPEMNUD8WyzKi+BYw00ihJJaLBh9Q
	 GtoN1z8p9S4Ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 119F4380AA61;
	Thu, 29 Jan 2026 03:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] tcp: tcp_tx_timestamp() fix
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176965862559.2339773.10119451321287817275.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jan 2026 03:50:25 +0000
References: <20260127123828.4098577-1-edumazet@google.com>
In-Reply-To: <20260127123828.4098577-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jan 2026 12:38:26 +0000 you wrote:
> Fix an old bug in tcp_tx_timestamp().
> 
> Add one corresponding packetdrill test.
> 
> Eric Dumazet (2):
>   tcp: tcp_tx_timestamp() must look at the rtx queue
>   selftest: packetdrill: add tcp_timestamping_tcp_tx_timestamp_bug.pkt
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] tcp: tcp_tx_timestamp() must look at the rtx queue
    https://git.kernel.org/netdev/net-next/c/838eb9687691
  - [net-next,2/2] selftest: packetdrill: add tcp_timestamping_tcp_tx_timestamp_bug.pkt
    https://git.kernel.org/netdev/net-next/c/6080d525aba8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


