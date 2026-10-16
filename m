Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DA442AD9F
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195066; cv=none; b=mY9Y7KTIKcj86d8OqKM0w2lMQl3+Y4Dr3wBb040UFOPIwWiECUm/2zm0Zyvh2JKYYrWYUr1F0QC+9KEkPLO7uPp0Y2FmI09mqQITYKDYDFna5ArNv7QNQCA5ZHzLW4AtXfnZHLHALip8PofllkT/2c1sH89zu9N6AZr/H9mddXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195066; c=relaxed/simple;
	bh=SYwBoc6lridL/+OSfqP6JQDDklUqd07zyUUHXQrJ4q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcr6Pw7mjuQJicwL8y4v489PyVYm5R/zJFNSptD/O35SnAeCX/6IBeivEVFmXR7AUJPhJJiTLKx71Inub2lnOIa37TPGZbw8m+UIE0sTRxyvSAkH8trmqoNTYg8MQVcY9ZrPwcUvP1s6nb16lIyYvKM2bB1MuRAGLCwGWbXKjRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bv945dHc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNbttL5F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bv945dHc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNbttL5F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792195063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qOKVAt0on4azaGyL+2yuKkrJq6J+UyxVY0ZXT9K1Dc0=;
	b=bv945dHcP0ziwlUR9NGUI5jTCf9qWAJrzWpZgiA1OGD+/+ECwMCQcVeSMeNEW9Pm/wj/0V
	F7PMoZoG4QYKDOuKpCPETcVBlBOdMqXYfQJPdN61xTNILT5M0hAldGEG9p4z11mpO/cpw9
	6hF5ykPst8PQxT63gHPT1Vqk/phCI74=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-z4rX3p_hOSad7ZMBaASNzA-1; Fri, 16 Oct 2026 23:57:41 +0000
X-MC-Unique: z4rX3p_hOSad7ZMBaASNzA-1
X-Mimecast-MFC-AGG-ID: z4rX3p_hOSad7ZMBaASNzA_1792195061
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48b01a74792so186941f8f.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 16:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792195060; x=1792799860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qOKVAt0on4azaGyL+2yuKkrJq6J+UyxVY0ZXT9K1Dc0=;
        b=UNbttL5FQHriKrQxpc49B/yHqDT1QgnZemdxjgTAxKcycAroDiqkyIKbbzIuvHG2gJ
         PofUuPrJ0onW/64bNyfGjJJSVWcLW0XRAGOu47KEq0gZgl5CL4nJpkQWYOnDO0zImOPA
         gTwv7LziV7RS1T7s/OtlCRoE4UJR5cfltjKsuj/V7J+D2iqXjF6EBEH6TPCq5a1xCcQC
         EKbGeeFyg85zmF4epD2Wa50FI2wahhb9xCHeD7TK1BgmNKGVwr+VsK/It+E+V2nE5O4Q
         sS5EfMqnp3U0er9S7KkNm1j99ecHjYvFc0VBq9sZOnTlgY4uHxmtkz7zD5Tsd02K6d0D
         kZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792195060; x=1792799860;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qOKVAt0on4azaGyL+2yuKkrJq6J+UyxVY0ZXT9K1Dc0=;
        b=nEjqAa1reSpljCwwdZpz6j+yLFPqJ+lNLl+pfs6Aae/gxNmN0jeZ2Yc515Rh4vlpVw
         QzuF07tbtl6qNuG9lpOqgXuEevNKqaIz219D2vbXkXodqKEDjuQSX7By5G74M95p/+df
         m+OvYyU4qXAWaDQRj6PD+naa7YgprhZPmyJT88g5H5PYoUwUTufETK9wo5JknW+V8xzU
         +r/m47M6iSMLKQk/Bh6pHbPVeQYt4Vj9Ko84LUrNR9U9G1L5eJMnn6JnfJ9ral1++3jI
         8L/AL7ulCNNSnuFCctPDxPO8jZFPuhSbca9KGqvfyPDwoxC4HOFRrfBPI9tLezCn061J
         YOBQ==
