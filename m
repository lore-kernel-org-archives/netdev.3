Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D233448423D
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924705; cv=none; b=ErsCHLJl+XY9uX8M7lCYU4QNrDlxQl1fn0UrOwqa846rNQy/F/IIIf0ntJIK6p4QlqeBscsBaE5GKWnRSlZzD8Ztq1ilhWjX/6zZPfbZLaRf9/N3LyY3EZmUhuAnSY9B8cUemeJcVxxqkdsHunB+ZsMBxxJ3EKa2ZRGEUz/Qyf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924705; c=relaxed/simple;
	bh=PMk+BA1iV1gVZQS8hgs9PA8z+zdMSKtxYgSZ7oRIY/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hkhd3KSydynn5cJqzgDeq+jZ0WtjhQ/LP+JePqEzZleA3sF4OVe8LtESiFzDLztYAG5ZOf5Y8/Cgj8pA0S0ycNyMJ4q00Jtc8L7olvK6xfIYwMx1QNXK25fB9B6xT/1iSFLnnh2v8W1L5EAuqwIMvXxbFjJgWKgalscHfgw99vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fXvK3g1T; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I6ssLcr6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXvK3g1T";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6ssLcr6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791924702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7QcsbmPf6U5Ksxc1MQJeA/MDBAEnBcFQoG0wVwoAmHU=;
	b=fXvK3g1TZz3dMKtpW+ftIoR2Xm+ac6SD9w3CrGW067WfXWNr4FsknU47ug4prSiJ/vq9oM
	UB6KcVLv0SRRWHJ74nNXZaFpl6SyHXcTL7tnLe59R6fntTBeFwSbP2XtEX5zGHdn+sO4DR
	Md/uOgA2QDLnIIO+bIzmhCOi6ECAknY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-984oBstVNg6pXDEODD4LxQ-1; Tue, 13 Oct 2026 20:51:41 +0000
X-MC-Unique: 984oBstVNg6pXDEODD4LxQ-1
X-Mimecast-MFC-AGG-ID: 984oBstVNg6pXDEODD4LxQ_1791924700
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c4d7ba211so2072578f8f.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791924700; x=1792529500; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7QcsbmPf6U5Ksxc1MQJeA/MDBAEnBcFQoG0wVwoAmHU=;
        b=I6ssLcr68jcTyRY5y7i/fx3Pkqk+9jnqwMhh8yiy5JG0b3LYI9ng+L5FPjIObN2V3z
         z+5+nCR/1UjZRhTjI5B7/428vLpxO10i/GGD9v0nLqfdvpSSwAPklmJDDAXxDFBw5W22
         aVMcwSSGtT3EuenTRFyFnS1YED2gppqCoBX5HOwwNSIdB/zGOSLDCYQxp/qsV6KoMQSr
         uZ+/rytbps2ZpghnYS91xe42MrpBlJnelaC7xWmX7sE21TSf9bOCoc06ajLsIfUFBO2I
         lbI8GW/umOahfeuJD32UXP3wUhOv4upLIn7WtxnmzfroAZ75uJTlsXx5HYcR4DbZ/0wy
         iYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924700; x=1792529500;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7QcsbmPf6U5Ksxc1MQJeA/MDBAEnBcFQoG0wVwoAmHU=;
        b=nKxD9+uFLsKRYV2vPIN+1Uc+2IFeqQ95I+2th4sUM2QHaSu0Xwwz6E5gKsJrMbd9S+
         ofIUYppDdiZGg6W9y7/tzTseJIOgeqKpS/WJFjbUolgrxJ/rOSjVTQHx2EXt9knd/y+h
         IEyscyqAXOYajp8GfXCyOLPws3FG+WaSDlgn9iHLIJych8kKEl3G7rDhdqKYm3rjhVth
         ZkFeL4DTH0375julST25kobwxH7eIgn46DbyugWvgvVathDRfUeJNTzpb2eJDhpxRWvG
         /76md9UeDPNYMLQbURFaZ8vkkuTzTWxJHH9cp3FCzDIM73BYPp7QuKuSrUkqEJJKwvJH
         GAdw==
X-Forwarded-Encrypted: i=1; AKwUvBy+70FpS4XfLPdMhxCSR93h0g0JB7UrV0aMzY4M5415SKGQFQ0UAXJetMwQYmnfk9hEaNYrohg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXo6tYdYNPWl1wfWJQQK/nRNH5pjz+dYvgERnMo/Mib2T0qs5G
	jb2SuKGmSk2oqfhhKNp9rOJzVxt1Tez4sFHJItwUa8U7qG5jzYH6sqQwWI/av5OTI8Sroqc4Itf
	0HYn8vIL2KsW5Dm4Ja+kHmBOgZoouzW9pUQB5/fHfGio7A3HjUHIB655adA==
