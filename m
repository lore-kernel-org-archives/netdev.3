Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793555066;
	b=Nej8w/fYZZSMdXxILBQU7W/SQKMnYYndKzVo9xXieHkwguMImo0D24fRqM4qKw1uv8h5
	 CkvUqkxs+JYB01NjTAShtGd2icuUbnVLpAHstNVtUbdjTKu+qsAFncfzOIwkpYoIIXk2+
	 I4Uzyynfh1emXtfBVHJ1+RDn7nTEuESAYFts7VTzu5QJjQ0Q/TWW+SULlHBgOGj3oTF1u
	 cIpBDKcl//p8Attbg6+1R9jo9oek1oZvZ+51YUEe8dh7HTpCkrbAqMSqfRcBNt34CCuRr
	 2iOF/fF7IXC+iwF1FeYIS48fqug8+mQ2WLYLJNHSBLCqdM/Cj+usHALAbE/F5aM9vOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793555066;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=XNm3LmvLDAoOMp150KbZwglunPFF846Cqv2g3FpPcDc=;
	b=YZDKKIAY0hyR7pI1ylHJiYPHK2SUofq2QH6XxfvbF74iQCMUm2VJjFJTfof7i9dKSADN
	 NMG3+QDfeOi3oaog+CY5RsdbLuo6FzJmmlX6LYOix1JF5G6JiOuR+glZ7CwF2OMEdjeB8
	 j8ITI+lFVHXuW/pt0Vk6BIn7jwcZfvToS5dPdedWpctJcIR4cj9+UAhPYq8GgYJmr6r2e
	 DWTcn/LZNMEYLvSgEu6k7sEi6sDkUNiyGS6boTtpLqpUfpUqf68XYOVfDJBWMfQJ/cVlP
	 ORU7ux265VcFQwFQ5iPdel6dILi+NrnfvZB9qx8rR30kRyQpqNsrzgJNuBWsWXMnXNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VJ215M29;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lQAOWYS6;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D36606A329
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 17:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94D36606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VJ215M29;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lQAOWYS6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793555064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XNm3LmvLDAoOMp150KbZwglunPFF846Cqv2g3FpPcDc=;
	b=VJ215M292f97S1XO38lWLbyWQMyGURPGPjdo0SoOByIgzhPEf8Bm3jjxqVARlsrzsEesSi
	FoCAYYzaV5YK0n5/t5J0ocI9IwSnY9zuW9C4+XxrAiRHvsb2ipPprS5372mWIQ3Rlw6lDN
	ksNpk27DFqDYtJODFSwoM3a/ejRPwhg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-ISryBUC6O02zxxoSXZ2_sw-1; Sun, 01 Nov 2026 12:44:23 -0500
X-MC-Unique: ISryBUC6O02zxxoSXZ2_sw-1
X-Mimecast-MFC-AGG-ID: ISryBUC6O02zxxoSXZ2_sw_1793555062
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e1291432aso1824636f8f.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 09:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793555062; x=1794159862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XNm3LmvLDAoOMp150KbZwglunPFF846Cqv2g3FpPcDc=;
        b=lQAOWYS6S+5Yf9TTn5qo1vLRs/TKvPqiCoXOqp5mNMeDDCFVPvK+Ms8pruPNkilKOk
         XKyiuEGS2IYRBo6rqQIQrPCZnX9wlUSHhQmSoRMub96VP3zDcsoqk8M7zS1zQQzipL7T
         T37Qk2PXzQ1gjvJ4MOzQhEMEua8/epD5iax13CfLh30QdzNx2wyDkkyurqP1y71z5hfg
         ENIJJK/0K8LlR76g1BQr+JKqMgO7gX3ra6jqb2jjqR9ySdDs9+4zAnzyf2Z1XZDjyDux
         Cdiqb+GFdiTpSjuZjpbSy+6CvJPxbpsCZ5gktrNlcn8qdm82zHYOF7i0B6bXqfJU/Yzp
         /smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793555062; x=1794159862;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XNm3LmvLDAoOMp150KbZwglunPFF846Cqv2g3FpPcDc=;
        b=B74sY9pG5b1UY2B0fJEyyCUfeEieavMpP7K1p8cPW6cenmGMZUwjIpt+hCT+W1olrg
         ujzknT7wRpJBaz68t+5PXubvj2cmf247Qa6JpKzbKthtTANnIXPPffKWEVP3DlZpAMSV
         oRD0o1X+D6UxNLsCVML7IVXZkYxzgeKhqw3rcZQJZh6s3lJve1tb4FQ4SvaSLjCACF2W
         oZJT4ObdD7NpWsvdTwK95Bg7lVMQSlF3uBD5rkbNhuAxWdG/kz25VVq5mERSbPcs1WXB
         85hUzHEH90ceSaZZAT5t50+Q5jqcno9oFjU96x2eEUKQJtJHorwR9jvOWEfFmYAPhHxF
         JjgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzB/KlwnCEct24hX0lrR9VBju5U1Ns5h5O3sfRHQ/f3GHO2hMegN//gK0yRIg1o/FKb4vepFSI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJK3nAygjAj1V1dgbW46Mfiq1x5m4aNVrn3GqguAI84vob73w47
	e2J8HGyYLSq0E05cGMbVTtys7JWGSy4iEMwMC7IrnAGZAyHheOyus2g6Ptak31yqwZry5n7NMLL
	Wmofixmas4rdcOcYb2Zgom3A4EXAj5JRjHdb1sRjfChgxGVLtBuZxbVzeEg==
