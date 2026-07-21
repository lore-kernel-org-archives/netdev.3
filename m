Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857F046E00C
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662251; cv=none; b=Eq7F559kqTkXZZTWrHDTcUsIphA9pzQ27VNpYRRpnVUIuzB7s6tnGZ6ioQ8LOGpZqzKhtLqfrtC2vGFVhG5PsJo9ZDSs6Nq/eOa8JPCMJVJHVaG8Bc4/jv302ntt+73KF994myvizkwTs16PgmYpuI6osgVlrC5bUKPBxknek24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662251; c=relaxed/simple;
	bh=Hxs6jDCQ9l98nCluQ2Kq7au+6sl3m0r3SBygOwOB81Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dzkqgh7UVo+N+4gGZgKJUHB1q6lVw/B49x93aG1vCtWb4+rVZND5o2oPda9VsBhK9hvX3HeW1Pel6fQqMJMZ7Wf0Ciwjp3ZSeNxK0pBYEXi0JDTQB/K74C0WJ/H4ktDT3Wvzo9ojdOsE7CQxcnsfyTPOyMzbbFNlk6CkrtGyWao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzhuFZ8L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzhuFZ8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC8F1F000E9;
	Tue, 21 Jul 2026 19:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662250;
	bh=y6Kb5yuEahOTCgW67RrH1/TG/VjPPZTwZjFwX2zL5kE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dzhuFZ8LP2FVGeUc3/I4MWuOuwpi+iGCJq1Crcaq6WNwWWbaKZWMJjoVJTKyHSTUt
	 tux+8vUBXfSRJt5dCDnOlkGM3icw44QvLVygphRm1lV3wjThmAhaebOmbkRXoaSI9I
	 jvZikaOJOi9KlA8jugJ/HyQqCS1mvkdWcgI7z6K/Kjxec0PU6DIJPbMjNsj50t33wC
	 0B1dDle4UdFe9NzwIQ816+0N3ML3Kq0zjV0avIRtwBbws8UN0zAGGCuwjEXmSHdhFZ
	 NORAM2D9l2l/B19gDYirdYD0NLZTKRv4903FPCk7HExbZOij2jAvnZ1kQM6PZiyK8O
	 m8LWQ4EJwwGHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1996739253FB;
	Tue, 21 Jul 2026 19:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: txgbe: fix FDIR filter leak on remove
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178466221964.987340.17047297402325333190.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 19:30:19 +0000
References: <20260713091911.1614795-1-chenguang.zhao@linux.dev>
In-Reply-To: <20260713091911.1614795-1-chenguang.zhao@linux.dev>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, zhaochenguang@kylinos.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jul 2026 17:19:11 +0800 you wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> Perfect FDIR filters can be added while the interface is down and are
> kept on the software list for later restore. unregister_netdev() only
> calls ndo_stop when the device is up, so txgbe_fdir_filter_exit() in
> txgbe_close() is skipped in that case and the filters are leaked on
> driver remove. Free the filter list from txgbe_remove() as well.
> 
> [...]

Here is the summary with links:
  - [net] net: txgbe: fix FDIR filter leak on remove
    https://git.kernel.org/netdev/net/c/ecaa37826340

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


