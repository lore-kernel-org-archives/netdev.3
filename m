Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DFD2E424F
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769482822; cv=none; b=GkZkcTNf3ARQFfixMV3HXHdQjsi+soPHoelymHZMfkgERaylpEMj83XDIEbM2kUB7L9a0BrzflyYfSLh5izkCOOIgmSiTF3AD6ZuCwBDi8vb/dev7Y6UjlSZdeIJNxPxh0Z0b6itxejWAxsG/kCZ+O9TzJNatbYi03eptPlRDKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769482822; c=relaxed/simple;
	bh=02jYaVwuKharSwhauytpia0fjRiEJfcwHBSSlX+VfdM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VRl1uwl+zy0ujlV+8HA0fV3scw8vfDoxAET9p4c5TkNWSfZoRpd6Cmxsh53AF/qt4ojmE268/vfifQ+8APBlPOymPT0pm48BrL5Qpp51o5DHvWQnYZDFW39r5d3jy2Kje9BlG9KKFXL5VMX0ig7++ASxOJWfJF6rIEvGygSoe64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsZOy06C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsZOy06C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9500BC116C6;
	Tue, 27 Jan 2026 03:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769482822;
	bh=02jYaVwuKharSwhauytpia0fjRiEJfcwHBSSlX+VfdM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jsZOy06C6wal4hd3kZnJrnfIIRmXIsRlFQylZllIqCfWVzrNW4UFK+hmZafE5a083
	 q5YhzwNbsHed+/rb4STcGzxD9YZjy1bJVLYrVl8pQBns+st3cG3itwRAcTU9d9QPBI
	 ZTFIaxssPn+nPjYb92HLlMDWGvgs3epw2PR1l62mBr0tTVhp5M0nf63eRvo88HryT1
	 Mb7RjG/u71Ut066/9F0HwdN5dfSB4euXXPzTPlKfKsmTomQaOYX4fIT12WjzXGv/5g
	 QHsFyxSLrP2mhs+rVmmBw9pLYZ3F89Oid7Z54ahSSarr+k2+CMrYkAlNt2qjW2wRtL
	 XdkHBu/RdrEEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11DD8380A961;
	Tue, 27 Jan 2026 03:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] code clean up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176948281659.660450.4225430749989258747.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 03:00:16 +0000
References: <20260122194949.1145107-1-justin.chen@broadcom.com>
In-Reply-To: <20260122194949.1145107-1-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, florian.fainelli@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jan 2026 11:49:47 -0800 you wrote:
> Clean up and streamlined some code that is no longer needed due to
> older HW support being dropped.
> 
> v2:
> Dropped a bug fix patch and sent to net instead so that it can be
> backported to stable.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: bcmasp: clean up some legacy logic
    https://git.kernel.org/netdev/net-next/c/9271fc31901d
  - [net-next,v3,2/2] net: bcmasp: streamline early exit in probe
    https://git.kernel.org/netdev/net-next/c/1fd1281250c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


