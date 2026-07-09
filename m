Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8093E0241
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588686; cv=none; b=kUgXS01c+OBMWlHsOHr/DwZD10YDkwGvP0nqCaZekeRU2uxreEk53JtucLQT1iPWrK3LE+nb7zkHH9dvVVM348yrywl9SOcCFwg1PJklDMQRjfYQ1ftRCkrNvvlhWzLSVl8vPfl4bSC79LJ35gw+VNuj8ccLjBrJxe7w9H8icc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588686; c=relaxed/simple;
	bh=FjpUXsvhXEAkUlVQP4tEH1Ee2iSdcpYkelan5p5vzPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfuyFEi93XKkSfzl8xpdkc8JFe7KWtJ6HQS0cWJSvjJWE0Ru9JcfGFPsIplkpibhKLyBqY0sPENJIzZ3qA2nII6xL1hoHLyMdAGHcs8l2Uv1RAzwaP3L45qTmO0sPiKtAiG7v5HF69GcQQTBC19FuFvxq3KiSFHfSMn1BJPul60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsa2QEWE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m3q6G+k2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsa2QEWE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m3q6G+k2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783588683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lcgAW3wWwD+CDc95tyrJwQ6t0jD3GIhvTCB6YDG1NyM=;
	b=bsa2QEWEHDPr5cMcdwWrXYDbSL3c7Dg+wGlrHKnmPIrtA3I1t1SzjuBa7KkqdRKyf7sqL/
	fbLG7sHwE3XBJqniWOalHS693gxNlJFxoGl8ymRTo2ebT1IDZjWK2/aFCHEJWXrXMF8Ee+
	2M8y29ejM0lu+Gku12cDnw+O5pOccIk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-LWTVZQLqMfCFvdBNM7W48Q-1; Thu, 09 Jul 2026 05:18:00 -0400
X-MC-Unique: LWTVZQLqMfCFvdBNM7W48Q-1
X-Mimecast-MFC-AGG-ID: LWTVZQLqMfCFvdBNM7W48Q_1783588679
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47407691804so1362001f8f.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 02:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783588679; x=1784193479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lcgAW3wWwD+CDc95tyrJwQ6t0jD3GIhvTCB6YDG1NyM=;
        b=m3q6G+k2BxxHrRuy8NIc3HM7r5BkAQ5kBQ1fZ9ywGCU76Ww2QoD/Ei/V6NBLnwI8dP
         49p94kw0oGoRgi10BqgLIvP3Fl7Fwk+kdgpsLR7Me3bzNDOqPzGkN/Owy8+dCZwIys5S
         E/HTui+ygs+0ZK7c0wRh8RmbhlFIObPhFcEFbMDpxyv+QGLycE8U1jdpm5wWcmcXfhO2
         KxQuY430In6dk8AbRp8TUiJ52D/d64S9jTnwkznspCX+hXqnuRKzGQU3vGuTB7NjcFtS
         HEFq3Y+yLePpLqpZWWE84RKIjYCyY2s2Yy8bXB0IgAEEUt01zrrBzLbXZ6ksZeGPKNIv
         UnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783588679; x=1784193479;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lcgAW3wWwD+CDc95tyrJwQ6t0jD3GIhvTCB6YDG1NyM=;
        b=PMt/WU2pEth7ExpNtM+lGLPRf1FoyO+5Czn6vSOSwxc2KSPFLyTYUm2VMFKL0pfRYa
         2EKiQiU7R/YM5c4ebOuupI8XvIHhTADSmIxYVbWebVCHhOS9P6lS5qtzU8+wyp3ycOlW
         4YIzEOIIqVvgsVelUXlrHAyCvVEhugzpLFDsy/WzB3925SDlThDKSDwwMTWi0d4DLo2f
         QBSfKRq9RNhaLwJ8ymh0jxJH1MLC3UzkKiI4jqMNZww+ucHyBCxtrPzIN8k+6hI5nSRR
         N+111EYlZpVfV1hpgAJnppMRK0XaLs+KsqlZbmD5bCDVI3Gl5kiGlT+dq0kbg/wFbKow
         MVLQ==
