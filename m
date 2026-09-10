Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E6757C73A
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064407; cv=none; b=UTdCPzXMDv69FVMNPG1gNtraFVVpeMgqYC62UgcE+S99Y88jMfiyGV/wXkm/KTf6omye0s/aQV2v1D1aX2p1wjp1tSdZqzUX6rXPdJdPsNRhN7HR2Gb+elIbbjeLKBsXGqhWxoufiSWwyz0TGl874WBxxCaVAZj3gjKMFrPHTDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064407; c=relaxed/simple;
	bh=qF51l8XO0vylmqZ0r93gy6syKZHssm0J0aqhvYt3uik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDMjzbeiGBkuKjLVppZmgD9br/4NmHjvlHLTe9otegfU/VyRu33jk95utV7FbPq0GIEI9J6TZO+roDzj5tEf3OVr1UO8rYSZV+Xzog9IcwBE8wyNjDRn2MHk7Fhr2cp3xigSHL/KIZ6XzUhKcIXytUS7qrYGqdsUgQmGHKNFilk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=ltThp2Yk; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="ltThp2Yk"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2dso97305a12.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 11:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789064405; x=1789669205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DIF4EGNYV//D+/mRr01nJgL7wM1T2zwMBGkKJveANRw=;
        b=ltThp2YkwJ/W8ZBYvQhFDmWVKGHbE7lgLR+hlyhgMQy1R0Kq6FRxF9jIv+Su3oRXSE
         0yQugKyKzUugP9sIqKh5zraSgVK/cvrNax7gY/ZIaSJ0azricHEOyiAiEKmnqvBvpUs3
         NFu+WfByTgOPRN2Koq3Zz3pljo+KFQEXC6bnfTHNH/BIBxMu7fsNTg5VHRXWRcj3L+Xm
         LRg88IQZht8f0y6yYWNABqAxvX/hWeR1SVdimdOZpz0wc6WG5ijv0XNqNmgelHFLCRop
         0ozwZ3Ul70fdCE/ni1xYSjpqM7VPtWN7T2C+aYDgbsQHBuewIsgM1afQGym6WRp2DCBi
         v/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789064405; x=1789669205;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DIF4EGNYV//D+/mRr01nJgL7wM1T2zwMBGkKJveANRw=;
        b=CcpCllH9iSzhl0bFCPNDloLTRwgN/dFA6C4q1LfRyD6+Uyr+Iosdgji0SEocwUSOsG
         ZckZA6wBw91NtH5FF9oTNY0VFFULJZ9XPBRyCzkPhjtivpvYsPjur8ikfZ2ADFqkDCQv
         00Ehvf8m6AmBMH3yefLiSvfLScWavgzyT4OFqJNBPQ5gYMIlgWgu3oTqQwrqaE5CWEX9
         XzXMsrbSJEK5zz6kgBYfzjsj6N5pzH71I1xNcc4wM1xr3asxm0RlKLRGE4KK2eWWlj1W
         TkXBUBYXc5I65QroKGQR3WTZ87Li1+totIToz4HTNvCoAt/wh2D4oBEMNhox0VowUpwl
         rejw==
X-Forwarded-Encrypted: i=1; AKwUvByZW/WbQoICcA4tGw91sP5nMnSTUVlEZTX8dHvmeZgCTqlY6ZRSKbtYm0+j/pPCzOXJi5k7xuo=@vger.kernel.org
X-Gm-Message-State: AFuF++mZTECQo75Mew09d4REt7tuaKzq30Y2Xq/p6Y7diEnsVaNAzlkr
	zCVqQz8zDIhlZVnsTAhV8k9EvuTtAp2QCihYqoEzVCCjMH8mpgtv7nXBfNrO74V/Np4=
X-Gm-Gg: AYBFou2GvnSSuCoHyMfx8go7MKeEhj9/RdvmMVKGaKLPmKp0SBMFu26h6YrkMxvqmSD
	a/N+LPHsfxEa5BnmWnDsMZxzxXA3YIm9MJpgVjKX0CDO52UEyHTjtbHVXXhI3Jfduq/uaKPEwg0
	wsa2IWuzrbPnYWdzqBqlU7pwKk9fsu8M3QYbkfJfC7EnX5/Tmtf4zPrPU6BL/pkv2GulM90bcCF
	ILzhc/cJQzJ4bFgmItICdvPC36OHC7/tvPS3sBIDWCGKT4EY2bDCqVdSQYlTqcWYdffyhhotq/7
	wBxRT4oT6jFQmKY0go631ZwP3aHRvQBq8iQv7U4vr9DTOE4oYa4mAguo2XBTeraFEmgGetkl3fn
	QE4ThkbcMzPyovdybhEYIRG5s1xW2DsSggOYbUqrbtWx75HcYySGRPct+plePCGPKBppYn4mFCB
	j9r0rM05qkRZ9P6WguWptPk5IOikQPgqYMdrPTAPUJCN2bwIC0T0zVRz4eozzxu9g0b+SUSdbAu
	1gb/m+90lC8twvKPRPF2z2asaAxhPuNPfQsMyjK
X-Received: by 2002:a05:6a21:7314:b0:3d2:5eb3:596 with SMTP id adf61e73a8af0-3daed31ac5cmr217449637.16.1789064404793;
        Thu, 10 Sep 2026 11:20:04 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6599249sm101174a12.28.2026.09.10.11.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:20:04 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:19:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org (open list:NETWORKING [IPv4/IPv6]),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] net: ipconfig: use ifreq field aliases
Message-ID: <20260910111952.47068985@phoenix.local>
In-Reply-To: <20260909144417.28871-1-lalitshankarch@gmail.com>
References: <20260909144417.28871-1-lalitshankarch@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 14:44:16 +0000
Lalit Shankar Chowdhury <lalitshankarch@gmail.com> wrote:

> Use the ifr_addr and ifr_name macros instead of the lengthier versions.
> 
> Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
> ---

Why? seems like useless churn. Those header files never change
