Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322132;
	b=S6vXUytrmcjFbfcMAX+5Z/CAEyx7QUTrxJoj5Ue18+h0LBPl0YfX7gnSNxHEumGdIOWW
	 IFxoRKejbYsuKw4veVFVNd/WGA8ZsEJ5GPV6SowsarzJg52cC1scHyp3HfDPPda99kymC
	 3DxMojpMzqfHhMhED/jN0Jd+N+WQ83sF1zkTfV5p+CdsCJZzjX7iRFkzEcvYX9e1eQjj/
	 DwsShmOFEEx5urUWJaRja/3abdLPjRWlJ9Gb1vR5Xrou6MWKTGPOLVHSz//T+lOV8ZgMl
	 5KtNCy8eUAJ8KUo2OcYWVJH1V3nAOf+Sb3RK157CbLh1lfFHvp31+1W1IqAI0UBnthA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=fAbYIaMbKYCKHf2gfjmqZLM0xjJUGwU3yVMDiOxjgH4=;
	b=mCCDvsaJqa4YzoOVaw5Eye76KwAdsQICr44xd/ynKH2dmcGaax/3j9YVzpbdVGnWU96a
	 UwjA5KtdXrvl5Udm0k/puCvps892nJya3JRQkxCHZsC0a8q9JGDzGsklm6GpSWqd0W2jF
	 dufoV6LUxbZ7WVHRE73f8E8rXeRJvMqmQxslJXE46NdN7iZhx8z0mQfHmqtYA3D6kq0Wf
	 vR+3kMCxcbyZJBt9xNlHE+3dnohb92aBBJD7QBZlWt9VWh6sB5E84lj4rw0lCmdVSJMdm
	 AjcrfTfCJt+Jyhee/8Rtb2dzWLzw2SJ/XWXMh1/YblvT2lUWjYBXdMQS2AzMZcosujQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=gygQx+22;
	arc=none smtp.remote-ip=209.85.208.178
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BE2606A331
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62BE2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=gygQx+22
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3adf9b1f5aeso18508661fa.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1794322129; x=1794926929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fAbYIaMbKYCKHf2gfjmqZLM0xjJUGwU3yVMDiOxjgH4=;
        b=gygQx+22MiGb8A12jCIVoodFPcmkefSsixa37wHTEhT1MzxWq6BzL8o48XEuR8mSNK
         MUjfbYYu7scXCQJTQKBd+fcRxqxiNr6iUShKHjbrkIftJ9BhueTEUpBpURRfPiSYn1ti
         AuW3CvR7TAPBqa7/E6022B39ojmDEFmB3PHks3dgDh3v5yC9VBJBgvlIlOYVvC9lDhnZ
         /USMQwp9dQfP4gwdefKXnQcMzsQrCL6Um7QAwsNWj+UGr5ILYY9ccQm0DWHUIoDLJ7wo
         jinuppRG0dzlXidwnwSbgBj813A8aMW8SL9oJidZBgvNMsFQ5WVE545jk1Si/dX1aeY5
         /miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794322129; x=1794926929;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fAbYIaMbKYCKHf2gfjmqZLM0xjJUGwU3yVMDiOxjgH4=;
        b=fE284qwFi+gikmBimMhMUD93p3PE646e8NiGVZrRNtIeuKSlLKVzlA/Qc8OL5XVgwN
         hG8Pv+wuY2e9aXC/TH/TaYr4+x7e5zjj+JC66XXUXkJlCW8XZnlKechaK4oKQtsxBOXD
         TbF+XtQPQr35+tx5U8zaJtUpIIFpJHAiJtr/At/+Eo6l566g9UE0rBLB4Mqw5v7w2ii/
         pnz+ff8RT3BXmJFQoB0AB4xx6dxre/oYgyV302CxKUGi2EcpmxVndE7C7v7JbEXr6QrX
         f8Y3iQcPW3C1CUuygBPnpvjbYX994bHu+MoBXACBCMsXb3cLmlkINnXe3sBLS/QxYh3z
         lAlw==
