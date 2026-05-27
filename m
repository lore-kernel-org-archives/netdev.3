Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637131715D
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779845415; cv=none; b=GTMpchk/HZE1RBEZ3rdjkQdGAmK8VplymSHaVvurjYPGfjSnAlkZG4wV3pcjhmOnDpY5/c2+EWaoqZzXjBupQvoXz793q9gffqL49V5vg6MX+I5QmGCezskiZU8vCOFMNerCSdoS7kNGBF4zsfF5uc3lfTCkU2FB3H0lxlKYf8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779845415; c=relaxed/simple;
	bh=7vT19sIl3Q9+t3tbRGH26qmkXHgt72j+N6Lv2fIYPdY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i33Ogf0soYVUNpMQPn0SXhZ0oNgJmaG00/avS6oOf9VziqJZE54vg4XXSMaATfXoOgeWZzA2BMrrBb4Bj5KuJWckG2qHoTg14sUOUtKo1FF/so9rxnrxr+GdBGgUo/1WxKKWFpjC92sh1Q+s54Ger90VuJ9sBMm1+gKIMqQWGxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrCNXCmh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrCNXCmh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D821F00A3C;
	Wed, 27 May 2026 01:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779845413;
	bh=0ydQFosR+nLRxDjYae3CHk11toZXFY6axBJHsyfLZqI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PrCNXCmhXXZIwUoOO2qOEbuyZxPMS96lwGYMiZdXEM01TaPuoH6aJAx9sKlg+Q+lR
	 HSg2ZSXZnh7O1GXCrD/7dRPqk1I19QIEce+u/V07ZzxPmDhrBrqc8LRzN3d9gJLkAZ
	 c0fvJ5Fm1A1wPMKjRfleweKOw3qMVXBvQ/SdQv0fOgHK/do9BI+ImwgelbVNOyD8xE
	 tRvcR69ssR9Qj0wNIJq94f/SIoI9IpgLgodWgHN8flL7QxuvYGDb0sPVB8+eVg7nL5
	 x+aRc/Ga8LCzggqawLoSHynOqsk0HKJ7sWzul/QmCc75DT1f5SO2knjes4UhHVpG5c
	 tCARGsga3VPIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A37380CEED;
	Wed, 27 May 2026 01:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vxlan: do not reuse cached ip_hdr() value after
 skb_tunnel_check_pmtu()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984541939.4041297.1723728768792340106.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 01:30:19 +0000
References: <20260525203642.2389723-1-edumazet@google.com>
In-Reply-To: <20260525203642.2389723-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, sbrivio@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 May 2026 20:36:42 +0000 you wrote:
> skb_tunnel_check_pmtu() can change skb->head.
> 
> Reusing old_iph afer skb_tunnel_check_pmtu() can cause an UAF.
> 
> Use instead ip_hdr(skb) as done in drivers/net/bareudp.c
> and drivers/net/geneve.c.
> 
> [...]

Here is the summary with links:
  - [net] vxlan: do not reuse cached ip_hdr() value after skb_tunnel_check_pmtu()
    https://git.kernel.org/netdev/net/c/7d9ef0cb2715

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


