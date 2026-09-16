Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A85D41379A;
	Wed, 16 Sep 2026 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543019; cv=none; b=ZkAmILsWHMenwAZ9euKRYi8D7FAk97V8LfXAqvQUJNXof04CzJnl/9zIMl/i7TnKZQuB5uq4Eqb3ngagOEz49DTV9d+CuH3b3to3gxOo56IvP3TJIS9oxtypSpib/ppQcBwbkNRIQwj0zYXlk4nhA83gy5jkWJrt2YYlYtplNKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543019; c=relaxed/simple;
	bh=wYpErp51XFEOKNatJQQ1qpUFTA7CH+HP5CrI7Ptlie0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YryCuzup/X+fut539agnPcuZa8VNSxKX9r5kSfUp3i83iQ2Pfp9fQ2xD5DtzftJq5iEsB34nSeML6nHakab6l+HyQ3hO4Nvod5Zd+cTv79o4kqZgPny1SrQkgaXKSSMkgQVGzdVZn23sw+VlVWFyvnH5n8ZjGTHWXtd8N8UXiW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9vCZns5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9vCZns5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D0D1F000FF;
	Wed, 16 Sep 2026 07:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789543017;
	bh=wq6GtURhwb9MScdG8EkqvppgH8diWprnVq/FWu3TiDQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=a9vCZns5vIqi57Hd2MAe0qTFt3gxccKVQZJ/OGL8tuyq6BNO3fR8U9msFU+RwRu8Z
	 kfqdkfu1I47DuigHrvL0jFRE4fRtJ0tokbKZSOC71/Ygo4qhEhfDEdt72Fx2eO5s95
	 6yCe+6OQjnPchM4vw2Eg3GaksRs0q5h5g/kz4D6ieQj+WZIyEKnK0OW4SJhPx80ZTa
	 XfIuulalD0LWTmXtTjtkceAqmAfqHnhMBPap2BQYJmCRJ7gt1f+A1DbSB3Az4jBkSN
	 mnhm1YrW3xASSHAQVfgz4aJfYs2iEdylIEhJKC5aggW3WbvuLVheb1IwekX5YJMpoA
	 LF9ic0Zp6sknQ==
Subject: Re: [PATCH net-next v14 3/4] ptp: ocp: add TAP CPLD access for ADVA
 TimeCard X1
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, corbet@lwn.net, rdunlap@infradead.org,
 skhan@linuxfoundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 07:16:55 +0000
Message-ID: <178954301560.22033.8297653930280070647@kernel.org>
In-Reply-To: <20260914071555.11684-4-maimon.sagi@gmail.com>
References: <20260914071555.11684-4-maimon.sagi@gmail.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

- [Medium] adva_x1_mblaze_release() (drivers/ptp/ptp_ocp.c:4375-4393)
  documents and the changelog promises that the hand-back "waits for the…
- [Medium] The firmware hand-back failure is swallowed.
- [Low] Forward-referencing leftovers in this intermediate patch:
  #include <linux/iopoll.h> is added at drivers/ptp/ptp_ocp.c:23 with no…

--

ptp: ocp: add TAP CPLD access for ADVA TimeCard X1

This adds a request/grant handshake that re-routes the registered i2c
controller of the ADVA TimeCard X1 from the config EEPROMs onto the TMC
bus, so the Lattice CPLD behind the PCA9548 can be reached.  On top of it
the patch exposes a root-only cpld_status sysfs attribute and reports the
cached Lattice device ID as the fixed devlink version cpld.id.

> diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
> index 3ae41b7634ac..c440d8930384 100644
> --- a/Documentation/ABI/testing/sysfs-timecard
> +++ b/Documentation/ABI/testing/sysfs-timecard
> @@ -11,6 +11,30 @@ Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
> +		==========  ================================================
> +		done        the configuration flash was programmed
> +			    successfully and is active
> +		busy        an internal operation is in progress
> +		failed      the last ISC operation failed
> +		==========  ================================================
> +
> +		For example "busy" while programming, or "busy failed" if a
> +		failure is latched while another operation runs.

