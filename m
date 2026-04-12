Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06112BE7BE;
	Sun, 12 Apr 2026 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776009057; cv=none; b=I9wVvPtM0ZSLor2FomxZkkhkpWm3iWXmXTUcNIA4usxx3WvvTMS4cNX3OHQGsAx2/AMiQpPP4W1jrwvwzmNcpfgmpelcBAE7nv+QqaJQci4dmW4xHl9smAy8aOuRGr5pDs4mOFwzBsa0VgM0YXEiyu9Uq2lojdwrWi7yECQe/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776009057; c=relaxed/simple;
	bh=osIpXDbFP5WXV7jXS8qAjR1DaP4puI6wth/HrHBO2ak=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G8mWz3bRvvIdWTq80qUhXj9Act/vJT9v7if+JksNsVBMSVGZNdtefwbFL9i6KwkcJq9aX1uIf0OzAIUdY7uN5DN6GuKcoAK1mu9PplZE1B/kZMhBw6ND03eY/m6O0q+nqz+JAoiGUnIrpWCegJkYre1TBUMUP8UL+hCjYcGFyy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSqTFdAe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSqTFdAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70106C19424;
	Sun, 12 Apr 2026 15:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776009057;
	bh=osIpXDbFP5WXV7jXS8qAjR1DaP4puI6wth/HrHBO2ak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DSqTFdAeFDNZGuUocuhhDxRfJJvlljme5xMaAEfGw9JQwdxUU4j7opnCHqAs7NPNt
	 yUcJP+iD8oDYXPteDl0GoXgb42ngaHoebNCJ1An4KrTAQ+QpR9itdb5hrSXSBuG1G+
	 dNzlLlW124kmzrCv2glwK3rwUyV1nWb2YwqL8ZjMiMhhRAbuU2qgMsUdTtVKLGAGmQ
	 AO4YCN81F+Q10p3v3J+Yw2AJ2b2vggwzfNoXQq4PcKOLNJY+T1sLnEfBuvTEAMnNdg
	 1ivLW+dM0S6T0d2rPud1nBb7jutu084Nc372VgtXlCLSOzRixF83+YSgsMk/wZNfkE
	 JPxHjk+KFibBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD2F3809A8B;
	Sun, 12 Apr 2026 15:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: net: ti: k3-am654-cpsw-nuss:
 Add
 ti,j722s-cpsw-nuss compatible
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177600902979.3323732.15626307133193777506.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 15:50:29 +0000
References: 
 <191e9f7e3a6c14eabe891a98c5fb646766479c0a.1775558273.git.nora.schiffer@ew.tq-group.com>
In-Reply-To: 
 <191e9f7e3a6c14eabe891a98c5fb646766479c0a.1775558273.git.nora.schiffer@ew.tq-group.com>
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, nm@ti.com, vigneshr@ti.com,
 kristo@kernel.org, s-vadapalli@ti.com, rogerq@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Apr 2026 12:48:01 +0200 you wrote:
> The J722S CPSW3G is mostly identical to the AM64's, but additionally
> supports SGMII. The AM64 compatible ti,am642-cpsw-nuss is used as a
> fallback.
> 
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> ---
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] dt-bindings: net: ti: k3-am654-cpsw-nuss: Add ti,j722s-cpsw-nuss compatible
    https://git.kernel.org/netdev/net-next/c/f757a2da6df5
  - [net-next,v4,2/2] net: ethernet: ti: am65-cpsw: add support for J722S SoC family
    https://git.kernel.org/netdev/net-next/c/436e9e48ca51

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


