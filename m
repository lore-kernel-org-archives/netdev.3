Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F743914F5;
	Tue,  6 Oct 2026 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791315370; cv=none; b=Q9PSx0fik1RzDPAHrwDDSOFElitGnV6FXzB7sdy3IvoZg2HRdNfZ+XqE+IDKqALL0CJ2u15gl53ALEBYehzT6zj8jnXW8bA+i6KTKf1fo7Pjjf8vBX0EQF8ChnjOWDZcoxjzHAUjFr/J8wMMF44EoomZFzCzPzUZvyNR8eJEA78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791315370; c=relaxed/simple;
	bh=wj/sWfdoddtzMIGh1H3vjjBs66rG02RDwUhV9GRgmWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqEE+LXwRZeSUInF7suoYAUtDRremclJbYUAGwBIe5/aj1rypMxanpcx6QrRHDLAUJvdcI7+Fc/9VlCkxgnwlBgdsMYtXm0rE9r3+tX5s+R3DWGp5aeOJlA1p1kcW5imjYaiWbjyLwJuAP/cpehQp5nayyO+rre48TgXzc5E3MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JIXVxyYP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JIXVxyYP"
Received: by linux.microsoft.com (Postfix, from userid 1223)
	id B1A5820B7175; Tue,  6 Oct 2026 12:35:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B1A5820B7175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791315312;
	bh=ZHFeuUEcgA/zJNYAb+gVRneYC++YNlFUgfUofhTwpC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JIXVxyYPVGUahVQSbBeR6lhtqlo+464NbJKVnsn6MnEHpuAojkME6r5sK/6Vg4jbk
	 TE1b2xfxdU9SmWh0bU8XY9UYwUFrXHCszXWEv7hY8gF7i+TF0HC3F7IICTGKZoti5g
	 8wdiOittX0hXTsSe1NqVwmj/ySYwpMcP8fcsBKbQ=
Date: Tue, 6 Oct 2026 12:35:12 -0700
From: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
To: "Patil, Shubham Sanjay" <shubpati@amd.com>
Cc: Frank Li <Frank.li@oss.nxp.com>,
	Shubham Patil <shubhamsanjay.patil@amd.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	meaganlloyd@linux.microsoft.com, git@amd.com,
	jk@codeconstruct.com.au, matt@codeconstruct.com.au,
	netdev@vger.kernel.org
Subject: Re: [PATCH] i3c: master: dw: Clamp GETMRL/GETMWL to controller FIFO
 limits
Message-ID: <20261006-fc1d7a5f0e4e3b1b453450f9@linux.microsoft.com>
References: <20260908102724.3232660-1-shubhamsanjay.patil@amd.com>
 <aqL4HaQ1gjeaJYUQ@lizhi-Precision-Tower-5810>
 <eff031f6-e212-43a8-98c0-5f52a4b9317b@amd.com>
 <arVBZ0j2noe0g0Wi@lizhi-Precision-Tower-5810>
 <44e2c06b-7742-47a7-b2fa-2284867d4f32@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44e2c06b-7742-47a7-b2fa-2284867d4f32@amd.com>

