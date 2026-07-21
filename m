Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102EE444700;
	Tue, 21 Jul 2026 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628045; cv=none; b=MkN7ohDyLtlnNA7w6nW8O/U9ndaOV6bVO9O0pAhPsmvXo4yTxh+J3FCTvi7tjiK5kXHG/LK5vocd+BnMxbs7B8/krsrbrto/jUaFVOo78Gq2RLiHJmtodzDccRDwjlkFXjNDb1sTPG+uI4JASRAkLzKln79+X83+FQy2uSeI/2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628045; c=relaxed/simple;
	bh=QMg9IN7yeYRxlCrLiWxY2XPOhOBFXWwZyTZXOkqRtjM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dYFHYoYDUAA3TQDaD9sBnvcCcUIMG9tMTWY7WJTaQBqsb7SoSR8pUm+354LMN6gE+BMkE+OQsh/CqpP3z2b2ljeusPncFp05gXYu5Ss1tkSiLyICK1rn4WfjTA026a8tes25NU6I73NEctWpR1Xg/LiXb9kKPtYiFevXu/yYGtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+cLTBUU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+cLTBUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934201F000E9;
	Tue, 21 Jul 2026 10:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784628043;
	bh=k9z3a2U36wFTjnJeZbswelF2Vavb9L3CTpDqqN4n+VI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=R+cLTBUUn1SAMSLW0eK8l+6oKuazY3m8cfiNhOrf0D4v2+8cN1ubqyvYozfs+WHCQ
	 /U90XmMlVv5xpgPH/lvrlRPYaw+iTjRO3evNUWmOqha/aglO8cbEYI7mlK5Kmv/Lo1
	 gYxmnWiS+uxAkyTGHdKQdYi/KVw52bQpxuRUeYYdKzvBwf+rM/72fTWhkN/qOw6aNT
	 +Aay5IqJtutwHRXnUNqKNSDbT2V8cYKoFnb4iXNTsaB2qrJBw4KVCTegmwlFE/rQkp
	 R/gIXWXq7lP770YhUouIx0vcpHtCIl8iu7nxvxTE5zCDWnq506K/WukGQbVDnKOZgR
	 25dvbfYIAuapw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938CE3924A5D;
	Tue, 21 Jul 2026 10:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] ipv4: update rt_flush_dev() and two
 dst.dev
 readers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178462801320.197248.14976916852856571721.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 10:00:13 +0000
References: <20260708060537.17188-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260708060537.17188-1-xuanqiang.luo@linux.dev>
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  8 Jul 2026 14:05:35 +0800 you wrote:
> From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
> 
> Patch 1 makes the rt_flush_dev() write to rt->dst.dev use
> rcu_assign_pointer(), matching the existing dst_dev_rcu() readers.
> 
> Patch 2 makes ip_rt_send_redirect() and ip_rt_get_source() use one
> dst.dev snapshot throughout each operation, so a concurrent rt_flush_dev()
> update cannot make them use values from two devices.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] ipv4: use rcu_assign_pointer() in rt_flush_dev()
    https://git.kernel.org/netdev/net-next/c/1469773b246a
  - [net-next,v3,2/2] ipv4: snapshot dst.dev in ip_rt_send_redirect() and ip_rt_get_source()
    https://git.kernel.org/netdev/net-next/c/7804eaa057fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


