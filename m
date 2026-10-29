Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269210;
	b=mkT5SHW7rpHX2pZCzEvvpcFvMnQ4OzRDQgsba9It4g6PyoHjFIZoB1ItOGjCFgGagryL
	 zg4PKOwbai1jnOVHRQFVwBapHKHRWaNrt7wKfbzK/v2YIwzO/ZDS+RoHMwuRabOy+P9u+
	 zofyGCfByFeFg2sW7TygkvVfMtpmWqEpp4ZVF3ZtiVYOyTy9A0/lLndxbpT/FFvOS9sZD
	 e7yth/IcvLjf6nqim4clXPrw9Ve6siSAv0bzElYzUqUDUJeB8BXc51sGZNciF5tXp32Oz
	 PYZmDvWikViHlhqnvhOF2afLVHFhwqibXT8TI8UB4R83GGeC8D1UJbS5GJM2pNTyNLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269210;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=OF2QB9cgRpekb1TO5KWZK492f7aBogRyKJ8KyPEWbeE=;
	b=osbpMNrbvCP8o5Rwe/xHEckD32gqe7Edi3fjrHxCb2ohfcXMWj5B0hDt/8szy2ipOSSo
	 0vpSJo/33d2/W+ZFY3jFJQc2fbsdpfMP6ZJ7FF2nARcoTFJGWbyOn1nMbR0LaRGW+khIE
	 6uH5GjFoerm3BDmlkcCAIn8UExq1wC0qSyEmI0Idk1koLH/i3DGCH0B5xXCwoh4gEKfft
	 fUbZBHaoPDgaATwL2VO6zKk/eWMqIKmFpspu8GHi6WG1tRrg5pQLlOLW2UpDVpFuRaWj+
	 tlwDpCVjZL95YU9AV5vgOXZRHvt3+1W56w9GEzi8ZBO8g+eSi0TJ8bSX76lrcwi23Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0phUkTR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7354606A31C;
	Thu, 29 Oct 2026 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0phUkTR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD251F01825;
	Thu, 29 Oct 2026 10:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793269209;
	bh=OF2QB9cgRpekb1TO5KWZK492f7aBogRyKJ8KyPEWbeE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K0phUkTRT3DQ6MPEfP9WuRYonjs2BmKz75jIGpzhBsM0ty2cRL9FToxn0CJdqX3Zp
	 QrCi1RglMLuWc9AviuLqywP0CxBYZY8g0KQsW2gnn3OnaQiW47bI8BnlmYoIGzZRrQ
	 z3JK2eg6DkvCPjO6x+uTA/CgRQahnofr+4U4I346L9SN5lM3bZ71pJ9pEwWxVMWree
	 4lqmD8HeySxbJVwhPut3N0xmnI54a4+q+bw0nHHkRPgiA+krQtdEr5ylOFQEjmwkdl
	 b5gsWszkwsgvU5KAOjWdPGT5WKQsUe2ctNARaKBQDf31FUm1nELZ21HhvL8P926pex
	 yxKORZlpoYXYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 815173AB8A8A;
	Thu, 29 Oct 2026 10:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mctp: free reassembly head skb when key_add
 fails on
 SOM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179326920806.1737402.15204469071401829479.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 10:20:08 +0000
References: <179287946888.17431.11219154409333681184@gmail.com>
In-Reply-To: <179287946888.17431.11219154409333681184@gmail.com>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 24 Oct 2026 19:04:28 -0300 you wrote:
> When a start-of-message fragment creates a new reassembly key on the
> broadcast/bind path, mctp_frag_queue() stores the skb as
> key->reasm_head before the key is made observable with mctp_key_add().
> 
> If mctp_key_add() fails (a race with another SOM packet for the same
> source/dest/tag, or the receiving socket going away), the error path
> only drops the key reference via mctp_key_unref().  The final key
> destructor frees the key itself but not key->reasm_head, and since the
> key was never added to any list, neither the expiry worker nor socket
> teardown can reach it to release the queued fragment.  The skb is
> leaked.
> 
> [...]

Here is the summary with links:
  - [net] net: mctp: free reassembly head skb when key_add fails on SOM
    https://git.kernel.org/netdev/net/c/d2bfe74a8fe2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


