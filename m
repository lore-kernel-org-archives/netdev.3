Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A8713D891
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 06:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786860186; cv=pass; b=M7DMeCW5MIdCvByZsujDGt/VOEaOUsVv8UaMN105cbVyiiPIp2vZomgI2iIDaqi2KOLsResBlYdxemfF1+jbR+OvSmigbpwcFeCGCgc+giCnp+TwFCNhQ8TrgtPOWLzvOmVX9P0mVrXd9WRumchW6Ul0FBXIpRI5PzgvyiC0qdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786860186; c=relaxed/simple;
	bh=fMqshKK4N9+kLimfhd3AaLyQDJKwvZfh/cEeDasbnH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLKGCWLgvgGGHMiWo8K7fngiyEcApVBixZulmYUewtBqEHPszJQx4v8ghy8ZnfTRc2xrZxc4d1igd6KfePwrlvTDk8PflCUrzQiGZ21VE6ysNawP8/Mtg9/YenS323OK6UOeyFKVPk1lwHAy1bbMLYuTFhAod5azlXZ78PSLa8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7M4Eygt; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7M4Eygt"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aebd52488cso2510532e87.2
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 23:03:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786860183; cv=none;
        d=google.com; s=arc-20260327;
        b=WksXbXMEf07T2K+GCDRyBb72NHwdAGmyW+Wpe0x1cZ3MmIaYKPrGi30LtuEOmmolb3
         HoN9rvFZL954f4hFEc839NegInLMoOdtj2pgeNGF0WrZNj9tiac4XJyQJvBsMoFzuId9
         P0KZSmo6Jwm48RksiQ/DXb/gpQdEM0ENtJeLM+z1Vrjt+G3s580hKreRmHXirqIrfh25
         4KzVFGYv5fDOlTICCevtybe6CErY4o/ASNQT0dFAJ+KGPAjTNBnzjGNkyN6n+pDP7Iu7
         1hfYsoXY8vIEjeVMlFJYwrCrgBroaGHzbN/A6ejXuQfLzZSbrjNBi1PMS5K4a8Eym+ph
         2+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7jRLj8ZdcWGdENRIS0xk6pRtOjjVqR8rCIRjuNpVn6M=;
        fh=78qpYm1lhK2bkjBxe/W7gqj2aIjHO8OZGPkSeAgeaXQ=;
        b=SfhUJ+2Pu4vgPDCMxbJPNp0vAqsQrlNUEWd0+DbCKnzYt3ZJMDbh1RPmgOOb4+f7GJ
         FAChzm95+2U7hJ89BOtrz1yxzzsPQNb7QYTd1MzIHY5uEfbmRQz0KisMdLJjtUGwkBDO
         ABga9SolMOKRvla/zVHWHg6VDVPrHA1Bo5EfrD1BJdVbQ9wD0pc1p3uCqkx6b/OAEvkK
         X3nWLONmZS7sIjI0uF9hf/GV7ta4Q80Pgbd+mqvgUjYDXYtuk6aq8XpmkwMyNhrj303f
         E9IsnZpNy9FHL/ZaKFnyCww9DywoREgq0w5OE5ijf6nW2eSR7KFCW0x6NSHIJ/Ra3anS
         Bi0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786860183; x=1787464983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7jRLj8ZdcWGdENRIS0xk6pRtOjjVqR8rCIRjuNpVn6M=;
        b=B7M4Eygt8Q0mtFg7cTZKbf9uDh+rgOq9njU3j9w+CVVpL55D0QeqI0YelYBR/MtARZ
         QIdr8M+Qt68DFN72z8puPopVBDbHSsr+bzBR2Ve4J/H1lRGwwxEQhotUEITE29Byhdu/
         wUtCB82zJB8/WaNQmcAPbTC0TR1Urrdi6JXPkahyw3QHR9USqCTKxbWrCJskU7p4SbDK
         WDIIDye9YRHCKcK0HbFC4gEHb+LIY2hIpVKOEvAc8AntiRRgl2f9xWbOuWtY9xICFpwr
         W3lKR7wTUZ4q2wUlSYLgC6uisGlty/kWop9bkVCTqfgZdq94czcbco1R4hX+jjGYK5V8
         Xqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786860183; x=1787464983;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7jRLj8ZdcWGdENRIS0xk6pRtOjjVqR8rCIRjuNpVn6M=;
        b=dK5/dYEwv1TJwJolMn1MqlD6DXktNXTFPvrQuG86ibaDqUTwt4WbOJajOCXyXiDYmp
         SBb6g0TRmZFQIvXIIqGyO8IToE2rLAFvcoLjOLV5XXvlLSK4vvGgKPe4RKuapaF73YPQ
         SbTYf/CEpyOLG3pmanggdu2zkIGlj7LewSlS+wZsFqP2VsCfJ/wgN5rmiLFVS24EG2Ce
         adyrCTKaZnnwSnUwgIXY1P6ixMkOB5TRu0Vpqmk3Z/KKFQeHSOy+3r3OtnRtTUP0vzbe
         eIeMom2xXMKIMjIqFB+eSgNH7l/sN4XG+Z+tbAhnwBocg2pkWCa7+nFhh3o50pn2DBe+
         v74Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr1shyvd0CNloRIQ0XKTdYG5Xu1r6ElDjaZdNQ26LAAlOwsE6ohjmh/JHTd42ejbnUXnu6ICcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkd0gGy3BG8/QOkRs5BfKIIIzqV3MIDCvml3Di7FppMSHB/xgL
	cK5ijywuP1FMgMmCmgjO0VpqrnWY/lq3LbiDP01jJDAS19cCYjH6MnJk3YNJ4iuZ16dMfGj7bju
	X8Unl/693EmXkiGWZDETZgqfNEeu3+f8=
