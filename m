Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091054;
	b=OV2DnRUp5POjyZPH+sNbm8cX9CNMkPchy4f1SxSIQ2vJQDmvzEE+Fl88g3VO+kSpJ8dD
	 2tGF+Td4q7pwO1hFro8n0bQWg+lxiPKdR2DNPZb5u+qkQ95vayvng+AFsJvRNBx+qtqrC
	 4pE2x9vxJsEypyRiUEcpY9Q3HOkG+FoaV5N6kM+ZTtaoFSeOszO1A5q8Nlee9pwF9WWZy
	 /HgCMyLCD0jQ41HPLmGQXA4HUpoy1I45zI8ifjZwkXYzBbw2puRTO2ZtLq6Ffp0uVl5St
	 ucR6ARoFI7dWhW2+Gv7fviKZ45/Tuk/aWYEOCfAyXNqv4gtxj6tdwPhAg5sWPFWW0Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091054;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=05pWYvdSFKuQTlIpLib2CW0D3AAIr02xLV3H0zVKlko=;
	b=bkgUZAx0sSiuSwyWj6Yk+c4TqLsNGcOhIa4o+bnT3Sfu5hZC9PR9ej+hyfnrDD6p+ZZ5
	 w3ct/rXeOknIByzQ6OZlSWOcWb78Nu+aEvQeBaE6RGY7u2SuooBR7DAWKuNcUjWUqxDus
	 W01xd8itqES+eSAHeqdGK6YDndqGxEzHLYVyCK7wRg6UZRVwMGNbCIH2oaUmZHxCpzNwU
	 7cEGw0zCwg4FT6Wwwwu7mQsxlboDZX+fyW/rbk2gaoEEJXSc7yIvm2tzbpkGdEfUTMI8m
	 8vg4OPM+rfWpAQCQ/UZ3N1G3hK8xrxDvUzLmYvoNxlPnBsavzlCy7q61ibqzTE1xMqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TCkFoK6B;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CKwtIhUT;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76849606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76849606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TCkFoK6B;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CKwtIhUT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793091052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05pWYvdSFKuQTlIpLib2CW0D3AAIr02xLV3H0zVKlko=;
	b=TCkFoK6BdyeWSDXRDds76wek9S8/AoUKw0AqZgkSUKz+KuZ145U9Hg1/xbosgXKWjp0MYV
	1FRSULf2Y/yleZlqG+7HoxFVLmWhIqqS+jYY5iu8s0LFc4rJf2YWinND7g7uNutvZnLJCg
	toIWx1EhYWbpwAmxFEIY1vQ5FfLjVY0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-qQbCsxd5OPqQR-n6Lu0viw-1; Tue, 27 Oct 2026 04:50:50 -0400
X-MC-Unique: qQbCsxd5OPqQR-n6Lu0viw-1
X-Mimecast-MFC-AGG-ID: qQbCsxd5OPqQR-n6Lu0viw_1793091049
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a204ac318aso20934305e9.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 01:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793091049; x=1793695849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=05pWYvdSFKuQTlIpLib2CW0D3AAIr02xLV3H0zVKlko=;
        b=CKwtIhUT3e+evXhP8lwAOn/9H3MiC48E78f0NbBhlr9rid3UF26ldFUeh6V2tEULgm
         db2NE1a/zadHKbcWiTqOipEg0FZYfVslHjIyS5g+wy6jIaOnh+F/NDtKCUm4a/bi5fKF
         5edNWAhVvkuXJWDXimuf2zfVOElrQjYNvVJP165ujnwSipvhcRuWTb0RVp9AeopXj8fi
         TG2gM4kdUizHDheb6+bfuG558uT+oXHJpMZuVTnLhab+LFxtRq3rtE64kJ7k7dOQzLMH
         /9jnNL4tEq/sNJkZG3KkJMizvH9NbjaCuFGoGrQxdMPK0FReI9jzT5lvV2CrWfMxNWiJ
         mqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793091049; x=1793695849;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=05pWYvdSFKuQTlIpLib2CW0D3AAIr02xLV3H0zVKlko=;
        b=tj0f16ww3z6/XUYp7wEUGOAILLDVRe4AAfM54OFysZuYJHS/T2rqFcElfKMYh2+0Ig
         9GRmFzXaJldt7Y1Amq6X9I+eduqwzH2GhYk0FKYJSu/e/RexZ2Lt02TcjeZia7Om7dAG
         JJQiEKa/I+xN2geUc/ZAgxVB32YYKJgLoHEMvMyBqgMVgwRrTAGTYoCFu5xKKBlM8WLc
         iKoZXyNyO8emNttaU26srF5f3p27+9g7NLMI3ZYtCBUGylczEvhjE1wJyCl8x9CEBXkg
         3+5PdZiArsk+ognjIFk+Og7prGADw6z0nKtn8KX+IlCsh0F7Jaa5z9SPm8ajCYAdZ0CV
         /BvA==
