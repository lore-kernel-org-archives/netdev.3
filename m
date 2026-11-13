Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563701;
	b=sn4BpCYgvz4y2fPcRRJPgyGuGRM330DJpJgWgaM3mGtu2LyB+nX+R5uypOWOMKG/3OzY
	 Iryac8UfkGEQteaGyWgAUhXwWKFxSBvPNIqFhsOBZBRfSHukX6CeeR2pFn0DBvgY5bcES
	 acCgEzPYXMUodu5k2lxnbWfP/Apm73NGrU760XrpwRNYJnxe6vG46eshPSjPIt2re7Wby
	 j33kP+ASBYBr8dRhrM/8vtra+fiV+cNx1NV5uLZ2cfJNjS9TVmlWlmaSIDnmA6+9H3Gjr
	 hr6vetIZO8YDgHednqh/B2EhwNeWm2dBgXaiRQqntrVjw6IHv7WxWMPHMrHJFExqzGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
	b=W183WBHJ0n/ppWs/Znnp+iz1+YPlcdc1kH7V94QTBpceZDUg43N30ZDAYdHlhRkb5EP8
	 pUBmsyLLRR4G5Z7nOJXMi/BSV7qrW1rOdVUbIURO6FW6rxSTFeoR01YsgYpNAahD9HBvL
	 6v3JwrDm7gNtebfGcqY6+edX+qcf1sDOmdRJQIPydDGm/81KTJOw0odUg/d1wEWxI8Ys+
	 4ke20LrOrDM5bYFQwNxILb3bSB0oxeNK1OtFNgA5F1CLeu0ByHgzT32tJyhZYpvOxL83N
	 kOcSR6gcd3drBps42yyf5VYvu+vBGbLApSaN+HmvWhFQsmIu2J44SoXDX6l5hYfN5wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sk58W6sW;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5A060A260E
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A5A060A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sk58W6sW
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b547d6c07bso1415664a12.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 01:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794563698; x=1795168498; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
        b=sk58W6sWmN4ERo+6S+koVh/BM/TVuc998Smvb7+dAHAHasLoIxA1PyH7SpTb2sphTs
         qaL8BceJIK/C5zTluK59TXAg0t7i18MIhSXKzAc74GDtFkVBtJ5XexxofTn2ErTCpEyw
         wBL0ZIwSoD+QdFLNUYuAtp3uhttIIU+8CcgeY50Q9BuPcdVkRSxffNnvhBi5q+TOT3Z0
         N0fPVcnw8avDa7R0wdKzwUNoVC/3vPRCD1SmgKjZfrkNv7BBIugYP8aqCryl3mRTzhIm
         nyzLSOhSkS/Bye+QA00IM2MsjhnUA408QIyungJaHYxvuyXbuTeC6K0dJcKnUnQNsCLo
         BJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563698; x=1795168498;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
        b=LCHNGCNAM5iLJpNqPLQDyfpc5JYawIATQKM0pGExHKyhvnZsyKzIFaw2YU6CXnCP2J
         l38GjXFlBixXxEvqXms0iXLe5iM3ckS+ub2RL8xvSmgqRXINeJWbl8wXE9cvqExEY02z
         fAqvO+y/8nrXRwP4RDlG3ZEN1n8qEW1+RBJL5DViRJ00OISOOhdb/kso38dulH6XYEmA
         uVocygQRR3C2bczwTxCo/CzICw9hjP7EqrUmJ98QC3HZZbKL1lF14/yQXWm08seDF1J/
         xR3p6wjYmf8uVDT3mj4hwGMn3sMc0wllwC0LOF7i9atFeTfI2DY69oX4Q0e9KYaJkXfd
         f1xA==
X-Forwarded-Encrypted: i=1; AL+hErGW9AA4HDH8z/B39vpxrBzX/JketjRCHmL7HRvr2/A8zM0J4o3Y7IcMtuYAXz6eZGUjAdwYz+A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sDjYSXpvJrp/Ozagb8+8X2wMnQf+P4xJGBA6sM2/hCckr3s0K
	q0JQEDhaWWMR5TeJxsWM4WQasqc9YEJRZs7k/Gc7ZEVzWKAqZ8mMINmy6KdrsZ7E7wrp
