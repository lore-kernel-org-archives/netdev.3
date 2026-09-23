Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F00E424668;
	Wed, 23 Sep 2026 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189555; cv=none; b=a0uVy0O5CmGGCD4exGMVA5LlagDa+gF96nwpunGYfWmcjwgoKYVbnjt6UUFq36RX0d4jf6Stt6L1Mq7PhgSfy5YxU5qzUkekZmEbiUKRJwS8iW61CflSF3fqT3PosQCgpzjBTnS2BVLxXkdk7lIbxfNNqfkAPBi9VUQBXPP3Dv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189555; c=relaxed/simple;
	bh=o6VNPcEo0cLAHgD8yiZGDuw1f4tKu1q+wyxHGAu7M1w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EFBwGjTxlM0AmkK3SydkM8mG6Scw6r8VcVyTILWjVg3hksZqyQ69elfdxbJkkhkOXx1lbcXNKFP/KVacFI3Kpma3/Udryn4BkhhjDgCS5X529PVpBdTuDczZkW92ym2+m5wa5fNQUqlooetm9LsEb+XCFMDfQYXlWH8FMMmPyn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArPqpY12; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArPqpY12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FA91F000FF;
	Wed, 23 Sep 2026 18:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790189553;
	bh=4639aOZrqqEi//ezkJvyEz3CljUGoz150LNGFfXx00M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ArPqpY12gRzNjbR/BHkXsL//C9aFdr7zedZbOGkMPIs4MGedO/AwT9AB/YE3t7Ykx
	 Arqaa1R9TSvBcXnJYH9juMiAN05hU0J6m4xWmhH7H46lUnHY1I5dgnrVNXWRiPkuQl
	 Rqvp9QCIdTdN733alpsqR5LUDJM+Ab/S5U6cBGFbGxoX1C5Gm7RFYA5IcIGTb3AitE
	 2kywyueS677UV6ecTEbTK4R4U1hMhzIrukXFbY9x6S9g6oNvCvT9sfBd6eJpSauFTF
	 V4zY1bGfpRAuFlJolg86bgegmHAWCNGbHz7Zjos3ppaqSK5PFTWPRakUYzj4FfwhJH
	 +BxG9NunWOk7w==
Subject: Re: [PATCH net-next] net: mctp: add MCTP_OPT_ROUTE_SRCADDR getsockopt
From: netdev-bot+sashiko@kernel.org
To: faizana@nvidia.com
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, horms@kernel.org
Date: Wed, 23 Sep 2026 18:52:32 +0000
Message-ID: <179018955261.2160803.4837007906041522245@kernel.org>
In-Reply-To: <20260921035118.1649687-1-faizana@nvidia.com>
References: <20260921035118.1649687-1-faizana@nvidia.com>
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

- [Medium] In `mctp_getsockopt()` (net/mctp/af_mctp.c:451-452) a
  *successful* route lookup whose resolved source EID is MCTP_ADDR_NULL…
