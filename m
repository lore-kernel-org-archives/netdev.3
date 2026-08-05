Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAEE3D9693
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914914; cv=pass; b=DuNBrdxD7LWWaJfb+pvWIcmRQhkTCIDsdmN0llFHBgGOyvAG5+ZwpgUUPvYQ/vjKi+G6jTQAuacwmEKKQS/LJgNBL5TH65lTqbiCFU+ajDBXBp9ABvA5g2tvfLkBJx18EMHL2y2bBw5vDu4jGZRG5hWOFHgyBGHrHzBQKdXF5WY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914914; c=relaxed/simple;
	bh=8q+gFP0vJvpRXkgvdKsFK24nuzuT7xLBCqwgKX0Wi0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cinwOMIt5+dYkHe/9AHZ7GOjK8AIwV23ONdk6ZR32JSfJubFKGGqbAYawY5lzUsjreoHVvL3nCShoO/qtq1nenlACgveRK0uabj4/N0Ytn6p8toBUTsts6xNbepxhhE9bMEKE3dMdM7SWVL2IqboHyex2Uau1NUP4TZG8WyIyEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abTn70sJ; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abTn70sJ"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39c9bb9d2fbso6028971fa.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 00:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785914910; cv=none;
        d=google.com; s=arc-20260327;
        b=V2OBN3ya72oa/KUPgSg5RnwqwHfJ91jO0mBjl8X/xyc/x5UBfOiS51byRqkrvAXZb5
         Y+7bRP2v15bbAOyM/xxvpTVtQzKLsTx5mP9Rox+ighkzaQHWT5+lYWfwJaH1z1KohFo8
         4pqSA2gj5egWBOGx+DukeLDDlbyuUEtRHJQ9cMw1OHfXTS+2SNbcElQr2pTcMoFNzhZd
         Lj617HV3nwPvUqV/6i/fS5VA6sSIuKwGTfelgk1TTled+o26OJ3VrwiZf2/pzzKqLQsm
         7cnu58HNEpnjJE3B1GHtAa2oJP4j5+MMWDl+KJYoQB3b2adeCy338osQnz4oN5pOYqK3
         SrqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xaRcbEsfEVx7aPVZtrY3/6rgc4/TBzudWxm1jBolpJ8=;
        fh=cQlrPxTWV6PZgHlZD/Y2EJyJKJK99huDM3nrRV2Obhs=;
        b=BXQC+XP5vkgKYC5redVuN9+eByHj6UHURn/M9w0VsXtpxGgcdO27jK2PHClqqIpOld
         dLudNdqQnYJehi7arXQfv0iWflH/PtqvCDINemPFSB5J4jpGqED75MUPbyJpkODbtHMW
         xP1rukj0zW3qSU+O0bwz2H3vn05aFjyETbj4DJVMXtSR+DDdCC6MY5WUK9p0+gjIW5wz
         9a5FMhu/wf4Sph0r7XyQ9lsR7PgmVmGE/Xs6tn4mNpBHSDDGoICJWk7bytQDJA4AVcw5
         A0gh41XVn02el0nZmUkPS2pA403rIBn0PQSnNP08jQBdWOEkAyUocEZMUGvfy9v6pfUT
         Kp5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785914910; x=1786519710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xaRcbEsfEVx7aPVZtrY3/6rgc4/TBzudWxm1jBolpJ8=;
        b=abTn70sJXvBe8etUH3hdQNuXSwpcccgNfPDMhSAzLSfkrcr/PmljP03lEXIvZOlugn
         cvkh90rH8sbuoK8J9QyJdNC368RJA6/LwSdrZVx9bwiCzFcE9qs47WxOYK3gTRfUNSBa
         lY7OUwIyeEY5Oi/eKecmBTlyHcbKa7kqk4cmFFLahaEahjTUOBb/ssPg+R0h3FfMkqpr
         ZvakVKVZgDc4pxR/HqGpp1ORP7w3NLVjd+MV8GT61vYTCg4dbC8G+6XT4OFjvFiYHl45
         gW7yhicomIZ7hpipzv31IHTLUQhwrKPKelNJcm2rGKKyTxYHjTimTgaJSCR4AArdO8NJ
         Dv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785914910; x=1786519710;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xaRcbEsfEVx7aPVZtrY3/6rgc4/TBzudWxm1jBolpJ8=;
        b=KX2LXPnXaqTAbQe0V89uLI/E4gVpEv0dvTCOeEsqHF1wD1XzjdJFGhYXWL/qShSe97
         L7RfLTAaV/TV09gX3NRnc1Lg0cfPrhCvBoYvSQ1vysuyLmZvAH9zlOniFDEcDIcDCUDn
         CRDothSv+K6PAAyTKWpDsFWiTmjjsAMgERliWxD9E8+URp8RMCytvNQfEqQv4JwWdy2D
         a1SKgdTJuuEC7EedpMpNSs5jBozx6YsdzrKLf9elYe091u85B3k9AEs8t/c6bSjNp5eU
         6o+7MMl0c4hLGBeyQDzqywkbnEoJu5+X1rsTysGaBKpJmbmbLblf2k2xs6ZXeAHyib1D
         eo+Q==
