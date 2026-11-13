Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564378;
	b=D7r1dD7F7sbazuiE7vWr1pQfT7CpR0nTH+tdtyokgmsUY55vFxho+BeSEV/SqFfCxonu
	 XFBzD0ZxBTDCELQyEtDDGzvT/7mR6fCCOiazHYe5pVnfVNh6GtFBN/33xqH86byIntP26
	 OvYQB4W0+GhEBwHZSPa3qWbXb1Fvc4az/jMGlkKy6go7NjSdBF7T1QyM4+NU+PVBT9Y3j
	 zpPl2Cam5XTXxBYdcTAvey1mCI+o/pjIgyZCP+H2gTXbwte/iWcU16StVr7je9/glsjri
	 Efbe+eyuPbZlWnkREeNBxniMZL/EVxYyGk+vdo7mZ9foljGLjedFXRbLt+QdikRi9nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=oBVCWZMOabVq55k67Q8GIm9NBAOJHOxllLRlvncSbis=;
	b=woo5mKcZu3/1JydigbSMkl7QZ5aZgvhBUIDSKJnZakrKPtO+4sme5MUCNnAqASYb1r47
	 KcJFKVl0j/D+tX9nUyOsF4QL1oUPiVXhZ3rJE4sC9rRfMmlLsCeEzy2byJovk7YvHbSnv
	 cS+h4d9kQPPMMXUdh4Aoo5j+om1TMslu8lh5v2c5ao2Qnxi+trAJ9gIkDII3lFIuy/EpB
	 I3NDdmgDkCplnsQF1UGPrgL2PXToiXvPyNepnla1t+8ywbwUNIxuzCSnOs5gy8kwdEYNl
	 ljuM18DWO6pwcXoCsDX4Ay37P5bp3UYQQoVhFIsEknajak9Mvwpd71yBjpmqieRzFFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WDdVkHgl;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB355606A8B7
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB355606A8B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WDdVkHgl
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b56221d361so1538898a12.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564376; x=1795169176; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oBVCWZMOabVq55k67Q8GIm9NBAOJHOxllLRlvncSbis=;
        b=WDdVkHgloKbBDmiudlEZ3ZWe+zg0BVZ0Jxwgdy+X6nc8ZJ9FIVi7F/SYJVqBRxNf3G
         3Gnq29xgDZdSKYiYaDVmU8W0xCuGm4Eu82rb/A8U6D5iLEOgHTmlDog4vSfdCU82B9rm
         qMGycG7Kl4j8h61zt+kqUkohzwqy0DPARMdjq2hKw51hdb6jylA1cwqwSD8nreSBsEB9
         DkDXk5ueYK99P4pH+jY8EwMoZnNW6BehoecLG+1JSq6wWJXsZMYgAdKGybKKFJkxuO0p
         O8Ri4u2My3QdIqEe8fwKAquZP0382+IuLTCd4KpBNa7znuGAHwPb5rxafjOggGTtG7Td
         r9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564376; x=1795169176;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oBVCWZMOabVq55k67Q8GIm9NBAOJHOxllLRlvncSbis=;
        b=yYoYW+cGHd1WTfc6Cp2f67T/81hXAovYQMWr0v++rGbuvPNnSrFafKwaYZPgTve6SF
         lnfjNWUqTaUaaCnFv/2lep8qOt6RuoaaSB6SxaRjhZKutQhzH4+o9Dzi/0NaQI0cOsw+
         0hciXec/3V9NlBcJP/9P+hXEJrYlc8j8YCEcDD4dyxahpxUcU4IfEOmGk/Ye8FJVGGOf
         v0Bp+okyOvEOa8UCIyv3pAWQUo2m05t4z9pEOEhiqAFV3Hd15BA00AbdSeMOvzMB5prc
         ScV1hgCot+Poe1ZFlx9xgvmUQRlM+5XPc9lK5d/cs4gkgD59UyonAWedOqZ2A1x+n9RT
         c7qw==
X-Forwarded-Encrypted: i=1; AL+hErHGAl8QS0lyROx7VwerQsX2V848YccVMMjRl5u83qD+Zfh3W/IhIoSbrzmXBt4sohD91mOtk2c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Oqv8dogEwAw9dDTWcj12NYBKAB5gzl1WXkUWRffB1xF5H4CGW
	Lqa6jeuD6wOTxu/5wZLEX9kuDcNIp1bVFnZ0NA2U/GhHJhk51O3ghKjCb5a5FSXizq62
X-Gm-Gg: AYBFou0XPVoaRQM8u7WsdATKGBszOxDt0V/L1CUUNBYxsz3QelD4w+fF4nm4I3SLA5k
	9OjRZoK79u/36Lti15Ans4x79mGgUlh0/XonlxwvjCsWotxzrHmLLSPRUDo3rzCCtO+fmTLbTu4
	J6pwuMHlMTyASJlhAUTV81lEFhd/JOM0b126iWsasCRt3EayPvgS3nWj4LYeQX6YacNTvPrYWZ+
	ZLWkKrzTB8ODaiz9wF+flAeJAv3wWUTP94Nf2bK4BY6mqpwTZpAKe4nOQMpo1AcqpTsGw0E+XkR
	hk3Kg+A0fWJcn0yhNJ1ihIBZAa4PmxDhxn9F5TG9qzO8bzfgvgZSTg8BJ33tviLe1TkaejlNn3s
	Qm86Cnd9wGprLXH2ze2Zfd09pT8iqm+JIU5NpFrsTWZTPXjDc3NxJEZOMMyBHwqeShU5Hr8qvK+
	whMXRnv6BruSwefejnRx6HuhGm405FFA1EGSBkBHm5nlDIIBoSGpah6Khe++0GZAaWCtdzUWch3
	I++f/1onxQjYo0xV8M97BW07stVQtGKls0O2yvQuNU7tOblmUPcQCRm/092bw93SJNAXygU31Sa
	h7inOiUIO1Lx7ga/QDEzCmO+iFzy/IQkFIZ+tB7fgJhXiUOJ9sFzAqz/CM/xEq8=
X-Received: by 2002:a05:6402:280d:b0:6b6:4dcd:967e with SMTP id 4fb4d7f45d1cf-6b7c0bbc394mr1685420a12.20.1794564376161;
        Fri, 13 Nov 2026 02:06:16 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c21b1b5asm706711a12.4.2026.11.13.02.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:06:15 -0800 (PST)
Message-ID: <4dfa19dd41ec1a202182284d9617926a259288a7.camel@amutable.com>
Subject: Re: [PATCH RFC 16/41] configfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:06:14 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-16-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-16-4c998976c6c7@kernel.org>
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
> Initialize configfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. configfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/configfs/mount.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
> index d8cac1cbf3bd..60ba24e7ae2b 100644
> --- a/fs/configfs/mount.c
> +++ b/fs/configfs/mount.c
> @@ -13,6 +13,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/slab.h>
> @@ -106,6 +107,7 @@ static const struct fs_context_operations
> configfs_context_ops =3D {
> =C2=A0
> =C2=A0static int configfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &configfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
