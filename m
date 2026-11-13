Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573510;
	b=mEjLyB4BIhMRiUQfg50QuCuACLy5Sua14Ir7m+/xCBy5hGJpMpCTdBTK8iNLTxtjwFYC
	 EtY+83KLAeQ0r0LK3Zez+w+RE4qBZE5sLdYRgvGPODLygnqiMMDCc/6xYM/CjJAU/N7YC
	 b0dIKB5pnPoBKubJxeubvL9Jt3RB3GrMruVsghYQKsMhspTiU0rYFNDBkZtRiRAXrf3Y9
	 j+kWVNoX5PgOLu/fodPvuZvjOFiHctf4V/CH4dZjGFbkSMX4KhhL01mKwnrTRz2dLKUmR
	 HJn8B6oLazzxlcFRTWES2Ps7gEJG6Ef7iNnGHBYas1yCkF8nY3hy/S6OUSFkC25xsag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
	b=qRWSMU2DfFjj4oGKl5fQg80tGDEOzezlcZtHgcDfZ7CvyfRVTFHwo+h5u3pk8uejwNnZ
	 AgSKGk+36qLc4fZy7x6eqVwSC4L0s7mEDnBF7MaJsDX5QTrT0bGqTLy3hwrhhEOVeFoYr
	 QPnMc+IPJK0f4MHTGyxzkXwL8ZUWerMXCiHChNljYss2E0+V8035BeWmneOsVyDckY3xD
	 j40PcjZti11ZDhKuN0gd9NbEIO+jox9xkC8ytvv5VLLBMMmn3F41SSGtRJSmgfQTsIbL3
	 252mC4hESJhcFdlxRjrR1FCqmPaOfI1NeAYoMZuCzKruGj/YAavnxyxkj9j2YyeJVkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bz2+TnPI;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DCE606A33A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1DCE606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bz2+TnPI
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so3649075e9.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 04:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794573508; x=1795178308; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
        b=Bz2+TnPIApHKvsf08kyiSuJZ5AWViHONwTwuNXVAuo2u8JGXjKnEoxSd3hG/r/h3b1
         tdsUEBtaZSOWfU3+mD3LjyqvBKt9Vc6RBsvkZZTD05u5eCDGhnWto1Wbu/C0r64DVVdd
         h2TGnt6meedDH7Iwjf2Hw2JxWOY8jwAvEAcAC10FURsf5jjp4p/KJzFYjzuPwuYFNKea
         Iij0h8HoPs5opXKf2XwMBJpd5hsYSV0+BHP/DvKdCCgwNFtbeIFAwqDf2ag0NBOCbqs2
         OXWiZmXbdGCixyOlqQBMgrkFkrhg1VmbSdmvvBdeQ4Vz+QMvhYl+k9AO6FJ5UW1pg6b2
         DVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794573508; x=1795178308;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
        b=Oo/YcTdmTpxJRt3XfwPKphHpxPhIdk8KZ3c17MpUxwPBXx1Zam4LpwF8M8W4QLLNIy
         7Cwn0KBwcGnLiu9B6KtsBD/AEZaE5FbRh8EeWRLJYi/xn452drMrCcCaG7PJMu9bbbXN
         GIpIH9ntPaiaRXtg+FiIhPf/X8+qV8pqXouH1V6gk7On3kRabTNK1+1AssrveZASWpFs
         DUIgu/4MHMJcFc5ak02JZ7WeaE0vhBEUAzMb7txu9Z6O9wJr0oNbhPe11V6XArJ8FSkz
         5qjU6R/vLaAL3AycXRayFaZTt+lJaQmu1YyUQ5olDbFsqj+9xzwTqqyhZ0eYTLHaHD5C
         vpSg==
X-Forwarded-Encrypted: i=1; AL+hErE3JLflKIafZJoJoip5hUoPNSPu76x+7wPor4OrhKv9jx+IVoO00t8s/zHSKKGCfzsEqtbwKzc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YKdbjva3osldfXmG8GAEObnen3phlxMWpNfSVtl2kgUYsNaeO
	5aTHGHCECo843J7VLpmS3AqPyktDRRKX3xtGFc69fEMtzD+FyJGxpGRX+ji/QvdAyrlk
X-Gm-Gg: AYBFou3WoEgTNOQEucUHDoc7px37Jfa9gmsTsJdJTzCPn957SNQHpw3gpS67VvN556c
	zKiqnmt2SC8bsev+zW2Nia4XmMZRSGXqeAnubNj9gYnqRCo9ZLQb9jNLZHRIQEmj+pUo2pIvOQ/
	C1KhMRbMW4AX7O10vrTGa0MQ232dxpGyjVZsLz7q3KxYCDSRQwFvPZhEzn/OWebXbqncO6cIsRe
	Qi6x5+f/3Sq1auy/lZqXngUcwbcZ1PPuajxMsf6M/nCjwtxGYreqVByMpNAUX+tLdU21vQkybMr
	bwJhJUcTy2VgwC5njUz4hx+zLPJXBA9x8AM1W3whXyef75GaZnWjFB8tKJCK+kai01m/hqnzINW
	YRR3D3ChA/wA0uUVQxekgTlbWsku+9GwNKpnZM/vqb0BWT9it1yAwqQszA5f/qMOgD/9ZbVaTTZ
	lb4IRgWbUwpjDvnrVCrSvTUeTOda90LEP7AejWfv4xxLCulH/QDimwqsyxY0YacfrN5namh6na2
	mmOYJTwxJoBGSd0JFfYDOzr4VCzJFAch7YiaBSwTLqn5utLFYAnrsCoyvZpokELimvw76gPcUlr
	JRuiKLz01h2eItmBw0fVfinuzPt8EArmieBziRlRg12cYwMMKq41eZs15nTZ4vY=
X-Received: by 2002:a05:600c:a596:b0:4b5:d95c:2380 with SMTP id 5b1f17b1804b1-4bb55a86fb2mr24790785e9.11.1794573508217;
        Fri, 13 Nov 2026 04:38:28 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571cfa2esm48348475e9.2.2026.11.13.04.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:38:27 -0800 (PST)
Message-ID: <28a33fa649dcaae2eadcc934ec49fa591ec1c283.camel@amutable.com>
Subject: Re: [PATCH RFC 20/41] apparmor: use fc_init_pseudo() for apparmorfs
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
Date: Fri, 13 Nov 2026 13:38:25 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-20-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-20-4c998976c6c7@kernel.org>
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
> Initialize apparmorfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. apparmorfs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/apparmor/apparmorfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/apparmor/apparmorfs.c
> b/security/apparmor/apparmorfs.c
> index a99366467217..351ea3a7120e 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/rcupdate.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/poll.h>
> =C2=A0#include <linux/zstd.h>
> =C2=A0#include <linux/string.h>
> @@ -263,6 +264,7 @@ static const struct fs_context_operations
> apparmorfs_context_ops =3D {
> =C2=A0
> =C2=A0static int apparmorfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &apparmorfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
