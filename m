Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21604ED1A1;
	Wed, 30 Sep 2026 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791541; cv=none; b=V0HGzaXgsg40B+HpwyKc9jeZK2KBrq0S+EgSAgLYGANFb5webBXAdgLn0VBffAt2xUH9Gy/nPAMQuq7fTngSLT1ZlP0I3ppbJEChEKJSgyOaN6iZPilhNdoUlyF6XXSGNhHfvZLt6cpsLT252HuhNhiJozcIGDBQ9h/OQvJ5y+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791541; c=relaxed/simple;
	bh=7s5qL3VoiRN4QgP/J54GeewUvXqQW/DzC+gYAs1/9kw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o1iurhg2b7nr2t1QnY+/ArK+A1qftzq4kz3aZLndRVYiRMR5nkCbNbkG0dnaA7dPzSKll1Z5TQjavQ0q9U3RS7x5KUISGnlglbZjO7zUSxc5oE2ARUbRX1rccdiLiYBNldWCjdIieqiLMbfuLs+SIs4ZaUk9v7QaTRbn4l1VwpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLaXP/7O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLaXP/7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260EB1F00898;
	Wed, 30 Sep 2026 18:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790791539;
	bh=W5ODwbM0MB+eZLv1w+RfFfGPAGIgQCXbgH751X9MUQI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BLaXP/7OeHAOzcjfnsdPyGOttnkx3QXXIQkpdlyqKvdneneVeEHKCrqjEYWP9ldsb
	 k25CGOA2hPzz3PE9zbhwDdDHnTCONiEI6J7MBDIMs0h10+87oJkHsgDRxqSJ/Thn7N
	 M51XGtQY3UmgNBF+EBtPpkWYnhjEQri8ANogmK9j+e/oLsSkSjD1Pl98MYvJ5ffpGl
	 3xH7Vxv8sd8J3WdV7ouFhSSjmv+Zz6EImU1xys0YO4CUYchjACz348//oLeOxTUol5
	 NmCZbkZwV56dAASKOH5SPtBLd/x7G4kFW905ZQZrpRaw8TikF+nDrfpAV/Ur66XRrP
	 3IC6bhNtwbGEQ==
Subject:
 Re: [PATCH] net/atm: fix shift-out-of-bounds in __vcc_connect()/find_ci()
From: netdev-bot+sashiko@kernel.org
To: ngocthang2710.1999@gmail.com
Cc: 3chas3@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 18:05:38 +0000
Message-ID: <179079153866.434549.5010567126851808519@kernel.org>
In-Reply-To: <20260927120410.44906-1-ngocthang2710.1999@gmail.com>
References: <20260927120410.44906-1-ngocthang2710.1999@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch says it fixes the UBSAN report 'shift-out-of-bounds
  in net/atm/common.c:382:32, shift exponent -1 is negative'…
- [Medium] ci_range_bound() (net/atm/common.c:338-343) uses `if (bits <=
  0 || bits > max_bits) return 1 << max_bits;`, which treats bits == 0…

Pre-existing issues:
- [High] find_ci() checks the static VPI cache `p` only against its upper
  bound and never resets it when negative.
- [High] solos-pci's atm_init() (drivers/atm/solos-pci.c:1348) calls
  atm_dev_register() at line 1359.

--

net/atm: fix shift-out-of-bounds in __vcc_connect()/find_ci()

This commit adds a ci_range_bound() helper to net/atm/common.c. The helper
turns ci_range.vpi_bits/vci_bits into an exclusive upper bound. It falls
back to the maximum range for ATM_CI_MAX, or for any other value outside the
documented range. The direct shifts in find_ci() and __vcc_connect() are
replaced with it, and __vcc_connect() gains explicit vpi/vci < 0 checks.

Closes: https://syzkaller.appspot.com/bug?extid=f6ac161ee9699270b8dd

> usbatm_atm_init() has exactly that window: it calls atm_dev_register()
> and only afterwards sets ci_range.vpi_bits/vci_bits. A bind() on
> AF_ATMPVC/AF_ATMSVC racing in during that window sees a vci_bits (or
> vpi_bits) value outside the documented range, and the plain shift is
> undefined behaviour, reported by UBSAN as a negative shift exponent.

