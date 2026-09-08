Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E83559C8C
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880379; cv=pass; b=FNlI0/YEBA894mQccL4j9XEhi5M/WC7gTenmV3HOms0hqXDiNLvEA1Fr9DtNugkSDJqOmzomPQkdZG/GZgp0DwUvOuX/DV5CdBFl/F8dFv8vHpZdC7+mOmLkII3FAHBZEohOtTdQZWc1RnKhO+3vIJ89bJhjpif24qUeilCTD3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880379; c=relaxed/simple;
	bh=h4V3qmSg9Cl3SBicqioBkg1pZFXj8Z00HAErU9xLdic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIJNC2Zy3xRggS3bzDOKpKvZ1F/3cTVtEWpgBVXdX950Ibr7qY73mNxOrXWjWymrD5lutsZb0bFPeV2bvyW+PAzSt5r9HZtes5Ni9TkZVHtnd8D99D6uHQWSm888ZNxa/GYWCPMhWJCsFt5oh8qH0c1G1iv5MJw4kyywySQlEOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C8hA5CSV; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8hA5CSV"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca06so244405ad.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 08:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788880372; cv=none;
        d=google.com; s=arc-20260327;
        b=m4kFVYLryhcPtk89ChA7ZCGUgAoumd1Plv3sNsZOkTwYA+km01iWUk9f10mqgT4rvJ
         rjrssvI8IthVPLmo8sdTFt1dWMIP0u2K7SRYb8QC1TBLRrc16LBu5oO+i+pbtd7xRUoS
         OoBJe12fy7zHAi7fXqjtPNd7DT9+HrFSlleEwp0vy9mcjZQAYiYjoU2CidX55Ki8JZK7
         l5/ZANng0Pg5mYizdnI9GiH5EIfeqcNxBBBjyDQtSaJwQq+u2qAv+nLblEUu6Di58qKI
         6kNCROvFNkWXssRIQ87VwVIzvQXUBYlykusqbl/IAkB1kDhdpNcd8qXoL7DdCQP/Fj28
         Ducw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BouDQyseTpgBscOBCF3a6wtMXmz3CzisSn6GhPbdwBA=;
        fh=X8vZunwKv7nAygvNJgm51mg5sF1UwAKg+cZz7N8n0oY=;
        b=ITxRDxg7qMH3weYpg/e9BjIWjF9YiaouJmArpFXGZMcG07jBLO4G0Ys5ztSfgRdv/I
         Of80ES+Kdx0VCimKnfjb73tMn3V7r8lXDCDUNOzMscg8ahOphG8/3WrblYeDY5Mjoh7L
         RIiAp3Q7MKNhSBSi/EF+SYGFk1aGzlEEJX1b7KYWZBJr1Qsjhzytni73xkYKQAT/k3wY
         G06p8sZN4iSLDTfY4ud07faUBE2D1+UDPbtIxO5BCt+IpDSBRV6eNiQ4NLNLUc2pdXO1
         FEo12CnkWKF/FHRjOqm9qptHSfKYiIPXpAAbtHk9h0DrlgqTdeyFw80EQYAZ9ujZ4cHm
         e31w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788880372; x=1789485172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BouDQyseTpgBscOBCF3a6wtMXmz3CzisSn6GhPbdwBA=;
        b=C8hA5CSVxM/Z74ufDl36ekUeNsEHH0WhC055seX39waYfrIjxLVZ4VhECPL9nMmD/K
         wLdIm0FQyh/deMhjU8aIUom//KEOY82WrXpdUbM7PBWESChmWZNeTyh8FOIkFGCQRHnH
         V+QjdSgJVP6wZaBVd28laxSh8PhhsWvJvsV1HHj6qpe87nj4gtmmTAyZr3inkbnv59dk
         wOlegio/ZYU86wJwwQ+16BwGPyXrbgX2sA2hLTvUfeuEIsqb2ZeILbC/KkOzbkRi7UCN
         9IPPJlDqQt0j4OnW4uSgA5mN04rCsNt5IhBF0P9BZnrGSF/ksjVmbDiLioj2EAV5ji1F
         g6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788880372; x=1789485172;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BouDQyseTpgBscOBCF3a6wtMXmz3CzisSn6GhPbdwBA=;
        b=D1vBfyEYEy0oJjkaWy+7MyVzKBaH7cYrzQVl0Z1nFV4rHNHHjzOIUDre035tt8QH1h
         0jp/eypbpslxenf6yOWDN/uhz/5wVgBsjs2bgtzvsKNy1/cBJTM8ExKcVA1PsFFo4Opi
         CMR7FVP8tjzVMq22OhAin3itGfFFYeff6esR+9aT4v57SLCMgLdbWPK2uyYVLCENHBt9
         ThRF8v/OJfFkOKA3LYxgo2FRgsQ3OqziFqceEP67N0/YAtZc8QHJKnb56jL9EPBP6KqY
         XeoFh6sa9TD7Xm10pTwedARQF83hOU7zBn3qX7PiTHgUJk9L4sLrFtYuLMFK8qYAmu7H
         oX6w==
