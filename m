Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27D32135AD
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516070; cv=none; b=k6pBa3XQzCCF+xVg1wmd62AzRnL/21wMcVeIIkPyozjbXwxTaZvyr8koUU3cDBg7zo4ZTbVp1u2Ff1Wy1EQGprMwrsxmiBiObQYdSFEZ6eHOMFPxDagRZRgik96c/EIM4H/KHin0eDNlQWev99eD2VrR2O+y3BpP5o5WQuYn9kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516070; c=relaxed/simple;
	bh=4mRfFvi9VVma0iwirFcjYoapEWF2puTDZ6iEiOrn14k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B17rWodxyrHdmoZ5Y49lYrhmNUYwFy1sxohs+uRt5TmdP4JmHXDaDs7M0KMNUdx2VBpDw51t8B3bsfofVOyYE78EWGDpH9bLzW1qQeQr9LRda3YZXLO6ziHGvBKQX2UuBkFaVuJhRpq1fOL/j/zmp4EwttDJX0Z7ive9q1JlrGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTSa+dwI; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTSa+dwI"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-cb221a59829so48323a12.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785516068; x=1786120868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=axVwyepzuz5vs7KCy+kgdXSLK2Fq5ai7WRMb+rYqcNE=;
        b=JTSa+dwINgEVUWQEw/0177r7VRnjYZ2DVnDfNuJq3VK1YHUe7AiLERVdeilLyMuEPe
         2VgeWF3lQWdXvtuPo//5MEchDmBnZvmNXefJsDQ7mlNFId1VONRsWN5n4tcMlmzG9Luv
         D/23mKwVvwke4Bf7fXUOv44QBD8WSTP9ydzfSYqAauP9fjn0K1YugZ7W10MTx9kr+F4i
         zen/JFfz+JVFv6u0c8/YSnoJi0Rccre4jqj2m4PmvDwalKi1zEjGFKMEbKEnB/fKOB5k
         4k0y7RhByaKeykjKIMASetGsPM+aBoC7PeTFVxCvOXYYZZ/lo2qt9PaxI53SW6c3oIHp
         /wNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785516068; x=1786120868;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=axVwyepzuz5vs7KCy+kgdXSLK2Fq5ai7WRMb+rYqcNE=;
        b=djwlRep83Mv+J98rLAgPrY8spePKeOhZ/wEyCNUFIceGTOUCwcWqykUnQAZhN5ecxv
         ydUzvjMRt6n3yInpYNp5Sjo22sAWU3DVGHQjcTj7AACFuAM7WvsoT531/wj4jCBOFRlk
         pDfVsC+2+uy+QWXcxZNmrNvTyZ33kLTe2lt/Y2OAj0wvYghVpCndmexHMH0whUqhhF0r
         Z9dU7QvTBqm8Sna204PVE9aHGwxUY4o69aLC6FPz1Wt289IYg/5g/TlQX9J45Uv7Rkbl
         9O5g4orwKcvQKpX83PfY9zgmL9PbL/QV6CdnWCu1pzGlo2YSf36ZpYvUJjRzu000mwK5
         OKiA==
X-Forwarded-Encrypted: i=1; AHgh+RoajcTnhAivRXFIDDaBQejkm5PuAwYw6r4xgOIwiAOJ7D2LlersNV4Un3VTjKmlL+dBySjBfRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhyMpRmj1cYXq2GgH09Iey7n42ERWqU7ms2ixwRgHnOCh+OcJ6
	wpXiSMyJ9xks4iUI65C8XmTTXYfS2rg1zREGGAbmOYnRXCeGM94Zw80E
X-Gm-Gg: AR+sD11XUCH4Jby1FlYTkqm1HvZoA4kD6OX8vVK4dtQIxUia0aJnNN0PrSSLybyGKVM
	tmdIqNSmSbzpIydkx+vbOZOruuxf8hsncXHnkGwlQj1mxRj82kf6KC/iO3StkTn3XVMofbVehOU
	rwD/jYr9v9By031k8m9yHwXoRF0X9rw/VFb8RwctiGDHrdwhj8oJnOu+aKFcCFL4SFnk/n0ELMZ
	XSONgpV0n/D2P4806DyW2cPv+kGOGmhDYOjqrnBlDOOjJPD4zVDMobQZ9291FzYfqqppN4g8VSM
	NmmKiWypf5s0MuoZase63Z0Q2HiD+vazBxtLy3qJ/AGjOn9J/AgPd6ktr9tM0MOmXvm4bpu+OzQ
	wp53oRoYBKqkR6TqZDT36JN/uC1QRrkZkMELuq849KFMr6tFyxC1P1doR2+WTvGToxRf8X2bfTT
	JhwSBrPnQWVjH3L0feiH/tOskUwlExiBKJU1K1GE5W6QGdsFdr5M+FH2h5JGaUnZ/e
X-Received: by 2002:a05:6a00:a254:b0:847:9d6c:a56d with SMTP id d2e1a72fcca58-84ee4844d1dmr300123b3a.12.1785516067920;
        Fri, 31 Jul 2026 09:41:07 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4d::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe7a243sm687490b3a.24.2026.07.31.09.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:41:07 -0700 (PDT)
Date: Fri, 31 Jul 2026 09:39:19 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me, 
	chaitanyak@nvidia.com, gjoyce@linux.ibm.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [RESEND PATCH v2 0/4] nvme-tcp: NIC topology aware I/O queue
 scaling and queue info export
Message-ID: <amzPgFs4whuvrnUW@devvm7509.cco0.facebook.com>
References: <20260731073918.614014-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731073918.614014-1-nilay@linux.ibm.com>

On 07/31, Nilay Shroff wrote:
> Hi,
> 
> This is a resend of the previous series to include the networking maintainers
> and mailing list. There are no code or commit message changes since the
> previous posting.
> 
> This series has been updated based on the feedback received during LSFMM.
> The changelog is updated accordingly.
> 
> The NVMe/TCP host driver currently provisions I/O queues primarily based
> on CPU availability rather than the capabilities and topology of the
> underlying network interface.
> 
> On modern systems with many CPUs but fewer NIC hardware queues, this can
> lead to multiple NVMe/TCP I/O workers contending for the same TX/RX queue,
> resulting in increased lock contention, cacheline bouncing, and degraded
> throughput.
> 
> This RFC proposes a set of changes to better align NVMe/TCP I/O queues
> with NIC queue resources, and to expose queue/flow information to enable
> more effective system-level tuning.
> 
> Key ideas
> ---------
> 
> 1. Scale NVMe/TCP I/O queues based on NIC queue count
>    Instead of relying solely on CPU count, limit the number of I/O workers
>    to:
>        min(num_online_cpus, netdev->real_num_{tx,rx}_queues)
> 
> 2. Improve CPU locality
>    Align NVMe/TCP I/O workers with CPUs associated with NIC IRQ affinity
>    to reduce cross-CPU traffic and improve cache locality.
> 
> 3. Expose queue and flow information via debugfs
>    Export per-I/O queue information including:
>        - queue id (qid)
>        - CPU affinity
>        - TCP flow (src/dst IP and ports)

[..]

>    This enables userspace tools to configure:
>        - IRQ affinity
>        - RPS/XPS
>        - ntuple steering
>        - or any other scaling as deemed feasible

Can you expand on this a bit? What specifically helped the most for your
tuned case?
