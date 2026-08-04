Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333A35F161
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843314; cv=none; b=K2/k4MvTZp/oHVWedmMBgyKz8TlueFHSRXP/7cDBHwICQxFFvZMvv1QraC9/Jnn17Jmqk+vyl2Gq7dOSJte/KK9wnqsNYy0IJVw8eT0PcG0AyI1fLlTGoZgC3NZDwSO4DnMILeAA46NTv8WNiH1yF8wK6vL5QBGMBU9uQjBhdIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843314; c=relaxed/simple;
	bh=wwe0tJgFgj6xGZ69YmaW0MWUyxWVhECQ5L+QflGzvPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxhzJoqAARxE+Lq8iw37rlXdzJm0NrN+O/FSgtc+EWQ4sh0jpyAVSv98o26gLrgFixA31oNB7CBZY5jH4epC/3WRArHFDwg54yBv05IbbNTuSRJB8qKCFjm5ZRuU2oid1NbUDGgJm5+fDfTYhHlZvs5dYSiBB8VdyYiGjaqu1Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QNEv53Jl; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QNEv53Jl"
Message-ID: <65c42538-9607-4dff-adbe-d9d5c9a338d0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785843308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tJBz0QPm/37VpuFBA1epM1ll5ftoL/nQgLvLHANImr4=;
	b=QNEv53Jlrwv511+t7srJdEpqiJhuVR66q29WQ5pG9cnRGDFGB74hGNbNJj+1Lh90pkPkwv
	bS2EcjlrUc0YH8T9RhLNQihaTARAC83qfLFeogL8gviXmQ7zwIhKp8qXVjUJsYYNWrhr+x
	tkTt/CpEEvSjojcbnSsWnIZn6TnQIZw=
