Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761AF2F84F
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 03:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773890510; cv=none; b=E1HSaNU0G4hhVFQLvPnEMv8ew6vg/zskAWHQkwnWaZCj27rwgBKwK26JNQo3Yt2ln9ncNN7sBUhKGPkKBcS4PD52fhv+CiHl7Y8KjTs4aGEFiVwNRLZgiFfnWB1toE2b7dCOoezaQXe7xomIuqehDeZRmZoHvIZMsZ5+Q9JQ1gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773890510; c=relaxed/simple;
	bh=tSD9vDHRdGsanzDFLEmkRB4m9SPozlQI+SHdWshiGpc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMBRD/WNQlQl6+9Ap60ufYKhEedNqmx4ASw99wFadakIbeWC1BT72qXwX0KudmSDrbQDW3Z0E3CaZPE7BVc7NcukYWMM3Unc3tLBfQoj+sRqYLdwB8WCWP/yW+dLtNumjetoVsohqXqZjJSyRDzebZOgIOW4DR6n50Cc0O+z6Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQ4DO/Ek; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQ4DO/Ek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BA2C2BCAF;
	Thu, 19 Mar 2026 03:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773890510;
	bh=tSD9vDHRdGsanzDFLEmkRB4m9SPozlQI+SHdWshiGpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cQ4DO/Ekjh46P97NsavC26Y3TlaBrFzSG6my+aEeRPqYcUesJSERomtUuTvd5qlKl
	 CQZZyvuRiS1cS9NHSpog79tiagkXcHzneynhz12fORyTS+h/CZDvsPJnCO0neltH/j
	 7fDphjaRBy4jjlc0WjTvna0PZTjHyKRD3gdAVsmDhI4dsX59/fVqMD6fLCMu4jCnPb
	 2oVcjwJcUpZ9+37QqjVnzm5C2KWaImgF6HdYRK1MAUa5qQCByCavFKZ1RxmacruUvU
	 n3NoDLWO7c3kLi+hMX5s86tKWH5EkREtqUyq48sXMx39caZ09Jp21oKdXunIC+Nnu6
	 yCB1ZguRGjijg==
Date: Wed, 18 Mar 2026 20:21:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, Philo Lu
 <lulie@linux.alibaba.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Dong Yibo <dong100@mucse.com>, Heiner Kallweit <hkallweit1@gmail.com>, Dust
 Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v33 3/8] eea: probe the netdevice and create
 adminq
Message-ID: <20260318202148.230d0424@kernel.org>
In-Reply-To: <20260317015257.79494-4-xuanzhuo@linux.alibaba.com>
References: <20260317015257.79494-1-xuanzhuo@linux.alibaba.com>
	<20260317015257.79494-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 09:52:52 +0800 Xuan Zhuo wrote:
> Add basic driver framework for the Alibaba Elastic Ethernet Adapter(EEA).
> 
> This commit creates and registers the netdevice after PCI probe,
> and initializes the admin queue to send commands to the device.

Looks like the Google AI review bot found some more legit issues here:

https://sashiko.dev/#/patchset/20260317015257.79494-1-xuanzhuo%40linux.alibaba.com
-- 
pw-bot: cr
