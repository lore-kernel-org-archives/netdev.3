Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6654678F2F
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 00:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788480667; cv=none; b=RwqBA06zr9Bi/WBnyDbmP+O7gQ7c5TagXxRPS/ygs85kxmuxJjmSski25i2cCNu4ElR9nYRsO2YNha/uaI45PRD3VdYCR0xQ8ITayeiwywrFaid8Ge2CAauxQ3dWQdI/fBCLnB0TO6s/81749IiZK3+sKXa3hRy0mfw2OEqOWXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788480667; c=relaxed/simple;
	bh=scjXLcQvcaVTWdkWn0NDO5A+YMnWWXGE9A9Jy69Kts0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OOhi71+a4pEH7nu7q0VZ9yGEx5GcsnFV+h+fjPlc54dMdfOvJcIWi2aXIdB912Ck4thObdKSr9ZteGBb+7j1wPiDJpaXT1o6z0zhgRRUUln+mB/LqeSkjCsaX26tnROEiWBTdmzx1Hwmczdgk19rX51Fw8QDb7MJhrfJaGWomhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zsvuij/K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zsvuij/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18D31F000E9;
	Fri,  4 Sep 2026 00:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788480666;
	bh=z5WonLJhfzUtyqt16SdlaLa08/NrIGbbcKN3BkQy7eE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Zsvuij/KR6c5aw8xWc0LOsDXSt/fN7dOFuopHk5+r56VT2DetzEz0bGDIDjb5ADII
	 M9T8iMDIgqGCuPeGnY1t0IBuTCENouzsoVUd3ZhPVznThMvml96mqMsMdCQv808Wkt
	 3JB1qT3V/X79+yox/fx+DO8ddauVTLUlf2SIFDAoW4xYucw5OS1tGnLCdpYDOTAUSa
	 COq16qYBWnL11iOnWMs/dU42TixY2zDpZ2sfFuBOXTrD764QEFEmNBL2fAUTi4OOY6
	 2ZoxxiXM0r2UupDa2xERHqkK8VaPU1rm1ieS6jH61ZfxqpB4i7K/Y4/QPpwqTELWLd
	 JZTGTJ0gt1hwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5690838119E3;
	Fri,  4 Sep 2026 00:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mlxsw: spectrum_ptp: Fix napi_gro_receive() call from
 GC
 workqueue context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178848060690.4080441.7467727339140621500.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 00:10:06 +0000
References: <20260902024949.2273997-1-tmbates12@gmail.com>
In-Reply-To: <20260902024949.2273997-1-tmbates12@gmail.com>
To: Taylor Bates <tmbates12@gmail.com>
Cc: idosch@nvidia.com, petrm@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 amcohen@nvidia.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Sep 2026 22:49:46 -0400 you wrote:
> Currently mlxsw_sp1_ptp_ht_gc_collect() is run from the PTP
> garbage-collection workqueue, rather than the NAPI poll context. For any
> unmatched PTP entries carrying an SKB, it calls
> mlxsw_sp1_ptp_unmatched_finish() -> mlxsw_sp1_ptp_packet_finish(). For
> ingress packets, this calls mlxsw_sp_rx_listener_no_mark_func(). The end
> of that function is the following:
> 
> [...]

Here is the summary with links:
  - [net] mlxsw: spectrum_ptp: Fix napi_gro_receive() call from GC workqueue context
    https://git.kernel.org/netdev/net/c/2ac174dfcdde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


