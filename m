Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969CA49E13F
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303600; cv=none; b=l6E+nscYuXQnd0MlsvFh4i/FbvFUzLRpcaGNZq/TgdMWC0H9JJwRnjvzUdRniTzVtaimp+ORa1INdp0TIpzCiwFcSOL7BdDXQRwA1EL49gifaFTbnDvhVFpPyAZNLrByKU16jFMLT2/HeWpYHJjRw7vUxPByPgC3SNEO1NGCCaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303600; c=relaxed/simple;
	bh=8XmTb/uNthGcBzDVJULJ9GIDRaylUclddVA6bmOT86s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkUa5iK/NMTbX0HfKjqPJ8YatnbtMrhej3BgW2EcO3useb1ibkHN69eu7ouCvqlOMh+f6dy046PWunMk2mtX51rVNKV9BUeu2h9pkkaQgXSVIfuuHHiJTCmYWEO0mD5iMZpIWrO2VUEv3caKOnI2JpWPhl2nSgnQ8r8zHSFbNdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfquB2xX; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfquB2xX"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4f512029e45so2316978b6e.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 09:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791303596; x=1791908396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bVSkC26N/T0p18ivdrFVUCv/Svi1LvWIFBSx/DqrMHI=;
        b=YfquB2xX7GFunjbYOTonCHvh+NgjSqhvPhcTUpcfni4AsdIQzR7RRFhsa1QDh166Vh
         1+BQXgK/iYetwg3AG5mtWqRkworQNoKWc9EZADDjI4rFZhOr2041zDA3VgPt/emaLsyS
         uzz1d4ZAlUqnyC95rzyc8XQcou8zGIAtq+DbIPCZt0Cfq/bMuJIrPO+UTFRpjMaVMwpm
         rIBd7/djQRfs8H+DkKLutfVJLueuThI3vuZvPbXz9wxbO75Yc+tis0rms2unGEq9G18b
         6cJHUv8yA3SX6TljboPmKSVsHyv/93Q/IaVSdlF3mGKQwPrahFUhlvCeZ0yUp24PBpjY
         ELSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791303596; x=1791908396;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bVSkC26N/T0p18ivdrFVUCv/Svi1LvWIFBSx/DqrMHI=;
        b=CS4bhriJR7WY0uVBpC/0WxFPQMRn+3fFSE6yrLvV7S9V17u/8RMQlVZ7hS8Cv6akM5
         k0rtAoDRZhcxVdDl2boHpxeW4HTJA6CQNZsrNZGTaeZ6zo5bVra1LRtHpH4g8PKCPUmx
         z3rA9Z7Jqs655XFXvnxhab6XiVAM8oIa5jX+P6hOsALNkpXsXSmQTfvE3xj2SdO830we
         OnIms9t1vmbZQlPYiFOd9ICdxDUoJj4ra+5hSqG8+KzwHTjbgttt/RQcGXorU7+zdMBr
         E1EpscGgaHOKrwtHsx6WJR+HFaARqk0Le1c33bNHiJC1vhQovQEP3aADcw7zPs2oThg5
         Y2KQ==
X-Gm-Message-State: AFuF++nv+3kamazJfc6eEtZVPbPF8FK+1ULDlMSWvqJ5rQb7pKF6DcNd
	xN4Ymml/RzPXVYAObFQAWba+y9vZTcEbl+Nho7vp0DQRQ9X4m37hCJxT
X-Gm-Gg: AYBFou1Rk4zq1xOZR3h/KbRJx+uIXHyaSXfliwT/34TnBeAYHumVxqPdGX40epAsm+B
	3R0tQeQTitUUvtADeFr4gKIZa23nHgtoRgcz1tDck/yYUM4dPRgrH6LL9dwZuav2G1CBe5fdRtK
	YA8TNp2HKJL2KEnkOxcDtVGmnZSdvNmaqIJUTN725PEVzFUkxLCVrWlIbYcreE4nkg8xD2DeIId
	T42LZp1sTm5Uzfg2DnuAi2/StZL3Eyj2cE7FFOz0bAFmlcA1vlb9Rnc1vrU2vQtREDrh/TaTYcN
	YZx0UMn6WXESlF+hZ4PAQYZHKrgdsSz/YtTW5Q8Lzvkwwz+umzTRI0qER3V/CrA8so81Pa9ujQ3
	hS+oLwkSQIBircIy/6v3B4H5rkGyycCUawF6DvQtwkzIxH+NYSxdjTILHpc4w6lqcialKoC5pQb
	NQe/OO418OOB9G8Op9bqXc2o4PU6oLSwx5WRwuKPTR6uFhuTXHjea2GSNBEsBpckiBy1Jbofxeq
	lp4DbruaLzY4Va7ETc=
X-Received: by 2002:a05:6808:f88:b0:4cb:abff:3db9 with SMTP id 5614622812f47-4f67703d731mr10612896b6e.9.1791303596128;
        Tue, 06 Oct 2026 09:19:56 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4fc1eb376absm52192b6e.10.2026.10.06.09.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 09:19:55 -0700 (PDT)
