Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B3253958;
	Mon, 15 Jun 2026 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781562254; cv=none; b=TAHZITrNZW8cCjXkJJ0r9DZH5HFC69Wfc+e+YJ2EwN3zgyf8Fc0kXDNT/OINpb/pLGr08DI6lGgwuRSB6grNdDY2I57R5InRoHvmYH3TLU4NyEK4X3mPFPBcx50XauHi+m2IsDQHYdzUYJYx2MsX0+IHt+ZRq1bqtVPVfON/egU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781562254; c=relaxed/simple;
	bh=Ck6oW+UV6WWpELEiwLGD3DMzFlKYRT7AuvIE5fJxano=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5rKr9RbpcHK/7+k8aenD33uFjPEl5PAvrMdYPtwPAd4v/PCn6WB3mg3WEwptjbsjK/IsDJgjFX6glL4rVr75kwlJuKjYA0yjc9upFSjkOK1rjYJ1qjLmH11lTKV9iDBVCSgl6INDNATydqE9sj8jO7phlGERodtpiZKKGGGzqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=MWmVgEvt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AliQLUpt; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="MWmVgEvt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AliQLUpt"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E5793EC0184;
	Mon, 15 Jun 2026 18:24:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 15 Jun 2026 18:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781562251; x=
	1781648651; bh=vTb+Ifos7RekvApIv68Ss6RZwt/Fqz7M8khzu9TWQH4=; b=M
	WmVgEvtt1O+6xUQHW42k6U/PdLH48pzAiGVBazVW6SBXilkfA/ba6vSWB5vv8ddZ
	Nk8r2QEJLXJqqkPYF3ucak3LYCJfx6/jf/Inu5kZH2c/GWY3FA/OC/hdld6ET0No
	E+bHX0N0buwm4iWMoEKjNxhuKZJcsu3O5O9pB2I7w4FIxVe4IR43kP9fIkP/SbCh
	dI0qTTSyI5oH4FPtvgsbCVYIT57krOUInYEjHV1B72IKHWBR6+o7/atJLqZqHZvh
	tqvzPXKPZzYbiW93Q3ByERS6xlp57eBLM3s2KDplsj4QgYM7RI3qxKdoGHNlLYzU
	qY/yRzLXvIQ6jIh2gs5jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781562251; x=1781648651; bh=vTb+Ifos7RekvApIv68Ss6RZwt/Fqz7M8kh
	zu9TWQH4=; b=AliQLUptKEjpKdSA6lNP7XNotAa+Bsey4mNQLvLvWxG/TLCWhGd
	ZdUP/ziFtjuCZLqDTYyIE65Jjgh4YlrYL+V8gqUatmUFNx5voJpS5J+o8QgkoZLD
	vqM7l07T8yRbXgOT8kd+hQpO7LrmlOvCkDEY/ae2O9zAbkNYeseYnm/csLg1GWlE
	yk/Ra8AK7btWkvTSa8bCWiBLCka6Xppa4LJSsMvzsk64EV852lzeXbcoHIN8ESsX
	UEZGWOlM9TcgxP17IpQTw46c+MIDfUEXjlIaIQcPYUJg4i1sU2BbOc0ZDIemLJNi
	406Ni8155aMfWPSdG9HPZ/48QiSr/Etq7mA==
X-ME-Sender: <xms:i3swak3G17vKdUgnYSKKbbCjrB0-3oqlwSypYHT5W4OT7Aed84iX2A>
    <xme:i3swagrasp4iL5hu6s0B8CxImpurJlx77k0QYNAaszm_26vRRXSUom3_ibU_zkuaG
    TYwDuU4ghOR-bwo5tqMR6B1F8zFZcRXLoiLxglpDwioemJcNnsb9dI>
X-ME-Received: <xmr:i3swasJozjU1LnzbuEBudqaA_I8REYfSn-6_aM0mH_neWLiIDJeyJS_38Q_sxL9w0uZi8KUdmIiPKa18Y2y4QFU>
X-ME-Proxy-Cause: dmFkZTGcC0OyF7QcL8zHSJPvYuC/f2eOMXgRz+jax2sxEVGQFMgdPdSHImiIbtpQza1Hhe
    zANnl3bNLbt8BSu5Q86oZDgYVHPTxgmFpX04+rdi4XU9c3+/1oRsFAjFfYuJpv4691xr9+
    xEG+Bp7OX3soPs8ay4FOR+vzQJnI8hzjuMa3AQ7eIEjquN5Pzad/StkaL+0wdYiIdajWFw
    oS69uf6rJvqDtYuV0a1TOfgTx6hCboyb+LCV2e6mPYpdlRIuwKBbPFAK9VQRlAYGVazIUA
    qjZpFRuyhdq4B2jT2LsGISNZ2gpdga2V7lD0gWlhsEaMjCtI1XPvCQabgGg1nL+uUaR1G9
    tSeY8E+AlvxPJbvacUVhCZWZtndR8WispB1FmzT2Nh15Lr13i/1BdQHS0xmJyX25tplGZf
    Rl7ZwWWgK4u1J8uUxHWVHam1rBlR/X/rhzL+hsQu9QzhdcAgwYaGCyZNtwt/PNwEKCcqQQ
    QTeowr55N+7YnPBb4W+uYOA2S9M3n1X8fg7nFC/1K/R9wMBVDghoEZhy9L+XfZZZybxDf2
    B8whAOSlOZpDeqLCkKNr920ZYUAGq1UPMuY2MVlRsGSBQTpBh+3t1m5Iq/6z5lYDOi3xcw
    Fh9u6N3E5FRu7ZyRvGfv5dVqLTrd3nHVo1X7KzbxHBXOV5rB7wNw8U4UKTCw
X-ME-Proxy: <xmx:i3swakS411SLZQNvWUmqVMOvyoVFp5NwJAvG60MntzwGnF-Dl1mcBw>
    <xmx:i3swasOar4-fRnlu927JQgIneHuW-lx4uyV1G69lQ6b7OpZtrDRmjA>
    <xmx:i3swapWV_gr2rK41ffylk27CQH-CfiDS5f4Gh4Si9lePXHJjMV9kpQ>
    <xmx:i3swavivFQF_eedquDaaE752ZxA9ar2XjiJMtXb04Y97QUMTF4AzIw>
    <xmx:i3swalqT8HsyjS_85wiYkBvPOXiA5LZH96f5_ubCY3Y8RA2Qo7Ug4xZe>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 18:24:10 -0400 (EDT)
Date: Tue, 16 Jun 2026 00:24:09 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	corbet@lwn.net, linux-doc@vger.kernel.org, john.fastabend@gmail.com,
	jiri@resnulli.us, skhan@linuxfoundation.org
Subject: Re: [PATCH net-next v2 1/3] docs: net: tls-offload: document
 tls_dev_del, tls_dev_resync, and rekey
Message-ID: <ajB7iZQfwX2fnw9K@krikkit>
References: <20260613165846.2913092-1-kuba@kernel.org>
 <20260613165846.2913092-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260613165846.2913092-2-kuba@kernel.org>

2026-06-13, 09:58:44 -0700, Jakub Kicinski wrote:
> Fill in some gaps in the TLS offload doc:
> 
> - describe the tls_dev_del and tls_dev_resync callbacks
> - add a mention of rekeying being out of scope for now
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - add mentions of the callback in resync text

Thanks!

>  - Stack -> The stack
> v1: https://lore.kernel.org/20260609201224.1191391-1-kuba@kernel.org

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina
