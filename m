Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564824;
	b=GQvTmzuemdjVeQ65S5reUL8n7blYVyCEXHwU7l6RRZVLtVzUFg39Vw88bJcWIA48NNG1
	 EIPzOhGLlxqfvz5ZUchoaDymK36scVFNmibgMnaSuR6JYJdIy2pusZdTCX2EfJ4R/4JBp
	 AMiPQBWND8E2Gg7BDItytf37qoX6bEtuFfxxkT98bq+4ozug9kqDXULrODlh8Oe2pTlyw
	 1eqFvhOjCSh8ergI+lwqlN4M6FktfsEO1AKv7a/RbYmFRqQlyat4o4yNTiZgXT72lG5lH
	 EIvKFNSauDsKYhV/PC3RlQxYFAEPGmAuwe4qPaVvncf/cWn7LnH4zCcej8djyZ4W2yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
	b=O53790dABDOlUprmo2xIbGKGfszzDoz2CJfIA+Bkqjyg6VzHYOXBHD74LLsrNAiRBtdB
	 tLo8q7nWrsuARz1dbDiFSsk3QSu8wEurC9qJGd5cXD5+ZE42q4QZWKSM+D9t2cjxS8N34
	 NiiRECtpv5RLOnCVTD+sCW6q2Ypd9QMI5tTBhxAt0+ruSbwP8H4yan1omZnNC3/j65sDA
	 Uj6FhmERiOSWPvKKWpwr+kiUOdJXwbeYO1zE3GR1kpvP4IQX4+TsAk7gdC6SQ9ixNLrDx
	 X+3WSUP5J5Zb3mBk/oXny9X7UCOfYOXTeLkvsTWs7z1ITICeAYaIj4fOFo6jXIRPvag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tBSDp3uS;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FCC606A888
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4FCC606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tBSDp3uS
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b581b6b0e9so1096351a12.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564822; x=1795169622; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
        b=tBSDp3uSBFgypsbtBQgsadIQZQK7UWodMC4WHZVi1N1ipHHYu6WywVfCa4AZ6QIaRM
         wIcOajhLTVFUJp4yf9/N65gePrg5n4K0AYKI0yA+7KNwnMoUY/irx0jTqY91Kx7jR9xZ
         Pm03fPe9TdsIWGPKhcU7A4Ssshd7c8Dhe1zzS2a/pwsZLiwc6FmAy6ptf2LWGhArJX18
         uzRhPjO9k+hyhG0ceM77HGUPCflD5+7VnbyODCgVUFUm1PdMwYT1gZdGgKWe2z5NHlJg
         Ao5qYJPp+rBAoBURzi6iHuHACVVyoOXqBDLcaaEy2+qVTTu+93IkZN11FbEDMtWMDX2T
         mB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564822; x=1795169622;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
        b=0Z7raoEktLLC1m1qrkOfZxK64jloglV+B2bpiLUL0TEaTKV9llysWPI32emKVhAuCi
         3QaUMsjlisAOSTsX7C639cvQ19UJI5+6IfuHoitERtSQLPNdX65OOWGe9SHo1enJre/y
         nI2oggdKCoqAo+cWIJYmb/RCC2+QJ6ezWpgiWg6/bTSMvbQzhfs2kWkYG5dvMsjnj4K/
         r7Cbip7yq7ogPhY8HIRuzPV1hr65z2y1QwjlM0hcJfCTOMHBUwRmCmt8y8MF7zMac1op
         DC0aQLj+OFtBLoW7DfmmV4u77Prz+Qx/WODnVMdkJRwVuQSHpCF/EXnchPt0ASC4Hw09
         5Q+w==
X-Forwarded-Encrypted: i=1; AL+hErFWwSvIBd8dE577r4cDJKa9MIAibRU6bWu1x+GX7JaNE50dEa61nUTiUtxIh5Y7ewTQbrz8fAc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VTbvARoL+QUmqEYYGg9Ic1tBp7Z22cJpJigE7AO1v94hbRJcG
	e4D4fnfIvZ6fry747Cf3tQb49YBn8dYVXKCHilas3g0kjMd0Z4VcjDTnLwWFnaSTQ33N
X-Gm-Gg: AYBFou1AcypQp3/Zx8GnqwZEJhLoMcVi+SJJ7YHLMuLGFkmWDu0xRFM8dVJRPqUqwTA
	Nnl981Y4bU+jNR1SEd77zOAvOnGE0oUcrqpDBavJcI8TARjeSp5dPSucxsaTd/QZmM/LbqxIIU2
	R/YjOjhhIzMLnywpm/25YSMUpxW9wA42HYtI1QZIt2JY91i3ckYYMh+aVdJTU1eIqfTi3iV6Oce
	qxb+DvByBZBfZMZQpyp/HJU1nhCkS4GXBWNdfYViWDyuGJ4f8r+ntStHPmQYlNQSGN2DSxpHBOV
	1VCoULSRnKBKjweU8TzCg06eSjZ18xiu+3ql4X3MhGUVd7OkmCPNk+bcpL0nMgicVW7B9Xuhznv
	dYxdwB4qba1ErS8iTKD2x+yJF3iSZzf1IM0zmUkMNZQwgGmZgFxRLgqQ78+KZtiV0CVXBINKX1J
	YQInyO380xXpGpBv/w/x7AADplelczZGShoLgdTTBsTXiGOiO3v5E8oOA/BeMKrpFJVc6GMamV+
	hlH2Ey9pb9qnhoqWUlwRDCighHs/Cz6AU5sz0tfLpu579zfanT4pLotUEi2FM+pOGz3+940J7TF
	doshtaiQ3lmyL2njUfS63wV9+2zYwMSeft9jWe0NRPDaaqNIf0D2+qO0cAfAGcOXRHSzlGoe2zz
	zXDhqGl+t
X-Received: by 2002:a05:6402:208c:20b0:6b5:69f4:e7ce with SMTP id 4fb4d7f45d1cf-6b7c0c62bacmr1415990a12.39.1794564822367;
        Fri, 13 Nov 2026 02:13:42 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4d29sm4332158f8f.35.2026.11.13.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:42 -0800 (PST)
Message-ID: <3546dd28b1d63c1478d391a2015fff4c1b976639.camel@amutable.com>
Subject: Re: [PATCH RFC 24/41] efivarfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:13:40 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-24-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-24-4c998976c6c7@kernel.org>
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
> Initialize efivarfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. efivarfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/efivarfs/super.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 12746ced6dc6..e598d42c5f42 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -8,6 +8,7 @@
> =C2=A0#include <linux/efi.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/pagemap.h>
> @@ -554,6 +555,7 @@ static int efivarfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	}
> =C2=A0
> =C2=A0	fc->s_fs_info =3D sfi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &efivarfs_context_ops;
> =C2=A0
> =C2=A0	return 0;
