Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38B82D0C75
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 00:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790124589; cv=pass; b=vDmWxLYEKzLWoVvy+MTpgxdxAV5p0ivNnrOdy38mTccUbY4gc6GIfai/oxHkBEx9n9QbfbWZNpET9i/ODLH/OaVyCMNAg7/20t2uT590s5tj4ITLnjoxjPW3Sq/rL5YpZZCvgiMTOqIBOUr2rRXebzyxDBQo2Q4y3ZvXCALq+Tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790124589; c=relaxed/simple;
	bh=z4nEtmW/B7eogzGruiprSjDTAnPPo0KNEGcrLZetKgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdtgzDdhtBbJ2CUC4uRUUvn1fpWwXw27ixU8OdPzTPPY5W+KHgl3tDgRmDmcvj3DPolFWCahBt+YNu1TuUzU6d5Q1vz6i/1NY8KwpmgYePjEXKTMIppfGjozmBTW5j1Eprpfu+KLhjWZYxNX1t5fJH6cUsTQoGajXUhDwiVfk4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPmhPf6G; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPmhPf6G"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3a20f06cce6so4415091fa.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790124586; cv=none;
        d=google.com; s=arc-20260327;
        b=nit3bX+I9PVC3ivRmfVBZ/fzHjXvMVR0A9qH05QOZvYTRtpsEQrU3jcVKs/e/nuAhf
         bg0vgL2mObgZ9vu9rhWdNLyPBeOEvN8Egs7VGv0sDEqeeaYKZX2R3yeXJm8uEAWVAzAV
         j205wT+qDxYQA2reMvbX+GOsGZd4TIepi3idRer8PJWSvtaJr2Kf72RZJrPkcX0yL+lt
         rEWkj5kZ1jTyKBHsdarzgx/1LFn94eq9D5/8uA3YE5SwTX86RbvLnnEGyJQyQCac1Dr9
         gNbH7jcJylcS2xobi33EI7iroXCCjOph7fNNJFsv1B7LMzDt0Z6BYuUloOLfzxpwAZ7i
         Wx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L/jUfJT4ttFuk5nJaSR/zxk67u0WSF3uD0qyCWP34DU=;
        fh=tcThzQluaCtLLeZrphxr0HA60qCGxiaqIBXxPTf97B4=;
        b=NsmYHdfscc9I5Dzk6ngt1hR1TockgvY4jVwdZbt5Ew8B/VFNoGsR/XlzCv+SXPsrE4
         DTRzWDdm5AqWrHNVlPZ783V7FE9n7wgVdM8Xv5zpoQclnxXQH23kj9gGG6bcMfs6ZdCf
         omRNIaiG6vs+wzPayfk55myTyXGo/Tqq1AE2mJomD4CwLUlEr0CtGtuOXsPYm79WxFs7
         4bbs25Mjnxd23AO3jSvk5anwST82lCEspRQIjl+X5VM212Jhm4YFzDJofGluBEF+qAl/
         weFBNY22JSkfuK1lTnzMNha2Yzjkm7vxa+AMjsXYLyxJAzvRt0RHZgAxggFOl4IapWB0
         UyLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790124586; x=1790729386; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L/jUfJT4ttFuk5nJaSR/zxk67u0WSF3uD0qyCWP34DU=;
        b=kPmhPf6GKAPw3LS7y85s3PjBNg3bk61omaCv6WTEwcjvDNy9YxJhCPIUaWNV2jBJho
         F6YH+aTw47peFBTEkDE5L6r777tVK6YHwSC5eUC2zwDvRegrhrecbsOHUNEsVooVScY/
         aEhPC734NOpIAn3lthxA679K/o8az2HWx94umWqHXiC6AEsQFTaGlcUaF96r2Xa8dhkR
         UDfgDVjp+83EcLBOGAS8PuDY+4tocoD4G9WJ3w5eGZ0OcOVvwxxVW+AqIYgY1SRJoxHI
         /E2O6wI/9Y4hewo8yTZ9iNgQDdidffqsp7SwXR5godqEWQHM/01S7wgxKJHncQJxk1Cc
         EmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790124586; x=1790729386;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L/jUfJT4ttFuk5nJaSR/zxk67u0WSF3uD0qyCWP34DU=;
        b=gJqYKh2l5KRFZvMK6bPfUraEK6d/I2yaXL50lHmTma9IKM0jRN7a3WN87eVGd3Go3X
         ovi8UycEENTQu7iQzpMySo9ewRQSEax2t0iug1jFyvKUiYxdbL709U/913YKW4zd1I+d
         oHgv6LZ2qmOzid5LYcWehl+nbjZOahyHlzIxMT6BRQ7dZav8mGBRFwQumwY/P3Yo7GUf
         QUnmAoA6wVWtTZBGkeRGuk3p3U9kTwqk7MeRb/w8/1gkd3tZi2yX7me4aB9T9WfjU3Ud
         YkpJn96AWpDYkVNnzCJlC0nhegRRjfIrHHhSEbkAMwncp+VCubtqbv26+6JUx3JkvWdz
         Da2g==
