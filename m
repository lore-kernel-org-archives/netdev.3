Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F195341F35C
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785278351; cv=pass; b=s2DqH1LmmLWP6VcwCnq/eGh5/qbMRDi37BTdY4UNCk00Jwki6PA6Vxiwmb+HPNK68kakClCUzPF+almUPi9hZa+9CNQMGAmSDahhTsNiLaD5QAbXOJceFEBCcKnwaawW0YjTrjZYIJG7uACdOp5T9SRVIA1gDQVpO4ie3KzFqww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785278351; c=relaxed/simple;
	bh=EAyi6L9No5/fx0fdOcqHn+474sy3i+zfCZSL00W43ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzEPe7JIk2tkqMCGf71nXJZA72SVf7vufHE5zyC81sIGbvj1Q5La4xQejZyAtgUhbNRY+Yz9/4c9X7YPxSW6cYCW1QNJC0nVNMRKJOHqtsB/7GgYg/90E7pOUtoffB+zxT8ffsVrcD9IP0H4GULM2ddlWr5cHoPZv82w7UnoMjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YWoclopz; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWoclopz"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so2174605e9.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 15:39:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785278348; cv=none;
        d=google.com; s=arc-20260327;
        b=QdxwaMWNYs7sSCPrJAJv5NwppYwUbQ5p0YxnTglVfW7cnSdJtFrpk0yWSowfPS10tr
         j41eK3sQuRChcLnA8YW8OOxcF45WkINUOZHURGEYZtDjv2BdoDgcu3PdvrB8ADdOCLqO
         CH9H4K5kbdYH6gxZbAQcgx90C5z1lwMlh5Zj0BfKm0NbNobyOAeZX5KENmsfUvoq5ix+
         jgVjzBNYcROL33FbIIoKqR3Vor7FcaXG/g0Gh8oGY+APWFDJTjRjkmpX1+r9/mywJoPY
         UjmowdIZkXqVrEx6TvX+2e+hTU8hndPfZjwclvmp/j3GHqa5rGrBv5f1EPV4AW5/aNPt
         5ZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EAyi6L9No5/fx0fdOcqHn+474sy3i+zfCZSL00W43ck=;
        fh=EjUXosBcrb6cNKPGy3ucMgZoiBeDyBi9JRwUWK7N5Sw=;
        b=AwzNw7jpFB9Dg6WHHwiRG9NZ/9/tllUYiVyCCjuhSb6stZJnnNBGsF6lGlAmgm8bXa
         RV/+Mztbgka5vhzvVr4aWbq0oJhlgc+5DJmggC0/cA1+q2nXcuTCnI+lj+CYHRnwaL/A
         gNc+aZNklF+cS21S9Et+dRuuXWd8c1d2tQCaf4b11vAkTjajz6w3DWhDs3cuWI2h9CQ2
         h1/bK8FUvTqn5ak3h8hSiJW2oEKAQh0QH7IFwtxob9UktoCE0t0fBUO2ibYeD4mcMjpf
         Ysn+jpbV3VIgZuS8lbGByk9gGIrDDHMHhhxCl85Kq+F3p/n2fM+AL973Lo2+BVWlDowD
         r9DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785278348; x=1785883148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EAyi6L9No5/fx0fdOcqHn+474sy3i+zfCZSL00W43ck=;
        b=YWoclopzcAsui40AKEhHWylyr8b48nO3U5NCZ88fRc5D/4rKqBUppuDIx/ML2bfyAu
         auE7QGhTCVOC6kWqHlN3b4xGBG992yh8W1rXFRAMHcRqYFOvsy7LlWQkEak6Djmk0Hbh
         32HM3Dz08fbBPKdoAYmOWlWwMDoGJaZXlQ1Q3AtcGXzJ8F0fWV5qizKWwvna4Up+fdTz
         kq7RH9lmFFvWCwZavd6IqghjcU9OP9bBpmiTXl1BzXhRIAvg/s+nGkisRCeuljcEODUs
         EpH0JXMFonib4x3R+x7QuDaZsjXN+XtAVySm+dusw3/IAqjhrIqgfujiE7tzVpi+C4Bb
         yeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785278348; x=1785883148;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EAyi6L9No5/fx0fdOcqHn+474sy3i+zfCZSL00W43ck=;
        b=Ay1jTxZcl1jie84ZdyQpnvEPk/YA+p2G1J/xDbM9Z81L7cLCUhnL+uMQ4efYmLc1yy
         cu63Pp8w/ainIyLAUb3wUrOk9KXuydhvUADzpmdPXo0rhKmNkNXazM+GJ/l/NcHUahWV
         Z7xxMnNKV9g4nTFaggk/wHvkeALwQ/X79B/UcqM6kyF8ceUxmaAbYBVbZSEXkUcgzQBu
         rAPqexkeD4AxU7pjVhXmBj44YYd9mlNKa3n98PPZPL4WWUxeX79JyqP+aB8atwEXUcD1
         9AsITEvC9Y8AmcdQ/GUUE37kMY7kvDzFT8otYBtdgY5HHMbksBR5EcfeNanVp754AC8e
         /gEQ==
