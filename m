Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D901F94F
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 23:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781393629; cv=none; b=oBVh74W5mYOb0PwUCpvIktpD6RDkQcUpn5mjr0YV1l7t/lyD5euwx4tTwkpZcMhPxp13AODeSJ3sK/SClhk8/Gb691bbbxWYyuV/GBLFQb8X1STvb0oaT1RuD+3ob/PNb0oh/ixTPAQ5kyOY4oWgqNrWOgN9o/317lEfGveazgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781393629; c=relaxed/simple;
	bh=tR9J1jy00cHm0oI1rJi/MESnBSfbkhEnjuSchyCKcMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hV+hOUHawPmy1N96XsAdXQmxJVrPxNFJfBgZ4n7NHW8CDrosjhzgPcRSGEz+DtVIAGr6bsH+3cu7yp93px3BiN5K6AwJH6apRjgq3T2FB0YmM4vOsfnb0H1Vw4kYZu1vUjTxmZKAIqEJ7Ywex9/+E36tmhH07eoTLZaRx1aSuus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=LWwhsfdj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="LWwhsfdj"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf30d530bdso21975785ad.3
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 16:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781393627; x=1781998427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I4uOuZF0y7DRPMLnYjlwnir5lzzhkV55mcprQDuWW/M=;
        b=LWwhsfdjk0776Uhp0WZo4LIYDkLSqr0vsQ+VUduxTuLBAMcxjsFveMufTnfYWYZXtL
         66kQX9KMANrf8rbRElasKd0VUOXRYclwIotCMvKzNH9wuHmrJoERfgKypCkIFInhrzXS
         h+reivvbl5E7rUlBGxciRXT1uhSEjCM/6X/bWScXE4++1fCNK+NMiZ/5JeiYnno18qJo
         W7nbNnkcLJBGp45loiYMHK4mnRw3zxkt6bnAV3ZuR7MS2Kf8lLP/emsQJowEvtq4JVmO
         MPSnI9/0WVMYl9hDd5Fkk93Ot2NGY9wgCrUV2krnaqpK2jALIsnaU/4r5vXDVmSOyr15
         QIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781393627; x=1781998427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4uOuZF0y7DRPMLnYjlwnir5lzzhkV55mcprQDuWW/M=;
        b=WcrwqJusmL3vcQkhQrl7D6YOhE8GD/w8nmneKzvHG6c6XqkmmMz4LzpxFrF2iYIxs5
         5JHN0cxDtknXSlXgEbE7hCFfhFCVVof1obeahAHweTDIeE7X5ZjWZpYabvcyvjgGxgwG
         2sKZQ3hu+kudAY8ezMCbhhnQ8bh3ceaPW9tAiy3Ws8SgNuamEKcZz/EUflNz/Pf2XRvX
         biUqi/ZMvCseTBvWZG5FhzeZTgeg/MB+YF9Yd8mbf/FeSuzv4+mK06Vk7AF8WgPMXjLs
         woAcLkTLXX2gZOB+kkzDS1+oV8NnURCTDjkdiCnJt7AwWTdT5j78BGhMBDIaUjDC4lj2
         7vEg==
X-Gm-Message-State: AOJu0YzXO3KpU74effoFhvJuWbt16Gf6zFAZ08O6p741JuB0ZMBtfR51
	vg4S+YB1YUnT2s+xEtFzV3dTkIojttjMOYXJ1sVKPPR1lC7XYeOnEjEXqNAy4PF9ZQ==
X-Gm-Gg: Acq92OEwibPfHgORur/Qz3tFltRaN4N93sNKMbCu1yS4vTiGCNHpfJfgFHI+WkzgP+5
	eaDBfkHxz4sf/Epr/fFhdDc0sIkjmtgWpIFzRhnvw1KvQ7b1gQ8oUQii+0zp3gF4UMHsjOSxSM6
	ZMAC/KuW0dMhWb5I6RjVzyrm7HBgNzv0caklkLRNQC0Qxm8J/S1zcZrKefgI78MHfmfz7/mumDu
	Sh98G6lwXDPADSBZp4iNguO3dtm4y3F6ikY+RcPBFnfDrJ2ztrEiLmUCMC5S6Nhc5gjgiY28SjE
	IH0GV2StgU4zfSj090nGhLF3GR3x3O2x0LDJ34Bi099H5r40iM9TZNN7A+SvMxuCSWZYkUg3Jvk
	h1qNJjiBvTNKToFFqp3PtoRTWyG3Nn3US8DwRL+rurkG899q3EfKnhyUuITmQ62vmdwk4JGKfnl
	uwHDFZJUftUF0c18Cb
