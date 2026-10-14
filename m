Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FF8519929
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985149; cv=none; b=aUX7xFa82m3nCdcvsVF+N7fKfoZ4kKrCxMHSl6r5kyeqJ2Z/pN/l7ZEiV14K+xJzx9aJi0puvV8cGNi5n+MvvoYG+pQRONgzKfjfqUdkaQtIBVIm9Fi8JMBplJf3PKOTYYsofSyqfThhFO6Vhm27aSSBjZeLuJnQwH0LqDn170c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985149; c=relaxed/simple;
	bh=XRrUOzN+NP7TxCqwyqb5G/WICf2DwxlBtMMD3s12L10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSnSYVKmXexZwOc4DWuBelDIGDik1dV1yiAguxqV+9DX2rV73XVnd8WNRGkR2FQw24Fv29TfFPzLz3kY2H5QPX/H1RburzQ14BZYO6lZwjcktCF7PzXNreWk17UyKT2xy9vq0aIh0BWJq6fhcODzwZDZwlk96eGH1Z5kFf8sNCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=UA8W0FdN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WAbKs0p9; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="UA8W0FdN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WAbKs0p9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DDE92EC01D3
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:39:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 14 Oct 2026 09:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1791985144; x=
	1792071544; bh=8MfkxtYGDYyWeBPkbEJGCf75gCs73x5kwKUCjnhnidw=; b=U
	A8W0FdNk1QXN8znJA4fHbzcRQzSkLzjUgxd2e5TAuAOdziLEHZdHRI8Y4g6JC0Nn
	m4Af4a8N3Y6MrG7B93QgyUUF3eRZdPF97L1UkxEweZiT3x/wRT3ukBJf9bTfhGnR
	TyL/EA0vIstmZHd0okV3i9yNDiSXKaNhkmGEMjRLl5FlMwdJuFvcmHHpi10tO31b
	lQUdDlBLYsDrNeWi9dlgfMPZAwxuxUTkhCJDvad0iEQDIZ+i+Yg9XR4js9aP7LjZ
	TLT5cc6VUVVI6lliCkDWMaEPNrazm1hZ6/J8yFZNLIGuztYzf3+HdC4RtfLSJEZ4
	CjMngeoE77zfIA3VCFu1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791985144; x=1792071544; bh=8MfkxtYGDYyWeBPkbEJGCf75gCs73x5kwKU
	Cjnhnidw=; b=WAbKs0p99IPalo1LYgp/JvrD5ggd8AZRdj6/kfdKhkMkxqjC8Cr
	Smn7lJoUNi6KkmbBAD16c2D95yVrtKtdcZIrNb7p/AvwPhgejIYLuvHvTxzzUeos
	JrB1lqpurSyuAA0wfdxfpwO5lZw47jRM1bHLHfOcaF8PvVZerCLWA2OT9tXsVUqX
	jKp6x3DPnYcP9AsGMLi5AJXtgUEQVtJYbFXXZd3S5PuSXr7mqoosg/+OahKxHE0W
	misjuo7G+99bUVnP6t/5CL5U7eAtjrd5VDcGp2tnUL+zwOX1YeW2dfoY5MtHCIEr
	vsCb6ve0AOKISA531T3BDILE7jfJYJ53FbA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=queasysnail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791985144; d=queasysnail.net;
	mf=PHNkQHF1ZWFzeXNuYWlsLm5ldD4=;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:mYO/MfJmW4FjogcVqQs8OP5xWHeQSvfeyvdVCG65jxfTo4w
	8Pxc1/LS1JB6pJhbAAHeJ3sQ9zqQwjkf95p7SDXowLf0CNuYtxvQOzD+ey8T1a1C
	Kfp4b9n4VUl52n6C+qeigcE7esg2i3pqydfWpSd0DTlnW9L4ydG1TuY/+y5z7G4B
	rNUHo8XodMN4MVIHcDBY0P5FrhyD9xW6CpDHyvzalZXzCVKhlWO50AqVgtqsq7Iq
	WFL/nxvdWTrf5zg7jOu0BelJBCSvQFQqJg1h2V2nFq0H0JqPxfrh0B4nHGm5lxmc
	gEMe+G9EmjtHh8P36N6vTR0ZehmIr2LOrNVpRqg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:z605fDMooHPh52ILpT+7O/w9vrtI6MKg9AYlXeQ1Ebk=:XRrUOzN+NP7TxCqwyqb5G/WICf2DwxlBtMMD3s12L10=;
X-ME-Sender: <xms:-IXPanlwbiaS-ycyk-BoC-XKYWvcdD33OWiiIxGtXqMyX4Tnp1PN4g>
    <xme:-IXPag05Mgxq_5KupC_y-YvHfWpMLZO3YhiZfwAfSS_1RDtiAP6OZWCBY7iMLUpec
    1pLxF_GNbQ-xQFirp3uTd1AoxHm8HS7lSs_BjaMrB3sVdbcQ5vfybQa>
