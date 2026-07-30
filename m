Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF6306767
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409246; cv=none; b=aGgTmGyLKhOGKW1jfY4myo6p4eGrsWpAvOZpqVBQ4kCcp5cm4HIjrrC8iNXJhE3KMG4+1RnKILbeZmPD3XV1mRaB6v0tvXfAkoxowE1piOzrtGZtt0dy1NKYzOT6ebNSiDh5hRCs4vk2llx62tbYcESvo24BNs7w/YOtWrILUIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409246; c=relaxed/simple;
	bh=NhcMVU2+vbCkRGchulsyEeZqNlsSlul5b5EmFgXfvF0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uvjY6hppj+TTwpP90X9GFcjQSX2abFIQtHUTGK0QoLABcQm4utq6UTSz+N2S5FG+b2oU/IMYyehe2bNGyMV2c1ZdHbj1Iv/wBDeH4RHPVj1Y7f10ONgUYxQ+zXTgKVqAdCL5zjq5AFtMC5Sr3qHs26UUtkf/ZxSiVR60B0vwKv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ys6V2vbS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ys6V2vbS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321A81F000E9;
	Thu, 30 Jul 2026 11:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785409245;
	bh=FVLfXa3XcyhCoeDf/E98Yd/cMhofj3bj0oGaNy6tSiA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ys6V2vbSn8/cR4X7qboGdmZh/w4iTXRtK7sw84q1fIubAZeGUROtAixAB/K5SACdK
	 4KeXMMwDfRlbKkyKe7nM5ZElQ+XJY4689NrH5uEiuPnNbXMoNXSKdnMYaF+WiUzQxK
	 6WukWLMxxqr37hOWvQ2oxvbC/IqiturDcr5WN+QdCzjYFsekDegAaQ65AvxjrjM27q
	 yap7ode6WUnb1EyFP9TfDHln7+DzC7/AVeuOUt/gZEP4Ye2s4mov9WVGZHQI8U2hND
	 /G7W5xLkQx801cU46BJ0KwWc9bzKvJq82JPh3IPQlsBNot4yUKr7qsMfvUElqSwjlq
	 f8GevobNAfz9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 000E23811979;
	Thu, 30 Jul 2026 11:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: libwx: fix FDIR ATR queue mismatch for software
 VLAN
 packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178540920863.3506370.17411627610118442488.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 11:00:08 +0000
References: <0879DA38A8E32701+20260724074657.10773-1-jiawenwu@trustnetic.com>
In-Reply-To: <0879DA38A8E32701+20260724074657.10773-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jacob.e.keller@intel.com, kees@kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 24 Jul 2026 15:46:57 +0800 you wrote:
> When TX VLAN hardware offload is disabled, VLAN tags are embedded in
> the packet payload (software VLAN). Previously, the driver failed to
> set the WX_TX_FLAGS_SW_VLAN flag for these packets during transmission.
> 
> This missing flag caused the txgbe FDIR ATR logic to fall through to the
> default hash calculation path. This resulted in asymmetric hash values
> for Tx and Rx flows, preventing return packets from being steered to the
> same queue as the transmit packets.
> 
> [...]

Here is the summary with links:
  - [net] net: libwx: fix FDIR ATR queue mismatch for software VLAN packets
    https://git.kernel.org/netdev/net/c/732ed8f75ce5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


