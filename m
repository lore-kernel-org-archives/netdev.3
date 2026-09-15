Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA92D0614
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499796; cv=pass; b=jNA//oSbwKXWIx48lGwps5nb11hkc2rU85NjwZBIuKehR8hUXSbqfmIGrTNPZ997dYMU3ZYjY86HdlDrUdf2SrOFgclgfvKPIDfbrVpY49js0ZRET1B5y8iU2+2rQGGZ3uu/vYlEQWhGc0qgs6dIepElUIZIHytvcZae+xXbIps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499796; c=relaxed/simple;
	bh=qXq/IP+wG35Y9ctxb4rJVIeyhdtgKyqMuYb9Sujr+40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqL78rdyyRbYTEUiKa428hXNbjIWig9sJE9d8XZvc+mcuJpFUVbK+IC353EaOSi7DLYdT+B3N+A6/+/kqvT/1ssD2kn7aeIT3xGMj76oGEZKasiiAIshJ6iVBWtDuzYaWExReiO/iDQW5SKQcSAFWJTa7p5D2sL/V+UbQDTGp3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfDyQnMz; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfDyQnMz"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d4ddd179eso995527b3.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:16:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789499793; cv=none;
        d=google.com; s=arc-20260327;
        b=mqqXg3eBLMeZ32RQE2GXrdhRch6NaUu53LJkSLn+z4NOcY48Gb72a59b/ABZmH1+w5
         zkmxPT7HbAsA5oyLHdZ1LCrwlc2cf3Gp4EOIQwr3uSkTa9FX+T6+SR/1/rA6BrnDaMfj
         zjGQTu3oR9/87SklUn/xpmbc2IXKWA0stT6HKBA6iRdZW5pvEe6OUieZIt1gESU8gAEf
         IVPvo2QZDPIqORCK5RkT/4KUddkd+HZwZYH/kTf2N0gOvVsUR3pu5+eYpZ+xZKs3BAfu
         Zhpq0pK9mpnkJYC4V53+FzphN4uN+tzhf417mnkz1bc4jMkXEQQhBaRCV4OhRErqrSrE
         WTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MpL80pv09E/LLYkePzuWDbqyU+RJlTYLhbM6+QzZG70=;
        fh=UseNx6jVRJozO/y2Z94V2HWUBbT4gal3vR03gquyA3k=;
        b=LmJFTGACki1Te1oqUgka4IVbfBc92/oZkLSZtmCYtfFLcSgnnumbAZ4Ddk3tl5KZ4c
         kX44oeV9b+IaI1DMAM43OSR64r6/AE+gUW4h6N+if3GK1KDS9s4fv2EFrVPlv2WPxprg
         WWKAzltFf7UdEUDYN2TPf1D9xLk/0p2yJLi48CVmc1aH/VOUEIAhYoIyythg2J2NBDA0
         rYjNJE6lD/IErGNvQe1mLk10TbsKhTgSrb4PcsAZpyI7SDHYOH9TxjPjYtA6Dx+Qtlr4
         DhnsOFN2EVVegZEBb1Nqx4Qr2TEmm915kyqIT0geFQQgPOMmjNaot7W/dEW2x+11TvLv
         1h5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789499793; x=1790104593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MpL80pv09E/LLYkePzuWDbqyU+RJlTYLhbM6+QzZG70=;
        b=QfDyQnMzmGz+Mlw6PX4HKxt4tiAOUu3O5677WF+zwkoeRVm7dT03Tsjydio+UXSCpP
         PxJq8rPHGA1G/9mc7/g/Y3ZjQoPMgu6fyEHEILkSsAdOBxMCAAm8h/bHANc/xMn0yM00
         ANWIwEUPHzxZOVQM5Ts46+LKempxbPsirsDaJIvThNtk7glFICD/c9ekqg7gjRoZKmxm
         a15dzVj2ujYbX/ynZkyO/qsYu+I6JLfmUJTJobbSwwGcUMdDkCAj7YptRVq8tc1rCITd
         WovgGlT/lbIFHuVRej4sww3jIAQTV6pRsemMENoeywKB3via6OAh/QH1fZC/Uxdp+Da1
         afsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789499793; x=1790104593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MpL80pv09E/LLYkePzuWDbqyU+RJlTYLhbM6+QzZG70=;
        b=jo/Ca5WA5up8QN2UkhMN89j1OXXYx7Qm/bY1kxMccDVQwf99G9gLCpvLEFdiOHdz7k
         dopzxwLWHt+xgpTb7e7Cca3omeX+PuA/IQoYGQOfuWTq4mkOdiyAr/tQYzzGOj+icxnY
         c3B1am2Vdoy2LAfg2uRG7tSoPiAFroBjNHkHVnLHsMkKz26P5R3cKdF5n4eNJWge9rkp
         ORHfv+x3VUy59Nr44flYUjPerYnJkiwmBK6RZKrz0exiM+fEhY1Nq/O7FB4rTfLdWgP3
         qdvY5iO8qDpKgMhlYJWU5bXlkoHIYfH+o8UiNxQfXKjsbQ3sgNolemdn5uSRxorRkzPS
         MibQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVHsHdTy61QV9Zfnh8qG+Xc9JHTHzw+zB2EgPR3ANR1SUyhKZ8wrvpSw0zbQmINWEoEEl6QDA=@vger.kernel.org