[Severity: Medium]
Is this description accurate for the current tree?

Commit a60fd8c6dbaa76 ("usb: atm: usbatm: fix invalid ci_range
initialization") already fixes this UBSAN splat. It has the same "shift
exponent -1 is negative" in __vcc_connect(), reached through
pvc_bind()->vcc_connect(). In that report the -1 was ATM_CI_MAX, which
usbatm_atm_init() stored in ci_range permanently. It did not come from a
registration race.

With that commit applied, usbatm_atm_init() does:

	atm_dev->ci_range.vpi_bits = 8;
	atm_dev->ci_range.vci_bits = 16;

solos-pci atm_init() does the same. Neither driver implements
ATM_SETCIRANGE.

The atm_dev comes from kzalloc_obj() in __alloc_atm_dev(). During the
register-before-assignment window the fields are therefore 0, and shifting
by 0 is well defined. The new comment above ci_range_bound() makes the same
claim, that "the all-zero value the field holds before a driver's probe has
set it" is not a valid shift count.

Is there still a path that reaches a negative or oversized shift count?

The reproduction was run on syzbot's kernel image, which appears to be older
than a60fd8c6dbaa76. The Closes: tag (extid f6ac161ee9699270b8dd) looks like
a duplicate of the report that commit closed (extid 6665d3db5fef15914802).

Should this patch be dropped as a duplicate? Alternatively, it could be
resent as hardening, with a description that references a60fd8c6dbaa76.

> diff --git a/net/atm/common.c b/net/atm/common.c
> index 81195727fa18b..bb6bc26eb5992 100644
> --- a/net/atm/common.c
> +++ b/net/atm/common.c
> @@ -327,6 +327,21 @@ static int check_ci(const struct atm_vcc *vcc, short vpi, int vci)
>  	return 0;
>  }
>  
> +/*
> + * ci_range.vpi_bits/vci_bits are documented as 1..8 / 1..16, with
> + * ATM_CI_MAX (-1) meaning "no restriction". Neither that sentinel nor
> + * the all-zero value the field holds before a driver's probe has set
> + * it (see the register-before-ci_range-is-set race in usbatm_atm_init())
> + * is a valid shift count, so compute the exclusive upper bound instead
> + * of shifting a VPI/VCI by a possibly negative or out-of-range amount.
> + */
> +static int ci_range_bound(signed char bits, int max_bits)
> +{
> +	if (bits <= 0 || bits > max_bits)
> +		return 1 << max_bits;

[Severity: Medium]
Should bits == 0 really be treated as the maximum-range case here?

A width of 0 bits is well defined. 1 << 0 is 1, so only VPI/VCI 0 is valid.

Before this patch, a device with vpi_bits == 0 rejected any explicit
vpi != 0 in __vcc_connect(), because vpi >> 0 is nonzero. find_ci() also
limited its scan to p < 1.

After this patch, __vcc_connect() accepts VPI 0..255 and VCI 0..65535 for
such a device. find_ci() can also auto-assign values in that range. An unset
range now gets the most permissive bound instead of the most restrictive
one.

In this tree, bits == 0 only occurs between atm_dev_register() and the
driver's ci_range assignment. This change therefore lets explicit-CI binds
through while the device is only half initialised (see the solos-pci comment
below). It would also affect any driver that uses 0 bits to mean "VPI 0
only" and indexes tables by VPI/VCI.

Would it be enough to apply the fallback only for bits < 0 (ATM_CI_MAX)? That
avoids the undefined shift and keeps the old behaviour for 0.

> +	return 1 << bits;
> +}
> +
>  static int find_ci(const struct atm_vcc *vcc, short *vpi, int *vci)
>  {
>  	static short p;        /* poor man's per-device cache */
> @@ -342,12 +357,13 @@ static int find_ci(const struct atm_vcc *vcc, short *vpi, int *vci)
>  	/* last scan may have left values out of bounds for current device */
>  	if (*vpi != ATM_VPI_ANY)
>  		p = *vpi;
> -	else if (p >= 1 << vcc->dev->ci_range.vpi_bits)
> +	else if (p >= ci_range_bound(vcc->dev->ci_range.vpi_bits, 8))
>  		p = 0;

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but the
patch rewrites this line. Should the static cache p also be reset when it is
negative?

A bind with vpi = ATM_VPI_UNSPEC (-2) and vci = ATM_VCI_ANY runs p = *vpi,
which leaves the static p at -2. A later ATM_VPI_ANY request, on any device,
only checks p >= bound, so p stays at -2.

The VCI cache has a matching lower-bound check (c < ATM_NOT_RSV_VCI). The
VPI cache does not.

This seems to cause two problems.

First, find_ci() can return *vpi = -2, or -1 after p++, for an ATM_VPI_ANY
request. vcc_connect() sets ATM_VF_PARTIAL based on the caller's vpi:

	if (vpi == ATM_VPI_UNSPEC || vci == ATM_VCI_UNSPEC)
		set_bit(ATM_VF_PARTIAL, &vcc->flags);

The socket is therefore treated as fully connected with a sentinel VPI.
usbatm and solos then write that VPI into cell/packet headers.

Second, once old_p is negative, this exit condition can never be met,
because p++ only wraps back to 0:

	} while (old_p != p || old_c != c);

