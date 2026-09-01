Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF6F47ECCF;
	Tue,  1 Sep 2026 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268866; cv=none; b=WnYD1VdHMwbe0qgE2P7wAD5g2M2Pqg03sbd9ZfWwH8zRSrQ05qjGkJernZQFy4zrdWyZrpaNkJxtV262cLz9uaYmm38f5puLNS2M8QESATzF1LEnZxZ97QsRowclxJwCRUKoQ49xYTqsMj7KuOzGh4nyy2hngMJtTBu9Dp4zOtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268866; c=relaxed/simple;
	bh=2PrHryj8+USEXhYl6c38xd+xOYn2c84IzhlNY7Rrt8I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mh+sJ5neEtf99YcgMEwkBYt05dT+A3cF/kwKOlRUkJ4Qj0alCfOm8Hsbld4V+ggDef5lq/QyGs5js2oRE1ZqVAeAM9DbPasEh8H7Lz/On3hzllFe4eSsVGyrPMdIiBc5GdBWi4qfSggVlJZIVnWTYt6AhS90vWQcfmGK6A1eBDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaXmx65l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaXmx65l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4650B1F000E9;
	Tue,  1 Sep 2026 13:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788268865;
	bh=PwfQOQv5U/H6GNRkfpy1YEGVeZ3AjkwjFuLFTH7wD78=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DaXmx65laaTvfAJWFbH7ngaF5RyTAiwpAwGouhMkbEer5qF7r2FvDC0LrPQqwrE91
	 MuWJi0tbg7YHxb67Svio51ZaAHsx20fXdOWNUdET206jtTcN/Po4LSQvdrDT+A79Je
	 K87XtfE291Jz6s9awaTHNFz0PIuZzYWNqO44RM5xsQ7k1Z96XJdCmZIuQo+ildoM+r
	 E+/3R01ax25fBjysvS5lXP7xEhIRgOBVzwLTup2qR+DBjqOghb2yN801KCFTq4PGCO
	 TED0+aaWpJM3s9HsQRhKzqCJTmTttB035GA4Ih6glbSPwqNQqxWXOPibRHRJuYC2Ml
	 jpMEAUpfG4bpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1989F3924FEF;
	Tue,  1 Sep 2026 13:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: psp: do not inherit the Rx association on clone
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178826880765.1174044.4123277856056435344.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 13:20:07 +0000
References: <BC10EB92-ABB3-41B2-AB16-266BEEBE18C0@doyensec.com>
In-Reply-To: <BC10EB92-ABB3-41B2-AB16-266BEEBE18C0@doyensec.com>
To: Norbert Szetei <norbert@doyensec.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuniyu@google.com,
 pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, daniel.zahka@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 29 Aug 2026 18:56:18 +0200 you wrote:
> sk->psp_assoc sits past sk_dontcopy_end, so sock_copy() copies it into
> every socket accepted from a listener without taking a reference, while
> inet_sock_destruct() puts for every inet socket. psp_twsk_init() does
> refcount_inc() for the timewait socket, so a child closing through
> TIME_WAIT cancels its own put and leaves the association with one
> reference and N timewait sockets holding the same pointer. Closing the
> listener frees it, and the timewait timers then put freed memory.
> 
> [...]

Here is the summary with links:
  - [net] net: psp: do not inherit the Rx association on clone
    https://git.kernel.org/netdev/net/c/1d2929d0850f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


