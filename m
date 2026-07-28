Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD0A14ABE
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785197229; cv=pass; b=X4umKioy+wZUYzullDeB1Ux2BatstqDHYNZS4peiregW+Ss3R6hZJuwgyFoT6lEw0k06mFWrV94ToOC14rSjI/ym4mh4iVw8bXF4CrtpO+6g/BYpZSspXDAzovLN7QvTT4/BfOy8hmBJuJ5Lthqzo8olqtMe4en7UqeFMD/fN/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785197229; c=relaxed/simple;
	bh=UbX6uSn8QiIfHMG/M4f5YR8NY2BGATDX57OPgoOAdTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLfkPCa+Mghk80s67daGkOGTpB7HnU+HwQ126rNm9ZY2MpQqbAqc8ji69iDw2NGm2+3iiZ7oqBV5/qTNHPIs8KF+YXqgt7hPib+RC4qYc2PfFsUHLSlWNLyaBxVGw+l2IGuJL+urScEv7rAsu0geefZ5c/lUgPfdz+6KKF4vHaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gikSNa84; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gikSNa84"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69c7ab350e9so4842490a12.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 17:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785197226; cv=none;
        d=google.com; s=arc-20260327;
        b=XpgXTQUrfpMzHtJ9nmjQqiSXSO4kH4IJdBSQIqo5Fyf/UQO3fbrXEYTrbiVAVFRMqT
         MDqi2noj2ZdppNwwiw/tE9638ugkOcaPvekuG9Ed+g1rgOq041tMLj20m0/oWpMdiON7
         roZ+IyG6vw1t46B7HMqf0XUqZb15Hci3P5gnkSYdlXJgFcvsAuJldn1Owo01AZ8ow/nF
         XGAiv0eDlahE0IcOzPaV5zdYNHdIqUgCb/7cFKcVew87U6HP6pe95clYIlU+iu0mkcQA
         gvX1N9y3VKWvOUoOwr+rngq/hE6yZmYT6dbdae18sgoLpGeIdUK/vnYs2ex06RaWDOVG
         +wFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UbX6uSn8QiIfHMG/M4f5YR8NY2BGATDX57OPgoOAdTU=;
        fh=ETxg6XxiaqxleFava/tEN4h+aMyzLwdA9kObV96M+ys=;
        b=h46IAWYs2vNTQ56b6y9p4vJ24aIn+uPQxH0CsSb1ZxXKNKEl+Ceo4k6TU4OQtBr8xS
         T4sCHxVvJVxyVZsi6T+sEdxtWCqGMQiNUky3nDsICy2xF4thgoFwjhBfXIOn7Rjy81H+
         YCIsQWkFfyfMLqDwnOusJOQAiUOFnvkVMTILaAy9o1rJS4b9wIRxN+r4uxWiUDAy0qZv
         xXTn49aWBBvnBeg+JRZByDPscpOpiPT732akEwOZnLf8YGlz+yqCDItBMRy85NXDwk6P
         1CG469nOKpsOkcTq9GhbmvFQJ+3V5qfut/ovfTh6vkoBbss+//Cy2JzzYJmKyMIu21mC
         ktTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785197226; x=1785802026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UbX6uSn8QiIfHMG/M4f5YR8NY2BGATDX57OPgoOAdTU=;
        b=gikSNa84vt/8MRKr4Mol/TKvEFV5UNZbPV8y4Ao7DrK7GmwnCRacRvayE8nPiFe9Gp
         N/0IGZs2yUwmiSNa4PU22Q+tA9Qh8pD1RXthUCtDby2pM4Hr1Z3CXsDc0Gf+cFUEkbrP
         wSDvu2AvyDFYhJVK2RrB9kFQuXEPTv51utf/syNDxZG8jBIgB0Mg145uiOWGv0Re1yLr
         nG2s4JBSH3rbNdusrlAgRVGd9P/8VFK+fR9My6kHq3Rml3i3Lka3E95Rtfl0TzM6rzrR
         k0NDFrHCZygBaZF3YhvkNmkJ8zwC9YTYG62VbuwFuH3YUSfyCMwctd6Pgj8v9LUwuZKt
         f+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785197226; x=1785802026;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UbX6uSn8QiIfHMG/M4f5YR8NY2BGATDX57OPgoOAdTU=;
        b=R3A6skRPwvKVbxWOdlec/LkkkcBDoYPnN5Sjl3hV+zegbrG8uN15OupZl4kkuAwma+
         2Vc1JA0DiTLvcN3UGlNk8fe0RQ2J8tnlGj/vuFmyq6lC/S/evlLAPeWm47O0fSa9v8MS
         WmrV0G9IFsincZCwUeo6heuiEnp7bCIOGtg72iOrMU/g0g7ZADZE9ifl29Xqkbl90ZOY
         UfKuvZmvGP+k0rsiP2Su/GKXKNqkO9BAnWb6nIdqe8Ohf0s6Oxvkfyxw7eQ3Z0bgtzsU
         Q+8tzq0vQxx0pVbM1ceuM11fLjwzbbpVDc5vTCOWztM/D8FKJriteL6RQrMuOydoOygp
         Ah4A==