Take vpi = ATM_VPI_ANY with an explicit vci. If (-2, vci), (-1, vci) and
(0..255, vci) are all occupied, can this loop spin forever under
write_lock_irq(&vcc_sklist_lock)?

This sequence seems to reach it for an unprivileged user with a usbatm
device:

  bind(UNSPEC, ANY)         -> p = -2
  bind(UNSPEC, 100)         -> occupies (-2, 100), p unchanged
  bind(ANY, 100)            -> gets (-1, 100)
  bind(UNSPEC, ANY)         -> p = -2 again
  bind(0..255, 100) x 256   -> explicit, p unchanged
  bind(ANY, 100)            -> p never returns to old_p = -2

usbatm_atm_open() does not range-check vpi. It also sets ATM_VF_ADDR, which
check_ci() needs to detect collisions. The sequence takes about 260 sockets,
each with UBR QoS.

[ ... ]

> @@ -378,8 +394,9 @@ static int __vcc_connect(struct atm_vcc *vcc, struct atm_dev *dev, short vpi,
>  	int error;
>  
>  	if ((vpi != ATM_VPI_UNSPEC && vpi != ATM_VPI_ANY &&
> -	    vpi >> dev->ci_range.vpi_bits) || (vci != ATM_VCI_UNSPEC &&
> -	    vci != ATM_VCI_ANY && vci >> dev->ci_range.vci_bits))
> +	    (vpi < 0 || vpi >= ci_range_bound(dev->ci_range.vpi_bits, 8))) ||
> +	    (vci != ATM_VCI_UNSPEC && vci != ATM_VCI_ANY &&
> +	    (vci < 0 || vci >= ci_range_bound(dev->ci_range.vci_bits, 16))))
>  		return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but the zero-to-maximum fallback
opens a second path to an existing NULL dereference in solos-pci.

drivers/atm/solos-pci.c:atm_init() publishes the device before it sets up
ci_range and dev_data:

	card->atmdev[i] = atm_dev_register("solos-pci", parent, &fpga_ops, -1, NULL);
	...
	card->atmdev[i]->ci_range.vpi_bits = 8;
	card->atmdev[i]->ci_range.vci_bits = 16;
	card->atmdev[i]->dev_data = card;

device_create_file(), sysfs_create_group() and dev_info() run in between.

A concurrent bind(AF_ATMPVC) in that window goes through
pvc_bind()->vcc_connect()->__vcc_connect()->popen(). popen() reads
card = vcc->dev->dev_data, which is still NULL, and calls
fpga_queue(card, ...). fpga_queue() then does:

	spin_lock_irqsave(&card->tx_queue_lock, flags);

Before this patch, wildcard binds already passed the zero-width check, and
find_ci() resolved them to (0, 32). Now ci_range_bound(0, 16) returns 65536,
so explicit requests such as (0, 32) or (5, 100) also get through. The old
vci >> 0 check rejected those.

usbatm_atm_open() returns -ENODEV while dev_data is NULL, but popen() has no
readiness check at all.

Would this need the device to be initialised before atm_dev_register(), or a
synchronised readiness check in popen()? Changing how the bound is computed
does not seem enough on its own.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927120410.44906-1-ngocthang2710.1999%40gmail.com
