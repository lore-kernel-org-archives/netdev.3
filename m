Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223660;
	b=yladYY36LmSyBSho49/4xyBC1qWo/LzAZKrwyq5JUXl8uRc0fxxWiWRytG4uzLC0ymAZ
	 tqCZthSdH2sc+d/F/6NhHpQYu1scazJKRbm7T0/4PwwwCH7YV8L82FTpeCs/DBJ17BIAz
	 AFfgFuOfnLB9U/Czv1lAmZ2JWIZiSX1Ly9Nlit12wQ8cIvfXa4eYj38agdDKE7w43aELR
	 +i7HCTee5DipQnD7BN3Yw9DuPbBtxBXOFojuUvPt+Zi0i7VHKgDNabVxjGvi8Zq3PZMnP
	 LUULYCWiclveYIq2CmB+a51H5sgmk4eNHk7lWTcRtJzC/jCfJBezujTHZUvsSuXyN8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223660;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=umBzuMBmol8a4492mtiSqpBu+wYhWnyyfG/+WDRtoO0=;
	b=BRW1mS0HfWwkpdxGKGoST4GhLlv5YcPBAa7gWcFHXenbqcA/gcDT3rI5LOmef5z3Ndu3
	 cOHOxy/WmqaFf2U36v8dombVfrDw6PzZ0g8sDrLq6w2wQTnf1NSZqmL1uT9WZvqb9JbtZ
	 rovDLk0S/ZQOF2f+tfXbsCxusvJ7y2GZA/bvyVt7ulBcqEqQMfWpESFkfOL9w1S09hJNI
	 Jsru2siNfPudcEM5KANdVDEH4FCQuXnTWbnf6zAqifhXUW4KP8NE9mkC+IGxlB5b2fDOG
	 TRANemU/QkV7603YCsKQQH70yn/1Ybu94XPxEXAklSnplZAwjdICX8zB+M0JODQSAUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aMqJuCbR;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pYjhUbT1;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C95606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98C95606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aMqJuCbR;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pYjhUbT1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793223658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=umBzuMBmol8a4492mtiSqpBu+wYhWnyyfG/+WDRtoO0=;
	b=aMqJuCbRoNljs+gHplfsC4cknrWT0iE6is3gpa57KX8SX0m2tBOaSL6jxVcLyIySByyYkU
	uxxN9ifwAYt4CkWY4Vni31F8WzlOnjJP1YwO8v1V1QT7GY+o1s775EKkhqyDtPSj4RtRIu
	rFGkDKlhd5pPE9CTjDXMWu3KoF5fWx4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-GqpgTJ-6Og-gTO1FX2F2rQ-1; Wed, 28 Oct 2026 17:40:57 -0400
X-MC-Unique: GqpgTJ-6Og-gTO1FX2F2rQ-1
X-Mimecast-MFC-AGG-ID: GqpgTJ-6Og-gTO1FX2F2rQ_1793223656
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1e489f97fso14591895e9.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793223656; x=1793828456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=umBzuMBmol8a4492mtiSqpBu+wYhWnyyfG/+WDRtoO0=;
        b=pYjhUbT19dFwzDe35ZffbXjBS7jlCGTl+MGU5IhKkhmSpyru0/bCR9aQGuo1JqcLdf
         EhuwYL8qmdhrjsu7Sgg7D/MiMYeU8oBrQmqXhfrwCweFCoodhgulqPf5qJmPnDETIFQY
         1CDR7xqYhur2XCMP6ONFU9NpPz38bhMT92uPSS7KwsVBUob6e0SB1igI2OCgs3Z3S7sG
         t6wCDQT2VRgDAs5X3HzP5gOSi3CIUttboEEFCgB1NzRJZVIVR35wyNWIXeRT9Eh71L6r
         hvOrH6GHKRjKnhR2TcsEcp2RRmr9qOfmzRbIJghgkYvVbNL0Z/Z9spoSQATot7HTJ7d6
         f/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223656; x=1793828456;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=umBzuMBmol8a4492mtiSqpBu+wYhWnyyfG/+WDRtoO0=;
        b=b5xdNJVgfmPhexSVgd1qzri9H48GOAUnVxGhddVL+A+UJolWdRZAgFrW3P/mmUpmCF
         GCU53KPmGDGd8XXWZhmxJq/DZ+xSAtqruPOznw8Sm+7AADA5fx1Hb/r1Az38Jnw4xMfh
         fBWfTwIl3J2aeMArcIIPZ76yEEXqjig4Np5pvC7DqK8lHt+Gj8rSCwy21W9R1vnrtVOV
         tGes8altxwmNC2QQeGYmmXwHtxyjLTQaG1Rp1Ieq24dEnaz91hw65zd3xOWoM4lfhGea
         cZ74rezxgDGmEHpZ/3UlFPtErItJlX5pRdiwJMOlzej6/sKffempK6u/XyarMJVnKFMP
         NHcg==
X-Forwarded-Encrypted: i=1; AKwUvBwB48Fdwzl0RkdGJ6WVBcGggW3xefcaQofaqAgLHc9jYvSXK84lQetnlMy3YHUTzyZfQmGLlnU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTDZeFZqnvnNtoT+6Pba3o6W0g8euoQ0UawEKGdCm6PLuqoGZW
	tT2Q5BxwdmNtG84i89XFhjkJrKCNAODHdb1jDrV/qRGBoMcwEHQ9CRi3mGRwSEVWaZWQFUr07uu
	X+ht3qRwZgyEEkFZ1lMi/SIk6A6AqtF1htAed7RDMwGIavu9lxWdazWooXA==
