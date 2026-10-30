Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793371433;
	b=b0UQCAPNxpjjr/saRiyWL5aM25Qp5ajyjbu20PnFsicnMDo6A6m3BTtum6UHOUPd/Kcz
	 5R0Re6cSQtgcwnRxfouPJQp1VpmH5MJ7ByaOV2ZEsYG/iVXo+IM+kUrvBcteRxkKYVJvD
	 Lz5grMXFy1V4NAYnnhfZIOJenR6X0/8qYrA1ZHNMVoEjmU+c1wgXldhTGEAPKjiak84RN
	 2Cs5P2g38044VxvpsD7+gxvzsuncO8l6xjXyyJP3Rz+qM81T315rLP2361PxCeM6Wav4g
	 G8hs441e2mHApeXXyYalXpCmoaZEdDyyf/H20z/q0gKn0S92CvX5voEQOShxvTU8xDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 Received:In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=2DCszlHWvxqB8webBIdmXax3WRZ56Q66qaekkXf2dZo=;
	b=axV3LHRImisKnwmIXvVVCHt4tYMBDI1moSf6aOHeKK6FuWtzDlaF9h93g/annJf6oO6m
	 jb1Cm9IOCUWJV0x12wR0dwTKUVee22A7Yj29nEJFI7UoBPEOe3TYspeBJsR1VHB65dPJF
	 37TYvHwveKAdILVq65xDxUkt9I6sb9y/NfO06Q4+YCT/SJrQq9utONUxuw+ML/VS2Re5A
	 Majzir7fAjZeu8xhbtZQixY3tiF/xq1WtHnsw0whR2elMmEaJqCuqErF91x+smWIpPOb0
	 JLvavadbN0W4re/l5QZX533AcG5cJeny0EqqTHYq69fcLbrLAVXbQwZVDml+y0wQaEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gA1ltqi4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50650606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50650606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gA1ltqi4
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4b190cdc9feso514760b6e.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 07:43:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793371432; cv=none;
        d=google.com; s=arc-20260327;
        b=GRtpdi/FnBxAXPOH+Jl50GW9Pi2FRMVT+R/ZJ08n/H+rk/LrFuYQQ6sWUm2rsKwgY2
         ASrd4fPrK/AoqWDgkSTn6U+WgjkK+u+ETm3V6gKxzXCSepjiSFBQ/BCB6fDt7bywVdqH
         hpK3gBN9FLd9nfUxIUhFsdhRb8LDK+CjgVdK3zlWWDKqvJLrfqB1apLos+cKBcPBERmW
         LKfwZ7Z8qu65Zp5CY14n0teZgcRonDwc+bqRjUiRF1i8TNzPUF3IaLq6keA66j9FDidU
         /FczQyyic5PjKlxHyIjcbViD57r+dvhojTqSPh7FqDxiebgpI0b7LmRx6TVnEaefsBbe
         S/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=2DCszlHWvxqB8webBIdmXax3WRZ56Q66qaekkXf2dZo=;
        fh=CxbVuMP2JTmwSnudDGoUDFRNhTnJtgtXV6wJs155yxU=;
        b=n2Fqg7lZzqIgH07PPGZO7MfxUAA9HX3wHHPgWNWCwqWhXM81QbP/RyC8I6yxYFWojO
         kJmpGhD5mNRLGELz7EqWU+iW+/XHrzaQHpggn9pSQQighXadYsR1jwU0wgckXxizpNi1
         4I0EVWqDtEObeL2fFf2Br8jOopjxEFUrhOLILAj/FAO56mdWikMZqEzVe3DtpSup+tUg
         BbUvbtaoFr75g05u+AitnnEkG3d8fEheFCIAtnf1x2JgkU4wGu0Rj8AXlGO2Xxxpk5fH
         fqx9/MoRB7pqKJWAD/Eo6JH7O0R66dsYua4+HmwO3qPUo69t3QXWCPwNkGnvFy81IRHW
         cbRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793371432; x=1793976232; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2DCszlHWvxqB8webBIdmXax3WRZ56Q66qaekkXf2dZo=;
        b=gA1ltqi4ElqKRY9O35EwjyQFXwRUhmrOFbwpo/cItbUqcR3YRx7545hWH0SzP1bb9e
         jyc5KYPVaEOJMLD7XmDygKzZf/FAGqxBo2Ox/MkW2r9alv58djmCtm3b0Vj2ZxoTBoqf
         +dn7ca6/EEtZGFFM2OZDTRR9OCI2Qw0R8udd16KFpve8ZPsjVZxzZf7eTjjBYsrPzihy
         dKTHySEbW4T38YFYS/YUozYZbFRW4gqbuvmuVEH4Jkvm338CFgz9FvX7XYj0TxD0GLCF
         77EskBiPog0zASlwtAaoKp+qUh3X8DxFy+aNtWOvN9svabS3+f+3LX1Wto5jFIZMMKgp
         qdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793371432; x=1793976232;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2DCszlHWvxqB8webBIdmXax3WRZ56Q66qaekkXf2dZo=;
        b=kO1e2s3RrR1xOqXx2kyyYHAUJxNKzoTMt91G7twLw4cXxNJ48uEDxbKQStgW+XBfl3
         G65PKTY+A+RmT484KNqHErYuQW0S3ZdbE0dr+ZYsmdxkg0SkLMVqb/LkrN+v4bXUnDOt
         n0ZnN+wDFk23lJArm71zF1XTlI7npRhs6jZ4sVMf3dKDfIoxXLVpE8FFCwi6E/eXf1rt
         TZ1cHD+dhKbuOqe76nQZsMa2VbZ7loxuA4EB+idQeWqphSJ0JxQHc95jFHFctD8Cjiab
         9HNd4KSVf5/lmK1rGjq+IGAoO7oQF/C7a6hfJUMjEbv48LdJG614wYwcJNGjsyb2h0PB
         jJBw==
