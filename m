Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794485011;
	b=m6BM1a6zx93e0RJ9WuMYafhxtXobjrWCubH5rxJ2QznCiV55J49F81ARVxsATRRBO+1v
	 0jfTu9fIeOcTtwJchUGwvT8RVt0O6B1yLQcoDKzJ0WVTDQG5Op4Tu/DgqOCmlD5Xwc4aK
	 miNtPV/Trrk+xeKepATbcnAAunIi5Um8HG6atJj4nMsgzZHOnNRbPezlsYAAx4EL6cjEF
	 M9ejabrON/E0LDFrtGdzKP30VXPBheqCx0bfye4Y/7TLViNDIUfYvyeZlS0Jo/boiEeRj
	 ARAvdCVTYBnYsAfu3HYg4yBxNX+/KfUwfn6tkMOctvpvySCJJAlEhNYWx6trB6D7tCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485011;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qjpP6sWhpG2Ula7WRaKgo/2HPG4feJykT/QDSXFbrdo=;
	b=2jrSjXLFfnecdUv+zFcxEluOJ8nnNOWvGbSlwuBUf3f6/5Mv9jAHEusMhtbzPpaNMGMe
	 mDCusVUrQ+a2NBCEMkvJgG8YQwK/Ztdcy/oQgS+e8zLCgA19dGenc2jqojjm8oXH59UTZ
	 ksXD/8DnklbVyQ2xq5lm25RRocEL3pHiP2siKsJsYTJWknbV34gmzR/eaCf93nJMh1UNJ
	 Jy54ajr49LK2J4Faf6aCwI5/imbChOn222h79nw8+a22ecYWgnedriMhZqg8N5nf5Pj+d
	 Vb/Ekm6+5PQvq8pj6ntGEjtGMwN9TcrbQ8LJOURr2ZJ3t4ZZh5gEFdoSZbYq5IHrlqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bdwzf7H3;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PzRRGtld;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272FC606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 272FC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bdwzf7H3;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PzRRGtld
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794485010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjpP6sWhpG2Ula7WRaKgo/2HPG4feJykT/QDSXFbrdo=;
	b=Bdwzf7H3xAekP/HbHjzVxt6kfoXz1kOIOM0ru/JZQDYvLUAz7UC3ibl/NlXvQ+OUBO9FoT
	gEY2sYtP+GVMXPPnoQeIwfTkQNss3+nccdPEEGKlIpomrUaluI0k5XRNWP8V+0QRxcQdco
	PY9EZBbd7FiT+PYaOWCKA5Y436KndP0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-sB2bq5i1O1K9xjsbAp4EeA-1; Thu, 12 Nov 2026 07:03:28 -0500
X-MC-Unique: sB2bq5i1O1K9xjsbAp4EeA-1
X-Mimecast-MFC-AGG-ID: sB2bq5i1O1K9xjsbAp4EeA_1794485007
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c42888c50c4so378690166b.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 04:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794485007; x=1795089807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qjpP6sWhpG2Ula7WRaKgo/2HPG4feJykT/QDSXFbrdo=;
        b=PzRRGtldF7LT6cDvfPC91vb+8yFU6aS9u/gMeT34r+Pl4QQ4FDB0Q477WF0UaQsaX3
         awiY2l60BCGwK7UCJEwE3NM6b844ae1zRyoW/Ial8eGw5rAWOsA0kkVHUakOhwtQrVZz
         XlsGdL6Y63+sRg9yRwpCt+SodxDbnGXy9qWlyxlzTePvpGTdzfkutScmHm1S1cJathgy
         E2BfRMmWHO640KbUBz6OD31CxqAai7xiMplBg5xzVCgOJBAJg6d9jgHPAaP4sg82JkXP
         INVVs4+mPR9tMdp+g0LNqqFzSSYumdlFZUin0ZJfMb/RvXILJ1BhpLjGGZEyJGzbGi3m
         KVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794485007; x=1795089807;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qjpP6sWhpG2Ula7WRaKgo/2HPG4feJykT/QDSXFbrdo=;
        b=IJHOPT+O/0QYayi5cM1aeBVOq6Y8TawZITuv866INJzdVrfw853FB7FBo6j0w1FcJz
         CvNAYyQfIJGdbqkj5ZTchtDd5XPNO32OcFCAXDvlHNi8ND8Neqcy3IBPScBT5bmLAf9W
         rGdcwXFd/WRWEdgupvsGJFeXgEd/8mDUckNgheHCieuCikoJcImQLTxMp7nslNR/Q7fG
         BPg7uJm7/uVmzLtXcIPMy8qq8ibwkk41OrnT5gsvMC67FGazi3opZFRoWaXcBoGzqO8O
         Rd7MuGslSHIbqqmons8tuDSLidr0Fd6cj79Fqr3wu//AzAryX11980kC4QyLpliN7snH
         h4Vw==
