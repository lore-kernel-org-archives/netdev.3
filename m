Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0343BADA3
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791492224; cv=pass; b=m/xJKZdk9mZKXSHgKqro9L63j/k3rO28G0hQeZglQpE6gONjsA3ZAY+UpAf8y7kUHIvG0jhPZub9wTckfr0i+7cnH/WyeDVrOwlcneULfTyhLaw+MnWn1wOsUnQwujnb/2nsjo6TKm8c/34CVlmmbhV/q3mX2LMiqOf5zw7qj0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791492224; c=relaxed/simple;
	bh=DXPXIxtQSkMVS11dIJtcA6DG/ZgAjQoJ9mCCc1ZaObM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIqKTRwnDVQIlU+FiX6dPi33ZQjDA3mpSZchdEdoHrA8utilaojZBoQ67qx1iiPniZkKlM9MoTKoSm5Dp5YZgPPkden4N8pvwPVr2uaGcGKGSQ6UILtAXY3CwIsVuw/na+h8moTvfzq1E9lfvJSmrPItShCpSSaDk9OPzrAyH5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ATCVXH8m; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ATCVXH8m"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9828fee1b4bso866771241.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 13:43:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791492222; cv=none;
        d=google.com; s=arc-20260327;
        b=IpqPPo5osbG1Kc72kn/3LHnZGMARnBthE2OjmqmBQUnrlDwME3Hp3G+0ZHQE58gEtD
         s3Od9HbY/Q8Ztd+BRimqBCJ/IowHK/sPqTSiRPHoHvyVgPPHpdJzP1LHqeDxi1fS6Db5
         Dn7g7qK8ZUnOWZ1+RXWSZR9eU2eeCwzTh3cd597RypeRKY/FRYpr3zMx9OQsKKfFgEVJ
         isrD2jgNzz8NQ8ixfr/IHmgi1pjLLXf6+Cgen2P6neP7ujDziETST871kYJXcp6utelb
         WcvL0NVkxntjJiqX1Iz5foSKLgeVo+dA70enz04B0ApVUmOcjl8o+VkZ7cUXuS3A9XSj
         eYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A/W/PUrtn/Cc72CQ/8yShHdG2SRzclcrVf4wdHjhRnM=;
        fh=dHrCjU6oV6tLdXXhS8oUx6ffLi5dFTdyTofjXfI/Dcw=;
        b=DqNdSqzXwviTFBU7h/QYsmm5aiaced0pfbRME/IuHZVkNZiKLgAwsngqDck0QCj1sI
         7fQCydSpI5yWrJTtpK85SFEk3PsaJ4B5pcmoaKU3t/OS7Q8u9Dvw6DEw/2vxL7pqwazq
         eOvvMY/D7ZNl51Xv+4XB2laDUx0CyB+S4hUzsjYhS51YoenX2xyGGgamJoobVZxnTWtI
         jYIAUFEMcOc+7k21HobE8nfGMvlvuXsTA/tuiSanvVxjpgKU7U9wwziIzYfU0tEf159k
         H2PtoSgdFPMZxAwdmU5ZojHUGxOnH+53mC/mypw4XnZR0MCNlNveJEEZ3cZ5M5JByPGa
         9r+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791492222; x=1792097022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A/W/PUrtn/Cc72CQ/8yShHdG2SRzclcrVf4wdHjhRnM=;
        b=ATCVXH8mUHUUPC4rYmqcBMFW3PIqYfVrd87qLw7wuMLZyE+d6IupYLnXHQm1YC32NT
         WNd/VJaWh8ILfA+FUnY+XQS/e8K2IJuXcVTdPpW8o8TWsejLakLhOYys5lPtU5VM25tk
         Zy5c35eauMKawOT0/6YzGCUSVePz+Xvp3XNEhm438vuZssRviuD57PxOf53W9uAvpQsF
         b7wBxaOUW6TQbFlFIjTmPZArm1tID4ZPwr7Ka8i/xp/k5cUForZCTP8d/CW/WVlxlqyM
         Ds2ghyt6G5Bul6CBkI4BgRFzGOF5l/fShH6hgJz3OsaxxUdOgLCGKNwnZFH/Mgb6GIRU
         L1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791492222; x=1792097022;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A/W/PUrtn/Cc72CQ/8yShHdG2SRzclcrVf4wdHjhRnM=;
        b=FS481L/XzK+Tg2QXNr4oYu3Nm42Qzla2YNzycLI2zqfqJEM3J13GhOGUSLonGXuAeq
         70q40DddXcReekFQBqP7Y9J3dVVRcajLV51rxovdkfkP0v3w8p8pYmt6Tp/n+v5XFFyU
         sg8yvYGm4i2V0mDqQOYpP3oKLIj14knldb0+fDqZOhE2GTI/qbibkD2Yghaj7BafhytJ
         D3xT3mh6itz4mCu9179vG22ZhHJyAfJGaG6n25DGNSADHGn0HsFMfMQBkd9YfWGIQZnG
         ybwP8PUzkfJMprx9FxgdXagUJqxo177O9wfp6fSgxvEJpMvt2CkUuvGNBwhkqk+ZfgOO
         ZmbA==
