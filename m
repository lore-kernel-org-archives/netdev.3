Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE4E3939DA
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791362953; cv=pass; b=PtW+AwApkADIgduGeqKBBrCLwKO+f4tHlR9Ge092L2NX1txQPQNGfWb5ntQSEkfD0pWftlhTp5WH+nqX/Fa79vxD+hursAiDOS2g9o+MdcAZSUgly7TXgp29zoEp7eK6xUdRndMwaDJSSKLLJ3L6PMSzex3WDTa9GSh3qOyJu3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791362953; c=relaxed/simple;
	bh=PN6EPY1yryWW+YLFcjEUwHC1lGp1pOZRRH3avkGam3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7roEkiAEoxVmPMU5bcmcJIKLLsM9xp7PZDhFmUKMS7CBZ61p8uiH2zJlEpxG/Mp185+VvBScg1licyz2/pgK2ezqFdWnm8RBizIP8lYEObEwJyEOzsEshvwr54tBwXJXFMrx+mB2dlGaSJZju3bMZ0yyxQzl/Qmck5oAYEOumc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=tXr3ugRo; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="tXr3ugRo"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d6d28aa26cso19359475ad.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 01:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791362952; cv=none;
        d=google.com; s=arc-20260327;
        b=I4T8lOmPRFIhcJx/Mkh5FhrmmuYWooV/5oX6GT2bt0elr/at4ETdvRiAMo/j67Rvkq
         BXhaXxT23qMLlVcXM7p6HcyKYNFc++etjJWVFiwb/RJHGgyVqGqyYnBfgmm+/xMA8d2B
         o3hOaD3wqBDxvTsMChYTQjEMUl8fAZTGxb7qT4W4s6WLvT5hkKZtjxcxe5clesYLLvUP
         yJzKS/0c9trgFjQVtix9QTfwX5BfblFCCrrLkP87AqFKCtpMD6a9/Bi/lLS+sjIpZdk8
         dWRjqWeMmYPnjp0+hq50L1EI21LWYnBnCQzP5qmT+cWsjYrHpaxGoYM69QJdP0iveeSi
         j1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7mWXlw8htwSt3nqOewVTDtCFW9iqaV8AEvbO4v+RrdY=;
        fh=sGDOPBtEudTWFRw+nowOmKmZU4L6eJkzULalwnma2Dg=;
        b=Kn5HoJBYiPLqwotu7KhqSn8J0XLoGGfQkzVJYG27OMSPkN1TvWXTdPZMPTglzWK1mw
         9MMT6O9yupMoPHfikjDFIxaEsIuMYREv1t7evMyZRBaco9OAhnukWcaCtrjmsUCUnHXW
         mQ64IhjTzXnyFuL1hZMZAXjVL33Wh8QiYWF0KqJWXsNpXdmUYoGucksrCwg1NkltMCTg
         KAZBwEenkPQqH2M856pBJLkxw4OJ2MyKhviuFlPMdC+UoHv9qdGWv5T7IuPvIotivgrt
         W1djaHOdAxdomH8a0L9O8h0vc30PsYTJHNUKCi4BGPwBsilaL68kaD+jNecOIn7SbOoa
         NOtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1791362952; x=1791967752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7mWXlw8htwSt3nqOewVTDtCFW9iqaV8AEvbO4v+RrdY=;
        b=tXr3ugRoKe0hWT7LoaR2jZI9AFLFM8Ywg/XZtlv5uoGFG0/X5kVrerfFtPFhrztc9Y
         zXfZT1at1usZPohxymMMcmCWZrPioA0jzhtvI1Crs7WHaJnGN51lzo+n+r2OwSmH3crM
         KLpUN40rXDWUqYg2498yA5PhCbMBYiUZGeKnS0nnembaYf609Ug64r/OFN9G1hanDYfF
         2b75T4pUHs9kPBZKJl5XdT2k02epCtfvXg00a3NOSA3RlxzyPMgvAerdwygXVXYS2A3t
         C4AjsXtMH6K/bfW0Xg7utkV2l26mAhGI/cRRFPnDa9WhWIrkQ01CN2AAdBS1WCku+vjr
         qc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791362952; x=1791967752;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7mWXlw8htwSt3nqOewVTDtCFW9iqaV8AEvbO4v+RrdY=;
        b=JBnaH4wFxQUX5YbV9P1Bs5Fbdcw82CXCoPpERgYJraxf8hP5N7BT4oOFjJjsWDSN/C
         25JbaKUa9V6wBxWbIsMcv3Dlda0Y8o4IbpdO3hTNpT6mQwV82bWsJtuDEAoIRiCnsiLr
         6LdSf1z5DIE9SLBOboLLkWOyKawn6DxoaZ6f7YMp/bJXRbsDFWi754lTDuxLFMvuQLJE
         9wiGlTj/vtZADWqT2aX+Bu9oJyGlxBdSgERqV3QXvpDDNYEGUNjjsyr2XMFQ7Gfn6jYu
         wSDpZ7MQeyRgSbjxQBbdDjgqltJh+vuNWc5HLUvf7SQ25BUHNxP95oJrHesPHjRkWpRt
         ObWg==
