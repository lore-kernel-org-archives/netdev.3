Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2AF3F3292;
	Tue, 25 Aug 2026 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651461; cv=none; b=CvrxDVrOcyQA57cEchbHs8GsjU7wK+WvTZFCR4MoGNQ5BQCHGmst/OwUSFK2guUmlRzYBgfE9Rlt1QpxRzhgauWuPF3K1ER7m6x/HXegNcX9matCOHGkCvncx4VDUbEk1+GnsNpmRmtUdMNIbBmUgJ+qOOgYIdYQYQHup3u5cAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651461; c=relaxed/simple;
	bh=G3mmfNdXFDsA8w+3o98zpHTf6zFrb4rb684O+0B7ha8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t/rjjapwKrRLfBt4ev1kfgpELCgOcyymv82Rw24z4YA6rXHKqB8iGcwlcAQlDIy58s7PUvkO8+M+Xwvb5EyZmLvrZ/EV4ksksykT4/LhLVCGDaO6rGGRG2kc64ybPNDVAvjZGSECQv40NY+yFOslmP8EM1TgRSCJ7V2jwJ1/oGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/GcOqio; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/GcOqio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4DE1F000E9;
	Tue, 25 Aug 2026 09:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787651459;
	bh=KuGNbOZ9PRXKj4VPiYPqxxdWybUC4KWW2tZ32/HRLOo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=c/GcOqio8HdlGDlmFXMvUiTm/R6xF/6/QdhS6MnclHKyXdluCxe30nz5ArEi4LZcd
	 ryGutzOl8OwquOS3DByA5r05htpyAooKsEkzsTezinzyVcv9GDEzAvYbdEaNO3hWWy
	 +CLjiQEd71p3Sp8HlyI31G092dRblavN2BGhBZvmct5D6J+2+fzZUm4F1lyR+K069A
	 A6aG/szRpqdLN2mqylO0FGgbJwiCf5kkJcq5YJiIURMTVewXoMWJeIUvt9cj/Gh+YH
	 kPjCOeG2ho0ET82l1UeF2pUsazq4KeZOK3kmBT/lpaPWJh34QgFEOlwFy100LscoUm
	 qZnITmkNkkasw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B9A3924A7A;
	Tue, 25 Aug 2026 09:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 1/2] net: core: check skb_frags_readable before
 uncloning in skb_copy_ubufs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178765140614.3359754.9513103982415965156.git-patchwork-notify@kernel.org>
Date: Tue, 25 Aug 2026 09:50:06 +0000
References: <20260823183602.1051453-1-almasrymina@google.com>
In-Reply-To: <20260823183602.1051453-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: kuba@kernel.org, kaiyuanz@google.com, willemb@google.com,
 edumazet@google.com, zoltan.kiss@citrix.com, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 horms@kernel.org, kerneljasonxing@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 23 Aug 2026 18:36:01 +0000 you wrote:
> skb_copy_ubufs drops clones and modifies the SKB via pskb_expand_head()
> before checking for !skb_frags_readable(skb). This alters the SKB
> geometry prior to throwing an -EFAULT on an invalid SKB. Check
> readability first.
> 
> Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
> 
> [...]

Here is the summary with links:
  - [net,v1,1/2] net: core: check skb_frags_readable before uncloning in skb_copy_ubufs
    https://git.kernel.org/netdev/net/c/00e11ee9831b
  - [net,v1,2/2] net: core: fix head-page leak in skb_zerocopy
    https://git.kernel.org/netdev/net/c/97148bcb7511

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


