Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C730344DA0;
	Thu, 23 Jul 2026 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821852; cv=none; b=qrSgymtY4/e48bVAUllZXnlHGZtxyQNzTZyx8wjl0XcVCHfbSswOnpbMsY8T9mr7OU7ksb5KmYOx4JOGofoRDUBcaSBk0+bMK6YAX8QXZItIAZSmVimFblqENDkAEUHu+jnMeqiwCL09UWrYEzR9yYPdVx36I47vIuWGE3r6T5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821852; c=relaxed/simple;
	bh=VP9XoSxe/Kfe/eniO0ixqNzEl0wBjhMoYswywG2as/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cFJAsCGhu3dcim8NYOsZlecp7yRhS6yZkub51tzXkkjaTzyh0OQO22tMYmWUsMbU2tEc/hs6SUz70d1cKmHOMLpFuXE7dHA0XMdHPlY2+gDTb4jHy0wYHOCSo/Jxaf+IKG9A90UR9VzphAVY7mDH1XjRjuf+dgR8QhMB+BGCaCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbDYltm8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbDYltm8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F3D1F000E9;
	Thu, 23 Jul 2026 15:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784821847;
	bh=+0WYfJvAb+U5Uh330wr1TsbZeVHUMtw/aA7WAzOxJ2Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nbDYltm8PBaJ0Wn0hH2M3i4LgJy64RdcDjLLElxG6Fu8q12fvRKqQpKEhaDMuBPQF
	 w/mWkkDSk06R+lYcEoq3L+ZCJGo8zg3q3rNOB09SPR27wb6v85vQNAYrYTI4jAzaYa
	 1xKB5elXQfdkFGJad2XqKmnqj13TMNpvkuBHFqcw4WqfSRnlB4CHa6Gxu9G13oHtlp
	 Ic4bZ1FNvv3HwBfhsE9wg+L33/SsEm4Qhqwrc1aVXct5Sk+nciJzXRGWiggQAeRlUq
	 ipkk+PKI/w6jCZ+hEF63ykpiSkUyj3hgRzX0zqYG/Ri+vXCKbHjxeiEv97sCHN5J4n
	 WYcVN32pWql8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7FB393924465;
	Thu, 23 Jul 2026 15:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ipv6: fix dif and sdif mismatch in raw6_icmp_error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178482180715.2436121.5389089467831911039.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 15:50:07 +0000
References: <20260717143230.1836-1-lirongqing@baidu.com>
In-Reply-To: <20260717143230.1836-1-lirongqing@baidu.com>
To: Li@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Rongqing <lirongqing@baidu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 kees@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Jul 2026 22:32:30 +0800 you wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> In raw6_icmp_error(), raw_v6_match() is called with inet6_iif(skb) passed
> to both the 'dif' and 'sdif' arguments. This is a copy-paste or typo error,
> as the last argument should represent the secondary interface index (sdif).
> 
> This mismatch breaks ICMPv6 error handling for IPv6 raw sockets in VRF
> (Virtual Routing and Forwarding) environments. When a raw socket is bound
> to a VRF master device, raw_v6_match() fails to find a match because it is
> not given the correct sdif value, causing the socket to miss relevant
> ICMPv6 error notifications.
> 
> [...]

Here is the summary with links:
  - net: ipv6: fix dif and sdif mismatch in raw6_icmp_error
    https://git.kernel.org/netdev/net/c/440e274da4d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


