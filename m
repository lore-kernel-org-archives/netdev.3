Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A05332EBC;
	Thu, 30 Jul 2026 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785372651; cv=none; b=QMez+U2w1N2eNXiceuG+2hAC1aydgeeKAOlCm2B+DOnD2OMQaWJOuAoJ1TJl8FV0bVblbELPQMJ9ojAJL2vbtdnrjeGlmYejK9fNiS/PuSFftXNkr0a0gF33j+s6d+5uOA8gxLzVzmZHFj8ZzLN0oJDtpqsXhuatsUtEs/kIsmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785372651; c=relaxed/simple;
	bh=V4korjQhFkL28XJjXtjX0IMbnVqkirKI5MtIWBJtqTM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S6BxT7DY5wne9u6SEVkkT2r2lxE/LcNaYXrRK5hIuuHmu+86BfZt0mGPKFLsfvIArve4jC7qaTACSQWM0SlKXeUMFttpoDp6gOa/VBUkHmbdzvrflfzND5BfgTOWKnRUSHSbglFs2rPTs/+OOEEFwLjpGnjJq55wQP8sToOd+H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=effPoXOg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="effPoXOg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46391F000E9;
	Thu, 30 Jul 2026 00:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785372649;
	bh=yaRApCO2f6y3WBPL5pFFKbJXlYZtJ+2BoizGjzbYVSc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=effPoXOgsEF8oi0LGsKHRJq3vV5ybpYldIFyG6rST9sPuXqcUoPDnk4zdeKwJEujx
	 UKKgcMmfLTiHR8evH56HWkta3VlZzX44Ol5YBHVSGrqYdClU2TDsH1L10aKwB8RZrK
	 scpzJDJHIPk80wQQFvsJ0BxGkfbBdg276SqZIfknsh0F1sKvvztGSmNGWvVB/J+U//
	 K/r7TOj4Hxf/eyS4I/teQaw84H/xv22qfAL31YwG7rz3Jqz8VHP051sGvpRjZgn1wE
	 jWTUaZzRJdxz6mhJR19ytqKn7ioE1lD3860hyRuYHa5VXUkyuwjAb+NavuwCtqgQ6I
	 UC5ySmrr31luA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1983A3926251;
	Thu, 30 Jul 2026 00:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: openvswitch: fix skb leak on flow key update
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178537261363.3300615.16001981204180035474.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 00:50:13 +0000
References: <20260727181851.306076-1-i.maximets@ovn.org>
In-Reply-To: <20260727181851.306076-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jul 2026 20:18:29 +0200 you wrote:
> Fixes for two issues reported by Sashiko while reviewing other patches.
> The root cause is the same, fixes and the Fixes are slightly different,
> so two separate patches.
> 
> Ilya Maximets (2):
>   net: openvswitch: fix skb leak on flow key update failure during
>     recirculation
>   net: openvswitch: fix skb leak on flow key update failure during ct
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: openvswitch: fix skb leak on flow key update failure during recirculation
    https://git.kernel.org/netdev/net/c/e1cf066244da
  - [net,2/2] net: openvswitch: fix skb leak on flow key update failure during ct
    https://git.kernel.org/netdev/net/c/bc62e843bc48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


