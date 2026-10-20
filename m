Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792524538;
	b=PhruvgEs9jiG3PuMh67J5WjJU7SceZzAraKsEYPue233UJ1QWopGuDZfitU9tZdnhJXb
	 Qczgkp8Gx7BYHZnHMV2KI7e/q+TFGXBWvt55D9CX7/zahVJV3hNd81Dsu1nY7OK8u1IPD
	 q9QGRMNE7RFBqqS/0CIViGTOG1eHWpzFIW3wZwJ6jbL6KZh/1xmvYXT12JlTgsYhwyrtQ
	 geK6IELGE+A5debNfPVYj9yt2VIoIfXhTCX/l5vfqWA4PB2GiaeMil0cuh7DYHF9BVgGP
	 hBBv/DGBBq60Sha0dKxbEfI50c1KntL0HU+Yc82UNQR6JuWk6FQlTBox2R+NW149kug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=CvHTF2BdIpxsaRxnz/zRtanylYll0eUwMFDVXdF9DNU=;
	b=GXioufwd3PANiD/hJkC/sbJyAaXPOceC26lomBYEupGWIqeDv5uOj2IeJNJJrrfGpnJz
	 Pha6zonGlcYqjQXIMQ9iCY+de49HUJAM7yusaZaITRCYZB0wBx7i/XBAbK9+sun2KzB1M
	 Bo1oh+QbQcr09TUYxCte34xinBuIOC/txo8YqOhYQEhmzsX8mgJabxH2dPQRU/Y0t5Smy
	 SQzgReVEq0z+gdc6kzLwMhcobB/whB2g/YpWTANhf9jUocnC+ktO5uH2JS5BzJ/zYfw7X
	 KTbYKxTaZPC3ECi/kYyNcwNvRFOZ5c2HkAALtgf1oCc9lCMZwpIerECiK8x+3YcvisQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OHmmwVGl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886EB606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 886EB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OHmmwVGl
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c43373ae89aso433429666b.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 12:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792524536; cv=none;
        d=google.com; s=arc-20260327;
        b=inrveDWY4+C66YYsEXnkK/l9Ubkeo5B34ndhsnFdICgV0IFpyIS5JBJeH/r7mP7jxM
         wYNzohJpkXfSr8c4tnWFNPtxhwEuEt1UNhtwJIKza/qin0qIFfjKeHCDORRBMGjRAk7B
         sqt90V9rB7Zm1+xcphseeQ2v1oRsptBIpAB6dASWB9Zh5T2b8JFbxoGqTpp9LdAMcvKW
         OMNyKulbp77q11vfivs6nyu6LFVK/6aISAAlBeo5ae2Vdaas9uee6J2YdRf/QNHyqYD8
         XSO4BrXOL0VO8Ot9O9wy34dzMUyT3pnqGNsMmWD7xU6f5y8eELdpweZJaeohxlgEPyFy
         c9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CvHTF2BdIpxsaRxnz/zRtanylYll0eUwMFDVXdF9DNU=;
        fh=yvrLcZFlO9PdaH0haKQ+mXcCVpmf6VCrEhiUwrzFws0=;
        b=sy5mR9EzRgZwGFT3QsBowiAPF60ybR00PHmY8m2UQd40z3tG3/o9AO5PJq/ovAyoI6
         8tZMupTGzQUjlcoDU0RCKJjOyZyiomzbQvdVFixV9lOgT79OTP+Nnh9PO0Y2hfdHkpSV
         yMLJ5YyoG554AbwE9MNwZ7vFx6J9PIwczzF4FTU/nn/ihR2pycznnqC6UT5iVBCW1KeM
         PWLOaj4toGFet4ro+wWCs+f0SCMAjNJXGJ/FVh8VomPxKwcn/1bBRef1v4a8x4dyyYsc
         583RXoO7V4B/H28baSAL+/9jo6JGHRYtr+ZO0dYrZuOtn1SrxaBbPLrBLNBwOMAx+Uzg
         rbgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792524536; x=1793129336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CvHTF2BdIpxsaRxnz/zRtanylYll0eUwMFDVXdF9DNU=;
        b=OHmmwVGlIrv/Al6w/wEGq/QUIctnlg43nnJH3gZzYgBO4INhGapCw1TYGw6gHKoWKb
         PcE2rexk0i0GEbihgCQX0e5/mVToWDuyFwmp6WweolCeudeEF94pwc3MrYNOnvTN/1Pq
         yZJA9RBMVmM8Lmqx0UkX5B/d32fwGxXgaRu20mxJgJoKk0gx8gILlEldSysQkpYJy0gv
         0q1k0tRXsWBeuq3pBT0FGJPtIR2XuXqS13hhqf+zh/dRp0Gf0unBWOhHYdfwGcZpSLbD
         HBkW51bvEJ/RAsDlr2QWTe+qsLySZMPFgYz/kMZt458zUqD2fj/7u6ND798+ICUGd4mq
         AQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792524536; x=1793129336;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CvHTF2BdIpxsaRxnz/zRtanylYll0eUwMFDVXdF9DNU=;
        b=VEvE8m8vufqBHKB55poyvlPVD5zfRVXQHYS+D6b1u3oPjHCEUYyaDd9dZWdxYyopqR
         prt3F8IWYUi4L7p+g9sFv6KPDTesa8cFqWm9ebe7IZQDss2wxLNd1ws0WnNtFHzeLc75
         A1ejPAN7yVi/ecTq5LNwExIg+mfyMYPDecYqIwhNJ9pT2YgUJW6xSfQhRpnh6fCghp/u
         ATpzY8GkiSDFv2LJodoBXRXzKLXJbkDjHR/E2LLnmZ0TxAOK073ula956vh9J5cXBPdi
         hnO+wepCbpbP+zu91iCPkzwXWlVWd6rMzrH3bZzAj7vs3kUa86tXwL3ECjf2koBqPDK6
         GmUQ==
