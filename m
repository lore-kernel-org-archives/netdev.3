Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7972C2D29C8;
	Fri, 31 Jul 2026 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785461242; cv=none; b=VAoA14d729I89fI+lclTkrsX51sgcm18zx5mOfR8J9ue2UhaZNUEr9K0pYosaSdCjuJtPs08O5UFtvi1nVzblo0izRnGugjqdXhDLaYgXWgAAeMtlc5N0N6yw/gJyjQrITU1fxzXbreRxMZb9RHtyf8HAwR417eZbbdDctucXUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785461242; c=relaxed/simple;
	bh=Fs4C3vVbQUMm9+e/1pNnlPcmhRle5K3ksEsEbmmBE5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGgwxq8i703vwvNCjHos6RMBcBZbkFAklcJT1DoU19dwWSvTFCI4BDTX/baCmPFF4ZQFXFxSOciVaOyyYjy382VvPUI/2G+ImM/H2G93I3cvEu/6q+0AlAVIitn/WpqgSOaMNzAZ/vWylE0qyiZkZGjmN7A8YL7IssxfUJu+oIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foXJBBLd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foXJBBLd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FEC1F000E9;
	Fri, 31 Jul 2026 01:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785461239;
	bh=8mOQId4nJjQpSHjOIhtnJr7zm8EPmQIy9APsuck10dM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=foXJBBLdujJiz/wL9/3Zh4ArvZayuZ6q2gj5XVuowIs6k+ClKi0KuRYBDsHyj3MyL
	 3opzLXy6xVcgUD9FKR0D3STFcByxHNaK6adrFrNoZwxnqJ9hN72MkWzu0vIY8NDIGs
	 nZ2qF+pqZUj9eS9Oj1hKapxGXPh/tdBlKRt7+dtmOodktzJ+MzJH1MXMZaZCAL2AXY
	 0pKWxB0PXkq13vrg37GnAbqo/2HKVHHCUUKoyEqcpObI/RxDTjF2cC4bE0RLAJzVix
	 l0Dirx5Si4IBe8b7AuwlxYEUE8a09pdopxyQv0X+Zb2ATFR3p/yInjqv4yTmMaYHYU
	 28OAPs8CJkjvQ==
Date: Thu, 30 Jul 2026 18:27:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v22 net-next 04/12] net/nebula-matrix: add channel layer
Message-ID: <20260730182718.7b85ca1f@kernel.org>
In-Reply-To: <20260723040110.91410-5-illusion.wang@nebula-matrix.com>
References: <20260723040110.91410-1-illusion.wang@nebula-matrix.com>
	<20260723040110.91410-5-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 12:00:56 +0800 illusion.wang wrote:
> +#define FNV_PRIME_32 0x01000193
> +#define FNV_OFFSET_32 0x811C9DC5
> +static u32 nbl_common_calc_hash_key(void *key, u32 key_size, u32 bucket_size)
> +{
> +	u32 hash = FNV_OFFSET_32;
> +	u8 *p = (u8 *)key;
> +	u32 i;
> +
> +	if (bucket_size == 0 || bucket_size == NBL_HASH_TBL_LIST_BUCKET_SIZE)
> +		return 0;
> +
> +	for (i = 0; i < key_size; i++) {
> +		hash ^= p[i];
> +		hash *= FNV_PRIME_32;
> +	}
> +	/* Use bitmask if bucket_size is a power of 2 */
> +	if ((bucket_size & (bucket_size - 1)) == 0)
> +		return hash & (bucket_size - 1);
> +	else
> +		return hash % bucket_size;
> +}

Why are you implementing your own hashing function and your own hash
table? Can't one of existing implementations in the kernel be used?

> +int nbl_common_alloc_hash_node(struct nbl_hash_tbl_mgt *tbl_mgt, void *key,
> +			       void *data, void **out_data)
> +{
> +	struct nbl_hash_entry_node *hash_node;
> +	u16 data_size;
> +	u32 hash_val;
> +	u16 key_size;
> +
> +	hash_node = devm_kzalloc(tbl_mgt->tbl_key.dev, sizeof(*hash_node),
> +				 GFP_KERNEL);

Don't use devm_ for inherently dynamically allocated memory...

> +static void nbl_common_detach_hash_node(struct nbl_hash_tbl_mgt *tbl_mgt,
> +					struct nbl_hash_entry_node *hash_node)
> +{
> +	hlist_del(&hash_node->node);
> +	devm_kfree(tbl_mgt->tbl_key.dev, hash_node->key);
> +	devm_kfree(tbl_mgt->tbl_key.dev, hash_node->data);
> +	devm_kfree(tbl_mgt->tbl_key.dev, hash_node);

... if you ever have to explicitly free something, chances are you
shouldn't be using devm_ in the first place.

> index 7ae331959ca1..d6b7bfff3cc6 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
> @@ -11,23 +11,34 @@
>  #include "nbl_include/nbl_def_common.h"
>  
>  struct nbl_hw_mgt;
> +struct nbl_hw_ops_tbl;
> +struct nbl_channel_ops_tbl;
> +struct nbl_channel_mgt;
>  

Lots of unnecessary forward declarations.
Using type as a member implicitly forward declares.

>  struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
>  				  struct nbl_init_param *param);
>  void nbl_core_remove(struct nbl_adapter *adapter);
> +
>  #endif

This chunk should be squashed into an earlier patch

> +#define NBL_CHAN_SEND(chan_send, dst_id, mesg_type, argument, arg_length,\
> +		      response, resp_length, need_ack)			\
> +do {									\
> +	typeof(chan_send)	*__chan_send = &(chan_send);		\
> +	__chan_send->dstid	= (dst_id);				\
> +	__chan_send->msg_type	= (mesg_type);				\
> +	__chan_send->arg	= (argument);				\
> +	__chan_send->arg_len	= (arg_length);				\
> +	__chan_send->resp	= (response);				\
> +	__chan_send->resp_len	= (resp_length);			\
> +	__chan_send->ack	= (need_ack);				\
> +} while (0)
> +
> +#define NBL_CHAN_ACK(chan_ack, dst_id, mesg_type, msg_id, err_code, ack_data, \
> +		     data_length)					\
> +do {									\
> +	typeof(chan_ack)	*__chan_ack = &(chan_ack);		\
> +	__chan_ack->dstid	= (dst_id);				\
> +	__chan_ack->msg_type	= (mesg_type);				\
> +	__chan_ack->msgid	= (msg_id);				\
> +	__chan_ack->err		= (err_code);				\
> +	__chan_ack->data	= (ack_data);				\
> +	__chan_ack->data_len	= (data_length);			\
> +} while (0)
> +

Why are these macros and not C code?
You only seem to pass struct nbl_chan_ack_info into NBL_CHAN_ACK()

> +struct nbl_hash_tbl_mgt;

This forward declaration here makes no sense.
Please look at your patches before you post them.

>  struct nbl_common_info {
>  	struct pci_dev *pdev;
>  	struct device *dev;
> @@ -29,4 +31,19 @@ struct nbl_common_info {
>  	u8 has_net;
>  };
>  
> +struct nbl_hash_tbl_key {

