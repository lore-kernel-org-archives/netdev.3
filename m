Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E82364055;
	Fri,  8 May 2026 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778283657; cv=none; b=fMUNdYJXOGFtrOzTWbDTJjevpeZ7V6yfJ4asdkMJq4D2yHCI/XoJvNx/1ms0Yw2C/MToGWpddJ2x/Iy6j35syxq5hvaODQwjFxpUtss5Trn2ejz6uLuRQBs3iFea/dSQSL7I3tmuS2yVxCl0p1FbhajVcC/nsLgnzSQU415GYfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778283657; c=relaxed/simple;
	bh=Ddjr/eJZZoInUIx/ym0Y2EcxljNwQ60zhTfnaf+zFgA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TW2Meb5vqGwVUy+tAeV7ur2SgiYH+dV78EsPx26snG1OP6kFDya6iyos9rRUFPHBRxD2Izcto16K7EzMYLIZLZV++FTR4UdgC9nP9hl2rBXb/BBEHhmC2Mt9lf1oVDK1xMB9qgyI5nBIOkzGbOxy5+Eh3n+xyX5KHTfUFx9/s+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgJT9Ysr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgJT9Ysr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263ACC2BCB0;
	Fri,  8 May 2026 23:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778283657;
	bh=Ddjr/eJZZoInUIx/ym0Y2EcxljNwQ60zhTfnaf+zFgA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UgJT9Ysr6UWuekEE8WZsqrxMy+jyN1kAsiilSQJG9DSDAAcpwkQQfp6Gy21r7rZTR
	 nwaepsf2kvraXwtTyD7ECqkSPGsBJmB7R1XKxGxD/TqMTsqxyTfsmGDTap1DjcwQfH
	 FqpXa0xNFnzUZk+hczXMAk6XcEm/te5MB12zbVH5AFlbCVqKmfWXRmRIol6VybkRzl
	 imHazvGGLyNXpsWE7nEA1X32/XNWAoJ700sy0XOlRbvXhVr7CitHfUPIae3Q4s2tPr
	 gtqprWIAls5ni/Zr/1RlFD86NMWGQLok8cuX1a6g9z4tWRKSf/KDcoThhcrceGe1/8
	 pCS3Ux92JP9HA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EF638119DF;
	Fri,  8 May 2026 23:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: lan966x: avoid unregistering netdev on register
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828360559.897985.1784544891349710541.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 23:40:05 +0000
References: <20260506124331.31945-1-mhun512@gmail.com>
In-Reply-To: <20260506124331.31945-1-mhun512@gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ae878000@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 May 2026 21:43:11 +0900 you wrote:
> lan966x_probe_port() stores the newly allocated net_device in the
> port before calling register_netdev(). If register_netdev() fails,
> the probe error path calls lan966x_cleanup_ports(), which sees
> port->dev and calls unregister_netdev() for a device that was never
> registered.
> 
> Destroy the phylink instance created for this port and clear port->dev
> before returning the registration error. The common cleanup path now skips
> ports without port->dev before reaching the registered netdev cleanup, so
> it only handles ports that reached the registered-netdev lifetime.
> 
> [...]

Here is the summary with links:
  - [v3] net: lan966x: avoid unregistering netdev on register failure
    https://git.kernel.org/netdev/net/c/c4f3d6eb1fcf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


