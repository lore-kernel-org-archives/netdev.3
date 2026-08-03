Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1BA358378
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774683; cv=none; b=fD6M41P5J3pwg41xc8KSRr3E1Fck66MHDEaRXLPyoxDgMV01C0NJfbn8TT6mE7EeUA14jjxu+gCrSWUaSVrTtQg8kYU4xA7vylAXDgC509Hn1L3f+o6bmIAPp6NQMF6e0xOxLfszawS5Vbaa/IHn+9AkGWdTloOSCMjvRhnH8H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774683; c=relaxed/simple;
	bh=sXax4XyqEePA2uvjjA9BQDiPluqqxOQItj0Pake0ndI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtIelQP1GFtn96rFn3cp7pO1n8K4POvUEs52pOHdmYjZQqbyXGveN5WE592yLduhOwQGgXngv4s6ElUIgBUBJKW4GAcXnIo2YXBjo85v9FhhePXgvUndaaqUkLfqc4cYWs+7/ZEofvd++TGPkiVduzCtCBdqj16KFT+D3a58Nog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nuum7kwY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dA+w3HQL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nuum7kwY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dA+w3HQL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785774680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=clVP0Rp6+nFt6KFdS3kiVhjiCcIY0l8NWj1SeYxgeWI=;
	b=Nuum7kwYK18P34zhBIwsIUObig8CsaKgxYFKCIipRT1WH4b80objw37zSSiO6fvo0P+mAT
	GeEnkCQGw4ntHFLDVuDVpNytPlLxcOXWVrxclVxa4NDbOlNcTGKfxFuZIlrcFWRW+ohFwj
	WCuCe+huI4M8rUBEhMxfEfo6UUc5DXI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-Ke3IlnsWMh-U4R3mVnlyOQ-1; Mon, 03 Aug 2026 12:31:14 -0400
X-MC-Unique: Ke3IlnsWMh-U4R3mVnlyOQ-1
X-Mimecast-MFC-AGG-ID: Ke3IlnsWMh-U4R3mVnlyOQ_1785774673
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-473ac08a6a4so2855774f8f.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 09:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785774673; x=1786379473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=clVP0Rp6+nFt6KFdS3kiVhjiCcIY0l8NWj1SeYxgeWI=;
        b=dA+w3HQLFXI56VyjQZlRFWBI9j2hX3blt0yU0hmJH2rvQbwgzyF3Z25kNiMyEylrVQ
         fh6Ikj+26QU4+dxON2fmvGrIolWql48xxfw5w1/CrlV0GkBttM1+kJcGcbQ07BF1ZeR9
         N75NfGvHxDc5AMXddW3qfhDB7KmmhruQxAE8SQbceMYKkP3ux9kiVwBhyG/CmsIq4RRO
         rE9VhBlwI6EWgUb9KTG01oivnPbELe54g7cRlPjky76FUqNPr1AXfdIfKGVNRpJjSNvM
         8vrqHVOAGD9+T6eFcsSs9BZocT2F/LQZBa1b8wh0u3omFeWFDJDUJC+thzPVIkln5ueV
         d9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785774673; x=1786379473;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=clVP0Rp6+nFt6KFdS3kiVhjiCcIY0l8NWj1SeYxgeWI=;
        b=hdiXVVW5/AbvJnvCpTHjJ8KK1Z7WkRMDvcPeVJCDmb9+itRnvClCe84c5Gkax/6c/8
         x5wTEgMK0L2b1j6ppdUoB/xmXCf8do4a3JJgDF9CrjPniTVUYCHIZECRMmMdpB/VFJwR
         mw4N6MYpCqdXR8Sdkkvhhg3w6cXwIH0P6lqpHPvyQIGX0DlpcowEL8XD0Y1aaLaLU1a9
         kjT/yIqIY3OxZHszDaKt6+MDjDPW0VYiQ964Bx4zNBt7VbmUfF/Dh4P3zGqE8kYN/Wbi
         +Ta8/XIfKz12g45uqaR6zWMBFTEOE12oD0tEsFAy71C1H5S+q9nivXIs5zKCObuLB9/0
         UcZQ==