X-Gm-Message-State: APuU4Z8IfEYIV3ps4JMp2lTG0df2tuM6Bxi9/J/YU0aL5SaC7rOKDMhd
	youQxE9zC/3TTVVYuQzZJQcpx61dzgNz+5HJCrZlvKbVzu8grtlrlaH/ew6CAaBtBOo=
X-Gm-Gg: AYBFou2JcwKjVj4niHqQn7C3mMHKFYD3y9hsQAjPVbX5pHnwA4/hf2/or2dy6vn/O6G
	Gvy7P3PN5tfMoRsh0e80lz0oGWHsOBJyUEh/NaZjrh6gTl1bFBQa0xZWFqEguDSBXGmRE7hYX7B
	EPi4FjGJcI88EdTQsPuTvzfxYLqk3MTeqIlc9STepPIGlamN0iWwFs05FNfCxKNycEnVlF39gXm
	QyGw9cRkug3MtzkoN4Gmq5Y9WNILPRYkM8eGEQty0k37KCMA5ObJnT9LqQlyneM4Esh9F9FKy2U
	5cGxkbN4UOhdkdRO8wYURCn9U4vhFGzoT2FkD55PVhIKl0duhdWYUYWYXcLseyEYSpiqGn0csJZ
	JSd8TyZNZ2WhJ+GNYbNr7Zd2tvOF/rs+rmD/YvRr4TFglW/OyYeyj7aUk4Lo6TzmQKbMZwl/Img
	M2UOJkoh7TB+c8eVptmaCh+wFXCoA57QSoIiSVznpvpT6d3oaHhKB18tMz7s4F7EtT+ZBxmP0U4
	NulQsFlHucXHMdeO23JWj91fH8vK0kULKfxdiwwFiLz+v0GUuYre7eWOrctWXG72ws2ZPnGJjly
	ZEoxgLr75yfdL1swJSixrLE5im1Fbh1BhVt0SXIl
X-Received: by 2002:a05:651c:1502:b0:3a8:7caa:cd4b with SMTP id 38308e7fff4ca-3ae0962656cmr4623601fa.7.1794322129299;
        Tue, 10 Nov 2026 06:48:49 -0800 (PST)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae0928b945sm5356381fa.35.2026.11.10.06.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:48:48 -0800 (PST)
Date: Tue, 10 Nov 2026 15:48:45 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	Michal Schmidt <mschmidt@redhat.com>, edumazet@kernel.org, horms@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org, 
	rdunlap@infradead.org, andrew+netdev@lunn.ch, saeedm@nvidia.com, tariqt@nvidia.com, 
	leon@kernel.org, mbloch@nvidia.com, jacob.e.keller@intel.com, 
	jedrzej.jagielski@intel.com, anzaki@gmail.com, brett.creeley@amd.com, ohartoov@nvidia.com, 
	Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v5 14/15] devlink: add devlink_alloc_drv()
Message-ID: <avMuxjQKh0ryA_G2@FV6GYCPJ69>
References: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
 <20261110141534.95614-15-przemyslaw.kitszel@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110141534.95614-15-przemyslaw.kitszel@intel.com>

Tue, Nov 10, 2026 at 03:07:23PM +0100, przemyslaw.kitszel@intel.com wrote:
>devlink_alloc() records the driver bound to @dev at the time of the
>call as the owner of the new instance. That fits the common case of
>a driver creating an instance for the device it is bound to, but not
>a PF driver that creates instances for its VFs, as the VF device could
>be:
> * not bound to any driver yet (VF driver not loaded, or
>   sriov_drivers_autoprobe disabled), what triggers the WARN_ON() in
>   __devlink_alloc();
> * bound to another driver (VF driver, or vfio-pci), which could be
>   unloaded while the instance is still registered, leaving the stored
>   driver pointer dangling (it is used to report the driver name in
>   devlink dev info).
>
>Add devlink_alloc_drv(), a variant of devlink_alloc() that takes the
>owning driver explicitly, as devlink_shd_get() already does.
>
>The first user is ice, in the next patch, which creates a devlink
>instance for each of its VFs.
>
>Such an instance reports the owning driver in devlink dev info, not the
>one bound to the device in sysfs. Document that in devlink-info.rst.
>
>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
