Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB9379C43
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774643; cv=none; b=UdPTYGGPxjaMtK06JfLaCGNm2XozsKswBs5v4lGrFrPwcT0arJQv12HPEr5ePABiXOsE0CVf0s5GallHz5a69MNDJGvUCNEwddSI0ksDvGDVm/xrgqkb4zZwZcfZ9A62zz9vCm0C8CWA0F7H6XGgwN0QaKfmbzTmLJizQ9Tkl/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774643; c=relaxed/simple;
	bh=FH6u0ZqIO6N0HR4J3dgoA+GAj2MWoJtB76Y7h1DJ5Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTTNLJoFbWP6xBAvHNMUr1mYWE4HQXQb/4rFGHqG3atCeCxlI1UlMxs1Au1lIy+Yau+KBNhUHpF6cg66giIC1mKcoJRR9iF0f5nujNYykkwbuSlvJlRM6LrwdbZFnekJhlRmqScY/xXEJVb/2K1YvYQmdSvEAAhqXDE7yAn6jdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/kTzg7u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rAhxbLEq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/kTzg7u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rAhxbLEq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785774640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qWQ+1q8EeDtmybLAmLTofYXMu96kyU0p7L8VbHb+ITA=;
	b=Q/kTzg7ugvnVPiSrj6kjQEq8Ni1vKMtyxaH/QYZIm+cqYBjidkxZoYd2TwKZe7tiTIioow
	spBIu3oVa0fC3PfqANB2I677B3i5y9ypcfTCuxnoc41Sf33asy+XziDVZJQqyegVnxUlz7
	c2fMOTzclZbkL50o1MXANe9triDrtsY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-zgavcd5LM5WZD8_Q0b3VXw-1; Mon, 03 Aug 2026 12:30:39 -0400
X-MC-Unique: zgavcd5LM5WZD8_Q0b3VXw-1
X-Mimecast-MFC-AGG-ID: zgavcd5LM5WZD8_Q0b3VXw_1785774638
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso17079275e9.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 09:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785774638; x=1786379438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qWQ+1q8EeDtmybLAmLTofYXMu96kyU0p7L8VbHb+ITA=;
        b=rAhxbLEqbo8KjFPx5QnOyWQfIOVD4OtfAzAamlOl6YqIGZYcx8mI4njtddhhLi9Vtm
         t4PtpypfZQpWX6rw+Q0B2fHuul+MFlnMajat5Gxqg1dxym7BhEh3n6jFUMJxMWWXn+Uk
         QAin+zycemHvdvsQNjVTeXSg2m8RoDfsLyCpjL4TQ+tZbrE/mayMRp//opBRKIcBOLwJ
         O9byW6GqH9YZeerIR7gxFGNQt0ZBLpJ92wUmtwJCYuczhXkNHkk1WlSPe+hyhkpSTwyP
         kkUbCoUs/oQA1+NdjRdMNIEKrivFg+aRUGzy0WpKwHjrO3t0PVJ2riJG3dMeIYmIiZ6/
         ZRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785774638; x=1786379438;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qWQ+1q8EeDtmybLAmLTofYXMu96kyU0p7L8VbHb+ITA=;
        b=NtsbhnoI5REXCftltDctGvIhdTlHKYA/0UfS25UM7jEghN3TQo1VlGe0j5RN59/e1I
         rrYLhHA94toGXHYRRMtH42lSxln7DmssdMBUWmErvJUrnh3L2Sjq2E0OvpksLdE4MVYx
         snqoMM7DaBsc0TxEpmvYMawevSxJj/y6RjzecUE8ducJO5jQra76jz03ar3FmqQEQf6H
         xvcsUyepe9aULrKkZYqPH8FfMqN9CFuw2pZ9D9bSF1YV9/sGHPXSge/iD2Y0XGQCCFtV
         JdI4jj+/oZHXsvmOhvQh/hBDKP8MIcfJckb4yCAY2QWQXIqZnS5akCJ48RzPYMX7WoOl
         5jpw==
X-Gm-Message-State: AOJu0YxxgUzOAaXWiulkUn3ZlsWOXMKvLKH4wb1lbNsYRxMvQ0xTOzqc
	CMNDjkGSCkWEbcGy4ePLOuVzkq8vyNBr0R2dNU36ioKFewg7Wkt93xesyIrkHC9jDwjkHDScHw7
	32O9mLp5W6DuRzvSMGfSSuHAStui7JuMXfFvWRjSqhYQnxQ55XOvTjVeWNQ==