Date: Tue, 4 Aug 2026 12:35:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260802071132.5078-1-maimon.sagi@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260802071132.5078-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 02/08/2026 08:11, Sagi Maimon wrote:
> The ADVA TimeCard X1 (PCI device 0x0410) uses a Lattice MachXO3 CPLD
> that is programmed over I2C using in-system programming (ISP).
> 
> The CPLD is connected to a secondary I2C bus shared with the onboard
> MicroBlaze soft CPU.
> 
> Add support for CPLD access and firmware updates on the ADVA TimeCard X1
> board by arbitration of the shared I2C bus, CPLD ISP command handling,
> status polling, and firmware upload operations using the firmware-upload
> subsystem.
> 
> Add the following X1-only user-visible interfaces:
> 
>    /sys/class/timecard/ocpN/cpld_device_id
>          report the 32-bit Lattice MachXO3 CPLD device ID
> 
>    /sys/class/timecard/ocpN/cpld_status
>          report the CPLD status register, including the DONE,
>          BUSY, and FAILED indicators
> 
> Firmware updates are performed through the firmware-upload framework,
> which acquires ownership of the shared I2C bus, erases the CPLD
> configuration flash, programs the image page-by-page, and activates
> the new image using the MachXO3 REFRESH command.
> 
> All CPLD operations are serialized and coordinated with the MicroBlaze
> firmware to ensure exclusive access to the shared I2C bus. The added
> interfaces are available only on ADVA TimeCard X1 boards.
> 
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
> 
>   Addressed comments from:
>    - Jakub Kicinski :https://lore.kernel.org/all/20260730130424.77a90fa3@kernel.org/
>    - Vadim Fedorenko :https://lore.kernel.org/all/7075bcdb-da4d-4d2c-bd09-516d9f244277@linux.dev/
>   
>   Changes since v7:
>   - Use %pe instead of %ld + PTR_ERR() (coccicheck)
>   - Add #include <linux/unaligned.h>
>   - Widen adva_x1_i2c_xfer() buffer pointers to void *
>   - Use cpu_to_be32() in adva_x1_cpld_cmd_read()
>   - Use get_unaligned_be32() in adva_x1_cpld_read_status()
>   
>   Documentation/ABI/testing/sysfs-timecard |  34 ++
>   drivers/ptp/ptp_ocp.c                    | 497 ++++++++++++++++++++++-
>   2 files changed, 527 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
> index 3ae41b7634ac..f7c9955acb0a 100644
> --- a/Documentation/ABI/testing/sysfs-timecard
> +++ b/Documentation/ABI/testing/sysfs-timecard
> @@ -11,6 +11,40 @@ Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
>   Description:	This directory contains the attributes of the Nth timecard
>   		registered.
>   
> +What:		/sys/class/timecard/ocpN/cpld_device_id
> +Date:		July 2026
> +Contact:	Sagi Maimon <maimon.sagi@gmail.com>
> +Description:	(RO) The 32-bit Lattice device ID of the TAP CPLD, reported as
> +		a hex string, e.g. "0xe12bc043".
> +
> +		Only present on ADVA x1 TAP boards (PCI ID 0xad5a:0x0410).
> +		The Lattice LCMXO3LF-210 reports 0xe12bc043.
> +
> +		The driver acquires the MicroBlaze I2C bus internally before
> +		issuing the READ_IDCODE command; no bus arbitration is required
> +		from userspace.
> +
> +What:		/sys/class/timecard/ocpN/cpld_status
> +Date:		July 2026
> +Contact:	Sagi Maimon <maimon.sagi@gmail.com>
> +Description:	(RO) The status register of the TAP CPLD, in human-readable
> +		form:
> +
> +		  done=<0|1> busy=<0|1> failed=<0|1>
> +
> +		Only present on ADVA x1 TAP boards (PCI ID 0xad5a:0x0410).
> +
> +		done=1 indicates the configuration flash was successfully
> +		programmed and is active.  busy=1 means an internal operation
> +		is in progress.  failed=1 means the last ISC operation failed.
> +
> +		The driver acquires the MicroBlaze I2C bus internally; no bus
> +		arbitration is required from userspace.
> +
> +		To program new CPLD firmware use the standard kernel
> +		firmware-upload interface registered at:
> +		/sys/class/firmware/adva-cpld/
> +
>   What:		/sys/class/timecard/ocpN/available_clock_sources
>   Date:		September 2021
>   Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 35e911f1ad78..a4a8cab5ed7d 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -24,6 +24,11 @@
>   #include <linux/nvmem-consumer.h>
>   #include <linux/crc16.h>
>   #include <linux/dpll.h>
> +#include <linux/unaligned.h>
> +#include <linux/delay.h>
> +#include <linux/firmware.h>
> +#include <linux/delay.h>
> +#include <linux/firmware.h>

why do you double include headers?

