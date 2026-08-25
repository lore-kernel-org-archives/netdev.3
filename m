Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEBE3D6463;
	Tue, 25 Aug 2026 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654464; cv=none; b=EwcnUOLL/Z1pbqB2w3gdPmiLweEKkXp09HdYrb/EWRTicJrwxwg+j0lWGARQXghRixzNIyKcrH5nWQO+Opj+o4YAO9nnNsSlrVO+uLEszT2Hf42os2L82NMdeFPpbKTvWkbgjARvTsL0fld3lVE6LmpAldpvb7ThetiMhBoE+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654464; c=relaxed/simple;
	bh=vSGiLL4GmELsxBqiXvsVZc9fxDRAEizVhRq2hvUDlBA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uqPuNnkKCi+sstwEb1ouaLQRmAyl4vA4Xi50LrxAVpZavSUj8IyqHRZfpS3TZevSwECx+7eQxv+/9et8E3k+nas9OpImuLMynjZ3ulZhaLERRV2y0/dUYRxh63I8Bw7caAqb+Jq7sCCbMrjPnmgrjgQjqWkLr13n1WuJiw7yih0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D37VT5wJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D37VT5wJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037321F00A3D;
	Tue, 25 Aug 2026 10:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787654463;
	bh=mo+PunfX2JOx/2nBETdz9r/0T8eYVhgV4/c2fAP0KA8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=D37VT5wJqHPraHGCyw6muLOcpJX7XMAQgkGsBBwl1wVGJhmR8d5sfP89jciUHUVHy
	 79a9tBkg/Iyim9COVFIyFKO2BajyxGVz0YhNY92k3C7WEgffXOg+9V8KWntf9cjh7v
	 KQnngUUX0vrU8H/iDp/vlQtoxA7pScpXbdVhw4tinvcnYhaErFKAquJM1M4a6u1R01
	 fKhufyqbgN6mx9JMNkJ4ai3PIbxUzE5i3W2LRgxy+zS9aqXQvDuBhw0ncFtIbmJv1+
	 c4TrSPQvUargFWZQsoIbjs8BIKoAc16BXApCQg+dj93GeygTdq8aA+WguCQso1vdsi
	 JUxuRqP8+Elug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 465273924A7F;
	Tue, 25 Aug 2026 10:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fix a resource leak in copy_net_ns() error
 handling
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178765440989.3381513.18011374580267192341.git-patchwork-notify@kernel.org>
Date: Tue, 25 Aug 2026 10:40:09 +0000
References: <c182cf90-1ed7-435b-88f7-9f00e88a0487@I-love.SAKURA.ne.jp>
In-Reply-To: <c182cf90-1ed7-435b-88f7-9f00e88a0487@I-love.SAKURA.ne.jp>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 22 Aug 2026 17:18:31 +0900 you wrote:
> Currently, preinit_net() does two things:
> 
>   (1) call ns_common_init() which might fail
>   (2) initialize resources which does not fail
> 
> However, preinit_net() is returning early when (1) fails, and copy_net_ns()
> is jumping to the dec_ucounts: label. As a result, resources allocated by
> net_alloc() are leaking. We need to call key_remove_domain() and
> net_passive_dec() in order to release resources allocated by net_alloc().
> 
> [...]

Here is the summary with links:
  - [net] net: fix a resource leak in copy_net_ns() error handling path
    https://git.kernel.org/netdev/net/c/3220b62fbb8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