X-Forwarded-Encrypted: i=1; AKwUvByMkWlv2NfMUDTpJ+xdvUDR10vs/3arbgBX0e2ethBI1eZCEAWSEqVRJxC+mDyuxka+/v0WyWA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMbAJnZ23BmuudxR3/w3qjYXddepVHZDhoa5+j3rN1jrqet7UF
	KpCqBqG9ZL0cIJyiCnr4Xf1ahP6gzCwm+VDRvBOcIN9BxmQO6/H1zdZfirY7A+M8kWjpzwzeuAk
	OlR1z4GRJsfBzjp+W7krup1zzWyBhBjK8FmnDTz+n
X-Gm-Gg: AYBFou0HBji4YiCpNL79GK7gCn3dI+DqOTKTsCtIr40uXSKjkW9p9bWI2S0GRxLaP2L
	ZQ7TeFsSULyXngCehuw4XrzEQBFQAhF/hsVmK/18XCNnmZ6e0/SSQfPdhTmsxI5imsXQLtG1eaN
	38eJ9CkBIylSwCkzZy9hgkymqRILCxzwc8Zg/icxo00dI7UaQ5Jnrpef4bAOuz9792r/XEMEvYR
	XQNQ4yl+icSUylLPCSo6EJT4USAgX38QzcPN9nY1IpNJmEMB06KL7O7lMYGFQxmvHBebySCOJms
	H2h314iXxSovHxIz66U4+EiGXku2iW8lhDLPrFvmATmfC1K+jXSLUFdp8K8SkNTTPH7L0mqsfAz
	wry37GIlt
X-Received: by 2002:a05:6102:5cca:b0:7ae:c2ca:8e1 with SMTP id
 ada2fe7eead31-7cb37282493mr11701137.11.1791492221308; Thu, 08 Oct 2026
 13:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008173334.2881475-1-brianvv@google.com> <07ee6c66-034d-4cea-bce9-91c63a1aea86@molgen.mpg.de>
In-Reply-To: <07ee6c66-034d-4cea-bce9-91c63a1aea86@molgen.mpg.de>
From: Brian Vazquez <brianvv@google.com>
Date: Thu, 8 Oct 2026 16:43:29 -0400
X-Gm-Features: AclHuK9aU2BVIj9HzCVTcUiFNvmt9s4B0i7YOub1a2UyUu9MFQ1Y8cPTxsttm2c
Message-ID: <CAMzD94QiYANH2e-jr2LDD3yv4ojcArterT69k0aMBP_iZxtzzA@mail.gmail.com>
Subject: Re: [iwl-net PATCH] idpf: wait for the reset completed state in idpf_check_reset_complete()
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>, 
	Joshua Hay <joshua.a.hay@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	linux-kernel@vger.kernel.org, David Decotigny <decot@google.com>, Li Li <boolli@google.com>, 
	Emil Tantilov <emil.s.tantilov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review, Paul.  I answered inline.

I will fold the spec reference, device and reproducer into v2 and
carry them forward.

