Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B15543635D
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079926; cv=pass; b=CaIWx5bEdGJeH0SHNoINs04hz0S27PnySLmPOsiC/MOr4FoHvZqQfw4lQORulEGUVVXkgCq1O4VaJI6ERuBEkWC+MEAjrzFRxvr/4Ac3nytJ2uRIbL9wu3vaysQ6eE+l/fr+2XVFRCkkIIjsRvywWOmdxT69Lnq0WTec51+RwBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079926; c=relaxed/simple;
	bh=SFtccoLb3l9zc2iIxLNfr+pNo9wHAKwDYS1fN9NT/n0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUPBSaI15vHCSZNoFxagZRE/sosxhfchmIS07L3DZUJhLpXer1R+6W7Qh48/UucO+rGkECawy2wfYArS5r19GELo0BFm7LqK4piXG8Jxmn6qSrOEfud2lXMrkeNilYMEwSuoscf8lb5rG+WujY3SXWzuxBCVq1GZPaf0DF5geto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boE/AcGw; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boE/AcGw"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-65c3ea2ebf7so14898379d50.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 11:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780079924; cv=none;
        d=google.com; s=arc-20240605;
        b=HOwLpaSOsgbQFWsXpQlkS6+VCGYSh2wUjsB7pDLhKcVBgwc+Z3E/39LP4XqWKkmF2V
         s1/Oid/hMq0+Ntzej6Yt5CL17VeSaaw7JS/ebGYPhhqmnxQ+cKTgzTqXUjvv4bX7VWJc
         NcrH3Kz2hxMB365bYM7qtv4PmZ90XHSX1FZu4gDxiVrQz1RyG/EGK/UfKDDhqgp2JHqC
         upfsAUHLOv+Mb0401o9ssocn/Jv3ghcs/wS6sG0etJSLOoqIVNGMCZ4EqGXhuU6s6fQi
         OyzjSviceK+RrI1I+/VQckz0dk0UUVQ3JDqEkCt00+G7w75g3FsVb93JwP3F4WoWJBxe
         9bNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SFtccoLb3l9zc2iIxLNfr+pNo9wHAKwDYS1fN9NT/n0=;
        fh=Ja9R9YnDVOOrATnCUhvLSCnNDxuh8gQNNY1ngMLv+HI=;
        b=L+ocDYt1fT0DDbFfBKF6jPNuGPqztKbr62AoKuGLfTnpY3U+69kHm8CpJU4ggviaGj
         mUjTBzb4EaI0xhh0fmiT7NtieA6Pp8howyML8+4dIOPWXyldO++4RAlqqYIemY0dMs5w
         VnbQF/uJlgVyMIfgfdta67mfgkpFiDRE8BjbzzqOZOZuFCP1AXA3804tHECtU60tFUu9
         6NQqf9a/yOEZRFdMK3w0A4C0AKa2J7FSYmbhJbQ2cSnMtrbSwD3A4DHY2ZnQBmd4bKis
         jTp21yaGCeVKCKjsMV7fc0Iw74WLeWqRdz7APx4yp3Zb/O6uMh93UEiycA7qX4z3VYBb
         QLbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780079924; x=1780684724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFtccoLb3l9zc2iIxLNfr+pNo9wHAKwDYS1fN9NT/n0=;
        b=boE/AcGwrQM5pVw17c9WBg0ymtKMRopTtyTccyycGhT0VKwuKWGNjWSEGfeUlAnpHl
         Fqu8Eg5sjBSQiOzg+YGzT0uPw8t8qpjW1fwxNf70K70DcjzO5AgAXwfIkkSuROioYiwm
         M0J354rgdJHUa2IhsCdJ5ir+0dJ82dyYAMMpNwvvVedOvRNnjq+oQtkL8nnPscukFUjx
         r0s1ZhSyJNyrL+cc4tgDppszmklgWEOTsIylb949Wc+WlN2aPYTR3pH5VFRCW3ygYJuz
         QnDgP3fs4ukZyA9x9t3D+AiEXooLIsCv4L5VsJ5TwxGaVpmclIvYYwRBkAXCMQA6Awxs
         0rtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079924; x=1780684724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SFtccoLb3l9zc2iIxLNfr+pNo9wHAKwDYS1fN9NT/n0=;
        b=eEDyLU5O0ylPC9SRRZYxVoLwA9LhBFaTNOxCKi08LqT130f2eAcm+EoACvLtuiVoUf
         8OzpibGaXDcexau6iGOOaFi8wLrfQ/nQhD+4ecVW2IMqj/tstwpyJR9lr4oLUptD2lZp
         VVXEG+YGSuzSOHyozk7qbQATMuIdrgWX55w6yQu9/tAK6DB/PU+wNYLXDyApVQdmsuaJ
         p4N27FEsr04ade+ePTmnImgw/ZpjiqweH1Jq5lfRsFaCOOwzmIrdGHx8FTZDy3MYJGLo
         0auQ4fUK5ZTcscsVB7sdkvKHs+U44ERlM56B0Ia2O4bEBwPAJbfWaX0NVRgbAN5vD5w8
         NjIg==
