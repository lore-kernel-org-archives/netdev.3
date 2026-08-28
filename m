Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E3288C96
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787955063; cv=none; b=lcyeax+zKjdSMY5T82xP46KGuc21KrDzYJLZovzdJBKF4VVRrZGNe8Paq69BOkARlTb9GLAX9BabojXtTBxgsGEJax83uonstwkSOhgbRGMTVB89alI9ScCVfdyte3Lc1/UArOxeSUD77F1pJMdQuaP1SKkaJNq++fQKnB91GXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787955063; c=relaxed/simple;
	bh=duKYzC96DSDXO9aU3DH2EvC90AfQM4HZ8RKCfeUmzKY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LHCKoINFfMC2InbEY4ayfjNAT0kB3krww46U1HYVxo/+QGfonwROMtj5b3WH+qw2J5bX78UPpDilUWF5j5T6L/PWYPs/QJdJLmQskuJn4KbeOdzgojblXWa2DHJl4+XBcotlX6D9NdX244tnihCIcFu18Q79hBssI/Wzz81XiZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KETt7C7+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KETt7C7+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF26C1F000E9;
	Fri, 28 Aug 2026 22:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787955062;
	bh=nygYmCHuhzIdnG57U4cF6eClg3pg/mtv98Uw30qLcXQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KETt7C7+8YtfHuLbzoT37BIcxvn8h9krgkBqbIXtgP6xFSqKgftBexJ35PiAZCzH7
	 8HOeBesY78OLC1VgBeBsfyIE0zOMRuL9zJ4GihSjacka3u29zfodxR5GbUSXrp4wa/
	 LBYJTt1f3Pj6aoJQbzVmu5PBS7INp/WUWQA1Eoswult/37bA1bj6Wtx2ep4TcBF2dp
	 1yUj7zf/JPdbKc8kXEEglYXl+B4BJpaElbrNCYlVLDw64TIVP6nuZJ5FwXdJDja+Kl
	 c57r+bbbZ97+0K3mxye9D3RcI7RvVvue1Dpn0GP6msu2LmLvBCTTlZhmOiutxOEqVu
	 Zaxpr7Fjr25WQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A29380AA69;
	Fri, 28 Aug 2026 22:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: icmp: avoid invalid transport header access in
 icmp_send tracepoint
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178795500640.2819210.2098274616727139246.git-patchwork-notify@kernel.org>
Date: Fri, 28 Aug 2026 22:10:06 +0000
References: <20260825084551.1562967-1-edumazet@google.com>
In-Reply-To: <20260825084551.1562967-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+6d2762674103618994b0@syzkaller.appspotmail.com, he.peilin@zte.com.cn,
 xu.xin16@zte.com.cn, rostedt@goodmis.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Aug 2026 08:45:51 +0000 you wrote:
> syzbot reported a WARNING triggered by DEBUG_NET_WARN_ON_ONCE():
> 
>  WARNING: at skb_transport_header include/linux/skbuff.h:3087 [inline]
>  WARNING: at udp_hdr include/linux/udp.h:23 [inline]
>  WARNING: at do_trace_event_raw_event_icmp_send include/trace/events/icmp.h:30 [inline]
>  WARNING: at trace_event_raw_event_icmp_send+0x48c/0x6ec include/trace/events/icmp.h:11
>  Call trace:
>   skb_transport_header include/linux/skbuff.h:3087 [inline]
>   udp_hdr include/linux/udp.h:23 [inline]
>   do_trace_event_raw_event_icmp_send include/trace/events/icmp.h:30 [inline]
>   trace_event_raw_event_icmp_send+0x48c/0x6ec include/trace/events/icmp.h:11
>   __traceiter_icmp_send include/trace/events/icmp.h:11 [inline]
>   __do_trace_icmp_send include/trace/events/icmp.h:11 [inline]
>   trace_icmp_send+0x320/0x49c include/trace/events/icmp.h:11
>   __icmp_send+0xcfc/0x11d8 net/ipv4/icmp.c:1013
>   ipv4_send_dest_unreach net/ipv4/route.c:1280 [inline]
>   ipv4_link_failure+0x57c/0x8dc net/ipv4/route.c:1287
>   dst_link_failure include/net/dst.h:438 [inline]
>   vti_tunnel_xmit+0xe40/0x17a4 net/ipv4/ip_vti.c:307
> 
> [...]

Here is the summary with links:
  - [net] net: icmp: avoid invalid transport header access in icmp_send tracepoint
    https://git.kernel.org/netdev/net/c/7fcc2fe39fed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