X-Forwarded-Encrypted: i=1; AHgh+RpCfWfBU1tu3vxo9nJ5qTeVM3KFszFz4hjgyLE3FhjJYLVa1fm0L9J/Xc1wzH5cMw3TQhSn7Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWu1fKu3Iavd6r1yb+YSrGYVqIvvGb7C+uJDoDnfxvSb3rgv4B
	BblkIP/jxtVAH4cuSwylWux7vZWuDKPZ1+cTJrUjNGPYpZxfK1mB7bUxh6+tlmTWqX+lrp+fnZT
	QfdLeGqvMKlEAhpu4+jNcjnm2QL/7fB5nBesdExr3
X-Gm-Gg: AR+sD11etZzWcZh6OmTPP8LOYMf9YZGmcPHbhiDANpmWbPZFA5WDxlgyGB1zYmEG3DE
	5+Vz3zDeI5BmYygZBe/TZEVSYWNgPYqFPVc4CN2BWzqhFYTZQSKDj31NWyXTShsngW9dbPC7o5c
	9XG73mQylmm9QvX2w8g0RyTFRSWzYkRVIH0n7KrzwuBzWC/9o/nvllTTDjLfWYnno4G+D3XsBFq
	pUGZDrH2nXBgkY/jZ0xsfUUbfOx7GbenyQxecSSwG0LKMML7UoEsN2rPGeCX+pcb4XSBBRiPb2p
	fsY98D22CvMfAR/bHaCxDocNGsLPPLnGdUegSS18c2PxoE1nHSw2KuamiDlVuZIrU5fvX/zYnTc
	=
X-Received: by 2002:a05:600c:1d08:b0:493:e451:a9e1 with SMTP id
 5b1f17b1804b1-496c642d97bmr45881735e9.2.1785278347546; Tue, 28 Jul 2026
 15:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721063829.7d9e6c7f@kernel.org> <CADWJPTsP=2=JFE9Oh5ym_wz4vROEFOCqa+dyCLRymyYLRB1BSg@mail.gmail.com>
 <20260723103607.55debff2@kernel.org> <CADWJPTs6G7zy+9aLxz9QD9Fk1szZK0b-vEFUm2jxTMtxt+t1uQ@mail.gmail.com>
 <20260728151333.2d778f4f@kernel.org>
In-Reply-To: <20260728151333.2d778f4f@kernel.org>
From: Sheena Mohan <sheenamo@google.com>
Date: Tue, 28 Jul 2026 15:38:56 -0700
X-Gm-Features: AUfX_mypnR9XDPD5VfFl6ymyQ_3c5rLa7uWI_FIQZfdNYSp0opolYbPHEQqxq38
Message-ID: <CADWJPTuet6HTd7V104+MmgaS0EO=ZcLu=FiZs_c_CtX231w1cQ@mail.gmail.com>
Subject: Re: [TEST] google runner needs nested cases
To: Jakub Kicinski <kuba@kernel.org>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 3:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 28 Jul 2026 10:07:15 -0700 Sheena Mohan wrote:
> > The recent updates have been merged, and the tests should now report
> > sub-case results.
> > Please let us know if any further improvements are needed.
>
> Looks good, thanks!
>
> I'm still waiting on the device node, but I assume we're stacking that
> separately.
Yes, we are tracking that separately. I will share an update on
devlink support once the patches are submitted for upstream review.
