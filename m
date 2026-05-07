Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C412D29C7
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167862; cv=none; b=L87TeSPgt43w0mzfN55GCRyCOBzuc7GN4Pi/CUOk57V5m07ErSDPb17XWAuN9+gbvW/2EGPvU855rDUgc6s/D2ARiV3WwZIxbhj2iUH42kX/iLH+lQzRwhCybYu+y+UT9Mm4AN0jj0j6IspjU320M+1AUbrxq1Yzb5L624C5GBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167862; c=relaxed/simple;
	bh=jC9HXGtAaoXlhMQJZ1xcYXk9vWMu7Bm9xf2PCGUKPiA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ag0o65g5wdJVFrRbgsbShPKiklpNB3Or6hJFk0SZgsg7hcRb3HwxEZbSxygftsuerg+AP3PNeGjiDDmLM29Ne67WfCoPqGTEveq6mSbYsRgQcGmHYnWqnvaj4h7lykBixCGNGMtluTdBzI1KWkuuLC7j1LMgTyoa4qOKKCCUnDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RudNYnex; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RudNYnex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56301C2BCB2;
	Thu,  7 May 2026 15:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778167862;
	bh=jC9HXGtAaoXlhMQJZ1xcYXk9vWMu7Bm9xf2PCGUKPiA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RudNYnex+a6OGWEu1ZcXCf4KIBNAsodThAQPSDcimvcAv4DJ2wEFChtg8aRmqb8CS
	 /yeRCDTf/XRL00QrtTydCkfOzm/uXqqnwt+0FCXcaQwjM4h9PZZp9OtT28TnyG+RVS
	 1Qz44f7xTEyV0b+O7FA2/q2zFJQPs067/hEwbCX/FDqbXbF/XEPDcBWdLwl/SZcS3E
	 B8ePmnUmumHlG+O+s0EdXfFGLdithR7xZL4PaOgQuviMnSKoIDLrOhNN14yclfdzgO
	 byjxSXGwv0caWJn7PP/Aw9EnHaiSGKlBeXthL3w8N8qEaCQniox+q+nyE5/jfu+eLn
	 IkWfQgquxoHJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FB13930906;
	Thu,  7 May 2026 15:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v3 0/2] dpll: phase unit display and
 frequency
 monitoring
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177816781160.4040424.13608923962799018672.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 15:30:11 +0000
References: <20260504163014.416317-1-ivecera@redhat.com>
In-Reply-To: <20260504163014.416317-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, poros@redhat.com, dsahern@kernel.org,
 stephen@networkplumber.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon,  4 May 2026 18:30:12 +0200 you wrote:
> This series improves dpll pin output formatting and adds support for
> the frequency monitoring feature.
> 
> Patch 1 adds picosecond unit to phase-adjust-min, phase-adjust-max
> and phase-adjust attributes. It also introduces dpll_pr_phase_offset()
> helper that properly formats phase-offset as fractional picoseconds by
> dividing the raw kernel value by DPLL_PHASE_OFFSET_DIVIDER.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v3,1/2] dpll: add ps unit to phase-related pin attributes
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=410888eea295
  - [iproute2-next,v3,2/2] dpll: add frequency monitoring support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=12954bc7d2c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