X-Gm-Message-State: AOJu0YysqUZm3RlwpmPTtX4dBJMdQ0LlQM66/Ua1O4JWBTe5G2XB9WLM
	pP4x+hGzvOQIoG1r4ti/B7Ulat21b6zru1Cppw4z3GzkBkYSIiIXhcQw2b40+dGNlTjxqHk/GMf
	al1CLcITaHcEIMz5i8TKithembGceX4aqVj187gPUsv6NCKr+2sl53yxfUA==
X-Gm-Gg: AR+sD13E2/kaBOiZqRLATOBxTfsiOeFEPASRkNzTcraFkoyaKpaURrN0A2NkN7hZmF2
	o1SB/ffWt6C0iIJ5TtPM4PEMiVf7PZ38bVkFARD+V6cYooU3QjIbnyVZ02VcIgWe5YRuqh9iapB
	KyKhUvnghw4ZAG/S53Pg6HYylNA5/LrBQV2hmB9eb2C4Dd6qTurLhA9WITP3VEKwLVxcZYmJsBP
	+f1wmTc5Zr1J2l5ojlUDDvfQxGWgMCFXzkRiVQ6L8mFCDhu8cSU3KKqNrviDo+XnFVelogE6CTv
	obuSP+z0W0u1Bjby/GgoKiOAXXbH5dm/l8s7xf0eCO01dGVMEa8kbk/69x2u7zQTA6Ktcl48Kze
	s29PI77BsG7V9VX7DmdcqEw==
X-Received: by 2002:a05:6000:230c:b0:47f:d0fb:ea33 with SMTP id ffacd0b85a97d-47fd72c482bmr28366667f8f.20.1785774673317;
        Mon, 03 Aug 2026 09:31:13 -0700 (PDT)
X-Received: by 2002:a05:6000:230c:b0:47f:d0fb:ea33 with SMTP id ffacd0b85a97d-47fd72c482bmr28366554f8f.20.1785774672765;
        Mon, 03 Aug 2026 09:31:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm33181044f8f.34.2026.08.03.09.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:31:12 -0700 (PDT)
Date: Mon, 3 Aug 2026 12:31:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, danielj@nvidia.com
Subject: Re: [PATCH net-next v21 09/13] virtio_net: Use existing classifier
 if possible
Message-ID: <20260803123058-mutt-send-email-mst@kernel.org>
References: <20260803140721.1871678-1-shshitrit@nvidia.com>
 <20260803140721.1871678-10-shshitrit@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803140721.1871678-10-shshitrit@nvidia.com>

On Mon, Aug 03, 2026 at 05:07:17PM +0300, Shahar Shitrit wrote:
> From: Daniel Jurgens <danielj@nvidia.com>
> 
> Classifiers can be used by more than one rule. If there is an existing
> classifier, use it instead of creating a new one. If duplicate
> classifiers are created it would artifically limit the number of rules

artificially

