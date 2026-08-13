Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263D4418A30
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786618252; cv=none; b=X//IiCSCyU4cXJC9qPjgnBTSf/AllwOGcK0JBJKo7iqngJe4XwgUQvm/eop5aCO1Gg9WnDIlVu8fR4qfu+wa5DgJ8yzatGk2KXvQfp8LupBgoOxQPF5TTt/1pePRjw+ZRY6432J4iFbu3pDyt1ozpeTrVKWx9s4PgkdVvJHSe0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786618252; c=relaxed/simple;
	bh=jIaqtkJVqLo85xYm8GRjO5oVfzgg/kufPOpqYfbpfZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3gjsfUdKVcNebC1uc/QQLYlK3uU2F3Vw3COCS3vJ7xkVdYVJ9OPR8ttOGOxzL81xIXBO+gBurmLJ3wBOWyI4Y+2oh3z7yhTkNlZNObsnXYbTkJFW6xrsviXA2xvqRh8cBFl/2tKl2XywHDR4GIhuws9HpdNoMgNzJ1F/48UJ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gvoUItCR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zrdu9MB1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvoUItCR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zrdu9MB1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786618243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ApJCiVNhwPyhM9F5TuLUvYx6NvREVpkY9PTxvpXK5lk=;
	b=gvoUItCRvAuVb7l0oX8xMtnTkilayYTYckzZoUo+6VdZlLVBtlS3zVWmRCiYvvBluMp+RC
	qQQM6Wo2VJtWzjeRCNF6SkesKbn36pXgRI5uedgT7rjyQZeA3kRngakXXn6poTeCPAlCiy
	JoQnyJdcBZqacumb2QS29D2Mw8AUl4Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-tTkJKCv9PRyDj3d-5Eq5Tw-1; Thu, 13 Aug 2026 06:50:42 -0400
X-MC-Unique: tTkJKCv9PRyDj3d-5Eq5Tw-1
X-Mimecast-MFC-AGG-ID: tTkJKCv9PRyDj3d-5Eq5Tw_1786618241
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4955e865174so3206395e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 03:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786618241; x=1787223041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ApJCiVNhwPyhM9F5TuLUvYx6NvREVpkY9PTxvpXK5lk=;
        b=Zrdu9MB1haMaN8Aj4AIV/O/gmf1k1e4ny+wMbpepxAv5UG/3/8SPTQEATxlY+OQENE
         6a98ta/MdhCFY+D4B+tEekHPaf/6uCar3YXDJBOTpkbtlto2QLvEgt9X7wuU7D4tR3rG
         yE+/5yJrOrk/6MEDiYbyHdexC99YlhZiykWoUsG+RGZ/8PVCv8uHMl0ZxUUPh6qBPaYf
         ELitVETh54hPfFw5YIUAiQVewfm0w98cB5oHj3bAr0he8HpjnYDsSY9uM86IsiVOfwRD
         gUFU03lHjYYPd8LCmMoPfYscpKoZvdyAgNHte3IYaFJpq3w72mcm9hIFa60Hdmq+zIxU
         lUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786618241; x=1787223041;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ApJCiVNhwPyhM9F5TuLUvYx6NvREVpkY9PTxvpXK5lk=;
        b=UWYlCRtQNKdB38AET/Ge3IpnQN9bc+Z8jtJwhQUKdRYLG2kw6//x2LCW2wL/VseEGF
         nsa5GnpLqsXuWLjSQpGaYIJXG7NkeDuYTrJckQdf1Lf1FMERsPsSaFf8oy4SfnZXDT7v
         ca9U1TcWvdipsZBBIZsxFVowJ3f3jB/MGRzAujnuOvUIirSCITVxE2EVfLFOy3lcIaOV
         NQXaQr0DeREmxb3DBAfBi/EAWjnX5wT4AQpNL1i2un/Dte20HDM3sTeYBcm6ubdqojfK
         nzsB6h3VG+i4KpVuM3zo65WZzHHLUFYukkL+yoySRXM7ZMR2Ras3gLQ6OY3KSOHJaII6
         rVKw==
