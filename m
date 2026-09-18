Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C84741A571;
	Fri, 18 Sep 2026 23:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789774873; cv=none; b=ce0D7tEomqtg5A7YCEbdGPv1VnvDIFjKVbxZuVAVXxono4QabmGBV5WpScDL8cyUmq7xpufGhcpuT2IW4zFC79sXMYMlK+5BHOUP74bR58FxhjgR7sChgEM3IuH18KuMk3Pu6+eDkDq2HjaQ6JAuPpfDn0fT0VntZIXSy4DU58I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789774873; c=relaxed/simple;
	bh=lFYIUBuU/nTNgYx/kpR+u3mxkxgZf4kpEbiw3xLJs58=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lOEDVoFhpKp9eDWlVgVymFY24BHe7zb33UEOBa2iLynO9QUxRssjZsM4N/rhR4QlqCsBHK47t7q9WewnT3gjTkTDlPOFvEg7QErIHyHQ9+A8T81CoBw/2X9ELZyFWeQ5GjCJuKHn0PMhtRboDhBOGjnCuXS+f0guAUUgR8EHN1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7k/o+rT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7k/o+rT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E034F1F000FF;
	Fri, 18 Sep 2026 23:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789774871;
	bh=TnctOyKpE5/oxuc1Ps0Qta/8S+5cl5VX9qneGpJ3tbE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=F7k/o+rTci9VtOCyHiSrJ8ncqP7Tt6VIXI4/nBh3Ix71Ew5PdfyBVQ9qA7Cm6ggos
	 QvXHmkLPIp0wdGWhROXISfE4DImRZj4Du5YmXi72wr7hrT990/bY4wlaQFbsx1+agm
	 /ICIC078xN9xoktJ/BcXtM1cJjCBSIwKGV1DOcWthR2CKNb4kuKVXCdPaWp99TzPWm
	 NlR9H9yEvJ2pQkbp5bpEmeWPsFntZYgpsZ6aBTzTP3WylPRTTV1BWrhr/7Dtyp+woz
	 MrDnSXjgEYuNQ0ZJa1rZoIO98P7VUj8QhGKTnagd2QJNGsBCfoR2XyAPGDZMB1klGk
	 LAd1f3Nr9vM7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198C23811977;
	Fri, 18 Sep 2026 23:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: act_ct: don't WARN on benign
 flow_offload_alloc() failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977480490.1188948.5274904800302804627.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 23:40:04 +0000
References: <20260915150816.36487-1-ngocthang2710.1999@gmail.com>
In-Reply-To: <20260915150816.36487-1-ngocthang2710.1999@gmail.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, paulb@mellanox.com, linux-kernel@vger.kernel.org,
 syzbot+6cc37aba98dac721c415@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Sep 2026 22:08:16 +0700 you wrote:
> flow_offload_alloc() returns NULL when the conntrack entry is dying
> (e.g. raced with a conntrack flush) or when the GFP_ATOMIC allocation
> fails; both are expected under load and neither is a kernel bug. This
> path runs from softirq on every committed packet, so with
> panic_on_warn=1 an unprivileged user can panic the box just by racing
> a conntrack flush against a `tc ... action ct commit` classifier.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: act_ct: don't WARN on benign flow_offload_alloc() failure
    https://git.kernel.org/netdev/net/c/47abe7a5c4eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


