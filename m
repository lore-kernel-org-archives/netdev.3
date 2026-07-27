Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4562C40A93B
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157185; cv=pass; b=oXWkbACU23cVxBs3YNfrNFlpJb12d4SRa07lEqwg73vwhJlMXs38E4ybYTbQsy79pz6ZdeSxNQ9agdLNPZitWVTrEpCBmF7SVnekyao2CMw//Jdl53kiYbVKa+2yXZSFWkwJlCs4zhmquVdw+0vOEUYElnR8ao/dT7cv3I9pdvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157185; c=relaxed/simple;
	bh=luUc9ZQFmCjynsr/029wplBmFfuONlqLQlNMir6ffmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrRCAVOMptIkZ+iIx8b892n3jyJSBThrHHykHcQi8Ypj8sgcwtrHzzXYbdRjK1fn67fRN0PKDG2N2+tFGjcArBKom9Rg0azdhFUA3HC7Do9MvrBrFMjP0VRRv/Y4T6rgMZx6j1QRTs3GKQ3kkV7erUQ0TjZC/Zqd4Onl4NNExbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jq+uwgTQ; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jq+uwgTQ"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81f36179d72so31144067b3.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 05:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785157182; cv=none;
        d=google.com; s=arc-20260327;
        b=ntvhT5EniY20IdD0in1WITUpFi1caO9O6W/lMdbSNxGsA5BGhHjw9g5OvOxSPP+zN1
         ZYAR0O/ONl5babVSxb2/Urn+9JTvY35lkAJKiJNVEm9h2M+mXJYmP1+7/SiYjkz6x4xm
         IfXUWAI8ZfskwZnW4NyYGChOXCooS5POO2PCb1hV3Rte1CW03aT8GdooYi2hWCn7P4mW
         2+0bhyQKfoWrciAfb0rN9eIVHYdZG5n+XRtVTicgT9WPx8Kg+0Z9qDYwdn6A9dezLdza
         tAoZUKBQHkZC1UuULM1a6jzNYuByQk+4+2bpZdsTDC+ucVY5qiU7KHl2UayTKhpkDJvg
         /TtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ix29oOBbLOf7nlyiJN1FbRfyq7KaaHwmDtcPHELsDuI=;
        fh=9RiqADVpITQKa76/aNmHGcrfp9iohWjXOLwWWTTamCU=;
        b=pdTso7a3gnUi5gj93KH5Ip5NbqHoaDKBfmMVrT9CQQlBeJRqv0vGDmzvUSbzUIgWj3
         h7f2F3D8unOXO3pmrv5JwkFH6Sm7pCXaaIF+hIW7ehQQvBGyJbzpSBa6VXexURuiS4y1
         p5jz3GmL6qJh/XI5qRaB2y3MbANl+dcdT50Vpa/KyPlXWPC74htxB8HZrBeAw+yEJplS
         LlRKODPTf7LpiUEmcgAfHKNNsTFkbQZYc2TeLa/zy5Lf9GWh+nDkg9frbuMpecl11qIn
         Iu5Bq9yVEo4dNrPX1bfTxrove3UCdEjVPu/CUQoQgPVi+Qv8HhJtmPs8I/iBEQdIN/Gc
         ecLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785157182; x=1785761982; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ix29oOBbLOf7nlyiJN1FbRfyq7KaaHwmDtcPHELsDuI=;
        b=Jq+uwgTQ0O1mmHxnBGxWcL+kdE/a9RtHdIP1tjT7Ei9n+xl4gDgXDSpklqMXUWUDZJ
         ac+GrumYYzSuNYK88A3/T4fkN6MG4wQqkhyc+crip1OV9Ijk+VP1IqgTH+CDfXD7MNfK
         izYR0QrNtnZH5422kCYtXpZUgaLbeTRubkLzot33FEHtm/0zOCL+zY/SYXVb/YZMHfi9
         1UT3syyMpKMiD5iEheioIjGtc40Mtnrnje0QPSkcU+JF6Fi7cbHX042hz4Kxs0mUOVq5
         ese1af/Z/IOALMSRWCj+UGhUzDc90HKs6jlW61M0+1P4+BJjqXHXw0K6Q6tEdTQomu6E
         hxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785157182; x=1785761982;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ix29oOBbLOf7nlyiJN1FbRfyq7KaaHwmDtcPHELsDuI=;
        b=Lbioe93Cmm8+gr9ZTPhEmFsmc7xLoO4UrJF7qRBiCkflIQspoLoG2S+sRITonjdaIs
         u7vWZzqNlvDZ3XXsGF1zLU0k4sPw3MbDwdc2J/o/cGnOL2vGwtrO7LQIqOChdmJvb7/i
         6/UJCncNKGPfcWYhmT5uwUuPJ4zoAj+pUMek5rZqDHPdz52cem8kLyJYReNsGg3N+RAA
         9JeWZDr/80yCfzPKSiLPE3KAJmhiZ3cdWbAVXN9GT3obNGGiDSua2jf6cr0AodzarTyH
         VmoiILF417e1a7rKt5++BU7ETOmxubv19YdVbfP5WWfDlxzf91HwcMivQcT7KFso3YRR
         68Hg==
