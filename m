Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA892D97BA;
	Thu,  4 Jun 2026 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539028; cv=none; b=fw4NyGN3SBZFe9iMh+QtE+YuwGbaIJs4s/fn8XTidqoI4Ximf606n53VRisrMrev+3faFrZKt6q5VoebD1hY4aznEJYjUQorNQAai8lSGVtVYCS3pJrjG+vMetVvWP0fUY/y8pn1nKOxTQSjYVolSO3RcmsC1i+UeUbTQVH7YO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539028; c=relaxed/simple;
	bh=IfJ4lUmEgor+lLgw4qJ8V8D5IM569iCXpRAIB9tqFZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b9tQ7UpSYqdOOCuwoeflw5Isre88Kp7UU8nvZJ1ZoGqGi7/5hfXkzwXKBNwNU2SL9WkIB8vNFAebFAtSdeZtQ5muEmJVAj0XdeY3YgwwJMju91WLoe2n/UXgSpCQrYiUjVg3/At7nR183BPmr3V9ekKmzC91gTABvBjE4ccZ6dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbTSxjJ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbTSxjJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319441F00893;
	Thu,  4 Jun 2026 02:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780539027;
	bh=afzY2cNMtzaBGBaAzvPIPOOB1uBITZemJQJkndVADOA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GbTSxjJ7lwOshPsDGkUvdRTKbAKCgYLaeWbuU6ZUWmhJqqJAjTMhfx985u+jL2Tzj
	 P0lLHoOC0BOKT+tpVT0VP7fuPFvjL6mPotu3ByEW++3dze4VihgNWyJSQxFHXyHdcr
	 NLwPkQGyuSc2pl1BjTRbLbBRJczpPTIVvB+x88Fo4eBOvZ7R+eqy7aXfP2iQCJ8t+6
	 WPC8mK83/wxonBZfivdUoFsTu1wLc3DyJK4OU1/1gCNZ47D+Kqw3cKbGUgCGd2jVlo
	 e/x5Bw1ajUZBjYi+PN9HCb/GYpoVRdjywWquGPLvJ9fi+hofMBifI0pr5qammm+Lkc
	 IetUcYMbGRGhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A4739308E0;
	Thu,  4 Jun 2026 02:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ptp: vclock: Switch from RCU to SRCU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053902807.2204548.18128583002992277362.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:10:28 +0000
References: <20260529-vclock_rcu-v2-1-02a5531fab92@linutronix.de>
In-Reply-To: <20260529-vclock_rcu-v2-1-02a5531fab92@linutronix.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: richardcochran@gmail.com, yangbo.lu@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ihuguet@redhat.com, mlichvar@redhat.com, hector.blanco.alcaine@intel.com,
 christopher.s.hall@intel.com, bigeasy@linutronix.de,
 florian.zeitz@schettke.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 May 2026 19:11:47 +0200 you wrote:
> The usage of PTP vClocks leads immediately to the following issues with
> ptp4l with LOCKDEP and DEBUG_ATOMIC_SLEEP enabled: "BUG: sleeping function
> called from invalid context".
> 
> ptp_convert_timestamp() acquires a mutex_t within a RCU read section.  This
> is illegal, because acquiring a mutex_t can result in voluntary scheduling
> request which is not allowed within a RCU read section.
> 
> [...]

Here is the summary with links:
  - [net,v2] ptp: vclock: Switch from RCU to SRCU
    https://git.kernel.org/netdev/net/c/672bd0519e27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


