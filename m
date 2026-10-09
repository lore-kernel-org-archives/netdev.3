Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DA04FC8F5
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791575126; cv=none; b=n3foaDqIdFxgSvdqHRUGAm2mD8nBq8G1qHhm2rt7I0agDsaN7zwusLsrzMtF7XYaIfVjCs0rhFvR2THghMiJz78zsF4PgTxMPFQjA5N9xDIFlyD/y3cnBj94QrpkU9FCPSvVgrsVTHAJMz4+f67KGNO1rHMUBvl2c0gT/vApa28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791575126; c=relaxed/simple;
	bh=EloxsBTAFGMBBEvrMxew3OZ84oY2809c07/0bEzcf38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOEP24hqZwV4oUNVy5vrBUQbE+XX6mO58/JX7IVJdwFzahFKV3ZnbOJhJS5RyAWl9pI3ICiFvFzSgQLf/aBkmSetRGIfCpVPwS7lGJr37ETv3fXpnZVrMdkKPyoL4+7Lk2WWXNZM1Q0rUI3NeweYIYyqIJ7gFjVd8i4tSxEPbCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=ejfygQK2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="ejfygQK2"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e61f017091so565235ad.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 12:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1791575115; x=1792179915; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zRktNQAINep5jabUt0Um43RJIzgR/yjHPucefqAmOec=;
        b=ejfygQK2nn5qCHhMJwV7MsO/8AtAu0S8FcCGpKndwEWBgMn1+77n4FVrFfrIM5i62V
         1CbLz05BBF7qrvOLFqzhPvEpY6GcvZA2tINAtdbzyeDy6JCUc+1Zoxqa3+LBGJx+jMQ8
         GY3zlV2EQnoHZNtE9EiE3UPLcvtMShKZSi3DoBo6dyjZHtIS+qXfnWmZohJzQpINjG3L
         hKABRUnVypZvLSzxHMvhFeCJW9FFfoGrFwDB0HEfquWzg5zMzvv18RRj36lO32JjDJ6C
         lu8WqyYIP4zLSM3tWb/Ggb9tnDV0i4GTqKHvrb24pHzpwZEseysJYOqT9yswKW+b39rj
         pSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791575115; x=1792179915;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zRktNQAINep5jabUt0Um43RJIzgR/yjHPucefqAmOec=;
        b=eFn3HfGbpeEiDdh5eFtsVjGYSzhWAMgE8X5nRx/62/huPILlRwsOmGpIjG7GoKjqr7
         XztbXRbGDiVLhH3S05GdsoXHpeG1FH2MMpK8klwE1BOjs7uIeoVDEF8+EgyiW/BiZuBw
         C/bAg5yCuoBmfmGGbJ2J3ZJrkVGeYVj0KjUd0bGWoMBr0e3HN1Tk3Lk2vEFPLhiARqaT
         ptYOs6dS3RieOcOaKmrfq9dOrtRDg31t8DuDo8k5q2cwRSewuI8UG27zVqs8n5F/DuYt
         7OEAmxkLou+SLdP+i23YlzA+BP4lKsfH18Gio0o/ug1PTfSQ8pNRHZtpe54rz6kAI44n
         KOnA==
X-Gm-Message-State: AFq9FYKvHHG/lw1Ti3c/Ke5ydnZlXm/0wepymGlafg9N2Ug+kS82P+rf
	qNJzc0lb4K9aN3queW+sB1sX8kH62MNMkhpL2x8djsSNUNZbwBXoxEXg/CA2FjMlwnQ=
