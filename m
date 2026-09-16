Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4E84D7957
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583462; cv=pass; b=S/sVZ8UGPCioBAp/7BRZyBIrtIwQ0AVXYGOflYgbN2FuuOgRBZMvRo+otQoywzgVyCplFxpeQSo7LsDt7DGGJ0ZmJ9ZOM/u9IiuS6kFgrE4or5uTDHquE6O/0ifuD6eimSpfNsTeMcCh4Y/M5HH12p4VGm70k4lg1w3FpRM2SpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583462; c=relaxed/simple;
	bh=onmKTaBroLnQHSziLElRNTVusNSumHu5B2jtCHXy5uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZeLuDB1CyL7SN7Xi9UPkMZP5nihRoVXpBneJGKGDB0Q5OonrGac1UCvz8O1OaIkPr+D/Ye0jXbFhOjl7Wv9Zr+6XZQD7CiWoO1b34EDN9wGEJL1ErkqAdYuueRj/gR2SDcKr/5OAh0XQMrLcmMeYGfzZbNZqqE/iQRnxC39FmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4DpSgXx; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4DpSgXx"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d46e4cdccso10658197b3.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 11:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789583442; cv=none;
        d=google.com; s=arc-20260327;
        b=aqu/sWHknYIN0c2U1JOIe57wBKicu2uZbJxb8lscG4AEmp3ALOF6CwG0QJjbA8ZXkw
         GZ6HdfP2gpC0hkvbEbx3hLv65Ve4eLf6OJ/Gii3Jot/2HVpB5jAPqqQhM3LkyI3b1aeq
         HisUpIAiqQv/isdf0A1F28PgZHFxsJbzPA++keBovPVBKEK2Pt/21uJxDQ/gLT8+/MVg
         NY9cKH+58iTWzyRcg/h2Q9WSrIkdVgvG0Z5qpg4Ye9TQHPjS2v7kLgIE4Ga267gLj1iL
         NOqKy34RJm5LEfWuRHhS2MRmRlgw9ZbxIPQOVrxVfu9+VQOPy/Of/pvIMHu+WL31ZxYr
         dzAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AwudpkD/kJzzZP+/2SGiHye4aqMnNy3/NaZ41CzM5dA=;
        fh=nDBP16WbclOvyWMxRG5zfAiryFs8xzEiOMHA+j2L/BI=;
        b=rpoghYLcAcOlWaLVLN0ERaUrYHjDZdig2D3Y6+7caqUU670v4Qe/Aq5otjvBk/6wo/
         V5ClG6NDi7I/UKKwfbGNuYdwF9kdFyOqx+nuOwmddyIJ0HqdOvUYBSSP/QwYEmjNe3MT
         X15Yl7Om72txqxPNxwK6aBnIADGVNUtd1Q1PLh+Q99Lk8Szbt9j0jsZEQMiKn0MCM5RE
         lP0HmSX9eEEiXU6Jyqg/0rVzdUPKl46Y88dgjFwYr4a8ppMRs7hn4iJgwywXz7U/29jJ
         SVYqwGpnonqj8eXdWN+oh9qH9CUp88EYtJ1ey/GBN+D81SLP/4qrVueOFIL9enh0RCoX
         6e3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789583442; x=1790188242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AwudpkD/kJzzZP+/2SGiHye4aqMnNy3/NaZ41CzM5dA=;
        b=h4DpSgXxRjFr3lhQ1mXtQ6XdyZHLWxt0r3RiKrmpoMEjGjmBnkB0JkvSCaBstsyntV
         iVa1hSs5F/5+hp/31nfIG9ocVIMoOKIrTTjbHIfMIhoM/2bvYsSUJfWNkmUHYHdnwL+/
         Y759HMx1lWZ8OAW3JG/rn1DlEb/3E3sEP5ri1o3wBKtmUKuImRAeN/sodVD8C5ahUj1A
         wy1P0idF7VSV29AMW9G1QjVBiogKPCDP6fUoS2lkqqwfb1xAYR+TGvnpiSFv4+COmtuj
         JJ2qHgbptLV+lWxLhUwmeJaitSGK7I+CyfXxfRoXIu2Dm/1lhcpwhvC5EIPYuxMk27yy
         MV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789583442; x=1790188242;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AwudpkD/kJzzZP+/2SGiHye4aqMnNy3/NaZ41CzM5dA=;
        b=Vg2rMkXh5VoG7crXhqzHXy35zwUz7sgeB23TEwwcJPvCCJXa+upDNpYwy54Q19cjr9
         K7R1PvgaxdX+k8IpNH6uPjhZIDIOJbJymCuT4s8F9Ww5/4BFoapmAmV7bUFFVGQ/PXrP
         JAxz/U0PxSWiUZ9UnW/Kszfy6OQcVyPywGQ42sIJjHQFA/lAzestQZedxGSiiUi0eiy7
         fJulf/mLgNH8IYtqc7MpdLbfQLtmUtuyKIFWwtYljDkz+blsHff7S5qERI7zOvVLG9r5
         HQ5pvFkeXFE2Mzi3i3OvJ9nNFmNnXMsIv3FXmeE852IL8VBCI6ugZ9ZtgXKsBh4u2ySW
         Q6hA==
