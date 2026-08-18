Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA5347BD4
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 04:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787028232; cv=pass; b=NWh7ize+uQVpd4MkGwS1YfRiZxbylqdnpvrBA8eytnVk6A7i4grV5bTBf8fEcR82TkCHM1iL3pL1ZjrDuPydOE7d1ttyrjVI9BuC2vSvGq4x3kXAYgZriUCYLFrd7dY+HOXcmH2AbCMaoiSeRr4Uq6XbwgGuNIMu+T1BCkMgT4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787028232; c=relaxed/simple;
	bh=n/7hD8Kmcx6LmalLIOmWoVcqEx6Ddv0HAHdXUHnCjHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDS6VjN5ul0VUcIkV3AWYL8xmqM0UKtudfN9EEBDjZr1xKzXCTaSOjeGdjjgr7rCDq9HWe8jZFraC1qMcYnFcZLNLkCGX54gmQ3iA0tSHlyn/6gpZOwGUWGn1P2MNbBNlx9y73hIYEn/6w5F14Pg1g/tP7AZD9N5z1MgPkBoOL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvnifsZ1; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvnifsZ1"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b01910b499so575127e87.0
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 21:43:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787028228; cv=none;
        d=google.com; s=arc-20260327;
        b=FhBe8o/K0hFi5ONFB9RvyJob/DcXgNC7Hh2wKtTJERZbrxvEX31bTEMw33K9t10wGw
         0bp70MYSur3bqzU0om0VsGUqqw6NXuhYmeN16pMJoUGHwGcQevHMA2pzHkRshkm9R0xu
         m6sJLsplEHKCSFWhRghqx4zX06b/rIYSCRhP9VNTKAnZ1Pckt3prnukPElR741NI6g+7
         YvFy61d6qoROoRKpUHs2TOKUtcSvWQQlLzFk63o9VatVqnvMLXp0ftFQacDAJzC1jQmk
         pzNKAs3eYWip2NEVNEu2C6L6QxM7Dko5LdXBT7X9CxzAMGUB5XFXF8ZCFpXX8QSkOc9F
         Dv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vs+0yoQ+2csalhbX8xRlSH2mZEgsNhiXsJ7Opsjy+3s=;
        fh=oOnqNsTILqMA2TMTByCMO4mB85AO9RTFppEbgM8912s=;
        b=YdN9JHoD4kMvtoPRP7OHUPsXe+XDvRqdW7kp7Xmf2m/9RcPP+kaUKtGKTuWLWEuo0m
         7W7cm12fVW8YhUsfxpP5m+wLgCSBGB73Xj+7Kzeb0N1eMr/xCk5IAz05+tI0CB+NkkfE
         g6kbkwP7b27SnGFkrj6l7AMGPVFXf9Etx/pBT3HiZVAA2ykoxd2lNwx3bfm1kcJ440hK
         Lbg7FkpDWqRrBs7O+KYVSUYDrLSEGqxm4ksn5rEG8Ssh8a7hITCye/W+6M7+dPCyXZ1k
         C3ZSIrCIMccn7oxzXeT145Wiij7zwXIYWi8jQdzX9hgPj8DQsOROIhLufXg7uTjn+5ze
         ffLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787028228; x=1787633028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vs+0yoQ+2csalhbX8xRlSH2mZEgsNhiXsJ7Opsjy+3s=;
        b=EvnifsZ1iD+lzCHamJ8z+I0fcrpsmTkQFAZxtxgNe+vkBH6mGvN8fiDsYrnXJ0rVbk
         HWqhTYjb652ohHupBBoylGGbDLc8or60+OgpXVgWfYQ4hhCdxpkJMMRfDKOAyai8pT0m
         CSN3liLQRaXE1UjR8LqCmtSLZ0Xu0+yzaPH/f7bgHjXHuZQ8GTBs/PitsGVkCSJcIfAK
         HZdUD7Z+1fmEkNXhEqFxEhPby49XJ4L2UxHQA2zaWWomKrDi+GjT6aCnXTax+HBOBcgj
         UGhj8J3SQOHr5Rn/fzJlS2TFNKoin47QaZhHc6GbRu9CkAV/hOJ3viVWvLe8Hqj6yvjy
         ivlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787028228; x=1787633028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vs+0yoQ+2csalhbX8xRlSH2mZEgsNhiXsJ7Opsjy+3s=;
        b=VdixF94IL+Bi/WglLhoQJwaBPIxWREZJ8xoumFaso4gTmu42lmovevFCPFgCD+/cls
         e9vim6cV5XfI/LC6sB1jRxVJbhd0XHoiKy2AYCBV8+/R8xTebLRQG1F1IP24sSr3l1cR
         OvGe29p+qORA/3yp3FuvNQGXTo6LlmQyeWBcMmxSqatoZ3kjM8UnOwI9FCeljGPjHTAR
         t2qNAmvrDSJgAmyz2IO7FBgHq7sXA11wN0aNc109lazBwhXTOuEec/+Tcgr5CDfRaw4s
         nwQ7O3B0nu9Eb29LEb0t6oi3YQd+jEl8UzrDstkoVOwTj0hwKQbIAbp8F2ozvQcxQsAB
         N3wA==