X-Forwarded-Encrypted: i=1; AHgh+RrsQyBAuhYUyW5ahoU2pwigQNjJCUaUIYfr9NFMIVWgcs6bgMSBP9LwDQoNRDYqVp+oox5eX2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGu1qy1JQXLyIcsDvclTDIesYWE3foUjmYyZfpX4Wiqwn8Kxs9
	9xE7IQIk6GLwf0KY/n82uDaAqX8LjJljZAk6tw8VBrsXU+UDH5OfZ2WyfKYE332YxHSnJWkdunv
	PAyIzUXV3e/WO0rtOmU8JFKpehXL4FGc=
X-Gm-Gg: AR+sD12PqDqaIQaM0XYoxCgMU2a+udo+sizS9UbAShK5xZMmaxNsj7hJwJm/JafG21y
	SW28epLva22vEs0JtNa4eipuk89F1IBadJQ0NaYDrQcwgfZxaOZNl9mORWpI8B/mNHODZTKsOrO
	6V21HeaIO7hgKI9xnF1oxTZIE+HVk34jUtmJygU5Vevl5nG86DW0E64gJf9QcWutifnI591oMU4
	xkaKw6Zp0TrpjTu6nhDOfOTEm4oFjTbeCmfIP5YWRP+SnPX9udlCe4xh8iSVkURFDAJ+6gqLbNi
	HXsDzZgk+kSs6hPY5apC/pG2Wa2qvXsuNtbuac3cEHQ=
X-Received: by 2002:a05:651c:150d:b0:39b:32b3:b31f with SMTP id
 38308e7fff4ca-39fbb18fc20mr5168471fa.5.1785914909908; Wed, 05 Aug 2026
 00:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802071132.5078-1-maimon.sagi@gmail.com> <65c42538-9607-4dff-adbe-d9d5c9a338d0@linux.dev>
