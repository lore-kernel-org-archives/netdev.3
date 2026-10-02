Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED66748EC8A;
	Fri,  2 Oct 2026 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937151; cv=none; b=kWAJQnvjjRJ3CIcW83WdlUEv+bivbdIo/gQiu0F3j+86bfaQfIVpzDTQiG9b1DmmkRYp0INRXP/9m3knxKyeh/M6yk+w804Byi79J5RwfFyzLPDr0xmF2UIM236xra+3eC8nthsjXgDogFQGIeRs2tzM4hre37c5u0k8JbbOaOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937151; c=relaxed/simple;
	bh=ydBFhpdAzuAcijL3Fh9cHDBVMW7ZfprahH2ZFyMDR/w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IIqR35I8i7h+rXliKiyWGrthO1ZFIiwTQvkHE3EX5VypPKwAygHYMJ5pjrPUZ68SJTI207M4tsJtEmpcVNyBIW6JOL8rtGgLpBm6GdJbOrp7nhnfDri1hHepvnRCO1kGcx8a6VWE1liZsLQ6FpeXQmTv82Mezs20zYNSqhOEjJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqiMWneN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqiMWneN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457C71F000FF;
	Fri,  2 Oct 2026 10:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937149;
	bh=sAqPtztX0dkXNBNH2xEvKC3o0OikiQC2grp4Yr31NvY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QqiMWneNiNT1SqZVgT+tNWir8SrkDW+Zugw9p5vHm+MfGy8rJdp7dD9OS+UWj+LZs
	 mR5ISgh4rn2AScBt5eDEHrP+utanNeInGwN6SMauaQkU0dRUixVvCzztzeSYEFhb+Z
	 xvlfS0ufNOWcoXr9cJEhYM5260MxZxh9uWkOQcPRoOMMhygpLThJ7+aG8oK8oKuPYi
	 Csf3N5oVBzRQGYXis1FDLPvG76nr0XSnT4U9GLN7bet3Df9XdqPt07TLKfv/zewfem
	 Bmz0d+K42DoRMtUjR/oBjvjlF5bMNwNxRna6Aa48PKhIHfKiYGdz42Tz+Li2JcaoHY
	 rc02QGfYQ2D1A==
Subject: Re: [PATCH 13/16 net-next v2] net: bridge: guard ARP/RARP proxy and
 suppression with CONFIG_IPV4
From: netdev-bot+sashiko@kernel.org
To: fmancera@suse.de
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 edumazet@google.com, ebiggers@kernel.org, ardb@kernel.org, krzk@kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 10:32:28 +0000
Message-ID: <179093714886.434549.12503393738688334727@kernel.org>
In-Reply-To: <20260928193046.6698-14-fmancera@suse.de>
References: <20260928193046.6698-14-fmancera@suse.de>
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

- [Low] In net/bridge/br_arp_nd_proxy.c, the patch removes `#if
  IS_ENABLED(CONFIG_INET)` from above the static helper…

--

net: bridge: guard ARP/RARP proxy and suppression with CONFIG_IPV4

This commit replaces the CONFIG_INET guards around the bridge ARP/RARP
proxy and suppression code with CONFIG_IPV4. The reason given is that
CONFIG_IPV4 is becoming optional and separate from the core stack.

> diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> index da15f4d7c1aef..d739b86974299 100644
> --- a/net/bridge/br_arp_nd_proxy.c
> +++ b/net/bridge/br_arp_nd_proxy.c
> @@ -39,7 +39,6 @@ void br_recalculate_neigh_suppress_enabled(struct net_bridge *br)
>  	br_opt_toggle(br, BROPT_NEIGH_SUPPRESS_ENABLED, neigh_suppress);
>  }
>  
> -#if IS_ENABLED(CONFIG_INET)
>  static bool
>  br_is_neigh_suppress_enabled_vid(const struct net_bridge_port *p, u16 vid)
>  {
> @@ -57,6 +56,7 @@ br_is_neigh_suppress_enabled_vid(const struct net_bridge_port *p, u16 vid)
>  	return br_is_neigh_suppress_enabled(p, v);
>  }
>  
> +#if IS_ENABLED(CONFIG_IPV4)

[Severity: Low]
After this change, the static helper br_is_neigh_suppress_enabled_vid() is
always compiled. Does that give a "defined but not used" warning when
CONFIG_INET=n?

All of its callers are still behind config guards:

  br_do_proxy_suppress_arp()  inside #if IS_ENABLED(CONFIG_IPV4)
  br_do_suppress_nd()         inside #if IS_ENABLED(CONFIG_IPV6)

config IPV4 and config IPV6 are only defined under "if INET" in
net/Kconfig. config BRIDGE has no INET dependency, and br_arp_nd_proxy.o is
always part of bridge-y:

net/bridge/Makefile:
bridge-y	:= br.o br_device.o br_fdb.o br_forward.o br_if.o br_input.o \
			...
			br_netlink_tunnel.o br_arp_nd_proxy.o

With CONFIG_BRIDGE=y/m and CONFIG_INET=n, the file is still built, but
both guarded blocks are compiled out. That leaves the helper with no
callers and triggers -Wunused-function. With CONFIG_WERROR=y, which
defaults to y under COMPILE_TEST, the build fails. At the baseline, the
CONFIG_INET guard covered the helper, so this configuration built without
warnings.

Moving the helper out of the IPv4 block makes sense, because the IPv6
block needs it once IPV4 can be disabled. Could the helper get its own
guard instead, such as #if IS_ENABLED(CONFIG_INET) or
#if IS_ENABLED(CONFIG_IPV4) || IS_ENABLED(CONFIG_IPV6), closed before the
IPv4 block starts?

This still happens at the end of the series. The only configuration that
triggers it is INET=n. INET=y with both IPV4=n and IPV6=n cannot be
selected, because config IPV4 is only user-selectable when IPV6 is enabled
and defaults to INET.

>  static void br_arp_send(struct net_bridge *br, struct net_bridge_port *p,
>  			struct net_device *dev, __be32 dest_ip, __be32 src_ip,
>  			const unsigned char *dest_hw,

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928193046.6698-1-fmancera%40suse.de
