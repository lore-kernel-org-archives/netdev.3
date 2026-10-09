Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A5E4F93A9
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577399; cv=none; b=qZ+0Hc0bEFH0jXh1f+ZwTSquy0BdJfgXbO/8LgZeQgaGHe3ouPWKWm8mGTHx38GyNwSz5swSDbt35dmV29JROdhXjtkcXDtmHx65JA0wNDY/Wup1XuSLcTar7oJRYsz1uHFPRAAK9By3GynoHUzG/LjCL/T8mKd7pmtbf9ewV+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577399; c=relaxed/simple;
	bh=9N9zFjDUxZrk4uykJ3LeSVBg8jAHHAq3PWq8u7a4uBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fI+st8vHp7zw/j7ybiml7t5tcp9b09Q9v0C+5TFw7cpm33vv0UmvvYCTC8wrMCbHqI4E89fshSOZV+8RhWFGKYI9KeFXJ4jhNsz6vTOvLh2K5G2ui0/+sVH3h2UEpBrEz3UJVYbe4eQ6chQ78FH6hjhvaRPELApb9Tl93Q+ycCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=GBb69ut/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="GBb69ut/"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3a49623b865so26737a91.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 13:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1791577397; x=1792182197; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P5TCWATT4rCU7DEWZvcvh8GLxiFiVd9cWWdUAWSZxmQ=;
        b=GBb69ut/NFNFdxi9PBR4vCMAqX/aZE4LMV0UYKD/fMEr8ILDkItB+SoA6KNungBoIG
         rgLQmyn09w/Jd0a3xlNhY2mT9uF156bXEkO/b1Xrt9IYKjo8i3CiFLoHkbCeNrSsI2tS
         fCHafnQD3dKxUv2NvIGlMrV+73DqI1PggKYb+vKpmukhc+NhRyWpMxWA4P+61VwSPcKQ
         DnryurXfvJ+I+Fg07mqwMLGJ45KTu1kKJtYQeNqzjh/IpBLkJy7pMJg7J2b65a2eCues
         IcpZK72nmePd/mi0st7qUQeaK0dxn4gPYpWCpgzX4xa6nu3DxxYDWCtWLMgiqMw32YsB
         ioeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791577397; x=1792182197;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P5TCWATT4rCU7DEWZvcvh8GLxiFiVd9cWWdUAWSZxmQ=;
        b=y+86TfJWVeoov0o0efqlqljmyn8rT6qgKD7X/UL9WwgQo9Yh2EKg7u/s+DXv/d/j+v
         LkL1lezCei/3mCL8I5/NU8B1DE5X48IO7srYSbCoGG1vM3mdiKaLiWKE8lv7n+lLwN/B
         8YyphPzLpQYjGfce0wkCMhUaUkBXB4dZHBlH7ZE7xaHyvwLJOThx7UYi2Uk8Kl1gKnOQ
         xjVFMCF34+xLNz3ylwyyCRxmyaPZLKRHMes1D6RHkeXgECbi6ltcWtg3ED3oEgJURVr3
         xUx9QisR2BO484pjMWcxAnFPkM0haH35CE2JrBbTKV5LnUJjwmegs3ono5wtV2YIJkxi
         z+UA==
X-Gm-Message-State: AFq9FYLd8JUQtUug8FbpeGRLtM+qisbP/P+kb87dg/AVz1BYNMYkvLxP
	K99OM5pbVVFp4bWNVdLoo5TtUE0t5yl0vhyNCWOZJvhPt+rRQdkSuQeR4vQxc8+lARE=
X-Gm-Gg: AYBFou0LHzaMQKhQY+jceq3CcwXHEC8KPli6tG94QDuJWHm/b4eIRFMRDRwZm3mcmjV
	FNIadkHZDLon3FUwvXWPkuYSWEAEW0b7cxYS19MjT948GfDGgHqTGrmhCG8qdsNDycoU49BPmwi
	qFKEB996dtbKnuXicu6oC3pjD6KHM43tPcNwbCkrMwY/u0iBTvVge1x7GmwSvTAOu0bdFKNtThQ
	FTdWJqKQEr6SFrOtksII/399CyPFcMCWD+Zl+bQz5EdoQZ/fM64QgK3bdtxn4UG22iJA1KH8Xbq
	pPnUbSVKstBXQhzsAPGwFPY555nSJ7/3fFB5OB9a8zJoP29U2VtysIUhoDnI0ThXJ24volAB4pk
	9E7uRdN5gKg8O4yMhZSKFf4GLpfJvN+CLmYqBIspeSI9/iGqwi5cpl2XG/hgtUmO3xEiOa0j0YB
	KfZDslLjxslnLUsLuUhha9dtdGFqsniK/Z4RheZSDmfQoQcoLPon58iE4UnrLohP7ImYh59uaYJ
	8oi8p/8bjOqMD+oEWt13g==
X-Received: by 2002:a17:90b:4b:b0:3ab:2c2b:1030 with SMTP id 98e67ed59e1d1-3ab3a747cfcmr2434340a91.22.1791577396727;
        Fri, 09 Oct 2026 13:23:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36f46dfesm5009374a91.8.2026.10.09.13.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 13:23:16 -0700 (PDT)
Date: Fri, 9 Oct 2026 13:23:15 -0700
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
Message-ID: <aslNM7TjcZ/17/MS@devvm20253.cco0.facebook.com>
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
 <aslESokQPvYCWarH@devvm20253.cco0.facebook.com>
 <CACKFLi=0uuY36A+pnHVDqRYACfC5WVXx357cgD5BDMiTfW9sRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLi=0uuY36A+pnHVDqRYACfC5WVXx357cgD5BDMiTfW9sRA@mail.gmail.com>

On Fri, Oct 09, 2026 at 01:07:59PM -0700, Michael Chan wrote:
> On Fri, Oct 9, 2026 at 12:45 PM Joe Damato <joe@dama.to> wrote:
> >
> > On Fri, Oct 09, 2026 at 11:33:07AM -0700, Michael Chan wrote:
> > > Did you mean generic XDP turning around incoming packets with XDP_TX
> > > actions and transmitting them through the software stack?  This path
> > > cannot generate USO packets, right?
> >
> > Hm, I'm probably missing something, but the case I'm describing is generic XDP
> > bouncing received packets back out with XDP_TX.
> >
> > I could be wrong (and if so I am happy to drop this if statement from the
> > code), but IIUC generic XDP runs from __netif_receive_skb_core() after
> > software GRO, so the packet it sees can be a GRO'd UDP packet with
> > SKB_GSO_UDP_L4 set (because maybe the socket had UDP_GRO set?).
> >
> > The generic XDP path seems to keep all of the gso fields. Later generic
> > XDP TX calls netdev_start_xmit without validate_xmit_skb being called
> > and so gso_size could potentially be some tiny value.
> 
> I don't know.  You may be right, but this is a highly unusual code
> path.  Other features checked in bnxt_features_check() do not get
> rechecked again.
> 
> If you decide to keep the check, please add a comment.  Thanks.

OK, I'll submit a v2 with the following comment. Let me know if this OK
with you before I respin:

  /* bnxt_features_check() makes the stack segment these, but paths
   * that skip validate_xmit_skb() (e.g. generic XDP_TX of a GRO'd
   * skb) can still get here. Padding every segment would need more
   * BDs than bds_needed reserves below, so drop instead.
   */
  if (unlikely(bnxt_sw_gso_pad_len(hdr_len, mss)))
          goto drop;

Also, since I haven't seen this issue in production myself and according
to my math it is not possible to hit this with QUIC on ipv4, Jakub asked
me to submit this to net-next instead of net.
