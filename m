Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794577796;
	b=PWzTKe++Wt0uJSg9J9zQGF/zcQhDEGYAP7IIxmAqxXvwymkdN7VUWiPJZfJbEOJkY0Ce
	 4be9G7IyTA0Nzd8bXOEJtOBqdm4iYlAKT1LVURXyChpY1/2kDZhM6HnINseGAw6Zr2rlE
	 KSoe8ukzFebPh9yOsroKxzK0j9xM0h3XaCFc4HMSaMOL9tGYK1G78a8zJDao9w/yGSVMV
	 N8OWAKD0zKqqZI3NMYms2bDzceUfQN0DQJbhGNeRUYapGrJIdk3prpl3E1lu12BxjNqv5
	 MvW8TlmSQMP4wbiKS7XpGzrySN07YoFeFxpfw0/r7M7jEwxm9p86/vuP0gqGtqhNrww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577796;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
	b=d785xSFq207SWZjGB6WDr9A2AHv+V+5fAMF3buVrMukVBFUztp5CrxsErBUoB1p8rE2J
	 UrOxFlF2M8KA16kkOm3Zvj8xXwspwrrP8ItYqhPEwpzNBLJhI+9H68txgmfckUUV6rtKV
	 6qi+uJouh/SXvuXGOnVtYXGiTsKn7hWKgvuS5It13gpZfB0IEWqXh6QzVJyUuJWwTShH7
	 QFhN6O72mB/73kzMq1c05zBX9mtNoB6Nx9cFkJNldwUM1T3QPs4v3C4ELV9aPlLBKJAHB
	 leBDXNbMPu1IwxRM6EJyH6m0ApjfRw5Ycc8be2AS8abaizDITHrFVatJlIDdwczHj3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dnr4bWaa;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ga5oluTv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3647760A3834
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 13:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3647760A3834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dnr4bWaa;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ga5oluTv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794577795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
	b=dnr4bWaah9/wySNrHe71UxG7yxYO1hP4OJsDO4UuONplGfOBRiaQICVPWXH0a5xAfClVPc
	t+VpNg58eHK3YP5XWW59CAcUzV5E/GfH9p/c18EmHQRz6zpg7GqxOWWu1kW44oqkX5txvm
	zu2Lk64sIPPATltWgXHym6Mxatxh5HU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-i3984RHvNXyMYD7T9ww8qw-1; Fri, 13 Nov 2026 08:49:54 -0500
X-MC-Unique: i3984RHvNXyMYD7T9ww8qw-1
X-Mimecast-MFC-AGG-ID: i3984RHvNXyMYD7T9ww8qw_1794577793
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91edde88d16so12636516d6.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 05:49:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794577793; cv=none;
        d=google.com; s=arc-20260327;
        b=iyDmpS8kdk8x7QCyPbYrDAdRR9LvzlYMobjGflPFIElWUmoDNwcsVT9g9oAk5GL9+f
         Se61z+W97QT4WqRFSbi9Iq0BXKsya95MsFRavTX5V0lCsOTap5YDv3eEIVTuBQ3owyb5
         wsKZ/ye1UXOesq+smX85cLY+DKIgZKJ7jw6VoHlFycYCB+DrYv1doE/YUPlPi/gSi51u
         ZzHt262EgWomL3kCCrTxO6q128HjPddNPmYBzvsRaoBwiIJceQV4xJeGcIdMM4fPF541
         ZL8UmUxm225mMvRY2N/q0pOys+McTRFOO8pDtkjkF/MTdadk5ETDUIqg+kF7DRFLSiL4
         ljMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
        fh=lMRBbP+vfhtYMXscdNuOsvUHW+X1WMH1WohFm5ZPALI=;
        b=oS21Kcd9EdW3MPg/jSuVsRi8hFnGELjFlUpa7m1HchXiSk/+R3UrdfE85LZ5EY4C7O
         5V7ngerufidv8FHXDAaDcKcW9eOoBieXSx8a1sLUesAV6aQB8p3M7dVqLgbjHvFM6Wat
         8LBAEipYmJzu2k9GT5/4VokHd/n+gKra+k85U++u5ktdxf59xuNrAA+dH3aiVPCtNf/f
         y/9xDhxCzvmtM9fzpCAJ+K94cYyhavruxMM8pYOXwlAQIIPFDajMrTxF+eJHJA9qBrW5
         L9zOtKqBTNx8ZbODQ30zRGn5NiCU8hW7IYoBx/ue5OHDrRv46tHxJyDoJXeHeK/lAwK3
         mBiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794577793; x=1795182593; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
        b=Ga5oluTv2VoCAk4tJJMwd4DcHxnzZN8P5RMMfsYuwHSiMT40x247pqXYZppw40aUfp
         AgXHj7O5P5EGzLh4fIFmrS2LDUH+QEQZYT3NfXESJ7+2AAzl/5iG4ssuum/lz5MnkbiY
         FEWaupRQi3hJm3DKU1Rj2ZQVesMwID+ZlD3yg4Dcq13ucBIA2y5CuZZ0qDg+hag5pCQ2
         rQ5GzjunzI61xrZyS6U/SOWzCL5dpAMnK6H42AAF/0so3HDc8I1e5CduBSEcu1Nj+iKT
         Na7YqNXXzrX2iDdPop6PnLFczlm8s6Y4c3Y6Takf75DT2e9wYXuz0ZE7I3UrxJfbFVUJ
         fD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577793; x=1795182593;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
        b=atu3VDFiM+41pS1xinYhS5QaWcuPcuscMpgREu/EfqqdB5eMR0wSPoQbYqcvBCp6FJ
         X/IpmsAO29G3Y9obn/R3XwQ8gRBWOuOv3mr1AwdvPaR6ErcdpeOnXol71biWGI2h7n/w
         EN+mCZjTJATWgVPcCl4tKTaSbttthy0UK43CJOP2h7YMWKSkCXdo5sXTNFX05s5F7PmV
         jdmo66EerOnmNBgOz4BeYTQlWwXHp/WPqgTiIQv0DIyK+FRw2DhD//kQGn+rwfAtlr92
         wO+Wo9f+YYw657XuqDVM6ISyauoJMrxonQ5uw6qj6rHV1d9SpZU2bPn4JT+n2RmPf0WK
         jIHQ==
