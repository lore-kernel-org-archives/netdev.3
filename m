Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175F94F6478;
	Thu,  3 Sep 2026 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455917; cv=none; b=iVSYrcobZAy3iv7Hj618s07EblX4dLQMbvvWyCQX7HPe9031rPjw/gCi6nP+jy9mjva55zyfRBxgaueQLbCBqprzdau/2E8TgcZjbVrddVIoYx8FzPGnCrfafsQDz5tUbIDl2Ysm/Z3ff226JwobS9i5hf5+VwFZl3C2diF8TDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455917; c=relaxed/simple;
	bh=Kv0UFpfRjsDqQXOojFir5k2Ouf3Znjfy+VL9ph2YjEc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T52YNt16bjZ4tyzyKd61wD1uCMIJQ10ZnikBAHwgEGKKvCbELUzTyKCPfVJm4RzqBPVT/KTY1j3NRI+FTMkkjQVU5h65Yi0nsM2lpN4XhDsXO8ZiHCDAo2lq9gt61P4XI/h6R8wEmQHqV/i8oeczs1/bytl88tS2R+uGzf9WNCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqIMJ8Of; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqIMJ8Of"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14861F00A3D;
	Thu,  3 Sep 2026 17:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455915;
	bh=uMaqWB+UwzvgUWyLE918KLfU7I23jSgtdGI6IB7cGoA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VqIMJ8OfLQqPW9Q08MzHis4U4oWI5mX6Um/5R58S3RJ0rhNeAqebKiplbdmMFHOuF
	 rUrM6KqoV3EqxeBljLCfDNTLI9Pdycca+nJuORu7VGjM+zHFbzvsbSq+h7XycSVQN8
	 I+eX7xB0NHmsF+6fZn8vCfs7MCVRyYnsjH7KYPC3HoqF0WXPoks/O7TzLkQ4JqhEvh
	 86XxmssQT3thruc8WMm1/otSHV8fW32XH4x0cpwQu6sYWJOZQcsUKv9zTKC/bUU2H4
	 f/yl4Gs+SiMo7vyWlZpSJE4Dq0QBLNnfELEU6HLZ5U24F0Sj9efDnF4GRLG5jkGoj4
	 jlpq3N+7sAVIw==
Subject: Re: [v26,net-next,02/10] net/nebula-matrix: add core driver
 architecture and HW layer initialization
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 17:18:34 +0000
Message-ID: <178845591416.3394541.11052822581750086704@kernel.org>
In-Reply-To: <20260831021408.2325-3-illusion.wang@nebula-matrix.com>
References: <20260831021408.2325-3-illusion.wang@nebula-matrix.com>
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

- [Medium] In `nbl_hw_init_leonis()` (drivers/net/ethernet/nebula-
  matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c) two error paths print…

--

net/nebula-matrix: add core driver architecture and HW layer initialization

This adds the nbl_adapter/nbl_core/nbl_common_info device context, the PCI
probe/remove entry points with basic capability parsing, and the Leonis
hardware layer that requests the BARs and ioremaps them.  One question
below about the BAR size error paths.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> new file mode 100644
> index 000000000000..a67d1a674466
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> @@ -0,0 +1,152 @@

[ ... ]

> +int nbl_hw_init_leonis(struct nbl_adapter *adapter)
> +{
> +	resource_size_t expect_sz = NBL_MEM_BAR_TOTAL_SIZE;
> +	struct nbl_common_info *common = &adapter->common;
> +	struct pci_dev *pdev = common->pdev;
> +	struct nbl_hw_mgt *hw_mgt = NULL;
> +	resource_size_t bar_len;

[ ... ]

> +		if (bar_len < NBL_MEM_BAR_TOTAL_SIZE) {
> +			dev_err(&pdev->dev,
> +				"MEMORY BAR len %pr smaller than expected %pr\n",
> +				&bar_len, &expect_sz);

[Severity: Medium]
Should these two be %pa rather than %pr?

Both bar_len and expect_sz are plain resource_size_t locals on the stack,
but %pr is the struct resource specifier.  vsprintf hands it to
resource_string(), which dereferences the argument as a struct resource:

lib/vsprintf.c:resource_string() {
	...
	if (res->flags & IORESOURCE_IO) {
	...
		p = hex_range(p, pend, res->start, res->end, *specp);
	...
}

struct resource places flags at offset 24 on 64-bit, so does this read
roughly 32 bytes past the end of each 8-byte local and print adjacent
kernel stack contents (both the decoded resource type and the second hex
value) into dmesg?

Nothing warns at build time because every %p variant just consumes a
void *.  Documentation/core-api/printk-formats.rst lists %pa[p] for
phys_addr_t / resource_size_t, so %pa &bar_len (or a cast to
unsigned long long with %llu) would seem to be what is wanted here.

The path is reached from nbl_probe() -> nbl_core_init() ->
nbl_hw_init_leonis() whenever common->has_ctrl is set (function 0, not a
VF) and pci_resource_len(pdev, NBL_MEMORY_BAR) is below 64MiB.

> +			ret = -EINVAL;
> +			goto setup_mgt_fail;
> +		}

[ ... ]

> +	} else {
> +		if (bar_len < NBL_REG_NET_ONLY_LEN) {
> +			dev_err(&pdev->dev,
> +				"MEMORY BAR len %pr too small for net only reg space\n",
> +				&bar_len);

[Severity: Medium]
Same %pr versus %pa question on this second site in nbl_hw_init_leonis(),
which fires on a non-ctrl function when the MEMORY BAR is reported smaller
than 8KiB.

This one still appears unchanged at the end of the series, so no later
patch in the set seems to address it.

> +			ret = -EINVAL;
> +			goto setup_mgt_fail;
> +		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831021408.2325-1-illusion.wang%40nebula-matrix.com
