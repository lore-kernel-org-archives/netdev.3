Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836292E8882;
	Thu,  5 Feb 2026 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283207; cv=none; b=khmB0rbLa9WMY2yQ6kfYGWOJYXMovzgk8L3d6xV/ziIzQBqu8i7I8uzyAOjsU2vmtgEZr+SQgpX6x+EmDT6Jeaxx01T2ju2KVVawOWkZ9chJt4XOS4jZ7pui5YWWUPFFP67t871XS0LLbE0vFtC2KFS3GWZBhar7qMVphNbezKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283207; c=relaxed/simple;
	bh=614M0VdzJXYBFJAeJT1VgDJRpFBN3Hzr5FT/n+JepO0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bhQuyUYXH7W3CaVHQ8+Hflij7gh+krmHRIYw0aUVIr4NdRSFlSR3i5EmcAe9jrdTazZ563fz3ilb9K6WhEdMTUAiFGqhkNSBzYmqI6j08vG6jTZA9sj13zJ1ciO0SQBBGD1PKrsKSiFdiKM3hFysj69DpXXUSlsQozAL2qvhGc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXKza7/2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXKza7/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28765C4CEF7;
	Thu,  5 Feb 2026 09:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770283207;
	bh=614M0VdzJXYBFJAeJT1VgDJRpFBN3Hzr5FT/n+JepO0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IXKza7/2BEW45wIdqlmpVYRWkE1EV/VrazjK5nYifKm0LzK/DajLoYoUrMfEXJy9e
	 OW2/CtvZC5oz9D7GWH08FGIKkSGe7se8uCAsByaGRR2fg3Je86C40nrOBjBp9dEdTl
	 0ohoF/UrFpcgFdQ8/+kl/fzGhywe7huDYi2hTd7vo0z3FXHpyuSzwzbQq6DxEDDgvo
	 lHg9irduEAmxvvRXYt8XALfZua4bWbDrLKe6PFPO9+6w6gWLw0h+Akv4D5QaA6I9TL
	 fD81lV7pV1YpG7wupzD+dPzceiXYwpn6C4yPcNGNp9mDU0s6I4p/PeWMtsOdNA3ct1
	 Crb7XDamx840Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4824E3808200;
	Thu,  5 Feb 2026 09:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] ppp: enable TX scatter-gather
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177028320508.240033.8201991692936661182.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 09:20:05 +0000
References: <20260129012902.941-1-dqfext@gmail.com>
In-Reply-To: <20260129012902.941-1-dqfext@gmail.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, toke@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 29 Jan 2026 09:29:02 +0800 you wrote:
> PPP channels using chan->direct_xmit prepend the PPP header to a skb and
> call dev_queue_xmit() directly. In this mode the skb does not need to be
> linear, but the PPP netdevice currently does not advertise
> scatter-gather features, causing unnecessary linearization and
> preventing GSO.
> 
> Enable NETIF_F_SG and NETIF_F_FRAGLIST on PPP devices. In case a linear
> buffer is required (PPP compression, multilink, and channels without
> direct_xmit), call skb_linearize() explicitly.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] ppp: enable TX scatter-gather
    https://git.kernel.org/netdev/net-next/c/42fcb213e58a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


