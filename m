Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564809;
	b=ReEKbX2oNQWF+LY4GdJ/bTYfAz/ym6/oSTgKsKUuLCcdwLlLEUNg6ie5RbFgGPqt/YZf
	 hf/KwZfRXMVrueuQ+I507h6ny7B+njeKC+VoWsUhu83IULwFC5o/IYQrebVKzuHea5mGJ
	 nqELy+B17WHQ782E5PUmkjtflPlKCe+uNe3deMEe4BTvqKJ3xTwt2bfEAG2/UyhNg5Yen
	 qZch1QBNEaxiorgtzRCd+lXha95+TW+xBB7SHUtba5RnZkTKckYy6XB3r/jr8U3i0w/vb
	 1i2wexPDE9DuFlaILWH7JbWIs3DGlykP3qtEX273e7nnlhMI913c5m8491LgaPukx+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=UX3uQO58FXw3i2m3kzI3o8uINYIcsljrdUAfEKBly4o=;
	b=Un6AADTXtxdg/NvKMF/p1XhDF9ogPWnXxsGToIUHvYZ+sy8CudPLkC2bOgEiMV1qk21C
	 xcN4i9gaSwUc+AaWuYmRBQKtdsF3/YUcg7DJeChXWT8AMUWCY0cnMjw8TefstKHVnkhGt
	 1pywqfZPbLYPlUQoqFP70wRXyXYXHSdRl4JHI2WcN/g/es91idqnulRfbBhTn27FnFXPO
	 ZLVy/P1L9PHlqin01/LVaxYKQh5TyesQdJPbj8hPQCeWhhT+eGlHTd3G+FxA1vLW938F6
	 Zp6YYLUI4pRUVSgDPDfq5fe6UABcQoYJmfSEfIDCBA4K7HIVPrQNSgh9Khte5rO2irg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rqBNEWhe;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABB0606A896
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EABB0606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rqBNEWhe
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so13721145e9.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564806; x=1795169606; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UX3uQO58FXw3i2m3kzI3o8uINYIcsljrdUAfEKBly4o=;
        b=rqBNEWhefqtER2dpEJNVPTElbe19fVdkNyIzbVbNULqUnWk9JP4TtodfrAxZg35Ufq
         +ciPTMXXDC3Fn73QdDq1nxL10hoZ0LEMTSuk+HTluWLCH3mNQBpp5ecm/W/Lr1PQghIv
         NQThaRjLVubmwKFzY9W4H2pkvpw752j1vTd8XwcKuq70wsUgwzLrChjclsxLFe4j6CXh
         P2+zI4RYwkyiSmtYnxi7mmM5Yw0kfqLENKBervoD5JNkytp6QIULxp+qmuf3k5WOFN+d
         HC6ACfaHkSpUVoBZwd9XYoAangfmrtxV8FymQjjH9iY0qoozDauX1oxEdXhYxV5zTWYW
         c/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564806; x=1795169606;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UX3uQO58FXw3i2m3kzI3o8uINYIcsljrdUAfEKBly4o=;
        b=qLtYdIXM1PiFdlvHvArxuqDlEUyTERiJnh+udeGf/YTUsExyTzm5RHVxbkLkVfwgKz
         VkYUUOoCp7NbRy9B2oL6cTEpBeT0hXq8tSI/CmQQq0WIPcOxusJWmWaVxN0JphUniqtS
         HCtb43p651B+Ptiptx2KThrIOAZ0INz8kyE3G0WAtorRJvJ7NjQm3d3AGK52uhc7bBPw
         YmkOm9Vjn4hIn8a0zarC7mQtNKsiUtdFPS2daL7m/5k1fkRz0bzDVkH3r97hv7UFtluv
         x3sthRcWQ7vlQttKo0y7NtjwVNidS1GY3SEaeMbYePUZlOKOp/aaN8V/I1OjYuRvTzMe
         32kg==
X-Forwarded-Encrypted: i=1; AL+hErHziBXqeo40Ua7dp48QrzIYbqNEfkc9+9NdVyaXiv8aIk+gY5spgLa1XRDNhJ3zanKvqnJxNgs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wJqufSB193QMALze+XQxMNLQ+49kQXbqnXNEKxORKagyAjxTm
	qx//JmMuaSrIhvLdfGpQPQ1LV9RhI5+K1PgisjqD25xAkI2bisLSZQ7iCS336x57LTlx
X-Gm-Gg: AYBFou2sT+wlJKm676riHWwwcrEEkpNWJw2lSX0cLX4mgx89rpGBIW4MbxDAX04rmhu
	CTtMkd78inPbS7HxD8CRwKJnVO71OfCmqMHnkZVEM1Sgd4uwSsBDUAGnQ+S2FSfLfzyXzbIR18b
	qtFDyS5VKf5MOm7P3dG8xI5/I5klUtQXaWuDpRa4lnDOSZAtcKQvDOq6xhNZbCq8D6cBCdKSPxn
	Ixr4sOrhbYAOus5MaMxXxh8DTWZ4zB58YtECwHszqYblrtB0L+qyGeuG30EZQZ+q4326TpUffXB
	yNgmnS3CavAIh5p4w3JSpEYC1eV+YfKg9nCdbfOhigoMUOuyLhphp1tutLpOli7bYkupvH2/S9y
	ovY6afrXbCADf3UvmVThGwQ2JZ1mRvKLVzyYQNyaXd8GxpcMagGpbalmFMZ+5eWLivVdaVNySSY
	ggWywhGeYdHChPIJuFsg9NUXkVboqIULpq6LGwLipm5q5+4N5TGKqptRnFyNUv/fAt1GyuSt0mV
	ZieJ2hlW4/Jy/tEheYl1s8MgfW6xQ8nrAjkE38x0TSgqTOwXE4Ycvd2Fh4gKW/l8NQXFDMM1qtJ
	EisiTx3BYUjEKgXceRoepx+b+T/gr3eiAD8OEU1RGgNB9xim4NJbe3TrHSiGBxQ=
X-Received: by 2002:a05:600c:45d4:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4bb559f6f31mr43583035e9.2.1794564806374;
        Fri, 13 Nov 2026 02:13:26 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c8a77sm4362275f8f.49.2026.11.13.02.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:26 -0800 (PST)
Message-ID: <23edc29c421f5d4c1103004f79e104e9f94d42c2.camel@amutable.com>
Subject: Re: [PATCH RFC 23/41] fuse: use fc_init_pseudo() for fusectl
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
Date: Fri, 13 Nov 2026 11:13:24 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-23-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-23-4c998976c6c7@kernel.org>
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
> Initialize fusectl as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. fusectl never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/fuse/control.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 21ffde596d61..4497362e7df0 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -10,6 +10,7 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0
> =C2=A0#define FUSE_CTL_SUPER_MAGIC 0x65735543
> @@ -334,6 +335,7 @@ static const struct fs_context_operations
> fuse_ctl_context_ops =3D {
> =C2=A0
> =C2=A0static int fuse_ctl_init_fs_context(struct fs_context *fsc)
> =C2=A0{
> +	fc_init_pseudo(fsc);
> =C2=A0	fsc->ops =3D &fuse_ctl_context_ops;
> =C2=A0	return 0;
> =C2=A0}