X-Gm-Message-State: AFuF++kjoOU0c+7Tmz1ImdKkih1O2V6PaVy1FFajR1JGJD8u+RwvyKpI
	HPqvfSduwUmfP/TAoagSBsjT2Iuo3QjutIlpJ4+oj4WH74/NL8vJv0WmHRyu2lNJrhTWOqjq/o+
	K7PP8iLpWS+klx8yt85HlFKkG4/esewg=
X-Gm-Gg: AYBFou1/+0apvCCdeQGEMt0o+maT40S5wLiOD1knazFUfbQTelgzJheMFKuKInhPC3T
	pzCHF/Ye9Q3ZPTsULoDWW8ZgCgHqui2ZZXPWHcBqUUzaaYOqv1X31Frs3Cxe15gR3RNUXK5LlfE
	KRgEitbjtyNk4FFURutJk8BgANjyW+dk434xq2qcqxqSkZ4dj91hXg7aHkwmptNqBq0xOHFrsSh
	BQcB5Gq6yr5/d+6ee70ja3Ls5/lyjKwIlb0Z1mKTTrnwWYMp5CRUrwkJ0kgevaTIYw0IGyvuovH
	7Va7x91xHxxbFCgVH3yjl2N0OEjHABSavDKP0eSTml3OrjhvzzzHPhpuUZtC2NHKqbEVPygxQe0
	yBdJN7yv3x2fccZvUy7YExNy/mOfBk0agZnjAt4fgrdg=
X-Received: by 2002:a05:690c:34c9:b0:886:70a9:3ad2 with SMTP id
 00721157ae682-88d20597e82mr43362677b3.15.1789499792652; Tue, 15 Sep 2026
 12:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907172648.457103-1-luiz.dentz@gmail.com> <20260908135708.552fcead@kernel.org>
 <a0e8bc1e-c237-41fb-b448-9594bd484cfe@sirena.org.uk> <CABBYNZKrSve8b=Acj2qu0YBuEZ9u9xHJe-ffRb+78x5KPY8Ntw@mail.gmail.com>
 <d5676b70-f60b-4ce6-b6e6-de564d5c0a29@sirena.org.uk>
In-Reply-To: <d5676b70-f60b-4ce6-b6e6-de564d5c0a29@sirena.org.uk>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 15 Sep 2026 15:16:21 -0400
X-Gm-Features: AcwNN1UsRm7OeWs90ouRy-sgT7iYXR6jPSxvfvxEerVxDP4pW0LdsgBtnpFL-XY
Message-ID: <CABBYNZLKnQsypBR8Kbx4QFL9KfnVXRhO9_d5BHYQCabVZSY34g@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-09-07
To: Mark Brown <broonie@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue, Sep 15, 2026 at 2:26=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Sep 15, 2026 at 02:07:39PM -0400, Luiz Augusto von Dentz wrote:
> > On Tue, Sep 15, 2026 at 1:46=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > FWIW I do keep reporting signoff issues to them:
>
> > >    https://lore.kernel.org/r/aqQARvWlSUQEHMtw@sirena.org.uk
> > >    https://lore.kernel.org/r/ap6Ze-_ckuTFyCMH@sirena.org.uk
> > >    https://lore.kernel.org/r/04d6aba2-bf5c-4e73-8ba2-1fe57218fbd9@sir=
ena.org.uk
>
> > These have been fixed though:
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-nex=
t.git/commit/?id=3D8d463624a249b6023e1bac6a5ebb0853a9c96d26
> > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-nex=
t.git/commit/?id=3Dbe1cc4fae4cb7d506ad01fa7746db363c41dcb6e
> > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-nex=
t.git/commit/?id=3D9ec9d1ade8ae7a3bd3cc061534d767fe305bedb6
>
> Sure, they do mostly seem to go away eventually but I'm usually sending
> reminders, and apparently at least some of these issues are making it
> into upstream pull requests so it seems the reports weren't acted on.  I
> did ask in the last of those mails if you should be a contact for the
> tree given that you seem to be doing a lot of the updates but never
> heard back on that - should I make that update?
>
> Given the issues caused by the unusual workflow for the tree I do send a
> lot of reports of issues in bluetooth.

Are you referring to the unusual workflow where fixes are merged to
bluetooth-next first, then to bluetooth (which changes its ID), and
finally merge to net? Changing the order to have Bluetooth first and
then bluetooth-next would require reworking the CI so it could
determine that it is a fix and then use Bluetooth as a base just to
avoid ID changes.

--=20
Luiz Augusto von Dentz
