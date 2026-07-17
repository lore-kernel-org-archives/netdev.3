Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D154394EA6
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784290560; cv=pass; b=Ly2KgAC22QQU92TEowjEJ5kD9RjR8sK5Ow/3xWrSqzLgm8pCC0Goy16oko6NS7EIB2awKtoc/a1arKL8URhAgWC6aXuKbCtY6VDjItWTHaDQVsuA9jFiO/v1EckBUzqnyCYDwfu6sNsEoWtaBae6i3uFE5b4PuynFkyq/6XfAeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784290560; c=relaxed/simple;
	bh=lLXOBzquebNhGuqikS2V4uKnmHX6rL6Jxc6Q1kIs6oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6ROgv/75mAn/9cm1vMJ8H5BYBacv2sQHQ+5BjihUoInM9QHBnAjDM+P04dixRjRn5gLQgTewA8I3vj+IQz3I2dfuPziO0bzsAhN7ZbGnySmEo+J8CYqOpzkJyBL7RlSJQYMki6H+pYkHB+9aQ0tj27jq/+Pd/fInP7Jl8esnkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=g/X+YoOc; arc=pass smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="g/X+YoOc"
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7DE123FBAF
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 12:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784290556;
	bh=N/hnahT5kZbiNxMSUWsFWdLZL5SL2X58CFxZoF5fAdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=g/X+YoOcMiMkod5lc2R2TrCxW33/QUCORe0sULosfB1rhSn9KTYL4Ssu8UW/BBQo+
	 i8z4P6TTlZiUFpL1EWbeDrExHoEIdu5uTLVaQlmMyprNUo8rxKX4Rl9b4292xHVX4Z
	 0UmjMpBAvcKK9GQAG0Bqs3/YdPMGlxy8te2TSMgPZ4O7RtPUf6RwprhpfKMA2Ayiai
	 lhDbUEwQvFUOFUfD3uLu7BnSfUy9/M9k8PrTMqGfz2psBqhaEMfIItbsDRN8Gzx9Cn
	 fCAp5ngReacWtIkd6u91+PsvmYs8gaOS5Ra6eItpr/P3gkLZOEUE6wUj/RHLJywf7o
	 eIIaYxocr+3xc1el2UlDw1akJozSEHwD9d5hr+3q5huqmoYZQudD5C/DNHME5udGfr
	 UFVtptJKE+/IdrUskCiGPqE25ljs4GM7pZDRBCYgenTQRvEcQHNQPAaoCVE3rNcayS
	 s8SwTpj4VwRsZPNxCf7qnUSE7uD03CH+OZbu4fqLtUy7ALdasi7LTKiL1FT5L3HdLV
	 n55ExHVMdOgMIv+HceAe+vUyhDcqj7fMgKW9GluXoxYXwSqwP+8vnD6jIcK9UVCxu7
	 Tt0usj7Rw77EIK53ovByc6With5jUSyn2YcI27KCxZpbJfLaAfzqaMrRDr+ZSbkkqA
	 eZ5/kgnY8fbQRwtB5KwEXZbU=
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15c32294e1so878767066b.3
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 05:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784290556; cv=none;
        d=google.com; s=arc-20260327;
        b=FIvHf0zzVVCX3pw28EDT/l0Fp4T9A63X6mhux5yeIY8k1CsYCKs6yPBycXrSPAr2ya
         jDNDQV1zuWF2alAQaCBHyyysxCyNBEOtxCQZaZT5E8Rplx/W83blkGuWTNIXmLEQJ/VG
         JCqb41WT0pEQSjTUUWnJKPaSCuJHNH/X29tCstw2UG6WBQPUeG7OIQQGMVrPLl74wP2m
         2d7Me+otOkPnjrg1kjrKpmxgCdf8N04W0v3/GO8gIFjYpzlSzKrttGUo84/n73cuDwMk
         dvlSg83IZ1HKYvlCV/z1hfci/07K3iU7Bx74qllxhvdFdhi4boH2yjm0u2sUeIrkzD3a
         8q7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=N/hnahT5kZbiNxMSUWsFWdLZL5SL2X58CFxZoF5fAdg=;
        fh=/qFOYiZItRODqDgMnBB09b83TPXiSI4BdL5UvQolhJo=;
        b=LPEkA9XYl8pUiz/78Y385YZpfz9clT9w1+zThQQAbGFIR8fDpsvIjaJ7mRiSq8UtdJ
         mP60aHktPOoumB/1ObaCcFBOPuxrNFm/jZMZMT/RYYfoRwX5Dd5w2DLYlK5g+X4pfCX4
         0Tvj+U9GTTo5lNxOOBIIhkQDbSWTZp5yacVoqHR2xH4Gn/RWwf6GgjlZLflcKBIWdnst
         lzx/y4xj6SZbwvnjA77+uOQeaRMBgP5YWi1eAjkCUWFa7xwMyFlz0sHuOiO0F5+54RId
         H0fY4u/A3M9EZNCpLmy+x+Dtea0RCuQh0dOAIFQBwSTI2TE/Nf/dkJNspqdWrdig1X4V
         ThiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784290556; x=1784895356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N/hnahT5kZbiNxMSUWsFWdLZL5SL2X58CFxZoF5fAdg=;
        b=oj/CCBgZJ9yFYHrxZM31ojNMdm7ucR1E6RL2wOZKnbB9KNeI835cSvA9P65l7HCult
         V0h8Iwzogo4EiCyqH71G1dyRqnLfQisx//aA1LfknECuA7unrTDbvZwxT6/629RxtyOP
         /bzF3LTUyJWe/i19SutAukODD+tZVMcVRXLXN7ZIvU4F/QPvzU7RsMZfsjTnbtmeowiL
         haIQePMzpIxu43iZdsJ1cM1NNm14FtTFLKJUzMYfM7rsksS4HADPXs+WbCZIYLuPzDEi
         eJ6T2W5lVDFJ26E2/+oDVUL2+rWcMpOjWjJb5v+d0vH9RXLDidZgEc1fpfEN+rIxT6XS
         mD9Q==
