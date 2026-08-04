Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED834749E6
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852336; cv=pass; b=EHaj6gejleHTb5aPDRY+ge2UHanZ9UPcCvBgX0CHJgH14vpQECXQTUjHk9vvyyvBKyK+VYUW5QVchCUDS5leicbDbn4TQ0YXfSNTSj4v88EA0mTF4tHIwEENJDsvKvY5xgS7rECH63LjRx+xqPx0Em53vz8yBzcKNLAMPC/4/Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852336; c=relaxed/simple;
	bh=uh87EH3FNFHbG0MjAtvtPoh1GXZVe4Phu8T1IymeRJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScFsymGIuQ6EekKytjXUtLaecbUD/HYmbdVaLwQqYnLdTyNdmSCMFAUAtwgumFxSnuXtNKKYNGfxsEqUwsK5Iv7yBwW/OrQEIe/qEENeRBAdtRiU8D9aSwNycu9IvOh9tX2jOrv+mF+zyCnmgpQ6LcuJdObiXb7as7DUP40BXi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLx88TWt; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLx88TWt"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15f020a223so712596566b.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 07:05:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785852333; cv=none;
        d=google.com; s=arc-20260327;
        b=YpheJakmepEf62jROq8+kHefkyH8V5PcLlPVWPlaBsxnVfDlJ2rLyOOMZjcqL+x/1H
         KY3FQlz3UEIq5lhMCvkxq7D65ik3zddFPb8zM2f5i+dLZ7JJZ3i/lvLdsn17bRWwAo+L
         NHDX9uht6x8Nyp0SG1FWRgCDpzm59+fzZ5ho8SI0FMrYtf51HFR3+WDrObJjGNggEOHE
         1NgimSoBGiFF6pzZY63/9MqGFKJ00eURD2Ss3bPsgjvjOMcI3f8ykCpcKqLp6DdDnjFq
         CnoQmq56pJGg3zdqaQsMGsuW+YoFhd8I6MpIZ55JO0j9F5N5kTBXgllcf4xQpA7tJrCR
         S2Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uh87EH3FNFHbG0MjAtvtPoh1GXZVe4Phu8T1IymeRJg=;
        fh=Vld2zxj/xZjnE3RLNH/H4EIU4fJXydtO/ZAYYhaOfNE=;
        b=pZpJGafIaYLrSM0hgNIXbNyFtgfZBDJj+u5BYG4kLUrA9Wsk4shYNdmYHcS/ID6KZz
         iMYbRzijSXryUygusM3FtPta2f6zu19YGirNC34mKq/PeGDqOvhv69hch/BLp5Bb3zV3
         NyXFotaLjGDHFgiZxGDHRlJathHMefqHh5l92CuXu4AkXQ8iqewYeBrW5iF5b3lEaqmv
         eBPXcIlvTpMve8IzFx+2m9q5igm2ePAj/BeHvn4ykBXhW0o+XFE/BuQOxmV9hcCy+IuQ
         dO8yCfX359AJ0Rd0g+VlLRF8LVN6TMUdj4SplyI/bs6aEooWO7XtPeVG60J/JdWmMrxW
         A8dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785852333; x=1786457133; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uh87EH3FNFHbG0MjAtvtPoh1GXZVe4Phu8T1IymeRJg=;
        b=jLx88TWtb42V4LhKuLgwQVPmacJ894kP4ZaXch8u5/cHqRV6GR9ibkaz4395/ux6bT
         lF5YV8Jv8DEUg3O7FA4MvvUkthPp37B/2cM5etoFJbwP/jIlQaKhcXnciWreu6DjeT4r
         Fre9ArdoyGm2A2P/Z0A58T2NIPgqyK8ON3grx4sqGk1PVYc7FwkcnQ70Vc4mmj2EDP32
         gNxALN8uqzHi+0p8BLak4BmPxQrFISKta+jQFHLb2kiE13ooxUuPNwpnxFOStczSC/QB
         WWVxqe2s+J8Anley56H15qz0kxp9XxyZjkt3aC3y1tEPFNfORihh2n/g+Cx2yEt1mYxo
         mDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852333; x=1786457133;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uh87EH3FNFHbG0MjAtvtPoh1GXZVe4Phu8T1IymeRJg=;
        b=To79x41fJ0CPM8rdZB2Bxi9QkRhRHRbrHpirmVnrSUlTMr6ENna/46QoUXbOfjmvBM
         PjQ0IgHAfaFiYdkOPSp3CtrTKyDtBHYaXwwMSqMw2wArLWaQdzBEoeexq5E8byhxsLJb
         ZZCGOScxH78Zx3f8knKRgx0dapo/Nu1ADv1ClmNrNCr0l6SmhT1X2ONLzIRItCFEqGmP
         MlFGkIGmlZqPLD8AHs9XL7Vk7pUEmDYgYre+Idj8EiPu3Ac0iiJBa115biMaI92LEvHo
         u2tVfku7hPcYKfZebEc5i2hXGVVe5qhhbTSJ0Awu9nDV21fuDnc4OyDw8kSW57Br1yZO
         l0lQ==
