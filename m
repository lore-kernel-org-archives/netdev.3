Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6E7275AFD
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999261; cv=none; b=dg//YJa/ur76pzRa1vqiejoAbQnRzaqJXfIVLTC4JALjuP/eNsEbe6C1KwixPh6mG3vywej1kEqiEY/zwIoBp7wbVJJQjzEd/mhyf9y5gxeg4qQtogKBiSOMmTOWXwUNKGvXSgXDciXbiSZk4jhbrqde5cTh6zJ7ZtlZ0BqjHoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999261; c=relaxed/simple;
	bh=RwglYbYO5OOTUMdS4KdCpbCvZUci6IDhIJh/Q9/MuaU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BeGSKiTBjnrKksfvDgZM1VZVND04UHgoMRBDKA/Nez9AEzzhkO5ODckEd/5wVr59Id79pYH+ySnogrcQ5ySBc+zzNIPg6NwAOw9lfAMXGiKP4EpHT2Gvh0NerblX9uFnNzkbskvnT4Une0j/bB7h4Isj4OYUzNOaUpqCxOJ/AKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmJ0kvP3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmJ0kvP3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7894D1F000E9;
	Mon, 17 Aug 2026 20:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786999260;
	bh=uEijsVS5zci5DkD/BWFnivyalINaddYV8GX9zfbvkUU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TmJ0kvP3UkisvOw+jO1kuIUPiSic1xpqU1JRgTuS7xXsSIdC9Huxmln2C06vjhhhm
	 rugnsDah0UQPMUvh6FaiWoA5CuIgVndPEyBObznLNhpE4j9Kd13wwKVxG63C5Y/fYm
	 GsochnHU9ISXRSSTFYwJfNmZ42LoQ3d17U4oBRlNN3QnNexDUXw95Yn9BIgxCppYTy
	 Mx0NVFsWxLEqrk4iw4HCArRE2w9avJniPW4vzRSHUNxehQsGI+uTWX52/ELgX5bv0K
	 S/iEwiAsVsp6FYnyIF3ZKibzq8Yk8pm9Ilq8yB51Sxs/Qh+VhWtDOvbV1Bk6VSY/Yt
	 nyZgyhPRqbfcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A2D3926265;
	Mon, 17 Aug 2026 20:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates
 2026-08-11 (ice, idpf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699921239.1728655.6420820877236270138.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 20:40:12 +0000
References: <20260812000918.220714-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260812000918.220714-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 aleksander.lobakin@intel.com, konstantin.ilichev@intel.com,
 richardcochran@gmail.com, poros@redhat.com, przemyslaw.korba@intel.com,
 przemyslaw.kitszel@intel.com, robert.malz@canonical.com, willemb@google.com

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 11 Aug 2026 17:09:13 -0700 you wrote:
> For ice:
> Przemyslaw Korba adds a fallback path to utilize sideband queue when the
> low-latency PHY timer writes time out, likely, due to NVM updates or EMP
> resets.
> 
> Petr Oros restores call to ice_clear_dflt_vsi() for the default VSI in
> ice_vsi_release() to ensure no stale rules are left in the device which
> can cause various issues.
> 
> [...]

Here is the summary with links:
  - [net,1/4] ice: fall back to SBQ when LL PHY timer interface times out
    https://git.kernel.org/netdev/net/c/6959fbdc940f
  - [net,2/4] ice: clear the default forwarding VSI rule when releasing a VSI
    https://git.kernel.org/netdev/net/c/d04287e27bf1
  - [net,3/4] ice: acquire NVM lock around each flash read
    https://git.kernel.org/netdev/net/c/df88d6f1ed65
  - [net,4/4] idpf: add missing cpu_to_le32 in idpf_tx_splitq_build_flow_desc
    https://git.kernel.org/netdev/net/c/b802a8c1ca16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


