Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B0F190462
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051744; cv=pass; b=KyDZxQqU2O4dPjjUNWzLdJbVRHFcxZTbGmBe4+puc4wVWyr72neub6JjflzPyMhHHHRpmgAQ1kRdB0pCCHrqN6EKVUFkuuM1jz/MOVFU5qYxJOjOSmSGguZVFzCyGSCqZ9ZOyVM4HMxKpAfIdzlgRKdNTuLXfk9cnlDDBpvSHwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051744; c=relaxed/simple;
	bh=RaKjiYdpU+BhOXv99b5A9nBCxGzh7Gm6QxYIRWKV48s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upRMZnLk2RyCiKJwmrx+bpHkWznAXkfx5Tiw6YTiT39bAw9BYb7xACEjQM9MKOAX8wvgxm7YLDTiDKRq4t6qhl97J9W/hjLgntBvaTxrj+w4o3dggG8h5+DZhjVNbjd6kDqKHuiCrYQV/HKFv7VT1+l/SCz/oylIwCxRv+Tcx+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z+UcDofu; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z+UcDofu"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cacef7d299so12665ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 14:29:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786051742; cv=none;
        d=google.com; s=arc-20260327;
        b=cbtobKATLlORrXXDmkFViYhe4hHL/fReX/pbu2nlwd9vLvzLIzaNnGkkO7bp6FX6La
         IE46yN/T1H8UNZl3mna38gUQ7uDaQsPNjf9KYOQomsHb4xMkycgI2jlnCw+TXVKSe24h
         gI4spK1Cs2ICcpTYSe2blelnESn079Xmo5LiYhy2XKyYf7KqHrfO8JB+S13dDQLxfkJ6
         CeVDOxNd1C0bFyVJ5m8yxSmCqkY9VAdYD+Hoa5ZXjLwaAszGun4/2x7nuH2a34fId/51
         pJVFOJH/uHMqIkS83aE6VemMdP/mUC9vYGPZXa4fJfKaz2ZbPaEJLK6GGQFpO7EiIFgW
         V8SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RaKjiYdpU+BhOXv99b5A9nBCxGzh7Gm6QxYIRWKV48s=;
        fh=pJPzFbHZ4tbbmlULhhfsAeEY55EVjtgtiAzm/b612vU=;
        b=JCoF/n8DHwL2ppx0QECiOHD8SJD05as8Ny3dX66elCCMYEc0pwZppbeLWeU9/oaz1M
         TwVZQBnvNJMKaGF8e3GdJGAmoZeX5+dnkxhFujwbibZuLVx/nJIVw7r/l8C9nPP7uct1
         q3u0HDdYFBcXNuYhOkajm8N2fLFTfjb/e806PuCQ4TQIz/KbnWPpO0qgNJpht3RiPrUm
         6Iyav8v1Y5lByHYDva7mI92PalJObT5ii6tWSzsNYAn9Gp8OWuue0S1xJszoNVTpKscM
         Ex3mw03DCMDnGn45OK7OzsOHsS0oUqxXSI61fJuJfGe+3j0v1YdFGacjVTLSzEfCD+MA
         mvgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786051742; x=1786656542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RaKjiYdpU+BhOXv99b5A9nBCxGzh7Gm6QxYIRWKV48s=;
        b=Z+UcDofuTWDOZo6QhUlvMeX9u5hJ5VjEqd4xwHv4NCR74F0V6ahWvE9poKsWeaLQGP
         iJ3Wy4fV0EVFYiNxyMb53745fzMbc5Hze2E18vq2Tyl5kszbTC4tjAvTF80cQcByvIqi
         +XcialBt8eQZfAqKcSUI6PdvFJK2CxB50v/FHADgISbUGLiIav3fMN+jEzVuIyNCutHd
         p6J9Logd3hnxn+zmrA1uyWHQKa3Fx0e3nG7Gk7/WRSlhAb34/P1J/ua/+K6Yj3/EjiAQ
         DD4JX+sIYVfX+iCOqMPweGCvR1xiEO7yXh0XeudMmwn7Iwg2cVoQmlghq2JqVThUDgI9
         cREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786051742; x=1786656542;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RaKjiYdpU+BhOXv99b5A9nBCxGzh7Gm6QxYIRWKV48s=;
        b=de3X3jVnDUqesa+hUAGkynhrpUegUFyDmF5X2WDe4TtpM3/FS28s/v1hQEUpDxoM7/
         GsumDWKhxKpMUnE+IcL5Jt+MZuPDH0LquF+Pzpiy4aAmPxAqJWm2SHz5gtHpkOjWuVSC
         EmILcFnFvk1eLFy3R4KqZCkY1yqHGM0S1R/zql5YuppjqbVRxw4J0ZWcCCIvEVFzSCbu
         +qYCMpBml6uThVtisoM6PzrO7EQRdc0VeQ8r71N5S8cYOQw90/yGUZCH5eumFXs6XDX8
         H3bsgtSU54mGjXU6TGIfGh/q4HtRHjGMqgZTqKebCstEyfaX6hu+6PX4IZ/jNGc10dtu
         ttuQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpw7gox+nOfVOW1eIh78KTfTjXOUmPKq1NNUAmpjr0uWwqt/KoUaGLF9eXE+1MPtJkJ5cwA6fA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy59pp9yuHbxDEyh8iJARlzYxfxyO+GmECEO4IWcKCfdJVbssy4
	r9hvydRI4HFllzyZ0Z0Eenx8ld9anVCtfWMjsK3rLIgR0byi/EnKqY+1ltob9JrqfwkPG5fbP2B
	OFQhiZBTC8WEmj+qmYfIXK3hWR1qVdu+NzW7XcbRqKlrUIK75IglityRZdKw=