X-Forwarded-Encrypted: i=1; AHgh+RrEVeYh7Dh5/BhXxHEnX+CyUs8BmHGtGuJn7yLT9b5wR1irvge5id08Hcb5rzs3FvydvrPAPQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxESyxW4oNsDsPbgBBNfVRyp7OAr/FNwdcqh29h7TtpN0MaonMP
	kRS/BfB8E7v7xXxKG6MMxb3tKHNn3GRN6FbtXSukQ8/YbFon50ja0IBc4F1Cmqhu+RszQ1pD9jZ
	rAWr/DDfS3JDEE/wIrQHBiGZTOCQNc72yTisqP/cgSf+qGCfEA6SmUaWkdBa0j9+WDIJ/cIgDMu
	3v6Tgm68HUvXmbSviNa9C8hE1EAXKirGELDuPUW/CXmT487aiQ
X-Gm-Gg: AfdE7cnWS4B/gr2H2LvU5jDKwcv5dynT60RMNrNnIu3bP90xOH9fA/VkT5aidY0L3Hy
	AASCWhfAGKz6V7GLaJjBedgA/uXxgYdXhmcwersJGPmJRVIC9L4oJBmGfmYeAXJ0XLb3Bnk4L9v
	GuN3WlOIx6I4XGD0cgcQJ2dfxt3MTr2Os4FVtB5IpKhqWRLN+iJaJ+O/gSHQ==
X-Received: by 2002:a17:906:fe08:b0:c12:713b:e199 with SMTP id a640c23a62f3a-c16b46e922dmr112680466b.25.1784290555995;
        Fri, 17 Jul 2026 05:15:55 -0700 (PDT)
