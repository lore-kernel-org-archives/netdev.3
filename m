Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792451117;
	b=Z4LVgAbNSA5GPSiuA84iigcSR0lt3ov1q4XHEJS6oVNLtxJcYrkeHMbuq2cJCs91mRj4
	 hVjLxsZtFuweCWwMpxsuE7IydQMSXh2AUfIazhV2X1c+uDHZnISJfoFaUrA8s/GTlqTpP
	 qWvW2JPz/JBjLc0R3EAZ3Qc5W32ZS4mYGHg4U9Ws9n/tKFSAIxSNyLBdTt4xAGffeuAMn
	 0k/jgnN34kIIP0PSUd9xINHSMOx5AvHRreHtvh7714pyAdrqU80BNe4jK6efEqs35cSmt
	 YaNs/R5ie8yp3f3uP5MAXPldOeP6W9x97TDTaonipfKgxlx0GP2WCLon9++3gekafRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451117;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:Date:
	 From:To:Cc:Subject:Message-Id:In-Reply-To:References:X-Mailer:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=4ZrW2XDhJ1ZSsjZ8zayT53/LSqDZun16ck0JO1KEWzA=;
	b=pKbeWLDJfgoHf8/cEVrw41xd2mmKHd00LjpU79TLgmDEI9zVdE3R8GWxfCtwXFcKfZKV
	 6bN9mfdFOdUKjoAQegEz55tLgfEat/uCXiTjWy+rKuvHHkUJ99y0aWy8/bFzrHdMo7Rpu
	 IiQr2QFMnP0IJxBHC89RlgPRhDHLbQtDdutS0EBCP9eHdQA38wsVFWKaxwPm/NZy7HBt4
	 zEOFg8L9I86umz8FhBHMCAfr8Bq9aLj57EpfK7uc4i9gAcTXt8Sf1RBGXXN35dz/FGdTx
	 6YWn6qK/QXNpOHSPj5OWJd65OqR1TfJQhjC4xIifHQYQ6i6jfiRJgFSkPENV3hHKnIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=BQXXBn08;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=mDptg2QS;
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A683606A31A;
	Mon, 19 Oct 2026 23:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A683606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=BQXXBn08;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=mDptg2QS
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 69JN4Zcu002830;
	Tue, 20 Oct 2026 01:04:40 +0200
Received: from lubuntu-18.04 (host-79-32-222-240.retail.telecomitalia.it [79.32.222.240])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 1F7A51228F2;
	Tue, 20 Oct 2026 01:04:29 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1792451070; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZrW2XDhJ1ZSsjZ8zayT53/LSqDZun16ck0JO1KEWzA=;
	b=BQXXBn08cWJ6LYVhQiP5a7WodtxyDFokJES7fatk1PdARsJu8KDIAVmpRffwy2EvuO8F1M
	FCpYIZk9TGG+m1Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1792451070; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZrW2XDhJ1ZSsjZ8zayT53/LSqDZun16ck0JO1KEWzA=;
	b=mDptg2QSjG3RCKHR1TS6GScTC/24vLpuPn3Q985dUpvsmG1D59VdDh6f7EB6iHtqduw7Sp
	JbFnOAIwS3INjIKxfOy+Yf9LafO/iXBo2qYZIQ2qGcRfaiNbMTsiLJ8ncPX/VWYIsBs24K
	3m3OS+0aaFrHRA8zlzyxqIx6956IVn3BTzGT0bPjwJQ5abEXppJnYqoEskv6TGizjXXMa6
	Xjtr5N7dLxUm4ICPoWi/1IC3tQVDdPvh+RXcXX6p5v0ZXtePWgoLx/hMWtPriQbsZEhtlw
	iIqEE1ypKgbjFPaHmBkH9zZrjKg4JkQX9Z4FGhsf/INGvtV6PCe79A45ZK5+NA==
Date: Tue, 20 Oct 2026 01:04:29 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gabriel Goller
 <g.goller@proxmox.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net-next v3 1/2] seg6: skip the route refcount in
 seg6local IPv6 lookups
Message-Id: <20261020010429.eeffd6f140ec6157609c310a@uniroma2.it>
In-Reply-To: <20261015-seg6-lookup-noref-v3-1-6d51a60a67d3@gmail.com>
References: <20261015-seg6-lookup-noref-v3-0-6d51a60a67d3@gmail.com>
	<20261015-seg6-lookup-noref-v3-1-6d51a60a67d3@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Thu, 15 Oct 2026 23:39:27 +0900
Yuya Kusakabe <yuya.kusakabe@gmail.com> wrote:

Hi Yuya,

Thanks for v3 and considering my comments.

> [snip]
>  		if (!table)
>  			goto out;
>  
> +		if (noref)
> +			flags |= RT6_LOOKUP_F_DST_NOREF;

Even with the change below, the "out:" branch still takes a reference when
fib6_get_table() returns NULL, because RT6_LOOKUP_F_DST_NOREF is set only
after that call. Setting RT6_LOOKUP_F_DST_NOREF before fib6_get_table(),
inside the table branch, would avoid that reference too. The oif branch
needs the flag clear, because ip6_route_output() returns the dst with a
reference.

> [snip]
>  		rt = net->ipv6.ip6_blk_hole_entry;
>  		dst = &rt->dst;
>  		dst_hold(dst);
> +		flags &= ~RT6_LOOKUP_F_DST_NOREF;
>  	}

With this patch applied, the end of seg6_lookup_any_nexthop() reads:

out:
	if (!dst) {
		rt = net->ipv6.ip6_blk_hole_entry;
		dst = &rt->dst;
		dst_hold(dst);
		flags &= ~RT6_LOOKUP_F_DST_NOREF;
	}

	skb_dst_drop(skb);
	if ((flags & RT6_LOOKUP_F_DST_NOREF) && !dst->rt_uncached_list)
		skb_dst_set_noref(skb, dst);
	else
		skb_dst_set(skb, dst);
	return dst->error;

After a noref lookup, the "out:" branch still takes a reference on
ip6_blk_hole_entry and then clears RT6_LOOKUP_F_DST_NOREF.

This branch can be taken at steady state. The noref lookups, except the
ones in input_action_end_dt6(), run with local_delivery false. For example,
with End and a next segment that is a local address of the node, the lookup
returns a local route, seg6_lookup_any_nexthop() discards it, and every
packet takes and drops a reference on ip6_blk_hole_entry in the "out:"
branch. The commit message describes the same pattern for ip6_null_entry.

For a blackhole rule, __fib6_rule_action() picks ip6_blk_hole_entry and
takes no reference on it when the lookup has RT6_LOOKUP_F_DST_NOREF. The
"out:" branch could do the same, for example:

	if (!dst) {
		dst = &net->ipv6.ip6_blk_hole_entry->dst;
		if (!(flags & RT6_LOOKUP_F_DST_NOREF))
			dst_hold(dst);
	}

RT6_LOOKUP_F_DST_NOREF then stays set, and the skb_dst_set_noref() at the
end of the function attaches ip6_blk_hole_entry without a reference. The
line that clears RT6_LOOKUP_F_DST_NOREF is removed as well.

What do you think?

Nit: seg6_lookup_any_nexthop_noref() and seg6_lookup_nexthop_noref() can
attach the dst without a reference. They rely on being called under RCU. A
one line comment about this, like the one ip6_route_input() has, could help
the next reader.

Ciao,
Andrea
