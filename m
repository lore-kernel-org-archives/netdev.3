Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9104F46D0BC
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787232732; cv=none; b=Zaq0Mqjb7Tf+i7cwSSRHAh/h7B1Zy2v8nQKJnEsMIhDfU/MUZqIm6+Ic9EDJ8PLdFuqjL2Ju9jmue5yYSB+1Elu6gyKKe2ssc+Df8Nty3P2tm1mj6vfdk8gxYrGysSAvhMCguJwjnJtNKuNltK/r1ty6C3yt/x41ete2GA66e7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787232732; c=relaxed/simple;
	bh=MHlt4Bp4lT/1oanoxOubTRkFrbNXcbqmukwFj+RYUGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADVw+VfzOQWMk2jv2oyeTm8t8GrdR1pEjsVJVCSYvEkljjEaRVJBw2gcw2ZjNmg7rvQVssngrlUBoEs9o/hhrwA2/OGL4b6pNgelYlKKgkYg/XofX1V0qzIuJlZsqj2MPoX1/mtEtlnxUuY6hBeYa2d75V8Bod5ieoDydvGzbUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NRjMQo/s; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qbv/QnDI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRjMQo/s";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qbv/QnDI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787232726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xpVTEUGVCHQRJ0rJl1+PNpG232N7cltDp8fFwuNrPoM=;
	b=NRjMQo/sV83grhulxSAg+R93+oMv9ssf0utnHHya6Z//zY+r09h02hgnF+W/5RzNQeCWIH
	bktBB3R8Q4uzANz1WcujutH0hAcQrYSBwGW3ekxlWtVQ9z+0fYnmBBPtYdU5cdG/cI4zKO
	DiTLzvsEccZXRq21vYpsDuFxO5aS2j4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-wyiPgquTPdSH_6pN0muqYw-1; Thu, 20 Aug 2026 09:32:05 -0400
X-MC-Unique: wyiPgquTPdSH_6pN0muqYw-1
X-Mimecast-MFC-AGG-ID: wyiPgquTPdSH_6pN0muqYw_1787232724
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f835ac1aeso1418364f8f.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 06:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787232724; x=1787837524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xpVTEUGVCHQRJ0rJl1+PNpG232N7cltDp8fFwuNrPoM=;
        b=Qbv/QnDIxOnFJlNE6+6yPQgmGAtFGr52Xe3wSf/LhTn42Kji2xCugIdA+6kyV/yrCd
         MiurN8hBBsxyOnF9bH8XOg+WbpNc0rs6Oercdmn4PuUpfOSWfSa+eNz0X/ZI8rCN3PPV
         zVrXUbONKSI/DJcta3vb7n7Hje4oaGhexi/kFuPM9g2YXcDsCkBkA6U52Rb0tzjP469M
         na28JcKdt5GanDdcdb5Txtyzdfu8R93jMe+vO0VRNH4go3/x5hWzw+tqR6fIewOCTz8l
         VWzUko6YEgYkCKMY+Y74Dykykam49jlIIn8ZNse+KbMmgtYJVhDvsZHhWx90AeeZO4Fm
         Hv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787232724; x=1787837524;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xpVTEUGVCHQRJ0rJl1+PNpG232N7cltDp8fFwuNrPoM=;
        b=ieWobGTODldLYLH+q914ngtRjZCYUaX0hE41L6weKFS4m0tHTjLeitFySrjTnWUt1j
         OrsnLCgnfTuOWjHpErRX1FSANnV4DTX0Nrfln9gBNCd+PqTrSTVcRxBWheFAGUWH9LgV
         jAluFsL1zEiutOqJCwRnaUPb/fsS+rsuKosbmGey7k8kn1McLbQaK2AOHqqiWGa+yd/5
         JA3Bd4DkJUwvK2Dvif/jpDB1Xxu6TefButDZiw6bD21kBuIpweapBfvn4Jueur8UvPvj
         e8gUef+JNsUT1/AFBTouj816tYn6llTzGml1Pb4HsCNfCJAvn41xPbvlM8dgGNqgkNd9
         QTDw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6IHnAHsA/wSY/EM5QlqF5nxr5y004G1JW6rAkBLCrT1klsmpi/jZEpY2N9lHvVT+zY/bGZIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4cxqdG3Axo7j22VKhYFazoc/G0Dx2waW4D4TI9Y4nasAKMRmV
	/i9sFwItYZqVboRtRYQkNxN4GGHOKoYvMtNSf2QiJryuz/bfoDG7omVWcaedvc6e4RvhD0UxylB
	u7IyQqh6cboH8BMoJ2WkBqeqTaohmbhqffzIdIexFsP6id2aqpCwxQS+Eig==
X-Gm-Gg: AR+sD11nlUdGbD+vXrDzlY4S3mbm6rC+hYY47AG0XEf+EQ2KZRIoipxNi0P7ZoSoEBH
	NH/fqpw5vOH3MCX6g74jpt7W5X5EdD06/JcGHi4ZNngByEXlpFVrrRL1ondc9586jTDWoybawTl
	8aRD2oJFdkeLn9hDtq4adVxDYPsU1lfPPXLNsRo3665T+n56YHO7ctRE78wdelS3g6+CUdSSB1k
	SPQ0K5DZMNjUOu7aQa96v8AGuT6Tu2FNsoZVh8YhZWbqH3eIaBzvCnb7X18QaG6eM7GJWLKo0yF
	BeBh4BobNWpg05qGNLQJydi9d+yHJWk++IzvyXIEWBIDgkRm8jazJRXgkvEGIxnbScJnt1vfCTd
	tfROAQRAnWTzyo+NTVYVmBGqcBErSHYPOQBNZAfGwhG0DxArGbJD4lS5QnU6H0lHhyb8wVZIL0r
	Y=
X-Received: by 2002:a05:600c:37c6:b0:499:858f:2653 with SMTP id 5b1f17b1804b1-499aa14b457mr236098235e9.2.1787232724211;
        Thu, 20 Aug 2026 06:32:04 -0700 (PDT)
X-Received: by 2002:a05:600c:37c6:b0:499:858f:2653 with SMTP id 5b1f17b1804b1-499aa14b457mr236097115e9.2.1787232723711;
        Thu, 20 Aug 2026 06:32:03 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b3c556a3sm31194145e9.3.2026.08.20.06.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 06:32:02 -0700 (PDT)
Message-ID: <ba6df9dc-d629-448b-ade2-f716391b5bb6@redhat.com>
Date: Thu, 20 Aug 2026 15:32:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: marvell: mvmdio: Handle errors from optional IRQ
 lookup
To: phucduc.bui@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 u.kleine-koenig@baylibre.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260820111612.98011-1-phucduc.bui@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260820111612.98011-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/26 1:16 PM, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq_optional() returns a positive IRQ number on success or
> a negative error code on failure. For an optional IRQ, -ENXIO indicates
> that no optional IRQ is available. Other errors should be propagated so
> that the caller can handle them appropriately.
> 
> The existing code propagates -EPROBE_DEFER, but ignores other negative
> errors. Propagate negative errors other than -ENXIO.
> 
> Found by manual code inspection.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.3,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

