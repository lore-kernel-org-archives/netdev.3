Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797383F8717
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745853; cv=pass; b=qmrt/clq8nvz0SL9qTRmMRxRZT6xH5lpxX0qzS+z4aOwd3+iSvYulsPJ4PpZbBUFL3QZlnnUmjx4JU1P0pgr8HYBx94m+pbk6bghPTD8ZEcMsopo0Z3qXbO1kb4U+4EC7YYB+hXzeaVhsPmXOd3T4oPzf2gvMUZPABJSUyrHwqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745853; c=relaxed/simple;
	bh=g8fXetp79t4fnV4qXsoKx7uhaXURFpvOU26/CCLUaH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCzmiM181nPZAtCrG8M7+36AFR9NxMN+Cvg2ymzREh8TKL985JPSR2WH+r4RPKBlYgWt6kpUjdz/KKT7JfS4SRU/oZP+1dTyqALK6kkAGhdDJapmLsVYequAU7RO5aDi7Pc57l19enYlaA/TQFAqnb9raGag4FkxcHxLn+xAz80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NxV+PgTr; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NxV+PgTr"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-52d590ce5cdso7065991cf.1
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 05:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787745848; cv=none;
        d=google.com; s=arc-20260327;
        b=H/6xmwYE1br2itlhymK405MxFiN9moJF7686P5LvATE4feE0ggpR3CYUwOa7ME/SBw
         ZZhIyx+EQ5DItD0LvBoqflDY4V8QiNrgfGizptMXiCCvBD5rwJeKBMwQGmb4PkQHWGXs
         itvsVvnyQiurcM8S5m7x0bFmqhk3tCXT0CWu/3O9Th9WtdizsHli2MkvabkIQULLimNi
         7c1XLPPnJeQnqfe66DZu52PdSAraQX8z6+vDCW8Pfiu4ZSIOfXDPxx9bANxu0EnGJ9Kv
         bhqI3v/PvSfrtI/Q2+vHDY5WG7A9ufx80sg9V9i71fNqLy8ZD2LZRUyj17dIS3+cQrG8
         IBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U4Ml/4zqqR/5ynL7idVVkN6ePtxJ3l/mCBkMjrk+5rA=;
        fh=AHn+PwipwV9s0NZ0v79f/OWHq3iWPSq0NDwBQ3GA6vM=;
        b=QFB6SfgU+JNxMbk+GwHMPtvs3lYLIMUFWnCHcaMpVOYHTLcrndio4kIUJBj8F62HPZ
         S+0I9CjUSWtOqrQf7m2xWTfHmyJQ+qZjeXapa9iGyP+vyyXeRkYDODzoNIPr3A4U/IWu
         nhhxdxtm8J07Na/jy9pQ/Eo0+hKi3xAHgPBYC+p8VBuTCSbjSZn16SkFPRR//AO2WudT
         qVLrKS2mxnikEZKdV9KB3DUCrXjr+nWnHcUFY+pEcfJWSieH2cCPRDmYqX4Bs4gHv4H+
         kKpAIZiavQ5b+FxmvZzmoM8QpGe8Qy5khIb0HgaXxoIPJxJqu/c8DGngCzzR0YlITquX
         X5nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787745848; x=1788350648; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U4Ml/4zqqR/5ynL7idVVkN6ePtxJ3l/mCBkMjrk+5rA=;
        b=NxV+PgTr4uh+OLqXSxG3hzExU0HKKfbXJHSusn4x9XiphqHFej0a+o/7r7e8kxW0U7
         JUvwx0zKLTKujOpZy2oZ2CKoGibwyftDM1bAR/1/ZEboRATo92XM73c98NzRcfT4z6Vq
         EmpO+JBCY9XpDuPlSXCtqANROqrz1vSNoMgRQBydA8zmmlk6bkUHnIQ2xU+XI4hqjk1Z
         WSFurDjBVIebFeti6zpQT5R7hUOtvKtOUeRKfPjxjnVWHXwvk6LdJ+oto95IRApu9Etv
         jPx5ZPOR5ECl5wP9CO4bebdAcz8+du746H5AZ4tSelCNFKgveg3ZHbPZlF6k9v+hOyl8
         cIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787745848; x=1788350648;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U4Ml/4zqqR/5ynL7idVVkN6ePtxJ3l/mCBkMjrk+5rA=;
        b=Esr7JagDuth83qhaB1kIRe4zPV7Zq7RzZZD7+XrLwGdwtcYD61pat50dGmbhvjb3md
         hN2sBgIOY7/GDFD1W/EibqF++M8UqOm8Y/QK/f4h6pwFALPPci0x5nAxzNcj3KxRXz8U
         os6geKwHgZ46shQG4riAaV6D8DM2wxwIOt+EIQmXebFF5LvEAu5vAPN8DD/t/4aBBGt+
         Bu7ZbaSYv3ONH8RoNjXuimmCUUqEVUg3YFvktsUl7LhnY47PMftzd7neRSr+B0Be8gxa
         TGpOCCoo1OU0in4sfKOQq28b9N38zlMSkCk4SH4ORLVUcVzbVGhfveBSvjAx2OwEtnTz
         0u7g==
X-Forwarded-Encrypted: i=1; AHgh+Rqnl9X4LKAGalvbC7LllhfWOLDW4WKM+55o6tkxRxhY6X03aQYjxWu4MqUruqv3gLBcQiTvcOU=@vger.kernel.org
X-Gm-Message-State: AFuF++loml4E/BFtAi2YWQROayJVisbeLtvMTrWnbpsZzh3FyZ29Tpcf
	CzTFQS5DDQsn0YRnLLbb97XhsS+yE+xYM5ven3WIVrZZnsMQ6skfj2rSacUr6xOxiF3VxqJHSoQ
	yzKADLFnVwPAbeQ7LJUG8zhvAZf3uLkCDNfPMIyzx
