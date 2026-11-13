Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564841;
	b=Y0zsU4RflHy0Ci6WH8eiuWCMoedbPKPP2RtwwaP4YStZl3DiPAOo65CBhr37xEDXz/J9
	 Hx+a9TaS98XRBY3AsNrK+6K0ooK7rR/DatgKGv5Sjl0CH5MqxUfJwLKdAW02o4PpvxwVT
	 PepNpJsrIECvx6B7mELWb7i9wThklZTenAQRuBjVvkBw3MIpQjkMDKqrpJNlPL1MjIXff
	 XIyQ6SSUBJJeg120iXAx4RbuoVj9V34Db6vuxuJQeGcRtkl+tzJaJDzPEcVU9iD0HS21B
	 dKTYU/dEmpASq156rOeU1+cLfMdcjbuGGltEmLDeiXlQeOyF6fVEUeErQgexH039ZFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=LWRhkHq/o14g3eGvU8PB/2eVsiZ8AcgjQiitoPu4Uko=;
	b=RydPIo3pqHr4wew2oI1CIZL7UWtatwOWlHUZqfW0PoFEa1NlvBufEF7mz43xvOy3yGOq
	 p48nZS9MRHIfWYNMixRE9pf+ksKrVi7Na8Oj5K1qnXABxxIVmx+bTBLwfr9p7ICCG6QCU
	 3hN9/RV+MBnBfr1njYjkJd7pVjpC1O+bW90EBFy3Ne3gdcQhR35ucJH2aKM5Hg49Rxt8y
	 +CXdOTVAA6CXtdseX3J3gURsyws717ntFYYBfG8wLNennDFeZJKGRW5NbgUtODtUocjN4
	 nyP6lRF0mDI98ZqOxG4aImnsRflqSaClkXgbmgA4MkfUnq/8l1XRxtJqbRlEHubDIkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fgkfOyvU;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE02606A8AF
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FE02606A8AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fgkfOyvU
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48dee593f18so1055766f8f.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564839; x=1795169639; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LWRhkHq/o14g3eGvU8PB/2eVsiZ8AcgjQiitoPu4Uko=;
        b=fgkfOyvUu8xf6W8q9zChbNscxyQBBGlOoHgKBKJ1BkQkWvPVGihrF+rRK/++Rh9GyG
         JHspcfYOBNPixo8oPKNP4HMqn4Pm5ECxNu6WadiPSEV1Ef7s5pMOTmdpp1h0qheNYCAL
         reGCPjjBuRkeLgJtvMnJj51efD/XBAnW7OBUZupe3DEOpiY9mIzToOLvbGpl9PZAiITD
         ja/hKOWfLJ2HwVqW5WbU5vpLe4u/8sEd47rKsdelsOgJDSYM8eMKS9Bg+p1Lcupp+2o7
         A8nYundFQzH4qm98PvOkGZvKdsA4h3jxn0f8A/jmsMNUP8nMz4irJ6DT1xabl6IkGIEw
         iw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564839; x=1795169639;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LWRhkHq/o14g3eGvU8PB/2eVsiZ8AcgjQiitoPu4Uko=;
        b=m9OIXAumZqX3+ZqYoBC6R2sZqEvUUfdIQkBm+676DGTbdZCU26GuU1xqdu15LQjd6K
         ISFCXapJEuQsIyaOY/ewNzUiHUmkrI6FfKKRxsUBzdiEduuMoemK2BtcJpxgExPbcIbU
         EfgITXeec8lIKv2eD2V64IuyMaHQZsANoqgaXKUczrpKGTBgAo7j66E3Iivakbuu3pw/
         yifJYgjeB9gGIbfsC76uROc/UAQmRF41JGKwh5lxQJB7cDCrevh3wbXsbr/gcfgRN/XU
         /SVl1C50m7DJsAYRN8DcA4EEs3NijyxGyS0sG9pO8ijrqHjDDjO4wC1AJNCZf/L5WJQ/
         ruBA==
X-Forwarded-Encrypted: i=1; AL+hErG9Rjt9b2kkjbBuy6szEmMHHuLOzGSQp5jyBe2NXjGc6wGJ8dGvpRYWo0inb79t1hlHGmGJkBo=@vger.kernel.org
X-Gm-Message-State: APuU4Z98MTv8dRyQ/8RXquKR/Geqwz6WP47WtJhjKweWYs6rmO1R9rII
	UrjvIBSn6s4QKVstMPGUB6s2BX2Abts0EFpNpTs2EW1gCVAVYqUX6s6+zfxSldfiMogo
X-Gm-Gg: AYBFou0abzFiwp/IsnCpmPwwY45dd6JsnSygDXIzqW/ZtEPx3wbw+4xUpwdV/6Ed7hZ
	1G1UgPbPpFEwxzbE9MTnq4UG8V8ZbCoqE5GDYWMnenHlWGk+MyKF4fGqlgHZk4C9MvRdv6LgXHV
	GRFi0iyZLSUkEsUMDMnyDTaXcv6buvfrgr0qkBgSlTh00XMSi7Eb85HgGdfCQuRRnVU31k41rNU
	EoiPDvcGz7KTQDkf9afj9+xVW/T/2zfyFyBaoeOW6Z2YIDK2i5C0R6ZcSKnqrPrHFknMIUTCjsD
	syQ9+6YgDZY6DkF50ZGp/ZzXCkwOhr8nFWRyrb3XypZa7bSkHeL+DVKASSO1lEdzbFhVSVQR38R
	PKDmcGta1S281ijHMtcSH5dAWrKUOB4yJfiXrl45yNmh5u45nSRJoiNUGCFyj6oK8jtNGsQUGtZ
	8mIMaXraQtHIQi1SKL9JRibYLmE9t2rmx+BhSu+oHRqREPOhYB2ze25sUB2grGBEjYcBXQRR8cY
	E+oFCTHs7RMLm5TYn0+W+skAxRwXUOy/W22/G+TkpJRZ1fp1buJ4Epxq3wP9rpTjqmBAM8B07vo
	ZCPK1wL+Jw8QfyaFCjRqibeSk8XnGkh7xrH8b9QyjHsKm2lWjmUMRzXagRIsAbo=
X-Received: by 2002:a05:6000:993:b0:48f:bc59:ab9c with SMTP id ffacd0b85a97d-49c6fd932f0mr4358101f8f.12.1794564838578;
        Fri, 13 Nov 2026 02:13:58 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49d673ce75fsm190118f8f.55.2026.11.13.02.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:58 -0800 (PST)
Message-ID: <77855be3fb9f0e1888c6dddc56d73a1683c820f0.camel@amutable.com>
Subject: Re: [PATCH RFC 25/41] pstore: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:13:56 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-25-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-25-4c998976c6c7@kernel.org>
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
> Initialize pstore as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. pstore never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/pstore/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index cf499ba72702..4658561cf90b 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -18,6 +18,7 @@
> =C2=A0#include <linux/ramfs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/pstore.h>
> @@ -491,6 +492,7 @@ static int pstore_init_fs_context(struct
> fs_context *fc)
> =C2=A0	ctx->kmsg_bytes =3D kmsg_bytes;
> =C2=A0
> =C2=A0	fc->fs_private =3D ctx;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &pstore_context_ops;
> =C2=A0
> =C2=A0	return 0;