the Reviewed-by tags.
On Thu, Oct 8, 2026 at 2:31=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de> =
wrote:
>
> Dear Brian,
>
>
> Thank you for your patch.
>
> Am 08.10.26 um 19:33 schrieb Brian Vazquez:
> > PFGEN_RSTAT[1:0] / VFGEN_RSTAT[1:0] (PFR_STATE / VFR_STATE) encode the
> > function reset progress as a 2-bit state, not a flag:
> >
> >    00b - reset in progress
> >    01b - reset completed, written by the control plane
> >    10b - function active, written by the control plane once the functio=
n
> >          has completed VIRTCHNL2_OP_VERSION
> >    11b - reserved
>
> For me it=E2=80=99d be helpful if you mentioned the datasheet.

The state encoding is in the public IDPF specification, "PF Reset
Status - PFGEN_RSTAT" [1]:

[1] https://github.com/oasis-tcs/idpf-specification/blob/main/idpf_specific=
ation.md
>
> > idpf_check_reset_complete() tests (reg_val & rstat_m) as a boolean, wit=
h
> > rstat_m =3D GENMASK(1, 0), so any non-zero state is taken as "completed=
",
> > although only 01b carries that meaning.
> >
> > That only works if hardware moves the field to 00b as soon as the reset
> > is triggered. On the devices tested it does not: PFSWR transitions
> > PFR_STATE to 00b only when the field currently reads 01b. When the
> > function is active (10b) the field keeps its value until the control
> > plane finishes the reset and writes 01b, which takes a few hundred
> > milliseconds.
>
> Please mention the device, so it=E2=80=99s easier to reproduce. Also, the
> command to trigger the reset.

Intel IPU E2100, 8086:1452. An FLR on an active PF is enough:

  # echo 1 > /sys/bus/pci/devices/0000:01:00.0/reset

  [  299.685030] idpf 0000:01:00.0: HW reset detected
  [  299.715710] idpf 0000:01:00.0: Device HW Reset initiated
  [  362.916087] idpf 0000:01:00.0: Device HW Reset initiated
  [  364.318246] eth0: (slave eth1): link status definitely up, ...

Nothing is logged during the 63 s; the VERSION timeout is silent on this pa=
th.

>
> > Consequently, on a hard reset of an active function
> > (IDPF_HR_FUNC_RESET) the first poll sees 10b, returns immediately, the
> > driver re-creates the mailbox and sends VIRTCHNL2_OP_VERSION while the
> > reset is still being processed. The control plane tears the mailbox
> > down underneath it, VERSION is never answered, and the driver sits in a
> > 60 second virtchnl timeout (-ETIME) before going through a second hard
> > reset which then succeeds.
> >
> > Make idpf_check_reset_complete() wait for the state to be exactly 01b.
> > This is the stricter reading of the register definition and it does not
> > depend on how the field got to its current value: functions that are
> > still in progress (00b) or active (10b) keep polling until the control
> > plane reports completion.
> >
> > Fixes: 8077c727561a ("idpf: add controlq init and reset checks")
> > Signed-off-by: Brian Vazquez <brianvv@google.com>
> > ---
> >   drivers/net/ethernet/intel/idpf/idpf.h     | 2 ++
> >   drivers/net/ethernet/intel/idpf/idpf_lib.c | 3 ++-
> >   2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ether=
net/intel/idpf/idpf.h
> > index 470bc23c844c..ce8a1bd0ec8b 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf.h
> > +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> > @@ -166,6 +166,8 @@ struct idpf_netdev_priv {
> >       spinlock_t stats_lock;
> >   };
> >
> > +#define IDPF_RSTAT_COMPLETE          0x01
> > +
> >   /**
> >    * struct idpf_reset_reg - Reset register offsets/masks
> >    * @rstat: Reset status register
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/e=
thernet/intel/idpf/idpf_lib.c
> > index 2c148377540c..a827e0fa67c8 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > @@ -1870,7 +1870,8 @@ static int idpf_check_reset_complete(struct idpf_=
adapter *adapter,
> >                * register for us yet and 0xFFFFFFFF is not a valid valu=
e for
> >                * the register, so treat that as invalid.
> >                */
> > -             if (reg_val !=3D 0xFFFFFFFF && (reg_val & reset_reg->rsta=
t_m))
> > +             if (reg_val !=3D 0xFFFFFFFF &&
> > +                 (reg_val & reset_reg->rstat_m) =3D=3D IDPF_RSTAT_COMP=
LETE)
> >                       return 0;
> >
> >               usleep_range(5000, 10000);
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul
