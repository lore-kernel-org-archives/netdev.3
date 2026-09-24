Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFE74BA1F9
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276671; cv=none; b=rUTUUoEXDExIQB0cVe4EvMBLHF7ahRl+hfk0IgPVeqk8kxTX5/qxRBovJb1tyDOUl9a+sNX6Q7NUPfhQ8VEHSkIluiAFycgupHNOt7M+fr/+k94kwuNFoL1mTfAUnYfzsJfsNKOV8OHX+sDPxL727V+f5p2Isrz3t8e44udLH8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276671; c=relaxed/simple;
	bh=SwQs7Al5j1UmJvVEuj3rQLTuudaBD2rDp3JiMnsW21o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k50uwx3F6xLNrk7TGq4bFy0YqEzJVKG38wTDOimZg1PT7hjz5Jy6OWLVGKyBdsUM8x78DC3vD6DU0UdFCIppJYLzJPooc30GwmsfyS0eajpQOUzDTThvnXsMa+s90TfMi9hD/J66142sRKZLl8Rfzmn3jscSzE95tvoF2U2Z8E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R4/oe6pq; arc=none smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R4/oe6pq"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aab5dae09fso309484a12.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1790276665; x=1790881465; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k0LKHGhZmNR41NYnppZNxPzzSiKvbLHZ+crHqls5R78=;
        b=R4/oe6pqZZ+GwXPyTwDhSRD2vLjw9O89lKNZ0YOmxRpc+vANyLRxOmZ8TbneLanrwX
         4I76WyQZ/ANh3sWqh8LqtkdsOiMb8a5P8O4zfvA/gKclS5GqpjCRkFiGL9HadkLTjREW
         Vm19hyw7hZNYqPZMkXgvhGxie/fcSBlNPIEts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790276665; x=1790881465;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k0LKHGhZmNR41NYnppZNxPzzSiKvbLHZ+crHqls5R78=;
        b=kK2aPBofjzXcrDHd/0KXFOIExgtRK0+0Rq9HCAjstRcFDD1QXVll6IlfHFpuznhVHH
         BO+JXTwko3Tpyq99agg4aMD79ZxpxRn+RcR9oroBASaLMz7MzrNY3/N5+uTwSg3/Qiw7
         dnS782vQAm1Box3EaIYz97Oq64P3osZyT1Tbgn5UhSTgU7JSXmLPquXSELyUBHDC4hf9
         lhh1JWO90CdI/yCERhx2JEePc+NiCsLnbDcCiOn6jMoVwoU4E2yhvDx3PrqMK7ytmkV4
         N9UjT5693OTU5h+qBCsg14smkatJle/AiIKYhs67rgGuP0+iCXxWOtxZXpAd/qdlK3LC
         CPtQ==
X-Forwarded-Encrypted: i=1; AKwUvBxCgZgDUi9UtXYGu31MbUe8bb2VUzfmIgCkMCs9Gr0rqDl4dqqkqa8K5muV7oHGHHv5bWrBbb4=@vger.kernel.org
X-Gm-Message-State: AFuF++nsalJwVPGPaFBiMRV8CoZAMdNCHJnzp4JKymiNiRPaGW80N54P
	c+Vb8UI+m1XIZVwFFumWSiTfjrBk7DawmLKX4YK3oLxnFyWM+6KL/5IQdxXEgq3iwlhAiJaaFKt
	P93+agxQ=
