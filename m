Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF8D26ED4F
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 04:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013139; cv=pass; b=Qt8hmjdIJeaFLspIZxd7bO4r3A6y7kH3xoG5nyr6kj+pvFmtENiRa8QnyI7B4mNN7u4gnccFxYRKtZ+UnTiANWOWdhfzOE5h5SheIaBlt+FGBjGNhZ9mbbTzfoJDVDuzcqzVGa4XxHkB6kGHmPphcEUTd6SDxPFySYuZBs0HSdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013139; c=relaxed/simple;
	bh=cIB6oLLxIpfMMXfc6SPhaw9BgxUvuAuXYXicau/x3EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MM1zfS5jtpyNtpkY1GEEOEHlzezCzaXb9fQNk1suVDpRMktJVngjLkRFCO96JhbcgW/PADLEwJiE7DXM1a3yWEEZlYe5Q1eLlKCfjyzoxCMgT7rCyatrCbLA7+LcW23Si+1dltSGgBmvX9fd937P7+qgwHqbBWhaivAT+Yclqgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSIvP0YF; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSIvP0YF"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3a309f92daaso54179621fa.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 21:05:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789013136; cv=none;
        d=google.com; s=arc-20260327;
        b=ecN0jxZF62qWbZ5lH7BOYPhoFWHNhLzVCcSKnG+HNiEc6lRlzunT1Nx4n1gLKXDfWQ
         tXlqYDiKNpQCeR5r7ynDoFeeiUeOsNFxhlc1uHAO0adz0xl38rz8/Li+tdxpGfx+/eh6
         M+3lrIsNumzFS9eZXLVTckma0R+814pkEzqUVXhLoxwBZ+K/aAkx0P7AKEe8Wm0S2lXA
         uDSIjAedH+8XDy25nRcmU4Zqe6zpkYpWTAfPQf4Zfr/6GmYI/ORIlitcb9Cdi+aUt/C3
         b9B+lNjnhpAAlVi7QUReGRERM0thKjus8Uuj58MJ658RqlP1/5er8oz2OqKIB/RtaXXg
         vayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xDVcQUv0ft4THKOXTAkOW6jh8BrJrtEn9YRLIX/ZPD0=;
        fh=x3oHEBSrraUf+/Je3Ry/XcK3kSa/3ygOtk69LCcbZLc=;
        b=JHcJGmYmcniSmr+sSfP/4pyW+9giwZpmIn+3W9L6jg6R/V2TiBIAui58sMDI6HFTEI
         kQ8OPmLK9lVMumKHcKzkajgWMVD7HApicXFapFwtfBZkA0yx8vlZ2hsRXg9wH0pypB1f
         7y5sRzZCBNhI1c/b/1+DWSIU0uim+TubHn1GcGIXHGLzO5a7DYL4FKmx4AWLG+xJbvv4
         qgDtMdpyGvuWe7HIiLR+k1+fX0wc+a5PGgVeU+kTVlYAvLohg4bOIKKoIugWQY1DtQW7
         Bx5yYJiD2dZvd+EgOA8j3sPZzqaD/ECdDnk7UZuZN/IxeNE/SZgR4cxFwfDLwawhkBCb
         u5bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789013136; x=1789617936; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xDVcQUv0ft4THKOXTAkOW6jh8BrJrtEn9YRLIX/ZPD0=;
        b=XSIvP0YFENBnGXk/ya+4tmRlWSVGZd5JzXbwsFu2XXK8pvRxrrBYjlzKgsYF1Qr+2Q
         sla61vAw6ugcyj7iNPJ+g0rzbTeQX8KoqeFeyWXuC5KSxhuqX2XZOBOeyOmUGfPOuP6l
         HYiV2dq+UZZ8mKc8x2jVD0fkwW/ZtjiO2tZqZfMzGrdsdqJpSsMmaFlfhsqcEN5FWqMB
         mGF8FIvxGCzRhFtZh83gitciEnGm7mjOtz05kies4KsTAIKoR+9cN1UGPxx7f41Pt/r/
         EVKmd0Y3zlLahR0Eo7CKyAsdFeOCvgPEPVkN4qL09Q9BgDUbRj3kYLFOaTvCaYS+BtDb
         yfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789013136; x=1789617936;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xDVcQUv0ft4THKOXTAkOW6jh8BrJrtEn9YRLIX/ZPD0=;
        b=LNyeEj/ixCWhpQQTLKV42rsmrfix1yaui9Vh79xC2IBSCzyiXrqMp336Ltd29R51Ba
         m3CSKPtaeNR9nFUGLPQrQ/wOXsYdv90FMxSVdIr+TOkC9FRpQDIKk5S3nIPJCz9yhn1X
         1H2jmGvyER6/gvCUlQuc9JSTPBjAvozz6EJunmvPeoR886EHEUkuQNkgnqn1StRY06yk
         nGQdugpVRUp6YsGBEMqeIObnU6J1F0TVnMj2pmwT8KMTdbl1zyRr/vrxo93s/SMzWOIb
         6b2iRnuI0h9y9/2KgQe7R3BGnH9zEVdIDxfPHg3KPL+JYQYX/HQBPDx9NX12I/gLulh1
         xGRg==
