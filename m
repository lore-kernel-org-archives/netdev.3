Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315486;
	b=jy3hrFCG6h9PKDQ99YO1N3IT9ozvM+V+ydlu6dQgoaLu7UuXhXvoWuxGqIdrcy3dfiHq
	 leYqW+I4m577R7wTiAPGfF7iyT5p5dRicFScBwurwKxK8lHkLqXqyNGjlmVdfHo8MlAa1
	 olL6sfQX324YuJVMOWC7GjQkgLIyw/dsfyc/smaaP/sTrtRMDy/1vmTIYdGfuaLGUCgz6
	 afkf/FJWMfIiVo9Fxsbp4LGHFAmTrhQYLK1Wxa3RhtQXAPdmuy/+M9G5dONh44PzB4MZQ
	 LmaUowQwHe/FSrXQiNb+ncgZFcL6Nw7I/Xgo0T38vlmCZhvgww+rTVyHrgiiYdUhttg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315486;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/qGbTFCiD5QAMJwdqAPQ6i7bfkwwlyseHKlumB8BzOk=;
	b=OqpoROnrZpfnT2GX3fte2IBPcYNUSAIeAnkKDwIWwlk/UbTaPg8ZgYlQIVpZeXGLqXzh
	 siKa6mnonDgnR2I8F0inB7fE7pHTLCmYPq0zCgpkr/lMyW73diHBWw0cQHrRIX/Gsj/k8
	 hb3x3+r8v4hsQb4OKOYBDSv27R31jWcL0ni97qsOIj+1iQSkRkbxPxOcqPEBvxfRix5KS
	 XVfpXRcXXXM9evdvhkFJ3Olw/dG6mlsDIFrnCqcUIyf2BXY04Zl3cmmD6EIDA2BR58q4a
	 ml9aM54k7d73T2mbuIDMnkYiW4LdgcnQSSgAyK/OisadXoZV0rTEa3v8ibLi1lkRgiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoyvE5wz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ADE60A6F73;
	Tue, 10 Nov 2026 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoyvE5wz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A291F00923;
	Tue, 10 Nov 2026 12:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315485;
	bh=/qGbTFCiD5QAMJwdqAPQ6i7bfkwwlyseHKlumB8BzOk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UoyvE5wzzqDHEUmZuXHQbgHrRgDSlhzzSL75IdX9oyzyaAHb0OLp5w9PjpKWzTKza
	 QrC9c6mj3tDlPARzgl0aqJU3C0+JbDj8Rd1ljZQWmrFuQTtxQp0coLK5yP8oIvvkk5
	 H/it3NKfPEdHEnnIVlnHlMDM5JGgQt4qe7nSUyGjEroYTVR+zC69xlLBzMHgYuHwir
	 ZA6P7DulY5wfvtBIw7LUpuIR5hxYMu7sTrfDouOw4wATt/L6SdcB4glSbqtbDxPd1l
	 CHDj3/cJZfN0iF65l1doFrAzoJ4l1Wvu5TibEPz5Avx7ftacWQ+orNij2bujtjCfhM
	 bRbPDdXjVei0g==
Subject: Re: [PATCH net-next 2/2] net: dsa: user: document the write memory
 barrier on LAG conduit migration
From: netdev-bot+sashiko@kernel.org
To: kuangkai@kylinos.cn
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Nov 2026 12:58:04 +0000
Message-ID: <179431548491.994134.1097968032701195124@kernel.org>
In-Reply-To: <20261109120607.344544-3-kuangkai@kylinos.cn>
References: <20261109120607.344544-3-kuangkai@kylinos.cn>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The comment added in dsa_conduit_lag_leave()
  (net/dsa/user.c:3438-3441) and the commit message both say the wmb()…

--

net: dsa: user: document the write memory barrier on LAG conduit migration

This patch adds a comment above the wmb() in dsa_conduit_lag_leave(). The
comment says the barrier makes the new dp->cpu_dp values visible to RX
path readers of lag_dev->dsa_ptr before the new pointer itself is visible.

> diff --git a/net/dsa/user.c b/net/dsa/user.c
> index cfad269be75c8..96393d4b5da1b 100644
> --- a/net/dsa/user.c
> +++ b/net/dsa/user.c
> @@ -3435,6 +3435,10 @@ static void dsa_conduit_lag_leave(struct net_device *conduit,
>  		 * physical CPU port
>  		 */
>  		lag_dev->dsa_ptr = new_cpu_dp;
> +		/* Ensure the new dp->cpu_dp values are visible to concurrent
> +		 * RX path readers of lag_dev->dsa_ptr before the pointer
> +		 * itself becomes visible
> +		 */
>  		wmb();

[Severity: Medium]
Can the wmb() in this position give the ordering the new comment
describes?

In dsa_conduit_lag_leave(), the dp->cpu_dp stores and the store to
lag_dev->dsa_ptr all happen before the barrier:

net/dsa/user.c:dsa_conduit_lag_leave() {
    ...
		dsa_tree_for_each_user_port(dp, dst)
			if (dsa_port_to_conduit(dp) == lag_dev)
				dp->cpu_dp = new_cpu_dp;
    ...
		lag_dev->dsa_ptr = new_cpu_dp;
		wmb();
    ...
}

A write barrier orders the stores before it against the stores after it.
Here all of these stores come before it, so nothing orders the dp->cpu_dp
stores against the dsa_ptr store. On a weakly ordered CPU, the new
dsa_ptr can become visible before some of the dp->cpu_dp updates.

The publish pattern in dsa_conduit_setup() puts the barrier before the
pointer store:

net/dsa/conduit.c:dsa_conduit_setup() {
    ...
	wmb();

	dev->dsa_ptr = cpu_dp;
    ...
}

The placement in dsa_conduit_lag_leave() instead matches
dsa_conduit_teardown(). That function stores dev->dsa_ptr = NULL, then
calls wmb(), and its comment says only that packets "from this point"
take the new path.

The readers also use plain loads, with no matching read barrier or
acquire. For example, dsa_find_designated_bridge_port_by_vid() in
net/dsa/tag.h and dsa_tag_8021q_find_port_by_vbid() in
net/dsa/tag_8021q.c both do this:

	struct dsa_port *cpu_dp = conduit->dsa_ptr;
	...
		if (dp->cpu_dp != cpu_dp)
			continue;

Both run on the RX path, dsa_switch_rcv() -> tagger rcv with
dev == lag_dev. That path runs in softirq without rtnl, while
dsa_conduit_lag_leave() runs from the netdev notifier under rtnl.

Suppose a reader sees the new dsa_ptr but a stale dp->cpu_dp. Would it
skip the designated bridge port, return NULL, and drop the packet?

The opposite case, an old dsa_ptr with a new dp->cpu_dp, also produces a
mismatch. So no single barrier on the writer side can fully give what the
comment promises.

The barrier placement and the reader-side race date back to commit
acc43b7bf52a ("net: dsa: allow masters to join a LAG"). What this patch
adds is the comment, plus this statement in the commit message, which
claim an ordering the code does not give:

  "The wmb() orders the dp->cpu_dp stores before the new lag_dev->dsa_ptr
   is published to the concurrent RX path readers."

Should the barrier move between the dp->cpu_dp loop and the dsa_ptr
store, using smp_wmb() or smp_store_release() paired with READ_ONCE() or
an acquire on the readers? Or should the comment describe what the
barrier does order, which is all the earlier stores against the later
ones in dsa_conduit_lag_teardown()?

Also, this is ordering between CPUs, so smp_wmb() would be enough here
rather than the mandatory wmb().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109120607.344544-2-kuangkai%40kylinos.cn
