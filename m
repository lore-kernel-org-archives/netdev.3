Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ECD248886;
	Fri, 23 Jan 2026 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188876; cv=none; b=Tg6u1tWjwx+Nt2x/8SJx4wv/N6mX0xxfFgm0kZntpo0LUV3RyZWUAWJhlZgvju1+2YHhRKAPj/Vf115wMJ/diil1ryW6C7cy9aJM4Ti5kIdOfq48iGwWh3wxAyG6oO4E751ldYol6O4rL1JExPXWdlGmFrwvkGmz5jWWcJJKks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188876; c=relaxed/simple;
	bh=oDYlsT8ao4IVUn/v2GEIWN5chgYkGCfLTxu2tBB/5Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6pXkYDcEEu6d1C8zCDFW1zYDs1Yd6WHis020flKmA9woUjTPS3kdP9WgaLtj9v8zq4LYQWkAEuAR/6WCVhz83lJrT9luaoPgsQyP1DKZLT3y9wwtDiTkpIWscvLpWYrKDfRyxAVIqQHED8YlBKMsGyQG4CJTK3y688re39OQO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFmBW25T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFmBW25T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BD5C4CEF1;
	Fri, 23 Jan 2026 17:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769188875;
	bh=oDYlsT8ao4IVUn/v2GEIWN5chgYkGCfLTxu2tBB/5Js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aFmBW25TZDiYDj3uLSa8f7KCO8yKS4dhtf1jYKDt8DWbWk9y8tvZHAIpD2Vb+W0m2
	 SLYvw9lJpuGYGYT0Nx3HSPqYX/8Yc4e51lOSZROLoe/UbDyQ10arao/N6ZIebDCCID
	 LTB5kAkUr1B4/hyoEAvPI5re4zjeQF7vL/AyhR4ohr4B3t1aownyKN0QqJb6qYOpyA
	 vS+xnoE/c6bG5lSXjws/fWrc91GwZNupgGOZM0vjM70RU521NTQN4gW2FkRQUiWfSE
	 URow+soqN4Dl6EmhG/kddp42vccphaX00iCfKS0MykmpW+YnKQnWLIbhFmeuhkC9rP
	 xkJk1ojfjXJZQ==
Date: Fri, 23 Jan 2026 17:21:11 +0000
From: Simon Horman <horms@kernel.org>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net] net: liquidio: Fix memory leak in setup_nic_devices()
Message-ID: <aXOuByqgZ0iY81ak@horms.kernel.org>
References: <20260122072933.328997-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122072933.328997-1-zilin@seu.edu.cn>

On Thu, Jan 22, 2026 at 07:29:33AM +0000, Zilin Guan wrote:
> In setup_nic_devices(), the netdev is allocated using alloc_etherdev_mq().
> However, the pointer to this structure is stored in oct->props[i].netdev
> only after the calls to netif_set_real_num_rx_queues() and
> netif_set_real_num_tx_queues().
> 
> If either of these functions fails, setup_nic_devices() returns an error
> without freeing the allocated netdev. Since oct->props[i].netdev is still
> NULL at this point, the cleanup function liquidio_destroy_nic_device()
> will fail to find and free the netdev, resulting in a memory leak.
> 
> Fix this by initializing oct->props[i].netdev before calling the queue
> setup functions. This ensures that the netdev is properly accessible for
> cleanup in case of errors.
> 
> Compile tested only. Issue found using a prototype static analysis tool
> and code review.
> 
> Fixes: c33c997346c3 ("liquidio: enhanced ethtool --set-channels feature")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Thanks Zilin,

I agree with your analysis, and proposed fix.
And that the problem appears to have been introduced in the cited commit.

But I am wondering if we also need the following, probably as a separate
commit, to ensure that liquidio_destroy_nic_device is called for the
element of props[i] whose assingment your patch addresses.

Also compile tested only.

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 0732440eeacd..3ba2806f5d1e 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -3765,11 +3765,11 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 
 setup_nic_dev_free:
 
-	while (i--) {
+	do {
 		dev_err(&octeon_dev->pci_dev->dev,
 			"NIC ifidx:%d Setup failed\n", i);
 		liquidio_destroy_nic_device(octeon_dev, i);
-	}
+	} while (i--);
 
 setup_nic_dev_done:

...