X-Gm-Gg: AYBFou1SN3uW8nRlPtjyd+eEp6KtzwV3YUAdkGmnFwq/ySK6Mtn0wnK4yvVzrpiIfoS
	QlFdd147FYkII+qJh9TEeQ7OFeP3J0gcngGLtm+1GlHvj4h/vOx4LquFWT1Qhsn6K9yHqpUh7xB
	0FRNRol+m8hN4MiWc7Tg2b6XBQqjCY7HrkaAXLuvsKsDU9+YW5mpfbUoBI7pGCRvYm3T4RarIXK
	/p8gm0i4k5nOhHB1T8o3nnNUO4O3oEVZ2NiNBHJWvPPkqYVwqvycAI1OriR6aYNHGuw+W9AXGz4
	SI59aeVb11MeVBG0ySvsYaq+rnf5jvPtcOFLeQ0roReJMyttU6BOaiMnWeGTOibIUzY2pMCu4MD
	H+HEuZ1Uv57xKVokvrsmXLFD+hP3TUFd8coafp9Avfgntq1RxdyKwd3/Xna+kJ5X3Q/ifaW2Alc
	mDwNVUQ35hKkT7Y17IVZjdG7w2IUJHyXoVlrEdZLmOuAg=
X-Received: by 2002:a05:600c:1f93:b0:4a1:7e76:d02f with SMTP id 5b1f17b1804b1-4ac180f299emr171019115e9.14.1793555062158;
        Sun, 01 Nov 2026 09:44:22 -0800 (PST)
X-Received: by 2002:a05:600c:1f93:b0:4a1:7e76:d02f with SMTP id 5b1f17b1804b1-4ac180f299emr171018685e9.14.1793555061751;
        Sun, 01 Nov 2026 09:44:21 -0800 (PST)
Received: from [192.168.88.29] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf751c2d2sm233727495e9.15.2026.11.01.09.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 09:44:21 -0800 (PST)
Message-ID: <ce0bdf39-d514-42ba-bbc4-066054737944@redhat.com>
Date: Sun, 1 Nov 2026 18:44:19 +0100
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
Subject: Re: [PATCH] net/rds: Do not unpin a page after a failed atomic pin
To: Kyle Zeng <kylebot@openai.com>, rds-devel@oss.oracle.com
Cc: Allison Henderson <achender@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 outbounddisclosures@openai.com
References: <20261030042110.73571-1-kylebot@openai.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261030042110.73571-1-kylebot@openai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 05:21, Kyle Zeng wrote:
> rds_cmsg_atomic() assumes that a non-NULL output from rds_pin_pages()
> represents a pin that it owns. However, pin_user_pages_fast() can roll
> back a fast-GUP pin after racing fork() and then fail in the slow path,
> for example after a concurrent mprotect(PROT_NONE). The output slot can
> still contain the already-unpinned page.
> 
> The common error path calls unpin_user_page() on that stale pointer.
> This can consume another subsystem's pin and allow the page to be
> freed while it is still in use.
> 
> Clear page when rds_pin_pages() does not return one. The error path
> continues to release the page on errors after a successful pin, and
> successful requests retain their existing ownership and behavior. All
> four RDS atomic ancillary operations share this path.
> 
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
Picking this patch randomly.

Please slow down a bit: you have already a dozen standalone patches in flight.

Note that that 15 patches limits apply to patches tied in a single series, having more
than a couple of series in flight is quite unusual. Having more than an handful is putting
quite a bit of pressure on the maintainers.

Thanks,

Paolo

