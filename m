Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D4D3148A8
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775429456; cv=none; b=BlBHoVsxm/b6yPCCp9/SzeKuwUimXFZQDw911XPienQv0wa8ujSKNzOpjoWmvYZa6P3TJjZkladR6g9WiYHilj5lubq/gk+yDdd7oJVg/e3RJMDi6sbcIVvIPcOrZSyZ6dl0tkrcY3he70+/8OcE4repivu+1F0L/UXYoemJVFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775429456; c=relaxed/simple;
	bh=zzMy5NtaL7AD5tUyCQ9LrBMAHeKvVDbZmilsbp1EV5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQE+FMjm+HXIkzYKgEgZkYy2+uC1KLF/ZZsE7chhb0yUlkJ/ocVcc/imqxYmz5c+n707Ech5v3ghvQ4Qc05VMb/am4DmOOAinG6+ZU1/USVvdbEF8FTGuGweBXuiDd1b1ksTAORxorjukRcFCHyVtmXTxU1ImkeEdO+1wfomU2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QtVcM9bI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QtVcM9bI"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9c3e2cf3c0so544461366b.1
        for <netdev@vger.kernel.org>; Sun, 05 Apr 2026 15:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775429453; x=1776034253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzjlDiAhhtCwD9FkXK7yFaosCzkOtMCSogVYlSJljQY=;
        b=QtVcM9bIh+y1qFeFYrA7qlIfAXmqyMvVA2g8x4gxWnsj/335qfuyv0jsJvK1MCXzK9
         OJiu3THsRZfsF3jUYDCUJlipGLTMfFrNWenXtZ/iJtYfIz+Kp5Q3bjKyftAHMyI8JJzw
         ukb6wbkBiXM5ioPh/M06jO+8T/CVzHEzNQ6s4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775429453; x=1776034253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jzjlDiAhhtCwD9FkXK7yFaosCzkOtMCSogVYlSJljQY=;
        b=ZEXUwBmHebg1Vpc1DXxpgnngYpDp/xOK45kD7V2ON26rek0NjiaKjXczlcwSDpwQSm
         E8WIVYpMtKqTi4puqGFHKS2KxASEJkn9MidKYIkypXIL+7L81WK5XeI8Vpk97gqMfPW2
         J/KjiCCU+5TE7+UI5rlUaB0m7Tvy5v12FHSwipX1virUPFgtQa5G3xWuvuoTEn7Pg+Bz
         0tjwhyDHbIuR9/sXpVmlTPp+yb3LY446R7qakScLchArQui+Unl7VvuFPkDOhg0iQTrN
         zjsGZ6edvQC00deI1T92dhRGNkyt0b3pHpDP1dVRwF9v+S2PKMV2hjWaVa210mqwaD1Z
         mCEA==
X-Forwarded-Encrypted: i=1; AJvYcCUGBvkC+VmFvYFFTLweIIcMszhGd3GTIFZywJ5Wtzbzg9grNYo1JSsPnXjgRmLuG8cQ/Ezit+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYqm6Md8J2optl7Ff6aTG6M5/MZOuJRK2bZle+YkQnM5NYprNC
	dub7Gmp6ZfRyzMb4QA72QywA/9c3rPODar66iw+qALg8BNMvRMVHehedb0FfmXyKdgECd+GwKWN
	c5HKIsT78
X-Gm-Gg: AeBDiesIRSUTFmPBynZ5dDD9x21hDvXTRPpykB+oYIqBqKOaU1crArRxDINyOvw8A6N
	S//CD7c0024Fh9b9g0vyV1AuB7wgMXr2cRJw4PT9sEEVj4SMY+yG0IQma1taXIbpS741Ia40a+C
	pLs47Qn+lkg8jmHFs+6WVqYK1g8+6NlHaOZGjY3+FbxZy9eRLVCixIu2T8On66zzSXeqoogT0Vq
	bESrz5dt5NCLuyG1pzAD3ZC6zQhdPsnX3lyOY+pfWgHyV2Uzs7kvtWNjkT3FsCgbMGqkoBryIbN
	zJs7PEU9WJmTPBEMTweaXLOlSlTQlPrH1XbYpy9ArBlopKu8MZy1Rl2Xob1+yGvAbG7KeGdviTd
	PUPzR9IlPczDRA4TDOOjbLk7ZSbmh0b2DpgH9T9BH7F7xpq0DQrwyJ2Ivh6x5Ygxe63uuQ0J0N1
	P/ioMyxVuf3a4xZb1abj9xyUQoIYpE5R1lYU+jBkrJYHRHQw6pcougxteuj+O7gw==
X-Received: by 2002:a17:907:d40f:b0:b98:2b83:909d with SMTP id a640c23a62f3a-b9c679f592dmr540325766b.37.1775429452683;
        Sun, 05 Apr 2026 15:50:52 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c9721absm429451166b.6.2026.04.05.15.50.52
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 15:50:52 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66bb6eb28acso6183326a12.0
        for <netdev@vger.kernel.org>; Sun, 05 Apr 2026 15:50:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXazha1EBxyS967kNoxcDPHkYPbWdI311DgL4roXjavYspWXsIjSVIvx7i6rw1s9DZHoXO49Z4=@vger.kernel.org
