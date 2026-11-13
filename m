Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564338;
	b=WYOSzo1/xriYrs2+n9Zo6OgKPcc6b4o6JKa9/4R0Y/3/BkMbADAKOx5kbOJrf4s4p0D0
	 L+r04Jv9Z0TjROss3H/drkYnOCgw4wdynDq/i7E7i6AABmYJV4is9E9vk9NVRIjjBCocj
	 Aa99MYjNgC3ubdhqacMNEEDwVklIf3iIk59OGzBJDguhWY6R+rkCJx3djpxWQYFhOEDyW
	 /L/bDpXi7SE/G73OBBwRlUhqRQaD6hz3yohIzpz8qJsarsLz74NN29uBA6sRMW9ctRIHz
	 4QV+4tBQe47fKoUD+dNrvN4BeTlmSD5/S+v5YnT3Lv8HeuwjOU1f9UyPcddK8oLFn0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=/ZNAGjGCHSUHK/hbpNrctHFuArQcFUaSPHFuYTd8W2k=;
	b=bTemtyXn668GITY2QHTSqVq/1XRIkK0YVD6kCqS3COi/088lrFluBs1hGzJt01DMR+S2
	 1q7/Gd1uQy5+Qi4e3gZoraPzxM4JPJlLaxYfxTmyC4E2UGgbdyteMVIm8z/GLOErlxOUD
	 h9+Q9MmicCaX2B6Kv8iqJXlINncdaSZ9Ag5TT9wT0/QPSPawEI97UBlUdhOHd0FPWyEIp
	 w4yY97Y5CrmHrn5lnfPCReWGkpyVYUTsVOzsgmQEIfOJaeda/zVMwu8Xc/moH9I10rqMu
	 fd73cmZzFYqFv+mcaM+oYer07QQToedLfm/NwBTX5FXD/HhKtaVvti7+4NCezyZRgMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="BcN8/JZ3";
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76C8606B137
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E76C8606B137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BcN8/JZ3
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4322d310e7so190391366b.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564336; x=1795169136; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/ZNAGjGCHSUHK/hbpNrctHFuArQcFUaSPHFuYTd8W2k=;
        b=BcN8/JZ3o8G8RngOszXG3JTNOcmRF7Y5HhcgHfEFuj8bd59D6/ZB+k5Qh/rpeFRCcR
         ddACGgLLZgU5b3f6uROOjMlLzNHxLpnDWTvmFTIG7dNNkaJHDW07G6TO1gom3Rvc3G6a
         phj31A4a6/nEoCYWD8i1KXLteYhy5qLcfDwMY03tf9yOOPsaa+sC0St/LDVgowIEHsk0
         tZO/CMI2RrlSiK2F32OSWBbCdipxonxIIN0DBtho56nDsRF+fFDKa92VHmnJVt2oHACg
         qH7hz+1dQBsoiVIgFoQGohYiLAIIKP/PCGAm0hHsixZQutOWB167lk9DbkeNw+vQ2Hrh
         L2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564336; x=1795169136;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ZNAGjGCHSUHK/hbpNrctHFuArQcFUaSPHFuYTd8W2k=;
        b=Mc86raR4ebwd0Rt8aYLSjoJImLB73dm0FoKynr64tf7eXEr4TwFLLGUrB35n60FGW5
         3KWdohGYe+dDsryyawNcs2Tx8rK+9S4Qhd6KjCvNBCE7MmBTyDvOJqKfHL85I+puGXQc
         2WKHbg0zhuR062mQnPmN0rt1hA+0acCOx01HyvleAiquDTXrWzg8Xp/yGHtoi9eh1YTp
         BXxIaC3xo1gXrLOJbgff3FVsGxurwwEOK50kyiqcBT1mfHlCbuzgSOFZ4xDBXAOS3MBM
         +u6EfxgOd2XhIPetBlX0BMrS2HCY4Ld5DOs1zrVHk00RTEgz/9t/wWVEkQVCaAblfigy
         G+cw==
X-Forwarded-Encrypted: i=1; AL+hErGTFUub+bgt25ERCWMYsVUgeU10Yp5PllUBKl38mB1Ap536529G0hL3UzIuw8JX7C/6+rmPMgU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oCpsauSXJZ3bRTVJCdot30n4hCO71Sq4eH+vEcDX8zvMfPjcM
	VzocUf6z4Z3p3WVd6R6gW+B3A8fOs7sZnZq9P8nzEKEPI76y4N5zTTegZVoNuHwMfmgU
X-Gm-Gg: AYBFou303w2Hr6jkZpXNBasCQ5vArK8P73Z/aC4bL3fh5KApkjhn7ZX4eH6mSMK+rSM
	hdMcA99UjYfBp01b3+dfVgg8sQNGKEINRyM+khPEJ1+XlnoMqym2Fk7qjNo5LixxmwCtcksgMYF
	XHcYctpeWRLu+HAqaSv5IkBqnzdWahBbmu1Q9js2ElJNAth+SPYzQ6kl9HE5fwgwrJ7B87FODLB
	bHuO1r8My+HLmnLFxWnOnHKPdr6d4WHJypUp0UZaMCG8UvO08D+BXbLKC3+0VO3bQs9XIYlGIOZ
	Ad5SH7WPb4Kg64WZDg4zhYqeGRT7aHPsNAYa8hpMS8qfwSayWGp5WHhBKHmYBOgpBdd6GoREy95
	uXyDruG/aq3di5/kPwr6I+pvdVis16cyg2oosVCva+3JoWoCkNF7nwFSkF/D/vKqLt7arWS7T3P
	5HA7auDrVNTK/bB6W2szkJNTHr/ZmNq/Hq+ff++1nVdb3AyPMiAkSSXP+po90VclrDRxez8Bayq
	fvD3gE13TFLoC3x4H7pCe0YaA6RyV+4M3gZ8QiQI3lWx9nn4QDJHC3To/tnowvZgMo1ygaQqyBA
	28boLY+C0w1EBZulEga7EtRpsAo8mOKTdl5OhAuU7J5UnZfACPXXd8OdusCJShg=
X-Received: by 2002:a17:907:94cb:b0:c2e:3a72:ffbd with SMTP id a640c23a62f3a-c5096389759mr162937766b.41.1794564336347;
        Fri, 13 Nov 2026 02:05:36 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095a5b93csm75365566b.5.2026.11.13.02.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:05:35 -0800 (PST)
Message-ID: <8f532a01f6cc2eb73582864343e25be4ec990919.camel@amutable.com>
Subject: Re: [PATCH RFC 14/41] debugfs: use fc_init_pseudo()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:05:34 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-14-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-14-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize debugfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. debugfs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The debugfs files that
> can be mapped, kcov, relay channels and powernv's memtrace, map data.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/debugfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index b4915551ad31..f163f0bc5703 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/init.h>
> @@ -317,6 +318,7 @@ static int debugfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	fsi->mode =3D DEBUGFS_DEFAULT_MODE;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &debugfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
