Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C7B3AC0ED;
	Thu,  6 Aug 2026 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982256; cv=none; b=tHpTGkaqx1dJHNeJZzSGiWj/3qy38rw4Xsi+o+Fqk2TyFoM+2tTjaz5vW7kMIudfHH1A5qBtHk90x4DnS5UylSpZugA+BfUdcBoLZ5jl/qsuYjeAIihDJIL102CjB5eskr+WwGWE8kUhppi2OJpmVaEVIXpe97uE4zbu5Oqj5Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982256; c=relaxed/simple;
	bh=+so+mQ1oShiTZOva51uqVaNr1VQhDdDomFlsaLqTFbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sP4iPiUmGGKmo9aGXBLn4JxEjukQ+Zv2zY/sgmJCrVDwvPr9GNTNsxNMTLsO9eBwexw0ek9AS3/Bd+1hQue+cq28/df6jcH+fax4t+6pN38ael4PMCJHwQL9DmJhWkVB9JR+77DoNjxcSWhyvG6X1VHAYOWSfNPtH4jnGZs/FjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hf6vAOcb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hf6vAOcb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6271F000E9;
	Thu,  6 Aug 2026 02:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785982255;
	bh=CxX8VvPNyTfIWLpP0aK3UBxqKOLsZG7BCA2rd4b1LdM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hf6vAOcbxE3H0io0JtYjCbPJHo7jHx5WdA4AWDzY8a4bjeOO+38psQSYoaxyaMCEp
	 F1cPfPPpXRlsdcazEwEt5tq21tWF6+cA3J1q8f2K2X32yQHotXYMklyJt1IBBT77BJ
	 ArdSdUcBo6o3yg530Z5m2hoDNls6AwTv28TOEwGiFyo5v7aodHODLaNaEBXQw05NZt
	 jmmJuETWDcuUda7i+V1N49esKnrZnkyCi3nVQfB7WAlCZ18vqtEaI24xLfgc1mDXci
	 rPT81IMNYz+LYsemK00Jzzgt2Wb4jSi2X9HgAgTw29Rf9urbPIWYaMy9SoLON56glH
	 KXSZcjHNoS1CQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19934392FFF5;
	Thu,  6 Aug 2026 02:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] dpll: zl3073x: add Microchip ZL30643 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178598221489.607412.12370158005617212276.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 02:10:14 +0000
References: <20260730-for-upstream-zl30643-v2-0-0ea0bbd03755@free.fr>
In-Reply-To: <20260730-for-upstream-zl30643-v2-0-0ea0bbd03755@free.fr>
To: Vincent Jardin <vjardin@free.fr>
Cc: ivecera@redhat.com, Prathosh.Satish@microchip.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Jul 2026 19:35:34 +0200 you wrote:
> The Microchip ZL30643 (chip ID 0x0E3B) is a 3 DPLL channel member of
> the ZL3064x timing family, register compatible with the
> ZL30733 of the ZL3073x family.
> 
> Patch 1 describes it in the binding as a fallback to the register-
>         equivalent microchip,zl30733.
> Patch 2 adds the 0x0E3B runtime chip-ID table entry; no new match
>         strings, the fallback binds via the existing microchip,zl30733
>         entry.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] dt-bindings: dpll: zl3073x: ZL30643 is compatible
    https://git.kernel.org/netdev/net-next/c/d4b0ad9a8174
  - [v2,2/2] dpll: zl3073x: recognize the ZL30643 chip ID (0x0E3B)
    https://git.kernel.org/netdev/net-next/c/24e4aff8983f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


