Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DB937A848;
	Mon, 14 Sep 2026 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789410904; cv=none; b=YBvkjuu2V74FE5E5tGGIJFFa+o9e53jQ6lseCKm3KayZJodCc/NhvLRlbebxdveY9C+LFkuVXo7x4+5UdHJPM8IXOjNIp4j2IeeiNN7DfhXKxZp2jxPmvQCJEDC5dyNjNAjjVOYq1XsHQeLQjp+NrJaCkCAgMhhC+K+J+C6R4xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789410904; c=relaxed/simple;
	bh=2DWjr6tfneSycRcLITs7xeFzwLWXpQLQrPpHQRvNPXs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QQdejJNJ0z0z7R6U4zCiVby10y4Jd4ayaWIS9pVnOuy6MP8E5Wv9jrtuyADRuZt3Zr0LsrTYBe7PW0HoM3g8beRpyB9QlT32ZTxw/KCF+kJkh2eHkasp6Z2ILpHEEjavr0GWs7BZn6AVQ/BIYnff75EPfUCJhwcxBw5xPq5kcSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtcCjaBh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtcCjaBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C321F00893;
	Mon, 14 Sep 2026 18:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789410899;
	bh=wJxDxY9HWSSHy0WuS/Cypa1Lkj/6kf8RiQsbB8ldFW0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BtcCjaBhvvNpCho11De7PyZK3RQgVjpHqyCqB8JQfhTlSlUWgDvQ76F9hU+PtOg+4
	 fZMeF77wz4E6oXlhbDrsdUBJghxPpL4v42Tjes6Ds1F9HQBiVq6c1liGBh/zkoa7Tp
	 3NqWiMnHvtupX1If/TK06C4IsEqrTK/WGUp9hqZOty9WUUwBuYrMGJERLNw07mtKYu
	 Hno4pnhfnIRnjX/DhjaoJeeXe9Igp5zMHhiZIKhqhwad4IR4dVWio4FpfvyvZWMWTP
	 yM7HxbKwJZGN4kSvFonsdkjsmI0bvW+iDlDtb6KPI0RSAU5cMePWjznwOL3ZI0a5f9
	 ogBieMvA3Vtmg==
Subject: Re: [PATCH net-next v15 6/6] net: dsa: mxl862xx: document devlink
 flash and info support
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Mon, 14 Sep 2026 18:34:58 +0000
Message-ID: <178941089843.22033.11660782467868066665@kernel.org>
In-Reply-To: =?utf-8?q?=3Cc0d50bd459b97f4f5efd8a4fc09ab4f9ee4d605a=2E1789175?=
 =?utf-8?q?618=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3Cc0d50bd459b97f4f5efd8a4fc09ab4f9ee4d605a=2E17891756?=
 =?utf-8?q?18=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 2

- [Medium] Documentation vs implementation mismatch on the `fw` info
  version.
- [Low] The Flash update section says "All ports of the switch are closed
  for the duration of the update and the driver reprobes the switch…
- [Low] Every `rescue_failed` cause is reported by
  mxl862xx_devlink_flash_update() (mxl862xx-fw.c:998-1001) with the…

--

net: dsa: mxl862xx: document devlink flash and info support

This adds Documentation/networking/devlink/mxl862xx.rst describing the
devlink info versions and the flash update behaviour of the mxl862xx
driver, links it from the devlink index and adds the file to the driver's
MAINTAINERS entry.

A few questions below about places where the new document and the driver
code seem to describe different behaviour.

> diff --git a/Documentation/networking/devlink/mxl862xx.rst b/Documentation/networking/devlink/mxl862xx.rst
> new file mode 100644
> index 0000000000000..7cbd538a5f3db
> --- /dev/null
> +++ b/Documentation/networking/devlink/mxl862xx.rst
> @@ -0,0 +1,81 @@

[ ... ]

> +   * - ``fw``
> +     - running, stored
> +     - 1.0.70
> +     - Version of the firmware running on the switch, reported as both
> +       running and stored since the switch boots it from its own flash.
> +       It is omitted while no firmware version is known: after a failed
> +       flash, and in MCUboot rescue mode while an interrupted download
> +       is still being recovered in the background. Once the loader is
> +       ready to accept a new image the version appears as "0.0.0",
> +       which no released firmware reports, so version-comparing tools
> +       offer any available release as an upgrade. Use ``devlink dev
> +       flash`` to tell a recovering switch from a ready one, see below;
> +       a missing version on its own does not say why.

