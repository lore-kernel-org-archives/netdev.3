Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7961E7C18;
	Sat, 16 May 2026 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778891393; cv=none; b=HMxu/KsKjMtIG/dGXdthe3Aw4PEfhZDYhYPclXpOXStvAy6RhfEcxfyLf3QCC0vauOFRC6ZDG16SZX0wFh7xbsAGitf4hdiPtyy1UM7WgX3V4ewuY7Eb3+3cJWQja+iknByXCUb+onj3HWt7FsznZ/zpV3YNBsW236AQR184w4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778891393; c=relaxed/simple;
	bh=Hp6hcX5gx1NPqEpF6beel4d/jDeir31hwJ3tHZEn4sw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PWSGoClXd60/1rDug5P8QmumTWmlHouy+atQKOFmx+pkWU9kUq3mzQ+koXO9Uos9djL0G0WOjcEgEP9p/nd595CB3S8tq8GxB8lAitMyALs5rQMI/DtdDqt0Y6x2AU3vGt/MrX4Q1GIQlvnFO0dPJgX3WUB4LqshjVPp9maXzVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRXEd7iB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRXEd7iB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C8BC2BCB0;
	Sat, 16 May 2026 00:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778891393;
	bh=Hp6hcX5gx1NPqEpF6beel4d/jDeir31hwJ3tHZEn4sw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sRXEd7iBCRjQz07/AX/7lxsfDV4P3r46IwARmGWZwCtrPvFsj6JVS64/QOVM85xb6
	 3obi2lMwLpEcbm/ScqCDhorH0RAZxj3JipB0r1LmwhwWuAMunPF8dUuhFRn1ABUHjO
	 2Y1XRst7bPbJJ9EGfeU2siBNNBS+3s0BAnADbUCOa39tMaJhD88Vx4e681jwFNe9mi
	 VxzOQCOv6+foQj4Qbv0K6z6EA1rpMPFg+EEw+L+ULfjDqYbcsMtrXnJV8uMNOaIhGu
	 TBNN7RYhuw187ECvvsS10Kulz47jRUPnBcShXXxpl6epr31ifpnYA/XbzMsi9qZM7I
	 //8YKoviIQPUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569323930A23;
	Sat, 16 May 2026 00:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: CGX: add bounds check to cgx_speed_mbps
 index
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177889140614.207359.1820103760731056941.git-patchwork-notify@kernel.org>
Date: Sat, 16 May 2026 00:30:06 +0000
References: <2026051352-refined-demise-e88d@gregkh>
In-Reply-To: <2026051352-refined-demise-e88d@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sam@samdaly.ie,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 stable@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 May 2026 18:42:53 +0200 you wrote:
> From: Sam Daly <sam@samdaly.ie>
> 
> cgx_speed_mbps has 13 elements but RESP_LINKSTAT_SPEED can yield values
> 0-15. If it returns a value >= 13, this causes an out-of-bounds array
> access. Add a bounds check and default to speed 0 if the index is out of
> range.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: CGX: add bounds check to cgx_speed_mbps index
    https://git.kernel.org/netdev/net/c/c0bf0a4f3f1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


