Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B773D9530
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038499; cv=none; b=bW0ihpSusHnM2AVJ+TUV/9+HR70YDVN9HSYgXVpssVFDnDN2JPZANduomwkWvVjkbaxRwnuYtMMWIF+j/OKlq9xCI0cxYeUTAlr3+S5KxC1lElY1nk0FnZ4T6OeK5UXsrPr7senPlRo4uYlKvS0C3mGAYVo5jqQuaBpkv0fHRA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038499; c=relaxed/simple;
	bh=A81B61BRd2x1sSFxHm+OOFOqfMYEtzRTvPX8AsEKQ68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2CUdXNdxKqI051v3gXjBfNwnV6SxFXG8uhXQSzDYSOpYSCNkYNYD1G5dMNFxTusC2c16qkN5J6TSebCuN65dy63Xw49S/Mw4NTvcjxHtLyLCcAjTqGnlz36HXvtEour7XvZisp4iSW6SwUs1VUzswI5bBpMmvNxwSyFnGry6fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hS4PsL9G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tj9stkns; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hS4PsL9G";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tj9stkns"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789038497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G8CFytEdCGSTDyDlAvIjNaZjMoqpFkxgcAOASoLn7Aw=;
	b=hS4PsL9Gcz1Iv6m99GXjVLYSsnwASWI1BRAjWZvy+TRVjZSWCPzqphGVurUrUHMRxQJFf5
	5zpt+F3p16CUuntXu/3jtnpoIjLQR37l7jNjloAKz2jREadILXHoSdBM+ouYCekLxbVVSS
	2kRoNUZOdzD/cjXwaQP6f4lOdYXuQA4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-Q2qp6Vy8Ob6WI5IAQwYULA-1; Thu, 10 Sep 2026 07:08:15 -0400
X-MC-Unique: Q2qp6Vy8Ob6WI5IAQwYULA-1
X-Mimecast-MFC-AGG-ID: Q2qp6Vy8Ob6WI5IAQwYULA_1789038495
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49cf5bd2f12so89699815e9.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 04:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789038494; x=1789643294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G8CFytEdCGSTDyDlAvIjNaZjMoqpFkxgcAOASoLn7Aw=;
        b=Tj9stknsmFyLalVHTz5fsL97nKqzThx/BaJqmTTbj/KBmvVG+40t2aj+eSlPmrcT5a
         zY9Ifr0XDyhby2a3z8eiewXGSEx8k8XsQCSz6Dtx8IOq6TJvNDfuZa3t5sUXI1n9f2+q
         x+w+YkWLD6ei1/hs4FhgryyNazsqt+S2MUs+dEoIRyQrgdlzN2q11zk8KtOhrgq99MSp
         COJiRTzLxvN0AycQs2BS+izAB3OECARKMEgfKMIJYS2Q+V2BxP0kQqwpfv9lrH9LXeUe
         G/kI5/sNhcqKOmTUbL0nSOT0bocQRHWmFdlujDkTL/z735+GZJ5v91QDaMa+MDRNENqt
         aCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789038494; x=1789643294;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G8CFytEdCGSTDyDlAvIjNaZjMoqpFkxgcAOASoLn7Aw=;
        b=r6dk/mXyL+bPu3pkFFNuF9Z0eK+TMvYfXkeuzBOx+s1SHPe0dSMjLky/Lf0hTpSXf+
         WqE6zb+b50I3C8jFx8MPrb6lzFwluP3u1Q+SzSFGSCzhVFnKG1MpW9FsCjs44QOOdaaH
         o7XH4k8846ykg8S5n1jJNnUTrxvegCQmj52N4TpXaKXcEey25AdxmpZw9oB9YlgN60RP
         VjBge8cU8xc5RoGkCe8Ru+19aUP6noX/oUGl/615iB67L++8SZXQLgCpJ+yCfrFw3WoQ
         0dSSn5yvzHzDrQ5C9KBrSTs/Jpfq+fE71NULUZnw2PdA1raoKcssXq2XNVYyUzfLMiz0
         s+yg==
