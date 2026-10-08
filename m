Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25D03845A7
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 02:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791424811; cv=none; b=W3NDVH8CiW6nyfWVcjbupWnerlficbcyspVxIVxqMwOPKsoSIgRCqEotapaXOR3juTmwZUDsywcDAsa20RBe0fRbZcGZ4FPL1M2wYvgZWTjCXwcO9HfOokVz+Xd7ExGDCCuZuI11lyg7G586NPh5FClKUPosPhCS14ucwXRN+ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791424811; c=relaxed/simple;
	bh=RszinOXxN5EvYBqaHou37vxwI9m6DIiYtae+QfnyZjI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h1+mM9dlYJjemimrCelk2bsZvCDh655frAZRh7Clwt8w5jd4jRvOGHtBwzYiIoFxBVU1/yY/AnMmXWk0v5MYG5d17XzD0JWa5S5Uk0y/p6fkn0bJD0JebQx8TZuQAvRzorA1l9hgc7GDbeivCWE3IcJq8pJjyDi3fMpCEfOGkLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJPel+SJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJPel+SJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4506A1F000FF;
	Thu,  8 Oct 2026 02:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791424810;
	bh=42cO8tpMC4PEsFhzmXoN8QPC9IMFYcI5qAc0lVGmpFE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JJPel+SJRmfUyDrFtBLquKXtyK1QBuwMWfsOq16rYKb+AAOZo2kzB3cP9oJ0sMd57
	 wGYep2Wz45x1CMXygJMn/eue3+gVEE2mRNKO75ZczO3d8jR+32PL/RHl/kLtWkfc0+
	 CeUfiGeqh/ue30/UMw6356CoDNQI6QH+0Xzj+MFocEVzcrKJh5kvlP7vHUYM1MNR3J
	 6uJjWlIuJufZaFU/MiVE2tKcCvLZ152HBMgBSoqoQdCHABpjjkZb9jV+ilJmOsvqNs
	 dG2CDK7YQtQj/IyNsRK4i/AZS0CpVJFun7gtIvDI9QAjyfByoBGlHUF25zRxD9PJ1G
	 dmvy9jbt4t5bA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A1873809A09;
	Thu,  8 Oct 2026 02:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] flow_dissector: avoid u16 truncation of hlen in
 bpf_flow_dissect()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179142480877.3768853.7937189397834700341.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 02:00:08 +0000
References: <20261007045616.445596-1-edumazet@kernel.org>
In-Reply-To: <20261007045616.445596-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Oct 2026 06:56:15 +0200 you wrote:
> bpf_flow_dissect() sanitizes the offsets returned by the BPF program
> with clamp_t(u16, ..., hlen).
> 
> If hlen is bigger than 65535, the upper bound is truncated before
> the comparison. For instance, with hlen == 65536, both nhoff and
> thoff are forced to zero, even if the program returned sane values.
> 
> [...]

Here is the summary with links:
  - [net] flow_dissector: avoid u16 truncation of hlen in bpf_flow_dissect()
    https://git.kernel.org/netdev/net/c/f202578efc73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


