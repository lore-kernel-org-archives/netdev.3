Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164EC3F107E
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792352854; cv=pass; b=aCt5PkzoZvKTjiMsc6j3jKa1u3/XuFAb1nIU62VS/IimTSeQpPH5YzBr1F6o0vIkkQjxTjp1mnKFGeeVkSHncsWD2sfa0XkPMMDy6elgXt7RCuVryKF4KcxvVCXpKYtN8lvk4GqfHzIDh08eU9ico/RUxivLGcc2du1wPvv68tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792352854; c=relaxed/simple;
	bh=uSwsGj7z13o5NrJE21iC68UKNr7h5yOq6P5JpP5TNDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/bcSyPxt62NLdYBfJgzcN7Hs7joe6LqFodeTjNaqnt3EZInXyI1THVLOYPUr7biJJxJfcnjKV0Nj1MblfAU1JzvswmXCPVAon0TX29Bk3+iEV1XvNNPdjTi5L3Pry8zuEtjQimIhB6Qp1WXWQLMO0ejdy64I0y0/NaBhxTiDaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=U61hr0Px; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="U61hr0Px"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3a9787a156eso10101751fa.3
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 12:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792352851; cv=none;
        d=google.com; s=arc-20260327;
        b=CjYC/6/ZGgSTx/HNYg0uIcL549Cdn6BF4TRJSbLf/trH4BjKNhHKeUpBHQ7xGrbto8
         9IETaMZ3/RN070HZYJanvT1+ZE0PRdDcnLKmAcVFIhZThXsUe09IOatRAkC/G9mgBxFQ
         6q1OeN8PhCIh2XTEv5GcwsfVXa1/JA/0uAfFc9VfvGG6Hbx1eyjEmHEUtIepMn0U3ws1
         DkHYYH+pDM5Q8BUbh7YWL+6Ig9utu77LFvLeYhin42+C77CX9BOKjO461oGsWpCVkc7d
         O8XhJJyKUTaVWYdR2flSKEtZF+dD87YvKV788mhUyjpR6At3uUuRnbWfRykq/LlbEkM4
         1evg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C9PTaRCgfnWLejuxwMwgHezQmSpb/Q49pSzLQ94ksTk=;
        fh=G/9PMRGLA1V0K6bOjBxQtcxBBNbOVSypMNpYiaHDPlY=;
        b=ipTAacxXFzu4usFqJxDb5kTD0BJEe9b5fIeWDKee5DA3Pt/R+S//PqgyClKYhIEiUY
         tS2UvozaNRwRAL6KnCyN/PDQsfeT8TOQWFrVmvz7B1vws2YiFJS3/AWPte3CnUYBA62z
         AQent7JZFlfwUjuZCivaWuwV92pgsr9hUCwsG1ogisdOxOCMWbdE9JFrys6EHQAO0mxS
         /6wI0uyIghzH89NI268+q/H+t/ReyLeBdlvAuRhlBm1wqbGiuBtTC5zwpfg+W2Y9q0/m
         3VVxL+EovvWVMwIE9U/d2bmXvRh7LQM0PZRwn2atN5yciL/TzkCz5kT188wOzLBwlPnN
         ZGhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1792352851; x=1792957651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C9PTaRCgfnWLejuxwMwgHezQmSpb/Q49pSzLQ94ksTk=;
        b=U61hr0PxGjsekFN/Peus8SSvsCkWL+X4cEShlWPsXJwFZsPSOlvUCsybYg9BgwgJRd
         4XnxIJgNM2UxnPRJ7LJ9ePNZaMA3S+v2khZQd28a3QJuiBcuUaNEpSAyegrHLGxeAQOF
         XWhhz9z4gvoj1jD71wUdmMg7TKUgBLlQEbfCfdSDreL0vc42Gwa+0w9MuT0mJeW9FjHk
         InbXbqmJqWqFBCaE7bhMzpyoImihsnstJokhn5vCptf2p7cb0uxL1CtKsrsoOoa51lXm
         tyklrtgAN7N7S853vG7iCSHElYqHLPGyLpCn9vrAZ76I1HHBL84qCv0LlLe1GVF1/qq2
         6Adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792352851; x=1792957651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9PTaRCgfnWLejuxwMwgHezQmSpb/Q49pSzLQ94ksTk=;
        b=qKlXfiUxvHnRztTlRW//aAU3M6atg4yIjrDxtc57Lx4rdaTyRQk2ihs5eumlrNpJuW
         uW6vy6dIKm8GOc59z3gdsQlH6btQ/rvelyTxplrYHjR9mbE9VJl2ZNs3hBx61SMcd3WN
         vzYDI0ZOQiZGV9hnJgmZYFdTivacl42OiTrrYmd77iO+4z7rkC0jCbZew9KNt4t8h/uu
         eA7AX/7wCkhh1ZgD/2Zv0edGJ7Ulo5akLDj1QSi3k7mvTnFW5vn8deamjRulEIGH3KdI
         LkDoG6Bln8sLJVLyNDUjARPty0mfWPzIN39rdSb1oQ/DnK6mjqNYR7mEQ1iGfXGDsvGV
         8wyw==
