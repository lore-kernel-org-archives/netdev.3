Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3192E3D0938
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215882; cv=none; b=ctPj2/WG1glwj4HeaQ6TwDaPjsVHZKuMd8zjqxbHppgk6CKOt2N4CaYMw27bOH9gqNMz9N2xCSFxlOn/1d4dJpyv9CFh10OCKl7uJSp9uSsjzELR2h+g/7EShzx7ppBuZMSpjvywuPs77ekpcnlHPxtEox/uUfVP4jMOVEEA++s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215882; c=relaxed/simple;
	bh=TT+VCNMJeoaakignuW6HXMkB+DeVGzo0tLCgHJOHmB4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qn7YCZDYpd9lcWI50RI64L6y4YPLRu+xnW14w4qid0hQtho6FXl0PeKKJjS2yw7xCQ+USTOPOFTDCa0ktEDfOxea0DsAI8g5qJv5TFKxs/FQp6MK/24PtVCtijyfs260ckEWtjBe5Ybecrp+/hogeajlmNaS9hm7S8/u50G5rgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8RsT6fu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8RsT6fu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C640A1F00893;
	Thu, 24 Sep 2026 02:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790215880;
	bh=UBJQsHTuHKeYrDlzZPQ5HuB6ZOOylChfRbUrAsFG5ME=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=c8RsT6fuRtjTDiC469IKkwNgnP0KSOJLLftVsmB8ZNj2/zYQalvsfXX9LrXjezVd0
	 7V1TFMqbKbQvxZHRq12JtJQXzHQOCOQFODXjh5TkLim2PQCrdBS/444/OoVmGTbx4C
	 gtoIfBq/Cniucc9zEWmu7913CRKUThO7BUL5ECTOGaCFEN4joVUpkeRZz97Em0al0v
	 HRPeh8AuZZOFzQMP+9EnHXA/RaF2UJVsA1FfEEeO+IlGd+tgkhZ3TLTxJIf6/40zLk
	 fC/mJie/EVcDMfgh9SE/PQfkH1saWxATZTlsGm6PWShOu0EvlVPSYPLfSzAPV7zwOG
	 3wk2BSrLbMYiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938DB39E9611;
	Thu, 24 Sep 2026 02:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/1] net: arp: fix stack out-of-bounds read via
 unterminated device name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021581014.1277764.16093484647233360808.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 02:10:10 +0000
References: <cover.1789910973.git.milkory@outlook.com>
In-Reply-To: <cover.1789910973.git.milkory@outlook.com>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, dsahern@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, vega@nebusec.ai, milkory@outlook.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Sep 2026 01:36:18 +0800 you wrote:
> From: Zijie Huang <milkory@outlook.com>
> 
> Hi Linux kernel maintainers,
> 
> We found an issue in net/ipv4/arp.c. The bug is reachable by an
> unprivileged user using private user and network namespaces. The relevant
> details are provided below.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net: arp: terminate device name before lookup
    https://git.kernel.org/netdev/net/c/d8b6529e80bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


