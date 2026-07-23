Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A9346E013
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784805936; cv=none; b=r9kU/b5PkkXNQDevcMBZX6UM+25fHjEYwKQPj6eELEC2yc9I+pIoCELRuZ/XScL08W6PBq4O9LPiiBn1GQRUs3musCvB1t1PquxjfHqCuQVZ5h4iIdw8BmniECmRWek39K6XYUshzj7nB2ceh9qQx4MbvuKwNQ5X8/cWXQV2hbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784805936; c=relaxed/simple;
	bh=ZcmnhOKniZwc527ZELr7zQizE70j/om2eAuHBgP8cGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NuvDyKvhUxqSGaK2MbOp2YmDEyzwpNalwxpvGeOXnEvxXRKREP/G5wwrGCjk7V0ZEqy2xmK22hUshydOeHcgs8BDwy9EZaq1MlgB+djfs+qFD6aGbozQSt+XUEQ69npF0pxrJEUK77RGAUXUDFrQjeAT785WwiXoNQ/4f0EDI/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=djapgpWb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lNSEyNxn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djapgpWb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lNSEyNxn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784805933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXrbOpC3YLfit5aNhXIcynE5RNffOo5pmBqtQCb+v8s=;
	b=djapgpWb0EDcJnka15F53dIj0jpdc+/Fv/PxQIRi8Mp5P715nFCzJUCFQD4GWn+meekFzU
	RRbtZPq5AB5rHYb9FIxWCm/OTgTx67XEoqp+uiUXwhkyyH1NpPBi4Y3KBIylRC3Wkev9Yt
	8AWhkCursEgtiYEqcdFL2ql2mpcZXXY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-LBEQdIG6Pu-GIFCOe-Rj3w-1; Thu, 23 Jul 2026 07:25:31 -0400
X-MC-Unique: LBEQdIG6Pu-GIFCOe-Rj3w-1
X-Mimecast-MFC-AGG-ID: LBEQdIG6Pu-GIFCOe-Rj3w_1784805930
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso5045905e9.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 04:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784805930; x=1785410730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PXrbOpC3YLfit5aNhXIcynE5RNffOo5pmBqtQCb+v8s=;
        b=lNSEyNxn8dIAYew2D1OLsGUys/smRq3kgV+9lmb1OyQ+Uim12baYkJue2dtO0/TkqQ
         eY5ijtHIJk/4VEjHgEE+tEGJIH/DxRRppx8PDOAJO4PIFPmIuZL5gozRJxpTWR9KpO97
         ecQUOsPBFGxdjOapLm3f6JVVyzru0zDYP/mDTBc0yIn6JSh341Ao4sj53xg1hzDYRJD1
         KRDgveWs4JO+9rOaVw9gJHbBIYZeh3ZiWCweyEjz8KKNt/ESyDA866W/aIhjJVu7oRuE
         W3FarVvVltEis8TbJicAc4lV0xrfPvvsc4DwwlRSErbFNTHdTMVT6i6sEI//ECLAbMfb
         QvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784805930; x=1785410730;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PXrbOpC3YLfit5aNhXIcynE5RNffOo5pmBqtQCb+v8s=;
        b=Bra7GDNMfp5rAOsVqvGzbjsRcFGbAM13HP3FiCAd8JTG2suh52RclZtoatlOHhEiug
         ptB+DegS4OU7416g7hACzmrJFpujVTIfUCd6tOWU96eOVZ3CGCFYLIWEuDpcyq/gGqms
         wd+fdFrAyq7mRSeQo+zbcwcB9f3PCA1bdKFnbu/y48fQ5/bP6i7gtWPAyTfclwfmvyu7
         +KNz07D4TfFATcIC3V2+o2TbnZZlZ14UfcgaNe4+K8VQgyPnrV7r5KqU0/KZtpln7d82
         IXXdHikA/9XAuNoMGpV1iLOkvjhBDSezJ4v/CY9O9RYZ0mJRzIklQjgAfQGVKHq9wIXv
         j8fA==
