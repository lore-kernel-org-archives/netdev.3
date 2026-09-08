Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A964B04BC
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788866833; cv=none; b=XWnsoOjDI3Y0x7Gd/ZiZayZ3YqJlsWxPYIN7Fr39vlOYFpqS0QsgPw3Wh7RK88yM6BF32vHPkpIFpvmNGyaV6q9LvZdackoTD9SYaksQZinUzyckqv95VuVvhtYSykLTVjeG1R9Bc9dVuVphQ/tsErxO5AZFE6MQQ+7L/fGbfzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788866833; c=relaxed/simple;
	bh=ZlvQEaSbZo4H1bDmsspv6kSBdLiYLaGz97cLJBzZfqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNl5OdKULlR/oCQ68DC0dKWXvxbpOfbVueAUSLDDJDWuvrYrkA2d+pkdz8zTWKR3sKJVSFQ6bRn7PdXTEQ6Qks+9li0w4BRmReirCNuSyQRECD/nXxZmUFxWMEgbqzV81H/qL1ZKEQLUco/JfwJYolmm2vLmFulR2pHGR4rQ3IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KT+Q+msk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s9SYmMwj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KT+Q+msk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s9SYmMwj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788866816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RbWEa5Bde75USO7Z02DseODnL+IIRgvkNImN2z7KE5s=;
	b=KT+Q+mskycUDb1I5l3D2ESBVM0vf5jK2iYQjA5cXMIbveAuGCS9ZvPdwYq/F7ubY3bphTQ
	FjI8rU4044fRyX2q0clZnHV6ZfqRWEkvRoUzFwae9iQV2tdqJo7Y9D1v6rvuqF9ePqOGsi
	1Qa4YUFEXikGqKiC33Su53FwlWXSakc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610--8kVNLneMCGBOrJAiIlIrA-1; Tue, 08 Sep 2026 07:26:55 -0400
X-MC-Unique: -8kVNLneMCGBOrJAiIlIrA-1
X-Mimecast-MFC-AGG-ID: -8kVNLneMCGBOrJAiIlIrA_1788866814
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49cf5bd2f12so61584635e9.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788866814; x=1789471614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RbWEa5Bde75USO7Z02DseODnL+IIRgvkNImN2z7KE5s=;
        b=s9SYmMwjz1oXEW2c7N8nRHvgN3XCP6pn/bALQAv/c2a7DwTaMylzvuDmiUdqmFYjd9
         crsk684CQYMZhyP+T0Q2Hkw74KpqJ9NA0OaWMPlicuqE03RN9sqWW+VicBs0XLr4gNAS
         SR7cpEYa36y2xVUzoepa4zJCti9N6JrbE+TPHkN8RsaOYfbTTlz4cUI2wS1iQirNysPr
         mjY6p6svPDUkhb78mJJhnRqIamTXSPi7K6bAvj6JBjeQnQYAd1nlSLFKiCf067SWlrt1
         xYB2itzLBrHkVeUmWySYauL8NjsRbkaqbTcXPRtZVionukEMRK5CbGoa93XYWTvG8LVF
         HNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788866814; x=1789471614;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RbWEa5Bde75USO7Z02DseODnL+IIRgvkNImN2z7KE5s=;
        b=HG/XDNZFdTqxq64KnfyOCt4a/8YszY+NTiriTZ+XfvNPPn98GTnQToRUkvSWxINdg3
         oyRDmjNRMH0JuKZzCQomjDJH34LEmKGS6Fj3c7/qsDRo+fRY/Xm+qdjpufO3jRSW9HMU
         hrLxJ406fzZmxpDC7VrPKbAde0FdyCoPjcS3AyL1Gm7uJ9zWFgEBFJXLimQGf1FRW45C
         NaSwHdcKy1tGnejWMipmOJaOpUOf/MCOes6aFIqSzBqoyzjIgRpZSGdJY41V/k7X14tr
         ZSapung0qOmep9HcOV5zD/qUYvjWuWcQlV6QhfMgC3sEiLPjiXqpFbRdGNFGlbqsaJvt
         s/zw==
