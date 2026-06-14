Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEC81CAA78;
	Sun, 14 Jun 2026 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781398817; cv=none; b=T/N5ymmf48U46B27Zcs8fEhF91kbgiNDw9w2GTbK4xkO3mfcIZj69z2evcU0bX/MwvHocLMYbxdExcw9IATAspy4qKChfjoLGXJcU6Waf3AsZi3BjxZyNo5MwBc5HafszLOWKiXzxSWOVaN1/dENvs85jaMqvB9cRvXc14Hf604=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781398817; c=relaxed/simple;
	bh=xeItTI9icJsDQO7ZGGZr4yZHn+1kPfSqJn4bWZsXi6c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JRt55UuKl3uoxqzdLx3VzqzDjZnsQ6W8o4VEOF7isCLDcfKacd6ORlbnuAfSRk/LGz9Edg6qvgul6vVSlJZsPUmH11FkLwiNThoswlpqfqQkC01bVO51npjCN+zA0EMDvnFxQRUNslZM2mL+lm/DRZdPKcTfnfK8VsIW2IGhuJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUzZaiWG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUzZaiWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AB01F00A3D;
	Sun, 14 Jun 2026 01:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781398816;
	bh=mrt0kCKlXkjkwpqUsdvtCmmeB0epBgTE7F1Vqf6IdVI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KUzZaiWGOLlD70Gs3hlqfROY/Q07R6GFH2MgNPaShykIz3JjERG+ssjBmbcnhWOLR
	 Rf9lDURjH+Hipb+jV1NAqUfSQrMnU83CUYGHfvsREj5rIhISFcL4FSdbSa/+/7Ld5S
	 n9FGf6DpU8LNqUcm/t8DRlABLCy00Fzx5tb96tkeV84qBHDYxlSbmCXg1nn71WnBwS
	 /fHRLX6Yap+CfgLTJH/iNH8sRypWdJiPBqd9GBBl+6yx2MDB8+srIXFFYu61O8Or/c
	 d5oh2GEPrLPN5HEhDXkhtJkRNjwME2sCp0ddIjf4pvycJMd5D6p+gC6iEP6ZclTVcV
	 1g0Kc7Ijy+ZRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A023A54A32;
	Sun, 14 Jun 2026 01:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] dpaa2-switch: FDB management refactoring
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178139881214.1643025.15820072872565162202.git-patchwork-notify@kernel.org>
Date: Sun, 14 Jun 2026 01:00:12 +0000
References: <20260610150912.1788482-1-ioana.ciornei@nxp.com>
In-Reply-To: <20260610150912.1788482-1-ioana.ciornei@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 18:09:07 +0300 you wrote:
> The FDB management done by the dpaa2_switch_port_set_fdb() function is
> hard to follow even by trained eyes. This series tries to make it easier
> to read and understand it by factoring out some code blocks into helper
> functions and unifying the join and leave paths in terms of FDB
> management.
> 
> Ioana Ciornei (5):
>   dpaa2-switch: change dpaa2_switch_port_set_fdb() function prototype
>   dpaa2-switch: factor out the FDB in-use check into a helper
>   dpaa2-switch: move FDB selection for join path into a helper
>   dpaa2-switch: move FDB selection for leave path into a helper
>   dpaa2-switch: unify the FDB update logic in
>     dpaa2_switch_port_set_fdb()
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] dpaa2-switch: change dpaa2_switch_port_set_fdb() function prototype
    https://git.kernel.org/netdev/net-next/c/646077cc6b20
  - [net-next,2/5] dpaa2-switch: factor out the FDB in-use check into a helper
    https://git.kernel.org/netdev/net-next/c/5617bf8538ec
  - [net-next,3/5] dpaa2-switch: move FDB selection for join path into a helper
    https://git.kernel.org/netdev/net-next/c/e31f457ac7da
  - [net-next,4/5] dpaa2-switch: move FDB selection for leave path into a helper
    https://git.kernel.org/netdev/net-next/c/2230a2e62251
  - [net-next,5/5] dpaa2-switch: unify the FDB update logic in dpaa2_switch_port_set_fdb()
    https://git.kernel.org/netdev/net-next/c/7aae797a003e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


