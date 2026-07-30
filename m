Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D63B530F
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 21:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447710; cv=none; b=cbDLe9a2dBoGrP1lManWqzHCg05NwL02Z3crUXPwxIMurvvXanLXhuJKOoteFb8+5oVS8ztpbOBw0zBsyNOX1E4VxebADaH2mRjFLSXS5rn2ptTass6GP2gKtuyccYxUv+ciEuK3eKYPQSfiKNXUZxaa6RmjZpjgvOH82JLr6uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447710; c=relaxed/simple;
	bh=sMZwigJUFr1o3Uemq4VvvaBZsTWnKSkIajK9j3hxV28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFZURzv52BKGfNKVP9hlFH048ZChOGkRSW9vhE4WY8HGm0bKZSFHQQbSVXR3jTjIih62CwcU/67elutiRSO28z+eNTprcq65L7HERe9BKG4zz3iWqImNFvJNwWF6C2PbnYV8TBL0mPGsDE+clS1wt0KDPqDH3me4Vg8YqdEIE/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QswSYqsQ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QswSYqsQ"
Message-ID: <7075bcdb-da4d-4d2c-bd09-516d9f244277@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785447695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPBYeS5eM8QfNUI0c8pm5k4frcClcEoZo0/PO79jetg=;
	b=QswSYqsQkgJkubMyqnoGdkwylK36hsymfJ61Pp+wXw/LV407fb05w6FaYy9W6Z/Z4/K3vo
	nOT1vjRuXV9o6xaLUozGFZayMt41FCYqXC+hU9EnMa8Q4mrGXo1DWgRBAfNwk4ejTu89+g
	f1yU+FQioAfKQV+u79f6C6b/M5JryYs=
Date: Thu, 30 Jul 2026 22:41:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260730134401.20241-1-maimon.sagi@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260730134401.20241-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 30.07.2026 14:43, Sagi Maimon wrote:
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

[...]

> + * Send a 4-byte command then read data back without an intermediate STOP
> + * (Lattice combined write→repeated-START→read).
> + */
> +static int adva_x1_cpld_cmd_read(struct ptp_ocp *bp,
> +				 u32 cmd_be, u8 *out, u8 out_len)
> +{
> +	u8 cmd[4] = {
> +		(cmd_be >> 24) & 0xFF,
> +		(cmd_be >> 16) & 0xFF,
> +		(cmd_be >>  8) & 0xFF,
> +		cmd_be & 0xFF,
> +	};

this is open-coded be32_to_cpu(), please, convert the code to use it.
maybe make adva_x1_i2c_xfer() buffer pointers as void* to avoid extra cast.

> +	return adva_x1_i2c_xfer(bp, ADVA_CPLD_ADDR, cmd, 4, out, out_len, true);
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
> +	*status = ((u32)buf[0] << 24) | ((u32)buf[1] << 16) |
> +		  ((u32)buf[2] <<  8) |  (u32)buf[3];

here we have cpu_to_be32() I believe - please use lib functions.

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

ditto

> +	adva_x1_mux_select(bp, -1);
> +release:
> +	adva_x1_mblaze_release(bp);
> +out:
> +	mutex_unlock(&bp->cpld_lock);
> +	return ret ? ret : sysfs_emit(buf, "0x%08x\n", id);
> +}
> +static DEVICE_ATTR_RO(cpld_device_id);
> +
