Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E199C43B3F5
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341258; cv=pass; b=P4UXIPcI0HU7ci6lXqe4gib9hTDf/KeKA0vnI7gTm1BMfG16eLSkdjy6RXdx67TS1nuHzoxczq887lnYsRJgC2gBs4p405O2xC1YYGDNf4tQoE+04xZo0DxnPXJDRUmzWzb9rGI9JuBA/ijn4lnw8U4gcNcpfTHOrzp5eslWWdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341258; c=relaxed/simple;
	bh=88zp11RG4j8iYFg2++fN10FbqRpm8U939v69/2jFPCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HoGarSM77N16MHkirqznL+bUU+xgvp79O7OJf7EpusEtwh5i0ThsU31Hn7m97wwKuc4lOdHT9VwcQjDkO5g3t20x6GelKD+dpFU3wTQAkCRl0N3NRHnzlWgz0FKsByqJfXHTzMdHTINcYWILE4mDN56YJius/7YwRIPOZvnsKWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPaHV5sH; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPaHV5sH"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37a2ffee6so313806b6e.2
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 06:00:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790341256; cv=none;
        d=google.com; s=arc-20260327;
        b=qZ9nprcY+lO9Z/b741/a9uUK5J/8EbTFqup3ecBl9xm2IL6ITx+PZVtgzUIjMKKYuE
         9yhFqm+fDieHSvbD7HgriZj6hkpCmVAPzqg75pB5fe2UoXqyDyV5SAMNVOdGqltJdLUy
         1++u0L2Kmc1/JyllDCmFz72xKSWJXZI6Pe9UE7bJc94mfflSD+Hpz/7AGUZ16xNw0wgD
         nBTADZ+Y5LSIcGw7vx2KDUmTALaw1ez/mZieQkrhl+6AhVXZgDoYF0pDlCgw4CaGsN4s
         iEqxajoaHyzkv87I6ht3gXtggmdBCJO3z54dnYNQ1UvqsQTOBDvXonE6hfQ7E96YSIEV
         qM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MBaQ9LVOrjLaMIJyB1YHVFLBYO1gU4YEmH2n9HVOEPs=;
        fh=OsYXKoY2sSKBhNTThW9kucESC7dyZwg253Kp+7pxyN4=;
        b=HqIi9cNwbfyYPdt1FjHdramRkxvYLyPB28pKGn+Y5LecUwq8GIKT+qMMffKbARDBMu
         FsXUjubaX2mIeaR0RjZbQfIF3iXM33FvGDER21zwLAQzmbxfizCokrQGZUXLsePqlN1o
         YqrOk3fI6dfClxaOeV2wOlhJZOh1bgHruFes8QCFsIwG3HGINO7zoSRzhC6GHiy6w2v5
         sakrt5lvoWKykvjxCL7wQ7wr+Zc/bG/zfIyI44ZrNUeo9jcMG6li4/u6BEKtJGlpadO/
         ZUEurlHRxlLXn3Z1t3MHhYwN19nUXkhj3CGnX/SqdIQsPRK7HTJRCrZ+sWdcXWzM4+R8
         bHUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790341256; x=1790946056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MBaQ9LVOrjLaMIJyB1YHVFLBYO1gU4YEmH2n9HVOEPs=;
        b=NPaHV5sHKhSNySUlj93BDfUFY+mBMlrO7zMyiBAJ4LbqoDxs+0UkTfA43NhqsV5crU
         aDDxwYO/pXaogHmoRjEujZHYq50Zxx1aUp0Y1oD1RzHLJwih823pTtzpRivo1EVsY9q/
         Bvf/wViB42P1fQrwis43kuxsgH6vxhsggzzyI8DPMh04chLZg+9/JLEnmS7vMNoxDCXV
         QysVZkZcyqAaKq4z3tJZ9cJe3YzVfrVLVab6OQ8RM7OUFAPlMJUuW/GXjUu796lyFsPb
         CcQ9XO9ao7O+litldsTYKJ4v47zNuzApQuhmVDMy7OsG0BQx55kqbl7vTmORueuTDB4a
         aYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790341256; x=1790946056;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MBaQ9LVOrjLaMIJyB1YHVFLBYO1gU4YEmH2n9HVOEPs=;
        b=xbGD4a8AbLvbTGXRHgIU+oPbHyuRw7QhJRXBfr1H6KTT0fq0vDc62y4RKsCz5g9v76
         nbCxQ3duQdFteScGc93adGI+IcZrSLvPl1jHoweTgum+4lNHBgkuY9/dy5bBj3XVkamL
         riV2jS6sRqaXPofK4qXbuF2y1j60pGyL3OqeT9XA25UshgikXO+wwUUkC7zcydDDU0YV
         4th8uZ+k0tz2dvtUBlfftBG7//qC3zqXzJ4HUfhsrpprYqz32aQI3ESGVGsL0oNlOTDe
         zCOnCjxl1//b4ZZ7L5Ec3y9lwU83ielwx3OqCE6liFTy9rqyykeK10SrhDDvECFJn3Kg
         ls6Q==
