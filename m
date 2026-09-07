Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6770F3537C8
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788771808; cv=none; b=AEvbMStE4SHd+C7bPrc+cjDj5l9Ijhhjj1WLhk5arqwDwrCwC4Ze7UErBqfMdjvBf9h/9JAIVYDKxG/1r4PDAAfzV4cC9IdA278VfUPHqBQEkxCPk3FfvM97cm7hZP+kDWQ/CocXOVdzVIWZwFO1c31QQjyQEpX8M2vWXTIDFTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788771808; c=relaxed/simple;
	bh=UCys/yk5OxSHFlx0G+FD6MU3BrVVamNj9bHLgi00djw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBcHusR9dKWrM5R4a7mJXqpudBt64Hwcmm5mds6R2QlZZCzLNdcHVqsVnN+IdnfKZNp0pPOxFknp83t/3UTTNlOdoe5W0IjyKXojIjk4PnPELV1yRyIh+Jwzd6BThfgQfKWyawyI5wLvCFEYFd6OjxPU/60myJ+M1AxhynaScLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZP86Wvt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uOhUxvlX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZP86Wvt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uOhUxvlX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788771805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucajRS6H+HWWoQAE3fO8klKyejIpls/4GdgTUYhqPJk=;
	b=GZP86Wvthu6OPB6UVI+W6ibvJQk9AXVWYuFOIyj098REiiMJfrZfcmcAuD50n4muDfu6py
	Q6h50gBbC1szbSUsfac08BO51Acfs6GWyT0F7kkyujVWFiii0DwQBktxjlvMsAkTvnZJnP
	3WNW010Qd1PNxGFo7en0C74G5YSrr3U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-ackqZYs0NJmamzfrGZE5lA-1; Mon, 07 Sep 2026 05:03:23 -0400
X-MC-Unique: ackqZYs0NJmamzfrGZE5lA-1
X-Mimecast-MFC-AGG-ID: ackqZYs0NJmamzfrGZE5lA_1788771803
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c253185765dso344673366b.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 02:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788771803; x=1789376603; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ucajRS6H+HWWoQAE3fO8klKyejIpls/4GdgTUYhqPJk=;
        b=uOhUxvlXAFmxZjF8oVWuUrrIP9v9fMSRn0bzxodH2SSvDLP9rMnG8/ND/er1GFygzE
         8obFhiJcZn2P7u+jk8zKJurWH/rhseMPTvyoYAl2KKxc99etRlgFYVstWu0esnNoIObb
         wSBfrMKVNtBmNJdTq2roHMm0SGscxXaHFN9bpB/HQgwhEmq/Ft9X4pg/qrvGxgFcWOYb
         MnvGJLOm/SZ4oAhFT6zuY4TkiN6PAAT7hfC1FGVQ9Ct3NNAE+JJvO67o0go/5nVWvu3D
         GKGyloXrq/RAY10GFevk6A1Dpg3S8RSkH8ckmL7sB/ZWISEnsymjmdr6q7JZlsZSPm+j
         LwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788771803; x=1789376603;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ucajRS6H+HWWoQAE3fO8klKyejIpls/4GdgTUYhqPJk=;
        b=bK3xZj1QoagdPxcBeSbQG9lruZksRLKB3gDtWM6wBqLrnSuTiibPOnHXbz6UPeEvvC
         PJb99nhQNODYwoapru/zJN+SDdpW3556nUKvww/5nEET0umieyEAzjzJBfVH5F0wYnMZ
         nqtzbmDS0DlngapHYUry5vLXoMpXJgXq/RvMX1mhZQEw1juCOySgl/iIeeCaZG1ryN1M
         8TpCWVA2Frct1fmaJWBhGngX2NeKd9VCmPdCRWrONMfhZHJHpEGN28xyf85eELKe2RUE
         bFiqyjgtNNiZSP8ycj6QdyZAOGIiolZLKHpO1t5GO1FVGP4IhkOwb1zgUmt5ukjjJ8Ya
         3LCQ==
X-Forwarded-Encrypted: i=1; AKwUvByusxw4h9dKV/Bqp15kiTeNYx99Y3AGzCKoDn22AI28iD1yz0H5sG1+pynIMx2g65GouB5AjhM=@vger.kernel.org
X-Gm-Message-State: AFuF++kHTFiJm8SBrnhNMDHymxlcpdvBtlZ32we2U3UEP3YHNmh9zbyH
	375Mqe+7mNOHmDNsTqO3RjGElJRelD4EHi9IUjjpQK+3z4mPwNuT/ZX2xERBznGefDPry1AUsFl
	deIyUk+cbLFnodF6zYY8wBmEtDwpA/l4JgALmOtlOjpjV5kvlgaSL1loZew==
X-Gm-Gg: AYBFou0gKXOb0Cp5Qx/V+RQhV7Zoero8bjcOW3wBfuGcOeaPiW3WnYZ7da9IltUhX8B
	8l0xDpyW2KEGgULWv6nK3ITD23riLOkDOe/NaLrl5hpscTGyPlggecs3BTAbG3QqT0DA+pEMlEW
	7NwTcefFep4sJlwpINQsKkxoVT8rWjefHvl7giZWyEoalL86GAfb24LRGvxL3kXvRIyZQG16B0U
	XTtqQq8czg03z88OogShTaOGa8GU22rOu5iJ5W35W7lu004D5FjyidvAJt6AFTtptCnb5QI6de4
	5gdNqyR7lShfY49oR9Wq47nmbrkSBUTHrDlmzeJt2itmw6+mUOets1bc+0NQfsdcp2wlwzglqWE
	FOEGpD1kqNnsXTFkgB3U/mA1kxi3qTARHBHxcSxGZVCYIz3IecBPDDrY06wm/EKIaAwlDjotVcg
	==
X-Received: by 2002:a17:907:1c9f:b0:c26:1691:b374 with SMTP id a640c23a62f3a-c261691ba04mr806871166b.45.1788771802707;
        Mon, 07 Sep 2026 02:03:22 -0700 (PDT)
X-Received: by 2002:a17:907:1c9f:b0:c26:1691:b374 with SMTP id a640c23a62f3a-c261691ba04mr806869166b.45.1788771802245;
        Mon, 07 Sep 2026 02:03:22 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c28e9eb4d38sm142341066b.41.2026.09.07.02.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 02:03:21 -0700 (PDT)
Message-ID: <f52b173f-79f6-407a-b7a3-f3b94f34003a@redhat.com>
Date: Mon, 7 Sep 2026 11:03:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: prestera: validate num_counters in counter response
To: Aamir Ahmed <elb12345@hotmail.co.uk>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 enachman@marvell.com
References: <AS8P251MB0001CC8A4737B0CC46F41DDFC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <AS8P251MB0001CC8A4737B0CC46F41DDFC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/7/26 5:22 AM, Aamir Ahmed wrote:
> prestera_hw_counters_get() iterates over resp->num_counters
> entries from the firmware response without verifying it does
> not exceed the number of entries requested. A firmware response
> claiming more counters than requested causes out-of-bounds reads
> from the response buffer and out-of-bounds writes to the caller
> stats array.
> 
> Validate that num_counters does not exceed the requested count
> before iterating.
> 
> Fixes: 6e36c7bcb461 ("net: prestera: add counter HW API")
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
Patchwork shows more than 20 patches from you in flight. Please read

Documentation/process/maintainer-netdev.rst

carefully, especially the section about the 15 patches limit.

Stop sending new patches until are the pending ones are processed.

Processing for the pending ones will be likely significantly delayed.

/P