X-Gm-Gg: AR+sD114L9bhI+v3wuONKbTZFiaiUAGXHzgyBjdgKeqSb7IdKupB3PX3F7FLn8Hr+ro
	BA5Kip+yO8v1sixpV4KqMmEe0EKFnBamlz8U4q4KyHqdRXrqloccz+Xh4o1/Y5Vujls5hAWYkx4
	HhAvHhUy7How3gkU8geMWPRj4wLklqCuxpWiEgS0fk94gjkOoodbwdL3R004tfJ4h8Ugs5oRH/L
	Gzg/xQAC2fL9sNWxRR45CDNj+2aRri0zSal+pBR7fbRPkhadYfMcCbMl5fp7H1F7PicXlYWh+bL
	GK+l2DHFdbm4bVyxNdrgT/QV3ixF/+xGuJfxq6S+ZFO1WT4fJ9v32w==
X-Received: by 2002:a05:6512:138c:b0:5b4:58ba:dcea with SMTP id
 2adb3069b0e04-5b459146dd2mr2799984e87.49.1786860182795; Sat, 15 Aug 2026
 23:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723143908.4019-1-maimon.sagi@gmail.com> <202608160048.0KcqzO98-lkp@intel.com>
In-Reply-To: <202608160048.0KcqzO98-lkp@intel.com>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Sun, 16 Aug 2026 09:02:37 +0300
X-Gm-Features: AcwNN1Upq7mcZbEwPOwlm_zt8_kPg-udjL_o5jbO8F9JkoVSJrXgl7UXIZBv2YA
Message-ID: <CAMuE1bE-a2EM70nx_6u-Tm5WskK8=afSdKbG9oH+csYpRzPdPA@mail.gmail.com>
Subject: Re: [PATCH v6] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
To: kernel test robot <lkp@intel.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev, 
	richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 1:54=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Sagi,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on net-next/main]
> [also build test WARNING on net/main linus/master v7.2-rc7 next-20260814]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Sagi-Maimon/ptp-oc=
p-add-CPLD-ISP-support-for-ADVA-TimeCard-X1/20260813-075719
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20260723143908.4019-1-maimon.sag=
i%40gmail.com
> patch subject: [PATCH v6] ptp: ocp: add CPLD ISP support for ADVA TimeCar=
d X1
> compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca79=
33e47d3a3451d81e72ac174dcb5aa28b59d1)
> docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
> reproduce: (https://download.01.org/0day-ci/archive/20260816/202608160048=
.0KcqzO98-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202608160048.0KcqzO98-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interfac=
e num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode is defined 2 times:=
 Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:364; Documentation/AB=
I/testing/sysfs-driver-hid-lenovo-go-s:234
>    WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interfac=
e num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index is defined 2 =
times: Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:373; Documentat=
ion/ABI/testing/sysfs-driver-hid-lenovo-go-s:243
>    WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interfac=
e num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled is defined=
 2 times: Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:636; Documen=
tation/ABI/testing/sysfs-driver-hid-lenovo-go-s:252
>    WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interfac=
e num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index is d=
efined 2 times: Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:645; D=
ocumentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:261
>    Documentation/ABI/testing/sysfs-timecard:14: ERROR: Unexpected indenta=
tion. [docutils]
> >> Documentation/ABI/testing/sysfs-timecard:14: WARNING: Block quote ends=
 without a blank line; unexpected unindent. [docutils]
>    Documentation/ABI/testing/sysfs-timecard:14: ERROR: Unexpected indenta=
tion. [docutils]
>    WARNING: ./block/blk-map.c:366 Excess function parameter 'op' descript=
ion in 'bio_copy_kern'
>    Documentation/driver-api/basics:42: ./kernel/time/time.c:370: WARNING:=
 Duplicate C declaration, also defined at driver-api/basics:436.
>    Declaration is '.. c:function:: unsigned int jiffies_to_msecs (const u=
nsigned long j)'. [duplicate_declaration.c]
>    Documentation/driver-api/basics:42: ./kernel/time/time.c:393: WARNING:=
 Duplicate C declaration, also defined at driver-api/basics:453.
>
>
> vim +14 Documentation/ABI/testing/sysfs-timecard
>
>   > 14  What:           /sys/class/timecard/ocpN/cpld_i2c_xfer
>     15  Date:           July 2026
>     16  Contact:        Sagi Maimon <sagi.maimon@adva.com>
>     17  Description:    (RW) Binary sysfs attribute providing a raw I2C p=
assthrough to
>     18                  the CPLD and I2C mux on ADVA x1 TAP boards.  Only=
 present on
>     19                  that board variant.
>     20
>     21                  Each write initiates one I2C transaction.  The wr=
ite payload
>     22                  must be exactly four header bytes followed by the=
 write data:
>     23
>     24                    Byte 0: slave address (only 0x40 and 0x74 are p=
ermitted)
>     25                    Byte 1: number of bytes to write (0..67)
>     26                    Byte 2: number of bytes to read back (0..20)
>     27                    Byte 3: flags
>     28                              bit 0 - suppress the repeated START b=
efore the
>     29                                      read segment (I2C_M_NOSTART);=
 only valid
>     30                                      when both write and read leng=
ths are
>     31                                      non-zero
>     32                    Bytes 4..: write data (write_len bytes)
>     33
>     34                  A subsequent read() returns:
>     35
>     36                    Byte 0: status (0 =3D success, positive errno o=
n error)
>     37                    Bytes 1..: read data (read_len bytes), present =
only when
>     38                               status is 0 and read_len > 0
>     39
>     40                  The write and read portions of the sysfs file sha=
re a single
>     41                  per-device response buffer protected by a mutex; =
a single
>     42                  open() / write() / read() sequence must be used t=
o avoid
>     43                  data races between concurrent users.
>     44
>     45                  Only slave addresses 0x40 (Lattice CPLD) and 0x74=
 (PCA9548
>     46                  I2C mux) are accepted; all others return EPERM.
>     47
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
This report is against v6 (20260723143908.4019-1-maimon.sagi@gmail.com).
The cpld_i2c_xfer attribute it flags was dropped after that revision; the
current posting is v11:

  https://lore.kernel.org/netdev/20260811135720.109580-1-maimon.sagi@gmail.=
com/

I checked v11's sysfs-timecard through the ABI parser and docutils - no
indentation warnings.
