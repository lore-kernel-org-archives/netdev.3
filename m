Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F7B4C225E
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792330309; cv=none; b=sZAV7AgkwBbTwAsTttXgZ+M1xwmoRuDpoNpoY2Csellq6ygMttbUvC7b4bJg6efZ8npzTFQ2JXioFllkgmDDT/zivDETpOJvyOIe5OxTtF2m4lyVXXk9kqJqeiqrjyOzph3vDG2M2kJCCFNa9/uPAI09BcETNExQxqqDB3Q0pBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792330309; c=relaxed/simple;
	bh=XaBaNJOIr2VqStywvy/9xoTCulp5zfETL6K/LDUmyNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvIosn8u3WzAGYdFPqDdwLO3/R/Sxc1iwDFZXvpyFSK5RPGXn5hUqEM9uOhUYTVE7NxfB7B50w2b3opiUCP3ckRTySCV65MPjBx9ITh2rBKLjrog2RNXlWg41dYDWyy8ey8dosfbiCaYtqVP7OZxXZa63yKqJbOOVzXiNTqd3aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mihkTFLP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mihkTFLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C162D1F000C4;
	Sun, 18 Oct 2026 13:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792330308;
	bh=BEZ90WQpiUEzi8ylRYGE9MccVTzQK3GEFkgglW6m7cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mihkTFLPwXsVsV1CWRk4GUpHgyTx9zjA6tCbkV9/95+yXPEAu3uQ6PZ9V9W0W7Usn
	 PUtEFyVXzS+IpRkXUhGdcthxpRUwvdkH0/iivMaH8kiHXsYM0f9k+H/eq+DjWnbxE0
	 xsjN7ffXG64a4WF1aQymH43ahufKKUGUE7nuKh/Fu3z/zLiMMy7V3YQkGxr7aJ+mZJ
	 IbGZl8QyRKdvNRY+V8BcsIb/Eo4O96J+FWQ1yBP53aFMWB9uu3QVU1LHN2FkpFNaA0
	 vS6LZ9/GlamgItS8xPQ9Vu70mFFtIqcaJ6U5e1mxiGaX4hlztex3gx588Hk7elocTv
	 K84RSADs912uw==
From: Simon Horman <horms@kernel.org>
To: weir@nebusec.ai
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	courmisch@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	remi.denis-courmont@nokia.com,
	vega@nebusec.ai,
	rakukuip@gmail.com
Subject: Re: [PATCH net 1/1] net: phonet: ensure headroom for aligned GPRS TX
Date: Sun, 18 Oct 2026 14:31:28 +0100
Message-ID: <20261018133128.515871-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <eeacc6bb1a121b6161c38898441997ea4641e5c0.1791616268.git.rakukuip@gmail.com>
References: <eeacc6bb1a121b6161c38898441997ea4641e5c0.1791616268.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/eeacc6bb1a121b6161c38898441997ea4641e5c0.1791616268.git.rakukuip@gmail.com?part=1
---
net: phonet: ensure headroom for aligned GPRS TX

This commit adds a skb_cow_head() call in pep_write() on the aligned pipe
path. It makes sure the skb forwarded from gprs_xmit() has enough headroom
before pipe_skb_send() and pn_send() push the pipe and Phonet headers. If
reallocation fails, the skb is dropped and -ENOMEM is returned.

Closes: https://bugtracker.nebusec.ai/f/1935

> diff --git a/net/phonet/pep.c b/net/phonet/pep.c
> index bd1cdd00edfa5..9d24b370fb7c0 100644
> --- a/net/phonet/pep.c
> +++ b/net/phonet/pep.c
> @@ -1259,8 +1259,13 @@ int pep_write(struct sock *sk, struct sk_buff *skb)
>  	struct sk_buff *rskb, *fs;
>  	int flen = 0;
>  
> -	if (pep_sk(sk)->aligned)
> +	if (pep_sk(sk)->aligned) {
> +		if (skb_cow_head(skb, MAX_PNPIPE_HEADER)) {

[Severity: Medium]
Will this reallocate the head of almost every packet on the aligned GPRS
path?

MAX_PNPIPE_HEADER expands to a large value:

include/net/phonet/pep.h:
#define MAX_PNPIPE_HEADER (MAX_PHONET_HEADER + 4)

include/net/phonet/phonet.h:
#define MAX_PHONET_HEADER	(8 + MAX_HEADER)

That is at least 44 bytes, and up to about 188 bytes depending on config.

The GPRS netdev does not advertise any headroom, though. gprs_setup() in
net/phonet/pep-gprs.c sets:

	dev->hard_header_len	= 0;

and never sets needed_headroom, so LL_RESERVED_SPACE() for the gprs device
is 16.

For locally generated IPv4 datagrams, __ip_append_data() uses
hh_len = LL_RESERVED_SPACE(rt->dst.dev) and calls skb_reserve(skb, hh_len).
ip_finish_output2() does not expand the head either, because the gprs
device has no header_ops.

So UDP, ICMP and raw packets arrive here with 16 bytes of headroom:

udp_sendmsg()
  __ip_append_data()        /* skb_reserve(skb, 16) */
  ...
  ip_finish_output2()
    gprs_xmit()
      pep_write()
        skb_cow_head(skb, MAX_PNPIPE_HEADER)
          __skb_cow()
            pskb_expand_head(..., GFP_ATOMIC)

Before this patch, those packets had enough room for what is actually
pushed and did not crash: the 4 byte pipe header, the 7 byte phonethdr,
and the lower device's link header. Many skbs forwarded from ordinary NICs
also fall below the new threshold on common configs. Only paths with large
reservations, such as TCP's MAX_TCP_HEADER, avoid the copy.

With this change, the zero-copy path from fea93ecef619 ("Phonet: zero-copy
GPRS TX") copies the head in the common case. That makes it more expensive
than the non-aligned path, which only allocates a small wrapper skb and
chains the payload through frag_list.

The commit message describes the check only as a guard for unusual skbs,
such as ones redirected from veth, and does not mention this effect.

Would it be better to set dev->needed_headroom in gprs_setup() (for
example to MAX_PNPIPE_HEADER)? The stack would then reserve the space up
front, and skb_cow_head() would only be a rarely taken safety net.

> +			kfree_skb(skb);
> +			return -ENOMEM;
> +		}
>  		return pipe_skb_send(sk, skb);
> +	}
>  
>  	rskb = alloc_skb(MAX_PNPIPE_HEADER, GFP_ATOMIC);
>  	if (!rskb) {
