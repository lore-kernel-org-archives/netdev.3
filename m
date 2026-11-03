Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698468;
	b=RfZufreD0IWpeYtwIgXVZMPe9DvauNAxnd05otLLXQ268lwVVxTZ38BLcsBukxq3n96L
	 UUXrW0C6eGNNHc1kW4XJ6hiZPgXsnkwpzxmxUszRLjZFz66i67z8JmKJlV2O0w0ucqZJD
	 INIh16wy+SrO9Gu5DMeswMGJN+YjTrEHZwEFVQYF8NLQljpRiZTESf0v55uaW0/mmQ4gO
	 8zvK6iXqEInCV/9TDhHRBwkouls7fhz/nU92st2pBGbLmnGuIPj64R71p/ygt0btFmjAT
	 W6gpw6amImFooL4+zoSndPaKP5NptSKqH1bI4xNqjHB8Eo4dLsoZizTBzmelSW0VwBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698468;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy;
	bh=XtO6LfrZVzR61+jJKzdUgwqYUQbw+cj9b2KqBtOJGgc=;
	b=CjViSqAUZSQOnR4thIxNko3RDwL2K4LOgIrPmBBxpGJoQ+LGTGKgh7RVyZpMEgP5rwWQ
	 0bwszdRd5Kow1Wn6RwkxDXaYsAvj9+SXRMwRcA6rp3hblY124bXn4t91Y7mhJniuiiBxn
	 Oxyi+WE6scfAs+OgFSX0e94XDIGftu8N2+YdJF+uQD7EzUYNUzwcDylcRDiITn+ENC0B3
	 8GQlvsJA1pD8y8Kmytzfn+0InNu6N0Ed9NBP0u6lt2iN3Iw6ulDUZVl6sAnE9vh6vSNy3
	 K2HKgFTrKIwhPOqenpwLmpu/vAkNzbiE4Vv+VLycuWEyFyoXCU48Q+bGc6txDUbarbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=CCuUNukn;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EAA606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86EAA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=CCuUNukn
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8E7BC201AA;
	Tue,  3 Nov 2026 10:34:24 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q70V1dalfaGg; Tue,  3 Nov 2026 10:34:23 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D6F3B20184;
	Tue,  3 Nov 2026 10:34:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D6F3B20184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793698463;
	bh=XtO6LfrZVzR61+jJKzdUgwqYUQbw+cj9b2KqBtOJGgc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=CCuUNuknDaKoBt1fGk76DQHARQ+Ok8QMgbJgB/QyJaJyS7epLbweVibl4QVxIvlaD
	 bC7FccaOvgafHPit9RcDcaZWQjlzyF5sd2EDZB4d/tgVjyEfwLIqVL9PIA380+pNZB
	 jwOd2rY+H21YDcPqxm5K/meOMqZDRJB+wSSKwuEsY4nYvy0Jr/xyVkObic5NvMdBYr
	 5dd5DIe1I50oqCZVSScfFdOAdMu10YojYwnUTLO1rGv+PTJlxAnHsDqrbQKvEbwI+6
	 WOhkpPKbA/JHBww/5YpXpN3OFSAzqwWEhTQoabta36w0fiSLxnyeySJo34atVSQeZf
	 tffd++NeUoung==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 3 Nov
 2026 10:34:22 +0100
Received: (nullmailer pid 3726600 invoked by uid 1000);
	Tue, 03 Nov 2026 09:34:22 -0000
Date: Tue, 3 Nov 2026 10:34:22 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, Qihang <q.h.hack.winter@gmail.com>
Subject: Re: [PATCH 02/14] xfrm: interface: validate the IP header on xmit
Message-ID: <aumqnmq4CORk6k_7@gauss4>
References: <20261102100451.2505200-3-steffen.klassert@secunet.com>
 <179369310046.488856.2145189284558172500@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179369310046.488856.2145189284558172500@kernel.org>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, Nov 03, 2026 at 08:05:00AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] In xfrmi_xmit() (net/xfrm/xfrm_interface_core.c), the new