X-Gm-Message-State: AOJu0YzMHDdZ0WoufLzaP4S+8DYFAE9RqYP4IZnhpuA+a0mzHKzTa+sX
	1cwSHoQApyZ7RaEfoimSVnRIJq68XX8o1Q63lV0GO/sLTs0EZt7UQyubBvyArB0+0XjF//VIBgy
	VDoT5VihB2T1BNprd5inq+6jmIngGeQw=
X-Gm-Gg: AR+sD121MLFRn4ySrPt7Ujg2CA9jQs3S/I5pOYa4G61ci5pTOqfoQZxpvZM4Ek1Po8P
	tgUJ2g1N+/vg3YoZSnKsr7u0lKJ0dehgelV0qXHXQozAieZHA8q4wBQVxS9yzri7qRX8QbFf+QR
	HQCcbBwdL2lUKo/lrHvU7YrPo1HHjVVlHTC9dpllClbB7LHi4koN+nn73VdFgMWhudJjTCPnpu6
	9vFxhESgfthqKXbRmEA/S+e0q9BI/Kh6m/ynUfaTBeaxoYZYZOFNXJCjkkgguZYUf1soiJu2yai
	btgcWQhtJQgI97XUiXjgtSWCGfkQHDjYei2mUfBw+ksBUwchC8eRVqfutQ==
X-Received: by 2002:a17:906:d9cb:b0:c1f:7b9e:8400 with SMTP id
 a640c23a62f3a-c1fe817da21mr1039198766b.30.1785852332606; Tue, 04 Aug 2026
 07:05:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803101734.270821-1-a.shimko.dev@gmail.com>
 <20260803101734.270821-4-a.shimko.dev@gmail.com> <239a7699-bbda-4fab-bfa0-604b1d8806a9@lunn.ch>
 <CAOPX744YEhdgmOFPT8PjfKp=v4tVq4XefYaRnk7N3J4MPB9sfQ@mail.gmail.com> <78ad6961-6be7-4759-8c7b-f4ce070521d3@lunn.ch>
In-Reply-To: <78ad6961-6be7-4759-8c7b-f4ce070521d3@lunn.ch>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Tue, 4 Aug 2026 17:05:21 +0300
X-Gm-Features: AUfX_mwPmNyhuHL06sDHGot-7HNxt9vk569IkwVex18nFN6qIuG3Dbu_KFGLeoQ
Message-ID: <CAOPX744zBT16jcTQHTPSDHv2rov1UPt=aTxECkrPK=7yG6FSQw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/3] net: phy: add DAPU Telecom DAP8211R(I)
 Gigabit Ethernet PHY driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, Aug 4, 2026 at 4:26=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> Ah, please add a comment about that. It could be there is a minor
> design issue within the PHY, and this is their workaround. So keep
> it. A comment will then stop reviewers like me asking...
>
> Part of producing a good patch is to try to think of all the questions
> reviewers will ask, and answer them as part of the patch. Either
> comments in the code, to text in the commit message.
Will do. I'll add a comment explaining the hardware reset defaults
and update the commit message.

Thanks for the review!
---
Best regards,
Artem
