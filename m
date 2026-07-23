Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA5141685F
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798075; cv=none; b=hJiu6jr0TolZXzqoAzAp3oW7j2OsRGwjCEXiO5vUaAtP6vVlQKWwmxZQnEZNfn6qLWR6jJTQI1Duk3KqgkNtc8z9zH1rg+smlVmL0capssyjUpdCE6Y1/vxs1I521/vs1WO81ICJMkYxHhaYNTwfGWWFa9AMGPvm0XheMKRNztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798075; c=relaxed/simple;
	bh=MGzlaFYxY0p1LJl5ms8gmtRg7Db4xnRwOjt2AcrJ8ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HC3dU8qVyAXaAWJjsMyfBTu/h3iNR7uC3c5Pn3n3tNVRL65Fkz2sPO4hB0uWDB0wNl7PVT+KRuCUDw51oNUboShQj3DM4OQGqHDFMDi5w9i0BikIWiF6LrW4aPwYF89jp/8oc5wSZItvU4y+bM2RNxZ9HFgI80GmiwX8YBgiVFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bwnHO0On; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dI2ZRg6n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwnHO0On";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dI2ZRg6n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784798071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yD7oMmz7uF9R3lT33QqMXiSpyVxWBX5RWkUEZ5VLlHQ=;
	b=bwnHO0OnBUyn+rAaDd8NftP+4FnHszUlVkkC+1OvY0HpuZ1TC3z35xSTclOBmRnmddQod8
	zt5upywxD0o4EuEYrYZa7ufWrsHwKl2wfKXSdZZMY/HrfQs4QLkS9RxGvR2foDzU8l06/8
	Zy1ayaatYRYJTvHxj/mhf1zmz+Cnjyo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-v5DSiU7DNy2obi-ikGp7Xg-1; Thu, 23 Jul 2026 05:14:30 -0400
X-MC-Unique: v5DSiU7DNy2obi-ikGp7Xg-1
X-Mimecast-MFC-AGG-ID: v5DSiU7DNy2obi-ikGp7Xg_1784798069
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4956b4cfe19so3451205e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 02:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784798069; x=1785402869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yD7oMmz7uF9R3lT33QqMXiSpyVxWBX5RWkUEZ5VLlHQ=;
        b=dI2ZRg6nYyRKFGEI6tA4U5v4viTynwzT6ovgBzI7Lj6i1wzb51sGTEffYqmvXz54Vf
         W3zuBGAwv9ua6HPCA2qmfh6aBIQhVfRgfoJ+nkzy2SDqdf4b/iDlNvdvs6THYMAojYdU
         lX75XfIEyJGxzkxgQceGQZ1scb3gwlxDgak0i60dEbL2zgsa8adIVeIaprJCQ+wXk9Z2
         zDpQtga5iYnjXCkDkEiyegTjlpyNadShX+T9AvnT2DZbKUBUVmn5zkKiMu6t2ZaUjExd
         XoXOinyodxMCXN/7xxldgaP4ITBzegTRIhnPjCAuRSOTe4JiiwqW0OOznD9N+gVjg+Be
         n1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784798069; x=1785402869;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yD7oMmz7uF9R3lT33QqMXiSpyVxWBX5RWkUEZ5VLlHQ=;
        b=c9e2KbSS6Hm4ZCWINr/rTUwCpqRIGysqJIuHtYIRQC1Rwr2q5XIV0zjgP6AbEXwMsZ
         IOBBX4yNAY7kIjk5Y6Bp0LjMEOlCPSL5Bv3I/McYmRv++Z0dWUbQbXS7D4yq/RaInb/R
         0Z2nORo9kBamNvveXwNvw+0K/CsNnRah3AQDit14cEDqD6Iy1qr0xQLxPNYtlLkMJSqJ
         E3aRphIRtYYcmYtOqihVxBNdBaFGiE7Wb0kD0Ka/6LITEPEhOO7TawvdNXXTWji3oBkJ
         lOtBEwEye0VInJsO/Upaq4jCnF0Pw09DMeh9TK9Lno/H04QQH1bhp/ZmWmffd6AHUp2G
         gldw==