X-Gm-Gg: AYBFou3kNGVlrv5piy54DlC9ltD6auFadq55K+19GiwbR+6LR+X+EZ3vHuum51X2pSO
	CWRq0vtsWrwNocKin+koCf47OVTKgz3bhzeuRGRn2cOICLT/aaR4aeWvtiqG3ZnHqEK7dEqSgEb
	4mdN0PUwGKLnYOxlmtutL26sYSbaQ/R5RDOlebHjTbdZSqx8GCTyQUkP/k1RT8R/lmm4rWUzW9V
	vY4fiSWK+S+Ajr5raNw09wWvYeu5HSpvpt8h0mxCurVaVT/i+k8+4nTQ8zFEiFLB8AacJodaP1m
	HSTk5zg4esvMbcQrRb9wIGMyxcKdP8yA4hZSilHGG91GDiQIwSGaWA7lPVpo0SRnMBkr6w==
X-Received: by 2002:a05:600c:4f14:b0:4a0:89:6727 with SMTP id 5b1f17b1804b1-4a18e4adc5cmr281152655e9.16.1791924699984;
        Tue, 13 Oct 2026 13:51:39 -0700 (PDT)
X-Received: by 2002:a05:600c:4f14:b0:4a0:89:6727 with SMTP id 5b1f17b1804b1-4a18e4adc5cmr281152325e9.16.1791924699503;
        Tue, 13 Oct 2026 13:51:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a190344032sm399689525e9.15.2026.10.13.13.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:51:38 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:51:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH net-next 3/4] net: resolve uncommon partial checksums at
 ingress
Message-ID: <20261013165004-mutt-send-email-mst@kernel.org>
References: <cover.1791887415.git.mst@redhat.com>
 <e12c6a45aae251d1642af55d8d3121e554993a66.1791887415.git.mst@redhat.com>
 <20261013070549-mutt-send-email-mst@kernel.org>
 <CAF=yD-KdTn2rHyp_j8ORr9F5hpm=TzaPRan5+gvLiYBd9HP-sg@mail.gmail.com>
 <20261013143335-mutt-send-email-mst@kernel.org>
 <CAF=yD-Lz92nGVFab1Dq8M9VusDsKf-ioda8KrZoyh28x3Xtg4Q@mail.gmail.com>
 <20261013163706-mutt-send-email-mst@kernel.org>
 <CAF=yD-JKeej85t+sCc_5K0b122uw_LiKWwX1fRL2V-QLrGA8QA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF=yD-JKeej85t+sCc_5K0b122uw_LiKWwX1fRL2V-QLrGA8QA@mail.gmail.com>

On Tue, Oct 13, 2026 at 02:45:07PM -0600, Willem de Bruijn wrote:
> On Tue, Oct 13, 2026 at 2:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 13, 2026 at 02:32:26PM -0600, Willem de Bruijn wrote:
> > > > > > > +
> > > > > > > +     if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> > > > > > > +                                            inner_proto))
> > > > > > > +             return 0;
> > > > > > > +
> > > > > > > +     if (skb_is_gso(skb))
> > > > > > > +             return -EINVAL;
> > > > >
> > > > > This is a risk the commit message will have to call out.
> > > >
> > > > I tried with this:
> > > >
> > > >         > > > We can't easily "complete the checksum" for GSO we don't recognize - GSO
> > > >         > > > assumes knowledge of the protocol. We could segment ignoring the
> > > >         > > > checksum then do whatever csum_start and csum_offset say, but that
> > > >         > > > seems like an overkill for something that should happen.
> > > >
> > > > I guess I can add a more detailed explanation about what the risk is?
> > >
> > > Let's just explicitly mention the consequence: non-standard GSO
> > > packets that previous would be sent may now fail.
> > >
> > > >
> > > > > I don't see a simple way around it. We discussed segmenting here too,
> > > > > but that requires intrusive changes to all callers too.
> > > > > Alternatively,
> > > > >
> > > > > 1. call segmentation, but only to see it remove the SKB_GSO_DODGY and
> > > > > thus verify that the TSO/USO packet is valid. Still drop otherwise.
> > > > > This also does not add overhead, because it would be called later
> > > > > anyway.
> > > > >
> > > > > 2. a failsafe off-by-default sysctl + static_branch that skips the
> > > > > drop when set. Messy, but so is the situation we're dealing with.
> > > >
> > > > Tack this on top or do you feel it's needed straight away.
> > >
> > > Not urgent. Can even wait until a report appears. But worth taking a
> > > look sooner if either of us gets around to it.
> >
> > Maybe if people intend all this for stable, I'll feel safer with this in
> > there.
> >
> > Just to make sure, the branch would just short-circuit all checks, yes?
> 
> Ah option 2, the failsafe? At least any new failures (GSO) that could
> cause regression reports. Operating entirely as before this series
> sounds fine too.

Right. I feel 1 is just as likely to cause regressions. At least 2 gives
us exactly legacy behaviour back.

-- 
MST