X-Received: by 2002:a17:906:fe08:b0:c12:713b:e199 with SMTP id
 a640c23a62f3a-c16b46e922dmr112678966b.25.1784290555523; Fri, 17 Jul 2026
 05:15:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703103245.374800-1-robert.malz@canonical.com>
 <bc89cccb-3f22-42c9-9f96-382586d12fcf@intel.com> <CADcc-bxLMg1NujF+jE2rOXGc38quv_XqZfv5K+yGQFfhc03avA@mail.gmail.com>
 <e8a4e549-c67f-4d20-8d33-fb50b4c44de9@intel.com> <5b420008-96f9-4f62-b155-a4b694a58369@intel.com>
In-Reply-To: <5b420008-96f9-4f62-b155-a4b694a58369@intel.com>
From: Robert Malz <robert.malz@canonical.com>
Date: Fri, 17 Jul 2026 14:15:44 +0200
X-Gm-Features: AUfX_mzqbVwIfN-n_6r4R2Imerfb5FAU2AjX_1Gj95UHrg4tI04VLZsTxG42NGg
Message-ID: <CADcc-bxOBSaH=NdS3rHHCSZZ7e_0mXvmD0R9tanNQ1_JwoQ=PA@mail.gmail.com>
Subject: Re: [PATCH iwl] ice: acquire NVM lock around each flash read
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Jacob, Tony, Przemek
Thanks again for the review.
I have submitted the v2 patch with the mentioned changes.
ref: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-2026071=
3/056079.html

Regards,
Robert

On Wed, Jul 15, 2026 at 8:22=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
>
> On 7/15/2026 10:04 AM, Tony Nguyen wrote:
> >
> >
> > On 7/15/2026 3:22 AM, Robert Malz wrote:
> >
> > ...
> >
> >>>> -             if (status)
> >>>> +             if (status) {
> >>>> +                     /* ice_release_nvm() issues an AQ command that
> >>>> would
> >>>> +                      * overwrite sq_last_status, which some caller=
s
> >>>> +                      * inspect after a failed read. Preserve the
> >>>> read's
> >>>> +                      * AQ error across the release.
> >>>> +                      */
> >>>> +                     aq_err =3D hw->adminq.sq_last_status;
> >>>> +
> >>>> +                     ice_release_nvm(hw);
> >>>> +                     hw->adminq.sq_last_status =3D aq_err;
> >>>
> >>> Does restoring hw->adminq.sq_last_status here without holding the Adm=
in
> >>> Queue
> >>> lock risk overwriting the status of a concurrent AdminQ command?
> >>> If another thread acquires the lock and sends a command immediately
> >>> after
> >>> ice_release_nvm(hw), this lockless write could corrupt its error stat=
us.
> >>>
> >>> [TN] I don't believe the AQ lock will work as desired we can't guaran=
tee
> >>> that we will have the lock directly following the release in order to
> >>> restore the AQ error. Similar to the NVM lock issue, I think this is =
a
> >>> small window but wanted to bring this here in case others had
> >>> thoughts/comments on this.
> >>
> >> [RM] Agree, this can cause issues. We can't drop sq_last_status as
> >> ice_discover_flash_size depends on it.
> >> Proposed fix: drop the save/restore sq_last_status and propagate the
> >> read AQ error through a real return path instead of the shared global.
> >> I could add optional enum libie_aq_err *read_aq_err out param to
> >> ice_read_flat_nvm(), capture sq_last_status before the
> >> ice_release_nvm, and have ice_discover_flash_size() test that instead.
> >> The log-only callers (devlink/ethtool) don't care about it.
> >> Let me know what you think about it.
> > This sounds good to me.
> >
> > Thanks,
> > Tony
>
> I concur as well. In theory we should probably try to fully refactor the
> send_sq commands to propagate the error out from the lowest level
> without sq_last_status at all.. but thats a bigger ask and I don't think
> Robert needs to be asked to do that.
>
> The approach described here seems like a reasonable compromise fornow.
>
> Thanks,
> Jake
