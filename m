Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1628325B0B9;
	Wed, 10 Jun 2026 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053222; cv=none; b=JyaOdUzuNN2Fnyfwh6JkYzUQbme/a/ijVH3xycArpSUiZtdPt6HAZkRnZnm60yZ9CyKC9Pv8ElAeVw5lhPfGhF+eHuoJ8BGSWtB7EvQSuAU6Bl/0Wf4fIfXB1nLZmUmM7zx2imipk7W/XC83ClW7zj1dnzTPa2HIgi63c/KNNvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053222; c=relaxed/simple;
	bh=6jo3pn7ncYNvh+ZM1hipTbj9j/x5TQMoiF2QdfK6p20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GaMh3B1mCQDJeKV40mnEO9w3Yyx2yVx9rBMEmOXNXne+kPQ+YsRcOLoeSkY5J5LnOTX/UI/jC5ZDWTySs0E02whUFI9QQ36aTm4JLdu/xGtr6ZlFHJJN/0bMALCJm9qwk8dKWMJKl2rlAgHm+6Mi9CFaC4x2IUS0YYahPEkmO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTe+smOT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTe+smOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9921F00893;
	Wed, 10 Jun 2026 01:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053220;
	bh=CisMcesBLTys4b9llimGpTUDsNVeh8kcpD3Tlw5QUk8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fTe+smOTfp508L2lL1WGLVjJ/krIGfi0yOM7CXQdNTm7hbr3W3zTwyDRXycpp6oul
	 sO2HxjAtXbm7EqcPJVUcRtNlR3lr36zFNXb/NfWMITsI4m9S7G5CJ20+L7iZhJvro+
	 fcx1UZ704EGTwb6JergFpgrCIbYKR+s79abrdqosM/Xm+gDQoDSMj+RGPrOCe1Ek5N
	 oCZyX4nX+dtV4WZzThP+bu1HqP4rQA2QCAXDFGZnSb32iW9HFBzc8U9p/AzeP2OW2q
	 BUKkLNVx9LiY9XJhwOyljBwD+g+h7dV6vu3mx3h5rEvEaIXPNqGUATnTtZa8O/GNi+
	 VFd2BOaDFfl0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198C83930A12;
	Wed, 10 Jun 2026 01:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mscc: ocelot: validate netdev belongs to
 switch in .netdev_to_port()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105321863.2773882.14974731560626407551.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 01:00:18 +0000
References: <20260606125247.305167-1-mmyangfl@gmail.com>
In-Reply-To: <20260606125247.305167-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, vladimir.oltean@nxp.com,
 UNGLinuxDriver@microchip.com, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  6 Jun 2026 20:52:44 +0800 you wrote:
> The .netdev_to_port() currently takes only a net_device and returns the
> port index, without verifying the netdev actually belongs to the switch
> being operated on. This can cause flower rule parsing to silently
> resolve to a wrong port on the local hardware.
> 
> Update both implementations felix_netdev_to_port() and
> ocelot_netdev_to_port() to validate ownership. Also update the callers
> in ocelot_flower.c to pass through the ocelot context.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mscc: ocelot: validate netdev belongs to switch in .netdev_to_port()
    https://git.kernel.org/netdev/net-next/c/ea07514700f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


