Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77974A8A25
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916885; cv=none; b=OQrJcYXbIYICmi311brHgz605706KZ/6PhLmEuanbOawx3JYWypAfqKjRYGkwaWJlHF++ndL5tMC3MCjMASeBupZnlZhNfhY+wskKvzq0qBaMmK6x6ilzPlHomRYl3VdqTnor7Zz3ldLGGFwoSRsN5hjBNua9L7/x7/JNaZSiyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916885; c=relaxed/simple;
	bh=yARy+Nf0dbu9XT9d1ERfBCwuVuYyeCm3xP8uoZbF/fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSdPfWZzxxXbwp/5BXGeyyeMKFYZ/+QwnmRVI+Lkci4bKPj0xbZHlttl4TX7LEstz0PJpB2PEXs9P6k9Aw9dgUrBzZt7PNyITd27Qy8R2EODIYkPoqD5IROQyN2ZmwPM9IVIiJJnziXsDOBHel50Ns0MojnAnIbbFo0qyLjWDAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gAL0CW2i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Adn4zYSW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAL0CW2i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Adn4zYSW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791916882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+79dBe7BXsqjXhOxqgwaqCIaKDkT92Pn+PV93QPrx1M=;
	b=gAL0CW2igTOoUOOqplJNlsL1iQ/7oeZ2MgD7ZshhI0D2h5HhdqiW97+QB4QVmhSlkM8Vjd
	99W7wMIZQKyLXMC8+8cd5MClO/vN3AH7wXVvGfEDH/QFth8aWA2jItTha9MgHALEbygstl
	soVVrMy34GW23lQTDOkC6PaFqXrcYug=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-ymCyxE-xP8uGkndW1UIjIQ-1; Tue, 13 Oct 2026 18:41:21 +0000
X-MC-Unique: ymCyxE-xP8uGkndW1UIjIQ-1
X-Mimecast-MFC-AGG-ID: ymCyxE-xP8uGkndW1UIjIQ_1791916880
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-486f9d150c3so1967045f8f.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 11:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791916880; x=1792521680; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+79dBe7BXsqjXhOxqgwaqCIaKDkT92Pn+PV93QPrx1M=;
        b=Adn4zYSWCBa3xaTK1x9LiwJ7Z9IC+GPqGXG43Zemxw8GcALLxpG7TpQnmaqXZxaYJL
         mZ77526aqSyMpGcYZ6va2s8635mBM4Mzp7W5uSkkWdp7Gi6s371bxHI2zLpycOUpy36D
         tP9XVhhWADEiLo5vCZfzhDi/dF5uSmiw0JTfG5fapB+lpMomfPbAx4BwphHg2IWdHTZj
         zFsylVp5q28cYiCwOEacxk8VS18sNEEFC3KPKigqDddeUbQy0d2ac7EbWNqAVyAkuITA
         w35hI8Rw0/2HDKlAgjqRtKd3h9YDT2VaTrurC18X3jqP+U/uc721+YW2Mk2/ejsHNtYP
         OVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791916880; x=1792521680;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+79dBe7BXsqjXhOxqgwaqCIaKDkT92Pn+PV93QPrx1M=;
        b=1M6wqzb5zMhzB0iyhQtcI1i89mH98YibrMLa4oRu7eaKZZFaNPqoVmar2FJ+hwHfnQ
         FdPrbBddQpW/EhzEMqZQjbgXatnRSAeBOcGRrRt8IYe7Pfge+HsqdfuqM+kKh8Q0kcdk
         sgicXrQ1FOOWqyjTjwaJAhXrXpxcvg7a/yxr0csQs0FRyEvpWCiYTCAyY8kxnxd7Q8I5
         WcyO8iw+a0agnrD4gSnkFXoRktXZiSWgjH4WWRvnm8lwYnnPXXwcPXm0iv1Xs+UPknlO
         XftMUdruJqcQ738S+hhPy4SY8GZ2tWUxRvvTn6SGr8Bip6aiMhhVGDY1mD9c7WohtA7x
         PGPw==
X-Forwarded-Encrypted: i=1; AKwUvBxA4+SxHxv+TZ9HgdeLiBLiQQFhUeFb4i3MkhfXLL42YUmi0Ql0VpNvielW84ql4uxEHZ6UaeE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSGPAlhOlXIivxdyo8YZWFBa9swUSEXWV6uy0EUG26pmZCX3/7
	4V0CCtG9M8N2RS5DH6LhlZ3OydSNG4ETy1All2THeLYFWNyenaCuThgUCptkYxGMscaZ1FejMa7
	oHPJyFrYrKjt8VyJyl0ahbvoio3cwSl0EIYvVFcIKa8dfkdUESeydo5rAcQ==
