Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573910;
	b=ytXLgB5sqkzenp+JlF3HFkKqcK4kAmeOZRSOXpCd9GmIf+f2S5ODtueLegQMPKhRHkaA
	 YRncqC1nkAapyl8xHHit3Z8JA6CePGUR8u0Zp1I6+xRNLzIhGoIYZSpzX4UPqqmFTVX1W
	 EUOH8ctVFVzPqY3guhV8mND++tVC6G0SYfO7CeBlcF1pUMk+IeahQrGbfmmgAjj7yiBvE
	 9XAToS5Ma9cwHnI5cRbbCVL1rJ7rhilcyipof74TMhNlVioLi+Yh2BNmwe6KvOV/21yeN
	 yNtzDH9pjCQx6wy1Pew6XPHuBCQXtbjtcmGyo48XB8iQ53iGl9dDbJqLSPDQS4O3X+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573910;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=0RwBi1DXr0zgZdIiYyh+9mcJNVIQ1eSv6Kimn0za8QU=;
	b=jJ66ARhyPn2x8pnCqk3e51B5KFH1TsUgEpBQ2nOX/f13BsbXk+cgA3Wb/Gng7589o+sD
	 KTORD/iZzk9f4Y1aphdHR1gckzLppe71wFVwn4iYt5v3kAT86+LI5pbQEmPerJfkTcpgp
	 OfNfZ7GJ0ldeOpsyGGf7ibumzB/c3XLByjjxVCmMedB7QCQ97aeCYxibNV96PcFwqVcH+
	 dZECcVrHSaF60oKSqqqA3Ajp6tONU6V9YamJbTrd57rhZZVUFNguLusX6B3UaSq8ytweq
	 e1IOQe5x5ShoFp5eZEBpv1dx/U73rFYWqMCPX9bUOf3aDEzo6L+ZugtHlewhWcn7DpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=BhKte5E6;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0506B606A32D;
	Fri, 13 Nov 2026 12:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0506B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=BhKte5E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1794573900; bh=0RwBi1DXr0zgZdIiYyh+9mcJNVIQ1eSv6Kimn0za8QU=;
	h=From:Message-ID:From;
	b=BhKte5E6rAHzy2FaV2ZYYjDDk7VS4RSxmJ8xHeifRWlHSuf9/MmD7fUYfhffOJzUe
	 KImvnqORiDCVCkY34NbXEYy73I8sFny6pZ5RoHqOUlxittXhE20fXVFBFIWV5nnk6t
	 0BIfwxj8wpuzU5YLqktizqy4r3hsIXezWxrZJ+Bs=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 3BCD6C0954;
	Fri, 13 Nov 2026 13:45:00 +0100 (CET)
Date: Fri, 13 Nov 2026 13:44:59 +0100
From: Willy Tarreau <w@1wt.eu>
To: Johan Hovold <johan@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
        Randy Dunlap <rdunlap@infradead.org>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH 00/14] security-bugs doc updates
Message-ID: <avcGSy3QjjlA2W2l@1wt.eu>
References: <20261109080240.29444-1-w@1wt.eu>
 <avb9iICZ5dvD7yR1@hovoldconsulting.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avb9iICZ5dvD7yR1@hovoldconsulting.com>

On Fri, Nov 13, 2026 at 01:07:36PM +0100, Johan Hovold wrote:
> On Mon, Nov 09, 2026 at 09:02:26AM +0100, Willy Tarreau wrote:
> 
> > Here comes a new batch of updates for the security bugs doc,
> > essentially to make it more readable and to address some of its
> > apparent contradictions for those not reading it entirely. Some
> > additions were made to explain how to send a patch and a reproducer
> > separately, and to ask that first-time reporters send a single
> > report at once first.
> 
> These all look good to me too, so feel free to add:
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>
> 
> I'll respond to individual patches with a few comments on language that
> you may consider for a v2.

Sure, I'll consider them, they all look valid, many thanks Johan!
Willy
