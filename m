Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6312C3AE1B4
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471872; cv=none; b=Knp6oKQvws/UhOD0QrKK7900ksSDTK4XARwMtn9VVVIugc3uF5+1OE/UtxzHai61rOEEM3kFqFR5pW+8IJBzpeGvYOh6x59OjKVAXPA04YeJMIHWvj7580ekb4PNTtznZj9R8i3tRd9aAZEXGUZzD1ek/rD45B5DqwLepaL4whs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471872; c=relaxed/simple;
	bh=2Ob8ULWhGpzPdB5MqlOgkoH8FF/O+8NTAEYRw/hs0Jw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l0xQiHDIievmLJ0bMWfqQH3S6mKSOGHO095qkpJsj5kTBaMskoPOKQpMXleiH26yU2ku2c+Evy5IT9KLcA7ypDKR3Ce3FGeW7o5v0YD0KxmElXehzQjvPArRdGcRWGHkol4fWjuqLkD1juwpMMyIZkYu5xfbyhaadUAiRSMWMBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hxkt2xQk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hxkt2xQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44D21F00893;
	Tue, 15 Sep 2026 11:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471870;
	bh=cdwIB5Hqrhp2EACG+Xdj2ZOwb1wZ/zc85hK4KF/i/fw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Hxkt2xQkCpt7h+jaAesIlM2ZMXPtWSUWedY7jwEJw5+UbLl8zeDyKaxRbNEbw7rye
	 8IImBm6QPQijnKSwvx/gnCn6uFFlEMJ/KB032vT+u9Yq9VWaUXrYAT9m59iE1QC7j4
	 4wfBSQz5VNQLDxEHj8KkkzbHMzhEDzuzEOSrHLo04mLKPBDDYxHXJrKwjPB5tjB3na
	 hR/G6hwebc7pQrsOZcPSvDwG9S0k9zVIctEfh3vychXG4WnLMwS3lfraX/odDIaCl8
	 AL0itshKxwpUk1vIe+9h9+aNxzrl5C6uZJZdShc3Vd7ao3nRxvXzbD4RWwStFb53Fj
	 a3Oo5eTrAdMmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09123926385;
	Tue, 15 Sep 2026 11:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/7] ip_tunnel: Support per-netns device
 unregistration.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178947180563.1533227.4866453860583500378.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 11:30:05 +0000
References: <20260912230043.2586313-1-kuniyu@google.com>
In-Reply-To: <20260912230043.2586313-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 12 Sep 2026 23:00:26 +0000 you wrote:
> Patch 1 - 3 are prep patches to unlink ip_tunnel device from
> the hash table in ip_tunnel_dellink() only.
> 
> Patch 4 removes ip_tunnel_del() from ip_tunnel_uninit() to
> ip_tunnel_dellink().
> 
> Patch 5 & 6 adds mutex to protect the per-netns hash table.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/7] ipmr: Call ->dellink() to remove DVMRP tunnel device.
    https://git.kernel.org/netdev/net-next/c/578fefdbbdaf
  - [v3,net-next,2/7] ip_tunnel: Set itn->fb_tunnel_dev to NULL in ip_tunnel_delete_net().
    https://git.kernel.org/netdev/net-next/c/0239bd767b3a
  - [v3,net-next,3/7] ip_tunnel: Don't pass rtnl_link_ops to ip_tunnel_delete_net().
    https://git.kernel.org/netdev/net-next/c/7ba090b04ab8
  - [v3,net-next,4/7] ip_tunnel: Centralise ip_tunnel_del() to ip_tunnel_dellink().
    https://git.kernel.org/netdev/net-next/c/e53013fe10c2
  - [v3,net-next,5/7] ip_tunnel: Unify error paths in ip_tunnel_newlink() and ip_tunnel_changelink().
    https://git.kernel.org/netdev/net-next/c/6faf19060bd0
  - [v3,net-next,6/7] ip_tunnel: Protect ip_tunnel_net.tunnels[] with mutex.
    https://git.kernel.org/netdev/net-next/c/6724a7baf149
  - [v3,net-next,7/7] ip_tunnel: Support per-netns device unregistration.
    https://git.kernel.org/netdev/net-next/c/8f3c72420257

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


