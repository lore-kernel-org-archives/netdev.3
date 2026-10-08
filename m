Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DF4534440
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914234; cv=none; b=IZFZscF7k+WLiLJj9FPfOeYbNxZRD0y98OqE9h2KB2xm4X/CupajNsSpg3QbrSCBhJ5d6JtUXQNVJeEJvhil36RuvCSloUTtuckTD3CqceFfYyp1E18szrHJAjRhOMntAEN3GRZCiT5ijNTnP6E0X7S4RBdwvDTE/iO8b9cuZyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914234; c=relaxed/simple;
	bh=UWPvnjOv63k2n4GV31aTm5MT/9h1TqVy/TiyOQxup1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBIUfbjgiRZLWpNCMTyfFPFfZzsiDvroYYRhf2t7ZK5JYrFUCgrCXEL3p3oMvijzbXJt0R8p7L2ya4g05w7s4KDYi+9JObfG6ci0/tGuKMy07Jc7sjAbMkLC+3UsFihhZpgjpRFtJw3zxS20PVvXpdgSMVipbLq/G4CD6E4Iqkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XAeU0AW6; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XAeU0AW6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7579DC653FA
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:58:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D44FF60362
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:57:11 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id 4B0EE11D718A4; Tue, 13 Oct 2026 19:51:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791914231; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=2KrY5bcaWM/iCHC3nc2lc6IZhhlnFZhRjcHEfSOffhc=;
	b=XAeU0AW697oBR3wZ0XhC/T1qjWL4FxMkLkAxclZEsxZCehTDXS3nfLd/2jTYN7NjbqZhI1
	7VswTvYnsnmZ2ABuegmIh0HysHc7NCHiUkk6pmJpwVRi2gshCQEybXpSGry+pWoLu65Mdc
	My1VQr/tA3+T52xcL4rUVsWW/k1mOjLJ7Qdp+4E4Ubt85WZCu9sJTqea3lByeK/6zweKPh
	XC2dSg6kYIICGh9fupR2UVL6uX1WCtbPJ9Wey3Ps6ceXhPC+A4UMHBnK3VcGpkGLPh+RTr
	dqjeiVz2VDu5sip2y3L0XCC+UHY6MINqfcU6/6lxeAZ2MJLIMNMdQgWfHeFFjQ==
Authentication-Results: mail.galae.net;
	none
Message-ID: <bfc0027a-932e-42f3-93b3-49ab5474abd6@bootlin.com>
Date: Thu, 8 Oct 2026 11:04:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/3] net: rss: Require indir table size or
 hash key size to support RSS
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux@armlinux.org.uk, lorenzo.bianconi@oss.qualcomm.com, nb@tipi-net.de,
 jitendra.vegiraju@broadcom.com, thomas.petazzoni@bootlin.com,
 alexis.lothore@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, pbrobinson@gmail.com, joe@dama.to
References: <20261002142806.1299041-2-maxime.chevallier@bootlin.com>
 <179121059086.434549.5364767976780818051@kernel.org>
 <d6e61c8b-cd3d-43fe-b4ac-19ff5d790b0f@bootlin.com>
 <20261006163349.61c738e8@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261006163349.61c738e8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: 4B0EE11D718A4
X-Spamd-Result: default: False [2.39 / 30.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[128];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.01)[44.02%];
	RCVD_COUNT_ZERO(0.00)[0];
	BCC(0.00)[];
	TAGGED_RCPT(0.00)[sashiko,netdev];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[localhost:rdns,localhost:helo,bootlin.com:mid];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,oss.qualcomm.com,tipi-net.de,broadcom.com,bootlin.com,vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,dama.to];
	TO_DN_SOME(0.00)[]

Hi Jakub,

On 10/7/26 01:33, Jakub Kicinski wrote:
> On Tue, 6 Oct 2026 09:59:29 +0200 Maxime Chevallier wrote:
>>> [Severity: Medium]
>>> rss_get_data_alloc() is shared by RSS_GET, RSS_SET and RSS_CREATE. Does
>>> this drop flow-hash reporting for devices that have ->get_rxfh but report
>>> 0/0 sizes?  
>>
>> Yes it does, that's the intended behaviour here. RSS bits are all optional,
>> but does it make sense to report hashing params when the indirection table
>> is size 0 and key len is 0 ?
> 
> Not sure if there's an implementation in the tree but 
> it's possible to implement poor man's RSS on strict
> power-of-2 queue set with some hashing built into the
> Rx engine, without a key. We'd still want to control
> which fields are hashed in this case.
> 
> In the Netlink API we combine the two so we'd break this?

Hmm I wasn't aware of that :( I guess the safe choice is to check on -EOPNOTSUPP
for .get_rxfh() + 0-len indir table / 0-size key and skip the device during the
dump instead of returning early ?

Maxime
