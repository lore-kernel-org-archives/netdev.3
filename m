Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCBB14EC73
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771784852; cv=none; b=Y8kqdnwn+CL3cdUVJb+A3/L0ItgUDoM8pBGq3yJU87GXk0/nBl+OYQU1j0RekFCr3rYBaa3WLg5g6BNRZcMV0vDmXxN7cxhJJVjZttN9rmQNBLyBilRmGfONA5teeJgarlsHkiHf9uSs9ydkJO8DH0VHPvi6K8jzNeC2vnIonS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771784852; c=relaxed/simple;
	bh=Ix9c2Lsr9lIBEM1FL5vboG1LzP8v/vhBlJbmYuuWIa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+NbEdSAIJ7LRfYjoZ5eKBVhGqG6qjVRqahtk8IjpgR1TNev/R0vZrmSYN5OMxrenGgNra3LzsgrK1Ts5enwGHdtR5W44lo2bx9z4lb2mAWtG28nwYQxbXQINrwizuN8SQAfsNGi94Ou8/UMntAIpQs9d44KEeKW2kkYkDr+mpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9cecG4i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9cecG4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77093C116D0;
	Sun, 22 Feb 2026 18:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771784852;
	bh=Ix9c2Lsr9lIBEM1FL5vboG1LzP8v/vhBlJbmYuuWIa4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o9cecG4iuguIiIQi+Nw013qptncRG2bDH4bn8SJPye+7m5lcJgNn6vJvrs6vCGyoY
	 sZmhvm5/fJpCLpHzqMpK4E2HpHMhJ7ZJvuh76hHCzCxneNKqT0AW4o5ABYY3tBWpmO
	 MqxUxuBdOQxEPuKu0NfKi+zFtiIP18g6nj/v5MZ0PLgd0+VApD7mbQTMTldnALtJwc
	 CU0EQEfOJKDyTthEjQ+RtKLvVSvB7xAuPomSzxexQGswI7s6S6m09FXlGJ13pvHk2n
	 vHxHWLbEsvSU/m+/PXTL0JK0LZ6miyA84C2dkgyT23lNgmE7C02DUO8lHSppmA9wgR
	 ZxwqN04alGLZA==
Message-ID: <56e04cb1-e205-4076-8236-1f172a75793d@kernel.org>
Date: Sun, 22 Feb 2026 11:27:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] drivers: net: ice: fix devlink parameters get without
 irdma
Content-Language: en-US
To: Nikolay Aleksandrov <nikolay@nvidia.com>, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Daniel Zahka <daniel.zahka@gmail.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Dave Ertman <david.m.ertman@intel.com>,
 Mustafa Ismail <mustafa.ismail@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 intel-wired-lan@lists.osuosl.org
References: <20260213084841.1406442-1-nikolay@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260213084841.1406442-1-nikolay@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/26 1:48 AM, Nikolay Aleksandrov wrote:
> If CONFIG_IRDMA isn't enabled but there are ice NICs in the system, the
> driver will prevent full devlink dev param show dump because its rdma get
> callbacks return ENODEV and stop the dump. For example:
>  $ devlink dev param show
>  pci/0000:82:00.0:
>    name msix_vec_per_pf_max type generic
>      values:
>        cmode driverinit value 2
>    name msix_vec_per_pf_min type generic
>      values:
>        cmode driverinit value 2
>  kernel answers: No such device
> 
> Returning EOPNOTSUPP allows the dump to continue so we can see all devices'
> devlink parameters.
> 
> Fixes: c24a65b6a27c ("iidc/ice/irdma: Update IDC to support multiple consumers")
> Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> ---
>  drivers/net/ethernet/intel/ice/devlink/devlink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

This patch was marked as awaiting upstream; I wanted to confirm it is in
Intel's queue or was the expectation for netdev maintainer's to pick it up?