X-Gm-Message-State: AFq9FYKGgqbgp/qgw+sFuCyb1y3Vn9XuxDzIxOXOnxqxMM72WfqFrKT6
	HCsjohCCTWKaJfoHNFd2tVq3XN1fpex8JqzE1yaKkYPn4GrNHGixZeHDBcqB4OQ9Dg2wCfcRpDm
	WlUf0X4M6136My7DuEL9gjk19dzuHOoskyX5P
X-Gm-Gg: AYBFou37xjnPCP1vDh0DRPV80UJINxDBiTvoEY+qMCKqq9LZzCgJyzqXS+taoToKNeI
	gfftCjbB+GeUsrmeoojn1FO9zoLjgqViNUXl9ohbeZBDDZRP3WHzZ9vauOeQIQxQczkfbM66h9S
	tkK45Rn5Q3XgWIqXcftm/c2HPzB7+d6kamhuHQzyhMAWG583MBgAD8PN4HNisjcVdXeMwDMHt8m
	0H7Wp6ZVTJC2bxxKQjIAH4lxJcB7EUXGLn4drnSXRlSNCQPxfQCbYuBcziEEbVYvvL811pZ+++k
	+IDK/nBzjtrdr6k09FT4Wglxg0uqLLltnLK0ztof8db7Q8BJ4f/7NprsQe/IyjilrgRlr7+T34T
	CLwPLvrVt5seq8EH5ayGp1DjNLoeykBVoBJ72a78gUzwL3l1M1aiVsx1yWGHzqJJ7IqgyqqxY3D
	vGKT9Pe8KorQ0jA6a6wL738d35InZ/NbAbZ4bBqtenbA==
X-Received: by 2002:a17:906:4fce:b0:c44:9a32:b27 with SMTP id
 a640c23a62f3a-c4679682019mr14111466b.25.1792524535617; Tue, 20 Oct 2026
 12:28:55 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261011032906.1398174-1-dave.seddon.ca@gmail.com>
 <20261011032906.1398174-4-dave.seddon.ca@gmail.com> <20261019101906.6933fc2c@phoenix.local>
In-Reply-To: <20261019101906.6933fc2c@phoenix.local>
From: dave seddon <dave.seddon.ca@gmail.com>
Date: Tue, 20 Oct 2026 12:28:44 -0700
X-Gm-Features: AclHuK_CPviHQ-c0PGLeNDdN2EwJ8O1iZEYYpx2iQjv4lUo9MyDrQ6jjaitj6I0
Message-ID: <CANypexTz13nT_YhUNT9f8aDbJi3Gz+VLwHNTwoaEsLagT5ZANw@mail.gmail.com>
Subject: Re: [PATCH iproute2 3/3] testsuite: add bond slave LACP port state test
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Stephen

Updated and corrected here:

https://lore.kernel.org/netdev/20261019203843.3127235-1-dave.seddon.ca@gmai=
l.com/


On Mon, Oct 19, 2026 at 10:19=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Sat, 10 Oct 2026 20:29:06 -0700
> Dave Seddon <dave.seddon.ca@gmail.com> wrote:
> > diff --git a/.gitignore b/.gitignore
> > index e5234a3d..a16f6362 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -39,3 +39,4 @@ testsuite/results
> >  testsuite/iproute2/iproute2-this
> >  testsuite/tools/generate_nlmsg
> >  testsuite/tests/ip/link/dev_wo_vf_rate.nl
> > +testsuite/tests/ip/link/bond_slave_partner_*.nl
>
> Just skip all .nl files there
>
> testsuite/tests/ip/link/*.nl
>
>
> > +
> > +# IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE is a u16 on the wire; the
> > +# actor state next to it is a u8. Each row decodes one blob written by
> > +# tools/generate_nlmsg and checks the printed value.
> > +#
> > +# The synthetic 0x0100 state checks the full attribute width on either
> > +# endian: a u8 reader returns 0 on little-endian and 1 on big-endian.
> > +#
> > +# row: file suffix | description | expected regex (!regex: must be abs=
ent)
> > +while IFS=3D'|' read -r suffix desc expect; do
>
> That comment reads like it was AI generated. Wordy, awkward phrasing
> and unnecessary.
>


--=20
Regards,
Dave Seddon
+1 415 857 5102
