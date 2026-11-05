Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910513;
	b=hTr2VoVNvxLw2nrktGZYpPQKTYGQScUX1pd9daoffO76nwC7Na4tTy/K6/RU0gSMzx8f
	 67qsHPvH7AuxkQN2sW1h2pOv60HkTDySFp/3hn0k7fFW4DYumV5jpA2UYFl2N4VeRuzOg
	 EwFtAc9CJ9J0uXj5qW5UlO8n17f77s1VxTyrL2z6NxfUZErt+aslHP2T8HAk1tudfB91i
	 ii5aTirKywbLtUROD4SIFTEXbQCuVJwu1JvpM7NeeTSBPcA716+KJFxwrGJSvJo0cKqZQ
	 cw23q7f5N53S6rvidNhh5DvLWhGmsTBMpH2zbr/w03j/ieopBsOkrbdKBOXIn80iuWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=R2bDHLUAsY5ANQjjsP8u82fVSG+atwQzzewhrRI9VEE=;
	b=a3cENqKiYzSdESYA0jv4x+6KnjU2KADbyAMl+8FF8lVrXyfZgRjXR+s7gf/R5n1YBw0+
	 kAt0nUArhJpHmaefTbEKDynq20yI9ra5IkpVECAEY2ntjk7taQ3JWfo00PHs9elNiNNlI
	 QX/QfzhaRo//NBt/GfS4SqS4Isbx4loQXWcGtDLEJeNIc3K9lfF6s+oRrFODnZXJG6VN9
	 u/ohSOBQUJ/1LnlxoApvI595HSc2yLKf8CtTx8C2NW67u00U0b87CWEGkm6FzElJkyUK6
	 3N3YSvcI1+ua0zKvE4XwOmAytrHgD0XyCPWRq7PtwzVkf75gTP0JCrNOaCYMlri/sUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZDw3Fv08;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFA5606A330
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 20:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAFA5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZDw3Fv08
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ed34e33913so4312575ad.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 12:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793910512; x=1794515312; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R2bDHLUAsY5ANQjjsP8u82fVSG+atwQzzewhrRI9VEE=;
        b=ZDw3Fv08GbIaELfQzU2lVdkQzsG9SYeT4IhmThqkd0r+ivmudLFKo32ZK9wCysH0WP
         M/KZNAZ9MwUAqawzOeNP7MaZ57AhY2PYMb2Bsndo8bifLcQPCNmM8PWn8jWqOA5HmeGy
         XwHFQYZCOfBRCCCwKTW4XlKkc4zmg4RDGdRflN898KkviHKTVj6UlaiCvOVcVWRn3DAc
         rTGnh91U09sSZ3sECmmSmgq9AbPkSIbP3EdcsmDmJoYYd+2KE00LdZNXx6wg3p8XvRKL
         ugk0j8iM5rFN/osJa10R5v3GXShTUIUJKJwSR2WezX0htSEDwwbppSxPwXscKdN04D1Z
         X+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910512; x=1794515312;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R2bDHLUAsY5ANQjjsP8u82fVSG+atwQzzewhrRI9VEE=;
        b=q9QsAyAqDDYzROce01LLgNQxnxoNlQ60QfM4auyqTmt3ZeDkFN28I+rgAc1tVDXNPJ
         ERitXt/YzCAtpLKKcRVM0DXUozxhDhKCTB9HOAZm0/r7O3MlMr635MabnPo2u84LOe16
         vMpOONXknpR7Br4C5MVwnY7ik3cfgxFBhMLFoAqcLhfWZOYbk4mE/Ik5vggNkyVz2ZbS
         S/UaTtLdMMqf4Cy72933WFFKGUFbcpBH6xEE9jb3TEFfwM7Hzxmtp9kxMqYmRJpOOWRh
         a7jALSpMC3SZ7LrXQt8NnzGLrMo5Lrm3IiJDN/BE0nI+4yF81ujkL48lVnGGC1FZFkqn
         xTpQ==
X-Forwarded-Encrypted: i=1; AKwUvByppKzWtS/uvvr8xYzYaWOh7bITswHTKwVgI4q0qg6m4EJHQiMaHGHWJ0JO2iQUNflczU0gnyA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GinaY238JJAyALNkpXGZnMRNMD+tIyCHBZpfnfJBBtpoRPWx/
	neNCgO8j9o/ccHZCxYNAWYGGhJZ/KyH0w6VLMej15qWPCg7vZ7dv4SNVLym5V0gTEZAbHN46S4z
	VKoRbFg==
