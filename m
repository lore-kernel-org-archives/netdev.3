Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495936;
	b=lNNMZWrbJ8M2YBB4zH7doDjudiRtZc4vM35BjtXEzUOZDgULBa8OYr5bj88uicNQLpLj
	 wZCWHv9AfnRRuGoqgi+5+SIpvNpYXZd1bucz+iDidy+Nya56YTHOsGdHfxX7zMHUUOlj1
	 RPK+F5Jnf/t1phQfX0NDFuFcG+EOKHcGhLexkKLM94f/4aUqj70qVTxSrKTD1q+EF1okQ
	 ePS1GpmLWsVLCwKX8Nry07i0xnPWsA836ZvYiMCsZErg6PkeYJslruNUH477nfpXcCBYA
	 GVxLxd3DNjRtqVIT7s2h3yCJmcvyyU5+hEz7Fgui0kjezC07aMaWkZbRNp0pZGhYhYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495936;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GOqpkyo4LPYyLkLcWc/OmF1B6GtriSScGQCA7EInhEE=;
	b=EgPCJYJ/pe8pgB3QT/eZT2MQJTlSdCldvHq2Ct9HURivUvaFGZrBUcINZm2/D0Fr4ADv
	 A2j/Knah9sHur98VgKH+by0ScleA2tNUaueY4eOxJEV1JpAp9y3+SnZlEdgG05IuGehIj
	 7H7bWHS41A6Y3wCGhUhD4PnwEcb6Y6CkBxsW1Gz7L/4fs4Pk1i2p1QAvrZ98cRNAREXcD
	 Dx/ibpK3ZVDx3a3CkcNYYY61RG1UWjy+J7ntsh0QOECT0hNOLHvabWklnCX5rQUilJMEt
	 tSEQlwzCUfuwxHM/xUDSh04WfgE6z0Qy14LGw03S1eEXjvVL9IMjdAqz2OHo/uv8/Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=edYMVlV7;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="F//A/5n4";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD6606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 15:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7AD6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=edYMVlV7;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=F//A/5n4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794495934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOqpkyo4LPYyLkLcWc/OmF1B6GtriSScGQCA7EInhEE=;
	b=edYMVlV7KDj4CILKc1yV8+dPJk2KPiMCF1jiT0GG9UhfS2vf+qLfVPbYhNlc1nnDjm1wB/
	qctOx4t4wjWYhNFx280kIeaP0TzQ5KbUdkQoc6YOOUrphR6ftt8S+o6HELhsSXb2VLQ9Ph
	u4KFyS0MJ/zqCaFG1QxtVIrNiyjEwxg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-TUNkaSLEPVu2JuVJQVzPfg-1; Thu, 12 Nov 2026 10:05:31 -0500
X-MC-Unique: TUNkaSLEPVu2JuVJQVzPfg-1
X-Mimecast-MFC-AGG-ID: TUNkaSLEPVu2JuVJQVzPfg_1794495930
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a20fd059ddso33822175e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 07:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794495929; x=1795100729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GOqpkyo4LPYyLkLcWc/OmF1B6GtriSScGQCA7EInhEE=;
        b=F//A/5n4pQpDyMCnhlgIVbYdrM7RbFo+BdEuiCYObiEwZSLgVxjUXaSj8siJjlevCs
         vsX2pH1A+BoqXzfHhTjCGYtRJKd/JwEVaZXN1Pu38YkEDBmK5e3p+7hld6U9gjKRtene
         zF6qrpx/7O2oOvop729rO2GJF3Y6M3Ho0QTklkiARvJMLF6tYvJ/BLWzytxrnbj6THWD
         ngbrtqSnAcDV+uyL3iGaAaKxR5Z7M0PoNDy1Lbo+0k/DFjBqrYGTRaBPSQYUfv0P8NbX
         IT22NqA+gBevaE9Qp6Yed4EohOB4oH7QcEcLdJiflhxIU8Yimh/k8KYVUvYJeXSERYkN
         +4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794495929; x=1795100729;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GOqpkyo4LPYyLkLcWc/OmF1B6GtriSScGQCA7EInhEE=;
        b=TOe5KsZxZUZFYACH5xSpaOyI2JbFWwDY4gYPtttySNGtWCC8gZqJdOZNJZMQt6e2Pb
         2AZP7OB5ZQcX12vUM3oz69wg0MIB8g6ZMX+TLNy7rXdyqKim9P/pIyX9DX7MLShKe6kT
         IKaLKEPpITYWZg6BBQHVsnQajj0yqmh2vS/TM5YVHQoyCAr6XOQOFHC17/UP9zeRDrnt
         S92tzePfCf5XGTxPLh+hpgP14qdOX+LkG/TvnEPXu4bwNGRffu7Ol2sboU4LUeoGzKp7
         YDThay1l3alH4/wBqmRQ3XUnu3Lz+p5YakvVfEAw9RTXrtoyKwOlpPDPgbs9pQostJau
         Fh/Q==