X-Gm-Gg: AYBFou0sbBb22I1JH1ZFDnD7xC8a/BEXXJEbzJJlNzhXZVyiZB4/kkZbVYSZ0wBBlNj
	RxdkL8ZXnSh1ApFtA8g4qDvO0cjH/1FUGtF+tcZAUn+V+AhbLuiOtZp3xuZIxhNrNzFzg3TsjvB
	14gMNubjsMFZc5qRVB9hiPy60GbMUUAUKwmloriLaKr1TXDQPmInOyksD8KQbPkLnNMOhgcba2X
	PW704NX46shdo1t684930U37PQQG8zqMKiRLXSBiYKJ9i7maxAqksCOgjw3b3jlYRKhpOcVHkCA
	20EK9+Z6bnqVvjH9j5diGCnhuwLxmboh5H4YIXr9NXewch6GvJYhmxrxQblNkLFn1NJzY0JZujD
	oaXtiGnLZAnEJD4nq/UjCFLH0A37hby+oTasXD4ztulcRs/nvHtBTj9BCf7CjJM2yN5PRtHgbKm
	kQ5yWLxZbZl/Tl+Ad/JJw2Y96D5WcSdeQJuFY38V7P8UqSkobG7zykIP3RNPFeBv1xhTMzmrwPc
	Vn2/NKkGhVnGFIQvX4SZy3MiNfoljYxoSnhRtfl/AAaEAYvTBHQVwTqMb6duphR3IIXn5PaRe57
	f5WnAwmPR0ckV1Z015U4Dtq75YZEpP2ts+ms8tmT/yrmxJp5A+4PmsvuFD+/LkI=
X-Received: by 2002:a17:907:ea93:b0:c41:4c20:5a80 with SMTP id a640c23a62f3a-c50963bdb9bmr198299566b.44.1794563698514;
        Fri, 13 Nov 2026 01:54:58 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50957c6c1fsm75151566b.0.2026.11.13.01.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:54:58 -0800 (PST)
Message-ID: <b42c9f4d29a9cbea66929c95cc8f736f12703c72.camel@amutable.com>
Subject: Re: [PATCH RFC 01/41] loop: refuse backing files that aren't open
 for reading
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
 linux-kselftest@vger.kernel.org, 	stable@vger.kernel.org
Date: Fri, 13 Nov 2026 10:54:56 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-1-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-1-4c998976c6c7@kernel.org>
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
> loop_configure() takes any file as long as it implements -
> >read_iter().
> Loop itself never checked whether the file was actually opened for
> reading. Buffered I/O went through vfs_iter_read() which refuses
> files
> without FMODE_READ. Direct I/O has called ->read_iter() of the
> backing
> file directly ever since loop grew support for it.
>=20
> Since commit f2fed441c69b ("loop: stop using vfs_iter_{read,write}
> for
> buffered I/O") buffered I/O calls ->read_iter() directly as well.
> That
> commit was about O_DIRECT handling and the FMODE_READ check went away
> as a side effect.
>=20
> So whoever can set up a loop device can read a file it was only
> allowed
> to open for writing. Open the file O_WRONLY, configure a loop device
> with it and read the contents through the loop device.
>=20
> Refuse backing files that aren't open for reading. Loop always reads
> from its backing file so a write-only backing file never made sense
> in
> the first place.
>=20
> Fixes: bc07c10a3603 ("block: loop: support DIO & AIO")
> Fixes: f2fed441c69b ("loop: stop using vfs_iter_{read,write} for
> buffered I/O")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/block/loop.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index a3325ceab484..c96e35c3ef42 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -528,6 +528,9 @@ static void loop_assign_backing_file(struct
> loop_device *lo, struct file *file)
> =C2=A0
> =C2=A0static int loop_check_backing_file(struct file *file)
> =C2=A0{
> +	if (!(file->f_mode & FMODE_READ))
> +		return -EBADF;
> +
> =C2=A0	if (!file->f_op->read_iter)
> =C2=A0		return -EINVAL;
> =C2=A0