>   header checks look only at skb->protocol.
> 
> --
> 
> xfrm: interface: validate the IP header on xmit
> 
> This patch adds a pskb_inet_may_pull() call to xfrmi_xmit(). It also
> drops packets whose IP version does not match skb->protocol, and IPv4
> packets with a malformed ihl. The aim is to stop xfrm4_transport_output()
> from working on an unvalidated header when packets are injected into an
> xfrmi device.
> 
> > diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
> > index 688306bf62c5a..9835fbe63ccb8 100644
> > --- a/net/xfrm/xfrm_interface_core.c
> > +++ b/net/xfrm/xfrm_interface_core.c
> > @@ -531,8 +531,13 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
> >  
> >  	memset(&fl, 0, sizeof(fl));
> >  
> > +	if (!pskb_inet_may_pull(skb))
> > +		goto tx_err;
> > +
> >  	switch (skb->protocol) {
> >  	case htons(ETH_P_IPV6):
> > +		if (ipv6_hdr(skb)->version != 6)
> > +			goto tx_err;
> >  		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
> >  		xfrm_decode_session(dev_net(dev), skb, &fl, AF_INET6);
> >  		if (!dst) {
> 
> [Severity: Medium]
> Can an skb marked ETH_P_IPV6 pass this check and still reach
> xfrm4_transport_output()?
> 
> The new check in xfrmi_xmit() looks only at skb->protocol. The transform
> that actually runs is picked by the dst family, and then by
> x->props.family.
> 
> When skb_dst(skb) is already set, xfrmi_xmit() skips the route lookup.
> The dst family is never compared with the header that was just checked.
> 
> In collect_md mode, xfrmi_xmit2() also swaps in a different dst after
> this check:
> 
> net/xfrm/xfrm_interface_core.c:xfrmi_xmit2() {
>     ...
> 		if (md_info->dst_orig) {
> 			struct dst_entry *tmp_dst = dst;
> 
> 			dst = md_info->dst_orig;
> 			skb_dst_set(skb, dst);
>     ...
> }
> 
> xfrm_lookup_with_ifid() then takes the policy/state family from that
> dst, not from the packet:
> 
> net/xfrm/xfrm_policy.c:xfrm_lookup_with_ifid() {
>     ...
> 	u16 family = dst_orig->ops->family;
>     ...
> }
> 
> A tc BPF program could reach this with the following sequence:
> 
> bpf_skb_set_xfrm_info()
>     info->dst_orig = skb_dst(skb);    /* IPv4 rtable */
>     attaches the per-cpu metadata dst
> bpf_skb_change_proto(skb, ETH_P_IPV6)
>     skb_valid_dst() is false for DST_METADATA, so the metadata dst
>     and the IPv4 dst_orig are both kept
> program writes an IPv6 header with version 6
> xfrmi_xmit()                  /* dst != NULL, only version check runs */
>   xfrmi_xmit2()               /* collect_md swaps in IPv4 dst_orig */
>     xfrm_lookup_with_ifid()   /* family is AF_INET */
>     ...
>     xfrm_outer_mode_output()
>       xfrm4_transport_output()
> 
> A plain IPv4 rtable does not survive bpf_skb_change_proto(), because it
> drops non-metadata dsts. So this appears limited to the metadata dst
> ordering above.
> 
> With an AF_INET transport mode state, xfrm4_transport_output() takes ihl
> from the low nibble of the IPv6 header's first byte. That nibble is the
> top four bits of the traffic class, so it can be anything from 0 to 15:
> 
> net/xfrm/xfrm_output.c:xfrm4_transport_output() {
> 	struct iphdr *iph = ip_hdr(skb);
> 	int ihl = iph->ihl * 4;
>     ...
> 	__skb_pull(skb, ihl);
> 	memmove(skb_network_header(skb), iph, ihl);
>     ...
> }
> 
> pskb_inet_may_pull() only made 40 bytes linear for IPv6. For a small
> packet, skb->len can wrap and the memmove() can read past the end of the
> data. If the skb has paged data and a linear length under 60 bytes,
> __skb_pull() hits BUG() instead.
> 
> One step has not been confirmed end to end. It is not certain that an
> AF_INET policy/state lookup matches a flowi that xfrm_decode_session()
> filled in as IPv6. It looks plausible with a 0/0 selector, because the
> ip4 address fields overlay ip6 address bytes that the sender controls.
> 
> This path also needs CAP_BPF/CAP_NET_ADMIN, a collect_md xfrmi, and an
> AF_INET transport mode SA and policy.
> 
> The commit message says:
> 
>   "xfrm4_transport_output() uses iph->ihl for __skb_pull() and memmove()
>   and expects the header to be valid."
> 
> Would it make sense to also drop packets whose final dst family (after
> the collect_md dst_orig swap) does not match skb->protocol, so this path
> is covered too?

Not a regression of this patch, just a missing path.
Can be fixed by a followup patch.