X-Forwarded-Encrypted: i=1; AKwUvBzkcW6RuKiienQzaAz/Bds/ANyzHYReAUndeQ5Xu9D7ZersJ9M2uxme5YM3Zmj6kG4y2GFJjeY=@vger.kernel.org
X-Gm-Message-State: AFuF++mAd/iREWH94wJz392nQtExBlARcGcMWqOYuWdbaHiw5uNohEMA
	O3hmNNjMb7itWAphCM2js7HjDv6v5APFL0FRsdQO0OZRTUQ+3Ps2ujZ2rFO6zRSuI9/uQeEyxLQ
	pQxDzKvJcsXyhaTIPwlq62xtQUfVdVF0=
X-Gm-Gg: AYBFou1X6IEeMdEmWUIISM7DqdM5vIjdjTD+kIkXM7O4LXtunPu/KdKCrDkuI1P5Moa
	YiZhSDeMJZ5loif+JxTMukMzUsuOZTDgDyCGOaF9R4cjvOD+X4aArOfM/gb4gJ5EdmTqLvJveRO
	QsSBw+2fRNx//B3/G2F0IBGQILts73Mx/YvP64MqQD3HAa5qUfaa0BooaU7O+wcMny+z+nKIcAm
	cBecGQFZ1zTKtXF00SkknnuI/dMMREOVcHs73rEDGEZHSaRtyYiBj/GZWzZ105qVv3EFDpfZM0F
	hcSH0ypPQ/4pJsNlWqcZ4FRJ5FrSF6aMLczY2qgTFjV4e/y1oziGnkJkVO5CNfzCV/mm38I9cyl
	3dgXybracWXBvPuOR5tgP0FgTgN267hSVeD1Esf0xDg==
X-Received: by 2002:a05:651c:2213:b0:3a3:749e:319e with SMTP id
 38308e7fff4ca-3a3749e3381mr39434621fa.18.1789013135821; Wed, 09 Sep 2026
 21:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905093932.43726-4-sigefriedhyy@gmail.com> <178901169484.219967.3624591832079760064@kernel.org>
In-Reply-To: <178901169484.219967.3624591832079760064@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Thu, 10 Sep 2026 13:05:24 +0900
X-Gm-Features: AcwNN1Wyvr5GEUMi694_30SRPcVjVb5vZp8y74DSCcC_5qtyY0PjOtWZgmHeQ78
Message-ID: <CA+7S2v+7tGH2vRnN5g_oWLwGs=0JfFCX558+CgGOGAhWM6VxwQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] selftests: net: test AF_PACKET multicast dumps
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, donald.hunter@gmail.com, 
	edumazet@google.com, idosch@nvidia.com, kuba@kernel.org, kuniyu@google.com, 
	nickgarlis@gmail.com, pabeni@redhat.com, sd@queasysnail.net, shuah@kernel.org, 
	horms@kernel.org, sdf.kernel@gmail.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>- [Low] dump_mcaddr_l2_check() in
>  tools/testing/selftests/net/rtnetlink.py dereferences dictionary keys=E2=
=80=A6

Same issue reported in v3 thread, already answered there.
