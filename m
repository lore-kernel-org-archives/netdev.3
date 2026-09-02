Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C90387588
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 05:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328323; cv=none; b=NYKYxWZujuy8bCjVG7Y2T0ij6LWBVlhU4Mx2N3XYRfdRSyF6uX9ctmAcwts+IYeRG0cRR1UcvQs5C0+z1FQ7TxLEhzhMco3IEus0wp8TYhwcib8SxiM8jzRYrf0rLn+e3NqXUcMJERJq3s1dZK60fRggpuFs0Jiv0XIEIbNvrdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328323; c=relaxed/simple;
	bh=7l4peYpsLG5Hj6hnKyFxnr5IKBQU+StYyEZw8wPhX4U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UqTxlgcBfaeur3jGDKbWryauVz7yubEIpoUT8T0eIoc9cy+8NpHBKj5zAjEROAg6WpwGTzn+OZ5m6O2Nm11HZ3vJUOZ73490SaJTh6u5Qj9Y0XCzM4dXk/O6a0RwVJAzjlQqRb7tz1VyVDWaZnrKZ+A787WKH4fXmFNeZSEmWy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VBPZFt9p; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VBPZFt9p"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a623987d32so1009678a12.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 22:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1788328320; x=1788933120; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=msJ962y2Ur2hfvHw80bKQSxrz0+5j73UTyN3FVxQpoY=;
        b=VBPZFt9plI+vZJT9WedmMpF4m7VJxSVssGFbzDGoxs8Y2EUWDDtS8sepW+wPejbnDr
         3otY4k9WUJOPhuDp5czYDmTgD8E8RNcmq59BNJv7Ofew9C6bQa4gtbhUqLFFv4sMBbR4
         osMW3GOXHAoOga9qcdjr6ghgZF+kh/QmAAhjYLoVrDGLX7/rHbvdoKwfn2vTemwWXotw
         RTkRCTvF8RzP/ODAbLdTeHLuYqNT6Bp9fY1LPjwc/pBSPr0C3ZnQD7NOt2jOkXLl4tlM
         9rU3Jg3lS/DIdfFXA0+UBFb2C88U7b0Yve2OIge78Qmaa8YtVivAVTUSqdfe8EvDHNte
         0nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788328320; x=1788933120;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=msJ962y2Ur2hfvHw80bKQSxrz0+5j73UTyN3FVxQpoY=;
        b=avnCmgejMPty1h8Sl4gl0IlwKbpSzqDMOWYc2rSqhTdSFd0nT0nJsf+526SyoTI6h0
         tDo/hQtrpk0N+8qPrvvvfNifBp5Wqk4NeES78DA3i3U1RPeHv4ZXVZuWi5MgCTzMKnRp
         mJ+efCNc30eiN5QTLI1wDUeyP6RUxBHaMenWBzielUL5ymQpSSSvE8dPLpYhS79NGj2K
         6nXMVbohdE2L3h+sKmlDiO5kDjz89+qVH3kZuiTVL+i9JeOFJBvB/wUWOk0/SbBgqb+E
         z2VLe5HrX4edmEzF1AIEQd2eFIEMDICzA17CQ2ZCBKDJN+j3XryB1vat8BQbKU6HNKc7
         gcaQ==
X-Gm-Message-State: AFuF++nHhSTU2cd7H43GmGVU0veS4pHZaWkiyrVxPFOrVNmixWMdJP3d
	SJyAptzFxqCRNxEnU327vVsbNdW+XMa9ic8+kH+SSjJ/kGXDt1AoLbksB2qVEhoty60=
X-Gm-Gg: AYBFou04kVnRAT1xsv5BF4ruZt5+cUfWowhU1z7HbYO8Aik6Uka0jMZZU9891nKaijZ
	5hbg87WdjEPIqRwJC8pQHnu3BdNiGY1f1Z6bIHwnl9d24tB2w2Nr1NSv/J3WUjiOZOksDvDeHQk
	+ZUUBq+LV6e/16pBYew/eO3XntBwu2IwhIForjyuDkcD+8HMvIHDfFA+SngCsOIp7OLsKQNSU/R
	G5S9KOCq1laYBo69iasgevymUfUjWNmDq4oxB07YmJbF4ayCkWCJxF5wpcO4iyH5Z/ducWgrZRc
	4oRC5aZeGxQjFVBbR/ZCx2Gxfe6aXvCSITkbdvfHJk1uHtOfvJXq/LnbcxvloPkxHzE0uY8RhnX
	T3lfOxJGxVv4hvq9EAhPidvb7Ll1zi6wt1ELHW5DNqV2m3tKULK/qsNG4ut1hFxtFNwtLai4ZWV
	MFOzyMi5hPPjqQZsysvhYG8UW0GQYWCilKH7iQYrc6V4+agvzEpH+nQLrhaAexUw==
X-Received: by 2002:a05:6402:3218:b0:6a1:2400:baea with SMTP id 4fb4d7f45d1cf-6a6829af69bmr1585123a12.10.1788328319907;
        Tue, 01 Sep 2026 22:51:59 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a67f895f34sm554152a12.6.2026.09.01.22.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 22:51:58 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  Florian Westphal <fw@strlen.de>,  Paolo Abeni
 <pabeni@redhat.com>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Simon Horman <horms@kernel.org>,  Jeremy
 Kerr <jk@codeconstruct.com.au>,  Matt Johnston
 <matt@codeconstruct.com.au>,  Steffen Klassert
 <steffen.klassert@secunet.com>,  Herbert Xu <herbert@gondor.apana.org.au>,
  kernel-team@cloudflare.com
Subject: Re: [PATCH net-next 1/2] net: Make skb_ext_put_sp() idempotent
In-Reply-To: <20260901171520.072acdd2@kernel.org> (Jakub Kicinski's message of
	"Tue, 1 Sep 2026 17:15:20 -0700")
References: <20260831-skb-ext-prep-work-v1-0-ecc2a8542fd9@cloudflare.com>
	<20260831-skb-ext-prep-work-v1-1-ecc2a8542fd9@cloudflare.com>
	<20260901171520.072acdd2@kernel.org>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Wed, 02 Sep 2026 07:51:57 +0200
Message-ID: <87ld9k2oaq.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 01, 2026 at 05:15 PM -07, Jakub Kicinski wrote:
> On Mon, 31 Aug 2026 08:27:38 +0200 Jakub Sitnicki wrote:
>> +	if (!sp->len)
>> +		return;
>
> Somewhat mixed feelings about explicitly checking what is the loop
> bound, anyway. But I guess you can argue we shouldn't write len?
> Probably not worth a respin either way

You read my mind. Then I thought maybe I'm trying to be smarter than the
compiler? But it seems that neither clang nor gcc eliminate the write:

https://godbolt.org/z/EcWTdEYqh

>
>>  	for (i = 0; i < sp->len; i++)
>>  		xfrm_state_put(sp->xvec[i]);
>> +	sp->len = 0;
