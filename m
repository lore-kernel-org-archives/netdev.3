Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1B34D9F99
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789595086; cv=pass; b=RrbuyrI9tHthIjApSlo0qvMr/4Pl/75HrAjbqb3PtVJIwkngJf58F7zlXMSgIA2vX/r+XWKMbH8Ryn65ibRW7Mx+GiUWzaIbV60ET5ARWeocGCIFVqpUxMyte5+DYKf78Q52d4jJhDCrcnOd+T53tUJvA0gK+MaRB1oAWl/rl7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789595086; c=relaxed/simple;
	bh=+TMWi8xF1c/GpLGSJWBDMGttEHh102/5Ofx0+5TAWdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=py3aHY3daG6KSsqQ95unaoz+mMhrPaHS3mhalauk/mQWEq1Qxb0To1FuX3n/sDDwYzOzHtKfxGF2RYV0w3yt1JFn64z44lAQ+O7X4HnQ9V7lLOXQe/NbL8GFoFzBbI3mu+oRvl3GNKrK5Xj8NvMU2sYCBVfUzlUxY2XhbbxsX6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhRvxyDc; arc=pass smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhRvxyDc"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-980b6159d30so52150241.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 14:44:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789595057; cv=none;
        d=google.com; s=arc-20260327;
        b=jo53g5WTz6V8CRE88Hj6LMYLn692TzXwsRF8A7qHhjr1LXg7KoH+NY9fC4JlkviIIF
         sv6Z12E8ICQcBwJWg74OY2VGtIhQVWTfS4nqBl7JMa0F3AxLN4eAn8pvEiGe0x/1Rmub
         yJdbPpN19NALTs95VvQHn4/3SAlO/CV2ELQCf0cf1lEEAgPf1GlDcClIRVpiWHlovYU1
         nnGFR3dr4fAav324Ozd5nwf3kJqPTSQpAGFejw60CyiP6nVKMvW2vmo5lOeLFL5Gig/z
         RgD1Ig3+WW4EOmGwMozpyUX7iFP95qlLdAVX+UjKSLFlumW2Cf+hmUwjtJd6u0PGhLZz
         hJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+TMWi8xF1c/GpLGSJWBDMGttEHh102/5Ofx0+5TAWdU=;
        fh=oGHoLIYaZZ5VXFKE3jVGGmwIpxZA9pYA7V1GB8dz7XU=;
        b=mJAPZm3k+9PoSu0W+QWq9DtrRVnidUrw+y/ssMm/JZkVDMFiKlEXH06CHLppyR08B6
         kC2fcB603By6x9ZTXdmnZKUVq8P1yj0slXDAfJQIPHnyNJGUpZk6CUA56cZD89HT3JrA
         /WwsZ0EQHR7wNAVZrL48SZ5hicz9iJNT4bBoAn2V/Ij0OnocUi0GEXZKo36IksvtKFqa
         99JhzcrJAs1oyQKYWWZdwcYCttTtF4lRzXd63xtaHRiWweJRAWEfXg0BJAUgBqdCDpZG
         lsKHZ4z0AHwQ/ehoA9E+YcPFA5IHzc6R3WSispI/rxb5bMKXpUPFNo1yqjT3tU5QVI6L
         kVdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789595057; x=1790199857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+TMWi8xF1c/GpLGSJWBDMGttEHh102/5Ofx0+5TAWdU=;
        b=PhRvxyDcEKpo82rz7bjO1wDQ8uBdzgmqFw/6qMLJ6ysl579NXOSm57qPRzt39pD3oV
         RQb6cdMJNN/Ek0B5W2zGNfO0RqIoSKMqtIpUc7eAhIfyNHQGufGBDtCJwInLu+pX9hxn
         J9cpThCkU1tmfCxsOJRLdZFf8wYm3kRlo/yoPwYzsu2PbhjQqcSKR20KyEdhLP8618yJ
         5CmZfZeIm2+Na8mFl/ktZ3dXA1iPW6HhEYtD+ujAGpNgWXor7U3Ki4cMIqiM6LMBSHL9
         ktggN+6MCwK15bvCxc3iBeUikkFZwpbRMOG0Pyt60U5y0YJFcb8fm4EhJ+LQPrX9SbDv
         Tdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595057; x=1790199857;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+TMWi8xF1c/GpLGSJWBDMGttEHh102/5Ofx0+5TAWdU=;
        b=mJcCMqJzhfOsWIkKn+wdgZge/peBtXRSGzkh6PG5z5lunkXJ2kohichI1V6A7iHPXy
         37C68t8cOMECJDlsLYDq1apt3OZkNHliva1EFYwpRTnndwxPanNDkc6LCX2CrzUklEiM
         DmpSoXLjIRJzQxkIZJwT/WVlERtTglfEJjm2K0iXuX4V1h1WgRiSCSZokeW125CXfEV9
         aUkYNMtOX944XeBE2TzSdIIZlCizH2LJ2roEZn6esaIqNBGZ43aBirmoup+1f5SkLxI3
         n7fIMy4RDc9qQw6MFhiRYJ4y2j5ZwpQ1SJNutF5nm2s9ds0Q3J7kvhbXw2kUW56UlJY7
         hrIw==
