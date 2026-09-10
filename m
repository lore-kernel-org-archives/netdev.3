Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19269345CBE
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 01:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002699; cv=pass; b=k0Y+2Z0zaiLHSFamUkbqxb1Z3mx6F8wEPQay0GpPdqQjqaUOLC4IgGbLs+3LDsz0NYSdGVu//3EMtWs2x7huHoGkVyidUKN0laF+lme5O1mnG2wK7UOotOyvdn7IsQPK8MIaWxjRXxBcFSwCIIps8bWMBNivD1vLQ4mx1BttSoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002699; c=relaxed/simple;
	bh=dO5xIwDGCeR2biovWV6ccb/Zfx/Tx0QVvxvkWwn+Jhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwLHWLAc4t6KQdGEvCnkckBpxPIEfU/aRX3LWAimrFqJwG6PD5BrtB897CcwqECVAvMgzjFLbPz9qna8kQYMoQKBRjPePviS/xppD0y+rF2nYwwnmm89f5wOtnna0CuapEcKHvgjEGz7chl031Q7RGFjwPnGS1wXEVO9p1tMfvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STo9fbMu; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STo9fbMu"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a499a6d02cso13651051fa.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 18:11:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789002692; cv=none;
        d=google.com; s=arc-20260327;
        b=MRuYF0K2ItQbjJYlp3g3VQvs5xrzxWEB/heZr4BSStBdgWpZEqsdnV1ImC3eIskB9Y
         /Ac76XqmZ8fBINn3MtTry8ODOfA3mCShqnWowBuV0xrDT1NV+LXO529A4ZSMreSxhicN
         Ov+yll6QZ59me31/DTDDXp6n24NfmhO8aOmBcoTadFguEhLBMWHs0fxIxWIwISzdBdM5
         CxM2dBX1XxwBRw8cmYMu1tKzP+Ka7KHLGi629WcvGbwvNCBlpIdP9GJybMRnv7FvMtmW
         uJX8dxgurIOKzRNlyW+TzGvC0AMcSMUkAsgOp1Psi470q9EbwtibnzC4f58ljpiwkvPK
         jXlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dO5xIwDGCeR2biovWV6ccb/Zfx/Tx0QVvxvkWwn+Jhs=;
        fh=BzrQqZaBSAzkeTKNzEu4GBTqL/PinoGW3FmUbIBi9sg=;
        b=KHCIjib9zBRgbaHK328QCanP7tlUHdYzcjNf9EvktB5MPkCuFCi6sugs2l7GlaSrdX
         bUw3IMGwBDUTNl1AAPBCvWBdj3HBWqgrRL29R2QO7VZ/yUN7tNa1cbuaRjTNfZd+336M
         JWClF1HZ2CEjxBj7yJULBFug06CE/2dBNSiABvrxFRJVTdQ1heexsVbs1bTgYduyca7F
         F9M7jodTe+rZL7pmtgkcKU7g34iOB+xaKj70XjIxlRyYnfwda7AEk9rT2bAmAgkGS8C4
         vPS0TjUTdw5rNrzyKMm9d8uRXxQVvmyBh9sPf4+N555cJrK7Hbmqc/nE0GLpizg68f7s
         O+Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789002692; x=1789607492; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dO5xIwDGCeR2biovWV6ccb/Zfx/Tx0QVvxvkWwn+Jhs=;
        b=STo9fbMuqQfrxCCADuP2rbP1sidSRyFmhGVkdu7ZbX9isK2AfVz5ahEXjjVvz43fCo
         KtENrfgLXcYtROgblNwKoaUZ0lfOXs5GdeliXIqvKXvQio/PPf6q6vNA8LXzzy18lfEv
         aV6HjMh5br12fPLfDDJCEumOtXIlSARvwO2R6sjc3/rz4asjMH8RlMFVenQWdT0fL54a
         GzQXJKI2gCrknivDOd7dPW8y7ZVCkJohjRhsqIcP5zNXbgw/a3iVh3YqMyRXQX1Yhk5e
         Isfuk0Acv/8imKGWsAQchkin2GzF63cJxyGN5C4FUXPN92q5kg4PswSobpnk3XiGm5u8
         9uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789002692; x=1789607492;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dO5xIwDGCeR2biovWV6ccb/Zfx/Tx0QVvxvkWwn+Jhs=;
        b=FrNspq3ombllyUh4wchXN+ea3rbW6aYtfHKZb1AaOLIh+qQEdZnJ+E6+pS7kH6A8pl
         jdyEkrgeAVWCOWeUNLs/z4N1n95ZUdFnxiGV5ZnLj/W5zrDZOdBzKmEEIbYYp1ajQj3W
         Qk9A+uZp8v0X05+OA9q1H4uYoQkayACr5123QHwJsjupN2k0BQ1z0IfCDjLICUypsI4S
         2kdAO+ezFMMLUKxffh/UrxyQlOsG83OCZhSgGBEj0fTUKpi3fqrJ4Fwsp7BY9OBDsaFo
         zLDTQXVIAvyJBCiAqgG8TtFy5DDi0/qJzpAzomuaFhm99WBc3Lc4vkHP9hzdE+AD0Rw7
         QWKA==
