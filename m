Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38E619B5A3
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776679; cv=none; b=H6yBECbNK9vJXnwYnB0TERlkVqF5bBE53mYLr9KDOrdC5VJblsSLC/U9Y8kEBmiwlKciZQ80KvNTcLchadPjW5ZUCEnyaUE2U2+QQcl0CCgIeC0O1fZ5Gb43jWkqPSlHXyAdNgwb9v82lrUv+jpoKGEFcMmgBB4cpNHhbarD578=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776679; c=relaxed/simple;
	bh=mIPvzTUS5+1VF/EW9Cs2rm5RTfqKBbfcIrtzgXRzUew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=COQrUy4xgGZrKg4We/N2XvSc4CsfdpSnGpgc30eeH+sKxw3IMTAKHcz1wFgaacRBhXOE3neYUG+M0I9UIc+QVWJAzJ8S8siHdRP21n3793X7I2nFncXhPzR0dwdQIbKaYsRwPjTq7lJ+g0DuVKLKRQdary2a6JUE8uRtp+6opMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdEmYdPZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdEmYdPZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B991F000FF;
	Sat, 19 Sep 2026 00:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776675;
	bh=WtKmSB6P2YzmavjZE5w8kMC0rQTITsIJffa/Nrmj8eA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cdEmYdPZIr/HDQr5fxnA/QpoJ3e8sPweLyZHqeOOp033xwiY0aIMO+Hddxc7bOfsy
	 e8tsPXRmygoPli17w2cTHhEi8oYJduxUp1mMu5ALUXWQnmDPMIBx2MVjl0Dtnbvvk+
	 xbFf+U3zyoQcyY/WfmvzN9NqBLUzx2hPhoorCD9Re//P5vTpqKUGv5c9OQ8JOHuWGe
	 VHSk0rihjq7r4c3F/D0m1k5SRMEZvBQl1yuv/9aYTZvl2J7Rx1u0F6rKwLsvcnNICq
	 kyETy0iz03X0lbQcJkRIHHOeHa0WzUvKyH4c58kTOyDyahTqbbwbScnycgtAMd950z
	 u63xux2JkcAaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D099D3811977;
	Sat, 19 Sep 2026 00:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sfc: add X4D PF support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977660839.1197442.3353465333414817600.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 00:10:08 +0000
References: <20260916125641.12238-1-alucerop@amd.com>
In-Reply-To: <20260916125641.12238-1-alucerop@amd.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, ecree.xilinx@gmail.com,
 andy.moreton@amd.com, pieter.jansen-van-vuuren@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 13:56:41 +0100 you wrote:
> From: Andy Moreton <andy.moreton@amd.com>
> 
> X4D is an X4 controller instance as an IP block in an SoC.
> It has the same feature set as X4.
> 
> Signed-off-by: Andy Moreton <andy.moreton@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> 
> [...]

Here is the summary with links:
  - [net-next] sfc: add X4D PF support
    https://git.kernel.org/netdev/net/c/24fedc7a569b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


