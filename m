Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8328448D0E
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789501024; cv=pass; b=fEKtMJMNzrrhnqGY4IrKdpfMV4ultHT2Ko2/KaPSeZWyyYcS6y2/U/dy4spfpkSF5TW8B5TM6s0Lp4TzsTvO6GgZGWbuLdyCddmbroB4ZtlDK6C/mI4V6CBkE7le6M5o7Ti2TiqfCfI7V2fg57ulkuGiwIlxAYPVFjkrToUY+SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789501024; c=relaxed/simple;
	bh=Z2f4FQ8va33TGvYyGtCEXC3YdwZgKCv0QJI6Otw6I1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLmG8qWttRLMnKItKgcRyJJD1Ec/4wF2Higl0JKsCcAOzfLGXHXmMarRfuUAm9NL3uc53G07XzXqFvs7NyAQFnf9p7E+Pu5qEhTbRs2CC82+Pan9P5L+rWquLcK6NtRsD7HDUuukbLz+XhyGBbeaCYGKM1Mls73XXFPbjcKkVOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKn2G4wd; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKn2G4wd"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aae3147so157153d50.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:37:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789501021; cv=none;
        d=google.com; s=arc-20260327;
        b=ibJGdbyOjktAz+ZMC6PrkjegWNMM+lL+xREha3wWtAu+x2SAw6UlRDIVx/WcBk3geU
         PEUhmeahXB9k0pIiZc0vCqcmtY4aEXTar7AeDcRyf9+P+GzSEA98oOUs9wPnZTbQ+vtR
         1UrvNPHYjnzFZl3b1A6l+kpswhvU7F+S4mpGjb8DNMEo6vpJvKmujQXLJDozzLfHYKia
         4B0DG0Fwhz3wAKV4Qy8i5jsv4syKecgaCqUKVPn/IAKc8ZBsWfnSah9UbUWlGXE52MqE
         oC4ijThfrpVZtxW5D67CBlmZqI/mq/S9AaaMjI3XfVhUL9nhccJSR4DTF08bnvOpmAA9
         52tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NR8RlaqooEVk50qaakjuofXzFH4w/MxQZ1es9fZiI7M=;
        fh=ROu4K7xw+jMQv9ccFUyy/M8H6lqwlY4aVC/VxutwaiM=;
        b=CLRCEWRJsnHSryPk2EEVRsTBJJFpg2IpNj/dSgCVxhnz+evP0wpRbTUWj7jXaSP67t
         dqVnCueWElTonEOF4lsi4DoGSWwOEIgJVtBXgnDx484YCibarHRvHrBeq+2Zt0UjdmuG
         JG2HkkkPjdOWVlDhLMBrBye55rzxPxbls84OyMx+lwHBa5pWG7enDuMiG/klYF7jRO4x
         Im+vO34tOrCxQUCtdJ4Z2ZpiNwXbrZ/aWRg5dP90PG72FOxD4R1UK2Z1ZLoOF0Kg/sFf
         I/gdEOU2c/r+nMcew0dT9KRHC9vpwGQ/kt8YMe+rUvi8CLj4/U6bbx9f5jLspn27Qcbm
         y2sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789501021; x=1790105821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NR8RlaqooEVk50qaakjuofXzFH4w/MxQZ1es9fZiI7M=;
        b=fKn2G4wd5oOdkktuabzRYBZDbglA+QrMTqjNscZoR/nO0hwyZDokFwRKLr1u5vEAVM
         VwVyxJ8Nfp0fvRVjtlfaZ004r2sfDffWNvoYN/CKNnfmDW/k/o9ghDGLWCSo3+dz4dNQ
         +vQ67dZdUwzvM38DEoliQNIgAFo+LMaN/wSCuUkzyEYdooAaFM41OaLlLmuNxXMQOZhY
         W17DBNuA9wDVrcRW5RTXx0V/VAZaRiSmG3532wCjfFh1VUqU27Lw0HSIK0lOuDMX75Lw
         5aMADngVIQA9WAZ7A7jY1zVQmpHSO8JatfArZUyh6FHgT12S0sAb0TK0iWuG68wuzczl
         IVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789501021; x=1790105821;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NR8RlaqooEVk50qaakjuofXzFH4w/MxQZ1es9fZiI7M=;
        b=aDviPoUy1HulEDa4kGZ6TgmAmF74a+9r6PVPanPhyMX+8d1P4NN0g5zVllozFY4Y9x
         OtOWDDu669TNxikI+1L5a2i1DQPcZb+uPQH2CrYrJ/A//ylmUUUIe6KhHCEETAREw04a
         Fq8IIKavl0riNCVyWqBqoifoVN3V14jr6tciqOtial2SC2Zi0EY9ZzYTW1CTY3zaYJxg
         DQPYW383jTOtrvVkxvbjjERJ+7Qph1HJ6eleBKH6WMixOuhVKgq9yf/vgK0S/OB2/Fb8
         OBPmaFv66P2gBbqK1dNy02fDEi28hV/zuLZ6mySzEdCHwFpSCJ7/K1aYm+eWBDmhtGNh
         9tbA==