X-Gm-Message-State: AFq9FYINl8y1WQbUKDnyUVxGrta93QCX+FHHfjj8H5ezYKpytZrdgPjt
	SfF0bUK96i+hogel562fFBsVPjqdktYLZaHsE2stE4zcK36RoXR5mTCgVxQvDOGdmSw1pouKWLz
	GyiwWe6gQ4Mf6o6x5nueugnVf+Z9doT6YfCPO73JV8g/LZMSkM5sf3rObZg==
X-Gm-Gg: AYBFou32GkIF3DBdWCqpyG5nyRFz2lPRg6uUE1yVwj1Z2r8/4wVjmHTos81iXCbGz49
	sA7fksJ/cvWKXLD8950iCS8STl/Alm/zGRM4pVzzRN9FA3bdU4FNFpYtSuR4R650F6I2b08hC6a
	OoSUVQJfk9Z0mNz9rE3FLUSw90I8DomQ7XLSNqS4BUg3RXXrIaiPlBGgxsKCFpVJOt61k+wn1jA
	WAHRW4aWXnjuCDTXaM8fXQM78jq5j5wgXzsQDoQ9de4XeFjZze0l4e1ThL9gohddn0WeAYYcQ/Q
	RGTQq2QdXMdo1FaHAdmUGPbay4nXF1a3OyHXM/3dAfWzlRU1GL+NsVKaEPeCm1EgXgYswMk=
X-Received: by 2002:a05:6000:41cb:b0:48b:10c8:2181 with SMTP id ffacd0b85a97d-48e07f9a2b1mr2014691f8f.27.1792195060431;
        Fri, 16 Oct 2026 16:57:40 -0700 (PDT)
X-Received: by 2002:a05:6000:41cb:b0:48b:10c8:2181 with SMTP id ffacd0b85a97d-48e07f9a2b1mr2014659f8f.27.1792195059909;
        Fri, 16 Oct 2026 16:57:39 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73fb:d100:601d:d7d4:d03f:527b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4d4dddsm8072055f8f.22.2026.10.16.16.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 16:57:38 -0700 (PDT)
Date: Fri, 16 Oct 2026 19:57:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Megane Hebo <hebomegane@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, willemdebruijn.kernel@gmail.com,
	habte.yibelo@gmail.com
Subject: Re: [PATCH net-next] virtio_net: validate csum_start before
 installing partial state
Message-ID: <20261016195543-mutt-send-email-mst@kernel.org>
References: <CAJPVW+=TP73rBavAGTJVqXVN4Uer6JwOi210+2V8nDsH=H=BcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJPVW+=TP73rBavAGTJVqXVN4Uer6JwOi210+2V8nDsH=H=BcQ@mail.gmail.com>

On Fri, Oct 16, 2026 at 02:25:31PM -0700, Megane Hebo wrote:
> __virtio_net_hdr_to_skb() currently installs untrusted NEEDS_CSUM
> metadata into the skb with skb_partial_csum_set() and only then checks
> that the resulting transport offset is beyond the minimum network
> header length.

and? why does it matter, the packet is dropped.

> Validate the raw csum_start first. Successful packets are unchanged,
> but malformed metadata is rejected before it can transition the skb to
> CHECKSUM_PARTIAL state. This deliberately does not replace the broader
> ingress validation being discussed for virtio checksum metadata; it only
> narrows the state transition at the existing check.
> 
> Link: https://lore.kernel.org/netdev/20260922030310.8684-2-habte.yibelo@gmail.com/
> Signed-off-by: tonegawa <kiyotaka.tonegawa@gmail.com>

what is the point?

> ---
>  include/linux/virtio_net.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd00c..c8180f1222f492 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -102,9 +102,9 @@ static inline int __virtio_net_hdr_to_skb(struct
> sk_buff *skb,
>  		if (!pskb_may_pull(skb, needed))
>  			return -EINVAL;
> 
> -		if (!skb_partial_csum_set(skb, start, off))
> +		if (start < nh_min_len)
>  			return -EINVAL;
> -		if (skb_transport_offset(skb) < nh_min_len)
> +		if (!skb_partial_csum_set(skb, start, off))
>  			return -EINVAL;
> 
>  		nh_min_len = skb_transport_offset(skb);
> --
> 2.51.0

