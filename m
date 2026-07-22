Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A3F33939D
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784718897; cv=none; b=Y6DPgXD3+UH3YNN28VoaSkez2GXLAGeardO8wPrEBMfUTdyaCfUpm5JBInH2hWGx1s0ImNpDvIBCYx06c8Dbw4eQnVp+RMcMR+6HbDCYCKiT8CHpHWt513u3f4yyhj8HqI1V6KwqSioMe1DqZCSQvp505tg+Kv+XfRJlIh+rlps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784718897; c=relaxed/simple;
	bh=uzhO8qZzZtzCkuyAcsiEJ5CYBHHM+UYYe7aT1XzV47k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPtpyMdyliBZBfEZuonh6tL1kMmVCv4QlpE43MT0EsdpMD2IRbKgMPDpCQyeErRdR4bdHLKQ9nVXojkQqskbu7Xw1oVnN0R5a4YgJvUOjlECAR9eBVfihSEDjGlH/v5B6gEU/RbizJ28LteTXvB08Tefu62Qw5y4NfA72j32klo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G6PoZXKH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lgErPBHZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6PoZXKH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lgErPBHZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784718894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dskBU4xlQcMFjG1mjYNj5Dyca/KZhN8IjWXgEILKj48=;
	b=G6PoZXKHsa/x51+5Kji2SzXDQ9IPMDCzV9Nz7rG7YCecSjyqLOs+4aHAZ828eStEjGxJoC
	MX//zIuOHhzOdJTRqg6IwJd0Zy7PwtclRbDIKyBSobpguWUZ/D/q2wjlZwY9AlhrBjIVhs
	e3Y3GvahiyW6ntEOJIeT2WpWScKVTGg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-1yq1D273Psy59ZYE-mlosQ-1; Wed, 22 Jul 2026 07:14:53 -0400
X-MC-Unique: 1yq1D273Psy59ZYE-mlosQ-1
X-Mimecast-MFC-AGG-ID: 1yq1D273Psy59ZYE-mlosQ_1784718892
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49561facb1dso24588635e9.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 04:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784718892; x=1785323692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dskBU4xlQcMFjG1mjYNj5Dyca/KZhN8IjWXgEILKj48=;
        b=lgErPBHZJ6aADIcXqmNIWpn6+Kuwa48zVKQDuQHsBygAgF/0+1MKu+8yCy5cz//a4S
         rtALm/aEOTXs+JlVczXr9dP2tNtNIlYCAgKsoKmhGaAUC2r+RLOECoHw1d0jd7ESFsvw
         i6mbWHP4W4eW7AdqM2JGCwd2FftHUoc6TvYd0nbPPUa/UsnGnnaGLRFzZxNPfkTyD7IE
         53AP+snCUZ2JacekFcksUJWNYY1oCeqREi9n+TK1yAu26QD/QymEUNwO22emr7QY53my
         gx8aUOtaKDt+JsigrUoxIH1DqqYTsJ71Mmym63v8WNdZp3dk6mJ3gBsXduIOec0Y1rtr
         EHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784718892; x=1785323692;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dskBU4xlQcMFjG1mjYNj5Dyca/KZhN8IjWXgEILKj48=;
        b=lyOcy1yW5PDaff3kSKDbl1KlywVhk0rFpQx+uRCHoNkcUl4LtPopQ1WuBFHUyKf3E7
         BOUNddbo1tMzaQr3GD5qPZ1fq/VwzGUSmYE4KvCucEGrnrL1e84XsP8qwVzpG9jPJz5B
         itP+a5fjUCQA8B4OZ1l3ImoTBFu2u7gwd++e5QKtSsZeBPD764cQYN65fkA67Q/Eb89u
         KUmThcaEdXvmixTfrwR6/6/yCResI1XwihfR2YETyqAFk6uMNWxjeNHxwQiIHV0y21Ou
         4/Neqz++qHPeo4s8gzEkJoMZLAH/9hgUqL0B1sk4TKua72r50hheifg4zNeEKOfYRF+p
         2NGQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJcEmnIRffpR1uKIaaTIf78dvBkkrW3go1VihHQipPIpAYTvihQRsIut8L3GAcjuoQfE9oNQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS1+6bTxPO0SxbSKw1jkVQUk2q651LGr3VMFt3z+C4oYszCuC1
	EBADCsDM4zfaF2pp1wjyozCx/JcCbOYpcxrNuhNp4vk59dk8JOgN49MKCXznLmoRfc9lMMy+w4Q
	6xu2DPLSvlSzvBk8zt+4ZjSWwaHIuWvcHzjaNfylzXPgObHcAHKkKFkqoow==
