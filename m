Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599ED51AFFF
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689152; cv=none; b=k0gaYViXY1yLxwNJ+5bFZRxC4qzMgvla9kAZMsN4BRS8zF0PwzZRfDgVmtAQWN7l/hrhnZiJVzSkG8k3trUABGd6n+HYgTeEduFpBW+gePIeJB0FgbfIoUe2khNbcNEdmTXfwiTFxM2abaCgywQx3s3PMhuhLD7Mbr4+3MuEPCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689152; c=relaxed/simple;
	bh=bX0vghnpJNEcep57BRAwSFZ8AVgRzOA1zDESa2UhD8k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nax2UpBxmLi1rVRJBbJm98SoqLw1KvKMtUsMgpWpsIC0CyDRC1ctApjpk0iBKsnVVAOCIlOId09th16ZgE6Ohe1nZI7SPuU8yNGuzzYZAoIRJKlbLlrggvHMUspP6s4uTCwwlkPW/dNwnSJaIo5/gbEKyNZm7Y8Xre8IXSGXM58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLRNN3Z/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CM/BjlSY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLRNN3Z/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CM/BjlSY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790689148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bX0vghnpJNEcep57BRAwSFZ8AVgRzOA1zDESa2UhD8k=;
	b=VLRNN3Z/7GIafT1js67iA8cQ/d3r/HOA1VLDJz92sXY2m58CtnMcsyN+4k9TA9Oh2Ar4ka
	DpF85V3j2tlzXE8IBRi6oEeFq3RxHqzH8CSP3/wjwiZwnh9HHZctKxMCxGWwIKFh5VEBeR
	4a1fglCviMHxC+u1jqen8QQ8mNsKCpk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-bvfBmUk_N0-FEzxhlgYkRQ-1; Tue, 29 Sep 2026 09:39:07 -0400
X-MC-Unique: bvfBmUk_N0-FEzxhlgYkRQ-1
X-Mimecast-MFC-AGG-ID: bvfBmUk_N0-FEzxhlgYkRQ_1790689146
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49fcc575709so42831665e9.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 06:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790689146; x=1791293946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bX0vghnpJNEcep57BRAwSFZ8AVgRzOA1zDESa2UhD8k=;
        b=CM/BjlSYOvRZITxz4Uedg0Tk/wr1Qki3VlajsP9tUltRN7Yr9vgrni0ttA060wJ+jm
         z7jJ0k106D0aYEvyGQAjGzlRw0VVss1ulM1xlrEtnRT61EeqnQR39v+6xCdI6iLvVWKP
         XzL1NomPtkiZRvSTPi7ZcVNfvHbfS+TMmBNSpXsG8Ki6+0izL1ffiASYYlCDvQXYwX8F
         nE7qqGEzwwCVrLNOpzNHKoiznPUte8+MStS7Ghu/VQ3D9f7n/DoaT2UqcF27ltsUpy7/
         iLIaCxulSHebxCfRsoEhHKLWwvUq3QARxXQ8yVQmojINemHDTjOlrCzQR7/T1+mjElUc
         vwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790689146; x=1791293946;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bX0vghnpJNEcep57BRAwSFZ8AVgRzOA1zDESa2UhD8k=;
        b=XtqyjUUlClLsu/n8e8zYf5aoIxlsswh/ZGG+aj3b2Qyf0euPVmykqkTJYdlc8w4nFJ
         5PlUnNe4ztcUIJIEN4gqnDklK/vbHWGvuGnoNrxOcxtb1qrShJbwPytpJndVM+fxkem4
         C0rjJv7a2BIk8uNn8S/3nD+rGkEg05VtGHmFOtacNg3iigc96NOH7znKs0JytxYpHS/l
         kbQ5dQGuKFdfh/9pq9bYN3SZgtN9pQ47pG4rdNhajMjcY2rTrCSTYtliLQLic0RTwkTI
         bzMli9a6ELmTkyRqrdq/NnQON8O+V2dSNvpWOJA1iP4xnTVXH4lYBBT1AE7y0lNmZg9C
         vzRA==
