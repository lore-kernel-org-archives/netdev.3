Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633D13570C8
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774668622; cv=none; b=WYB14lecOs6ZuxYis3kOmHxDk6aIYMKxI8PLXChlyQYVVD3R/+TGGouSyV/4MsAeeusCvIYkzV/kvIx3XhuUlp7nD67g8iDVlwcDASjX8qJSZb4SVSxwA5icHZrILmQZUoWA4x7AKva7DuSxJ5MOScpS5BvE0KLYAc5WUTqueY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774668622; c=relaxed/simple;
	bh=qNgTJrcSbRWTJNsCbL8Uy4Y1WuReDjsTAnGInzUDEHk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R1GmC52LpGzMarPYETvPyrT2cOfTDnXh41YC+8UgASWWhOqrZDxnYU59FafjI7hSut0Xx0IO7HJ7W77ENMIudMrdjrjEsAwfSRx6Cul2JuvbLe1yeBidUW3zqkKk8Ri4X+boiqunbtSjuwtmr9lKW9l7W3IIQdlJlsIgNQniPOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPlv4t8o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPlv4t8o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25297C19424;
	Sat, 28 Mar 2026 03:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774668622;
	bh=qNgTJrcSbRWTJNsCbL8Uy4Y1WuReDjsTAnGInzUDEHk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rPlv4t8oQhdxFgNJttvLatAlBaOv3wKYb5WkIiOB37GFnHa6H6IXCVpuzSbMBTx51
	 +Re+RwQSSh7sNy4KZAt5qLhD0bjdpymOFNIQik1lK8TWBoZFC1URIqlXGpzw+bMb3z
	 CTuEEpJWw56ACpa3gOPAHeB5v2FDZjcg7WQNHNewhZanDcC+OKae/52wdksoh3olv+
	 Kss7wVk8w34YiGs5QlkfunOWvO4ZC71BtdPFxJ4HeinE5y2qZJrkrCeYrh1xRpXQOd
	 +inhRnCvwNhqXNZQ+1LVLAs7XU12sEycZ2Pfb2mgTVcZPwyPLD86vP0I+DU25RUuPB
	 CepuPdrIYTm+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C3A3930181;
	Sat, 28 Mar 2026 03:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: icmp: clear skb2->cb[] in
 ip6_err_gen_icmpv6_unreach()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177466860778.4167434.3160952028617568089.git-patchwork-notify@kernel.org>
Date: Sat, 28 Mar 2026 03:30:07 +0000
References: <20260326202608.2976021-1-edumazet@google.com>
In-Reply-To: <20260326202608.2976021-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 idosch@nvidia.com, oskar.kjos@hotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Mar 2026 20:26:08 +0000 you wrote:
> Sashiko AI-review observed:
> 
>   In ip6_err_gen_icmpv6_unreach(), the skb is an outer IPv4 ICMP error packet
>   where its cb contains an IPv4 inet_skb_parm. When skb is cloned into skb2
>   and passed to icmp6_send(), it uses IP6CB(skb2).
> 
>   IP6CB interprets the IPv4 inet_skb_parm as an inet6_skb_parm. The cipso
>   offset in inet_skb_parm.opt directly overlaps with dsthao in inet6_skb_parm
>   at offset 18.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: icmp: clear skb2->cb[] in ip6_err_gen_icmpv6_unreach()
    https://git.kernel.org/netdev/net/c/86ab3e55673a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