X-Received: from pjnx22.prod.google.com ([2002:a17:90a:8a96:b0:3ac:df91:33d6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b48:b0:3a0:cbe2:9e0c
 with SMTP id 98e67ed59e1d1-3b0db725ccfmr125374a91.63.1793910511945; Thu, 05
 Nov 2026 12:28:31 -0800 (PST)
Date: Thu, 5 Nov 2026 20:28:31 +0000
In-Reply-To: <217109d64f0cdcba1db9569ee6ff7304754c47a4.1793793623.git.petrm@nvidia.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <217109d64f0cdcba1db9569ee6ff7304754c47a4.1793793623.git.petrm@nvidia.com>
Message-ID: <auzmIrtt_gMVjWhs@google.com>
Subject: Re: [PATCH net-next] net: neighbour: Avoid sending RTM_NEWNEIGH for a
 dead neighbor
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, 
	Andy Roulin <aroulin@nvidia.com>, mlxsw@nvidia.com
Content-Type: text/plain; charset="us-ascii"

On Wed, 04 Nov 2026 14:56:56 +0100, Petr Machata wrote:
> During the processing of neighbor timer, in neigh_timer_handler(),
> when the number of probes for an unresolved neighbor is exceeded, a
> non-ext_validated neighbor is marked as failed. To send the ICMP /
> ICMPv6 destination unreachable diagnostic, neigh_invalidate() unlocks,
> and gives opportunity for a concurrent update to mark the neighbor as
> dead and send an RTM_DELNEIGH notification. After the lock is
> regained, neigh_timer_handler() proceeds to send its own RTM_NEWNEIGH
> notification, this time on a dead neighbor.
> 
> Sending an RTM_NEWNEIGH after the corresponding RTM_DELNEIGH has the
> obvious semantics of recreating the neighbor, which is not what we want to
> convey here.
> 
> Userspace can in theory recognize these faulty RTM_NEWNEIGH reports by
> the state, which will be NUD_NONE, but there is no reason why it
> should.
> 
> The following diagram, which illustrates the issue, comes from Andy
> Roulin:
> 
> timer handler (softirq)                neigh_flush_dev() (linkwatch)
> write_lock(n->lock)
> nud_state = NUD_FAILED
> neigh_invalidate():
>   write_unlock(n->lock)
>   error_report()
>                                        write_lock(n->lock)
>                                        unlink, n->dead = 1
>                                        refcnt != 1 -> nud_state = NUD_NONE
>                                        write_unlock(n->lock)
>                                        RTM_DELNEIGH
>   write_lock(n->lock)
> write_unlock(n->lock)
> RTM_NEWNEIGH: state 0, no lladdr, ndm_refcnt 0   <- stale
> neigh_release() -> neigh_destroy()
> 
> Fix the problem by refusing to send any notification other than
> RTM_DELNEIGH when the neighbor is dead.
> 
> The issue comes from a user report and was obseved in the wild. It was
> reproduced on a vanilla kernel by extending the race window by inserting an
> mdelay for neighbors on a device with a hardcoded name.
> 
> It is tricky to track down where the issue was actually introduced, and
> practically speaking, it may have been present "always". At least as far
> back as 5.10, which is currently the oldest LTS-supported kernel release,
> the code still looks substantially the same: neighbor timer causes neighbor
> invalidation, which unlocks to send ICMP, which a flush can then race. Even
> 2.6 has elements that look like they could combine into the same race. I am
> therefore not citing any particular Fixes tag.
> 
> Assisted-by: LLM
> Co-developed-by: Andy Roulin <aroulin@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Andy Roulin <aroulin@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  net/core/neighbour.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index d6e9c7c59a89..6fa490f7652a 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -3593,6 +3593,13 @@ static void __neigh_notify(struct neighbour *n, int type, int flags,
>  	int err = -ENOBUFS;
>  	struct net *net;
>  
> +	/* An attempt to send anything but RTM_DELNEIGH on a dead neighbor
> +	 * indicates that the neighbor was marked dead while another update
> +	 * gave the lock up for a bit. Do not send such notifications.
> +	 */

I'd remove the comment, it's apparent from ->dead that there
was a race and the rest is just repeating the condition bleow.

Otherwise looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>



> +	if (n->dead && type != RTM_DELNEIGH)
> +		return;
> +
>  	rcu_read_lock();
>  	net = dev_net_rcu(n->dev);
>  	skb = nlmsg_new(neigh_nlmsg_size(), GFP_ATOMIC);
> -- 
> 2.56.0
> 
