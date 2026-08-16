Received: from mta0.migadu.com (out-74.mta0.migadu.com [91.218.175.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEB03DCDBF
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786918797; cv=none; b=saO2kb5f3xP7VTgRCUnOIX7/ZSVr7mikxvX1hArY5umoWkOjSyDR8U2WmjcrHMRhOE0tKZkYGddYH8nSLQ3yf4AYilaZ10tfiEou1ftqa+MOaCFV3wEy/H8jlgAHT1uujd/qCRApXOb2YLeVItX/AiW8YXh7T4TJa6np7eVd/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786918797; c=relaxed/simple;
	bh=cQzpTJIcL0FxmqDTSIPae51v+jtcUsta0N2xhAsJmDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YT1dyaQ7rS+Oyf6bL/SklvgqYDSH0OpB8n26/MJjtohirz/H0hSInO6NuGv3UQW531puN9RAJdAxbTqsG0QqiRDeiJFadn8j5bfN6FnaO3kxAxnihIiIBHfSkh8D018eRJCD2lRKCK/lr8BXMunCZy0kgX/jBs87qAylbOpJgmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cs2fls47; arc=none smtp.client-ip=91.218.175.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cs2fls47"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cQzpTJIcL0FxmqDTSIPae51v+jtcUsta0N2xhAsJmDU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786918792; v=1; x=1787523592;
 b=cs2fls47hq/GUfhR4LUGqD6zZMYew7rs+qMnZgHOWSQrPqstQsTa8rCbYysnOqnisSzFVNqm
 zhC1tZPNtr8uLYukyEmnmYVGZ7W7whB2WRSfKbHeVEuhp2DqxHLHOrsqlydcQnUlwxDnGICPVPF
 4TvQo9Y2vmVJ3wX9FxV6djwY=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.1.24] (51.37.165.162)
	by smtp.migadu.com with ESMTPS id 189be061e3611b45;
	Sun, 16 Aug 2026 22:19:52 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <882712e7-b13e-47a6-91f0-998dc59e8eb8@linux.dev>
Date: Sun, 16 Aug 2026 23:19:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 2/2] ptp: ocp: add TAP CPLD firmware upload
 for ADVA TimeCard X1
To: Sagi Maimon <maimon.sagi@gmail.com>, netdev@vger.kernel.org
Cc: richardcochran@gmail.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <20260811135720.109580-1-maimon.sagi@gmail.com>
 <20260811135720.109580-3-maimon.sagi@gmail.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260811135720.109580-3-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2026 14:57, Sagi Maimon wrote:
