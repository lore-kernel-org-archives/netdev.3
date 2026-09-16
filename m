Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C4E3EC81F;
	Wed, 16 Sep 2026 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541248; cv=none; b=q5lpXho6CESd529os2Ufo+6Iy8uXk7fQbRRGzIX9XvYSmjIiBtNbjNtq5bq+SfZ1QqA9Qf/AwfVza/s8h5EP0q3tgoQFhuWu0CfEpH1akm2KQ8XD25iQC35F5QAkrP9cAxgfsszBwDg33AhDlm/q0mUdAVyKT3ojYBtZqrhDT2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541248; c=relaxed/simple;
	bh=o3vogTUu95DwrpQeSzEgM1srp4178kkh8Vy1WlDn73c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cvveLOupHA7Wd6vSUvQyGsvAhuTibRcMiUXGihEk4lk2walUXyGaWpEhlE2NN4+JesdEyyFzDKAVlVyNwn9IwbdPQA2odaKmKbs4Z8HqYLmKMC6Tv7EIU8dVGYof51cZY+ocD1eLQqtX4X1GXcnypNCNFAtHmqKkEEv9ugaVbDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KW1Pt/Jy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KW1Pt/Jy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592161F000FF;
	Wed, 16 Sep 2026 06:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541247;
	bh=x6u8b8cXzrLweZKG0SaQ7whtt4ES33gjdvQPqQFRrUE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KW1Pt/JyVOrR4XNp1929VB9lNLL5syzN332WzSRqn/P2wI/lD6DNj55+bMDezn6RK
	 O65z3ioBT3biUjc/Be0oo1fxkvox/MsO/Ixn1kmZN+5pDMGZ2EZjJmTQqmDGHRh8pj
	 xOSDnm8sG63qJMgzdQN8Oh4AZwxM9V76DpmRGaZfNvVPtsg2JwZ9BgI2XAaeuzASZS
	 QN5BP543Axhgddyes4wfLXBZKwAZz3nJudmwyxfD8pJq/efANe8Pm2H7sj5wSkDfs7
	 GX/zF/qLP3BrQ6YsGf9XhChOLyy2EmDZGHMJywUedAFhVmn9wsp5D/R3KAzs08qqKO
	 4k3366SakFLzQ==
Subject: Re: [PATCH net-next v11 04/15] ax88179_178a: Split driver into
 library and device specific code
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Wed, 16 Sep 2026 06:47:25 +0000
Message-ID: <178954124592.22033.14925382201575115008@kernel.org>
In-Reply-To: <20260914-ax88179a-v11-4-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-4-5ea7a925ba6d@birger-koblitz.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The patch renames the built module from ax88179_178a.ko to
  ax88179.ko (drivers/net/usb/Makefile:…

--

ax88179_178a: Split driver into library and device specific code

This splits ax88179_178a.c into a new ax88179_lib.c/ax88179_lib.h holding
the register definitions and code common to the AX88179/178a/179a/279
family, leaving the device specific parts in ax88179_178a.c. The built
module is renamed from ax88179_178a to ax88179.

> diff --git a/drivers/net/usb/Makefile b/drivers/net/usb/Makefile
> index 4964f7b326fbc..ddd76fa71e2ee 100644
> --- a/drivers/net/usb/Makefile
> +++ b/drivers/net/usb/Makefile
> @@ -12,7 +12,8 @@ obj-$(CONFIG_USB_HSO)		+= hso.o
>  obj-$(CONFIG_USB_LAN78XX)	+= lan78xx.o
>  obj-$(CONFIG_USB_NET_AX8817X)	+= asix.o
>  asix-y := asix_devices.o asix_common.o ax88172a.o
> -obj-$(CONFIG_USB_NET_AX88179_178A)      += ax88179_178a.o
> +obj-$(CONFIG_USB_NET_AX88179_178A)      += ax88179.o
> +ax88179-y := ax88179_178a.o ax88179_lib.o

[Severity: Medium]
This renames the built module from ax88179_178a.ko to ax88179.ko.  Should a
MODULE_ALIAS("ax88179_178a") be added next to the usb_driver in
ax88179_178a.c so that the old name stays resolvable?

Device autoprobing is unaffected, since MODULE_DEVICE_TABLE and the
usb_driver .name are unchanged:

drivers/net/usb/ax88179_178a.c:
	.name =		"ax88179_178a",

But anything keyed on the module name stops matching after the rename:

  - "blacklist ax88179_178a" in /etc/modprobe.d silently becomes a no-op,
    so a host that deliberately kept this driver from binding will bind it
    after the upgrade
  - "modprobe ax88179_178a" fails with "Module ax88179_178a not found"
  - initramfs/dracut force-load lists naming ax88179_178a become dead
    entries

Grepping for MODULE_ALIAS in drivers/net/usb/ax88179*.c at the end of the
series (5c3c73e953b8) returns nothing, so the old name is never restored
later either.

Could the changelog also mention this user-visible consequence?  The
current text only says:

    Rename the module to ax88179 to reflect the broader scope of
    controllers supported by the module.

which does not indicate that name-keyed modprobe configuration changes
behaviour.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914-ax88179a-v11-0-5ea7a925ba6d%40birger-koblitz.de
