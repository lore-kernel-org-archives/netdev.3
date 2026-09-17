Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954842D0617
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 00:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789606272; cv=none; b=np8LLoCRMAwOVSmIZM34k8wCHckXXK+Gc0TH7pBotb8AWBDg3esYGJY4jqXQ76UzSCRqElLg6ke+I0ZvX8dkDwSmoyJKx98VmwgauzUlzeTDMmI+m/2NbEgwHICxZVw2KdY22+zlkBC7dyfDv2ncWSSljUcMyx+UV2hwKmP5JXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789606272; c=relaxed/simple;
	bh=15dBIkNJcEFCiem+HqEDPqGx1nbDSobxDUut4EpJjc8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tbGiZwVVvDf+rgHQUpkqY0y9FlNpperEuIDMYI1g0KfBSof8X9RYO4AqL6q4VeLU3tIncdmFZjJRw9nGc2t08/mbSKscxh5ZTEIZbv8DLcAmde6TpJHkiZMpX4bmih/ZmlnlU7jM7LokJjI2CR+ak4jjyQN+Yu4/04FpCO+wYS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDLK/I8p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDLK/I8p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A12E1F00893;
	Thu, 17 Sep 2026 00:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789606271;
	bh=PFSdFKQUnoNfR9fHSuRfdAzj5hImFJOVMfGf6oGqpvs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iDLK/I8pBttF9yfp858uqYqvNlZxr43Waz42HVGZajEuXXvGzaosy7dVYhKTfRqmO
	 r6vZmW8v+ntBdsEwrK3lMAnmuB+FzTJ3RZ8i1OpvmPN6n86fV0aRTKCaxMURRPO9gD
	 EzJFASVk2fEgpjc6c5/P/YHpHx+hra0lE04CvZBp14Gwf1+zPF/aGOSrY7fIyG5zPa
	 L8BSHmCDVy4HMomPq+8nuGVYRC8bJSgHqDRX+tQgKppUh7kfS9ePhPNPurxexzZ46l
	 KK0+DBpFTbiK7sXUkGi/EJsbsaEN18hPzsx7TFdffl452bCkXPNsuijtQC3xRLNGPn
	 ddk8E9U7Gzz0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 937D039E9601;
	Thu, 17 Sep 2026 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: lock the socket in sock_gettstamp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178960620516.3357310.2759339527077267245.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 00:50:05 +0000
References: <20260915043055.3441600-1-edumazet@google.com>
In-Reply-To: <20260915043055.3441600-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jwlee2217@gmail.com,
 qw3rtyp0@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Sep 2026 04:30:54 +0000 you wrote:
> sk->sk_flags must only be changed while holding the socket lock,
> because sock_set_flag() and sock_reset_flag() use non atomic
> operations (__set_bit() and __clear_bit()).
> 
> sock_gettstamp() is one of the last places where a bit of sk->sk_flags
> is changed from a syscall without owning the socket lock, through
> sock_enable_timestamp(sk, SOCK_TIMESTAMP).
> 
> [...]

Here is the summary with links:
  - [net] net: lock the socket in sock_gettstamp()
    https://git.kernel.org/netdev/net/c/9ed55f3dbef4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