X-Gm-Gg: AR+sD13X9ZO5FmDzc8DWNGLs8y4zoyN1cSPbkhSzuEPtQi7RuisO+rXw7txftcySJPC
	CE+Q9peo4pGPy5ddSydCRvEf+179mPE2sudda7zPAv2gpjv4pMAqT2tpGzd/TR+/dl8Ax6pyAfh
	CuwmFoziswWNDTCGlhPFyUArHg/o0gIIaqHUZ26Z7uvp0zVyID9sX7ulmHgixK5dQOVYLvqyS4e
	LeIZ9IdAMBIug204N2pfkOGgB1m0M2VdDiPrYd+UwlKkOFjG2tGboyCWVKHqCupCuQmarGfYotG
	eivWdtUHTvfiJxYnubSpQcPKoRaYaNLtnfa2KLBkiz+S1p7oKo56yIRjyVxyK3qkm2Qdn9NuxGV
	dp+1S36yD8OWO1Yd7ev09KQ==
X-Received: by 2002:a05:600c:4e90:b0:495:7426:c392 with SMTP id 5b1f17b1804b1-4980eb4d5f9mr198339325e9.1.1785774637847;
        Mon, 03 Aug 2026 09:30:37 -0700 (PDT)
X-Received: by 2002:a05:600c:4e90:b0:495:7426:c392 with SMTP id 5b1f17b1804b1-4980eb4d5f9mr198338345e9.1.1785774637229;
        Mon, 03 Aug 2026 09:30:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fe742936csm3515001f8f.31.2026.08.03.09.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:30:36 -0700 (PDT)
Date: Mon, 3 Aug 2026 12:30:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, danielj@nvidia.com
Subject: Re: [PATCH net-next v21 08/13] virtio_net: Implement layer 2 ethtool
 flow rules
Message-ID: <20260803122746-mutt-send-email-mst@kernel.org>
References: <20260803140721.1871678-1-shshitrit@nvidia.com>
 <20260803140721.1871678-9-shshitrit@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803140721.1871678-9-shshitrit@nvidia.com>

