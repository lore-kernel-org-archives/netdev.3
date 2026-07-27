Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD17C3F6600;
	Mon, 27 Jul 2026 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785150215; cv=none; b=RVQd/yjg8c4DLIa/WiVFZ5OkUcze/N/Ht/CjLcfpJNMr/R36Wxsp6N/XyV2ntBXMmaPKwyIS70LYw1P8nyvojLEwBtpFeCcNW5nBBKOPNgE+jDpr95GT/nDubhxTSB7YUbUzK/ZLjfbSUFXuvpomX157tlTSQ0Qnzjq77dNpD/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785150215; c=relaxed/simple;
	bh=4mDzR4K24lAyRHYC4gXCXskC3mzGof2e3TVxWzJW19I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pfwMEIYj6dxMINHO+0dMLcMi7VbaoXsbpD2BjjpZapTZTVFIh+2U2qmeZDUH/vHiEZepGONwkXGlv4U6On3lzRn45nGrAxAK5U0itxiG4WkNk0XMQeqKPxuwMiKfGQbQJtlg8SD0VTMN8kfhcZPAHRdFvVk+gEyHPlBJd5rpZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ph0VjpA7; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ph0VjpA7"
Message-ID: <118da808-b9e0-4e5a-9094-9c6dc3740ff4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785150208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pTZ2wdeqGD3OHSx7NCUSqabg5MktQXBsZ0WkjZMuP4s=;
	b=ph0VjpA7kdyxB1Sk/MWlgkmyPJbjeqeEOmeu1GOBusfYW5fWNHsuSs1bmx/b68WIeKU502
	uKKWJgIeDQ5y6IRD/5fZepfaLVcu5NDRgMNL1B0nyR6F6ixa94monjfLugymUNdbrCwbtS
	gXXSg01dpEK3iVAyNJygYWFn545jsmQ=