X-Forwarded-Encrypted: i=1; AKwUvBz2/UBHGHymCUnnPUGHxEnxTyqcnBPhBF5zVlNyY6NlsZttlIZMEUjt0aJXfZbetnkUbRqswyo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPD9Dro5nNQX6t1KLILC9Atk8LXaU07x84VvWFNGaKlxgYtge6
	OQRXiGeV3n+SjzMduy6KuN8/XIL8aTqEUe4762xSU7YQSEaoCBXkNUicyHBm+j4DcRxmScE9wkQ
	aVzJ9pgj4MpmjgGLnJz12VLqkPdZYREIHqLC4G4pN
X-Gm-Gg: AYBFou17J5eAT+C1kmofaVw9aF2RS2Qbafn1eHY5EFlIbBKK+k71MeERj4k9RouVaeW
	tekx6asb6UB/YzjH0PJRqhlxJoOzhLs7+h8mlMglyHYvHJVxr4W/PVGB8bwtB28oWxpfNsdaq47
	/wxiKOBlhub1wb0XNn8EkkzZsFCOc1dTvvf49X6Gqakt12HqNkivUylnRDqfk2fjCMdmhMNb4ZC
	IOG+3ZJMsE2cTsNmjZt4dc3w0oYvZPLCJd9SE1GO4J4bKgCikp9sbLChgDaeX+9OZPn+vhA/cuS
	hAByjEQDBSmEtqPSWeVg4IGS1DwR/XSnUIsS6fl/MiGY/D9YJ901
X-Received: by 2002:a05:651c:3614:b0:3ab:1639:9a79 with SMTP id
 38308e7fff4ca-3ab292b7375mr9897881fa.15.1792352851051; Sun, 18 Oct 2026
 12:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1792346472.git.jan.koester@gmx.net> <9c17a1f7f82b953e6f4d9e17f4ca19d5220d7f2b.1792346472.git.jan.koester@gmx.net>
In-Reply-To: <9c17a1f7f82b953e6f4d9e17f4ca19d5220d7f2b.1792346472.git.jan.koester@gmx.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 18 Oct 2026 12:47:19 -0700
X-Gm-Features: AclHuK_TjVvADO7YV_Of3nNvklGJn7yisT4mnRNh7189wUPwvl6Zlkl0ZNpg8pA
Message-ID: <CALCETrUjRpHSTBzO65uU-YaEj4espqnwDSaSLcXu653xJyooHg@mail.gmail.com>
Subject: Re: [RFC PATCH 09/41] uidgid: let kuid_t and kgid_t hold a UUID or a GUID
To: Jan Koester <jan.koester@gmx.net>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, 
	audit@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 11:10=E2=80=AFAM Jan Koester <jan.koester@gmx.net> =
wrote:
>
> Make kuid_t and kgid_t (and vfsuid_t and vfsgid_t, which share their
> layout) tagged unions: a classic 32 bit id, an RFC 9562 UUID, or a
> Microsoft GUID. KID_LEGACY is 0, so zeroed memory still holds the root
> ids, and KUIDT_INIT()/KGIDT_INIT() keep building classic ids, so the
> bulk of the kernel needs no change. The member is renamed from val to
> legacy so the compiler finds code that peeks at it directly.
>
> Semantics of the new ids:
>
> - They are not in any uid_map or gid_map: they exist in the initial
>   user namespace only. kuid_has_mapping() is false for them in every
>   other namespace, so no capability in a child namespace gives
>   privilege over them, and from_kuid() and friends give -1 (the
>   overflow id when munged), exactly as for any other id without a
>   mapping. Anything that can only store or report a 32 bit id thereby
>   already treats them safely.

Why?

>
> - Idmapped mounts map classic ids; UUIDs and GUIDs pass through them
>   unchanged, as long as the filesystem itself is in the initial user
>   namespace.

Okay, so they pass through but don't work.  Sounds unfortunate.

> +/* Like kuid_t and kgid_t: a classic id, a UUID or a GUID */
>  typedef struct {
> -       uid_t val;
> +       u32 type;
> +       union {
> +               uid_t legacy;

Linux is Linux.  small numerical uids are not "legacy".

> +               uuid_t uuid;
> +               guid_t guid;

I'm at a complete loss.  Is guid is only unique on Earth but uuid
unique in the entire universe?  Even Microsoft admits that GUID and
UUID are two names for the same thing.

I realize that Microsoft colossally screwed up years ago with their
little endian uuid idea, and I sincerely hope that this is not some
endian thing.
