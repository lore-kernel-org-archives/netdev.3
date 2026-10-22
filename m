Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661352;
	b=Nh8z7pzKqNE3ssHxiz01kApAEE21EmmFGfrzAMylR+3xJFh3r2AVNmhRT/MJTleOvO3g
	 SJ2mNrfaRNvnX8mq2Db8fadc0Wt0NC8OT7lO5sYaKearhS86wjJlY4J+DvwI/jpcFcGrE
	 sjlEc+gCBOLhoCJqADDWUZWWHGxf8bevdmVTKWXnU/avRqlHS1885+CfKJIcjBmosTbnP
	 OfbOPReNOyWnVTCttMZIhz6jLpzd7jG08tE1pd2wzQVQxdsTtXdyd0WGvA89TBV/JpPSf
	 uvh9Y4gcU4Eh5B91RNs/Nh6GNUEcN2oSYSiI9L3PNCM992zM0YebyXYfD5TC0JAQb3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661352;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6C0nwTWJOi88sDum8VGip3YZoxwI0Nc79E5HIgWtPfM=;
	b=hdNFCQCBVdCpJ2ItxF3qefIRiqIL4n1jBAmDHJ2jUDuop9Xd+uJLbPRw0Mw2g7cCAfMf
	 yQszQ6Bbo/6r4hT9M+6C5kGYt1k3gPdY+OuzzMCAoq51R0qM/aH8pCR5hlpTUmAEb+fCE
	 yGY63cHnaKPXYdH0YtcNw7XP5+vb1U0Mmdj1Wyv7zAaH1DJ2EGFexDaePTMqv7Q6dBgkc
	 B21bnN9MCWtuMBP7thUWLyOHJW5JKmkc+0ObsfYE/YiQPHoekDnWYzUxdC2T5sATiJviR
	 CWLpUyCWDEBWoJJrYbKDQ1PBIfxjhMUVb2NHhVrHAg0v+mDBk2rhGTKLXZe+fEmJUjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hyMf04X6;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="fW6/HOpL";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1965606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1965606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hyMf04X6;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fW6/HOpL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792661350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6C0nwTWJOi88sDum8VGip3YZoxwI0Nc79E5HIgWtPfM=;
	b=hyMf04X6mgLpHqkAivlQqoL+Q05Rd4b+RtRcPhaTIj+siQ4jGkHSZuxXF4jHfgRMOlbYfE
	3YlEhw5EfSDyasHfyPwafkmx9BPWLI95zENeQVwXuHe9PIsYVmtnfiDBvOYcDMd6g3bdsu
	Lzr6LBbdKSfMLEZ3kLFsEsOZcPxzN/o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-0_6K4nWBO4aRylZTUjniEQ-1; Thu, 22 Oct 2026 09:29:09 +0000
X-MC-Unique: 0_6K4nWBO4aRylZTUjniEQ-1
X-Mimecast-MFC-AGG-ID: 0_6K4nWBO4aRylZTUjniEQ_1792661348
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a2065a2ef9so5381045e9.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792661348; x=1793266148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6C0nwTWJOi88sDum8VGip3YZoxwI0Nc79E5HIgWtPfM=;
        b=fW6/HOpL8dIxGuiiDpKI03pmgLFA64DVP3w/EeHlzc+k192QYqX3x57BU8tRCmA4dA
         AZf5L+g3jLxNIq5RpLhbFvbzpKSMP60lFldlNeMGERpCjaGXaFKm129m8zlmoBKRDVBA
         S5QC7cOUn5c2cBmZ9V/pCAqjxbnkqBkfGJ2UKImZpQWB8abN66TUfpZhHBeUIOWsaQUI
         lI1ErMP1HX85uZsAVAgMgdL3qI2T7qEh7C5d+ns9zSR4JheX7rcIup9v31pB+FMDGtkQ
         52CMpE8Mxg1WUw3YQ6P804l40b2nYk0SWpONRfTRQWsb5Jd1/WZOOJTCwnGpEHqioowi
         3SJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792661348; x=1793266148;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6C0nwTWJOi88sDum8VGip3YZoxwI0Nc79E5HIgWtPfM=;
        b=sKfa6rsOolH/Op1lEeLzHLKuLsb5JxEmG+WLulbFdOWepFTY/aBhtPJKGrwfSTXFYA
         OoZuGplEZmr7R3d6Z/CiwgvM4tEiSmthBnrcuXXkoQEAIlpo+ZrJe7VmOHaYVbEbKup3
         KHC8YZDTh9O74g7kx9kC+/0KDGvnHnPABpAtoaqp0heyRQM+NnKm/RSyrRBYIxqboQ4l
         jKiRiM2N3k91D+pxlSlb6+O1ZnBjFfVVXHcPIZy41az313jGEhslLQ4uXHxKXKC2ieJ5
         obwn8Mm9Z1bNP54ftYvbksMhrZr1hZVSiGX1CCRizjWj+ym96MaXSUZ/nFcuOYezgyCZ
         lECA==
