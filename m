Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3805C3B05A6
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790522650; cv=pass; b=b1H8PjfOdBtRizd7RwLcbN3hGs/kBbg5pRg2ClzRHGxmns7Yam56+a64jwk5OXrvayLPWw1pii3qcr619E0YdzpRsD4fmA9ldmwZLqtR4ExMSSdS2wGtk+lx9Mcbh0V2sICdaeRJNrJN6hHKzz2HIJ97aZerK4Bp08NPjKHePsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790522650; c=relaxed/simple;
	bh=IqYOXuenTrd/G7JC31ZlM5cYuEr0pOS90JESQYxp+5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWns8NDeS70Tg6l0eufLD9lBetubwq+24A7qRf2PraQ2BVy0R/ndu8QXALs1eZDf0OFaEBEo7g+dtpTFmzGG6I8JadUAZZl6SaFP5aHD3xvF2IcvaZ7kl9NFHi0A4BiAzAUFNf/kdndPoOhfdH9tXoHhII0JtQ9SOzoaHKzDjhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=bvDNLnlw; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="bvDNLnlw"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3a20f06cce6so25880501fa.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 08:24:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790522647; cv=none;
        d=google.com; s=arc-20260327;
        b=sFXbF4psAtpeZ4jsTnZkZTMKBXtI6ekmmErBB4Mmg8HRVqNJ8iTY4aWd7o7e+p1nz4
         XLeiTpwHLUoveCVEKfUY3cabGCtZPqRXbJtnx4ISX7OBslR1Mr4b89bVK3FB/njD54lv
         JvnC4nyVbX8v/ioUHFeyYc83BXcjx43LvQ2F8p7gz0ywF7uSV39aq3FQwqtFqVxoyUet
         jY/xU/GxcP76Y55W/oK4IGD8nLS2j1MTLmqMVcsu28Q2d3qGbISvSQRS7Bx2HeRi5sCb
         Sitgm16l/Wup//1xhqYDOL1OVC3aYqWdCnjqtFXXDVJ3gFR7XAY3n9orVx50T0FA2phH
         0boA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lYYzgThSGrD/5n0iLNuP+nmqXn5Ij30rBL7XkqdHCKk=;
        fh=/FCEeOiMS8m+kRIO4gOCiw27YOf5yAaPjL4meAdn3gA=;
        b=Zp+6gCN1V5FVWP7/NwySU/nSfwRutGG2clggRmQzcTqB1V3eBwPR/qG5+MGfWaFYwm
         9OmNJDIvWh8arPvXCICvLHHfyyQRTtF4yDJZSJ0IjAYdnby1W6mnXjSDh/fdipBRKMR3
         H/cJjGsOpZ6RKxDrtxh15+7wpIUdyN5WLggiw/AJaTBtG+MEiH8C92hMTU1lo1nTg9fL
         LQgxmLbIykhbj779vFIi910rYhHeImoXGeyTWSYSydAe1RN1ujq9Nm1DTv96dKPsBvbj
         tP42gJLg0cQ4qGQ48fYz5EJjLD6+BIjEe4ILtdiEqiWAklOnbXAn2nDovJXfmPQMm9Jn
         87pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790522647; x=1791127447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lYYzgThSGrD/5n0iLNuP+nmqXn5Ij30rBL7XkqdHCKk=;
        b=bvDNLnlw3JWJDcmPd1MdT2k8B/AD8S1/hBjBPSJfveFXjXweDtRMb6xHaSLFcvHEjt
         6hceiOSwN3ndIPKPTRB/32pmlI4+YDqNN+sDOcKC1rQGCzDtFsPOr9HQhltk2PXDoCuH
         B/VJXKsTUvALDvnAI1c1VlIlUOZGY47Lteh4Qh5aLu1vvbkOWw6Godf5Fp65Hnq/16/6
         0sZ34cy7So17e4pmIjOnFVt0YWZFID3UogeyuNN9qeWCLFNziTUhsrQDC8aE70EOf7sO
         u9IoXKkjPfhv/GtIJO52vYBzc6W+gjv17Lc3Jx6EXZ52ymTPadq6FT6DqDkGKn9xuI7i
         XnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790522647; x=1791127447;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lYYzgThSGrD/5n0iLNuP+nmqXn5Ij30rBL7XkqdHCKk=;
        b=wDly8mQSnI4DobYxDe8GgSKBGNAYMnCMhrutwZ7YQgFx5csVHnmvNFkUairGIq47lY
         yJCzd2AY6dd6aMoFhwXlJIUWymAVQZ9doBYPWQV0GFSe+X2oLbT7i11N/c0eSW5Ip1NL
         DJwed/XZfX2XtIoDn23U8FlYQZpC//LWtEVuj0qpPJnWjXcyuLJGlupI8UawpFMHP07W
         RJd7UFK5Ht5BI39T5K+PJGajXXIfQOD+6+BeqNKc1YU0sM73RaTaY/gqSja4DBZwK4M3
         ZU5tMHYLdSCpEaKCn/RlUn3jBVvd6jux+WaWp7gIZEhLeN5V773hNFpOX1w5LLZ62xti
         P6ig==
