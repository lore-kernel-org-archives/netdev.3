Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E90472F99
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820823; cv=pass; b=cnPtwLt6ThXMBVUVg6tTboY+p683EARBGtwMCQzs4Br8WeyUUIV3L5T0eiG1eQK6LyaZj0PeO1cANpnPsILBE0GnvqOErrU/TOzdAjuuS76No5zdj5mPOKq9AukQt8O9F9u+sb31n5/BB0XzKOucuI0/Fj1nZt0ciIj5drITk/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820823; c=relaxed/simple;
	bh=Rz7upTm4pxfuFzgQz7YjZms6gbEYTpepr7z+iFrlmB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGgOwON/FoSiMVEUfuuaHWpY5ScFStda3UfQIMhM8YCEZLuNAMRMtxBk1Upyg5BbDO21Z7tlVW9hjoFVQmQuWzTZcX7ExLTA6pvWEwVRZwLoWBXB+8AKNFb890UBB15oYcMivUz+SaA7r9f8wmxo5PJJXyfKAsjLaWYr7nXFN3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XepvaSm1; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XepvaSm1"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-963f63fe025so241610241.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 08:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784820821; cv=none;
        d=google.com; s=arc-20260327;
        b=evxIEkIUfbKQHx1P4E55FoY/98IsqAxGUpy9WjuMBLTZvwYbc+KnqEfTWgK9k5CWjv
         BbLuZnbvbKmRLEChLYbWryt0WWUL8Zg+cqPsZxLE/rXxPY1EnKzaoX4l36xCydAiqorc
         fcyopTRdynunfxcFlcveAKkAS1PtXIOxYrMDcA/oMA2tl8idNPXjfdHaxocPo9uEd2di
         QW2AuUc6YbznQnJvOQm0n91C1muRkwHJGptiCUnqhRGrx4J3rndPYAutm036azZVQ3JM
         oXKdoV/8YiwC1rfnTTM3QF5L8sM45/Jc2OKO/kT+4i6kR+5gijSjmk/vglHwED6ZJJj/
         j3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rz7upTm4pxfuFzgQz7YjZms6gbEYTpepr7z+iFrlmB8=;
        fh=ivOT3rXSc0SoP8C0kxVmLH2WZ8//Xkf8ZLOhiz1oJlE=;
        b=CtTMo61vJ1k+e7IoLOfMghx9s78I5NNITgmB480YxHKnZJjMaLxKODO0uc8qfvCBfx
         Tdfa8uy34YxSHTUfq3MzD+onD+AUie7aNeZ7cHuawBlnEY0UIWq9Wz3m9mqbpdYvbAYp
         QfpnNt9CfwPcIzfKPYeBw+4jEro/1bmjXKaFkn5SRY1IYWvugFCb7/aHYVJDMGpFlaSc
         noXZfdN4zPgQaJ/vLiXwwdd8qDxF+qgn7HucxGXzWcBkkYftG4v6t2bhg+R/7zdKq6Kr
         3eFZM/9IIMSJIPWoTp9u3KWzm7/mshqCpPnwL3VMhQ3CtJOefIdkveH27dADNEJBW2nm
         YHaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784820821; x=1785425621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rz7upTm4pxfuFzgQz7YjZms6gbEYTpepr7z+iFrlmB8=;
        b=XepvaSm1ZJjICMWMi7bJn2+veSsV13hGLscDC7OXQ5R3z9HwgYaU166c7bSMq7OfxV
         lJ0VV6vrqrW7LenMpXy4Inn/8TcQ834zwgllI6NroY34fBI2MRFiWo7jItiqhFclZmoh
         GBWIHyEj8NMK9ZsEt+s+iH/9XP4dVVSJHQs5E9sOPNqWfbt2B/JWBd8fHhGpklixgHZB
         f6JlyzQVuPThsBSy+6szs2gsMVav8Y2iV0eQ8wdg5Io6jY//FiwvBBSY3GAIax/7TJdK
         u6CV0cVap/ihi4cmOmV0MfYrwgrzHx+GwoAJpOCO7ZuuL/pocypwyCDFpmUebZbePPRF
         Twaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784820821; x=1785425621;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rz7upTm4pxfuFzgQz7YjZms6gbEYTpepr7z+iFrlmB8=;
        b=KzTD3jlvj6Zua8nvqC9aM2ItSC58osnIBgPpEmHb9/TOL3OdwEyM1Lk441hrXcSoXV
         fHuoWhzvvCouXV5lwryIJ3R16mhXPDhpOw4fmJ5LDT1nuvoarsTDAIZa6n9J0uJ3F3Yg
         aqkRIWYqkRdvNMHVDvbZrKU5SmaQ5pCiJ065uav6L0cYscIHG32Rq+xd9e9/qhruiJCy
         8Q6/716hFwXfEGmPS8pyGVvWLk2+/0fWBIJHZ3xWkIomR0fKn0BbPM88IiyyVntGn1UI
         qDASfWNsiqsxH+Bc7FwwGY4yZvyXJg7jhhmspBRV/5E4WQT3DNi+CmL3otBTjCFItnqA
         La2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr5sDIGpbTou4mu1sSIWX2LpfUJf3d7PRFEt+K1x+WH7DsSHO3e3Ib/duXaEqyK9EetsFL08Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+4oXqia4HlIq/vdgnnH2HbfE4pRXsbXtEVDQzMeYiS2agfAD0
	XCLFBfxZAz2m1+7uEOQFc1ZUhfFeVDqp1TGQzT8vY5ApiZ98YR1Gwy855aV5dw3ors16kNE4OuI
	+4vcMvTSIvVJ0fIcwifD1zLzL4aFmNH4=