X-Forwarded-Encrypted: i=1; AKwUvByITpm8NBbJ1re5tM5E3EG3ml8R0J1KAr82LSReMyOQmu9iwAHcKaPYLOCKeV0fxR+Y+Yt1yh4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvje9DY3HgUSgTfiqGlC/0fI7K0fpxHe9I2LBtpnyPyAJCv7PS
	UoRS3FIlsGq+XWb9XTKukKVRk3cvfLsBHXLeiGn+VZ6LP3fgB8tZFqnlV9ZVJ5S3vJu4iEw2O+N
	DaSI5kgNZHjfjperm7YuIA/wu6TV2N4jOMT+3c+fYjZBhuWzddLA8GtalVg==
X-Gm-Gg: AYBFou0x9gEQQrLYIVvRpxZq4bVxHr+ce1HzokAeoG/T9Dm6BRLJk4N0nEJ4+DOYUiX
	uyd3l70I6b+9kD9ogaI6rI11roZ5zDVFUwSSr7WRzJIJs1S74eAWVGcHsZrJpDcIBk0D7vzmSan
	k9xpEy/vGgZohEa5HeH05jmxRgB1hrGYnQwY45VtA3uq7r5qn2S1oQyuvTxGv/VQAaFojxjG8MV
	buIK5JXRm4A3oD6nQwwIA6E5lvc0RLTe5BeXjuGRTomd8HmuF/f5m8No4htWzJTZGMPbFi0B+QL
	z7pKbUpYGfhiqpe5tufktSAf06gYmCl+eGNIPt4quVRbh/tQRvaq6/7q4HdZAzS360Jh7c4l7nP
	xzs41H/IiaHm7nVMh5qtac9bt4XDXli3GK4lmL2gkHLUxnd9hmgVoMOkOEO+tU1K5jK6r8B6EMw
	==
X-Received: by 2002:a05:600c:620a:b0:4a1:706f:b40d with SMTP id 5b1f17b1804b1-4a1fdb1a609mr83563705e9.7.1792661347973;
        Thu, 22 Oct 2026 02:29:07 -0700 (PDT)
X-Received: by 2002:a05:600c:620a:b0:4a1:706f:b40d with SMTP id 5b1f17b1804b1-4a1fdb1a609mr83563385e9.7.1792661347465;
        Thu, 22 Oct 2026 02:29:07 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203b42befsm54154205e9.8.2026.10.22.02.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 02:29:07 -0700 (PDT)
Message-ID: <9756cf25-6951-4330-959b-3260f4760c3e@redhat.com>
Date: Thu, 22 Oct 2026 11:29:05 +0200
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
Subject: Re: [BUG] net: tun: zero-copy path can expose uninitialized packet
 data
To: Cheng Yongkang <teel4res@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Eugenio Perez <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261022091847.3654028-1-teel4res@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261022091847.3654028-1-teel4res@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/26 11:18, Cheng Yongkang wrote:
> The experimental vhost-net TX zero-copy path can hand TUN a user buffer
> whose effective vhost virtio header size is smaller than the TUN
> device's configured vnet_hdr_sz.  TUN computes an skb copylen that
> remains larger than the bytes actually available after stripping its
> configured header, publishes skb->len from that copylen, and
> zerocopy_sg_from_iter() initializes only the real payload.
> 
> The resulting frame contains an uninitialized tail.  The tail can be
> read by userspace from the TAP peer through normal forwarding.
> 
> Observed on Linux v7.3, commit
> 08ab31164c55f20c7a2653de3186ae333470e2c1, with:
> 
>    init_on_alloc=0
>    vhost_net.experimental_zcopytx=1
>    TAP vnet_hdr_sz=200
>    vhost TX total length=256
>    real payload length=56
>    TUN copylen / skb len=128
> 
> The exact control with vnet_hdr_sz=10 delivered the expected 246-byte
> frame.  The corrected trigger delivered 128 bytes after submitting only
> 56 payload bytes.
> 
> Sixteen of sixteen corrected triggers produced the overlong skb.
> Eleven of sixteen had nonzero bytes in the 72-byte uninitialized tail.
> Several contained recognizable stale kernel allocation content from
> previous skbuff_small_head users, including fragments of environment
> entries.  Those bytes were never supplied in the virtio TX buffer.
> 
> This is a userspace-observable kernel-memory disclosure on a
> network-forwarding path.  It is configuration-gated by experimental
> zero-copy and an enlarged TAP vnet header, but the overlong skb occurs
> regardless of init_on_alloc; init_on_alloc=0 is needed to observe the
> stale tail in this test build.
> 
> This is distinct from candidate BR-023/BR-025, which exercise
> IFF_NAPI_FRAGS.  This reproducer uses the non-frags tun_alloc_skb() /
> zerocopy_sg_from_iter() branch.
> 
> I found no direct upstream fix or CVE.
> 
> The vhost ring reproducer and complete program/console logs are
> available on request.
> 
> This was found with a multi-agent workflow; the
> information disclosure was reproduced in QEMU/KVM.
Please stop this AI-generated test-walls dump: it's not very helpful
except for other agents consumption.

Really, please stop now.

Please instead ask your LLMs to try to generated fixes for each of them,
manually review the generate code if you have the skills, and share
the patches on the ML, at a very limited rated (no more than a couple
of series in flight at any given time, with no more than an handful of
patches overall).

Please consider collaborating with other already in place projects
(i.e. nebusec) to make you finding available to the community in a
responsible way.

Thanks,

Paolo


