Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A963ED118
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181840; cv=none; b=uFYE5kGoc3/8RasRT0a0NdxMBetm0l2TKUKdBpNAf8kVeLY9RvCm7Xx3HeT7GPLvY9JeZaFiojxUiuqgVVlPI8Byap9CD193S59ywkl0Lbvvc4vmZSMyFlyPM38uTszbYlsOXRdT1Dj5f1JFaxva7i18zDMAZjbI3sp1P7RERVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181840; c=relaxed/simple;
	bh=xFTSK6+Cltdgnow3Z2DaeJZdd2h3JmVzxg0j3t3MWS8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BLpuV3Isq/8kbvGUIbqk5R/GEuHwEBABYidjvxCo2mxBUD4YpeKsx+CSwsU0/gLWvWLzE5ItdG79bGcf+6MJDADqCaVB8eS6PjsqRJ3wX9Uy3GOV0CR6eScAbuhk5PDdYFKodd3qfKM1UEazzFVpNJb7qyHkxRzOCHolofltQPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7L1R1dO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7L1R1dO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02188C19425;
	Tue, 14 Apr 2026 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776181840;
	bh=xFTSK6+Cltdgnow3Z2DaeJZdd2h3JmVzxg0j3t3MWS8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T7L1R1dOjzR68j1G08OmwXRbMTJsvDjX8pM7FhBlcmSK2qjOiOy4FzSLDGWcVqYeY
	 nBoB7UB9QKOrl/Ioba9maPx872MvriIfvJa4DPtAO9rQIGKZ1vS0EuKq8hVBm1ngBF
	 iSFxQl52Lbohl0cL8WTANXjJFIZtzeVqKhb9kJEmGBROzpHA4cSc+CccgaNDo7Sf8K
	 LNd2wqfqRyX3JdyfCAbJz6SqMksl/ePz8I5UtQEWh99RtMiJ8bWaQj8RC+H17Zki41
	 GBWWG9RVR4cmSHuXJs3cP3zZkZVq0UnlMZKE1cXwIc3EtZFZHLUmeWJ8dHsAziFQkC
	 MpMSz02GND+6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D703809A06;
	Tue, 14 Apr 2026 15:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: Add netkit selftest files
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177618181055.1350742.14553442162453167616.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 15:50:10 +0000
References: <20260414075249.611608-1-daniel@iogearbox.net>
In-Reply-To: <20260414075249.611608-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, dw@davidwei.uk,
 pabeni@redhat.com, razor@blackwall.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Apr 2026 09:52:49 +0200 you wrote:
> The following selftest files are related to netkit and should have
> netkit folks in Cc for review:
> 
>   - tools/testing/selftests/bpf/prog_tests/tc_netkit.c
>   - tools/testing/selftests/drivers/net/hw/nk_qlease.py
>   - tools/testing/selftests/net/nk_qlease.py
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: Add netkit selftest files
    https://git.kernel.org/netdev/net-next/c/bc28831d7a09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