[Severity: Medium]
Does the "omitted ... after a failed flash" wording hold for a flash that
was started from rescue mode?

mxl862xx_devlink_info_get() returns early on the rescue path and publishes
the cached version without the all-zero test that guards the normal path:

	if (READ_ONCE(priv->rescue_mode)) {
		if (!READ_ONCE(priv->rescue_ready))
			return 0;

		snprintf(buf, sizeof(buf), "%u.%u.%u",
			 priv->fw_version.major, priv->fw_version.minor,
			 priv->fw_version.revision);
		ret = devlink_info_version_running_put(req,
				DEVLINK_INFO_VERSION_GENERIC_FW, buf);

On failure mxl862xx_devlink_flash_update() zeroes the cache but only the
success path clears rescue_mode:

	if (ret) {
		memset(&priv->fw_version, 0, sizeof(priv->fw_version));
		priv->asic_id = 0;
		priv->asic_rev = 0;
	}

so rescue_mode and rescue_ready both stay set and devlink dev info keeps
reporting fw running/stored "0.0.0" - which this document defines as "the
loader is ready to accept a new image" - while the loader was actually
left mid transfer by the no_end path and devlink dev flash answers -EBUSY
("device is reinitializing, retry later") because skip_teardown is set.

Normally this window lasts until the deferred reprobe fires, but if
device_schedule_reprobe() fails with -ENOMEM nothing else re-classifies
the switch, so it persists. Should either the rescue branch also suppress
an all-zero version, or the document describe this case?

> +
> +Flash update
> +============
> +
> +The ``mxl862xx`` driver implements support for ``devlink dev flash``.
> +The signed firmware image is transferred to the switch over the same
> +MDIO bus which is also used to manage the switch, then verified and
> +installed by the MCUboot bootloader running on the switch. All ports
> +of the switch are closed for the duration of the update and the driver
> +reprobes the switch after it has rebooted into the new firmware. A
> +complete flash and reprobe cycle takes about one minute.

[Severity: Low]
This isn't a bug, but "closed for the duration of the update" reads as if
the pre-flash administrative state comes back once the cycle completes.

mxl862xx_devlink_flash_update() closes and detaches the user ports and
closes the conduit:

	dsa_switch_for_each_user_port(dp, ds) {
		if (dp->user) {
			dev_close(dp->user);
			netif_device_detach(dp->user);
		}
	}
	dsa_switch_for_each_cpu_port(dp, ds)
		dev_close(dp->conduit);

and the rest of the function never records the previous state nor reopens
anything before scheduling the reprobe, so the interfaces come back
registered but down and userspace has to bring them up again. The commit
message of "net: dsa: mxl862xx: add devlink flash_update and info_get"
does say this ("The closed user ports and conduit are not returned to
their pre-flash administrative state across the reprobe; userspace brings
them back up"). Could that sentence be mentioned here as well?

[ ... ]

> +If the driver gives up on the recovery, ``devlink dev flash`` returns
> +``-EIO`` and says so in its extack message. The switch then needs a
> +power cycle, a driver rebind, or both: the driver only re-examines the
> +switch when it binds, so on a board where the switch can be power
> +cycled on its own, unbind and rebind the driver afterwards to have the
> +recovered switch recognised.

[Severity: Low]
This paragraph and the extack text in the driver seem to disagree about
the remedy.

mxl862xx_devlink_flash_update() always advises a power cycle:

	if (READ_ONCE(priv->rescue_failed)) {
		NL_SET_ERR_MSG_MOD(extack,
				   "download recovery failed, power cycle the switch");
		return -EIO;
	}

but mxl862xx_rescue_heal_work_fn() sets rescue_failed for two different
situations. One is a drain error, where a power cycle is the right advice.
The other is a successful drain whose hand-off failed:

	if (device_schedule_reprobe(dev, MXL862XX_FW_REPROBE_DELAY_MS))
		WRITE_ONCE(priv->rescue_failed, true);

In that second case the loader is already sitting at a clean READY and
only the driver needs to re-examine it, yet flashing stays refused with
-EIO for the lifetime of the binding and a power cycle alone does not
clear the flag. Would it make sense for the extack to mention the rebind
too, so it matches what this document says?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1789175618.git.daniel%40makrotopia.org
