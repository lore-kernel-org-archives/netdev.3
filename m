Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CAE449B26;
	Thu, 17 Sep 2026 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789684501; cv=none; b=DwPZ0iQf8q1PuwmWDDX2zQgbBFcfYQcdOOzTfkOiR1GuvVnxMyPFXfPzy2MMHKyGeV11kodTZF+DVz1u3waAhFksK8oCYOjgPty6FBuR1X6Svcy4uEOHrlEZRdJ+KySOxDjS+rxleKF372V+xbjStr08Z5AjcWD1Qbi2Dzok5pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789684501; c=relaxed/simple;
	bh=slmwenKVNm7oiFHsA0N2JQn3F94d4Vx0OSusBSuSHLY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uya0lXHNjGMpgPh5jPNCUj3znyt/Ryct2t2KW8g54bFVJdF4T5bmn2CIUDx+Sx6IViJBb/bGuNNrCY1FINJ0VF2UXpGGFUfi483EwzLIAbKkEQfxUK/9NsN4Vh7t5dP5H2h9dLUn/JaIEsThnKpVa5QZRpLjRNReqS9FJcrodBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVATthhi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVATthhi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5646B1F000FF;
	Thu, 17 Sep 2026 22:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684500;
	bh=AwxJ8N+cZbpD5bptxQGFwIFSG4k3sUIJceTDXjNhTGc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KVATthhixeMA+YMMyshkfJD37dUY/D7jd4LBOSfuFz4yK04r7+lv+wxob3PaMTOBF
	 7fRlXY51wuY4s9+wRG4XSg/b+QI5kz14CbE6DZF4kAHz3StynxN15EwUyxlzwET5Uk
	 +V7I+v7UxVIWkElW8gdtMMfpXq+fu6l/5vJdjAZP+GNRDck/5oT0DHPan/1Ro0WwYM
	 xCKoEN3+OQIJL02rCMIdAxU5fBkyQrMfveiYSk9dizUKH9dpiFvlxc67O//r4tser1
	 BBaapRFtxaVwVTobUt+L3KR5AX2NTwwrbLTdmW61f05z32s+r3BImtygEmsoPcmXKO
	 YyHribX3lAy/w==
Subject: Re: [PATCH v28 net-next 01/10] net/nebula-matrix: add minimum nbl
 build framework
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 22:34:58 +0000
Message-ID: <178968449889.22033.13874613436402978456@kernel.org>
In-Reply-To: <20260914123429.56596-2-illusion.wang@nebula-matrix.com>
References: <20260914123429.56596-2-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] At this commit only, the user-facing artifacts describe
  functionality that the added code does not contain: CONFIG_NBL help…

--

net/nebula-matrix: add minimum nbl build framework

This adds the Kconfig, Makefile, MAINTAINERS entry and documentation for a
new nebula-matrix ethernet driver, plus a PCI driver skeleton whose probe
and remove callbacks are empty stubs.  The commit message notes that the
real implementation follows in later patches of the series.

> diff --git a/Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst b/Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst
> new file mode 100644
> index 0000000000000..5540291cf3766
> --- /dev/null
> +++ b/Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst
> @@ -0,0 +1,28 @@

[ ... ]

> +This driver provides the core infrastructure for m18110/m18000-NIC
> +devices, including:
> +
> +- PCI device enumeration and resource (BAR) management
> +- Firmware command interface via PF mailbox
> +- Channel-based communication between driver and firmware
> +- Device initialization and teardown

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/Kconfig b/drivers/net/ethernet/nebula-matrix/Kconfig
> new file mode 100644
> index 0000000000000..dd0e91d14131f
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/Kconfig
> @@ -0,0 +1,32 @@

[ ... ]

> +config NBL
> +	tristate "Nebula-matrix Ethernet Controller m18110/m18000 support"
> +	depends on PCI && (64BIT || COMPILE_TEST) && !CPU_BIG_ENDIAN
> +	help
> +	  This driver provides the core infrastructure for Nebula-matrix
> +	  Ethernet Controller m18110/m18000 Family of devices, including
> +	  PCI enumeration, firmware mailbox and channel communication.

[Severity: Low]
This isn't a bug, but the commit message says:

  Note: the documentation describes the final full driver features;
  implementation will be added in subsequent patches of this series.

That disclaimer covers nbl.rst, but the CONFIG_NBL help text makes the same
claims ("PCI enumeration, firmware mailbox and channel communication") and
isn't mentioned.  At this commit nbl_probe() just returns -ENODEV and
nbl_remove() is empty, so none of the described infrastructure exists yet.

Would it make sense to either extend the note to cover the Kconfig help
text, or move the feature list into the patch that actually adds the
enumeration, mailbox and channel code?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> new file mode 100644
> index 0000000000000..199626159a4ce
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> @@ -0,0 +1,100 @@

[ ... ]

> +static int nbl_probe(struct pci_dev *pdev,
> +		     const struct pci_device_id *id)
> +{
> +	return -ENODEV;
> +}
> +
> +static void nbl_remove(struct pci_dev *pdev)
> +{
> +}

[ ... ]

> +	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX_BASE_T_OCP),
> +	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) },
> +	/* required as sentinel */
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, nbl_id_table);

[Severity: Low]
This isn't a bug either, just an observation about the intermediate state.
The full 16-entry nbl_id_table plus MODULE_DEVICE_TABLE(pci, nbl_id_table)
publishes udev autoload aliases for 1f0f:3403-3412 at a point where every
match is rejected:

  nbl_probe()
      return -ENODEV;

So a kernel built exactly at this commit with CONFIG_NBL=m will autoload
nbl on a present m18110/m18000 card and log a probe failure for each
matching function, with the device left unbound.  Nothing is allocated
before the -ENODEV return, so there is no leak, but it is visible during a
bisect of this series.

Would it be cleaner to add the id table (or the driver registration) in the
patch where nbl_probe() gains a working implementation, keeping every commit
in the series functional?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914123429.56596-1-illusion.wang%40nebula-matrix.com
