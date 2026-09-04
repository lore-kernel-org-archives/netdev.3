Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950C2DF59;
	Fri,  4 Sep 2026 00:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788480069; cv=none; b=IAT9nsvXltI2V2zBQOnaL0fPatkffmn6JTw8+a+OSWeErMSAw4P8TGn189G9XLUXsVBmFV1CsP6j+0IH0HdDJiEdi6JcFcXSR+TS67O7EsTM78qRJeofyrtOjbN0t3DyxuzYzESiEuxyO9v4FIKYHPjMaFx4de39vAJKNAVPn0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788480069; c=relaxed/simple;
	bh=shCxixmMLbuhiBwD5fPr/xohNEQ0Ny7ofQDfzYK5u04=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UQD9PnBgth57T3XFwANfkD5TR3PFZnTAY/IFlvzxvaJfUT5vfaXeB4hg4yIZJ2E9TlQKUuurpIPFY80BXzyUD3qV2y3hvmhSOkVNDQOh+Ttl2CizzK8WG+yXVTYXexOp7I0b+4V+VOdRUPJradYnKytpCdahqH3RWPOpgt0VYgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii0SRMfN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii0SRMfN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE5E1F000E9;
	Fri,  4 Sep 2026 00:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788480068;
	bh=qMNpia4hA42mXFQdFh9lzgSKloGeeTRNn35TAl3B0Cw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ii0SRMfNNva76uhs3o8/p+e0ajvfoEgnenH6L5lGrw/oUwWfaBnkMI6fFn5qmCAeJ
	 xkLiQNrOPDL1qg3gEQx3s8y3xipNMm9D7RITJwwX+rlbJNWmVGUyL2m0+NyW3K0iN9
	 J9cNlDNbSSQTDVy1QFPaSjgKK9ezCUPUDqhjgDooTwux1YLQ/MAnVhX/Z4kzp8Izwv
	 u7t0ffpbOwfLQeibY5fqDAUUibFtzdpT6c7oYRHnysXiggKGBT66BZGFjow3JyvhPz
	 2MMdGgAAKLpepdiiPPPsf8uPN8zBODr12WjjuY2AB8YDiRgpDXQGiB/Lw6zZ52O+NP
	 wPv8rEnrH2Rdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9399338119E3;
	Fri,  4 Sep 2026 00:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: bcmasp: fix TX ring accounting bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178848000914.4077563.14627683271472464588.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 00:00:09 +0000
References: <20260831184235.4133351-1-danesh.petigara@broadcom.com>
In-Reply-To: <20260831184235.4133351-1-danesh.petigara@broadcom.com>
To: Danesh Petigara <danesh.petigara@broadcom.com>
Cc: justin.chen@broadcom.com, florian.fainelli@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Aug 2026 11:42:33 -0700 you wrote:
> Two fixes for TX descriptor ring handling in the bcmasp driver:
> 
>   - tx_spb_ring_full() re-initialized next_index from
>     intf->tx_spb_index on every loop iteration instead of advancing
>     it, so it only ever checked a single descriptor slot regardless
>     of cnt. This let bcmasp_xmit() proceed even when the ring didn't
>     actually have enough free slots for the SKB's fragments.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: bcmasp: clear txcb->last before writing each descriptor
    https://git.kernel.org/netdev/net/c/18e5e0ec0e92
  - [net,2/2] net: bcmasp: fix tx_spb_ring_full() checking same slot cnt times
    https://git.kernel.org/netdev/net/c/0c5cf62e72d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


