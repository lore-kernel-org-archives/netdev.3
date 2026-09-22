Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25513F9F30
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790073911; cv=none; b=kdOM6e/tetPJ0N+5G/fUNk0K39BAKUXnwfnzi1AtumWfI/Sq0GA0LBc/EFI+Ts8sd/lmOh3NTgAiuDao5LUJqOzIaBYgAs2GUQyx4+VJvSnXU+dudjvW+YJ90KLGK1oDdJKPgb8Df1iUZO48EiQ1t4BJqMlvCvttYF1NADa12LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790073911; c=relaxed/simple;
	bh=rsszUF2KmfCwnNhIRD1UgT1nm1ET2JyqCNtTeEplDeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuDYP0qaWFMvqhJpFVymb5Xs6W2CJBgJRRV59B9VIR0/RJN0twDVQLYjhvoFHKM5veKw+qTMdXVQyQDfZ68a14olPbTwQ8I+lnfucvL6s34WPqfUQCsUYJW0lXLPnmd3Go1a03W0X0Z279kxezepcnwIUMsBkE1UwmAaYsQG18o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ac8YblxV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWFeNaKr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ac8YblxV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWFeNaKr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790073907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rsszUF2KmfCwnNhIRD1UgT1nm1ET2JyqCNtTeEplDeE=;
	b=Ac8YblxVYvCajEuUrLWvcpilzrXVsVh1+T7dWQizExuN8vxIZGVAPJGZ0H7dkOyYdhHRI2
	tJeqAVVIHiu/iTeELLlkuFBqnfWn+Ar2npgxqjWsXzYo9IMsn2K6tATNYnUb0QABRhovN8
	CVN3nVLVOStR3w0ND3QG4dVuHSpcAvE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567--xxEOHFOOiai14eshE8Zng-1; Tue, 22 Sep 2026 06:45:05 -0400
X-MC-Unique: -xxEOHFOOiai14eshE8Zng-1
X-Mimecast-MFC-AGG-ID: -xxEOHFOOiai14eshE8Zng_1790073905
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e76a80fe5so55983875e9.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 03:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790073904; x=1790678704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rsszUF2KmfCwnNhIRD1UgT1nm1ET2JyqCNtTeEplDeE=;
        b=dWFeNaKryHWywC4OqRkscRGuncEZlTMk8T8Q5wn9Zxw9XqQJ/e/+cOccdw8L8wwXPB
         tFfH51C8Wjb7clsoHMx+W+5RZMDBYJyFRNZJdPveM6pKeTWJF7jIr//AKhJDYFNfeBj1
         +t3LKdSfIJWVZYsLEThHqlVwLcYhOvN2AEwj+vhBkes0RhfmKlXm5QTo3K75/3hmdEy6
         O2TIJZiG87R/fzw+MGMz5EoKld4wHZji50r+cOfIeqOIxQ/nho9cy3Wh/M0LFwUQeGd5
         CovG/kwXt+hgOs4rQKGL/QmkiJZCFTYtITMxpvjeNRi2qx/tFnWNQUvnEJjfzA88jAPR
         Ousw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790073904; x=1790678704;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rsszUF2KmfCwnNhIRD1UgT1nm1ET2JyqCNtTeEplDeE=;
        b=JOuhJoPtb/Ty3O8R7TN6g/+1O3F18nhYZDlW/sBkMUVYdDv7bimCuWMd0nX6rtZA7W
         KvXuClCoUQPJD26gcpqkmB4yTShhCMC5c7gkpkvpa5yrVY0c7ObnH0MBxEs/URBgQHSJ
         xUyf1IFADmBgqOc08TDnokuvSY5AuA+rd5HAt9bdHRaARx0artgc4TQNvYEeToSgLLOC
         PUe7Uyns54/ZffsmYLz7fWwN8t8B45LgNf0jFVq9Cs7shzfPRLWLiUyWNP/T6dvhPmX5
         gMVcuaODxAM6RHPD0whtEw1F/bajQ51BwoIk3kQShZsx1nwW0yqhTnEU+b3hkdmKycaV
         vVXA==
X-Forwarded-Encrypted: i=1; AKwUvBxYGRcFLj0FIaC/l/7ALqz1qBq37wZeqkSNnmmmY6qbLkAb7bXmXwPhk4b8ubo1VcbyK4GQWvQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ndVL5aZMxXZJl9PjWJsxh3+4uqrBtx+I21FhcK3ZGfyDR5mqXx
	Abf92AkSs0gIDOBiz38ycSm96436CsPJjJA4eIlwZIgLRMQKXoe5milbs0yOpYRB1ow1h9gCYyP
	4md77Mz7WHir2D78BRRQV6Myu4lKg6S/doEH7mQt9MmRsPI2jgRmeG7OvcA==
X-Gm-Gg: AYBFou1KJbcq8mJNLAphZGd+K703sFgAQBCFyh++duqS2bVGGnG9Py3jkAiVovJAXK6
	8Zk6e7gleqqtxdq+21rpiFMQnl7fmn3xoKIet/9wz+rdEOpH8soNb2yuuQEOShzXT7rJtxBpZ2P
	UxLMb9act2pXqu7M157CbpiKawxZ0gK6xTLELPYr+abym3AVEgaPghieVE+AJ5N4Bn/pFNHQJ/z
	FTmd63fhf+D4SYkC6FBulZ/neDCM5JfkJnxgNX0bW1xVTKjjZmqDznrwGhi8mSxuoZEcy/BnBuY
	sHSW0ZAHo5Wyzi2ZrHN7IY0meo3ooPQ99t6t0FIc+BZlNweOgi099DJN2JxUWhICznChcQ/Rl8R
	KyfVnwgAS+poD4+/rIjB1PFAjZGN7rO7entLqIxA8Z2TO2J12xgs=
X-Received: by 2002:a05:600c:a410:b0:49f:d58f:1f8b with SMTP id 5b1f17b1804b1-49fd58f214fmr60712585e9.18.1790073904511;
        Tue, 22 Sep 2026 03:45:04 -0700 (PDT)
X-Received: by 2002:a05:600c:a410:b0:49f:d58f:1f8b with SMTP id 5b1f17b1804b1-49fd58f214fmr60712315e9.18.1790073904124;
        Tue, 22 Sep 2026 03:45:04 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-131.retail.telecomitalia.it. [82.53.134.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ce24fesm110065955e9.12.2026.09.22.03.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 03:45:03 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:45:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] vsock: remove dev_hold() and dev_put() in
 __vsock_deliver_tap_skb()
Message-ID: <arJcFUflXLlF6wzA@sgarzare-redhat>
References: <20260921094218.483234-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260921094218.483234-1-edumazet@google.com>

On Mon, Sep 21, 2026 at 09:42:18AM +0000, Eric Dumazet wrote:
>__vsock_deliver_tap_skb() is called from vsock_deliver_tap()
>under rcu_read_lock().
>
>dev_queue_xmit() does not require the caller to hold a device reference
>count, and the device lifetime is already protected by RCU.
>
>Remove the redundant dev_hold(dev) and dev_put(dev) calls.
>
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/af_vsock_tap.c | 4 ----
> 1 file changed, 4 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