X-Forwarded-Encrypted: i=1; AKwUvBwe2L9+qlFqLExpqVKyYTHgqyZg2qPR1lFanPJk1TZQRpX1/2FlNk3qJwg9u8K4Yx1ZOV8zmyw=@vger.kernel.org
X-Gm-Message-State: AFuF++nnPJo0TcB8ZYA2bh+gduZTW9X1bkFv4eqwXppwfqF0h8wB2ewa
	WbT935jSwndt/MP1kC7tLgVTP2jUVdobvaYSXFQ4rpAwuaUMZhEDfXbxOU++p+IX9p5C3MZJIUJ
	8MQNjxMKvfrrL6LOMD+juReCMt7DOE2Q=
X-Gm-Gg: AYBFou0FGCWkZ8qw7a0NMoSnAk7px7J4PQzq7A4UwclQGT9+1TkF76f7HMGrxiOpkSP
	rTHsaHgWwD7tRasL+6a2KSq7XjYwAtqEDQiTWpBUWfGOrP7+tDgIPe8vfNESbgJ8ivzAhrQBB3X
	gg4/qNVFrbDecr3lGLmrXq9Nykmq+mte4ZqjvJfPL0sUr2ze35cFVq431DhN54N4iUR43pktdQA
	0Yd0yUQOZUszDVxlX0rOXAdwCPtNGJZmNhYy+Obk2QaVpRFcAaZ2nRrKTTUxmuCq7OU2mVrLhNR
	893U9EOSfU3V7sZqON9CU2ooU6/eZaCwXa7Og56r6PKwrBG4p/ZyOyXK5zowck0J/IEPwCUFFj+
	Z6rtggqKz+F/3nkPr7T17/nACGx/9DxNJ4Em687heXw==
X-Received: by 2002:a2e:bc02:0:b0:3a3:7741:b446 with SMTP id
 38308e7fff4ca-3a37741c060mr43937781fa.22.1789002692206; Wed, 09 Sep 2026
 18:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909133247.113923-1-sigefriedhyy@gmail.com>
 <20260909133247.113923-2-sigefriedhyy@gmail.com> <a6836306-a60a-4bd9-8173-0bd759f73dad@6wind.com>
 <20260909113259.3d061483@kernel.org>
In-Reply-To: <20260909113259.3d061483@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Thu, 10 Sep 2026 10:11:20 +0900
X-Gm-Features: AcwNN1V3nPrWO9zKa7tKGgL71iRod9c1a385A8lYHx_2U83y6B4hET2sWFNcdm4
Message-ID: <CA+7S2vLwLDd6y-u_8=SvQXXd4yjuFB5rqvJjUqYPTf7vQdAOsw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/4] netlink: specs: rt-addr: fix the type of target-netnsid
To: Jakub Kicinski <kuba@kernel.org>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Nikolaos Gkarlis <nickgarlis@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>This is a fix, so the target is net.
>Could you submit it separately?

>We should just drop the Fixes tag instead
>It never worked, and if someone cares they can use the latest YAML file
>AI makes people slap Fixes tags on everything these days :/

Thanks for the advice, I will drop the Fixes tag in the next revision.
Though I think it will make sashiko unhappy....