X-Gm-Gg: AYBFou3CEYIuJW6005vATTFqrnYwjPBvhoJtSiI7EgypSUhY5IZZ+bUAa7RdGbBStCc
	u1cS+Fo1r8LmfhZtEDrLLdhNFOh68eovqa39UxDH1hFwLrmadWnvvQlZtUarZpScuXv4BtYdoiW
	/eB4rTNT5RT6bd4QumaLUf1ja7Ofy58tvE/vvLBj99oqYYNeqHXP2Q+syHFb8PBvlyxxILbuBKh
	dgVYaBnxComRLdneUwH6tF5hpmfNMLy9uLVJQTVaNogEagZttX1IJEfI8H25LQuGZ7pwcjB/aM2
	3pcG6htyyzufi5RKn7kjBlKzHiFCeMuwO08sjmzhCIWYpfeqxvrBki5u7NGioIxkE2IDLjxn7BM
	JIMbuk1EjuLtSpR3m5HPd+eFCdty9y9hlVuuwIlN0qSFK9ByV+OvbuhY53uKZsjKEh/UXH4ZC43
	kFj/oDiDhyBXRFBm0qKIjrJTB5rEu0+/SWQSDFNGQoIgcPMpOnINScxqenPOJ1wohetGbYg4PeW
	LQ/kY7vz4Xt6r565CP/Euj0H3HjAp10hW5IxW46hpZDqbulIA==
X-Received: by 2002:a17:906:4793:b0:c29:3e59:fd03 with SMTP id a640c23a62f3a-c2ac2106681mr312792166b.18.1790276664971;
        Thu, 24 Sep 2026 12:04:24 -0700 (PDT)
Received: from mail-ej2-f36.google.com (mail-ej2-f36.google.com. [74.125.228.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae76a68aasm3131966b.35.2026.09.24.12.04.22
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 12:04:23 -0700 (PDT)
Received: by mail-ej2-f36.google.com with SMTP id a640c23a62f3a-c254f9f0b1eso18069866b.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:04:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzabp0Z/oQEWtWLQdnJj/e0y9moecesfmKfAET2Jyv+w+jNEZH9QTkwzYeBlVjCuvdP1Q/RgYY=@vger.kernel.org
X-Received: by 2002:a17:906:dc90:b0:c2a:85:5c01 with SMTP id
 a640c23a62f3a-c2ac22cabd1mr316782166b.41.1790276662520; Thu, 24 Sep 2026
 12:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924183257.2700506-1-kuba@kernel.org>
In-Reply-To: <20260924183257.2700506-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 Sep 2026 12:04:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSnTE9vBZ=5_v+3EEkdazCCbBM5YABRzRHUAeRdyd4Xw@mail.gmail.com>
X-Gm-Features: AclHuK-h0HvnSFS6BUSGEtbcXeLV5EnKaL4B831cNvb7NqxoQbE6uE34Lfb0WDQ
Message-ID: <CAHk-=wiSnTE9vBZ=5_v+3EEkdazCCbBM5YABRzRHUAeRdyd4Xw@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v7.3-rc5
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Sept 2026 at 11:33, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Every week in this release is record-setting for number of posted
> patches. It doesn't seem like we're creating any regressions with
> all these fixes, 3 Fixes tags here point to 7.2 commits but none
> are true regression fixes. We're trying to keep the count down,
> nonetheless.

I'm looking at those ovpn fixes, for example, and they fix old stuff
and they aren't marked for stable. The ones I looked at seemed to go
back to ovpn being basically merged initially.

So they clearly aren't regression fixes. Why are they in an -rc at all then?

Are they actually important enough that they shouldn't just go into linux-next?

Your merge message notes don't even mention them, which to me says
"not important".

"Not a regression, not critical" should mean "next release, not rc material".

Maybe it *is* important, but then it should be mentioned.

I've pulled this, but I really am trying to start pushing back on
pointless "fixes" after the merge window.

For post-merge-window patches, it is NOT ENOUGH to just be "a fix".

It needs to be a regression, or it needs to be critical. It needs to
be something that would merit the change being marked for stable.

Regressions are serious business. They break existing setups. They
make it painful for people to upgrade. They are critical, in other
words.

But stuff that has been broken since the first release of the code?

Sure, it *can* be a very important security fix. Or - more likely -
it's just a codepath that doesn't matter, never did, and was found by
some random LLM and that's the only reason it now shows up.

            Linus
