Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D855B3603E0
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785063268; cv=pass; b=gncu7WQXBJVeWbbalTLCsTjSizHLX7sJE4nG1afYFEPSys5UdVXux7UX0HkhU5gA3AzO6tMZWLxa+S7KdmFF2AsCHqxpw2bBfUotcUu3yKSMEEStXeKHlo4+sq59RmfcykaC0KJ/LQGLjveOnK/qzT5EN2FAPao1JcrIT8F+QwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785063268; c=relaxed/simple;
	bh=Iw88qdhbLeJWjjRsO5YQ58HvJ0RtCrw2s4pHsHM+gn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKEGb2Xz/eANkpBgkQEWwR0qKjJoW1rZ9UbfCyBO52SZmWVbGWQMScKLXBvWOIqi0mPjECJVX8B5F8ABrfdpbXf8bDSGGhsOYIWcd4nxXi8/83GEivrvHZux0ZXahHtoSOPwLbM39bNQozKaFsW/BxLerc06zXGpkS3UQwlqUdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dvpv2ol3; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dvpv2ol3"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso1290151a12.2
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 03:54:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785063266; cv=none;
        d=google.com; s=arc-20260327;
        b=GxLyQbXiv21nbTcrEpRJ+eUmSQD2hDiJgQ5g1vn096QwZNAjegio3GgtwTrz7maGAe
         qC29IZLS577VKWQ/EfaqbfZ6G4dgIUF/53zvmNWZqXrqKgfpiWlHnnpCfysUAjYzk1ZU
         M9UpAkU/Qq8XVcVCiH1rKle8UWJsxQ/7fmHuOo/ZVuUqBp6x71MWmJ4Fs9P6OgZlWaEK
         88eS/JQ+C5/qd/7nc/AVxsdGdEWrs5A+W7UC2GktxU9Zl80H7ri2f4OLXnpPVwpuSow7
         d72UHEOXOSBz3xUhD0Usn0mJechoQSl5YcMfzOLegY/kfWHe5QabKgq1X9XiRkkUaJFO
         B4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Iw88qdhbLeJWjjRsO5YQ58HvJ0RtCrw2s4pHsHM+gn0=;
        fh=GAGiFCws7atibRTPjwvcdSw7+/YKHr9oq1oAClnXSMs=;
        b=kEIQEVVJCbUtZTWcz+2FUxuKW/xk02soAfazT2ueWUpvPMk4s9ySMsB1RO5JsEiWI0
         S/BMfzQ3KlCMTjyKXhaJ1r4B+UFErwJlFq4dRSpssJVbxKRhvDpBP1bRGWIutwXMIMJ3
         51FW10Jefy3DfJ6dg1eKpeaUq0Z/pUCnbM9qIxdKuA+bRy2laA9c2IP/SxAWsyAwqQm6
         sMw6rydloznFDgpX6cmTMCPuguPW5h4qvA0M53g/JL+yoXKpNBf/NCLE0RMWykBD9/wc
         C59auH5TDYdU4H5t5Eex6wDvfhMhl8++xCDglVy1pgoTmdxfsH/caO2m3PXz9COWfCJS
         uYyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785063266; x=1785668066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Iw88qdhbLeJWjjRsO5YQ58HvJ0RtCrw2s4pHsHM+gn0=;
        b=Dvpv2ol3gARkoIB9UcQeTblO9C1suXXD5K6j2neVIym/I5hSAZlqwQL5v2vjOD4O2M
         9NG6JlGieKWNZyTtPpSWqLT4v0xdA4egzED+rPp8omqS1McUmXTfJZEY3U0WTEbTVfmt
         MP53Lf3RrzMlMlm76Y3ya0RXlJSRQnwvi3oegwzmjx1uU6XXsu0mm7hVs+t/h4M/BVAx
         EuY9B17ZQlYQUrS0Sm3a6ErwpxkZIKSa/+6e4VI4lWbSdiXArkeiv11Pj+QZN8TAPhaS
         6Uf642mGc9VUzor3mcI2nOPnXxkVA8iGytd3v19AvBPm2fi+6HdqNq6FwRU4Z7Cx1yYJ
         6SjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785063266; x=1785668066;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iw88qdhbLeJWjjRsO5YQ58HvJ0RtCrw2s4pHsHM+gn0=;
        b=IiN2UXtRhSfW33oK8NbJq3gVuCC28lyqpQMm2dbwBWRONPRBcd7GoJCODkXZefc3sh
         JRPbV6Z2IF9fdD6P0PUyFi5ziTR7oC85ethjWHgmS/oR9l8duqUBUruob5drG0zikPzv
         yc6tHZole3+xI6YlLkoO/uwTvH1sPHkBdKUJZysbZPPRyeM0xXqjCikgsCuVXPpplT7u
         Qf7PeWgZPwDzZEOizcY7NzCbjeIt8iR4Sgd073OkwmUtuX0MIRsvC9ih2gw4QWHx4UqL
         RMLPdXBzOlVuBbrqjpbKTbWF8s48EINBvf9OqP+ewZo/T9cKKymM/CkH7fk1dOCspUtm
         ue7w==
