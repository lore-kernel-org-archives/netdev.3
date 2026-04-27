Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D3536D506
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321566; cv=none; b=fmAA+gxIIiAKfFYujkw4LkcETEUuu39T7I/ZlUQALrxxdClm+ZqUiS+ZAp07JNETPc5zQKkFhkrJBIybl2GxUr0a/0FAQnlFNkFKs35xD0eKFqnWTMiXPY09e5Fyqc44yLEMwN9ix64TmwFj1WCqgNfI3Ur7CepaLCGVx7xuodU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321566; c=relaxed/simple;
	bh=IJpREljCv+tCpa781iljVxrdidqfIWDfk9Kom6HM/kI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CI3xf8y6GcoglqMqCFymCwe0lPANtpgaKhequu9wnp5PQFGfIc35Amls5HZuP1lSTtlAzwttgSbRdrKkIQ48scFEs/j84YOAuOYAvC1ZtbMo2DBXtElX+hXQJ2JdqC5yj9pxEc1S8B5RrZLOj4pVg93o5+FxmC0mZWtptj8W04o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLp1nX9I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLp1nX9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6F3C2BCB8
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 20:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777321566;
	bh=IJpREljCv+tCpa781iljVxrdidqfIWDfk9Kom6HM/kI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cLp1nX9IP0AAxlM54rpfQSxvMtM0GJuKgJ0Rr7uahgmmifGFPAq9ZYsJuTZ9b+q65
	 bNyVcBmpZqK7nVld/6mypC8uGCCSli40mbn8yO8vhshOh6/deK5ltUJOR3txLDm4Fy
	 OeKfIINot/T4hfAtyJ4mNQpxM+6bmK6OHpuRFBj9f398XRR53PjQR3X+hG77N2sCd+
	 ESlNbVKXs7Gneam50UUYItDfGlSyVTRRsxwBCeYzy7ssVbouxBNE4+jtC0i1FKQSCQ
	 TNnSrGuCJYVrtTiG1K1xW2wDY5bvzH/yTuBIymW7aYRWPMm3dXTrNSkdtPfA0Iapm7
	 f/xT8+KBPGk+Q==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a415fd6bceso11759153e87.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:26:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9p429VF3Y1awxJp8FnwltgoVBsDkC/9QoFHsWo4btt79g+AUSUnnSNxIREPVMDEefL5bEG/X0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxScWi93PWbWveMOScBgPx2ImVwY/u6SyBQ1x79eFQielYAV8ze
	1mr1/pixiYTl4BXYUyALVV+L++tAmqOOe8eCyuvnj7b6Wwq9CFUlfYKnghT+hDxNPTMuVy5JccP
	3PqIGsI820A5lpaEBVpbxRlyMvCdNb4M=
X-Received: by 2002:a05:6512:3dab:b0:5a4:178c:62b7 with SMTP id
 2adb3069b0e04-5a7468b5f60mr46249e87.20.1777321564779; Mon, 27 Apr 2026
 13:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427143020.2800317-1-arnd@kernel.org>
In-Reply-To: <20260427143020.2800317-1-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 27 Apr 2026 22:25:52 +0200
X-Gmail-Original-Message-ID: <CAD++jLnLDTe6eP7UP7ryRwC9R7=7PNMuaqYzsVezsKFRpZtS8g@mail.gmail.com>
X-Gm-Features: AVHnY4K-oubdFI7rdfxfc9VDXytCd_jxlAbKESpT-vV_8bgvOKkOnhWhSdHLMnw
Message-ID: <CAD++jLnLDTe6eP7UP7ryRwC9R7=7PNMuaqYzsVezsKFRpZtS8g@mail.gmail.com>
Subject: Re: [PATCH] dsa: b53: hide legacy gpiolib usage on non-mips
To: Arnd Bergmann <arnd@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	=?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	Kyle Hendry <kylehendrydev@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 4:30=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The MIPS bcm53xx platform still uses the legacy gpiolib interfaces based
> on gpio numbers, but other platforms do not.
>
> Hide these interfaces inside of the existing #ifdef block and use the
> modern interfaces in the common parts of the driver to allow building
> it when the gpio_set_value() is left out of the kernel.
>
> Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
