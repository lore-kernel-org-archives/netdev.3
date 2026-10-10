Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC2336F8F2;
	Sat, 10 Oct 2026 21:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791666535; cv=none; b=OIJymuXXaGPZMn4+r2VKX9IKIBtrQL7955KjjlhSvbzNGNYJjs6n0HU2Jagt6IxZ3I2OTB6uiQ8tbEHYzSKZoL97uX6geM4Ylv/GQpyjPswyxTfUfGHIPsWGiOmSFwcnJJYOcOCxGUFJaxn/B+Le7A5MKi43XTLsojHuU3sf9gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791666535; c=relaxed/simple;
	bh=ZQfrfZgYIIj+xriL1FdNEdy5OlnVY6TsC114SX0ZFcg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rBhrKLxdG8Xp0gFb7dFfQcJmT8Oyg32y+1fihVEVkrtwB2z9S2oIbv/bVE/MMHFetgfLqwbkNIPGGqPJbg9ktllacCXsw2qfPJ7I/FoRpyiGIGmdkma2ligg/Eej84QHMkPCOH+8YjSBwmkq4+S3JtI5am3A7cYEtaHfUJ0YPQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jkb2MuQA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jkb2MuQA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1EE1F00893;
	Sat, 10 Oct 2026 21:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791666534;
	bh=Gg9Odpb8GX+VeBeKSAWzFWr3ml/oqtZsY52TKxyJ/uE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Jkb2MuQAuJ1Pz6JOzk+ygeI+etUm1u9nK5CvAclVt6EB6u+G6aUY68luMDcuAK4EG
	 dPBeR7yZbDv0EprhH9Ej0uLVZFp52zC6LoPvx9SWHW1rnJCUEE6hpdBwSCMQD3c9uB
	 lpQO0kbA13VQU2FkSZ7nr6W3bLf4wg+3geQEWckIovXSqTqkWuc0oH3n8jvLDz3HJm
	 ST9P8IZRTE/ghBnBdJBFKq1vpTStZPnKQYNNFEOSTXk4vCXX3OLtV61chDOh269Cfj
	 hdDXncB2d6zLma22OyRNn3x2ABxpbi8I6oT0StnpWmMDmofZRJR503xlQ9Qfxfmf2K
	 8kku0+izwDFCA==
Subject: Re: [PATCH net v2 2/3] amt: make pre-query report drops visible
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Date: Sat, 10 Oct 2026 21:08:53 +0000
Message-ID: <179166653324.434549.3763843215808008320@kernel.org>
In-Reply-To: <20261009201455.1904698-3-omar@blockcast.net>
References: <20261009201455.1904698-3-omar@blockcast.net>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message's protocol explanation is wrong.

--

amt: make pre-query report drops visible

In gateway mode, amt_dev_xmit() drops an IGMP or MLD report when no
Membership Query has arrived yet for that family. This commit adds a
family-specific netdev_dbg() message before that drop. The drop path
itself is unchanged and still increments tx_dropped.

> A gateway cannot forward an IGMP or MLD report until it has received the
> relay's Membership Query for that family. The query supplies the nonce and
> interval echoed by the Membership Update, so dropping an early report is
> required, but doing so silently leaves operators with a dark multicast path
> and no indication why the join never happened.

[Severity: Low]
Is "The query supplies the nonce and interval echoed by the Membership
Update" accurate? The code doesn't seem to match it.

The gateway generates the nonce itself in amt_event_send_request():

drivers/net/amt.c:amt_event_send_request() {
    ...
		get_random_bytes(&amt->nonce, sizeof(__be32));
    ...
}

amt_membership_query_handler() only checks the nonce against that value.
>From the Query it stores the response MAC and the query interval:

drivers/net/amt.c:amt_membership_query_handler() {
    ...
	if (amtmq->nonce != amt->nonce)
		return true;

	response_mac = amtmq->response_mac;
    ...
		WRITE_ONCE(amt->ready4, true);
		amt->mac = response_mac;
		amt->req_cnt = 0;
		amt->qi = ihv3->qqic;
    ...
}

amt_send_membership_update() echoes only the nonce and the response MAC.
amt->qi is not part of the Update:

drivers/net/amt.c:amt_send_membership_update() {
    ...
	amtmu->nonce		= amt->nonce;
	amtmu->response_mac	= amt->mac;
    ...
}

So the state the Update needs from the relay's Query is the response
MAC, not the nonce or the interval. Could the commit message say that
instead?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009201455.1904698-1-omar%40blockcast.net
