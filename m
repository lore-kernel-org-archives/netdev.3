Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510612;
	b=JFW2ogLsmmB2TTONud8eCHucv4B95rwrolkTeZmsHx5MOwzweQv6Lq243VYzhvy3G5wD
	 wULgYaAkbyuIHC7NB18mTmgYtYEYKv3+eRMG7MB6/5Zvdoic6hgzo5K5eNbzywAyf3v+7
	 pX1KQBlxxfmtrPXZ02HewH+krVchbnId+No1LnHkvKwynl//rzAucgeYK8PA6T/1BGHOs
	 8TZcJfjjgQzcExKaRLBMt0e/D1mktzTDsnBx6TDV6q+G3Zxpwor9UnPFnqyMGmKo8qwTp
	 yXO0LlFiWs1R5p/VnUGwIiY5kUs4Ie3omTgyIdgJDcqA//OBA+QuYWFn2MpfgB1dDvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510612;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=0/wRb0QkrCnpP/cVCpQ/2KgkiapnxUmfzZNvLjxejRw=;
	b=fAdVLthOq5AfC0uk0HZPDt3xCn79sxKI1rktZT2XwLikjTAhm1gDHuR3YLxyCO4j6CKc
	 mv3DIG24ziBg1E9KscBul+AciFi/RDgx+ITLVA3iANKOZCnIT/6WQwZf9ftaVBkdtpFL0
	 izoWRQhbKcGKQZ2FCjsixgGghPxrtl82HZuQI+jx36N9tILUIEuTsN7K6YnDThGziN2n/
	 3L1stFeZSRc9fiMlZtE0M/CrM6mqY+f8QsbBkT+/ovDwwP9LboyhQ1scIjTSyEiCik91C
	 LbfAskaA+dh28owSgP45vf6mmjZdK5ZSQsL5pX824i0bsh8OgLI0X7G9GupgVLfQT4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nLZUkaRD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7251E60A260B
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nLZUkaRD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450E71F000C5;
	Thu, 12 Nov 2026 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510612;
	bh=0/wRb0QkrCnpP/cVCpQ/2KgkiapnxUmfzZNvLjxejRw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nLZUkaRDwTxJciXRHkKbmJlzw786NyZwzt/uMpqEbfLy3/MIWbxDW89DcsOqJTOwz
	 MZjbvCKnyCyUu3dk8dgVl8bY4LrNQD5WDf+Fr+kmhKdbwgo2cmx2ixab0hHMfMF+DR
	 AgI3pifcOjOxATigKSiiLswLrn472KnRjSRCDLSQvCaxeWGk0I5WGkZRABSC4x7aDb
	 zAvBZ03xMjjhMOGg+mY93JEZDivQTPGv5TqWkRY3dSOAvh6zWCACCktMQ1NPuKbq9x
	 zAivNPghICDPRfWcnXVDBhyah+JvbDZripUcwLE2fqpx46NOxVdNDEyBEpW4+7OfK6
	 yTsvZ6dENapuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A36C3924A5F;
	Thu, 12 Nov 2026 19:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/15] batman-adv: mcast: explicitly initialize
 mcast.num_want_all_rtr{4,6)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179451061077.599290.18211748615272269475.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 19:10:10 +0000
References: <20261111102729.2096241-2-sw@simonwunderlich.de>
In-Reply-To: <20261111102729.2096241-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org,
 linus.luessing@c0d3.blue

Hello:

This series was applied to netdev/net-next.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Wed, 11 Nov 2026 11:27:15 +0100 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> All mcast.num_want_all_* are initialized in batadv_mesh_init_late() - with
> the exception of mcast.num_want_all_rtr4 + mcast.num_want_all_rtr6. At the
> moment, it works because atomic_set just initializes it to 0 and the netdev
> private data is already set to 0 before being passed to .ndo_init.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] batman-adv: mcast: explicitly initialize mcast.num_want_all_rtr{4,6)
    https://git.kernel.org/netdev/net-next/c/9efd82f6805d
  - [net-next,02/15] batman-adv: mcast: explicitly initialize mcast.want_all_rtr{4,6}_list
    https://git.kernel.org/netdev/net-next/c/ec14a473ec1c
  - [net-next,03/15] batman-adv: uapi: add note/clarification on access of reserved bytes/bits
    https://git.kernel.org/netdev/net-next/c/50d3cce980fb
  - [net-next,04/15] batman-adv: avoid torn u64 counter reads on 32-bit systems
    https://git.kernel.org/netdev/net-next/c/82c663800f4c
  - [net-next,05/15] batman-adv: bat_v: initialize last_unicast_tx on neighbor creation
    https://git.kernel.org/netdev/net-next/c/b844a1f97194
  - [net-next,06/15] batman-adv: dat: annotate last_update with READ/WRITE_ONCE
    https://git.kernel.org/netdev/net-next/c/0ca317f5194d
  - [net-next,07/15] batman-adv: bla: avoid negative reported BATADV_ATTR_LAST_SEEN_MSECS
    https://git.kernel.org/netdev/net-next/c/53a21998ad66
  - [net-next,08/15] batman-adv: tt: annotate last_seen with READ/WRITE_ONCE
    https://git.kernel.org/netdev/net-next/c/a063d1749de1
  - [net-next,09/15] batman-adv: annotate originator last_seen with READ/WRITE_ONCE
    https://git.kernel.org/netdev/net-next/c/d4b4b01b5f37
  - [net-next,10/15] batman-adv: annotate neigh_node last_seen with READ/WRITE_ONCE
    https://git.kernel.org/netdev/net-next/c/45d1474790e4
  - [net-next,11/15] batman-adv: annotate hardif_neigh_node last_seen with READ/WRITE_ONCE
    https://git.kernel.org/netdev/net-next/c/150e85d113fd
  - [net-next,12/15] batman-adv: use matching return types for bool and void functions
    https://git.kernel.org/netdev/net-next/c/2daee4a0d81e
  - [net-next,13/15] batman-adv: mark read-only MAC address parameters as const
    https://git.kernel.org/netdev/net-next/c/c58558f8998f
  - [net-next,14/15] batman-adv: use bool for boolean flags
    https://git.kernel.org/netdev/net-next/c/0f97847fdd1c
  - [net-next,15/15] batman-adv: mcast: document the value stored in is_routable
    https://git.kernel.org/netdev/net-next/c/d5c0415dfb58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


