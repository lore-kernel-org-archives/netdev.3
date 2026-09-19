Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F9A37F007
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 01:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780252; cv=pass; b=puJReIbTkOmgDcOw0JTRJU2CYnJ8E+9Sg40NnOGbn/YT50D3Blo4u9Ysi02Ioe4peI4/m/4bTo8i1iDtSi2oyeHzVKWo8zqEkh5wS8bjJpen31bEaq6eMUz5+puhgmBy9km2fWlgov+tTsdKZ9TmEM81czaV7zz3XItM1N6zDWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780252; c=relaxed/simple;
	bh=iGzdbSllr8QjJeo+SoUN85/5fREjJOEUukH1vTN+KoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDt6jynaqLQd8p6N+R2QER408tdgmqk84mJNrtSEEynXKMO4dZFA7vQyDdFMI+/GgUuALjCOEt4ZQWNLlZgURsiBYv20XeQuvLg5jjBSPE1zxRTrIzgBg4mmQHQkqbJCl3ztCdzi2xdoQrglEfUjO79r8FgS9cH05Q6rXl/WUnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ku5ZZPbI; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku5ZZPbI"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b79784a6edso1389729e87.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 18:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789780247; cv=none;
        d=google.com; s=arc-20260327;
        b=nmjEDh+cFBoYEt0Yb5EQiHNeNkC6oxNZ6Zl5hoeJ2i8XVOEuc6QZE400Wd0xGkxLqn
         az5FYFfSKNm3qzngppyJUsHEFfIxW1vWv7o990IPL4Lea881nznssaJmlShUJ1Cvzcnc
         cxNPld5VaRp5BJJ0IYocFQtFfD8CQ9WJULLRo8OObSbFIey9bhfQF6ERwxhShMwLfAR1
         xANa4pncQjyZhqCJ1u/+gbfMwbCjMceRt6d3q3iIyZCa+e/8nA3ckm0d95MK2cXlO02K
         txg+FEdPtYjITQl6CbNAy9JbaDJZKUgE0wIPgSb5iHrBt7jFX5q6U7rFDfw7HC6CVtgS
         uluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DGdaTY1YJtwZ1uBv2RCa5jny+whMo/kcQ9jtBIf3Fls=;
        fh=AMb1tmK/KjBhdo4pr4uX9NVLF5DYoGBzliP4r7ykaPg=;
        b=nyUD8QHofzISTCIj4fyLIjBdPONfOVW9XEvnfEHKBXsOK+MkIJYI18ru984m1Etr7D
         xjVNwzylOHMJcN7JJxiaia5AGHjbmlChLRBsUq6tfbfUv8ju79xMPu6gkmMDuaylx5CF
         5m2GSmFiClbsEc1LmvySUpgwOExUBVRACq4xXCFSr4CTMqZR2xRYYnfIneZZSq2vNPAy
         U7okUMym22uVOiMmSL9HymEE/ULsyeU3CY67c/N4riqE3b/MHwMzdkM0s47Q4KAhuEmd
         Mv/GgqCPvApKt4iS5NzfpWbglo3aF+5BE8VYNfUY4FFOZ4rMIJxJ7fBrItO3BUY58iKk
         VVBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789780247; x=1790385047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DGdaTY1YJtwZ1uBv2RCa5jny+whMo/kcQ9jtBIf3Fls=;
        b=Ku5ZZPbIm91w7kzyXvKcmdkfmlSKPDj+ikn3KeiK/GwOGSBJ9mpq3nBJSMHiNnbYPt
         jyvMl0IoC8odxWRjDmCAXDRycZmZ2CocvDLMlm/tWUGO4AnE8jyB5KrDg5qKVYyPBfiU
         QBncdpuJhP0zSi2lsJUhfKphm6zsyLbw4MEMCOh9wqzNGEACdz+tpekBeMPb75WaHsx7
         8ZZFNBJKwmZUsjroh7HXTWscFxfrrfdphl+Z/Z2WCEDAvozgjb5q/9IcVtadvjAfTykn
         azh900vhnQ2ZhpP9jPgu6C5PG3g0TSRClPqhk0iKVbKXwsuBY9nAOVj6P6+h6SMSUJYa
         vxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789780247; x=1790385047;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DGdaTY1YJtwZ1uBv2RCa5jny+whMo/kcQ9jtBIf3Fls=;
        b=GDgzMBRzoPANa5mTfrfSje1gnTiKCYSRmS9asOCx8lWMfiNY7RQMb9xAvZVLw79n/y
         dbyjbICF2uSQZxcO8n5asGJrQ5utIf7UKklIRegTMPso+8g10rSP2HTnADL/22X4/Uq1
         QKjF2KzNTwDClWw2COxOibbEOeEN55mSdDcKNPa11uwQgEVAS7JXTlhGv8JftmTQ+HaE
         ufBCBwEcn9VY0mnTFcx7NUyqIC3GvIyKnTFSYOdYr2tYPvJoj/n+IL8px7L6p8JzddbI
         nk3Jb/vTF/aauaANNH6OLEuULk+6Qk7n8iJNOgqAmDCOSac6EFqKn6iaEbp/nSvapnZW
         hS1g==
