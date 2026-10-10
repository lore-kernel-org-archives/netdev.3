Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A49255F52
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791626213; cv=none; b=kx4kIbzXYhCJXh6h+Ijxbz2qUV/XitSqHES756NpMIpDIvKbIFR86hzoJ/SPfxKovwsC3BpuwgFNQLcVeyIcACaA7j7kQVcEQD4A+Fh4VKYxPCFYQLQqcFQcpDuRC5rpHuPkixizs+hQCQoxVedy+f/JbVJO2/nzyMox6/tSNR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791626213; c=relaxed/simple;
	bh=EQwaIVpYCg5E5ydBQbytU/MGSRUfC1bWM8MHkwd4dos=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnDj+bnb86DHxIGtJV/66/RGFDwDonj3TkQmTzbdiCCcWlxWU66Dx0BYe5gbDX5TfqcLsr/RsFRZbiChrl11fSVQIhAHqWbxym9jTipPc0Hvpkp/vO3T6zq57nGo5tEp9cWt22JrN6677hnC0BAZtEldSFqe1Z53OfxLih2Z5mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Y1+Hn8nr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jrVT+kSw; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Y1+Hn8nr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jrVT+kSw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 70B0D138009F
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 05:56:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 10 Oct 2026 05:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791626210; x=1791633410; bh=nJReIR9tSV
	8zwZOy58+KzaQBNhO7VbvAAXc7HpRGYro=; b=Y1+Hn8nrpp064xV6sAge7A9fhD
	W6cPOm7upOkqGcSpfSC4tjBfkLZbcSsQ/PbBdUS+tMD/p7KobLcSmNmwckVWbvqO
	FQgPGZHyRSi9LSU5nb4/JyJK3R6pHdUHYstO5fan21HH+izFiZoiaIaAJ+GlQw2R
	Z4HCT9f2fmMFn+CisWC0FimYj+paxB+hm49CU7Pej4vIMvKtUGQZTdANGlRdt+qR
	oBm+WpJL8K832xAp8DH/cfkrVW1A7ym+805RHxohQ1/znN3oB6BzAXk5SeU41ZcQ
	4o4iUirKE3shoFgWMIsbMh2ms0Vzx5eaLv8BP1tgFi1sxi4fDiuSKt4kVSLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791626210; x=1791633410; bh=nJReIR9tSV8zwZOy58+KzaQBNhO7VbvAAXc
	7HpRGYro=; b=jrVT+kSwdWYpLuwFHG9QHLj3s/VpEgHbvn66esiWcvMt1MQTwB/
	dKnT4hJ3xhwCSBGvKwVP6K5tW2xuv0I95UD3qJwGUzRxpAGnzhXPAezWNvyFpksl
	6SPTWHc1uz2SOOqHz9lDZA1TvLeGAOoM71KDqD+wwhtyKKpGdJ/MynGqS3v5gOPg
	Mx6YAvngqot5If3nWo7PAD0Pvx5bdG/6Z668zHBHqG2ypR669cmAEAtvRC7oW+qE
	cAsSgQGGN+jelmQN1iVU2C5JuGBT3wAFd52kwuCWX1Aw++YwCiS1DGQhWFpfQxuH
	239a7RpBRN5tU+CGkbi5BPi2hMaUkkMXXcg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791626210; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hxnY46BnjOGU7QOYsukbuowGCuYkBup+YQvQtnmjeH2Nvs8
	o2rmrKCncGlH/3RNSlkzzEh5CTp1qKb9lNcOzjLP0X7A6I+Z6lOHELOwRZ7ganBP
	xcIn4smpkPTGWNYIQjFUwGdj+1gWVLXzLmlpw16rV0MRKQ91gAGa6Yq1w2EqHCmC
	OsFYltTT7b0Xk0BgiesLveLGxH2DmCaiQ96qcE8U3uVXlo0sFQMR16ODbwFs1ljj
	YKeZmIDhSgSHtf8wNNw2sVVh1gzfWHVEHQJqYr64YsyPK/bsF5tP/NLfmDlYq17B
	fOZBo6suT2T1Kaj4TvP+cFcxYfJYL93WVsVwPTw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:dx36ySUIPjOF8JZnX0c0xgk6+9g6Jwnh6Uao7zqga6w=:EQwaIVpYCg5E5ydBQbytU/MGSRUfC1bWM8MHkwd4dos=;
X-ME-Sender: <xms:4QvKauiHLPn4eVXalp1mor1b_mEOJ5zbdN6Ab_DSdZIr-lfG-WHzIg>
    <xme:4QvKaiWSyejddYyH-GIHxYoWg7LWs0joWqSiAGr30pBwacaRVuRbEW6IbmgqUHPNf
    gJKc7uoi1s9IORCdmLQtZfGlw0IVdd-30WqdByUKxrmzcZUYfk>
