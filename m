Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FC43C1F57;
	Thu, 24 Sep 2026 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249628; cv=none; b=RcS7zKWIHa+q8bFM+VRCaOs79FQyu4wDntKAVOCbWQynU3Qu18qKLfVTsUnFgMOrSap1+ldzwLyWlHtw7phdj43tWkqT9PoNYP+fPTiegiwXWEui3TpCdr8QWSJwgtsQORfqnLZ5S7rsNpzwvx+h39rx+bC8oCW+KKNxetN2ggs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249628; c=relaxed/simple;
	bh=uxscIP7OJyfM7dk0uHvdNBa7BC1Q/dfRSwlbTBDVa00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ieja47BZPwJksNxKmxLTyRc4FyskZTLHkFOnq+azVTMsnKxvuQ02zg7MyrKHuAptROk+JVZAi5ZCizDJjbi2JpQgztXQQLKjmx8kN1Th2znw9eRbXu9M4yRshp9JLd/6GdBAnOyAABEAhxcJgGyTgSf8qNLwjM1IYO0z/d4haHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMY6S+Bn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMY6S+Bn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8353A1F000FF;
	Thu, 24 Sep 2026 11:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790249621;
	bh=gpEA6fUy3JVgcQaZHWEzheoPdnjTOP9NEnmDegJUc/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fMY6S+Bn70Ys3Kmsb3BntrNVe8Jt8iD9l0QuJyWfPf39Oa/p2rV42aQ+VHciQV55b
	 yM/H8rVA1JH49yS+630vMdz5/6MePkYFIM33Ng8DsGwR4xqzR87tzxusZWDX1t+ZbI
	 iRpVpYFjEAIATE1d2j2UHD5rSUY5TXDmU4CZa5WUY4gzNRxqMbBd/QzHmLhdvnSHUX
	 kS9XhRcRkIPRw4hOqu/hTiCNfnt+Lolhw7GfxNIFarIv+9aOJkxdIHzOIXGTsTNuvV
	 EQKVhf1KyQtsGXTRmagzX+dSVkm3RuISQPFhKyysoFpId8elfCIUgTvhS75ci98l7m
	 iYs8kbzCS+Zcg==
Date: Thu, 24 Sep 2026 12:33:37 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: benquike@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: llc: clean up unaccepted child sockets in
 llc_ui_release()
Message-ID: <20260924113337.GD13925@horms.kernel.org>
References: <20260919213635.3314344-1-benquike@gmail.com>
 <179019939874.2160803.14497903403458944686@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179019939874.2160803.14497903403458944686@kernel.org>

On Wed, Sep 23, 2026 at 09:36:38PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider.
> 
> Critical: 1 · High: 3 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Critical] Type confusion in the new TCP_LISTEN drain loop in
>   llc_ui_release(): the loop assumes every skb on sk->sk_receive_queue…
> - [High] The drain of the listener's sk_receive_queue is placed at the
>   very start of llc_ui_release() (net/llc/af_llc.c:207-225), before…
> - [High] The new child teardown in llc_ui_release()
>   (net/llc/af_llc.c:213-222) removes the child from the SAP hash, drops…
> - [High] Incomplete fix: the new release-time drain can only reclaim
>   children whose skb reached the listener's sk_receive_queue, i.e.…
> - [Medium] Reference-tracker acquire/release mismatch: the new code
>   releases the child's netdev reference with netdev_put(child_llc->dev,…
> - [Low] The commit message cites a non-existent symbol: "llc_ui_release()
>   calls skb_queue_purge(&sk->sk_receive_queue) in llc_sk_Component /…
> 
> --
> 
> net: llc: clean up unaccepted child sockets in llc_ui_release()
> 
> The patch adds a drain of the listener's sk_receive_queue at the top of
> llc_ui_release() when sk_state is TCP_LISTEN.  For every queued skb it
> takes skb->sk as an unaccepted child, removes it from its SAP, drops the
> device reference and frees it with llc_sk_free().  A few questions about
> the new block and the changelog below.
> 
> Commit message:
> 
> > If the listening socket is closed without calling `accept()`,
> > `llc_ui_release()` calls `skb_queue_purge(&sk->sk_receive_queue)` in
> > `llc_sk_Component` / `llc_sk_free()`, which frees the queued `skb`s
> 
> [Severity: Low]
> Where does llc_sk_Component come from?  A grep for that string over the
> tree at this commit returns nothing, and the only skb_queue_purge() of
> sk->sk_receive_queue in net/llc is the one in llc_sk_free() in
> net/llc/llc_conn.c.  Could the changelog name only the function that
> actually exists?

In this case I am just going to stop right here.

It's a low severity issue. But at a minimum it seems to imply something has
slipped through. And looking at the long list of issues flagged above,
combined with the long list of patches from you in my inbox (~66) I don't
think it is wise to spend more time on this one in it's current form.

-- 
pw-bot: changes-requested
