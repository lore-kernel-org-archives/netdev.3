Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59FA2F24
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971637; cv=none; b=L5j3FNKvjWROi+KJHnftJXLR4G5n69fsT+tjDfyMDjsQGAPnDYaINmKF8mhGtVE2Nnv8WQaA+SizILwNSy32vPyhZGZn/vbhhhfLsfoYrLEplhaJDqQzTA8Fn7Ln9o+opjsRNgIKgs7Jl9+LaqPsVT2ltxTg1Cj63bs/3S9K1KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971637; c=relaxed/simple;
	bh=+8S4vPJGfMv7NlAHMZN0/uhfNYiYBWUuW6amhbVE+qY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXJxZ2KVqALZvYEtxLHzVi8QI/TgiMjW2gRzBEhAk45AmF+/W/sGEZq0OUV1yM13qILSt2d6N1S4g8iAgarvNAnnDto8sJemD13dlU4RnPgtJElipiiStX1uFzVist0IzGzuZoI/zGq6pVeORccmxKm+v4Lcg1sup95h+AiJNJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJYIETxU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJYIETxU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665BCC4CEEF;
	Thu, 31 Jul 2025 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753971635;
	bh=+8S4vPJGfMv7NlAHMZN0/uhfNYiYBWUuW6amhbVE+qY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eJYIETxU4+WnO6sWcVkai7o1TRmmfX1yBCZ//VDX+ipnNITmKe85QxMu8c1kWWgpU
	 WKyLh+rRLU2XL1867dSv2taBrR0ESbbGST3RCJY/1KQhxn/9cRcBjDNzaSNKSy/nU3
	 xhCvcmaYhIcV8p/o4yGJDzYJDANoTLjGkYkh2n8Ymu4MgPA05pFM15NqUwFF4nJ4rh
	 bWr78ByBh/KQlS7QBrG/IExPsdwatpl5vJJBXhGJSB0xWQqna8sU46jQjxSXDfRUll
	 IWbptYoEKeCNZq+qsjHwSTvhk6I5wOzS66KrVc/FSK6v1XurlEAB58n5zTsxO2NZhF
	 if/R9YExYEOPA==
Date: Thu, 31 Jul 2025 07:20:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com,
 mgurtovoy@nvidia.com, tariqt@nvidia.com, gus@collabora.com,
 edumazet@google.com
Subject: Re: [PATCH v30 00/20] nvme-tcp receive offloads
Message-ID: <20250731072033.030866c4@kernel.org>
In-Reply-To: <253wm7o354g.fsf@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
	<253wm7o354g.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Jul 2025 15:40:47 +0300 Aurelien Aptel wrote:
> Any thoughts regarding the series?

What thoughts do you expect me to have?
