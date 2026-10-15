Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA39141D659;
	Thu, 15 Oct 2026 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060214; cv=none; b=EIFZjVaI+vFLxctWcn6AdKZvSYgXWS4WIFEBw0NmejoXS4u7mo6jW0RC3QfgZWGZHotygPebecfMuYOKj+mL0yB5TliC+jzyxgqNK7ZqkF3gWb/n0MxFVf/RaCa1Z5SNuHpSzoGU3k41gRdqvq+7TbPIsJxSQiE6iR4okQybU0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060214; c=relaxed/simple;
	bh=FmTnMTXoMftNJXLowT4G1GI9tqdH8mB+StRO6xf6WwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kudf8Sx8TQKPQBIG+4MUAjBtjpWHbydH7Dc9StVyfspcjAkR85dkhYLDf5dpfLBQAUNZ5nF6e3onixfeYVZcJNhDLYmNszJvpEFWJBTGnnIfutk673iAHGDOMV+mC/WzD2eIsEIRIv9ujaUaAXlpcupGPBjS5hjb7jMaGNpOz5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ag912mMu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ag912mMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AB01F000C4;
	Thu, 15 Oct 2026 10:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792060213;
	bh=GXSX9G24eQkHRhW5tGhUzyC0HnkB83Vi/qlvxIIebWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ag912mMurzXzCm8h1tDv8HU30JipHJexjLxZtL5Ec+cPDDEH5hwljrVvyTmsqEOzL
	 6JAPnIcrHxEAZFdVYrTr7W3wf/Lejso8tIJvb5lglXDqQcOeCLqfj3TOolu9TpJBmS
	 HbcXZVnBL7FhKLjspUZoP1B6eOQV4THkgjOOE4e2jjhaJb7CtxMQhO94yh9w6xk0gx
	 5NL5U5ay0JNMcqoXQ8IqTb6Q+uDrBMlJvL+5t6A4wsLL7S0k1jjhkrHzwHWSnHcc2o
	 /QQVaF/YNBZCfoJbw748jRLI+1ka4726gejDT26szrAp09msUBXySlTrCUoKI/oOfv
	 o5TZYF3Y8aSxw==
Date: Thu, 15 Oct 2026 11:30:10 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: tjdqudcks0424@naver.com, mani@kernel.org, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH net] qrtr: make repeated lookups from one client
 idempotent
Message-ID: <20261015103010.GE83879@horms.kernel.org>
References: <20261008082518.347350-1-tjdqudcks0424@naver.com>
 <179179445439.434549.690451607886863842@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179179445439.434549.690451607886863842@kernel.org>

On Mon, Oct 12, 2026 at 08:40:54AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The fix does not close the denial of service its commit message
>   describes.

This does seem to be a legitimate concern. But I wonder what can be done
about it. I expect some sort of non-trivial heuristic is required, but I'm
not sure what one that works would look like. Or even what the bar for
"works" would be.

> 
> --
> 
> qrtr: make repeated lookups from one client idempotent
> 
> This patch adds a check to ctrl_cmd_new_lookup(). If a NEW_LOOKUP
> request has the same node, port, service and instance as an existing
> lookup, that row is reused and no new one is allocated. The goal is to
> stop one unprivileged local socket from filling all 128 global lookup
> rows with duplicates and locking out other observers.
> 
> > diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
> > index bcb090ee79d49..ae0dc2474e5e9 100644
> > --- a/net/qrtr/ns.c
> > +++ b/net/qrtr/ns.c
> > @@ -547,6 +547,14 @@ static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
> >  	if (from->sq_node != qrtr_ns.local_node)
> >  		return -EINVAL;
> >  
> > +	list_for_each_entry(lookup, &qrtr_ns.lookups, li) {
> > +		if (lookup->sq.sq_node == from->sq_node &&
> > +		    lookup->sq.sq_port == from->sq_port &&
> > +		    lookup->service == service &&
> > +		    lookup->instance == instance)
> > +			goto notify;
> > +	}
> > +
> >  	if (qrtr_ns.lookup_count >= QRTR_NS_MAX_LOOKUPS) {
> >  		pr_err_ratelimited("QRTR client node exceeds max lookup limit!\n");
> >  		return -ENOSPC;
> 
> [Severity: High]
> Does this close the denial of service described in the commit message?
> 
> The new loop only skips allocation when (sq_node, sq_port, service,
> instance) exactly matches an existing row. Any other tuple falls through
> to the unchanged global limit and takes a new row through list_add_tail()
> and qrtr_ns.lookup_count++.
> 
> The service and instance values come straight from the client packet in
> qrtr_ns_worker(), and nothing checks them:
> 
> 		case QRTR_TYPE_NEW_LOOKUP:
> 			ret = ctrl_cmd_new_lookup(&sq,
> 					 le32_to_cpu(pkt->server.service),
> 					 le32_to_cpu(pkt->server.instance));
> 
> Can a single unprivileged AF_QIPCRTR socket still fill all 128 rows?
> It could send NEW_LOOKUP for services 1..128, or for one service with
> instances 1..128. Requests spread across several sockets would also miss
> the exact-tuple check, because each autobound socket gets its own port.
> 
> Once qrtr_ns.lookup_count reaches QRTR_NS_MAX_LOOKUPS, an independent
> observer still gets -ENOSPC. The rows are only freed by DEL_LOOKUP or
> DEL_CLIENT from the owning port, so the attacker can hold them as long as
> the socket stays open.
> 
> The test in the commit message seems to cover only identical duplicates.
> 
> The root cause looks like the single global limit, which has no
> per-owner accounting:
> 
> #define QRTR_NS_MAX_LOOKUPS 128
> 
> Would per-owner accounting fit better than extending the exact-tuple
> dedup? Options include a per-port quota under a global ceiling, or
> per-uid or memcg based accounting.
> 
> Also, the global limit is hit by whichever client sends the next
> request. So the "QRTR client node exceeds max lookup limit!" message
> names the observer that was rejected, not the client that filled the
> table.
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008082518.347350-1-tjdqudcks0424%40naver.com

-- 
pw-bot: changes-requested
