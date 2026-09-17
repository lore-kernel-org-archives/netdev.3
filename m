Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C004DD3D7
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650055; cv=none; b=dN4OjGwlneEn3C/xS4W4Ztep6IsT3z+A0QnL/6atw8EIDcCGrdhQ3fqNr0rhO4akY3PGZQ79jP+ig0jxQo5IgVH0kPv13QZCdV0Fv/P7/k94b50TjNbV8GlSUmZP6J42xuY2R0Pi+7TAosozp3KMe1Iu6X6eoAbe+JU/6fl/yFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650055; c=relaxed/simple;
	bh=vwgRYswkmFYVOj7RHSLDpXjS8/vNLNG+d/Pzf2YpRbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q87OKPy/AKCeWOhXKkBlOXo5MnvTHrCWZEJA81d8SkBJ1H8ruulkgqD+j2zAHGs519m+ahVgO3CMd5Vd/B6Qm6ZWTeuTPAueosjQiS0wRirQj3zxBnNOACunwOI9aGz26WfVF/bWhCJtD429yN69egNHZfmnMTuhyz1Bs/DeGt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQ0AGg9c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gYU1mMVK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQ0AGg9c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYU1mMVK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789650031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ouQ9UMJuK7mTop0Sws+ZpuUFqnmqPSVJ5MDQLtIoDE=;
	b=dQ0AGg9ckFvXLcEiMeLqyM0AnHSU4twP5o4NRFCOx98Cqj08QgVOn3Iv1/GViV2wsv4KqY
	IX7dakL6wq0RydoFO7Cdz3eVK8jysK7xk1QTTp0+pDr5XIIC840yOmx3tg/+lBt0dQ249M
	gqZuQh05Mp739+JQimy2fG4UWU/Nguo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-ztRGwRtbOzuRgBN8AXFsgQ-1; Thu, 17 Sep 2026 09:00:30 -0400
X-MC-Unique: ztRGwRtbOzuRgBN8AXFsgQ-1
X-Mimecast-MFC-AGG-ID: ztRGwRtbOzuRgBN8AXFsgQ_1789650029
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-486f768517dso613308f8f.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789650029; x=1790254829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ouQ9UMJuK7mTop0Sws+ZpuUFqnmqPSVJ5MDQLtIoDE=;
        b=gYU1mMVKxpIL7kVEhorRkqxxcgyrl5GASp1nooXcYDHSkjUCcqaOXNE5HSK7oSDnV1
         7ZbyUbuhQiUyFL2EP9LJtB+pvx3uav+XVIMrI2xZRN2pIMKmnVft0tC7CnRuBTy4LTXK
         xQB7JcuIJ49HsIKOuVyfxWiejbrJK8zzP0qdyG3h4e0Z1paX42IuO13Eg40uZ9cgO1A7
         DTGimitjeeBb70bEVz9SSIQnxMuHwz/zZmP7W3kg04BTHbE0XBPJ04AeBqSkZ2N3kMn1
         AfTDkcU7LITdCgU1V4zTBev9c2k//xBDWNN0gAhLJKZ8HTAzedgvI/TfOQTuiz51SBgj
         37+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789650029; x=1790254829;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ouQ9UMJuK7mTop0Sws+ZpuUFqnmqPSVJ5MDQLtIoDE=;
        b=VNHJPTsWsUk2ukntkKfYnykNRGce4uDvdTKDkWKeugGNwxuLVOfPl+0pP+dE+cD4C0
         BAa3xBLUWFMxs8cD/Pmw1UVjFMD4/XOOWgEOvdjyPn3kJ08Wy8X8OtaVbYZNrJEbtU40
         r/mFrW/tDcZ25rSuXiDdUr3Ffg5SY//CekwtM66FyYrBbHUc7acdGA9YvOe0qDWVLNPc
         OsquaevMnmpyY/9u7gMbVCurNWC8Gq6/Y5dRGOdu/mMS5TRvcjnMAXhErGhSUy3tkhsU
         Ur2asRILG+zaKHrEQVAH0cAwfCDUsKBug8vxnauB1hjHknOcSr9eOxwQbfNFXvKdN7A3
         0aOg==
