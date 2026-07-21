Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF9B390CBF
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632764; cv=none; b=DYLr0sCFjJiD1PI8S/VnoLbB9Mx3TbM4axdBmKv1rv7zsL4KQXQd5UFkDu8j2NsTiQzzZrKE3nCkEaV0/IMc9lUjJFUAoCkHeG3sxVKoQEduSK6vKUZev37DMUWp4Twwk2vn3VvyFt8RzHfdWo2w9/lgkBuzE+NEfikKHjo9rHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632764; c=relaxed/simple;
	bh=xJAhNcViqgxaoHWIEmJNFrtF1OLjmyQnDUZ3IbhOx9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKmHdQxoAI1K6M4zuRE2JDvoCV6SLBrpJBOQ1dn1wRkWl0RJxhstPtYvKmTBLOj3KsnmCFhjQ63W1vHe+RHTJsmAFLXRBGMXuW82kFIdTssmXwGCcn4PODsj4KeMK7tym4X4W+fZBAHjnC+j1S3dwZ5kN6dii6eLPTkLYZW+lGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTgCD0ue; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OWeZ3whz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTgCD0ue";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWeZ3whz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784632761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckJwF9bZHsl72YuWwH3NmbK3C+jjMomDQypn2jeRFnE=;
	b=gTgCD0ueU3Ghwx/GAhT/1I+maRCKMZ66oH4O7YzoFbFK4wkkzKyphalKLbX843wGhv1/UE
	VOG2LCJUid7qkaVYjFauo2EujNe4medjysFCd/4ELP8IX+y3UxaO9V5Vgeah4AMMjkG2Sg
	mLijkpBuVuaxdZOwD9w+oJlBfc4uKdQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-MTTQEFGfOz-j2A2PxyX_BA-1; Tue, 21 Jul 2026 07:19:20 -0400
X-MC-Unique: MTTQEFGfOz-j2A2PxyX_BA-1
X-Mimecast-MFC-AGG-ID: MTTQEFGfOz-j2A2PxyX_BA_1784632759
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f810c8aebso309409f8f.2
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 04:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784632759; x=1785237559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ckJwF9bZHsl72YuWwH3NmbK3C+jjMomDQypn2jeRFnE=;
        b=OWeZ3whzxU4G3rLmTNLnFvWiYl5lbG53I/h2VL0uxB7Bnl8azlyH05y4vyeeKx1gY2
         3A4tdu7mJvCdo/t3xEDNJEsD0koflTvQKDygO9Pg5+2IYTDPsRHlOG/zNcshH+m3bkf2
         tx2K7YoyEraHq1Bv+AS672JAI/+PZ8GbsmrlSQ/ICPkIbE6zuyBFrGKC6Qxb5v3dKBRL
         UO4qDFCA+UlBXnCcuZmw6/n+xLr4VFSCJEV/V5KIkBfdKCEaIUo0SZ18u0NAwqGwC/GC
         c57VnRAt3yFxE0j4Ikcd3CcvrkJj2shIUJWem2qAXgacOFRH5P07JtI1FfaBZxZ7n7S9
         Ox8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784632759; x=1785237559;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ckJwF9bZHsl72YuWwH3NmbK3C+jjMomDQypn2jeRFnE=;
        b=rxdFXuLqwSwWWvnsKmUCyQn7Lk08LimSqemYnDTt8z96+mBNIYAa5BqfRdVDV8FbdZ
         yHOK4JOKj46YfxP6UvGGH6NOWHCxKz4MvhuVnYtUeIq+o4j5TjXaD1CDNo0sa9yXgt12
         VYDmOMRQRsluXNdTqVi+vHSUBTk4Xgb9jmR5dPwt0VVC6SZFKhE+pm8eMrDAxAPd4rt2
         cayEmYo7XOjuZdFTeWtHMkkhl/mDDCQYFlBS14mACYC5CBwDuTP5CoFT7SbLuVVbnSXV
         rlxBxFwtwVNhg72IgRzgN31BVDI1WhClUL17L97vFyeyJExHwxB/FWIJW2KRuRsjk9KY
         nlig==