X-Forwarded-Encrypted: i=1; AFNElJ8sbhg6JIunz4ndtzQ0hNZw281Rm/vuxSIrzCpBDetImrRfw/6ER0Nnx0aKYB4zhXn8NBd8Fvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyywtoQ5p4TdUsENxOMuTFqOIHIg0rod+olTuj4xjXzEXlic6IZ
	zUIbsmuxRvkjt+7x1+1C/cXlQO4fxBdJSnDy8J6KZRrE1lm3QoXrGAN/zRq2KI8eGc+/YgxZ8qT
	kUHTJWIzaznUJZAQWg/llHfLBme+mdnk=
X-Gm-Gg: Acq92OEcWoouLKyn0gDmNdchI70ZAb0sk3dSFMEm26TlpHJPegIs+PL/Av6OPn28AZy
	ZyWRwnuncEk6xQMZA5B53mCIq+vmSG1moO2T28hRaGcVPwcjS4VHV4wHducVsfYdKOWlGJ1rcPX
	3VHkAL1dIsVW3frQFPCKSx5ttUW3d39qu1QSBETWupixr4BM9j3BT+Ta4N0ZZgAQ1YmoWn+WPry
	XyyJ8tp8cAYWXqP6jr07OjJygEvnvgG2FL9q7i3qWX8R4jFgRuwcpo9yMvgZTSBBPrmRkX35cx6
	m+GFLjWfTu9W0fFcIrbTpM9Qh2ILNLOR9pG/qzzW0CDyIQ95IEkhq0RCvKsN7bvnlBH+5gxvpdj
	LuQ==
X-Received: by 2002:a05:690e:2547:b0:651:c160:1c06 with SMTP id
 956f58d0204a3-6605f17dc1cmr558121d50.58.1780079923810; Fri, 29 May 2026
 11:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528131839.462344-1-luiz.dentz@gmail.com> <46c6541e-9cd3-43f6-94d5-baac7b3fe7ad@redhat.com>
 <CABBYNZJjCVRp-00vA29nZahxOWYkCE03TnX=3-QWR7jzwx4mww@mail.gmail.com>
 <de887211-1005-43cf-b1d3-ddf1a82c283e@redhat.com> <20260529112024.2c0d2c51@kernel.org>
In-Reply-To: <20260529112024.2c0d2c51@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 29 May 2026 14:38:31 -0400
X-Gm-Features: AVHnY4JUj9gksxceVt0oHOCDSlEf9H8CdV4f4Gokr-amuunhelnWFcgboTNYuNY
Message-ID: <CABBYNZLKtrKZVhXOQz3Mq0joY-jXTBRk1bHGTps83v1M4FXX2A@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-05-28
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Fri, May 29, 2026 at 2:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 29 May 2026 09:35:20 +0200 Paolo Abeni wrote:
> > Even multiple PRs per week makes sense to me, if the average size is
> > still significant. I'm not sure about others maintainers opinion, pleas=
e
> > don't take my last statement as "a please go ahead with this" before
> > more acks.
>
> That's a pretty costly fix. It takes me ~3h to generate the PR I suspect
> it takes you similar amount of time. So it's not going to help the
> patch review queue if we waste time generating multiple PRs.
>
> Luiz, simply run this bash script before you send the PR:
>
> github.com/linux-netdev/nipa/blob/master/tests/patch/verify_signedoff/ver=
ify_signedoff.sh
>
> it's not the first time you're missing SoBs

Ive already integrated it our CI:

https://github.com/bluez/action-ci/commit/c1b86bca7cacc936bea82b3ca8b2ee4b4=
fcb6e74
https://github.com/bluez/bluetooth-next/pull/257/checks?check_run_id=3D7855=
9358818

I might be missing a local hook though, in this case it seems my SoB
was missing, maybe I could configure git am to always adds SoBs, that
said we don't use that on userspace portion of the stack.

--=20
Luiz Augusto von Dentz
