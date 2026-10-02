Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FA43A6EEC;
	Fri,  2 Oct 2026 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937143; cv=none; b=lNUnJMARrd6MNhJq6YJwxtWANtyh+aI3O+rf+prrgh2jHNtflA/ZCvPh+joyx/8XO+E3DP1/Po6yR8SJGHG4PjdvR8v9eMTuUagIFrXGWbhSAHfXs4S8lXEKqDJvvLNLMkoVWGmNe+6NxZbUfZ6GW/SZ1UZW3UjGhlEoNlFNUJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937143; c=relaxed/simple;
	bh=eRHIKZcQnKf0B8Tu2YmmigVBVcF+saAZUYZ86/FOS70=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dIlcKCfJ4cZEakZMm98nQKsl15ihqxXsvLbKkic4wX7GucawVQN0oQTwjYgmINDC8lt8sxYByN8blfsV7OaV1/B4C9AlvL1srQ9v/sulM0IYTdWLQ8fafgvvH0YXym/FiedUy4ZIAFj77JkyCXnfCIqEDsQXb27k0/1VOOHiecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXbspOYZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXbspOYZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02741F00893;
	Fri,  2 Oct 2026 10:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937142;
	bh=mIgrCRqNqoulTv8TgjE8sDNWzid24V3HhfhVX5t/Nd8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bXbspOYZCecMbcXO7Hz/GfetZwS8kz+BrGbY72DPOQHuc/AsdJoRhN3N+/VQ01NH5
	 LjxB3wsL3S9EnbKZRMIKCR3pbSvxvCNa0CCWz281nk2JpxKMT8LEOvP6XEvhRxqLwK
	 o8zsQktfOkykJPmesWCU5uvhjkHzjjr2f3wEj45wmI21j3ZN01bNc/7YI2DVxYeyqr
	 TQ9uxpAuoAftvJwS+HdyF/N+ipV4rgJPmG5SQELnoD5sHuJaqtv/9TfD7YE1Q+dVfc
	 b0ZkiJNUN90+Udv2xZnNFJHthRVTeh9rZmjnc4Rfj8j74MXaOxjUrzvQdgqgV1gNV7
	 KSUe6URO3IZQw==
Subject: Re: [PATCH 05/16 net-next v2] ipv4: raw: split IPv4 specific logic
 into raw_ipv4.c
From: netdev-bot+sashiko@kernel.org
To: fmancera@suse.de
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 edumazet@google.com, ebiggers@kernel.org, ardb@kernel.org, krzk@kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 10:32:21 +0000
Message-ID: <179093714143.434549.2001403334246591455@kernel.org>
In-Reply-To: <20260928193046.6698-6-fmancera@suse.de>
References: <20260928193046.6698-6-fmancera@suse.de>
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

- [Low] The new file net/ipv4/raw_ipv4.c exports raw_v4_match() with
  EXPORT_SYMBOL_GPL(raw_v4_match) at line 60, but it never includes…
- [Low] The move is incomplete and leaves dead code in net/ipv4/raw.c.

--

ipv4: raw: split IPv4 specific logic into raw_ipv4.c

This commit moves the IPv4 specific RAW socket code out of raw.c and into
a new file, net/ipv4/raw_ipv4.c. That covers packet matching,
input/output processing, ICMP filtering and the AF_INET raw_prot
definition. raw_ipv4.c is built only with CONFIG_IPV4, and raw_lookup()
in raw_diag.c now guards raw_v4_match() with IS_ENABLED(CONFIG_IPV4).

> diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
> index 9d01006d8189e..dcd554d920825 100644
> --- a/net/ipv4/raw.c
> +++ b/net/ipv4/raw.c

[ ... ]

> @@ -48,31 +47,25 @@
>  #include <linux/sockios.h>
>  #include <linux/socket.h>
>  #include <linux/in.h>
> -#include <linux/mroute.h>

[ ... ]

>  #include <linux/rtnetlink.h>
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
> -#include <linux/netfilter.h>
> -#include <linux/netfilter_ipv4.h>
>  #include <linux/compat.h>
>  #include <linux/uio.h>
>  

[Severity: Low]
This isn't a bug, but some leftovers from the move seem to remain in
raw.c.

Just below this include block, raw.c still has its own copy of the
struct:

net/ipv4/raw.c:
    #include <linux/compat.h>
    #include <linux/uio.h>

    struct raw_frag_vec {
    	struct msghdr *msg;
    	union {
    		struct icmphdr icmph;
    		char c[1];
    	} hdr;
    	int hlen;
    };

    struct raw_hashinfo raw_v4_hashinfo;

All users of struct raw_frag_vec (raw_probe_proto_opt(), raw_getfrag()
and raw_sendmsg()) now live in raw_ipv4.c, which adds an identical
definition. Could the raw.c copy be removed, so the two private
definitions can't drift apart?

Also, <linux/compat.h> stays in raw.c. Its only user was
compat_raw_ioctl() via compat_ptr(), which has moved to raw_ipv4.c.
<linux/sockios.h> is also still included, although the SIOCINQ and
SIOCOUTQ handling moved out.

The other includes that are no longer needed (asm/ioctls.h, mroute.h,
igmp.h, icmp.h, xfrm.h, netfilter*.h) were dropped. Should these ones be
dropped as well?

[ ... ]

> diff --git a/net/ipv4/raw_ipv4.c b/net/ipv4/raw_ipv4.c
> new file mode 100644
> index 0000000000000..8d3d6f30b0e80
> --- /dev/null
> +++ b/net/ipv4/raw_ipv4.c
> @@ -0,0 +1,883 @@

[ ... ]

> +#include <asm/ioctls.h>
> +#include <linux/igmp.h>
> +#include <linux/mroute.h>
> +#include <linux/netfilter.h>
> +#include <linux/sockios.h>
> +#include <linux/stddef.h>
> +#include <linux/types.h>
> +#include <net/icmp.h>
> +#include <net/ip.h>
> +#include <net/raw.h>
> +#include <net/sock.h>
> +#include <net/udp.h>
> +#include <net/xfrm.h>

[ ... ]

> +bool raw_v4_match(struct net *net, const struct sock *sk, unsigned short num,
> +		  __be32 raddr, __be32 laddr, int dif, int sdif)
> +{

[ ... ]

> +	return raw_sk_bound_dev_eq(net, READ_ONCE(sk->sk_bound_dev_if),
> +				   dif, sdif);
> +}
> +EXPORT_SYMBOL_GPL(raw_v4_match);

[Severity: Low]
The new file uses EXPORT_SYMBOL_GPL() for raw_v4_match(), but
<linux/export.h> is not in the include list above. raw.c included
<linux/export.h> directly, and still needs it for raw_v4_hashinfo.

In W=2 builds, check_missing_include_linux_export_h() in
scripts/misc-check flags files like this one:

    warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing

Would it make sense to add #include <linux/export.h> to raw_ipv4.c, so
this new file doesn't bring in an extra W=2 warning?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928193046.6698-1-fmancera%40suse.de
