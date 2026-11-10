Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321679;
	b=E5xyx0FawJcttNQGX7qsF9mnjBAslEoQvB2jzEihkt2hv3Drdmn78A0uSJjFuJB7TZok
	 yC14yWMidg22RdQUYkveikVwkR+4qRjCmuP64tU8LCeFKRotp+f6ppPSQDn7+jZOgmhRD
	 hsEBMnbr0uzK2J6tlVELtISuCJBMk3O0vUFA60SiKJl5eyKO9WnSe/LeHnuHXKJt1Kg2v
	 Q7N3lhq2gjyqDjgBtLCA09b3JsVK8w9W2FVcvy1EMnUe6FYaXjtEs6FdXg9gmq4oCSMD6
	 bKJIX/NBIfXT5qWG7ePZGJIi8GnuSIL9sPnumhj2eIat9grivXU44V5BrsuW7BJABoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321679;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=e6tmUSbTA8kI3wpkqOhoSuw/zjQHagh6vk2l/7Qyg7s=;
	b=rjQVUGMGqQzW5kHBNH/NcrULFKVK0VhDWpiRc8dsJfd/Wt79YyPNGiIuODjHzjt83JsD
	 C1Cwik0lpL/vY7lyMkDSiCHsWXCxPYj88kdIgLfFT73A2HGcD9WbsBuXs0DibgutUYm/k
	 cwmpdX9ClDVvwxbSYeorhk/ZNdDLy62Bpph99rL06LEbp3CIQTywVXun/gz4WamyapeUu
	 AU7hG58RXnkHx7hr64mVXfKmZpv0UC5aXaQSfa0U4zj8UdkFXmgmqGSdwLZ/crWSMfQXi
	 K6pFGE9SVStzYNZx0dV8Oo6eefx6lwSm6jNx/XQcgQzkxxkNfLb9EQeh8Aq6gxutI8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jWifvQaO;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=t4v9lJxs;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86A2606A33B
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E86A2606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jWifvQaO;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=t4v9lJxs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794321678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e6tmUSbTA8kI3wpkqOhoSuw/zjQHagh6vk2l/7Qyg7s=;
	b=jWifvQaOxQtWR7L3wfyXBXDnMcgvl7g/PsBcZ1aKeVSIk4Bwe7c77dWcB4fgNaGWvkqKxY
	d4FWFZM9kS7Ig40De98DeNLnhoDiwV/CQI5L04hhF1ZCrFfaJNJ9xmyu3S/0JSM7wZJazu
	tgmF/YBKruKWTgeKrKjhyIk/3w2Xq0U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-XAB1pRP9O5usL3pcDmlPCQ-1; Tue, 10 Nov 2026 09:41:16 -0500
X-MC-Unique: XAB1pRP9O5usL3pcDmlPCQ-1
X-Mimecast-MFC-AGG-ID: XAB1pRP9O5usL3pcDmlPCQ_1794321675
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a2065a2ef9so16694335e9.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794321675; x=1794926475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e6tmUSbTA8kI3wpkqOhoSuw/zjQHagh6vk2l/7Qyg7s=;
        b=t4v9lJxsDXuT21EpVxi2YjYy5Kaex6++wgkV19OfuHGPOFtxZGQ2EHsQraHrI2SzD6
         RhYGkUGGBi8Ce73dgdimTxWL1SQBwsu7U1DhSXrTQ9sVYlLEhgrbjNiW+JD8olIPpGDv
         d5w0zFC7vv6HtfoHDv+AjoEz5J14bpyGXs+O0Pfo1z7iCo+p4PcfktVIlToS0v/9mwL2
         UHi3itNoduyzWLS1sSxTr+2+LdpIYv2PF95OUrwQ00hDjqyTKY58hbBw/A+DGU0iXqSr
         xLF/IRmSYRoOu1uvuBuk5olPlEv4oaJbiHuj20g3VqEV+KzKpNx9cXlTI1gmiXVaJ3gS
         phOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794321675; x=1794926475;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e6tmUSbTA8kI3wpkqOhoSuw/zjQHagh6vk2l/7Qyg7s=;
        b=Tz5EL4+2L/Dg/O1a0Kniqok0ooh9htS/p5UxY6+3tU+rWkpD2RqVShHtoEz1KoyLQ9
         xMwws4TiJGsawm1Sk6YchgUt4VS/cWRDrrc3lY/uC+hpAG+JtBtL//9ZqpydSfT1rFso
         wnDYvYEQTuWPqQIIUuLWJTKd/M7yV4oSRSl+oVAF8E42Od6Qji6gNIU1+KiWW7A1QU4S
         pbZsNQJOcSKnRO+oUS8AZTlCDFK8FgPGPeaFyWP2dkmv+HePzGdzjpuTOLD8IyKn+4F2
         zPtZynKqGX3Zd+sHNKewd8+fbJGxjmwZJMd8aXo+7Vbk4nPuu+ZkOPAKTsUUSFlhBMKT
         Wzog==
