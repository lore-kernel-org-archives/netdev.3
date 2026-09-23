Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81E2E736D
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197885; cv=none; b=L7hmbQTMi44nNBI+4kvk7DAt/yYhEP7TatRjEimpVYfxqIxs1Tjwwm2EnE/q0Yj386Y6gPj0MsVKukcugZJlRLm61g0gY7RZmPn6QtdUp0efz6VarN9g/AjH2RAnCfMBsK4hV/g8qBMxgUO6nHbes9Wk9zelhWmJFL0fOts8MuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197885; c=relaxed/simple;
	bh=SDxH7fuyCF3my8a0ciq8FGsWE3MgWZpXN7CLqcs7I1U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mYhyquF4jNziE0fPlwKK/xhnfFPNL7RDuafvy62YN0UlIaX7nYPKaQMmy5MCEdo1IrDQDASXM3S/lvyaNa0jNdLgzizzuXnGnwr3Obu3OMziGz7j7z89ZZHq303+fSDo5m05n9IZrn+1w6zHNhMJ3n2w2aeXPcIc4/IG4fvsK8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BldbFmM8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BldbFmM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84431F00899;
	Wed, 23 Sep 2026 21:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790197876;
	bh=31SmYBS4BNDFt+Ig4onc1y3LCBBMUOG6ofIlqfLcUWM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BldbFmM8KZIHEVyYyFji54Jjt3cqpuAQAN942aO6npRQLu9B3pgg3evCA0L/Ggs48
	 DY8ncyJEYkWYKu6lDq1jGwQASUI5U/MExiwg45cL7SHtrOq1hbkyLRgirHKJz0fqLl
	 AjqsJVusIRc/0wK9WTPVsjaZAVfaLY9d0JC7VvrYqFgmEbZgOxUJH4l8zT/zMPZQWU
	 Z8nzv3Rh0VaTUzdOc64tJ7JNBzXintvEFb8vhaqyUegB9EiuGS5cLOtXAVS03lUJbw
	 4r0JWC4Z1BccTPaO5YYGwtf4q2pu18SZhPa9lR2dNBMtS/M604hKl0zn4XLi9taEyN
	 opuOCN9YXHj8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A5A39E8A76;
	Wed, 23 Sep 2026 21:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/3] ip: netns: report the network namespace
 cookie
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179019780665.708051.2101591826806923729.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 21:10:06 +0000
References: <20260923161756.2914560-1-idosch@nvidia.com>
In-Reply-To: <20260923161756.2914560-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
 petrm@nvidia.com, daniel@iogearbox.net, ferenc@fejes.dev

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 23 Sep 2026 19:17:53 +0300 you wrote:
> The kernel identifies a network namespace by a 64-bit cookie that is
> assigned when the namespace is created and never changes.
> 
> The cookie is reported by a growing number of trace events such as the
> TCP-MD5 and TCP-AO events and the net device events (e.g.,
> net:net_dev_xmit). This allows filtering events that occur in a specific
> network namespace, for example:
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/3] uapi: import nsfs.h from last sync point
    (no matching commit)
  - [iproute2-next,2/3] ip: netns: report the network namespace cookie
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=f49fa3143008
  - [iproute2-next,3/3] ip: netns: add "ip netns cookie" command
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=07a6444c127e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


