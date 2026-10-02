Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C711490BEA;
	Fri,  2 Oct 2026 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937153; cv=none; b=dyGjSgkRdu/PjT9ec7xgdZjuyE1ieQmK1FB34w4vuVbagW5EtUvitCnt4oM2qDaVhrwQZveQt7ENqU7nmnSps/3so+/ol/xvXGX8R8tRaAEm37aX15UUvuaVhQ3aT4CGmQtyvj5YmSi8EsSnYiWFyjQlL1bGH1U1tBBUzFnmdLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937153; c=relaxed/simple;
	bh=BH3IXpOHdMbe1D7MPqkwfQktWqbGdy0jssWA5LDF5Fs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jfy1Z4XwFtnoRRnh1cAMG4Bft+BOAQACGbKaX0dof3jgqj3R9iT3PsHjaW3UtHX7/I6HbqliGmU/dlj+CztnRn57LFuAcIOPBt0s8NhjdZIvz/Zbua0JM+8zN9NcVCaS3wlei3n2gybYuijojwtoi191mNWkXCGuedT5m7nIslg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KL37sYW0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KL37sYW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A744E1F000FF;
	Fri,  2 Oct 2026 10:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937152;
	bh=hK4F1acqDmWcfyZlAzE0byAzA/5Uxr5CMrrUkC+Ox8I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KL37sYW09NRJLkNtvKB/miviUESNwN7DzQ+/hJft/ISD8PJpLTvaLdP1UHUOS7rYQ
	 KCSR76aeIVUdQ80da+LJmTN8edOAOdZW1EnUHD8lA7bZSFDgcYMqS8ikJ56NNxgov7
	 UlodcO4AUgdIv8HtmGpNEjqFIW2m1BRopap/BcL3tylvEM5MPtIKfewtqCF/+w1Aip
	 rPHMACM9SRbs1xMzxoKn9zvj4ChoOvCufT3uXxu6okqWzzQXef9pOA5LcE5KO7eH12
	 PmOcw8KJt+xYFvAMM4KxX+W/v2ZyG4AtKqFtw4Eg8lDcZR0Fcg5lB/3H9s3GTSZtQP
	 rdKsv8S5QAdMQ==
Subject: Re: [PATCH 16/16 net-next v2] ipv4: make CONFIG_IPV4 boolean
From: netdev-bot+sashiko@kernel.org
To: fmancera@suse.de
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 edumazet@google.com, ebiggers@kernel.org, ardb@kernel.org, krzk@kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 10:32:31 +0000
Message-ID: <179093715122.434549.218741328514033959@kernel.org>
In-Reply-To: <20260928193046.6698-17-fmancera@suse.de>
References: <20260928193046.6698-17-fmancera@suse.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says this patch lets users "build
  IPv6-only".
- [Low] This patch makes CONFIG_IPV4 user-selectable, but two IPv4-only
  options in net/ipv4/Kconfig still have no `depends on IPV4`:…

--

ipv4: make CONFIG_IPV4 boolean

This patch turns CONFIG_IPV4 from a hidden def_bool y into a prompt that
users can see. The prompt appears when IPV6 is enabled and defaults to
INET. The goal is to allow an IPv6-only kernel build.

> diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
> index 51bf05d9770c5..c7d36cfa4a1d2 100644
> --- a/net/ipv4/Kconfig
> +++ b/net/ipv4/Kconfig
> @@ -3,7 +3,15 @@
>  # IP configuration
>  #
>  config IPV4
> -	def_bool y
> +	bool "The IPv4 protocol" if IPV6
> +	default INET
> +	help
> +	  Support for IP version 4 (IPv4).
> +
> +	  Disabling this option compiles the kernel networking stack without
> +	  IPv4 support, resulting in a IPv6-only system.

[Severity: Medium]
Is "IPv6-only system" an accurate description of what IPV4=n produces?

This prompt makes IPV4=n reachable, so every existing "depends on IPV4"
in the tree now takes effect. Several of those also gate IPv6 features.

