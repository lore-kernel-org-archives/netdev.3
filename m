Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793732616;
	b=dW8zYGlc5Ml3auGsxZBsVJu39IjDUY9D3wlQpNtspIfyCuYcdbqTBCGp8iXtkSgIrmfX
	 6kJQEBgPvvHAvDdqn8lyvi68rzKlhjzxJzh4CbfRFpAP+BMec+j7ClUNjt1c0P6GIh8Ti
	 Dl0SHCsJG0y+E80o9XimviYYHKfZymIpi+JxAskgUr/yqeOYF2K6GpTm3NMGZmD1h9N9b
	 vfwwLPJlpp0jGvLo2O+QwK047E0zqOBfh9DCuMBP86hwHMPhCBlSgWr0KmMKlH2pDkmPT
	 2Fcyyi6splMlbwmklAN+y1l15EInCNomlUG1OE4t2/NkWWBXBe7vUkTBfN6zZgsExyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=P9YIaSVOIFDCGM+06fwVMBsO9ra2iweeAuUBvKRsY8Q=;
	b=Roew+CjSSOPOwZVh8i3FbNCF6zF2WLDIhLRCBoXA2ZcugO+8MhccQ8eMx4RehHBEQXa9
	 TeRmCODuzgeqB37UYSwylGoTa/Ha9B2JOqeLcv5bvklArnuq+YOC3W/k8gmcddfmB0DpL
	 xo9ZWpmjswYqtTZC4K/TxndwKlycc96QKH60pp+JQipCeXNQ3e5dxegoRoVITqxG4llwc
	 EPonbGv+OpFQDCtvnDFp5XswszVR0CQvspDzsxbDnbECDOv7XMjwr5MtOy+FqoXUm3SlE
	 FRhu7OBhUOxXAb0+BfvR9N28XBDPaby3cAuC5zeG75mkCRTCk7mOPQeEule7AZJukGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XytStsn1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB23606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 19:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADB23606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XytStsn1
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-48e9476e26aso1326149fac.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 11:03:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793732614; cv=none;
        d=google.com; s=arc-20260327;
        b=F664PL+D/ZZ7EYEOyc3MsPKafHqy6RvTjvqmoSF19oDxQlowxzKn/3AexZ2YN52p7V
         tJbcNSHMK7Ypw6TdZuU5s4bjdHe5ZKhZulYgPzW2/Cw9uml6Lxp9I91EshR3zbOh+KkZ
         u+Pt+16BYgjNDcCLvY3yoa262nEiE+85OpHJ2qNbOLtfAuZZvHPNKMHyfQpL31pYJEaO
         fKtK4Cze+Oa+G51O5SonouCrpUY6PuBUVXwLh+UhmqsxAQw6kpVylSr4IRZeYVUDE5Dm
         MxsAbGJ19K20K85JjNqIjNYqoJP16fw6/s662PAqgUJUdSPBtTyITkzRg2WJDLGXXoGv
         Vv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=P9YIaSVOIFDCGM+06fwVMBsO9ra2iweeAuUBvKRsY8Q=;
        fh=AU3fY/uoSzXPyvEh3c123WLJHdn/TXmQTX0nZDPo5Qg=;
        b=Jp7yHot1oFcrK6yY6YIMNZkIEue0I+EHeunGgUG0YSi/P1KbjhE4OaU/0/98Q8IRhi
         e1cyU7FloYJxeg5TSRZwTI6PYy7CtXu4NKJvGjbDsD+3PyvF0BWNNYjMGNTXL8N+QaxN
         5q8kqR+nT4g9gQo4LNDGOHgoBhjvuKCL48XO1nzRnwTJ4yM6pGD+uYGKAvPMI02YpHUS
         FMUAqMl9++optyOlHiDTilY4LBWdTdWGzU5WrgkOm5W84aQxds7nMseqX2+b+82BvPam
         qqWPFyQPcXt2ZBzIGSkea+pZ4IJepkeM27KFwGDd/4kdImA+x7kIN6Q3GZZ2xF1mW8EK
         vjcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793732614; x=1794337414; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P9YIaSVOIFDCGM+06fwVMBsO9ra2iweeAuUBvKRsY8Q=;
        b=XytStsn1AP0F2AO1/r8sxXOSkNTl6Jzmk49zhgkJfm6TELhWsT+6X8VCen1v1x1xlV
         G8m7MUoxLh9i58kzggHXQQUlAptzmYtjel4YfTgJAjZPSFlcPp3j0oYLCxU16hI8MpWA
         aCfCGe0ZqbySGVYDMH6ZemZeIf65qaW69qBW3bHPoA22+80A2my509XZADnrON1z3ONz
         oyytRKpbfjwT3aILjXic42twt/MIyC7ptbXGqtld6up8H1bPaumP2Zz7AjzxPuQQp2FI
         O1vCnDVyATWoxt0obECRMD1ivprXliOeJXzrkBIkJ8dBUDrLAUoSPuNbrtXk9zOkcokr
         sj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732614; x=1794337414;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P9YIaSVOIFDCGM+06fwVMBsO9ra2iweeAuUBvKRsY8Q=;
        b=uRNpuSx6KFhGNaomJQ1vly8StpCqAT0g1ztymyRNy+hZM4Hq72KzBXEWz61h3nrfIJ
         8zvsBiI+2P/fsI7QQRg3zFsFUSK7Ousj6EWtqrmCN5XMyaeRM+PXAHKvh8/W7o31PRR3
         zp1k2ffy/c2o6AanqwXxEwVjgHHx4OjnZdN05pWiFcwoje0QqUcYEAnfx5feanl63buZ
         fp5Tzsa1/dI1YwYg48xXGiYpqYY6y+tuev9LSJYq8WRSA7eAPcUXsuxbQM8XxY4/B/lk
         DKDSKvZoxz7KP6LnAr2jrzrt6RTyFlWpz00vnW26jYRbTjHfOJ4vIOvEeQsEw7HLDNML
         rlIw==
