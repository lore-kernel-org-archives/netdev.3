Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9BD30AACA
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 03:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769830163; cv=none; b=SOZhjmvphNRY5PJq2rhVfBdAiHIDMi1wWxDHIh8/TsmgyLOpvz9jZfum0DbVFgDqV94ZSE0xwhdGPOVR0xbkJDoKBMby3ia5OQUYkto1QSA48y10jdXCuxHyoucd5G+31epAzbn8acKx9NmCqnsZCo8f4qOlVi1VVBoo3WyH9Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769830163; c=relaxed/simple;
	bh=8vbxpWQDRNcfdJl9G4dEjNOcyoieq4QUZ0QUFbIjnw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mr8VKISxKzTd1froJrXW00q5GgLw6yDomyu9ewCqdM+eOTxtWlYlf19ljIJsWnXikconVSLOXp4rgwB5MBluKCW2GNtdGIAoHYxcyq3jqV0j2PtSduGcGLS524mmjewa9G9ZIpEE9ViSkGOz8+BrqEO+jTTbNs/PBGJzjUtQivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnEekZK2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnEekZK2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693AEC4CEF7;
	Sat, 31 Jan 2026 03:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769830162;
	bh=8vbxpWQDRNcfdJl9G4dEjNOcyoieq4QUZ0QUFbIjnw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lnEekZK2L1aq1N9GOqK2B6V9dbPnDQxFgSvQQw1UL9jK+pihhfp82MoI3GBgnihm4
	 2c5LYwefRuV0KBusreL7qgLvd3s1KFfugzTHti/PM59H/OP3T+U3r1ZkQkpe8ROVBH
	 O8+AT65EeZqO8oc3QxLGAp+B7BltSHtLOhJYXXf5ieO/0tZjYRbzD+PAMovA7ZYVGB
	 6yRogXRp2otAS9yhYTWCVV5KVjI6KJ8z3d54ol0WY24ipJdkn+64Ym11YGWRxGS8is
	 N1b9DcF8pEzk+gZnNBXv8kXvrykdBHWFJqlLa6WQJFTW/QkLR8gAOE3AyMtC2ahc7o
	 eVKwT9e+dvkzQ==
Date: Fri, 30 Jan 2026 19:29:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net/sched: don't use dynamic lockdep keys with
 clsact/ingress/noqueue
Message-ID: <20260130192921.1fbf5e21@kernel.org>
In-Reply-To: <68f55cee98e5402af2509f1d3873fbc7a27f67e9.1769699825.git.dcaratti@redhat.com>
References: <68f55cee98e5402af2509f1d3873fbc7a27f67e9.1769699825.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 16:24:35 +0100 Davide Caratti wrote:
> +static inline void qdisc_lock_init(struct Qdisc *sch, const struct Qdisc_ops *ops)

wrap at 80 please

> +{
> +	bool skip_dynamic_key = (ops->static_flags & TCQ_F_INGRESS) ||
> +				(ops == &noqueue_qdisc_ops);
> +
> +	if (!skip_dynamic_key)
> +		lockdep_register_key(&sch->root_lock_key);
> +
> +	spin_lock_init(&sch->q.lock);
> +	if (!skip_dynamic_key)
> +		lockdep_set_class(&sch->q.lock, &sch->root_lock_key);

is there a reason for the order of things here? The code flow would be
far more natural with:

{
	spin_lock_init(&sch->q.lock);

	/* Skip dynamic keys for qdiscs which can't nest */
	if (ops->static_flags & TCQ_F_INGRESS ||
            ops == &noqueue_qdisc_ops)
		return;

	lockdep_register_key(&sch->root_lock_key);
	lockdep_set_class(&sch->q.lock, &sch->root_lock_key);
}

> +}
> +
> +static inline void qdisc_lock_uninit(struct Qdisc *sch, const struct Qdisc_ops *ops)
> +{
> +	bool skip_dynamic_key = (ops->static_flags & TCQ_F_INGRESS) ||
> +				(ops == &noqueue_qdisc_ops);
> +
> +	if (!skip_dynamic_key)
> +		lockdep_unregister_key(&sch->root_lock_key);
-- 
pw-bot: cr
