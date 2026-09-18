Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89064E50DA
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748701; cv=pass; b=uX8kvdSisAi+XdPfVDpRvWm+xZ1LSj0RBdWnS6MkvawP07DLpF7STYNUXFzqQF+8dpgkPM+Ll2fjUOWK8K0ngNp8j2WyD1QVNPj7+6F3gbiI9B1x56x2wNhLRISGtfx2Fm6ZQqkGKaGjhvn4JlhrCxd/l9sD1e8MmUrk5WtRRcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748701; c=relaxed/simple;
	bh=GyB+LxtWJ6Lbwne+97cZYzWC+/mtz0PeJakWuS8VxWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaGURuxVbwV0DL+k5uURuJgyj7U3RImeHwiImK+zANlgZPasleJ/rXOz8Y1t01M4C6oLDCYPD4BEaWqUfi9MRyPxgmOBifeR5TcKPHqKmxauoPMMoVQts50jyLM5/zlTGzJGwSP/oVtamJa4IqHhOmV90VQ8KfFARtaH5RIxS1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atk6CdIu; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atk6CdIu"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4678d3e490bso1506174fac.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 09:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789748697; cv=none;
        d=google.com; s=arc-20260327;
        b=bp6aJZYzA2iSmnV9mTzXn92A3ogO9x9LE+zwtNzs23gH/UrpLHUzCu5sasblwic6XN
         wp0P09WXpblIbjnWQO8Z+1aHhbXSGx0Z9ns5mXYAbggLk2UUII69pmB4xoGF8ASRFjiD
         eypb6WmPyHfaCcd8teseVCx881SJlN0dkvfx61Z3soOheVUnjeRHvOeaRxijKdg1NH4T
         oX01yYUKAp4pVnetD385mAUbJEk4jCbcIySS9nDcExIpIOEyhazXACyR70JcR3PA+5A8
         ZHCbZzfqhiIksB2S0ymMZ7wi45+Q7h3IPKNtn+bU+jeNpCIr56+WEO60EhTV1frieqa2
         npVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GyB+LxtWJ6Lbwne+97cZYzWC+/mtz0PeJakWuS8VxWk=;
        fh=E95j6uwIFtrCeqjeMpfcVno11LNk/V+Dr+1Lx84tfxg=;
        b=Hvpftzf2hT2jxpasJADsIowtwM3IPYKSSoli9dr0WasUOj6Qc3K3HrQj2j5ypE798A
         Q5SFUWUjCtHviE/K7XPvCew0oTQ02Teog1JWbr4ajQAnk1yuhFNPUYpQkFoQtkZ6ruiT
         VEl9BJGGmnXit9RA2mmG0X1TEW/Z2Rph+WXEbN4OLKD6lvXS2gD7DmZs0QJWBXQqkYyS
         38zSXjl1x9Q0Ov6ozRw02UUfc6T33xtMZFPksSz6uReS8zxZSOj1BgMTSqbSGgsHJkWE
         crRz6jOuGJFgaAS7Ry/DFt9QL8zhrUDb1TBvnUAVn1WGojmfpyXvIRcTqU3uJ1ZD5QKi
         hkdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789748697; x=1790353497; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GyB+LxtWJ6Lbwne+97cZYzWC+/mtz0PeJakWuS8VxWk=;
        b=atk6CdIunM6oWAXckr4IGh45HCWb/rOTvmf2cNjVwBPPN0OjaqoDcrbg03BajHBUO2
         caIWOyiy0ifnMiZ8rvBXqk8HnJLyOMEsMu8jbRvGvlm0aIsLEF/6J4RU1hHpGs8L0QMN
         8Mtw3zMKhw6F6vpeNcmhdgEAcYB4D4ZRq6bUfdgCdq8EIQuRrUXcIFOahO+woqlp0cj/
         kzjU5Ddlokjvv4jnIDz5ttUVi49PAYbXgrbZ1+onqG+4eRUT8geEknVfdrkhU2YjuNsM
         9n35U8x3ifX6uAvO9sx7FAKIOhLLF2vhfGU7zi095KUt/zOXzR2QcXUIr42S/HqBf2ZO
         2/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789748697; x=1790353497;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GyB+LxtWJ6Lbwne+97cZYzWC+/mtz0PeJakWuS8VxWk=;
        b=qE+2uj8YVh+l3ctTIQQQJgkfiaPzdkvPN6fKHnGaTXMUxxUBCBtZYQ27wDwql8ixsy
         0VZJHe5xmXYULdJcDPOmkvPk1dQDGkSS0BU8V+8SQvZtLEydLa0EREp0/2CTBRAUEVpJ
         bcMd9CYKdFbh43XNXruRMwATzJD5isyGhZzeVOuvudok++tjUx8LGK/5Pk/q5xp/OQBF
         jmjyvsqfBWJpi1rZfAX95+lEVpxfHfAgeiA1JoFIGGE0fMcmkTGePR5qW+Sbv+GhDbnG
         q6TbEsaEPrL2qowpD1WNr1qJrG2A3Of/7Qmf+EzRJTHx9ftCEQJEJEERfc7flFbhDa+l
         uJaQ==