On Tue, Oct 06, 2026 at 06:05:16PM +0530, Patil, Shubham Sanjay wrote:
> On 9/24/2026 8:57 PM, Frank Li wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > On Thu, Sep 24, 2026 at 10:25:44AM +0530, Patil, Shubham Sanjay wrote:
> > > 
> > > 
> > > On 9/11/2026 12:04 AM, Frank Li wrote:
> > > > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > > > 
> > > > 
> > > > On Tue, Sep 08, 2026 at 03:57:24PM +0530, Shubham Patil wrote:
> > > > > The DW master rejects private SDR transfers larger than
> > > > > caps.datafifodepth with -EOPNOTSUPP. Targets often report MRL/MWL
> > > > > values larger than that FIFO, so the core stores limits the controller
> > > > > cannot meet.
> > > > > 
> > > > > After a successful GETMRL/GETMWL, issue Direct SETMRL/SETMWL to the
> > > > > same target with lengths capped to the data FIFO (in bytes), then
> > > > > rewrite the GET payload so the core keeps the same values. Only update
> > > > > the GET buffer once SET is acked, so a failed SET does not leave the
> > > > > core and the target disagreeing.
> > > > 
> > > > I think i3c device driver should know these information choose
> > > > min value dring each xfer. even though you set devcie's MRL/MXL, device
> > > > driver still issue a longer transfer.
> > > > 
> > > > Frank
> > > 
> > > Understood - I will drop the SETMRL/SETMWL and stop rewriting the GET
> > > payload, and instead expose the controller limit so the min is taken
> > > per transfer. Two questions on how you want that done:
> > > 1) Where should the min be taken?
> > >     a) In the core: the controller driver sets max_read_len /
> > >        max_write_len / max_ibi_len in struct i3c_master_controller, and
> > >        the core caps i3c_device_info to min(target, controller) after
> > >        GETMRL/GETMWL. Device drivers then use i3c_device_get_info()
> > >        as-is and cannot forget.
> > >     b) In each device driver: the core keeps reporting the raw target
> > >        values, and drivers do the min themselves.
> > 
> > We can provide APIs for device driver to get whole data path required
> > max_read/write_len.
> 
> Thanks. Next v2 will be:
> 
> Patch 1 - core: add max_read_len/max_write_len to struct
> i3c_master_controller, set by the controller driver before
> i3c_master_register(), plus two helpers for client drivers:
> 	u16 i3c_device_get_max_read_len(const struct i3c_device *dev);
> 	u16 i3c_device_get_max_write_len(const struct i3c_device *dev);
> 
> Each returns the smallest limit along the whole data path, i.e.
> min_not_zero() of the target's GETMRL/GETMWL value and the controller
> limit, and U16_MAX when nothing limits it. i3c_device_info keeps the raw
> target values untouched.
> 
> Patch 2 - dw: advertise the data FIFO depth to the core, by setting
> base.max_read_len/base.max_write_len in dw_i3c_common_probe() before
> i3c_master_register().
> 
> Thanks,
> Shubham

I'd vote to avoid overloading the terms 'max_read_len' and
'max_write_len' as it currently refers to the device's MRL and MWL
values retrieved through the GETMRL, GETMWL CCCs.

So, maybe something like:

struct i3c_master_controller fields rx_fifo_bytes, tx_fifo_bytes

i3c_device_get_max_read_xfer_bytes() - min(rx_fifo_bytes, device mrl)
i3c_device_get_max_write_xfer_bytes() - min(tx_fifo_bytes, device mwl)

-

The first meaningful user of this patch would be mctp-i3c driver. Where
the i3c_xfer.len would need to be updated from using the device's mrl/mwl
to whatever these new API functions return.

I think that the mctp-i3c driver update should be part of this series since
it'll be the first user. Unless, Alexandre and the MCTP maintainers disagree.

Thanks,
Meagan

