Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A336B92B;
	Thu, 17 Sep 2026 00:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605680; cv=none; b=JHe8hUdRXCTVo5tIp5MMamwYUGfzYUlybrU2qmyGtqCg74XTMrcnF4bJrelC9hfBYQOzUkSPhaOOPoVGGSKshtl8a/bvQJaUrBNX3AtR8HFPv6YLnIaDCNyDHAPU9DPHlAViC8mMDFSiEvfJpHrbgduzcJLee5hRu5y7V6rXimQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605680; c=relaxed/simple;
	bh=9lDotnf8jlA4jkg7R4nlz58KMj5YHW5neoAxl0bIPAM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TwA+fdVAQd/Kmf8FxpO4gbU9KDsDYwHj5nWNfk3QJcTbiPe0cGOl82Y9Z/1fgJFCr+DwEq7xOTUhtl6/t9RtSlDVt1WIgCYpkC3iBBUsJ1reGkaQSubmFDpFIATUBD0kDMFnSP4eVXlwpSQBcFlR1U/EfY0sIMuoN2UIDlDgFZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYUH5/TK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYUH5/TK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E161F00893;
	Thu, 17 Sep 2026 00:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605679;
	bh=A49pSXXpzfrBkD6SlzbHdxfk6FZ7Gw/dVi6SdDOmqCw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GYUH5/TKfOThuqIkZPbO0p/ES8ALwCzbqAn79eK6Os79gaN16NGzV8wIM9kMXCtQ/
	 oS4OpgmAnYE9clwrxz56ac1NmSFbJesB5KAjL/BBWSOdjxndiIcNyb334EmJmri17E
	 I7ULhSZm6eUIOqvsXeBDKPSkftkfcY556mWYoakuconHayLtKutzbj6bD2z+gIMvOh
	 iScikuMstcPmBV+FHRNHT5icbrUdM4bNqABMNK6Kg37pqSmMWyQCkJCSnjqk8GmlH+
	 1PR6BC5UJhWZuq6JqFu2/RWVQ24PEL8Hynord+6Q++1T+cmJiBjgmFNLRMlywaOuYw
	 xQT4q0t6KymHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93ADF39E9601;
	Thu, 17 Sep 2026 00:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/packet: clear RX owner on VNET header error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178960561315.3354472.9079792511142407738.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 00:40:13 +0000
References: <20260913-b4-send-packet-vnet-v1-1-5545ffb528ae@gmail.com>
In-Reply-To: <20260913-b4-send-packet-vnet-v1-1-5545ffb528ae@gmail.com>
To: Mark Amirkan <markdamirkan@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 pabeni@redhat.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
 kuba@kernel.org, jrosen@cisco.com, horms@kernel.org, edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Sep 2026 10:28:08 +0000 you wrote:
> From: Mark Amirkan <markdamirkan@gmail.com>
> 
> Commit 61fad6816fc1 ("net/packet: tpacket_rcv: avoid a producer race
> condition") added rx_owner_map and made tpacket_rcv() claim a V1 or V2
> ring slot before converting the virtio-net header.  If the conversion
> fails, the drop path leaves the slot claimed.
> 
> [...]

Here is the summary with links:
  - [net] net/packet: clear RX owner on VNET header error
    https://git.kernel.org/netdev/net/c/33ff111d7ba3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


