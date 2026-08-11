Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C07E372B2B
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455042; cv=none; b=pl0Ha4wHyLqIP1ck9n9D0vqrolARBRQaQ1gEWH8ZVUVjA3VdP0GizTlYC3ij17+0ojF+wNskYJPSuZxL/TIVZJZnVrXyOxfNpf7gy3vuEllIT7LAx09ekH1CVYK0ewnpOf+zOGgm+WsWbNvV+oJZ2JldMl5+O0A/fNfpPtG0vnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455042; c=relaxed/simple;
	bh=SYnOgk4fjAS1DNyJ76z0EyhamP/1F1KRjfEg70VPxio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HC0j3EXwjUy9j71HXomIeVyaH+r6paet+oEZBpGsR0iUAttGw9Ji467en/DU3b/dFlowLW8kEwlt64t5k3V1XvynwE6K8ia0LaRyxUGnnyaCGDxyJStEd9K/siULQ/7LclCpCoRIth7+Yvi07bR5yGPJAJpM6Xd/VuQA04DTNo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+62SisM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFjz+Z4N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+62SisM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFjz+Z4N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786455037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=343Vv4nwV5gIHpPMrByAKq2+ZRg+6KdX8JoUQb2ghhk=;
	b=A+62SisMx6/4DFm3tMwMKAM+NDwCNDUTU7esrwR6jmkxx0BXGsa7alKtWlAmllYmjMxuDA
	v+txESxulmmrpJPGNKzSSq35FtdI3QY1qY2Ml3umOklzANBCSnhZHdiO85gAC+0cIulDKH
	5lRc7vFJfm/k9AwNqwhdrHgsLrxP7sE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-I5Bws9_4OhKhYF0DqfD9Rg-1; Tue, 11 Aug 2026 09:30:36 -0400
X-MC-Unique: I5Bws9_4OhKhYF0DqfD9Rg-1
X-Mimecast-MFC-AGG-ID: I5Bws9_4OhKhYF0DqfD9Rg_1786455035
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4954c2d4081so23917565e9.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786455016; x=1787059816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=343Vv4nwV5gIHpPMrByAKq2+ZRg+6KdX8JoUQb2ghhk=;
        b=SFjz+Z4Ni/BZhQ0Emw9wfXz4/SPv5q2jEfB/WSh+gr8NTnDMh4KNnKVvFf9JSfWBe2
         pzv5eSNSxaa1INT1i8+yzExorjK4nEbnINGUZoZuWzN6cQO4hqX6rZ9F7R01jSptboWT
         /9MUVmUr3ZtVVKK9AfFJMDLze38Ml734tFw1BoJfKbUhn9tIB6Rk7vitb3NpEiifan7E
         zGDt4621cAIjpBrFnJXJ9SvatztRTHA7fJMMeKrSwAjdHOtIy3OH6IHEwxJ6M6YaknGb
         a564vpRRUDRA1KFZUyL71C5+DcgcVRkXOOLWPQtOY7TbDEcrYbTTy3Dht9g+sbKagfAl
         3g5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786455016; x=1787059816;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=343Vv4nwV5gIHpPMrByAKq2+ZRg+6KdX8JoUQb2ghhk=;
        b=ay44/sgUPVdpVDErDKoNYAYjUR2Bl1D2lP4SdWRUdfvz9CGa6Pc1u/U8uiwiU2pxnM
         nXlB85jhRb3tktl1Z+mjDdgFG08agBYihK0d6l4KeFT9B1RYxR8n+H68Qj6osjH2uafE
         ZU07wZNyND+wNSElICHKQDttLi4x/ab2BQfNb0lZsQyw0HVzM0ckMoJK1mluZQOm5qWz
         GzheFpnf3Gn2LIpYXywNjzLSMAL/fchRit7FgwljaZdHBTcqOBeSo4H6vu8lMA/D6nVR
         YwjrI8f6XAREflLFxWz+c2ijxG9u2Ac4Ej1YWD9dzEGrsa1aqZVHARFRr/hYRjYk3eQo
         hslw==