X-Gm-Message-State: AOJu0Yz0J+wgEIoZnZ09DBHdriLy+JrFI+RRuW16nqlIqlF+Dj+vIhSs
	lfcJr3T7fbi9Bzgvx6rRIglIumcroK9Be5BPv+jX6/5TKHvlU+tEAykcyQUTp0Vc1cnvkxfVObE
	wQIz4s1Knx0cP/Ab7jCyz9ydwf6wF4OQ=
X-Gm-Gg: AR+sD10QMagChLVsmsMlQUpr+5+CIKE7STo8qKvVmicGU8kTpaRMH+8ayqVHdLTOnWt
	Q6wj37sa+w3mghmkbu0rTbn1/FdJPidqLh8tYw+7qAlOtLTCjU1CRgTMdr4M9Ecb0b4EX9vr0Co
	NzEGLOVD3cGO7JEah5kKsp9cK7lW0NygQM4Ic1ZJ0Z/e6n1ohDrnkfEgm+q7AdcwVYw1QYPn1u/
	zickyCMtG05hUv3drp6tDr+5xOBjzT0Mi0WTk1Y6YwV/YR14fS4Tn3EBGYbHuYoF4xGHPOCWZ1u
	IzFgwxF+pbU9I4Q6py8TRCqCrUmnY4WKMyuwpwaPOHU=
X-Received: by 2002:a05:6512:6695:10b0:5aa:6981:333 with SMTP id
 2adb3069b0e04-5b4711988camr466588e87.16.1787028227711; Mon, 17 Aug 2026
 21:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811135720.109580-1-maimon.sagi@gmail.com>
 <20260811135720.109580-3-maimon.sagi@gmail.com> <882712e7-b13e-47a6-91f0-998dc59e8eb8@linux.dev>