X-Gm-Gg: AR+sD10VvHZbTw/HjHdYGHHbUWkcxGpWcRooetBwtJAITe+3iN5z/Yc7p9J703RgF/G
	3MZEG1DmdZFEtKpclg3FkRShq7mOg6T9SJXEo9aMWpEfXfCKnw7aZFnPzXq12ePZb6Fe5vE4waS
	JUb5e8V0dwCHe6XPVAWuRmnyCn9m5XAT8v8T3FPExzsMsly+KYlsDW385t/9DQv8SVj2sxxo3Sg
	Qgbh/Ak5KeAk9V2rldIkHhsfuLpF/gL/XbF/jhiWycm4ePiza/OI4PnDgVwZ2vQh3ZNCXJZ6whK
	CnUHaDst92gdwHOp5jFjOKv6lOs5cdYTTQByfp3WOZXm+dXRgKHVPUaTf8CkQsjHjj10Kge6hqE
	zsIHR8tp3DFRWkqhaz8OQzlZ8E/uK0kgkT5jd14l6UzY=
X-Received: by 2002:a17:902:fc44:b0:2c7:9e6a:1a8d with SMTP id
 d9443c01a7336-2d1203c4dffmr2257905ad.12.1786051741053; Thu, 06 Aug 2026
 14:29:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <18c88903de19db1f.df50d089680ca23.c305d6e51002e357@desktop.casa.g02.org>
 <20260805170139.2ddb6216@kernel.org>
In-Reply-To: <20260805170139.2ddb6216@kernel.org>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 6 Aug 2026 14:28:48 -0700
X-Gm-Features: AUfX_mxe8fH-UpfEEsCW1DvrbJfNXE1KYXSaczQrbPCFaLT4ntgs73qAl67B__Y
Message-ID: <CAEAWyHfOrTrxdt-Bxw9-=WFtx3Abuyw1TONvZpSoba+p8hyrdQ@mail.gmail.com>
Subject: Re: [PATCH net/gve] gve: fix early boot deadlock between rtnl_lock
 and service_task_mutex
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?B?UsOpbmljaCBCb24gxIZpcmnEhw==?= <renich@woralelandia.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 5:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 4 Aug 2026 07:18:21 +0000 R=C3=A9nich Bon =C4=86iri=C4=87 wrote:
> > We hit a reproducible hard deadlock (AB-BA circular lock inversion) dur=
ing early boot on EL10 / RHEL 10 kernels when running Google Cloud Platform=
 VMs with the gve driver:
> >
> > 1. Thread A (NetworkManager): Holds rtnl_lock during __dev_open -> gve_=
open -> gve_queues_start -> gve_add_napi, and attempts to acquire service_t=
ask_mutex.
> > 2. Thread B (gve_service_task worker): Holds service_task_mutex, and ca=
lls reset recovery which attempts to acquire rtnl_lock.
> >
> > Serial Console Trace:
> > "INFO: task NetworkManager:856 is blocked on a mutex likely owned by ta=
sk NetworkManager:856" at RIP: copy_net_ns+0x1a4 / selinux_netlbl_sk_securi=
ty_free.

Hi,

Thanks for the report. We've communicated re: this on the Github issue
also but just an update that a fix is now merged for those kernels.
Like Jakub mentioned, if you also see this issue on the upstream
kernels, please let us know along with a splat and the exact kernel
version or commit ID so we could look into it.

Thanks,
Harshitha

>
> You emailed the upstream Linux list.
> If the bug exists in the upstream kernel we will happily review the fix
> - please post it to the list.
