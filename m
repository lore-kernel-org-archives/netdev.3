Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03BD5505D9;
	Tue,  8 Sep 2026 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873126; cv=none; b=eURfWzWsqR1O3PCwEbnNQfFEmgJn7Wzm1gIaj7MFN0qFFY20IqffdNieKekGPOsgXRHxo43lBJieYOgAkC71PjH7zuo63YDSj4jetEjeuiePzJ85wy18nzhpPhZMlMFP2JbbPxtwpXet3Brh2WKStV7pIQ86uc3e+Zt6+a4uYHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873126; c=relaxed/simple;
	bh=noOGhJJCgbCBMyAn3mldJ2BGRkuUyH8JSGLChAX4KZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1p+40JqSs1HpPLrH/a2Fw380afJBGhseDDNQIFO8Xadh7TbrA0jm32D1JnXLjsgJ3QraqzmwAkTwW6v/A/dR6kLJQPUMHhQup6xCK1RPYFc8uhS88cOmK0hM3zUDWmAq7fY6zpbGUS5bANABkGcyElzgsuF1dzWicj5k2qPo0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEilIild; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEilIild"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4DB1F00A3A;
	Tue,  8 Sep 2026 13:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873118;
	bh=DLRz70AEZhaKE9ONUUqtV+Djdb8ypaHB/yTowmctThM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WEilIild8hxFFLc4LaUWR2SWsOxniTP3zGpn+Zlog8mPEMi3g3WudDUAXnkY5u+K3
	 ezSt0+ENktyEoXjMV0UWejMjwkyl3uQtzXz1j7z0HN61s/FGdI12WGARR3eSWQZYdT
	 4peIILXAo8D+E/zAfuItvYwTY4OEubM5Q3JSkWiyPwb6S0weGbZfgvkg7/8D9Q1w5y
	 lXED3HdQ6++/8/BtDmrlEKK6N1OVMY3WaXHc/6AqzJuhDqX3nPoOn4zHMBhEFyvuBF
	 qppELAlq137LHWp2tFuTA14eGdBujf1VkoGbVer2m3PAI+qbjCk4xfxFAbYIa80+ez
	 JUEIx0VvmxBvw==
Date: Tue, 8 Sep 2026 14:11:54 +0100
From: Simon Horman <horms@kernel.org>
To: "hpp.iscas" <hppiscas@163.com>
Cc: Jian Shen <shenjian15@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Subject: Re: [PATCH] net: hip04: use 16-bit byte order for HI13X1 TX fields
Message-ID: <20260908131154.GY40544@horms.kernel.org>
References: <20260905132958.63085-1-hppiscas@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905132958.63085-1-hppiscas@163.com>

On Sat, Sep 05, 2026 at 09:29:58PM +0800, hpp.iscas wrote:
> The HI13X1 transmit descriptor stores send_size and data_offset in u16
> fields, but hip04_mac_start_xmit() converts both values with
> cpu_to_be32() before assigning them. On little-endian systems the
> assignment truncates the converted value, leaving neither field with the
> intended 16-bit big-endian representation.
> 
> Use cpu_to_be16() for the two HI13X1 fields. Keep the original 32-bit
> conversion for the other descriptor format.

I am curious to know a) how this bug was found b) how it seems to have
gone otherwise unnoticed since 2019.

> Fixes: d413779cdd93 ("net: hisilicon: Add an tx_desc to adapt HI13X1_GMAC")
> Signed-off-by: hpp.iscas <hppiscas@163.com>

Please consider using your name in the From field and the Signed-off-by tag.

The fix itself looks good to me:
Reviewed-by: Simon Horman <horms@kernel.org>
