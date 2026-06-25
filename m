Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A83D32B11D
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403548; cv=none; b=YWZBqP+bZsVPPhdvWKSDr7bQzj4cNZH4y02EV707I8kj38htzsYsdB2L8l4L7kxV1PeqcAInzXANJpUD24/EPk9UTbEC4beUbnq3PhYEAlkBONO5dJQ/xUSi2sHj12xaoEjnR85iOpyFI1uonzZpNFrdUy/XWzhIREAXinvtpaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403548; c=relaxed/simple;
	bh=YJcOu6NyveNs3VlR+m9k6HxcWFD4ErZ8ANTta6Oumtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wsm2duwXEagHEN9o7GQnRHzONeZF9FhUzlX7kx+GStqJ+GXBhBoYnvZOZnWaLZnm7+6a60BvNfW8RntawSiMcDKi+fg7no4Ni4FgBNsRxJtbPu8XZvrLj1YKDUAB9+F3FJNijkQTdP+RKKll+KgBBoVDvypESEJ48ri6icBw1BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2nOENTJ; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2nOENTJ"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-8454160043aso2341353b3a.3
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782403544; x=1783008344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0LJbevz4vUanZrFz9FeCIY7ktQP1laksdtC7d7Bbx7o=;
        b=K2nOENTJ6bCPi0IxrW+LpC/kM2V5CZx+YswAvMdlFLxvD62S+XLzo9+vjiExS1yxpq
         ASh2ZzjQa+crrn0uW+2Ir31PgHL0Bv0ytKPKiUHNAEHBJTsI1TRplvHIMYLWMdX11JTS
         3uYNJRghFrzDATqHP01okkdC/dUZN71hLk2YTSRNJZvAGzP2boQh37YM5gkm2SyEDz8q
         9rYyGFD8j6m6hOcC0rAPdqxLBzPaAU3zLX7EKx3CgV0rBzaxJAwMA+G40D0Jb+kHzIre
         k+uChol/sQKYX0EYCtZxJYY7gbeWa1RzkZagVJ8qXakkh2I5okPFYzzE+LGstDzBYM+H
         tR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782403544; x=1783008344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LJbevz4vUanZrFz9FeCIY7ktQP1laksdtC7d7Bbx7o=;
        b=sIQzFljAoyhKgqssR6yZ13TD0rmuUCPbDx8MPQ3Ue8kByQ8ztpPml8ZXtTBK0TcNR8
         f3Nub2pTlgM+o8MeIYqkVAm7+cBwPImchQoAWgvTo10ZCTLTsX+7fWqMiZTB5elwpyuv
         P27kFMSUWF4GabJnUW+53UzxxCBmTDO6YUqzLywc1WAqjjgLpAgkbp7u3G7rCefKrTm1
         A8HD0p4aJ/k2rvGx5JOd7wTU51d3Gf+X/+HZlpIJCefx6ljjjwPMVB9kZbxUP3FKw6k9
         DuCP9AZ9ZOmARl9nNRhtZWuXDloCoKUGSrKMwUWTBp6G5gny9drd/g4W73/rdeDMpwRn
         xv3g==
X-Forwarded-Encrypted: i=1; AHgh+RqthT0nOrPOWfLxlMvkD6zyYXjrNKkJ35YAVCGzCCHkfXWI/47Nh41b2VKXnR0E/v11C7Yyqz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVtFeoEQxaUUlBCe8FewHGwIuNof1M4orSE1WlHplIqZrPCbT5
	YvLDb41QlN/DGwqZ7+miBojna1BYvQ5X+836fs+aiqrYK0UcMzH1QV69
X-Gm-Gg: AfdE7ckp+iWM0v7eXqsZ4M4t5Z4/PKQnDDgRMi86OjhgmUuY4/fnb6DHEEvC0yHoDqs
	rs75iW0LopC3Bb68X2KOAhXDC+rkaSCipVPASZA+XgT0Ip6twTbeeNo+6KTHJyrK5R0P+fDMh1M
	RPxqHgblS6K/iTGziDi2k+ZZfG8wmWrYs+reiDakOjQnLpEoBt6slmr7981xlv/k7coz7tGvyBs
	6RbiECUWLK8/RtBimJAZfsSiXzuMKDlX2FTsenTSO4m8QryjQTXDyzAvmcmj7oWDa3MdESg3sJ8
	K7PedI7dvkRNeu4GEgefWnSHzgO3Amn8XbGOBrXsFFCGBTk/4HtRzR7TtsL8tbBwg/YrfhaPZp+
	VW3icpVcZ578ZCaB1yDiun/Mi+7JNWEMxlP7Eghp9J2SB4XGRHzdGmhHhIsTwF4qtpv5BQrHoCh
	uYquMOJg==
X-Received: by 2002:a05:6a00:3cd3:b0:845:3ab4:7864 with SMTP id d2e1a72fcca58-845b3b1e279mr3777993b3a.44.1782403544045;
        Thu, 25 Jun 2026 09:05:44 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a413c7ecsm5801278b3a.56.2026.06.25.09.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:05:43 -0700 (PDT)
Date: Thu, 25 Jun 2026 08:49:42 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net, 
	sdf@fomichev.me, dongchenchen2@huawei.com, idosch@nvidia.com, n05ec@lzu.edu.cn, 
	yuantan098@gmail.com, kuniyu@google.com, nb@tipi-net.de, aleksandr.loktionov@intel.com, 
	dtatulea@nvidia.com
Subject: Re: [PATCH net 4/4] selftests: bonding: add a test for VLAN
 propagation over a bonded real device
Message-ID: <aj1ODwv2tHTo4xv4@devvm7509.cco0.facebook.com>
References: <20260624182018.2445732-1-kuba@kernel.org>
 <20260624182018.2445732-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624182018.2445732-5-kuba@kernel.org>

On 06/24, Jakub Kicinski wrote:
> Add a regression test for the VLAN notifier handling that the netdev_work
> deferral fixed.
> 
> A VLAN's real device propagates its UP/DOWN, MTU and feature changes onto
> the VLANs stacked on top of it. This used to be done synchronously from the
> real device's notifier and deadlocked when the real device was brought up
> while enslaved to a bond (instance lock held across NETDEV_UP) and the VLAN
> on top was itself a bond member: the synchronous propagation re-entered the
> stack and took the same instance lock again.
> 
> The test covers both halves:
>  - that the deferred UP/DOWN, MTU and feature propagation actually lands on
>    the VLAN (link state and MTU use an ops-locked dummy, i.e. the deferral
>    path; features use veth, which exports vlan_features to inherit), and
>  - that the deadlock-prone topology - a VLAN on a dummy, with the VLAN and
>    the dummy each enslaved to a different bond - can be built without
>    hanging.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