X-Gm-Message-State: AFq9FYJekTU4Nxb52HigIWs6mKnmMdCuXJyGxsya9VJHHwf4YhWNeOwz
	Q8T/NnPEPPGHKK3/svaqovO3V+lQYkHcMEp3wuvtwzXmUw0tRp7pEAdeRGEwQykxnYNcTGbwh1/
	kXkl7FetbJdKD0LVwqaspDJFhLBIu7teZMczZYK3AyKw=
X-Gm-Gg: AYBFou3/DMk7XRXIWdSRQlQxZiL+CrQPwzkzbXFHlKvlOfw6NdQYBcpWuk1nm0s5qbL
	P/SlWT+Sj1qwggh4dHKR84jj5FUDAzY+oxdSqi4zuUDFBney5EcvqJg+kxVlU+xvL9ZORV8n2sG
	pOPsitb+RmZeoPYHQ7efsPoeuaCLsprEGcYT42Zm1vHR4wNRIST9ZF2kmIfKirIKGjwIE8Bcozm
	tknCRPrWGD7JHradexTMBeoybT5ZEkXqUh0QRSXPrps9kU9B74tHFoXFk1O2S9pp7B4nSXRtNNA
	UNEA1v+pniU9ygM9EV38MmsOI7yq6qMhYwooOFGIXOtv3kyXLG/E7Y87PRgnI+h47hpWs/XdNkz
	4iEMBRx76zw==
X-Received: by 2002:a05:651c:1585:b0:3a3:61ec:43c7 with SMTP id
 38308e7fff4ca-3a63c2fbf19mr25857111fa.24.1790522646186; Sun, 27 Sep 2026
 08:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790266803.git.zihanx@nebusec.ai> <ce3d490f-4be4-7eaa-0993-c1e4d1fd863c@ssi.bg>
In-Reply-To: <ce3d490f-4be4-7eaa-0993-c1e4d1fd863c@ssi.bg>
From: zihan xi <zihanx@nebusec.ai>
Date: Sun, 27 Sep 2026 23:23:52 +0800
X-Gm-Features: AclHuK_dLGbaKOOdt-gDveLynvCg56unCBYk_KeFbEJfV6pwu-pvHxZdAFl9y-U
Message-ID: <CAANe3eTgtXLVzrXuXQykh67XaUzGj-kWKzB1Sp0fwT0kZ_74Pg@mail.gmail.com>
Subject: Re: [PATCH nf v5 0/3] ipvs: avoid stack overflow from recursive
 connection expiration
To: Julian Anastasov <ja@ssi.bg>
Cc: netdev@vger.kernel.org, lvs-devel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, horms@verge.net.au, pablo@netfilter.org, 
	fw@strlen.de, phil@nwl.cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 10:07=E2=80=AFPM Julian Anastasov <ja@ssi.bg> wrote=
:
>
>
>         Hello,
>
> On Fri, 25 Sep 2026, Zihan Xi wrote:
>
> > Hi Linux kernel maintainers,
> >
> > We found and validated an issue in
> > net/netfilter/ipvs/ip_vs_ftp.c and net/netfilter/ipvs/ip_vs_conn.c. The
> > bug is reachable by a non-root user via a user namespace and a network
> > namespace.
> > We've tested it, and it should not affect any other functionality.
> >
> > This series contains 3 patches:
> >
> >   1/3 Fix the timer callback race during IPVS connection deletion.
> >   2/3 Replace recursive controller expiration with an iterative cleanup
> >       path.
> >   3/3 Reject zero and configured FTP control ports as data ports.
> >
> > We will provide detailed information about the bug
> > in this email, along with PoCs to trigger it.
>
>         There are some valid concerns in the Sashiko review
> that we should solve with v6, so we are dropping v5.
>
> pw-bot: changes-requested
>
> > Best regards,
> > Zihan Xi
> >
> > Julian Anastasov (1):
> >   ipvs: wait the running timer cb on conn deletion
> >
> > Zihan Xi (2):
> >   ipvs: avoid stack overflow from recursive connection expiration
> >   ipvs: reject FTP control ports as data ports
> >
> >  net/netfilter/ipvs/ip_vs_conn.c | 117 ++++++++++++++++++--------------
> >  net/netfilter/ipvs/ip_vs_ftp.c  |  18 +++++
> >  2 files changed, 85 insertions(+), 50 deletions(-)
> >
> > --
> > 2.43.0
>
> Regards
>
> --
> Julian Anastasov <ja@ssi.bg>
>

Hi Julian,

Thanks for the review and for preparing the timer-callback fix. Understood
that v5 is dropped and the series will be resent as v6.

I=E2=80=99ll revise my iterative-expiration and FTP-port patches to address=
 the
relevant review points. Once your v6 patch is available, I=E2=80=99ll rebas=
e the
series on it and recheck the combined changes, particularly the controller
lifetime handling. I=E2=80=99ll also clarify the active-mode condition and =
how the
FTP path can extend the controlled-connection chain.

Regards,
Zihan
