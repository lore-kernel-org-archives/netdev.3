Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4C6257849
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132706; cv=none; b=hBZDgV8wOGnvIIM1JxIobEFn4g4iLvmgofpoEyxzuNF4W299kf2EHw1phK8nUrdN0NqlmSFQPHKkCEDKglzeoYhM58hxUGIVk78k9lIXvGGlkJW7aGoMIMYyGkD1L86H8pUI/K8FJA6OWUIydYCkXEKYHm0Zcopzk0Lfd953mKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132706; c=relaxed/simple;
	bh=ZABh3N+dem81nZCQ8n96tOvTfOF1rO+50IpDtahu8CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1iEfAq/1sgSEj4bWC1Nguiqqaq1cNMwBcZuFpq6NHxPvj9Q6X1x0GBQjR6sNo3pF8i+vZMEtZDeDiHXeLHimEYCzpwyT9zFen9F8YWGY4ZgMRBv6nzqNVllLQBBulmdhuSdYZdeb71lU3uqltETx5eiIGhc4/zRVqo/gSsiCes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sP9+9y1a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sP9+9y1a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEC6C16AAE;
	Fri, 23 Jan 2026 01:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769132705;
	bh=ZABh3N+dem81nZCQ8n96tOvTfOF1rO+50IpDtahu8CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sP9+9y1aaMnku+8OdacD5u/HCvkLuLWEYYAH4Q3KO5pjr5hOlwUbWxLSQhqiVxCFn
	 DpF8gtmWAQt+4a41XVmGkmXwjW/qze7/QY4yFbSkRFqoeyJfl/jxI6BQqlQdXTy63M
	 8ioibogTxLeRzwENfv+K40kTAeYjjcC9vAfwH7OroelEO/sttfuVEiM5YEVZUvvGIa
	 DRtHDI5NuTifBsArMC6ANwph6ykbNfsEyWJPZ3611Kmm2qo6l23bdI/sR5XMKBPM1w
	 aK1xn+mCEAdB/HL1q30eScmVuB39igDaWwX8cfIZOkefuk17WIDOFpLLXu/7H49tT1
	 LrAdv4SeeCRCw==
From: Jakub Kicinski <kuba@kernel.org>
To: danielj@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	mst@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	jasowang@redhat.com
Subject: Re: [net-next,v16,07/12] virtio_net: Implement layer 2 ethtool flow rules
Date: Thu, 22 Jan 2026 17:45:03 -0800
Message-ID: <20260123014503.3008177-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121220652.894364-8-danielj@nvidia.com>
References: <20260121220652.894364-8-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
virtio_net: Implement layer 2 ethtool flow rules

This patch adds ethtool flow rule support for ethernet headers,
implementing classifier and rule management via virtio admin commands.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index b406f5f1c75e..e3f2a7e0e99f 100644

[ ... ]

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
> +		goto err_key;
                  ^^^^^^

If validate_classifier_selectors() fails, this jumps to err_key which
only frees key but not c. Should this be goto err_classifier instead,
to avoid leaking the struct virtnet_classifier allocation?

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
