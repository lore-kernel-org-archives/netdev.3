Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846E5344046
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 04:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787371378; cv=pass; b=vANY73c1wqKfBCp8haT1rLSIlfsLUOgSDiKZGR45w2Tw0qBJVu19DMzSxfB1/6Te8PPp0hE/SV/BCM3eQ8pk8uFCOyG8EZnKPu0HDf7a1fcxjn2zZHCfMM7ZIKx7dGxpd705NDlQHtttetcI3x/I9wfP4wo8+lPB8uT72cT4ooI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787371378; c=relaxed/simple;
	bh=Jm0QsIvOyFEtY0yZ3Z8DFSW1RbDxHfe3nBSWKOek2uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4y1grVgpzH2bdfDbvD3n8CBAkD0tIUnuAH0Lx2Kr9yPhTFt0ZLnmu7JFNZOQC3uCLgEA/yoZDHgKxHI3xvmTwxcEPZUco15C6Dk/hsjQEgVzqbzkSG7OjGbmDY8t7r2SFq4MPFFePH89JdVWKPiEqU73q0kRs8F0LnginXK/uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=fgBBVPMR; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fgBBVPMR"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a41191c9a9so3477144a12.3
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 21:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787371374; cv=none;
        d=google.com; s=arc-20260327;
        b=XAAERaMRnn26419heLsldXsM3lNc3r6nqz6xayGswZ023Z/hH/DRYbso3Z8duYVmPW
         Gwyyq0xe0K2MQRuF3Ugh5hq+u5dQLL4yx0bB6K7AhJ8trQ/I6egSHm5osFKFB/EabZYL
         hMKAlDTd4X/HMhCUYdxbfEtzqGGxsnyyVHNG0y4XK76brq2UDZXM6pU9V7IpxE3qXFug
         pp14UYbrj54Lv4nhWSYZQYD5x1xdjCeRuyieYj/HdycrNVMuhpfnz+kkGWUuiar+7LiP
         TR4Rf0ZYO9WE03H2rx17cLaJgjQjfK67Mf+KSRJc6OxIbqWWn3WUZ88RRE8ieWfnpls4
         1/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3KcjaDy9kvf6pEFMnDiFeqRoRi5mZddMWsHyqJUm71k=;
        fh=+frFW9wObLteWkS+ywVyftH44pFMJx6arU9T8Wl/XdI=;
        b=VzPwIm1A031X0RiRMX2qXCJ6ZKef30oE/eNlr1u1bomLIF1cO1zMjviXhLll43dtCi
         Z6EG1mIxPXUz0o3OcTx/qF4/PB1dkYXSU3FPoF3ingZv24+MsDApfE8eRQ8mOGaHyNrA
         Eh30Ue4I/blrmm77oVCJfotLbd61gQs/VbdKeYDlLJSUPrEtz8p80DIl+/pCF/zCFxaj
         7AB8G2feM6Wbfxgvd1Ec89o9NUbGz9mWR4alj3g6Y3jwsWwXjm+xPZ5fYlZlxbwWAAY0
         rB9W9gLKV0dX+p1q0uYEsqlnami8XkdL2rOzJ5rHXmVLjH87jK0yGjT6J0erp4AIBXDA
         1Kkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1787371374; x=1787976174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3KcjaDy9kvf6pEFMnDiFeqRoRi5mZddMWsHyqJUm71k=;
        b=fgBBVPMRcGA/HXTOPOJUthP4xUIaczX/qbILEaDUH5EFNCP+wDwL977KgjVXJ7WYxG
         VggwwLqRKxFHxtZj/fsysF48H8Mp/0aJ1cWiw5CzzyV/2WtW2xZvewhPcJ2iZV7ZEP5D
         QlSpHo61R+rbPd88/02DV1c+GuB50+eUxXxNRPNp87FVdUqrL/S9tDv2O95c6ZWroI2e
         tE/2z8nqarGam3WPfx2nP3qgh0I2I1gbyRUq2d2qUmiDYFxDkV2eK9ZwiHUX/DQDpGwI
         HpS6OcusAXPfk1R2ThtBovMihBm9TynwrVT+n7IjkyIsa2BJNkg3CioCCj09KLp2dQXD
         01Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787371374; x=1787976174;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3KcjaDy9kvf6pEFMnDiFeqRoRi5mZddMWsHyqJUm71k=;
        b=fGftO0Pi8XrvYK4uozBxoFWxuu6XpHDN0ufbiGm5gJgiudmefkESV3DeYtoCOJikdS
         e4kSidDYOqgfL4axkVp//SHi3rGVe3eX1yaB49yxZLBvPbWT1ozxJihSph7uwOMjPcmH
         FTNGnKUcQgnN7nhtUkSI5/5IwT3Z0+IHNEVmxIL1uSSi0gEdvZUGIdUazaI42hHB9tDv
         hxl3MwqVgluP+wBltVcVdHC5M7/nl2/drhNzmLh0v14Yfeel4RJlqmcAE0FaWR+WYvs2
         Pf6x1plt+c5BAdk+A/KlD+xIFEXCQAX8ySD2e+uDO0utYkGUfwjHLT7eHbDmbz8pv8gO
         vGsg==
