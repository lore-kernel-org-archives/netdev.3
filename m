Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3151254B18
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 00:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775608728; cv=none; b=ukHFsTJO0dOJJJsbgXjkgxHHfRy3T38poLVS1q0SpScLewyu/DF6QinjkYy7Fy0zozZGREFZqoOx0RppqdzzOp7ofS6F4cW3P1oiK9lh1mJ6x8WIxxdVjCF19bk35FpA7yanFFT2ivE890PySL6CDIRzv29lGRwTR7xIiA8Y5w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775608728; c=relaxed/simple;
	bh=XlSstnNTPTnbAPf7CszFu+uuopPUOk217z4nC0YmvSY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EHRixuSpoij5hp5icpDN/rhtP6ES0N1LVDdW8mi/iTyy9LJ2R+RyCleu90eqCrmXPVEajtNALJqVyv/o8PXrthNDoLnT4eDWMugNboSVvdRXMHHTWm7QO4DQo8VzQRj8795nj4U2iFwam5BOnzYbmIZ9eBbW1unfQPQNDYsQxiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOwmv8bM; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOwmv8bM"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79ab5fd969aso57673517b3.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 17:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775608726; x=1776213526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/Y8ALG36XOvbL7464wJlGy71Gu6GunBo4ycY6okTs4=;
        b=HOwmv8bMUPhHDVpURf4/sp1UAJLqs9IEk34wxXvBammRxrPrDKbvPDRLOfFxcj78uS
         jUB0VpQOyokC3O4LYq/jwBwB8skTUH9uxFMpJmuUMCyRurJiM4BPVQwVyIccf30rFSGK
         EHmwGgTA/9TYrR+MEmwnq/lm5wqG9XCsgwdHJ78gYYf17gnNwOlL9zPQvnAiLQ84vqpR
         4FBnFyozvulY0ToSrRM9/fCOqcjpZH7vNfmVTJNegwuP55EcxXjcm+wvbP5xwUBRILIf
         6SZLv4SbTSBldRs3MGB4XGe/dDQZfqj0lBmqgLU0LFoP8Zihw61cDZdRgX0RDVYZg7Cz
         rs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775608726; x=1776213526;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/Y8ALG36XOvbL7464wJlGy71Gu6GunBo4ycY6okTs4=;
        b=Wdo8/6fZnobvKgVXS9EtIL9AlVmZpnribOjzA+Ftf26xpJbOSCFWhf2r2pIoJZheGz
         0UpGiRPm1f4/3Au0VsA1dLmfZbK9yl05yMPJgmg2WL9jPYoS9JbcJqfaPjVnpAwq/uJO
         iizpkluEuf9VWZTdqSFf2OjXXgbXMf/tG9n07Ncz9FqD48E2eVr9jrVuOpXUBPVBIKLk
         1rD6zXo9wv+JZB0BrUzt+GFwwE5JaHpw/MmQ93OEcz/ZS4DCO+qrVDPhJljrIazevNp1
         UuZ7ZYYkmH1dLo/02CqfxOld0tvU629Kq4cSyVhTXvLddpwbhC1K6QGu+8AkCcEoUKoI
         ar0g==
X-Gm-Message-State: AOJu0YyPvtmpuoLCMsqGGl9p6VMt0m5hY0tU4+5m30FNeqVyEjiTU+YJ
	L2TErmSWo6py1wP+ywNGlNgrdGNwMBHjYtaKElFVZGgRrVzG3Rv17KOKPmaiOQ==
X-Gm-Gg: AeBDiesZUJ31t0njtANWtiDp1FqEZRRRZnZwWoC5UaG3B/aORzgtkjJhWVq2JQ2K4ga
	Px8O636Oz9lYWCbLoaXWgInxsNk+HG2ON21Fd9gZ+FHeIpoFm9pKOtNeGU8fdDpBw7UWYK/Dv4O
	P2zUQkWCjlvjQpDAgYZwIs2h2LhFjlOShHia/CDuLRmIRaGy41GnOm4vjMSWuHGcXdJqXZTXlw8
	nks1iy2o6P7KcE1Ee9KJVpkaitSyFES8Rncnp4W3KfJ2KOlnkZqpShp50pMrOqjf6K5k3XhSnOG
	aui0+jH6YKEIKr3frQdPTl1xo0R99pTo53Qw7wHWnPG2aLC4ADrHK+p9KBvPr81EI60rJHHXl/7
	tLcxrw9mO8Dok05U0tpIv0m/4lwfyjC+bMTSeQmqLo3TH9ECet2LArPcGvOuFvutIlCq9pSM0yD
	E4vr1xedJ6TTB4WTrLBym9bFtynt8BfJiADtivYWR5QzTgSDidjGleOk58AvWxZTrZ7iyPAqyWW
	NQ+
X-Received: by 2002:a05:690c:c4fa:b0:79b:deb2:f5d1 with SMTP id 00721157ae682-7a4d644733bmr189144697b3.51.1775608725829;
        Tue, 07 Apr 2026 17:38:45 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e228f75sm76487797b3.10.2026.04.07.17.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 17:38:45 -0700 (PDT)
Date: Tue, 07 Apr 2026 20:38:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 shuah@kernel.org, 
 petrm@nvidia.com, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.334c641c131e5@gmail.com>
In-Reply-To: <20260407151715.3800579-1-kuba@kernel.org>
References: <20260407151715.3800579-1-kuba@kernel.org>
Subject: Re: [PATCH net-next] selftests: net: py: add test case filtering and
 listing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> When developing new test cases and reproducing failures in
> existing ones we currently have to run the entire test which
> can take minutes to finish.
> 
> Add command line options for test selection, modeled after
> kselftest_harness.h:
> 
>   -l       list tests (all or filtered)
>   -t name  include test
>   -T name  exclude test
> 
> Since we don't have as clean separation into fixture / variant /
> test as kselftest_harness this is not really a 1 to 1 match.
> We have to lean on glob patterns instead.
> 
> Like in kselftest_harness filters are evaluated in order, first
> match wins. If only exclusions are specified everything else is
> included and vice versa.
> 
> Glob patterns (*, ?, [) are supported in addition to exact
> matching.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
