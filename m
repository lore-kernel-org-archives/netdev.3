Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9529A385D90
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252672; cv=none; b=HgDi4/QLBXlVkpu7CKu2C7SWnZmFVVceTezppCKUTFK8HO9pM3FwDYm1XrlVA+I5DhrE8y+cLrTECD0pt5ZQqTYyFFn6gCdH+gfqHCif+bYw4JH1xI9TLKV6IjENcJy7tQrXlZg5XarkUyKGd8CZ9VLh9oP/rE1rNQx9HxdJ3p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252672; c=relaxed/simple;
	bh=kRF+XTm0Y29DJA6L0FmlFFVu41s0e6vH4LIddvKF+CY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BrXqx3GAEU0qkwKkdQ8YC633BfA1A2ONm2WvKyEbbQZiVhWVBePVvrcCcy28RZRqUm3Kx648asxLdbs8yN3wlXqClICkcPzmte97hU8RiJ53lx3ONUq0514S0mKyKim0MjwCkk18CwFHZvuZpigGoy006N4kmqrhKBcdXifnfZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRfnvKM6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRfnvKM6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3A81F000E9;
	Tue,  1 Sep 2026 08:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788252671;
	bh=ptkyV63gWnjxXlNGWyt/4NSmr1e3rMOtDfJCJoxXQ30=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WRfnvKM6eIMXula5Q7C17JMBQ60QvKKhuyH9M/awWF6JcrNVnJEcpQ+3Gb18j3mJj
	 EYMKqL0o60FhJs3Dm99yZ+Pw4pFpPKjWnXMLIguyTkQNvDTRP+JsGYjzJL4odgqCwy
	 yLQBJd1qSHvGU2UIjHVsqTgvlelMU6VuPWyt2GfBwO+eOadDxje8ui2CPO/7cONWcT
	 5fIdl5EhBfhFXqbHcJjnohsGAr/XytKnAbWthwRGi13rTZZv0gMR6V5QKsSe48AVZ+
	 GSF9Usn0TGRA0/u5AkSzBRVRl1jBH8DC3vlwvWBLPHvAU66tzctVAWVsnBNi2+i2/4
	 ESpoRjws2a6CQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198333924FC7;
	Tue,  1 Sep 2026 08:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] af_packet: Don't cast tpacket_hdr.tp_len to int in
 tpacket_parse_header().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178825261387.1041503.18296517355721988030.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 08:50:13 +0000
References: <20260830180915.260225-1-kuniyu@google.com>
In-Reply-To: <20260830180915.260225-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 johann.baudy@gnu-log.net, kuni1840@gmail.com, netdev@vger.kernel.org,
 syzbot+73df3f89e1e13089e466@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 30 Aug 2026 18:09:12 +0000 you wrote:
> syzbot reported BUG() in sock_sendmsg_nosec(). [0]
> 
> The problem is that tpacket_parse_header() casts user-provided
> tpacket_hdr.tp_len, which is u32, to int.
> 
> If the length is larger than INT_MAX, the following condition
> in tpacket_parse_header() passes,
> 
> [...]

Here is the summary with links:
  - [v1,net] af_packet: Don't cast tpacket_hdr.tp_len to int in tpacket_parse_header().
    https://git.kernel.org/netdev/net/c/73e594c19b4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


