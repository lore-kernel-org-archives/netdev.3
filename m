Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C78D2DF130;
	Wed,  4 Feb 2026 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770177026; cv=none; b=HkIoAC6TbfaejKNhEhPyUeeai1ZaZsj4SwHlNbHgo+/q2m2URAPCHrDgYkdy0Ss5Zw5CEBhknfTn9flphrdKwjiZ9GZDdAmHHvakBlnoE7cQBZDtm6MyYoygBzcdZvV3IhRuf7fBgsMazLcpQsC1Jb+NJFndRqJ09ENg11PSnbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770177026; c=relaxed/simple;
	bh=DBdPX7NNQGxbeAsS3YX+wbMdH62RhjjuKO3N+opP9Ag=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ly5YF7KWbDXMrNuSFHfRmV9ZdoxrznRrCTm4+Y/V0hTtIfY+Kd8Fnf+SnnqcIip2Q+x4i7C+H4ICx6mj/GimcIXHP1AmRpZdwWg6XAd21MOLV263Qrs3OI1uN5Sn8E0zt878D9pyYCFiDa7KOF+14nnqpPP2WGAZqwwNphiz95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZmgz21o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZmgz21o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEEDC19425;
	Wed,  4 Feb 2026 03:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770177026;
	bh=DBdPX7NNQGxbeAsS3YX+wbMdH62RhjjuKO3N+opP9Ag=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nZmgz21obhHww1fMd23zzkSspbK6ahxp5acLqGCEsiKpHnUdZFpPjSpAE4iU7unx2
	 pK/c10IPcHMv9qqNfM5Q+NANqKHkj1qV+9LGzHBKh74pGJwZ1TzHf4vVy7Vqed6fI/
	 QEA8/sriiWSgT35Ax/pvxaKb9C5m5jh/r/y3R1gaslYSmepIuVCqsHMYWBQ8pbVM4L
	 tkmOrVIIjdLMIgudf/AQgFYrPS9zN4kQbxxKYtNPpqJ0s3iyN6x7aQf1JwA1umLn6b
	 UHfzmXalOIYN814ssPY/CPP1Gyeor0mSV6TGJl3Etw580W6oB8EWhflrKj/YoC8lZU
	 Q75ETOtR/kTFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 90E5F3808200;
	Wed,  4 Feb 2026 03:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: usb: sr9700: remove code to drive
 nonexistent multicast filter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177017702212.2171580.301972725500810661.git-patchwork-notify@kernel.org>
Date: Wed, 04 Feb 2026 03:50:22 +0000
References: <20260203013924.28582-1-enelsonmoore@gmail.com>
In-Reply-To: <20260203013924.28582-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, horms@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, o.rempel@pengutronix.de,
 ebiggers@google.com, rmk+kernel@armlinux.org.uk, peter@korsgaard.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Feb 2026 17:39:09 -0800 you wrote:
> Several registers referenced in this driver's source code do not
> actually exist (they are not writable and read as zero in my testing).
> They exist in this driver because it originated as a copy of the dm9601
> driver. Notably, these include the multicast filter registers - this
> causes the driver to not support multicast packets correctly. Remove
> the multicast filter code and register definitions. Instead, set the
> chip to receive all multicast filter packets when any multicast
> addresses are in the list.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: usb: sr9700: remove code to drive nonexistent multicast filter
    https://git.kernel.org/netdev/net-next/c/9a9424c756fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