X-ME-Received: <xmr:-IXParTu6GIb9dB64LSpIXaMed0iARwDc-MtX096TsVpXLgR2hhL1yq2boM>
X-ME-Proxy-Cause: dmFkZTGvp6gX7ed8hm2jbR6obXdQ8QUqRo94LXU+UoUphqo2VoZZKPA0HFAXTYfTlo3wFs
    JbXDHwZfFNW88vn2hnXeTkcWW3Q/Qi3NC6nCgjqLJbogURiQmb/kfG+Rpvd7Uah5/VpHEw
    Ox503XssiC6s7YJ32mzGjlgrsAvRYPP69nQtW/3r7zorberHMHCzgf/lxnbcSXkJa/3niE
    OTSNgtbcOxq1wC7UnXLN6zHYVAUge9joV0KjpFh0AqNFr/ApQrq2eT2rguxSqX9kVO1LJo
    TJBJPsm3OGWMSi+NNra5qHZXaG7ioRDyeabEMA3QgSsKU+Dd7QG+THWSJ8kLXXSjQcZSCu
    qDItyOBNrOjnVFo0J8W4/2VZr79oNAhmLIMwMkYb6r2EpiLqYeeHAIboJOdpF0UD3sNbhT
    w68lZDl8RVkLkQDZFtrE9GrDjFCqFULBzoLR4i4V8sIl/BoKrRq+rkXY0etC8jrFe6vggB
    pmcuga9zUL4uiqUFGCcarcEwdFTlcLkmMIbPCmj/fdeap0o7SsV+VNb7wtwUbMFjJtQhKJ
    KwZz4NBDqZDI2h4YfTgLPDrbupXznuQ0n+5PkOpaFdGZcx+yz8bwxopdBQIlM/iOkhVFRE
    JxY3BikLCAdmUcsSJiXn8wj6VWqKaqCWcC1nPljimGUFADef3kB9eNJpcnKg
X-ME-Proxy: <xmx:-IXPaqujbbHCBSBNaorD9-Ykkmooal7RpplYpYjSCf6zFb4WtDZCtA>
    <xmx:-IXPaobPJCIoOLaa2AdNlDTj-QL4YShDktJ4UiYdfrqfp8RNNXBWiA>
    <xmx:-IXPanurPr2EX5nbgUVmZvqVKp1El4llcR_uIv3mX-64OB-hBLO0uQ>
    <xmx:-IXPaiE4uHzMSvGWmZTwwwCNtezrdEw0-PHSTKpybXDbNEMnRPTQPQ>
    <xmx:-IXPakxjYEMBEMjxvxRHeQ05nYDnEwyQHo7tdHKEpP2BkSzH1yFaq9w8>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 09:39:04 -0400 (EDT)
Date: Wed, 14 Oct 2026 15:39:02 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Sung Byeongchan <tjdqudcks0424@naver.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net] macsec: reject frames after receive PN exhaustion
Message-ID: <as-F9pXfjTnpAR3r@krikkit>
References: <20261009135109.718408-1-tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261009135109.718408-1-tjdqudcks0424@naver.com>

2026-10-09, 22:51:08 +0900, Sung Byeongchan wrote:
> Track the exhausted state explicitly.  Preserve the full recovered XPN in
> the skb control block so that the post-authentication path can identify the
> full-width terminal value.  Deliver the valid terminal frame once, mark the
> RXSA exhausted under its lock, and reject later frames.  Clear the state
> when the receive SA is initialized or its PN is explicitly reset, and
> restore it if an offload update fails.
> 
> The unmodified kernel accepted a post-terminal authenticated frame in three
> fresh boots for both non-XPN and XPN.  With this change, the terminal frame
> was delivered once and every post-terminal frame was dropped in three fresh
> boots.  Lower-word XPN wrap, replay-window, bad-ICV, reset, replacement,
> and concurrent-duplicate controls continued to pass.

Even after understanding the actual code, I can barely follow those 2
paragraphs. Please make your LLM write in a less obfuscated style (and
also not describe the patch line-by-line).


> @@ -744,6 +745,15 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
>  	u32 lowest_pn = 0;
>  
>  	spin_lock(&rx_sa->lock);
> +	if (rx_sa->exhausted) {

That's not reasonable. Now we will reject "delayed" packets that would
fall in the replay window.



nit: the style in this patch is also not nice:

> +		spin_unlock(&rx_sa->lock);
> +		u64_stats_update_begin(&rxsc_stats->syncp);
> +		rxsc_stats->stats.InPktsLate++;
> +		u64_stats_update_end(&rxsc_stats->syncp);
> +		DEV_STATS_INC(secy->netdev, rx_dropped);
> +		return false;

duplication of this big stats block


> +		if ((!secy->xpn && pn == U32_MAX) ||
> +		    (secy->xpn && macsec_skb_cb(skb)->xpn_pn.full64 == U64_MAX)) {

bool exhausted = secy->xpn ? pn64 == U64_MAX : pn32 == U32_MAX;

-- 
pw-bot: cr