Date: Tue, 6 Oct 2026 09:19:49 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Kaifeng Wang <kaifengw@google.com>
Cc: netdev@vger.kernel.org, almasrymina@google.com, edumazet@google.com,
	pabeni@redhat.com, willemb@google.com, davem@davemloft.net,
	kuba@kernel.org, horms@kernel.org, sdf@fomichev.me,
	bobbyeshleman@meta.com, kaiyuanz@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: devmem: check uid and netns in
 net_devmem_get_binding()
Message-ID: <asUfpfngzZGlpkaC@devvm29614.prn0.facebook.com>
References: <20261005210403.3206872-1-kaifengw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005210403.3206872-1-kaifengw@google.com>

On Mon, Oct 05, 2026 at 09:04:03PM +0000, Kaifeng Wang wrote:
> NETDEV_CMD_BIND_TX is unprivileged, and dmabuf binding IDs are allocated
> from a single global xarray. Currently net_devmem_get_binding() looks up
> the binding by ID without checking whether the sending socket belongs to
> the same user or network namespace that created the binding.
> 
> Record the creating netlink socket's network namespace and UID on the
> binding, and verify both in net_devmem_get_binding() before checking the
> route destination device. Return -EINVAL on mismatch so callers cannot
> distinguish non-existent IDs from bindings owned by other users.
> 
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Signed-off-by: Kaifeng Wang <kaifengw@google.com>
> ---
>  net/core/devmem.c      | 7 ++++++-
>  net/core/devmem.h      | 5 +++++
>  net/core/netdev-genl.c | 5 +++--
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index f4d60654ce7f..9a773b1ce92d 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -191,6 +191,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  		       enum dma_data_direction direction,
>  		       unsigned int dmabuf_fd, unsigned int niov_shift,
>  		       struct netdev_nl_sock *priv,
> +		       const struct sock *nl_sk,
>  		       struct netlink_ext_ack *extack)
>  {
>  	struct net_devmem_dmabuf_binding *binding;
> @@ -220,6 +221,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  
>  	binding->dev = dev;
>  	binding->vdev = vdev;
> +	write_pnet(&binding->net, sock_net(nl_sk));
> +	binding->uid = sk_uid(nl_sk);
>  	binding->niov_shift = niov_shift;
>  	xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
>  
> @@ -390,7 +393,9 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
>  	int err = 0;
>  
>  	binding = net_devmem_lookup_dmabuf(dmabuf_id);
> -	if (!binding || !binding->tx_vec) {
> +	if (!binding || !binding->tx_vec ||
> +	    !net_eq(sock_net(sk), read_pnet(&binding->net)) ||
> +	    !uid_eq(sk_uid(sk), binding->uid)) {
>  		err = -EINVAL;
>  		goto out_err;
>  	}
> diff --git a/net/core/devmem.h b/net/core/devmem.h
> index 4a293a7d1149..7b9d3e04367c 100644
> --- a/net/core/devmem.h
> +++ b/net/core/devmem.h
> @@ -10,6 +10,7 @@
>  #ifndef _NET_DEVMEM_H
>  #define _NET_DEVMEM_H
>  
> +#include <net/net_namespace.h>
>  #include <net/netmem.h>
>  #include <net/netdev_netlink.h>
>  
> @@ -26,6 +27,8 @@ struct net_devmem_dmabuf_binding {
>  	 * dereferenced.
>  	 */
>  	void *vdev;
> +	possible_net_t net;
> +	kuid_t uid;
>  	struct gen_pool *chunk_pool;
>  	/* Protect dev */
>  	struct mutex lock;
> @@ -97,6 +100,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  		       enum dma_data_direction direction,
>  		       unsigned int dmabuf_fd, unsigned int niov_shift,
>  		       struct netdev_nl_sock *priv,
> +		       const struct sock *nl_sk,
>  		       struct netlink_ext_ack *extack);
>  struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id);
>  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
> @@ -181,6 +185,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  		       unsigned int dmabuf_fd,
>  		       unsigned int niov_shift,
>  		       struct netdev_nl_sock *priv,
> +		       const struct sock *nl_sk,
>  		       struct netlink_ext_ack *extack)
>  {
>  	return ERR_PTR(-EOPNOTSUPP);
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 33b9f4eb9565..847814e3df3f 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -1094,7 +1094,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  
>  	binding = net_devmem_bind_dmabuf(netdev, NULL, dma_dev, DMA_FROM_DEVICE,
>  					 dmabuf_fd, niov_shift, priv,
> -					 info->extack);
> +					 NETLINK_CB(skb).sk, info->extack);
>  	if (IS_ERR(binding)) {
>  		err = PTR_ERR(binding);
>  		goto err_rxq_bitmap;
> @@ -1243,7 +1243,8 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>  	binding = net_devmem_bind_dmabuf(bind_dev,
>  					 bind_dev != netdev ? netdev : NULL,
>  					 dma_dev, DMA_TO_DEVICE, dmabuf_fd,
> -					 PAGE_SHIFT, priv, info->extack);
> +					 PAGE_SHIFT, priv, NETLINK_CB(skb).sk,
> +					 info->extack);
>  	if (IS_ERR(binding)) {
>  		err = PTR_ERR(binding);
>  		goto err_unlock_bind_dev;
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
