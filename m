Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDE129D268
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 00:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408522; cv=none; b=J3i0T1M8AfzNN9pfIXpu2hhnkeLQ2g5lKW2bC4na7sN0+Y7cy/V2Tm4R9m04wX2ivl9bBt3q8R4407KHxd0T52vDvW2ep4q5YQL8R7PmPU16Xoo/vEgDX+w0Q3WumSE+7OKwbmoxobwjxjA3DBeNBhlm2yYD2jh5bkSCLuCjo9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408522; c=relaxed/simple;
	bh=WhP2lOM5w0n8maLt12F+2DFx80adq//haApkvQ4VJbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iP2mM9xzfPLnVE9qEkFDLRiu75lsdvaHJfO/8aXOptz8yeQ11QXCqPmsssm+H94uoc/S/E/PjYTk7HygdOjG0Dbkha2opedFjfTkZvpfpW2xziqRkUyJKNIIWynIdFOnnXGLESvERDdfCwKMDYVq8ixZmN55vjZNE8Mc8sIbyBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpQ4BdE+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpQ4BdE+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651BA1F000E9;
	Tue, 11 Aug 2026 00:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786408520;
	bh=ZSCpf6OJ/ilffCJiSskzsvzilKbwsxvMYFLd8Puqe7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TpQ4BdE+m5/VfCxCyzWyPInhNykdZGgwGyvSmfNOPtM7JE+Ua/49JvW0g4L6ija3x
	 7CeElP0SkQqRLJESw2R8PPlMg/5JaBqQt9/zDU9VH6rffvxkLOBnVOdcy84lZBdivd
	 /X1alpnJOjuz8YDnb6p6ydQpyVFsyHcGh7qGq334U2LEousPBhPom3JhWXYOW7Zsau
	 8sDPxDn3EKZ8nN9ygYcuCEDmsWwQYZacT3DVn47oqgiS8RSjZjl1Wst8hsetgSwOdF
	 fU6jcqvWDIH6YcZyXN2mI6teLu4z4TDc0U4ofEMuVHeNeifw7GY6Qn0Cat00pyFpph
	 vpKjpHkglABeQ==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	tactii@gmail.com,
	dima.ruinskiy@intel.com,
	aleksandr.loktionov@intel.com,
	pmenzel@molgen.mpg.de,
	michalx.cohen@intel.com
Subject: Re: [PATCH net-next 14/15] igc: Support ACPI-based MAC pass-through
Date: Mon, 10 Aug 2026 17:35:19 -0700
Message-ID: <20260811003520.1056993-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805213541.2281287-15-anthony.l.nguyen@intel.com>
References: <20260805213541.2281287-15-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
igc: Support ACPI-based MAC pass-through

This adds igc_get_acpi_mac_passthru(), which evaluates the ACPI objects
\_SB.AMAC and \MACA and parses the _AUXMAC_#AABBCCDDEEFF# payload into an
Ethernet address.  igc_probe() now uses that address in preference to the
NVM address whenever eth_platform_get_mac_address() fails.

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 21d2fe38a41a6..424c12c0394a3 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c

[ ... ]

