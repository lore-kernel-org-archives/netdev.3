Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9743FA5FC;
	Fri, 24 Jul 2026 22:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932848; cv=none; b=N9yXnp9Uq4hcsR/QIX19o/AKwjikJnn73MWUzN6Zngd0+5oAq8RyK5W2xDYY3gLWlhyX9+s/J9yFeY1UsY1kvT+LwEfUY+qWPjyp7Jr6GvWaB3ZSSMM+z+cBJErs+sArqJhgkCw96JrNDJGrBMwnMNk8EHqkyJa/Qob3yB4Khao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932848; c=relaxed/simple;
	bh=fomWCfyfABSskXuPhq2s58IXf6NwK95hv7atmnGCvG8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ioVJwEeV3OaQSUMHisoNSDacx9w6k/xbUqKuKtZK4ry0+ZkM97wZ0aY9gJEPcOy4HKEXrwMoCrA9DNZoV5hJ64Qen+WyqE22AxDA5AD8UoUsboDzhYdv6rtWMhSyDqzUfB7OP5ZJ5xNFsCgIzBztUmvxPx45cIeUvZZ+KkYJdPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNnlqBr+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNnlqBr+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E36B1F000E9;
	Fri, 24 Jul 2026 22:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784932839;
	bh=tDedWZ+dAWBkH307mREvALS7lopnEw58yrEtivcJ7cs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UNnlqBr+JncASSvirb8c511UaGu79zsXuP7MDJBo8+v66BWPsO05LiYbqwkBvt7vZ
	 YUpJC4HsG1jGumGS5KgZua9QP1b9yOIoIKPNgbXVY97Aa5mkW9xr5VyNx0m4arrQdW
	 9d+D500H3T5X96IHOMSod8H98RGbT0Ux55lEh6/bp5+zyXrbuAJY69cqRSUJRQMXYX
	 MzU0u8W1ImuW7tr2FTjQCFIkLYa2BlTpQKR1KzjbmJZS15VqSif8qIR0+Pxc4XYhre
	 JnRjYKa5wd9jgbL7iRA21eLcC+VysLDRqUTWaAn/6bW3JPTZok/6buGVsINWxZiv3F
	 qRE2nWQqG9xqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9393038111D7;
	Fri, 24 Jul 2026 22:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: hns: use u32 for register offset in RCB
 TX
 coalescing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178493280614.3338677.8807103639653876808.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 22:40:06 +0000
References: <20260715125856.19346-1-dish@amicon.ru>
In-Reply-To: <20260715125856.19346-1-dish@amicon.ru>
To: Daniil Iskhakov <dish@amicon.ru>
Cc: shenjian15@huawei.com, ade@amicon.ru, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, rrv@amicon.ru,
 lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Jul 2026 15:58:48 +0300 you wrote:
> From: Daniil Agalakov <ade@amicon.ru>
> 
> In both hns_rcb_get_tx_coalesced_frames() and
> hns_rcb_set_tx_coalesced_frames(), the local variable reg holds a
> register offset passed to dsaf_read_dev() or dsaf_write_dev().
> 
> Register offsets on this hardware are 32-bit values. Use u32 for reg
> to match the register access interfaces and avoid implying that
> 64-bit offsets are supported.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: hns: use u32 for register offset in RCB TX coalescing
    https://git.kernel.org/netdev/net-next/c/bf8cdde4ef35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