X-Gm-Message-State: AFuF++miZ0kUqbcLy+TwkWytNa9hxl2GIkdst1uh1lbhcHECpIEmLqMC
	4i4SHTE5XHCjBUYsJxKjn3wmx1aKknZMWKnPaoAKz50eJg252GjIclPdjVkG3xwodEHALdDeSCu
	/DSuVMFt8zwxdzmToKOn6vEm288bjKRLvd9tmlvQ5
X-Gm-Gg: AYBFou0YDUf5DJjFjBQMYDy/HJ1CuDVASVRImtjZpZAtKRjwv1qvbbaZQ7YFZogn/Bi
	xMLHWL/9V5YZcPWN51ar6lRbJoza2auJG6mTMU2zTba6IqRuWCn7/f29hBP8wWuMCSCd/DcnIy8
	6WxnJBoBM+B/zUuQHJk/7s7zawVvEphF40+Te4PPr830dHdc6Cb2VUcZQ9R+5ckQPV2jF9edfJs
	T1eeaFamnKzegaHEAc0dons063sFixMm4nqwTJ6lQw+cZREl7VXOqGH5jf1z1BXt7Nvgz+tuCj6
	MXbmsVE74psv6+boq8o4+EdQryDgtf9SXYcmsni3rxa5LtRs1LmgDChM/uzdAQUsVoPijfs3mWq
	AEYVUYaciBI8nBA==
X-Received: by 2002:a17:902:c102:b0:2ca:4bb4:4bd with SMTP id
 d9443c01a7336-2db294d1416mr11909045ad.5.1788880371498; Tue, 08 Sep 2026
 08:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903215606.31633-1-hramamurthy@google.com> <923eefe9-141a-47b7-94c5-c91df94e66f6@redhat.com>
In-Reply-To: <923eefe9-141a-47b7-94c5-c91df94e66f6@redhat.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Tue, 8 Sep 2026 08:12:40 -0700
X-Gm-Features: AcwNN1W-djDon6i2Oxz6RcG_IKMBsvPvG6L-ePIXfRp75VFE_wdPCqR4Vyc6SXM
Message-ID: <CAEAWyHdvav2Yd1qjt9Z+O0f5OAN3OKd1y9OPV=VuASLXYbUdpQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 00/12] gve: AdminQ mode related refactors
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, jordanrhee@google.com, willemb@google.com, nktgrg@google.com, 
	maolson@google.com, thostet@google.com, jacob.e.keller@intel.com, 
	debarghyak@google.com, kees@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 3:09=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 9/3/26 11:55 PM, Harshitha Ramamurthy wrote:
> > This series is preparing the driver for the addition of a new control
> > plane mode(MailboxQ) by commonizing and reusing as much code as possibl=
e.
> > MailboxQ is a new control plane infrastructure which uses mailbox queue=
s.
> > This is a new control plane to communicate with the device when the dri=
ver
> > is running on bare-metal instances as well as newer versions of the dev=
ice.
> >
> > This series contains 2 main changes to the gve driver's existing contro=
l
> > plane(AdminQ):
> > 1) refactor some initialization/teardown path methods to make it work f=
or
> >    both control planes.
> > 2) add gve_ctrl_ops structure to the driver for various control plane
> >    operations
> >
> > The refactors are mainly around the init, reset and recover paths so th=
at
> > functionalities could be moved into the control ops like 'set_num_queue=
s',
> > 'set_num_ntfy_blks' etc.
> >
> > This patch series only sets the control ops for AdminQ mode. This is
> > intended as a preparation for adding MailboxQ mode in upcoming series
> > which will add the new control plane infrastructure and then introduce
> > the corresponding control ops for MailboxQ mode.
> >
> > The entire list of future patches can be found here for reference:
> > https://github.com/hramamurthy12/linux/commits/gve-mailbox-queues/
> Imho the 'medium' severity issues raised by clashiko on patches 1 should
> be addressed in this same series.
>

Will fix in v6.

> Please note that you are supposed to act on sashiko reviews, see commit
> c82ff94592fb68f529afe63ca7f5ddb7dae4ba83. Lacking such feedback, I'll
> tend to err on the safe side - i.e. requesting a new revision.

Acknowledged.

Thanks,
Harshitha

>
> /P
>
