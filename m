Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04848261B9B
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782340307; cv=none; b=ejSUt8ahWPJA2bIn9tu8Cvr83BZ6DVucyw66WMlSp2MnYXBkUUxvqZ7YbKUW1YyHS54U9gQQpCo7sISY9Iht9LDKttaIxKgQYYdhWLcd11YFtbzkBygz/OddBRixBuG4ghGtqoj3i+Hym4rNNKcOoe7bcDmgZyNVlFEP4rwE2Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782340307; c=relaxed/simple;
	bh=s8k3/6YIogxMvXLnwCat3AUIfmMsKkl7H7qfg4rEcpI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SB6IYE1d0kGlM6lot+SuMEnHjbvCYL9sgWnKesGeo+xOd7PqE6QuV65GrkMbYmxOddod3qseMCsL/CzToBNeBNGx6r+CI0O2FE0S1kcPFBrJInMo1wpw0foPBAEsW1UKlUQHBJpwFho6OLjlaqSIBpHnCCvCwl/D9O+e3areaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXiSDVgr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXiSDVgr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5771F000E9;
	Wed, 24 Jun 2026 22:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782340306;
	bh=mqDU0jYT7fql0ZGUSAd4YOFzVEzIxtmqJobN1DH6XcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KXiSDVgrG7pLxbQbzapAbBLTaHQBxEwYrQOmQPswMa8CHOoaVMhu6hl0ZI695ma7I
	 KSUWZs1lGxRsAnUw368ecjZfCya9TBbNmn7rCRYuXzplqJf5/9xYvJb/d3NQ522Al6
	 e/59VFoqmTgYXTcwXz1xsM1vgc9edhqfRGGqYHQlm44fh77qJzj20VHGJexphKnkoO
	 bhV8i7PhzFHH16nhXTI4XJhsLrIZFVIoxg8N1f7xx+ccY7TeSNVC4TA2iMOIkEK1vD
	 uko1sY77VMRC6amOOTg9WAE3UrFoh8i8c0vpq/Jomz7XL9EtUhKEf06dynZNOz814m
	 KgBm7Yg/WrbGA==
Date: Wed, 24 Jun 2026 15:31:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Yue Sun
 <samsun1006219@gmail.com>
Subject: Re: [PATCH net] net: udp_tunnel: fix use-after-free by refcounting
 udp_tunnel_nic
Message-ID: <20260624153145.3b0b9f49@kernel.org>
In-Reply-To: <20260624145722.083632b6@kernel.org>
References: <20260624171034.4117423-1-edumazet@google.com>
	<20260624145722.083632b6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 14:57:22 -0700 Jakub Kicinski wrote:
> so we just need:
> 
> diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
> index 9944ed923ddf..d7db89a222f8 100644
> --- a/net/ipv4/udp_tunnel_nic.c
> +++ b/net/ipv4/udp_tunnel_nic.c
> @@ -863,6 +863,7 @@ static void
>  udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *utn)
>  {
>         const struct udp_tunnel_nic_info *info = dev->udp_tunnel_nic_info;
> +       bool pending;
>  
>         udp_tunnel_nic_lock(dev);
>  
> @@ -899,12 +900,14 @@ udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *utn)
>          * from the work which we will boot immediately.
>          */
>         udp_tunnel_nic_flush(dev, utn);
> +
> +       pending = utn->work_pending;
>         udp_tunnel_nic_unlock(dev);
>  
>         /* Wait for the work to be done using the state, netdev core will
>          * retry unregister until we give up our reference on this device.
>          */
> -       if (utn->work_pending)
> +       if (pending)
>                 return;
>  
>         udp_tunnel_nic_free(utn);

Maybe not even.. by definition the driver should not race with its own
netdev's unregister? I don't get what the race is..
