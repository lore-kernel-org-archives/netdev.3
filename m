Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682D433D4E4
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782257434; cv=none; b=fOFX5sV3JvvQutgMXxcXXN3NqEdGylKWZRqm8PsqIMYmj/Iry1W78qnaRVvKhGyJSDIDhU6gXGA0aC7qjswiWHBZoIHJGljpmrYprcIz5Ooq+P3y6odTGw7FtcDxQrDO36MMYcJ7pBefc7PuHdatlUPSLzUqmUYOgKHlI8lnyB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782257434; c=relaxed/simple;
	bh=mvy+5fv9INmzW/Wfx7iqb1gfM3e+XkL4/KHPcBq4Qvo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rCBnVOf5z4MCphQYmkCiPauOzd59r27sljdUyGJrn3bkEgYUCZfY/ZGQ0tTMKswPWKlwZnALAzdzEJUvm9xRD5PzAjko9pgluFjK2LlR6YJxjuQ7cVVCL7SsLBFKuVNl+z6Q+oqyDJNvrcw9PbD4cbXszQ02ZdkMArvB/RwaXfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rj4BLx8D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rj4BLx8D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090691F000E9;
	Tue, 23 Jun 2026 23:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782257433;
	bh=YbNzKE9LQ0v+mZddWkozD/Dm3Kd2AwXXFIosP+ndJGU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Rj4BLx8DQHiVEMWylA28i4HCtAZNh/9f05ObOQGgZ/zRKJI2zK1ZuoGsj/wv8WD62
	 y2m7/JLTUCXiTWSHq7mxY1+hnp/UIRm//CXMAq2drHIDLAjzIml/MbbcPWkcmfmTq+
	 UcqxOrs13TrLFzKtop+opjU61m7H5UnapWOpR7nyQlGRtkcaYFy57qJrw7OfKFUpwA
	 WRdaERgjmmJtT4yBcgrjR14aPwKMJ9BOwNQF7U6406mxVT1wO26HjMkk5ZhWU6Mc7B
	 ngEoDwcFl7kw2tYptHYoEbwSoRDkOqpF76Y7nOvzEh+/syVHhfWjrg/Tvdw4l9LryE
	 j3MreT0nowrvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BAA393101F;
	Tue, 23 Jun 2026 23:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/7] xfrm: use compat translator only for u64 alignment
 mismatch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178225742225.2469097.10118689224229379237.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 23:30:22 +0000
References: <20260622075726.29685-2-steffen.klassert@secunet.com>
In-Reply-To: <20260622075726.29685-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Mon, 22 Jun 2026 09:57:03 +0200 you wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> The XFRM compat layer (CONFIG_XFRM_USER_COMPAT) translates 32-bit xfrm
> netlink and setsockopt messages into the native 64-bit layout. It is
> only needed on architectures where the 32-bit and 64-bit ABIs disagree
> on u64 alignment, which the kernel encodes as COMPAT_FOR_U64_ALIGNMENT.
> 
> [...]

Here is the summary with links:
  - [1/7] xfrm: use compat translator only for u64 alignment mismatch
    https://git.kernel.org/netdev/net/c/355fbcbdc253
  - [2/7] net: af_key: initialize alg_key_len for IPComp states
    https://git.kernel.org/netdev/net/c/d129c3177d7b
  - [3/7] xfrm: Fix dev use-after-free in xfrm async resumption
    https://git.kernel.org/netdev/net/c/8045c0df98d4
  - [4/7] xfrm: Fix xfrm state cache insertion race
    https://git.kernel.org/netdev/net/c/ddd3d0132920
  - [5/7] xfrm: annotate data-races around xfrm_policy_count[] and xfrm_policy_default[]
    https://git.kernel.org/netdev/net/c/68de007d5ac9
  - [6/7] espintcp: use sk_msg_free_partial to fix partial send
    https://git.kernel.org/netdev/net/c/007800408002
  - [7/7] xfrm: validate selector family and prefixlen during match
    https://git.kernel.org/netdev/net/c/40f0b1047918

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