> @@ -7105,6 +7107,57 @@ static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer *timer)
>  	return HRTIMER_NORESTART;
>  }
>  
> +static bool igc_get_acpi_mac_passthru(u8 *mac)
> +{
> +	static const struct {
> +		const char *name;
> +		acpi_object_type type;
> +		u32 length;
> +	} sources[] = {
> +		{ "\\_SB.AMAC", ACPI_TYPE_BUFFER, 23 },
> +		{ "\\MACA",     ACPI_TYPE_STRING, 22 },
> +	};
> +	struct acpi_buffer buffer;
> +	union acpi_object *obj;
> +	bool mac_found = false;
> +	acpi_status status;
> +	u8 buf[ETH_ALEN];
> +	int i;
> +
> +	if (!IS_ENABLED(CONFIG_ACPI))
> +		return false;
> +
> +	for (i = 0; i < ARRAY_SIZE(sources) && !mac_found; i++) {
> +		buffer.length = ACPI_ALLOCATE_BUFFER;
> +		buffer.pointer = NULL;
> +
> +		status = acpi_evaluate_object(NULL, (char *)sources[i].name,
> +					      NULL, &buffer);
> +		if (ACPI_FAILURE(status))
> +			continue;
> +
> +		obj = buffer.pointer;
> +		if (!obj || obj->type != sources[i].type ||
> +		    obj->string.length != sources[i].length)
> +			goto free_obj;
> +
> +		if (strncmp(obj->string.pointer, "_AUXMAC_#", 9) ||
> +		    obj->string.pointer[21] != '#')
> +			goto free_obj;
> +
> +		if (hex2bin(buf, obj->string.pointer + 9, ETH_ALEN) ||
> +		    !is_valid_ether_addr(buf))
> +			goto free_obj;
> +
> +		ether_addr_copy(mac, buf);
> +		mac_found = true;
> +free_obj:
> +		kfree(obj);
> +	}
> +
> +	return mac_found;
> +}
> +
>  /**
>   * igc_probe - Device Initialization Routine
>   * @pdev: PCI device information struct
> @@ -7268,9 +7321,16 @@ static int igc_probe(struct pci_dev *pdev,
>  	}
>  
>  	if (eth_platform_get_mac_address(&pdev->dev, hw->mac.addr)) {
> -		/* copy the MAC address out of the NVM */
> -		if (hw->mac.ops.read_mac_addr(hw))
> +		/* Look for a system-provided MAC in the ACPI table before
> +		 * falling back to reading the address from the NVM.
> +		 */
> +		if (igc_get_acpi_mac_passthru(hw->mac.addr)) {
> +			netdev->addr_assign_type = NET_ADDR_STOLEN;
> +			dev_info(&pdev->dev, "Using ACPI pass-through MAC addr %pM\n",
> +				 hw->mac.addr);

[Severity: High]
Can two igc ports end up with the same MAC address here?

igc_get_acpi_mac_passthru() takes only an output pointer and evaluates the
absolute paths \_SB.AMAC and \MACA with a NULL handle:

	status = acpi_evaluate_object(NULL, (char *)sources[i].name,
				      NULL, &buffer);

There is no reference to ACPI_HANDLE(&pdev->dev), no PCI slot/function or
hw->device_id check, no NVM/EFUSE pass-through enable bit and no DMI match,
so every invocation returns the same six bytes.  igc_probe() runs once per
igc PCI function, so on a dual/quad-port i225/i226 board, or with an onboard
igc plus an i226 add-in or Thunderbolt adapter, each probe takes the same
system address.

Is the address only a software label at that point, or does it reach the
hardware filter?  From igc_probe() the path looks like:

	igc_probe()
	  igc_reset()
	    hw->mac.ops.init_hw()      /* igc_init_hw_base() */
	      igc_init_rx_addrs()
	        hw->mac.ops.rar_set(hw, hw->mac.addr, 0);

so the duplicated address is programmed into RAR0 as each controller's real
unicast receive filter (and magic-packet WoL filter).  The existing check

	if (!is_valid_ether_addr(netdev->dev_addr)) {

cannot detect this, since a duplicated address is still valid.

These same objects are the Dell/Lenovo dock pass-through ABI already consumed
by drivers/net/usb/r8152.c:vendor_mac_passthru_addr_read(), which uses the
identical names, types, lengths 0x16/0x17, '#' at offset 0x15 and hex2bin at
+9, but gates the lookup on device identity or capability first:

	if (tp->lenovo_macpassthru) {
		mac_obj_name = "\\MACA";
		...
	} else {
		/* test for -AD variant of RTL8153 */
		...
			if ((ocp_data & PASS_THRU_MASK) != 1) {
				... return -ENODEV;

On a machine with such a dock, would an igc port now claim the address that
firmware designated for the dock interface, colliding with it and changing
the identity used for 802.1X MAB, DHCP reservations and MAC ACLs?  Should
this lookup be gated on a designated port, a capability bit, or a platform
match?

Relatedly, the commit message says the system MAC address "is intended to
override the permanent MAC address of the network controller", in the
singular.  If applying it to every igc controller in the system is intended,
could the message say so and explain why the duplicate-address case is
acceptable?

One more thing on this path: read_mac_addr() is what normally populates
hw->mac.perm_addr, and it is now skipped in the ACPI case, so perm_addr is
left unset compared to the NVM path.  Is that intentional?

> +		} else if (hw->mac.ops.read_mac_addr(hw)) {
>  			dev_err(&pdev->dev, "NVM Read Error\n");
> +		}
>  	}
>  
>  	eth_hw_addr_set(netdev, hw->mac.addr);
