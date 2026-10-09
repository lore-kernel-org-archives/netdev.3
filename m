Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33CE3DAAAF
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791585237; cv=pass; b=hqKmvu5pAPsH4eeBYgf8b6QUQRkL3Ka7S2njGMfLUa1SVMv/xQ104r8AvVTicfBfJdi83zqApozaL3Syz4Gjmbfp1PpCVyWP/mPqWjD3WfsjZgPCVXuCoFShyLvRa9lN/s+3X5NpaQPTP39OTQQJwMQ/FX1mvymlx+XnKlsq/80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791585237; c=relaxed/simple;
	bh=9quX5CnvIgOd2bqETq3nY4+kaqua2/tRKQhSxS2Xq3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e07qca/v4+ALlCYDiBakZYG1sfiJJjyXhfiQy+hYj0A0iKajZcSUb2mihkH3B7K8hMzCgrm2+auiVvoXhBbnoWW4Tv9MBHw3PXG+s6D7EYsRomMOGjGo9W1fXyIFLiK2e6Q8NFZ4SEQtNJnlNQHZCZMCFTHyWTaM2jZ3EuDMo+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TD/ymqd2; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD/ymqd2"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c2e2db5e8e4so56765666b.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 15:33:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791585234; cv=none;
        d=google.com; s=arc-20260327;
        b=J6MFuCLwSRZjm2AyNyrY89uYEtizUBQ/rA2ekLZ+PB6QLIFW5GWuyb1aelb7c3+cbq
         UPQRI4GVf4C2IoFRI6r31Cg9aIpNcwYJANC4384nQcrQdOFy4Q1KiXo8JbAUufQjxX0y
         zvBH+n3W0PSei20wV37sZpn3jqs2vNyD8LgxrdBHS1pcM91N4fmpCsiZhu7wRMRq/7lK
         V70dsKQBwCgxcZ4NQA1vw5A+jcEElkZAwscIgt/laaIuoykuc8hpl2LK8ReiNi+oNn38
         bMOdsv/2Auvp9/R5B8OsVCdECwAIoi8wSb5rLaoMwzcgg/V4tRvq+hhT76xxqwFCods9
         l4UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y2x5f8OW9Jzw5234KyE0CilJDEpfG7QLEYaTd+TOUYw=;
        fh=uA/gQDxeH5EXosqVQ99q9VpcrtUYliT6RHyDBlZM7J8=;
        b=mKkMCvAp6fYKYqNYwxRpFXIx9zuvRjclXgiWeT8WIvmG0DvQ3zRSDUDbWR7LmMkgWa
         btffmv9imIR9zsnYAqL08sRJeLIWVVltZY4gAjpOcfOOM0dZgN8gFnO7mQIq2FdITC0E
         fGY65OMfciOpr952T30JXZ5BCREXeuXdyWre4zpfFCt5IdW6RVv8dYmd1MWM5YA68RaO
         8VLSBrF+b5y5ccWmpCA2u5hlUXPfZ+gk0sjn/VKeQGavRrnWLY7WZrIQk1/5TABJyNxQ
         X+033BOlWXq2vORL1XpTVnJO+m7G/QtmBe36qSYEgmIwAYSEupOGYGMQeZ2OC6oacDbc
         9T9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791585234; x=1792190034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y2x5f8OW9Jzw5234KyE0CilJDEpfG7QLEYaTd+TOUYw=;
        b=TD/ymqd2VZsqvzs84kGAYMrXgiIsi0tA/PegsHu60frn/DOT1ctF+MiMGTsbyQcTYD
         kQLVASiSGlEMPvWB15cd5iUyNzTfQZlopj4Y7NmufQsK2RrX3CFxQYf52BKSHodzesEu
         fADYmaEg0us2ZEJ0fDS0jp6WlgwgxBHbZCIWMKicO/QiMbNSS4KWjQYZGbomk0PTNWQh
         s+MTM1qFHBgs7uBmGGHLKLRX6rbN1EEvAxcHMRxZ7f8bKEGht1J17tKRdFBi0Qi9SxpD
         vCu6OLUG/PcLRS/FPHqqBDsRK3k4F1BW8hvgfMjdX9M39G1RUrD7yIs3hqGq/Lmi4agJ
         tW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791585234; x=1792190034;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y2x5f8OW9Jzw5234KyE0CilJDEpfG7QLEYaTd+TOUYw=;
        b=fCxC3g+j5xT2Dohd9mVLSbXtxOQUqQj9/BnSRf9FsJLfrDBFaQ89I+4h+w/b3iW7P4
         Pie4mmlWc0kR2GQkVy5GH+QM4S2xuwGHRf2JLOVqlZMzb9lLTN0hpb05+OWGHycXcCeP
         v7Pi88+xxNOU2gkf/xIJz8+gEOTTZYnS9Km0jOaMrZCa3OSKXxrGqpPQ8v3x80KI9am+
         XFG1XhsxX5Kq+6fRNu5XWGWTaOVxuqoiBmQW7Vk90f6lONhKxsX/RobNmH/pjEWkti1O
         YtSH/0wlQ1yzjXBogEIoz/xSniy+UYh3J0XKk8eQ6XHvIy0IGUQchMlS4XaD8UB7K+3s
         qy0A==
