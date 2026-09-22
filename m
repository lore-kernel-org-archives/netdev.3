Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0ED52F285
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066818; cv=none; b=c/Bu/nLe2P58eApbu6RjJzA1/Aybmdd2yWnQf8eVdGuaqrkCmfVQ+RKKQIu+KcuFw5YqivuMz9n2EVryP26BaaNlgszpmRGWI6QPyFh+PJOel0EUAPLSlVycKnNAq668WropRd16QJ2pnrzEu+MowoQ+fERsUHtfP2kaIjVW/wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066818; c=relaxed/simple;
	bh=hEj5nL9MRpMH+JX12YZNspzZFd1+3Fuf+CZGgePMxM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gM5WtwUk3M7TrubweHF/xQnThN4UYAla/oGRBmSUKy6voiWj4klKWMyqu+3tkK8sXj/5i5TuCowbSzhlHpw4Xn4UfHbZ02+P/7dlZIm3UGnV7e1GFQDDY8Pae+coJznRsTi4kPtlzWqEv325gdMp357r1/rGbM6VOlR9kOS5WNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IYBKNLtQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WaYJ8M0W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYBKNLtQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WaYJ8M0W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790066815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C95bRAv5IkFCsxK5LjzncGYLGpBLHTNK6JTZFhyWW0M=;
	b=IYBKNLtQq8wTUycH85md9ifO3UzdBdQpmXnhcI9WuMUbzlJTZb2nJoqTJfUGv/jkxW+2df
	Q6/0abTDQLcb41eolbGg5OtlRpucdzzl5QIHymKupyLRdX/r9s70yGIJ1MliJgs8JNm5Z+
	SWpooAx5kvmxb+KysJsp5NFMcJny9wA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-sfUkQX2xN9yuT3oxtJ2GMQ-1; Tue, 22 Sep 2026 04:46:54 -0400
X-MC-Unique: sfUkQX2xN9yuT3oxtJ2GMQ-1
X-Mimecast-MFC-AGG-ID: sfUkQX2xN9yuT3oxtJ2GMQ_1790066813
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e7631c43aso50743625e9.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790066813; x=1790671613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C95bRAv5IkFCsxK5LjzncGYLGpBLHTNK6JTZFhyWW0M=;
        b=WaYJ8M0WDXY41t6aJdV7dAtLD/WG9BCa/2mVdYHEDhRiXod0jioeiS2VtDV6Az20T7
         +Gr5LExcSy4Ohg55uWipz3cTnR3X5yZ5Vrt3O1jcfjIJXGVmEb62WZWwUXYJfrNtTYV3
         gjCLuime50/prA+2ewWPzEGdksjxsuIW2XXn+WOC49hXygfCGlALNjwZD+au/Rmiarrz
         a8hNui9wBUadUJBh10cz5P/IAhq1F8jYrrl8p64nuynZB/YFqgf+HF+ASUJIMXfAu9Tq
         6iWjtEM/9Wp196S8wQxONv3r6kNIo0cZfqqbyuIVxvcyXASjjndyrHKkyhslSraLunjy
         aWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066813; x=1790671613;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C95bRAv5IkFCsxK5LjzncGYLGpBLHTNK6JTZFhyWW0M=;
        b=Hsz59Ur+lPd5vptLTPFs7mDDtArTL9I2nMUn1yEkZYHaj2YaLRSbbdYz/URA7YxqfC
         T+dGQk2Rz6jvBgo1u2Djgu1ezaD8raFi1Wic1Q1u+38EDNdYr7E9NC+yV2HZ1e2NJ01T
         +Q0Vu8VilKHJwN7vE2B5O56QYn3+NuD2OgwwmQnvWheK5LHmD9NnxvwWXBnSEX1GoXLH
         +7JSxa8pC7b39/Uqha5+QSii0qfYTgjcGfgSi9zWD7/zmQsHan8GKfFUM511uAXd/dJq
         +/Ztsf9jcZrvy7qsYyAEpQ9ofoGXW3J5SlNTpcEOWebiIFqhYBZR5mgGwqziPcgPS6VG
         K4Jg==
