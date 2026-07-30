Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACECB369D57
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405728; cv=none; b=DvAuu5ea/RvY2Qx7oLDCQkwTwSE6vX3/zQytEfV5Ksa+cQQm/o/RnjCFRksXJhHBSNXpyQaJ2VQJjJxTYDI0N/GMB8DQUsyTRXxUGXjbR+DU/FSSZM6Ui0fPWFHqlxKXG6xOdFyqZbK9KdG62IUxHJc2QPQ8PG83ODKb+Qy1ZqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405728; c=relaxed/simple;
	bh=hrSLrX7YC7PkUUv3YBWcTkVq+DlhAeV468G35ct75MA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rnKa3dcuZTInafdFfUFfbTdHBfkCbP8o+EwIfgPRtN/EIphVJmOZA7toEB14wJiRLQMbLHddnu579yGMcApKvblJVqkgC8Ci4TPIvKmE/TFlSJmPkgTf3wi9brKVVETul6cr5ve8fMcoHongz41kOBKDHcepOr5NDF/Zv0k5PEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L9UwGFQS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gH3ZYSPn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9UwGFQS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gH3ZYSPn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785405725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QiyZuiTForSAZqWqo/gtIBy3q8EpOKn9So3zlplj93M=;
	b=L9UwGFQSW1+cSx6q21dF7ogm9EJfnq14eC++sO5q6gcMDVog1o6D4SPwFZGQ2rZyBefJys
	HkdI05QvTfD1AzvwVBuA8wop8QPOahNRpfuPglp/1IKYUSvD3KWrZ78yeHCSzTKkaMHftw
	NZ5nK/t6EReffdMLsAxDbP/0HjZmiYQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-3_pdmnYXPRGUT1tZVdHDoA-1; Thu, 30 Jul 2026 06:02:02 -0400
X-MC-Unique: 3_pdmnYXPRGUT1tZVdHDoA-1
X-Mimecast-MFC-AGG-ID: 3_pdmnYXPRGUT1tZVdHDoA_1785405721
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-496b4cc049fso5596535e9.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 03:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785405721; x=1786010521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QiyZuiTForSAZqWqo/gtIBy3q8EpOKn9So3zlplj93M=;
        b=gH3ZYSPnb6B6gOY7N0sUwsaw7O2gWzQkbJ97NOCp26yF2JmPh/gFKJd8F0WWMqmsF5
         EZLXlJ6gUkEY5Jr6ccNZUjOx0u96x6hkFRYljqryY2eGcCO6LHattrfmG5PECKvA57wX
         GdLMLixSh1wFTvy4fbfNMEuBI8V+lNhJByTMkpmx0zCvUQWmky6IHvy8ghCX8FxcS35J
         L9UkmQgQ9PJ0ouVD3XNQ7rkzC7SfwatGlALAbKBXrRHtU28GSwVKcm1hiQbQB/5/p8t0
         yTF+rfbYzn76eZ62iP33/xnrNVVh/UZHLtuZe0TeO+Bt15ywNX8cCPskl5sTucJgc55N
         RUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785405721; x=1786010521;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QiyZuiTForSAZqWqo/gtIBy3q8EpOKn9So3zlplj93M=;
        b=kWVVNx092OX3rogW6ktzO04d5A8lgmoEc78g/4+vQSbLtlu4d7L3zCirYxQSstvi72
         2Pnu2fI41ZvA7t0le/c57BJE6opaIssc5Dae9JcSwye9dZnZ6+FzmYDdtNxP1iYvbB2R
         kTssxBwz31XlZ3Vjj42cRwDrycc8fkGu4UeWbzS3UPalP3Xit0Fh/zrqqoRljCofO5Gd
         hBAiZrKGETfGKShnDhYApp7J8COS5V1T/hUJzG5MEydb7w/WnSQ5Pnq9I5itbwmaGPXN
         pJyJxGv789/HJhXiZUPjldhLcXsa5Cn6zukaXLClxdWrwfMkllMeME1KjeHFQPxrh6Bi
         Hvtw==
X-Gm-Message-State: AOJu0YzL+dT1wWPXem4u0KvBmjQ/rdle6rwUgU+wNpsKuxSUksoQDvNJ
	otq/ibemHpfw7IRjLQF1RXRJ+q+d0hzPfGbzhzWr166bxpxvJP+RWJdFVcGBCUPJULVjP8PGN5B
	bpUI6O/M7tuhrwFhPgl6KXjZdlmfpF1hCW3X0RkGHYDSVXuMT09W5J5xq3g==
