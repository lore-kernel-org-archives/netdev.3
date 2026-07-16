Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278641A79A
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208635; cv=none; b=ti/NpMe9OllVjzKEEOgUQcbyfJOQhBkUu0HQprk2dgHcdqO5+qEZfcC8Q3couhTMDykhZcIPH+9yltXnOfgwWcTEIOeaXVFglVc/YvD8lxO+DKJ0eLztIGCEt1ugCx7tZkM+sqQJLKOVieAZABioLqskglAOXAlhJlYAmWUNJ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208635; c=relaxed/simple;
	bh=WB6mu1i3NewQ+i2LFqeE0E/NcGweHadEcPFk8ntwrEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/gGbOPs2fN9ALykcO6m87NMGSWaiVBK0N5WL/Sg3i7W/1xznB0rRVES2T6o3YeZjN0qDcmwlzSFpKxMfI5Y40r8yTTDuK/k+hJEyjPoTTRmyMng5h7WAPw2MkOXDyUpmXbWr0iTbdT5pxGMizjIPnZ2Wjnb9uKz/MU1WT1+q6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oizErKJs; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oizErKJs"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7eb61bbeb25so1861017a34.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784208633; x=1784813433; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f7TYuXzoNqDH2nR/xpl074QpxuDI0hlYBZ5yt21l508=;
        b=oizErKJsj4adiBXTxWdWxGvJBWd7U6JVhwAKQtsC4fiHw3XSyc84Pv8fnIXjju3gW0
         LFY1b7NUjo4aAfUr9Gzge24YquM8EJYwge+0VG5H6mpolijVV+dgcc1qnlSekni33j76
         1/pkb0s7oPsHJFiVOp/wot+ewVF/OjWL0q8/C23tPa5qAKc1i2kecqkTP1ecJffpRnWn
         VwHhLSc3JuZ4D3ZuTQGHoMavbwELFF3450Gk8W5qskMA38qXTd6nVBpyRC3M6wQLavTC
         qv1wPWn93CK8lZmZMeyGy4KBOqWR6d6XTs5a78nUoK0chcgQy2yP58A3yUCfkp7r6HJw
         m/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208633; x=1784813433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f7TYuXzoNqDH2nR/xpl074QpxuDI0hlYBZ5yt21l508=;
        b=ox3/aI3yhr7bRTPZkY9Br2IpAkEqdWyKSBsgHv42A2teT4dCpJ7/zvt4T3qsM1dbK3
         XgzzRxMlvqOmoMnrfgN8TvmYyyMq/Lq4tK81qBcz9NJEZxFze4/EYr146aV7KwRVzfqV
         KPFShexc03z5F+SJS/AkJCakul+gYq9T8E5q+JsnsQeJLXNQFCYvZ11/Iozf1WeFiqeY
         e/DNpraewFIz2vTlXnKXHzo3GR1GEejxkwV/fAc9USlOF9No0URi4Rb9J7RkB+Pf3Rh/
         DoN1dZ5m+Wo0gajZdRTK5HeQ2inBjY//aF1Zjo/yhyJjfHJddBWMKrAStY+sOfXf4vdJ
         0Yog==
X-Gm-Message-State: AOJu0YyUoLEzDL7Kt+qbHsr12194vsl+z5hz+CRD3At+QMQxEydv1PRa
	pKCRtmzm0we8DRDDl8wi4dlVmB/Vo6yh5sfc4lcUDBha4Av3mwmxbvDA
X-Gm-Gg: AfdE7ckRmwafnqP+GHtp9+u8FteRTprZge4ND8pyUGt/v4OAaZUORU7AaPRs32TPKSX
	qCPycSpjrLeIrSKdIese16VsZ2yMd5wDno91UMDiITULifHRffoz1dSlpzuD/gNcy5caNMrvUg2
	qDCgFeqWAs0VzRoEUddSfpBNYRx42orQV2c7e1Ae1w6s+s9PXzB0Q3L/O0dHmuKflpaBJnbzHx8
	IHN3s9Hv1QioYGH48YprETlbzhss3MfIAQ1s4ycdKeHjgIrR3BGl6AGsVP1/l/pOCWXBnFxSCDc
	Rt6pR+RCiT+kahVJ/7AX5tpivS/0OyPB4RThmQDEu2gbWJCd8Fm7O6F+7RW+IJlYvJxiu/musyD
	svxa+CUxVL3F/rg/M2gnJK6DlPOhlyfWoWAQ7/8tu3UR0vXN6MWcxK/uZSiSn9JV3Zmr7srYJi9
	86JpxT
X-Received: by 2002:a05:6820:1508:b0:6a2:e7df:c4ea with SMTP id 006d021491bc7-6a39a85a39cmr12923260eaf.65.1784208633146;
        Thu, 16 Jul 2026 06:30:33 -0700 (PDT)
Received: from localhost ([74.80.182.90])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a36a83ecc4sm16678950eaf.11.2026.07.16.06.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:30:32 -0700 (PDT)
Date: Thu, 16 Jul 2026 16:30:25 +0300
From: Dan Carpenter <error27@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Yibo Dong <dong100@mucse.com>, LKML <linux-kernel@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: net: rnpgbe: Pass an expression directly in rnpgbe_rm_adapter()
Message-ID: <aljc8RRt8OuYz90H@stanley.mountain>
References: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
 <alScHkiC3EmGzOlI@stanley.mountain>
 <8110bb3f-70d9-4f0f-82f2-ffe1262b2962@web.de>
 <aliA1EIIrX82jGR-@stanley.mountain>
 <320cb00c-28f8-4871-9ec5-d9b86cca8bc9@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <320cb00c-28f8-4871-9ec5-d9b86cca8bc9@web.de>

On Thu, Jul 16, 2026 at 10:20:42AM +0200, Markus Elfring wrote:
> >>>> The address of a data structure member was determined before
> >>>> a corresponding null pointer check in the implementation of
> >>>> the function “rnpgbe_rm_adapter”.
> >>>>
> >>>> Thus avoid the risk for undefined behaviour by omitting the variable “hw”.
> >>>> Pass the required address directly to a function call.
> >>>>
> >>>> This issue was detected by using the Coccinelle software.
> >>>>
> >>>> Fixes: 2ee95ec17e97c58b65e978a08b75fa8cb6424e4e ("net: rnpgbe: Add register_netdev")
> >>>
> >>> There is no NULL dereference here.  It's just pointer math.
> >>> No need for a Fixes tag.
> >>
> >> How does your view fit to information in an article like “Fun with NULL pointers, part 1”
> >> (by Jonathan Corbet from 2009-07-20)?>> https://lwn.net/Articles/342330/
> >>
> > 
> > Of course you can't have NULL pointer dereferences but this is not a
> > dereference, it's just pointer math.
> Does your understanding of programming language details differ from the view
> by Jonathan Corbet?

Jonathan Corbet's article talks about dereferences.

	p = tun->sk;
            ^^^^^^^
This is a dereference.

	p = &tun->sk;
            ^
This is pointer math.  It's not a dereference.

regards,
dan carpenter