X-Forwarded-Encrypted: i=1; AKwUvBzP36QEetblBHWM3rgbT8hMswHoRe1KysAJeX+KIzcK84UvjXnO0zxCiOVM/nxPb3ENLgDK53o=@vger.kernel.org
X-Gm-Message-State: AFuF++msXhbh0H+MbVedwQ8hr/R2KsTtSWkFarLbkJThOgTg7DYCLKIp
	nID2it0C4xUBIsWRBn3P4ME2iFMN5vJX+W8W5ttHUL9ylIu0nCuDVdT61kfdY8EJoQ7cs0JPIY6
	CKWUOWeQR4hV9/3i1gEuTRx6ZmiAh7u25RF5MbLs=
X-Gm-Gg: AYBFou1i9hMY4IkVbTsrxqOH0l0NpAaijjfblVmuShTa0F1VFXD1s8RmT3PtEXdFRhv
	Tyypb60qLiBZ8Oiais+wh14AvnQXsMHWP533EJEAcBjKRPZo0TxOEaEWo/yOEu675Fsvt9kWaNL
	B3KO/ogEMBqLtufJetHHoqn/jleucRaMRjtcgihal7rzYDrAqZ+ehpsMUGtUFQqm/oyauSG3/vD
	paxARzKZZhUkL5hPaY3DR6Q59/p/XxLpd+WTHp/ZI5AGLT1SmV05jTo1j5MS4CjTLmgSGT8OtpS
	ZXMyVlwoj94J3cI0yxB4Vwz8KPAuahBpmJxpyx4P+4XIsRXVKOAlnDZLt9x3efPaMRUVxjVK4qj
	DYMU3Z9h9xzMi1GL9EfK3
X-Received: by 2002:a05:6102:a85:b0:7a2:2a6b:e7b4 with SMTP id
 ada2fe7eead31-7a22a6be8efmr62586137.2.1789595055938; Wed, 16 Sep 2026
 14:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com> <20260915081910.4142719-26-morbo@google.com>
 <202609151258.5FC01072@keescook> <20260916010945.GEaqnsWSZ-DTMyTO25@fat_crate.local>
In-Reply-To: <20260916010945.GEaqnsWSZ-DTMyTO25@fat_crate.local>
From: Bill Wendling <morbo@google.com>
Date: Wed, 16 Sep 2026 14:43:59 -0700
X-Gm-Features: AcwNN1XbboPOY3deKY79Gty15vkSErYIT9HTgeQdVXaDzFhBvm8_kiOA449bIqU
Message-ID: <CAGG=3QVZRCJ94+DOfSsSDhsrXVYf-ec01NZBy299nYiCAYfXKg@mail.gmail.com>
Subject: Re: [PATCH 25/28] EDAC/thunderx: Replace strlcat() with seq_buf
To: Borislav Petkov <bp@alien8.de>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	codemender-patching+linux@google.com, Russell King <linux@armlinux.org.uk>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>, 
	H Hartley Sweeten <hsweeten@visionengravers.com>, Tony Luck <tony.luck@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Matthias Schwarzott <zzam@gentoo.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Linus Walleij <linusw@kernel.org>, 
	Anil Gurumurthy <anil.gurumurthy@qlogic.com>, 
	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>, "Martin K. Petersen" <mkp@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Kanglong Wang <wangkanglong@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Qiang Ma <maqianga@uniontech.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Pengpeng Hou <pengpeng@iscas.ac.cn>, Ard Biesheuvel <ardb@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Thorsten Blum <blum@kernel.org>, Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lyude Paul <lyude@redhat.com>, 
	Ashutosh Desai <ashutoshdesai993@gmail.com>, Imre Deak <imre.deak@intel.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Johan Hovold <johan@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Cryolitia PukNgae <cryolitia@uniontech.com>, Jiaming Zhang <r772577952@gmail.com>, 
	Will Porter <mrwillporter@gmail.com>, Cen Zhang <zzzccc427@gmail.com>, 
	=?UTF-8?Q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
	Rong Zhang <i@rong.moe>, Arun Raghavan <arunr@valvesoftware.com>, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-edac@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, linux-input@vger.kernel.org, 
	linux-media@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nfs@vger.kernel.org, devel@lists.orangefs.org, 
	linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 6:11=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Tue, Sep 15, 2026 at 01:00:00PM -0700, Kees Cook wrote:
> > Seems like seq_buf would be better her? But yes, at the very least, thi=
s
> > needs to be scnprintf, not snprintf (or add the checks as you have
> > here).
> >
> > The rest of the seq_buf conversions look right.
>
> This driver has been an orphan for a while now (we just made it official)=
 so
> I'd prefer it if we don't do anything here.
>
I'll remove those changes from future emails.

> And yes, that mega CC list is just gross.
>
Apologies. :-(

-bw
