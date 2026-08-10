Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC1239A04D
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 07:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786346315; cv=none; b=qmuauZMqQHwkWlVm4UqKxcahQn7S3ioFg9sGRtHn4Wi8ZXjxCC+R51yITFgLuCpnpo0JXOa4kxdd6QyPxRY2rxyYPuRF8mc38X6WQhPKSZNmuhs7uf7NQS+GTxzkkVJ1YymYcFIlv6K6XNx0qGdElp8ia/k8blvTjwxPh2uJBjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786346315; c=relaxed/simple;
	bh=dZmmtYnK5ZfoMK7fkd8gezFvAqLjWQZtfAN+1DdmHNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIkD0av4s47Ql1ESxpN69/22CxkykWLoYTqyM5gPGOXcz35OWFBWKdwWGA9Hp53p3zXq9Y0dqPNgspemmrfSzqWNoDlsEoSGjq0oBqGTIht7Ju/R37pUEmDoKiJwc598BrsL386goMFbc70l+qhOfTzEvVhHYDemY2jKulSVyrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=neRaPry5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="neRaPry5"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so21743555e9.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786346311; x=1786951111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OZw6DBqMzFtZ7sE+YyKqzNiJoc28YODNR4pO+dPyYsE=;
        b=neRaPry5NCnIYxH5/cdJeLdAlASlW6NG4RlUnG0HMzNzn+cH1QYRlvVP+Nu3Qqvfog
         wdxUL3kBAmr0HXKi0KUI3wIOd8+CI/sNxruZar8ompEJY5XSdVokITAAGVc/JuSwD5Oa
         m7ZjQ5kOtwdNw+irFimS5EdOn9HP6aDM9OPG4K7iifDIx6xx/d49V49mtkwwh8/xLLma
         2mJbaZxZYnFLJQm8J7N1XtUpbNcEiqTskFT1zYloplWbgPovbJbGa7gMZ5CykjrL9x12
         8f/Q40hTBS4E74IOrNbARybQsZTLS3+7uNZu6wrQG+L5GXO2K59VhAPmdOUYa722xp0U
         D47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786346311; x=1786951111;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OZw6DBqMzFtZ7sE+YyKqzNiJoc28YODNR4pO+dPyYsE=;
        b=nlJLAoso5laGwr5Y9OGHzpkPCr7fvMMERZkz6RmAG3X31phh8tO3nfRRPBlx5XKenV
         3aHpjbvxJEujNSdUfM7dVdkQEFw+dp3ZvdxhYPSfEvbcTQ4iUXTi8uF6XRJf3SZBj2Rv
         WDsCe06avsQHwxMqf3HLFDKjqnLcItF2rePM56IwVG1vgWL2XnIOxIS554QR9ejXooOs
         JrIZ4+s82P/iHxGi0jDKhrQdF2Gf6i68eivyvDY7+iCRSXtFIJ7o3/Gbp6UZfpxNh/ON
         vqDyxkvjcmshuIYeX9PQb2NH3KdUvwsu7TEAIqItZD1eaend6iFBvObGP4d/6PTD0jf/
         ZtvQ==
X-Forwarded-Encrypted: i=1; AHgh+RrORCjUBlc01S4Y6MDVqIdi/GftB1PZ3CHtU61q6II6CCQz9lWQ1yVCaBxGyZ6A05iG82RuF5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+SoJtjQqea0Sd1sK/Rj9F/f9XI/jLNr2tQh4Pj4J27pkV9aiK
	MewPywK8KfBn/OHHJFHPI81kjwlQCIiv+ap7TcvTyxdziZduHy8L8YmHbPcCvARjDAM=
X-Gm-Gg: AR+sD13BM58pHrl/jbrAzn4JHfWVcOex07j40ZPpvrEzclQpNuu3rUj7iHUdAzgOKKg
	I387OLYM4hAsh5+NahbHCfBN0UQT1t0AxoMElRmhcOtPyOIh1phtkWUFGPNgmjN8g2gyCXDMu9m
	1bkT/VcVhuNrbP2XSxCqJfR8S0xDUU3h0Hl1E5UaLnUljHDC1g4jBhpj8aUc+KDJQsEz70XEQr1
	jN2/+eL2pJaSOjNqDNGxTYbUUbyg5+zHyq4l/2Mo4nwhFc25L337UlZFCUDvCgzR4eKrO+ToRQr
	DGGbakHruF5tXehW//Pf66FiJT9ngtZ6cRDwPMeYLDH6lv/245w2YqR1V1e2wvCOf8PkQtDTpli
	TEK9Kl7xQmsHZD+c/I752Wfqb8iJtRRprj3SfDn5usZ5tA/n+gYXTX6BUoQUyow8nnXEsVv7waB
	ibZ3C7N2lV4EH/y1DeKpuMBNKp2ztXsHg0nHnGmuo8od9tnBIP+mxqhWPp1WuZyqS310EqtTVBh
	lvWAXkgGj6wiJn/9Rs=