X-Gm-Gg: AR+sD13lEXMFu9+xkyhOeml/Xyy3IkbF+IDMbxTjR25NggSiK1IUWoCld0sX0XBZAY/
	uMcDe+yxfWl6uHaoX+P5K8wfRfSmJeLh0ZeOKQvDwVkapV0s2SqmNKBlhrIrU+sIjqlFR8m1bd8
	eUvLDZQfhs6/c+cSVZbhK2HGhR7V2dN9cd968RJO+OYS/mFtPlLIdVRINed/ArXvglNEsPN5OvG
	iUDolY5SpiB43dFO+SfZnkNfDNb7fxJbiPiX5hSRi7VZbqSvVy0bYssgU6G3iI8OGJlRgWzIZnK
	OxjGoSyvisMLFPWRFe0K6d4ruY97J6IiyiaBTZ4rnIk2DYVH+BbzHkw+48Qxma1Y7/trKCnVd9N
	PnI6nQ6UhYTy3XDh67hC3groSG6EXhrJtOp/Yoqjm7FZVASnV5hffQ13bEWuU6etmcxVX73m1Rp
	ks9A==
X-Received: by 2002:a05:600c:a42:b0:493:e983:806e with SMTP id 5b1f17b1804b1-4954a3ee98emr268993405e9.3.1784718892181;
        Wed, 22 Jul 2026 04:14:52 -0700 (PDT)
X-Received: by 2002:a05:600c:a42:b0:493:e983:806e with SMTP id 5b1f17b1804b1-4954a3ee98emr268992935e9.3.1784718891747;
        Wed, 22 Jul 2026 04:14:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a500dbfsm57899085e9.6.2026.07.22.04.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 04:14:51 -0700 (PDT)
Message-ID: <7fe2578f-9cf7-4803-a446-a9a3b22ceb86@redhat.com>
Date: Wed, 22 Jul 2026 13:14:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/9] net: Enable BIG TCP with partial GSO
To: Alice Mikityanska <alice@isovalent.com>, Simon Horman <horms@kernel.org>
Cc: alice.kernel@fastmail.im, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, lucien.xin@gmail.com,
 willemdebruijn.kernel@gmail.com, willemb@google.com, dsahern@kernel.org,
 razor@blackwall.org, shuah@kernel.org, stfomichev@gmail.com,
 andrew+netdev@lunn.ch, fw@strlen.de, netdev@vger.kernel.org
References: <20260710134242.216538-3-alice.kernel@fastmail.im>
 <20260716144724.333095-2-horms@kernel.org>
 <CAD0BsJVXORyveLcNxCeOcL5xQhBX0c0Tyy3q_PSmmMhi1uZ9kg@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CAD0BsJVXORyveLcNxCeOcL5xQhBX0c0Tyy3q_PSmmMhi1uZ9kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/16/26 6:28 PM, Alice Mikityanska wrote:
> On Thu, 16 Jul 2026 at 17:47, Simon Horman <horms@kernel.org> wrote:
>> [Severity: Medium]
>> Can the partial_segs calculation exceed 65535 for malicious inputs and cause
>> a 16-bit truncation?
>>
>> If a crafted packet with a very small gso_size (for example, mss=1 via an
>> untrusted packet socket) and a large payload is segmented, len / mss could
>> produce a value greater than 65535.
>>
>> When this 32-bit value is later assigned to the 16-bit field in skb_segment():
>>
>> net/core/skbuff.c:skb_segment() {
>>     ...
>>     skb_shinfo(iter)->gso_segs = partial_segs;
>>     ...
>> }
> 
> I'll clamp partial_segs to GSO_MAX_SEGS=65535 to make sure that
> gso_segs doesn't overflow. Worst case, in an extreme scenario of
> gso_size=1, partial GSO will produce more than 2 output SKBs, but the
> traffic should still flow — this is how BIG TCP SKBs were handled by
> skb_segment before this change.

I *think* this is better handled when the bad GSO segment is
(potentially) assembled - at GRO aggregation and virtio_net_hdr
conversion. Possibly a check in skb_gro_receive() should cover both cases.

Also if this is the only pending item I think it's better handled as a
follow-up.

Thanks,

Paolo