X-Received: by 2002:a5d:5889:0:b0:43b:47ee:4586 with SMTP id
 ffacd0b85a97d-43d292d34e1mr14051064f8f.29.1775429026066; Sun, 05 Apr 2026
 15:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404000644.522677-1-dianders@chromium.org> <2026040539-sponge-publisher-2b42@gregkh>
In-Reply-To: <2026040539-sponge-publisher-2b42@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Sun, 5 Apr 2026 15:43:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X6DRHV6k7G=p5Mno22na75G-69F-EzMkisSxMoxuvJcQ@mail.gmail.com>
X-Gm-Features: AQROBzBHjVedWun0AWH98b5RajBbraAAaRvLQSenEhaNEY8p1Czch8mAczvPiQQ
Message-ID: <CAD=FV=X6DRHV6k7G=p5Mno22na75G-69F-EzMkisSxMoxuvJcQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] driver core: Fix some race conditions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Saravana Kannan <saravanak@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>, Johan Hovold <johan@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Alexey Kardashevskiy <aik@ozlabs.ru>, Robin Murphy <robin.murphy@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Frank.Li@kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, alex@ghiti.fr, alexander.stein@ew.tq-group.com, 
	andre.przywara@arm.com, andrew@codeconstruct.com.au, andrew@lunn.ch, 
	andriy.shevchenko@linux.intel.com, aou@eecs.berkeley.edu, ardb@kernel.org, 
	bhelgaas@google.com, brgl@kernel.org, broonie@kernel.org, 
	catalin.marinas@arm.com, chleroy@kernel.org, davem@davemloft.net, 
	david@kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, 
	driver-core@lists.linux.dev, gbatra@linux.ibm.com, 
	gregory.clement@bootlin.com, hkallweit1@gmail.com, iommu@lists.linux.dev, 
	jirislaby@kernel.org, joel@jms.id.au, joro@8bytes.org, kees@kernel.org, 
	kevin.brodsky@arm.com, kuba@kernel.org, lenb@kernel.org, lgirdwood@gmail.com, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-usb@vger.kernel.org, linux@armlinux.org.uk, 
	linuxppc-dev@lists.ozlabs.org, m.szyprowski@samsung.com, maddy@linux.ibm.com, 
	mani@kernel.org, maz@kernel.org, miko.lenczewski@arm.com, mpe@ellerman.id.au, 
	netdev@vger.kernel.org, npiggin@gmail.com, osalvador@suse.de, 
	oupton@kernel.org, pabeni@redhat.com, palmer@dabbelt.com, 
	peter.ujfalusi@gmail.com, peterz@infradead.org, pjw@kernel.org, 
	robh@kernel.org, sebastian.hesselbarth@gmail.com, tglx@kernel.org, 
	tsbogend@alpha.franken.de, vgupta@kernel.org, vkoul@kernel.org, 
	will@kernel.org, willy@infradead.org, yangyicong@hisilicon.com, 
	yeoreum.yun@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 4, 2026 at 10:28=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 03, 2026 at 05:04:54PM -0700, Douglas Anderson wrote:
> > NOTE: one potentially "controversial" choice I made in some patches
> > was to always reserve a flag ID even if a flag is only used under
> > certain CONFIG_ settings. This is a change from how things were
> > before. Keeping the numbering consistent and allowing easy
> > compile-testing of both CONFIG settings seemed worth it, especially
> > since it won't take up any extra space until we've added a lot more
> > flags.
>
> Nah, this is fine, I don't see any problems with this as the original
> code kind of was doing the same thing with the "hole" in the structure
> if those options were not enabled.
>
> > I only marked the first patch as a "Fix" since it is the only one
> > fixing observed problems. Other patches could be considered fixes too
> > if folks want.
> >
> > I tested the first patch in the series backported to kernel 6.6 on the
> > Pixel phone that was experiencing the race. I added extra printouts to
> > make sure that the problem was hitting / addressed. The rest of the
> > patches are tested with allmodconfig with arm32, arm64, ppc, and
> > x86. I boot tested on an arm64 Chromebook running mainline.
>
> I'm guessing your tests passed?  :)

Yup, all the tests that I've run have passed. I also threw in an
"allnoconfig" compile test just for good measure.


> Anyway, this looks great, unless there are any objections, other than
> the "needs to be undefined", which a follow-on patch can handle, I'll
> queue them up next week for 7.1-rc1.

Thanks. As per the other thread, I'm happy if you or Danilo want to
apply it, and I'm happy if you want to make minor fixups when
applying.

When I see the patches applied, I'll send a followup patch to address
the "needs to be undefined" comment, unless Danilo makes that change
himself when applying.

-Doug