X-Gm-Gg: AR+sD10X0+7rVrQJxa0rjaRh11gZo4iiviYBYKbcauI2qr7buRNzgDHWgevyjZj7L3m
	5PwWi02mjxOLtH92oaFcTegCvX/ZykcXu2JyyrinFz/veETen+jDQLyzP0K2LyutwTbi3MZj7Xu
	RDrdqlbePX/tJtZ2lI7z3oVC4VOvFcBtJOEfTZMFwCS2V46H3OzrMLG2NQAGKycu74qdR7vUf9Y
	pL+4HasPhXZHyVqju7Kvll5QSCVGgBUcj+zOBn/UnGI3D5oL++TLyMeJSXxSXjQOOTBXu7osbJB
	uB4pXkJiw3qDWwl2HNyIiVL0w08Pgwmd/s2aVRwgAbMkBDh5gSuWpwqbSUGvkMLnNgpiz3AxAtp
	4sNMD19f8/HVVmo1JWPEup3ebpd1pyGZN0xyCpH2EEcYfWB0xxxHkeD8hZtEg
X-Received: by 2002:ac8:5cce:0:b0:52e:1e8:220c with SMTP id
 d75a77b69052e-52e423233damr63458161cf.24.1787745847393; Wed, 26 Aug 2026
 05:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824024620.23485-1-kartikey406@gmail.com> <20260826115927.343690-1-horms@kernel.org>
In-Reply-To: <20260826115927.343690-1-horms@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 14:03:55 +0200
X-Gm-Features: AcwNN1X1NWLfviWvaIZ02Nce-Jxqq2P_zMbYHwbvhyxjoUZX5Ya6rksSLZPWcPA
Message-ID: <CANn89iKr74KHmdbzCmx70NmgFgX=Wd9nR4rYNxyVuenLRz2q7g@mail.gmail.com>
Subject: Re: [PATCH] net: atm: fix shift-out-of-bounds in __vcc_connect()
To: Simon Horman <horms@kernel.org>
Cc: kartikey406@gmail.com, 3chas3@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, linux-atm-general@lists.sourceforge.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+6665d3db5fef15914802@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 1:59=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260=
824024620.23485-1-kartikey406@gmail.com?part=3D1
> ---
> net: atm: fix shift-out-of-bounds in __vcc_connect()
>
> __vcc_connect() used dev->ci_range.vpi_bits and vci_bits directly as shif=
t
> amounts, which is a negative shift when those fields still hold the
> ATM_CI_MAX (-1) sentinel.  The patch skips the VPI/VCI range check
> entirely when either field equals ATM_CI_MAX.
>
> Closes: https://syzkaller.appspot.com/bug?extid=3D6665d3db5fef15914802

A simpler fix would be something like

   usb: atm: usbatm: fix invalid ci_range initialization

    syzbot reported a shift-out-of-bounds in __vcc_connect():

     UBSAN: shift-out-of-bounds in net/atm/common.c:382:32
     shift exponent -1 is negative
     CPU: 0 UID: 0 PID: 5987 Comm: syz.0.18 Not tainted syzkaller #0
PREEMPT(full)
     Hardware name: Google Google Compute Engine/Google Compute
Engine, BIOS Google 08/05/2026
     Call Trace:
      <TASK>
      dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
      ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
      __ubsan_handle_shift_out_of_bounds+0x36d/0x400 lib/ubsan.c:494
      __vcc_connect+0x14b4/0x19c0 net/atm/common.c:382
      vcc_connect+0x328/0x8f0 net/atm/common.c:498
      pvc_bind+0x272/0x380 net/atm/pvc.c:52
      __sys_bind+0x2e3/0x410 net/socket.c:1976
      __x64_sys_bind+0x7a/0x90 net/socket.c:1979
      ...

    ATM device ci_range fields (vpi_bits and vci_bits) represent the number
    of bits supported for VPI and VCI addressing on the device.
    net/atm/common.c directly uses these fields as bit shift counts:
      vpi >> dev->ci_range.vpi_bits
      vci >> dev->ci_range.vci_bits
      1 << vcc->dev->ci_range.vpi_bits
      1 << vcc->dev->ci_range.vci_bits

    usbatm_atm_init() sets ci_range.vpi_bits and ci_range.vci_bits to
    ATM_CI_MAX (-1), which was defined in <uapi/linux/atmdev.h> as a sentin=
el
    value for user-space ATM_SETCIRANGE requests, not as a valid bit count.
    Shifting by -1 is undefined behavior and triggers UBSAN warnings.

    ATM UNI cell headers allow up to 8 bits for VPI (0..255) and 16 bits
    for VCI (0..65535).
    Initialize vpi_bits to 8 and vci_bits to 16, as done by solos-pci.

 ...


diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
index 9600e1ec099304e465dddb00c36817339f538b3b..7b0c791399eaac9ebe00541a2c4=
1d715f465a24f
100644
--- a/drivers/usb/atm/usbatm.c
+++ b/drivers/usb/atm/usbatm.c
@@ -917,8 +917,8 @@ static int usbatm_atm_init(struct usbatm_data *instance=
)

        instance->atm_dev =3D atm_dev;

-       atm_dev->ci_range.vpi_bits =3D ATM_CI_MAX;
-       atm_dev->ci_range.vci_bits =3D ATM_CI_MAX;
+       atm_dev->ci_range.vpi_bits =3D 8;
+       atm_dev->ci_range.vci_bits =3D 16;
        atm_dev->signal =3D ATM_PHY_SIG_UNKNOWN;

        /* temp init ATM device, set to 128kbit */
