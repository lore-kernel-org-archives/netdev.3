Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690FC33B961;
	Thu, 17 Sep 2026 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649494; cv=none; b=WA1uhOXzHX5gy+HXb2hnHDGCRJdv++v5zR7KJ25Pa7CXInU7TrbihHuIMtgdX16hvAaQnvHZ45jmja7accWy00lepHtkkC0AqcksBUgVX3KS5yHbaZrOsaucAN3Jo081rfZkcwjFtDjw9QHhTqAdB1bGsgXpN/YX7xUw8gMGN3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649494; c=relaxed/simple;
	bh=SDRUvFZK8rIAmUeAKRbRDQTTBXH3SGVln2dxFWZlVl4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eJzoZm4BuZlkVIbt7vxSzh5L4VF9n/dBxqPPwYEOB7cxYwOl0FWtzNgoge7MeprAaWxDoE3KRqlMTXFHYSBkCXl3PPeP055H3OOec6uhi1Ki1dfZyHBsxgFW8bgcWqidDTFMmTXwdWqCFZjgxOA+CSCM9AMDUb0r47udAaxEnsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5JKeL6f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5JKeL6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F307C1F000FF;
	Thu, 17 Sep 2026 12:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789649471;
	bh=sI+GtRw4aHTAKjYrhnVtt5dXcKHZCDXMagn7KFbRBsM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j5JKeL6fDPwVohNHTCbCuo+XjWjgw1YRExstLfPs8OKpRaRTupUBb0nGSLFznhLh6
	 c67jIXE66bYK8gDu2LIHCYPPuEjYu9aSgipzbjRmN6BEekm8bf0UHdQi2vy9f5iAmc
	 elQZ53k1JIvvqwS8KK6a98IOU14pUbLDdCjjQGuAcJAD41cX7z6k7aPlrWbHekA9w3
	 YKvTKgiELmpLUN6g1ronZy4fqq6q1+42Au84vk0AUW3f2f7bX+liUHwkRCoZdj3PD/
	 4XIPuufnGceYdyEa/1gOh5Pa3ui7NuEfsvVikG8WuEGrOFz6t7ovPl4ogS1UNvmCfR
	 yWxy5TIT3u8Zg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C0D38111DB;
	Thu, 17 Sep 2026 12:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mvpp2: prevent buffer overflow in page_pool
 allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178964940461.3627421.6609181029649236837.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 12:50:04 +0000
References: <20260914091557.71769-1-dokunevdmitriy@gmail.com>
In-Reply-To: <20260914091557.71769-1-dokunevdmitriy@gmail.com>
To: Dmitriy Okunev <dokunevdmitriy@gmail.com>
Cc: marcin.s.wojtas@gmail.com, linux@armlinux.org.uk,
 lvc-project@linuxtesting.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mcroce@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 14 Sep 2026 12:15:57 +0300 you wrote:
> The per‑processor buffering scheme is supported only if the
> number of pools (nrxqs * 2) does not exceed MVPP2_BM_MAX_POOLS (8).
> This is already checked in mvpp2_probe() during the initial
> activation of percpu_pools.
> 
> However, mvpp2_change_mtu() may later call
> mvpp2_bm_switch_buffers(priv, true) without this check, which can
> lead to an out-of-bounds access in the priv->page_pool array in
> mvpp2_bm_init(). The array is sized to hold MVPP2_PORT_MAX_RXQ
> entries, and mvpp2_get_nrxqs() may return exactly that value. The
> per-CPU scheme then doubles it to nrxqs * 2, exceeding the array
> bounds.
> 
> [...]

Here is the summary with links:
  - [net] net: mvpp2: prevent buffer overflow in page_pool allocation
    https://git.kernel.org/netdev/net/c/14cb1e7702e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


