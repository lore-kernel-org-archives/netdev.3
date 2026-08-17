Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7B744781F
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980316; cv=none; b=FHK45v4P7D8Vu66OmfySVRO8ldEv2Qx/hwhk8iF/UlsL6CCL1l7w4ZaKFaBxd6LABAKINXzKvvFiTVIl+DFOq9oyz9+xWu9Ek8BIjAJIiuIAP8rv49Hiqhq/hUdDyDMyKezQdbiZmDt3vA2jVKFSr65kLr548awj6Ku0yJk6rHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980316; c=relaxed/simple;
	bh=Hj/x1Qel+xVYtqxVygQXyYvIQBZxWWsmvNpRCmhYuB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggMIo8FNVFGPZfbdjZ4JW0b5hjGaL3FSQIK8X1PGYGSkIqmJfXiH3gLGleFKQ7wUn7SOlyPLKucl1eSJFDIIBZcHY3DIYUASaiagOBpjKpxf+WabI9xr+INvY02OX+a6AhF8obgcebuO5MDSNcKIUe46FoQvIZiKVIWnYYZ3xGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=cKDwDMqa; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="cKDwDMqa"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f703a9d05so2359628f8f.0
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786980314; x=1787585114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S98fjURZckKHw3kQIeH1ci3sUDlJW1dlj7BkFC6FteM=;
        b=cKDwDMqaYbFl69Kp5blTVknWGuJmeoyGo0XBHNERb6ENj9js0Fxlnvd3ph87LuQSox
         IiBareOSL8QO6e6LagUQtPocs5Zko8F2ginvAV21amX3VusKcrD8U76eEHutW1Aze7Oq
         sKSot1JXVa6Ey7VikKjG7HSYVHusUshWQq0T0wlB89AB4U8zVbIT6PshAQHZ/2Ny23Bg
         WX2wHHhbAn+ynO22zDh233yy64UwezPf9g/qySIwwe1ZgWlRupV97qJeEj6d3sE85XTA
         pQq+VcJvIAD8R93Ww17KTm9x9pXop9gAqi/F5H0lSqPMjqdNa1HeKdVHOhB8jcuyNJBP
         5ooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786980314; x=1787585114;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S98fjURZckKHw3kQIeH1ci3sUDlJW1dlj7BkFC6FteM=;
        b=Fp4I7T2GjrqaIGyujbhMibMYTJ4J+benxbeOJcI6xYixl4Rok9qe6Lor0+3wSlZOSp
         sdW2B7ife6SnUTOM9rl1dyIrwgXo/9O94mz2rgF40nzbHCdMP5oqumh4EfJC6MCMMx7p
         /AFgB6XWCE0MZ5Ju5dE8zIsS2LD3fE+I8hguvOvuvqExHw6x7iZN+2dVc7HFRqyNqC5o
         +xqtxwLB4C6P8DlkqBgVQR2o6e9VnoG50uP2IafX5AknZt44JUWq0aVwbGDfnp7ppXBh
         W6XjUtKneFOVVfFlGOHr5KVsxhn3hjjLOivXbeurHgjN9ihusEOGBF8ZTI2+/CZCUw/B
         6qGw==
X-Gm-Message-State: AOJu0YychcqnTNPZca/y9k+jGtdiC1689CN16Z++qDvwoy8aqFg6KSqL
	Z3zaiyJETBIsCReZNQTeech3TQuDpHxDL7JGIefeWiKjs8j3Rv6ERG5kjddl10ny4VrVNu1n/vQ
	sDl58
X-Gm-Gg: AR+sD10BnmpwvhHv1+TFb6Lmm4X+z30XpPoQSunQSFQ6I3WiGaasV6D/i9lcVw1in2G
	bBtSpT0+0wY1ufEHu6ydXX3IQXHQ/XZdJAPWU45QUy10B7DGKXBol1tU8ngOvn3vQqqvfI2tTTR
	Le+vBPYqGpfUdy9TgMXo9rPYyoP6p+aqJVy622SZs03tmtxAUAd9g1FrDp+RLrQREqW9AN+qCp/
	CN/4boJjMEGvUV7z3j/0lRolv2qcsA1SsybLqp8Os6HFQrGMl1yzkHXLBWypBS9Ia+O4hL7P1vL
	s7zzq6AUieL6z/N4/ihC854kDWZI3e7nYI9lR18WszxqvIqPOj0CEJSMqxeWaKmE7CcjqkIbJDL
	PkbGCT7GmLaxoRj6OBCK+PReTQyKC1Lukzov+TyWFSox2uZimpDyWshPej34nBMLHKHG1OxxAs/
	Ep0+oZlTzg+G4SGUeQ/oaH1DClTnW1z2x+781297z2t9CRgjMi+hV0C56h1Z29vVmydTxoS+6pV
	Bt1OG/XbQ0v2aibYqE=
X-Received: by 2002:a5d:51d0:0:b0:47f:f4b9:88b7 with SMTP id ffacd0b85a97d-48160723e00mr34560526f8f.1.1786980313693;
        Mon, 17 Aug 2026 08:25:13 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b7cd38sm5306739f8f.32.2026.08.17.08.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 08:25:13 -0700 (PDT)
Message-ID: <0543351c-2c7f-48db-891b-4d8a60776b3d@blackwall.org>
Date: Mon, 17 Aug 2026 18:25:12 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] bridge/vxlan: fix reading neigh ha without
 synchronization
Content-Language: en-US, bg
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, roopa@nvidia.com,
 bridge@lists.linux.dev, andrew+netdev@lunn.ch
References: <20260817143613.685769-1-razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260817143613.685769-1-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/08/2026 17:36, Nikolay Aleksandrov wrote:
> Hi,
> Neigh ha address must be read using the seqlock to get a stable snapshot.
> Both the bridge and vxlan read it directly and can see partial updates.
> I reproduced both issues with running neigh updates and exercising these
> paths in parallel and saw partial addresses, e.g. updating between
> neigh A: 02:00:00:00:00:00 neigh B: fe:ff:ff:ff:ff:ff was able to observe
> 02:00:ff:ff:ff:ff and fe:ff:00:00:00:00 in packets. Noticed this initially
> in the bridge, then checked vxlan and its arp/neigh_reduce functions have
> the same bug, route_shortcircuit is doing the right thing already.
> 
> Cheers,
>   Nik
> 
> Nikolay Aleksandrov (2):
>    net: bridge: arp/nd proxy: fix reading neigh ha
>    vxlan: fix reading neigh ha
> 
>   drivers/net/vxlan/vxlan_core.c | 20 +++++++++++++-------
>   net/bridge/br_arp_nd_proxy.c   | 24 ++++++++++++++----------
>   2 files changed, 27 insertions(+), 17 deletions(-)
> 

(-CC bouncing emails)

Hmm perhaps it's better to use ETH_ALEN instead of MAX_ADDR_LEN to explicitly
show the expected len everywhere, it cannot be different anyway.
I'll do it for v2 after 24h.

Cheers,
  Nik



