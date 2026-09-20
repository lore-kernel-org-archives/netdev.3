Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052CF175A80;
	Sun, 20 Sep 2026 00:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789864276; cv=none; b=kmU7G1JD+LN/4BQyxPASWjimOvshQ2Jc9w7kK4gH0b9QKPVMvq3IU5n3l5+irg5+Bev0J4y73hz5pv+H8NV45TrN+vWB5ytQM3719dJtJDWB+ncGVY/nPrQpfqwFMzeMkVdZrK0tBbdpDl8ulqQO2htPgL/rwdGQjQMcY62dH+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789864276; c=relaxed/simple;
	bh=NhO6LjNGNPTBSAX0zBbauy3pJv0ikbNT554kyVvd7AQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o8Hk05m5ghJ4xJP5qes0WeIFBHadPaAswxXN/0WtiYj1ZBAAFf8nR+e46yW0ECeljE+stA/3ago50AsXmhkqxK7UXhuyS/JGm9UqFP5DKdcnHkHMp0iaVcdUahAoZThdk68ULvB3ctLbE/IU4dvxHmiOuzeo7PuPj62XrRChl24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrWgrByL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrWgrByL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A889F1F000FF;
	Sun, 20 Sep 2026 00:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789864274;
	bh=EVl4oQboWwEQhZhW9ZTUruk6/S74ZR2/BAj/sNR2CU4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CrWgrByL/o10HAyBXQeD6LsJ+VsFxo5vD4VB8VYWBLmn5yoRdA4naMYRVovlURQj6
	 SA0FZXwr13CMRGaBlqz8yXyq0dTds6Ehoy6cI1Pn5GAGhBwUzlRSgLGeTbh5pW3jY6
	 bP307Q62LIdvgPhKTpE4gM3EP+o2m212t5dkEYfbjegf4YI+nbA6bXuJPANvE8NW/H
	 GQZEAem8zwJ7OxtMshxLvC5MJaTbvVE0lLeImLlkAWPcZDsJ7xVLdK+rUG4LN6T6A1
	 CL+vR9w55Z9zarQ6Xv6pCT6zI6omxACMIjfYXeR8oYt4tUmKZ6oL71eDhCrdVjDOtp
	 PVKknVSXRkTOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AAF3924A47;
	Sun, 20 Sep 2026 00:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] net: gro_cells: add drop reasons to
 gro_cells_receive()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178986420690.1502569.3136807848474973558.git-patchwork-notify@kernel.org>
Date: Sun, 20 Sep 2026 00:30:06 +0000
References: <20260916091420.138170-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260916091420.138170-1-xuanqiang.luo@linux.dev>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de,
 dongchenchen2@huawei.com, dsahern@kernel.org, luoxuanqiang@kylinos.cn,
 kees@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 17:14:20 +0800 you wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> gro_cells_receive() reports SKB_DROP_REASON_NOT_SPECIFIED when the device
> is down or the GRO cell queue length exceeds max_backlog.
> 
> Pass SKB_DROP_REASON_DEV_READY and SKB_DROP_REASON_CPU_BACKLOG to
> kfree_skb_reason() for these two cases, respectively.
> 
> [...]

Here is the summary with links:
  - [net-next,v1] net: gro_cells: add drop reasons to gro_cells_receive()
    https://git.kernel.org/netdev/net-next/c/a907a89ff105

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