X-Gm-Message-State: AFq9FYKLlHVtEuIMwi7R1kYdIUVDdbBVtCMrYv99cX0DnX6m0SI92uFz
	dzQg4mOGtcZYd2NQulMW4RCr3auxo1RWE6Gc+ZDFV7xIOETU5mD19a+EJ4sUHmo7EUmBqfE1lCp
	kPCFX3CBvb+DDbQM2/EyUev51jJ9fb8g6xr36nwk=
X-Gm-Gg: AYBFou3qqaNjVHZAqhaaOBrVAICLgZMOuojRtRgP6Pbg8mtyIRie60kVtX3xPKvbFSf
	OId35MHVw6+5amtfuA1fXwfKtgH4+isgWQGotl3rpBRqYtXgBTBpRVXWhEC5CgYWY/fBu3Si3Vw
	VNo1dCOomIlb+PF/SXZItP3hgIpD2wueVpf0rojTKtJS8SLJqCEonRisQc2XUI+DKxx2cHe9Ckm
	XlpNE/O4YC0AJ/ysooyRaFtH7Zh2Z8By4qQCncjMsyMgiQ2eCd2daSI9VlTzHL1wuqFzvXuyxj/
	2UnTQ0qqYIGDq4EcNXqBVnHI3EsvwEKRlYLZhe8bq3EkMNEeb6AxftJepW28DlFFUvJWXTu9yFZ
	ZYQSOWZU+9ZhAHKdeSsl2s1dbaVGL9JYba/7rxdilJn8BJI9oORQ7n2eEC2jAOeF+8ScSlil6/Q
	Lrv7PPn7wEZNIjQ4OglG4gqnU2/Rq8cdSWpFFgxj+0dirFA4eFVOcujEe/MBonpf+DF3lwTPKq6
	cOv
X-Received: by 2002:a17:907:3f87:b0:c2e:2e1b:30e3 with SMTP id
 a640c23a62f3a-c31aa00e12fmr387733666b.21.1791585233913; Fri, 09 Oct 2026
 15:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007174449.671416-1-rosenp@gmail.com> <20261009164732.GG83879@horms.kernel.org>
 <CAKxU2N_=H=D0p=g0XBqFtJFHDpidO-5d7P1kKZxXEDX86BGnPw@mail.gmail.com>
In-Reply-To: <CAKxU2N_=H=D0p=g0XBqFtJFHDpidO-5d7P1kKZxXEDX86BGnPw@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 9 Oct 2026 15:33:42 -0700
X-Gm-Features: AclHuK--vcR19Q4c1HmMxBuosb_aBRVRtTK0Kor0FuyXWmfdeo3iVtKqvmIrSjw
Message-ID: <CAKxU2N8svLRziH_AYKMVdL0t-ndUfxSGO+=ftekFG0KQFsXVZQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ag71xx: align the IP header behind DSA tags
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Chris Snook <chris.snook@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 3:27=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrote=
:
>
> On Fri, Oct 9, 2026 at 9:47=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
> >
> > On Wed, Oct 07, 2026 at 10:44:49AM -0700, Rosen Penev wrote:
> > > The receive buffer offset includes NET_IP_ALIGN to get the IP header
> > > aligned behind a 14 byte Ethernet header. Most ag71xx devices use DSA
> > > switches whose tag sits in front of the EtherType, which moves the IP
> > > header by another 2 bytes. Every access to the IP and TCP headers the=
n
> > > traps and gets emulated by the unaligned access handler, around 6 tim=
es
> > > per forwarded frame.
> > >
> > > Take the headroom needed by the DSA tagger into account when choosing
> > > the offset.
> > >
> > > TP-Link Archer C7 v2 (qca8k), median of 3 runs, Mbit/s:
> > >
> > >                        before   after
> > >   routed up               743     855
> > >   routed down             660     749
> > >   local receive           554     572
> > >
> > > The unaligned instruction counter no longer moves while forwarding.
> > >
> > > Assisted-by: LLM
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >
> > Unfortunately this patch did not apply cleanly to net-next at the time =
it
> > was posted, so our CI did not run.
> It appears I was careless and sent it ahead of local commits. Will resend=
.
I see the issue

A different patch removes the comment:

For our NAPI weight bigger does *NOT* mean better - it means more

so git am fails but git apply works.
> >
> > Please rebase and repost.
> >
> > --
> > pw-bot: changes-requested