X-Forwarded-Encrypted: i=1; AHgh+Rqx2l4JqO4E/YhCQ2/jM/Tam9fv/eu5f68SgMFPpRd1uOzes3Lq+5voS0e/f63zfv9CeUFDu70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6W+aHJ942+SP6wxizF18TjDgAHeq9tAj9LFHE3e7L7G2xftQx
	J+nso6fEL39nj7toZGLtyFGvSp5koWwFhfpGNTTbcP7H605sGmrjQ9voNi4HAkMqoTqik44qDlq
	RjwnVZvdcp8xoQ0fgWIF4Hye/c5wZxZpLWc04mlJIpcVrBGS2T3JOjaS4Vg==
X-Gm-Gg: AR+sD13lxY8Ur4I9LTeuZAgO8716HhC13y75y+dUxWyXuam/YbizCFbC9LpYbzlZwA3
	4SRxIF4OkBwFNP0Ozl5yPRYt3n66GSPTDnHwc/uymeJVDVK/8G5l/r+x4F4gP1zKeyrFbihWfSs
	ELfRAb1zleFQsw3oKoEHdCze8UF8piVXGVtJXUv9mnlFknbqT1t3qYNnwRPRkRWqvEe6LaWmyTj
	vVOUWaENPGNLyCEEGAGUQ6eutlAh7/PfosV2qQZUyq4/dJ0zI1wkxuooqjRtSwigKgrK1cfAkQE
	ials256qxu45MsX912++awhjEs3hBRcxbhQpxjxoU7He7kSpPTJD42pGfEsm9RkmchnZdhQIAlD
	FbIm00iiJN1ixmtodh2KiR6DbNHRpbqJ30Z5HBib8FP1yZUSXlGvGrjchZEtDgCABx9EUxtWO+u
	0=
X-Received: by 2002:a05:600c:4f54:b0:498:2b1f:e0c6 with SMTP id 5b1f17b1804b1-499821fb125mr44849285e9.18.1786618241043;
        Thu, 13 Aug 2026 03:50:41 -0700 (PDT)
X-Received: by 2002:a05:600c:4f54:b0:498:2b1f:e0c6 with SMTP id 5b1f17b1804b1-499821fb125mr44848755e9.18.1786618240571;
        Thu, 13 Aug 2026 03:50:40 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5af453sm5954432f8f.23.2026.08.13.03.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 03:50:39 -0700 (PDT)
Message-ID: <a227ef96-9b2a-4f8f-9fac-c725eeb0e998@redhat.com>
Date: Thu, 13 Aug 2026 12:50:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/rds: clear i_rx_lat_trace in
 rds_inc_path_init()
To: Allison Henderson <achender@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org
Cc: jhubbard@nvidia.com, leon@kernel.org
References: <20260810055631.299558-1-achender@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260810055631.299558-1-achender@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/10/26 7:56 AM, Allison Henderson wrote:
> The commit that introduced the receive-path latency trace added the
> clearing of inc->i_rx_lat_trace[] to rds_inc_init() only;
> rds_inc_path_init() never got it.
> 
> That asymmetry matters for the one caller that reuses memory:
> rds_tcp_data_recv() carves its rds_tcp_incoming out of a kmem_cache
> with no zeroing and no constructor, so after rds_inc_path_init() the
> array still holds the timestamps of whatever message previously
> occupied that slab object.  No stale value is user-visible today -
> every message that reaches the socket happens to overwrite all four
> slots (RX_HDR at allocation, RX_START when the header completes,
> RX_END at delivery, RX_CMSG at recvmsg time) before
> RDS_CMSG_RXPATH_LATENCY reads them back as deltas - but that is a
> property of the current writers, not of the init contract, and a
> future trace point or an early-exit path would expose another
> message's timestamps to userspace.
> 
> Clear the array in rds_inc_path_init() too, so both init helpers
> leave the inc fully initialized.  memset is the form the clearing
> already takes on the rds_inc_init() side since commit 1635bb548f84
> ("net: rds: use memset to optimize the recv").  Hardening only; no
> user-visible bug in the current code.
> 
> Assisted-by: Claude-Code:claude-fable-5
> Signed-off-by: Allison Henderson <achender@kernel.org>
Mentioning this change in the previous series thread would have saved me
a lot of time :(

/P

