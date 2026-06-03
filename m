Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5152A2DC334
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485823; cv=none; b=HuiiGT1RIl2MtZPtwdQELhLBG9JUZEtgisvh46shaP08+62j5pr9FQ+QO5aqtuTihCr7gkWg4Zn5H7DkNeIz9W1LT+A4nRGmsk9tTsiWe1NIAhaII8UldfVl+EXW6ZdvRMGDcZBuFu1vCE2KVgCo1U5tWoX8SsQn/QAl3jmZZC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485823; c=relaxed/simple;
	bh=2kWXiCHi92nvKi/QTqY8tZ968lNNnX1Gw/uZfgeXfH0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=uIUbQLG4Lm+5pGOiJXogw3oeR80ifS8p65hpslNx6pQD7HjY0O9kScJrRuxawum4Q5OpfNP3Kx81MBwMBtYNW5G9K5qszKsItTJv/ENjtIH7N94F7gxt17PwPBwGgsITyn9KZiMiD5+nTOW9eAeLYI6RIAahVpHNthz1yc/q0HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WW85VgGe; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WW85VgGe"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260603112339euoutp012216d9e3463f174ff4cae72919dfd4ce~1jmtgzg9k0340003400euoutp01D
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 11:23:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260603112339euoutp012216d9e3463f174ff4cae72919dfd4ce~1jmtgzg9k0340003400euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780485819;
	bh=jv2NZDjCmqpJ6i3N0i8aFFmqp0/dthJadelXYP91Vuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WW85VgGeRJIAjkVn0BCJm446CNFu9QnAATEQRgJ1/8mNOHFWH3LWNmnpEBQJrHVCh
	 Oli/Zoc7R0/7JJ0oTIpzssKfHBRswvHEa7MH1/cqtkxGOwY8tlO05xRtHPdnFVPZY4
	 YjBHwZTdnhXw19GZ96SuY2E/AlcAeWxo2xjhuxK4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260603112339eucas1p2cd5715cf813f8328d391177f057d3f82~1jmtIucSo1667116671eucas1p2W;
	Wed,  3 Jun 2026 11:23:39 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260603112338eusmtip1bf193be958356b3f7da362d226643219~1jmsMvpKs2273522735eusmtip1r;
	Wed,  3 Jun 2026 11:23:38 +0000 (GMT)
Date: Wed, 3 Jun 2026 13:23:34 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
	k.domagalski@samsung.com, k.tegowski@samsung.com, cs0617.lee@samsung.com
Subject: Re: [PATCH net-next v2 1/2] net/stmmac: Check for STMMAC_DOWN flag
 in all XDP paths
Message-ID: <aiAOthinXOZexBnw@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260601163258.554300-2-j.raczynski@samsung.com>
X-CMS-MailID: 20260603112339eucas1p2cd5715cf813f8328d391177f057d3f82
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="-----ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_e99d4_"
X-RootMTR: 20260601163313eucas1p20203ee427dc9d3733a9218835f4f7ed3
X-EPHeader: CA
X-CMS-RootMailID: 20260601163313eucas1p20203ee427dc9d3733a9218835f4f7ed3
References: <20260601163258.554300-1-j.raczynski@samsung.com>
	<CGME20260601163313eucas1p20203ee427dc9d3733a9218835f4f7ed3@eucas1p2.samsung.com>
	<20260601163258.554300-2-j.raczynski@samsung.com>

-------ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_e99d4_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 3591755ea30be..3a66f28425275 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5267,6 +5267,9 @@ static int stmmac_xdp_xmit_back(struct stmmac_priv *priv,
> >  	if (unlikely(!xdpf))
> >  		return STMMAC_XDP_CONSUMED;
> >  
> > +	if (unlikely(test_bit(STMMAC_DOWN, &priv->state)))
> > +		return STMMAC_XDP_CONSUMED;
> Does returning STMMAC_XDP_CONSUMED here cause a memory leak and a double-free
> in the zero-copy path?
> Since this check occurs after xdp_convert_buff_to_frame() is called earlier
> in stmmac_xdp_xmit_back(), the conversion has already transferred ownership. 
> In zero-copy mode, xdp_convert_buff_to_frame() allocates a new page and frees
> the original buffer.
> Returning STMMAC_XDP_CONSUMED at this point leaks the newly allocated page
> because xdp_return_frame(xdpf) is not called.
> Furthermore, the caller stmmac_rx_zc() handles STMMAC_XDP_CONSUMED by freeing
> the buffer again:
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_rx_zc() {
> 	...
> 	case STMMAC_XDP_CONSUMED:
> 		xsk_buff_free(buf->xdp);
> 		fallthrough;
> 	...
> }
> Could this result in a double-free? Would it be safer to check the STMMAC_DOWN
> flag before the buffer conversion takes place?

Gonna respond to Sashiko review.

Funny how in first version of the patch Sashiko wanted XDP_CONSUMED instead
of error and now it considers it error, but thats beauty of AI. But 1st concern
was valid.

As for this, same issue would be when if(unlikely(!xdpf)) triggers,
or even worse, because it would free page that failed in stmmac_rx_zc().

Issue regarding ownership is valid though and this should be fixed -
it is freed by xdp_convert_buff_to_frame() but is dangling so should either
specifically free xdpf or xdp_return_frame().

"Would checking this before buffer conversion take place be safer?"
Sure, why not, but it will make code bit more ugly.

BR
Jakub Raczynski

-------ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_e99d4_
Content-Type: text/plain; charset="utf-8"


-------ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_e99d4_--
