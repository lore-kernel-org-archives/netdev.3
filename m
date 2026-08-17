Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC9847125A;
	Mon, 17 Aug 2026 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787000454; cv=none; b=Ei9sKg4LC/ap8WKhaPTa8a9qIFvo6a9hx479qQCRnJ+W9yG2cwovyGVWTxGNwcThntJkXGw2JwyBx1oYF1kJ1r2Tj0WrKI/upVUbUZrGLhhBpA+jHDqxktyzVvW3hIVDDFl60Avcf+Wyf58E5sDIM4mM99W/a26hdr0mbpNTpr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787000454; c=relaxed/simple;
	bh=7LkoGmNT8dK5bPyN2SSeuBoFv8pzgegZVg5rn2lLcLk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=USs0VTZUJLXR2+k14ao6sVCV0IU4j52ImCVcM/nlfv2aT8U8eSw5vPWxjH4oyAZxdj/KZo0ETn0LjaiIAs40tGXESPJvgdnowdIVWnkx2gwffMCHhYTC5dEOoa/SK8zAM/aaEUVbTaLkQkvJ+h8WDx9rZp+YUjD//Huec0JTIl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hm6A5S+f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hm6A5S+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78F81F000E9;
	Mon, 17 Aug 2026 21:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787000453;
	bh=1zHSB2kdYshtl9GRDQW+rRHORgGEWAannWVOHwHs5cc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Hm6A5S+fO/G/xUpJK2j1/BoqVeyCgGpcSyyjxY8uWNwv9mhYwkIr3jxKhbBq/AXW4
	 8zG6uq0FmmQpbq4hIWzb0zS8e7kzRvWmdPjDgfvaM72uw0tJItx8Z4eukXUWv3RVpM
	 jIO+R9pUF573Ugeo8ZK5u4qUU8RgnWYfRPvKP2f6cSn6TCCypo8sKOOuhfr0KLrRlr
	 Rt3QlxeLNsUlvhBuTO0XYNczsHRY8x2xq2ucMGZsr8cN5KXWADlG+sO+4+/prHa5E8
	 qK2gEaTRqyeZVWNuucAEryxl61Z1DOdjyNMr1/LHVKcVkwNzE17iJsMR3b8FNdOvbp
	 wMQUtDcy2/uhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198623926265;
	Mon, 17 Aug 2026 21:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: b53: fix error propagation from
 b53_fdb_dump()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178700040565.1735578.574294228176111818.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 21:00:05 +0000
References: <20260812201121.2012356-1-vladimir.oltean@nxp.com>
In-Reply-To: <20260812201121.2012356-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, florian.fainelli@broadcom.com,
 jonas.gorski@gmail.com, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Aug 2026 23:11:21 +0300 you wrote:
> The blamed commit replaced "return ret" statements in b53_fdb_dump()
> with "break;" which jumps to the mutex_unlock() -> return 0 section.
> 
> This is notably problematic because it swallows errors from the
> b53_fdb_copy() -> cb() path, and this will result in FDB dump truncation
> when the netlink skb overflows - see commit 21b52fed928e ("net: dsa:
> sja1105: fix broken backpressure in .port_fdb_dump").
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: b53: fix error propagation from b53_fdb_dump()
    https://git.kernel.org/netdev/net/c/4f1d06cf8aaa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


