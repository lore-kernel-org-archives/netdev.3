Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFE5403E81
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784722202; cv=none; b=RrFiEwpYztNk4fFW+Bx4gzX7iM2OXop51TUsf7FK1LTlzGDt676WKsx6p7AFAR5434UeQJbegYuZVZJHzNiM6BZruKNdhgRWTUo3gsJ8uMO1evbonqshldMQ23UnSHI+iaq2lJmtYA8IGKfmODSH6n+du7KFCyjvmXiqTrdS8Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784722202; c=relaxed/simple;
	bh=VA/au3nj23tfBwijnMQqd1qgNEHIaeUmb7okR+T0hCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faltVa0ALRYGdyIWjbzaBOiO/d19/r7Ehc2s+2mXJkJITkUiCZlQCJNx+KcouJSYzvc2MQn1HIZPEqnXWCVL+SCP3IZFbUxbyVpurZ2w4E7eM0Asuun1mGt2m/DCC3NH9owStKL0mLdZo76MtFsgNoX27cphA3ruD3h4oysjCuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=dHLxXcYA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="dHLxXcYA"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so5799012b3a.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 05:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784722197; x=1785326997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d2jd2hvRF7vFVJakiAK0dQf14t+sZP48pSdkltZU5mI=;
        b=dHLxXcYAMNkGS88tIaERsd7WqnGZe1Gf5VrnR8JUPE+Ojhl2w8j62aJvaUmpmmPDup
         +anHgF0tIQbKnLZVDaDBwf+Erx6VYmjXQYAhEQFcy9QwBMVlHc3L0C2q53L3bxXSiFDO
         bAsEA3OH1/AJUaW+DyEZ8l7gxY3qYKCTWfYQAZ17tBjjddjGfaAwEN26oT61ZcpKHFYY
         w9DtE9xqudJYNh0e4nmRTkL3/c63wJLe/22nvzrA+cXYquE+kf4H09CpKI9cvRgVZTMk
         anyE88dkydFGSxqDB2xm2m+6NDA7SCslY2/KPWgIF3xzV+cux8gR94HzMXgO4ce55Gdo
         fg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784722197; x=1785326997;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d2jd2hvRF7vFVJakiAK0dQf14t+sZP48pSdkltZU5mI=;
        b=Skjl2LOJ+V+BXyd+JhRvpMgjT2nq1+ivS3mqdhrLUNZnVgk6aa9+n4zXSiEDvI5wja
         rABsHgybbh0Bq4B6V3jmwOjYcSfFwgguENxwN0kJOe6ux/myDF+zEB+uXONBLCxKRlg9
         f0EoI97oqxYUB/+XVjeK6LVkIlpIYKD+UhhnHh95t/BSMMoJLLfV+/YI4btYd1K0Z/bR
         I2Z7ebwa7okAWYT5rnyVrNG6HV8X6zTVLJ0CTjcrn8/Kgd6ud+QdMWEqoZjWmAN3IEXd
         SbQ97vbtAyIZGUV0equPWHSAjSg3fVr4LB9nHNzRBlBT5IphrnKS76+20y4rc3GEeOdh
         8x6A==
X-Forwarded-Encrypted: i=1; AHgh+Rrj9MRBNN9xmGMSRYrtvDYI6RN1d83tKxXBbtWPOIfBJYBoz0qkQ4mf+7y/LfdCWjqVbz4t48A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+t+yB1etKq2C3pEoF6Mpf7gMIz/1TSKev8rnWvUsx07UkISKd
	w3avT2mjGw7Sb9aIW3OUZ+2hqfGezLIl/Q4YkVCe+2mfQbo6A4y+3K0NJLkkP1/iT0P90JUiVex
	GBKqZWTYZpg==
X-Gm-Gg: AR+sD11+8beKjmAmfG+hF/hKiHNaEEvFikt6+kUN9oMbEyc14p8dxGdhVWUoiaHgYS7
	5/k7U2gfElh0K3kpYKsQt4Ew5QwLOiABZnE5Sad6jqfP+aUtSvVyNLYgQIyuGdh0MfLoF7Oyx9Z
	tRWf946gmgfZmVPb/gc2iOR02wCuoEemZsUJ4MjldVRwyQCxHamdU0ZnicdP72xzCh0fH9VWkeh
	a5Lq47xdwKjJRsI9Y9JOC4u5u1+ksD8VVVxINhh7C8fXwQXhbbvrqgqAnJyAmd30FDsOA51AC4C
	dPRxpLOf3YbJ3YMiWoQRGzISwmAfdWjXp8OG3SSSw1VREiZJFk7lJcy9KwL3xUupN3bW8rQz9qO
	iGjKIaRI2sqj11ay6weZm/5d/jIQqqTBx55Oan0bOHHqu3S69l1xTSICvRGk=
X-Received: by 2002:a05:6a00:3a1f:b0:847:70f4:613f with SMTP id d2e1a72fcca58-84e15f7fc30mr3843283b3a.12.1784722197058;
        Wed, 22 Jul 2026 05:09:57 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:53::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175f31b3sm1238033b3a.54.2026.07.22.05.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 05:09:56 -0700 (PDT)
Date: Wed, 22 Jul 2026 05:09:55 -0700
From: Joe Damato <joe@dama.to>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: cai.huoqing@linux.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: Re: [PATCH net v2] hinic: remove unused ethtool RSS user
 configuration buffers
Message-ID: <amCzE+rz/lsfWqIt@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chenguang Zhao <chenguang.zhao@linux.dev>, cai.huoqing@linux.dev,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260722025353.328179-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722025353.328179-1-chenguang.zhao@linux.dev>

On Wed, Jul 22, 2026 at 10:53:53AM +0800, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> rss_indir_user and rss_hkey_user are allocated and filled in
> __set_rss_rxfh() when the user configures RSS via ethtool, but
> nothing ever reads them. hinic_get_rxfh() fetches the state from
> the device, and the hardware is programmed from the original
> indir/key arguments. These buffers only leaked on driver unload.
> 
> Drop the unused allocations, memcpys, and struct fields.
> 
> Fixes: 4fdc51bb4e92 ("hinic: add support for rss parameters with ethtool")

I like this approach a lot better, thanks for re-sending it with the
unnecessary fields and copies removed.

Reviewed-by: Joe Damato <joe@dama.to>