> The Lattice MachXO3 CPLD on the ADVA TimeCard X1 is programmed over I2C
> using in-system programming (ISP).  Build on the TMC bus arbitration
> added previously and expose the update path through the kernel
> firmware-upload subsystem.
> 
> The framework acquires the bus, erases the configuration flash, programs
> the image page-by-page and activates it with the MachXO3 REFRESH
> command.  The upload node is registered per card as adva-cpld.N, using
> the same index as the owning ocpN device, so a host with more than one
> X1 board gets one node each:
> 
>    /sys/class/firmware/adva-cpld.N/
> 
> The whole prepare/write/poll_complete/cleanup sequence runs under
> cpld_lock and the i2c adapter lock, so an EEPROM read blocks for as long
> as programming takes; the alternative is reading the TMC bus instead.
> The upload is unregistered first on detach, which cancels and flushes an
> in-flight programming cycle while the I2C controller is still up.
> 
> Select FW_LOADER and FW_UPLOAD, as the documented update path does not
> exist without them.
> 
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
>   Documentation/ABI/testing/sysfs-timecard |   5 +
>   drivers/ptp/Kconfig                      |   2 +
>   drivers/ptp/ptp_ocp.c                    | 313 ++++++++++++++++++++++-
>   3 files changed, 319 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
> index 26a93cee0b89..41eeadd46330 100644
> --- a/Documentation/ABI/testing/sysfs-timecard
> +++ b/Documentation/ABI/testing/sysfs-timecard
> @@ -30,6 +30,11 @@ Description:	(RO, root only) The status register of the TAP CPLD, in
>   		ID of the CPLD is reported as the fixed "cpld.id" version by
>   		devlink dev info.
>   
> +		To program new CPLD firmware use the standard kernel
> +		firmware-upload interface, registered per card at:
> +		/sys/class/firmware/adva-cpld.N/
> +		where N is the index of this ocpN device.
> +
>   What:		/sys/class/timecard/ocpN/available_clock_sources
>   Date:		September 2021
>   Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
> diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
> index b93640ca08b7..0c2c7dd32e7f 100644
> --- a/drivers/ptp/Kconfig
> +++ b/drivers/ptp/Kconfig
> @@ -218,6 +218,8 @@ config PTP_1588_CLOCK_OCP
>   	select NET_DEVLINK
>   	select CRC16
>   	select DPLL
> +	select FW_LOADER
> +	select FW_UPLOAD
>   	help
>   	  This driver adds support for an OpenCompute time card.
>   
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 41a7fde1ae6a..4a0bd9b89452 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -20,12 +20,14 @@
>   #include <linux/spi/altera.h>
>   #include <net/devlink.h>
>   #include <linux/i2c.h>
> +#include <linux/iopoll.h>
>   #include <linux/mtd/mtd.h>
>   #include <linux/nvmem-consumer.h>
>   #include <linux/crc16.h>
>   #include <linux/dpll.h>
>   #include <linux/unaligned.h>
>   #include <linux/delay.h>
> +#include <linux/firmware.h>
>   
>   #define PCI_DEVICE_ID_META_TIMECARD		0x0400
>   
> @@ -426,6 +428,9 @@ struct ptp_ocp {
>   	struct i2c_adapter	*cpld_adap;           /* claimed adapter; valid under cpld_lock */
>   	u32			cpld_id;              /* cached Lattice device ID; 0 if unread */
>   	bool			has_cpld;             /* x1 TAP CPLD present */
> +	struct fw_upload	*cpld_fw_upload;      /* firmware upload handle; NULL if absent */
> +	bool			cpld_cancel;          /* cancellation requested */
> +	bool			cpld_in_config_mode;  /* EN_CFG_TP issued but not yet REFRESH'd */
>   };
>   
>   #define OCP_REQ_TIMESTAMP	BIT(0)
> @@ -459,6 +464,8 @@ static int ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
>   
>   static int ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
>   
> +static const struct fw_upload_ops adva_cpld_upload_ops;
> +
>   static const struct ocp_sma_op ocp_adva_sma_op;
>   static const struct ocp_sma_op ocp_adva_x1_sma_op;
>   static int adva_x1_cpld_device_id(struct ptp_ocp *bp, u32 *id);
> @@ -3225,6 +3232,29 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
>   	ptp_ocp_sma_init(bp);
>   
>   	bp->has_cpld = info->has_cpld;
> +	if (bp->has_cpld) {
> +		struct fw_upload *fwl;
> +		const char *name;
> +
> +		/* One instance per card, numbered like the ocpN device.
> +		 * firmware_upload_register() keeps the pointer rather than
> +		 * copying the string, so it has to outlive the registration.
> +		 */
> +		name = devm_kasprintf(&bp->pdev->dev, GFP_KERNEL,
> +				      "adva-cpld.%d", bp->id);
> +		if (!name)
> +			return -ENOMEM;
> +
> +		fwl = firmware_upload_register(THIS_MODULE, &bp->pdev->dev,
> +					       name, &adva_cpld_upload_ops, bp);
> +		if (IS_ERR(fwl))
> +			dev_warn(&bp->pdev->dev,
> +				 "CPLD firmware upload unavailable: %pe\n",
> +				 fwl);
> +		else
> +			bp->cpld_fw_upload = fwl;
> +	}
> +
>   	return ptp_ocp_init_clock(bp, &info->servo);
>   }
>   
> @@ -4283,6 +4313,15 @@ static const struct ocp_attr_group art_timecard_groups[] = {
>   /* Lattice LCMXO3LF ISC command codes */
>   #define CPLD_CMD_READ_ID      0xE0000000UL
>   #define CPLD_CMD_READ_STATUS  0x3C000000UL
> +#define CPLD_CMD_EN_CFG_TP    0x74   /* enable config, transparent mode */
> +#define CPLD_CMD_DIS_CFG      0x26
> +#define CPLD_CMD_ERASE        0x0E
> +#define CPLD_CMD_RESET_ADDR   0x46
> +#define CPLD_CMD_WRITE_PAGE   0x70
> +#define CPLD_CMD_SET_DONE     0x5E
> +#define CPLD_CMD_REFRESH      0x79
> +#define CPLD_PAGE_SIZE        16
> +#define CPLD_POLL_US          10000  /* status poll interval while busy */
>   
>   /* Status register bit positions (Lattice LCMXO3LF datasheet) */
>   #define CPLD_STATUS_DONE   BIT(8)
> @@ -4408,7 +4447,8 @@ static void adva_x1_bus_release(struct ptp_ocp *bp)
>    * Claim the TMC bus for a CPLD operation.  Holding the adapter lock over
>    * the handshake keeps ptp_ocp_read_eeprom(), the nvmem attributes and the
>    * at24 sysfs files off the controller while it is routed away from the
> - * EEPROMs.
> + * EEPROMs.  A firmware upload holds it across the whole prepare/write/poll
> + * sequence, so an EEPROM read blocks for as long as programming takes.
>    */
>   static int adva_x1_bus_claim(struct ptp_ocp *bp)
>   {
> @@ -4442,6 +4482,20 @@ static int adva_x1_mux_select(struct ptp_ocp *bp, int ch)
>   	return adva_x1_i2c_xfer(bp, ADVA_MUX_ADDR, &val, 1, NULL, 0);
>   }
>   
> +/* Send 1-byte ISC command + optional arguments. */
> +static int adva_x1_cpld_write(struct ptp_ocp *bp,
> +			      u8 cmd, const u8 *args, u8 nargs)
> +{
> +	u8 buf[1 + 64];
> +
> +	if (nargs > 64)
> +		return -EINVAL;
> +	buf[0] = cmd;
> +	if (nargs)
> +		memcpy(&buf[1], args, nargs);
> +	return adva_x1_i2c_xfer(bp, ADVA_CPLD_ADDR, buf, 1 + nargs, NULL, 0);
> +}

this function looks like not needed. basically, all callers of this 
function use either static, or stack-allocated buffurs, which are copied
to another 65-byte stack allocated buffer, which is later copied to a
heap-allocated buffer in adva_x1_i2c_xfer(). I think it's too much of
copying for a command interface. It can be simplified to actually copy
a command byte to a very last buffer only. The check can also be moved
to adva_x1_i2c_xfer(). Even static per-command data can be returned as
a pointer via helper with switch-case block. I believe it will make code
much simplier and more readable.

> +
>   /*
>    * Send a 4-byte command then read data back without an intermediate STOP
>    * (Lattice combined write->repeated-START->read).  Two messages in one
> @@ -4467,6 +4521,38 @@ static int adva_x1_cpld_read_status(struct ptp_ocp *bp, u32 *status)
>   	return 0;
>   }
>   

[...]

> +static enum fw_upload_err
> +adva_cpld_prepare(struct fw_upload *fwl, const u8 *data, u32 size)
> +{
> +	static const u8 era_args[3] = { 0x04, 0x00, 0x00 }; /* cfg sector only */
> +	static const u8 en_args[2]  = { 0x08, 0x00 };
> +	static const u8 dis_args[2] = { 0x00, 0x00 };

here dis_args are copying another static const buffer from
adva_cpld_cleanup()

> +	static const u8 zero3[3]    = { 0 };

this one is redundant, because heap-allocated buffer is zero'ed on alloc

this code needs a bit more thinking.

> +	enum fw_upload_err ret = FW_UPLOAD_ERR_NONE;
> +	struct ptp_ocp *bp = fwl->dd_handle;
> +
> +	/* Do not clear cpld_cancel here: fw_upload_start() queues the work
> +	 * before this runs, so a cancel may already have arrived.  It is
> +	 * cleared once the upload is over, on every exit below and in
> +	 * cleanup().
> +	 */
> +	if (!size || size % CPLD_PAGE_SIZE) {
> +		WRITE_ONCE(bp->cpld_cancel, false);
> +		return FW_UPLOAD_ERR_INVALID_SIZE;
> +	}
> +
> +	bp->cpld_in_config_mode = false;
> +
> +	mutex_lock(&bp->cpld_lock);
> +
> +	if (adva_x1_bus_claim(bp)) {
> +		ret = FW_UPLOAD_ERR_TIMEOUT;
> +		goto err_unlock;
> +	}
> +
> +	if (adva_x1_mux_select(bp, ADVA_MUX_CHANNEL)) {
> +		ret = FW_UPLOAD_ERR_HW_ERROR;
> +		goto err_release;
> +	}
> +
> +	/* Set before issuing EN_CFG_TP, not after it completes: the CPLD may
> +	 * have entered configuration mode even if the write reports an error
> +	 * or the wait below times out, and err_deselect only sends DIS_CFG
> +	 * when this is set.  A DIS_CFG to a device that never entered the
> +	 * mode is harmless; leaving it enabled is not.
> +	 */
> +	bp->cpld_in_config_mode = true;
> +
> +	if (adva_x1_cpld_write(bp, CPLD_CMD_EN_CFG_TP, en_args, 2) ||
> +	    adva_x1_cpld_wait_ready(bp, 5000)) {
> +		ret = adva_cpld_err(bp);
> +		goto err_deselect;
> +	}
> +
> +	if (READ_ONCE(bp->cpld_cancel)) {
> +		ret = FW_UPLOAD_ERR_CANCELED;
> +		goto err_deselect;
> +	}
> +
> +	if (adva_x1_cpld_write(bp, CPLD_CMD_ERASE, era_args, 3) ||
> +	    adva_x1_cpld_wait_ready(bp, 15000)) {
> +		ret = adva_cpld_err(bp);
> +		goto err_deselect;
> +	}
> +
> +	if (READ_ONCE(bp->cpld_cancel)) {
> +		ret = FW_UPLOAD_ERR_CANCELED;
> +		goto err_deselect;
> +	}
> +
> +	if (adva_x1_cpld_write(bp, CPLD_CMD_RESET_ADDR, zero3, 3)) {
> +		ret = FW_UPLOAD_ERR_HW_ERROR;
> +		goto err_deselect;
> +	}
> +
> +	/* cleanup() unlocks everything.  fw_upload_main() only pairs it with
> +	 * a prepare() that succeeded, so the error paths below unlock here
> +	 * instead; hand the context to cleanup() for sparse's benefit.
> +	 */
> +	__release(&bp->cpld_lock);
> +	return FW_UPLOAD_ERR_NONE;
> +
> +err_deselect:
> +	if (bp->cpld_in_config_mode) {
> +		adva_x1_cpld_write(bp, CPLD_CMD_DIS_CFG, dis_args, 2);
> +		bp->cpld_in_config_mode = false;
> +	}
> +	adva_x1_mux_select(bp, -1);
> +err_release:
> +	adva_x1_bus_release(bp);
> +err_unlock:
> +	WRITE_ONCE(bp->cpld_cancel, false);
> +	mutex_unlock(&bp->cpld_lock);
> +	return ret;
> +}
> +
> +static enum fw_upload_err
> +adva_cpld_write(struct fw_upload *fwl, const u8 *data,
> +		u32 offset, u32 size, u32 *written)
> +{
> +	struct ptp_ocp *bp = fwl->dd_handle;
> +	u8 page_args[3 + CPLD_PAGE_SIZE];
> +
> +	lockdep_assert_held(&bp->cpld_lock);
> +
> +	if (READ_ONCE(bp->cpld_cancel))
> +		return FW_UPLOAD_ERR_CANCELED;
> +
> +	if (size < CPLD_PAGE_SIZE)
> +		return FW_UPLOAD_ERR_INVALID_SIZE;
> +
> +	page_args[0] = 0x00;
> +	page_args[1] = 0x00;
> +	page_args[2] = 0x01;
> +	memcpy(&page_args[3], data + offset, CPLD_PAGE_SIZE);

here again, stack allocated -> stack allocated -> heap allocated.
quite a lot of allocations and copying for 16 bytes of actual data
transfer.

> +
> +	if (adva_x1_cpld_write(bp, CPLD_CMD_WRITE_PAGE,
> +			       page_args, 3 + CPLD_PAGE_SIZE) ||
> +	    adva_x1_cpld_wait_ready(bp, 100))
> +		return adva_cpld_err(bp);
> +
> +	*written = CPLD_PAGE_SIZE;
> +	return FW_UPLOAD_ERR_NONE;
> +}
