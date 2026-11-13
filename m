Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564223;
	b=ObM/zDToAxZtqTSafg3MEc/4ld5YOV9ZAJZ14IM8SfBuhGgVF3y1RQOuRPhULmYwIcC9
	 HznyRqufQ1kACqvbS7bsXMerQKLUqEDms42k4DoPQ2xyXB6pUM7pkLlKfKPWYWIigZdxE
	 GUitoQNiS+SdHWeLJpdsH7GoVuAiMffoRHZ5sk3cboI/TxdpwtR9xGRx6Fph2sjuyvhIN
	 8169TnjULGQnYCc+QEltBpX8trcf4s0a2g2IN8cptQ8IDUj51gzt/01Xbm+NtjuatMcHj
	 dkDYD1QCH89xcBBZ2LsoYH2xi5jwNqhu5bc0s0AE4rzDsO738tdmSA4I71d5XX0BsFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
	b=AP8zVvnA6prq3cumLkqd+4P1emIpqSmKK4uDaKSVz4xZ9HCGO0JNXr4ShyU1WkwsQcm7
	 2ZdCF8iabHHy6Qc1YwMYrR4GjTr0aJ0XKnMFqHalX2218TAhYQcPujZV11AapXzT1ahUe
	 rr/eXrUEY26Z8EetkaF9nwBly+9m3MH5Gs6GAw10F3C0B5sK9sh1dzK8aaL4KKfDXcMM2
	 hArTgIazIVlFc/JKavRnMeJAgG9E+dByhXBOnF5KKPcPSoU7X3r8D9nAE4YT4xCEluqkr
	 RBJqOTdVRrlPStECW0yxS2uo2mhzuavAsgI6bBzPydretpZHh07X+7puqbgSY8BrQoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="YppAuU/f";
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC3E60A262D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCC3E60A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YppAuU/f
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c40e30c26a4so170618566b.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564221; x=1795169021; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
        b=YppAuU/f77eWMTZ8F/Y/RTjltBDd6igz4EttMolmckndL9mvAt3euwqVCnUFPcnj1L
         wpVFClVgg0YlcE6bTABHQT1NnQyujG09t70SZ+IGoHQq0qQgGGwB+4JQikI2kaQwvi8W
         H3KupRONVF9kXu90kRN/xwbfNoANJajav9pnhnb3IMIJ4A6DWEq+8017kOKRrUT+YN/m
         jRUDmGHXRq1c+43Y1O2K5XEGEQl+nQ8YkAZ+/5vrEItOhIamTuHGEOkZUAeGsE8baOwB
         Dj4haSBpRwT/bMXANPqkevI0ogqYaGkZDRE/CPrkXlmZ9T16K5sayD5Snik8DtXgYcT5
         haBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564221; x=1795169021;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
        b=zaXXLSIE55/ZAIY/NqjrqFEflPqdgyys7Xrjilu4Vkn05lhFi9d20zqJ4K+EpQMJbz
         Mh6xo8hAWCrV1G/5zKmKIq4wT4o8spCg77m9tMwZiHR6SJ31MC+QjxSYlbD4S1HZdtCn
         oRfSVe6dh5oTMswaC/ngDD8dSV4cm+56WPE9IqAXQOKkp332kN/htqplIjl/zpK37cVt
         7/61S3LS85B5rMFs279wbe3C8x1kY2bdZD6zlb74lZ8fJezj2vXkJHeTrtbtPdQr+v48
         6fWRaZLReF+y9ev4ORGw+RiH8P0eoKnXQtZnJmW9r6Wy+7Qnsy/d2lW4yp1NXNdMBTpw
         nxTQ==
X-Forwarded-Encrypted: i=1; AL+hErExZAY2+ChIsGrnl6qHMriUkS2Ju9SrvGnPkSOiZ2lZp66c7cl/BbUHmkzhk8oMJHVVPvzTSoY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YaWCiTeJsJDqJfqM0QNauQl924AtalsIn5LBG7u32HcpZ6zS/
	dks0aGkSKwcVcHHZaWMvLmBzQJ2MaWHSuRam1TXCvUAjWJN8ScOc1lpF69zX86gVkIcf
X-Gm-Gg: AYBFou32wTlfOxmblLWPj4GPNAkl1+QTN5HeLS7LmKGlukufAQ455jDwjuGgWJrLAb4
	rYGcozbfwSpxovsyiTUOUsr67UVMaEluf/2K6nTWhLZ/UNayj9gdGKcztT2qFIkziCv8x/wj45j
	aIznKWyRV4EZ177AhyNhZ6eehiy5HNcX10hAdUaKlwQPkoV2E/XZxJWKlMfTRpL9XGaV9GsHiSK
	fYiW8alp/ZMGFyiSb6UrWyiE4lsWvJA06TAkPokTmxfQl+SqXKdz+2PFgBv7PeX+Ef1iwWJQij0
	oC9Jt0Ow4kmDB5ZE21XqLu3bl+XPxN5XNA2XMEgDuufXGNB5kEfEcqMCn4AGUZhDpeMumOGy65K
	QQkzOzrKzkaSMsJCtUVlLheMUV2IjfDiE4fCMZ69zZXKJSmNXwSDdJOvfmF8ZKQcOKW6HqXsb6t
	v4adZ/HX3J05/4bgs5Z7h3DCG5Vgcla4KLWR9E38AX042N7+7SXqhrjPiiD8JI/cz3AFChhOztQ
	jqLsATakXbjizsRIdPbY4qQ2hJa8u13KC77+tVDzd2LcYrcqgUfab/uDEcnIXJFa3pnlznKf7Y0
	tBpfBytQzVHRsYvt/dRLi5oV9Lj7U1Wkf3ePGJn4yopOiLZ/d7BzFolC5dVFNyc=
X-Received: by 2002:a17:907:7b8c:b0:c42:bc58:f21 with SMTP id a640c23a62f3a-c50963856f2mr175546966b.15.1794564221164;
        Fri, 13 Nov 2026 02:03:41 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b3asm74752966b.27.2026.11.13.02.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:03:40 -0800 (PST)
Message-ID: <cfcbef5caf7651b63774549fa1999d34981c78a4.camel@amutable.com>
Subject: Re: [PATCH RFC 09/41] bpf: use fc_init_pseudo() for bpffs
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
Date: Fri, 13 Nov 2026 11:03:39 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-9-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-9-4c998976c6c7@kernel.org>
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
> Initialize bpffs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0kernel/bpf/inode.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index c6f328e4752e..57cf3775c076 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/kdev_t.h>
> =C2=A0#include <linux/filter.h>
> @@ -1197,8 +1198,6 @@ static int bpf_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	sb->s_magic =3D BPF_FS_MAGIC;
> =C2=A0	sb->s_op =3D &bpf_super_ops;
> =C2=A0	sb->s_xattr =3D bpf_fs_xattr_handlers;
> -	sb->s_iflags |=3D SB_I_NOEXEC;
> -	sb->s_iflags |=3D SB_I_NODEV;
> =C2=A0	sb->s_time_gran =3D 1;
> =C2=A0
> =C2=A0	inode =3D bpf_get_inode(sb, NULL, S_IFDIR | 0777);
> @@ -1261,6 +1260,7 @@ static int bpf_init_fs_context(struct
> fs_context *fc)
> =C2=A0	opts->delegate_attachs =3D 0;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D opts;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &bpf_context_ops;
> =C2=A0	return 0;
> =C2=A0}
