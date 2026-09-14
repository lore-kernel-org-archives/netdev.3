Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE60E42DA4D
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789381356; cv=none; b=io0d5yK6dAHoQ4OgL29A22V2zFTZOt7AnL4qk6V5E7sGpUGEdOLUDGzMQa/zn/E59PQG8ziq4uvR6dC2o7GxIIw+kNKHAtaqxNKh6GI9SI/xYOXFvtkXy0hP03hNZ2lIOvakgpRBWJkveCBGmPc0H9Yy6RGNlZNKEd7Acb8fDlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789381356; c=relaxed/simple;
	bh=ucT8MZPWGwtNZivg3T+VOLW5OccinRlZ71vcwaQQE1E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqeUgeeS2Q+qxWyh9GYqRYP78OeoLL4H99YXMfYul+pd72bhWigDlHKsu2LMfEjfBv+NArnXB4f0IGeku3CTH5+3NNKfY4fakByZwdX7RZjkzQTPH+W59KPRuNO8kOTldv4yRuQ985OombDorlh04877iYByfn7LxdUlEVYoBXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=o5lPWVXR; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="o5lPWVXR"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 7356F206BC;
	Mon, 14 Sep 2026 12:22:31 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LgL0chXIu42W; Mon, 14 Sep 2026 12:22:30 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A8BDD20758;
	Mon, 14 Sep 2026 12:22:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A8BDD20758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1789381350;
	bh=/SRQLjgEvkL1A23FxKYxFLKGyd3OR6ak2Hvzr793798=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=o5lPWVXRfcjtDfY/3Onqzp80clj5ySWeI5bU78mJETNncm8i0jLzgqF60CDYuXQTV
	 T2y0OdpHyXiMiQ5sK3SViqW4pn6ojd2Un3tW/SmuuVO/yEwKvWNGMDLJHwUS2r0Bwl
	 qzspPNV8rY4goD6XxsBwP54V9TEBEQntvHc4gq6ecOy3AVxFJxbIGlsK5xk6BHxXQG
	 RqEQYcDkhMAfPETQmR++9qShv5tXPjog/5bA0B9NxS+rBotMTSP9eHwflf9x9F5mz4
	 9RqiOhJfkjB7gyIHVLpfi6CydpGti4dMLgm2EyPgcc/FPBEbwAku79GIJ/9DjhXcD5
	 gHnT+VxQI2b+g==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 14 Sep
 2026 12:22:30 +0200
Received: (nullmailer pid 1906231 invoked by uid 1000);
	Mon, 14 Sep 2026 10:22:29 -0000
Date: Mon, 14 Sep 2026 12:22:29 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, Wyatt Feng <wf.kernel.dev@gmail.com>
Subject: Re: [PATCH 12/12] net: xfrm: reject unrepresentable espintcp
 transport headers
Message-ID: <aqfK5ap1hORomJmY@secunet.com>
References: <20260907093020.2228346-13-steffen.klassert@secunet.com>
 <20260908224902.1591378-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908224902.1591378-1-kuba@kernel.org>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

Ccing Author of the patch.