In-Reply-To: <882712e7-b13e-47a6-91f0-998dc59e8eb8@linux.dev>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Tue, 18 Aug 2026 07:43:20 +0300
X-Gm-Features: AcwNN1UU3sbdcKLoDBG791Mua6HUln821yo_XIWun73XbkzCcWwn6kCfPwVLtwM
Message-ID: <CAMuE1bGfCv=Pa1BnCh_Rc9vDMwLBfL7vJZHiWeTtA7+LYmAhDQ@mail.gmail.com>
Subject: Re: [PATCH net-next v11 2/2] ptp: ocp: add TAP CPLD firmware upload
 for ADVA TimeCard X1
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, kuba@kernel.org, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 1:19=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 11/08/2026 14:57, Sagi Maimon wrote:
> > The Lattice MachXO3 CPLD on the ADVA TimeCard X1 is programmed over I2C
> > using in-system programming (ISP).  Build on the TMC bus arbitration
> > added previously and expose the update path through the kernel
> > firmware-upload subsystem.
> >
> > The framework acquires the bus, erases the configuration flash, program=
s
> > the image page-by-page and activates it with the MachXO3 REFRESH
> > command.  The upload node is registered per card as adva-cpld.N, using
> > the same index as the owning ocpN device, so a host with more than one
> > X1 board gets one node each:
> >
> >    /sys/class/firmware/adva-cpld.N/
> >
> > The whole prepare/write/poll_complete/cleanup sequence runs under
> > cpld_lock and the i2c adapter lock, so an EEPROM read blocks for as lon=
g
> > as programming takes; the alternative is reading the TMC bus instead.
> > The upload is unregistered first on detach, which cancels and flushes a=
n
> > in-flight programming cycle while the I2C controller is still up.
> >
> > Select FW_LOADER and FW_UPLOAD, as the documented update path does not
> > exist without them.
> >
> > Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> > ---
> >   Documentation/ABI/testing/sysfs-timecard |   5 +
> >   drivers/ptp/Kconfig                      |   2 +
> >   drivers/ptp/ptp_ocp.c                    | 313 ++++++++++++++++++++++=
-
> >   3 files changed, 319 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/A=
BI/testing/sysfs-timecard
> > index 26a93cee0b89..41eeadd46330 100644
> > --- a/Documentation/ABI/testing/sysfs-timecard
> > +++ b/Documentation/ABI/testing/sysfs-timecard
> > @@ -30,6 +30,11 @@ Description:       (RO, root only) The status regist=
er of the TAP CPLD, in
> >               ID of the CPLD is reported as the fixed "cpld.id" version=
 by
