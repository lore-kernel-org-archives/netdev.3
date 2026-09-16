Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226803D6CD4
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582374; cv=pass; b=SJwP+5qlzojPFFVt077TdrD9yQjdCJWq1w99662TY2BYSr0iAMW+4hd8ft8xBR/k+JsT397nDKcFaVbDb7Tn48RlsbM2xbuixatld7vMTxKIbQwyizyGFY1XZ4wlk73eVnaBSXENBYafPtTJYe5t9EMoWGWLQdC6WbeA1vJj8jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582374; c=relaxed/simple;
	bh=mu2tPus9QdfOxChxIrPwMgq6LJM/HiOoNaiArCUrrhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=de98HveqVUvpMjvLlj7gYJScyEU1lsOWw++WWNAxuT6Wlj6A1HrCungjZClR7BH3otVxuZWjw4FAg9JwZ1NKv65UiEE+7zoiNRycMYS0GEA+T3jrwwGMkI3EvA+BpsplzglCULkt/az8l08xHlxm2ENm/NL8JRFrpjPMNV97m7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wl9ikd8b; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl9ikd8b"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab201ebso1201379d50.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 11:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789582359; cv=none;
        d=google.com; s=arc-20260327;
        b=XTtV6mPcGs/lIEAN0YaYdGvyfmtLy2WfqHxxYaCj6nYmQ+fcIBanCYVJtQsra1yxHK
         qQMIa4MFUZyo4LvOZ1t6dvxYuMvLy+FhZ4n6qOF4UCr1BKSu69QxFV8sebP7I5KSHcVr
         5LTNJ+F9Hb1y/CPz9zFopVL/vqAG6/54Up49EO+mmWeROQqnsJNLgaylak0HThVktAz4
         MfutWVKFCOnur5kftqNAWJbvr0rz+wtzhkrI92QgSO/6qfTh6oAxhPZaulq6tSlMpqI0
         APlDy4Brsbkh3xNDDYnmyIEDbJLpoOoBVc5dNdwBH3gED+8nzpjZSoLyP7EAwbvDOLz+
         UoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RJUsWgqA9N6UNnQBce4r6dMBOkGwuuLMNggHMU0HA9U=;
        fh=Z0zYOrtOLCYH0MBKFs6Xa6SqtHERw3ex/GGJnt4cjms=;
        b=Oi+zw3HZIQ0ivdRR1BHt48qYywH+mOcYe+fjPmqh4K9E8zGIHHVVpXnbkMo1htHWu9
         GZOhHP1h61TWsyaUTeBX43Y28D7TLSELm8VEOUk8+Kr551iPtx/kLD6HIQoWx9OR8618
         4MGhUzeTJvpIAzlLWbu9ghibgUOSRpnCyOJvd6OmhFKN3NCpoG2Sf1jWH+00qJFnhIa3
         SkNxAHOQiApBUiM1WuLkbEzYa8RQyyMyevQBgbtEME+ld7F9fprIiFU+7nS3samcdBeX
         OlTg4Zs0duo4O9qhqp9VNpgCro49f5vXh4DmEkWw4V7a/KTAXHjM4Scjw8bdwlcrjiYS
         SMUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789582359; x=1790187159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RJUsWgqA9N6UNnQBce4r6dMBOkGwuuLMNggHMU0HA9U=;
        b=Wl9ikd8bveTsHtdnyuIwH4wdhZQU/gUEZh3iOiyn2ykUWhqWNVR4Jd/gDlj4of3wwD
         7nKPj+gifypbOQu5m1+4kLuYT6cmRNRykMui/BLh4UrLRcBKsvjqgDQQLppL6V0xrH/e
         KQcNAb8gkl8Z0/kRRemPJBXVyVQVkXrzcfUNQquUU8veBsnWpeJvpOFKYTzAA6AFSRk8
         0yUpMCIcnFer2get73Nn871H0MLaUnLI2oSCend/HUeMdXLfMO9JYgsI8/Z3nRizG1jp
         HmZZJzMZfXZwyRu6fkCSwCehB9tOH0h1pxGBx7Ok+NQJ+GnJRMTAlxWQw74kdTFrtRAC
         AtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789582359; x=1790187159;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RJUsWgqA9N6UNnQBce4r6dMBOkGwuuLMNggHMU0HA9U=;
        b=qJ/pwFoj+gwqiYWbeux5m9GBYusY6Vk4YcmRC4hD2eMSvgovdhlPpiuugMxrpbYxwS
         dxAeJhVraZcHHLfXtsbePoOw5bEXXOgQV8/bZD7fp+YLBUwvQ0S/lj2SS9vpmD79qpre
         YBl+4X0LhrktKsRxo4/wV4czoeleMNLlO6YkY75nDNAMpv5BmuV+E3nPSQ4mISwzp+hr
         P1FtxAKtbuaiZtNlMMh6XQSq70gtWkLwTn5suXdDPdzhkaFQybJPjFLGYrQwHRbOFGSy
         vOnFYEK6xnUye/MZmYi/Oy6BIsIwwW8AfxsjfYbETzJJOWDfnCtTMQo2+QGAKzoGJN/m
         hyIg==
X-Forwarded-Encrypted: i=1; AKwUvBxYWHlYTxnrAHml3Z8m8o22qh49G5+1VKSr+CXfkUceTA/L7OOJPiYBthmGgd433+HwDdYePRo=@vger.kernel.org
X-Gm-Message-State: AFuF++nN2B+lh+WoPoEBYsoOY4T6026ZcUZxFYqJWJBQ3mXffYtVN1Zr
	+Fe2EHlj1Vi2eWDMvJpLyZZVtmEShgkUnXqyZJXmvEY2NwpuNNaDl230cgQfaHv9AJI5rE4doaZ
	c2OkKM9jSEgjC/rAqIjUb2a3yUdg3bBQ=
