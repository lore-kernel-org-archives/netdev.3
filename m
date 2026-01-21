Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322BF2DAFAF
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768962628; cv=none; b=J07jk0Lbx1J0xtRARq28HEebBB2GwYSZmpu9tdjE6dnhlqx5KrBWxTQma+ti0WDCpX6NO/SOfzuLe9JuVxHTgedYnGyAA/YjUsQAcfL9ZcK05oCBSz6opXO34yxkDDz28Tj323g82BV2boOx4sGUS0BMtDmIMo4Fx+Np9hrgAGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768962628; c=relaxed/simple;
	bh=yOFLiu8j9KyJ4SLZ0tXgfcNX3nFM0NI5jXzURyJTxGA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ctS3XR+JnFSrs1cRPT2/Ne9UNShf1HqJGGZ0aF6WWIjFw2EHWUEb5HZYH6bzIgrhSpOnjdMa95zzf3KiHhZ6QbAk3ifMzacYoqPb9IqMNblGRbI2T5GYcxEfDHUmERomYiWr1lKZ8SbaL9QQdF9ZZ9kmpgDaqsH/zHzyw9qYtX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Igcup7e9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Igcup7e9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF5BC16AAE;
	Wed, 21 Jan 2026 02:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768962626;
	bh=yOFLiu8j9KyJ4SLZ0tXgfcNX3nFM0NI5jXzURyJTxGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Igcup7e9omJ9DgJ/GliM2wpQJjI1HfsHhLLAjSX5Vats5ZBpz6gNYEEVCcKF/MB73
	 lKduUyvAudNa+EKIb3pAgp/X3M7Rf0vSbhKEhtN3UVkibbyt40Ol1fkxre6TQt9trG
	 +kgMBnrklofYYXnMlWOCCaz7VGHXjiquntvWv2wE4o2qyOKgBKKPbayv3avjqIY35l
	 aKZsiOOYTsO/BTygFThU2vdTglbF44rVqMxBDwsVnvfO9La//CHM5cRc3fkaaPNcbY
	 krCoWhpAkczW0o66mcevam+8Fl2t4M+7Z1iCbyoB9QmyW461i1W6YZ4Z21AyaI6YLb
	 31z8WwlnGWcKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8D64380820D;
	Wed, 21 Jan 2026 02:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 0/5] eth: fbnic: Update IPC mailbox support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896262334.696500.8202466156662422976.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:30:23 +0000
References: <20260115003353.4150771-1-mohsin.bashr@gmail.com>
In-Reply-To: <20260115003353.4150771-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 jacob.e.keller@intel.com, kernel-team@meta.com, kuba@kernel.org,
 lee@trager.us, pabeni@redhat.com, sanman.p211993@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Jan 2026 16:33:48 -0800 you wrote:
> Update IPC mailbox support for fbnic to cater for several changes.
> ---
> Changelog:
> V2:
>  - Update P5 to handle regressions with the use of
>    fbnic_mbx_wait_for_cmpl()
> 
> [...]

Here is the summary with links:
  - [net-next,V2,1/5] eth: fbnic: Use GFP_KERNEL to allocting mbx pages
    https://git.kernel.org/netdev/net-next/c/bafae5de41c2
  - [net-next,V2,2/5] eth: fbnic: Allocate all pages for RX mailbox
    https://git.kernel.org/netdev/net-next/c/0c86b52b1a94
  - [net-next,V2,3/5] eth: fbnic: Reuse RX mailbox pages
    https://git.kernel.org/netdev/net-next/c/301ae0d5391a
  - [net-next,V2,4/5] eth: fbnic: Remove retry support
    https://git.kernel.org/netdev/net-next/c/320ee20a0b54
  - [net-next,V2,5/5] eth: fbnic: Update RX mbox timeout value
    https://git.kernel.org/netdev/net-next/c/5d18a4d04309

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


