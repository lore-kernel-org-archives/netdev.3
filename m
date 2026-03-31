Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DA228727D;
	Tue, 31 Mar 2026 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774917623; cv=none; b=dS0KJNHjh38+h66zaCxBjJvYU5avjWYRITkzOFZCbdqnauSMXU6ChC/tSEtw8PWdKrd2iBeEViM0R4msnB7wdsEP+IVrSvSXDTBfJX+Oik/osjtcE+pp2Q96ovt9bAD7V1ecCq80IpyntFRN0b9SLP4DaNrM+4o3zWYTE8ewa1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774917623; c=relaxed/simple;
	bh=YP3+hNUq+Nu+rrNQH3mxpsUfk41MmwADEDI/aTwd2vo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GVQ6iDPOQKx2K/8Pmmdo+P23OxjEWizDFFuMuKS9wjoKn+dxWvLnWPlm3dbJVoI3HOgkC9ieRZN08ShRFpzBYKHwxQSWP+yR6L7uvWGC08edMlqx2I7Tk9aeQ/7NTV0dIgsTrYl32gLqh/d18Xnzn3gZ+KD/YPycxm/gbAB5uIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/Q0c2Ba; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/Q0c2Ba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98890C4CEF7;
	Tue, 31 Mar 2026 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774917623;
	bh=YP3+hNUq+Nu+rrNQH3mxpsUfk41MmwADEDI/aTwd2vo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s/Q0c2BabcpahstSseJGDP7oiCxSbsNWvtobCbZpFLHweUlgMK4sOBIWFXkerPwAw
	 i+6fX7jF4sllaqaEC6nqwfJDyTZCejBqJ+wQ9PhNwbM2GLt8z2CoEI2EJRxkZKgJmt
	 v7R0P4FERfPn87+5b4fp9VHu5rMdDc/aWj4O3OiNhQ9QCqRzdTvjXglhocM9dh15Zt
	 AXURgamUa7nKE93dsIcPfOqm7RSJLM9WLPT9aPNPSzGy3Qc67URO/3gHrZ/8evnPND
	 93Ary04ptadl7B25+Chgv7S9hc/CEzYaO8fEkEHLIVO4ylIoRWeJ3T7eIvGP74AclL
	 cylclgbbFOtLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E2D392FF85;
	Tue, 31 Mar 2026 00:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v7] net: use skb_header_pointer() for TCPv4 GSO
 frag_off
 check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177491760753.2032642.18276185751372950060.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 00:40:07 +0000
References: <20260327153507.39742-1-yss2813483011xxl@gmail.com>
In-Reply-To: <20260327153507.39742-1-yss2813483011xxl@gmail.com>
To: Guoyu Su <yss2813483011xxl@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 horms@kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com,
 syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Mar 2026 23:35:07 +0800 you wrote:
> Syzbot reported a KMSAN uninit-value warning in gso_features_check()
> called from netif_skb_features() [1].
> 
> gso_features_check() reads iph->frag_off to decide whether to clear
> mangleid_features. Accessing the IPv4 header via ip_hdr()/inner_ip_hdr()
> can rely on skb header offsets that are not always safe for direct
> dereference on packets injected from PF_PACKET paths.
> 
> [...]

Here is the summary with links:
  - [net,v7] net: use skb_header_pointer() for TCPv4 GSO frag_off check
    https://git.kernel.org/netdev/net/c/ddc748a391dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


