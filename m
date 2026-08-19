Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E489D3E2AB9
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125311; cv=pass; b=qWGZuXe3AdNYDFtybeUYW6EHsR/lTf/PNdEWkhfpIOIX+DySTGXG6Gvrbv+XuUaKHUhRL9iCrPorgFxuhAordySV0naa8GVIylPRmM1XU6nSrXJcV0w/ITCl8uN7CwVmzBZv4e+0oIZvy1K5yDNK57Tft8njajSspSfkdEfKinU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125311; c=relaxed/simple;
	bh=i8g1kh5bGRn9T0dWTjOgak9HjdcyEv47iojLtZJK1TM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cin0RNBFY09KCECPF28leCMKOrW0FmMhTXmqKaTQameDZ68DG5EOLbZd0rMf4DHWCbz6DI0Ef5hm502jkHxRjyXkS94W837CuAiSDP3/g3wFYqHNgjwp033hKXgYDvQbPcQblgsoeHvsPSE2zlGA+FgXwp9SKoXfwXOjScdQR3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpJ+Wkqg; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpJ+Wkqg"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c20ce3c118aso129581966b.0
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 00:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787125305; cv=none;
        d=google.com; s=arc-20260327;
        b=RMvOdzy1aJV0pYt5gGVu4lvqF0GHl17wVA0Vsf3kChRXo2NfG6T/e1FR2xj4K4MTqH
         nu8af6q00IDanGLOhr9EEjz6IBCGcXQ2OvYtp/coeuBGBCsbs3JyTj3YP9vbWyON6ZlI
         wKC1WLoPW14tcxlJz7sOyoH0EB6+gJAU7bnu9lWE+mKpKQQXU5u7+ChCeS7ioN+CARtb
         ktJsliJHCrC+fIXSA/r1bxabsh1OxwiXjkMgMwqpHXrVi3sElhCnj2UtZhNZcRllTHrr
         HU6nfdeN26qHRgieYVBY4ahzo2Vh6TO2QDFbAwFHdUK+i6QIfTqETVwhiravrXUq6TVc
         vDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2XM8VjGIfz5XNFSi41BuHFpvUKE6C2ApVU9tTkW8ke8=;
        fh=5ZAfEoQPRG703fDv5XNpdakE4kxTMlRfH4ewJSqipo0=;
        b=PJiEhiGU1D7tlyRTjL5dTPjfSle1Uv7kA/Dhz9vAUdbEHCf4ifgCqg5nmC+CYS0Q3v
         R34IZXrIrk65Tdus1htfrCr2UCuLPqQ9f9AhOp//IFc8sbinKabBQdmszJ/WsTewIhZg
         t04ekQtefQlDKMxHJ35q+QAbFIySvjX+hSo1xZem2FP/XjWa1DT8vA/dYAtViwHKt2tc
         cPMNLVxmmg7iNjDrhcIT6Sk7Fmmy8Vber1WwwCTTFqz3lPPMz+d+zq1upWPG13AoLV90
         b3bM7XXJB0OtxD6CkBBW2R+9DX85J6kaVX8ztx4PwBh5b/9J8ypRAK1+VJlT7tURcKYk
         YVIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787125305; x=1787730105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2XM8VjGIfz5XNFSi41BuHFpvUKE6C2ApVU9tTkW8ke8=;
        b=KpJ+WkqgIYnJD6I7LAaemSa2VxMM5QcGLwCqP9p4ETHZcSmc8B/CYU3rlmEph/n+Qz
         MrlRbJXuYC7u5VmIANHBrT1MTGEaTZMkDJHi2Hc08jF1iozJ9EYdeCUVj4Cu9TSNT1SD
         1C1MmLLxGoxyo+CAsGq7ZzFVq4l9Dz3BYQSqAwqhx0yn/+81hvpeSWhvkMs9v4ldU1GT
         KrBMIFxkWfKaNvfnG55Azd1tmydnUWQUySPEZKMjnAyNj2waXMyCVfENItClkepIGzxh
         h3lBnQZ7J45+AB58Q1o96lKNvg0x6FQEtV8IWAv0O2u0OWy4uxjGj+WFaGTngpqZtGhr
         7G8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787125305; x=1787730105;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2XM8VjGIfz5XNFSi41BuHFpvUKE6C2ApVU9tTkW8ke8=;
        b=OtXaVnoIAhVyqYxVYBSECj77Z1qb7HoV26LeCYQR1dicjEGD+FBdskV9YjkeDk2YW1
         7ZIY/qtt8yj6qhI2yFk2LQdO5Wf9VNDXCrPgnkfIDLV6ONAPLLx3z2eiNA1VXRZAX3RI
         y6oA/b9P59aDU9mqiMq2NAO/njL1/v8LQGC6xqz9wDsKwrF1n4MP9mm8+hyY/5f4LkYl
         4PGlC2lp6FjxVc6FzSIH/QYv4VKrZUPKYbbz90i/mtFMLltT+l3cdNWNB4zUuOanCObG
         oBCWex22OdcU0r6iPYAcExlQqaZrZyk1PuV8o90cm8Mgjvxbr6We5ctpt+ba2VSxtYf0
         XyBg==