In-Reply-To: <65c42538-9607-4dff-adbe-d9d5c9a338d0@linux.dev>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Wed, 5 Aug 2026 10:28:03 +0300
X-Gm-Features: AUfX_myoCmJxv3WuJje3pMhcUNa0Itziz7AHvWPI355sKXqYIEtCd2KQMYfIttY
Message-ID: <CAMuE1bEaRBJVSJYONJ2o3adOOzayv0ayNZ2qCB1zxuodpbiR=Q@mail.gmail.com>
Subject: Re: [PATCH v8] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: jonathan.lemon@gmail.com, richardcochran@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 2:35=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 02/08/2026 08:11, Sagi Maimon wrote:
> > The ADVA TimeCard X1 (PCI device 0x0410) uses a Lattice MachXO3 CPLD
> > that is programmed over I2C using in-system programming (ISP).
> >
> > The CPLD is connected to a secondary I2C bus shared with the onboard
> > MicroBlaze soft CPU.
> >
> > Add support for CPLD access and firmware updates on the ADVA TimeCard X=
1
> > board by arbitration of the shared I2C bus, CPLD ISP command handling,
> > status polling, and firmware upload operations using the firmware-uploa=
d
> > subsystem.
> >
> > Add the following X1-only user-visible interfaces:
> >
> >    /sys/class/timecard/ocpN/cpld_device_id
> >          report the 32-bit Lattice MachXO3 CPLD device ID
> >
> >    /sys/class/timecard/ocpN/cpld_status
> >          report the CPLD status register, including the DONE,
> >          BUSY, and FAILED indicators
> >
> > Firmware updates are performed through the firmware-upload framework,
> > which acquires ownership of the shared I2C bus, erases the CPLD
> > configuration flash, programs the image page-by-page, and activates
> > the new image using the MachXO3 REFRESH command.
> >
> > All CPLD operations are serialized and coordinated with the MicroBlaze
> > firmware to ensure exclusive access to the shared I2C bus. The added
> > interfaces are available only on ADVA TimeCard X1 boards.
> >
> > Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> > ---
> >
> >   Addressed comments from:
> >    - Jakub Kicinski :https://lore.kernel.org/all/20260730130424.77a90fa=
3@kernel.org/
> >    - Vadim Fedorenko :https://lore.kernel.org/all/7075bcdb-da4d-4d2c-bd=
09-516d9f244277@linux.dev/
> >
> >   Changes since v7:
> >   - Use %pe instead of %ld + PTR_ERR() (coccicheck)
> >   - Add #include <linux/unaligned.h>
> >   - Widen adva_x1_i2c_xfer() buffer pointers to void *
> >   - Use cpu_to_be32() in adva_x1_cpld_cmd_read()
> >   - Use get_unaligned_be32() in adva_x1_cpld_read_status()
> >
> >   Documentation/ABI/testing/sysfs-timecard |  34 ++
> >   drivers/ptp/ptp_ocp.c                    | 497 ++++++++++++++++++++++=
-
> >   2 files changed, 527 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/A=
BI/testing/sysfs-timecard
> > index 3ae41b7634ac..f7c9955acb0a 100644
> > --- a/Documentation/ABI/testing/sysfs-timecard
> > +++ b/Documentation/ABI/testing/sysfs-timecard
> > @@ -11,6 +11,40 @@ Contact:   Jonathan Lemon <jonathan.lemon@gmail.com>
> >   Description:        This directory contains the attributes of the Nth=
 timecard
> >               registered.
> >
> > +What:                /sys/class/timecard/ocpN/cpld_device_id
> > +Date:                July 2026
> > +Contact:     Sagi Maimon <maimon.sagi@gmail.com>
> > +Description: (RO) The 32-bit Lattice device ID of the TAP CPLD, report=
ed as
> > +             a hex string, e.g. "0xe12bc043".
> > +
> > +             Only present on ADVA x1 TAP boards (PCI ID 0xad5a:0x0410)=
.
> > +             The Lattice LCMXO3LF-210 reports 0xe12bc043.
> > +
> > +             The driver acquires the MicroBlaze I2C bus internally bef=
ore
> > +             issuing the READ_IDCODE command; no bus arbitration is re=
quired
> > +             from userspace.
> > +
> > +What:                /sys/class/timecard/ocpN/cpld_status
> > +Date:                July 2026
> > +Contact:     Sagi Maimon <maimon.sagi@gmail.com>
> > +Description: (RO) The status register of the TAP CPLD, in human-readab=
le
> > +             form:
> > +
> > +               done=3D<0|1> busy=3D<0|1> failed=3D<0|1>
> > +
> > +             Only present on ADVA x1 TAP boards (PCI ID 0xad5a:0x0410)=
.
> > +
> > +             done=3D1 indicates the configuration flash was successful=
ly
> > +             programmed and is active.  busy=3D1 means an internal ope=
ration
> > +             is in progress.  failed=3D1 means the last ISC operation =
failed.
> > +
> > +             The driver acquires the MicroBlaze I2C bus internally; no=
 bus
