Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4737935F191
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781344166; cv=pass; b=peQf5bpPPORr475FiQQUdmFqcHAYYQiXvqz84lWX4HjnyKn+GDV4fHD5P8ltJcW7uDTVIRV1RDhesXmI8+LIcpHHa3R/GvW0HQT6C5HXEJNrtmQD2cpLUBc8wMfv7YcoLp6+ChCmGNKRXXnlLDyi+8Za/d+V3AdBX9s8gBtP8yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781344166; c=relaxed/simple;
	bh=N+BOVUokZvEKxogb7woXjEf8tUSXjSp7mQH0tyGXKLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzCirn7ztYKznj3dwc6xV0t67IRV++KSfX5ISmwGTJ6QxRI7ulYHaTj/HPfSC2um+1YQPt/tO71SG4f0sLy5uEKM76X0iSs4FWPwopVuEldfHHdDb49b+fmIq53CHjdyvjw1467v0jDVs+5m6KUgu+hJKeMTRugIH0qxoYUTH4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFLAiA0u; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFLAiA0u"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3042a99f0ceso251923eec.0
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 02:49:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781344164; cv=none;
        d=google.com; s=arc-20240605;
        b=DH8I6N2Yey8eJ3glsoKurzUcBe4YaPM4XmfHW1DcijWjK3dl7Qm0Z1lZ1aM5vPl/Z8
         xkwm0tvnlp6x5PEINEprYIY6tdRfQdvebUwFuM2RTyZ/Ps830kcl6htV+nxH3otKRMeF
         U2TZf6K6YMlhTECItRjavBomV0IVp7aUTUPhj023VdUXf8ea99CDXnj1uiHY3kUps4IL
         CXKe8FvtuhF8kKMGxWwewBhSbkgWheV5ytSwf/KgWgv7ZcfH/QMikSM+2Gh3sB6kLkVS
         HYRhbBeo7lEfaUB1eFnQdu1KwUGYvpgXihr1M5g9ZLWBpJIJZ0hezBQI/s1+ImFOMwwk
         yWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OkM4+eHaDUAb02aEnfu5B6pMfFHeevNTKhJz3xUQyG8=;
        fh=bveYhkwrcsChIZrXDPa+QKcSAV7DhkG0oE6r03NtisA=;
        b=HTj1crB/z2cfDa2gTfeqbkOw6z7uJaTg/5iyrxvPyPqbAkQG4Hqh+gd72uN189836I
         URvwnTcCghFpwJKDEYQT4xmPpPb52brM7ESiygyFZ0lXIpKK+Tn7t5u9iRZQ6aKiLB+e
         VpggWqYa6MD6h91St84bH3yH5egBRYrPgm7fGuS/MOc00HG83ItdUa5YyvC1/MYx3j0U
         uy5G3tknm11ly1xCSAeL6KadA0bDUT4I9ayUwQa9Nk9g73uJXH2W2kHIz9CzleNjVz/P
         nj/av8KKCbGESujC1YsTXKUF/Gt5N+UP5jJLuz7lQlK4i09xhrAb3ptTitOxB+7iVtVI
         sNzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781344164; x=1781948964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkM4+eHaDUAb02aEnfu5B6pMfFHeevNTKhJz3xUQyG8=;
        b=aFLAiA0ugGg00liGLh5iuyumERkQ5p2AJy8FxSZatEWdGhqba8Ux6DHYO+1mDOOagx
         TOV5UWC/HfXcBBfrdd8q6riZW69HykzJN+eXia64Ay6+wo4j7Fymlm7MfI1ztk4WYgUH
         gekntzdeyIX4pQfrlbnsFtAdCenB8VaCWntDyd9uwUcjEvNQ61+gp++UTpizymDg62RK
         EWfVUWatdwGiBMtVcAsc/5nx6M17COI5UlXWPCWXTo6T/NA4L17wiSOBLfvyJJT55Qb3
         biN4lsfnI1ZTreTNE2IEKAJAcSG+ntsX7nLcCpBpaZyAzPxPrjmf1IkAJ/5z5FZr534r
         OQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781344164; x=1781948964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OkM4+eHaDUAb02aEnfu5B6pMfFHeevNTKhJz3xUQyG8=;
        b=eUgTxtQbz7JPWiDGe/p/opND7uJ6Z30NoznZ8pM16SBj5H1i97VLdMC27erSvBYnUw
         UXE2qdEOgi6AQSEJoI0vVtMq7mpT+gr2Wqgg5x48MVXMMmI4eGBvM4G4i5m/v9aOZyZg
         fGfW4dzaWF3Kx/bUtUAbyJ7LZHv6xHhmmTMgMkkX/jqT6CU6pXjY/kyEjxOlnv0cV88/
         3htaAiWzrQXJ4tty90Mmui5PW3TqBWfQLkca0yn1ZxCaMR5SnaltwRhQ7eak13eb9EC0
         Zz/sCkZTSe3KXEn3UxkQUoN685GNRH71wyeEYfpA0b8W8Oib1E6owU8yx1nii1RVz/Vr
         B7Cg==
