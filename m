Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802495;
	b=O2JKSMj72YINk80rKD/JEPK9P0FnH+Yjvwv3kXgKWwG0IrSw9nEvoPaueTlPpNvIqMgM
	 N9gBZ4mESm1Ey1sz3merx5vKl0GHLX7c1yg6n7Mdp8/KRmQXgAkB4ljTVUzzDWvIAcfD1
	 lDYasQ/K3AEjzLgjGdJfLOd04rH0v5xk1UuGVA2BOc7ipMzS+Jkhnh/vnyMzS4F0SYMBZ
	 /bH2ombez/ozUSeOEoEHhMgTovsmumZvrdMtg2gPUnYDTbrV2vZhgx1vU4n9TFYxnN/WT
	 eDTFnMPFXvBLnR/+ORG5lurFGVAJSivfgZESPKybEMZwWPf9XmV3bBqGz64+tavWihw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802495;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4/Evz9fjrrpCnCXycWC63zfKI3HUYi26oAG2Biknep0=;
	b=kyVEuKlBrIBV0Isv2aNn7CQHOkDdV2EyhiXcK489pNZ9w2kJU73JfZtgwx0OpUF0xI8b
	 Xct1DXYgxrnfu74ekond53AbhJbtnQLFJjpwDFymTakVv+3CsJmTBsJeaq6XxZmwcsRKl
	 GkjKcCQvx5k7swxPh41SAOHChWOYn7Q/q324vNFrkE9VE/mvhavNe7NRAszy9qEDYmzV7
	 BT8kdBjLQzK6dCrVAHqyPTKpJEuCEqUdHWQDuYxvOQmSNxNder/TYLeVc+9eJipFJrJMx
	 7PFq5NzrGwh5uOeFTDICl5CcJex7yWFOxnRTMDueR1kAM/BBgDR6Xz+zmslvLc3wpqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UCCgpa0h;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="iaIe29/b";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C3A606A32D
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 14:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85C3A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UCCgpa0h;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iaIe29/b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793802493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/Evz9fjrrpCnCXycWC63zfKI3HUYi26oAG2Biknep0=;
	b=UCCgpa0h1y5+YbuN7Y9mcWyeMbYvSsWTkRRsjbxugC5r8oPcixNo2j0t0+l0nJrPbeB9xo
	nwbUclSoDqXyo6cVKm4u0py2WzalOC+VGMxyhMM90ycDKgpIIsYFamqAVgtByNvLZlpMgU
	4SGvFc87JltRAOQicXyH75IoPEmwx5c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-rpxj75vpMRmNRIemwzUHEw-1; Wed, 04 Nov 2026 09:28:12 -0500
X-MC-Unique: rpxj75vpMRmNRIemwzUHEw-1
X-Mimecast-MFC-AGG-ID: rpxj75vpMRmNRIemwzUHEw_1793802491
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e1d839ddaso609532f8f.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 06:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793802491; x=1794407291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4/Evz9fjrrpCnCXycWC63zfKI3HUYi26oAG2Biknep0=;
        b=iaIe29/b2YAJYfvUKG9cgMgWKhkRRPN6mzfVnfyEm8iti9EoypvstgW8Bw5glKA6UH
         5Cw/+Ha578Ab+8w+SBkcDKs2Nx3V5dwxF0HoBVFOA3czWMkpL3WEvst7hz5u2qzBVSS2
         YsNmt8+IetDIVVchHMvRPzn8XwBs1u+xW0VMv5IJEe5iyzHhR8MzAejjvga6/5BmXoth
         Aa1HfCADmvVtrEOQsKoXJi61pO8gwhkYZW8IcTbYTxmPxks+k9F5Q9mbAmCIGcTTG8Rr
         YrRPM3MfwQcokwlLRdP9zk+kdtGpuOIUw8dXhFbQC1xtLpQTJ7fDS9APT0nTu+NcMLyn
         3Wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802491; x=1794407291;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4/Evz9fjrrpCnCXycWC63zfKI3HUYi26oAG2Biknep0=;
        b=IW4Lt7YD5tFO8+HxeGvlYwmPj9BltF92ecMkdEdbFzOy2egpEsRC3SMwAId3/ccvtu
         FrgXGSe86pee83Bmg4UaHVxvPx2wyLUUKvsKsojHqjs+Ko0mw9lZIp7Y2qXE1K3MB/2H
         dAKoY15WSYO9nnmHAe5OhneAuzqUG4uHEHyXCBXHx+IDaY1gYuvCJHa5hHOpZRwnP+Vb
         ZHohbeloYEpq4LcaUMN5uVwSmOfUszg6dpixOuWFqh6ChujtlF/jNJBAAZSJkvPXrgL7
         TAtVFF6QGpVpDN1pYL9BtvdN0DAnCsop4kTcsbC+HXNmKygDjME/dWvIyQZyTVsa/b0W
         cMOg==
