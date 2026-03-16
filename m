Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2266386577
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657849; cv=none; b=RCru/XGN0daCkVMTfOpp5e8nlnLSKLLlsbmP08u2dRBR7fg9nLAlXHFaCIziCJnokig2kggG8Hkcu1T58TL5GbX+Nxd4L/wS7AdqeSpwysCL0XD1YY4YK1WRUPTuwY5vu19+3eG58m7r+xDM2VJIf4YcDNf2n+l50id+flHUPnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657849; c=relaxed/simple;
	bh=Sfai54yGfVswX06wKRJbvlx+Ae5w4/tFvgMB8FyVF0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuB74gJc/JwglA/pHVID2kmDkjMyqJDuKMLU/oAKp+pYPbWOLzKqrrc77yfJq4tfqCtX2QG5NbPyOf+4E240tJDNmFgVbR2l6yHIv8sym1BaF020hUcH0EfYV+s+DjGp3P5H7f2pWkCkY39n/VNk9zPgmzBTfp/hQeYdL69kIrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G848RMsI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uLuI/13o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G848RMsI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uLuI/13o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773657846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N/gyi8r2QqrmKNfnuildAwIe3Wu8jqbPwSPfbNMez1o=;
	b=G848RMsIykfGvEzrRxY+2+Ez7Sc7my0bZqfvakOq16UZT8IgiyQbbk/SM5WBSuYzuA5JtS
	TxAqz43MRUsp61Du0qrXvfKK7Qd4gTxwFTuNbT7rI4WEV9DLOo2i+CkDWP+R1JoaRvsvja
	hlazSUMepqzlAbK/+Ntj2/M/SdJcCDI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-PF0IuuE0OLWv3kISjfRnBg-1; Mon, 16 Mar 2026 06:44:04 -0400
X-MC-Unique: PF0IuuE0OLWv3kISjfRnBg-1
X-Mimecast-MFC-AGG-ID: PF0IuuE0OLWv3kISjfRnBg_1773657843
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439cbc5fd75so2830926f8f.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 03:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773657843; x=1774262643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N/gyi8r2QqrmKNfnuildAwIe3Wu8jqbPwSPfbNMez1o=;
        b=uLuI/13oe4sif2ofwTZvB8fNufqkvPnefy1nmZnOsEdwVaNHzyRfqNQKk7cQgGQbxd
         jLBzjKsbguZ4UXPxr+6U4ZqD7ziXbH15f1q1hl1vNuHzcFgcdTzdftdITzbcazDKRx/V
         mCCNqalZFEgO22aVHUycXwOEzRPHy9MltoqYrAiTvdRnH8qCviYGQWagABYli6P8I8OJ
         Iec393l7Kemhh2TtaAvxXN862zmjgfi1wsg+PUKyRstHUUbco9LN+fFPfD+GWna1o0ic
         USeiCCzcxdHx1j3V3T8V+eR0X0lY+hAzzZPeSmtk7WRwZUmD19AoaLbeX8j+n6o2Ypp2
         hJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773657843; x=1774262643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/gyi8r2QqrmKNfnuildAwIe3Wu8jqbPwSPfbNMez1o=;
        b=YY7K5YjLiEPvSonhimAsEoWqxtPUaCH/mKo5NR5IqC2nlFsd1ReeNWl9bAiJ5OFln3
         PbWSYzLAowlwxp3QCXZIdmhw7kGNhFOfRCqD3sthuI7SI4NVyociHfI2BtmkB6m7eGSm
         RMT9G9tIMrwCOzFbJ2K6JzAYusnWJGLcEytMz+8DCC1sS19/v99IX2RF5hUFGMJpKaRz
         PuUe3n97G95GVdEgD1EasWK1fTc4dqnD86kaJQJEZvYwoyQhwFu3hcJYbCHPD5sJXGxU
         U6fTCR33h23Xt2YdZYPkhsLsQOVQLMUkurt6J5cqnHW5GG+8HOWIO2NXKdjjC6nEy3WE
         Acww==