X-Gm-Message-State: AFuF++m1kgDlbT8LbByS1bTYrIQrviByfi21mtoGS6mx1enn2RAz7YSD
	cTzsKYp2cryXHF6UIV2k5VZ7lVRQIzBhyIWNo9adZma3XGrjJrWsVkM2wYXjToYLxuomI5pX4mW
	zmOx26w0zFFADAlUx9cgEUF+KOLfyZQnX15/rP0ajFYcWZQ1CdGToz7Y3RQ==
X-Gm-Gg: AYBFou0zGRnuEvPKnfyVxKKCKjOT3TsTuy0rGvQS3VnntMbSnaItTRJSpwbvEip5gts
	XdhzYb5qvF8WORN5iGLG5k8EjCZVsBwkB0la0X81K2cDBwHcXYSyouXhIJESe5vG9YVjSF3N3HI
	dMqfscvHC1x415Fe3ypu7GRe1rLtjZ/a0jQt0OQrcDvDP7Nk/Sj7hAjosfslnL771K6BEmNvLkt
	/NJCT21b13RUJnD+cNu3WXJXJyUhwytDINh8yGEKjHiPdzfoU6nWzJxRcoswBs7WnRT7XIZKO28
	+sUczVrf+Bm1cuwMU1Dt5k5uVTrM0FjoO7+d6qIG4yuMO4G22EnYOs6mmfone713XMuR/YnOPyr
	OwuDkgUqiVMmuYkQoqNyw/oGFSd4aR4z2wnj9QYzUJypxBYBq0/WVdtBwVkjbcdKf2nhkgUGIGg
	==
X-Received: by 2002:a05:600c:3511:b0:49c:fa21:1c86 with SMTP id 5b1f17b1804b1-49cfa211cd7mr271429295e9.27.1788866814366;
        Tue, 08 Sep 2026 04:26:54 -0700 (PDT)
X-Received: by 2002:a05:600c:3511:b0:49c:fa21:1c86 with SMTP id 5b1f17b1804b1-49cfa211cd7mr271429005e9.27.1788866813957;
        Tue, 08 Sep 2026 04:26:53 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740d44sm847238405e9.15.2026.09.08.04.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 04:26:53 -0700 (PDT)
Message-ID: <3e210ef7-f807-4de7-935d-09441710acbd@redhat.com>
Date: Tue, 8 Sep 2026 13:26:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: run netdev work under the ops-compat lock
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, sdf@fomichev.me, kuniyu@google.com,
 linux-doc@vger.kernel.org, davem@davemloft.net
References: <20260904180058.3803849-1-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260904180058.3803849-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/26 8:00 PM, Jakub Kicinski wrote:
> netdev_work_proc() took rtnl_lock() for the whole batch, forcing
> even ops-locked drivers onto rtnl just to run their rx_mode / ndo_work
> callbacks. Take the per-device ops-compat lock instead: the instance
> lock for ops-locked drivers, rtnl_lock for the rest. That's what the
> callbacks already assert (e.g. netif_rx_mode_run() asserts
> netdev_assert_locked_ops_compat()), and non-ops-locked work
> such as vlan ndo_work keeps rtnl, since its compat lock resolves
> to rtnl anyway.
> 
> Without this adding more uses of ndo_work, for cases which don't
> need rtnl_lock feels like a step back.
> 
> We can drop the comment about the extra ref now, with the relocking
> it's a necessity.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Dump question: can the `netdev_work_list` work list grow significantly
under non pathological conditions? netdev_work_proc is now going to
acquire and release the rtnl lock n-times for non ops-enabled drivers.

Would it be overkill trying to acquire the rtnl lock at most once (i.e.
keeping the netdev_need_ops_lock() and legacy drivers on separate list
and process them accordingly?)

/P

