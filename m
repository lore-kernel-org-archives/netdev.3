Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7712449B0B
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650846; cv=none; b=Vl/nSzd+UDjv02meQ/NaDCH0xQItsjGEgBfXy4y3xgNTiAL6sPHRSLEFpRgMGqzNMoIgUUoVY92fULdn0bVABhGS/P+Yzkp1LqcBa7lnQ/MKjpc1co9HFRiyUPogDdUo2H90QHGayFJMIjZusSFw7CYkrNyoDdFrD+jhUCZGgQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650846; c=relaxed/simple;
	bh=XP/CKGoS9SNEdUmscwOeKIKPwP3U3K0ZeVG/mXIsS0A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SddeZYrUpDJmEUCrOUR3tDsXYP2Tc2GprTtLSsVhcQ/W5HStHwoGdcgIdWufVOt8uQPO5n/eVF1UvIEffA9z2x7Evp4AEFJ7kXtRexSYKY4l8jbLSRzrwMcWrcWkncUX17PJkGeQQeZBT9R1M47rc/qZxZv3QFGam7VFpQoQrH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTP8huxH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTP8huxH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832951F000E9;
	Tue, 21 Jul 2026 16:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784650845;
	bh=j1jkDMTWGKrYtyrvk5lUrlacV++MeFwo8wbU2TGICaE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bTP8huxHIBfVw4vpgcjI8W/GsnXcJTDI4kXJK8D+2U00yHPGpcA6Z4PyJAOWEfXQd
	 Ejf+YnSF0SEK4jsWehRZJ2VSJbX3o1d+rPccJeSgrUVmybkfiCYmTwV4qvAhADCHFU
	 ShK/JqQv2vPhRlHu55GJCSzFM3ns/1X5lefb8z6Lwa1p2eDofWeh/sUX98NUk55966
	 sW3BOFo8QqEMV804oLl5mNKgNGBncTDEurxh1fJmBPXimGi7C5zb76ZA47Fbn1UU+g
	 gqusuvEHBWsYq0ox4fLbGM42l2926UreigD7mTMgulkWo2UVDSbFqMs+DMiclvIYHh
	 SJHG5xvpJVAiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A703924FFE;
	Tue, 21 Jul 2026 16:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net 0/2] net: Fix two issues in sk_clone() error path.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178465081488.386198.18204529491105935572.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 16:20:14 +0000
References: <20260709183315.965751-1-kuniyu@google.com>
In-Reply-To: <20260709183315.965751-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemb@google.com, horms@kernel.org, tavip@google.com,
 daniel@iogearbox.net, ast@kernel.org, martin.lau@linux.dev,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Jul 2026 18:31:38 +0000 you wrote:
> Sashiko reported issues in the sk_clone() error path.
> 
>   https://lore.kernel.org/bpf/20260709032007.9E4D61F000E9@smtp.kernel.org/
> 
> This series fixes them.
> 
> Note that Sashiko may point out the same issue for sk_bpf_storage,
> but the fix was already merged in the bpf tree:
> 
> [...]

Here is the summary with links:
  - [v1,net,1/2] soreuseport: Clear sk_reuseport_cb before failure in sk_clone().
    https://git.kernel.org/netdev/net/c/98da8ce87dd5
  - [v1,net,2/2] net: Call net_enable_timestamp() before failure in sk_clone().
    https://git.kernel.org/netdev/net/c/d50557779257

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


