Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D8147F770;
	Fri,  2 Oct 2026 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937138; cv=none; b=J9VDDad8Qs8bZv9cf823Ay8HvNpyRxsx7KEAU8EZa1zQTpwnFmo2IU69FIMH5q47lvwwSI+5u1m72s/bzGsLDf1RNBDUUVZOqDW2GkATOJwf9vKasuUO1gl4mBhBWFjVoS8AVY6R+W8skAhBIy7fGWbKd/t8p5vem1ddcbDrbHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937138; c=relaxed/simple;
	bh=MHTFMB7DtgItsH/LJ6ivEDUkjRDQF5OD64d1cvinLS0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kFpuYrwZ/+K8Ag+Kx6/ZOrv2O1wTTiKfMT9lzjAgHRE5+dHsTIMyJoh4xFJhCKVmZlRkRhtAEkP1Gt2J5Q3RaPnHaABgNQhqfL2nVhkANMUIYWGI6+Kke/KX3BHEd6Sw0liqix9s36Ozu7zNqPqlUDckraaoLgwznhDQpTBao14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEhjFs74; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEhjFs74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70741F00898;
	Fri,  2 Oct 2026 10:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937137;
	bh=rwEsw5DPWmUanXI2GC5Fi9GiZctaCsN7ibTuiBPQbcg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FEhjFs74l6KwKb5GSQlv5Lt5hlgQVB6rGgtplagJUn45ra6LYgSRLfv+RtdvcPDcl
	 TkZLLsy8waVhNgbrgKN5Ujuad9xBWS+nqUuqqCdUG8mGUto/YMaK67GG2/fSzdYdvk
	 AWMekQQ6RrDHRsLA8TE02/v/S1qsNjT+CPeVih/BhsMPRw4LlVEFHtgetEZSFpg+RK
	 JAvDAsvWQWyWwem7S7bddJfahGrRAXiZYbTqBQlhOR2lyZB88JBOb9fqPyZH8N8zPh
	 EYCWITIYUhh7mCr1lLltQ3+hOcyarfWkSZiOCnNQ3JvqFDylTKzE9Zs4+tUC5bqab4
	 kHQ51wpfEIS4g==
Subject: Re: [PATCH 01/16 net-next v2] ipv4: introduce CONFIG_IPV4 to decouple
 the IPv4 stack
