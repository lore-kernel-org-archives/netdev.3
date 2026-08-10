Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AF63DC4CD
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368327; cv=none; b=Ql8xHAzm8zUiZsEw+IDT2PwMdHYwXIFdQawVoo1m6gTraRFrlldbihJMQ8L9l1268lMFy/LvXf1NAWWigidmA9zHSS2sfmNvtlB2xmT4q4OGxu+1PmBTYrtc0QTkAjgupYgd2o0qa3b5tls3yub/XEQuJKmZt042hdxo9uwaxww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368327; c=relaxed/simple;
	bh=B8Kpw0JPqJEXYAOLDMKIaAc4pa002KqgaAqibO7rajc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8NV9DTUgg3/y8L9znpgLi26X6W+7Rk24e99ojJaVWu3+EfdEvfXqMijsXJbUxpAkBmIO3AFBCcgwJar3AWeg29k8S+yE+WiFy8XBreg5BSrIOrR04tVckk7V4QumeOMqOQ6M3cMURgZqvJrJmLGJoDqvKtB0DNGnR507aD2Zm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2xcQEdq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2xcQEdq"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49558ce01afso14626175e9.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786368324; x=1786973124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N0ofoODcYWs3I9OWUEGLHyeHF210MGua+sArH7R31wk=;
        b=K2xcQEdqGBHowxxZs8MPx/yE039bJWgPMxxkp4/jDRHdmNgymHgAgc9WngTbmWFVE8
         kR0lg/VezGKI02S2gOXPAvMPl1NL4qHChCPG/ThTLPbos/o+rJtEqopk9/dNOEXLUdkK
         O2Sk74awk7+s3DGBCsv4xDud6+vtc1gs0iSAiK94pR/d81O63/1bMuYlWiDFy6hgZysZ
         mk4RcYp9fwIDkk/R/u6/I3XeFDVaWHBF7dDR4s+jn6HQLrImLmURgtDa+AtGng0ZCHoz
         lpsaMhWbPAETUSj6urdZuNZ6rFCuTBD50gm30wvjxvewK6EQwhFSCJn3EE/+EOkYDHu0
         Rr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786368324; x=1786973124;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N0ofoODcYWs3I9OWUEGLHyeHF210MGua+sArH7R31wk=;
        b=PPNsw5yytu4/A7vpTkUSNSY0vq3o+9gzE91O4i6ZtvC/TbKywm3Xy5gIMPMqt+jB2r
         8v7aWEu2p4w4ndCNQRAeWkhI38fOiDJH3UJSr01V6+sFAVWuxq8BRTiXqxTxK4sIaySG
         009NH403L3/nPZwujdKiztsc5DixYyvWh1FZwihGD7s9fInE4X1Vj6OzMnL6eWWeqzS1
         VTeMVlI18OYmX1HA9C1B91yM9LD/q/tzw6sBCg1MWuS3XH1nrhL4CRTsWwe2etyMEMFl
         4Qt+TvVGMv/XxhiBU/ex9fkL3hdIdYCXxq6AWyOC89WOOlTKMDJsWMhTvAWLC4qzUE55
         lNTQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr9msBDjs1oVt+Bl+V9f7M0JOXAdEE3cbbkH1GOMJX8yE1R1Bbxyze+E1W6TYJLGIJBCtGXHcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8/afGEhf+i+9LJ8iwFGXbe53dSrxYJS8cHJ/4Yoh9eBYZ/v9V
	Rq49aWhS8EN1tH7sZGI6AHdMAqhPUi2kWhOzsPlV/DtWPeWhU19Mctb5