> 
> > 
> > > 2) Either way, a driver that ignores these limits still gets
> > >     -EOPNOTSUPP from dw_i3c_master_i3c_xfers() when the transfer does
> > >     not fit the data FIFO. Should the driver keep returning that, or
> > >     would you consider splitting an oversized private SDR transfer into
> > >     FIFO-sized chunks in the controller driver? My understanding is
> > >     no - splitting changes what the target sees on the bus - but I
> > >     want to be sure before v2.
> > 
> > the decision about split transfer should be decided by device drivers.
> > Not all device treat two continue repeat START as continue write/read.
> > 
> > Frank
> > > 
> > > Thanks,
> > > Shubham>
> > > > > 
> > > > > GETMRL is variable length: the optional third byte is max IBI payload
> > > > > and is only present if the target returned it. Clamp that IBI byte to
> > > > > the IBI queue depth from QUEUE_SIZE_CAPABILITY.IBI_BUF_SIZE (bits 19:16
> > > > > at 0xe8, encoded as 2^(n+1) dwords).
> > > > > 
> > > > > Rename the unused EXTENDED_CAPABILITY macro at 0xe8 to the databook
> > > > > name QUEUE_SIZE_CAPABILITY.
> > > > > 
> > > > > Signed-off-by: Shubham Patil <shubhamsanjay.patil@amd.com>
> > > > > ---
> > > > >    drivers/i3c/master/dw-i3c-master.c | 149 ++++++++++++++++++++++++++++-
> > > > >    drivers/i3c/master/dw-i3c-master.h |   1 +
> > > > >    2 files changed, 149 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> > > > > index 4563d8761ba0..51defcb57761 100644
> > > > > --- a/drivers/i3c/master/dw-i3c-master.c
> > > > > +++ b/drivers/i3c/master/dw-i3c-master.c
> > > > > @@ -203,7 +203,13 @@
> > > > >    #define BUS_IDLE_TIMING                      0xd8
> > > > >    #define I3C_VER_ID                   0xe0
> > > > >    #define I3C_VER_TYPE                 0xe4
> > > > > -#define EXTENDED_CAPABILITY          0xe8
> > > > > +#define QUEUE_SIZE_CAPABILITY                0xe8
> > > > > +#define QUEUE_SIZE_CAPABILITY_IBI_BUF(x)     (((x) & GENMASK(19, 16)) >> 16)
> > > > > +/*
> > > > > + * IBI_BUF_SIZE is encoded as 2^(field + 1) dwords: the smallest buffer is
> > > > > + * 2 dwords and each increment of the field doubles the depth.
> > > > > + */
> > > > > +#define QUEUE_SIZE_IBI_BUF_MIN_DWORDS        2
> > > > >    #define SLAVE_CONFIG                 0xec
> > > > > 
> > > > >    #define DYN_ADDR_LO_MASK GENMASK(4, 0)
> > > > > @@ -844,6 +850,130 @@ static int dw_i3c_ccc_get(struct dw_i3c_master *master, struct i3c_ccc_cmd *ccc)
> > > > >         return ret;
> > > > >    }
> > > > > 
> > > > > +/*
> > > > > + * Cap the limits a target reported through GETMRL to what this controller can
> > > > > + * actually transfer, so the core never asks for a private read the data FIFO
> > > > > + * cannot hold. The optional IBI payload byte is capped to the IBI queue depth
> > > > > + * instead; since that byte is a u8, the IBI cap only ever applies to
> > > > > + * controllers whose IBI queue is smaller than 255 bytes.
> > > > > + *
> > > > > + * Direct SETMRL is optional, so a target may implement GETMRL and NACK the SET.
> > > > > + * Clamp the values handed back to the core either way: a failed SET only means
> > > > > + * the target keeps its own larger limit, which is harmless as long as the core
> > > > > + * stays within ours.
> > > > > + */
> > > > > +static int dw_i3c_master_clamp_mrl(struct dw_i3c_master *master,
> > > > > +                                struct i3c_ccc_cmd *ccc)
> > > > > +{
> > > > > +     u16 max_fifo_bytes = master->caps.datafifodepth * sizeof(u32);
> > > > > +     u32 max_ibi_bytes = master->caps.ibififodepth * sizeof(u32);
> > > > > +     u16 actual_len = ccc->dests[0].payload.actual_len;
> > > > > +     struct i3c_ccc_cmd_dest set_dest = { };
> > > > > +     struct i3c_ccc_cmd set_cmd = { };
> > > > > +     struct i3c_ccc_mrl set_mrl;
> > > > > +     struct i3c_ccc_mrl *mrl;
> > > > > +     bool clamp_ibi = false;
> > > > > +     bool clamp_read;
> > > > > +     u8 ibi_len = 0;
> > > > > +     u16 read_len;
> > > > > +     int ret;
> > > > > +
> > > > > +     /* Need at least the 2-byte max read length field to act on. */
> > > > > +     if (actual_len < 2)
> > > > > +             return 0;
> > > > > +
> > > > > +     mrl = ccc->dests[0].payload.data;
> > > > > +     read_len = be16_to_cpu(mrl->read_len);
> > > > > +     clamp_read = read_len > max_fifo_bytes;
> > > > > +
> > > > > +     /* Optional third byte is valid only if the target returned it. */
> > > > > +     if (actual_len > 2) {
> > > > > +             ibi_len = mrl->ibi_len;
> > > > > +             clamp_ibi = max_ibi_bytes && ibi_len > max_ibi_bytes;
> > > > > +     }
> > > > > +
> > > > > +     if (!clamp_read && !clamp_ibi)
> > > > > +             return 0;
> > > > > +
> > > > > +     set_mrl.read_len = cpu_to_be16(clamp_read ? max_fifo_bytes : read_len);
> > > > > +     if (actual_len > 2)
> > > > > +             set_mrl.ibi_len = clamp_ibi ? max_ibi_bytes : ibi_len;
> > > > > +
> > > > > +     set_dest.addr = ccc->dests[0].addr;
> > > > > +     set_dest.payload.data = &set_mrl;
> > > > > +     set_dest.payload.len = actual_len;
> > > > > +
> > > > > +     set_cmd.rnw = 0;
> > > > > +     set_cmd.id = I3C_CCC_SETMRL(false);
> > > > > +     set_cmd.ndests = 1;
> > > > > +     set_cmd.dests = &set_dest;
> > > > > +
> > > > > +     ret = dw_i3c_ccc_set(master, &set_cmd);
> > > > > +     if (ret)
> > > > > +             dev_dbg(&master->base.dev,
> > > > > +                     "SETMRL not accepted by target: %d\n", ret);
> > > > > +
> > > > > +     if (clamp_read) {
> > > > > +             mrl->read_len = cpu_to_be16(max_fifo_bytes);
> > > > > +             dev_dbg(&master->base.dev,
> > > > > +                     "clamped target MRL from %u to %u bytes (FIFO depth limit)\n",
> > > > > +                     read_len, max_fifo_bytes);
> > > > > +     }
> > > > > +     if (clamp_ibi) {
> > > > > +             mrl->ibi_len = max_ibi_bytes;
> > > > > +             dev_dbg(&master->base.dev,
> > > > > +                     "clamped target IBI len from %u to %u bytes (IBI buffer limit)\n",
> > > > > +                     ibi_len, max_ibi_bytes);
> > > > > +     }
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +/* Same contract as dw_i3c_master_clamp_mrl(), for the write direction. */
> > > > > +static int dw_i3c_master_clamp_mwl(struct dw_i3c_master *master,
> > > > > +                                struct i3c_ccc_cmd *ccc)
> > > > > +{
> > > > > +     u16 max_fifo_bytes = master->caps.datafifodepth * sizeof(u32);
> > > > > +     struct i3c_ccc_cmd_dest set_dest = { };
> > > > > +     struct i3c_ccc_cmd set_cmd = { };
> > > > > +     struct i3c_ccc_mwl set_mwl;
> > > > > +     struct i3c_ccc_mwl *mwl;
> > > > > +     u16 write_len;
> > > > > +     int ret;
> > > > > +
> > > > > +     if (ccc->dests[0].payload.actual_len < 2)
> > > > > +             return 0;
> > > > > +
> > > > > +     mwl = ccc->dests[0].payload.data;
> > > > > +     write_len = be16_to_cpu(mwl->len);
> > > > > +
> > > > > +     if (write_len <= max_fifo_bytes)
> > > > > +             return 0;
> > > > > +
> > > > > +     set_mwl.len = cpu_to_be16(max_fifo_bytes);
> > > > > +
> > > > > +     set_dest.addr = ccc->dests[0].addr;
> > > > > +     set_dest.payload.data = &set_mwl;
> > > > > +     set_dest.payload.len = sizeof(set_mwl);
> > > > > +
> > > > > +     set_cmd.rnw = 0;
> > > > > +     set_cmd.id = I3C_CCC_SETMWL(false);
> > > > > +     set_cmd.ndests = 1;
> > > > > +     set_cmd.dests = &set_dest;
> > > > > +
> > > > > +     ret = dw_i3c_ccc_set(master, &set_cmd);
> > > > > +     if (ret)
> > > > > +             dev_dbg(&master->base.dev,
> > > > > +                     "SETMWL not accepted by target: %d\n", ret);
> > > > > +
> > > > > +     mwl->len = cpu_to_be16(max_fifo_bytes);
> > > > > +     dev_dbg(&master->base.dev,
> > > > > +             "clamped target MWL from %u to %u bytes (FIFO depth limit)\n",
> > > > > +             write_len, max_fifo_bytes);
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > >    static int dw_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
> > > > >                                       struct i3c_ccc_cmd *ccc)
> > > > >    {
> > > > > @@ -866,6 +996,18 @@ static int dw_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
> > > > >         else
> > > > >                 ret = dw_i3c_ccc_set(master, ccc);
> > > > > 
> > > > > +     /*
> > > > > +      * Clamp GETMRL/GETMWL responses to the data FIFO depth, and the
> > > > > +      * optional GETMRL IBI byte to the IBI queue depth. The GET itself has
> > > > > +      * already succeeded, so its result is never overridden here.
> > > > > +      */
> > > > > +     if (!ret && ccc->rnw) {
> > > > > +             if (ccc->id == I3C_CCC_GETMRL)
> > > > > +                     dw_i3c_master_clamp_mrl(master, ccc);
> > > > > +             else if (ccc->id == I3C_CCC_GETMWL)
> > > > > +                     dw_i3c_master_clamp_mwl(master, ccc);
> > > > > +     }
> > > > > +
> > > > >         pm_runtime_put_autosuspend(master->dev);
> > > > >         return ret;
> > > > >    }
> > > > > @@ -1728,6 +1870,11 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
> > > > >         ret = readl(master->regs + DATA_BUFFER_STATUS_LEVEL);
> > > > >         master->caps.datafifodepth = DATA_BUFFER_STATUS_LEVEL_TX(ret);
> > > > > 
> > > > > +     /* Read the IBI data buffer size advertised by the controller. */
> > > > > +     ret = readl(master->regs + QUEUE_SIZE_CAPABILITY);
> > > > > +     master->caps.ibififodepth = QUEUE_SIZE_IBI_BUF_MIN_DWORDS <<
> > > > > +                                 QUEUE_SIZE_CAPABILITY_IBI_BUF(ret);
> > > > > +
> > > > >         ret = readl(master->regs + DEVICE_ADDR_TABLE_POINTER);
> > > > >         master->datstartaddr = ret;
> > > > >         master->maxdevs = ret >> 16;
> > > > > diff --git a/drivers/i3c/master/dw-i3c-master.h b/drivers/i3c/master/dw-i3c-master.h
> > > > > index 17ad817d1f8e..54c3912374c8 100644
> > > > > --- a/drivers/i3c/master/dw-i3c-master.h
> > > > > +++ b/drivers/i3c/master/dw-i3c-master.h
> > > > > @@ -15,6 +15,7 @@
> > > > >    struct dw_i3c_master_caps {
> > > > >         u8 cmdfifodepth;
> > > > >         u8 datafifodepth;
> > > > > +     u32 ibififodepth;
> > > > >    };
> > > > > 
> > > > >    struct dw_i3c_dat_entry {
> > > > > --
> > > > > 2.34.1
> > > > > 
> > > 
> 
> 
> -- 
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c
