Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794358808;
	b=UvloS0Odgtmow1tpJqk8Z2g/B1eL51OnbBlckwDpgOzy5iYTuNjChCv84Ti+9DrG5rJV
	 amWab1FAJqDozlUGLppCIp5rXzBqnmG3exB87zzNCdmS6EHQ6PoYTH61DkozP+2O4m+9k
	 EZYYty3rjZMAQuRm0VSFioC6gVdrN0jreY3C23bSh2X0mnJ34Zf/qHoHmFaOE3u1mhJNL
	 fVIoj4cNpZzyXGQQ8G/zGcBy8nwG98l8+R9pXYETZtO8MEbkkKlvOWkG2Gnm96fMMZS64
	 7dNl5IDXux2aOf87LiWZ8SG19p+uH7T+c+Sh1wRzD5ubwon2yQhyp980WHXeX8cFVJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794358808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=/2HU3eDpT+Wbc/ngOLAsx+zjXZWXB+xChl3j0oBArdQ=;
	b=woI4h3f2xgDKEaCV0cI8s/WjaAlL/47QS2ba1bEFy/Sl+55IeBf2e2Ptz5VlMQL1Mwfi
	 49SBIcVJzB8p336tOrdAmyuAjhEDNeLOCgodIHJwQh3KupT7906BkAVvW9FFB04V7XorB
	 MxSqNlQ2/CMM579ozHk5vEimiDAKSMUtvlHrj9MmkIcHrr0YBarBCuePkw8X1gnFGoUOK
	 C5cHUomtcd8oTEJTJE5dTCirnRe5/zaCAqe6ps7y4x4z9iCZaN6A5tXDwAYvenoTzkiYe
	 d/kkI2wJFE7Erw4z8Kz1VVkRKpklTC8FFNSUbFMjDbC8Cs1qk9h4/Op4m5gO/FIyDOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o1qRuE84;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3BA606AA16
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o1qRuE84
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55A31F0093C;
	Wed, 11 Nov 2026 01:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794358808;
	bh=/2HU3eDpT+Wbc/ngOLAsx+zjXZWXB+xChl3j0oBArdQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=o1qRuE84xz2ty/I7gNsjqqFiCS/rf7C5NeBs5YDA5h87hglCpg3v2tc900d/gxQkW
	 RyCG/Jzmno4An+3G8ihb5bOO6NYm2aIKqb5PPAlG1an4tgqSe6n80J8YIVdNk4lMJY
	 8oJP+Xxq47QSPwjrVuMy/bZMt7xHL0NLTww9JIj0EWpVA1svv0ewaw6Ojf2OG8H/m+
	 CZlqsDVZ4EsILHwr7V04Sc7heAUc/60Jh8YECOC2TAvb6SYlQ0dCjkiNQdkDPZxujm
	 H2iSqggYIXx0mQKDnqkThcIwgB6i5/Yc9MsmJSUPCws+Tvv/7phTjACaRTOfWlZ6sp
	 jD+8XbOP15LGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D824B39E8A55;
	Wed, 11 Nov 2026 01:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: gro: compare skb->protocol in
 gro_list_prepare()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435880668.145868.8552377604048030008.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 01:00:06 +0000
References: <20261109164540.3104392-1-edumazet@kernel.org>
In-Reply-To: <20261109164540.3104392-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, kylebot@openai.com, willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Nov 2026 17:45:40 +0100 you wrote:
> gro_list_prepare() checks whether a held packet may belong to the same
> flow as the incoming one by comparing the device, VLAN tag, metadata
> and the link-layer header, using dev->hard_header_len as its length.
> 
> On devices without a link-layer header (hard_header_len == 0), such as
> L3 GRE tunnels, no compared byte carries the outer protocol:
> skb->protocol comes from the tunnel header. Packets of different
> protocols can then stay eligible, and the GRO handler selected from the
> incoming skb->protocol parses the held packet with the wrong layout.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: gro: compare skb->protocol in gro_list_prepare()
    https://git.kernel.org/netdev/net/c/511582022bfd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


