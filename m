Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564657;
	b=0JwOGU93EW6vqA306OKdfTkdgwNPHST33bt27kOHB5RWJiOhSigVC8NQUiKA4VT57tk9
	 YCQ6DUcZRvFHnwsWokCLvUmE2BvnAHOCuJ7HVBrb4KbkWUOWWFf47fGgiypTPIzxNYw61
	 j1Op8zQ3ZWLU1xo39BOA00GboRkpkE2vv91cLOagG8I/I0CwZRD61O01x3qYT+azQBatc
	 HXV7NIGBhbS8In/oPMLl2zN4ML5JFR3412FViqFmCBe3UXzKbJqIZRLeJGKKIZGsmJ3I0
	 zKHlasXKQlOC+mQcSoKrssGogjw9MX99QbY8vbnyURRl+zWa8eT5gjqXaIPojO6Oixw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=;
	b=1/DyqvVaIl9Wr8HJ2DGR7je2TF4sURny7p8Ppz7DunbrGFqALLBHVnps6HxSyz2Y1L38
	 1II+Nt6Uqe4dBibTr3VqT2gac9YoyFVldm6IFjX95YfuTK473ZTOu6vUYXtJofxz693b7
	 SFKpSl98XxETrbYjHvFBrUiWVQ7PSXhq8R9+6ZDxIXJ6rv8v31+P0h3+IP//v4yst5rAX
	 ellfLaVxAO2ypRjdRwrkQAIjsHt9qJIDD1AtuCXkCp4n5KCjJ2dVPUSq253jdGoiD/A6K
	 0g3aBkHZjThNq7J4u1KYQ7ccFkpIKiWrnSE7Wu9rlepSWmn4YdlvZluk+r6/cAHOY5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=afSYRRYW;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16821606A331
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16821606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=afSYRRYW
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-490f38e9688so497692f8f.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564655; x=1795169455; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=;
        b=afSYRRYW0Lzg1RjNF5a8Z8fp4FTD8+wBAkqEEgX+uXVLN6iB/1Oe+S3s3pjBsHkfPy
         t+OYs+BeBV0n1jEyBb10NVx3dBSZolIBqoZV0sAqk1NmAyPkc8BtADcPrCcEDzdTW4+p
         zgkm0FzjpTOQt7I53MJB0zmRNwJ5JPK+9oiFhFL/qPiFq6x22bgZ8fSq9Se2ho9ikF+q
         rg0gx4TedCmdQu2h6zCkoXcFHWmQ+ZQsRVeKTv2sVCXhncyHGZ2k8DCVvoh7926dtvhd
         5w+l12l3Dd1UCqA4z70s6tomNhqNtGqcJuf3lRDB60cxVt/wNhZpOgzeegjchzcaCyfn
         tojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564655; x=1795169455;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=;
        b=GGR6aq2nM0si6gnx3uPflsqgT9k0WPqApqrGQhl6oOTeZn/WrPN++gmpVGlNakwA/p
         riFNVho/ugxiKbhRidx8ZJ7wHzKOLvi/e51IhUv4XjcI6q6JYvguGPNO/8ZIUNzs2D6p
         7X2XgvjJ9O4cWmEdYe3fEqgQhrlLyHMSEpZXyryUfuxC6pE9KU1XXRBFDhoXlRMdxUlH
         i9JXGbsG8K7qmQGoQAP1PExM/lE3PA21IM7xNtqHuMAoTSXCwQ+DjgjXLoas9rO7d1SN
         7d/oyCyC6R0NnlpmhaQFx9VFkgiPP0caTzFEoLRh0mhzRuv8RkydELHEJHe2Rtb9b4+G
         E1sg==
X-Forwarded-Encrypted: i=1; AL+hErGksNXtIo1GHpngdomxWsd1ZiDq1zf0aVSCnM5cDta4mST05X+/D0dssohSpDFhY8pHjZ4I9+8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dKek4y8aqKnsjYeORBAJUfRDKnmOP2G0xgsf99s6vH4o+v4H5
	KGQpF45bNL6YX12xIUQvPxO3ncCRBYmB8fcWHytFpq04jCMJKLGO9c2cBMBV8DFaU3dk
X-Gm-Gg: AYBFou0GIJp+wHnQLQZJTU9N+soCh3uoCVMA1zFc+aM0ltGyxo5otVRQMlH11Pdtr15
	v7podpe8cNxRwvC1nSdi065FeHaPJHzUISe6HAxmu2uW9i9APuubSQkg4LNrIIvCXuUAiE72dV3
	fiw4TZ4Qd+xASCmaoYtnJtwP6vDmFnmDtw38JtQci7eHH8o+5tL512Q5Kl75N+tz9YwdPZLPZj9
	fJC9v1yyGagWMJTirRIwNEMjrkGKTa+HPTQy7b2q2MyaIZwwPYonwnS3znj1rHo3xeP/hrqo3s5
	OmwYR0aT25plWN0pkTETky4aNGIPKwnKugByr9C+7khhsL4WdHjceQQubNxnBJm9jDNZcDejWiU
	v9ZLmWh3RGmiRe/X7M0xbIKfmVQe0hF1NEQwgqG5ibr43IM0at6mvL+d/v7Lq6GXxUZgaVjAgOG
	3fPKJnPCd9v4lVKuqJuUZNlM/nAml3UQMSZpQc0qNsKt4LhZYFjCq7yBre3w4Se/xdkQFU7xAOg
	JhU6HbGpD/n+JbZU96mHuBQVSjGEwonAglxF/ZQ5CDCpSp0TpINM32Qd76AnXrH0fPN0Aad6qoM
	XsMaXGKMga8RQmQjNtXmI3uYZQJVdSD6s4aoOQcdQx8Dh5+mroDGN07DNgvU438=
X-Received: by 2002:a05:6000:470e:b0:499:ffd4:f519 with SMTP id ffacd0b85a97d-49b02d4c2cfmr11662822f8f.23.1794564655454;
        Fri, 13 Nov 2026 02:10:55 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5a32d336sm4988050f8f.0.2026.11.13.02.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:10:55 -0800 (PST)
Message-ID: <0894c601b3f3c5b92008c6c399faaa539b658307.camel@amutable.com>
Subject: Re: [PATCH RFC 17/41] securityfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:10:52 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-17-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-17-4c998976c6c7@kernel.org>
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
> Initialize securityfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. securityfs never holds executables
> or
> device nodes.
>=20
> AppArmor puts a .null device node into securityfs but only ever opens
> it via dentry_open() which doesn't care about SB_I_NODEV.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/inode.c b/security/inode.c
> index 080402367674..93997a9f16fc 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -14,6 +14,7 @@
> =C2=A0#include <linux/kobject.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/init.h>
> @@ -64,6 +65,7 @@ static const struct fs_context_operations
> securityfs_context_ops =3D {
> =C2=A0
> =C2=A0static int securityfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &securityfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
