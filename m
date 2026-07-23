Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5083547986B
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784808384; cv=pass; b=VVEBE9meL9gbr68pkU14ugndevOirhCpcni057jUc8V2Acdy+2Q4XKLJW4Whr6nDJZ7QofITgpyDoXsc5n2P2glUu2Ew1hfeA4B+1GZ6TM8JLR/xHqa7yuMoNoLgMLsJLWHm1SztsTV0Kst4hnoH55SjXEpypYkIi6Qld+voV4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784808384; c=relaxed/simple;
	bh=VvdkSEeK1pCtA7zottET1dPjUJJE5q2ZltSj3vFP120=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/FMjgW4oQgGPt144xDegik+MceCZea3oMboiW8q4b38Naze2F+36xf/EHwMDXFVCH7/phCCshERuE6izhsVk/5XI7BqA2Ympw/2ppQmDtEfjEKUTacu+Mh24OPScarCfLLefQVRF93uMEcnvMaYfaGyKzzO83y+XPbB46CNUik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssdA6TCT; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssdA6TCT"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81ea0b7d137so2996997b3.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 05:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784808382; cv=none;
        d=google.com; s=arc-20260327;
        b=B0o5wQU9QP9YLJf9KatuCD7sCFLAOTtcBdYKMOaWtiIIjHUK6rf1v1HVt+yl7b6kKP
         YpNVECegvivwCmXAXvCEKljhxKyav6QkqoA3R87pXvEMoHaC2ysVBHcyUcOHY+MIkrjZ
         78G6lKtk1Qnokyc5hiGtJrh0zSp1FOXOx8qho69hELKBsEeEiB5Nv+x31urJDd4j9Mmu
         prlngWnxrFjXdOLzJMMufzgLnuK2RMAzL02MwFT2KkZ+QD6CNuvgIbp3efBmq2ddG5KY
         g/dnAk9a/xaVX7ApFVF7R1x2gD9ATx0OBA+qT3Gf5wVG/b+vaL0Ohukzd+XcRc7/heOH
         1oLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VvdkSEeK1pCtA7zottET1dPjUJJE5q2ZltSj3vFP120=;
        fh=5Smurx7JwLfBBr/qWIUcD8n7ppVdHtJp7qgvz8OErao=;
        b=goGOy3s96yuCHd1Lrbpi+YyGsLE8NMYBtcYBqE6mLbasO/aPp+TYBNA2PPk5YF0coP
         /WWpBjEJBNhgUK01sN4QMraQE00okUHTW2JqYATqW4DyZfwo7GrcC/DRR1MNvk5W2QDv
         V7sg3VozvwsXZ9qXN/u9M189hyU9Eqb9FePyMd7pxtvNRvbaZS9mfjHsVGUTVJtYQvPD
         NIECetirpY1aTleofHx+hUDEGhm6eXGwfmzrhLU1HuCI+5qszTyrNspQ0DfJ/HsUHpDK
         c11x7zUFLjyLWaCcw5BoYouGsaGd70Z5qpyph53wUPyzqMtHyqACfOa23bqgRKXiz5F+
         n/OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784808382; x=1785413182; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VvdkSEeK1pCtA7zottET1dPjUJJE5q2ZltSj3vFP120=;
        b=ssdA6TCTp3sV4yi4dRKTaXyJM5+Bkc9ZNXpm7k5VK6LsItY7ZEYWlJUHIgHRR6dpII
         18pHvYGHUNRngurNlqULpryLy8YBVwJZGvFKpVeyxUFOmX9AH4oz4V/tNZlITbkERa2k
         saSjhbn4ZxQxuH5IMQNjaiHzwNBAIGcfnvJCRCIXkXx0LDiii8cQ0RQ1n0PlOQd3RZ/U
         Y5MGK+RtZcvNa4eqU9lFVULBg7gnBREO6ZX+jla7IMBth1WCy1+m5Y1e9TmLz1mPHZGn
         YYmO6x/36Ejr1T5DkDj/CXG33anjRnKAAjij9kNSkRt8b/k0HAMtqU6L0F/30uq6z3QF
         4nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784808382; x=1785413182;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VvdkSEeK1pCtA7zottET1dPjUJJE5q2ZltSj3vFP120=;
        b=rKAWAYQ/qPU2VAxPC4ApCQX4Gleutp0RU3N9HX2ww6UGrPCPw7gqKAsq5467PdnpMn
         C9B8UaklJ68n/OadYB/UpD3HBqIfqlCmQ64eqOKn3nvFuyuZ9g63wrXcBXOvf5NuzLGs
         zD+UhkKTOtlIpaRiIqaEO1JOo4AscVxJjNBeF8k+7PooGZi/eptCreSTFqHc6RufqrXd
         CzZiMiIz/EyyiTutepYa7egOuW6bfnNqAe8OhOOVwXEt7Asgh8hblNlw/4AnUdwkzh9x
         tbuABKwRGVAxCvFsnWSiPdD8K/xgZsOC02cTaPa67ZvgVqhHiHO2Yhnvn8ifmDyBr3L4
         cWEw==
