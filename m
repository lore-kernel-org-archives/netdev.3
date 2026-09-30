Received: from mail-qk2-f20.google.com (mail-qk2-f20.google.com [74.125.230.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A22424D5A
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 06:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790837333; cv=none; b=LuyTIPj4t+Z1jdqjNnmwwsuosXLHNbtABOSWLo18aaXgvQOUmnkw8xpVPUTpZw/fUhQa9i/yDi4YXbewDoesYwLjDiLvLYjaUjTruCtAbyvS3wZrHD0Y72s97tDTaK9qGYWj7J4Rvc75ssCja79WPyZgH1uoOmp3LmsLzyFT4v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790837333; c=relaxed/simple;
	bh=1LKuc+j7fPCOnVcslCs2pb6L2qo2nOSf117ZUwzJ6xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odl0+3DFKYaOJjDmyevAetly3I3OJtAGgY3sHw3a/m3nQuYcw68tcRGp2aprpO5F/HQeGcircphGKZrzF8unfyE+Wkx9n4ApxerYWC/caUrP6SnwlLSv8r7wYDxRZ2BHUY/Q+ak5aMYCEtdWbW99scJWuPtq/V7YqkSN9yiRij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aronleigh.au; spf=pass smtp.mailfrom=aronleigh.au; dkim=pass (2048-bit key) header.d=aronleigh.au header.i=@aronleigh.au header.b=RcDLFjHk; arc=none smtp.client-ip=74.125.230.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aronleigh.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aronleigh.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aronleigh.au header.i=@aronleigh.au header.b="RcDLFjHk"
Received: by mail-qk2-f20.google.com with SMTP id af79cd13be357-939656ff6d9so638818985a.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 23:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aronleigh.au; s=google; t=1790837330; x=1791442130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uyL9j5NsMH6VVd620xtlYO1n+HYd0As7KHaBAMxrv+Q=;
        b=RcDLFjHkOzi35Zq37CFHti1MfZmOteSoEvTozcG/S2nN5gK8Kqjmvv5I8ftCWSeNAC
         ObXRzSR6bpsMKyC3exsn3427Wa4xoLwHsY6GP0rY7hHQVi1JYjUWJE371VxomMMT604V
         sIFVvhnYC3JO5X4J7DTcIYSCGk3191GUGX0abWLWIgllDtEJf8h1wrouGSVEv/btpbx6
         mnsNhdY+EGrbiorinnMrlTs1q+ydsLIx7L8vTgLtOCDM/6C4ZO+Ae/XmLGVyyJBY/DXZ
         GjdW6A3DwJWnn4Sy8RNyaOBndsPghzVeW5NNpnS19Xi7yhqw0WXSs+vrj5QjTLu7j+1e
         6yGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790837330; x=1791442130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uyL9j5NsMH6VVd620xtlYO1n+HYd0As7KHaBAMxrv+Q=;
        b=jKCT+/in9XgnP8DbftoevuAbunyBs55RXqtfG37iwWLhskeF32Rp8hVJwvVx1LaqEd
         sILL+xEBiv5mDwxMZWz04VhdMzApftM7SDr5VXxLSo6H9+VYLuvYfghRWF3k5HSUHTA/
         smEh0BonbOoP9A4xKPXYGrSZLAaJTpp42onTE2SBZmyu3WQfMEKtEojXxn/e3vnydX/U
         jgUJqNrkuckIFcNIMiQjlFSEjtp6b7mBv+cNXCMiGyGPir1K1Krj18Se7nG6iu12SOaX
         +zEtEZRFzp/wEBTnc6pCEBuVvJ2jIpbiVlOYK8N7sWKEHmVZpKHcnlL6Uop+dAaldPC/
         GJmg==
X-Forwarded-Encrypted: i=1; AKwUvBx7T3TIoxcwd3uBA2hD1gAfiIf+E4k/d44U9xJz8TGyWo1akVtrMy0zHCHzuNOmxQ62bvI9vFw=@vger.kernel.org
X-Gm-Message-State: AFuF++mlgSLSBO58cjaBy5SheCQXNoRoyEabjdopjI25BO8G1RKnn0HQ
	WvC3rtVN2iq+xht2/f9ZdpsGKfmigw0k//7y//3frSJ/VfYcHxb66jQmLoGoVPkEa+DVVbqgJlw
	YlWFeByaM3X8=
X-Gm-Gg: AYBFou2hZMhnkU9Wsm8PfoJpZIll3CGf9wrOgEGfCbe/XtVIyTSQBA3a6LNYlB/BfFe
	/8au0Lj4kiFV4VyPfArvrdtibKUCcWz2G8LPn+d3ZpiX/Zv3dgzQqvQQHheCq2DsDw3n90Ac5Ce
	sqyvf7/h9UXCri0kZTioDW1THiAeFOOJtcqNo76xKOVnO+aks+fnY0875eKXQF9i93EjvLgsr4t
	yK5JYiI5IHR0D5IXky7m7m2e4LycfWSKv+Ox0OaBE59/ZuW+QZM89dhjh3u+4upIGUZb81K7YQO
	uI3sH53NBOszXt5yXLD4bqZIORSBnW+LNzwuO5FZOZq8pjdI9hCpBPZxyRVFii7UquaFW49NWuI
	J6vZG52/yiwyCic35ukB7GPlp39qL4pZGIvUtUbMadvP4EDX/HaJVcEmtHviuEKSADpeTAoUi1D
	eCVU8I80OynP+RpmRkox5DvdU2OKbA3PjebMdpQ1xUgIjJxs7P84gLUHPjd4oTvPWU63WAOiAUJ
	ndRjPkcjY2/VpICud1MoXA5gDK2nItIY5UldcEE4nQ=
X-Received: by 2002:a17:90b:2247:b0:3a4:6e84:e7d8 with SMTP id 98e67ed59e1d1-3a4c00cffd8mr926323a91.54.1790731952097;
        Tue, 29 Sep 2026 18:32:32 -0700 (PDT)
Received: from ghostoverflow.. ([103.75.11.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cae71827sm562531a91.14.2026.09.29.18.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 18:32:29 -0700 (PDT)
From: Lilly Aronleigh <lilly@aronleigh.au>
To: roshaen09@gmail.com
Cc: chopps@labn.net,
	davem@davemloft.net,
	edumazet@google.com,
	herbert@gondor.apana.org.au,
	horms@kernel.org,
	kuba@kernel.org,
	lilly@aronleigh.au,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	steffen.klassert@secunet.com
Subject: Re: [PATCH net v3] xfrm: iptfs: avoid canceling reorder window drop timer
Date: Wed, 30 Sep 2026 11:32:19 +1000
Message-ID: <20260930013219.280290-1-lilly@aronleigh.au>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179065460863.1915782.14730367973310266066@gmail.com>
References: <179065460863.1915782.14730367973310266066@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I am preparing that as patch 1 of a two patch net series, retaining your
> reporting credit and links to this patch and the review. If you would prefer to
> post the corrected timer patch as v4 yourself, please say so and I will base
> the device lifetime patch on it instead.

I am happy for you to submit the two-patch series with the retained reporting credit. 
Thank you for your assistance and work on this issue.
Please CC me on the patch when it is posted.

Thanks,
Lilly