X-Gm-Gg: AR+sD106M2H+H94VbbixlBODzNetvuhl0g+od/QlqBfQk5x8XJTaCU1tQLVAgL+wTrF
	FwVtA+2zGWThIBzdo+xmeC5HDdU4MRUVGIGIEJ+1R05iQhEsBnXD/O1RlR5jUzZoQpaIav4vhSy
	pIKWB1X+k1N3Ed1bsQnbWGYDvhy4ce0YcjQy/XTVJlFUiXot5mHf6DtOgnwGjFm/N9hP3nVtMAs
	K6FDc30vYkyV8EUognkvIgoG34wOYijGvCxY7dy10NLd+yHyXwC9s4AeFiPDrshGLELFGjKNAeC
	JKjochh4JDrt+iwrA2TLkEK5Xwjmtq9A4/qEK20N+22RqWVImOIyy7+GeYWTmFJdCpqsOsDdsPR
	iIZqmhNlvBJvSLkz14vKCn5y0nsv461dN/TN5PcWACt0Q+n70U7S360H1l2QvwWlmg+Pcy771Jx
	JGkXg1CG5LO0SAZ5OfYMcYywaYcX3+rSEBxhh85o9sXjyyKR7dQLUYn3QwWCIWdhElDyUKxQ==
X-Received: by 2002:a05:600c:4f86:b0:495:4d00:2fda with SMTP id 5b1f17b1804b1-4994e72f7c1mr558010415e9.2.1786368323764;
        Mon, 10 Aug 2026 06:25:23 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c8ffsm229399395e9.2.2026.08.10.06.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:25:22 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:35:51 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] virtio_net: Fix resize of the RX ring
Message-ID: <annTt1qn3LOmNvvr@mail.gmail.com>
References: <20260810120728.47445-1-a.s.protopopov@gmail.com>
 <2aef652e-d98d-4ca5-8270-5f108e5593a2@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aef652e-d98d-4ca5-8270-5f108e5593a2@linux.dev>

On 26/08/10 02:07PM, Vadim Fedorenko wrote:
> On 10/08/2026 13:07, Anton Protopopov wrote:
> > When a AF_XDP socket is attached, the virtnet_rx_resize
> > should resize the rq->xsk_buffs XSK buffer array. Otherwise,
> > when the size grows, the virtnet_rx_resume() causes a write
> > past the end of the array. This is easily reproducable with
> > 
> >      ethtool -G ens3 rx 32
> >      ./xdpsock -i eth0 -q 0 -r -z &
> >      ethtool -G eth0 rx 256
> > 
> > Fixes: e9f3962441c0 ("virtio_net: xsk: rx: support fill with xsk buffer")
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> >   drivers/net/virtio_net.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 3e2a5876c6c8..e34c52d059d3 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3444,17 +3444,31 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
> >   static int virtnet_rx_resize(struct virtnet_info *vi,
> >   			     struct receive_queue *rq, u32 ring_num)
> >   {
> > +	unsigned int old_ring_num = virtqueue_get_vring_size(rq->vq);
> > +	struct xdp_buff **tmp_xsk_buffs = NULL;
> >   	int err, qindex;
> >   	qindex = rq - vi->rq;
> > +	if (rq->xsk_pool && ring_num > old_ring_num) {
> 
> why do you cover only the case for growing buffer? Don't we expect to
> free some memory in case of shrinking? Should be fine given you are
> swapping buffers completely...

Isn't this common for "realloc[s]" to just return the same ptr, when
shrinking (to avoid extra actual allocations)?  But I do not have
any strong feelings about this, can switch to "shrink/grow", if this
looks better.

> > +		tmp_xsk_buffs = kvzalloc_objs(*tmp_xsk_buffs, ring_num);
> > +		if (!tmp_xsk_buffs)
> > +			return -ENOMEM;
> > +	}
> > +
> >   	virtnet_rx_pause(vi, rq);
> >   	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf, NULL);
> > +
> > +	/* virtqueue_resize may have changed the size even if err != 0 */
> > +	if (tmp_xsk_buffs && virtqueue_get_vring_size(rq->vq) > old_ring_num)
> > +		swap(rq->xsk_buffs, tmp_xsk_buffs);
> > +
> >   	if (err)
> >   		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
> >   	virtnet_rx_resume(vi, rq, true);
> > +	kvfree(tmp_xsk_buffs);
> >   	return err;
> >   }
> 