X-Forwarded-Encrypted: i=1; AHgh+Rr5P3yOh+Dr++mQ0zDxKIhuRrSkH1zbBUlQzjW6o+e/P6MrWTkTNvyRo7siooKV4Z7qvkEMvC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ+pCFhUHZUQz/eiInZe63/Ngclof55qZTeVGC6zVMq51qSqBa
	UqG9hpbU9GG7rziOcWtkpwoWYwDjhrSl1hMV1tM3rXx2JdX6bafkifqrDL5cW9+US8niBTeBvXE
	U4kWbPiJVAaUXBhL5zIPIDomCR0pMSofsJ5bpJbD4Gg==
X-Gm-Gg: AR+sD13dm0c1A2cOKZwlVg4TaQAB6PC1efYgflxVVPVqdS2wC+VF/LEG5Ed2qOCXam+
	v/cngQCtymba+ZSZ5m6sVFNCa6uc8XACLQR32Z8nWrwxCQghnYu7cAdXziwpTOF2j5Yc/AlgzNs
	tWSd2EsECjxSSxt1eLXbSgHUdppvTLtXCKYT4DMdn7Gku/3+Wvb1LFbSkPSN2DrHMgl7a6zOjTI
	Uq3XVeUKSvVOpJmewlLEPyODhp3uRgogH8Opz3JZWeaZ5FI2q5BNRia13/Nt7Y=
X-Received: by 2002:a05:690c:450f:b0:80c:85e5:8755 with SMTP id
 00721157ae682-81f4c393384mr8368317b3.62.1784808382077; Thu, 23 Jul 2026
 05:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722041326.75199-1-blbllhy@gmail.com> <amEBJTKhUJHaAsBG@devvm7509.cco0.facebook.com>
 <amHuIvHN1zY4wYpt@boxer>
In-Reply-To: <amHuIvHN1zY4wYpt@boxer>
From: Cen Zhang <blbllhy@gmail.com>
Date: Thu, 23 Jul 2026 08:06:10 -0400
X-Gm-Features: AUfX_myxdYyN-FDseAq5GS0y9o3kOqSSRxpPEbIzRQ50kO1HBtZJPXnfkXDNHuQ
Message-ID: <CAB8m9WjDoHb67ixPVs=6XgFfGP2D4kqM_SSUj5as=xegF63NMQ@mail.gmail.com>
Subject: Re: [PATCH net v2] xsk: reject undersized tx_metadata at runtime validation
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: magnus.karlsson@intel.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me, horms@kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, 
	kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 22, 2026 at 10:55:17AM -0700, Stanislav Fomichev wrote:
> Hmm, the AI review points out another set of TOCTOU issues :-/ I wonder
> whether want to go all in and rewrite the users to have a copy
> of metadata? Something like the following below, build tested only,
> any issues with that?

I applied your proposed patch and tested it against my local reproducer
-- the bug is gone.

> Maybe you want to take ownership of this patch and run the proposed
> resolution against internal AI review?

Please go ahead and carry this forward. Happy to help test further
if needed.