X-Forwarded-Encrypted: i=1; AHgh+RrVH8pV8JhDSY0xPJT33+eEtCiVvakKBADk3c32DqEvGn96HEzxw4aGsWtGjWXes0t78WDWt/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyst4bCoNTsKiBy8KNTiqcBCnunj6RhYCLwx0hFnHhMZ+4+lCF6
	L8AD6ZTZc6EMfi6nsgkSyKOflt1qCMgjy1qz+b3psiiNR3oSab6LUFZEcnrIK5noU1VuhiChJkF
	SZNHxrm8Z9R9m6ykXcFftPoHQfytJTAqy+z/Uyt1kd26oVLttUqgW6P1R1g==
X-Gm-Gg: AR+sD12N5yEgnx8kHi2yUqozXGOPBaKwMrj+w/GrduRHgCmKnHw4FTWJntFDld3btXa
	exr9dTn7Eupb7KjdmyyTJG7ie76C9E6t+RzCfGtxTn7r7Pr5R4MIQj8vyaclRZ2UUEDMac4MNa/
	YvNtQ7ggaLdY9uN4KNz1/7Q1HsC8OxXt0iWTvTp7DP6kQCXonxD0LPrKYFC00PCd/grtFe6vYAD
	/6EpqY/tUDYJZi5jOSSRn/TywbUflnWfQkBkPnc5FruCI7/nbVOq/7flfOwUNiOMCZ1IayeEVmw
	cGmL/QuPyNPC0gTCQMaJyMjsbddBUP1kqEGygrpQOj6J1bzjJzZljUahpe4C+tiBno70MTq/68J
	U8JPlRMZQcnUr+gMBusUjKeKucWZe1y5R9YgvHWy33Z78APV6p62pbWNDF9vcICCZeE5caoa/qn
	eJsw==
X-Received: by 2002:a05:6000:25c6:b0:47f:7786:b00d with SMTP id ffacd0b85a97d-47f7786b077mr10477190f8f.24.1784632758952;
        Tue, 21 Jul 2026 04:19:18 -0700 (PDT)
X-Received: by 2002:a05:6000:25c6:b0:47f:7786:b00d with SMTP id ffacd0b85a97d-47f7786b077mr10477122f8f.24.1784632758406;
        Tue, 21 Jul 2026 04:19:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eeece9sm37465633f8f.37.2026.07.21.04.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 04:19:17 -0700 (PDT)
Message-ID: <03f49d98-c6e1-4dd2-bf25-f42e424fd59c@redhat.com>
Date: Tue, 21 Jul 2026 13:19:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vhost-net: fix TX stall when vhost owns virtio-net
 header
To: "Michael S. Tsirkin" <mst@redhat.com>, enrico.zanda@arm.com
Cc: jasowangio@gmail.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, kuba@kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, eperezma@redhat.com, nd@arm.com
References: <20260708152242.2268848-1-enrico.zanda@arm.com>
 <20260708124901-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260708124901-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/26 6:50 PM, Michael S. Tsirkin wrote:
> On Wed, Jul 08, 2026 at 04:22:42PM +0100, enrico.zanda@arm.com wrote:
>> From: Enrico Zanda <enrico.zanda@arm.com>
>>
>> When vhost owns the virtio-net header, i.e. when
>> VHOST_NET_F_VIRTIO_NET_HDR is negotiated, sock_hlen is 0,
>> meaning that no header will be forwarded to the TAP device.
>>
>> In the current vhost_net_build_xdp() implementation,
>> when sock_hlen == 0, the gso pointer can point at the start of the
>> Ethernet frame instead of a virtio-net header.
>> This results in a wrong interpretation of the destination MAC address
>> bytes as struct virtio_net_hdr fields.
>>
>> This can, for some MAC addresses, trigger -EINVAL and return early
>> before the TX descriptor is completed, which can stall vhost-net TX.
>>
>> Before 97b2409f28e0, the gso pointer was set to the zeroed padding area,
>> using it as a synthetic virtio-net header. Restore that behavior.
>>
>> Fixes: 97b2409f28e0 ("vhost-net: reduce one userspace copy when building XDP buff")
>> Signed-off-by: Enrico Zanda <enrico.zanda@arm.com>
> 
> 
> The fix looks good:
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Sashiko thinks there's something something security here, but I think
> it is misguided. It's just guest hurting itself. driver breaks the
> device it gets to keep both pieces.
Out of sheer curiosity: which sashiko instance? AFAICS both gemini and
nipa are clean:

https://sashiko.dev/#/patchset/20260708152242.2268848-1-enrico.zanda%40arm.com
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260708152242.2268848-1-enrico.zanda%40arm.com

/P