X-Forwarded-Encrypted: i=1; AHgh+RpQ3brGaEYZCQ9EPl/Mjj5N/adKCbJjf2YQWuPRpH6kC8wTUBPQaVzvOZpLGk/oAR3EpKrYPEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkipS7jQlUhgh2ixeIhhv2CzQF0gjThLbstl378X2yhHy6Jy1C
	Hbf02oVrKqaAxkVnHGRyj1gnPpeGpF9yCgMIUaZdtCCtuFxh4azwl5SSOUH+trctC8Ra3jhXbSe
	9Bsy3oIlMxnwBKhTJ2ndDNy/ZJkYp+UM=
X-Gm-Gg: AR+sD13zG+KfdS9T6FQetBK4uHtj56nOJ8Tq5qorkuc4S9icRL/3GtPnRcjT424nRWW
	o3PeVcA/+rbObdKRSQO/6gJ/DKmIFgI8bVP+A0ShRSQHXwyrt7IdO9kz57vNEn0rqGmTsYvqV0r
	i/VID4LvVVLBamE67KFtneaWk6wxndlmDLxFTg0mC+ayH5MVpHjubiuydQpWHWHT1XKNJtwSbrn
	sE4d/XKy1W2u4M6I0sNAGun8heKbMNFQxHMjO10j5DM5pqCR4IWmSgIjqYpl3QprV1Ei6gj7klU
	mGBaYc7XF0lqmhLQpezYVxZrEosN/bf5RrBLaL5DB2SAt0llkWoRSr2pRg==
X-Received: by 2002:a17:907:1ca1:b0:c21:7c98:d9ec with SMTP id
 a640c23a62f3a-c237e153a0cmr174800166b.5.1787125304729; Wed, 19 Aug 2026
 00:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-leds-trigger-hw-changed-v4-0-f97e2ca976fe@rong.moe>
In-Reply-To: <20260802-leds-trigger-hw-changed-v4-0-f97e2ca976fe@rong.moe>
From: Ike Panhc <ikepanhc@gmail.com>
Date: Wed, 19 Aug 2026 15:41:33 +0800
X-Gm-Features: AcwNN1XvW54R3BtlIAEO0ZYWyRgIsnsmisrbLic33f3L9pxDYLLAY4SdpzDzLc8
Message-ID: <CADwxbCUVY7OP-BgBW-xd-AZCn_Msh8TPmiRX0__F2f-SHw2O-w@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] leds: Add support for hardware-initiated
 hardware control trigger transition
To: Rong Zhang <i@rong.moe>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	=?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
	Vishnu Sankar <vishnuocv@gmail.com>, Vishnu Sankar <vsankar@lenovo.com>, linux-leds@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 1:27=E2=80=AFAM Rong Zhang <i@rong.moe> wrote:
