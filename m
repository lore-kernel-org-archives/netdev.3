Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B2A41A519
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737298; cv=none; b=CIwfQDafUrnZ6Y74Et2haTS6qglOCHaOfSq1+cyWJJkdAXRVTZ9QfCRBKTOb8Glo6fM21jbqiYAYzPaRjDgSHqnbnjx9DCDYLsHog5I5GoGnVVvJvhjlZ3GbtMnkKxOgd38GsUUUW5aEgd9j65xFXgkJ6vtNG/zZqD71Cqg5uN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737298; c=relaxed/simple;
	bh=xxKyBPOd9PhQEIiuhI2I0kJjgACoLXtBzCwkT97oGSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e5jWkbz2idbewHOi/rKbj14IY6m5RLXGuLTwjWVtgjOHaN16qYhpI6/7NZF5UiNh42RnKf6+4HnMfUv8N4rDwp2/NmfJ20FEpoZSU+vN99ZZnl9dbwPGvbVoJxokQrkqmNNBGZK0aXrXhS80ITV7x9XjBG+dBHQCnLFS7lxst90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o7hS+BKs; arc=none smtp.client-ip=209.85.222.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o7hS+BKs"
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-976cb36b375so1560978241.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784737296; x=1785342096; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xxKyBPOd9PhQEIiuhI2I0kJjgACoLXtBzCwkT97oGSA=;
        b=o7hS+BKsgT8NLsXx/MC77lBBNC3MnT0nWrUBosXpBATLv0rsA7eGQcjpmea+UPVVbx
         vR2vY6Lhuc20bBJDHQAXxFVv/6NI6Vvy2pfsvV2PtTQvm0UCtCOQVUlqcuCtZLJUZThr
         GnviBoJD27UD6BIgolehLLVoZA3gx9V1BqbG9mDYo/mY7P2P9d6HZboNLXqpIOl2sPCZ
         g0c0oSkA/OXfdj/d/3Ff4Y/udBwQiZC8V8l10ALqBfwRKNkR1OqDyMOlOj4L/4zFswA9
         R6dIlTh13DAro0cIZovNYG+x7qWnbiUL2I+3D0+xRZPOoqblqayN0hC7w4Gwy+fBrPGN
         jJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784737296; x=1785342096;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xxKyBPOd9PhQEIiuhI2I0kJjgACoLXtBzCwkT97oGSA=;
        b=Xq93BdxG2/CeTC6TvmhDj/+qeUORYzX8Qthu7WesvNNtXIeOx7bsMyRBMn1CfrazTI
         QDuTk2dDuCzZ0gjoXejTrXMS+hbNKFnj02FPVpcon2Gyc1/SuK71BDCKnkhkcYRGg4y8
         GLenERM7dmDn2wWlYVDU2iHqWagj30l04UwMflHTvU+FHMtlpKvFSYQOvNPFO8c+pTdI
         uPqD4N1E9+OjOIElU8A0yQvwoWRxSAYwy3pdrBqANMOblTu/hSSs5JTG5qVcQFdu5FSS
         g4uODF2fJR8YgQHk9W2Yb7q2Lw+YWPY3os1Rd/pkS+DK+SDEevig5o0vM8WKI+UZch59
         8DkA==
X-Forwarded-Encrypted: i=1; AHgh+Rra04lss8GgzX317jvv5C8onbqpQSUZIqT523EhC/u/7elFf5rXFflEMZKodOoo6Baf3N40S+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHTcszeXrxB7Gldt1cxb8HSpazmsd57zq5AWyaJ3HC02ZtEVxD
	ZmTaXX+zpQWGBFSGDfk7KW5AY8v17932dKJgPg18LZa6R8wXoiugkCo2EgAX2FrGhoaDs4EsLhR
	Tm72GUnHfxeSHq0Owaove5hWxJQ==
X-Received: from vsbjq9.prod.google.com ([2002:a05:6102:6f09:b0:737:4dfb:a6e8])
 (user=thaisonphan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:61c7:10b0:74c:594:4847 with SMTP id ada2fe7eead31-74c0594668dmr725571137.25.1784737295957;
 Wed, 22 Jul 2026 09:21:35 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:21:35 +0000
In-Reply-To: <20260721115339.09a3ea0e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721115339.09a3ea0e@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722162135.331826-1-thaisonphan@google.com>
Subject: Re: [PATCH net-next] selftests: net: update wait mechanism for relocating
From: Thaison Phan <thaisonphan@google.com>
To: kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, gfengyuan@google.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	petrm@nvidia.com, shuah@kernel.org, stani@google.com, thaisonphan@google.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"

> I don't get it. I never saw it hang. And if the event is scoped udevadm settle
> should return immediately, rather than hang. We generally run on latest
> systemd udev in Fedora and CentOS. Please explain your problem better.

Thanks for reviewing this. I looked into my issue further. I found out when I
run into the hanging problem, the machine that I run on is using an internal
Linux distro that turns out to be running an old version (182) of udev before it
was merged to be a part of systemd. The source code for udev I was referencing
was out of date where it looks like udevadm settle relied on an internal uevent
sequence number to match up with a kernel uevent sequence number. At some point
I think it was a known problem that these sequence numbers could become out of
sync because udev would never get uevents not tied to the default namespace. I
checked the upstream udev and saw that udevadm settle was refactored, so that
sequence numbers are now deprecated. This patch is only applicable for versions of
udev without the refactor, so there is probably no reason to upstream it.

> Should be a separate patch
Sounds good. I'll create a separate patch for the exception fix.
