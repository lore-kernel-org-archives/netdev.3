Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81F6370AEC
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733640; cv=none; b=XP7Fa6FA0nbqAbwAviQPVGWDl6MkyXavUDyiTPimY5rCUaislmr90a0Xuy6hX0D9BNmE5R8MW24/Dd/j/LSOx6nml+b/D1II7ijV9HQwANFBzaeTZPhegcjAtp1REm9Aw4Ajabq5ZQvTis0tCbXqqbOt1soRv77+OqlI1Bjn4Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733640; c=relaxed/simple;
	bh=Nq9iHvsN6Oj992XEV1FBS/aWpeAtRK931WfRIFmTquQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vBR4FhWflUkMx81gv0zqlHSsnaatppUlyyeXsyjW8+XV59JzLaMM23y/9E7MSVqNb99NKAty26obum7wbPH6O07aj1pg8zusonY7NnUttsE156r2KXhWqhL+z8JT5ze0wSLHJ2jYxdJ/mQs0mAf6GSYjrB241qwI6J1ArCVVstM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hku3f8gS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hku3f8gS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76941F000E9;
	Wed, 22 Jul 2026 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784733637;
	bh=eAjR/tCjCJyt7rXboY/1CNS599nPNi7dR+gEmxFM58w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hku3f8gSCFzKqU3V9teHQjqc2xtpNafh8XRsHkSpkUkrQQG5HlKOdj8bJrS7iaAZl
	 r8crXI1JVy0G2w3p7XihOfx37bmgEHXrB1ork5OKWmX8hkdVLBgJnIQwMt2DN5nNmO
	 kRgYh/Zg3DxBo783jel/BQR8aXjURTESWviwkLNKaGyTTJZH4LM9ZhTixXcGUWl/8v
	 4HTYrAqW5W+0Zo8UOTlTfgXr4e1TiZDOYOptyxzWmQH6rNKOzWsJjvaqpDOkZkfslC
	 z9Ayl9DjpghkexP9d8e9kzxoeqXonNhCeXkfPmJWOCNk9eIqWasa4CONXLtvhqtoaC
	 OdsuNK8KnQy3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0BE34380AA5D;
	Wed, 22 Jul 2026 15:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: libwx: disable TX VLAN offload for
 packets
 with >2 VLAN tags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178473360565.1451948.8188774006991581939.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 15:20:05 +0000
References: <069DF89AA8029189+20260713060441.276612-1-jiawenwu@trustnetic.com>
In-Reply-To: 
 <069DF89AA8029189+20260713060441.276612-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, duanqiangwen@net-swift.com,
 mengyuanlou@net-swift.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jacob.e.keller@intel.com, kees@kernel.org, przemyslaw.kitszel@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jul 2026 14:04:41 +0800 you wrote:
> The current hardware does not support TX VLAN offload for packets with
> three or more VLAN tags. When such packets are transmitted with hardware
> VLAN offload enabled, the hardware may malfunction or produce corrupted
> frames.
> 
> Add a check in wx_features_check() to parse the VLAN depth of the
> skb. If more than two VLAN tags are detected (including both the
> hardware tag and in-band tags), strip NETIF_F_HW_VLAN_CTAG_TX and
> NETIF_F_HW_VLAN_STAG_TX from the feature set. This forces the
> kernel networking stack to handle VLAN insertion in software for
> these specific packets, ensuring correct transmission.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: libwx: disable TX VLAN offload for packets with >2 VLAN tags
    https://git.kernel.org/netdev/net-next/c/f5cfb576ce39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