> to the classifier limit, which is likely less than the rules limit.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 51 ++++++++++++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2540b9a23e5b..cfcbd8bcd550 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -33,6 +33,7 @@
>  #include <uapi/linux/virtio_pci.h>
>  #include <uapi/linux/virtio_net_ff.h>
>  #include <linux/xarray.h>
> +#include <linux/refcount.h>
>  
>  static int napi_weight = NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -303,7 +304,6 @@ struct virtnet_ff {
>  	struct virtio_net_ff_cap_mask_data *ff_mask;
>  	struct virtio_net_ff_actions *ff_actions;
>  	struct xarray classifiers;
> -	int num_classifiers;
>  	struct virtnet_ethtool_ff ethtool;
>  };
>  
> @@ -5718,12 +5718,13 @@ struct virtnet_ethtool_rule {
>  /* The classifier struct must be the last field in this struct */
>  struct virtnet_classifier {
>  	size_t size;
> +	refcount_t refcount;
>  	u32 id;
> -	struct virtio_net_resource_obj_ff_classifier classifier;
> +	struct virtio_net_resource_obj_ff_classifier obj;
>  };
>  
>  static_assert(sizeof(struct virtnet_classifier) ==
> -	      ALIGN(offsetofend(struct virtnet_classifier, classifier),
> +	      ALIGN(offsetofend(struct virtnet_classifier, obj),
>  		    __alignof__(struct virtnet_classifier)),
>  	      "virtnet_classifier: classifier must be the last member");
>  
> @@ -5811,11 +5812,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
>  	return false;
>  }
>  
> -static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
> +static int setup_classifier(struct virtnet_ff *ff,
> +			    struct virtnet_classifier **c)
>  {
> +	struct virtnet_classifier *tmp;
> +	unsigned long i;
>  	int err;
>  
> -	err = xa_alloc(&ff->classifiers, &c->id, c,
> +	xa_for_each(&ff->classifiers, i, tmp) {
> +		if ((*c)->size == tmp->size &&
> +		    !memcmp(&tmp->obj, &(*c)->obj, tmp->size)) {
> +			refcount_inc(&tmp->refcount);
> +			kfree(*c);
> +			*c = tmp;
> +			goto out;
> +		}
> +	}
> +
> +	err = xa_alloc(&ff->classifiers, &(*c)->id, *c,
>  		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
>  		       GFP_KERNEL);
>  	if (err)
> @@ -5823,29 +5837,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
>  
>  	err = virtio_admin_obj_create(ff->vdev,
>  				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
> -				      c->id,
> +				      (*c)->id,
>  				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
>  				      0,
> -				      &c->classifier,
> -				      c->size);
> +				      &(*c)->obj,
> +				      (*c)->size);
>  	if (err)
>  		goto err_xarray;
>  
> +	refcount_set(&(*c)->refcount, 1);
> +out:
>  	return 0;
>  
>  err_xarray:
> -	xa_erase(&ff->classifiers, c->id);
> +	xa_erase(&ff->classifiers, (*c)->id);
>  
>  	return err;
>  }
>  
> -static void destroy_classifier(struct virtnet_ff *ff,
> -			       u32 classifier_id)
> +static void try_destroy_classifier(struct virtnet_ff *ff, u32 classifier_id)
>  {
>  	struct virtnet_classifier *c;
>  
>  	c = xa_load(&ff->classifiers, classifier_id);
> -	if (c) {
> +	if (c && refcount_dec_and_test(&c->refcount)) {
>  		virtio_admin_obj_destroy(ff->vdev,
>  					 VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
>  					 c->id,
> @@ -5869,7 +5884,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
>  				 0);
>  
>  	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
> -	destroy_classifier(ff, eth_rule->classifier_id);
> +	try_destroy_classifier(ff, eth_rule->classifier_id);
>  	kfree(eth_rule);
>  }
>  
> @@ -6047,7 +6062,7 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	}
>  
>  	c->size = classifier_size;
> -	classifier = &c->classifier;
> +	classifier = &c->obj;
>  	classifier->count = num_hdrs;
>  	selector = (void *)&classifier->selectors[0];
>  
> @@ -6057,14 +6072,16 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	if (err)
>  		goto err_classifier;
>  
> -	err = setup_classifier(ff, c);
> +	err = setup_classifier(ff, &c);
>  	if (err)
>  		goto err_classifier;
>  
>  	err = insert_rule(ff, eth_rule, c->id, key, key_size);
>  	if (err) {
> -		/* destroy_classifier will free the classifier */
> -		destroy_classifier(ff, c->id);
> +		/* try_destroy_classifier will decrement the refcount on the
> +		 * classifier and free it if needed.
> +		 */
> +		try_destroy_classifier(ff, c->id);
>  		goto err_key;
>  	}
>  
> -- 
> 2.49.0

