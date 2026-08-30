Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592CC331EB2;
	Sun, 30 Aug 2026 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788126097; cv=none; b=YLceRwMfKhXK5XQ4bzxoTXZqqML/f7VqzQxgoCrDNMCzWn2IVn59J5PqwLAxtWbW5mCF6xSXEH+2/WLPiRH7yQxqUEf0rVIL6b/If/5/2SBCGBw/Stz1IAzzlleC0JZ//lzw/XrcRSMov921HSRreKViZXE3l9Az653iQf4bPwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788126097; c=relaxed/simple;
	bh=CwT4ePgHANWwDkZzPVuKJqjslYXVimO2C/gIYnVvQNI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oMbps4LPn3mqN5CcqryerfYSXzyENG/MsUcA+C2q/aK7/kfLinnLZ5rwIHo1TLk47jpWYYC0pKd2VcxIF4vO2Q5u2U7CgY3IjIy3jEhlgt94bM8Za/PZM0P+s8QCa01JwbA5M7r+6sMoza6zA9w5FSrk9T785U9ms+KeHatMa6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCW5UOd2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCW5UOd2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8778C1F000E9;
	Sun, 30 Aug 2026 21:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788126095;
	bh=WCSLIpB8Qlb51xO3yRF1mXrFzO+IfMAakV0ANBmeH4U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZCW5UOd2I/eCEO1p8foKfhp5RGIIS7FH99beeaV2DBJrOwcRX2v/vCuPy9fMQQDZ9
	 67m7NG8qdPASFnNLyTwEnWpitDHnEHNUvSvgk+hOHqUhfDQFkdPiqpLhuPTfCOPdLj
	 Mh0MpYinbp+kTXazJeFzzurogcrMHwo/kICQutb9O81IPMORXgjLFkn8Cxleh5iOK9
	 lrupN3Mo8qgmtwBz2EOWu5EREn4zlo/EiwEw/b+W8oDVZrSpKzyMIa5xTjfLAn28ug
	 nZnV3caS2qHJobZq3vJXFveGRkIZJK4fg4a7A+3ZqCDOGqv3inThF0flNOIq9pkYNJ
	 CT8ujXOJ8Pyow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5686D380CEF0;
	Sun, 30 Aug 2026 21:40:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] raw: annotate disconnect-side IPv4 match writers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178812603893.3466124.598946055091858741.git-patchwork-notify@kernel.org>
Date: Sun, 30 Aug 2026 21:40:38 +0000
References: <20260828012918.1461-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260828012918.1461-1-xuanqiang.luo@linux.dev>
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, kuniyu@google.com, edumazet@google.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, runyu.xiao@seu.edu.cn,
 luoxuanqiang@kylinos.cn, liuyun01@kylinos.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Aug 2026 09:29:18 +0800 you wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> raw_v4_match() reads inet_daddr, inet_rcv_saddr and
> sk_bound_dev_if locklessly under RCU. Bind and connect writers are
> annotated, but __udp_disconnect() still clears the same fields using
> plain stores.
> 
> [...]

Here is the summary with links:
  - [net,v1] raw: annotate disconnect-side IPv4 match writers
    https://git.kernel.org/netdev/net/c/ac08d183dac0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


