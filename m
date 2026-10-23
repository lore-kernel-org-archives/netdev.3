Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763578;
	b=ZcBHCQ0ubwTfuPjH7SUJU4xIKYRyZH7mhnIuUWXpnHA+td9YqgzL9zl6tmpZHcf54KF2
	 mp0QHpXsg4O0TqJ+UrYQIWb7J0s+oAZhGIMIDkPgViYYPJQR0SDXhOQLhTZKc+fAuWiWl
	 jDlBLt0L61l8abuayZbAFEXoYYbyBckiDp0Wj5irblioPjCk3uPFNtq5ex6fLUqQcBTCK
	 4tIRnaRMghdkEz0D3b1ehYhvSHtqwygIyXabajntxj2oz4e3Ja7GHfZZZ6Kh7ahypcoCc
	 UydynyV6QvbjXupfykaprMUPDbCNsnUMyDCaNg3ZYtfNTzR/wxLuJYr+a2ScSRhrVFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763578;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=idO/P4wNVCCS8iWUVIafJ01VIG3apG7cu4Mx0xXu/2k=;
	b=dB3evsTgpzQR5F+XFXuJSu6cS2+OHDpdQQe6QDnoW8jxeUVPEkXfiQfibi1UHnMeN8Xh
	 3Bs3KoYIxRIDRqYgh6D9ngNgwlXCD9v7jWltevqPLc4vanorJghC94pqMVKC7a+mTAKO2
	 MmMZJ59aYTzJr7/2FFYBUbBKNzG2qi2CCc6r2QwSf3UkRNk0ruI8qJN7xmK7U2FXDUQjQ
	 p8g70du49yoDp32t6XwDrYvTRVLrhBJ56pcN9YC6EsYTTZRDPlxdiwPOuOCVWjU1SqLnM
	 baHRI7uElAn1CJuyvkoZbsXW5TlOlv4hnpyykILWLGMbkIn3QZvRBpxVDNoTOFTUYSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=b7u7k6sk;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EB6606A31D
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50EB6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=b7u7k6sk
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 827241A12F2;
	Fri, 23 Oct 2026 13:52:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 54BF460398;
	Fri, 23 Oct 2026 13:52:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88ACC10328E54;
	Fri, 23 Oct 2026 15:52:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792763572; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=idO/P4wNVCCS8iWUVIafJ01VIG3apG7cu4Mx0xXu/2k=;
	b=b7u7k6skjQay1BQaLP9nX7hB6gqS/T31ASpavRQtwdTXPr8aj1CqM+0jCDW3KZyyKAztj8
	pDJ2P6GK0REsFJi/s7dNrDvG1GZe8sVmUH/ATTfagyAKN8mt+CO99JsDlj0lOSpp36vt4p
	el55TwFVgtuEH4ohfeo8mheA6IHcwGjl1wi8NCeX0LTxAuRD+hMV9NsnpRiBL+1F0iWUhp
	zLnGrKejhuptBq4oNkT7QL/1KEaJMZOZDvgFr2lDVxurDZsOF8jWtZDypFvGN1aOlunxC6
	hFqT0uSPyoSAgiAKjw2aNn3jCksP6S5OzIF+LdAMqYiEh4U5koOb8WiRunXJng==
Message-ID: <2c36a835-d297-44b9-a8e5-cb256caccbc8@bootlin.com>
Date: Fri, 23 Oct 2026 15:52:45 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpts: fix support for
 PTP_EXTTS_REQUEST2 ioctl
To: James Clark <jjc@jclark.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261020003525.1237742-1-jjc@jclark.com>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261020003525.1237742-1-jjc@jclark.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/20/26 02:35, James Clark wrote:
> Commit 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to
> ptp_clock_info") modified the PTP core to validate the supported flags
> of external timestamp requests, rather than relying on each driver to
> check them.
> 
> am65_cpts_extts_enable() ignores the flags, and am65-cpts was not given
> any .supported_extts_flags. Since PTP_EXTTS_REQUEST2 always implies
> PTP_STRICT_FLAGS, the core now rejects every PTP_EXTTS_REQUEST2 for this
> driver with -EOPNOTSUPP, where before that commit the same requests
> succeeded. Only the PTP_EXTTS_REQUEST ioctl still works.
> 
> Tests on a BeagleY-AI (J722S) show that the CPTS hardware timestamp push
> inputs timestamp just the rising edge. Encode this in
> .supported_extts_flags. A PTP_EXTTS_REQUEST2 for the rising edge then
> succeeds, and one for the falling edge or for both edges fails with
> -EOPNOTSUPP.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

