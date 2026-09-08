Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE99364941;
	Tue,  8 Sep 2026 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861668; cv=none; b=RRyhnvIbvlml4HzwMLVIomZX6IWl/FATUEpv94+wthVXELr4ZFUGN7/RvN4Sv1qiOYRUSTpOe5rtrwEUW3gCSUGFlMu84uWgz3Uv9a2ihdPhYuakwk8v3jKIaV9CuvQdgHjXHnrSMMEj2AI27yDy6uAS4xz1xOEr5g8B0XrA7vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861668; c=relaxed/simple;
	bh=RwMt2ZoKKZhbypVF7XntZ9YSCz9mLNjNib0Jx1z1EPA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E5BUCBDufqnPrNKKUVMZCDWQDmst/RQmytxR80oBA+hFLnQh4oecPi+rPV7pOuqzcTSMlSR0P8uoKYs0HHJ0WxVWqmN9EJAIPUqLHgkbuR31YVWe9A8SNWNpPpyRD8uO1Mq6bB+PGkra2GSx6CgcPJ8uNCvDCnMr7lAhOF228fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCW7IftG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCW7IftG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230A41F00A3A;
	Tue,  8 Sep 2026 10:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788861667;
	bh=zH5Zm2bnvfb1Ay/0SpYoHJ1gt8dsx1C7VxJjx8vO1ls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bCW7IftG5TbE5jEnKxYEV72iJdttoyh7fwk9/jLR6v/TGirE1g8e4HBWOvhK6zYGE
	 raAj3gAuPObW4IJuo3uBXcNJLh5Z0YoTz1w2OVYLsZu5bSs1B5bzNboMkglNkG74MP
	 6K8oTQjRxPqZcd4rZgZPzYqNZ7xmZYo1sDXvLdUYN89pAFc7aL6fxSfcJG0NbQ9mA1
	 ViKWD777+kh4ZZa3G0MqzT1KE43PAXvKyPlJrL+feEzbm57TT77piqNRk/JYMDjFsZ
	 9jz49Be5l5BtVxRAy/tGQwGHNICO84fKqm4Tm//Zlnv90CUaAin4FYEv3gvlfNb0v7
	 eNW77O9oTqqIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B1639E9600;
	Tue,  8 Sep 2026 10:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: macb: fix the link speed the taprio setup
 reads
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178886160578.3435835.5888416627064413364.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 10:00:05 +0000
References: <20260903123652.23900-1-f@lex.la>
In-Reply-To: <20260903123652.23900-1-f@lex.la>
To: Aleksei Sviridkin <f@lex.la>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 vineeth.karumanchi@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  3 Sep 2026 12:36:50 +0000 you wrote:
> Two small fixes in macb_taprio_setup_replace(), both in how it obtains
> the link speed it scales the schedule with.
> 
> The first: it hands phylink_ethtool_ksettings_get() a stack variable
> it never zeroed, while phylink fills only what the link mode provides
> and even reads one field back from the caller. The second: the speed
> check is written as "<= 0" on a u32, so SPEED_UNKNOWN passes it and
> turns into a 1 ns hardware limit that every entry then exceeds.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: macb: zero the link settings taprio reads back
    https://git.kernel.org/netdev/net/c/0523d5c52a45
  - [net,v2,2/2] net: macb: reject an unknown link speed in the taprio setup
    https://git.kernel.org/netdev/net/c/2b6c0e25a3d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