X-Gm-Message-State: AFq9FYIE+TDDmWvfk3FmwOMh1BX0m9Z3Hh1zbV9j7+MeDRH3kc54Ypqd
	J7QN0iEhf2Bw/lt1WxIehMD/HEncinm70AL7BtrfPpc0ENBjOoNjzetjhYXSFoaCITkbemieqC5
	iyz7vRErXt5ZY1bxWD1uJ6dns2OqMKes=
X-Gm-Gg: AYBFou0owBXfoyC68fY3BN2CKc7a71duSoehySECJ+vU/ROKiscv3WW1qJ3/4hzfPpG
	AdewapDvX7XmUvZCUXBY/IxoCSxakAA8n0V6epzAzyIOB5ZnpRJkGH3B+x+CkpCjiAUIKh15Q+m
	V+BNH9jN/4MjQkbQu1zMJqptl24OM/mc/mI7AE+4M+WZNNVIDxb0BVcMvsrLVygi/HRjcaWFvsd
	v2rjjHtKe5zv3m2TBOchVNZ6sg8HrWqPPRAcgH2NpR3uBwBtyneghV2sG3AmagKR2Yb0jrc8OQ1
	SxEt/X7G5CMLFmr33p8yD1NKDcyjN/b4mtOsOhgXSJUFuW1WhBfl5G0rc+Q09I8+dJ5JL6OE+Aa
	6Folwr7V7qZE3ZQYEYO+Q2EQRZpopA3w508nN
X-Received: by 2002:a05:6808:c413:b0:4f3:e98f:fa0b with SMTP id
 5614622812f47-5640d9718e6mr1839104b6e.5.1793371432233; Fri, 30 Oct 2026
 07:43:52 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 30 Oct 2026 07:43:51 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 30 Oct 2026 07:41:51 -0700
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Fri, 30 Oct 2026 15:41:12 +0100
In-Reply-To: <20261005183141.5e246d3e@kernel.org>
References: <20260930050307.1978654-1-roshaen09@gmail.com> <20261005183141.5e246d3e@kernel.org>
From: Roshan Kumar <roshaen09@gmail.com>
Date: Fri, 30 Oct 2026 07:43:51 -0700
X-Gm-Features: AclHuK8Gt7zm8s5fL3_lN32O1iml_DECRMmlm8TJyqnHu4NbnC8In9fPWY1CWbc
Message-ID: <CANphZRPkEfwrZ8=X5k8G5N10c2BEbAYSxWH=QjKUbeHhVrW_+Q@mail.gmail.com>
Subject: Re: [PATCH net v3 0/2] xfrm: iptfs: fix queued receive state lifetime
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Christian Hopps <chopps@labn.net>, linux-kernel@vger.kernel.org, 
	Lilly Aronleigh <lilly@aronleigh.au>, Shubham Antil <shubham@octane.security>, 
	Giovanni Vignone <gio@octane.security>, Robert van Eijk <robert@octane.security>, 
	Paolo Gentry <paolo@octane.security>
Content-Type: text/plain; charset="UTF-8"

Thank you for the detailed reviews. I reviewed and tested the reported
paths and prepared a v4 candidate based on net. Broader build validation
is still in progress.

The timer now uses absolute monotonic deadlines, so repeated updates do
not postpone an overdue expiry on low resolution kernels. Ordered input
is serialized per SA through a bounded ready queue, preventing concurrent
reassembly replacement. The device notifier releases queued references
on unregister, and the input path rejects new holds once the device is
moving or unregistering.

The revision also delivers a completed inner packet before a later
malformed block stops parsing, advances the reorder window past the
expired empty slot, and removes the redundant device null check Jakub
identified. I tested these paths with KASAN and targeted reproductions.

On the discovery question, I first found the device lifetime bug with
syzkaller while fuzzing IP TFS using custom AGGFRAG descriptions. I then
investigated the KASAN report and reproduced the lifetime failure with
a focused TUN test.

I also removed the earlier unprivileged reachability assertion from the
commit message. The namespace smoke test confirms TUN setup but does not
verify successful XFRM state installation or IP TFS input.

I plan to post v4 as a separate thread.

pw-bot: cr