X-Forwarded-Encrypted: i=1; AL+hErFIhccVSlUD4gD52uBvjC6MBfq/w94q3RMqrwszG2d8mVvfTKs9pyMJ8n2pddOP7P9qV+s8Tow=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GaouEHFv7K78euPXrOxYZgnyqmpaDF7qrKlHEcifypGSzy1WF
	osGP9fpQ35X4vl83am2uLTe5YnBQ8wngzF0lmYJAysUpSl6OMz9KueabPPDteYk1J1YJbLphBVb
	82siY2q1w3QphI09B+KmravdMtGcj/EYRiaWK+3wT2lfcOyqyf20T+uTf0sApEG+fHLDtRuTy32
	z2odGfRdofympzIbasjbaoA945KdfeJ6GD
X-Gm-Gg: AYBFou29xRWI+I7DTgEUwKhIqeralInMGPED/PofDjVgsH0genL5XGmRKOyeiGdQbN8
	kRrrFrTOvaD7XLK0q1G3i0iqxE2hrkqe4IYT9056Fw6lrF5G0ohFfyzrW2EGSpNRe6Mv6cAHaz1
	DIHsATYcvfDKlAZ67h3YGLDWRSGiv1KVhNEEwvfXKDVrd5ampdWCl1mXs=
X-Received: by 2002:a05:6214:85cd:20b0:91e:89d8:a330 with SMTP id 6a1803df08f44-91f241f6d2bmr27649276d6.25.1794577793134;
        Fri, 13 Nov 2026 05:49:53 -0800 (PST)
X-Received: by 2002:a05:6214:85cd:20b0:91e:89d8:a330 with SMTP id
 6a1803df08f44-91f241f6d2bmr27648836d6.25.1794577792581; Fri, 13 Nov 2026
 05:49:52 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Nov 2026 07:49:50 -0600
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <20261113080506-mutt-send-email-mst@kernel.org>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com> <20261113080506-mutt-send-email-mst@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 13 Nov 2026 07:49:50 -0600
X-Gm-Features: AclHuK9yYj2AE7jCL2Q7aluEqsTHouql9M7zvOo0Tu9GOsA54iFCZqauW8Q06G4
Message-ID: <CAAiTLFXvuHY=r8FPM7TFNTAO1oyco-brcc6YAc=YN432h87RSw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/8] vsock: add datagram support to virtio and vhost
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Fri, Nov 13, 2026 at 01:47:33PM +0100, Sergio Lopez wrote:
>> This RFC adds SOCK_DGRAM support to virtio-vsock and vhost-vsock through
>> the existing AF_VSOCK API. It is intended for guest and host services
>> that exchange independent requests, responses, or events and need message
>> boundaries and sender addresses without a stream connection or application
>> framing.
>>
>> VIRTIO_VSOCK_F_DGRAM gates virtio traffic in both directions. Each virtio
>> send carries zero to 64 KiB of payload in one VIRTIO_VSOCK_TYPE_DGRAM
>> packet. On the RX virtqueue, the device may split a datagram across
>> page-sized guest buffers.
>> START and EOM delimit the message; the guest reassembles at most 64
>> fragments and 64 KiB before delivering it to a socket.
>
> where do these limits come from? how does peer know not to send more?
>

The 64 KiB limit comes from VIRTIO_VSOCK_MAX_PKT_BUF_SIZE. The number of
fragments is a reasonable number to prevent the driver from putting too
much strain on the device.

Both limits should be part of the spec. This is the relevant part from
the draft I have put together so far:

+When VIRTIO_VSOCK_F_DGRAM is negotiated, each rx virtqueue buffer supplied
+by the driver MUST have room for the header and at least 1024 payload bytes.
+The driver MUST discard a received datagram packet whose \field{dst_cid}
+differs from the current \field{guest_cid} configuration value.
+The driver MUST reassemble consecutive fragments with matching address
+fields and MUST NOT deliver a partial datagram. It MUST discard an orphaned
+fragment, a fragment with an unsupported flag or operation, and any
+incomplete datagram interrupted by a new START or an unrelated packet. It
+MUST discard a datagram if its total length exceeds 65536 bytes or it has
+more than 64 fragments.

Thanks!
Sergio.