- [Low] The patch adds a permanent MCTP socket ABI but adds no
  documentation to Documentation/networking/mctp.rst (verified: grep for…

--

net: mctp: add MCTP_OPT_ROUTE_SRCADDR getsockopt

This adds a new SOL_MCTP socket option that takes a destination EID and
network in struct mctp_route_srcaddr and returns the local EID the kernel
would use as the source address. The implementation reuses
mctp_route_lookup() and new kunit cases cover the resolvable and
no-route paths.

Link: https://github.com/CodeConstruct/mctp/issues/147

A couple of questions below about the semantics of the new option.

> diff --git a/include/uapi/linux/mctp.h b/include/uapi/linux/mctp.h
> index 19ad12a0cd4b..7c3d4a936861 100644
> --- a/include/uapi/linux/mctp.h
> +++ b/include/uapi/linux/mctp.h
> @@ -55,6 +55,19 @@ struct mctp_fq_addr {
>  #define MCTP_TAG_PREALLOC	0x10
>  
>  #define MCTP_OPT_ADDR_EXT	1
> +#define MCTP_OPT_ROUTE_SRCADDR	2
> +
> +/* Query structure for MCTP_OPT_ROUTE_SRCADDR getsockopt.
> + *
> + * Caller fills in @net and @daddr before calling getsockopt.
> + * Performs a route lookup and returns the local source EID in @saddr.
> + */
> +struct mctp_route_srcaddr {
> +	unsigned int	net;
> +	mctp_eid_t	daddr;
> +	mctp_eid_t	saddr;
> +	__u8		__pad[2];
> +};

[Severity: Low]
Should this new option also be described in
Documentation/networking/mctp.rst?  A grep for sockopt or MCTP_OPT in
that file returns no matches, while the same file documents the other
userspace-visible MCTP interfaces in detail, including
ioctl(SIOCMCTPALLOCTAG) and ioctl(SIOCMCTPDROPTAG) along with their
"other fields must be zero" rules.

The four-line comment here is the only in-tree description, and it leaves
out several behaviours that the implementation has:

- optval is used as both input and output buffer
- optlen must be exactly sizeof(struct mctp_route_srcaddr)
- net == MCTP_NET_ANY is translated to mctp_default_net()
- the resolved net is not written back into @net
- -EHOSTUNREACH when no route exists
- -EADDRNOTAVAIL when the route resolves with no local EID

On the MCTP_NET_ANY case in particular: since @net is left as 0 on
return, how is a caller on a multi-net system supposed to know which
network the returned EID belongs to?  That is the same ambiguity the
deprecation note on struct mctp_ioc_tag_ctl warns about.  Would writing
the resolved net back into rsa.net be reasonable here?

> diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
> index 8af5e2b3c8d1..5c6077e0367e 100644
> --- a/net/mctp/af_mctp.c
> +++ b/net/mctp/af_mctp.c
> @@ -425,6 +425,37 @@ static int mctp_getsockopt(struct socket *sock, int level, int optname,
>  		return 0;
>  	}
>  
> +	if (optname == MCTP_OPT_ROUTE_SRCADDR) {
> +		struct mctp_route_srcaddr rsa;
> +		struct mctp_dst dst;
> +		unsigned int net;
> +		int rc;
> +
> +		if (len != sizeof(rsa))
> +			return -EINVAL;
> +
> +		if (copy_from_iter(&rsa, len, &opt->iter_in) != len)
> +			return -EFAULT;
> +
> +		net = rsa.net;
> +		if (net == MCTP_NET_ANY)
> +			net = mctp_default_net(sock_net(sock->sk));
> +
> +		rc = mctp_route_lookup(sock_net(sock->sk), net, rsa.daddr, &dst);
> +		if (rc)
> +			return rc;
> +
> +		rsa.saddr = dst.saddr;
> +		mctp_dst_release(&dst);
> +
> +		if (rsa.saddr == MCTP_ADDR_NULL)
> +			return -EADDRNOTAVAIL;

[Severity: Medium]
Is this -EADDRNOTAVAIL consistent with what the output path does for the
same lookup result?

mctp_route_lookup() in net/mctp/route.c deliberately accepts
saddr == MCTP_ADDR_NULL for a direct route, and only rejects it once a
gateway has been traversed:

	if (rt->dst_type == MCTP_ROUTE_DIRECT) {
		mctp_eid_t saddr;
		...
		saddr = mctp_dev_saddr(rt->dev);

		/* cannot do gateway-ed routes without a src  */
		if (saddr == MCTP_ADDR_NULL && depth != 0) {
			mctp_dev_put(rt->dev);
			break;
		}

		if (dst)
			mctp_dst_from_route(dst, daddr, saddr, mtu, rt);

So for a direct route at depth 0 the lookup succeeds with dst.saddr == 0,
and mctp_local_output() then uses it without complaint:

	hdr->dest = daddr;
	hdr->src = dst->saddr;

That state is exercised today by the existing kunit case
mctp_test_route_output_direct_no_eids, where transmit over a direct route
with no local EID is expected to succeed.

So if a direct route exists to daddr on a device with no local address
assigned, sendmsg() transmits with src EID 0 while this new option
reports -EADDRNOTAVAIL.  Does that conflict with the commit message
claim:

    the kernel performs the same route lookup used for actual packet
    output and returns the resolved local EID in saddr

If returning an error for the unassigned-local-EID case is intentional,
could the commit message and the uapi comment say so, and could a kunit
case be added for it?  Neither of the two new cases covers a successful
lookup that yields MCTP_ADDR_NULL.

> +
> +		if (copy_to_iter(&rsa, len, &opt->iter_out) != len)
> +			return -EFAULT;
> +		return 0;
> +	}
> +
>  	return -ENOPROTOOPT;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921035118.1649687-1-faizana%40nvidia.com
