Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E18B3B8406;
	Thu, 24 Sep 2026 01:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214683; cv=none; b=gUCUspMw5t/JbHpBamXXhaeK6nzLOwq3fpPghjk/CjwbdzT4Qh/Knhd+BXAwoxh1fULxh+8Us+sgT8gA08+4T0j+t8J35xSxXgknH62IGjIvaH5w6UrebP2NjVBBiNP1MEkDyBNqUJw/p02HroVCRB7niENOGedN8sGYbkr6Pz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214683; c=relaxed/simple;
	bh=9T/COWxcSeehihYLn+1YXqagT4+Og1lOsmkp8L4GAqg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U9EKHCuCCBMiiALsESh3V0gMMc8K0XK2B9jDmRv8wWe+LhyealuQ5t065HvgdFV/mlXeim07S/ParOtZ7PQPOwYZnHQ6Nj1PhgLhT66+rSQv1E5+CIV6OyxL1ZAt80VfFU3TV1mE2T18OPifbfGt6z7grlIVSpOUwN7tB18ZotQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcwLIV9e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcwLIV9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37111F00893;
	Thu, 24 Sep 2026 01:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790214678;
	bh=sHjop9h1tJbP3cnMjOYvnPxAkLglYFO8URcVR/Y7jhY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GcwLIV9eeg8mu6CsV/8uCo3/gNCDSyOB4HHsk7AJZreAnrAZ6hw+hEIj3zm4s+xjJ
	 F4w2Fo9b19nU10NVPvmmNfDEUFto+Ba0lk92apsapf6VN0sl9VfDSNjiJGm5D28Hdj
	 PNhsqpV/tpyaHcmDS8ceDcBm973vuUf6uKUa9eQKtuV6GVTLcYOyQ6jIwMrzKRtPZW
	 s7kF50erGRy8adci2MOkXJBl0jCM2Vs4KM0Nbwyc0f65+qy2Y6A629/raNRxROyz0G
	 ro+HniJU6f/6qGS/kzvA0QgU5UwXyom2CcCjvxWb8VRIebUiKv/+T2X8ueHxCTNy7R
	 ZDRtDYjJfsVGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C6739E9611;
	Thu, 24 Sep 2026 01:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: dsa: mv88e6xxx: 88E6191X and 88E6193X have no
 PTP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021460814.1272040.10325459981937055395.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 01:50:08 +0000
References: <20260921-send-net-v2-1-031ad720f140@studio.unibo.it>
In-Reply-To: <20260921-send-net-v2-1-031ad720f140@studio.unibo.it>
To: =?utf-8?q?Nicol=C3=B2_Giuliani_-_nicolo=2Egiuliani6=40studio=2Eunibo=2Eit_?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?=3Cnicolo=2Egiuliani6=40studio=2Eunibo=2Eit=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Sep 2026 05:56:29 +0200 you wrote:
> From: Nicolo Giuliani <nicolo.giuliani6@studio.unibo.it>
> 
> The 88E6191X and 88E6193X are 6393 family devices that share
> mv88e6393x_ops with the 88E6393X and are marked as ptp_support. Marvell's
> UMSD driver describes both as parts without AVB (88E6193X: "BGA package -
> No AVB, No Routing, No Cut-through"), and the register access confirms it
> on an 88E6193X: the whole indirect AVB register space behind Global 2
> registers 0x16 and 0x17 reads zero, for every port, block and address,
> with the 6390 and with the 6352 command encoding. Writes to the TAI
> registers, including the clock period register and the TAI global
> configuration register, read back as zero.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: dsa: mv88e6xxx: 88E6191X and 88E6193X have no PTP
    https://git.kernel.org/netdev/net/c/6b491af01aa5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