X-Forwarded-Encrypted: i=1; AKwUvBz787yGVHa78AU+JF8mED1y/jI99/V7FZzQLUlaMhm9ush7PpFwFfTwH85xYho1Hzfm3/RKLFU=@vger.kernel.org
X-Gm-Message-State: AFuF++lg3ljkoH4iLLZhRiXWksdhRGjMxe7FIcrQUklCdaMiwzXl/+89
	1gO91h86DDJGEHAik6m9ThosHsvJiBdO2FudOYHmhLmzRHVHDZUFoDg+xVByJDC4Sf/VETfY5lL
	K2xvPgm6BGC31gTz9ijWzkcm4DQ+V+mQ=
X-Gm-Gg: AYBFou3najDXqLOJLOOFgxY5jRN59UctqJtKvIlLQK9cmZ0NfmFW3yeRhqnlXjahsE6
	SEepLt4hOvZtJAzzdpAz5YmYxkJjTPy+INUn4L7lY7df/s/8H9txNDnJlQQqvu+j4vB6qqJJGF6
	/EyWLHIMBbNZc6guGWKDRyu8OGOFd8TK3Yoc/5xYi+AhXwyTz94XXtEYm/CeeyakHO/Br2BsPVe
	I7dGSTu+wyKE02p5OWj+cPacoQHucwNMBzNsBHj7XuQSNz4dOuaf2lpnMcR2zyx00nRx8kt6B7W
	YEk0Fk85n9t5iduMpjzddOHXkPgUV4TiAkJhouuwmr0TlGNXS/v/u8q/ryuYMQMuPOK8wYO2MfB
	iEd1zSSEaxb6Ubv+tHYFbh8wGnBcrNhXMRW3hKAUpZHruM8wyflOp9WNMBXmWTxWJm8K4Hc/gHA
	==
X-Received: by 2002:a05:6820:4b91:b0:6b5:ec2f:3568 with SMTP id
 006d021491bc7-6c8fde724bamr5429950eaf.25.1789748695420; Fri, 18 Sep 2026
 09:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178942021136.7700.4391219358260544104.stgit@ahduyck-xeon-server.home.arpa>
 <178967952944.22033.10329187569173798096@kernel.org> <CAKgT0Uf2xJr5hD_yAtNg67-2t5XS5d-QBf+gPscPJe+L1Miydg@mail.gmail.com>
 <20260918161451.GS51261@horms.kernel.org>
In-Reply-To: <20260918161451.GS51261@horms.kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 18 Sep 2026 09:24:15 -0700
X-Gm-Features: AcwNN1V6mGqWyxQH41wnf4KTLi-FvDoyAGTvB5SW8PB9lFq2_auBppHf31qV76Q
Message-ID: <CAKgT0Ue_9o_dW-OJEJxJXLks6miwNvx8pA3Xuy8fBSXHRm6xFQ@mail.gmail.com>
Subject: Re: [net PATCH v2 3/6] eth: fbnic: use the Rx queue napi pointer to
 find the napi vector
To: Simon Horman <horms@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 9:14=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Sep 18, 2026 at 08:11:04AM -0700, Alexander Duyck wrote:
> > On Thu, Sep 17, 2026 at 2:12=E2=80=AFPM <netdev-bot+sashiko@kernel.org>=
 wrote:
> > >
> > > Thank you for your contribution! Sashiko AI review found 1 potential
> > > issue(s) to consider:
>
> ...
>
> > I agree that this is a pre-existing bug, but I wouldn't fix it in this
> > patch. I would probably introduce yet another patch to resolve it.
> >
> > By my count we have 3 pre-existing issues that aren't directly related
> > to the original problem. If possible I would prefer to address them
> > separately, otherwise I can tack on 3 additional diffs to the set and
> > resubmit.
>
> Yes, I agree that is a good approach.
>
> I think that in the age of AI-generated reviews finding related bugs it i=
s
> best to adhere to a strict scope for a patch(set) combined with follow-up
> fixes. Else a patchset may drown in scope creep.
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks for the review. Also it looks like there are only 2 outstanding
since Bjorn submitted a fix for the page pool issue already in
8e0b235bd918 ("eth: fbnic: Fix payload page pool error cleanup").
Guess I wasn't the only one Sashiko dinged for that.
