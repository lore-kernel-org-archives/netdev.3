Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389B425A645;
	Wed, 10 Jun 2026 02:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781058284; cv=none; b=nO1QNCw1+mIIct/fZpfujnHzOge/o7jOydR4tNwXFzz6NrZe2DpMknNHEVLvHIRy9XC/jxx7PY34oLiT2N9x/iRFgI5P9MmMfAL4qIWAuVeBXTJFKvOpOM9Obws5cy/wQXsK9CS8ZKi3vbQO8RBOV9iadRQMjE0UkJ7dCaOuaV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781058284; c=relaxed/simple;
	bh=Y9eQYEUYRarlHqBWxz8W0yCt8h/RcsFIGWk9WErZDt4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iByuBoEUwJO8NQpV9/85Zzx4XemXXm8ZAyij3KF0F+cxmQkhfntQ4GUOeQgtdVTVTY/yNopOOarJuOx2TwSCvF/kAcT9+s2jLMbTYEZ2g4p+I1Vmg0SMkn5S3p4V4tGzMP3nBFtH43Jg2Kq6EUD9PZduPc8itdmCRUTL433baOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DW8yTeGC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DW8yTeGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054E11F00898;
	Wed, 10 Jun 2026 02:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781058282;
	bh=GpvSofoRKqMb+8N3ei4eKYxy3HvN4kINcPoLFVu8JBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DW8yTeGC3d8BvGT1Gk7g6/eD+4LxH+deDj649B44hVSjDW0xtf3vATaJEfAJb5DXs
	 1RbgPqGzAgzIMejztL7sN0aw5LttQBYb6FUkituS0q+fYnxx/COmNS3s+ARypri9fM
	 byzaAr9GtTca3KlBwRwgUaxkZ7ARsiLsc6ZvnZYpnNgoXQDyco3jYfk9ortu6/J9va
	 lb+kkPcw2e2v3BxUWO0hiiCU3Cvf2K0jWSLPSsU6ctWYVF2wm0mDuxunkjN2aG885w
	 CTNEQgMFhaO4k9xQkiPszxijG4hd/P/hibAmYo/jzPSnlWTeCqOKZmIhnieoV3e2dZ
	 JstOpvnOkidHA==
Date: Tue, 9 Jun 2026 19:24:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Wu Di <wudi234@huawei.com>, Teng Peisen <tengpeisen@huawei.com>,
 <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana
 Ciornei <ioana.ciornei@nxp.com>, Mohsin Bashir <mohsin.bashr@gmail.com>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
 <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
 <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v08 1/5] hinic3: Add ethtool queue ops
Message-ID: <20260609192441.6a61341c@kernel.org>
In-Reply-To: <4ad179dd9082df5e738219e05d90ddb2dcdad8f0.1780907605.git.wudi234@huawei.com>
References: <cover.1780907605.git.wudi234@huawei.com>
	<4ad179dd9082df5e738219e05d90ddb2dcdad8f0.1780907605.git.wudi234@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 20:36:30 +0800 Fan Gong wrote:
> +	netdev_info(netdev, "Change Tx/Rx ring depth from %u/%u to %u/%u\n",
> +		    nic_dev->q_params.sq_depth, nic_dev->q_params.rq_depth,
> +		    new_sq_depth, new_rq_depth);

Please don't print messages like this, ethtool generates netlink
notifications when config changes. If someone cares they can subscribe.

> +	if (!netif_running(netdev)) {
> +		hinic3_update_qp_depth(netdev, new_sq_depth, new_rq_depth);
> +	} else {
> +		q_params = nic_dev->q_params;
> +		q_params.sq_depth = new_sq_depth;
> +		q_params.rq_depth = new_rq_depth;
> +
> +		err = hinic3_change_channel_settings(netdev, &q_params);
> +		if (err) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Failed to change channel settings");

This message is useless, if you don't have a specific error to report
don't report one. also see:
https://lore.kernel.org/r/20260609190919.1139517-1-kuba@kernel.org/

