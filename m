Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BAD361978
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516071; cv=none; b=TrtvZwGU+quMR2d5KrGafZtMjq6lQcf9rpcsBzso+4HQvHTbyoXRTx0n53yc/16LHPWpISUJxPleUPyyBgZplIKMfhibx4pbp/ZG4jJR2N8wNs7pVN/wipczbwySMDSm469zedOgy+GWKGDiPLHX1UepMMKXOzCM0DOZZ49ZvL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516071; c=relaxed/simple;
	bh=xmYCwKC08BYL7lMXr/sMs8VYWdRHpT7NkXW792QlUsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMIfxc2fBB4HokgOT/21CcdhI0J37mf3plGhrQzGOQ3fp7j3epy4MDnMDh8yVnshkCfQ1rgwG9wAnmKSdUKKqpsV2fmMaK9c7vvZXrdDx02YFUbLi1RP16WIMRSw/J7l2WWiDZbxlLKjZ1Wz3IYV0BFoWD/0YT44ULWVHAwjoaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ja+iNjQQ; arc=none smtp.client-ip=74.125.228.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja+iNjQQ"
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cbbc9e6e637so592136a12.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785516069; x=1786120869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=geJgXx5Dm6qqt2ZAAFVL9G2Q6MfkYPKO/H3Ubz8hDvA=;
        b=Ja+iNjQQbEBSVCCDpKvJyinbxRrtjetNKZJD/L+o7dcPkRRnKicLpecdVFEVrzwLAm
         iaVRky3anFqsZXnzsCDLaGL1Cw5mhjJbrBy6fBlVO8bI1v2bYpUJBbMiD5iN6B4A5+0r
         ZrVr6uj4MFdIugiWUjRyAHnJVBjaopWPArLN9RqtTPrjxEnzahhpDqem8D05DEgIQzoi
         kBtTYvL7Q/H8MSi9VdVA5obxDbZjXJknn675SLVOjaRjCshiviLfiO0wB8WIi7of4xT7
         NuX6B2ceOYY9T8L/3f/beYNr+QZzNfJI+nsNVZU4+DlzjG7LisSQ4pHQg9pTgMh+kjfR
         zvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785516069; x=1786120869;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=geJgXx5Dm6qqt2ZAAFVL9G2Q6MfkYPKO/H3Ubz8hDvA=;
        b=OdnweflD2lY5axWiOyaWVcmX5UJvWYCLGqa473XUzvS9mP5q/qMIcMz0DtROewksJ2
         d8AM2mvHR4PrNBQb0nxBqyRLri9Y4vUmecWnIYItqS5vfM803GQCELVn+2yzWtufU5wa
         sq/9j9XTJWdnuf+KX0dth7NQB9IRbhM/91dQsGtoibrw3SKIrhJ9gNrUvsacYHp9iugL
         oeIZVKQPViON4g382XrXNfumeoJc4zmYTzEA1rRpj/mw6WrHtatqMCemWI9pX8/8lv6O
         CsYLKHmu5/40UFoxy5cCbjjigSeqOltxiuWOvUoCKmHlfA5cMZ2xpJMXMPVB3AmUb8Lx
         lTZg==
X-Forwarded-Encrypted: i=1; AHgh+Rr2lz/WERzuFMM+D9uYOv6xFeZmq+6W6PVFgjZysEaovq+dKYSm4bKBzqzSg0gdBqqHbcS7nag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZJNo9ETCPWl6mQW8dlcdzcYa31smYRNFfqPyOLAF4d8C6bwru
	9uWZICQTIsGYeKj3wex1Mm/hQkT2WH72RTJiUa5LVr9LFycOtIvMP1e3
X-Gm-Gg: AR+sD12BiuN9CjFeMLp4AGkuXVCFpnxtrB9nvxn+eM0I5KU+S7sDglSoGMLmqModEha
	oD9K9MFI8PFhxJs9i2u03AEcQQ2bdgq/5ZRuAlXQvHQon9Mu5NeyLyWV5dGH1fNru6nSLGTytWq
	GKF24w+K6UpUuVt2kKIADkY44w2XMmIdrmu4V6Cziokf3bAcXU5vki9luZFrRIVd2HwH0toqEhw
	L65z+p6R2uxwzW9b9M9G9eSyWvLBZj8yEUTzuZ5AX9hCAIcRfBunHzjWL/+Atbvt3UWh1VIeEOI
	EaquLRIdvwJWz5KNZeE7HPmj+3PfJ9D919SvNxQa4LQzDmthnslWo9elhpS4qEK8QTtDWz9NqGI
	1ST+OIAXUuncx9h5qyY8v6dJDGUrW2Zl8RccV8ANDuC0hQk1raAdcl20ETRzLlN03ufbJAnHaow
	aV7NtX65QmtmRYeGb63HC04wXretrQ+hViZ4V6Wy8EPUMTtCN0qApVUw==
