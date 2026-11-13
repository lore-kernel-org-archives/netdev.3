Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564363;
	b=RtpP/SC/ErbYIGOCqRllvz2q+l5EcGAyXY4NIqXbz4UAKvlTAQtIbzYTqkMrrtzDIzsR
	 Gf8jMmDDMh2voRh8MklmnsB9L7jmq+rDUtIpZEMPttpRtZ8fna/sQjJwhBWYBu7aIetTI
	 rs65+39oAQriq6ogJpVu6GQgE4QoozZR5HpC0/lXmIGLFk0Nxy+EbFs8Xf5TZZQCelsov
	 eKw06RrFH8/AMlMEgwzXn9CkPAHqXcQSQjKFYIMlDCF9zrdCZIbrtbzG731ixp4GcMN/8
	 yZKqSDsTXMCGMygt1RcKQDWS/2GYaQhTo7NHyvBsNk5PYC3ZUZPyXxgL96pypEsYmwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
	b=dCHLJyE+h03QdMWEL0FtSc+FjYBCT6ofDHKpO4TY/M4Po/pdPvlQPsU9ScABEBzkuWJo
	 vzBCBhKN9XyjB8xT97+ga5jGfdS8mhn9bX1Ou9emk1HpabKOZt8DPZ3kNcd5/MIhcksBD
	 nbWnJG7vobovC8/C2qgq0I17/JZvR+sPXTzPdNkbUEenrRT0oqSL3jGIOIyd3+AeGf89w
	 C49XbKxGgvXnyvneWIVfdvwESgsu8MkOEC0z2qzpxs5jXS9lzHye29PJnV2XUB5CowDHY
	 Z6uxZDYjvLjvOA996jcRB7asAwB0OBOIyOKl7mfGEGhOrY8x1JKEsK9Z7OvdiSSXrVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cjEYfKb2;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC9E60A380C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DC9E60A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cjEYfKb2
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c50a4a2132cso51084666b.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564361; x=1795169161; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
        b=cjEYfKb2ti/xguKoQF5XePY0eNOezud7K33Duf47S0g3JkHBuObkd06WZKSsE2j4TE
         DEwnxkXlTao4933EWT51qAqcKFQZzBDYUWq7IdS+RrJUrXD2u7QTXDm9Wr29l+nlsY2h
         ba2aoEFnt/fnBZ4TqG8AlHBTx7MlaAOM8MSBIpLqFecTqJgM42mukp171NeFhmx0Zx4N
         EfXY8c4e2NVT5eQpV/Fv1f87MHIzBgzN889RZpIYFKMs83t0n9Q8bpafRw7OfeQ9pMp+
         KOGhNvmnj7I3xZktgYLxquasfZAW0tMnNpo/9hpnK424qA58Vs+J+ftPxNsRzOLYAEav
         G1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564361; x=1795169161;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
        b=yYwIz9456a8SgTv2V0j6CTzCb+6RGmJhzGR8Z3LvktsAkCVUMcTDh91TnQ5xnE4+AA
         DRdWN1YkU2DjzeDVFf//ZNexrUDPKUutqA+msCUyL+GKWtFcEe+kfHuzfMG0mDHQ0ZZh
         +TtVSsCpW65C5PDBDs2S9lwtJQMSVeMhsa9s8N675S8Vk43LXv8P+rA3lX/+yjUQ+qzI
         YO9QrFgsTwU/YnWS29NEt96/uFLTMpAfy5p59QpTxtc6jrlGWG9YY7AeuGWgci4yCONd
         fFaNcuVccVXBkoPLhH5+h3iEwwcT9hkozAya/Ws/b6OYExSEzO21nWDxmHk1LilR0RUp
         RQKA==
X-Forwarded-Encrypted: i=1; AL+hErEPnnPbSTSfvywA79ZvKznQTb1yIaCrvw1rk28RqIIFpKUx/KDBucJTpefCZt0SECqxosZNCAc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lJqncvI/CmjfXstMXfcGI+S9DBc69tiISiNCTeJIXgfhWvtri
	tT0iJh8TXur2F9mDqFwYEZMxtPbnFIHU2U4St1shTo1n0maRodi2Q+qPZsPSawBnXqI9
X-Gm-Gg: AYBFou03yyeAE64IwJ1tHgRY/rIrtjsUxDWx4vwonf2CN0s1olF9fdO62fTnWkwMnBb
	ooVMuLmKJgt/7HrTzcuYC5m4bwInhRESoG5R/uxVhGiUiKtYl+Oxptr7DzaHAGjns+dTM+SXKxi
	bdzGtInaEosd5YHIbtsf0WjXlpK7HgO5Ogzsxh2C6C3CVtRjXmZTHSPEAaLYWlIOT1DZZbCD+h3
	MoucdyGxe3/mC+7cnrOzW0gyUR1bdughOH4EhYPkiDu4SFQJzq3Sxea6W2Ja7naD1Tmcycd7BGL
	BjltC3oNOpzB6znIZNwrJFHy7kQtvezbZ7dIJmYz5Mtg+9EHSkclku//fBR4mDfT6YJ/mS0dQ57
	o+4pUeiOHz1ZUamYxlOgo5PE2TJcZ7pqDuk5IjrMY7xUbESDql9BX1whG9kDJawgwBsc9H4VhjW
	oecVAMkrBzVbJXTeAS16so4Sx3K0jD0IZnWGWXuYaexSk4eF0+Ic3/kAi/crRKAm9q8Zq8YWKQw
	9XvN7okgQl5/9nc6RQ6RVs2E9ZDQL07ojtGEwAW9mxsISCS3nhAvW/1cSPPi7zx/aCbR0IaItpt
	Cc8qjTSn+oos60JRxoMDXgqKFOvyylJ5AEbUrO8tbl9r3UldhxUXUDnHr3zODLA=
X-Received: by 2002:a17:906:ef07:b0:c4d:5820:325a with SMTP id a640c23a62f3a-c50963dc627mr169588066b.39.1794564361325;
        Fri, 13 Nov 2026 02:06:01 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b8651bsm73693366b.78.2026.11.13.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:06:01 -0800 (PST)
Message-ID: <e8b71a2778d7d7797d433e7bac1a37ee64aaa30c.camel@amutable.com>
Subject: Re: [PATCH RFC 15/41] tracefs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:05:59 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-15-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-15-4c998976c6c7@kernel.org>
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
> Initialize tracefs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. tracefs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The only tracefs files
> that can be mapped are the ring buffers and __rb_map_vma() refuses
> VM_EXEC already.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/tracefs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 5020365ca704..e04febd868eb 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/kobject.h>
> =C2=A0#include <linux/namei.h>
> @@ -510,6 +511,7 @@ static int tracefs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	fsi->mode =3D TRACEFS_DEFAULT_MODE;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &tracefs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