X-Received: by 2002:a05:600c:4e8e:b0:497:ff5a:38b9 with SMTP id 5b1f17b1804b1-4996247e640mr186732625e9.9.1786346311317;
        Mon, 10 Aug 2026 00:18:31 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995428f294sm383337555e9.15.2026.08.10.00.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 00:18:30 -0700 (PDT)
Message-ID: <9cff59e3-247f-463f-8d43-5138eefc18e3@blackwall.org>
Date: Mon, 10 Aug 2026 10:18:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: convert netdev_nl_sock bindings list to xarray
Content-Language: en-US, bg
To: Shivaji Kant <shivajikant@google.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: praan@google.com, Mina Almasry <almasrymina@google.com>,
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Dragos Tatulea <dtatulea@nvidia.com>,
 Kees Cook <kees@kernel.org>, David Carlier <devnexen@gmail.com>,
 Yue Haibing <yuehaibing@huawei.com>, Daniel Borkmann <daniel@iogearbox.net>,
 David Wei <dw@davidwei.uk>, Maoyi Xie <maoyixie.tju@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20260810065759.3735934-1-shivajikant@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260810065759.3735934-1-shivajikant@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/08/2026 09:57, Shivaji Kant wrote:
> netdev_nl_sock previously used a struct list_head bindings to keep
> track of active netdev netlink bindings, protected by a per-socket
> struct mutex lock (priv->lock).
> 
> Since list modifications and iterations are not concurrency-safe,
> priv->lock was introduced to serialize operations on priv->bindings.
> However, xarray manages its own internal locking (xa_lock) for store,
> erase, and iteration operations.
> 
> Convert bindings in struct netdev_nl_sock from struct list_head to
> struct xarray and remove priv->lock. This simplifies the code by
> removing explicit mutex locking in netdev_nl_bind_rx_doit(),
> netdev_nl_bind_tx_doit(), and socket initialization/teardown functions.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Shivaji Kant <shivajikant@google.com>
> ---
>   include/net/netdev_netlink.h |  5 ++---
>   net/core/devmem.c            | 13 ++++++++++---
>   net/core/devmem.h            |  4 ++--
>   net/core/netdev-genl.c       | 25 ++++++-------------------
>   4 files changed, 20 insertions(+), 27 deletions(-)
> 

This patch should target net-next.