[Severity: Low]
This isn't a bug, but the flag descriptions here are phrased in terms of
programming the part ("the configuration flash was programmed
successfully", "busy while programming"), while this commit only defines
CPLD_CMD_READ_ID and CPLD_CMD_READ_STATUS and cannot program anything.

The same forward reference shows up in the code, see the two comments
below.  The follow-up patch in this series, "ptp: ocp: add TAP CPLD
flashing via devlink", is what adds the page-programming commands, the
read_poll_timeout() users and the fw.cpld component, so everything is
live at the end of the series.  Would it read better to move the
upload-referencing wording and the iopoll.h include into that patch?

[ ... ]

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index f4299878c27c..98cb26077181 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -20,10 +20,14 @@
>  #include <linux/spi/altera.h>
>  #include <net/devlink.h>
>  #include <linux/i2c.h>
> +#include <linux/iopoll.h>

[Severity: Low]
Is there a user for this include at this commit?  Grepping the file for
poll_timeout matches only this line; the first *_poll_timeout() caller
(adva_x1_cpld_wait_idle()) arrives with the flashing patch.

>  #include <linux/mtd/mtd.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/crc16.h>
>  #include <linux/dpll.h>
> +#include <linux/unaligned.h>
> +#include <linux/delay.h>
> +#include <linux/firmware.h>

[ ... ]

> @@ -4226,6 +4266,367 @@ static const struct ocp_attr_group art_timecard_groups[] = {
>  	{ },
>  };
>
> +#define ADVA_MUX_ADDR     0x74
> +#define ADVA_CPLD_ADDR    0x40
> +#define ADVA_MUX_CHANNEL  0
> +
> +/* Longest command or reply; bounds each half of the per-claim scratch. */
> +#define ADVA_CPLD_XFER_MAX 32
> +
> +#define MBLAZE_REQUEST    0x0000aaaaU
> +#define MBLAZE_GRANTED    0x5555aaaaU
> +#define MBLAZE_RELEASE    0x55550000U
> +#define MBLAZE_RETRIES    200
> +#define MBLAZE_RETRY_US   10000

[ ... ]

> +/*
> + * Issue one I2C transaction on the TMC bus: @cmd if not negative, then
> + * @wlen bytes of @wdata (NULL sends zeros), then @rlen bytes read back.
> + * The message is built in the scratch buffer from adva_x1_bus_claim(), so
> + * an upload costs one allocation rather than one per page.  I2C_M_DMA_SAFE

[Severity: Low]
This isn't a bug, but the "upload costs one allocation rather than one
per page" rationale refers to an image upload path that does not exist
until the next patch.

> + * is not set: the two halves are not separately aligned, so let the core
> + * bounce.  Caller holds the claim, hence __i2c_transfer().
> + */

[ ... ]

> +/* Hand the segment back, and wait for the firmware to drop the grant before
> + * the caller unlocks the adapter: a transfer queued behind us would
> + * otherwise be clocked out while the controller is still on the TMC bus,
> + * which is what holding the adapter lock across the grant exists to stop.
> + */
> +static void adva_x1_mblaze_release(struct ptp_ocp *bp)
> +{
> +	int i;
> +
> +	if (!bp->pps_select)
> +		return;
> +
> +	iowrite32(MBLAZE_RELEASE, &bp->pps_select->i2c_bus_ctrl);
> +	/* Flush the posted write, as the acquire path does. */
> +	ioread32(&bp->pps_select->i2c_bus_ctrl);
> +
> +	for (i = 0; i < MBLAZE_RETRIES; i++) {
> +		if (ioread32(&bp->pps_select->i2c_bus_ctrl) != MBLAZE_GRANTED)
> +			return;
> +		usleep_range(MBLAZE_RETRY_US, MBLAZE_RETRY_US + 1000);
> +	}

[Severity: Medium]
Can this loop ever iterate?

The constants describe a register with a host-written half and a
firmware-written half:

	#define MBLAZE_REQUEST    0x0000aaaaU		/* host half */
	#define MBLAZE_GRANTED    0x5555aaaaU		/* grant | request */
	#define MBLAZE_RELEASE    0x55550000U		/* grant, request cleared */

adva_x1_mblaze_release() writes MBLAZE_RELEASE first, which clears the
host request half.  After that write the register can read back
0x55550000 (grant still asserted) or 0x00000000, but not 0x5555aaaa, so
the first ioread32() in the loop compares unequal to MBLAZE_GRANTED and
returns.

If that is right, then the usleep_range() body, the
MBLAZE_RETRIES/MBLAZE_RETRY_US budget and the "TMC bus still granted
after release" warning below are all unreachable, and the hand-back the
changelog describes:

    "The hand-back waits for the firmware to drop the grant before the
    adapter lock is released, for the same reason."

does not happen.  adva_x1_bus_release() then calls i2c_unlock_bus()
immediately, so a transfer already queued behind the CPLD operation from
ptp_ocp_read_eeprom(), the nvmem attributes or the at24 sysfs files can be
clocked out while the host controller is still routed to the TMC bus.

Should the wait test the firmware-owned grant field on its own, for
instance polling for the register to read 0 or masking off the request
half before the comparison?

The same helper is the timeout cleanup in adva_x1_mblaze_acquire(), so a
grant asserted just after the host gave up waiting is not observed
either.

Both paths are reachable without user action: adva_x1_cpld_read_id() runs
from ptp_ocp_sync_work() after probe, and cpld_status_show() is a root
read of /sys/class/timecard/ocpN/cpld_status.

> +
> +	dev_warn(&bp->pdev->dev, "TMC bus still granted after release\n");
> +}

[Severity: Medium]
If the wait can expire (that is, if the equality test above does work on
real hardware), is losing the failure here intentional?

adva_x1_mblaze_release() returns void, so after the warning the caller
cannot tell that the firmware never dropped the grant.  Nothing records
the condition, so the next claim re-runs the handshake as if the
controller were back on the EEPROMs.

Note this and the question above are two sides of the same code: either
the poll cannot iterate, or it can and its expiry is ignored.

[ ... ]

> +/* Route the host controller back to the EEPROMs and release the adapter.
> + * Safe after a failed claim: it also clears a request that was never granted.
> + */
> +static void adva_x1_bus_release(struct ptp_ocp *bp)
> +{
> +	struct i2c_adapter *adap = bp->cpld_adap;
> +
> +	if (!adap)
> +		return;
> +
> +	adva_x1_mblaze_release(bp);
> +	bp->cpld_adap = NULL;
> +	kfree(bp->cpld_buf);
> +	bp->cpld_buf = NULL;
> +	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
> +	i2c_put_adapter(adap);
> +}

[Severity: Medium]
Should i2c_unlock_bus()/i2c_put_adapter() run unconditionally when the
hand-back may have failed?

Once the adapter is unlocked, ptp_ocp_read_eeprom(), the nvmem attributes
and the at24 sysfs files address 0x50/0x58 again.  With the controller
still on the TMC segment those transfers either NAK, so has_eeprom_data
stays false, or some TMC device answers and ptp_ocp_read_eeprom() latches
a bogus serial/board_id; an at24 write would be clocked into an unrelated
TMC device.

cpld_status_show() also returns the status word it read as a success in
that case, and adva_x1_cpld_read_id() still publishes bp->cpld_id, so
nothing surfaces the mis-routing to userspace.

[ ... ]

> +/*
> + * Claim the TMC bus.  The adapter lock is held across the handshake to keep
> + * the EEPROM, nvmem and at24 paths off the controller while it is routed
> + * away from the EEPROMs; an EEPROM read blocks until the claim is dropped.
> + */
> +static int adva_x1_bus_claim(struct ptp_ocp *bp)
> +{

[ ... ]

> +	/* One scratch buffer per claim rather than per transfer: an upload
> +	 * holds the claim for the whole image.
> +	 */
> +	bp->cpld_buf = kzalloc(2 * ADVA_CPLD_XFER_MAX, GFP_KERNEL);

[Severity: Low]
This isn't a bug, but same as above: the comment explains the allocation
by an upload that holds the claim for a whole image, which only becomes
true with the flashing patch.

> +	if (!bp->cpld_buf) {
> +		i2c_put_adapter(adap);
> +		return -ENOMEM;
> +	}
> +
> +	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
> +	bp->cpld_adap = adap;
> +
> +	ret = adva_x1_mblaze_acquire(bp);
> +	if (ret)
> +		adva_x1_bus_release(bp);
> +
> +	return ret;
> +}

[ ... ]

All three observations were checked against the last patch of the series
(5c1c35566015); the release wait is unchanged there.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914071555.11684-1-maimon.sagi%40gmail.com
