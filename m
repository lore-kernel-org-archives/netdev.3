Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2DD38C2D7;
	Tue, 24 Mar 2026 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375026; cv=none; b=LL02IzXckSC8qi7ppkzGmxR5Dv48o5fjIl5cMgLkuOCSgic+74UItCqAhPbAf4WusFIITznxQ0HwAVoWTzie6B5oCq0//9rMDTCurgcquW5wKD+v8V03n+dJUNXVmo4+vlTEn4J+QGXiJvrxNujQpBTGEQoIM+4SoUtF66pyrKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375026; c=relaxed/simple;
	bh=ovpHCT29HDtsa44+NAngbwui5zzVJu5Bn5Ksgq7Mlus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScmpqqMfCa0EJqhXYRRm6uIyuapBhUvU4jUqH+kT7rAP9VBwDlnulltrzyAgz5uUSafdWlXuPKpg9FSRJhKFkVBolshDrkP/5gP3JOYtYh5RWKG9d1TJgKfWF/Uqn2K5JunhJMvaJBl+UVESk54CQ47MwbnFvM6WnFjvFBU9Z2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8G/xsAo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8G/xsAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30235C19424;
	Tue, 24 Mar 2026 17:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774375026;
	bh=ovpHCT29HDtsa44+NAngbwui5zzVJu5Bn5Ksgq7Mlus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8G/xsAoQH7i/utTBvQUve9ydJzKqESKfjxwtF4nERGjldew+YUeJVj8uFndLBg8n
	 hpYVsht8Kh0ISRu5NDhar/fgvK70WqIQRN5KcrPB0n1hJrmusfwl8N1ifQzR7eaZ4O
	 qXEaZxiP4uvoyKy2GwkTLN0D22qJujaVxGHqZbc3WurQqG92uac/ukbOKobh7Qz12p
	 tN5vkNDKkTf64EkF9SqVCn4vn1pmfwnWm4+rZopTpjsc1rzMmGO+eSWeovzS435k1U
	 wAhQR0ise8yEgl8ErNJn/r4InsYjpmOvjOru39H1xTBucWNtvPY0UjtQ5PxhyttehH
	 9KHHzU+ri/MVw==
Date: Tue, 24 Mar 2026 17:57:01 +0000
From: Simon Horman <horms@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Pavel.Zhigulin@kaspersky.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qede: validate TPA aggregation indices from CQEs
Message-ID: <20260324175701.GD111839@horms.kernel.org>
References: <20260323072415.60149-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323072415.60149-1-pengpeng@iscas.ac.cn>

On Mon, Mar 23, 2026 at 03:24:15PM +0800, Pengpeng Hou wrote:
> The fast-path TPA handlers index rxq->tpa_info[] directly with the
> completion-provided tpa_agg_index field. That field is only a raw u8 in
> the CQE layout, while rxq->tpa_info has ETH_TPA_MAX_AGGS_NUM entries.
> 
> Reject out-of-range indices before touching rxq->tpa_info[] and recycle
> the affected receive BDs instead of indexing past the fixed aggregation
> state array.

I'm not sure that we need to guard against out of range values here.
Can it actually happen?

> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

...