Both netfilter menus depend on IPV4:

net/netfilter/Kconfig:
menu "Core Netfilter Configuration"
	depends on INET && IPV4 && NETFILTER

net/ipv6/netfilter/Kconfig:
	depends on INET && IPV6 && NETFILTER && IPV4

That means there is no ip6tables and no nftables for IPv6.

XFRM depends on IPV4 as well:

net/xfrm/Kconfig:
config XFRM
	bool
	depends on INET && IPV4

INET6_AH, INET6_ESP, INET6_IPCOMP, IPV6_MIP6 and IPV6_VTI in
net/ipv6/Kconfig are gated the same way, so IPv6 IPsec is lost.

SYN_COOKIES has "depends on IPV4", and net/ipv6/Makefile builds the IPv6
side only under that symbol:

ipv6-$(CONFIG_SYN_COOKIES) += syncookies.o

As a result, IPv6 TCP listeners have no SYN cookies. TCP_MD5SIG and
TCP_AO are also gated on IPV4, even though tcp_ipv6.c and ipv6/tcp_ao.o
implement them for IPv6.

Other options that drop out:

  - IPV6_MROUTE, IPV6_TUNNEL, IPV6_GRE, IPV6_SIT and ILA
  - the SEG6, RPL and IOAM6 lwtunnels
  - the drivers BONDING, WIREGUARD, OVPN, IPVLAN, VXLAN, GENEVE, BAREUDP,
    GTP, PFCP, AMT, NET_VRF and NETDEVSIM

A user who follows this help text gets an IPv6 host with no packet
filter, no SYN cookies, no IPsec and no multicast routing. With
olddefconfig, these options are also dropped without any message.

Could the help text and changelog mention these limitations? Or should
the IPv6 side of these dependencies be relaxed before the prompt is
exposed?

> +
> +	  If unsure, say Y.
>  
>  config IP_MULTICAST
>  	bool "IP: multicasting"

[Severity: Low]
Now that IPV4 is optional, should IP_MULTICAST get a "depends on IPV4"?
The same question applies to NET_IPGRE_DEMUX further down in this file.

Similar options such as NET_IPGRE, IP_MROUTE, IP_PNP, SYN_COOKIES and
TCP_MD5SIG already have that dependency. With IPV4=n, these two prompts
are still offered, and existing configs keep them enabled.

For IP_MULTICAST, this looks like it can break the s390 build. QETH uses
IP_MULTICAST as its only IPv4 gate:

drivers/s390/net/Kconfig:
config QETH
	def_tristate y
	prompt "Gigabit Ethernet device support"
	depends on CCW && NETDEVICES && IP_MULTICAST && QDIO && ETHERNET

QETH_L3 builds qeth_l3_main.c, which calls devinet.c helpers without any
condition:

drivers/s390/net/qeth_l3_main.c:qeth_l3_register_notifiers() {
	...
	rc = register_inetaddr_notifier(&qeth_l3_ip_notifier);
	if (rc)
		return rc;
	...
}

qeth_l3_unregister_notifiers() calls unregister_inetaddr_notifier() the
same way.

devinet.o is only built under obj-$(CONFIG_IPV4) in net/ipv4/Makefile,
and include/linux/inetdevice.h has no stubs for these functions.

Would a config with IPV6=y, IPV4=n, IP_MULTICAST=y and QETH_L3 enabled
fail to link, with undefined references to register_inetaddr_notifier()
and unregister_inetaddr_notifier()?

NET_IPGRE_DEMUX still builds gre.o, and gre_init() in
net/ipv4/gre_demux.c still registers an IPv4 protocol handler:

	if (inet_add_protocol(&net_gre_protocol, IPPROTO_GRE) < 0) {

No IPv4 receive path exists in this configuration. The in-tree users of
this module, NET_IPGRE and IPV6_GRE, both require IPV4, so the module
does nothing.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928193046.6698-1-fmancera%40suse.de
