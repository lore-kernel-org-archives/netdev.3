Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521125111A4
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583684; cv=pass; b=aGf0REo8QNxSgDCawrGMfYpyyL0cc1tv96+z6izrF6ZU2jOk0pm8BZCdnR57ggGu9Sbtccim1KFkUfcvaycAc/HX+iB9B+uL01Ivvuo6eS3diMLl8nuWhPNxt7SaH0xTHEaYkGzbQX9YBO5Y3hsi3xWp+FD3/Um/2O+E9tcFfpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583684; c=relaxed/simple;
	bh=WX++E5xEJeqIDSZWEklAf/DjrawPVs82hVtYOhoGZ1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkiyLXzO6R45QFky0/6w2EN2JpA/4luf7GdF2zyB4sY/Gntien/e2N9dq8DwqC/iFWjUnK5XOoXBj7IwMDjvAuC3LKtDYXKuQRUNbKcqnPQj3fQVMZ+IxwO2QncYq+XcTRzMGEr3qa/PLU8JKc0yrRsyTu0L+8PWTDPi+MZ6/fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/YIQ2d/; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/YIQ2d/"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e56a1fe83so1356949d50.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 11:34:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789583670; cv=none;
        d=google.com; s=arc-20260327;
        b=V4ZRsM09JCD8YAJFQHHz99EsS3PJ/puDmKEa6zrJLNceL14zTPhyp7D3Pb9uVLtwii
         2lCOGFsEol5NppmOmKE+U3ullpUL7Jbke+yYsQmkvpEk6BhpYyd1ZtV0VGB2qJoBbd82
         khDyyyGfaoHLWON/Ai/s0P0Aa6DXjz+5kyAfxY6E40aO82pVJ28hD9N6g2eqtZy6N2Du
         uHLtvnHQTdM9gUZjHbtpwtn+8e06/jUJw/9wVsQkTIKY40fHM3aSXVzJ+iKn72raonHU
         Byc/VgUBlu6rhe87efdp4E2uSnDWUNjOU/Fb/4wtSvE/jvYtOco3X47kHlJtWCHx8jq5
         cUHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XUCrJE9F2Ij1zpRepMcZoDkpmDPAIlT3nX+Tr0opt+A=;
        fh=teMqdaJ1pwc5P+NTqvhPSIFXG9Jn5KCViXIpqzkQAdc=;
        b=HB+ISoROgORNEsAuaPSkHX4wcFhRk5gwM97wGUdyNAI/hbhfs4eVhfbc+Heh2Egwz4
         fiOdv0hPz69MeD9bgZgFGMP9uh/RWvlLJGrzAbo6B4Y0CRcvQXrq1bmMklm7rrBnb4H9
         I2uGfpsSKJRreuO0+1ylBl32/G5M57sCM5xUy2OLaXozjzlecS4gjkT4PY+aDJdFYsZh
         ArWdlNOW8KhaELNDZgf2tBhImVo1zy/ugx1UV8kNZKzzw1os8eQGyTfb+i5yA/NsAqSs
         AUPZM1XhdG/lz+u+0ca/sbAmzg/NisRv7r/00mkreT/6mg/8J1lxZNmPXIT+8XzerkDr
         bIzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789583670; x=1790188470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XUCrJE9F2Ij1zpRepMcZoDkpmDPAIlT3nX+Tr0opt+A=;
        b=c/YIQ2d/49UNIy/fXV+7kX9r537D6c1u/WRbRDuRTvOMPdbZm2xOF+mixkZLxgz4p1
         hr54B/J0iGBdXQIi+wO68IzWxwAcH5LL7y0kudQWavGJ4hNs9BnFCSVDhQy5RnqHvtqc
         9VMi0NnIQ1GehF8eYK4I4JvbMBz8iRTyQL2Um4nZ2Ya80ru/r1hBj7i6HMAe6M1WESZV
         UXe7p0RRvlbcFIdfBwxvtPYQb7/u2o4npUehNLUzqDYw8gYVGHCiufyCHbkYCZHi3t/E
         od9r1QJjcmtgxe0M0zl8ViJthZ7biWzy6TS51DsoSY2ivC4qcF9NxEnhDo7ajjNE20dk
         cdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789583670; x=1790188470;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XUCrJE9F2Ij1zpRepMcZoDkpmDPAIlT3nX+Tr0opt+A=;
        b=xWRRxKY8OV+sO36IbSAQU31njF9sES77QquIx7GgClnHUOd2xScv+ydDdTwpoguQOF
         azS+rApjK7Q99Yp6Gseu6LsVgRKCouoNMD/CXfHwUC50Q6mfnxfw8by7pM5eWnrnJKaY
         y6H+aSmBKGScT3/FyPCwhnVbGtqDPyFmIDJMEJ0W3TROZh1RPeEEF/g+RjZC6kQx57N+
         PeGIYg36ZIVGRBJxV4eWnHEstFoaj/NpN8yTJDP8u7fJq3GDdNtZQAS1W8Wk8kAvKoru
         qHPwNqTMPIc6fANuUsKHLzpPJiDBIqffcXzz2FL6VsZ8dqcadGXuEfOprB94ru39bDOC
         qnbA==