X-Gm-Message-State: AFuF++nMmY8EK6cx+/kz0JUItijNDAVpLvSK2bXobpoqhl8FEgfy1xJ5
	82QtCMr1yHsLxQKDhuz++wP3YGQ4VdX5r5oXNATbxL5fzYhzT8TOP7igV1jbaVe1CNOcFzTU5xE
	UbW489mtyvhSnesaGuz4z7YipRggDe4U=
X-Gm-Gg: AYBFou3U7PxBbFvCGINfiPFdFTsdCM3ffyFIFw4zZjC6YGUtnV1NOdHDZEAlEq32yUT
	fMvSOCMkeyXagB88fXi6Kt2xtM1UCKxdiW9lF7LiW7Zyt0c/gPFaP2pegP4D8zPfJgKrudIMBtP
	I+gExG9NxZ5caNBtDEEuJ3zD75q0/E70Oebz9oj/FPtCSoPpY2UlhyuBYs8XGZlzNkRISHfe623
	wsovYUTQT1uE8YOSr3g+SgG6gZ5xPlazNXapy8o6I0UUgrSkM46GdBDI1iB3L7d/RZp5NSK17Af
	n8L+20+3L/6EdaSyCRzsUIzRQgC09DrHxif40TEqo1ZFMuzuaboEd2Lm+89/+yzJAJPC7n0yYdW
	INm8WmYqiJIthKsld12CgsjIugh1jCQ==
X-Received: by 2002:a05:6808:1a1a:b0:4c9:6b4d:f2f2 with SMTP id
 5614622812f47-4dc640ac175mr2018463b6e.39.1790341255580; Fri, 25 Sep 2026
 06:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923021945.2203368-3-mmyangfl@gmail.com> <179030278415.2160803.7209731671356572587@kernel.org>
In-Reply-To: <179030278415.2160803.7209731671356572587@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Fri, 25 Sep 2026 21:00:18 +0800
X-Gm-Features: AclHuK_s1xZW3aEfZCQ2YBSdIuy4mHtVdZ2xtFjyf74fEZZ89cQUVcbRlNpAk5w
Message-ID: <CAAXyoMPAHrfi9BpMxs6PRttmUx7E0tP4Xwp_+kwvH-SSSZ7P5A@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/8] net: dsa: motorcomm: Split xMII and
 SERDES port masks
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 10:19=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] After this patch, a GMAC port that is in xmii_mask but not in
>   serdes_mask gets an empty supported_interfaces bitmap.
> - [Low] Two comments in yt921x_dsa_phylink_get_caps()
>   (drivers/net/dsa/motorcomm/chip.c) no longer match the code after this=
=E2=80=A6
>
> Pre-existing issues:
> - [Low] The concern: the in-tree binding example
>   (Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml,=E2=80=
=A6

No real configuration is affected - xmii is not supported before and
now (as in TODO comment).