X-Gm-Gg: AYBFou3gjHXZrMe39SdcvKoPmv85mYuUE5gWl9eMFToa72BU+wddOO5egV128MSnN81
	unSNi+UP+h0qGXIsKZ+dr3fgX6TCwcwf4hLeBLVNOdfXGHS3NHwJBSTRsUTehGsJCWmZIN5nA6v
	79ANmpT8Hv8zrJoYlLUOIpaA2aU3BZXyLvh/Cofu/MpW5YfRrZGLhWOGUucXdENvjmvTCp2d0gO
	S9hbNoq0bY4iDxi1jK+M0Gn5nv6GBT+BEl4mNNweNRDh4kpnzaz4xhqt+6y0JF6nlhS5HHwuMxC
	xWwh1LLNcvCbrfVE+HIeP/hjfaFoiFMeL/noFipNMi8dTl8l4Y2R97+8pFPQ5q69+MEOKA==
X-Received: by 2002:a05:6000:490a:b0:48c:490a:336b with SMTP id ffacd0b85a97d-48dba7bea0bmr24731942f8f.5.1791916880184;
        Tue, 13 Oct 2026 11:41:20 -0700 (PDT)
X-Received: by 2002:a05:6000:490a:b0:48c:490a:336b with SMTP id ffacd0b85a97d-48dba7bea0bmr24731878f8f.5.1791916879648;
        Tue, 13 Oct 2026 11:41:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc506asm7057620f8f.47.2026.10.13.11.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 11:41:18 -0700 (PDT)
Date: Tue, 13 Oct 2026 14:41:15 -0400
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
	Paulos Yibelo <habte.yibelo@gmail.com>,
	Chris Arges <carges@cloudflare.com>
Subject: Re: [PATCH net-next 0/4] more virtio-net csum hardening
Message-ID: <20261013143716-mutt-send-email-mst@kernel.org>
References: <cover.1791887415.git.mst@redhat.com>
 <CAF=yD-JhTbmYmHUkkruPcyvSWv0QhVeGWC=K=ZvvpMdkzA-jig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF=yD-JhTbmYmHUkkruPcyvSWv0QhVeGWC=K=ZvvpMdkzA-jig@mail.gmail.com>

On Tue, Oct 13, 2026 at 08:41:19AM -0600, Willem de Bruijn wrote:
> On Tue, Oct 13, 2026 at 4:58 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Allowing untrusted hardware to specify csum start/offset for
> > CHECKSUM_PARTIAL was not a good idea, because, if it edits the packet
> > outside the actual checksum, and depending on the setup, the networking
> > stack could be looking at the packet both before and after the edit, and
> > seeing different results.
> >
> > Previously, commit 6785011f8b16 ("ipv4: validate checksum_start before
> > completing checksum") validated all known instances where this
> > causes the most grief, but the real fix is to make sure
> > that either only actual checksum fields are ever edited,
> > or the checksum is completed before the net stack looks at it,
> > so it is always consistent.
> 
> +1 on the general approach of performing the checksum offload at
> input, unless the input can easily be validated to be one of a few
> common protocols. That greatly reduces the risk vs my previous attempt
> at trying to drop.
> 
> Since we do not know the full extent of grief, I think this too should
> go to net and stable.

I think it needs a bit more testing to be frank, I do not see it
wait months out of the tree. So if this lands in next before the
merge window, we are good I think. If we miss that I will target net.


> That would mean initially a single patch that
> touches as few files as possible. The helper function in
> include/linux/ip.h and conversion of existing open coded parsers to
> use that can follow up later in net-next.

I don't see the value to be frank.
What moving code between files accomplishes, I donnu.
Squashing things surely makes review harder?
Does your backporting system really struggle with trivial
dependencies like this?

I can drop patch 2 and will if I am targeting net.

> 
> > This basically does this: checksum at ingress, except in a narrow list
> > of specified known good cases.
> >
> > Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> >
> > Michael S. Tsirkin (4):
> >   net: add ip4_parse()
> >   net: use ip4_parse() in receive validation
> >   net: resolve uncommon partial checksums at ingress
> >   net: account for ingress-resolved virtio net hdr state

