Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABF9579818
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883012; cv=none; b=X/ENCKnl6Ui1K3Wfrw0SNbyfaBU35vVtq+kvO2dO724RILXg9leUepMNr4QAjscZnKRot1n6BhVqjvQFTpSoBPtVv39X95tstchoiwSXv7ah7oIrFGt2PDbK/NaU4cYT7VHDEtXf8lgYbeJ+6yvzmnxWiLIXlOVynMNK4Wep5OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883012; c=relaxed/simple;
	bh=BDTXw8V1+T9yYLdscvALeVjlTpmAO2A5VFSV1E8Xfnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDiGlez/Y0tKK1C5l2u0zOkEtA+CApZMSauqlTfd+RLyhccZY4QJaryaOXPNKs+B97w4qVmCG0qwQLhGqAVJ8DnK1iZADuDsyvQywC1Tcpx9dbOO0hWAac0or9pHYcPT9jDVwYWT2NKmtNDXmWr8ZPWUXGCrGPFe42UIs8LaLLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2BeSqhS; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2BeSqhS"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-39569e136f9so2795831a91.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 08:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788883010; x=1789487810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7/ERv+qulj128buK5/vZcxB8uIf+XT0ARLfsLruBLn8=;
        b=H2BeSqhS29aORvc5nwxngxVHu/4Jf8/jWlMP1u62pRM7n7k5g4LjkXigndSupnDaPT
         6XvXznjQKRVu5gPurLjVt5OlTx5aUnr6i4NO6y+17blylnyvaP2BTnWTqaLCjrfrsU7+
         TUNeM4mQ+CNXPmxVogsfrHIOjbFXhRN+a7yRTZmL5U82otwERL0Rz873hsV2H2jRLdqp
         FN1Vb9KUwsmda927HaMaiGRq7yNaPcm2U/PXU0EE11jMY33Z0k9zRIdghxwyvnNEHdMU
         Cd4T8RxOw9IWFZK0kXYnLD/6lXsxz/gykZFAZVbz4AdOOoo5dJBsReplhCfvwcXkKwVN
         kEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883010; x=1789487810;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7/ERv+qulj128buK5/vZcxB8uIf+XT0ARLfsLruBLn8=;
        b=nKTSbLmWR/bJ2fB3C6cJCeBU8q3sB8/yO6q9BYRRohLLofPxP/koTPfdIML8fNsPwF
         2PecXj9e1K+8v17s+bmLTICK+45jOIJC9/amHI4tQ7gBY/96SXdaOiFA4EDVK+GquZef
         VHAgjbFj/VtQakKHTtdhVpqMXyh+7XzpCUMJVTw2IB/JJ8h/sx7Jrt64NVljrT5mu+Yq
         lqnhVIO7H/51ojBcWbRfloZ87I+fMKBpRx3PfZKRvKoW+ZvRl13qIen7XuWamccblYMo
         PxStcG6hVIJ/Jb1yC+oKg35cCfVDpJK+ERQ/Ecpzozp8XJJ16xxrgnVXTIuN5dHoZL8Y
         DZ9g==
X-Gm-Message-State: AFuF++lMHOlUnOvfkRPhVQtiY3nDvtZ3QYSDROqPOQnJwd2lY9THRbjE
	ZpH/3o1CbJBBpBcPxLBHMCgky/JQPGyLuFdtCyWRzE8LEUPG8gSevgkWcEX8sEsR
X-Gm-Gg: AYBFou08u83jFsJ/UGz6Cp8q0gOfNtrwHyqyt9zVvOl14NtEuXvSMfS9oRL7CuB8iSm
	qb3HG5ByaIPbTrYijRfn119Nrz9UAmOPyvrBqu2ojuaqsZOFlTGdnFgHJ1B+fxAg3vz4ic3N7Ty
	aatOKxlRwnb6jSZYdD8Ew2dFXkXM9OJYDze58EiA4ig2o45R4tAkY4uGE/33td3DK9IJVZjH+wz
	0kJpVQVrxNHWGFtIsmsarxj0wpPGTh/kJdoZmbZCEO73rTHTSwF5umbP4D8IZZb6P9oFUBsJSgQ
	PaFSjaMqqEsfQYcgBEy9Lt/3TiXPrOioF4teMgX/YYEhOdyaimxHjrtMpFO5WrNSXHBlV0fiAYZ
	ufdsWc8uSqS8rvvV1zekCxxDW2+LDxUyjIQK8SIAqvHDvqz0ggBgQVvIx+LONP6QJq+odZYuAbR
	HHaqsdByWr63uQqKlZqNbLfgDHdGhTdnfGj+YVJ4Gcv9IkVe1OOfNX8w==
X-Received: by 2002:a17:90b:3c42:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-39b260d2977mr44660146a91.4.1788883010217;
        Tue, 08 Sep 2026 08:56:50 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd15asm27244367a91.4.2026.09.08.08.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:56:49 -0700 (PDT)
Date: Tue, 8 Sep 2026 08:56:46 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Netdev <netdev@vger.kernel.org>
Subject: Re: [ANN] Containers to run Netdev CI tests locally
Message-ID: <aqAvrZhltKTjlKe7@devvm7509.cco0.facebook.com>
References: <9c66a2b4-2787-4421-bc9b-627de2f708bd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9c66a2b4-2787-4421-bc9b-627de2f708bd@kernel.org>

On 09/03, Matthieu Baerts wrote:
> Hello,
> 
> TL;DR: containers are now available with all dependencies to easily
> execute all static, unit, and functional tests in an environment closed
> to the Netdev CI one:
> 
> - https://github.com/orgs/linux-netdev/packages

Are these public/published? I don't see any packages when I go
to that page in the browser.

Also:

$ ./docker/selftests/run.sh --pull
Using ghcr.io/linux-netdev/nipa-selftests:latest image
Emulate Docker CLI using podman. Create /etc/containers/nodocker to quiet msg.
Trying to pull ghcr.io/linux-netdev/nipa-selftests:latest...
Error: unable to copy from source docker://ghcr.io/linux-netdev/nipa-selftests:latest: initializing source docker://ghcr.io/linux-netdev/nipa-selftests:latest: unable to retrieve auth token: invalid username/password: unauthorized

(and it's the same 'unauthorized' on another machine with real docker
instead of podman)

What am I missing?
