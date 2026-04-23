Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F52391849;
	Thu, 23 Apr 2026 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971458; cv=none; b=S9RoxxZLhZCdp39/a8aFnCHctpDCzgwggj7Km+gFDZ182lBwpiM71xkOhtcojqnhH+UfXv7HX/Q0sojJWy9oHod4cTCWHFbRuGCm5X1Ct0/dYKeg9bJH2kr8GDouLVwKzQbrAtWXgDfw0EiGqRw5wuP4jKkAQVs6+GsvsmQrMXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971458; c=relaxed/simple;
	bh=9e5VmGda+qwzIXQa0CxGLtz5GcJXNLvIIrfVCTCBjO8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZjnAfEQj7NXocfUb42RZrmyzTvVpmZKvb+Ijhx5XWpsw8t/f4h01vN1qC4BEK8RJSJyiUJjofDSBOzfyoZhfQ/QUmcJLRTZIiwefPdnsvstezOcG9xoJTOXhmxB42kgO3XOTH06t+8eHFYYncl4/QYvHpPjLl2wU6SBtq/FUYck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYIA9S+G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYIA9S+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AD8C2BCB2;
	Thu, 23 Apr 2026 19:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776971458;
	bh=9e5VmGda+qwzIXQa0CxGLtz5GcJXNLvIIrfVCTCBjO8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AYIA9S+GLMVfGejcdOheLhax3i3sonxphi4pQnDk5eoZhC49JFJx7DdOsiAslwzst
	 SmkuUs9Tq8nyWmdabL9Fv1K1QOzYi4qcoSYaGELWOxfxnuLVaMkUf5J9JGDCqOmMSJ
	 EVqbjA6YzR406L5pzvNK4ppKlBt6vjnDyNF8HymEyr+GmTnnVF8qJFE89BeUd96v5e
	 IA3inSOaUY7KRFu9UDPMT+nTRbNzG3hnQmdmxWlg0JRtMZSesz1f4gqTQnIk4S6nFC
	 r6qIS5/fNwotcObxhcyAOIfIH2bNf3V9s4U1jPaPOpqBcSILPMu4BjbatY5fyukhjY
	 n9uS16TH94XyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDC73809A90;
	Thu, 23 Apr 2026 19:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: txgbe: fix firmware version check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177697141900.724716.10482126880651767158.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 19:10:19 +0000
References: <C787AA5C07598B13+20260422071837.372731-1-jiawenwu@trustnetic.com>
In-Reply-To: 
 <C787AA5C07598B13+20260422071837.372731-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, jacob.e.keller@intel.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Apr 2026 15:18:37 +0800 you wrote:
> For the device SP, the firmware version is a 32-bit value where the
> lower 20 bits represent the base version number. And the customized
> firmware version populates the upper 12 bits with a specific
> identification number.
> 
> For other devices AML 25G and 40G, the upper 12 bits of the firmware
> version is always non-zero, and they have other naming conventions.
> 
> [...]

Here is the summary with links:
  - [net] net: txgbe: fix firmware version check
    https://git.kernel.org/netdev/net/c/c263f644add3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