X-Forwarded-Encrypted: i=1; AJvYcCVCM1WmIQpeDwfP133BN+hEN33FTZTGZ9NpSr6YXfsnDANERE9Hd5TJr2/bRyIUvTSv0pNTu3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKhrBbxN/VwrLCPCFGhyID2LHa0ElTWtOgNLF75hNcLbQ5dGKd
	/pdfkEtUGoWaCCin+P/uSb+KPcjN3ATcT6tPI66T5xOFM9x5c8TIOJ/A1Q4RhhroikfU3HMgr55
	iLEr7K5fgEkQhT4Lw67NmgNSoO1aL25714M4i6UXelpFSLvz6cZ8EJtVrmw==
X-Gm-Gg: ATEYQzyA5funPoKU8LogTBgkv5ZOosX1gzSpiuuoy7bTh0LFuCNO0JoCenS4188p4E5
	+u7NGorN0y80CU6zdtk4ucjqjzbGa1c6yNaZ3Gc1T0xYMIq+62TQgvtcY53LIfNOXXqRtrwFV/g
	lg6YNY5XrAcZrThG1wrPcsO/d/0gVy4CEMMv8v/bmKZl1hOTJ66pFjAVvmNXO7sAwZIsT5JXgzS
	JQPLrwPqtwy60KN3QhdhNiMI/N/yr0Gd2AThQjfQFCQexo7sWOrzAMVt+IZfueh6J1bbg4TtZnI
	UmP7YA4tGlf1+nUG0ytIu7/698mPBZ7dWdVVHVLEOKkEgDQa/ch81wBYjEEs6KlFuDqiLNtiahY
	9azX2zIbyQDjwd2RpDPZgpr6tnBnuIfOgsUNk0ML+r/OV4A==
X-Received: by 2002:a05:6000:381:b0:439:d8cb:1392 with SMTP id ffacd0b85a97d-43a04d91a43mr23683339f8f.26.1773657843205;
        Mon, 16 Mar 2026 03:44:03 -0700 (PDT)
X-Received: by 2002:a05:6000:381:b0:439:d8cb:1392 with SMTP id ffacd0b85a97d-43a04d91a43mr23683282f8f.26.1773657842675;
        Mon, 16 Mar 2026 03:44:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b45e51681sm3730121f8f.25.2026.03.16.03.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 03:44:02 -0700 (PDT)
Date: Mon, 16 Mar 2026 06:43:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for
 buffer allocation
Message-ID: <20260316064256-mutt-send-email-mst@kernel.org>
References: <20260310183107.2822016-1-vishs@meta.com>
 <20260316054232-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316054232-mutt-send-email-mst@kernel.org>

On Mon, Mar 16, 2026 at 05:56:20AM -0400, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2026 at 11:31:04AM -0700, Vishwanath Seshagiri wrote:
> > @@ -5857,7 +5863,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
> >  	/* In big_packets mode, xdp cannot work, so there is no need to
> >  	 * initialize xsk of rq.
> >  	 */
> > -	if (vi->big_packets && !vi->mergeable_rx_bufs)
> > +	if (!vi->rq[qid].page_pool)
> >  		return -ENOENT;
> >  
> >  	if (qid >= vi->curr_queue_pairs)
> 
> 
> 
> It seems that a qid that exceeds curr_queue_pairs would previously get
> -EINVAL and now gets -ENOENT.

Or maybe this if (qid >= vi->curr_queue_pairs) is dead code?
I looked at it some more and I can't find a path where this
triggers.

> Maybe reorder the checks:
> 
>         if (qid >= vi->curr_queue_pairs)
>                 return -EINVAL;
> 
>         /* In big_packets mode, xdp cannot work, so there is no need to
>          * initialize xsk of rq.
>          */ 
>        if (!vi->rq[qid].page_pool)
>                return -ENOENT;
> 
> 
> Alternatively I think we can completely drop this chunk: we already seem
> to init page_pull at all times except for big packets mode, so the
> current code is fine I think.
> 
> 
> -- 
> MST

