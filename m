Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFE4370ADA
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735682; cv=none; b=lxOiXcdImaGHHO0vMk4IInYCzePX7OEk5Lna7EtgvMFN0Bohtp8btEk9zT5toZcctUWffidGKFHjaB8SsNuV9SIUdzc0H5mS91uX09ZuOHaX5gqDTxzFvb57jB+JDot0u8kNXzsgnKoDcaoVrGYfXInEDfrNtik02j90OZOexVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735682; c=relaxed/simple;
	bh=q9aV8UEMRbT/uR1gFd6YDDhJxj0IDZcbyD15EdPgcc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izTEpt9XNtYOXD1oaurz25W555lfoDSZmZqQKhpuY6v4SF3enH6U428eKVc8XbDHUCpSvz8/jUU8v0yqcU0f92jSoHICYsS7+8dm9rthJshlRuQVDhLk47nACa5TkENCr550ppeF0phLpMO2LUwRDCs04WN6Vn6NQDgDlQkc9oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FLpa61C2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YhakHtRz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLpa61C2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhakHtRz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789735679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v+JaQ3C2cAyYFQJK2/l9R/7/otniBmov2ptyT3UUpaA=;
	b=FLpa61C2G1npS71icky6TU6kqja4FX1q1xTeIAfM+eI65G05BaMN07T49Q8zd10XlNnNgu
	ehY8lUBr+q+tXzQFzy6YZSZpIWbKNEdR7eOusjEHxP+9qf7Rw8Wi+sma1X4kO/42ilUCpe
	FW6+Xsf3spdJqSuCwC2KNSyxlDLTExA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-FuUib67dN-Cw9WUJgCdq9Q-1; Fri, 18 Sep 2026 08:47:58 -0400
X-MC-Unique: FuUib67dN-Cw9WUJgCdq9Q-1
X-Mimecast-MFC-AGG-ID: FuUib67dN-Cw9WUJgCdq9Q_1789735677
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49cd83ca361so5019675e9.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 05:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789735677; x=1790340477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v+JaQ3C2cAyYFQJK2/l9R/7/otniBmov2ptyT3UUpaA=;
        b=YhakHtRzDg3AFAhi1m8zD/7L6U44YVEtLDLCl6RlFTwUl4Azw27op6Kk363YDZq74m
         VrIhqEyAY32Y3vk99imElBMWb0zqMolGrHzTGEeLMb5HumtauqNMdlScUbYj5ahv9xR4
         TEMHDF0n/bMWsN4B4hX9xQFB05WARj4/psUFp9bF/ebfg6EY0sTb3ooP9OKYFPM08HXQ
         MoxCYGRSp1f17KHNaTjbQ/kE6hU6jzd25xah+a7ryCfzo06AJdMF86Lmt9dpZ0+gefQY
         IyND+X/WYsZUF6Mf+wBGhXRCNrVSNDJ67MB0jvomZwfmlIdnEpneTna3a0Ap/wgYeDO1
         jhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789735677; x=1790340477;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v+JaQ3C2cAyYFQJK2/l9R/7/otniBmov2ptyT3UUpaA=;
        b=Fxw4BX6cfMvNpLoAam59N2ZFaJXzI5I8Wfy0D8VqolwyfzchkfoN5G+lTZt9Hzl9gt
         HPCbDnr5qZDpyw7x3VuW4FxyY1EiZoo9Afh8q/C5EPzt/D3jtEc3pkM1fRlWn+jQmcnt
         eovCBvQp3w/ii70INtSgygrTEWQqxZtGooXhWdOlrCcgRmH64RE/+vorVp0hnasRl8uz
         F5nu1sJiS5BES6ebqbwXHjL7RASPcbR49FjNDujDwU/mgyUpHA53b3cv5F4Nq8FU7T+3
         3WjVHuJp5RSt+v6e0A/Nu8qUibVBoIw9LSm810PotDF/Dq8erhpcQH9KP4H/BCx7B/JZ
         CeLw==
X-Forwarded-Encrypted: i=1; AKwUvBzWXD1L5ASPrdZwnb+a6gvCDKShBZGdmmt+9NJkl0fKuc8YWPTHsTcQRb6ZUJL4yBl++hMAnHY=@vger.kernel.org
X-Gm-Message-State: AFuF++lGwKrj3z9kaqxtF8apTAC3hHsL21slo8gqJno0rLJuNbHh2yYp
	4trlBK5XOOYmE+W3473Pd1g1StBtx5wFNVopMKRMmTkhVG0gCRaZytMjQKku2GGizjUeAaPn8pu
	dgDubjFIfoCjtDLgis2Bkq68BWIF2ZiHla9JkhIDPevJw+fH9buNWZaPnXg==
X-Gm-Gg: AYBFou0rVueHDRt2Bs9UO27GzZJMCnw5g1oyso+slTHMdXcFBqgzx4ashi0Vge8BGsw
	jQR3+LMEkiURL9Mdb1fL5j4xGHoASC+ev3c5upizqmfm2bxt9V1sG+QX0S5VjpPTzeHBA7CfZBN
	j0V4jtGAOTOVEPm2c2vKJmRMCnkRtuAXGuB9CUVcCIrYXeNI2tReVO2eHzl3+wUfHBMK9qvMM+Z
	wtCgV0P40TpUtlo86qkdKZ7oeoKm8f97IXdfkAiJhEZ0W7JdzOf/eNcjUcleEoqpZtW9ZXI3g4y
	egW27GRAxRDcuZtD5nZjttTEkxoKE2sz+VnGKS4KZnXrB1pFxce/7v2JLu8LaLTRWskg+FlFQET
	CsKOurvaB2WWdEyOgZmGi6Ox2+X2KOg5lD2/7zvJO+IlW7g==
X-Received: by 2002:a05:600c:1d99:b0:499:8ff5:8ecc with SMTP id 5b1f17b1804b1-49fc56dacbfmr35462205e9.15.1789735676769;
        Fri, 18 Sep 2026 05:47:56 -0700 (PDT)
X-Received: by 2002:a05:600c:1d99:b0:499:8ff5:8ecc with SMTP id 5b1f17b1804b1-49fc56dacbfmr35461105e9.15.1789735675472;
        Fri, 18 Sep 2026 05:47:55 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc58a1176sm39414825e9.2.2026.09.18.05.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 05:47:54 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:47:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Ivy Lopez <skunkolee@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock/hv_sock: fix socket/table leak when rescind races
 the delayed close
Message-ID: <aq0ydoRGx4hq7BdR@sgarzare-redhat>
References: <20260917220213.56102-1-bartlomiej.dmitruk@isec.pl>
 <20260918025650.15990-1-skunkolee@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260918025650.15990-1-skunkolee@gmail.com>

On Thu, Sep 17, 2026 at 08:56:50PM -0600, Ivy Lopez wrote:
>LGTM.
>
>Should this need a Fixes: tag and possibly a Cc: stable@vger.kernel.org?
>

Yes, please.

Also, if LLM was used, we should add also Assisted-by tag, see 
https://docs.kernel.org/process/coding-assistants.html

Stefano