> >               devlink dev info.
> >
> > +             To program new CPLD firmware use the standard kernel
> > +             firmware-upload interface, registered per card at:
> > +             /sys/class/firmware/adva-cpld.N/
> > +             where N is the index of this ocpN device.
> > +
> >   What:               /sys/class/timecard/ocpN/available_clock_sources
> >   Date:               September 2021
> >   Contact:    Jonathan Lemon <jonathan.lemon@gmail.com>
> > diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
> > index b93640ca08b7..0c2c7dd32e7f 100644
> > --- a/drivers/ptp/Kconfig
> > +++ b/drivers/ptp/Kconfig
> > @@ -218,6 +218,8 @@ config PTP_1588_CLOCK_OCP
> >       select NET_DEVLINK
> >       select CRC16
> >       select DPLL
> > +     select FW_LOADER
> > +     select FW_UPLOAD
> >       help
> >         This driver adds support for an OpenCompute time card.
> >
> > diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> > index 41a7fde1ae6a..4a0bd9b89452 100644
> > --- a/drivers/ptp/ptp_ocp.c
> > +++ b/drivers/ptp/ptp_ocp.c
> > @@ -20,12 +20,14 @@
> >   #include <linux/spi/altera.h>
> >   #include <net/devlink.h>
> >   #include <linux/i2c.h>
> > +#include <linux/iopoll.h>
> >   #include <linux/mtd/mtd.h>
> >   #include <linux/nvmem-consumer.h>
> >   #include <linux/crc16.h>
> >   #include <linux/dpll.h>
> >   #include <linux/unaligned.h>
> >   #include <linux/delay.h>
> > +#include <linux/firmware.h>
> >
> >   #define PCI_DEVICE_ID_META_TIMECARD         0x0400
> >
> > @@ -426,6 +428,9 @@ struct ptp_ocp {
> >       struct i2c_adapter      *cpld_adap;           /* claimed adapter;=
 valid under cpld_lock */
> >       u32                     cpld_id;              /* cached Lattice d=
evice ID; 0 if unread */
> >       bool                    has_cpld;             /* x1 TAP CPLD pres=
ent */
> > +     struct fw_upload        *cpld_fw_upload;      /* firmware upload =
handle; NULL if absent */
> > +     bool                    cpld_cancel;          /* cancellation req=
uested */
> > +     bool                    cpld_in_config_mode;  /* EN_CFG_TP issued=
 but not yet REFRESH'd */
> >   };
> >
> >   #define OCP_REQ_TIMESTAMP   BIT(0)
> > @@ -459,6 +464,8 @@ static int ptp_ocp_art_board_init(struct ptp_ocp *b=
p, struct ocp_resource *r);
> >
> >   static int ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_res=
ource *r);
> >
> > +static const struct fw_upload_ops adva_cpld_upload_ops;
> > +
> >   static const struct ocp_sma_op ocp_adva_sma_op;
> >   static const struct ocp_sma_op ocp_adva_x1_sma_op;
> >   static int adva_x1_cpld_device_id(struct ptp_ocp *bp, u32 *id);
> > @@ -3225,6 +3232,29 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, stru=
ct ocp_resource *r)
> >       ptp_ocp_sma_init(bp);
> >
> >       bp->has_cpld =3D info->has_cpld;
> > +     if (bp->has_cpld) {
> > +             struct fw_upload *fwl;
> > +             const char *name;
> > +
> > +             /* One instance per card, numbered like the ocpN device.
> > +              * firmware_upload_register() keeps the pointer rather th=
an
> > +              * copying the string, so it has to outlive the registrat=
ion.
> > +              */
> > +             name =3D devm_kasprintf(&bp->pdev->dev, GFP_KERNEL,
> > +                                   "adva-cpld.%d", bp->id);
> > +             if (!name)
> > +                     return -ENOMEM;
> > +
> > +             fwl =3D firmware_upload_register(THIS_MODULE, &bp->pdev->=
dev,
> > +                                            name, &adva_cpld_upload_op=
s, bp);
> > +             if (IS_ERR(fwl))
> > +                     dev_warn(&bp->pdev->dev,
> > +                              "CPLD firmware upload unavailable: %pe\n=
",
> > +                              fwl);
> > +             else
> > +                     bp->cpld_fw_upload =3D fwl;
> > +     }
> > +
> >       return ptp_ocp_init_clock(bp, &info->servo);
> >   }
> >
> > @@ -4283,6 +4313,15 @@ static const struct ocp_attr_group art_timecard_=
groups[] =3D {
> >   /* Lattice LCMXO3LF ISC command codes */
> >   #define CPLD_CMD_READ_ID      0xE0000000UL
> >   #define CPLD_CMD_READ_STATUS  0x3C000000UL
> > +#define CPLD_CMD_EN_CFG_TP    0x74   /* enable config, transparent mod=
e */
> > +#define CPLD_CMD_DIS_CFG      0x26
> > +#define CPLD_CMD_ERASE        0x0E
> > +#define CPLD_CMD_RESET_ADDR   0x46
> > +#define CPLD_CMD_WRITE_PAGE   0x70
> > +#define CPLD_CMD_SET_DONE     0x5E
> > +#define CPLD_CMD_REFRESH      0x79
> > +#define CPLD_PAGE_SIZE        16
> > +#define CPLD_POLL_US          10000  /* status poll interval while bus=
y */
> >
> >   /* Status register bit positions (Lattice LCMXO3LF datasheet) */
> >   #define CPLD_STATUS_DONE   BIT(8)
> > @@ -4408,7 +4447,8 @@ static void adva_x1_bus_release(struct ptp_ocp *b=
p)
> >    * Claim the TMC bus for a CPLD operation.  Holding the adapter lock =
over
> >    * the handshake keeps ptp_ocp_read_eeprom(), the nvmem attributes an=
d the
> >    * at24 sysfs files off the controller while it is routed away from t=
he
> > - * EEPROMs.
> > + * EEPROMs.  A firmware upload holds it across the whole prepare/write=
/poll
> > + * sequence, so an EEPROM read blocks for as long as programming takes=
.
> >    */
> >   static int adva_x1_bus_claim(struct ptp_ocp *bp)
> >   {
> > @@ -4442,6 +4482,20 @@ static int adva_x1_mux_select(struct ptp_ocp *bp=
, int ch)
> >       return adva_x1_i2c_xfer(bp, ADVA_MUX_ADDR, &val, 1, NULL, 0);
> >   }
> >
> > +/* Send 1-byte ISC command + optional arguments. */
> > +static int adva_x1_cpld_write(struct ptp_ocp *bp,
> > +                           u8 cmd, const u8 *args, u8 nargs)
> > +{
> > +     u8 buf[1 + 64];
> > +
> > +     if (nargs > 64)
> > +             return -EINVAL;
> > +     buf[0] =3D cmd;
> > +     if (nargs)
> > +             memcpy(&buf[1], args, nargs);
> > +     return adva_x1_i2c_xfer(bp, ADVA_CPLD_ADDR, buf, 1 + nargs, NULL,=
 0);
> > +}
>
> this function looks like not needed. basically, all callers of this
> function use either static, or stack-allocated buffurs, which are copied
> to another 65-byte stack allocated buffer, which is later copied to a
> heap-allocated buffer in adva_x1_i2c_xfer(). I think it's too much of
> copying for a command interface. It can be simplified to actually copy
> a command byte to a very last buffer only. The check can also be moved
> to adva_x1_i2c_xfer(). Even static per-command data can be returned as
> a pointer via helper with switch-case block. I believe it will make code
> much simplier and more readable.
>

Thanks - v12 restructures the command path as you describe, with one
deviation I have called out below: I kept adva_x1_cpld_write() itself.

adva_x1_i2c_xfer() now takes the opcode as its own argument and
assembles the message in a scratch buffer taken once per bus claim, so
there is no intermediate buffer and no per-transfer allocation:

static int adva_x1_i2c_xfer(struct ptp_ocp *bp, u8 addr, int cmd,
   const void *wdata, u8 wlen,
   void *rdata, u8 rlen)
{
...
if (hdr + wlen > ADVA_CPLD_XFER_MAX ||
   rlen > ADVA_CPLD_XFER_MAX)
return -EINVAL;

wbuf =3D bp->cpld_buf;
rbuf =3D bp->cpld_buf + ADVA_CPLD_XFER_MAX;

The bound check you asked for is here now, and it has something real to
bound: the scratch buffer, rather than the stack array it used to guard.

adva_x1_cpld_write() takes just the opcode, and the argument bytes come
from a switch-case helper returning a pointer to the static data:

static const u8 *adva_x1_cpld_args(u8 cmd, u8 *nargs)
{
static const u8 en_cfg_tp[] =3D { 0x08, 0x00 };
static const u8 erase_cfg[] =3D { 0x04, 0x00, 0x00 };

switch (cmd) {
case CPLD_CMD_EN_CFG_TP:
*nargs =3D sizeof(en_cfg_tp);
return en_cfg_tp;
...
}
}

static int adva_x1_cpld_write(struct ptp_ocp *bp, u8 cmd)
{
const u8 *args;
u8 nargs;

args =3D adva_x1_cpld_args(cmd, &nargs);

return adva_x1_i2c_xfer(bp, ADVA_CPLD_ADDR, cmd, args, nargs,
NULL, 0);
}

I kept adva_x1_cpld_write() itself, now four lines, because something has
to consume the pointer the helper returns and issue the transfer; without
it each of the eight call sites needs the lookup, two locals and the full
adva_x1_i2c_xfer() argument list.  If you meant drop it entirely and have
the callers do that, say so and I will.

> > +
> >   /*
> >    * Send a 4-byte command then read data back without an intermediate =
STOP
> >    * (Lattice combined write->repeated-START->read).  Two messages in o=
ne
> > @@ -4467,6 +4521,38 @@ static int adva_x1_cpld_read_status(struct ptp_o=
cp *bp, u32 *status)
> >       return 0;
> >   }
> >
>
> [...]
>
> > +static enum fw_upload_err
> > +adva_cpld_prepare(struct fw_upload *fwl, const u8 *data, u32 size)
> > +{
> > +     static const u8 era_args[3] =3D { 0x04, 0x00, 0x00 }; /* cfg sect=
or only */
> > +     static const u8 en_args[2]  =3D { 0x08, 0x00 };
> > +     static const u8 dis_args[2] =3D { 0x00, 0x00 };
>
> here dis_args are copying another static const buffer from
> adva_cpld_cleanup()
>

Gone - both call sites are now just adva_x1_cpld_write(bp,
CPLD_CMD_DIS_CFG).

> > +     static const u8 zero3[3]    =3D { 0 };
>
> this one is redundant, because heap-allocated buffer is zero'ed on alloc
>

Right in effect, though not for that reason in v11: the write buffer was
kmemdup()ed there, which does not zero, so the zero3[] arrays were doing
real work.  In v12 the all-zero commands (RESET_ADDR, SET_DONE, DIS_CFG,
REFRESH) pass NULL and adva_x1_i2c_xfer() zeroes that part of the
message, so the arrays are gone.

> this code needs a bit more thinking.
>

Reworked in v12 along the lines above - see the per-command changes in
this reply.  No functional change: the byte sequences on the wire are
unchanged, and I verified CPLD programming on an ADVA TimeCard X1.

> > +     enum fw_upload_err ret =3D FW_UPLOAD_ERR_NONE;
> > +     struct ptp_ocp *bp =3D fwl->dd_handle;
> > +
> > +     /* Do not clear cpld_cancel here: fw_upload_start() queues the wo=
rk
> > +      * before this runs, so a cancel may already have arrived.  It is
> > +      * cleared once the upload is over, on every exit below and in
> > +      * cleanup().
> > +      */
> > +     if (!size || size % CPLD_PAGE_SIZE) {
> > +             WRITE_ONCE(bp->cpld_cancel, false);
> > +             return FW_UPLOAD_ERR_INVALID_SIZE;
> > +     }
> > +
> > +     bp->cpld_in_config_mode =3D false;
> > +
> > +     mutex_lock(&bp->cpld_lock);
> > +
> > +     if (adva_x1_bus_claim(bp)) {
> > +             ret =3D FW_UPLOAD_ERR_TIMEOUT;
> > +             goto err_unlock;
> > +     }
> > +
> > +     if (adva_x1_mux_select(bp, ADVA_MUX_CHANNEL)) {
> > +             ret =3D FW_UPLOAD_ERR_HW_ERROR;
> > +             goto err_release;
> > +     }
> > +
> > +     /* Set before issuing EN_CFG_TP, not after it completes: the CPLD=
 may
> > +      * have entered configuration mode even if the write reports an e=
rror
> > +      * or the wait below times out, and err_deselect only sends DIS_C=
FG
> > +      * when this is set.  A DIS_CFG to a device that never entered th=
e
> > +      * mode is harmless; leaving it enabled is not.
> > +      */
> > +     bp->cpld_in_config_mode =3D true;
> > +
> > +     if (adva_x1_cpld_write(bp, CPLD_CMD_EN_CFG_TP, en_args, 2) ||
> > +         adva_x1_cpld_wait_ready(bp, 5000)) {
> > +             ret =3D adva_cpld_err(bp);
> > +             goto err_deselect;
> > +     }
> > +
> > +     if (READ_ONCE(bp->cpld_cancel)) {
> > +             ret =3D FW_UPLOAD_ERR_CANCELED;
> > +             goto err_deselect;
> > +     }
> > +
> > +     if (adva_x1_cpld_write(bp, CPLD_CMD_ERASE, era_args, 3) ||
> > +         adva_x1_cpld_wait_ready(bp, 15000)) {
> > +             ret =3D adva_cpld_err(bp);
> > +             goto err_deselect;
> > +     }
> > +
> > +     if (READ_ONCE(bp->cpld_cancel)) {
> > +             ret =3D FW_UPLOAD_ERR_CANCELED;
> > +             goto err_deselect;
> > +     }
> > +
> > +     if (adva_x1_cpld_write(bp, CPLD_CMD_RESET_ADDR, zero3, 3)) {
> > +             ret =3D FW_UPLOAD_ERR_HW_ERROR;
> > +             goto err_deselect;
> > +     }
> > +
> > +     /* cleanup() unlocks everything.  fw_upload_main() only pairs it =
with
> > +      * a prepare() that succeeded, so the error paths below unlock he=
re
> > +      * instead; hand the context to cleanup() for sparse's benefit.
> > +      */
> > +     __release(&bp->cpld_lock);
> > +     return FW_UPLOAD_ERR_NONE;
> > +
> > +err_deselect:
> > +     if (bp->cpld_in_config_mode) {
> > +             adva_x1_cpld_write(bp, CPLD_CMD_DIS_CFG, dis_args, 2);
> > +             bp->cpld_in_config_mode =3D false;
> > +     }
> > +     adva_x1_mux_select(bp, -1);
> > +err_release:
> > +     adva_x1_bus_release(bp);
> > +err_unlock:
> > +     WRITE_ONCE(bp->cpld_cancel, false);
> > +     mutex_unlock(&bp->cpld_lock);
> > +     return ret;
> > +}
> > +
> > +static enum fw_upload_err
> > +adva_cpld_write(struct fw_upload *fwl, const u8 *data,
> > +             u32 offset, u32 size, u32 *written)
> > +{
> > +     struct ptp_ocp *bp =3D fwl->dd_handle;
> > +     u8 page_args[3 + CPLD_PAGE_SIZE];
> > +
> > +     lockdep_assert_held(&bp->cpld_lock);
> > +
> > +     if (READ_ONCE(bp->cpld_cancel))
> > +             return FW_UPLOAD_ERR_CANCELED;
> > +
> > +     if (size < CPLD_PAGE_SIZE)
> > +             return FW_UPLOAD_ERR_INVALID_SIZE;
> > +
> > +     page_args[0] =3D 0x00;
> > +     page_args[1] =3D 0x00;
> > +     page_args[2] =3D 0x01;
> > +     memcpy(&page_args[3], data + offset, CPLD_PAGE_SIZE);
>
> here again, stack allocated -> stack allocated -> heap allocated.
> quite a lot of allocations and copying for 16 bytes of actual data
> transfer.
>

Fixed in v12.  The middle stack buffer is gone, and the scratch buffer is
allocated once per bus claim rather than per transfer - a claim spans the
whole upload, so programming an image is one allocation rather than one
per page:

/* One scratch buffer per claim, not per transfer. */
bp->cpld_buf =3D kzalloc(2 * ADVA_CPLD_XFER_MAX, GFP_KERNEL);

adva_cpld_write() still stages the three header bytes and the page in a
small stack array before the transfer copies it in, so the page data is
copied once more than strictly necessary.  Removing that too would mean
letting the callback write into the transfer's buffer directly, which
seemed a worse trade; say the word if you would rather have it.

net-next is closed at the moment, so I will post v12 with these changes
once it reopens.

> > +
> > +     if (adva_x1_cpld_write(bp, CPLD_CMD_WRITE_PAGE,
> > +                            page_args, 3 + CPLD_PAGE_SIZE) ||
> > +         adva_x1_cpld_wait_ready(bp, 100))
> > +             return adva_cpld_err(bp);
> > +
> > +     *written =3D CPLD_PAGE_SIZE;
> > +     return FW_UPLOAD_ERR_NONE;
> > +}