X-Forwarded-Encrypted: i=1; AKwUvByK09UZFtDygXFM7fynKomweWISgG8z/8aZqhxFmQFl0hqw/Gd2X7vlFGv4UxjPmZR055JCysg=@vger.kernel.org
X-Gm-Message-State: AFuF++mfp5TaRrPl5hnr5RT9LAgwPXqvKXrfl6nmsLRDoL53/EUeSkzw
	cQsghOpcw+N5sWDT666+eBT2ZWwbFO09kawUx1DEgM/eZJn7KRW0mldcIp7AZU1ohLb1UhtNE4v
	4rZBd+mJLAZbeyatWer0BhZF1VyeV7jBcsJ8UKf88oa6ogQaRQ5JUxSLQ2A==
X-Gm-Gg: AYBFou2OYj6kUsxb4r40doZ0FubiVHU9F6dTJzfudGuwSuikLhfBSeeQW2BTjKsjTR4
	2k0tq59HBhMGmIbUFiQbThKEZhKA/pz1DmmF7f6V/L/tdpaUtYTTJAcGfsprZP0FVEM2YQPP/Uh
	zZox21WiOp+LD8eksPlhL8huMxURLTrOCLK5iIwnJ5fIkrtGi65LYEh5TEu418KR6NKCFlFQ+i6
	OAVj2DH9b2OmBa3M8OwKI0pwttWW1OzjmeXeMbe1F4E7kU5vwh8KcVrF5Ek6PUDRLqKNww2/Sut
	AK5N9VWZH77PQcJfmyq+NHk9Fjwp4DK6VTr09n9u8OEcDx8zZj8Rg+IfjfNz7LUt06iSCS5yfno
	GW6HX9dold6HvwdbqYCUtYQQ=
X-Received: by 2002:a05:600c:19cd:b0:499:7a15:fcec with SMTP id 5b1f17b1804b1-49fc5695861mr190094895e9.13.1790066813180;
        Tue, 22 Sep 2026 01:46:53 -0700 (PDT)
X-Received: by 2002:a05:600c:19cd:b0:499:7a15:fcec with SMTP id 5b1f17b1804b1-49fc5695861mr190094445e9.13.1790066812661;
        Tue, 22 Sep 2026 01:46:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm65246905e9.8.2026.09.22.01.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:46:52 -0700 (PDT)
Date: Tue, 22 Sep 2026 04:46:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Paulos Yibelo <habte.yibelo@gmail.com>, netdev@vger.kernel.org,
	richard@nod.at, anton.ivanov@cambridgegreys.com,
	willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch, pablo@netfilter.org, fw@strlen.de,
	phil@nwl.cc, razor@blackwall.org, idosch@nvidia.com,
	dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-um@lists.infradead.org, virtualization@lists.linux.dev,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	bridge@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v6 1/2] net: validate virtio checksum start after
 network header
Message-ID: <20260922044627-mutt-send-email-mst@kernel.org>
References: <20260922030310.8684-1-habte.yibelo@gmail.com>
 <20260922030310.8684-2-habte.yibelo@gmail.com>
 <20260922005353-mutt-send-email-mst@kernel.org>
 <aa560d2d2cbf94e50397740159c12e24e0ecf820.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa560d2d2cbf94e50397740159c12e24e0ecf820.camel@sipsolutions.net>

On Tue, Sep 22, 2026 at 07:56:23AM +0200, Johannes Berg wrote:
> On Tue, 2026-09-22 at 01:14 -0400, Michael S. Tsirkin wrote:
> > 
> > >  
> > > +/*
> > > + * Return the L3 offset and protocol of an Ethernet frame starting at skb->data.
> > > + * The offset is unused without NEEDS_CSUM, so avoid parsing and return zero.
> > > + */
> > 
> > for networking code multiline comments:
> > 
> > /* always
> >  * look like this
> >  */
> > 
> > /*
> >  * never
> >  * like this
> >  */
> 
> This, for the record, is't really true any more - we dropped the special
> rule a few years ago.
> 
> johannes

Oh good to know. thanks!