X-Forwarded-Encrypted: i=1; AKwUvByv5N13PY5nV7Q6lcgYmAtPjn82mRyqz/xaaWwvlqOf/c+hUdibVMcPznHl16kzufuzYIOBF2U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOrsY0X19C9VPJaZt0agh9Z+d4GSOoRy65SHYoT0Thwv6IHgD4
	k2qB5BRknVXxQBpQsBAYveSZ5QrBJ2TqThdQiuGuTzEGtw+kQxQ9n0u8jzTDEdrqceqf44sqX+1
	R8k35mG1odtx4X2jDMooY5dom2mBNnN73033ur4N/1w==
X-Gm-Gg: AYBFou3xcpjOlMcSST6iodW7LAz9iWMqHm+gYQRk/LNXyiVS1BDp7WYEiSSjL3KVWmB
	g8v2JCoN3pysvwk3ebLImic1qc6fQEbZ8sBeFEkv6XQnffr65R1T1ioHUSlJfUqARUuzdz5UaQK
	Va/O6PUuZEzw+hNBfX6+Dd2/WNmDN7ezyV0n6YTghgZTSiaDVYxp0vIcnNVmz6xTgrrEI8Ib72A
	KaAyO5CPxubr1vsNk5rRc1jMBoJgpIYmzfIWTVqqKH4l6fQIYrQVIV3ONKS7bF+KzA9IRw4OXIw
	jxq09LGqYpwUUyunmlcVu71ZSyVYArhQbMs9c4RzWR+Uev07323bkkY1cME9WBdxW/d5Qh0TuQo
	AOmq32wtsrW7vzBV/n11pJMlVPuGOuBvC1vY=
X-Received: by 2002:a17:903:2a8f:b0:2e2:cbf9:c250 with SMTP id
 d9443c01a7336-2e5ffaf23cemr14312045ad.5.1791362951863; Wed, 07 Oct 2026
 01:49:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930122305.293686-1-robert.marko@sartura.hr>
 <20260930122305.293686-4-robert.marko@sartura.hr> <20261001-splendid-athletic-coot-1bbbb6@quoll>
 <CA+HBbNEOiAw+_zzQco13nNzUPdGUgo+kjcRzLFEA4LmnzF8_=A@mail.gmail.com> <a2bcd146-0462-4ab1-b7be-93d6b4e05056@lunn.ch>
In-Reply-To: <a2bcd146-0462-4ab1-b7be-93d6b4e05056@lunn.ch>
From: Robert Marko <robert.marko@sartura.hr>
Date: Wed, 7 Oct 2026 10:49:01 +0200
X-Gm-Features: AclHuK9tvJ8qSGCNxCy6EHx93K-on75TQ8ncLTFdBZaNwxDWm7pb3b5jo-_JQ6A
Message-ID: <CA+HBbNGUbR3KeZMaWoBqEqMLMkELMLxuL4taCcOG7V03VsuUEw@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: net: maxlinear: add MxL86211C lane
 mapping support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, hkallweit1@gmail.com, 
	lxu@maxlinear.com, michael@walle.cc, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 2:33=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > +++ b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> > > > @@ -22,6 +22,21 @@ allOf:
> > > >
> > > >      then:
> > > >        properties:
> > > > +        maxlinear,lane-asp-map:
> > > > +          description: |
> > > > +            Mapping of the physical TPI lanes A through D to the P=
HY's
> > > > +            analog signal processing lanes (ASPs). The array index=
 identifies
> > >
> > > Are there other lanes as well? Not ASP? What sort? data-lanes does no=
t
> > > fit here?
> >
> > Hi,
> > I tried to keep it similar to the datasheet, but looking back, a more
> > appropriate
> > name would be ASP instances instead of lanes.
> >
> > I am not sure if data-lanes describe what it is fully but I am open to =
ideas.
>
> Analogue front end ports? Or even just analogue from ends?
>
> I do get what you mean with your current description, but i have more
> domain knowledge than your average DT writer.

If analog front ends are fine with you I would like to use that in
next revision.
Mybe keep the "(ASP)" so that anybody looking at datasheet knows immediatel=
y?

Anyway, I am flexible.

Regards,
Robert
>
>         Andrew



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