X-Forwarded-Encrypted: i=1; AL+hErFFyYkc+8axVFeb+k4rIW/c1ou6c5xChlq/9iPQqUk7IALmzh4SL433ewZ+PRW494G+deE1nbI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8u/TLkjdQGN1BeNYWH+nJdDNgNiwMw1FKRoaLZ3tnXsFU6WuYZ
	JxEfY2Dg3S5/aT+5EwSy8Ef5ckuAZ/6S/CRbHPn9PEDVnNlUBRcAadSSXYAUFLsmKBY8rPzUaur
	gMgpzAfKupQIRlpvg6Zdt8zRneEJW+Cv5ipTLFrRKa+6OhbsODSWWXkvGIg==
X-Gm-Gg: AYBFou0mE08V9RTrlyW8tEnfC5E3p1rBEJYRqApBJSjNITNe81l/04ddKP7bzF0UWhE
	ys+oKn3V8rV4mawvKVqROs1eOj3Y3UAx0iAfGYIy6uLGHwwNq1juCeAsUpNIa9HBEprzkCsNcUm
	YSBhwmy1xW5XF1CGWIh9wve1Dmh1C6er6qRmtQucyWTvz/ftMkAho1Gq2GDdtSp7y2/kil2FiwQ
	6I1RPDsZvawrGPXmonIJJioVW/hujHsKG2wKS7yEOkEtqVO46+eF27VN+LTCLAiP3MzeHeaj4OF
	PwqUvpfKwP9B2XaXkFhCrxlwSztZWLtUvzQt0Fdmpkhnzms329dzR9KklAFQpVUkPTwei44G/8H
	p4s2MiU3loCZXU5iVNoSErVNHPD5qAm9TW073Ni4/V1w5AurVlMFZtsxtTszSQYoNf62Shd6sqK
	BpP7CREVmnEignAyJ7wq/NhjUf3dWTKSDBAOvnvPaUGLZl
X-Received: by 2002:a05:600c:1389:b0:4a1:f8cb:7d70 with SMTP id 5b1f17b1804b1-4ba09388518mr111954105e9.24.1794495929600;
        Thu, 12 Nov 2026 07:05:29 -0800 (PST)
X-Received: by 2002:a05:600c:1389:b0:4a1:f8cb:7d70 with SMTP id 5b1f17b1804b1-4ba09388518mr111953325e9.24.1794495929170;
        Thu, 12 Nov 2026 07:05:29 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2842e6sm75067305e9.4.2026.11.12.07.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 07:05:28 -0800 (PST)
Message-ID: <2dcdcc8c-0484-4fd0-b09e-723b32cbacd1@redhat.com>
Date: Thu, 12 Nov 2026 16:05:26 +0100
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
Subject: Re: [PATCH net] ptp: vmclock: keep the device state until the last
 file is closed
To: Chad Aldreda <ca@modelmiser.com>,
 Richard Cochran <richardcochran@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Shuangpeng Bai <shuangpeng.kernel@gmail.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261107150344.3946529-2-ca@modelmiser.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261107150344.3946529-2-ca@modelmiser.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/26 16:03, Chad Aldreda wrote:
> @@ -649,9 +680,20 @@ static void vmclock_remove(void *data)
>   	if (st->miscdev.minor != MISC_DYNAMIC_MINOR)
>   		misc_deregister(&st->miscdev);
>   
> +	/* Files still open now fail, and a poll() in progress returns */
> +	WRITE_ONCE(st->removed, true);
> +	wake_up_interruptible(&st->disrupt_wait);

I think that sashiko comment about using wake_up_interruptible_all()
is relevant:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107150344.3946529-2-ca@modelmiser.com

/P

