Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A108C23EAAD
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 04:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792210404; cv=none; b=razMKcaOxCVq81C6JSn0hSXfJYIUzljxdwRAQn0eafEoxekfTGqD+kwUgTihLfYpU9c4QjvNET77y9ILxD/MdIhID4d8ANaJxOgnSx12FMO5sshIuIGLx0COjcpJc6NNVUsYrDLTu3e8bA1X5sCLf+KQJ4zaUra1Az1bEsmy0ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792210404; c=relaxed/simple;
	bh=80xxcsjvazoZ6qrFihdhX90/aRzMkbzpyGInQW/HkjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ab0jc73arWsrMCgINiuKURQhNAyf8ZMb/UUR+zjcu/tAk6UYG4lPi5B8cP0ODxj50mdYwSR2BNBRUcDI4I0m/pyHvvufBfzEaDU+tNC3OMlQoNXJ/DVLVD3rfAu87uhn8BfqmoomIOzEi4suEkToRCupy3nQoIacQlJAY2GVSOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=US8uIJ21; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="US8uIJ21"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8862ed0539dso625128b3a.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 21:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792210403; x=1792815203; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v2y/29nEZ1+RyY4h3lX7WuFyj3Qa08G+UrHqtr25/C4=;
        b=US8uIJ21+E+M+X7RvvKdaJdJtYw1tHuMMvWhJKkCmbcMe3zZwFBrrGbgf8weDLSf7P
         8Dm0Q3qrDFM/NR123Rf1wc+iN85L3bZoeBxhqCSKsXravReNRfPCmRId0SoCmNaiv+jV
         MwbuP1N1NioPdp5ymEIwqUdALUJPTRljGfv4HwNeA91mii2MgXqYBb+lNx7UJwvL2nC7
         /bU9+vdESdMQB6TbWG+5Bk4AYtPKfM4Ok5H6E7dlwVPFcXtTdc66DgwZA7uCGhXNgCIu
         j7NkOYrkn0J9o3vYF9CP9BozEOGdDzPA056UQLA4uQA729MJLDSRCmXKJbqBFoIybwAL
         nOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792210403; x=1792815203;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2y/29nEZ1+RyY4h3lX7WuFyj3Qa08G+UrHqtr25/C4=;
        b=IEVJSZktpbNmrjL7wIt+dhmgluHj2GgiIN4G6/pW0TbMK5HMIaPlRjcJRaJcC0rVZM
         KuUM8rUyOmVXMKhYvxD5jzSgWFp1vgdJ+fOPf0kTCEoJM1lsIDJPk8AL4Lp1hMIii8gE
         17e5ijIQ5V1TdjQ8m8SMTBDGB5XJEQE8SVXKMpoqbi72/XlM1PYEpXaAuRYPT4m8pGFa
         XQNUfzpOwfEFrY4aspmgNWjRtdtTTwcT7msQm978uinNJJ7g9KDzWMkzyREEb9+gM/FP
         R4rvVEKllOwstDMgtw+hbCE6eyu/PKOinHQLeUeTuwjDk0wxtNV0l7Wod4vOzdZUG/Iu
         kdXA==
X-Forwarded-Encrypted: i=1; AKwUvBwKENKwc1o8qI27bZzxhXezg7JZlrwNQM+PdRhDZT4QIs9VZ6aOR19AlxcpfCznfa9k1b6HHVg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVVUdq+bEgfyBzAB+QIYykk0PKcbxzq3a1y1z5nzZJzK9/SS9O
	Z56sMQJIJz/NeK9WWFx9qsXbfWqHE2gJxo1/R799EfH4qCIHYtMoAOPaZ9lxGJLcsEFKdNirbuP
	LvjdbNw==
X-Received: from pfbhw24.prod.google.com ([2002:a05:6a00:8918:b0:89e:a4f5:3f5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4acd:b0:89f:1b32:29a5
 with SMTP id d2e1a72fcca58-8a04ac29c73mr1355760b3a.7.1792210401822; Fri, 16
 Oct 2026 21:13:21 -0700 (PDT)
Date: Sat, 17 Oct 2026 04:13:21 +0000
In-Reply-To: <20261016091556.2750902-1-edumazet@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016091556.2750902-1-edumazet@kernel.org>
Message-ID: <atL1r9R5yfWs6Eu1@google.com>
Subject: Re: [PATCH net] ipv6: account route exceptions to the netns of their dst
From: kuniyu@google.com
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Qiliang Yuan <odys.yuan@gmail.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, 16 Oct 2026 11:15:56 +0200, Eric Dumazet wrote:
> rt6_insert_exception() and rt6_remove_exception() update
> rt6_stats->fib_rt_cache of dev_net(rt6i->dst.dev), but the device of an
> exception dst can move to another netns while the exception is still in
> its bucket.
> 
> This happens when the bucket is flushed from an RCU callback, for
> instance from nexthop_free_rcu() for the nh_info of a replaced nexthop,
> whose exceptions still point to live routes. If the device moves to
> another netns before that callback runs, the decrement hits the other
> netns, whose u32 counter underflows in /proc/net/rt6_stats, while the
> counter of the original netns never goes back down.
> 
> Account exceptions to the netns their dst was allocated in, derived from
> dst->ops as ip6_dst_gc() already does, which does not depend on the
> device. The dst already relies on that netns' ip6_dst_ops being alive
> when it is destroyed, which happens after the exception is removed.
> 
> Fixes: 81eb8447daae ("ipv6: take care of rt6_stats")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
