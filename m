Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561D71B808
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 22:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361616; cv=none; b=aj1u5PKut2EQkVCNp9nNz+b+j7bKoYL6uVXTittthZI91k9+3Ul+k4Q5ZLvG2OhtEVZZLdDKOFbHg8cziHt0lM9BQkDSJ0vqp3s0WPbOFZ1gtlWXgXI+ac7jRwa2NzHbV2BgRrV/BIBn0VsHmv2eKBPs9lk3HylbSY9vdcbF+6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361616; c=relaxed/simple;
	bh=JBnh6g8/khXfo/xjv3nRYstO4SCCAW5vzbTZ2OoUIp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctd8fjxsj1v2Zrvpi58FV/v1mq2/2b1gQLqBvffTBVRaMTY3yFCxlsgfsy+dZTvVpkx6BhnIW8bTBrZg2bNCKCj4SginVErCnHNoX7b7VP3Zg1CiCxscFeOM72TrH/hW8vAdS8ZSPWBxl8YY3/IIxcXAgDFYintSaHHMsc7E7FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsLpHUv6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UK7LpVC5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsLpHUv6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UK7LpVC5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792361614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2nWTmEzSlPTSS6/bv2DXBvJ1IMAaQG+TiNBhHr6z6k=;
	b=gsLpHUv6XRn7KQb2DbuEhMEV3nhOb/rQk+DoA4pjYS0Iw5sVuo16T4nEk0HZIBNtIUaYbj
	E2J47yTC4/R+IlflrVA9rrGeO86tUOsyF8trKct0jn7dd8sVH2V+sJv8aMmH5uF+Zo5BFz
	Qj4jLTJyXwF53IqbiQwPVLcFXgRg6Co=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-yGRkNPnwMrWJ0nwF97hFlA-1; Sun, 18 Oct 2026 22:13:33 +0000
X-MC-Unique: yGRkNPnwMrWJ0nwF97hFlA-1
X-Mimecast-MFC-AGG-ID: yGRkNPnwMrWJ0nwF97hFlA_1792361612
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1dc95bd3bso7187475e9.2
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 15:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792361612; x=1792966412; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D2nWTmEzSlPTSS6/bv2DXBvJ1IMAaQG+TiNBhHr6z6k=;
        b=UK7LpVC5ynnkkWWJnerT/vvL6GRVLxZzYw9dSFiA6TOTwmacWDvb0JnUgfqZmrU8Z8
         Cqva6B7MOWfLsFoBx3RczGjP/5sFmiMGMFft6qiJfRVi7n96+3FQG1fuKZbSlUF1/6jA
         ye8xT6ayeZhCESJZKPq5LdloJ1Vtfgq+VAFSA0xzdNIS7bj/S1kGfxqkdf9weUrwo+ue
         jFELfkq/ZEz7Rgmnvhxk+hbZM61kD+qbxIwGVTHPUuJ0IdMNZ/E0DHAsrZN+54OrCYeM
         EYguIh+BrZ6pLnjzr8zB4URPOVw86L0c8Tc43OZmU3a18hHx9dXmOpn1VI1GOP+Z4UHF
         RKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361612; x=1792966412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D2nWTmEzSlPTSS6/bv2DXBvJ1IMAaQG+TiNBhHr6z6k=;
        b=gLwA2GRw4TYDrnG0E4hSLqIZQpOmufgWy4y/keHsPQnlbxM9k2r6a1JNSzunwJCedo
         hOR5jD8iZoL/Na2Oj16TU/rgsKSCUNmmkBKvGnYVDAGMRCYHzeNSDsR9/Qv7KIfmK2/2
         8CnHq5s0XVkRRjeGGxRMjuW4oQqmGLizierMfA/oapTSJpr71cvZVqd2Qy7jnWppzS+o
         YUv/dn9I31GCycYAckb4Anf/G2VgEdNqWgsM76I5vTAw6AR0Si8KDoRuVU+m/AMleGzz
         /jyArRCKTxlr3/GrrXDkeNcTBqehcvhIOQ3ElnlxDz2K8rZ4FGGFAgSXgQOJ0xnu9HKA
         Rl4w==
