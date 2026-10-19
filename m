Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1E44F4750
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415006; cv=none; b=a6yW0MzfHuWtt1GgdnB+di9dlgftkqhi/x02VB58JrmNHw0xzqkGIkq+tvbZm+CqaQLLf91eiG4uU3ko0bjSn2tnIbU70ECjB/9R4783A6Wy5OqIbxL1WsdYkPRAYW3Fofsoj3dL6G+uQ8jmrA04NIA3gtaqp1Jk154QD0mMoZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415006; c=relaxed/simple;
	bh=QNrIDKsvgeRp/5paQVQcPIJk7NtUHcicaHd6IPX9Vh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pS87oSRnQoEii6nWC84joxFkUc/my9FlL2KD1LS1qcB8a6nXAWOIvtR749h8pMqk2OSc3/wVV3tnXmBq8EUaOlyjDAS4OaPpJ4ssvVR9wHKmEWiCWQjgfzjz0MF6/UBVMACPGk3htBkCFed7kYbC5HJUS5nRdWIGuZIMja4R0Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BDC2cjrH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSQbeXMZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDC2cjrH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSQbeXMZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792415004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNrIDKsvgeRp/5paQVQcPIJk7NtUHcicaHd6IPX9Vh0=;
	b=BDC2cjrHwdzrEqh9gPz9NK1mDPDe0ddeXpmWFZxyEBDCOTi7t3/lRcwMdgjQx2F54adDsK
	kxJHOG9P5NP+kJhSoDbOedJUJKS1t777A5qX1cTwRzdYMKt6wxy56xbBKSltOv6MGlKzbk
	E/Aib8GPr8MdUWA4wSHJF4hjLgVu7ks=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-oa3S0VHsMO-jkFUSIcVyMg-1; Mon, 19 Oct 2026 13:03:22 +0000
X-MC-Unique: oa3S0VHsMO-jkFUSIcVyMg-1
X-Mimecast-MFC-AGG-ID: oa3S0VHsMO-jkFUSIcVyMg_1792415002
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48b00febba3so1901418f8f.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792415001; x=1793019801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QNrIDKsvgeRp/5paQVQcPIJk7NtUHcicaHd6IPX9Vh0=;
        b=QSQbeXMZOL5183Y+WAlt+m6vDI+s5P8c5s8XI5GaZR8dl1YROpEQJg+li1FdU9DUy5
         HD2cRk4QGkbulVlcEZmkCnJSYhDxJ5GDHXMU9OkXpDywfy6vVPQnelB48i2cb6BssC1n
         vILt6WEjhqeNXG1m4f6acOQORifl5LddQhfCoB+VkwrHUOAso9zWKX9ihl0hnnyKmqO0
         xNtjj+4w1+0Q+kcW8m6/GDE6GDtKwhdr1xOcF2bwxvtzAwKZstx7PrKRM25Q7ENZTCCb
         AD3G3q/5x6cvsS8CNJNPZQqJ2O7TNJAuMfqxV1n3RacaWZ47o7vqKcE4i46LFkKiu4bS
         wLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792415001; x=1793019801;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QNrIDKsvgeRp/5paQVQcPIJk7NtUHcicaHd6IPX9Vh0=;
        b=EGlLjEiSowbKu0UweBAaDJe8/tDVXDHUpUW7QXSAgUvq3LaPDaL6kFk3DipxPpd9U6
         CG2L3cbgn2SazRNBOpMebwjpnhnNC5kz8+SUoTgcT8HvPFJqK4d2lkh5J7ZsXp8tZKS3
         tYpd9KEC1uUuTQ9ZYI5/if1i3/6hsB0fhhkaHC0OKbXnwTH8hFnYyvjl23FJS3kLaYx0
         29l5dJQAxZl2Z5lUgMiMX65ZwGqFs9l4fjfZ4m4xPN5igD+L9DsVK8j9NQ26BQI8VyhJ
         JLk0D1a6uHOy6zz3RF9IChF5DvnayJf3/HTQiYraplOOvr/sQ+qI5uucKpM7GKcK2NHo
         veSQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxKXzzkL9ZNBdYx75nl2vbOiJ9jydXfVz++Hs5if6d3MNOmUBtkmf3C5FN4LWPLGSuVj3rT/M=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2wB7tYQ/thJLUlDtq9vE17M7hafiQuDlhTowbyjQM4l/FdBLj
	u21rR5n0A8OKZpqEfnO7dWI/yn/oesWvEW7MeQENJYB7VwqpbMTUZRQW1WwHdkbJ7nGHvZVx2io
	6FiiEtByP9M4dM+h6LwmAC+o5sNQ9TdaCB5td4jMtI02nCJjSFCqkcXh5jA==
X-Gm-Gg: AYBFou2UDAy22rfc0nHIXtn4z1toBSW4bvpSI53Y3oV6c4BZs0nwfGnk2+D8h2icYGP
	LCg26KDpAS2u+FhozZhCsBoRJietW7emwinl/pYDQP0Ahj0NVk8Nn0reFFp16cJYAOyHAhm44ay
	priRwfJXN2eh58f69yshZlkF+svw1rfEMz5kBDIvaWH5Ap7t9UdPJzg6M1wci7Knwb1u2RMqvQB
	5ypXfnsQWc9faoGzjqGhhDEBUjSj21BTIzPGHXPoyIV+2FeBmGFR4dShQeT0R+1VChaaHXMtVVE
	pnZpiMArX5vnCDXGb/zbdZYFgSmIlxGhl80475PF5j9HuPTmx4SICnHkHD0gYNUiljIMUBzf+9C
	+0ksVATm4YFdbNW0EcO0GwC1RK1huDwv9fV14/aad1Aq2LHSKkKXBXsDdjC8hh7PJZtlRBBeINA
	==
X-Received: by 2002:a05:6000:290f:b0:48e:740:c945 with SMTP id ffacd0b85a97d-48e07f9eb4bmr15189661f8f.32.1792415001427;
        Mon, 19 Oct 2026 06:03:21 -0700 (PDT)
X-Received: by 2002:a05:6000:290f:b0:48e:740:c945 with SMTP id ffacd0b85a97d-48e07f9eb4bmr15189570f8f.32.1792415000735;
        Mon, 19 Oct 2026 06:03:20 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfdc4eecasm22733073f8f.13.2026.10.19.06.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 06:03:18 -0700 (PDT)
Message-ID: <5f01c934-990a-4fac-92e7-17d1e4949aec@redhat.com>
Date: Mon, 19 Oct 2026 15:03:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: korina: fix dma_unmap_single() length in
 korina_rx()
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20261013132319.22253-2-fourier.thomas@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261013132319.22253-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/26 15:23, Thomas Fourier wrote:
> dma_map_single() is called with size KORINA_RBSIZE and
> dma_unmap_single() is called with size pkt_len which might be smaller.
> Therefore, parts of the buffer may stay mapped after dma_unmap_single()
> is called, which leaks a resource and might leave exposed mapped memory
> that might be eventually freed.

Sashiko noted this is actually a cleanup and not a fix:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013132319.22253-2-fourier.thomas@gmail.com

and IMHO with very little value.

Dropping this patch.

/P

