Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448206;
	b=SHmd9NojqRm6hebFvJBXFuKkWU0I8MeYiVAvhNHWorODL9uLmIT2TJZzy6e+DdP7zixi
	 +QOXyp8dBoTsxgMmSwsqmNh4BrLYGvSlUtUhiBBuEMI1Oijfb2F7Gzwe74EhzbLdnvKD0
	 VPqKlYJaFizBe+0+L9pB7WOtGkBRC0DyIPGhtWqXm7/Cw+Q2dsURHDalIZJlO9k++B67M
	 vJGXWISrg2gHDV9qiaXLZoI8AQNFu9d5pULJkyjWWSGtc1rIyq2r2I84t8sjlIxSmbFN6
	 zydfpuX4wzq3XKZ2UZwbcCoqjP8WCtF0+7p5yUPT99FlvQo/a6ZC3kQUJl+Opp8oErA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=F6R/bSZIWnJ9S6H8K8ItSwPWni79d3HfM5cY/SM0vug=;
	b=OM9qHjvSDjF4SthJbmBpW/E90cbMQL6l9ZWiPmnURLCM+uNQrpUHyRjh8Fnl4lq0JAAR
	 FrLO+7iklHBzN4l/quAoLyc0UA1gKQi9hzMm0eEzb2l9RLJ4THUY14Azear+l+rHyD5lu
	 NzkEFZdtg9LvNNP4rZW2eCISMCgiBerCFlkOyuEttWZUZCHqpQ8azUwsfaLJPTHezqzVD
	 TI6ZjKasUJypnFEBG38Vv0k58BroVKr8FB+HzB4+64yEaR+xBH9eLqPHxZ29xihP9cLhZ
	 L1p+UlOkA/ShlJzX7nzqDz8G5Jq2mZZOLjqz88P96tzLBAeh8Qg0EOz8WLK6cVN+EGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EE5RfziC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3FE606A31C;
	Thu, 12 Nov 2026 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EE5RfziC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6877D1F00A05;
	Thu, 12 Nov 2026 01:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794448206;
	bh=F6R/bSZIWnJ9S6H8K8ItSwPWni79d3HfM5cY/SM0vug=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EE5RfziC/hHH+fzx3W6t0wnHJOgBV3sq3HwRx3bUvN9546HsmCVBK/l5y1mUovetA
	 Wya/gK5ZSjuGC99p2LlbOXhtxkEYOSMaQSUYvPiPRLTXThnjEW6acO8rYUv4FI+Yxn
	 HGNvJ+TgZ7M7z3fpv0G0ZiTRpZ7I/ARdrujRWopRIwtK444eLlKJFqWXaS+CVmZgJ+
	 zCTtkjYCvOcHfhHGR6wh9IJGBRRNXlpCETTfsp6sznOTX+xL34K9fqcenIGW31cFEB
	 0v7gjsZYtV5PSeYIBX8rdiRNIh2zGgnf8Tij+TG2Iu8ltFhwQsiP8hCmR6G1EEdwgF
	 AuQiOINMbB1PA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E2C1391AFCF;
	Thu, 12 Nov 2026 01:50:06 +0000 (UTC)
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
Subject: Re: [PATCH net-next] net: xgene: Fix the size of the IRQ name buffer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179444820493.1763187.7950827915969494287.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 01:50:04 +0000
References: <20261106044421.3461816-1-xujiahao@cmss.chinamobile.com>
In-Reply-To: <20261106044421.3461816-1-xujiahao@cmss.chinamobile.com>
To: Jiahao Xu <xujiahao@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, iyappan@os.amperecomputing.com,
 keyur@os.amperecomputing.com, quan@os.amperecomputing.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Nov 2026 12:44:21 +0800 you wrote:
> xgene_enet_set_irq_name() composes the interrupt names as
> "<netdev>-rx-txc", "<netdev>-rx-%d" and "<netdev>-txc-%d" into
> ring->irq_name[], which is IRQ_ID_SIZE bytes.  A 15-character netdev
> name plus "-txc-" and a full-range %d needs 31 bytes including the
> terminator, so the names of long interfaces can be truncated, and gcc
> reports it in a W=1 build:
> 
> [...]

Here is the summary with links:
  - [net-next] net: xgene: Fix the size of the IRQ name buffer
    https://git.kernel.org/netdev/net-next/c/9dc4c50bedfc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