X-Forwarded-Encrypted: i=1; AHgh+RryCHoUkQujwj+D7kwi0F+TZqPW0DGk4LjQjG+ud+TsEhS87inbp6sWFTrC3VHqhiHRVJSwEnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGAtXakxMIOdsQKmwpgculBMlswGbCKvidLhbmTqYsZojwnP9c
	mZye7ikGquXd1QNNDtgfYkC9j4Tea8yVUOqrTHQSuwPRlJeUK19/yuqIgOIDurxFIL5ADEGDybm
	I0O7ayEN6h2PXkxoUqzJdNcy3gJNzOsTMsRntsvUY2RR6F0IDYR7WI4UvJA==
X-Gm-Gg: AR+sD10uA2y4JnWBl9sbKjYve3pJ3YFgW0C72Pn4o/ntQ7tbW1HJ+SOtOmALu2YrL6V
	Uu6zOu5tMMynOAgLLJlEd2EuhhK4h+X10YLfxPLBiJ7VuJZzMBYWZ/c3vqZiq1CJd5OS2Fgv35/
	fCDi/sj16n1wU0D8Q1ruFRP4PQKoRo5fHJXW0UtZTXkZVR3SwxuDZ7oJy58wJi20G6e5K88qAnK
	VkMhJgfYtxAG7cH0dwCdScC72sHJ4Q8tbOed1fADkUolTmcmwKu8auVJLeehssJk6grKxxLFOjU
	Yfwh2FSDpf7f+iu/9736U6GlLlMgPSGxP1XKvP/IM5prbzCVDUQx91f+X5zn8lD23byguRIvbwH
	bOFFim7OywzMqYpAFEVyImcGdJ7PIBnCdhMZAuNFRL6Dl2X2cXpiDAXfRwQGfNzkEISWPbXv7KP
	M=
X-Received: by 2002:a05:600c:b93:b0:495:4811:d71c with SMTP id 5b1f17b1804b1-4997846a4e8mr49722765e9.13.1786455015415;
        Tue, 11 Aug 2026 06:30:15 -0700 (PDT)
X-Received: by 2002:a05:600c:b93:b0:495:4811:d71c with SMTP id 5b1f17b1804b1-4997846a4e8mr49721555e9.13.1786455014743;
        Tue, 11 Aug 2026 06:30:14 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499788f11b8sm53354975e9.10.2026.08.11.06.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 06:30:13 -0700 (PDT)
Message-ID: <61dd4a2e-ef14-46b6-bfc5-c5b6463deb38@redhat.com>
Date: Tue, 11 Aug 2026 15:30:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: phylink: treat PSGMII as an inband capable
 interface
To: Sandeep Sondagar <sandeepsondagar@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Gabor Juhos <j4g8y7@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260809-phylink-psgmii-v3-1-908dcd3a9e3d@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260809-phylink-psgmii-v3-1-908dcd3a9e3d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/26 6:01 PM, Sandeep Sondagar wrote:
> PSGMII (the Qualcomm 5-port SGMII) conveys the link negotiation result
> from the PHY back to the MAC through per-channel in-band SGMII words,
> exactly like SGMII and QSGMII.
> 
> However, PHY_INTERFACE_MODE_PSGMII is missing from
> phylink_get_inband_type(), so phylink reports INBAND_NONE for it and
> phylink_pcs_neg_mode() falls back to PHYLINK_PCS_NEG_NONE. The PCS is
> then programmed in force mode and its control-register speed bits (which
> default to 1000base) are used, so a slower copper link - e.g. 100base-T
> - is reported as 1Gbps and cannot pass traffic.
> 
> Classify PSGMII alongside SGMII and QSGMII as INBAND_CISCO_SGMII so the
> PCS negotiates in-band and the resolved link speed comes from the PHY
> in-band word.
> 
> Also add PSGMII to the generic clause 22 PCS helper functions which
> handle the SGMII in-band word. Without this, a PCS using these helpers
> would still fall through to the default handling and force the link
> state to false in phylink_mii_c22_pcs_decode_state(), fail to encode
> the SGMII advertisement, and get rejected by phylink_get_link_timer_ns().
> 
> Fixes: 83b5f0253b1e ("net: phy: Introduce PSGMII PHY interface mode")
> Signed-off-by: Sandeep Sondagar <sandeepsondagar@gmail.com>
Sashiko noted no in-tree driver is affected. At very least, this should
go via the net-next tree without any fixes tag, but I'm wondering if we
want it at all?

@Andrew: WDYT?

Thanks,

Paolo

