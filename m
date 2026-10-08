Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5319538F630
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791484647; cv=none; b=qs/EJZywuEkQCJXfY+2vGmkZdufVZEyXxQDfmXYxRyE6PpLHpOsRxQMrLzOV7puzvSUafKSZijwoZI/e71BP/9mciL7cS+du0crmm9Wsm/3C+0wKkRvTMzIDr6o7o6+MJj29e5M7cLKH34/oQrEbbbIejvvEyExwXFkfufWFOeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791484647; c=relaxed/simple;
	bh=r24BLMT/AXZeJc/3ihPOte4d7uyHmH1m249fwkrlx7Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=uhIAUXafWGDpvnvIwe2aa69Ms1k+webSjoyzTnXA4NJFjBhhRljnYuYD6TBxBhMkRw96kVsDNumRhXx4BN038bh0/sYilE2xkC6iBPKmlNHBcogkYliuCf/SdmFCPeZA51/lMdqzRgzEadQl/TTXlGDeg/zJ4Q5I3ZIyojIXjxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kd3HTTqn; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd3HTTqn"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67718201466so3163197d50.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 11:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791484645; x=1792089445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TzkxNQgy8ThJfs6qel04DqfDgpOkTC3bFiwmq4clDIs=;
        b=kd3HTTqnGgUX7+yssMQPbwNm4iawVOtyIsxrjcpPJ+xUd7ukTA0RDlEZXqH79HPRQG
         CDLGFUXWg7BXnuSPGYO4RiPHVhhllRQh3lwULnL32aNaoJrz2MvD4fo3wuD2tSLKwVdW
         tOHaeeNyTYgCGELqGKIqc/ZyXUPhQ0K6/FtZPzE+tnS3Zzr+cSShcsCrv5FgxTIUC0UE
         WwM6RcPWmwRpP03eGWvlw/P67TDUKa+N8fKndJEcLujM9M+KgAAE2uEtMdKeVnLop7r7
         5xCiOowvBWjTB01cEQYQasagV3r9hbHlTg9UWtMnq+0Is0kUtOq5UKbI7dcbGwbqsNMB
         FUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791484645; x=1792089445;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TzkxNQgy8ThJfs6qel04DqfDgpOkTC3bFiwmq4clDIs=;
        b=BsyO1MKIvMq9T8GOt3jxyWBM3S1iiwtMm+BxwO5L0Bpc3sme562SkEYdYV+olyTJkf
         WYAaankKSlWKYuJuv7u684zN9qeeCjWXIhZ9r+S7lWdqjIHcHELhtCS8JGAZNZ9gXqOS
         9E9zqk4SgHIyLCXubpQy6TLGnLbv/IJrq0rtely+uFDf5B7RAJyiHl6UE8WgFkYDAxdO
         R5kl0M/SiASUrwR4wgB/OuPeOVapx7OWY+nv5Cpt4PxVhLErOf35Ttb80190rETd3Poo
         6h/Rygl7SH8wNBs2IwO2MEN/e41PnGwQPkj+usP12wmY15ox55stsEbyaJRWlgu71UvL
         JjZA==
X-Forwarded-Encrypted: i=1; AKwUvBy4/o11oWXwZFYJCe73PsQpkj4MbLdM2xb2bADDoCilfC0e6ghfH2f7cjVcIcrxJ9c+8IddzlU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkXLGv0wsFjvxCQF0G5JqS8g0SRkkAReoRTlzXnSRqOW6wczWo
	5pJQTimbq8iDAfCMehxV+bb3vii40DmiP0CLsyAgUJGDsTWao7e6tDPK