X-Forwarded-Encrypted: i=1; AKwUvBzovss3WF/EDaZ7lLLIpiIDNsYLl7gTFJw5JGt98IRIB3NmnnIlSn9l9RjBHnjuPDVMMBYizXU=@vger.kernel.org
X-Gm-Message-State: AFuF++mjs9X6Rv7slBZn6sxZsTSuzSTeSS92k3eU9BtQnMGY7v5xAznE
	8mMnD+zoa/sswwYZL+i10LzhVu1fV4hdmZiNR+HfbVSz9hxqlpFgucyfxJLuBmtmaYmlpj7wC8i
	Y1TMqM6lcspHpOCAznVi6OUv3CD3rxhLAuk3aGd6/IXClKGuWdZ8JDCFJJw==
X-Gm-Gg: AYBFou1CZO012j6ERz47EVW3wKVF/VTtBrgqDfZ2PnoXz2JHB3r137Y7dwOvuZPwlrE
	BpPOsQ/ye4azahTlQrWs6BSWTabEpbWnO/qTdVVM2lBYXFcg2uwoqWhFj5NnM++IGFilKmT+0u9
	d4eVv5QySX9zapp4eAPaxnlBUoHuGavPJaf9Ei350N67hUdF/DxwEOb0JTcrIJBP91u2QQbAH9n
	CYKfNSVosZ06BzClHzeUpUtj6T06GUxnrxNNHFG4LB6Oahkmo0wHXFaFPf0Lneckcte70PRlU2+
	35g3dQ0iBhIG90xOniCusomeDc73Sb2QigJt2bGoul7u8AQq2n1MhrgvYUC+hKWw1YpFDLOdTef
	Ub6w3kaYnpotipl9nx6jf1XMniTtiR1w6krH1qMtZVlsmdMauBrkcqsbY7X9IEfd5K7veJSQZ1g
	==
X-Received: by 2002:a05:600c:4e8f:b0:49d:4ef:bf70 with SMTP id 5b1f17b1804b1-49d04efc043mr317131925e9.10.1789038494558;
        Thu, 10 Sep 2026 04:08:14 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8f:b0:49d:4ef:bf70 with SMTP id 5b1f17b1804b1-49d04efc043mr317131425e9.10.1789038494197;
        Thu, 10 Sep 2026 04:08:14 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485881353e8sm50339161f8f.1.2026.09.10.04.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 04:08:13 -0700 (PDT)
Message-ID: <54c3768c-ba5b-40f8-9fd9-d2e628c0c592@redhat.com>
Date: Thu, 10 Sep 2026 13:08:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 1/4] net/mlx5: SD, serialize SD LAG init/cleanup
 against LAG mode changes
To: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: Akiva Goldberger <agoldberger@nvidia.com>,
 Edward Srouji <edwards@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Kees Cook <kees@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 Maher Sanalla <msanalla@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Or Har-Toov <ohartoov@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Patrisious Haddad <phaddad@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Shay Drori <shayd@nvidia.com>, Simon Horman <horms@kernel.org>
References: <20260906071332.3759199-1-tariqt@nvidia.com>
 <20260906071332.3759199-2-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260906071332.3759199-2-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/26 9:13 AM, Tariq Toukan wrote:
>  void mlx5_lag_enable_change(struct mlx5_core_dev *dev)
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> index 4cdc50cd6f03..99cf455a61e1 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> @@ -345,7 +345,14 @@ static void sd_lag_init(struct mlx5_core_dev *dev)
>  		return;
>  	}
>  
> +recheck:
>  	mutex_lock(&ldev->lock);
> +	if (ldev->mode_changes_in_progress) {
> +		mutex_unlock(&ldev->lock);
> +		msleep(100);
> +		goto recheck;

My reading of the clashiko report is that the above introduces a
deadlock.

While I agree that the fairness issue raised by sashiko.dev
could be deferred to net-next, I think we must avoid introducing
the mentioned deadlock.

/P

