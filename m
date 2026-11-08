Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794172088;
	b=XA5STblskWK+jnaZrHPHeoqwo0BGe4Oz3hs7NUPTxW0tKufYTq0BqIbE6pT778Sz+2HY
	 eVpr85eBqJVG0taScmiWrvgZZHQu2C9tF0sdzO/dc/pRzXaOL5n8S1jD4eGc2I3Qo/Obd
	 5K0Ma7WUB5AZ0BgQs3jPVMeqEzRxa4ynbBS45qIZsFsBQ6t1+nATJgiqZdJD3lKcMVosV
	 QrYXjVB14RUN6oAG7m2ciIEo8UMFAgynCPJfGnv/TvtgKoXOJrX9SvTW8FvpkDvvQahHi
	 B68RYNwI/2Uj81Tc8ok3BtQ+4xDwKAPuij1jFkcSL68GMEZWVuPqvSekV3WvAJJpWfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172088;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Y7JWEwg9Ct2ossjTf4kZV+QIKiz/YwDb7vKoIKIg5Pg=;
	b=3iB/WdB9cwEvIDBkLeONIu0BOjN8/RV6vTCbOP3btlTbJWg+oL3ZWV2unE9MA0k9ySca
	 Y7EEG/yv0OGAjitTDox5ZMklxoORc0RuiDIx+xGaBMU3gkKVNdl4R3QTuQlU+FN0PFf7r
	 VhArkdpfRBPTubMJLK9Cq4INpveHU9sGfozvg4D7SANCdS1NdyGAXRU8mDRBgPHiAiatr
	 r5YScKUqOkWx4hqUDpcic2iRK+wLbz2qdAcsimLeFKfch9i6VH+zz0jgyPEwWKT7K60hs
	 DTKLSoy/6H5i48bXFua/5E1xrYIa2PdUcbrde466jc4IeDepf9xEGwouLiievWc8NEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ki0vmA/G";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3872D606A31C;
	Sun,  8 Nov 2026 21:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ki0vmA/G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3881F0089F;
	Sun,  8 Nov 2026 21:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794172087;
	bh=Y7JWEwg9Ct2ossjTf4kZV+QIKiz/YwDb7vKoIKIg5Pg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ki0vmA/GXah8WIGjXye7gsUwmK5t16oHld4y12MwkB7ntU38OWnaPADjYuR9LnEnx
	 IryscbnrQcqwbwggEzZWX6L3XUsSyw3CyTEGco1/vAw4QsrZsSKU/2xTj6msqDeKWn
	 3WhwzkvhlwD/2LQeLp9uHbr3H+qHNWixdx1OVV7sPrG+k7AndCDjzxkUkjHHUfk1PX
	 D+rBWQ0PT/qV83LbckRT2Ik4PQko74LzRbS/4v8yuYezoSifQ5pEFV4y4frnPwHcRW
	 SGWMsUvLOWjfq/uufLAsk4u4ONwqODDPm/bAiA+n5qyss+jm+qWdgs4z4WODhB6TH+
	 AfMWo0TYEYjuw==
Subject: Re: [PATCH net v3] net: dsa: clear the conduit RX queue on receive
From: netdev-bot+sashiko@kernel.org
To: dencity7@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 21:08:06 +0000
Message-ID: <179417208676.994134.17082599035866210951@kernel.org>
In-Reply-To: <20261107210653.2007194-1-dencity7@gmail.com>
References: <20261107210653.2007194-1-dencity7@gmail.com>
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

- [Medium] The commit message lists what changes for "code that reads the
  recorded queue later" (skb_tx_hash() and sk_rx_queue_mapping/xps_rxqs).

--

net: dsa: clear the conduit RX queue on receive

This patch clears skb->queue_mapping in dsa_switch_rcv() after the tagger
has chosen skb->dev. The conduit's RX queue index is then no longer carried
over to a DSA user port, or to a bond/team that receives trunk-tagged
frames. With that, rps_cpus on user ports applies to traffic from every
conduit queue, not just queue 0.

> diff --git a/net/dsa/tag.c b/net/dsa/tag.c
> index 6a5aa7fc331c3..e53dc3f3c477c 100644
> --- a/net/dsa/tag.c
> +++ b/net/dsa/tag.c
> @@ -95,6 +95,13 @@ static int dsa_switch_rcv(struct sk_buff *skb, struct net_device *dev,
>  	skb->pkt_type = PACKET_HOST;
>  	skb->protocol = eth_type_trans(skb, skb->dev);
>  
> +	/* The RX queue the conduit recorded is an index into the conduit's
> +	 * queues. It means nothing on skb->dev, a user port with a single RX
> +	 * queue or a bond/team with its own queue count, and get_rps_cpu()
> +	 * would check it against that device. Leave no queue recorded.
> +	 */
> +	skb_set_queue_mapping(skb, 0);

[Severity: Medium]
The commit message lists what changes for code that reads the recorded
queue later:

  This leaves no RX queue recorded, rather than recording queue 0. Both
  make get_rps_cpu() use the first RX queue's map. They differ for code
  that reads the recorded queue later:

It then covers skb_tx_hash() and sk_rx_queue_mapping/xps_rxqs. Are there
other readers of skb->queue_mapping on the user port or bond/team that
the message should mention?

One reader that userspace can see is PACKET_FANOUT_QM, in
net/packet/af_packet.c:

static unsigned int fanout_demux_qm(struct packet_fanout *f,
				    struct sk_buff *skb,
				    unsigned int num)
{
	return skb_get_queue_mapping(skb) % num;
}

Take a QM fanout group bound to a DSA user port, or to the bond/team that
receives trunk-tagged frames. Before this patch, its packets were spread
across members by conduit RX ring, as (ring + 1) % num.

Now that queue_mapping is always 0 here, will every packet go to member 0?
Recording queue 0 instead would send them all to member 1 % num. In both
cases the group would stop spreading load.

The same applies to tc/BPF ingress programs that read
__sk_buff->queue_mapping, and to the tc ematch meta queue_mapping
selector. On DSA ports they would now always see 0, not the conduit ring
index.

This patch has a Fixes: tag and is headed for net/stable. Could the
commit message also describe these two changes: how QM fanout distributes
packets, and the queue_mapping value that tc/BPF sees on DSA ports?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107210653.2007194-1-dencity7%40gmail.com