X-Forwarded-Encrypted: i=1; AKwUvBxQzAkwJrCnIZIiaaQLUkIOxjnrbTh+VAQf7cuVagCv+s11jwvPLsjl4c21bhBSbXOgRKq6B2A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Mv2k5LNHrgMV4XcnaPm/oarFXi33enXtQEklbEncy/NH8iShM
	mhOFYNFAt1OdFV6jarCb/kGhgUtnSI5C6033wA3fsi/rXWtkTFXqYG5acJieLqdZScmbfuIeFoS
	+Pbs/zozAwQTbrckSYcYDFDPJm3F00czZ5nIVWBBO
X-Gm-Gg: AYBFou2ivR1FBQ4wcr5d5+cHoYyybA5iziKSfISQe7rdGa3voj4OyTWyQEHtuplgWBj
	32Vt8/8y060eyBP6XraUzgJEi8aUYnTkBB92C7NYktGLz4CgbhA8Ru9ty07b+qzisqIp/8N9euV
	f/m9Md4VMBjQTY5Kwjj+W61SzltjQdgMATEbNVTYtbuSYvIbQtGKxj1jGRH8QWkGCnsH3m8cU3o
	eEbcfn3qjJHnMuJ724kWaXyzGltgNeVVPhnfZ9tbOOjJFVzP5XzDNe6H75rM6Mi0Gd6PD6v5+rk
	kVgErG4oGG1PLWQ5T5E5SHST1Wn5thoeL16SRryLzLe7jBR6ghsbc3xRjtlbdTdZ66LRepIWyWY
	xaHV6pXmH31S0VnTIyykb9Iffv8J/uoD5iSQLy9XJyNAe8z2n+JTt7wcfMyPnEnBy0VNAyF98H/
	pAUfZKDwNpLbRK/4SDbPOe51jj8Wol0c5iaUo=
X-Received: by 2002:a05:6870:330d:b0:48f:e0e5:a1e0 with SMTP id
 586e51a60fabf-4a9077482acmr8991565fac.53.1793732614026; Tue, 03 Nov 2026
 11:03:34 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103163949.1554-1-yishaih@nvidia.com> <20261103163949.1554-9-yishaih@nvidia.com>
In-Reply-To: <20261103163949.1554-9-yishaih@nvidia.com>
From: Jacob Moroni <jmoroni@google.com>
Date: Tue, 3 Nov 2026 14:03:22 -0500
X-Gm-Features: AclHuK8ywmthycKAmjfKbn4VSRuUvkSGxm-2-uZNuBVCtRwDkAgCNnLK-FxSWgM
Message-ID: <CAHYDg1TnFq3EnG+6ej5SosbN02C_h5tobDtrqy5XQBk+g914Jw@mail.gmail.com>
Subject: Re: [PATCH rdma-next 08/23] RDMA/core: Suppress kverbs_provider for
 adversarial_mode devices
To: Yishai Hadas <yishaih@nvidia.com>
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, kuba@kernel.org, pabeni@redhat.com, edumazet@kernel.org, 
	davem@davemloft.net, andrew+netdev@lunn.ch, dtatulea@nvidia.com, 
	moshe@nvidia.com, maorg@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Out of curiosity, is the idea that these restrictions will eventually
be lifted once the
ULPs (and I guess the drivers) are hardened? Or is it considered
infeasible? I am
most curious about RDMA CM.

Even if the drivers are hardened (no round-tripping WR IDs thru HW
from WQE->CQE,
sanitizing values from FW, etc.), I think it may be impossible to
protect against certain
bogus payload scenarios such as a NIC reporting a CQE even though it
never wrote the
data (or wrote bogus data), but this sort of risk seems like it would
apply to untrusted
Ethernet devices as well, IIUC. I can imagine it being very difficult
to harden RDMA CM
for this though.

Thanks,
Jake