X-Forwarded-Encrypted: i=1; AKwUvByvOTBafTNBst7xGs1Oovu0M9x7qVeOM5tde3epUIDJUtoEbN3KngL6Bwpu1jnFAMgvfoeCg5U=@vger.kernel.org
X-Gm-Message-State: AFuF++kL6Nh/Xe8Fm0XV3et1j/wIDDRw8Y198OKkTdqxdkwdJ7rWSNWa
	K0vmMMcOHWGhKBRQmNzZq8kAqqtqVOsgBav+PkrXQpdEsnUiwfki5b4O8Ch5zX2rIvDwccZ3y6w
	iyj+3WQDMCowDkSwG0/ynecDUC4KoEP8=
X-Gm-Gg: AYBFou3meS1tF4DcvCTsr3VzKoEw8AFGr+ZaY7MNhFhcuZL/CZfd+ufPQfkk7E1PmsB
	/nlsU7tWIux3LhMBVbKtuiwBuNbQqjYTGyYAHgm6O5fYtYeH0S3+y1y93CvcK+3/PDXSK5XwPt4
	ME1Z/3B3jF+1HDpdbMlv2LYuPTGhKUA1Z+das6p3RboriyWcRc8uyOUKja1jk5jBj7Rqu/xdeHO
	j0gPalJ15yqyPca0jUTncZUYwKiDw86QZnYlRqRPVt7+DD5k/a1giM+MEWZgj9Np9ip3e7X7iXy
	mj+UQYl9kQO5FIzG/LArQyd3iGgjAEXnLFdfuru93Ee3Dy0d+eIYSdzcVRimjAn0aYPZ6ShAorq
	Oq1s2NNgCVtsoL36ircS75XBGvv4WlgLjJ70N5JKQqF6qXjQhzuEzIw==
X-Received: by 2002:a05:690e:11c2:b0:671:1ae9:f20e with SMTP id
 956f58d0204a3-671631e2319mr1501968d50.27.1789583670174; Wed, 16 Sep 2026
 11:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d5676b70-f60b-4ce6-b6e6-de564d5c0a29@sirena.org.uk>
 <CABBYNZLKnQsypBR8Kbx4QFL9KfnVXRhO9_d5BHYQCabVZSY34g@mail.gmail.com>
 <064ec40d-66bb-4f69-ae1c-65cfed3581b4@sirena.org.uk> <CABBYNZJWcrvkx=6DekHxZzcrGjHwiqmSuwXqzHNV1=7BctThGA@mail.gmail.com>
 <aqnMueXiCztLUn-w@sirena.org.uk> <CABBYNZ+A+bNZ0THj0EZ4KfMj6wPMhD6hvbt5FP-exZnqxb4E-Q@mail.gmail.com>
 <6ce3c671-12e3-4057-9610-23efe14832cf@sirena.org.uk> <CABBYNZKiy+t_GC9dL6nraiH26m+2U=kuAF8NMAPNW-BhtOSovA@mail.gmail.com>
 <1add998c-b408-45cf-9442-0fda2674fe32@sirena.org.uk> <CABBYNZJn-ZYkX1DrOg9QWQHLWP_Pzh62M__X_jd0eXrKQx-K_Q@mail.gmail.com>
 <6b74cabb-daa9-4598-b118-6874f7993dd7@sirena.org.uk>
In-Reply-To: <6b74cabb-daa9-4598-b118-6874f7993dd7@sirena.org.uk>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Sep 2026 14:34:18 -0400
X-Gm-Features: AcwNN1WC3qEsPe9p-Vk0Sh3LOaPi39FeqRP44hCRDvkWBIOIU7sipBOD2cP8HTk
Message-ID: <CABBYNZ+Nj3x9K1AC0FtcSAG8OaM7tND8+E5UkDzvshVNrRMYRw@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-09-07
To: Mark Brown <broonie@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, Sep 16, 2026 at 2:33=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Sep 16, 2026 at 02:30:30PM -0400, Luiz Augusto von Dentz wrote:
>
> > Fixes tree is in:
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git
>
> The master branch?  There's also a for-upstream branch, though I see
> it's very old.

We only really use the master nowadays.

--=20
Luiz Augusto von Dentz
