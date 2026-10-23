Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792731134;
	b=Vqsz8wQ6r7mxzhRh0/TQrLYQD61eC0/ymtEMM3dBSf4Te589gk0GR0lSLk87YlM9rJ8w
	 2LYDEqlJnq4UTurqE9lStKtzqt73VRLdhW8539vshQZ9hVuN0sVzPstV+3qbuyRDVhBrC
	 ukSvQMKo4cLcKxkH8eG55rLoTru/EhCFIF/zeS8MRprSTm13ivXCfPtE0XBCBlt98ma37
	 yHkr1dZTsKijiXDEFBmbLGyryRWeETEj+ggxLJAUhiBlRijs0daHERWH6O2xFmXlKcnhb
	 yuMiciaJ3VgKDKMw916kfWi8hVuUVmK+Nlg5MKPXLCm952nwW6xTTGdBCo5fqm70rUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792731134;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=azFOvOpPS9RZ120HsX52bxdBzg8kjxW7KcH0FOk6vxc=;
	b=dt4Rvy32mzccGOCZFgnabi/jdJYO7RXfwax8d+v6+FE16ru7hjCCO17Tenaw0lmhpUaI
	 1tf8tSE7gUjd4Kbu4pjGGWOBBOI614aBb3QCH138e7AIo+O/5CJcRJbogaeDc+Hc9PaMe
	 AqfiCN3YMyvmqEKvP2YYwmqaSrO7IAkb0cV7iYcVUrCj4CSXY61U73l1VnIwvdqNMAxzB
	 RPAT7wXWQaGRU/vHUZKjJ7JQlEFGmbbCpDmg/jwoLfSIi4f6XLoYvY8yRv0PeVyj2HTvT
	 1QZgJl2YtCmHIWPzT9sFQLxW2hQhcJh47U++z0V5GVTIentZrsg5oq8sjOaIjoSWxSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7NZQ8FF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3938E606A335
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7NZQ8FF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050741F01829;
	Fri, 23 Oct 2026 04:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792731133;
	bh=azFOvOpPS9RZ120HsX52bxdBzg8kjxW7KcH0FOk6vxc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O7NZQ8FF6U3UOuTimWTmvUqmaQtqyLVbAEyVmIZaqkfWBBzHNo/Sue+FKa7kvDag9
	 nGpldSZO1RJeeeO4F/b6JyTA5GuQmwtOwKX2YAnRMGYPqKutIrABrHEG0WyLHhbOPa
	 Kcv1pUAXpm4ncNeD8z3Pk1V28XYa9S70hu7aQYRvmMt7qgz/g45PKhuwHFJk3/nqAQ
	 VA98nDMzOYmNGgDL/T48hpGLBUc4Fdk+jhHa7I5JOXrCF+tquW7nfEyu+ilOBrGK8q
	 PTczCVynq1BGOc3PQKef6MlH8AGHhHHFgfz+ZtkZDeft78f0gAmzpMsD9QViEHZ3af
	 YvoC9799xvoew==
Subject: Re: [PATCH net-next 14/15] net/tls: don't BUG() on leftover length in
 __skb_nsg()
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, jgross@suse.com,
 sstabellini@kernel.org, willemdebruijn.kernel@gmail.com, fmancera@suse.de,
 almasrymina@google.com, david.laight.linux@gmail.com, netdev@vger.kernel.org,
 xen-devel@lists.xenproject.org
Date: Fri, 23 Oct 2026 04:52:12 +0000
Message-ID: <179273113257.3134.13391569696975669516@kernel.org>
In-Reply-To:
 <20261019-b4-skbuff-bug-on-followups-v1-14-41dbef50b9f7@toxicpanda.com>
References:
 <20261019-b4-skbuff-bug-on-followups-v1-14-41dbef50b9f7@toxicpanda.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In net/tls/tls_sw.c, the comment above skb_nsg() is now out of
  date.

--

net/tls: don't BUG() on leftover length in __skb_nsg()

This patch replaces the BUG_ON(len) in __skb_nsg() with a
DEBUG_NET_WARN_ON_ONCE() and an -EINVAL return. A range that runs past
the end of the skb now fails the record in tls_decrypt_sg() instead of
crashing the kernel.

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 312e51270f29..1c578ea47a1b 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -142,7 +142,10 @@ static int __skb_nsg(struct sk_buff *skb, int offset, int len,
>                          start = end;
>                  }
>          }
> -        BUG_ON(len);
> +	if (unlikely(len)) {
> +		DEBUG_NET_WARN_ON_ONCE(1);
> +		return -EINVAL;
> +	}
>          return elt;
>  }
>  

[Severity: Low]
This isn't a bug, but should the comment above skb_nsg() be updated to
cover the new return value? The comment directly below this hunk still
says:

net/tls/tls_sw.c:
/* Return the number of scatterlist elements required to completely map the
 * skb, or -EMSGSIZE if the recursion depth is exceeded.
 */
static int skb_nsg(struct sk_buff *skb, int offset, int len)
{
        return __skb_nsg(skb, offset, len, 0);
}

skb_nsg() returns whatever __skb_nsg() returns. The recursive frag_list
calls also pass negative values straight up:

    if (unlikely(ret < 0))
            return ret;

So skb_nsg() can now return -EINVAL when the skb runs out before the
requested range does.

The only caller, tls_decrypt_sg(), already handles any negative value:

    if (n_sgin < 1)
            return n_sgin ?: -EBADMSG;

So this doesn't change behavior at runtime.

The comment is also still unchanged at the end of the series, including
after the last patch, "net: update comments that still describe the skb
BUG_ON()s".

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7%40toxicpanda.com