X-Gm-Message-State: AOJu0YwDcY8L3lXZQ17T2TqpcIqEp3OEc3L01egz8i1MUrtG0OOVQxaG
	YEVVUduhTyKZcGThcR3PIIR99ng8uqg6gpHbVz+d+1jUHD/RU3Fw2nguhKFFjumprRxE0BaJxJr
	GtCYb2O9ejil0wQQ65BPYHK8H7MqrvNZNlufLVD48jqdZh/8BMX9WP+xTOQ==
X-Gm-Gg: AR+sD137BH+H0OVEULBInTEgeIgLDMhx+MMyJl2BVsUmN2WNUTvZ0Mi5rPnyw85DcN5
	xS1CZNpJRkCiyJPVchLLuDOEy61bn+e3DjOXW/tvxB5rdA0MYjpGuTJD5AGKBgjSFSY1apOShLg
	NOvaH1rMRPA2CfdGkczWa6gwd5Ev4jvNsvdEjKr1jAVpkfAgMEdx8yFkqp8hE8j16E48CQ03uCW
	nEdtK9E+E5syJ5eROHvME+JsNcDdZmjmxu4JW9mM/5WDDVZtyytBs++zkj84ZUweRap5YhmXC4E
	xAvoiwogffijTzupYNmeQTg3QRqDpVOF6SG0r6QOgSb328lEV4FmKL4eTdhfTDiFk+H09M3UMzj
	XtSlMQnUfl4mJ1FxWWzn6JpqfQJ5nrLi3EkEvFDi5Kls5zhHuJeZJ0J1J0XiHOZsF6V2U2qKgwO
	xm6Q==
X-Received: by 2002:a05:600c:584e:b0:495:8a1:7670 with SMTP id 5b1f17b1804b1-49573d20739mr20996005e9.35.1784805930445;
        Thu, 23 Jul 2026 04:25:30 -0700 (PDT)
X-Received: by 2002:a05:600c:584e:b0:495:8a1:7670 with SMTP id 5b1f17b1804b1-49573d20739mr20995755e9.35.1784805930014;
        Thu, 23 Jul 2026 04:25:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a500dbfsm129233605e9.6.2026.07.23.04.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 04:25:29 -0700 (PDT)
Message-ID: <14455fa9-15b8-424d-aac0-b74d7da35f04@redhat.com>
Date: Thu, 23 Jul 2026 13:25:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 11/12] net: mctp: usb: enable v1.1 packet
 spanning
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
References: <20260713-dev-mctp-usb-1-1-v4-0-4ae8de764a01@codeconstruct.com.au>
 <20260713-dev-mctp-usb-1-1-v4-11-4ae8de764a01@codeconstruct.com.au>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260713-dev-mctp-usb-1-1-v4-11-4ae8de764a01@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/26 4:33 PM, Jeremy Kerr wrote:
> @@ -333,17 +345,20 @@ static int mctp_usb_probe(struct usb_interface *intf,
>  
>  	SET_NETDEV_DEV(netdev, &intf->dev);
>  	dev = netdev_priv(netdev);
> +	dev->span = span;
>  	dev->netdev = netdev;
>  	dev->usbdev = interface_to_usbdev(intf);
>  	dev->intf = intf;
>  	spin_lock_init(&dev->rx_lock);
> +	if (dev->span)
> +		netdev->max_mtu = MCTP_USB_1_1_MTU_MAX;
>  	usb_set_intfdata(intf, dev);
>  
>  	rc = mctp_usblib_rx_init(&dev->rx, le16_to_cpu(ep_in->wMaxPacketSize),
> -				 false);
> +				 dev->span);

Sashiko has still something to say:

https://sashiko.dev/#/patchset/20260713-dev-mctp-usb-1-1-v4-0-4ae8de764a01%40codeconstruct.com.au

and the race in look real to me.

Note that you are expected to act on AI review feedback autonomously,
either debating it or addressing. A reply on the ML is expected in
either cases.

/P