X-Gm-Gg: AR+sD12QFw7s94QdeE7/yaf7UOMDnvFySgBr9Ni8yhcyTXdPtb4CPuhvctxJ25xnIfG
	gWv5moPB7p1Fj3EJpZDrZnGxuo4SBAEA6IzYe/P4AndY5EJZskr+9SLUsCOdekMfnxwc+1vo69d
	MIQCSp6fnhyj9wKAvTsTjJIL/koJM7CGsMTmUtwcMheGZokq9CaNjZ081qYDNW5sGe4zMwXP4Rz
	00WzDdRkZjIf3LVXd5RIZbcLpqhUi0W9dsBo7uVAFJoWVikqUpANjQVJ/k3wy3LGAwv4c29aGSQ
	mCwn2zfKGQ7zbGQlAaPxsEd10ffIiujHkNxxBhN1SXosboUTORoPvmhzqpJ3BA==
X-Received: by 2002:a05:6102:8606:10b0:74d:d2be:b164 with SMTP id
 ada2fe7eead31-74dd2beb556mr544798137.29.1784820821119; Thu, 23 Jul 2026
 08:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_73762ED1DF08CC9D5F5F61954B01350CFE0A@qq.com> <20260723072924.7db6b065@kernel.org>
In-Reply-To: <20260723072924.7db6b065@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 23 Jul 2026 11:33:27 -0400
X-Gm-Features: AUfX_mx90Lhga-KS7yDsLk2MwoKth3UsEIGFsDBzPx31uQtuZ_euYpTHkPTC9go
Message-ID: <CADvbK_fjH_XGMVjZGXAk_Zj6_GOHu3u2bj9wOSMRymwNMK-k5g@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: don't free the ASCONF's own transport in
 DEL-IP processing
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jun Yang <1753810072@qq.com>, netdev@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jun Yang <junvyyang@tencent.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 10:29=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 21 Jul 2026 21:14:05 +0800 Jun Yang wrote:
> > Acked-by: Xin Long <lucien.xin@gmail.com>
>
> Could you point me to where Xin Long acked this?
> I don't see the ack in replies to v1 or v2.
Hi Jakub,

He initially sent the patch to security@kernel.org, and I asked him to
submit it to netdev with my Ack.

By the way, there's a question about whether patches for security fixes
should include the PoC in the patch/cover-letter when they're posted to
the netdev ML?

Thanks,
