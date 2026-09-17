Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157474E2F2F;
	Thu, 17 Sep 2026 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651896; cv=none; b=fSqqxppXVXEkGpl/B/mfqEJQt1/gpBtv75Pb4MvrNKyshaN9uJY7+wt08wH88bvCRh5kJvnTaFYjVRE+NuskLepohLVKhEh1J4gv6OFMWLaArjjAnFVc8+WCtEegcnuc0cssMjDmhZygw1vPYks9XiAsIwJn5sucKIM09YWa6Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651896; c=relaxed/simple;
	bh=i5uaSfZYqlS11eYJVyqCN9B5ccyOW07hnRC8OC1Bnzg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lKSGyV5FBFXX+tRGnzDveZ0IRKueXw2OxY5giYcTrAPVCrIoVAOwPsswPjawjawY9vNeBbLUkuAAWnTySqnsKJMPn5mM9+Pl/C8tKXRUAju5plcze7EnZYpd2oy3ejD9MxKC4lTtNzZ2KIcWFESQmK8eLexAiUR+Nu+TD39LAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQiUWzP4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQiUWzP4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EE61F00893;
	Thu, 17 Sep 2026 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789651889;
	bh=iV41gm6PLDRfgNm3s3my3eM4HlRSjdmg/UlK/6kwJyE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hQiUWzP4lmsIf7J8NZFlb658gqr5bTiX7JXaxhP1Pc2rnC4Kh6TuloYaJUJ9zkPGV
	 UzSLthpwjErBqO6CP6nbl5lOoFwtVM+Zb/jFx53LD3xDdw7llD1kq2FuulK8hiegfM
	 mBdAydaH/q4pZPlOfHwea1OMNNDnb2U1wCYkZLCK64BgfsBayebVIy/ZMRl2heyvHi
	 wwp9oH1cIZhRIXmWQ4DbfG0zdKla8ocZMxpYTnlBvmgaB4Q6dqUapt2oydFWA3xBxS
	 TXYZp6OkxlBsk41rX2tFlS0lhEOiGob/sIk7AkqnuWqTeB0cmxyDpQKv1Vm8eubRU6
	 ShTTalBIkRn9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B033811957;
	Thu, 17 Sep 2026 13:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] ipv6: make IPV6_FREEBIND and IPV6_TRANSPARENT
 setsockopt lockless
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178965182237.3645898.15101514552764203031.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 13:30:22 +0000
References: <20260912134040.215664-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260912134040.215664-1-xuanqiang.luo@linux.dev>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, edumazet@google.com, dsahern@kernel.org,
 idosch@nvidia.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, luoxuanqiang@kylinos.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 12 Sep 2026 21:40:40 +0800 you wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> IPV6_FREEBIND and IPV6_TRANSPARENT still take the socket lock despite
> using inet_assign_bit() to update the flags shared with IP_FREEBIND
> and IP_TRANSPARENT. IPv6 TCP and UDP sockets can already update these
> flags without the lock through the corresponding SOL_IP options.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ipv6: make IPV6_FREEBIND and IPV6_TRANSPARENT setsockopt lockless
    https://git.kernel.org/netdev/net-next/c/546f109fdbbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