>   
>   #define PCI_DEVICE_ID_META_TIMECARD		0x0400
>   
> @@ -85,6 +90,7 @@ struct ptp_ocp_adva_info {
>   	u8				signals_nr;
>   	u8				freq_in_nr;
>   	const struct ocp_attr_group	*attr_groups;
> +	bool				has_cpld; /* x1: supports CPLD firmware upload */
>   };
>   
>   #define OCP_CTRL_ENABLE		BIT(0)
> @@ -163,7 +169,8 @@ struct gpio_reg {
>   	u32	gpio1;
>   	u32	__pad0;
>   	u32	gpio2;
> -	u32	__pad1;
> +	/* adva_x1: I2C bus ownership register; reserved on other variants */
> +	u32	i2c_bus_ctrl;
>   };
>   
>   struct irig_master_reg {
> @@ -416,6 +423,12 @@ struct ptp_ocp {
>   	dpll_tracker tracker;
>   	int signals_nr;
>   	int freq_in_nr;
> +	/* adva_x1 CPLD I2C (internal use only) */
> +	struct mutex		cpld_lock;            /* serialises CPLD operations */
> +	int			cpld_i2c_adap_nr;     /* I2C adapter nr; -1 if absent */
> +	struct fw_upload	*cpld_fw_upload;      /* firmware upload handle; NULL if absent */
> +	bool			cpld_cancel;          /* cancellation requested */
> +	bool			cpld_in_config_mode;  /* EN_CFG_TP issued but not yet REFRESH'd */
>   };
>   
>   #define OCP_REQ_TIMESTAMP	BIT(0)
> @@ -449,6 +462,8 @@ static int ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
>   
>   static int ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
>   
> +static const struct fw_upload_ops adva_cpld_upload_ops;
> +
>   static const struct ocp_sma_op ocp_adva_sma_op;
>   static const struct ocp_sma_op ocp_adva_x1_sma_op;
>   
> @@ -1273,6 +1288,7 @@ static struct ocp_resource ocp_adva_x1_resource[] = {
>   			.signals_nr   = 4,
>   			.freq_in_nr   = 4,
>   			.attr_groups  = adva_timecard_x1_groups,
> +			.has_cpld     = true,
>   		},
>   	},
>   	{ }
> @@ -3197,6 +3213,20 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
>   		return err;
>   	ptp_ocp_sma_init(bp);
>   
> +	if (info->has_cpld) {
> +		struct fw_upload *fwl;
> +
> +		fwl = firmware_upload_register(THIS_MODULE, &bp->pdev->dev,
> +					       "adva-cpld",
> +					       &adva_cpld_upload_ops, bp);
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
> @@ -4224,6 +4254,442 @@ static const struct ocp_attr_group art_timecard_groups[] = {
>   	{ },
>   };
>   
> +/*
> + * Internal helpers for the adva_x1 TAP CPLD (Lattice LCMXO3LF-210).
> + *
> + * The CPLD sits at I2C address 0x40 behind a PCA9548 mux (0x74) on
> + * channel 0.  The I2C bus is shared with the MicroBlaze firmware;
> + * cpld_lock + mblaze acquire/release provide mutual exclusion for the
> + * full duration of any CPLD operation.  No raw I2C access is exposed
> + * to userspace; only the high-level attributes below are.
> + */
> +
> +#define ADVA_MUX_ADDR     0x74
> +#define ADVA_CPLD_ADDR    0x40
> +#define ADVA_MUX_CHANNEL  0
> +
> +#define MBLAZE_REQUEST    0x0000ffffU
> +#define MBLAZE_GRANTED    0xffffffffU
> +#define MBLAZE_RETRIES    200
> +#define MBLAZE_RETRY_US   10000
> +
> +/* Lattice LCMXO3LF ISC command codes */
> +#define CPLD_CMD_READ_ID      0xE0000000UL
> +#define CPLD_CMD_READ_STATUS  0x3C000000UL
> +#define CPLD_CMD_EN_CFG_TP    0x74   /* enable config, transparent mode */
> +#define CPLD_CMD_DIS_CFG      0x26
> +#define CPLD_CMD_ERASE        0x0E
> +#define CPLD_CMD_RESET_ADDR   0x46
> +#define CPLD_CMD_WRITE_PAGE   0x70
> +#define CPLD_CMD_SET_DONE     0x5E
> +#define CPLD_CMD_REFRESH      0x79
> +#define CPLD_PAGE_SIZE        16
> +
> +/* Status register bit positions (Lattice LCMXO3LF datasheet) */
> +#define CPLD_STATUS_DONE   BIT(8)
> +#define CPLD_STATUS_BUSY   BIT(12)
> +#define CPLD_STATUS_FAILED BIT(13)
> +
> +/*
> + * adva_x1_i2c_xfer() - issue a single I2C transaction on the CPLD bus.
> + *
> + * All buffers are heap-allocated internally to guarantee DMA safety for
> + * the Xilinx I2C controller.  Caller must hold bp->cpld_lock.
> + */
> +static int adva_x1_i2c_xfer(struct ptp_ocp *bp,
> +			    u8 addr, const void *wdata, u8 wlen,
> +			    void *rdata, u8 rlen, bool nostart)
> +{
> +	struct i2c_adapter *adap;
> +	struct i2c_msg msgs[2];
> +	u8 *wbuf = NULL, *rbuf = NULL;
> +	int nmsgs = 0, ret;

as this patch goes through netdev, please respect reverse xmass tree
ordering of variables declaration here and futher in the patch

> +
> +	adap = i2c_get_adapter(READ_ONCE(bp->cpld_i2c_adap_nr));
> +	if (!adap)
> +		return -ENODEV;
> +
> +	if (wlen) {
> +		wbuf = kmemdup(wdata, wlen, GFP_KERNEL);
> +		if (!wbuf) {
> +			ret = -ENOMEM;
> +			goto put;
> +		}
> +		msgs[nmsgs++] = (struct i2c_msg){
> +			.addr  = addr,
> +			.flags = I2C_M_DMA_SAFE,
> +			.len   = wlen,
> +			.buf   = wbuf,
> +		};
> +	}
> +	if (rlen) {
> +		rbuf = kzalloc(rlen, GFP_KERNEL);
> +		if (!rbuf) {
> +			ret = -ENOMEM;
> +			goto put;
> +		}
> +		msgs[nmsgs++] = (struct i2c_msg){
> +			.addr  = addr,
> +			.flags = I2C_M_RD | I2C_M_DMA_SAFE |
> +				 (nostart ? I2C_M_NOSTART : 0),
> +			.len   = rlen,
> +			.buf   = rbuf,
> +		};
> +	}
> +
> +	ret = i2c_transfer(adap, msgs, nmsgs);
> +	if (ret == nmsgs) {
> +		if (rdata && rlen)
> +			memcpy(rdata, rbuf, rlen);
> +		ret = 0;
> +	} else {
> +		ret = (ret < 0) ? ret : -EIO;
> +	}
> +put:
> +	kfree(wbuf);
> +	kfree(rbuf);
> +	i2c_put_adapter(adap);
> +	return ret;
> +}
> +
> +/* Acquire the shared I2C bus from the MicroBlaze firmware. */
> +static int adva_x1_mblaze_acquire(struct ptp_ocp *bp)
> +{
> +	u32 val;
> +	int i;
> +
> +	if (!bp->pps_select)
> +		return -ENODEV;
> +
> +	/* Release any stale grant left by a previous crashed caller. */
> +	iowrite32(0, &bp->pps_select->i2c_bus_ctrl);
> +	val = ioread32(&bp->pps_select->i2c_bus_ctrl);
> +	if (val != 0)
> +		return -EBUSY;
> +
> +	iowrite32(MBLAZE_REQUEST, &bp->pps_select->i2c_bus_ctrl);
> +	for (i = 0; i < MBLAZE_RETRIES; i++) {
> +		usleep_range(MBLAZE_RETRY_US, MBLAZE_RETRY_US + 1000);
> +		val = ioread32(&bp->pps_select->i2c_bus_ctrl);
> +		if (val == MBLAZE_GRANTED)
> +			return 0;
> +	}
> +	return -ETIMEDOUT;
> +}
> +
> +static void adva_x1_mblaze_release(struct ptp_ocp *bp)
> +{
> +	if (bp->pps_select)
> +		iowrite32(0, &bp->pps_select->i2c_bus_ctrl);
> +}
> +
> +static int adva_x1_mux_select(struct ptp_ocp *bp, int ch)
> +{
> +	u8 val = (ch >= 0) ? BIT(ch) : 0;
> +
> +	return adva_x1_i2c_xfer(bp, ADVA_MUX_ADDR, &val, 1, NULL, 0, false);
> +}
> +
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
> +	return adva_x1_i2c_xfer(bp, ADVA_CPLD_ADDR, buf, 1 + nargs,
> +				 NULL, 0, false);
> +}
> +
> +/*
> + * Send a 4-byte command then read data back without an intermediate STOP
> + * (Lattice combined write→repeated-START→read).
> + */
> +static int adva_x1_cpld_cmd_read(struct ptp_ocp *bp,
> +				 u32 cmd_be, u8 *out, u8 out_len)
> +{
> +	__be32 cmd = cpu_to_be32(cmd_be);
> +
> +	return adva_x1_i2c_xfer(bp, ADVA_CPLD_ADDR, &cmd, 4, out, out_len, true);
> +}
> +
> +static int adva_x1_cpld_read_status(struct ptp_ocp *bp, u32 *status)
> +{
> +	u8 buf[4];
> +	int ret;
> +
> +	ret = adva_x1_cpld_cmd_read(bp, CPLD_CMD_READ_STATUS, buf, 4);
> +	if (ret)
> +		return ret;
> +	*status = get_unaligned_be32(buf);
> +	return 0;
> +}
> +
> +static int adva_x1_cpld_wait_ready(struct ptp_ocp *bp, unsigned int max_ms)
> +{
> +	u32 status;
> +	unsigned int elapsed = 0;
> +
> +	while (elapsed < max_ms) {
> +		if (adva_x1_cpld_read_status(bp, &status))
> +			return -EIO;
> +		if (status & CPLD_STATUS_FAILED)
> +			return -EIO;
> +		if (!(status & CPLD_STATUS_BUSY))
> +			return 0;
> +		usleep_range(100000, 101000);
> +		elapsed += 100;
> +	}
> +	return -ETIMEDOUT;
> +}
> +
> +/*
> + * cpld_device_id - show the Lattice device ID of the TAP CPLD.
> + *
> + * Returns the 32-bit ID as a hex string, e.g. "0x612bc043\n".
> + * Lattice LCMXO3LF-210 reports 0x612BC043.
> + */
> +static ssize_t
> +cpld_device_id_show(struct device *dev, struct device_attribute *attr,
> +		    char *buf)
> +{
> +	struct ptp_ocp *bp = dev_get_drvdata(dev);
> +	u8 data[4];
> +	u32 id = 0;
> +	int ret;
> +
> +	mutex_lock(&bp->cpld_lock);
> +	ret = adva_x1_mblaze_acquire(bp);
> +	if (ret)
> +		goto out;
> +	ret = adva_x1_mux_select(bp, ADVA_MUX_CHANNEL);
> +	if (ret)
> +		goto release;
> +	ret = adva_x1_cpld_cmd_read(bp, CPLD_CMD_READ_ID, data, 4);
> +	if (!ret)
> +		id = ((u32)data[0] << 24) | ((u32)data[1] << 16) |
> +		     ((u32)data[2] <<  8) |  (u32)data[3];

why is this code not changed to be32_to_cpu()?

> +	adva_x1_mux_select(bp, -1);
> +release:
> +	adva_x1_mblaze_release(bp);
> +out:
> +	mutex_unlock(&bp->cpld_lock);
> +	return ret ? ret : sysfs_emit(buf, "0x%08x\n", id);
> +}
> +static DEVICE_ATTR_RO(cpld_device_id);
> +
> +/*
> + * cpld_status - show the status register of the TAP CPLD.
> + *
> + * Returns a human-readable string: "done=<0|1> busy=<0|1> failed=<0|1>\n"
> + */
> +static ssize_t
> +cpld_status_show(struct device *dev, struct device_attribute *attr,
> +		 char *buf)
> +{
> +	struct ptp_ocp *bp = dev_get_drvdata(dev);
> +	u32 st = 0;
> +	int ret;
> +
> +	mutex_lock(&bp->cpld_lock);
> +	ret = adva_x1_mblaze_acquire(bp);
> +	if (ret)
> +		goto out;
> +	ret = adva_x1_mux_select(bp, ADVA_MUX_CHANNEL);
> +	if (ret)
> +		goto release;
> +	ret = adva_x1_cpld_read_status(bp, &st);
> +	adva_x1_mux_select(bp, -1);
> +release:
> +	adva_x1_mblaze_release(bp);
> +out:
> +	mutex_unlock(&bp->cpld_lock);
> +	return ret ? ret : sysfs_emit(buf, "done=%u busy=%u failed=%u\n",
> +				      !!(st & CPLD_STATUS_DONE),
> +				      !!(st & CPLD_STATUS_BUSY),
> +				      !!(st & CPLD_STATUS_FAILED));
> +}
> +static DEVICE_ATTR_RO(cpld_status);
> +
> +/*
> + * adva_x1 CPLD firmware-upload callbacks.
> + *
> + * The kernel firmware-upload subsystem (CONFIG_FW_UPLOAD) exposes:
> + *   /sys/class/firmware/adva-cpld/{data,loading,status,error,...}
> + * Userspace writes the raw binary page data directly — no /lib/firmware/
> + * staging file is needed.
> + *
> + * Callback sequence driven by the framework:
> + *   prepare()      - validate size, acquire bus, enable config, erase flash
> + *   write()        - program one 16-byte page per call
> + *   poll_complete()- set DONE, REFRESH, wait for CPLD to reboot
> + *   cancel()       - set flag; checked at the start of each callback
> + *   cleanup()      - release bus resources (called on success or failure)
> + */
> +static enum fw_upload_err
> +adva_cpld_prepare(struct fw_upload *fwl, const u8 *data, u32 size)
> +{
> +	struct ptp_ocp *bp = fwl->dd_handle;
> +	const u8 en_args[2]  = { 0x08, 0x00 };
> +	const u8 era_args[3] = { 0x04, 0x00, 0x00 }; /* cfg sector only */
> +	const u8 zero3[3]    = { 0 };
> +	const u8 dis_args[2] = { 0x00, 0x00 };

this constants can be made static, no need to re-init stack on every
call

> +	enum fw_upload_err ret = FW_UPLOAD_ERR_NONE;
> +
> +	if (!size || size % CPLD_PAGE_SIZE)
> +		return FW_UPLOAD_ERR_INVALID_SIZE;
> +
> +	bp->cpld_cancel		= false;
> +	bp->cpld_in_config_mode	= false;
> +
> +	mutex_lock(&bp->cpld_lock);
> +
> +	if (adva_x1_mblaze_acquire(bp)) {
> +		ret = FW_UPLOAD_ERR_TIMEOUT;
> +		goto err_unlock;
> +	}
> +
> +	if (adva_x1_mux_select(bp, ADVA_MUX_CHANNEL)) {
> +		ret = FW_UPLOAD_ERR_HW_ERROR;
> +		goto err_release;
> +	}
> +
> +	if (adva_x1_cpld_write(bp, CPLD_CMD_EN_CFG_TP, en_args, 2) ||
> +	    adva_x1_cpld_wait_ready(bp, 5000)) {
> +		ret = FW_UPLOAD_ERR_HW_ERROR;
> +		goto err_deselect;
> +	}
> +	bp->cpld_in_config_mode = true;
> +
> +	if (bp->cpld_cancel) {
> +		ret = FW_UPLOAD_ERR_CANCELED;
> +		goto err_deselect;
> +	}
> +
> +	if (adva_x1_cpld_write(bp, CPLD_CMD_ERASE, era_args, 3) ||
> +	    adva_x1_cpld_wait_ready(bp, 15000)) {
> +		ret = FW_UPLOAD_ERR_HW_ERROR;
> +		goto err_deselect;
> +	}
> +
> +	if (bp->cpld_cancel) {
> +		ret = FW_UPLOAD_ERR_CANCELED;
> +		goto err_deselect;

it looks like a duplicate of check, or do you expect something to change
cpld_cancel during writes?