X-Received: by 2002:a05:6a00:4fc7:b0:845:4928:8655 with SMTP id d2e1a72fcca58-84ee4899b2dmr323897b3a.39.1785516068847;
        Fri, 31 Jul 2026 09:41:08 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d901csm675606b3a.48.2026.07.31.09.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:41:08 -0700 (PDT)
Date: Fri, 31 Jul 2026 09:41:00 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me, 
	chaitanyak@nvidia.com, gjoyce@linux.ibm.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/4] nvme-tcp: limit I/O queue count based on
 NIC queue count
Message-ID: <amzPvMWfzetiirw0@devvm7509.cco0.facebook.com>
References: <20260731073918.614014-1-nilay@linux.ibm.com>
 <20260731073918.614014-3-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731073918.614014-3-nilay@linux.ibm.com>

On 07/31, Nilay Shroff wrote:
> NVMe-TCP currently provisions I/O queues based primarily on the number
> of online CPUs. On systems where the CPU count significantly exceeds the
> number of NIC hardware queues, multiple NVMe-TCP I/O queues end up
> sharing the same NIC TX/RX queues. This increases lock contention,
> cacheline bouncing, and inter-processor interrupts (IPIs), reducing I/O
> efficiency.
> 
> Limit the number of NVMe-TCP default I/O queues to the smaller of the
> number of online CPUs and the number of NIC hardware queues. Aligning
> the number of NVMe-TCP I/O queues with the NIC queue topology reduces
> queue sharing, improves locality, and can improve throughput while
> reducing tail latency.
> 
> The number of NVMe-TCP I/O queues is now limited to:
> 
>     min(num_online_cpus, num_nic_queues)
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  drivers/nvme/host/tcp.c | 61 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index ba5c7b3e2a7c..a2110287099e 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1774,6 +1774,50 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>  	return ret;
>  }
>  
> +static struct net_device *nvme_tcp_get_netdev(struct nvme_ctrl *ctrl,
> +		netdevice_tracker *tracker, gfp_t gfp)
> +{
> +	struct net_device *dev = NULL;
> +
> +	if (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)
> +		dev = netdev_get_by_name(&init_net, ctrl->opts->host_iface,
> +				tracker, gfp);
> +	else {
> +		struct nvme_tcp_ctrl *tctrl = to_tcp_ctrl(ctrl);
> +		struct sockaddr_storage *src = NULL, *dest = NULL;
> +
> +		if (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR)
> +			src = &tctrl->src_addr;
> +
> +		dest = &tctrl->addr;
> +
> +		dev = netdev_get_by_addr(&init_net, src, dest, tracker, gfp);
> +	}
> +	return dev;
> +}
> +
> +/*
> + * Returns number of active NIC queues (min of TX/RX), or 0 if device cannot
> + * be determined.
> + */
> +static int nvme_tcp_get_netdev_current_queue_count(struct nvme_ctrl *ctrl)
> +{
> +	struct net_device *dev;
> +	int tx_queues, rx_queues;
> +	netdevice_tracker tracker;
> +
> +	dev = nvme_tcp_get_netdev(ctrl, &tracker, GFP_KERNEL);
> +	if (!dev)
> +		return 0;
> +
> +	tx_queues = dev->real_num_tx_queues;
> +	rx_queues = dev->real_num_rx_queues;
> +
> +	netdev_put(dev, &tracker);
> +
> +	return min(tx_queues, rx_queues);
> +}
> +
>  static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>  				key_serial_t pskid)
>  {
> @@ -2165,6 +2209,23 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>  	unsigned int nr_io_queues;
>  	int ret;

[..]
 
> +	if (!(ctrl->opts->mask & NVMF_OPT_NR_IO_QUEUES)) {
> +		int nr_hw_queues;

Looks like the userspace can already pass the preferred number of queues,
so in this case, why not do all this netdev resolution and queue
estimation in the userspace? Presumably most or the users you care
about always go through nvme-cli, right?