X-Forwarded-Encrypted: i=1; AHgh+RpihdYgXWwU26NPadDCBrHI/Bp6iVq6+9u1tDXPFf/qyRUrivAIJbFERwdlqqT16ux86G465W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMWSvnXaPlrHgW6BABFB9AXIgts8mFb51L3r6OOY8zLmywLA8X
	IoyVltihPgBKRiGYrGWUKct5QVxCc9mrpR2u6nAJMVyp4YU/0ju3ftVRwVrbKOAxn91M0AJkGbp
	koby8hrjsgtFgBt5AIMHi30W2C1PlXOl3phofNxQXKuIWgosCzQk8R4JzDA==
X-Gm-Gg: AR+sD11g25tkj2zzrlZPbTm7v/b/9KOCSpFlSvJpWeW4PyFey4SUAaS4QTFBa53pSg3
	WVkUzbDNJqf3TFYkMyD2yjvxx1hWd3Ae12Q3IBt65KSFBtu7irWMJtPtuQLkspCZB9FhxhkFlt4
	5avNI0u9QeFfBs5mIbSiXrRHw2LsBj36aGCpArFvG0Ywl96+mx3FckwFTtc0qZDKhgeJBpT2CwN
	kdVyPuXpjrCPqscG1dSns3IdPM+ddzpOdPYlM93l/cvYYVVPR1LPZkIt/vLgAbAXi1YlAWjfwMT
	vTQfysa9v7QcrpeVvFEvYOKhNl3mvYZIrF2lKppqQBnQe37t/4MtNqssipzjTmJuV9EwRdVoKC6
	2hLY0L0zEvR/900Py3vDNrKOo9GsDVCBfqTCsV6Q25u+NSuDnl7FONx6Nbkw9SkVPtXNTlAzbMN
	l4+A==
X-Received: by 2002:a05:600c:6a06:b0:493:e79e:da6b with SMTP id 5b1f17b1804b1-49573cffa50mr16107445e9.21.1784798068765;
        Thu, 23 Jul 2026 02:14:28 -0700 (PDT)
X-Received: by 2002:a05:600c:6a06:b0:493:e79e:da6b with SMTP id 5b1f17b1804b1-49573cffa50mr16106375e9.21.1784798066906;
        Thu, 23 Jul 2026 02:14:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956b4e8885sm90788205e9.0.2026.07.23.02.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 02:14:26 -0700 (PDT)
Message-ID: <b18ca23e-938b-4161-9970-b2e1878b801f@redhat.com>
Date: Thu, 23 Jul 2026 11:14:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 6/9] tls: device: add TX KeyUpdate support
To: Rishikesh Jethwani <rjethwani@purestorage.com>, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
 sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
 leon@kernel.org, andrew.gospodarek@broadcom.com
References: <20260709205325.1591196-1-rjethwani@purestorage.com>
 <20260709205325.1591196-7-rjethwani@purestorage.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260709205325.1591196-7-rjethwani@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/26 10:53 PM, Rishikesh Jethwani wrote:
> @@ -714,32 +730,32 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
>  	}
>  
>  	if (tx) {
> -		if (update && ctx->tx_conf == TLS_HW) {
> -			rc = -EOPNOTSUPP;
> -			goto err_crypto_info;
> -		}
> -
> -		if (!update) {
> -			rc = tls_set_device_offload(sk);
> -			conf = TLS_HW;
> -			if (!rc) {
> +		rc = tls_set_device_offload(sk, update ? crypto_info : NULL);
> +		conf = TLS_HW;
> +		if (!rc) {
> +			if (!update) {
>  				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
>  				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
> -				goto out;
>  			}
> -		}

Sigh, this reverts back some of the more oscure changes from patch 3/9
to something apparently saner; but the code splitting across patches is
IMHO very confusing.

/P