X-Gm-Gg: AYBFou3kY+2+l1RcZltnMEMvoyOEz8qDM6Z7HPFIa1mAgZxf7Tu86aoWpJY3i5RVUN1
	JRgsJA01zE2zyFezyQVPDsh8tdvvDYh2a0nO0s/ifSg/C3XY2yfvm1WtpsvBuHfE3/JZSyNUuov
	IuRpiYWpS5mNgqq+pK+brrsA+ms4m3zJiA/BAt8zssGjALh0ZpcjXTYlfdKgHsInnDhPJwgxiXg
	lFcojX6LfGnjPA9iaVNTKOU88V2wI+QVu9PCOWTdWW87eqS6iu+Km5x/h9yQH0M5wNN8oQ0XRkR
	aROSnMZyHOvEXk5W483+tj1Iffjd3agrmntQMpIeLzQfJEhY1QhKEvUTBd+x7sedhyYsjDWTCVa
	i/riYqtR3K2QJUxNXri7xtlcmsHdY0FA3ja5wPQwy5Xt5Rw1L4yDOIg6tNbXap2O3HbYqgFYbt/
	gXaudxaFXzhQPuSnHhKz4QWupw
X-Received: by 2002:a05:600c:8715:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a967ab1ce3mr81842095e9.33.1793223656066;
        Wed, 28 Oct 2026 14:40:56 -0700 (PDT)
X-Received: by 2002:a05:600c:8715:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a967ab1ce3mr81841875e9.33.1793223655725;
        Wed, 28 Oct 2026 14:40:55 -0700 (PDT)
Received: from debian (2a01cb05923c9a00005ce1bcb3793264.ipv6.abo.wanadoo.fr. [2a01:cb05:923c:9a00:5c:e1bc:b379:3264])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f41895fsm16607085e9.5.2026.10.28.14.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:40:55 -0700 (PDT)
Date: Wed, 28 Oct 2026 22:40:52 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Neal Cardwell <ncardwell@google.com>
Cc: Neal Cardwell <ncardwell.sw@gmail.com>,
	Tom.D.Williams@morganstanley.com, davem@davemloft.net,
	edumazet@kernel.org, horms@kernel.org, kuba@kernel.org,
	kuniyu@google.com, netdev@vger.kernel.org, pabeni@redhat.com,
	ycheng@google.com
Subject: Re: [PATCH net] tcp: Fix dup-ack detection on non-SACK bidirectional
 data transfer.
Message-ID: <auJr5JXS-zGjylHD@debian>
References: <2ab9dc5f5b5e9f50d7a4aa02a6b6759fc86314c7.1792658454.git.gnault@redhat.com>
 <20261023161013.3079347-1-ncardwell.sw@gmail.com>
 <CADVnQymSV+Z9T_XSELAeoE46CNVAK2XveHb4s6ntLvSn8fw_Pg@mail.gmail.com>
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
In-Reply-To: <CADVnQymSV+Z9T_XSELAeoE46CNVAK2XveHb4s6ntLvSn8fw_Pg@mail.gmail.com>

On Fri, Oct 23, 2026 at 01:04:48PM -0400, Neal Cardwell wrote:
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 99baf14afdfd..1feb370804b1 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -107,7 +107,8 @@ int sysctl_tcp_max_orphans __read_mostly = NR_FILE;
> >  #define FLAG_TS_PROGRESS       0x40000 /* Positive timestamp delta */
> >
> >  #define FLAG_ACKED             (FLAG_DATA_ACKED|FLAG_SYN_ACKED)
> > -#define FLAG_NOT_DUP           (FLAG_DATA|FLAG_WIN_UPDATE|FLAG_ACKED)
> > +#define FLAG_NOT_DUP           (FLAG_DATA|FLAG_WIN_UPDATE|FLAG_ACKED|\
> > +                                FLAG_SND_UNA_ADVANCED)
> >  #define FLAG_CA_ALERT          (FLAG_DATA_SACKED|FLAG_ECE|FLAG_DSACKING_ACK)
> >  #define FLAG_FORWARD_PROGRESS  (FLAG_ACKED|FLAG_DATA_SACKED)
> >
> > @@ -3959,10 +3960,10 @@ static int tcp_ack_update_window(struct sock *sk, const struct sk_buff *skb, u32
> >                 nwin <<= tp->rx_opt.snd_wscale;
> >
> >         if (tcp_may_update_window(tp, ack, ack_seq, nwin)) {
> > -               flag |= FLAG_WIN_UPDATE;
> >                 tcp_update_wl(tp, ack_seq);
> >
> >                 if (tp->snd_wnd != nwin) {
> > +                       flag |= FLAG_WIN_UPDATE;
> >                         tp->snd_wnd = nwin;
> >
> >                         /* Note, it is the only place, where
> > @@ -4354,7 +4355,6 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
> >                  */
> >                 tcp_update_wl(tp, ack_seq);
> >                 tcp_snd_una_update(tp, ack);
> > -               flag |= FLAG_WIN_UPDATE;
> >
> >                 NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPHPACKS);
> >         } else {
> > --
> > 2.47.3
> 
> This patch passes all of our internal tests, as well as the new
> tools/testing/selftests/net/packetdrill/tcp_bidir_fast_retransmit_nosack.pkt
> test that Guillaume Nault posted in this thread.
> 
Thanks a lot for the tests. I wasn't sure if I should put your Tested-by tag
to my v2. Feel free to add it :).

