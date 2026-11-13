Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564728;
	b=VnE2+vio74/jQacdLZEsDht0qv9b3gB+GwQzFvqXbYySa+AMqcbzKvXquG8DwJy/U6Ck
	 nI2mASCe73WbISkoyROYlZVdzHHJMPrKfWJ/PQyPHbNz+y+XDRMD5R5eT7uIciHAbB2df
	 bF6oB80gAkrTjxX3RTrm6YwLfMorvJCiyEBrkhz3vI5zXUlT3thF0EkmLAlDbcOw1mAAQ
	 fcADC2/gS/C2KNSpSkBviK/FBfzUpViOzaM6V0irQtupnkN8kzRgzCecwFu0IpNeB3Wes
	 ZIat6UO/Qqv0ADXfbxFGWzBtvYxVz2rNAEeVxCeTeMd2rSd74nj+w8SvjgPKgQsY8hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=C9TZKYRayQVC7UyXoancZRI4bPIYIHY06/n7s/4tB9k=;
	b=ccU2iX0o/0kUQ9I9/yp7zV0apc59LNFXf/gv+q2yq/8ju+ImmNhEtGql9DXDw1dYRpvx
	 V/Yx3Ta629sdQsuLLsfFVU8rFn9NuZgXJYibzF7EdwZPsp/ngAH/YL/Sq4ao8YFOTQ9Yb
	 69i0IwwSsdv196LSn9VqjqdcrWuTigrNV8A6k3A36x2SDL6uEZxT3SkjiMpJG/ktYXQt4
	 owWTPqWC/Y3Kb8YYAigNUNhuSEMcf8UxNX/W1vmUuTTKCu128EHGFpfikVyX2Jq0MM1ma
	 KVEF9T/UaUrBT0N9vZkaDJXxq5VIjHeFI1PNiTTl+nch+S345HPbnwLcLxnVI7qTDeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JofFrwon;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF95F606A33A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF95F606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JofFrwon
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso13097885e9.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564726; x=1795169526; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=C9TZKYRayQVC7UyXoancZRI4bPIYIHY06/n7s/4tB9k=;
        b=JofFrwonLml2YmEXhdcViuKQhdgodt9TPfkjQoH5bRE5MuhkX9eapeBcuLoN9BMOMG
         mg62x7tr1NIo2ce3//xfxGBo2Glw1JnMwrRUE5PKg9cgXRmANAsmerUzgfn4I+APSoic
         nLUkrr6h7Ej/6ZnsBOEx8OEPXrCx3CvMaGkTszs9w9WOs3gF62hftbL3MH/tr8iwAkM5
         IEqdn+20vI39qrHT5Lu5B20ux21tBPJwfptIyU9tNUhlU5QyFDk51k8ZhbiJowoQswf0
         13eatahih0uhEB44iQMwucAarD0vNvZBAG3aTkRmepVuKD8cgol5N6Bgv+DPTP+kX4Yt
         YdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564726; x=1795169526;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9TZKYRayQVC7UyXoancZRI4bPIYIHY06/n7s/4tB9k=;
        b=U/K7oBlN43TqOenq6FtV3TmJSmQgIxd88wQo+7+9yIiy0FQJO11zHVqg+6uUuWCvg0
         N5BcnVv8lWjqpo7CvI2DZYaYAhImhQz7ILVCiL/RaXECcKjh2AR6F9oMZo91dSw3hpyu
         mYM6pB0+KokjzJ8eRRRS+yatUh4yb04kM48Al822V9SBkH7szxEyIOj8lYK4p8vZhZxg
         LF4WE6XZLjGgM7GKVmeYn4ly5WCMGeKX6oTB1wgdtfHl1UCH15G1czvsYdSnm1drhlly
         vWqgLuXQ3bcIzkvAFyJIFcZWqjlCu3afulymQubOW4PKgvvJXlKxFoHx85bo6crB9rov
         ghwg==
X-Forwarded-Encrypted: i=1; AL+hErH3HWt/jEBPsSXaa2DUj0W1uCxWwPE9GFjS0Ikc28oU1TImb4UAUKbXLd4RI5ZTtY/n1sF2uWU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8X+pyPPP+Z0BfWA9fiOlD3pdtFCID0YC87ZE5KLNe8xAmN3GvP
	MqT3f30UPdyt5p4VHmfQLsO8MmNs6NoqeJPjpmu4aYhgHrwvYL6gkfLZiW4fFyt+hZwUmPOU9Pv
	D8kFg37I1Wj8=
X-Gm-Gg: AYBFou1GRe9KhvSX68OlaXbKLTIMmQyH8F6qi/6PaHFwD5EqUfiL1CzIDV34H3Q//Cn
	OyIPJPqHejI96SPts/d7cvnnSU+72NX/qKoNngY5zo2BWrXz0YKIQ7dVSX+RTVipYsMepsZeD2L
	nXfUSfkjcqgWSL2p04JCmmV7l42AMoo40SGDDI85syMHzcLHCOJ9kJ8c84ItoGDVBBP+aBq0HhJ
	n74obDOhNmv4dmvyXI/PzQYvrMy3E8kPKVfbs8ChRgiTJBkpQT8oTNf3JDM4KQlUOTIXCmScRlE
	kpWKV9knAEqqy6vxjDMEuuxMxNr8G9Bk4bfDcm3HAYP9MyzUHWaGGg7SPr4JAJHLuBLwV/k2iXh
	zp7/IvWAc/bjd56uS0EXZP364DK53k0mHK4Wq2YSzqn81eGuFj4GgBdfSJTRUXdAy9BEbY77Rl6
	7F1W/qy5aecv1X3LQqA114g9YIWvwf9vpo31EteVcfHbfflxbwOO5ve2qHantrE8T8RC9BLUOZf
	a+K9jPygkHuL+FWOJvdPSk9+HDq1lN4zDJnlafpklw2Wq+flUb1H7m2REUoK8IRiXOLgS6noAkB
	8wfAGjS9ESdthtyXYbaaKeTaHF3tPrfWh3396cl+sMhZe4WB2J72fxNS9hibUbm/QDy1ipihu0L
	fz/IRZhAI
X-Received: by 2002:a05:600c:c4a3:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4bb55a02932mr40317635e9.1.1794564726124;
        Fri, 13 Nov 2026 02:12:06 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2842e6sm142085915e9.4.2026.11.13.02.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:12:05 -0800 (PST)
Message-ID: <82d691d2db7579d9630bf89f73132e36124bf74e.camel@amutable.com>
Subject: Re: [PATCH RFC 19/41] smack: use fc_init_pseudo() for smackfs
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
Date: Fri, 13 Nov 2026 11:12:03 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-19-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-19-4c998976c6c7@kernel.org>
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
> Initialize smackfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. smackfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/smack/smackfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index a72bc7fabea9..4a56bbeaeca3 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -25,6 +25,7 @@
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include "smack.h"
> =C2=A0
> =C2=A0#define BEBITS	(sizeof(__be32) * 8)
> @@ -2880,6 +2881,7 @@ static const struct fs_context_operations
> smk_context_ops =3D {
> =C2=A0 */
> =C2=A0static int smk_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &smk_context_ops;
> =C2=A0	return 0;
> =C2=A0}