X-Gm-Message-State: AOJu0YyDZSg5d5OZCPEYis7lCLeirWrGxKKF3NXNYAd7kL5SG8sr0Rpq
	yVHpoO6+9tdh1zDikwx1Z1hcbJrwNROl4Of1bHaLHQqmFgGEIUqiqKhiBkofYBtaB6U3VuEvFRW
	gf6lbFaS/GLokjiJ02EvVoqUMAv7cDVS5t0FtXSsSExGQN+JR30z+FkIc6w==
X-Gm-Gg: AfdE7cnjc1hWQVr8Hl9KFZsOtE5NXvZYcoWuc/WOTYmer66ud+T5QhlLxWNzxUoRdVP
	otonXQCStBrLve5vE1hIw3fouiBg9e98ZG3u++60lL1Ic1i5MIhpsRRPBmm+XMYqeBTGr5EEidV
	vEQDrqcR8ODcUxZnYpBanUFbGoLmcr6tfp/ELYXH8CiAvFK1nkNVbw8k4UQJTQtbihfoSCl+ETe
	lVK0JNXPlyfiwdRCowuDfd+5OAox5f2FMRYeXv7ZwFjaSimc/flWPBTRxySzZb+5zWOHnRQHYMZ
	MtQyimojuE7PvLIB5sL2xjQCXUKNi0DonCgPbkt/vpLOFw6jKgZCrYGer4fRxR714ZRDxO0z62a
	AdxGV6E/PrUGBrWrM6x4dDXT4Z8T9QJU41TqLaXBDOo8JUWhOtTBhp7k/NGA3
X-Received: by 2002:a05:6000:1a85:b0:460:1223:a044 with SMTP id ffacd0b85a97d-47df06c10c9mr6983272f8f.0.1783588679365;
        Thu, 09 Jul 2026 02:17:59 -0700 (PDT)
X-Received: by 2002:a05:6000:1a85:b0:460:1223:a044 with SMTP id ffacd0b85a97d-47df06c10c9mr6983241f8f.0.1783588678905;
        Thu, 09 Jul 2026 02:17:58 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d910sm48486557f8f.6.2026.07.09.02.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:17:58 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:17:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, 
	Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net v2 2/2] vsock/test: add test for small packets under
 pressure
Message-ID: <ak9h1kWcLmpP74PI@sgarzare-redhat>
References: <20260708102904.50732-1-sgarzare@redhat.com>
 <20260708102904.50732-3-sgarzare@redhat.com>
 <20260708065853-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260708065853-mutt-send-email-mst@kernel.org>

On Wed, Jul 08, 2026 at 06:59:41AM -0400, Michael S. Tsirkin wrote:
>On Wed, Jul 08, 2026 at 12:29:04PM +0200, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> Add a test that sends 2 MB of data using randomly sized small packets
>> (129-512 bytes) over a SOCK_STREAM connection. Packets above
>> GOOD_COPY_LEN (128) bypass the in-place coalescing in recv_enqueue(),
>> forcing each one into its own skb.
>>
>> Without receive queue collapsing, the per-skb overhead eventually
>> exceeds buf_alloc and the connection is reset. The test verifies
>> that all data arrives and that content integrity is preserved.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>maybe cut down SO_VM_SOCKETS_BUFFER_SIZE? will make it easier to
>trigger?

Currently, with the default value, the trigger is practically immediate 
for packets between 129 and 512 bytes, but yes, a smaller buffer size 
certainly makes this effect even more pronounced.

>
>anyway
>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks!

If I need to post a v3, I'll add it; otherwise, I guess we can leave it 
as is or send a follow-up for net-next.

Thanks,
Stefano