>
> Some laptops can tune their keyboard backlight according to ambient
> light sensors (auto mode). This capability is essentially a hardware
> control trigger. Meanwhile, such laptops also offer a shrotcut for
> cycling through brightness levels and auto mode. For example, on
> ThinkBook, pressing Fn+Space ("shortcut") cycles keyboard backlight
> levels in the following sequence:
>
>   1 =3D> 2 =3D> 0 =3D> auto =3D> 1 ...
>
> Recent ThinkPad models should have similar sequence too.
>
> However, there are some issues preventing us from using a private
> hardware control trigger:
>
> 1. We want a mechanism to tell userspace which trigger is the hardware
>    control one, so that userspace can determine if auto mode is on/off,
>    as well as turing it on/off programmatically without obtaining the
>    trigger's name via other channels
> 2. Writing brightness has the side effect of disabling hardware control,
>    but the hardware control trigger remains active, resulting in the
>    software and hardware being out of sync. Most LED drivers that
>    supports hardware control also suffer from the same issue
> 3. Turing on/off auto mode via the shortcut cannot activate/deactivate
>    the corresponding hardware control trigger, making the software state
>    out of sync
> 4. Even with #3 solved, deactivating the hardware control trigger has
>    the side effect of emitting LED_OFF, breaking the shortcut cycle,
>    especially "auto =3D> 1"
>
> This series tries to demonstrate a path on solving these issues:
>
> - Introduce an attribute "trigger_may_offload", so that userspace can
>   determine:
>   - if the LED device supports hardware control (supported =3D> visible)
>   - which trigger is the hardware control trigger selected by the LED
>     device
>   - if the trigger is selected ("<foo_trigger>")
>   - if the trigger is offloaded ("[foo_trigger]")
>     - A callback offloaded() is added so that LED triggers can report
>       their hardware control state
> - Remove hardware control trigger when writing brightness
> - Add led_trigger_notify_hw_control_changed() interface, so that LED
>   drivers can notify the LED core about hardware-initiated hardware
>   control transitions. The LED core will then determine if the
>   transition is allowed and switching between "none" (i.e., no trigger)
>   and the device's private trigger accordingly
>   - This capability is restricted to the device's private trigger. If
>     the current trigger is neither the private trigger nor "none", no
>     transition will be made
>   - This interface is gated behind Kconfig LEDS_TRIGGERS_HW_CHANGED and
>     LED device flag LED_TRIG_HW_CHANGED
> - Tune the logic of trigger deactivation so that it won't emit LED_OFF
>   when the deactivation is triggered by hardware
>
> The last three patches are included in the series to demonstrate how
> these interfaces are supposed to be utilized, so that ideapad-laptop
> can expose the auto mode of ThinkBook's keyboard backlight. They can be
> submitted separately once the dust settles, if preferred.
>
> The last patch in the series depends on commit 5029bff09e79
> ("platform/x86: ideapad-laptop: Fix driver unregistration order") from
> platform-drivers-x86/for-next.
>
> [ Summary of other approaches ]
>
> < custom attribute >
>
> Pros:
> - simplicity, KISS
> - no need to touch the LED core
> - extensible as long as it has a sensor-neutral name
>   - a sensor-related name could potentially lead to a mess if a future
>     device implements auto mode based on multiple different sensors
>
> Cons:
> - must have zero influence on brightness_set[_blocking] callbacks
>   in order not to break triggers
>   - potential interference with triggers and the brightness attribute,
>     can't solve #2
> - weird semantic (an attribute other than "brightness" and "trigger"
>   changes the brightness)
>
> < private hardware control trigger (this series) >
>
> Pros:
> - mutually exclusive with other triggers and the brightness attribute
>   (hence less chaos)
> - semantic correctness
> - acts as an aggregate switch to turn on/off auto mode even a future
>   device implements auto mode based on multiple different sensors
>   - extensibility (through trigger attributes)
>
> Cons:
> - complexity
>
> [ Previous discussion threads ]
>
> https://lore.kernel.org/r/08580ec5-1d7b-4612-8a3f-75bc2f40aad2@app.fastma=
il.com
> https://lore.kernel.org/r/1dbfcf656cdb4af0299f90d7426d2ec7e2b8ac9e.camel@=
rong.moe
>
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
> Changes in v4:
> - Drop the RFC prefix
> - Add a new patch in the series to address a concern from Sashiko
>   - [PATCH v4 08/12] leds: trigger: Do not attach trigger to a removing L=
ED
>   - Without it, following patches will expose a race condition
>   - https://sashiko.dev/#/patchset/20260719-leds-trigger-hw-changed-v3-0-=
5fb55722e36e@rong.moe
> - Address other concerns from Sashiko
>   - Reject insane hardware brightness
>   - Do not notify the LED trigger core when the registration of the
>     private trigger has failed
> - Enable LEDS_TRIGGERS_HW_CHANGED by default when
>   LEDS_BRIGHTNESS_HW_CHANGED is enabled
> - Add missing #include (Thanks Ilpo J=C3=A4rvinen)
> - Remove needless #include (ditto)
> - Remove needless code alignment (ditto)
> - Link to v3: https://patch.msgid.link/20260719-leds-trigger-hw-changed-v=
3-0-5fb55722e36e@rong.moe
>
> Changes in v3:
> - Integrate https://lore.kernel.org/all/20260712-leds-hw-control-brightne=
ss-set-v1-1-1de593b09d26@rong.moe/
>   into the series
>   - Adopt __led_trigger_is_hw_controlled() in the rest of the series
> - Rearrange the series so that the code using the offloaded() callback is
>   introduced before the driver implementation (thanks Thomas Wei=C3=9Fsch=
uh)
> - Reword documentations and commit messages (ditto)
> - Adopt guard() and lockdep (ditto)
> - Address concerns from Sashiko
>   - Fix a race condition in ideapad_kbd_bl_led_cdev_brightness_set()
>   - Fix trigger re-registration of ideapad_kbd_bl_auto_trigger
>   - https://sashiko.dev/#/patchset/20260618-leds-trigger-hw-changed-v2-0-=
c28c44053cf3%40rong.moe
> - Make registration failures of ideapad_kbd_bl_auto_trigger non-fatal
> - Link to v2: https://patch.msgid.link/20260618-leds-trigger-hw-changed-v=
2-0-c28c44053cf3@rong.moe
>
> Changes in v2:
> - Restrict the led_trigger_notify_hw_control_changed() interface to
>   private triggers only
>   - Drop PATCH v1 1/9 ("leds: Load trigger modules on-demand if used as
>     hw control trigger"), not relavant any more
> - Gate the led_trigger_notify_hw_control_changed() interface behind
>   Kconfig LEDS_TRIGGERS_HW_CHANGED and LED device flag
>   LED_TRIG_HW_CHANGED
> - Fix lock ordering inversion
> - ideapad-laptop:
>   - Only call led_trigger_notify_hw_control_changed() when needed
>   - Serialize keyboard backlight notifications
> - Reword commit messages and documentations
> - Link to v1: https://patch.msgid.link/20260227190617.271388-1-i@rong.moe
>
> ---
> Rong Zhang (12):
>       leds: Move led_trigger_is_hw_controlled() to the right place
>       leds: class: Remove hardware control trigger when writing brightnes=
s
>       leds: trigger: Add offloaded() callback and provide trigger_may_off=
load attribute
>       leds: cros_ec: Implement offloaded() trigger callback
>       leds: turris-omnia: Implement offloaded() trigger callback and decl=
are hw_control_trigger
>       leds: trigger: netdev: Implement offloaded() callback
>       leds: trigger: Enforce strict checks in led_trigger_is_hw_controlle=
d()
>       leds: trigger: Do not attach trigger to a removing LED
>       leds: trigger: Add led_trigger_notify_hw_control_changed() interfac=
e
>       platform/x86: ideapad-laptop: Decouple hardware & classdev brightne=
ss for keyboard backlight
>       platform/x86: ideapad-laptop: Serialize keyboard backlight notifica=
tions
>       platform/x86: ideapad-laptop: Fully support auto keyboard backlight
>
>  Documentation/ABI/testing/sysfs-class-led          |  25 ++
>  .../ABI/testing/sysfs-class-led-trigger-netdev     |   3 +
>  Documentation/leds/leds-class.rst                  |  72 ++++++
>  drivers/leds/led-class.c                           |  39 ++-
>  drivers/leds/led-triggers.c                        | 150 +++++++++++-
>  drivers/leds/leds-cros_ec.c                        |   6 +
>  drivers/leds/leds-turris-omnia.c                   |   7 +
>  drivers/leds/leds.h                                |   2 +
>  drivers/leds/trigger/Kconfig                       |  10 +
>  drivers/leds/trigger/ledtrig-netdev.c              |   8 +
>  drivers/platform/x86/lenovo/Kconfig                |   1 +
>  drivers/platform/x86/lenovo/ideapad-laptop.c       | 270 +++++++++++++++=
++----
>  include/linux/leds.h                               |  19 ++
>  13 files changed, 546 insertions(+), 66 deletions(-)
> ---
> base-commit: c7acedb2db001160b1ec41cdcc759dd664150666
> change-id: 20260506-leds-trigger-hw-changed-96a62188cbdf
>
> Thanks,
> Rong
>

Review and test on my ideapads. Though I don't have ambient light
sensor on my machines,
Everything looks good from my side.

Acked-by: Ike Panhc <ikepanhc@gmail.com>

Many thanks,
Ike