X-Forwarded-Encrypted: i=1; AFNElJ8P6viRWs53yPvufLnQz1shq5qXYb496oRNuNm3KYL7SyTJz5vUJEEHBRRpMjwC46syr3f4rEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya0BneL4xb6nSoUKKD+mUyk61oz1w3R4zcpS+E6/7TZPNHX6b4
	3A1JqxzVMmnerxEFa4JFT/9Cv9/GmZr8+CCS6pr5jzMrfq7iAkxNAnsDfNisMAIRMaT9EaP4amq
	M7aqHgQn92Oy38RzBMGyggGl/FRO5OBFGCt5gQD0=
X-Gm-Gg: Acq92OGv4vk0dGfZUYAyAeJz35jaxI+ZEKFQtmehRtoPfQwYZbyJNfZ3xeyFr90Ts+G
	fcOU28VgTu1/weJIiCgMEif0Zl/5Bl0VdLD8/ZsI/AZhTGRhd39RorU1UqNKXh1UDHfZoryK7T1
	o/NCLpaFelWdR3cNHjKxQXNaudbAqldeDNbHqTZ55HGsekVh9avjtqF74hdDCTj1+dEazNrhDzA
	IoPg9WbYQNsJZio0iezCOgB3ZCfE3BPJNQ1mrtsuL6vDrvyjHe/ZP7EVN1yFcyYUeWvN/ydAnVO
	uS81/GAGysuZ3m19U8VT5tEnJ8ElJDDPR7w078Aa7EMHMsJEIMOLxmABRPwEN9MN5URAZMTHxyG
	P7U+gp2jHaw3cvc4ptGyDNmk=
X-Received: by 2002:a05:7300:730f:b0:307:2e1c:17ed with SMTP id
 5a478bee46e88-308200d09dcmr1479282eec.7.1781344164338; Sat, 13 Jun 2026
 02:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DJ4Q5J5OILOX.1KCPFIVUFN2VV@garyguo.net> <20260610072947.338278-1-ojeda@kernel.org>
 <DJ5A6AM2FDGQ.19T1Y9N1T6JST@garyguo.net> <CANiq72khOCLC5kG5vWhDeXpHv6n7Yo9Nv=PewNS0D73AxUDB4Q@mail.gmail.com>
 <DJ65HZ2867HB.2ZK56NEAURVJO@garyguo.net>
In-Reply-To: <DJ65HZ2867HB.2ZK56NEAURVJO@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 13 Jun 2026 11:49:11 +0200
X-Gm-Features: AVVi8CdobUhfSP0GVHy-aYqTcvmFqhk07mdunfn978mPaEmklHiQcpFapjBPE1g
Message-ID: <CANiq72mhdy3i+X-9ZDiwe-mAYu9DX2B29dQQi=2iAYMS8JMzXg@mail.gmail.com>
Subject: Re: [PATCH v4] rust: make `build_assert` module the home of related macros
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, a.hindborg@kernel.org, acourbot@nvidia.com, 
	airlied@gmail.com, aliceryhl@google.com, bjorn3_gh@protonmail.com, 
	boqun@kernel.org, dakr@kernel.org, daniel.almeida@collabora.com, 
	dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev, 
	fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org, longman@redhat.com, 
	lossin@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	netdev@vger.kernel.org, nova-gpu@lists.linux.dev, peterz@infradead.org, 
	rust-for-linux@vger.kernel.org, simona@ffwll.ch, tamird@kernel.org, 
	tmgross@umich.edu, will@kernel.org, yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 1:50=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> > Good first issue?
>
> Agreed.

For future reference:

  https://github.com/Rust-for-Linux/linux/issues/1242

Cheers,
Miguel
