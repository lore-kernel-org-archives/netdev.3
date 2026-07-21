Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C89318C02E
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784631042; cv=none; b=dLDr6p9tj9QaruMYaGJlBF6xqbnLdLqv4BHBv9YxtHM2q4SiYGG5sSZevi0fYc5IBKHxsa2aRIp9mrjD3NFBryDBg0pW6+CiJNYuLkVe7kVAKYqjPX7JxvbBGqojXqoxTDMZZ8FZZqFpeooWU+NT0AFP7JjU3lOocEuX5rLnfns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784631042; c=relaxed/simple;
	bh=l9l5O8vjlaq3QaKlMgCpwMNySaY1Hzx56m4Blt+qaxI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d8Rvuh5tILdOFr6eSb6brisfc3A3+kd9F2kV+Z1qZkvCAZ3Tsdwf7YZcHH/gTfb8mqzzlmQs06+SoCHuH8/RZ7Fy4clu+xq/Pkfr/TWqeQEr3pwdyhZlcO0SwGSGXFxJX6Ns41B5NjK0/WqWS8eFznepINQY03a9ips71jwKTKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3zLRMOR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3zLRMOR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E0F1F000E9;
	Tue, 21 Jul 2026 10:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784631041;
	bh=RCHeIDVhAyG4awo/rT3qaeZR/NGtRZQgt3bw/8ZIhv4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=k3zLRMORhv7Qcca3m//gHdPdoxZ+UZ7amiOHsMO+2MjgNlGcQMjpKoFgEafp7sAA1
	 qMag8m0u1lqplBAYVIBnh/ci1fivgf7c+B5dZES14abpMKVT5yIhUxg15Olr8DHcCb
	 +NJxG5jQ7RDLoZzGKBF9SpJf8ifrOdbB+I4pNmP+IFPtVYcGRNjRTsk+mzFCxcCfqr
	 oxPtYrOomn6/SNy00lv/fpy04X+jXFQR7v12Rxw6P99TX1zO3T65WcvXio9xMz/GHe
	 4MG4MxeQRKIc+1Uq8tYCjkbWmMSpesNGWWaM/zZQT0wyKa8U8sHXJwa/3RilELgMcX
	 1Z90/k9yN9pyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198153924A74;
	Tue, 21 Jul 2026 10:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] mlxsw: Make the driver ops-locked
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178463101064.226177.17488027333127938570.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 10:50:10 +0000
References: <20260708123933.1303291-1-idosch@nvidia.com>
In-Reply-To: <20260708123933.1303291-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com,
 andrew+netdev@lunn.ch

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  8 Jul 2026 15:39:30 +0300 you wrote:
> Make the driver ops-locked in order to allow ethtool operations to be
> invoked without RTNL being held.
> 
> An ops-locked driver has most of its NDOs, all of its ethtool operations
> and some net device notifications run with the netdev instance lock
> held.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] mlxsw: Convert to async version of ndo_set_rx_mode
    https://git.kernel.org/netdev/net-next/c/a5faaa079c61
  - [net-next,2/3] mlxsw: ethtool: Prepare for RTNL-less ethtool operations
    https://git.kernel.org/netdev/net-next/c/925a17fe4309
  - [net-next,3/3] mlxsw: Tell the core to use the netdev instance lock
    https://git.kernel.org/netdev/net-next/c/0501dd682648

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