X-ME-Received: <xmr:4QvKah5mzv1qds_FTzF48aw5fJT0YeaMpMPRZvsMvxsD9jgCtPT-ldRuGTPmq6QmpMvBOjDz-WhDkT5V6EuUT7nlpuj88NdoZVQyRHQ2xyk>
X-ME-Proxy-Cause: dmFkZTGNwFotM+MERPG7jwl/03lTN6Lvym52gvNwntgQ9yPA1rs2/HESVaUYydqavpJNTa
    4jDJPfayYKNrO+uNFu5P8MxBVZOPlUifNdd1B8EShhlMxxqQ6tdo1HvlwpN4RvOJ97eYPW
    ubQCD5XOADVJBw6yNerhcYSXhABUthZo8s6xILymRleoxS2ZJHI56Rt/T0XIKMmNXtRAKU
    FVffDP0WJY5BsT2RB0J31Qiv8yL4tyAgjfn3ZKh2e+qRBTthb0V6PynXEw3c/FcA+nUlhf
    xBH64Y7gU9X/hYHRb8S3CmFyDXJi7LNf9XC/g6sPKEoRlaMIOGgyT0qQuNJJKDxv9LT3NC
    F9cZnnsljeWuGbfitECMa5nMFXCE7wX0dhdNdRP5VZanKwncmCN7l5AqxAdtoxlGKkadYi
    ihNifPcTEl+1d8C490YOTlIdZ3QiIpMNiKUCzQAP/x5w372El/bFS3UxCMza2RQlZJVJ5y
    b2G6Twzzp3l9gCVsJa5Zx7kebQkQp2ooFw+/+wC18igLHrpAUIvvMFzy8deWhqw5tthKBP
    u7OWHLexdIMcPExY6qnBCyglBl1/h+g1qFa5qpWI0N/uX4xZeBnFhKapVeN0VaVsQs9Mb7
    S0+2ypT1/PHPXqQx5L1fXd90vbJ45XAmCUbJmX6zc1nZ1w8a4xLwa/vc0ucA
X-ME-Proxy: <xmx:4QvKaqcYgLZBkQZY8RBBR5_45rbklwyLopweAya9ChSFZdP4MVtiOw>
    <xmx:4QvKavvSc4vYAhiLnzn_o5KejXU6q692Z3pZWTQC2bWH7OwaJEkmsw>
    <xmx:4QvKaiiaFuk8NF4Q-oF0m_m9pY00H3ItsjfXllgVZR_tPJHVKy8sZg>
    <xmx:4QvKag6Z1NLzALCDHQ1hSqPHkUDoKYAxKml3qQgXnIWBewr00p4s6Q>
    <xmx:4gvKasNjp-JnMOY4xx_f0z8PRk-6YxljNDwCl1YFFOWeeTWEZAj5gjDp>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Oct 2026 05:56:48 -0400 (EDT)
Date: Sat, 10 Oct 2026 11:56:45 +0200
From: Greg KH <greg@kroah.com>
To: AmirHossein HajiMohammadi <info@hajimohammadi.net>,
	David Miller <davem@davemloft.net>,
	Franco Hector Hugo Montenegro <franco.montenegro.ruke@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Wireless <linux-wireless@vger.kernel.org>,
	Hungyu Lin <dennylin0707@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonardo Martins Martins <dev.lmmrtns@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Luka Gejak <luka.gejak@linux.dev>,
	Networking <netdev@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Ping-Ke Shih <pkshih@realtek.com>,
	Rishik Yechuri <epicrishik@gmail.com>,
	Rishik Yechuri <rishik.yechuri.code@gmail.com>,
	Rishik Yechuri <rishikyechuri@protonmail.com>,
	Siho Kim <siho93.kim@gmail.com>,
	Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
Subject: Re: linux-next: manual merge of the staging tree with the
 wireless-next tree
Message-ID: <2026101032-negotiate-overbid-c704@gregkh>
References: <aslfIkFxsc9oIqku@sirena.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aslfIkFxsc9oIqku@sirena.co.uk>

On Fri, Oct 09, 2026 at 11:39:46PM +0200, Mark Brown wrote:
> Hi all,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   drivers/staging/rtl8723bs/
> 
> between commit:
> 
>   c520f3af7df42 ("staging: rtl8723bs: remove the obsolete driver")
> 
> from the net-next tree and commits:
> 
>   dbc2fa996f446 ("staging: rtl8723bs: Remove manual ifname allocation")
>   eb903412616ff ("staging: rtl8723bs: make rtl8723_dequeue_writeport() return bool")
>   94f8dd8b96b03 ("staging: rtl8723bs: remove unused monitor interface name")
>   0e5058a181451 ("staging: rtl8723bs: rename PHY_ConvertTxPowerLimitToPowerIndex()")
>   36d9b855cf944 ("staging: rtl8723bs: make xmitframe_swencrypt() return void")
>   18a42264074ae ("staging: rtl8723bs: remove unnecessary parentheses around prframe->u.hdr.list")
>   6b4405c0f6001 ("staging: rtl8723bs: align function parameters in aes_decipher")
>   2268c1bf1a861 ("Staging: rtl8723bs: fixed camel case coding style issue.")
>   bbcc68a61f3be ("staging: rtl8723bs: fix block comment style")
> 
> et al from the staging tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> (deleted the files)

Yes, deleting all of this is fine, thanks!

greg k-h
