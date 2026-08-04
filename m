Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD33236BCDA;
	Tue,  4 Aug 2026 00:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785804653; cv=none; b=SQXyQNle3uHf+8dyPTF4ZQcay1OHf4NGojg58OX/Kj7XRuOwJb1bOeRfzEIq8tF+v2H194ApRdpX/48n9EEqHXVjw3mmgGxi0urBVz1dWAV1uCIeCIn79O4WjDk/8Akvzvqsphvvv/EA4SYHfyrsitT9ZQk0Q1I3TZRPFIWPb54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785804653; c=relaxed/simple;
	bh=MwJbiK+C42LDg5bWLfggiBHOXF35bdVOnxK/mJ8n3dU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lucz3Utdugak8up2GU0ZOdz48cOjFTaFeIuClyp7wfGfiVGDVDEqqXxWKH/DP9ieJ6uLJdFSaZ1Cy5OwBp6ZSMDaNM3p6FtR759VaFY3vRjwXune1sBUZgZeJHWXWimZI7iP8nGi3+o1I0095QMBSxVKMp76t3iOqcfpi2sgRAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKkDJcxt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKkDJcxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376B51F00A3A;
	Tue,  4 Aug 2026 00:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785804651;
	bh=truZYXkB8uoUeVw3Akf5N2rp6MgtiisUzz/pHUFsBZ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aKkDJcxtYh9ncQZIDMn/U1+rTX6JXDYXYowZy9iVhDrX5PC9OrjfpJtcvBLSLJOm2
	 dI4hyjfE0Wqe7fXF8Qtz6xv27t8MIPlXFAGRSweEAsW+ErL8ISBcn1e1FVLTn3HWSZ
	 4McN4sTB2GRiLBlX4RF+kLjU+JvrzAMwBBnrJKNl7DwJrssmZul1XERvKFp3tOr56P
	 4mazZ4r7l0HOA9cXnrNEdGluW+gjkNT2iGtk3AsUnfy6vbdLy8lSRlURgqdH9w2uaI
	 iwDj6+0+ZM3iyBZ2VZxgsMzNpcVsi4jLO/QJUWW6JFkD/m3OyRBCXOVIQLlM2yD895
	 jApOp0AjJkyQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568F23924467;
	Tue,  4 Aug 2026 00:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: phy: motorcomm: enable the reference
 clock
 for YT8521
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178580461189.2897167.9622896344243715541.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 00:50:11 +0000
References: <20260731013807.1488843-1-gahing@gahingwoo.com>
In-Reply-To: <20260731013807.1488843-1-gahing@gahingwoo.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com, heiko@sntech.de,
 linux-rockchip@lists.infradead.org, attinagaoxu@gmail.com, alchark@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Jul 2026 13:38:07 +1200 you wrote:
> Commit 42310a24389c ("net: phy: motorcomm: Enable optional clock for
> YT8531") enables the SoC-provided reference clock for the YT8531 in its
> probe. The YT8521 has the same need on crystal-less boards but goes
> through yt8521_probe(), so enable it there too. The clock is optional,
> so crystal-clocked boards are unaffected.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Gavin Gao <attinagaoxu@gmail.com>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: phy: motorcomm: enable the reference clock for YT8521
    https://git.kernel.org/netdev/net-next/c/dc3b7209b5d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