X-Forwarded-Encrypted: i=1; AKwUvBwqSxToKJG+Vgj6WoGAEqrcTn5WDOMbwN9wnWbYso/sTTdkc+52jSuFaR1riAhrK3e7cJ+ap4Q=@vger.kernel.org
X-Gm-Message-State: AFuF++n/ixNouT2pf7QyoatR6MkGN2IZzGilhF0p2ctvDwHC0VCfn5hP
	ZjFTJUxXBnsRZRszL5NzGcbMvfj3QD1QWJuIrwnd5rMZJOsPklpqWiBIM/F2vdpXPsi4YqmaMyZ
	7a87pW4gvVXd1JvdUbC0wxvzC3zA7ggONFoHopZ76c/RKYA7AlFVwsT8Ang==
X-Gm-Gg: AYBFou25fdfPJBeyKUMUyWhQy+WBzzn958AHepEARZNh42QJTfVWqJyQwgMcp2UrAAD
	C/joZfToANKR0orGNf0+4kZKwjFdZ7DLGW4t3yTIBxR94mR8nfeZiF40tQpwyQhLwsD/zMRVq4I
	CT1mczg59Ia5AaPPtFbdw6LKdgGmDDiYGunZrgH7n6xwVtlYaf7vbldoj4cO45RT+Lb/nlmGpdA
	Nae5p6Zl9nXsy70KDiNo2wljGaYDcdC9cB6DUXD6j6xyuhK2dJY2hl1LdwbSdm7bep/66pX5kKg
	vzcpDtVF25upzcSCBaH9s2N8qQIc4POapirGAIB0xUezcxITSz4RQ0QgYzOdNl8335H+j5ItKnn
	0JRm7OhiAAnmv8tY8qOmpKSwbvnigIIIe+cwE0Ec0XV9j1MMVHvZjqF4Vf3toE6BMeB7LW282TA
	==
X-Received: by 2002:a05:6000:2089:b0:487:92e:c608 with SMTP id ffacd0b85a97d-4870ceee268mr16040963f8f.1.1789650028875;
        Thu, 17 Sep 2026 06:00:28 -0700 (PDT)
X-Received: by 2002:a05:6000:2089:b0:487:92e:c608 with SMTP id ffacd0b85a97d-4870ceee268mr16040713f8f.1.1789650027358;
        Thu, 17 Sep 2026 06:00:27 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf342a0sm15323682f8f.24.2026.09.17.06.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 06:00:24 -0700 (PDT)
Message-ID: <ab569155-f779-427e-8c8f-1dc5315fb0ff@redhat.com>
Date: Thu, 17 Sep 2026 15:00:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: usb: catc: bound the RX packet length in
 catc_rx_done()
To: Aamir Ahmed <elb12345@hotmail.co.uk>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Peter Korsgaard <peter@korsgaard.com>, Ziyi Guo <n7l8m4@u.northwestern.edu>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <AS8P251MB00015FD7716F38C345619B56C8BB2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <AS8P251MB00015FD7716F38C345619B56C8BB2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/26 01:06, Aamir Ahmed wrote:
> catc_rx_done() walks a multi-packet URB, reading a two-byte length from
> each packet header. Its bound, pkt_len > urb->actual_length, ignores the
> header offset and compares against the whole transfer rather than the
> bytes left from pkt_start, so a crafted packet header makes
> skb_copy_to_linear_data() read past the buffer.
> 
> A length below ETH_HLEN is also accepted, including zero, and
> eth_type_trans() then reads a MAC header from the uninitialised tailroom
> of a shorter skb. The is_f5u011 branch takes its length straight from
> the transfer, so a zero-length URB reaches the same path.
> 
> Track the bytes remaining from the current packet, and reject a header
> that does not fit, a length past what is left, and a length below an
> Ethernet header.
> 
> A transfer shorter than an Ethernet header, including a zero-length one,
> previously became a runt skb passed to netif_rx() and counted as
> received; it is now counted in rx_length_errors and ends the walk.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
I'm sorry, but no minor fixes for legacy drivers.

/P