X-Forwarded-Encrypted: i=1; AKwUvBz27bsttKnz33AETgmFeF61O0QE2Q5zhRPLs31DJFL011dMj0XwtuXduZcpUifdF4ctDHxJ+8Q=@vger.kernel.org
X-Gm-Message-State: AFuF++l6BuOr+pinjKlm67a5eJGX6EOW3WpQ6FoQkj1iHtlysZiVS8km
	vCuJDYsF2sAsTvuY0YPDF3oab9UH7vGsdOm/vnMLroAHZsIfedy5YqgUlrFdqgmM+sQPcMf9S9U
	TUCywUdJso9FXb1mVUU06GLg7nXYZCTI=
X-Gm-Gg: AYBFou1KlHncUNJUr2NGtV5H6O6zNvRWX6Nq4a8j+aj8hZxHK2DECBl04VoY7ebCZWb
	aNXekYwdxgkV2digbR0rKyWf0wzj+s6ZCAjVfy3XcpN6nK9QRILe1RQ1aFmWsSsRZfPDtxxiwHJ
	xLoRQVXZFdIbXD+soISGiHpaz+d9uGru6lrLP74LMxCciAXR1rT6m8QagZRBVtGVJUhWbGxDVLT
	4f5H1CVEouVsrabkXnTUuchUQ69alfvoOMkiK8aFEc9LyHVwN68UldFUltVwCd/cf30pcjbBXlc
	i6fFELVgBq7nE9F6cDyc11zG2NTZd7cUu87ETwFM6xr4Wc9kSE1DHas54ohZMZwC4STplbyggXq
	DKvN3HU0JhEkZVz3BPivKz2fpfLIUOz3zAPxCmSgftt7F3xXdtvWskgQ=
X-Received: by 2002:a05:6512:3e14:b0:5b4:a8c3:d26f with SMTP id
 2adb3069b0e04-5b8c1809b8cmr1360063e87.23.1789780246375; Fri, 18 Sep 2026
 18:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914014539.5015-1-sigefriedhyy@gmail.com> <20260914014539.5015-5-sigefriedhyy@gmail.com>
 <20260916185405.2ccc6aa3@kernel.org>
In-Reply-To: <20260916185405.2ccc6aa3@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Sat, 19 Sep 2026 10:10:36 +0900
X-Gm-Features: AcwNN1V9shfXHkJcE1WXlFxXnTZCibrBttUB3lePMBgN9N4dGzTVVWcdAubNumo
Message-ID: <CA+7S2vJXBAz61SOu+rUt5aqbnsZ-_G_KYt8wXXbqzD0FCSh5eQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 4/4] selftests: net: test AF_PACKET multicast dumps
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, Nikolaos Gkarlis <nickgarlis@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 10:54=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 14 Sep 2026 10:45:39 +0900 Yuyang Huang wrote:
> > +        try:
> > +            addresses =3D rtnl.getmulticast(
> > +                {"ifa-family": socket.AF_PACKET, "ifa-index": dev_idx}=
,
> > +                dump=3DTrue)
> > +        except NlError as e:
> > +            if e.error =3D=3D errno.EOPNOTSUPP:
> > +                raise KsftSkipEx(
> > +                    "kernel does not support AF_PACKET multicast dump"=
)
>
> What's the point of catching this exception?
> The error for ENOPNOTSUPP will be both very rare (not sure I understand
> where you expect it to come from TBH), and also about as meaningful as
> the skip. Just let the exception propagate, it's fine.
>
> Otherwise Pylint complains:
> W0707: Consider explicitly re-raising using 'raise KsftSkipEx('kernel doe=
s not support AF_PACKET multicast dump') from e' (raise-missing-from)
>
>
> > +            raise

Thanks for the review, I will fix it in the next patchset.
