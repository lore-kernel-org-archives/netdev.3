Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461231;
	b=ijQKAFjLSWXHDNxBb22Cm1gj8K4DJyXTacOmJqkgWj9Hqk+zPiEfegT7JrpeP1n1Rzns
	 eoY2VJ5Rmnb3GNf4deRho3qIza9KWarTi0SDVUNxbaoSYoljnv+WbH/Ef2A4zkbGf/h67
	 yodxStOa/bIljmfq9bdCFbib7XtXb4tlvgkp0X40Oan9CvPNbwrn7mmYJey9ncBDxA9b1
	 qyCDN5fBO0a/VKzQRnozRuunlxZFKVIhGQt3VTed+wwY3NzWtdEy5mCDBgBl/b+n2EHG/
	 D92QkXOsFD6Sno5ZLmOyv6D35vQpO2L7NZu6ttysEmDrw31Xf+RWYQAvOod15/wgWew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461231;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9B9aHI7CTnJRvYzyQgWJoI5tIJm51UEzU3a0DQvkTkI=;
	b=kH/Fs9dVC4HPXhGnlSZGCFfaoqPK7yJ6V9i0hAZAWQoaF3c2/TobfiWv4M27xXxGhXzm
	 H6VzPHt8cRdnYkTlKgKp78PZOVAVr8rEJ8SZXeuX3mMFHmOPkUijY13ugtokrn2786rv+
	 kf8UIagyEbGsD1NqNi1OlgUCNIzux7YB9s3eFn/k2qe3lgm+7TLKwqQvbYE6PL3l7BRpO
	 KV2HMD/IronqXPYx/oVj92owLQsKd1SLdt5Lu56RyvWBmYj6eR/paM5+16cUs0l3Mu9KH
	 NbDLGo6JaBTGMroKvFgAPcjKJeAUXb3/QVYOX7O/GE68Kdbln66jafCY+nI2I5nJonA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehgBor7+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1651F606A32D;
	Thu, 12 Nov 2026 05:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehgBor7+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06571F00A05;
	Thu, 12 Nov 2026 05:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794461230;
	bh=9B9aHI7CTnJRvYzyQgWJoI5tIJm51UEzU3a0DQvkTkI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ehgBor7+9XDPYuszEu9PXxGOc01rifIdjVjUr8tuVUSHU2WOo+iyk3XGdKn3Vj0qP
	 GDUnLGjyKko5Zo1g5XslGiG0SVIDwPVpujet2PiaOE7r2wTjm+3he6pQjduIHvz61L
	 sB0oIHxKzPrcTAdIgUG3bzImgWowI55o925HSn2+cJqbFLXr7OyZFVoSRbJKSTwwPD
	 6bMCAXhi/NM3eo0PO2enCntp0xdokX7Az71KWAeeQoczNvNhwE64MigOG87uVbNmTo
	 y0I7pbpSJUp0UABtrKHyd+9tvlbRS6qPxt19CuiGfAKcTIJFLP2zVNPMFzPWrcnxJg
	 apnEhPOMhG8yA==
Subject: Re: [PATCH net v2 1/3] rtnetlink: return EMSGSIZE when first dump
 entry does not fit
From: netdev-bot+sashiko@kernel.org
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, idosch@nvidia.com, sd@queasysnail.net,
 sdf.kernel@gmail.com, parri.andrea@gmail.com, nickgarlis@gmail.com,
 willemb@google.com, linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 05:27:09 +0000
Message-ID: <179446122919.2199510.14139950363270003881@kernel.org>
In-Reply-To: <20261110172925.3293312-2-stephen@networkplumber.org>
References: <20261110172925.3293312-2-stephen@networkplumber.org>
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

- [Low] The concern: in rtnl_dumpit() (net/core/rtnetlink.c), this patch
  only turns an err == -EMSGSIZE returned with an empty skb into an…

--

rtnetlink: return EMSGSIZE when first dump entry does not fit

This patch changes rtnl_dumpit() for handlers registered with
RTNL_FLAG_DUMP_SPLIT_NLM_DONE. With the patch, an -EMSGSIZE return on an
empty skb is passed back to user space as an error and is no longer
dropped. Before, a first entry too large for the initial NLMSG_GOODSIZE
skb ended the dump with NLMSG_DONE and status 0.

> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index e141340172ce3..2777796a4ed2c 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -7043,7 +7043,10 @@ static int rtnl_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>  	 * Some applications which parse netlink manually depend on this.
>  	 */
>  	if (cb->flags & RTNL_FLAG_DUMP_SPLIT_NLM_DONE) {
> -		if (err < 0 && err != -EMSGSIZE)
> +		/* -EMSGSIZE with nothing in the skb is an error, as returning
> +		 * a length of 0 would end the dump as if it was complete.
> +		 */
> +		if (err < 0 && (err != -EMSGSIZE || !skb->len))
>  			return err;

[Severity: Low]

Does this also cover the IPv6 route dump? inet6_dump_fib() is registered
with RTNL_FLAG_DUMP_SPLIT_NLM_DONE too, but it does not use -EMSGSIZE to
report that a route did not fit.

When the first route does not fit, rt6_dump_route() returns 0, and
fib6_dump_node() turns that into a positive return:

net/ipv6/ip6_fib.c:fib6_dump_node() {
    ...
		res = rt6_dump_route(rt, w->args, w->skip_in_node);
		if (res >= 0) {
			/* Frame is full, suspend walking */
			w->leaf = rt;
			...
			w->skip_in_node += res;

			return 1;
		}
    ...
}

inet6_dump_fib() passes that positive value back up. With err > 0, the
new check above never fires, and rtnl_dumpit() still reaches
"return skb->len" with skb->len == 0.

With only this patch applied, would an oversized IPv6 multipath route
still end the dump with NLMSG_DONE and status 0?

The AF_UNSPEC path has the same dependency. rtnl_dump_all() ends with
"return skb->len ? : ret", so it only reports an error if the IPv6
handler returns -EMSGSIZE.

The next patch in the series, "ipv6: return EMSGSIZE when first route in
dump does not fit", appears to close this gap. It adds the following to
inet6_dump_fib():

	if (err > 0 && !skb->len)
		err = -EMSGSIZE;

The selftest "selftests: net: netlink-dumps: test dump of route larger
than skb" also checks both AF_INET and AF_INET6.

The commit message here says in general terms that an oversized route
entry silently truncates the dump. Could it say that this patch only
fixes handlers that return -EMSGSIZE, and that the IPv6 case is fixed
by the following patch?

>  		if (!err)
>  			cb->data = NULL;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110172925.3293312-1-stephen%40networkplumber.org
