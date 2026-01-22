Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FAD1F30A9;
	Thu, 22 Jan 2026 04:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769055111; cv=none; b=tPxqDWCdOCQq6sxZS7QgwGuxF1atmpJHlaVwzjPy5bzllmC42yN49SEqYKTqzwCJO7WDaa+OOzUWuxa6zCKQkSRPqUSGz2vDJl3dUTi94liaBgRf8pTTTTKJtk48L47yCjs2k1bSdC+s6VUSqIg6ZJeg/6LT3cHexhk04koHuFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769055111; c=relaxed/simple;
	bh=N2xDhWhzXbBIFQoZhcsFXsP8AL6+oMpK/7FxynEkPJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpMC5MayIewovvFsp/J10sXJzdQFXweCH+axH0aDTqI+zrSE866yVX2g8r3YSDm2cXs0d13HQ6GhY5Rcr4+0lRDNJVMZtpul4kUOfWLaU6POhKATI+IJDtWmCKDL0TNUfx6XiSj9GU4PcNNK+xg3EdhvNTM5fCNK70A+yfsqhEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/tfN+so; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/tfN+so"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97217C116C6;
	Thu, 22 Jan 2026 04:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769055107;
	bh=N2xDhWhzXbBIFQoZhcsFXsP8AL6+oMpK/7FxynEkPJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E/tfN+so1ge884TqoxaQEMU37E0pTDwtjbn/kX8SoaBPMY+GDbDOcBVzUtp6lZW1J
	 K/A+G9f3/Sq7kjyDiOTuziwL6QVTn3n5KzjoNktxxtK3lTkjBN3jAoxqxiJJmPnyj8
	 zsCAkr1EiABtqVtcTpJnoiEa7wz9dqtnWQ8OqEfZEK3We2v2uvM8wY65ox5mul6PMj
	 6ygTT5gan2o+6WkkmNZ3XJ+iUmOO2LaSh+hFJtr0myDQzrxkoRrBE+JapODaS873Ur
	 423a08j11J9dKgbRh+GH/5s+gD97C9lsO8qXFswebucPjwbj5IwfLU7YYDgnaSdyNw
	 RY38IWtmlZRyw==
Date: Wed, 21 Jan 2026 20:11:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
 <guoxin09@huawei.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
 <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Luo Yang
 <luoyang82@h-partners.com>
Subject: Re: [PATCH net-next v01 1/5] hinic3: Fix netif_queue_set_napi
 queue_index parameter passing error
Message-ID: <20260121201145.537a6726@kernel.org>
In-Reply-To: <fc0a7fdf08789a52653e8ad05281a0a849e79206.1768915707.git.zhuyikai1@h-partners.com>
References: <cover.1768915707.git.zhuyikai1@h-partners.com>
	<fc0a7fdf08789a52653e8ad05281a0a849e79206.1768915707.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 22:29:47 +0800 Fan Gong wrote:
> Incorrectly transmitted interrupt number instead of queue number
> when using netif_queue_set_napi. Besides, move this to appropriate
> code location.
> Remove redundant netif_stop_subqueue beacuase it is not part of the
> hinic3_send_one_skb process.

The NAPI <> queue mapping is exposed to user space via the netdev
Netlink family. I think this deserves to be treated as a fix and
submitted to net with a Fixes tag. The rest of the patches LGTM
for net-next.
-- 
pw-bot: cr