X-Gm-Message-State: AFuF++nf/ZhKbDtF+R6EbUT//uHsoI6wFDJU3ZiVV9drNwDL1olwqLqx
	4S/wXcmJPlfGHHO/A1hS5t+d1ejVtESBsHHuQ48rSHYWLvVAk5M9Oq92WCiV5B1H7hea9wZxuiI
	U6hOyP4gG9yfrX+USnRdAxjTur1InPMRAekvt77XT
X-Gm-Gg: AR+sD12ehFL9dKFFPSW9gi3PGdC275ipVtAZb7Td/Gyx2lKKOuCZdqywNHwpqaaQeWi
	K37kWo2a/h+MUjuPO92sCyjWg0fu49jcRmR7ZU4mSVHyfv68MUpOH0dK7zqayCbbehWLRI0ifcC
	jhnke7iZl01a5bj+JSXVf8WQZdFVvgKcJstsmWNHgZ+V7gYvHCby9LeaO0odbR8GrK0NUmhirPO
	t0BnhwC+JvEm1dZrHL8et9rFVtL48vy8oGPvyEgF2wNhBIEIyZLrRI4U3CM+lnov4g4mMsvIVyb
	YOCaBuHyrkFFwUbaPDa1iw5+j5xiOC7VTqUXwpAlfJh1PeTheq+VHp+TRtX3JyWDxvNrTefDNOA
	W+xnudIu9CiX7VwaniE87qWaI
X-Received: by 2002:a05:6402:3647:b0:6a5:7aad:e75c with SMTP id
 4fb4d7f45d1cf-6a57aade7fdmr4551884a12.6.1787371374623; Fri, 21 Aug 2026
 21:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821153823.266343-1-rastislav.szabo@isovalent.com> <20260821153823.266343-2-rastislav.szabo@isovalent.com>
In-Reply-To: <20260821153823.266343-2-rastislav.szabo@isovalent.com>
From: Dmitry Safonov <dima@arista.com>
Date: Sat, 22 Aug 2026 05:02:42 +0100
X-Gm-Features: AcwNN1WphHWvD4doB2ysWPWhLkuSwRuYE9phwkfAYILoKfqyuQarCyxkw4m-t7Q
Message-ID: <CAGrbwDRwfGLmroWzEkVcFkNVWZQj9A+iUukF2qEQCn64M0axhQ@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests: net: tcp_ao: test VRF-scoped key deletion
To: Rastislav Szabo <rastislav.szabo@isovalent.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 4:39=E2=80=AFPM Rastislav Szabo
<rastislav.szabo@isovalent.com> wrote:
>
> Verify that TCP_AO_DEL_KEY can remove a TCP-AO key scoped to a VRF.
>
> Assisted-by: Codex:GPT-5
> Signed-off-by: Rastislav Szabo <rastislav.szabo@isovalent.com>

Thanks for adding/updating the selftest for VRF key deletion!

With David's comment addressed,
Acked-by: Dmitry Safonov <dima@arista.com>

Thanks,
            Dmitry
