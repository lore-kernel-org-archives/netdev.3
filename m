Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC8E566C58;
	Thu, 15 Oct 2026 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086943; cv=none; b=ZGK691Y6mSGPqjh5DDrF3xpqrzvbLd+sT1SqQEox2PRNu6UAqo+z3zNS7vqslTstKMMOR4MdX6ELIszuNIB4e2aRCLcID7Xz3qKSbcO/YitQw/OdKyELooQse5n3tltqIOvt365luh57atWvjJ0RWS+rdHsehGkHoNA1a6wETt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086943; c=relaxed/simple;
	bh=jgWLwREZhRmBTdhc+Jj/kXz40l16tXGTpS1MeH/xrgs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PhYGyitn5aJE5jsI+FVhm4UreqX05j1A/0s/jtd8Kg7nvmyjiPkfPML1v/YSkhl9BPkoPBuVzJXWQRixixpGQ5RCGMO5Fvc7ll0i3Ru4wvhyenPNGtkHTcyE0FVKXuzfUOUn3PkYy1M+66jkQrkzSFTH8/3/PAiX9qKIUO82HDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4iFimT1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4iFimT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEBD1F000C5;
	Thu, 15 Oct 2026 17:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792086935;
	bh=q4ifquM97SMdR8lKmbWeoOGq0Xh7OXYDogSY1ltet9w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=S4iFimT1jHhoDS3EmGtkYzJrMjTwy2FzQjqxPla+orD4i/u4ASDVhNdb4xx2U8wLO
	 MsVVLsSoyYrK8aa8a0kCeel3beZ1Mz1KS1YRJy3vLAmbcGjsYjEHCCRwwSvtrb5zIB
	 ECcSFmpufCqoNAVAozhpzDuY8W6sSv3Jy7NGBNDUTTgi5nFjrSC54g/mzBhhhotgBW
	 xATRPksGAfcUbhMeGZUO8IGjHbfXWDl1j0HRPJ6OnBjK6htdytK+gQDnwd3mHBcGLz
	 7PMtYj7EkfXPVZjYVuQV9Q0JqZzdxGyzTBdJUDbInGWZ7wwqcG4xDfkF1pN9MOnbOq
	 X9/8g2s4Td0Fw==
Subject: Re: [PATCH net v4 2/5] amt: reject a gateway Query or Data from
 0.0.0.0 before a relay is learned
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Date: Thu, 15 Oct 2026 17:55:34 +0000
Message-ID: <179208693481.434549.3987642690643160802@kernel.org>
In-Reply-To: <20261013175407.947606-3-omar@blockcast.net>
References: <20261013175407.947606-3-omar@blockcast.net>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.

--

amt: reject a gateway Query or Data from 0.0.0.0 before a relay is learned

This patch makes a gateway's amt_rcv() drop Membership Query and Multicast
Data messages while remote_ip is 0. Before, a packet from 0.0.0.0 matched
the unset remote_ip and was accepted. The commit message says that, with
the nonce reset to 0, such a spoofed Query would be taken as genuine.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 530650d5c19e9..e9b1a4585ce51 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c

[ ... ]

> @@ -2871,7 +2871,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
>  			else
>  				goto out;
>  		case AMT_MSG_MEMBERSHIP_QUERY:
> -			if (saddr != remote_ip) {
> +			if (!remote_ip || saddr != remote_ip) {
>  				netdev_dbg(amt->dev, "Invalid Relay IP\n");
>  				err = true;
>  				goto drop;

[Severity: High]
Is this check early enough to give the result the commit message describes?
It runs in softirq, against a copy of remote_ip read at the top of
amt_rcv():

    remote_ip = READ_ONCE(amt->remote_ip);

The Query is then queued as AMT_EVENT_RECEIVE. It is handled later, in
amt_event_work()->amt_gw_rcv()->amt_membership_query_handler(). That
handler checks only the nonce. It does not look at remote_ip or
amt->status again:

    if (amtmq->nonce != amt->nonce)
        return true;

AMT_EVENT_SEND_REQUEST goes through the same FIFO. When discovery gives up,
amt_event_send_request() does this in the worker:

    if (amt->req_cnt > AMT_MAX_REQ_COUNT) {
        ...
        WRITE_ONCE(amt->remote_ip, 0);
        amt_update_gw_status(amt, AMT_STATUS_INIT, false);
        amt->req_cnt = 0;
        amt->nonce = 0;
        goto out;
    }

Consider a Query spoofed from the old relay address with nonce 0. It passes
the new check if it arrives while remote_ip still holds that address. This
can happen in two ways:

- it is queued behind a pending SEND_REQUEST event, or
- amt_rcv() read remote_ip just before the WRITE_ONCE().

If so, the worker would handle it after the reset:

amt_event_work()
  amt_event_send_request()       /* remote_ip = 0, nonce = 0, INIT */
  amt_gw_rcv()
    amt_membership_query_handler()
      amtmq->nonce == amt->nonce  /* 0 == 0 */
      WRITE_ONCE(amt->ready4, true);
      amt->mac = response_mac;
      amt->req_cnt = 0;
      amt->qi = ihv3->qqic;

The status then moves to AMT_STATUS_RECEIVED_QUERY. That makes
amt_event_send_discovery() skip discovery.

These are the effects the commit message says the patch prevents ("a
spoofed Query is then taken as genuine: it sets ready4/qi and the response
MAC and suppresses rediscovery"). Here they still happen with no relay
learned.

The give-up time is predictable. After an advertisement, unanswered
requests back off 2s/4s/8s/16s, so req_cnt passes AMT_MAX_REQ_COUNT about
30s later. Any host that can spoof the relay's source address could flood
Queries around that moment.

The later patches in this series do not appear to change
amt_membership_query_handler() or this event ordering.

Would it be better to check where the state is consumed? For example,
amt_membership_query_handler() could reject the Query unless amt->status is
AMT_STATUS_SENT_REQUEST or AMT_STATUS_RECEIVED_QUERY. Another option is to
require a non-zero remote_ip that matches ip_hdr(skb)->saddr, and possibly
to refuse the predictable nonce 0.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013175407.947606-1-omar%40blockcast.net