> diff --git a/include/net/netdev_netlink.h b/include/net/netdev_netlink.h
> index 075962dbe743..45a4a482d42e 100644
> --- a/include/net/netdev_netlink.h
> +++ b/include/net/netdev_netlink.h
> @@ -2,11 +2,10 @@
>   #ifndef __NET_NETDEV_NETLINK_H
>   #define __NET_NETDEV_NETLINK_H
>   
> -#include <linux/list.h>
> +#include <linux/xarray.h>
>   
>   struct netdev_nl_sock {
> -	struct mutex lock;
> -	struct list_head bindings;
> +	struct xarray bindings;
>   };
>   
>   #endif	/* __NET_NETDEV_NETLINK_H */
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 957d6b96216b..52fda18b80ef 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -134,8 +134,8 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>   	 */
>   	synchronize_net();
>   
> -	if (binding->list.next)
> -		list_del(&binding->list);
> +	if (binding->sock_priv)
> +		xa_erase(&binding->sock_priv->bindings, binding->id);
>   
>   	xa_for_each(&binding->bound_rxqs, xa_idx, rxq) {
>   		const struct pp_memory_provider_params mp_params = {
> @@ -193,6 +193,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>   	struct dma_buf *dmabuf;
>   	unsigned int sg_idx, i;
>   	unsigned long virtual;
> +	void *res;
>   	int err;
>   
>   	if (!dma_dev) {
> @@ -325,7 +326,13 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>   	if (err < 0)
>   		goto err_free_chunks;
>   
> -	list_add(&binding->list, &priv->bindings);
> +	binding->sock_priv = priv;
> +	res = xa_store(&priv->bindings, binding->id, binding, GFP_KERNEL);
> +	if (xa_is_err(res)) {
> +		err = xa_err(res);
> +		xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> +		goto err_free_chunks;

This error cleans up after the previous xa_alloc_cyclic call itself instead
of following the style of the rest of the error cleanups. I'd move the xa_erase()
into its own err_ label and goto there.

> +	}
>   
>   	return binding;
>   
> diff --git a/net/core/devmem.h b/net/core/devmem.h
> index 3852a56036cb..bf77e5a9a8fe 100644
> --- a/net/core/devmem.h
> +++ b/net/core/devmem.h
> @@ -49,10 +49,10 @@ struct net_devmem_dmabuf_binding {
>   	 */
>   	struct percpu_ref ref;
>   
> -	/* The list of bindings currently active. Used for netlink to notify us
> +	/* The socket priv this binding belongs to. Used for netlink to notify us
>   	 * of the user dropping the bind.
>   	 */
> -	struct list_head list;
> +	struct netdev_nl_sock *sock_priv;
>   
>   	/* rxq's this binding is active on. */
>   	struct xarray bound_rxqs;
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index c15d8d4ca1f8..d3f3a91a6d93 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -1044,13 +1044,11 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>   		goto err_genlmsg_free;
>   	}
>   
> -	mutex_lock(&priv->lock);
> -
>   	err = 0;
>   	netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
>   	if (!netdev) {
>   		err = -ENODEV;
> -		goto err_unlock_sock;
> +		goto err_genlmsg_free;
>   	}
>   	if (!netif_device_present(netdev))
>   		err = -ENODEV;
> @@ -1102,8 +1100,6 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>   
>   	netdev_unlock(netdev);
>   
> -	mutex_unlock(&priv->lock);
> -
>   	return err < 0 ? err : 0;
>   
>   err_unbind:
> @@ -1112,8 +1108,6 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>   	bitmap_free(rxq_bitmap);
>   err_unlock:
>   	netdev_unlock(netdev);
> -err_unlock_sock:
> -	mutex_unlock(&priv->lock);
>   err_genlmsg_free:
>   	nlmsg_free(rsp);
>   	return err;
> @@ -1185,12 +1179,10 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>   		goto err_genlmsg_free;
>   	}
>   
> -	mutex_lock(&priv->lock);
> -
>   	netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
>   	if (!netdev) {
>   		err = -ENODEV;
> -		goto err_unlock_sock;
> +		goto err_genlmsg_free;
>   	}
>   
>   	if (!netif_device_present(netdev)) {
> @@ -1233,7 +1225,6 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>   	if (bind_dev != netdev)
>   		netdev_unlock(bind_dev);
>   	netdev_unlock(netdev);
> -	mutex_unlock(&priv->lock);
>   
>   	return genlmsg_reply(rsp, info);
>   
> @@ -1242,8 +1233,6 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>   		netdev_unlock(bind_dev);
>   err_unlock_netdev:
>   	netdev_unlock(netdev);
> -err_unlock_sock:
> -	mutex_unlock(&priv->lock);
>   err_genlmsg_free:
>   	nlmsg_free(rsp);
>   	return err;
> @@ -1418,19 +1407,17 @@ int netdev_nl_queue_create_doit(struct sk_buff *skb, struct genl_info *info)
>   
>   void netdev_nl_sock_priv_init(struct netdev_nl_sock *priv)
>   {
> -	INIT_LIST_HEAD(&priv->bindings);
> -	mutex_init(&priv->lock);
> +	xa_init(&priv->bindings);
>   }
>   
>   void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
>   {
>   	struct net_devmem_dmabuf_binding *binding;
> -	struct net_devmem_dmabuf_binding *temp;
>   	netdevice_tracker dev_tracker;
>   	struct net_device *dev;
> +	unsigned long xa_idx;
>   
> -	mutex_lock(&priv->lock);
> -	list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
> +	xa_for_each(&priv->bindings, xa_idx, binding) {
>   		mutex_lock(&binding->lock);
>   		dev = binding->dev;
>   		if (!dev) {
> @@ -1446,7 +1433,7 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
>   		netdev_unlock(dev);
>   		netdev_put(dev, &dev_tracker);
>   	}
> -	mutex_unlock(&priv->lock);
> +	xa_destroy(&priv->bindings);
>   }
>   
>   static int netdev_genl_netdevice_event(struct notifier_block *nb,