X-Forwarded-Encrypted: i=1; AKwUvBzQUSaqvhtmWiQUKkXahelIzVih1aWmR/Ks4w0gBzNxZI8S/V1OU67mFFfrlYcUSdEOCKtqA3M=@vger.kernel.org
X-Gm-Message-State: AFuF++nEQJMJfARk9u+cgWjP+tCbv/oWqX5fB6XtOOUCqWVT4ew0amTQ
	DH5HKlH9OBf+2pnGUVO7Fu5PPfWirQSYhZy9heBHxxW8U9PdMfonw6wHcd0St57qtz7PIEkQCYQ
	ExhxEmsGfvABu5g9w8meyaqJv5P835Ds=
X-Gm-Gg: AYBFou34cK+DKzLk9e7peT1zMOqnBCXi7GFmBVwDdPdW6XAMQX0l6FDjzQECjEDfNQW
	y4fbNSRWafNYiucs1uoKudioPGPlFFU0xtG9K2yzKNDU8RUWczUeIkbQMWAixVtGsofM4Jkzw2V
	Fxm4QRFXiFMbyzZvnNCCJYMVCuKWUc3lkV9iDncn1hvSQC3qv3hk2YR91Z0ceS1yMqA8AXHPc0q
	UI9tjxpYJpf/uR0lfKmn0XwiR9RuA8kegOTwns/x08NOweF/sxH3IhjZcved+ojTGFrarG6RS6U
	tDsAqda5IXpaqnb0cx5WC3w7BH0oIPScmnz+9CSyht0yocGV4UtmVtdQmFBKoUD7dkqUF9bdQyO
	DOUZEZ6+8psenUw3TH8inxpR3Ut5hIx0xx2nb+XkOV6NAKuO2fEkCGUs=
X-Received: by 2002:a05:651c:a189:b0:3a5:eacf:9811 with SMTP id
 38308e7fff4ca-3a624d70958mr9639501fa.14.1790124585416; Tue, 22 Sep 2026
 17:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921235951.3214-2-sigefriedhyy@gmail.com> <179012274833.2160803.6278526272510624940@kernel.org>
In-Reply-To: <179012274833.2160803.6278526272510624940@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Wed, 23 Sep 2026 09:49:34 +0900
X-Gm-Features: AcwNN1XrOYM44dDQqYS22hhW-LuVc39KJdo7O2ULglxGQeLxCAP5lFJTK_NObdY
Message-ID: <CA+7S2vJ_Wq+_BrZ31qWnDFMowZdo2wR0THrZ-qkgFD1dMQoH-g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/4] netlink: specs: rt-addr: fix the type of target-netnsid
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dsahern@kernel.org, 
	donald.hunter@gmail.com, edumazet@google.com, idosch@nvidia.com, 
	jacob.e.keller@intel.com, kuba@kernel.org, kuniyu@google.com, 
	nicolas.dichtel@6wind.com, nickgarlis@gmail.com, pabeni@redhat.com, 
	sd@queasysnail.net, shuah@kernel.org, horms@kernel.org, sdf.kernel@gmail.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 9:19=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
> [Severity: Low]
> This isn't a bug in the change itself, but should this carry a Fixes: tag=
?
>
> The spec has been shipped with the wrong type, and the generated ynl code=
 and
> the Python decoder have been treating the netns ID as an opaque byte blob=
,
> with the request path rejecting an integer for a binary attribute.  The
> kernel side has always declared it signed 32-bit:
>
> net/ipv4/devinet.c:ifa_ipv4_policy:
>         [IFA_TARGET_NETNSID]    =3D { .type =3D NLA_S32 },
>
> with nla_put_s32() on the emit side and nla_get_s32() on the parse side i=
n
> net/ipv6/addrconf.c.
>
> git blame on the pre-patch tree attributes the type: binary line in
> Documentation/netlink/specs/rt-addr.yaml to:
>
>   dfb0f7d9d97956 ("doc/netlink: Add spec for rt addr messages")
>
> so would adding
>
>   Fixes: dfb0f7d9d979 ("doc/netlink: Add spec for rt addr messages")
>
> help backport tooling and users identify which releases carry the wrong
> type?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260921235951.3214-1-sigefriedhyy%40gmail.com

This issue has been discussed in a previous review comment before, we
want to keep this patch target net-next without the Fixes tag.