From: netdev-bot+sashiko@kernel.org
To: fmancera@suse.de
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 edumazet@google.com, ebiggers@kernel.org, ardb@kernel.org, krzk@kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 10:32:16 +0000
Message-ID: <179093713623.434549.10029309690029336462@kernel.org>
In-Reply-To: <20260928193046.6698-2-fmancera@suse.de>
References: <20260928193046.6698-2-fmancera@suse.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch moves route.o, arp.o, icmp and the other IPv4-only
  objects under obj-$(CONFIG_IPV4) and adds `depends on IPV4` / `depends…

--

ipv4: introduce CONFIG_IPV4 to decouple the IPv4 stack

This commit adds a CONFIG_IPV4 symbol, which is def_bool y for now. It
moves the IPv4-only objects in net/ipv4/Makefile under obj-$(CONFIG_IPV4).
It also adds IPV4 (or IPV4 || !INET) dependencies to a number of drivers,
filesystems and networking features that use those symbols.

> diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
> index 06e21c26b76f..8b148be79fa4 100644
> --- a/net/ipv4/Makefile
> +++ b/net/ipv4/Makefile
> @@ -3,18 +3,17 @@
>  # Makefile for the Linux TCP/IP (INET) layer.
>  #
>
> -obj-y     := route.o inetpeer.o protocol.o \
> -	     ip_input.o ip_fragment.o ip_forward.o ip_options.o \
> -	     ip_output.o ip_sockglue.o inet_hashtables.o \
> -	     inet_timewait_sock.o inet_connection_sock.o \
> -	     tcp.o tcp_input.o tcp_output.o tcp_timer.o tcp_ipv4.o \
> +obj-y     := inetpeer.o protocol.o inet_hashtables.o inet_timewait_sock.o \
> +	     inet_connection_sock.o tcp.o tcp_input.o tcp_output.o tcp_timer.o \
>  	     tcp_minisocks.o tcp_cong.o tcp_metrics.o tcp_fastopen.o \
> -	     tcp_recovery.o tcp_ulp.o \
> -	     tcp_offload.o tcp_plb.o datagram.o raw.o udp.o \
> -	     udp_offload.o arp.o icmp.o devinet.o af_inet.o igmp.o \
> -	     fib_frontend.o fib_semantics.o fib_trie.o fib_notifier.o \
> -	     inet_fragment.o ping.o ip_tunnel_core.o gre_offload.o \
> -	     metrics.o netlink.o nexthop.o udp_tunnel_stub.o
> +	     tcp_recovery.o tcp_ulp.o tcp_offload.o tcp_plb.o raw.o udp.o \
> +	     udp_offload.o af_inet.o inet_fragment.o ping.o ip_tunnel_core.o \
> +	     gre_offload.o metrics.o netlink.o nexthop.o udp_tunnel_stub.o
> +
> +obj-$(CONFIG_IPV4) += route.o ip_input.o ip_fragment.o ip_forward.o ip_options.o \
> +		      ip_sockglue.o tcp_ipv4.o datagram.o icmp.o arp.o devinet.o \
> +		      igmp.o fib_notifier.o ip_output.o fib_frontend.o \
> +		      fib_semantics.o fib_trie.o

[Severity: Low]
Is SUNVNET_COMMON missing from the list of consumers that gained an IPV4
dependency? Its Kconfig entry is unchanged:

drivers/net/ethernet/sun/Kconfig:
config SUNVNET_COMMON
	tristate "Common routines to support Sun Virtual Networking"
	depends on SUN_LDOMS
	depends on INET
	default m

vnet_start_xmit() in drivers/net/ethernet/sun/sunvnet_common.c calls
icmp_ndo_send(). The only guard is a runtime protocol check:

	if (skb->protocol == htons(ETH_P_IP))
		icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED,
			      htonl(localmtu));

include/net/icmp.h has no !CONFIG_IPV4 stub for icmp_ndo_send() or
__icmp_send(). The "Core Netfilter Configuration" menu now depends on
IPV4, so NF_NAT is n when IPV4=n. In that case icmp_ndo_send() is the
inline wrapper that calls __icmp_send() directly.

With IPV4 set to def_bool y, this can't happen yet. After the later
"ipv4: make CONFIG_IPV4 boolean" change, __icmp_send() is defined only in
net/ipv4/icmp_ipv4.c, and that file is built only through
obj-$(CONFIG_IPV4).

Consider a sparc64 config with SUN_LDOMS=y, INET=y, IPV6=y and IPV4=n.
SUNVNET_COMMON defaults to m there. Would that config fail at modpost
with an undefined __icmp_send?

Nothing later in the series seems to add an IPV4 dependency to
SUNVNET_COMMON, or a guard or stub for icmp_ndo_send(). Would a
"depends on IPV4 || !INET" line, like the one used for sfc, stmmac and
mlxsw, be appropriate here?

Other drivers with a similar pattern, such as bnxt, nfp and cnic, look
fine at the end of the series. They reach ip_route_output_flow(), and
"net: core: add IPv4 fallback stubs and guards for CONFIG_IPV4=n" stubs
that function in include/net/route.h to return ERR_PTR(-EAFNOSUPPORT).

>
>  obj-$(CONFIG_NET_IP_TUNNEL) += ip_tunnel.o
>  obj-$(CONFIG_SYSCTL) += sysctl_net_ipv4.o

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928193046.6698-1-fmancera%40suse.de