X-Forwarded-Encrypted: i=1; AL+hErEH+5OgHtoukKPqKL1/AOfJDLLRlM4yb35df8TXKRFtibG3AHZv85kdx0hsBI2FhPzv3IpC8E0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/EoaWcZ793Iot4QVANrMjKo1dql6yDd6MYwaDnKafwefo/cwMo
	hgHPpCz5OPlHSmpgmRXjcQZO+FbJ2JRG8zcWT+2UxvgMWYsv+FU+qP4SeLvZ2uowvGLcW060LT2
	aq7st/J0mEe6+QCXBx0WiJsAYAZ4PpoDkV5i6VEv3no7Z8ccYhiv+uMmi8w==
X-Gm-Gg: AYBFou2WwQXP+tfac7j5ZbZesloU0IgP4PcVC80wzfXt8rzwZ2rNDQC+l/nC9zV1G/m
	XBDYmzGFUolWEPSg115TqyuDTGHKpiAaEfxRdZKQ0d1l+jUPy5w0W5PIMbAaAr+qx/6IKC6yQz7
	PdL1dkiMcNwNiNU3gJ2dQx4lUIVs7r/p9uX7M2HiqF0PJ2d5IPrLkGxH1MmO1JMG8jMhg2Y67F9
	L7TGoQJy6EMj9+5fKS6cQVNGRhA9no0q80rX9V2Z4FboessdA/FaOc9DKvlj+Ps4Px/8q8XwnEe
	YQ8G5wynkpMyZ2FM8t9IDugVnmoETFlOkI9SDgQQA61izacDCo+GNaoFTZKtXlqLqei6Ks/zHUJ
	X8OI94rXdd6cOyYS26uHOYui72G0CN8XcoWa18E7ibMclvFkjgy7SBh5nqA4oCnvMl0oSkeq57x
	1rylhhta7+0Dl4PQEca7M1UkvHh7OV6D9AKzNXVmjBwGnW
X-Received: by 2002:a17:906:c150:b0:c41:7e99:c6c2 with SMTP id a640c23a62f3a-c5066d8a016mr441081966b.44.1794485007423;
        Thu, 12 Nov 2026 04:03:27 -0800 (PST)
X-Received: by 2002:a17:906:c150:b0:c41:7e99:c6c2 with SMTP id a640c23a62f3a-c5066d8a016mr441077566b.44.1794485006914;
        Thu, 12 Nov 2026 04:03:26 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49bad3cd31dsm2017312f8f.56.2026.11.12.04.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 04:03:25 -0800 (PST)
Message-ID: <d662a912-2b1f-4815-9f1b-f510753f8bd0@redhat.com>
Date: Thu, 12 Nov 2026 13:03:24 +0100
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
Subject: Re: [PATCH net-next v2 4/5] hv_netvsc: move a new VF to netvsc's
 netns from a work item
To: Jakub Kicinski <kuba@kernel.org>, netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, kameroncarr@linux.microsoft.com,
 ernis@linux.microsoft.com
References: <20261109194843.1353592-5-kuba@kernel.org>
 <179439413220.2199510.12624366739640158561@kernel.org>
 <20261111104020.2ba90f97@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261111104020.2ba90f97@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/26 19:40, Jakub Kicinski wrote:
> On Wed, 11 Nov 2026 10:48:52 +0000 netdev-bot+sashiko@kernel.org wrote:
>>> +	/* pick up whatever netvsc_suspend() stopped vfns_work from doing */
>>> +	schedule_delayed_work(&net_device_ctx->vfns_work, 0);
>>> +
>>
>> [Severity: Medium]
>> Can this run the VF move or takeover before the VF's own driver has
>> resumed?
> 
> The resume handling is a disaster, I can drop this patch completely,
> if preferred, it's not really required for the XDP rework.

I think it's better to keep this series to the bare minimum. I
understand the rest is functionally independent from this one, and
the above concern is only really relevant. I'll drop this patch while
applying the series.

/P