X-Forwarded-Encrypted: i=1; AHgh+RpJ/TpoTExRclY0H3Z11PgDIugOSZypHnNGWdlvLx83K23ZmkTqT7UkyvfomKVyWss0jeiXdi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ1Lacw96uqvdr1Q4Gj0N9rfdT7cyfLgELKqYjeXuY9xTVwcIr
	VolKuP36H9QdxTWlLi96xBiH2Ykhk8P5Uq4CY/TQXYtuqniqU/MdzXrYyWLXobu2hy+QPHqBr+b
	7LbLIYD7nSaFDFwrut9qNTZ+aBiidmR8=
X-Gm-Gg: AR+sD11aSmpGAPHI+thK18xNgK82IvdRJGaFwOKKQUIfg39h+HFcvHdAOF5Jj6fTZ5E
	zq9o+YrxqJpyNVKATRbKINsFSWfwsCzqNl/8xUp/5yNcontS13QBIErnvYp7p7dwWLimhX/BFQ4
	30f1uhlYCLO6QPSJ2/AiwKP2D7v8pe6CpgRsQ/RmXglgtPhmRJQou0gTAMK5torHIyyinpoxLHE
	K3fztSKIuy+XrVZREQxTXFmKM4ZUieYAqfxTIEBw4Fv4C3Ug69kHjf4XTXa/J3ax82v7A==
X-Received: by 2002:a05:690c:6f02:b0:81e:97e2:2210 with SMTP id
 00721157ae682-81f69ebac17mr31274727b3.69.1785157182142; Mon, 27 Jul 2026
 05:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723184538.3888637-1-ekffu200098@gmail.com> <adcfc6f2-3309-4496-8331-1ae31e85d363@sirena.org.uk>
In-Reply-To: <adcfc6f2-3309-4496-8331-1ae31e85d363@sirena.org.uk>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Mon, 27 Jul 2026 21:59:30 +0900
X-Gm-Features: AUfX_mxOitBR08KsPWHGWKTOhvBmlqBsOevQYdsbBN1kI3uyZROYcZJFQfRk1pk
Message-ID: <CABFDxMEmB=5UZx6RZgFNZyB5sg-+e2hgx_T1QjV0JzqP+auTFQ@mail.gmail.com>
Subject: Re: [PATCH 00/36] treewide: remove conditional returns with no effect
To: Mark Brown <broonie@kernel.org>
Cc: Julia.Lawall@inria.fr, Alex Deucher <alexander.deucher@amd.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Borislav Petkov <bp@alien8.de>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, David Airlie <airlied@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hansg@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jakub Kicinski <kuba@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jiri Pirko <jiri@resnulli.us>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Johan Hovold <johan@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Julian Anastasov <ja@ssi.bg>, 
	Leon Romanovsky <leon@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linusw@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Matthew Sakai <msakai@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Mike Rapoport <rppt@kernel.org>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ping-Ke Shih <pkshih@realtek.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Sebastian Reichel <sre@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Simona Vetter <simona@ffwll.ch>, Simon Horman <horms@verge.net.au>, Stephen Boyd <sboyd@kernel.org>, 
	Steve French <sfrench@samba.org>, Takashi Iwai <tiwai@suse.com>, Thomas Renninger <trenn@suse.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Tony Luck <tony.luck@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>, 
	Yazen Ghannam <Yazen.Ghannam@amd.com>, cocci@inria.fr, amd-gfx@lists.freedesktop.org, 
	dmaengine@vger.kernel.org, dm-devel@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, lvs-devel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	nouveau@lists.freedesktop.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 9:12=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Jul 24, 2026 at 03:45:02AM +0900, Sang-Heon Jeon wrote:
>
> > All patches are independent and can be applied separately, but for
> > everyone's convenience, it would be nice if they were merged through
> > a single tree.
>
> Please don't do this, it does not make anything more convenient - it
> results in huge CC lists and makes it more difficult to work out who
> will actually apply things.  If there's no dependencies just send to
> each subsystem independently.

Thanks for letting me know. I'll keep that in mind. In v2, I will send
the cleanup patches to each subsystem independently.

Best Regards,
Sang-Heon Jeon