X-Forwarded-Encrypted: i=1; AL+hErEeMR4F7vTl7kQPerb6Nu9yOoDBmzqBtPw4OD7ubuOy9GapqVhFnwsYllAV6P9kWrwF6Jp06K0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8UCARLSHeucRjO29b0DgJN+q0htSx50JYfSdhn0SOncTf+PcJ/
	iAflweT5APJqFKorYRzQeX4gKlK6BZ1uR/ziLNLC9Osy+RLYB09BpXf3bhxv6Rb74yFCe9BOsLZ
	NEJ3n1RABrnxVIMmhQn7xSsb4O0+WfMw5xcaCmKHFvqyt79j505W9SazjNNS30WLCYw==
X-Gm-Gg: AYBFou2Sqiy8jWu8VwztXgQUWMmif+a0ujm1gzF0olnvFDLiVEjZ41XUj6YZ/5KBVFs
	TYMVJi9jQGPy4BNWcaICtfKu9bkNsDEEI/3LHNf/O+s1n1YbYfvhfG5gvBw3C127TGFZlZGKinb
	KqsWZfAdKKeJU8SyXC2wbCzOkSbzP48XJQe2H6o9T8yOc/eqANQcsDIsr8q8TFmn4cWKjMsL/fo
	uNgV6UyZk7o6lN4u/xy2pxHEvMtulD2PYX2NzRZgSVyWo9umH/4Zy269AgIIaov079qJbxynO8t
	cYKnPU5n/pjzqKqGp5D6mqbqeWDfBtAcC9vN3A71ECeyK/4TWTZbtHdSkawwnTKFgxbTjve0580
	o0uhJjZ2UI4WIYfoIguXHKYlsJBp43+97ub4y03LL8uQmHlabLwEdpqu5x55CxYgCYoJoMV7QhJ
	KgS1Hy9jla+CgOPSEQ++A37xnIFQKZUsVsl84mh2F7qQbG
X-Received: by 2002:a05:600c:190f:b0:4a1:f99e:f22d with SMTP id 5b1f17b1804b1-4ba02336807mr53183075e9.6.1794321675128;
        Tue, 10 Nov 2026 06:41:15 -0800 (PST)
X-Received: by 2002:a05:600c:190f:b0:4a1:f99e:f22d with SMTP id 5b1f17b1804b1-4ba02336807mr53182425e9.6.1794321674505;
        Tue, 10 Nov 2026 06:41:14 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fe9357sm78127275e9.9.2026.11.10.06.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 06:41:14 -0800 (PST)
Message-ID: <1754e4c8-3b6e-4983-a7fb-d3444c1156c1@redhat.com>
Date: Tue, 10 Nov 2026 15:41:12 +0100
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
Subject: Re: [PATCH net v3 2/2] net: pcs: xpcs: make supported_interfaces
 authoritative
To: Coia Prant <coiaprant@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
 Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Fabio Baltieri <fabio.baltieri@gmail.com>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261102212506.3348537-1-coiaprant@gmail.com>
 <20261102212506.3348537-4-coiaprant@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261102212506.3348537-4-coiaprant@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 22:25, Coia Prant wrote:
> diff --git a/drivers/net/pcs/pcs-xpcs-rk.c b/drivers/net/pcs/pcs-xpcs-rk.c
> index 6f0a110e32d2..25fdc9c6b72c 100644
> --- a/drivers/net/pcs/pcs-xpcs-rk.c
> +++ b/drivers/net/pcs/pcs-xpcs-rk.c
> @@ -483,6 +483,7 @@ struct dw_xpcs *xpcs_rk_create(struct device *dev, struct device_node *pcs, int
>   	struct platform_device *pdev;
>   	struct dw_xpcs_rk *pxpcs;
>   	struct dw_xpcs *xpcs;
> +	DECLARE_PHY_INTERFACE_MASK_ZERO(supported_interfaces);

Please respect the reverse christmas tree order above.

>   
>   	if (!of_device_is_available(pcs))
>   		return ERR_PTR(-ENODEV);
> @@ -536,6 +537,15 @@ struct dw_xpcs *xpcs_rk_create(struct device *dev, struct device_node *pcs, int
>   		return xpcs;
>   	}
>   
> +	/*
> +	 * The RK3568 XPCS supports 1000BASE-X, SGMII and QSGMII.
> +	 */
> +	__set_bit(PHY_INTERFACE_MODE_1000BASEX, supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_SGMII, supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_QSGMII, supported_interfaces);

Sashiko thinks this last statement is a no op:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102212506.3348537-1-coiaprant@gmail.com

I don't think this is 'net' material, I suggest resubmitting for
net-next.

/P

