Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792449558;
	b=WD4EF++PoETytSGds52Tkh8wdE1MiikMDVxovtPzRsMZkibJqUjtB3DQjpyS2yEJ5dhP
	 Vy8Y3ps2SCkbm7Na0bd3R1q3DvTvvX7ynvYpfnDxmbsTRUaZIQuH2UdSCW2YAwxSXtPti
	 cHIcNgGtE9dezBhi/a64rQeKRVorYAvNJ8tlNsfOQ3OU2dyk/3qnvXy7jIGdbG7pBmPdE
	 FFirJRNjbyC2SGijNGiPc1/t1Cv4XNa1r0+BENLVNg8TI97IKbeZLrROuLdtWGkiI1MF/
	 Bjw9RuFJFsVpIV3d00oFaz06Q190iMj+phokXoQYQIz1Ll2lLgIV+x1xB+6DhVchjNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792449558;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cz4fuqoYE1iaCHuQcwh1LWMJgSlcRbLX89a7yZbeB3Y=;
	b=OFoDe30flM7ehD4jNB0uJ0hxup59dQbkuFAKY6aPzL2njOoSwy6N33/oQGmlvLN5QsAr
	 5afAlMSusyeihfHdSH/sxTB2kqtInPMNeTvu7xYjrk/FXvr8Q6h7nIkZT9JUhv6FYXu1b
	 aZ2Q4xAWgUoNoLmhcx6U99k8hxi0AapE7FVdkn54l9/ArtmD3v6xKlX/XKZogU1zmI2uO
	 U4fT92w09CspcSQpoN7HQjP6srr3NyY1C9KI2KprVtIVZpDyamuukfknQVSKOAaJlmJtR
	 e4NAw98CnbqPzi1udUnu+wsQop1VwDA4xbcIYMuRIbK0KbNFk7VNc9Ve0tEwz9OWUwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fkMicF34;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05154606A31D;
	Mon, 19 Oct 2026 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fkMicF34
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4861F000C5;
	Mon, 19 Oct 2026 22:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792449557;
	bh=cz4fuqoYE1iaCHuQcwh1LWMJgSlcRbLX89a7yZbeB3Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fkMicF34vgpb2itmvbSI42sGQcezgwh9b0R66kh/R5uneT+Mxhja7e8oumcfLw2OX
	 jNWYBJMSeGYnB1UiORkbA5JkjX/jRIlBytzuSw3Pf2iZAaHgs6z3zyIzfMcOxJOT9k
	 MEsKhsqvnJ0T8fsGXuXQEuz91mNOBrr+ambokNENO9h7gcdJreIFa1yVkJfSpdrYLa
	 z4jUFGW5ht6XAzcQAcoNiUm0kUcS6U1KRTtstCYoG1ulVfjrGrVGS27cJeD52Lqvsy
	 9N4bUPs9LOui9qVw7WCEhC2ayom9jFwQmfit2UmyILrEbQIhD6pz7OqMdg/8Ee0uBW
	 llFYNrJ9+s5fA==
Subject: Re: [PATCH net v4 2/5] amt: reject a gateway Query or Data from
 0.0.0.0 before a relay is learned
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Date: Mon, 19 Oct 2026 22:39:16 +0000
Message-ID: <179244955655.3135.11935138615702114109@kernel.org>
In-Reply-To: <20261015220648.1545576-3-omar@blockcast.net>
References: <20261015220648.1545576-3-omar@blockcast.net>
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

- [Medium] The commit message does not mention one of the three hunks,
  and that hunk seems to belong to a later patch in the series.

--

amt: reject a gateway Query or Data from 0.0.0.0 before a relay is learned

This commit adds a !remote_ip guard to the Membership Query and Multicast
Data source checks in amt_rcv(). With the guard, a gateway that has not
learned a relay no longer accepts these messages from 0.0.0.0. It also
adds a source re-check in amt_membership_query_handler().

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index b06916c7d57d5..2e0d3aae3759b 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -2413,6 +2413,10 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
>  	if (amtmq->reserved || amtmq->version)
>  		return true;
>  
> +	/* A deferred query may outlive a relay address change. */
> +	if (ip_hdr(skb)->saddr != READ_ONCE(amt->remote_ip))
> +		return true;
> +

[Severity: Medium]
The commit message doesn't seem to describe this hunk. It only covers the
remote_ip == 0 case in amt_rcv():

  "Reject both when no relay is learned: a 0 remote_ip must match
  nothing, so guard the check with !remote_ip."

This check covers a different case. amt_rcv() checks the Query against
remote_ip when the packet arrives, and the handler runs later from the
event worker:

amt_rcv()
    amt_queue_event(amt, AMT_EVENT_RECEIVE, skb)
...
amt_event_work()
    amt_gw_rcv()
        amt_membership_query_handler()

In that window, amt_advertisement_handler() can change remote_ip. It can
also be reset to 0 by amt_event_send_request(), amt_dev_open() or
amt_dev_stop(). With this hunk, a Query that passed the check when it was
queued is dropped if the relay address changed before the worker ran.

The later patch in the series, "amt: harden relay authentication and
teardown", says in its commit message:

  "A deferred gateway Query is accepted only if its relay address still
  matches the current relay"

However, that patch's diff doesn't touch amt_membership_query_handler(),
and it carries a different Fixes: tag (cbc21dc1cfe9).

Did this hunk end up in the wrong patch? This commit has
Fixes: b9022b53adad and is likely to be picked for stable. Could the hunk
move to the patch that describes it, or could this commit message mention
it?

>  	if (amtmq->nonce != amt->nonce)
>  		return true;
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015220648.1545576-1-omar%40blockcast.net