X-Forwarded-Encrypted: i=1; AHgh+RqjV7OaP9adQKLCnX7TZStoNjDWQa4AoIklOs5vopo1o4F4QJjkmKXLWSnfi702665YJkFsz8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNOYJJQLtifJAgj45viL60tV5ROxsiGtCZnZVUnKAjoA37RCsv
	d+CDvI3L+QMk2owYWUgaG5sP6Lu4bWpRYtkXcN2BzqAYPqGo8tbNzqKHeivq/ycLw3SOd0FU0En
	t9fgUuK0QwZRI+6RdgK8NNj5AJ+g6088=
X-Gm-Gg: AR+sD10Qwp3rcns7WMzNivynq/fJwwg4CLlANYElZWl2FSsMtCQ1mhjPlwS39/yAq3V
	4z0AZoOufnf1GqngzGy97s3X4nDrbH6YBvBmJJKMEFVur2VZgGx+aBFt0Qz/djSzX61KojAIhpj
	RISSTASAlsZ7hbLUbFKglHD9AEI9UwnQSGH54NOJv1nW0lW7dYAO3M1iVV7bG/Tm6RJbetHuBX/
	my9p3nqm63VBS9DDM8YTqfNXU0h32aEZyF0Dbse62S1iykmF6Yt0OGLUOZRrlAQK03SGXbDvYCG
	tueREcMw4GXoK/1FP6s=
X-Received: by 2002:a17:907:3e16:b0:c12:6bcc:a3d6 with SMTP id
 a640c23a62f3a-c1f724d48fbmr1625266b.54.1785197226398; Mon, 27 Jul 2026
 17:07:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-realtek-maintainers-v1-1-ab501adc0cdb@analog.com> <CAD++jLk4uEY_7YpZkzt5jESDU+kOrX1z7CfiEE7EYKKQnJKtnw@mail.gmail.com>
In-Reply-To: <CAD++jLk4uEY_7YpZkzt5jESDU+kOrX1z7CfiEE7EYKKQnJKtnw@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 27 Jul 2026 21:06:54 -0300
X-Gm-Features: AUfX_mz5HWsaqWyFwvtpbICUi3BBz5le3Ey2W__uoWjhp02jj-SXlNKfDZl0PwQ
Message-ID: <CAJq09z6046w4W1z7z+6uKG5f83_4zJ71aRHH7fzEEpCOsK9PsA@mail.gmail.com>
Subject: Re: [PATCH net] MAINTAINERS: make Luiz a maintainer and myself
 reviewer for Realtek DSA
To: Linus Walleij <linusw@kernel.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Mon, Jul 27, 2026 at 10:29=E2=80=AFPM Alvin =C5=A0ipraga <alvin@pqrs.d=
k> wrote:
>
> > From: Alvin =C5=A0ipraga <alvin.sipraga@analog.com>
> >
> > I have changed jobs and therefore no longer have access to hardware
> > using Realtek Ethernet switches. Luiz has kindly agreed to take up the
> > role of maintainer, while I will stick around as a reviewer.
> >
> > Also update .mailmap so that mails to my old company email stop
> > bouncing. Use my new work email for Analog Devices Inc. instead.
> >
> > Signed-off-by: Alvin =C5=A0ipraga <alvin.sipraga@analog.com>
>
> OK, sweet!
> Reviewed-by: Linus Walleij <linusw@kernel.org>

Acked-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
