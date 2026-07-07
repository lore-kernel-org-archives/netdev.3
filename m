Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040963D75B1;
	Tue,  7 Jul 2026 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417829; cv=none; b=uEKqGiy/qX+zmYcJIZz5MtRNOlV2WU+njG2r5WajML6mjmZBkTeSIv1bmk0aS0tksUo1rKWyeYpeSlPCt6d4i9rXwGXSuGVUqmkNdQna75nVkQSxx8a5nVsi2V7VEJ8clUxWaEdfG1+fZPKR9IWMOvyg4m7gZvZ340b28bb7NOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417829; c=relaxed/simple;
	bh=GZsOd4ASM39ZL0uhgJI3H6PDpbrOLY4f9sOg2w9s2Ak=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BQV9IUs/4AEOwrinNFV5oa2FF4DKBeLZLC3Tn/6ODqwHZmdwO4w5CfIiRSzRR3zilgIr+SL+lLDfUSr+VAJBBuJCr0Kvnln9f4+BuAKCk0KK5p/MlFBLWN+OEXsNP9hDRfyHWzt20WiXLs8ahwsgsiecVQQn3YSrZDnR+kGva7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+KnhyXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+KnhyXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C8B1F000E9;
	Tue,  7 Jul 2026 09:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783417827;
	bh=AnnvIz/B+fTDsDUtEoM9we67NZmuseAuB+0lljq7zD4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=e+KnhyXopdPcxYbQ7xnjqHQvhlZBz2kg7xfES+1ygtK+AvE9PWDDYX560+8g89nxw
	 JGF/dxAP8Hrqc3J7oGUXb6dCHcYmNUyP1Qu4cuy9suoVYXxGL6nNUTfPDtz0/G6y8a
	 gZFb58X+52NS4tdlDvHXlKFXhuCwgtQop7DJE1O2W547BBVL4NM9ELTC3dB8X3RIK8
	 S2z9wTDUc20dDyfMK3/QAAo3V7CCIs6Z/tmjWdQ8uG3tgoIMW4Q/l0MVoTCeRBRkL5
	 hFyZ8FKbIIrbt3PozYkKfQDEaVM70IydQ/KPllM8LUA0upbT/zp6yCf8cKa850CeJ8
	 r4oLsLpGM+JrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BF93925473;
	Tue,  7 Jul 2026 09:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: ethernet: qualcomm: Unconstify function
 arguments passed by value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178341780740.1462730.2151997289805409104.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 09:50:07 +0000
References: <20260702094908.79859-3-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260702094908.79859-3-krzysztof.kozlowski@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: jie.luo@oss.qualcomm.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  2 Jul 2026 11:49:09 +0200 you wrote:
> There is no benefit in marking "const" a pass-by-value (not a pointer)
> function argument, because it is passed as a copy on the stack.  No code
> readability improvements, no additional compiler-time safety for misuse.
> Drop such redundant "const".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: ethernet: qualcomm: Unconstify function arguments passed by value
    https://git.kernel.org/netdev/net-next/c/e0421c6fd39d
  - [net-next,2/2] net: ethernet: qualcomm: Constify "queue_map" in ppe_ring_queue_map_set()
    https://git.kernel.org/netdev/net-next/c/cefd16657c1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