X-Forwarded-Encrypted: i=1; AKwUvBxQ2jassNInkXTmZoHILDAHgqW55qHTJpLlGcpYSo9mHoiuQ2wAqQc8xaSOuJ9DFKgt6A8C7jA=@vger.kernel.org
X-Gm-Message-State: AFuF++kAduSaj3fCaqhNza6R8fFcDu4N4MPaxf0NkAPSSX3ScQ+c7yDq
	ouh/ESGt743fkchKNaBILEgxurVqecyHQSbJytQ2FEs4xysdUl4Wo5fE+Q9508HTx+LdRYesxIc
	cV28xJyhyAEghQhLHO3ftTJfy4XPH38Q=
X-Gm-Gg: AYBFou2kCtXT9vn4wpkILE7Hm58HxSijnO9v+0ltPsUXGmZWFV5JbGwQLzMVDUaBx9N
	mYdW3WSuiGLatLj6IhcvWwSMtJWozXosBxYlIG9Vj4KT/CCj5aeA5dakalERd01IZMUjUi1Ltqu
	uoDj8PRWVxUmUtfR1H2acsWwbTTyLFsB4SiDQ7twOt7xDmpp0jkB5M4nBXebz5K1Fcs11IJcrZ6
	4KvIXpI/NMzOr1dIHaw0jVDbPKS44qZxwS2sDKIJH6luBB59ucGXM40Tsjq0JqSEG/ULKxQ+Rzx
	e3hpTNs0+AF91hu8SKNwr8qQPTsf9HC1TMUFPZ+TNsrGthpz5laEq7Wxfep7kQZKerubCFO/ikb
	EKPoyViR0at3jQBnfy3J6ElTswxIpBb7EaSCiR+/BAg==
X-Received: by 2002:a05:690e:1685:b0:671:158a:ef96 with SMTP id
 956f58d0204a3-6714dfc87fbmr3560203d50.11.1789501021567; Tue, 15 Sep 2026
 12:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907172648.457103-1-luiz.dentz@gmail.com> <20260908135708.552fcead@kernel.org>
 <a0e8bc1e-c237-41fb-b448-9594bd484cfe@sirena.org.uk> <CABBYNZKrSve8b=Acj2qu0YBuEZ9u9xHJe-ffRb+78x5KPY8Ntw@mail.gmail.com>
 <d5676b70-f60b-4ce6-b6e6-de564d5c0a29@sirena.org.uk> <CABBYNZLKnQsypBR8Kbx4QFL9KfnVXRhO9_d5BHYQCabVZSY34g@mail.gmail.com>
 <064ec40d-66bb-4f69-ae1c-65cfed3581b4@sirena.org.uk>
In-Reply-To: <064ec40d-66bb-4f69-ae1c-65cfed3581b4@sirena.org.uk>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 15 Sep 2026 15:36:50 -0400
X-Gm-Features: AcwNN1WZSrhgKQi-A-4IUp8r81RK4e1x4QppNN_W4nJerIvw3znNgB3XikJm0fQ
Message-ID: <CABBYNZJWcrvkx=6DekHxZzcrGjHwiqmSuwXqzHNV1=7BctThGA@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-09-07
To: Mark Brown <broonie@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue, Sep 15, 2026 at 3:24=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Sep 15, 2026 at 03:16:21PM -0400, Luiz Augusto von Dentz wrote:
> > On Tue, Sep 15, 2026 at 2:26=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > Given the issues caused by the unusual workflow for the tree I do sen=
d a
> > > lot of reports of issues in bluetooth.
>
> > Are you referring to the unusual workflow where fixes are merged to
> > bluetooth-next first, then to bluetooth (which changes its ID), and
> > finally merge to net? Changing the order to have Bluetooth first and
> > then bluetooth-next would require reworking the CI so it could
> > determine that it is a fix and then use Bluetooth as a base just to
> > avoid ID changes.
>
> Yes, the routine cherry picking is certainly part of it - it's not so
> much the fact that things get moved between branches as the fact that
> when you have the same commit is in multiple branches and then build on
> top of one or both of them this creates extra conflicts, often harder to
> understand, when the branches are merged.  The more normal thing would
> be to apply once to the right place, or the standard fallback from that
> would be to drop the commit from branch A at the time it is moved to
> branch B.

If I merge to bluetooth, then bluetooth-next won't contain the fixes
meant for stable/rc, so I will need to merge them back to
bluetooth-next immediately it order for our CI to stay current with
the fixes.

> You do seem to end up removing the cherry picked commits from their
> original branches at some point as part of your workflow (since there
> are hardly any duplicate bluetooth commits in mainline) so they do wind
> up being moves AFAICT but the duplicates get left sitting there for
> quite a while.

Yep, once before sending the pull request for net-next, bluetooth-next
is rebased on top of net-next which brings all the fixes already
merged back to bluetooth-next. Git is absolutely fine with that, I
don't think I ever run into a conflict doing this. Git detects the
fixes already present in net-next as duplicates and eliminates them,
so it really surprises me when you say you are finding conflicts, not
just duplicates.

--=20
Luiz Augusto von Dentz