> > +             arbitration is required from userspace.
> > +
> > +             To program new CPLD firmware use the standard kernel
> > +             firmware-upload interface registered at:
> > +             /sys/class/firmware/adva-cpld/
> > +
> >   What:               /sys/class/timecard/ocpN/available_clock_sources
> >   Date:               September 2021
> >   Contact:    Jonathan Lemon <jonathan.lemon@gmail.com>
> > diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> > index 35e911f1ad78..a4a8cab5ed7d 100644
> > --- a/drivers/ptp/ptp_ocp.c
> > +++ b/drivers/ptp/ptp_ocp.c
> > @@ -24,6 +24,11 @@
> >   #include <linux/nvmem-consumer.h>
> >   #include <linux/crc16.h>
> >   #include <linux/dpll.h>
> > +#include <linux/unaligned.h>
> > +#include <linux/delay.h>
> > +#include <linux/firmware.h>
> > +#include <linux/delay.h>
> > +#include <linux/firmware.h>
>
> why do you double include headers?
>
> >
> >   #define PCI_DEVICE_ID_META_TIMECARD         0x0400
> >
> > @@ -85,6 +90,7 @@ struct ptp_ocp_adva_info {
> >       u8                              signals_nr;
> >       u8                              freq_in_nr;
> >       const struct ocp_attr_group     *attr_groups;
> > +     bool                            has_cpld; /* x1: supports CPLD fi=
rmware upload */
> >   };
> >
> >   #define OCP_CTRL_ENABLE             BIT(0)
> > @@ -163,7 +169,8 @@ struct gpio_reg {
> >       u32     gpio1;
> >       u32     __pad0;
> >       u32     gpio2;
> > -     u32     __pad1;
> > +     /* adva_x1: I2C bus ownership register; reserved on other variant=
s */
> > +     u32     i2c_bus_ctrl;
> >   };
> >
> >   struct irig_master_reg {
> > @@ -416,6 +423,12 @@ struct ptp_ocp {
> >       dpll_tracker tracker;
> >       int signals_nr;
> >       int freq_in_nr;
> > +     /* adva_x1 CPLD I2C (internal use only) */
> > +     struct mutex            cpld_lock;            /* serialises CPLD =
operations */
> > +     int                     cpld_i2c_adap_nr;     /* I2C adapter nr; =
-1 if absent */
> > +     struct fw_upload        *cpld_fw_upload;      /* firmware upload =
handle; NULL if absent */
> > +     bool                    cpld_cancel;          /* cancellation req=
uested */
> > +     bool                    cpld_in_config_mode;  /* EN_CFG_TP issued=
 but not yet REFRESH'd */
> >   };
> >
> >   #define OCP_REQ_TIMESTAMP   BIT(0)
> > @@ -449,6 +462,8 @@ static int ptp_ocp_art_board_init(struct ptp_ocp *b=
p, struct ocp_resource *r);
> >
> >   static int ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_res=
ource *r);
> >
> > +static const struct fw_upload_ops adva_cpld_upload_ops;
> > +
> >   static const struct ocp_sma_op ocp_adva_sma_op;
> >   static const struct ocp_sma_op ocp_adva_x1_sma_op;
> >
> > @@ -1273,6 +1288,7 @@ static struct ocp_resource ocp_adva_x1_resource[]=
 =3D {
> >                       .signals_nr   =3D 4,
> >                       .freq_in_nr   =3D 4,
> >                       .attr_groups  =3D adva_timecard_x1_groups,
> > +                     .has_cpld     =3D true,
> >               },
> >       },
> >       { }
> > @@ -3197,6 +3213,20 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, stru=
ct ocp_resource *r)
> >               return err;
> >       ptp_ocp_sma_init(bp);
> >
> > +     if (info->has_cpld) {
> > +             struct fw_upload *fwl;
> > +
> > +             fwl =3D firmware_upload_register(THIS_MODULE, &bp->pdev->=
dev,
> > +                                            "adva-cpld",
> > +                                            &adva_cpld_upload_ops, bp)=
;
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
> > @@ -4224,6 +4254,442 @@ static const struct ocp_attr_group art_timecard=
_groups[] =3D {
> >       { },
> >   };
> >
> > +/*
> > + * Internal helpers for the adva_x1 TAP CPLD (Lattice LCMXO3LF-210).
> > + *
> > + * The CPLD sits at I2C address 0x40 behind a PCA9548 mux (0x74) on
> > + * channel 0.  The I2C bus is shared with the MicroBlaze firmware;
> > + * cpld_lock + mblaze acquire/release provide mutual exclusion for the
> > + * full duration of any CPLD operation.  No raw I2C access is exposed
> > + * to userspace; only the high-level attributes below are.
> > + */
> > +
> > +#define ADVA_MUX_ADDR     0x74
> > +#define ADVA_CPLD_ADDR    0x40
> > +#define ADVA_MUX_CHANNEL  0
> > +
> > +#define MBLAZE_REQUEST    0x0000ffffU
> > +#define MBLAZE_GRANTED    0xffffffffU
> > +#define MBLAZE_RETRIES    200
> > +#define MBLAZE_RETRY_US   10000
> > +
> > +/* Lattice LCMXO3LF ISC command codes */
> > +#define CPLD_CMD_READ_ID      0xE0000000UL
> > +#define CPLD_CMD_READ_STATUS  0x3C000000UL
> > +#define CPLD_CMD_EN_CFG_TP    0x74   /* enable config, transparent mod=
e */
> > +#define CPLD_CMD_DIS_CFG      0x26
> > +#define CPLD_CMD_ERASE        0x0E
> > +#define CPLD_CMD_RESET_ADDR   0x46
> > +#define CPLD_CMD_WRITE_PAGE   0x70
> > +#define CPLD_CMD_SET_DONE     0x5E
> > +#define CPLD_CMD_REFRESH      0x79
> > +#define CPLD_PAGE_SIZE        16
> > +
> > +/* Status register bit positions (Lattice LCMXO3LF datasheet) */
> > +#define CPLD_STATUS_DONE   BIT(8)
> > +#define CPLD_STATUS_BUSY   BIT(12)
> > +#define CPLD_STATUS_FAILED BIT(13)
> > +
> > +/*
> > + * adva_x1_i2c_xfer() - issue a single I2C transaction on the CPLD bus=
.
> > + *
> > + * All buffers are heap-allocated internally to guarantee DMA safety f=
or
> > + * the Xilinx I2C controller.  Caller must hold bp->cpld_lock.
> > + */
> > +static int adva_x1_i2c_xfer(struct ptp_ocp *bp,
> > +                         u8 addr, const void *wdata, u8 wlen,
> > +                         void *rdata, u8 rlen, bool nostart)
> > +{
> > +     struct i2c_adapter *adap;
> > +     struct i2c_msg msgs[2];
> > +     u8 *wbuf =3D NULL, *rbuf =3D NULL;
> > +     int nmsgs =3D 0, ret;
>
> as this patch goes through netdev, please respect reverse xmass tree
> ordering of variables declaration here and futher in the patch
>
> > +
> > +     adap =3D i2c_get_adapter(READ_ONCE(bp->cpld_i2c_adap_nr));
> > +     if (!adap)
> > +             return -ENODEV;
> > +
> > +     if (wlen) {
> > +             wbuf =3D kmemdup(wdata, wlen, GFP_KERNEL);
> > +             if (!wbuf) {
> > +                     ret =3D -ENOMEM;
> > +                     goto put;
> > +             }
> > +             msgs[nmsgs++] =3D (struct i2c_msg){
> > +                     .addr  =3D addr,
> > +                     .flags =3D I2C_M_DMA_SAFE,
> > +                     .len   =3D wlen,
> > +                     .buf   =3D wbuf,
> > +             };
> > +     }
> > +     if (rlen) {
> > +             rbuf =3D kzalloc(rlen, GFP_KERNEL);
> > +             if (!rbuf) {
> > +                     ret =3D -ENOMEM;
> > +                     goto put;
> > +             }
> > +             msgs[nmsgs++] =3D (struct i2c_msg){
> > +                     .addr  =3D addr,
> > +                     .flags =3D I2C_M_RD | I2C_M_DMA_SAFE |
> > +                              (nostart ? I2C_M_NOSTART : 0),
> > +                     .len   =3D rlen,
> > +                     .buf   =3D rbuf,
> > +             };
> > +     }
> > +
> > +     ret =3D i2c_transfer(adap, msgs, nmsgs);
> > +     if (ret =3D=3D nmsgs) {
> > +             if (rdata && rlen)
> > +                     memcpy(rdata, rbuf, rlen);
> > +             ret =3D 0;
> > +     } else {
> > +             ret =3D (ret < 0) ? ret : -EIO;
> > +     }
> > +put:
> > +     kfree(wbuf);
> > +     kfree(rbuf);
> > +     i2c_put_adapter(adap);
> > +     return ret;
> > +}
> > +
> > +/* Acquire the shared I2C bus from the MicroBlaze firmware. */
> > +static int adva_x1_mblaze_acquire(struct ptp_ocp *bp)
> > +{
> > +     u32 val;
> > +     int i;
> > +
> > +     if (!bp->pps_select)
> > +             return -ENODEV;
> > +
> > +     /* Release any stale grant left by a previous crashed caller. */
> > +     iowrite32(0, &bp->pps_select->i2c_bus_ctrl);
> > +     val =3D ioread32(&bp->pps_select->i2c_bus_ctrl);
> > +     if (val !=3D 0)
> > +             return -EBUSY;
> > +
> > +     iowrite32(MBLAZE_REQUEST, &bp->pps_select->i2c_bus_ctrl);
> > +     for (i =3D 0; i < MBLAZE_RETRIES; i++) {
> > +             usleep_range(MBLAZE_RETRY_US, MBLAZE_RETRY_US + 1000);
> > +             val =3D ioread32(&bp->pps_select->i2c_bus_ctrl);
> > +             if (val =3D=3D MBLAZE_GRANTED)
> > +                     return 0;
> > +     }
> > +     return -ETIMEDOUT;
> > +}
> > +
> > +static void adva_x1_mblaze_release(struct ptp_ocp *bp)
> > +{
> > +     if (bp->pps_select)
> > +             iowrite32(0, &bp->pps_select->i2c_bus_ctrl);
> > +}
> > +
> > +static int adva_x1_mux_select(struct ptp_ocp *bp, int ch)
> > +{
> > +     u8 val =3D (ch >=3D 0) ? BIT(ch) : 0;
> > +
> > +     return adva_x1_i2c_xfer(bp, ADVA_MUX_ADDR, &val, 1, NULL, 0, fals=
e);
> > +}
> > +
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
> > +     return adva_x1_i2c_xfer(bp, ADVA_CPLD_ADDR, buf, 1 + nargs,
> > +                              NULL, 0, false);
> > +}
> > +
> > +/*
> > + * Send a 4-byte command then read data back without an intermediate S=
TOP
> > + * (Lattice combined write=E2=86=92repeated-START=E2=86=92read).
> > + */
> > +static int adva_x1_cpld_cmd_read(struct ptp_ocp *bp,
> > +                              u32 cmd_be, u8 *out, u8 out_len)
> > +{
> > +     __be32 cmd =3D cpu_to_be32(cmd_be);
> > +
> > +     return adva_x1_i2c_xfer(bp, ADVA_CPLD_ADDR, &cmd, 4, out, out_len=
, true);
> > +}
> > +
> > +static int adva_x1_cpld_read_status(struct ptp_ocp *bp, u32 *status)
> > +{
> > +     u8 buf[4];
> > +     int ret;
> > +
> > +     ret =3D adva_x1_cpld_cmd_read(bp, CPLD_CMD_READ_STATUS, buf, 4);
> > +     if (ret)
> > +             return ret;
> > +     *status =3D get_unaligned_be32(buf);
> > +     return 0;
> > +}
> > +
> > +static int adva_x1_cpld_wait_ready(struct ptp_ocp *bp, unsigned int ma=
x_ms)
> > +{
> > +     u32 status;
> > +     unsigned int elapsed =3D 0;
> > +
> > +     while (elapsed < max_ms) {
> > +             if (adva_x1_cpld_read_status(bp, &status))
> > +                     return -EIO;
> > +             if (status & CPLD_STATUS_FAILED)
> > +                     return -EIO;
> > +             if (!(status & CPLD_STATUS_BUSY))
> > +                     return 0;
> > +             usleep_range(100000, 101000);
> > +             elapsed +=3D 100;
> > +     }
> > +     return -ETIMEDOUT;
> > +}
> > +
> > +/*
> > + * cpld_device_id - show the Lattice device ID of the TAP CPLD.
> > + *
> > + * Returns the 32-bit ID as a hex string, e.g. "0x612bc043\n".
> > + * Lattice LCMXO3LF-210 reports 0x612BC043.
> > + */
> > +static ssize_t
> > +cpld_device_id_show(struct device *dev, struct device_attribute *attr,
> > +                 char *buf)
> > +{
> > +     struct ptp_ocp *bp =3D dev_get_drvdata(dev);
> > +     u8 data[4];
> > +     u32 id =3D 0;
> > +     int ret;
> > +
> > +     mutex_lock(&bp->cpld_lock);
> > +     ret =3D adva_x1_mblaze_acquire(bp);
> > +     if (ret)
> > +             goto out;
> > +     ret =3D adva_x1_mux_select(bp, ADVA_MUX_CHANNEL);
> > +     if (ret)
> > +             goto release;
> > +     ret =3D adva_x1_cpld_cmd_read(bp, CPLD_CMD_READ_ID, data, 4);
> > +     if (!ret)
> > +             id =3D ((u32)data[0] << 24) | ((u32)data[1] << 16) |
> > +                  ((u32)data[2] <<  8) |  (u32)data[3];
>
> why is this code not changed to be32_to_cpu()?
>
> > +     adva_x1_mux_select(bp, -1);
> > +release:
> > +     adva_x1_mblaze_release(bp);
> > +out:
> > +     mutex_unlock(&bp->cpld_lock);
> > +     return ret ? ret : sysfs_emit(buf, "0x%08x\n", id);
> > +}
> > +static DEVICE_ATTR_RO(cpld_device_id);
> > +
> > +/*
> > + * cpld_status - show the status register of the TAP CPLD.
> > + *
> > + * Returns a human-readable string: "done=3D<0|1> busy=3D<0|1> failed=
=3D<0|1>\n"
> > + */
> > +static ssize_t
> > +cpld_status_show(struct device *dev, struct device_attribute *attr,
> > +              char *buf)
> > +{
> > +     struct ptp_ocp *bp =3D dev_get_drvdata(dev);
> > +     u32 st =3D 0;
> > +     int ret;
> > +
> > +     mutex_lock(&bp->cpld_lock);
> > +     ret =3D adva_x1_mblaze_acquire(bp);
> > +     if (ret)
> > +             goto out;
> > +     ret =3D adva_x1_mux_select(bp, ADVA_MUX_CHANNEL);
> > +     if (ret)
> > +             goto release;
> > +     ret =3D adva_x1_cpld_read_status(bp, &st);
> > +     adva_x1_mux_select(bp, -1);
> > +release:
> > +     adva_x1_mblaze_release(bp);
> > +out:
> > +     mutex_unlock(&bp->cpld_lock);
> > +     return ret ? ret : sysfs_emit(buf, "done=3D%u busy=3D%u failed=3D=
%u\n",
> > +                                   !!(st & CPLD_STATUS_DONE),
> > +                                   !!(st & CPLD_STATUS_BUSY),
> > +                                   !!(st & CPLD_STATUS_FAILED));
> > +}
> > +static DEVICE_ATTR_RO(cpld_status);
> > +
> > +/*
> > + * adva_x1 CPLD firmware-upload callbacks.
> > + *
> > + * The kernel firmware-upload subsystem (CONFIG_FW_UPLOAD) exposes:
> > + *   /sys/class/firmware/adva-cpld/{data,loading,status,error,...}
> > + * Userspace writes the raw binary page data directly =E2=80=94 no /li=
b/firmware/
> > + * staging file is needed.
> > + *
> > + * Callback sequence driven by the framework:
> > + *   prepare()      - validate size, acquire bus, enable config, erase=
 flash
> > + *   write()        - program one 16-byte page per call
> > + *   poll_complete()- set DONE, REFRESH, wait for CPLD to reboot
> > + *   cancel()       - set flag; checked at the start of each callback
> > + *   cleanup()      - release bus resources (called on success or fail=
ure)
> > + */
> > +static enum fw_upload_err
> > +adva_cpld_prepare(struct fw_upload *fwl, const u8 *data, u32 size)
> > +{
> > +     struct ptp_ocp *bp =3D fwl->dd_handle;
> > +     const u8 en_args[2]  =3D { 0x08, 0x00 };
> > +     const u8 era_args[3] =3D { 0x04, 0x00, 0x00 }; /* cfg sector only=
 */
> > +     const u8 zero3[3]    =3D { 0 };
> > +     const u8 dis_args[2] =3D { 0x00, 0x00 };
>
> this constants can be made static, no need to re-init stack on every
> call
>
> > +     enum fw_upload_err ret =3D FW_UPLOAD_ERR_NONE;
> > +
> > +     if (!size || size % CPLD_PAGE_SIZE)
> > +             return FW_UPLOAD_ERR_INVALID_SIZE;
> > +
> > +     bp->cpld_cancel         =3D false;
> > +     bp->cpld_in_config_mode =3D false;
> > +
> > +     mutex_lock(&bp->cpld_lock);
> > +
> > +     if (adva_x1_mblaze_acquire(bp)) {
> > +             ret =3D FW_UPLOAD_ERR_TIMEOUT;
> > +             goto err_unlock;
> > +     }
> > +
> > +     if (adva_x1_mux_select(bp, ADVA_MUX_CHANNEL)) {
> > +             ret =3D FW_UPLOAD_ERR_HW_ERROR;
> > +             goto err_release;
> > +     }
> > +
> > +     if (adva_x1_cpld_write(bp, CPLD_CMD_EN_CFG_TP, en_args, 2) ||
> > +         adva_x1_cpld_wait_ready(bp, 5000)) {
> > +             ret =3D FW_UPLOAD_ERR_HW_ERROR;
> > +             goto err_deselect;
> > +     }
> > +     bp->cpld_in_config_mode =3D true;
> > +
> > +     if (bp->cpld_cancel) {
> > +             ret =3D FW_UPLOAD_ERR_CANCELED;
> > +             goto err_deselect;
> > +     }
> > +
> > +     if (adva_x1_cpld_write(bp, CPLD_CMD_ERASE, era_args, 3) ||
> > +         adva_x1_cpld_wait_ready(bp, 15000)) {
> > +             ret =3D FW_UPLOAD_ERR_HW_ERROR;
> > +             goto err_deselect;
> > +     }
> > +
> > +     if (bp->cpld_cancel) {
> > +             ret =3D FW_UPLOAD_ERR_CANCELED;
> > +             goto err_deselect;
>
> it looks like a duplicate of check, or do you expect something to change
> cpld_cancel during writes?
>
>
Yes, cpld_cancel can change asynchronously.
The first check is after entering configuration mode, while the second
one is after the erase operation,
which can take up to 15s (adva_x1_cpld_wait_ready(bp, 15000)).
A cancellation request may arrive during that wait, so the second
check is intentional rather than a duplicate.
