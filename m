Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFB540EBA9
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128833; cv=none; b=F0/NMdv0RgGaUMgH0wiD4U+s95ZaPfE4t+RejZ17Z6F3X44uu53k8J72sUfxa8UZtYiZ2t+w735aH/MxczYFvymL5Vb1EJuTf6xIVMw010dLX+tGKojOdCvHcuOqlfSZZwfNvl+AoEqXtlQOgTVHlqv++RynyX3EviD6b+x/OWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128833; c=relaxed/simple;
	bh=Bzh30GjJMqappmNFrUinkkhVx5hYWdLFiX326zqTss8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j06Y/avlkc5p/hJpVDuSLZ7ZgmhVYtq0vb99jzn4K/kRlUjNxnHEHQ7/PWOuaTMNTTazNOnGwxQXLBzi8egozANzL6/JWU+SGHjh7C7AKaV0XDNzy5J3WJkQ9dRHez/wJ3H1gAVUbdjktjnzkUP3BlwecQy5gzL6s7BQJAe4gDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib1PtUqV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib1PtUqV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C6E1F000E9;
	Wed, 15 Jul 2026 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784128832;
	bh=SycAcmIFNmRjfstMYjq+9ddAWM76CpAP7qO4daotyx4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ib1PtUqVWlHXqGoFiA38sJrdm4pqh+/UhKpCAB2+w6xIBz6owGX3arjNvyEGjDCpv
	 MJLMHFdGSbtZiujuytprRedYJ9Yjg47F9g16usxJ4v4n9Q+gvcGOaNfhjMIFo8fvwL
	 6ux75Cpv0C8TzEUDZhw5cseoBJEndSxV1rYgl0X3mliWK466guzjw4iOZEBeSULLhS
	 Yv4bOQBZ4GPwhpRK6suXbYF52Yz/hqchw5DmTp9LSZoIgkwHm63ckEjqddq1tO0n/7
	 2AGur88b74hYT4c42pR5ReJkUPENtTnHiaFo59R8ajasx31TOsZTVq5qUn4z+w6cEA
	 8EPwoRRiqDSOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199F8393AF8B;
	Wed, 15 Jul 2026 15:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] ip: display DPLL pin information in link
 details
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178412880565.4127287.3287584044929138457.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jul 2026 15:20:05 +0000
References: <20260713092119.1536385-1-ivecera@redhat.com>
In-Reply-To: <20260713092119.1536385-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, poros@redhat.com,
 dsahern@kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon, 13 Jul 2026 11:21:19 +0200 you wrote:
> Parse the IFLA_DPLL_PIN nested attribute and display the associated
> DPLL pin ID in 'ip link show' detail output. This allows users to see
> which DPLL recovered clock pin is associated with a network interface
> without having to cross-reference with 'dpll pin show'.
> 
> Example output:
>   $ ip -d link show eth0
>   ... parentbus pci parentdev 0000:51:00.0 dpll-pin 4
> 
> [...]

Here is the summary with links:
  - [iproute2-next] ip: display DPLL pin information in link details
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=20e860c632e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