Date: Mon, 27 Jul 2026 12:02:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260723143908.4019-1-maimon.sagi@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260723143908.4019-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/07/2026 15:39, Sagi Maimon wrote:
> The ADVA TimeCard X1 (PCI device 0x0410) uses a Lattice MachXO3 CPLD
> that is programmed over I2C using in-system programming (ISP).
> 
> The CPLD is connected to a secondary I2C bus shared with the onboard
> MicroBlaze soft CPU.  Add support for taking ownership of this bus and
> exposing the required interfaces through sysfs, allowing userspace tools
> to perform CPLD programming.
> 
> To limit the scope of this functionality, sysfs-based I2C access is
> restricted to the ADVA TimeCard X1 variant and only for the two I2C
> slave addresses used during ISP (0x40 CPLD, 0x74 mux).
> 
> Add two sysfs attributes under /sys/class/timecard/ocpN/ (x1 only):
> 
> i2c_bus_ctrl  - arbitrate the shared I2C bus from the MicroBlaze via
>                  a three-step read/write/poll handshake
> 
> cpld_i2c_xfer - binary passthrough for I2C transactions to the CPLD
>                  and its PCA9548 mux; one atomic request per write()
> 
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
> 
>   Addressed comments from:
>    - Jakub Kicinski :https://lore.kernel.org/all/20260722184418.266546-1-kuba@kernel.org/
> 
>   Changes since v5:
>    - ptp_ocp.c: move mutex_init(&bp->tap_i2c_lock) and
>      bp->tap_i2c_adap_nr = -1 to before the first error path that
>      reaches ptp_ocp_detach(), so mutex_destroy() never operates on an
>      uninitialised mutex (CONFIG_DEBUG_MUTEXES splat on the
>      pci_alloc_irq_vectors() failure path).
>    - ptp_ocp.c: reword the ordering comment above mutex_init /
>      tap_i2c_adap_nr to correctly describe the notifier race: the -1
>      sentinel must precede ptp_ocp_register_resources() so that a
>      ptp_ocp_i2c_notifier_call() firing during adapter registration is
>      not overwritten by this initialisation line; ptp_ocp_adva_board_init()
>      does not touch tap_i2c_adap_nr and was wrongly cited in the
>      previous wording.
>    - Documentation/ABI/testing/sysfs-timecard: add entries for the two
>      new attributes cpld_i2c_xfer (binary I2C pass-through, wire protocol,
>      allowed addresses, response layout) and i2c_bus_ctrl (three-step
>      handshake, magic values, release requirement, PCIe ordering note).
>   
>   Documentation/ABI/testing/sysfs-timecard |  56 ++++++
>   drivers/ptp/ptp_ocp.c                    | 239 ++++++++++++++++++++++-
>   2 files changed, 290 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
> index 3ae41b7634ac..c62766df7a20 100644
> --- a/Documentation/ABI/testing/sysfs-timecard
> +++ b/Documentation/ABI/testing/sysfs-timecard
> @@ -11,6 +11,62 @@ Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
>   Description:	This directory contains the attributes of the Nth timecard
>   		registered.
>   
> +What:		/sys/class/timecard/ocpN/cpld_i2c_xfer
> +Date:		July 2026
> +Contact:	Sagi Maimon <sagi.maimon@adva.com>
> +Description:	(RW) Binary sysfs attribute providing a raw I2C passthrough to
> +		the CPLD and I2C mux on ADVA x1 TAP boards.  Only present on
> +		that board variant.
> +
> +		Each write initiates one I2C transaction.  The write payload
> +		must be exactly four header bytes followed by the write data:
> +
> +		  Byte 0: slave address (only 0x40 and 0x74 are permitted)
> +		  Byte 1: number of bytes to write (0..67)
> +		  Byte 2: number of bytes to read back (0..20)
> +		  Byte 3: flags
> +		            bit 0 - suppress the repeated START before the
> +		                    read segment (I2C_M_NOSTART); only valid
> +		                    when both write and read lengths are
> +		                    non-zero
> +		  Bytes 4..: write data (write_len bytes)
> +
> +		A subsequent read() returns:
> +
> +		  Byte 0: status (0 = success, positive errno on error)
> +		  Bytes 1..: read data (read_len bytes), present only when
> +		             status is 0 and read_len > 0
> +
> +		The write and read portions of the sysfs file share a single
> +		per-device response buffer protected by a mutex; a single
> +		open() / write() / read() sequence must be used to avoid
> +		data races between concurrent users.
> +
> +		Only slave addresses 0x40 (Lattice CPLD) and 0x74 (PCA9548
> +		I2C mux) are accepted; all others return EPERM.
> +
> +What:		/sys/class/timecard/ocpN/i2c_bus_ctrl
> +Date:		July 2026
> +Contact:	Sagi Maimon <sagi.maimon@adva.com>
> +Description:	(RW) Exposes the MicroBlaze I2C bus arbitration register for
> +		the shared I2C bus on ADVA x1 and x2 TAP boards.  Only
> +		present when the board has a pps_select register block.
> +
> +		Userspace must complete a three-step handshake before
> +		driving the bus:
> +
> +		  1. Read  - value must be 0x00000000 (bus is free).
> +		  2. Write - 0x0000ffff (request ownership).
> +		  3. Poll  - read until the value is 0xffffffff (MicroBlaze
> +		             has acknowledged the handover).
> +
> +		After all I2C traffic is complete the bus must be released
> +		by writing 0x00000000.
> +
> +		The poll read is a PCIe non-posted read and therefore also
> +		flushes the preceding posted write to the FPGA; no
> +		additional read-back is required for ordering.
> +
>   What:		/sys/class/timecard/ocpN/available_clock_sources
>   Date:		September 2021
>   Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 35e911f1ad78..79fec5161c99 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -163,7 +163,8 @@ struct gpio_reg {
>   	u32	gpio1;
>   	u32	__pad0;
>   	u32	gpio2;
> -	u32	__pad1;
> +	/* adva_x1: I2C bus ownership register; reserved on other variants */
> +	u32	i2c_bus_ctrl;
>   };
>   
>   struct irig_master_reg {
> @@ -416,6 +417,11 @@ struct ptp_ocp {
>   	dpll_tracker tracker;
>   	int signals_nr;
>   	int freq_in_nr;
> +	/* cpld_i2c_xfer sysfs (adva_x1) */
> +	struct mutex		tap_i2c_lock;
> +	int			tap_i2c_adap_nr; /* adapter nr; -1 if absent */
> +	u8			tap_i2c_rsp[21]; /* [status, read_data...] */

I don't like the idea of having a buffer in a global structure. And it
doesn't look like you can actually serialize access. Imaging 2 processes
manipulating this i2c bus. I can be that mutex will put them like:

1. process1 -> write cmd
2. process2 -> write cmd
3. process1 -> read result

That means the data will be a mess.

That's why it is a really bad thing to allow direct access from the user
space. Is it possible to add a property per command?

> +	size_t			tap_i2c_rsp_len;
>   };
>   
[...]