X-Received: by 2002:a17:902:e790:b0:2c0:b4f5:41ea with SMTP id d9443c01a7336-2c66424305emr54477525ad.17.1781393627486;
        Sat, 13 Jun 2026 16:33:47 -0700 (PDT)
Received: from p1 ([2607:fb91:15ae:5caa:65ae:b763:3de1:910f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c43307a259sm59630975ad.68.2026.06.13.16.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 16:33:46 -0700 (PDT)
Date: Sat, 13 Jun 2026 16:33:44 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, yotam.gi@gmail.com, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, bestswngs@gmail.com
Subject: Re: [PATCH net] psample: zero the netlink attribute padding in
 PSAMPLE_ATTR_DATA
Message-ID: <ohbtwmotp5mvghzjkwpjecz4rglal3ayh5bylw72qkv6fjscii@3ks3kavmycel>
References: <20260607031640.2743713-1-xmei5@asu.edu>
 <20260609183018.1764046d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609183018.1764046d@kernel.org>

On Tue, Jun 09, 2026 at 06:30:18PM -0700, Jakub Kicinski wrote:
> On Sat,  6 Jun 2026 20:16:40 -0700 Xiang Mei wrote:
> > psample_sample_packet() open-codes the PSAMPLE_ATTR_DATA attribute.
> > It reserves nla_total_size(data_len) bytes via skb_put() but only writes
> > NLA_HDRLEN + data_len of them, so when data_len is not a multiple of 4 the
> > up to 3 trailing alignment-padding bytes are left uninitialised.  The skb
> > head comes from kmalloc_reserve(), which does not zero memory, so those
> > bytes hold stale slab contents that are then broadcast to all listeners on
> > the PSAMPLE_NL_MCGRP_SAMPLE multicast group, leaking kernel heap memory to
> > userspace.
> > 
> > Zero the trailing padding after the payload copy.
> > 
> > Fixes: 6ae0a6286171 ("net: Introduce psample, a new genetlink channel for packet sampling")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >  net/psample/psample.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/net/psample/psample.c b/net/psample/psample.c
> > index 7763662036fb..26220dca0f12 100644
> > --- a/net/psample/psample.c
> > +++ b/net/psample/psample.c
> > @@ -485,6 +485,9 @@ void psample_sample_packet(struct psample_group *group,
> >  
> >  		if (skb_copy_bits(skb, 0, nla_data(nla), data_len))
> >  			goto error;
> > +
> > +		memset((unsigned char *)nla + nla->nla_len, 0,
> > +		       nla_padlen(data_len));
> >  	}
> >  
> >  #ifdef CONFIG_INET
> 
> Could you see if this diff works? I think it's slightly cleaner:
> 
> 
>  diff --git a/net/psample/psample.c b/net/psample/psample.c
> index 7763662036fb..c112e1f0ccac 100644
> --- a/net/psample/psample.c
> +++ b/net/psample/psample.c
> @@ -476,15 +476,17 @@ void psample_sample_packet(struct psample_group *group,
>                 goto error;
>  
>         if (data_len) {
> -               int nla_len = nla_total_size(data_len);
> +               int nla_len = nla_attr_size(data_len);
>                 struct nlattr *nla;
>  
>                 nla = skb_put(nl_skb, nla_len);
>                 nla->nla_type = PSAMPLE_ATTR_DATA;
> -               nla->nla_len = nla_attr_size(data_len);
> +               nla->nla_len = nla_len;
>  
>                 if (skb_copy_bits(skb, 0, nla_data(nla), data_len))
>                         goto error;
> +
> +               skb_put_zero(nl_skb, nla_padlen(data_len));
That looks better. I just found that nla_reserve can memset for us:

diff --git a/net/psample/psample.c b/net/psample/psample.c
index 7763662036fb..c112e1f0ccac 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -476,12 +476,11 @@ void psample_sample_packet(struct psample_group *group,
 		goto error;

 	if (data_len) {
-		int nla_len = nla_total_size(data_len);
 		struct nlattr *nla;

-		nla = skb_put(nl_skb, nla_len);
-		nla->nla_type = PSAMPLE_ATTR_DATA;
-		nla->nla_len = nla_attr_size(data_len);
+		nla = nla_reserve(nl_skb, PSAMPLE_ATTR_DATA, data_len);
+		if (!nla)
+			goto error;

 		if (skb_copy_bits(skb, 0, nla_data(nla), data_len))
 			goto error;

Let me know if the new patch makes sense.

Xiang
>         }
> 
>  #ifdef CONFIG_INET
