Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794528607;
	b=W+4w234/vI+lpcYr3K/u+KYVhUAZyQv9Y0Mq63AmjYvrCgpQWJeL7OQXPl6G/R4+ti6U
	 +KZ5L4v4QDJR0NhfNZjLE0Tya8sEchnDmqhr0D4NW7erNvrsGz2JdVDkb6BgEtHxbF0wV
	 QwnVSau3A60n68yrL0yM3Tg7piZRpX/pz2BOOtTFhQOMbasJnN3LdyyX6PSg+1aGlVLvI
	 KTT5BSxbVwrSvNqJOvjnI7tmPY0d3nAg/fSrLuVBHvT/c1/L3NomlIb7zmVPrpLkIBmQp
	 4St3Ql0yA89zCLAUQ+gvH6lH73IrQO2jV6C7nTXhvU8aY7io9L/SJfv/W7OYyF93jNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794528607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=RhsUYAwiBCSPCc858K/sCzMWDe9ll9Sz63ppmvrKm24=;
	b=R19qsU4xumhwnz2Uof45sirKIY+4uhMHcfr19SFWQvP1lf/a3vFKobKpVDqrOSweJ/Tv
	 zCacoFxlzkpdjX0G21orcqnT39JlUo9/FWShRYOPvCzswsUE6uu+JvVwVILYa+5lghgQQ
	 dbMm+/R8ZmQw8rM6fOD4XNCmdbWGWqYpU9plWdca2i/2bZMAidV8nUb3AkVWflophEuKY
	 VCQLQpZRqpcC/UxxQlmxnT9z3lq3Ez4EV4Xsw5xEue/uA8ZosfNy8FJxJObR4ccqDIimk
	 dJDKQH23vaRdSkUo/fRn3mniULkWv0+Hg0PR0yntqGf/9fymn27hmWNT5zM83f7fcHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uz5BgWHY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF5D606A31C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uz5BgWHY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446881F000C4;
	Fri, 13 Nov 2026 00:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794528607;
	bh=RhsUYAwiBCSPCc858K/sCzMWDe9ll9Sz63ppmvrKm24=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Uz5BgWHY//eHgXm0niGVjoXpPDsbMpjnuMwQHXpa53ZqfPql20wj8W2SX4ti0dCYM
	 poMyDrsFfDb6nmnhNrOLJj+Fyo8r6bJwFpm0Wttvo1D3buAC9k/UIxgVB/6MSrGIT4
	 AlDTd3K8pxzsCFUkNEUvH+/O0AZaMmxeDxbiNfTKdNgz7f2JtmYsEV6Su5ALmMn137
	 jTbefYEoiZrVtOvOc7lUOskJXbLCfYzThvL18GWeC3IbQTu4oV7CIf24CUu8TD2VJ9
	 Ff+0F3hs46myrbK/mwufEdSnJttiKWM4zVojBiTKJRbIZtRrWu44Y1SxP7dX+Hcew6
	 5IxsVRdn9Y5jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A5CF392626F;
	Fri, 13 Nov 2026 00:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] bnxt_en: Fix PM resume on VFs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179452860603.714005.3219407857512187650.git-patchwork-notify@kernel.org>
Date: Fri, 13 Nov 2026 00:10:06 +0000
References: <20261110174943.2106347-1-michael.chan@broadcom.com>
In-Reply-To: <20261110174943.2106347-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
 keegan.freyhof@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Nov 2026 09:49:41 -0800 you wrote:
> The 2 patches fix Power Management resume on VFs when the PF is running
> in the same kernel.  The first patch maps the specific PF_DOWN FW error
> code to a unique errno.  The second patch adds pre-polling on a VF
> during PM resume when the error warrants further polling.  This will
> allow the PF to finish resume before the VF continues.
> 
> This issue was found in the lab when testing system hibernate on a
> BCM57608 NIC with 64 VFs created.  The FW version is 238.1.59.0.
> 
> [...]

Here is the summary with links:
  - [net,1/2] bnxt_en: Map HWRM_ERR_CODE_PF_UNAVAILABLE to -ECOMM
    https://git.kernel.org/netdev/net/c/ad3bee5c582e
  - [net,2/2] bnxt_en: Wait for the PF in bnxt_resume()
    https://git.kernel.org/netdev/net/c/5ab726ff726b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