X-Forwarded-Encrypted: i=1; AKwUvBzPaLi8ZG5czUFejBkz3jpnuL3B1I+dQqd8TS7T+Wgew8seoxXAIyIO1O2DlBB/kl8whzaggEI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2kvSf5Vg/BsPItguqeAnmIjWdzhr/7sB5BXAX26N4nY+l7CLQ
	ebWJL7ayokodHlap37bJEctINMaSB3JgXnyBWt4KUKehkAr2a+PKjhMUc6epgobeVMIZiSKeYEB
	WBEKB8cSulluRCyOX9HiZq78rFU7kO2ZBFXACCilYZu7nyNzePgzvBhwcnQ==
X-Gm-Gg: AYBFou0u+3gHl0tqWf4QN1T3aZpbcd4vyfDser2PXcaWG9C8CNIrpHBpTze/VzyIqil
	7skea/UiZb0RkgC1ES5MZ6Wkr+5dR22+3Xf/2bNzFGyFI8TKVXUAquKpGTTZXxioAbiO4G23+oq
	tCUetwJDJwVYWvFWgqKdRwrsoRr2vwRmKPk+A4EZcZfvsZoWOiwl6r8FYCWfSUZGZCrjqNmt0vP
	rcH6HoN/i9J0U/T3PLtuy7dWY9qNWfWRr50zgk2sEGfWcv6gWCAAimeVw/wO2Y8+/mMucnbCmge
	HIP6/OlI1s9W+/0HlJdRAh3BCqa5ft+T86Ej9SMcFrNfFcvbM0do3Xj/CaZUB8HfNnEN/PWaSMG
	qEC0nr8xSJ9HZuSIEDxbzaQokqPEnSv66gxsoQHjRSt7kgSAcZQg/uLgPNa9bPCfwFVS4c7624A
	==
X-Received: by 2002:a05:600c:8b86:b0:4a3:59c9:a754 with SMTP id 5b1f17b1804b1-4a35acb17bfmr169457685e9.22.1793091049497;
        Tue, 27 Oct 2026 01:50:49 -0700 (PDT)
X-Received: by 2002:a05:600c:8b86:b0:4a3:59c9:a754 with SMTP id 5b1f17b1804b1-4a35acb17bfmr169457205e9.22.1793091049010;
        Tue, 27 Oct 2026 01:50:49 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e542ed998sm6698767f8f.13.2026.10.27.01.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 01:50:47 -0700 (PDT)
Message-ID: <7136e772-513c-4ee3-b802-a9666fb8bdba@redhat.com>
Date: Tue, 27 Oct 2026 09:50:45 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx4: always create the eth and ib auxiliary
 devices
To: Peter Morrow <pdmorrow@gmail.com>, Tariq Toukan <tariqt@nvidia.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 regressions@lists.linux.dev, Leon Romanovsky <leon@kernel.org>
References: <20261020164239.3808903-1-pdmorrow@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261020164239.3808903-1-pdmorrow@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/26 18:42, Peter Morrow wrote:
> Since commit 7d22b1cb9d84 ("mlx4: Connect the infiniband part to the
> auxiliary bus"), mlx4_core creates the "ib" auxiliary device only for
> an IB port or a device that advertises IBoE. Before it, each mlx4
> interface was offered every device and decided in its own add callback.
> mlx4_ib_add() accepted Ethernet ports without IBoE and registered them
> for raw packet QPs only.
> 
> ConnectX-3 VFs on Azure have an Ethernet port and no IBoE, so since
> v6.6 they get no RDMA device. DPDK's mlx4 PMD, which needs only raw
> packet QPs, then cannot open them:
> 
>    net_mlx4: cannot access device, is mlx4_ib loaded?
> 
> Restore the old behaviour by creating both auxiliary devices for every
> device and letting mlx4_en and mlx4_ib decide in probe, as their add
> callbacks did. mlx4_ib_probe() returns -ENODEV when there are no usable
> ports, and mlx4_en_probe() binds a device without Ethernet ports but
> creates no netdevs, as mlx4_en_add() did.
> 
> Tested on 6.12.111 on an Azure VM with two ConnectX-3 VFs: each gets an
> eth and an ib auxiliary device, and DPDK attaches both VFs and passes
> traffic through them.
> 
> Fixes: 7d22b1cb9d84 ("mlx4: Connect the infiniband part to the auxiliary bus")
> Closes: https://lore.kernel.org/r/20261014133951.3219055-1-pdmorrow@gmail.com
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Peter Morrow <pdmorrow@gmail.com>

@Tariq, to avoid stalemates: this is waiting for an explicit ack from you.

Thanks,

Paolo

