Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565074;
	b=QmtpnyyjKyOdxbUZpp5RYM8FchwbQs6vQG+Qq38rlSqOVWf+fJ2np1g2Ps0ZMePBHfi4
	 WSecFX3rP5c4Kp/AvfWWiwyNv+LwGrfVbLyIJz0Rjt7Lz6ds/l2Dkidx52I4RI8LHChNu
	 UwrHbS0/79qBt/aawYKhzqHa6gW25RpjDSoThuuEF8G7bYViE8Bmxyk6lm3VboAjTE0uF
	 gHdKgK+seDrkg5wg1xrakEz5btDAdmKRT5lVNp+EQdczgUAtUEVHy/p6ZfDckFWtjyP2D
	 HVp3mOqRqq5VV734RCASKQFN/ITf14R8v6ER6XiqqvD1rGjeWOtHqvi7g3Ks1mP2PrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=;
	b=ND8YyT8Dd29qp1tI9dfbjxCPlgAJzPjkxSBvDNvU6pBxPQ3lQLscBj5fUlGF6PHPzllK
	 IHelNJpNG6qhzZL/cImwCd5054pMqYTW+vxsrHPPEusMMXssOmk0nvv4jjapTstMYUTGW
	 h4t7DTLQp7B0GxA2MUxRB7qXNxnTMm7y8CswT3WgutVXw6od+zMhfflOeU2Qlq70rDJP7
	 OBO5QroaWP/AbdY6T/wr3U8Sm/PwFVkfqiTErrpNpJ5OLlbQXXndRBSneukPiY6QFxy8R
	 uWmO66BZzW8JCtOVQYZfD8tMD4qjH1ncc4+CRCrpdjqrc3QBTjreg6BV785AqXORofA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hEEG7fG6;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C330606A32A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C330606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hEEG7fG6
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso10283225e9.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565072; x=1795169872; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=;
        b=hEEG7fG6RzQkOoGSL66zkn+hWpy0b8TxpW+CxGFBwGxbhLfdgmFqwESmbjaY7MScGa
         1TTEC4ZDzMo/nTmQbATUq4OC5CVK8FiegRjrCOceUr+V68t+3IyOPEhrmauT/typpuMH
         7BtZ7bLX9twnpc3pST7EzNdPnkg3BFhqHXhYG5RTwPNXEKUOMAEYxir+CLBCGEbp4xnq
         ot2tG8XA7sYEn5cZCga4RcL6w3I4tCQX2A1rGgTmCQohN7lvb4NCOhavzOt0i7fRXz7K
         0fiOYrUI/s1Mo3f+qCL5v2ciULr5WU1WUhy3OFmgCMCM2mU4bZM+JgAT1J65gELN03wt
         2Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565072; x=1795169872;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=;
        b=rrUBrTGxRm4BHcSKT2dwa0aJhlz911EdG8K6s/QxbW3IVLBRRa3fCpI39OW+BWzIe+
         Gpu98gzgRbWZ9nenzECmfqkXI5T8hcmdBPObOutHyJ23V1+mfBRjkbLmT9EtWGgabT/j
         vgZC5PUq3vw44SlIL4BVXGm1/NcgGqeu2kZyaD3zUib66Ink2RiKiYOnfpe7MbcLHmv3
         2P5Lidq9VfHVrYWoGZLe/rf0wuBgM68F/OOHhrRNuoyNwA6FifosqOZPzqWghiVoipyf
         DQ7CLQAF94UodkmKJCDdxpb3r6M+lEOcdKuNP83YViVGP4vgKHXKZc6/RWgghWtByVKU
         Iwqw==
X-Forwarded-Encrypted: i=1; AL+hErEBfV6mYM29X1iS7ZcjA5hM6ILx86GRYP6l+Ufgn4uH+0ekzo4m8U8QSx2aHT5BLL6IKQCIecs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HYccYLkY/05X04kFSbHnrncS37dNzdQV4SpBAhwTBN0vEKzhd
	L6PzyA1Enpsyjl09wrevC774vSYImXLfYMQio4tIFWZ6zZkxl8LxG/jm7/UCYyqQJQOg
X-Gm-Gg: AYBFou2iHHqrZaaoj6+ov4evj+ksMNpl2WYsepBZrVJDyGcwryXQIjX5uIDhOYjhJEC
	GQT7iYYzdS934gl17SaV2SPBMaVL2o7BenTy2+5dqE6+Dii9X3o4SRxgB/g/cgDwxDULrLGRIsQ
	hYh0wlN7lZmetET5fIjgcggtUez8sAlDkCkDoxZZbuG5l7hgGJm1MTkIWotkAjhAyfpTzEamfi1
	/wqFJS+vyNsbSBb8gsuAWItPa6SgKXkZvb78MmfsHcgwivHos1VVomtwSzuf4GPxScM5eT0N9dy
	A1FfvIundBMT6tKVuOf7o0s751f56UXGUYzyRv8m/f2qc0Wyi6dJ7OYQMk5vWmxPhuuVZywRZpK
	MSpzoGmZavKvR0MDH3L1uUrmNT01WdoiN+blRA7C+wqpaSFtIvcEvef4PRWciIdz7mC/6ng3cPR
	YLzLod3IkqqAQwTqL/0/1o03XtWFvRJr4qSL/AYnFJMlCknk4UuhOGNcjI1yOf2AmoeSjXXYuQP
	vuE/6nRn0wMTHNPKn5opQj15LIxYvyp3AAPMfaI0y9MWG3vH0Emvdstz8JvvNcvtXrMRaoFT5sl
	pINo/nqPrtt2ad5sCnZBO5GZDf5h7Jy8CAmQK3Zop/3rtrrGPSYXY+QY4+lc/zE=
X-Received: by 2002:a05:600c:45d4:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4bb559f6f31mr43851425e9.2.1794565071804;
        Fri, 13 Nov 2026 02:17:51 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c7da37b19sm3937770f8f.5.2026.11.13.02.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:17:51 -0800 (PST)
Message-ID: <7cde6f3091f9d90593e4a6441723b6b889cc4024.camel@amutable.com>
Subject: Re: [PATCH RFC 35/41] zloop: refuse zone files on pseudo filesystems
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
Date: Fri, 13 Nov 2026 11:17:48 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-35-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-35-4c998976c6c7@kernel.org>
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
> zloop opens its zone files by name below the base directory but a
> bind
> mount can put any file there, including a procfs or sysfs file.
> Refuse
> files on pseudo filesystems as zone files just like loop does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/block/zloop.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
> index 65634a39b0bf..dcc06dd47b04 100644
> --- a/drivers/block/zloop.c
> +++ b/drivers/block/zloop.c
> @@ -1137,6 +1137,11 @@ static int zloop_init_zone(struct zloop_device
> *zlo, struct zloop_options *opts,
> =C2=A0		goto out_fput;
> =C2=A0	}
> =C2=A0
> +	if (file_is_pseudo(zone->file)) {
> +		ret =3D -EINVAL;
> +		goto out_fput;
> +	}
> +
> =C2=A0	if (zlo->block_size) {
> =C2=A0		ret =3D zloop_get_block_size(zlo, zone);
> =C2=A0		if (ret)
