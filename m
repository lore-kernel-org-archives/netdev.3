Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8B231AABF
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 02:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329402; cv=none; b=pPU61xC96lhGOBJRGdLyNkYGCYv4CFQw5+dd6AIvmjSwftfcFOvPldJWWL4IASkWcoTba/paFZs8ZlhAnrZXugShwjJCKO00WG24LSxK7y5JbeqyS5ZI7znmcDh/tF3ea4hfAXW2hCTHaOlyK6bwNiRjT+oqRanptTPgCKDQ1/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329402; c=relaxed/simple;
	bh=gebvxyTj94tPXhhf7DouQ5gfFQnZoHMQt55YObU840s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uB4p+hFMyOBrI/2qIitMvrR/8Gndl+KhC5+drmsnw5W9OPCH4GUwjSqOqClHa0qsX+E6iuV/7h1IB9B9VPkB9t27s8+Rz42VAQgT9cA6YuPqupepRh6mK9BBPXwXxgcmZUMoPZ7NHn47HZ2TYP5XrlrINnUhvvOIH8z6zX9p9h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zjsrei1P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zjsrei1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49CB1F000E9;
	Thu, 21 May 2026 02:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329400;
	bh=8ZIGQfaD3up/dd4RGyyFeS/pQhQv4d9fQPwy6K0YbWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Zjsrei1Pqz9d+bdIVULJDf7hPGavonrz7UKkC9b7pHrMsAEseMb7j8i+gJNZaSebt
	 0HbmlHxw5LHcbWKcuYjTsdJeShF6mjUNS/wDYBiMMAZneN0+3UpvKkKOnVeslL91gU
	 uaKpmvIMzYpD3oEKtS1N4AoOYAe6hfxzzVIyaIDEp6p7awTqvQ3fKP2EplsKapbAsI
	 2SYbDgzFoYfU1sn4/PRy35Ftxxt/iy8Wb02z9wCtQRXldQXqU09W8sBAonZbRaWdgE
	 VLopiRYRTuduZ1OZFUgQKqsjTZBM6BuX+987kPSt52WlLNWCgBPY1Ms2CyrVyImV0o
	 FDZc4XGh6DR9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568C03930C38;
	Thu, 21 May 2026 02:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv4: icmp: reject broadcast/multicast routes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932941088.3832404.2328947002788399099.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 02:10:10 +0000
References: <20260519200836.4141061-1-edumazet@google.com>
In-Reply-To: <20260519200836.4141061-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzbot+c13a57c2639c2c0d03a6@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 20:08:36 +0000 you wrote:
> syzbot was able to trigger ip_rt_bug() in a loop, using an IPv4 packet
> with a crafted IPOPT_SSRR option:
> 
>   options: ipv4_options {
>     options: array[ipv4_option] {
>       union ipv4_option {
>         ssrr: ipv4_option_route[IPOPT_SSRR] {
>          type: const = 0x89 (1 bytes)
>          length: len = 0x7 (1 bytes)
>          pointer: int8 = 0xa2 (1 bytes)
>          data: array[ipv4_addr] {
>            union ipv4_addr {
>              broadcast: const = 0xffffffff (4 bytes)
>            }
>          }
>        }
>      }
> 
> [...]

Here is the summary with links:
  - [net] ipv4: icmp: reject broadcast/multicast routes
    https://git.kernel.org/netdev/net/c/7eb72c1e3984

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


