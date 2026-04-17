Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B0A2DFA3A;
	Fri, 17 Apr 2026 02:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776391842; cv=none; b=gie4bYqkY7uZSWziJrk3jRhsEc/onQHdHKKCiqRw4kgXv3Do0zKMV+03bUFJjGcMwY92tuBfbGR5WBwwORV/KHnP4XlvuoIITE50z4rRLXooLyo73LFZGmp5MeghXyNMZKKsRvtsmkZNGgCg56WrNwy7NPzSj9OzF3Kpg68Pefc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776391842; c=relaxed/simple;
	bh=T1XALWWfSIrCYQ5sqMz7Z7+GFZv3Ws66TpEvVbhY3Ds=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V2fcD9dXlSMgKBESuNJa3+21RSPy/vV/xih+9D8gTDvK63cr+y/kZJ4awSN9BlODQ5OLCPeyMsTtBAQAFvddyldyDG+yANokX7EhkyEhhikVrr+zzxV7Md6TNqlzBMCQU5tvmmkNPmi3PRU7HymejQtt5QxaOSRQ7Xh37hsHANE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYiRgBHR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYiRgBHR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD56C2BCB3;
	Fri, 17 Apr 2026 02:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776391841;
	bh=T1XALWWfSIrCYQ5sqMz7Z7+GFZv3Ws66TpEvVbhY3Ds=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dYiRgBHRdPAUbch38F4K5GEINgHdonjY+fIfPyNajENzE6mQV2TsQn5lcYfUqkdwF
	 bZx3GPPhROs77h7vXij9jyfVmk63FaUHHhRA4n+HbKfCb+EKZx2mNe6F/ON1lDGxy9
	 MFdUEl4td3HwTUW6M3yszT8G+bzDAviI5EM40TDw2pMcQuOFV5HBIJga35219JWbeO
	 bYJIF1XgE3+/jRMGClw9IlNoQP3hFT803WSVD6vM5ThWBYd/EuXvbEmfHfMF4nOatc
	 vzDKHwS+cwkSEfqL+/rC1VwLGRXcjJC1Pr8fA29+4m/Xhk3v0D4g2Ekxdo4WOpN5DQ
	 txPAn+Ek/pkfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CD5380AA76;
	Fri, 17 Apr 2026 02:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: taprio: fix use-after-free in
 advance_sched() on schedule switch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177639180954.3482475.2509573482616413449.git-patchwork-notify@kernel.org>
Date: Fri, 17 Apr 2026 02:10:09 +0000
References: 
 <20260410-taprio-user-after-free-fix-net-v1-1-0931b1579988@intel.com>
In-Reply-To: 
 <20260410-taprio-user-after-free-fix-net-v1-1-0931b1579988@intel.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: vladimir.oltean@nxp.com, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 qjx1298677004@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Apr 2026 18:57:57 -0700 you wrote:
> In advance_sched(), when should_change_schedules() returns true,
> switch_schedules() is called to promote the admin schedule to oper.
> switch_schedules() queues the old oper schedule for RCU freeing via
> call_rcu(), but 'next' still points into an entry of the old oper
> schedule. The subsequent 'next->end_time = end_time' and
> rcu_assign_pointer(q->current_entry, next) are use-after-free.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: taprio: fix use-after-free in advance_sched() on schedule switch
    https://git.kernel.org/netdev/net/c/105425b1969c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


