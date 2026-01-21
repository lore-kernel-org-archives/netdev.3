Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F11356A05;
	Wed, 21 Jan 2026 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768965010; cv=none; b=YFEmaFzD8isGf6pVOCW3lLFBPWQ7QiDaAmpMVdLBs6rqKHF32WXjYV5XSQJhf8gXPrZU/0Z9BqUkHaZ1ujXrURN6XVZSWabfv1gm+weC4d2GkTFlkxmQ2Gwj6kQklx5e9CKHZ/cHYZfyHxcBuTTIPvrIIuxrnDQNE6hnq6aIcUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768965010; c=relaxed/simple;
	bh=aielJTOBw58FwdnxXswivgYB/zLkpUygEabseHAholY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qtOQypmfvII23fy+7FT6yhgtvfAYMSg7bFIVCdnOmLRxAMQl7i4XXHeRXKIRZzOipb6Zk6rayU9vAX+qMTkCjDhqS2tWqoRqo2U9FvVqbrDQqAaStb2b0dYe7rW1ToLZrFprz4hISKVjjHE5qtt4PQmijP/DPiXeoF2OXJRw9fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tqtvpj7L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tqtvpj7L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E43FC16AAE;
	Wed, 21 Jan 2026 03:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768965010;
	bh=aielJTOBw58FwdnxXswivgYB/zLkpUygEabseHAholY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tqtvpj7L6nZJhK3/b7H42VznxbN/P//tWku6NVPFD2YMDCIIy2IQyn8u2vAxULYeV
	 Tv9B9V+PmTr0wGU06cMTGDL0ZG7cw0tkEoeGU9cQHA+NtonRfqEjUIu0BeEhDFbnhO
	 YI65DN2V/zuMMhW3vUbCIF6GRuHJQIq3E0hFVBMR1D34kQP5x9tTVJQC2doOyLgeue
	 Mf8CtykHbIDNMFgmuK16LuQYTF7T9qpvxcv/BIAF83bW8Uny+kZXR6XSy/GilZoM7N
	 f9rrNN7R+7lpV1zc6P56SVlgLeuqKox3oykxPNIlDa5VNRbU6pATEK2W9ETwGoIWgs
	 p6eOJSPCsKOtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8BBE380820D;
	Wed, 21 Jan 2026 03:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] usbnet: limit max_mtu based on device's hard_mtu
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896500760.707355.7611917521322998807.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 03:10:07 +0000
References: <20260119075518.2774373-1-lvivier@redhat.com>
In-Reply-To: <20260119075518.2774373-1-lvivier@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, oneukum@suse.com,
 kuba@kernel.org, netdev@vger.kernel.org, sbrivio@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jan 2026 08:55:18 +0100 you wrote:
> The usbnet driver initializes net->max_mtu to ETH_MAX_MTU before calling
> the device's bind() callback. When the bind() callback sets
> dev->hard_mtu based the device's actual capability (from CDC Ethernet's
> wMaxSegmentSize descriptor), max_mtu is never updated to reflect this
> hardware limitation).
> 
> This allows userspace (DHCP or IPv6 RA) to configure MTU larger than the
> device can handle, leading to silent packet drops when the backend sends
> packet exceeding the device's buffer size.
> 
> [...]

Here is the summary with links:
  - [net,v2] usbnet: limit max_mtu based on device's hard_mtu
    https://git.kernel.org/netdev/net/c/c7159e960f14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