X-Forwarded-Encrypted: i=1; AHgh+RpPPZoHSo5VX/uHKYaUbV/koI2kqDz9vp3ICDTBgc4N6KITfo9nvUsSpVSX1/Lz/+mLljd/b9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIbj0q3ZUUGyGqEOIq3sUrmIPzHT1h8sawGv7FGqiTRk79HzjT
	stnCddvMsj8yibI0UbDcPjpmfVhFR68plFm/ks8oiJGXpJWi8bkVybJqAmw7js9VoZQbShuI3Xi
	/S7GJUCJfIoQpylVw+PlUByCMphP//b8=
X-Gm-Gg: AR+sD12Bse7cy9PZgBlyJIp/x5n7+Gw8i1ShEHnW0uYedqpIFhV5+y3SqNEFsFrxlpl
	2fvOI97ICpoiS6Xtp13xYl5u+JDtU6GFiIsMUwADqFJWZ8y/XucR2plfT64uqzROClU17Dg0sQV
	3OjH1/Qgd3JedXtPR140qQLBE6u3LYD2BtCoVPuQ9HF84j093fM/uKeKe0eQ/9j0YBYQfJNI/e6
	03paHmejjXGMRk8Ozig7oQWCHtYcz1SRVpM3DxwTPoFl4Avqy9SzKZigo+LSBhX
X-Received: by 2002:a05:6a20:918e:b0:3c3:68a5:50c8 with SMTP id
 adf61e73a8af0-3c67e166966mr4554741637.71.1785063266062; Sun, 26 Jul 2026
 03:54:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719-usb-ptr_err_patchset-v1-0-85f7f2e4fefb@gmail.com>
 <20260719-usb-ptr_err_patchset-v1-1-85f7f2e4fefb@gmail.com> <al4zFG3zCD5FJ7eB@SMW015318>
In-Reply-To: <al4zFG3zCD5FJ7eB@SMW015318>
From: Subasri S <subasris1210@gmail.com>
Date: Sun, 26 Jul 2026 16:24:14 +0530
X-Gm-Features: AUfX_myX_j6xmvi1eW61hYxH97YPNgwMZ6bNH_j9w9hal-EVFSbaRcZHMpkAmFA
Message-ID: <CABfayGP4XpfqrfQ3qWz97yLTfjqwn8xXwW9WS2g1_vceS0srXg@mail.gmail.com>
Subject: Re: [PATCH 1/3] usb: chipidea: Use %pe to print error pointers
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Peter Chen <peter.chen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Duncan Sands <duncan.sands@free.fr>, Chas Williams <3chas3@gmail.com>, 
	Minas Harutyunyan <hminas@synopsys.com>, Hans de Goede <hansg@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Badhri Jagan Sridharan <badhri@google.com>, linux-usb@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 8:09=E2=80=AFPM Frank Li <Frank.li@oss.nxp.com> wro=
te:
>
> Avoid use words "This patch", just
>
> Fix coccinelle reported warnings:
>

Sure, will follow the same in all my patches.

>
> keep one is enough
>

Got it, will do.
Thanks for the review. Will incorporate your review comments in the v2 patc=
h.

Best,
Subasri