X-Forwarded-Encrypted: i=1; AKwUvBx/A9Rb2+ZpTxg/X5B8OOJrmNGqs2NAtY2spTTX557Swva6gPdRAgCWG5qtHE3JB9K+l1NCajQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mZ50DoXaU9YCmGV0FCEdUgu9QCw/gXZSAG+41AlUtmX4zrcnIk
	u9PyfZN3X+e7XGVCft6+Z00Hfd8fQxeBKaX+T0P1pym+cd3U2Laks0BJT9tCtAUXUQKyeqIRF2c
	pjjPpmUddc8RvfcH85Pbs7Ae2SbKXLbrvPz851vQ=
X-Gm-Gg: AYBFou0J79txWZD7Z9FTQvUI6OkWLFdgWEWQJEYFIW4eg8yMU/RtJedYn32AVrpG4wW
	fLRgAfvdQacvGwqO1LzZqMuYTU4JdiFyTQF11Dtsb6NES5nYOwflIeHnSzoBVmIFtHB4yT+tNuu
	Y8j815/a5lJR9HsC/SC0cJBnAkCqowWyUe8DgGnNcOKrkFEp159jg4+4kHmUfoqzYJtpxW+2/Qx
	54ymD5PklVqb3RY4oeVqvHMf5ZMGzP+HcvY05d2Z0cAPsdGWWnqVdqPWOTwljyJPgdsE3L5w5WC
	+os5uA6XgzRXlKQjRhPq9nUDFie6UmrRFH8CgqOnpwbJrgfwVOtor/4Gsp59s3pVZaoY7xp/YAf
	0V7p2/031+gE8VITGrmUhACy2+6kyG56iuVa2yJFX/g==
X-Received: by 2002:a05:690e:108a:10b0:66f:7d56:cf77 with SMTP id
 956f58d0204a3-671632a1448mr1234859d50.26.1789583441801; Wed, 16 Sep 2026
 11:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a0e8bc1e-c237-41fb-b448-9594bd484cfe@sirena.org.uk>
 <CABBYNZKrSve8b=Acj2qu0YBuEZ9u9xHJe-ffRb+78x5KPY8Ntw@mail.gmail.com>
 <d5676b70-f60b-4ce6-b6e6-de564d5c0a29@sirena.org.uk> <CABBYNZLKnQsypBR8Kbx4QFL9KfnVXRhO9_d5BHYQCabVZSY34g@mail.gmail.com>
 <064ec40d-66bb-4f69-ae1c-65cfed3581b4@sirena.org.uk> <CABBYNZJWcrvkx=6DekHxZzcrGjHwiqmSuwXqzHNV1=7BctThGA@mail.gmail.com>
 <aqnMueXiCztLUn-w@sirena.org.uk> <CABBYNZ+A+bNZ0THj0EZ4KfMj6wPMhD6hvbt5FP-exZnqxb4E-Q@mail.gmail.com>
 <6ce3c671-12e3-4057-9610-23efe14832cf@sirena.org.uk> <CABBYNZKiy+t_GC9dL6nraiH26m+2U=kuAF8NMAPNW-BhtOSovA@mail.gmail.com>
 <1add998c-b408-45cf-9442-0fda2674fe32@sirena.org.uk>
In-Reply-To: <1add998c-b408-45cf-9442-0fda2674fe32@sirena.org.uk>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Sep 2026 14:30:30 -0400
X-Gm-Features: AcwNN1XJ25cFXVjQc3Y6QUUrVUjgBedc6Z-Ottn4dwnykw-MCWmOOSeYEK-qb9U
Message-ID: <CABBYNZJn-ZYkX1DrOg9QWQHLWP_Pzh62M__X_jd0eXrKQx-K_Q@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-09-07
To: Mark Brown <broonie@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, Sep 16, 2026 at 2:27=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Sep 16, 2026 at 02:17:35PM -0400, Luiz Augusto von Dentz wrote:
> > On Wed, Sep 16, 2026 at 2:15=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > > Yep, you can add me as a contact person for both the bluetooth and
> > > > bluetooth-next trees.
>
> > > With your luiz.dentz@gmail.com address?
>
> > Yes.
>
> Great, you're added for the bluetooth tree now.  I note that I only have
> one tree for bluetooth in -next:
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-ne=
xt.git
> master
>
> so your fixes tree is not covered, I can easily add that if you tell me
> where it is?  It'd be good to have it in pending-fixes.

Fixes tree is in:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git

--=20
Luiz Augusto von Dentz
