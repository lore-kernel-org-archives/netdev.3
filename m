Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0F33B19AC
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290238; cv=none; b=AuMQ81GVsIXL3FhULOaNuyAzvM9U5SQgZ2VAO/v5J8yK8kWZUtMNqAFUMNsVJG/7g/j3eiYOQWl7M3MO6xWYuqw8BRXNXZdB+RMCbPhl+ac0AZnF5ZUJt/yI+h1AXtkc+Lf7rKyenuXkCJyYS7+vdXmotXZKlsYc+Q6l1T8Z5AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290238; c=relaxed/simple;
	bh=ETeEVoBsBm7p8BYaAtTcwLTqubL5V7ZcbXosM9M04Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glhcuLq2FWJHyt+4WO+L/7/RQ/WXZlOE6oei9fgBP8wFHlAgbhyEAhsmtW8OyLQHqjkM8HhzjbD5mIiQfEDa5h66UAFVk55oohvrh2zyCq8I0OOW+YwVXq+EsNeLp9b5IY1BS+IbB4SuQo31sJXENXJidIZTPIaIimJtlRi+/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5hLkO1T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5hLkO1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E4EC4CEF7;
	Mon, 23 Mar 2026 18:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774290237;
	bh=ETeEVoBsBm7p8BYaAtTcwLTqubL5V7ZcbXosM9M04Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b5hLkO1TI0G4a+Nk/t8GLS1lABQHU3dsdKQXVYK/CdNcoBPy8o2dgsUfoz3DiRaBt
	 EL6unHplZenS6pTLu26DaDT7JuyWexVu6r8aqXpLZ3HkBOavSLdy73BILT1AL7QXfX
	 cmUO39jvbPfgZ14+5sSdswthB1vmSmf+bUvMsvs9Vp5qxKSNN2Y9sYnQ0SX6pqosWG
	 vYkbcpR6HarRgOAINdlbRp7bZJiqBIHAw/J1vKoN08TXnhAzpOVOkdUzYVK3wlvZgu
	 LHKrcFGFm7fsKnw8P2WDm0JL5REy+Mro7hsZITX5t/QDXL+HTyaojtZYM2MfJOzrP5
	 qSanV5XtZkt4g==
From: Simon Horman <horms@kernel.org>
To: weibunny.kernel@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org,
	weibunny@fb.com,
	daniel.zahka@gmail.com,
	bobbyeshleman@meta.com,
	kuba@kernel.org,
	davem@davemloft.net,
	dw@davidwei.uk,
	andrew+netdev@lunn.ch
Subject: Re: [PATCH v7 net-next 1/5] psp: add admin/non-admin version of psp_device_get_locked
Date: Mon, 23 Mar 2026 18:23:38 +0000
Message-ID: <20260323182339.177058-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260322040704.991766-2-weibunny.kernel@gmail.com>
References: <20260322040704.991766-2-weibunny.kernel@gmail.com>
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
psp: add admin/non-admin version of psp_device_get_locked

This commit introduces two versions of psp_device_get_locked to distinguish
between admin operations (dev-set, key-rotation) and non-admin operations
(dev-get, rx-assoc, tx-assoc, get-stats).

> diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
> index f3a57782d2cf..fe2cdc966604 100644
> --- a/Documentation/netlink/specs/psp.yaml
> +++ b/Documentation/netlink/specs/psp.yaml

[ ... ]

> diff --git a/net/psp/psp-nl-gen.h b/net/psp/psp-nl-gen.h
> index 599c5f1c82f2..977355455395 100644
> --- a/net/psp/psp-nl-gen.h
> +++ b/net/psp/psp-nl-gen.h

[ ... ]

> diff --git a/net/psp/psp.h b/net/psp/psp.h
> index 9f19137593a0..0f9c4e4e52cb 100644
> --- a/net/psp/psp.h
> +++ b/net/psp/psp.h

[ ... ]

> diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> index 9508b6c38003..82de78a1d6bd 100644
> --- a/net/psp/psp_main.c
> +++ b/net/psp/psp_main.c

[ ... ]

> diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
> index 6afd7707ec12..b988f35412df 100644
> --- a/net/psp/psp_nl.c
> +++ b/net/psp/psp_nl.c
> @@ -41,7 +41,8 @@ static int psp_nl_reply_send(struct sk_buff *rsp, struct genl_info *info)
>  /* Device stuff */
>
>  static struct psp_dev *
> -psp_device_get_and_lock(struct net *net, struct nlattr *dev_id)
> +psp_device_get_and_lock(struct net *net, struct nlattr *dev_id,
> +			bool admin)
>  {
>  	struct psp_dev *psd;
>  	int err;
> @@ -56,7 +57,7 @@ psp_device_get_and_lock(struct net *net, struct nlattr *dev_id)
>  	mutex_lock(&psd->lock);
>  	mutex_unlock(&psp_devs_lock);
>
> -	err = psp_dev_check_access(psd, net);
> +	err = psp_dev_check_access(psd, net, admin);
>  	if (err) {
>  		mutex_unlock(&psd->lock);
>  		return ERR_PTR(err);
> @@ -65,6 +66,18 @@ psp_device_get_and_lock(struct net *net, struct nlattr *dev_id)
>  	return psd;
>  }
>
> +int psp_device_get_locked_admin(const struct genl_split_ops *ops,
> +				struct sk_buff *skb, struct genl_info *info)
> +{
> +	if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_ID))
> +		return -EINVAL;
> +
> +	info->user_ptr[0] = psp_device_get_and_lock(genl_info_net(info),
> +						    info->attrs[PSP_A_DEV_ID],
> +						    true);
> +	return PTR_ERR_OR_ZERO(info->user_ptr[0]);
> +}
> +
>  int psp_device_get_locked(const struct genl_split_ops *ops,
>  			  struct sk_buff *skb, struct genl_info *info)
>  {
> @@ -72,7 +85,8 @@ int psp_device_get_locked(const struct genl_split_ops *ops,
>  		return -EINVAL;
>
>  	info->user_ptr[0] = psp_device_get_and_lock(genl_info_net(info),
> -						    info->attrs[PSP_A_DEV_ID]);
> +						    info->attrs[PSP_A_DEV_ID],
> +						    false);
>  	return PTR_ERR_OR_ZERO(info->user_ptr[0]);
>  }

This isn't a bug, but psp_device_get_locked_admin() and
psp_device_get_locked() are identical except for the true/false parameter
passed to psp_device_get_and_lock(). Would it be cleaner to introduce
a common helper like __psp_device_get_locked(bool admin) to avoid the
duplication?

Reference: https://lore.kernel.org/netdev/6fde8fe3-1ac9-4a47-89f5-b6f759c2f103@gmail.com/
Daniel Zahka raised this refactoring suggestion in v2, noting the two
functions are entirely identical modulo the admin parameter.

> @@ -160,7 +174,7 @@ static int
>  psp_nl_dev_get_dumpit_one(struct sk_buff *rsp, struct netlink_callback *cb,
>  			  struct psp_dev *psd)
>  {
> -	if (psp_dev_check_access(psd, sock_net(rsp->sk)))
> +	if (psp_dev_check_access(psd, sock_net(rsp->sk), false))
>  		return 0;
>
>  	return psp_nl_dev_fill(psd, rsp, genl_info_dump(cb));

[ ... ]
