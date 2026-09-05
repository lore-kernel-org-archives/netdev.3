Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F5D2D0C89;
	Sat,  5 Sep 2026 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788637874; cv=none; b=UWep3wymJwVkYg1nTYucvelTE3kiokInBG7lXQfyUoWu7GA7oq11emlT2X1ebpIHnNekLEICQ0Qg4HFi9VWMPpQiJMjJpV/tce6P0BKtLrNOU6TKTdDEIZ5E36/9ZwIN6kg4OVKVu0ARThKTdXhgMMp3J9Hp7VU3+myVfr9C23k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788637874; c=relaxed/simple;
	bh=qn0xJDEfFT1GrvPk3pXMAjPhavaJFDRlCyT46KMX7Zg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UTS4yt0p/YTRwJqZYx5KvSvK7+JzLXr5RdRjaFlXYRStxdtXHjjsZZirJajTllzUH0/HOB8iOp1ouraVyYgqPLwgWDdoF9lt1TyZdRrRj1R8VHpfDFAH+RfwyjSps3ouI7WTrFMxJMQ07BkR589DVLAqVIrbx1VVt8Z0b5LdRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuydIPu9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuydIPu9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEDE1F00A3A;
	Sat,  5 Sep 2026 19:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788637872;
	bh=cakoosmI6MZrtMxVw2aZahhr7guh/cgp30K7eecUHHw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AuydIPu9yWcK0W3ufemC8oheCeAQmCLv23NIPh+cDDNblVFGOZ8G501GX8a40RONf
	 QmjVpKQLvGRhRQWNjDtcjShQDTf8UMd2IBN4s7A2Q+J06BgcfEWufr78BUPp/8UkKH
	 IJbKACKqqcFxjzqTfyAVAzf4e+yFECIiVGqMu/ywGsDt82aVMJlKeI1HqkEF5jCS4E
	 A5u/as3b3+duQYx5SWSE7jvhQhOGFHZuJa0sNVW4zl1queTmIQql0BhXeAMZHfFJVP
	 bZjVXCNKgwvGnOh2t7GmCDNCRlYN1agB5/SImmWCgkAVHTZArWzapNaUUyEjs+JSkE
	 Bl4aYJo9woUAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1993D3924FED;
	Sat,  5 Sep 2026 19:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] 8021q: publish vlan_devices_arrays
 entries
 with acquire/release
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178863781263.1335621.4618235712403259404.git-patchwork-notify@kernel.org>
Date: Sat, 05 Sep 2026 19:50:12 +0000
References: <20260902073334.397685-1-ruanjinjie@huawei.com>
In-Reply-To: <20260902073334.397685-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, nb@tipi-net.de, kuniyu@google.com,
 sdf@fomichev.me, liuhangbin@gmail.com, da-x@monatomic.org, jeff@garzik.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 2 Sep 2026 15:33:32 +0800 you wrote:
> Hi all,
> 
> This series fixes a speculative lockless data race in the 8021q
> VLAN receive fast-path, and publish vlan_devices_arrays entries
> with acquire/release for better performance.
> 
> Changes in v3:
> - Fix C=1 sparse warning as Jakub pointed out.
> - Split out from following patch set as Kuniyuki suggested.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] 8021q: Fix data race when publishing vlan net_device pointers
    https://git.kernel.org/netdev/net-next/c/2e9ff7bb668b
  - [net-next,v3,2/2] 8021q: publish vlan_devices_arrays entries with acquire/release
    https://git.kernel.org/netdev/net-next/c/d199b0d0bb01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


