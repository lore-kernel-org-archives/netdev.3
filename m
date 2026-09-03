Received: from mta0.migadu.com (out-132.mta0.migadu.com [91.218.175.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730D117A2E8
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 02:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788401846; cv=none; b=UvqV+xONIef+eecKaPMCZw4c3BJpNMdbH/4JzC/EqxbyMFBWcHdHPQ7Oy+WlY4DOETXkTaVoKMEkQs2p3BsZGrFk+CEf/IESSr8ekSqLmmUxOt1+RlQwDyWUSaR97Rlp5OBW9n+CgSIbiyq5Muwc4lnH8HVJ9O/jnqet/M8PA0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788401846; c=relaxed/simple;
	bh=6KHUrCXryuMRO6NbRZhGY1jVIGm3Mw09CKEhifRYOSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLDbJ7gXp2s+Dy5io9wqe8MKJZYi+bTKKwsMaD1ZuMfXjq6TkuFDS8ISU6k+2ghYQzcoV/6dJxyOlmzY3urfsyOV8JB9kMH5TOr69BmVSSQfye8q33yjK8Tt9rrKyWq9NWQYl0RNZOKCnoi6u8z5XdVwoNxW6i3yE3/XAMcZxZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z+ipQS3c; arc=none smtp.client-ip=91.218.175.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z+ipQS3c"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6KHUrCXryuMRO6NbRZhGY1jVIGm3Mw09CKEhifRYOSc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788401840; v=1; x=1789006640;
 b=Z+ipQS3c18g4uBgJK67g8G4sbcu2RJfSeKD3/b1IpVrAusdoBtkKptOUAk6m4l7KhZyIsQf9
 KxAT5E/8g396paddDDXw7kXyyfa85wlWQ0TR/ZxNTvf0c1M9GMG6o1W/SxTANI+F8iW/8oa2HxU
 oS6/EiZ7ErjETev9pePUNvBQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 88996744991c2e71;
	Thu, 03 Sep 2026 02:17:20 +0000
X-Mizu-Trace-ID: 88996744991c2e71
X-Migadu-Flow: FLOW_OUT
Message-ID: <fbb4c7c0-58cd-403d-bf77-8b58ef4c7b16@linux.dev>
Date: Thu, 3 Sep 2026 10:17:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: macb: fix NULL pointer dereference on unbind
 with fixed-link
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 theo.lebrun@bootlin.com, conor.dooley@microchip.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20260902102836.2019355-1-vineeth.karumanchi@amd.com>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260902102836.2019355-1-vineeth.karumanchi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/9/2 18:28, Vineeth Karumanchi 写道:
> When the device tree describes a fixed-link and has no "mdio" child
> node, macb_mii_init() returns early without allocating the MDIO bus,
> leaving bp->mii_bus as NULL.
>
> Two cleanup paths then dereference this NULL bus:
>
> 1. On driver unbind, macb_remove() unconditionally calls
>     mdiobus_unregister(bp->mii_bus), which oopses:
>
>    Unable to handle kernel NULL pointer dereference at virtual address 00000000000004a8
>    pc : mdiobus_unregister+0x14/0xa4
>    lr : macb_remove+0x38/0xa4
>    Call trace:
>     mdiobus_unregister+0x14/0xa4 (P)
>     macb_remove+0x38/0xa4
>     platform_remove+0x20/0x30
>     device_release_driver_internal+0x1c8/0x224
>     unbind_store+0xb4/0xbc
>
> 2. On the probe error path in macb_probe(), reached when
>     macb_mii_init() has succeeded but a subsequent step fails, the
>     err_out_unregister_mdio label runs the same unconditional cleanup.
>
> mdiobus_unregister() and mdiobus_free() do not guard against a NULL
> bus, so guard the calls in both macb_remove() and the probe error
> path.
>
> Fixes: d0c3601f2c4e ("net: macb: Avoid 20s boot delay by skipping MDIO bus registration for fixed-link PHY")
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>

Reviewed-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Thanks,
Xuanqiang

