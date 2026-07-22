Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3BF34CFC5;
	Wed, 22 Jul 2026 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784684437; cv=none; b=sN3MV1vYNZaaU9AQgxDXzCG9ivOcZCmPtKuWrhj0EGjTuLfRgXtIk6gCL5bl6cOwnZ0oc8/gA5anirHhqs7n+oBg1Io/e2FLm9hp0xouJp6BEbvasZaEFWjMUf3RslAMhV+xvrvTnLgsJAUgdNuC9I1e+5CJ+eX7cRxwD1FJkYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784684437; c=relaxed/simple;
	bh=19Uu/GUqdh8PzmnLlVtJmVbDO8BFQ+xhQ8VKVBlMFv8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=stIu5/d0A2HmgX5MIxk+2pUzS7ZKlM/Tzpy67j9ivJ7vfGxw55NjkI4f721n3rhwlX2Acd93ceoRuxgePYkUu1xoq2t+OgosVZ3dQBw9ZxsCt5ZHQqNJwlfpFdfvLC/oPDLQUlf5n1r/h/V5Bszd45nNEm6AEltqSvMKdXhViz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRkghYPu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRkghYPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9172C1F000E9;
	Wed, 22 Jul 2026 01:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784684436;
	bh=4cqjIZqhaeSQd+673kccrZfYuP+KNsDkbXzARVF+plQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XRkghYPuUzm1kaP9cc4ZK9Afw6GpYYk+OHJ4GU7gaonXOIItfawCBxUYccdbJrevT
	 LiTV5+THbZFlF8BSUzqf5NvhPBTNI+BROhI4jBdJewxbGBhq7FVFgfGLCgv92CSemV
	 I53neP4xJgDeilcm1arAYY6YlzFCNlEnHG4XjMFXxtdNROSVRHkgQIBWUB4Lv5cp1p
	 TGVavufjrMTYKQkLwHjg3fKVtezNbzUMek9sjD9QuL+KPSq1neDxXAN4rvO0C7pJY8
	 nXZndxtrsaBbdm8GpYg7KSersNFEB1DEYTU43ruJK2ZCIZF7Ir+IDpTTB2Is3173Sd
	 vXTk4AqBxjQPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A58380820D;
	Wed, 22 Jul 2026 01:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: dsa: microchip: make read-only const array
 ts_reg
 static
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178468440590.1196317.11052767741054474941.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 01:40:05 +0000
References: <20260714191406.195375-1-colin.i.king@gmail.com>
In-Reply-To: <20260714191406.195375-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jul 2026 20:14:05 +0100 you wrote:
> Don't populate the read-only const array ts_reg on the stack
> at run time, instead make it static
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/dsa/microchip/ksz_ptp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [next] net: dsa: microchip: make read-only const array ts_reg static
    https://git.kernel.org/netdev/net-next/c/df13c1df8147

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


