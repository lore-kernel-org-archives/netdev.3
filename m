Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C320424651
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208858; cv=none; b=j6F5dWLPDwo/VnRaeiz/8ceHrPV2ipGN8oW33VbDYVbx3xFQYv9aMfI2DNu+lqIwL13dxnn1q+vTO2dji5Bb72RFxa2cVgoLBM3U3ByKsMmunPxfEmuw9UEV+y0GB3pQFUDgYrjrGXW6vWDUa3tYTJNIt7K1aIpP8uaqWB6RY6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208858; c=relaxed/simple;
	bh=512q+FuN1hjr7tRKT5qTs7tS31ElK66Wl/lwjJg+hKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9eaBi3oOW6m74DCz87/b297q2OM/l2M5jH0T7oSXYNN39tQUS10wWyMdvvY3jwM0+bAYAIwG336Uhq4qrDKCBAcv+YxA8pD3y5SXEvIKiRuQ68YVsi778bFfZaAHtfZ6sJ0AFOAsIH/Qu3i2qALDNegMQlGAugmXmXJD3R3Lu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C31gzjPe; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C31gzjPe"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-489f3611e0cso4411689b6e.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784208853; x=1784813653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=paGXn2CXcdZsSsOEnSXii4F6dQRW7fZtzSuMwBvtGAs=;
        b=C31gzjPez+kNcFatrK5gw1xFV2Zc9zZwRS00DMnmH19feSru+BW5S/AnfYD1Aq/wA1
         Ltb0CYCXaVF/r7NGgo0Agq93OSvdHgXoSxRn8DFivoMEe8HVQ+YOjDmU5klMr9OxL1ti
         SQWp2iOQQzOyPrYpYabBkYW5MvJwp2n63wTzGmDfj8cex33vPyDevO8P0ohfBf5CV26w
         tGCvk2iVIOg+BId6UGtiJmN0Ka2ec67sLa8I/tL9Uhnfu9uH46SYhPtiQoy7NPS/2Jfu
         eQ1Lob/M0wFG1k3ocM125vkmKm7r/0++y1nyXmGsG0tzuy6rXoJEOqzxjPhZdIODjTOD
         OaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208853; x=1784813653;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=paGXn2CXcdZsSsOEnSXii4F6dQRW7fZtzSuMwBvtGAs=;
        b=esetBny3IHyPYRjxOKx14jCIVgvMIaFsIk2KoMf0g4roSjLFFeImjrRa73amZ5muZ+
         1XlqsO+C38s7G0VEQCbf01uFdQQ5qyHJd9+5912RjBjvsNNZJd0k92OU+UiRD5cmptkj
         m8Fz81IYc8412pLe+EqEti99M9sPY5R+tpmn/iE958pR1QNvrRfDY0JBdU/bXknaNC6m
         8ObVsTKj9/JV0XtlXcZtNUhnKMprJqzgpWIzFk6dhlV9aHE/wY8XQCL3bJH/5U+WDMtU
         ZZlxdmPl67cWh1AghVY+n8+zAL7q0SsKVJ9YpEVU96EhXVe/pB3E6PLw/xZZQsyvMUyx
         c7rA==
X-Forwarded-Encrypted: i=1; AHgh+RryjIqsIN5vadWqiVLuAd2EZKi54fvNW4OJaKsQ9HfiiGvCmJ6+b0S09DNQL+TWsJNVnxACVt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW4GrnO9tkUPG+VuHVxT9QXr07YbROYSyzI5W/8fok2YBAxYuC
	XGEpR/pBJIrnRwYgMnHo92boVH16JkiMbv45Bz1gTArD3o46rod08i6Z
X-Gm-Gg: AfdE7clurUrkr6ZFnBmu8goKMLWY7HdqBIxjOKEJsWX5Fk1xZMljFDrCM50QcD64WDL
	2lDVIpdF4P3KsgrbD/j9nfSnjdPUY6mEkdyKnyhInVHYTL1/MqZ33LcI6hoptIpb+OhiEZS7viB
	chOh62RfNT6YU7ohxEeIUJ1fM0MglcWRg4i/Xo8VvFUQcMQ1LasbbsE01j6sE7KWqwDNN+Gs0I3
	JQ3yrSKk8+dAmJZkpRZo2aZYJ8jDFt8xaleqzReOPAkBrxESH4J6DtWq3bPXx4BMso8552zpbhX
	kCGUMA2u2fmib+W3LS6ZLDJRkand7/Eel9rANHAM14DI3rw7MUaOt/OKkzHklvNMd9n/szoaraG
	HYHMxBwSS9JmoVDQzqDPbzTqW+mpHudWydfnjk3x04st+3uj+wtNrUPBEnMKOXJrIihPr4D1teO
	1/Sqrn
X-Received: by 2002:a05:6808:30a9:b0:497:e7e2:757a with SMTP id 5614622812f47-4a496072bdbmr5807209b6e.31.1784208852841;
        Thu, 16 Jul 2026 06:34:12 -0700 (PDT)
Received: from localhost ([74.80.182.90])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1adca6bedsm18285572b6e.8.2026.07.16.06.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:34:11 -0700 (PDT)
Date: Thu, 16 Jul 2026 16:34:05 +0300
From: Dan Carpenter <error27@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Yibo Dong <dong100@mucse.com>, LKML <linux-kernel@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: net: rnpgbe: Pass an expression directly in rnpgbe_rm_adapter()
Message-ID: <aljdzTZ_f5v6ckVg@stanley.mountain>
References: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
 <alScHkiC3EmGzOlI@stanley.mountain>
 <8110bb3f-70d9-4f0f-82f2-ffe1262b2962@web.de>
 <aleFN4Z2XT3NP3od@monoceros>
 <85ad473e-b2f5-4458-8973-a643f90eda5e@web.de>
 <alikx3W3NX7r9o99@stanley.mountain>
 <95abcefe-2211-4abb-9af2-7e8d7f4a9b76@web.de>
 <062f9181-e494-4576-bedb-36de488c11ca@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <062f9181-e494-4576-bedb-36de488c11ca@lunn.ch>

On Thu, Jul 16, 2026 at 03:24:22PM +0200, Andrew Lunn wrote:
> On Thu, Jul 16, 2026 at 11:48:43AM +0200, Markus Elfring wrote:
> > > In C writing if (!p) and if (p == NULL) are always equivalent but weirdly
> > > the NULL doesn't have to zero.  It's part of the C FAQ.
> > > https://c-faq.com/null/machexamp.html It's just a bit of fun trivia that
> > > doesn't really matter unless you have a time machine.  Even if you invented
> > > a time machine, the code here would still be fine because we have a NULL
> > > test before dereferencing the results of our pointer math.
> > Which expression evaluations would you interpret as pointer dereferences finally?
> > https://c-faq.com/sx1/
> 
> This is all interesting, but nobody has yet explain how this function
> can be called such that we have a NULL pointer.

mucse cannot be NULL.

We call pci_set_drvdata() during probe() and it is still valid when
we call the remove() function.

regards,
dan carpenter