On Mon, Aug 03, 2026 at 05:07:16PM +0300, Shahar Shitrit wrote:
> From: Daniel Jurgens <danielj@nvidia.com>
> 
> Filtering a flow requires a classifier to match the packets, and a rule
> to filter on the matches.
> 
> A classifier consists of one or more selectors. There is one selector
> per header type. A selector must only use fields set in the selector
> capability. If partial matching is supported, the classifier mask for a
> particular field can be a subset of the mask for that field in the
> capability.
> 
> The rule consists of a priority, an action and a key. The key is a byte
> array containing headers corresponding to the selectors in the
> classifier.
> 
> This patch implements ethtool rules for ethernet headers.
> 
> Example:
> $ ethtool -U ens9 flow-type ether dst 08:11:22:33:44:54 action 30
> Added rule with ID 1
> 
> The rule in the example directs received packets with the specified
> destination MAC address to rq 30.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/net/virtio_net.c           | 521 +++++++++++++++++++++++++++--
>  include/uapi/linux/virtio_net_ff.h |  50 +++
>  2 files changed, 543 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e11e42583243..2540b9a23e5b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -32,6 +32,7 @@
>  #include <net/ip.h>
>  #include <uapi/linux/virtio_pci.h>
>  #include <uapi/linux/virtio_net_ff.h>
> +#include <linux/xarray.h>
>  
>  static int napi_weight = NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -287,6 +288,11 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
>  	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
>  };
>  
> +struct virtnet_ethtool_ff {
> +	struct xarray rules;
> +	int    num_rules;


this is calculated but never used. was the idea to compare it to
e.g. rules per group limit?

> +};
> +
>  #define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
>  #define VIRTNET_FF_MAX_GROUPS 1
>  
> @@ -296,6 +302,9 @@ struct virtnet_ff {
>  	struct virtio_net_ff_cap_data *ff_caps;
>  	struct virtio_net_ff_cap_mask_data *ff_mask;
>  	struct virtio_net_ff_actions *ff_actions;
> +	struct xarray classifiers;
> +	int num_classifiers;

seems to be unused?

> +	struct virtnet_ethtool_ff ethtool;
>  };
>  
>  #define VIRTNET_Q_TYPE_RX 0
> @@ -5606,34 +5615,6 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
>  	return vi->curr_queue_pairs;
>  }
>  
> -static const struct ethtool_ops virtnet_ethtool_ops = {
> -	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
> -		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
> -	.get_drvinfo = virtnet_get_drvinfo,
> -	.get_link = ethtool_op_get_link,
> -	.get_ringparam = virtnet_get_ringparam,
> -	.set_ringparam = virtnet_set_ringparam,
> -	.get_strings = virtnet_get_strings,
> -	.get_sset_count = virtnet_get_sset_count,
> -	.get_ethtool_stats = virtnet_get_ethtool_stats,
> -	.set_channels = virtnet_set_channels,
> -	.get_channels = virtnet_get_channels,
> -	.get_ts_info = ethtool_op_get_ts_info,
> -	.get_link_ksettings = virtnet_get_link_ksettings,
> -	.set_link_ksettings = virtnet_set_link_ksettings,
> -	.set_coalesce = virtnet_set_coalesce,
> -	.get_coalesce = virtnet_get_coalesce,
> -	.set_per_queue_coalesce = virtnet_set_per_queue_coalesce,
> -	.get_per_queue_coalesce = virtnet_get_per_queue_coalesce,
> -	.get_rxfh_key_size = virtnet_get_rxfh_key_size,
> -	.get_rxfh_indir_size = virtnet_get_rxfh_indir_size,
> -	.get_rxfh = virtnet_get_rxfh,
> -	.set_rxfh = virtnet_set_rxfh,
> -	.get_rxfh_fields = virtnet_get_hashflow,
> -	.set_rxfh_fields = virtnet_set_hashflow,
> -	.get_rx_ring_count = virtnet_get_rx_ring_count,
> -};
> -
>  static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,
>  				       struct netdev_queue_stats_rx *stats)
>  {
> @@ -5729,6 +5710,435 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
>  	.get_base_stats		= virtnet_get_base_stats,
>  };
>  
> +struct virtnet_ethtool_rule {
> +	struct ethtool_rx_flow_spec flow_spec;
> +	u32 classifier_id;
> +};
> +
> +/* The classifier struct must be the last field in this struct */
> +struct virtnet_classifier {
> +	size_t size;
> +	u32 id;
> +	struct virtio_net_resource_obj_ff_classifier classifier;
> +};
> +
> +static_assert(sizeof(struct virtnet_classifier) ==
> +	      ALIGN(offsetofend(struct virtnet_classifier, classifier),
> +		    __alignof__(struct virtnet_classifier)),
> +	      "virtnet_classifier: classifier must be the last member");
> +
> +static bool check_mask_vs_cap(const void *m, const void *c,
> +			      u16 len, bool partial)
> +{
> +	const u8 *mask = m;
> +	const u8 *cap = c;
> +	int i;
> +
> +	for (i = 0; i < len; i++) {
> +		if (partial && ((mask[i] & cap[i]) != mask[i]))
> +			return false;
> +		if (!partial && mask[i] != cap[i])
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +static
> +struct virtio_net_ff_selector *get_selector_cap(const struct virtnet_ff *ff,
> +						u8 selector_type)
> +{
> +	struct virtio_net_ff_selector *sel;
> +	void *buf;
> +	int i;
> +
> +	buf = &ff->ff_mask->selectors;
> +	sel = buf;
> +
> +	for (i = 0; i < ff->ff_mask->count; i++) {
> +		if (sel->type == selector_type)
> +			return sel;
> +
> +		buf += sizeof(struct virtio_net_ff_selector) + sel->length;
> +		sel = buf;
> +	}
> +
> +	return NULL;
> +}
> +
> +static bool validate_eth_mask(const struct virtnet_ff *ff,
> +			      const struct virtio_net_ff_selector *sel,
> +			      const struct virtio_net_ff_selector *sel_cap)
> +{
> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
> +	struct ethhdr *cap, *mask;
> +	struct ethhdr zeros = {};
> +
> +	cap = (struct ethhdr *)&sel_cap->mask;
> +	mask = (struct ethhdr *)&sel->mask;
> +
> +	if (memcmp(&zeros.h_dest, mask->h_dest, sizeof(zeros.h_dest)) &&
> +	    !check_mask_vs_cap(mask->h_dest, cap->h_dest,
> +			       sizeof(mask->h_dest), partial_mask))
> +		return false;
> +
> +	if (memcmp(&zeros.h_source, mask->h_source, sizeof(zeros.h_source)) &&
> +	    !check_mask_vs_cap(mask->h_source, cap->h_source,
> +			       sizeof(mask->h_source), partial_mask))
> +		return false;
> +
> +	if (mask->h_proto &&
> +	    !check_mask_vs_cap(&mask->h_proto, &cap->h_proto,
> +			       sizeof(__be16), partial_mask))
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool validate_mask(const struct virtnet_ff *ff,
> +			  const struct virtio_net_ff_selector *sel)
> +{
> +	struct virtio_net_ff_selector *sel_cap = get_selector_cap(ff, sel->type);
> +
> +	if (!sel_cap)
> +		return false;
> +
> +	switch (sel->type) {
> +	case VIRTIO_NET_FF_MASK_TYPE_ETH:
> +		return validate_eth_mask(ff, sel, sel_cap);
> +	}
> +
> +	return false;
> +}
> +
> +static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
> +{
> +	int err;
> +
> +	err = xa_alloc(&ff->classifiers, &c->id, c,
> +		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
> +		       GFP_KERNEL);
> +	if (err)
> +		return err;
> +
> +	err = virtio_admin_obj_create(ff->vdev,
> +				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
> +				      c->id,
> +				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +				      0,
> +				      &c->classifier,
> +				      c->size);
> +	if (err)
> +		goto err_xarray;
> +
> +	return 0;
> +
> +err_xarray:
> +	xa_erase(&ff->classifiers, c->id);
> +
> +	return err;
> +}
> +
> +static void destroy_classifier(struct virtnet_ff *ff,
> +			       u32 classifier_id)
> +{
> +	struct virtnet_classifier *c;
> +
> +	c = xa_load(&ff->classifiers, classifier_id);
> +	if (c) {
> +		virtio_admin_obj_destroy(ff->vdev,
> +					 VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
> +					 c->id,
> +					 VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +					 0);
> +
> +		xa_erase(&ff->classifiers, c->id);
> +		kfree(c);
> +	}
> +}
> +
> +static void destroy_ethtool_rule(struct virtnet_ff *ff,
> +				 struct virtnet_ethtool_rule *eth_rule)
> +{
> +	ff->ethtool.num_rules--;
> +
> +	virtio_admin_obj_destroy(ff->vdev,
> +				 VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
> +				 eth_rule->flow_spec.location,
> +				 VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +				 0);
> +
> +	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
> +	destroy_classifier(ff, eth_rule->classifier_id);
> +	kfree(eth_rule);
> +}
> +
> +static int insert_rule(struct virtnet_ff *ff,
> +		       struct virtnet_ethtool_rule *eth_rule,
> +		       u32 classifier_id,
> +		       const u8 *key,
> +		       u8 key_size)
> +{
> +	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
> +	struct virtio_net_resource_obj_ff_rule *ff_rule;
> +	int err;
> +
> +	ff_rule = kzalloc(sizeof(*ff_rule) + key_size, GFP_KERNEL);
> +	if (!ff_rule)
> +		return -ENOMEM;
> +
> +	/* Intentionally leave the priority as 0. All rules have the same
> +	 * priority.
> +	 */
> +	ff_rule->group_id = cpu_to_le32(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
> +	ff_rule->classifier_id = cpu_to_le32(classifier_id);
> +	ff_rule->key_length = key_size;
> +	ff_rule->action = fs->ring_cookie == RX_CLS_FLOW_DISC ?
> +					     VIRTIO_NET_FF_ACTION_DROP :
> +					     VIRTIO_NET_FF_ACTION_RX_VQ;
> +	ff_rule->vq_index = fs->ring_cookie != RX_CLS_FLOW_DISC ?
> +					       cpu_to_le16(rxq2vq(fs->ring_cookie)) : 0;
> +	memcpy(&ff_rule->keys, key, key_size);
> +
> +	err = virtio_admin_obj_create(ff->vdev,
> +				      VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
> +				      fs->location,
> +				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +				      0,
> +				      ff_rule,
> +				      sizeof(*ff_rule) + key_size);
> +	if (err)
> +		goto err_ff_rule;
> +
> +	eth_rule->classifier_id = classifier_id;
> +	ff->ethtool.num_rules++;
> +	kfree(ff_rule);
> +	kfree(key);
> +
> +	return 0;
> +
> +err_ff_rule:
> +	kfree(ff_rule);
> +
> +	return err;
> +}
> +
> +static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
> +{
> +	switch (fs->flow_type) {
> +	case ETHER_FLOW:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int validate_flow_input(struct virtnet_ff *ff,
> +			       const struct ethtool_rx_flow_spec *fs,
> +			       u16 curr_queue_pairs)
> +{
> +	u8 required_action = fs->ring_cookie == RX_CLS_FLOW_DISC ?
> +			     VIRTIO_NET_FF_ACTION_DROP :
> +			     VIRTIO_NET_FF_ACTION_RX_VQ;
> +	int i;
> +
> +	/* Force users to use RX_CLS_LOC_ANY - don't allow specific locations */
> +	if (fs->location != RX_CLS_LOC_ANY)
> +		return -EOPNOTSUPP;
> +
> +	if (fs->ring_cookie != RX_CLS_FLOW_DISC &&
> +	    fs->ring_cookie >= curr_queue_pairs)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ff->ff_actions->count; i++)
> +		if (ff->ff_actions->actions[i] == required_action)
> +			goto action_ok;
> +	return -EOPNOTSUPP;
> +
> +action_ok:
> +	if (fs->flow_type != ethtool_flow_type_mask(fs->flow_type))
> +		return -EOPNOTSUPP;
> +
> +	if (!supported_flow_type(fs))
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
> +static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
> +				 u8 *key_size, size_t *classifier_size,
> +				 int *num_hdrs)
> +{
> +	*num_hdrs = 1;
> +	*key_size = sizeof(struct ethhdr);
> +	/*
> +	 * The classifier size is the size of the classifier header, a selector
> +	 * header for each type of header in the match criteria, and each header
> +	 * providing the mask for matching against.
> +	 */
> +	*classifier_size = *key_size +
> +			   sizeof(struct virtio_net_resource_obj_ff_classifier) +
> +			   sizeof(struct virtio_net_ff_selector) * (*num_hdrs);
> +}
> +
> +static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
> +				   u8 *key,
> +				   const struct ethtool_rx_flow_spec *fs)
> +{
> +	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
> +	struct ethhdr *eth_k = (struct ethhdr *)key;
> +
> +	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
> +	selector->length = sizeof(struct ethhdr);
> +
> +	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
> +	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
> +}
> +
> +static int
> +validate_classifier_selectors(struct virtnet_ff *ff,
> +			      struct virtio_net_resource_obj_ff_classifier *classifier,
> +			      int num_hdrs)
> +{
> +	struct virtio_net_ff_selector *selector = (void *)classifier->selectors;
> +	int i;
> +
> +	for (i = 0; i < num_hdrs; i++) {
> +		if (!validate_mask(ff, selector))
> +			return -EINVAL;
> +
> +		selector = (((void *)selector) + sizeof(*selector) +
> +					selector->length);
> +	}
> +
> +	return 0;
> +}
> +
> +static int build_and_insert(struct virtnet_ff *ff,
> +			    struct virtnet_ethtool_rule *eth_rule)
> +{
> +	struct virtio_net_resource_obj_ff_classifier *classifier;
> +	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
> +	struct virtio_net_ff_selector *selector;
> +	struct virtnet_classifier *c;
> +	size_t classifier_size;
> +	int num_hdrs;
> +	u8 key_size;
> +	u8 *key;
> +	int err;
> +
> +	calculate_flow_sizes(fs, &key_size, &classifier_size, &num_hdrs);
> +
> +	key = kzalloc(key_size, GFP_KERNEL);
> +	if (!key)
> +		return -ENOMEM;
> +
> +	/*
> +	 * virtio_net_ff_obj_ff_classifier is already included in the
> +	 * classifier_size.
> +	 */
> +	c = kzalloc(classifier_size +
> +		    sizeof(struct virtnet_classifier) -
> +		    sizeof(struct virtio_net_resource_obj_ff_classifier),
> +		    GFP_KERNEL);
> +	if (!c) {
> +		kfree(key);
> +		return -ENOMEM;
> +	}
> +
> +	c->size = classifier_size;
> +	classifier = &c->classifier;
> +	classifier->count = num_hdrs;
> +	selector = (void *)&classifier->selectors[0];
> +
> +	setup_eth_hdr_key_mask(selector, key, fs);
> +
> +	err = validate_classifier_selectors(ff, classifier, num_hdrs);
> +	if (err)
> +		goto err_classifier;
> +
> +	err = setup_classifier(ff, c);
> +	if (err)
> +		goto err_classifier;
> +
> +	err = insert_rule(ff, eth_rule, c->id, key, key_size);
> +	if (err) {
> +		/* destroy_classifier will free the classifier */
> +		destroy_classifier(ff, c->id);
> +		goto err_key;
> +	}
> +
> +	return 0;
> +
> +err_classifier:
> +	kfree(c);
> +err_key:
> +	kfree(key);
> +
> +	return err;
> +}
> +
> +static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
> +				       struct ethtool_rx_flow_spec *fs,
> +				       u16 curr_queue_pairs)
> +{
> +	struct virtnet_ethtool_rule *eth_rule;
> +	int err;
> +
> +	if (!ff->ff_supported)
> +		return -EOPNOTSUPP;
> +
> +	err = validate_flow_input(ff, fs, curr_queue_pairs);
> +	if (err)
> +		return err;
> +
> +	eth_rule = kzalloc(sizeof(*eth_rule), GFP_KERNEL);
> +	if (!eth_rule)
> +		return -ENOMEM;
> +
> +	err = xa_alloc(&ff->ethtool.rules, &fs->location, eth_rule,
> +		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->rules_limit) - 1),
> +		       GFP_KERNEL);
> +	if (err)
> +		goto err_rule;
> +
> +	eth_rule->flow_spec = *fs;
> +
> +	err = build_and_insert(ff, eth_rule);
> +	if (err)
> +		goto err_xa;
> +
> +	return err;
> +
> +err_xa:
> +	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
> +
> +err_rule:
> +	fs->location = RX_CLS_LOC_ANY;
> +	kfree(eth_rule);
> +
> +	return err;
> +}
> +
> +static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
> +{
> +	struct virtnet_ethtool_rule *eth_rule;
> +	int err = 0;
> +
> +	if (!ff->ff_supported)
> +		return -EOPNOTSUPP;
> +
> +	eth_rule = xa_load(&ff->ethtool.rules, location);
> +	if (!eth_rule) {
> +		err = -ENOENT;
> +		goto out;
> +	}
> +
> +	destroy_ethtool_rule(ff, eth_rule);
> +out:
> +	return err;
> +}
> +
>  static size_t get_mask_size(u16 type)
>  {
>  	switch (type) {
> @@ -5747,6 +6157,50 @@ static size_t get_mask_size(u16 type)
>  	return 0;
>  }
>  
> +static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +
> +	switch (info->cmd) {
> +	case ETHTOOL_SRXCLSRLINS:
> +		return virtnet_ethtool_flow_insert(&vi->ff, &info->fs,
> +						   vi->curr_queue_pairs);
> +	case ETHTOOL_SRXCLSRLDEL:
> +		return virtnet_ethtool_flow_remove(&vi->ff, info->fs.location);
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct ethtool_ops virtnet_ethtool_ops = {
> +	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
> +		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
> +	.get_drvinfo = virtnet_get_drvinfo,
> +	.get_link = ethtool_op_get_link,
> +	.get_ringparam = virtnet_get_ringparam,
> +	.set_ringparam = virtnet_set_ringparam,
> +	.get_strings = virtnet_get_strings,
> +	.get_sset_count = virtnet_get_sset_count,
> +	.get_ethtool_stats = virtnet_get_ethtool_stats,
> +	.set_channels = virtnet_set_channels,
> +	.get_channels = virtnet_get_channels,
> +	.get_ts_info = ethtool_op_get_ts_info,
> +	.get_link_ksettings = virtnet_get_link_ksettings,
> +	.set_link_ksettings = virtnet_set_link_ksettings,
> +	.set_coalesce = virtnet_set_coalesce,
> +	.get_coalesce = virtnet_get_coalesce,
> +	.set_per_queue_coalesce = virtnet_set_per_queue_coalesce,
> +	.get_per_queue_coalesce = virtnet_get_per_queue_coalesce,
> +	.get_rxfh_key_size = virtnet_get_rxfh_key_size,
> +	.get_rxfh_indir_size = virtnet_get_rxfh_indir_size,
> +	.get_rxfh = virtnet_get_rxfh,
> +	.set_rxfh = virtnet_set_rxfh,
> +	.get_rxfh_fields = virtnet_get_hashflow,
> +	.set_rxfh_fields = virtnet_set_hashflow,
> +	.get_rx_ring_count = virtnet_get_rx_ring_count,
> +	.set_rxnfc = virtnet_set_rxnfc,
> +};
> +
>  static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  {
>  	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
> @@ -5909,6 +6363,8 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	if (err)
>  		goto err_ff_action;
>  
> +	xa_init_flags(&ff->classifiers, XA_FLAGS_ALLOC);
> +	xa_init_flags(&ff->ethtool.rules, XA_FLAGS_ALLOC);
>  	ff->vdev = vdev;
>  	ff->ff_supported = true;
>  
> @@ -5933,9 +6389,18 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  
>  static void virtnet_ff_cleanup(struct virtnet_ff *ff)
>  {
> +	struct virtnet_ethtool_rule *eth_rule;
> +	unsigned long i;
> +
>  	if (!ff->ff_supported)
>  		return;
>  
> +	xa_for_each(&ff->ethtool.rules, i, eth_rule)
> +		destroy_ethtool_rule(ff, eth_rule);
> +
> +	xa_destroy(&ff->ethtool.rules);
> +	xa_destroy(&ff->classifiers);
> +
>  	virtio_admin_obj_destroy(ff->vdev,
>  				 VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
>  				 VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
> index b0780e49df9f..9152021c99ba 100644
> --- a/include/uapi/linux/virtio_net_ff.h
> +++ b/include/uapi/linux/virtio_net_ff.h
> @@ -13,6 +13,8 @@
>  #define VIRTIO_NET_FF_ACTION_CAP 0x802
>  
>  #define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
> +#define VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER 0x0201
> +#define VIRTIO_NET_RESOURCE_OBJ_FF_RULE 0x0202
>  
>  /**
>   * struct virtio_net_ff_cap_data - Flow filter resource capability limits
> @@ -103,4 +105,52 @@ struct virtio_net_resource_obj_ff_group {
>  	__le16 group_priority;
>  };
>  
> +/**
> + * struct virtio_net_resource_obj_ff_classifier - Flow filter classifier object
> + * @count: number of selector entries in @selectors
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @selectors: array of selector descriptors that define match masks
> + *
> + * Payload for the VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER administrative object.
> + * Each selector describes a header mask used to match packets
> + * (see struct virtio_net_ff_selector). Selectors appear in the order they are
> + * to be applied.
> + */
> +struct virtio_net_resource_obj_ff_classifier {
> +	__u8 count;
> +	__u8 reserved[7];
> +	__u8 selectors[];
> +};
> +
> +/**
> + * struct virtio_net_resource_obj_ff_rule - Flow filter rule object
> + * @group_id: identifier of the target flow filter group
> + * @classifier_id: identifier of the classifier referenced by this rule
> + * @rule_priority: relative priority of this rule within the group
> + * @key_length: number of bytes in @keys
> + * @action: action to perform, one of VIRTIO_NET_FF_ACTION_*
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @vq_index: RX virtqueue index for VIRTIO_NET_FF_ACTION_RX_VQ, 0 otherwise
> + * @reserved1: must be set to 0 by the driver and ignored by the device
> + * @keys: concatenated key bytes matching the classifier's selectors order
> + *
> + * Payload for the VIRTIO_NET_RESOURCE_OBJ_FF_RULE administrative object.
> + * @group_id and @classifier_id refer to previously created objects of types
> + * VIRTIO_NET_RESOURCE_OBJ_FF_GROUP and VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER
> + * respectively. The key bytes are compared against packet headers using the
> + * masks provided by the classifier's selectors. Multi-byte fields are
> + * little-endian.
> + */
> +struct virtio_net_resource_obj_ff_rule {
> +	__le32 group_id;
> +	__le32 classifier_id;
> +	__u8 rule_priority;
> +	__u8 key_length; /* length of key in bytes */
> +	__u8 action;
> +	__u8 reserved;
> +	__le16 vq_index;
> +	__u8 reserved1[2];
> +	__u8 keys[];
> +};
> +
>  #endif
> -- 
> 2.49.0

