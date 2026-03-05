Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3C426D4C7
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772678439; cv=none; b=b5c2EMPBvGR63B4iVWH/T7fGUYEWmNInEvqP4jLyIvVh8lZzv1i7PiDlA7eYNnynAm1r7/PK1aMtfo4aGRHfXsHuqEJa9bqFY30lisiohaoxud4n9pZd7hPfaNXPz2PPpfzky3vhieid8vp3savUBLzSund4XOq0/I0MohPe6BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772678439; c=relaxed/simple;
	bh=qis77h9KgCvM60NRAUacpF+DrwdWCbnQCF8oFx2N2wA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=At/85mVxoyzvQWLbN4mGLPz6dVzq6+2qKKbNt8LLPI9A7GoCuFMzAsPJEwSHxnuFcIhNarygjQYQtvDrY/TpMq95zJOBEukmQWeCkMReXY0vsbhlaA9CbEynvwCXpJXtwZK6VxquULJb6HETv5dra9UH6gRwPyr9WJGuHVvvtH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJyN57ny; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJyN57ny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0468C4CEF7;
	Thu,  5 Mar 2026 02:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772678438;
	bh=qis77h9KgCvM60NRAUacpF+DrwdWCbnQCF8oFx2N2wA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CJyN57ny5QeCluFOOIBg13njwkgJQ27wo+AtwBVHGVjDbKEZ+4o32MmFOHi7YR1J7
	 xilkMQpFLrmdKINno5AK6qlc2Ni0SzJ/y5+IiVuS+fyvuCls38Wa8NaDiw3Eu4UWqS
	 Kv7uPizBBgXp/FFH8g/v0lcyf3ssfwlO5NCXdBB/2FFv8OPWHPxeN2wlefFpt+7ovH
	 fzjOZ8folwsanxx0zye5HuzySd4FmugKL0X5jZ4tDP4PfpAiYM6WI1uurfCy91wDBe
	 RlPu2Wcctps1+USMiPfulu6zzetMGFS6kPMVn75UIQ11Inh0xi8jPBAfKCZgiFr+gQ
	 DMaXZLucLME7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE7A3808200;
	Thu,  5 Mar 2026 02:40:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: move tcp_do_parse_auth_options() to
 net/ipv4/tcp.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267843904.2487871.16636167961801121236.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 02:40:39 +0000
References: <20260303191243.557245-1-edumazet@google.com>
In-Reply-To: <20260303191243.557245-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Mar 2026 19:12:43 +0000 you wrote:
> tcp_do_parse_auth_options() fast path user is tcp_inbound_hash().
> 
> Move tcp_do_parse_auth_options() right before tcp_inbound_hash()
> so that it can be (auto)inlined by the compiler.
> 
> As a bonus, stack canary is removed from tcp_inbound_hash().
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: move tcp_do_parse_auth_options() to net/ipv4/tcp.c
    https://git.kernel.org/netdev/net-next/c/1d88db16156e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