X-Gm-Gg: AYBFou1gtCcjy3xcAV31/JFCE9rNDLl3RAL9Ntkx+suJCmF8KPPEc9hbNs7ZBbEJaov
	ew7g/h/K8J+/gnInlLY6V83R/4DfMeK3vopK1geUBFr/gZson7DsG+i0TJZozvAN/PZZhZ7nz/T
	Rsyr423iQQHqySWJQwCRmt47iDP1I43TxuFhmGo13FOiIx3b+TPtAIUv/oPInBdusgsUkPTxpyD
	HylfRsaO2LKMr7zwpYwBY01ItskvksuGpu1Y75sqqnMWO5ueCUMNSKqZEdHJMwV/39NSkOYb763
	10wJcSiDSxasT28Y0+LXkJiIAgtyc6UaN1GAvrQ41izBGywT+sltlGxQY5t2PS+TGteZDTkN5ly
	/uHwIA0RptmL4bG2dz5USOkckIKnwvm2GKyfdQ3dYZpbayUlTKVLXYq53+Vk0pHAgnPZb/F0RQR
	a7r3ZfjmacPt1HDMYxSYgTq8lf2dLzQelIfHWwxOEgHspDn8chZmm4cNBGQBp7sRByN7o6brJt3
	uNXS3AU/zM=
X-Received: by 2002:a17:90b:1e4a:b0:3a7:933a:3195 with SMTP id 98e67ed59e1d1-3ab3a236a1bmr2644773a91.7.1791575115460;
        Fri, 09 Oct 2026 12:45:15 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed0332sm5135080a91.3.2026.10.09.12.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 12:45:14 -0700 (PDT)
Date: Fri, 9 Oct 2026 12:45:14 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] bnxt_en: Pad short SW USO segments to
 BNXT_MIN_PKT_SIZE
Message-ID: <aslESokQPvYCWarH@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20261008191114.3736826-1-joe@dama.to>
 <20261008191114.3736826-3-joe@dama.to>
 <CACKFLikWkH6QaOG=EO_zu8cqCFRxGqtA2-+R-btp0TwUbJjVBg@mail.gmail.com>
 <asklVFvUJx8P/k1d@devvm20253.cco0.facebook.com>
 <CACKFLiksRwZm+Zy74G_u59yEpY5BK+xRv=r6f9Wpo6WgT_TwDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLiksRwZm+Zy74G_u59yEpY5BK+xRv=r6f9Wpo6WgT_TwDQ@mail.gmail.com>

On Fri, Oct 09, 2026 at 11:33:07AM -0700, Michael Chan wrote:
> On Fri, Oct 9, 2026 at 10:33 AM Joe Damato <joe@dama.to> wrote:
> >
> > On Thu, Oct 08, 2026 at 10:26:06PM -0700, Michael Chan wrote:
> > > On Thu, Oct 8, 2026 at 12:11 PM Joe Damato <joe@dama.to> wrote:
> > >
> > > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> > > > index ef04c9d08066..f87e02ef3033 100644
> > > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> > > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> > > > @@ -82,11 +82,14 @@ int bnxt_sw_udp_gso_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
> > > >         if (unlikely(num_segs <= 1))
> > > >                 goto drop;
> > > >
> > > > +       if (unlikely(bnxt_sw_gso_pad_len(hdr_len, mss)))
> > > > +               goto drop;
> > > > +
> > >
> > > This looks redundant since you already have the same check in
> > > bnxt_features_check().
> >
> > It's redundant for skbs that go through validate_xmit_skb(), but generic XDP
> > doesn't AFAIU. Not sure how else to handle this case, but open to suggestions.
> >
> 
> Did you mean generic XDP turning around incoming packets with XDP_TX
> actions and transmitting them through the software stack?  This path
> cannot generate USO packets, right?

Hm, I'm probably missing something, but the case I'm describing is generic XDP
bouncing received packets back out with XDP_TX.

I could be wrong (and if so I am happy to drop this if statement from the
code), but IIUC generic XDP runs from __netif_receive_skb_core() after
software GRO, so the packet it sees can be a GRO'd UDP packet with
SKB_GSO_UDP_L4 set (because maybe the socket had UDP_GRO set?).

The generic XDP path seems to keep all of the gso fields. Later generic
XDP TX calls netdev_start_xmit without validate_xmit_skb being called
and so gso_size could potentially be some tiny value.

LMK if that makes sense? I think that's what happens and if so, it is a weird
corner case that is probably pretty unlikely to happen so it felt like drop
might be the most appropriate thing to do.