X-Gm-Gg: AR+sD12R9UDdPt3RxMwfPFeJiDY5UkFLG79v3/Gp0RH7jYDJx6NQnOwNB8pIvIAdH9e
	iFIf00Zhp9o8VdePm2UZFFGbAGSkYY/uEjNILCajiibzcOE5hoVFXLDFvM/3COQW+M6LCjU7fj7
	Q4DkvPa/2rBbyFpVAYvMZStQK1PW45fT/mHCYU+cuENMkCDKlt7tfMQEfvAPk3viPzjTSeYZnw/
	gjx2ohoB9UqhlzX97UV/ZPb4tuyC7L/F9AuDaREVIM1OfcC2SZ6i3L2yi2o0iY8LG7/LLBlPfVY
	gpkiiwTRNpe0iGmPBxph98lXACND4ecNuugWjw5+Latl6MtEHdYE+QTV9ik+Fu6T+t1kAR43oB+
	m6k8U8MOcEV7ms5E3Lr5jfO/cucQdwzCpbGocjouFwbBFO/6FjxfrkC0y0FeJUA+dSE/oyxdxJE
	1pdg==
X-Received: by 2002:a05:600c:5487:b0:496:bc89:f0f1 with SMTP id 5b1f17b1804b1-49801f1eafamr18738295e9.14.1785405721458;
        Thu, 30 Jul 2026 03:02:01 -0700 (PDT)
X-Received: by 2002:a05:600c:5487:b0:496:bc89:f0f1 with SMTP id 5b1f17b1804b1-49801f1eafamr18737955e9.14.1785405720951;
        Thu, 30 Jul 2026 03:02:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011e5edesm46969165e9.2.2026.07.30.03.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 03:02:00 -0700 (PDT)
Message-ID: <26c1ea30-e6cb-4f3f-ab88-6d00f0ed2117@redhat.com>
Date: Thu, 30 Jul 2026 12:01:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] rds: synchronize info callbacks with module
 unload
To: Chengfeng Ye <nicoyip.dev@gmail.com>,
 Allison Henderson <achender@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Santosh Shilimkar <santosh.shilimkar@oracle.com>,
 Ka-Cheong Poon <ka-cheong.poon@oracle.com>, Dan Carpenter <error27@gmail.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20260720184955.3008978-1-nicoyip.dev@gmail.com>
 <20260727174826.135662-1-nicoyip.dev@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260727174826.135662-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

It looks like I was too optimistic in my previous reply.

On 7/27/26 7:48 PM, Chengfeng Ye wrote:
> @@ -78,8 +80,13 @@ void rds_info_register_func(int optname, rds_info_func func)
>  	BUG_ON(optname < RDS_INFO_FIRST || optname > RDS_INFO_LAST);
>  
>  	spin_lock(&rds_info_lock);
> -	BUG_ON(rds_info_funcs[offset]);
> -	rds_info_funcs[offset] = func;
> +	/* Validate the latest published slot value. */
> +	if (WARN_ON_ONCE(smp_load_acquire(&rds_info_funcs[offset]))) {

This read is under the same lock that perform the store. It's totally
unclear why smp_load_acquire() would be needed here. Very reasonably
it's not.

> +		spin_unlock(&rds_info_lock);
> +		return;
> +	}
> +	/* Pair with lockless callback lookup. */
> +	smp_store_release(&rds_info_funcs[offset], func);
>  	spin_unlock(&rds_info_lock);
>  }
>  EXPORT_SYMBOL_GPL(rds_info_register_func);
> @@ -91,9 +98,15 @@ void rds_info_deregister_func(int optname, rds_info_func func)
>  	BUG_ON(optname < RDS_INFO_FIRST || optname > RDS_INFO_LAST);
>  
>  	spin_lock(&rds_info_lock);
> -	BUG_ON(rds_info_funcs[offset] != func);
> -	rds_info_funcs[offset] = NULL;
> +	/* Validate the latest published slot value. */
> +	if (WARN_ON_ONCE(smp_load_acquire(&rds_info_funcs[offset]) != func)) {

Same here.

/P