X-Gm-Gg: AYBFou28ZHBAb7SmzqNpSWTn6rGP8yj7jsRhb61njufP3F7RYVwzmtH/CJcF4Pb1i/2
	j2gJUZM2TbUGIHG1zAua2mwV/Ycs/8k5gs1vlf2BtUx+ag32sXixV80ArZyvy3KBGUMdtZD4slU
	2ZS4jB2ss7sg61lqDOvXdE4hX7tf0Mm2aZViV3nAikDaoZTDsfbmP2RE3oHWeBmHf1Ms8w+NWVU
	hc4W2/jcYAqjkVqFzXT1u0UPtqT84fjyH6+KTzxHYZAFHepBrWu4AOtOHEaFSznIfbPgEmUxtVG
	2MrgAuAKNNYcZUWfVoVCOXrQWHDWQCn5voMn0x+eMQxqT3U53V9XzeZrrP9K2x/yX4hHhF5Bf5X
	3oTv3qaCsccUX1cHdvM6qKSAIgs3u6lOe5n/C87o4SJXaGZjMCCMXBPCDrlwpUp5gIytvxPApU2
	8HPfb98vqAYuos5/4hE+/STRJXgWX/E7qxEAKoOPn5Zj6hty/79NBiBAycaYYFvj4bxYxkuxi49
	HN6eFMtWoWyI1WOCAtWpmZ6Ijs7HCizAfX9D2jrfRgcOkYTAB3FHBUL4nPbzUegysJgl8rFbUOB
	C9yiMJoY87yiATVgHU5vSWLwmIrNDfi+f9fZgg==
X-Received: by 2002:a05:690e:134c:b0:677:d849:d9a3 with SMTP id 956f58d0204a3-67909f0bef9mr3735096d50.1.1791484645322;
        Thu, 08 Oct 2026 11:37:25 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07d69a4f0sm10907b3.41.2026.10.08.11.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 11:37:24 -0700 (PDT)
Date: Thu, 08 Oct 2026 14:37:24 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 rafael@kernel.org, 
 lenb@kernel.org, 
 pavel@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 linux-pm@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 stable@vger.kernel.org, 
 =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>
Message-ID: <willemdebruijn.kernel.cf8fec88827c@gmail.com>
In-Reply-To: <20261008124106.665014-1-Jason@zx2c4.com>
References: <20261008124106.665014-1-Jason@zx2c4.com>
Subject: Re: [PATCH net] udp_tunnel: drop packets when hibernating
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason A. Donenfeld wrote:
> The kernel's various networking applications keep churning away after
> userspace is frozen during hibernation, even as a memory snapshot is
> being made. This can lead many network applications to an inconsistent
> state, replaying packets and cryptographic state changes. For example,
> on wireguard, there's the possibility of this sequence:
> =

> 1) hibernating begins
> 2) handshake state cleared
> 3) keypairs cleared
> 4) new handshake round trip completes
> 5) machine memory is snapshotted
> 6) packet is sent using new keypair
> 7) machine is restored to state (5)
> 8) packet is sent using new keypair
> =

> The idea is to prevent (6) from happening, especially if (6) and (8)
> contain different data, but the same key and nonce. Presumably the same=

> issue applies to other users of udp_tunnel too.
> =

> Fix this by just dropping sending and receiving packets during the
> hibernation sequence.

A few high level questions:

If the issue is reuse of key + nonce during send, why include receive
side functions? Specifically tunnel (encap_rcv) functions.

Is this a problem specific to UDP tunnels?
 =

> Cc: stable@vger.kernel.org
> Reported-by: J=C3=A9r=C3=A9my Jean <jeremy.jean@oss.cyber.gouv.fr>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> I wrote this patch in response to the issue J=C3=A9r=C3=A9my raised, bu=
t I'm not
> actually super familiar with all of the hibernation mechanics. If
> somebody working on PM would think about this matter too, I'd be much
> obliged.
> =

>  include/linux/freezer.h    | 1 +
>  net/ipv4/udp.c             | 5 +++++
>  net/ipv4/udp_tunnel_core.c | 5 +++++
>  net/ipv6/ip6_udp_tunnel.c  | 5 +++++
>  net/ipv6/udp.c             | 5 +++++
>  5 files changed, 21 insertions(+)
> =

> diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> index 0a8c6c4d1a82..21d708dc4092 100644
> --- a/include/linux/freezer.h
> +++ b/include/linux/freezer.h
> @@ -76,6 +76,7 @@ static inline bool cgroup1_freezing(struct task_struc=
t *task)
>  #endif /* !CONFIG_CGROUP_FREEZER */
>  =

>  #else /* !CONFIG_FREEZER */
> +#define pm_freezing (false)
>  static inline bool frozen(struct task_struct *p) { return false; }
>  static inline bool freezing(struct task_struct *p) { return false; }
>  static inline void __thaw_task(struct task_struct *t) {}
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index b090bd1f59e8..5021932ad9f1 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -95,6 +95,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/slab.h>
>  #include <linux/sock_diag.h>
> +#include <linux/freezer.h>
>  #include <net/tcp_states.h>
>  #include <linux/skbuff.h>
>  #include <linux/proc_fs.h>
> @@ -2425,6 +2426,10 @@ static int udp_queue_rcv_one_skb(struct sock *sk=
, struct sk_buff *skb)
>  		if (encap_rcv) {
>  			int ret;
>  =

> +			/* Drop if we're hibernating */
> +			if (unlikely(pm_freezing))
> +				goto drop;
> +
>  			/* Verify checksum before giving to encap */
>  			if (udp_lib_checksum_complete(skb))
>  				goto csum_error;
> diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
> index a128fe85620d..e3666ed96af7 100644
> --- a/net/ipv4/udp_tunnel_core.c
> +++ b/net/ipv4/udp_tunnel_core.c
> @@ -3,6 +3,7 @@
>  #include <linux/errno.h>
>  #include <linux/socket.h>
>  #include <linux/kernel.h>
> +#include <linux/freezer.h>
>  #include <net/dst_metadata.h>
>  #include <net/flow.h>
>  #include <net/udp.h>
> @@ -172,6 +173,10 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct=
 sock *sk, struct sk_buff *skb
>  {
>  	struct udphdr *uh;
>  =

> +	/* Drop if we're hibernating */
> +	if (unlikely(pm_freezing))
> +		return;
> +
>  	__skb_push(skb, sizeof(*uh));
>  	skb_reset_transport_header(skb);
>  	uh =3D udp_hdr(skb);
> diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
> index 32525a051a6f..4a31e8cc8887 100644
> --- a/net/ipv6/ip6_udp_tunnel.c
> +++ b/net/ipv6/ip6_udp_tunnel.c
> @@ -7,6 +7,7 @@
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/in6.h>
> +#include <linux/freezer.h>
>  #include <net/udp.h>
>  #include <net/udp_tunnel.h>
>  #include <net/net_namespace.h>
> @@ -86,6 +87,10 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, str=
uct sock *sk,
>  	struct udphdr *uh;
>  	struct ipv6hdr *ip6h;
>  =

> +	/* Drop if we're hibernating */
> +	if (unlikely(pm_freezing))
> +		return;
> +
>  	__skb_push(skb, sizeof(*uh));
>  	skb_reset_transport_header(skb);
>  	uh =3D udp_hdr(skb);
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 93478d1ad576..db9c2050887d 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -34,6 +34,7 @@
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
>  #include <linux/indirect_call_wrapper.h>
> +#include <linux/freezer.h>
>  #include <trace/events/udp.h>
>  =

>  #include <net/addrconf.h>
> @@ -848,6 +849,10 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk=
, struct sk_buff *skb)
>  		if (encap_rcv) {
>  			int ret;
>  =

> +			/* Drop if we're hibernating */
> +			if (unlikely(pm_freezing))
> +				goto drop;
> +
>  			/* Verify checksum before giving to encap */
>  			if (udp_lib_checksum_complete(skb))
>  				goto csum_error;
> -- =

> 2.56.0
> =



