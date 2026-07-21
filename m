Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4383BFAEF
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623985; cv=none; b=oxhZcdiS4SXuIbdvUxO9LmZg7vv2nBo7KRi66z1DjTwvpitsojorcdiKZd6eDnf/kCF99+oABVxajAwV+uIFP4Ij2O1+839BnWCLpCwKtj5KJx4JY7DX3erLq3Wwgi497NC08Rin0GWjCm4aszf8H3Xb//pgnicc/ChW1TsydxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623985; c=relaxed/simple;
	bh=1MHRIePTbHHk9xjWYi87u8AUAEPnxZmCw9kRQrxCc/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFP4jUnsS2SvLLdpt+j5qqiLM/1yuQkIGqy3+/c9DWHNGCeuu7+eWDdWVHbq3FlDP+sPU/vKaWf/2xdRFHUw4j93zcIcj63ELbh4YDwmz3n6suyEzslTIC9GrBMZSup51EYgiSrl0/Oj9qD8MkuDurh2z7D8Z6r/blkGCh1W55E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXMdEDLk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oL4BLraz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXMdEDLk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oL4BLraz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784623982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=motssK5KBh9ULfnUG/euYaWhuODun2kccAtLo6xRXEw=;
	b=SXMdEDLkAYaeqX2bEGVt4MxCQjHAgEpWZbbWYw0oVd5VW0E3INk1c66e4OUjH6Q91GW4Y1
	SvKB88o3bZzA0P/VbXXS1bOjnm5ioFmWMwBuKmS1oyBd1NaB2Kcx6Y3Z1Sses0D2rqn5Kg
	WZmV0nApoMqqk4N1hLTXPXtmRCcbM9o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-wJiz4FflNmyVxW8p9b6scw-1; Tue, 21 Jul 2026 04:53:01 -0400
X-MC-Unique: wJiz4FflNmyVxW8p9b6scw-1
X-Mimecast-MFC-AGG-ID: wJiz4FflNmyVxW8p9b6scw_1784623980
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4955843c6cdso26518145e9.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 01:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784623980; x=1785228780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=motssK5KBh9ULfnUG/euYaWhuODun2kccAtLo6xRXEw=;
        b=oL4BLrazkPAuEUYGRLa5AFFm+2RNBSIRl7r8e5KienT82BpkqpLZbbOdnyHEVQ8fJX
         lxpE2X2o/WNbq+AIQ9Hi15X/m4m1XXWVjRkXhfbNj69lULVl+mkd4TT6dxJDU2ickzTF
         GflATpaE+nFPIPukYESqJuQOVy1hSQu1TbjfeFjvrVaMzGfYcVZxCe1088kUrLPAtSFm
         Lf6znKPKbUyX5CKjrO0WCsKysXDuDapjYLsUXjmNm1cJDL/yxOKTvcf07KuZ3Oulgi24
         VLvzkfGpXwTLK2TOcPqmRuS2RGtA9H9go2q0bx4D24i/3sR3C4z3INDjBv6V6n1nKJoL
         qhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784623980; x=1785228780;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=motssK5KBh9ULfnUG/euYaWhuODun2kccAtLo6xRXEw=;
        b=EmTX6p33srnuH5tzVFxz3PIbpTKQIyDokIzUFQqi/PUQ1LVHojvpt7kdEiLg5RltDk
         +i4dhy9QUTCsx/5LqPKv4UNIyCGpYOhlgm6OkZsm9Yp1mPpauqGT9U/wf4mj7gLN116m
         XIeLqDetOT/Rl1E/2uYcsuxbgMhQ5lFl4oMhRWPQgWpEXnN3i7nBZOSiFWinX/zTdpDW
         aUBANoUEn+4SPTMsYlDAeJu62J5CzBltJaghgydG415uG7iOsNfTysUoiOiHVVb5FRbF
         Dy0yg4j2TqgBxbQ0TIwQ0SFdDVrO2Go16z8WoMWBj8kMOrj1dVmjfkI+Z3TholYmJJ6C
         4ifQ==
X-Gm-Message-State: AOJu0YxlnYO+5XyFfeMF7JXtMTb13KG+F6ywsHJWBkXMZH8MoMp8Sj+p
	F0vUs/NNb4Kz39YXCuQy+STgnstORs8/yw5rlpcXFHxMFyPa2tCykAdet9vCmxDWcFngkXMsya6
	z7Y4HhUyuAVaTiEehzP3y1rFWKkQGrUybWMBeMbzt0ccTwM2vm7Evd6My1A==
X-Gm-Gg: AfdE7clnNa1XGAOUp0046YdYOe3XkAT/HMI8lGFbCk4i0ZQLHUSQdUxXPYK6Clad7fe
	42tiYb4kiSdileuMNnh677QJ9QKH3gmnEVA37Nt5UES47WJ8LDqJ+bKSzxL8uUXhlXMvSuzj/Pr
	KXDGpkGkmWf4SgcPOk05ZlBzfyIJ6efZK1BYmjL/ir6TSYGy1cA5xZlcfgi+iLsBG5bv7NrCUsl
	MR4NnxEWx/21mrPbBtRl+MbY7kECdWHr9MyXzYKrIkIIYHz1ZFb8Ivdpl/b5hUc8u8AuAw7qtQE
	olMkEeVQU6Z1tDw/I7BLMBMU9fy7XSMeNH71b1G/PEWcLrtuStWrmeEI+njcqZx8IwmHx7sim1b
	AYsGvZtlknXBBZ/1wjSX45qdiYvGlP+1XIJmWAXVst1+HSHY+OxkAuaym2+F+0UfQIDG8bu6Nmw
	PxAg==
X-Received: by 2002:a05:600c:1d1b:b0:493:f7c8:eae2 with SMTP id 5b1f17b1804b1-4954a3db7dbmr188111675e9.15.1784623980283;
        Tue, 21 Jul 2026 01:53:00 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1b:b0:493:f7c8:eae2 with SMTP id 5b1f17b1804b1-4954a3db7dbmr188111425e9.15.1784623979848;
        Tue, 21 Jul 2026 01:52:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49563969482sm145264925e9.3.2026.07.21.01.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 01:52:59 -0700 (PDT)
Message-ID: <4793fa8e-36d0-48fb-95a4-f22549b5e1cf@redhat.com>
Date: Tue, 21 Jul 2026 10:52:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 13/13] net: ethernet: adi: Add a driver for
 the ADIN1140 MACPHY
To: ciprian.regus@analog.com,
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org
References: <20260708-adin1140-driver-v5-0-4aca7b51a58b@analog.com>
 <20260708-adin1140-driver-v5-13-4aca7b51a58b@analog.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260708-adin1140-driver-v5-13-4aca7b51a58b@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/26 12:33 AM, Ciprian Regus via B4 Relay wrote:
> +static void adin1140_get_eth_mac_stats(struct net_device *netdev,
> +				       struct ethtool_eth_mac_stats *mac_stats)
> +{
> +	struct adin1140_priv *priv = netdev_priv(netdev);
> +
> +	scoped_guard(spinlock, &priv->stat_lock)
> +		__adin1140_eth_mac_stats(priv, mac_stats);

I understand that past reviews suggested scoped_guard usage explicitly,
but FYI this is not the netdev preference, especially in trivial case
like the above, where it has very little - if any - advantages over
plain spin_lock.

Not a blocker anyway, just a note for future submissions.

/P