X-Forwarded-Encrypted: i=1; AKwUvBxtSA1XbC4L4skpx2BguxyFg+ILEPmaGcDN99z13nsc854j7Yiymf3i8BeXgNYp4hZOJjqDtaY=@vger.kernel.org
X-Gm-Message-State: AFuF++m1zUNCCcrUGNhOKAXsWZeN+A6SKi86KDAPY3xuCVzP3Z/hkLBW
	36e99EVL6jqyhILmtEay//3aX9CbiD8JaRcQBPYGbiZq6Ay6c7YwykKerKDtJ3ZYiFotKBLdztP
	9HEQe2k3iO6U1adCIGT1acwQy5ewYqplJLyCHfxlCm2m7DKiByubG+9muhw==
X-Gm-Gg: AYBFou35w8rseFjBr2WBZfZBE5OuscWgZec/cnSZyyNF0R4o5bC1deXXes2KEKr0NpV
	MJkbWBtG8oKCqSNQVERGU5yXv1y6UmkJ8MnxQQiwU8jQ/rgsN61tXyV2TICHYRvYm6wd/XIsKiR
	BrWXX/sSWsC8ftAwXavA0eFsRiMrF+r9T2AODp1z7L/jJXeT7IQF3RfIcQBqfzuhzt0+CTdeOXY
	9Ym9ybRtq4at2WfQscsLP0RLgKmEPNA4nQs9UnDEOXk9iBWyiay7qmMt1i2lLfjEAh35ESNzFLO
	b/cGMeb19IvNq0ZnvgqqR+cb2zEqUWomabKV2kQF/vB54ktHNO6le/UwQmvinuUgJ7sH9wNQOuL
	Cp6L3oTpuotQJcqqb/+zcNc4zQRC84AXN58Eqm6/AIzkA7YWn6nG6p0IOVDyd1GvVMJ4TuXaznA
	==
X-Received: by 2002:a05:600c:1912:b0:49c:fc6e:8cb1 with SMTP id 5b1f17b1804b1-49fe66d811dmr276298215e9.21.1790689145779;
        Tue, 29 Sep 2026 06:39:05 -0700 (PDT)
X-Received: by 2002:a05:600c:1912:b0:49c:fc6e:8cb1 with SMTP id 5b1f17b1804b1-49fe66d811dmr276297645e9.21.1790689145324;
        Tue, 29 Sep 2026 06:39:05 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00d0f442dsm75545855e9.13.2026.09.29.06.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 06:39:04 -0700 (PDT)
Message-ID: <97f2fdff-3954-4d53-aa55-156672658ee5@redhat.com>
Date: Tue, 29 Sep 2026 15:39:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] net: devmem: decode DMA addresses for TX
From: Paolo Abeni <pabeni@redhat.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org,
 sdf@fomichev.me, bobbyeshleman@meta.com, almasrymina@google.com,
 kaiyuanz@google.com, linux-kernel@vger.kernel.org
References: <20260925201522.254717-1-sdf@fomichev.me>
 <20260925201522.254717-4-sdf@fomichev.me>
 <85ddcc36-7e31-42d7-8e78-a3e456e13944@redhat.com>
Content-Language: en-US
In-Reply-To: <85ddcc36-7e31-42d7-8e78-a3e456e13944@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/29/26 11:43, Paolo Abeni wrote:
> On 9/25/26 22:15, Stanislav Fomichev wrote:
>> On 32-bit architectures where dma_addr_t is wider than unsigned long,
>> page_pool_set_dma_addr_netmem() stores page-aligned DMA addresses shifted
>> by PAGE_SHIFT. The net_iov branch of __skb_frag_dma_map() adds byte offsets
>> to the encoded value, so the NIC is programmed with an invalid DMA address.
>> This can trigger an IOMMU fault or DMA from unintended memory.
>>
>> Consolidate DMA address encoding, decoding, and representability checks in
>> netmem helpers. Use the common decoder from the page pool and net_iov TX
>> paths so both interpret stored addresses consistently.
>>
>> Fixes: bd61848900bf ("net: devmem: Implement TX path")
>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> Fixes tag for net-next patches pointing to old code are highly discouraged.
> My understanding is that netem on 32 bits is mostly a theoretical thing,
> i.e. no actual usage.
> Would you be ok to strip the tag? No need to repost, just reply here.
Actually the above is more FYI than a real request. I'll apply the
series stripping the tag.

/P