On Tue, Sep 08, 2026 at 03:49:02PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: xfrm: reject unrepresentable espintcp transport headers
> 
> handle_esp() in net/xfrm/espintcp.c switches from the plain transport
> header reset to skb_reset_transport_header_careful(), and drops the skb
> with LINUX_MIB_XFRMINERROR when the offset does not fit in
> skb->transport_header.
> 
> > diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
> > index 674aedc5af5a2..3e72b9f067b9b 100644
> > --- a/net/xfrm/espintcp.c
> > +++ b/net/xfrm/espintcp.c
> > @@ -30,7 +30,11 @@ static void handle_esp(struct sk_buff *skb, struct sock *sk)
> >  {
> >  	struct tcp_skb_cb *tcp_cb = (struct tcp_skb_cb *)skb->cb;
> >  
> > -	skb_reset_transport_header(skb);
> > +	if (!skb_reset_transport_header_careful(skb)) {
> > +		XFRM_INC_STATS(sock_net(sk), LINUX_MIB_XFRMINERROR);
> > +		kfree_skb(skb);
> > +		return;
> > +	}
> 
> [Severity: High]
> Is this gate placed early enough to cover the pulls that the ESP input
> path performs on the same skb afterwards?
> 
> skb_reset_transport_header_careful() in include/linux/skbuff.h only
> rejects offsets that are already unrepresentable:
> 
> 	long offset = skb->data - skb->head;
> 
> 	if (unlikely(offset != (typeof(skb->transport_header))offset))
> 		return false;
> 
> 	if (unlikely(offset == (typeof(skb->transport_header))~0U))
> 		return false;
> 
> so any offset up to 65534 is accepted here with no margin left.
> 
> handle_esp() then calls xfrm4_rcv_encap()/xfrm6_rcv_encap(), and the
> chain xfrm_input() -> esp_input() -> esp_input_done2() pulls the ESP
> header and IV off the very same skb and resets the transport header with
> the unhardened helpers, in net/ipv4/esp4.c:
> 
> 	skb_pull_rcsum(skb, hlen);
> 	if (x->props.mode == XFRM_MODE_TUNNEL ||
> 	    x->props.mode == XFRM_MODE_IPTFS)
> 		skb_reset_transport_header(skb);
> 	else
> 		skb_set_transport_header(skb, -ihl);
> 
> with hlen = sizeof(struct ip_esp_hdr) + crypto_aead_ivsize(aead).
> esp6_input_done2() in net/ipv6/esp6.c has the same shape for the
> AF_INET6 branch of handle_esp().
> 
> For an skb whose head offset lands in the window [65536 - hlen, 65534],
> the new check passes but the offset after skb_pull_rcsum() no longer
> fits, so doesn't the truncation the changelog wants to eliminate simply
> move downstream, now on a partially decrypted packet instead of a clean
> drop?
> 
> Can such near-limit offsets be reached in practice?  espintcp_rcv() does:
> 
> 	/* remove header, leave non-ESP marker/SPI */
> 	if (!pskb_pull(skb, rxm->offset + 2)) {
> 
> which makes skb->data - skb->head equal to the initial payload offset
> plus rxm->offset + 2, and rxm->offset is bounded only by the size of one
> coalesced TCP receive-queue skb.  If offsets at or above 65535 are
> reachable (which is the premise of this patch), offsets a few bytes below
> 65536 look equally reachable, and the peer selects them at byte
> granularity through the 16-bit espintcp length prefix.
> 
> For ESP transport mode there also seems to be a second-order effect.  With
> k = (offset + hlen) - 65536 and k >= ihl, esp_input_done2() leaves
> transport_header at (k - ihl), i.e. wrapped, and
> xfrm4_transport_input()/xfrm6_transport_input() in net/xfrm/xfrm_input.c
> consume it directly:
> 
> 	int ihl = skb->data - skb_transport_header(skb);
> 
> 	if (skb->transport_header != skb->network_header) {
> 		memmove(skb_transport_header(skb),
> 			skb_network_header(skb), ihl);
> 		...
> 	skb_reset_transport_header(skb);
> 
> Can ihl here become roughly 64 KiB and turn that memmove() into a copy
> that runs past the packet data into the trailing skb_shared_info?  With
> AES-CBC (ivsize 16, hlen 24) k can be 20..23, which is >= a 20-byte ihl.
> 
> Would it make sense either to give the espintcp check a margin covering
> the largest downstream ESP header plus IV pull (or avoid the large linear
> pull in espintcp_rcv() altogether), or to convert the esp4/esp6 and
> xfrm_input transport-mode reset sites to the careful helpers as well?
> 
> Conversely, if offsets in that window cannot occur, what makes the check
> added here reachable at all?

The patch did not add a regression, but the question if that
can be triggered at all is valid.

Wyatt can you explain how you tiggered this bug?