X-Forwarded-Encrypted: i=1; AKwUvByRcDyJUQHZyH0eghM3DHYJdYZYN0IrpxIR3z2ckH1hXHXbOGrb6c0WaPY3dAXnIzivCMeFcWg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jwtTvvCOlm41roCBqIijZULyUfOrkgAONWJoshgKV8CAA0t8C
	Ygw7KXYqbUbBqSWbqthRTPCbpg3XR5RIpNBTeRQKcib2xwrX33cm1M0ZYCxquMNCjvADU8WhuJb
	qFmxkeU2Nc1v8KcChdtgyn17iqZyOpK3dHnKUsujddjc/Ohys2NCcIvaEaA==
X-Gm-Gg: AYBFou0/AexuS50DLlWMQa4TJ4oYPgiU/JePDvEZulVOz0uoZmMI5s9L1Ta7waEPbkL
	gONPY+1k9mpdpKAhb4cJBCeB7TwHpuPX5BnLq7fCP1spAvCYLt/PGpC3i7f7AEnHatz4dxhBJOJ
	SAz7I/KWErbDYFS+sQF9Vb62Fe7ZVpZI2F/gvcLUVZpmCOh1A7D23UP2fe77AS8h+u3NyeMW3tK
	gu+jDN8KvH/KP92JuW9mFWDn+l3IuU6cw2DgXKjzYHtRFz9CA818AsOT4CuwuIymglRABjMNrTh
	iRW9xQLad2V/HNDlxlsslbCvClmiJ/KSqPclXOGqjfXFarrwYIK5/N355aib2mxKVCW4WeeOH6B
	eQBQcxMEaCfKYa6b9QiPQxSevE7jO0KjUFpUxX/2rPIhas74QW7lD4PFzK/r1C5yW17tyDwogF8
	vXHJyVLflbDBZr86KS7Y0/gsNTjMjI28jKCvS4ZuNdODY=
X-Received: by 2002:a05:600c:4e08:b0:4a1:ce33:1536 with SMTP id 5b1f17b1804b1-4ac1719112emr360222235e9.9.1793802490801;
        Wed, 04 Nov 2026 06:28:10 -0800 (PST)
X-Received: by 2002:a05:600c:4e08:b0:4a1:ce33:1536 with SMTP id 5b1f17b1804b1-4ac1719112emr360221625e9.9.1793802490212;
        Wed, 04 Nov 2026 06:28:10 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a9faff90sm162472315e9.5.2026.11.04.06.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 06:28:09 -0800 (PST)
Message-ID: <ae9abdea-6c34-4386-853a-862f5f16b031@redhat.com>
Date: Wed, 4 Nov 2026 15:28:08 +0100
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
Subject: Re: [PATCH net v3] vhost/vsock: size receive SKBs from declared
 payload
To: "Michael S. Tsirkin" <mst@redhat.com>, Daehyeon Ko <4ncienth@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "David S . Miller" <davem@davemloft.net>, Will Deacon <will@kernel.org>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261004235101.1464007-1-4ncienth@gmail.com>
 <20261104065405-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261104065405-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 12:55, Michael S. Tsirkin wrote:
> On Mon, Oct 05, 2026 at 08:51:01AM +0900, Daehyeon Ko wrote:
>> vhost_vsock_alloc_skb() sizes the skb from iov_length(), the total guest
>> descriptor length.  virtio_transport_inc_rx_pkt() instead adds hdr->len to
>> rx_bytes and buf_used, and budgets each queued skb as SKB_TRUESIZE(0).  The
>> guest controls the descriptor length and hdr->len independently.
>>
>> A guest can therefore provide a 64 KiB descriptor while declaring a zero
>> payload.  The descriptor-sized skb remains queued, rx_bytes and buf_used
>> remain unchanged, and only the fixed queue-entry budget limits retention.
>> This is not a lifetime leak: the skb is freed when dequeued or at socket
>> teardown.  Repeating this across connections can nevertheless exhaust host
>> memory.  On Linux v7.2, 455 such descriptors retained 30,255,680 bytes for
>> a 262,144-byte receive buffer; a full-payload control retained 265,984
>> bytes.
>>
>> Vhost previously read hdr->len and allocated pkt->buf from that value.  The
>> conversion from virtio_vsock_pkt to sk_buff instead allocated receive skbs
>> from the descriptor length, introducing the allocation-accounting mismatch.
>>
>> Copy the header into a stack object and validate hdr->len before allocating
>> the skb.  Size the allocation as sizeof(hdr) + payload_len so descriptor
>> capacity no longer determines queued memory.  Check payload_len against
>> len - sizeof(hdr) to avoid addition overflow on 32-bit hosts.
>>
>> Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> 
> 
> Weird that this wasn't applied in net yet.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> let me know if you want me to apply this.
Someone change the patch status to 'Not applicable' likely assuming it
was vhost stuff. The patch fell out our queue, but I just applied it.
I'm not sure if the bot will catch it up, given that the patch is so old.

/P