X-Forwarded-Encrypted: i=1; AKwUvBzp6J1elk5lf0xvpwy6cMRosjOhILq8+LmZwhVaVqyfAkT9l66FsOKPeHe5eh4oRKaOHatxU5o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJr6osHX0anqeE4HOjy3lpz7l8NN9kwWSpb9O6wtynZv5hbLx1i
	oyJf0Uc/KU1z1GmINAQiaiS7lu4hKzQJGR3yAR59iCwiGgi/WCZnhw1KeqoldoX4wE7B42Xypmj
	VXjpSInxyCHGot+AMO1+P8YUB3IOs8GhqBM//xdL4mRkTpKjuCyz8j2MUew==
X-Gm-Gg: AYBFou2hQGnxbqjea4jFFfgthLJcWjbyTd67y0pdWnn5XE6CgeSpGDbgYLZDJA+UEx9
	E8ApJAuL6JEAfeMIwqJ3jgg8YgFTDxHDNK80+1V1T3LMedcTvEGuXBXmQGVJ9BVafmntnrtEPEa
	IpNO52/BdKPkOeBN60D4NuxBNdR3J5cxrd6nkD/SiX0C6UuYxUK64+p4NZ2jTjQ5/CAw3vAtrkK
	F8mCq5+cDg9K7U+OFOJGi8ipu6+neWgZYUTWhNcPktRD/fx0aIt/UcFwt2LXOxYcbrI07ztFpjl
	TuAT5W2A13wS+QUR6a0kMGioiw9IWQmitrEaAaEP/geS5p4db0Tw4+yMC3cPp9WRFyqeYA==
X-Received: by 2002:a05:600c:548d:b0:4a1:e250:b191 with SMTP id 5b1f17b1804b1-4a1e250b1c7mr52451225e9.17.1792361611698;
        Sun, 18 Oct 2026 15:13:31 -0700 (PDT)
X-Received: by 2002:a05:600c:548d:b0:4a1:e250:b191 with SMTP id 5b1f17b1804b1-4a1e250b1c7mr52450995e9.17.1792361611317;
        Sun, 18 Oct 2026 15:13:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a72sm20914904f8f.4.2026.10.18.15.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:13:29 -0700 (PDT)
Date: Sun, 18 Oct 2026 18:13:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Haoran Wang <haoranwangsec@gmail.com>, jasowangio@gmail.com,
	KVM list <kvm@vger.kernel.org>, virtualization@lists.linux.dev,
	Netdev <netdev@vger.kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Security Officers <security@kernel.org>
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261018181202-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <20261018204838.4080b238@pumpkin>
 <20261018175347-mutt-send-email-mst@kernel.org>
 <CAHk-=wjneFJ7XmZ6ux-LsHq4apDgANcKfERztmAG9sGVY_TxAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjneFJ7XmZ6ux-LsHq4apDgANcKfERztmAG9sGVY_TxAg@mail.gmail.com>

On Sun, Oct 18, 2026 at 12:06:36PM -1000, Linus Torvalds wrote:
> >     > > +
> >     > > +           if (!access_ok(uaddr, sizeof(*p)))
> >     > > +                   return -EFAULT;
> >     > > +           ret = __get_user(tmp, uaddr);
> >     >
> >     > Can't that be a normal get_user() call?
> >     >
> >     > David
> 
> 
> >     Ugh, actually no. This is called under local_bh_disable.
> > 
> >     get_user would splat on might_sleep.


> I[ sorry for html - driving around ]
> 
> That's a separate bug, and you really shouldn't use __get_user to work around
> it just because it doesn't check. 
> 
> You should use pagefault_disable() around the access. And if there is still a
> sleep_on() complaint, that should be fixed. 
> 
>         Linus


Thanks Linus, will look into this.

-- 
MST

