Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75E2437864;
	Wed,  8 Jul 2026 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509627; cv=none; b=iNLok5+HIZ8wmv/zKuMl/YnOvb/p/VNdrWVpnyPqDmZsyaU1lnzN+0nDroKHPxHDADrcAZlQHeErAk3MLiPySMdwrD1Wlpu4xjgPGUMCur2IpbeDk9oeNL0KRatoyqkv+E6omA5BfiUHX3IaXXaUlCvGbGhVElIbZoPvpmpV5t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509627; c=relaxed/simple;
	bh=naTLxVv/Y3+9ERX1j0xr+5nj/poeZC/gIQxlXs0FlG4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tV4Y3Vtb4OkGeFYihFNBBBRwwYpR4ZeHs9zsVFaVXJdhd3YeID3z6OeyJ2xc1jQYs3tvxJ4GT2GHh1iYWwIjY/iiO0V40ueegO596A9NbyYY3dqasJu9ZvJ6MvqA/kbvWd4JblzA8RcDK4FHiewAlR7koJONmksM2YshAKmcOEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1x4puQ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1x4puQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532061F000E9;
	Wed,  8 Jul 2026 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783509626;
	bh=AlmlQCmyiMaFrtx4Cjr1TuapotDHv/aiEeNOwcW3/n8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=g1x4puQ4PP8btquU8CG5zu4KwIMmALu+i8Evwq2BgnwCfTye0eRBvTLaJsD8Oqi/+
	 dGJaIT4xBfqF+LlpXMSGa4MVt1TyecGfyp3KQun2nAFmyg2ILL2MqDFzS+ke11h/rQ
	 t6gA+OVsiJmfvo7hqqCH+i9HomM8l4gsPuG7MJa68FSqmshVpem6Rqdd9F0anB6qdD
	 oVvra+0/KpOToqp+H9Lj7HEu76RcdVCa6PXloOSQE0RJ9GM/h6nYvwscHPODuBo01r
	 pr7nvxgKwHOhELk67ruWhCd/N5b04wY8DMyzz83G9s6PBUzH2YRJj8xB3Op2S87N0O
	 axmHah6Tq/fxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C44392666F;
	Wed,  8 Jul 2026 11:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ppp/ppp_{async,synctty}: drop unused
 {a,}syncppp::bytes_{sent,rcvd}
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178350960564.2449791.1582849842162293264.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 11:20:05 +0000
References: <20260702060420.95023-1-jirislaby@kernel.org>
In-Reply-To: <20260702060420.95023-1-jirislaby@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  2 Jul 2026 08:04:20 +0200 you wrote:
> The bytes_sent and bytes_rcvd members of structs asyncppp and syncppp
> are not used. Drop them.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> 
> [...]

Here is the summary with links:
  - ppp/ppp_{async,synctty}: drop unused {a,}syncppp::bytes_{sent,rcvd}
    https://git.kernel.org/netdev/net-next/c/155c68aef239

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


