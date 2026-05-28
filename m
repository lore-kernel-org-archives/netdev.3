Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18DC305047
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779987921; cv=none; b=MdMa9FyEiHgb+4xtYPb8x9IY8lj621VInyB/s/IR1TAOVjHJGzwfew0wdgG7k7IuEVzIWUcsdW53dvyvx76BXYKTUCPMKohjV92xcxf8eQKW6MOqOMZTCdx2z1ecQz3O7R0AfTFV1rh5jgqJ9jwW0PPCgsttVUd3kWJvk2KofZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779987921; c=relaxed/simple;
	bh=SLFbiKwocMwO5DEk5WAFFUXDRrcNia8HiUd2IqawVcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzBdm0cm7sUDic+YHcMvYdcDRV5ZG0XDIh7/YoUlz68npJztvR3h4NIJ31OC7sH2C89at15eN3z4TO6ufRSpsqKS4KcLMX2CQEVMuW+DZXb/VDgVy7rluRK1ruip9bw1b7Asc697m09kObEdERTDkMwwcRx+u/AEEZHDL+BT/s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCvSc1ky; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCvSc1ky"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bcd0111ea98so1811374866b.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 10:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779987918; x=1780592718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=caj7DELYYoitqJzkwAwAnO2//zgRbVrrcuHcc9Z7N2k=;
        b=UCvSc1kyAJOX8F0KqgGIeiTxiSfjWLQZpJAWS7uH1ZEOCSxr9eQYDekTWDyDj7oP6g
         YG79kaWJtx83pMRsdIecATEGXJAtK4GYyxBSBb0wq3PPgsYQO4Cx75JIM10RuQm9Ipl+
         INa2m6ZnCuTzqnM8iKSUtmyhDXSs1R7n9mtZ4ObCvNcWiFlkrC83A2d6EkdCg58FT8ey
         hmlme1Zf3q54dG4jE3N/JoNcw0bc40ydqr8yFo2IG9TWFXIuaY6MH3FhQSj/zX18i4+l
         YLefo0ER4zcl58tWzYlHO98Krz5KqAusLu4z3ErsHJbVAh7c2MQJHXkcvk+dJSg7pCQi
         2GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779987918; x=1780592718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caj7DELYYoitqJzkwAwAnO2//zgRbVrrcuHcc9Z7N2k=;
        b=PXZq9VpUO3hti2erFuJYc2lrgjLRxAXwKk6OVMZEsMECL7ZpM5BYkTomql3OMN5vRB
         dGEJcoSNPVOJO0T/KlksgC2FB7JfQxjLf6p7+gyHVrRJYtMIUdS1DIlAqYSCFcYSbvkK
         SgexCXC2XPkf5XkoRR9wpi3EmSZ5gdH1H4fWYSuNcv3SkfCq5ADFcA1UisiUvVlz7qkp
         iBtNN5D7l/7UD39I0GdiJa7szSW7huuHsSkraEd5jRvdE8f/w0Q8n6bVIbdhXa6Q2qL1
         Ufd+O7iOsV17N+EYVwCdimYLlI4D7mUQngG0kLb8UXzR0wV0P+YfzrZTL3EKCD6Xh6VE
         gMaA==
X-Gm-Message-State: AOJu0Yx4S3giF4JLAtUz5jT8JXhhuEMt8hZhAbAnuaTZaFcb0+X+Ykml
	mgS/z9H6xpfsAEQztuiFMEQW7xoglaOJJFjWd3A+cqZj4vk+sb10xX3D
X-Gm-Gg: Acq92OF4sgjlVYiBTAtaXrraK6uKhh0D/wky61L921LFeSGklDrwJq3vSGeFKFoM4Y/
	9lo0i0y/tDlGJfkZLSacpKk9Oz9n/Dx3RjOm4ucEsicC6MnYG5W9XYJ+JUcRhqXNz8Wcm5vQfn6
	w50BhWORRDxxiwNyXfB/dWScPHm0TD9CQCp7Evw0Hqu0SfVVTJ7+GvoGYk44I4mCfM8g+CpCsQp
	kJCVZ2tsokuyX9l1C+FYZ1D20f8boCA9ndwOokLndCZGSVm1Ymza/oLseTWQao3K1vV8OH1qP6+
	Yb9sryXmUfVv+ctDf2MAWSmOvULaBpq7WzP3+YNJC7aEo6IjJvhpkgqWEi+7dFYk8eit+IuA317
	7KVyga6u0ENEiMRDHWlEqSzxv0eAvzK3zWuoJdwRybIPTEPAf2JdAYlSnOVIPOvqFKp9YMEvIRY
	taWccGK2u9v4j+1yg+agj+HgWUmccQeLbEZE4xC3ULfVmW6K3igsaAn05N
X-Received: by 2002:a17:906:f5a1:b0:bd8:f7f5:269f with SMTP id a640c23a62f3a-be9711e020fmr4803466b.6.1779987917779;
        Thu, 28 May 2026 10:05:17 -0700 (PDT)
Received: from localhost.localdomain ([45.128.133.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc5ed2d38sm745682966b.34.2026.05.28.10.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 10:05:17 -0700 (PDT)
Date: Thu, 28 May 2026 19:05:10 +0200
From: Oscar Maes <oscmaes92@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 2/2] pcnet32: switch to napi_alloc_skb() and
 napi_gro_receive()
Message-ID: <20260528170510-oscmaes92@gmail.com>
References: <20260525125437.4061-1-oscmaes92@gmail.com>
 <20260525125437.4061-3-oscmaes92@gmail.com>
 <20260525084528.547fe263@kernel.org>
 <20260528142851-oscmaes92@gmail.com>
 <20260528080748.3e74355f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528080748.3e74355f@kernel.org>

On Thu, May 28, 2026 at 08:07:48AM -0700, Jakub Kicinski wrote:
> On Thu, 28 May 2026 16:28:51 +0200 Oscar Maes wrote:
> > On Mon, May 25, 2026 at 08:45:28AM -0700, Jakub Kicinski wrote:
> > > On Mon, 25 May 2026 14:54:37 +0200 Oscar Maes wrote:  
> > > > In my testing this resulted in up to a 25% RX throughput increase in iperf3
> > > > tests in both directions.  
> > > 
> > > On which platform?  
> > 
> > Intel x86
> 
> LOL. Please. Which _hardware_ platform.
> Or to ask more directly - is it QEMU.

It was indeed tested on QEMU.
Either way, the performance measurements were just a sanity check.
Changing the code to use the modern API is just better.