X-Gm-Gg: AYBFou2amABsnPi8VO5E9qFKRZ1isHm/U6aOMAO7VCHingV4Mksto4wgw29TJwpXKeQ
	Fyf06zyIG6/gnfyD9qzOFU3EyBvJ2x9scjzwm2wWQVwRUo1a5oNDZmjrqO5vKSOg35s9N/Z8UHd
	pX1kdNZwJrIoDaU8nuMCT0/nalxSyKjvpbz12KARTBv/X4A1r6mg4s8iOwwikZI98d/2gayLkMB
	m4byQhTp22GBmXgk0YATkgPzvh/XxIBtmsdW/UZGi3j1gSgBm0+vG8OboG07U37al4w4Hkz1VZp
	Sio6847QMNN2lU242ivYJdv1+NREg+5nKfeFDRjsF0IuZCVlwpWaKG5HKYXX9BZzZvQC6+buXGM
	fNVDTsE+3Y7uQnkAEyTdHtnueTZE+QGYMEVPHwJuIAjc3vTWI8fRx
X-Received: by 2002:a05:690e:d01:b0:671:b80:e8ed with SMTP id
 956f58d0204a3-67163216206mr1368981d50.34.1789582359290; Wed, 16 Sep 2026
 11:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907172648.457103-1-luiz.dentz@gmail.com> <20260908135708.552fcead@kernel.org>
 <a0e8bc1e-c237-41fb-b448-9594bd484cfe@sirena.org.uk> <CABBYNZKrSve8b=Acj2qu0YBuEZ9u9xHJe-ffRb+78x5KPY8Ntw@mail.gmail.com>
 <d5676b70-f60b-4ce6-b6e6-de564d5c0a29@sirena.org.uk> <CABBYNZLKnQsypBR8Kbx4QFL9KfnVXRhO9_d5BHYQCabVZSY34g@mail.gmail.com>
 <064ec40d-66bb-4f69-ae1c-65cfed3581b4@sirena.org.uk> <CABBYNZJWcrvkx=6DekHxZzcrGjHwiqmSuwXqzHNV1=7BctThGA@mail.gmail.com>
 <aqnMueXiCztLUn-w@sirena.org.uk>
In-Reply-To: <aqnMueXiCztLUn-w@sirena.org.uk>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Sep 2026 14:12:28 -0400
X-Gm-Features: AcwNN1XUskie5F9ZoTyQMt1nFf664bs0X3J3oBE7p7QBFY7x0WdYfWBQGjvVDvg
Message-ID: <CABBYNZ+A+bNZ0THj0EZ4KfMj6wPMhD6hvbt5FP-exZnqxb4E-Q@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-09-07
To: Mark Brown <broonie@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue, Sep 15, 2026 at 6:54=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Sep 15, 2026 at 03:36:50PM -0400, Luiz Augusto von Dentz wrote:
> > On Tue, Sep 15, 2026 at 3:24=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
> > > On Tue, Sep 15, 2026 at 03:16:21PM -0400, Luiz Augusto von Dentz wrot=
e:
>
> > > Yes, the routine cherry picking is certainly part of it - it's not so
> > > much the fact that things get moved between branches as the fact that
> > > when you have the same commit is in multiple branches and then build =
on
> > > top of one or both of them this creates extra conflicts, often harder=
 to
> > > understand, when the branches are merged.  The more normal thing woul=
d
> > > be to apply once to the right place, or the standard fallback from th=
at
> > > would be to drop the commit from branch A at the time it is moved to
> > > branch B.
>
> > If I merge to bluetooth, then bluetooth-next won't contain the fixes
> > meant for stable/rc, so I will need to merge them back to
> > bluetooth-next immediately it order for our CI to stay current with
> > the fixes.
>
> Or have your CI merge the branches and run on that (that's a fairly
> widely deployed approach).

I incorporate the merge back into my workflow:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D967788508ba263e22d856f971c9118dc1a73f6ff

Hopefully this should stop showing conflicting/duplicate IDs at your end.

> > > You do seem to end up removing the cherry picked commits from their
> > > original branches at some point as part of your workflow (since there
> > > are hardly any duplicate bluetooth commits in mainline) so they do wi=
nd
> > > up being moves AFAICT but the duplicates get left sitting there for
> > > quite a while.
>
> > Yep, once before sending the pull request for net-next, bluetooth-next
> > is rebased on top of net-next which brings all the fixes already
> > merged back to bluetooth-next. Git is absolutely fine with that, I
> > don't think I ever run into a conflict doing this. Git detects the
> > fixes already present in net-next as duplicates and eliminates them,
> > so it really surprises me when you say you are finding conflicts, not
> > just duplicates.
>
> The issue is not your rebase working, the issue is that until you get
> round to doing that rebase anyone that merges both bluetooth and the net
> trees (ot Linus' tree for that matter, often the conflicts are with his
> tree) sees the duplicated commits and that routinely generates
> conflicts.  This obviously comes up an awful lot with -next, I am not
> rebasing the trees but rather merging them, but do I gather from some
> conversations that other people are seeing this as part of their
> workflows.
>
> Anyway, to return to my prior question: should you be a contact for the
> bluetooth tree?

Yep, you can add me as a contact person for both the bluetooth and
bluetooth-next trees.

--=20
Luiz Augusto von Dentz
