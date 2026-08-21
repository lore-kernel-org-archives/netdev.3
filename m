Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A51132F764
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318765; cv=none; b=CsV+fMJFo5OEtzp/q8rP1S41MhPljA3GC39lic3QVut+V9QwCqrnl2dzjN1KPoXQU6R4UUxw4fqUkJzwCr9+sXSZcCri66u6xWu/gkj/ogRf6egtBVXGZda4Bdzezl9B+tFxMxiXqDGuk9ssPuvb7C7v2t2e0W5M6G/8f/X2PJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318765; c=relaxed/simple;
	bh=YawnfO93lFpiiiVsEDgOo67WdtKdWlruskTJ6qCMRPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVLJMSwzqU3cPJegfE/UPw/AumN29cZXTqEL7MQFqviK+APa0/5zGvCrfhTznT0DPI6iouzYvd95VyVIlQhjxTTgQGvXkOB53myEN1jW6siGV5Z5gQJDa9op1Zw/XJRPEVigLVmr48slVFyJG6GKF2nXMNrg/1K/3V3Pf41kY3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=i/1DlRNz; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="i/1DlRNz"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e65e18969so67289085a.1
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1787318762; x=1787923562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yZFW1sueN7C2JgtdNrAMsuj/OpX3+XPmkVX06g87NwY=;
        b=i/1DlRNzb+0/Qma+N7q7Xnhsg7CoG9BU3OoVNln18goCP2U8AQo2Eu8mnZSsxz0/3o
         C3Qyoa5J2Gg/0A5D71v9oyuFQHrFZ/5WyTbt2Ogz4eB3l6sZcNe4/srwKQUMDpzNcUxM
         nZ/W7V6SNaza2d8Xo2DOHwOF8Pyk6kyGQzsbUYNY9He+Wb0NBs2+YuaiguOJzX9gwLXJ
         FG7l8nAnwMRdcY/g6Yt5Jdg9osVf0eTufv8QygZEsu4CzBhtIK40aQy5fLncQS8M3E9v
         v50YDQfN2XGeDKyRwotzUTehHoiA+JQT0KyDFeChT4hiW7yZCF1HGMWJjxgE0AUZis1i
         Uk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787318762; x=1787923562;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yZFW1sueN7C2JgtdNrAMsuj/OpX3+XPmkVX06g87NwY=;
        b=kYd1FenUHv0VIJFvd9Fr1tJg0m1UA10biBMY/cBbUmAjncKkNnTx6xOPo6wl7gdIr3
         J65rvpmfRrZTTKPgGEXhlQa+OCh5xB6yFPCDhLCukEapC0L6cVnggYuuLkvPO1ndaXof
         8xOqMUMD+oD4WrG7Fcf2Ipy7qmMyARBizOenS5Ei0/00AJX38bZoYqBDT4qPC23jC6l1
         wJ8PJDTuQ3g32jS5dH5uO14YkoXXE3c6QnyUX7mSuIhOFSn2eMrp6Z47l+qu8kiRebx9
         KsWJ1CHNC5uQkqWo1DMDSxsTiTdgQTKGZqbpc+c9Am02Gy1Zsi/RWNjZbuj8JrMLeD8J
         pYow==
X-Forwarded-Encrypted: i=1; AHgh+RoXZdi2WoTD1mM6uOznWVMzyTCaQYWSa74eklWVbtF0DP5cvR8LtwyIV2JtVdDD/7vJc41LdXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIOPxBlld488mDhnHTdwBVAq7sZAQyqmo1QWCvnA+Rga7mbor7
	ZLGJaKSSuhHcvJAG1Stkfb/8Ns8xvzfoTdunU1+kCCGYTi+hQULY5luG5lvSG//tsH8=
X-Gm-Gg: AR+sD12Eseo8RuOmiPZKjMdjsj97tzZ0axJ1Bz2T179ffVAifb8lmrQwckEJM8i5Fg1
	41h97ldm7Ap3AR7As7NkezWdgygMxBi2GzqjgnAHLtPSXiAy7zUjl/iarHxtOZROxEYRkAne3+F
	M0BuVpulHndohySyRcx2YwVZiRVgERDMVS+CuRwpJduzDSyXtTEt2R1De7hEkUMX6PZ4w9hbn6+
	HXamRYqKkW3iHNryTBBMs6rXy4pr303ZeshufPSU8BgPi1vnF+i/FPB5l0pSyQjM4Dirdpk12q+
	VAhvHYMQFOYbLT2+9bggp5GlpYme6wZnyNwRC9+e/fLQjzFmYAEGboT9qmURiq6P6ldYkUmWqOF
	/C4GbOwJamepZCYLkIHgN6jTq60pzWSNGmEVtK7t2A3p7zhWM3XMAXZwgluJjb6nGYeVsaMC1CE
	Ho23iSTYwlLHj0FX/n3MABrp/oXO6oE3RehinbOXPgA3ywOQYqpCVTWUG20bHrI/dvzkgw1xgf6
	ddYZTU1nh3AFMA4Hc5k44XGirVrVvJczFcOwxsmracLYw==
X-Received: by 2002:a05:620a:800b:b0:936:a8cd:a28a with SMTP id af79cd13be357-937285a4fd6mr1422261185a.22.1787318761951;
        Fri, 21 Aug 2026 06:26:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93720493f35sm593233285a.9.2026.08.21.06.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:26:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wxPFw-00000005zlu-0XgF;
	Fri, 21 Aug 2026 10:26:00 -0300
Date: Fri, 21 Aug 2026 10:26:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Eric Dumazet <edumazet@google.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH] RDMA/core: Fix use-after-free in ib_get_eth_speed()
Message-ID: <20260821132600.GA1114497@ziepe.ca>
References: <20260821070512.3122442-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821070512.3122442-1-edumazet@google.com>

On Fri, Aug 21, 2026 at 07:05:12AM +0000, Eric Dumazet wrote:
> In ib_get_eth_speed(), dev_put(netdev) is called before inspecting
> rc and dereferencing netdev->name in pr_warn(). If dev_put() drops
> the final reference to netdev, netdev->name accesses freed memory.
> 
> Move dev_put(netdev) after the warning block so netdev is kept
> alive while its name is read.
> 
> Fixes: d41861942fc5 ("IB/core: Add generic function to extract IB speed from netdev")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  drivers/infiniband/core/verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I was intending to take this patch next cycle:

https://patchwork.kernel.org/project/linux-rdma/patch/20260812081708.32468-1-krystianmkaniewski@gmail.com/

Which has the same change embedded?

Jason
