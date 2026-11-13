Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573426;
	b=v7Us6ppBdKSsyDL+0FGIXfub9oYES8T1aXOiKxZZYtKTgNsd5kxquqdw0mfn03VPzwS3
	 s7AmFXDfYjfp9lUvKmfKKJYPQGbL+TvuVTbw/383zA6/oSaiV/HvvtYefFegqueksIQoT
	 3nGKX/p/2Wx8/3/h8Y8RG+Pxi8XD+GW293qNqf4HG8vD+tNiR8y5lMQedhz7AdSSpSFm0
	 UB1Y2I0YkclAmqOfkDdkOWrJ0VrdHnLQj9vDkiDR9P6SKvBlRrYH1haNXUTGyPGBRa4SK
	 Udm6L6vBHMoGUfNE706osa4e+O+jIjX/KpXizLWZkKn5zRHDlC90VgNBt/Siwgrf1bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=;
	b=UQvfU55WQGHFIrc9RmlLUpBWnQeadcp/I5Fnb6YRINvh5kBHzzyGKfK5RBA7hJPhNN18
	 p1Xa7MDl24YwAiVA6Js7UztKF/AMylW77PtOl1z+l1Fsir8IN7pUUyK0dByZOR2vfyh+B
	 W/q7NktImS3Uue9d5Vn63qtKYvXux4KZBSO9X6aaloAnA6BaJc7rPfr59dFtrbsswQFsr
	 jNN8EeP+Y9/V1j01vTPTzLeeHVy49bsafeQwkMk4TjpLlJ34rCwZXx6ZXdZSWGjyLXIqf
	 Um0TjtIvJV63/PvFx06QvydcUKV897ZuYTaJO4gHp+Wq9g7WV7rjb8xjR75qZa0WLgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n2XPHptJ;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6E0606A339
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF6E0606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n2XPHptJ
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4b886ebe069so3303865e9.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 04:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794573423; x=1795178223; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=;
        b=n2XPHptJWAiGnWBjuWK6g5NkFljgiKFcabC8Vn0J/U7Rs5oCxIs8ae//bm8icbKFtW
         GhaGag1Xoi7ZyXwdHESo4gzqQGVIFHJ4SWyDVffZrMrzihrR6J8Y41NroO1pUm4S3UEM
         GevRMV87lpSFNCzDE68IInZGbL5X+gYDk7IApotAPKeUo9xOfBbHGBSC5mcggp0KJBcK
         Nc+e1mR1SmgmgC0Frha4Bk72pKDTzd14yUseYASwtvG8qZfbG+gNn4GmoQhA8ODET64L
         X6SskqZIriPJvj35d5mhI8G8hobVKdLKjnxeG6bMHAYcCPTjUD9dRkaaJK3nWVTXV/IA
         bDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794573423; x=1795178223;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=;
        b=DJcN3V36dDV5M58Yo90DYRrkHki9HZxQ6P1uJsQVRY8Tf/gxVptyv/m0Ox7gDsWbOJ
         0NRN9QXT402BJnYXdZfvlGjM5yIz3xStO6KSaWnQantRKXTVqpHo9ty98fo5NzwyaMWN
         YWO+n9H7COuuEHvuqQ5zAPh2Xltt4LdwoCImqJxQVKjl22asUQfVlWpm91L494nesjOd
         0qdXUcKN8bLg7VV9OnLYsJ3TzoeBbKOLQ8SjPZRdmpK5wgdll7tSp/aEv41XFWqa6FZu
         KaXXy6XBclMP9p5ZcmcaE9lQwphDGSpwG3/PNlkXa7t8rPMXI1m/cT3zNdc26rcEuJLW
         ZZKQ==
X-Forwarded-Encrypted: i=1; AL+hErFGyctwOVCzsaGeb5DhUh6l3F6lsSg0/WWwro5ihHhSsCb7+MZcSylGnfIRkzvUr3GDC0ddS1k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RwuS81jlvImZLZ1wDZyfwwwJKeYwEx55edfHYUPRfSKAiDTCb
	s3PLHQXz3Kw5L2YyKWZJs0IIunBdmf+JGxXMwj78a42sSJeFazZZe0Z3g0m+fKMjXJ1U
X-Gm-Gg: AYBFou1s9Zy996lYIXKPbpZRcBClE4LHo82+a0YbY4/BLuBFWdHxX6CiV5/acdol5M6
	CKyG+sn0GZZxxmnyuaAYGtxc1j44fCjuu31cT7ouiJy2QBISJok97aqzqfiPopKayb4I8UNRKzx
	525gwH/APqNuLnRBd7opsfBClKjD5RAzrktKPx+JeBV5JzRG7SNiotN7MQERGrHwAsglxooMotV
	1EZGAnFsMPtwTLyhNleCH+iXBzzCrpiTLUcM6J9lGLBQkGhKmxL5L8WawynB+g8uiJ7i7cHPh+N
	nOc6xVIEHJLhBKuKAPFYwmn6p9e+M7QzQihiFAENnKbAzUIY/SLnAFu4SL3pJ0Kg027eU7oUp7k
	QIZIE4w69wUsQZTntyc9vPK3+mS0UDRFGixwsitRgHlG/HhNJeN4MbDk4AHi45wCs9g7zVBguGM
	MdGUF2QBME9WvqJqG71DHjZnTBNGeHf4kQ8lTfb1UEPJUYXJAvzOtbPyo9Ac02aTWnfLTc6y7V7
	ViW58AGn+mz+d28DDkRsUoCZyedZ1fXxM8ZU+Qg5/K7h+0orN6DzTdD1P/1wEjN2r2KD1CJD/YD
	G3bMB5M16k08PfEo+4pYQjC5Pa0F+qbdAmwcOYRUQNelfSE8PCQl5I2nHOh11wa3DRw8bI3rkJL
	rVsoXgmDz
X-Received: by 2002:a05:600c:b86:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4bb55ac4030mr49782945e9.34.1794573423157;
        Fri, 13 Nov 2026 04:37:03 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55af2901sm57437255e9.13.2026.11.13.04.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:37:02 -0800 (PST)
Message-ID: <f12140be54ffc4d1e8e4026f80c41c75cf5727e0.camel@amutable.com>
Subject: Re: [PATCH RFC 39/41] usb: gadget: f_mass_storage: refuse files on
 pseudo filesystems
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
Date: Fri, 13 Nov 2026 13:36:59 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-39-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-39-4c998976c6c7@kernel.org>
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
> fsg_lun_open() takes any regular file as the backing file of a LUN.
> The
> file-storage kthread then reads and writes it with kernel_read() and
> kernel_write() on behalf of the USB host. With a procfs or sysfs file
> behind a LUN the host gets to read and write kernel interfaces with
> kernel credentials. Refuse files on pseudo filesystems just like loop
> does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/usb/gadget/function/storage_common.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/usb/gadget/function/storage_common.c
> b/drivers/usb/gadget/function/storage_common.c
> index 75831f2c7abe..83683ade20c2 100644
> --- a/drivers/usb/gadget/function/storage_common.c
> +++ b/drivers/usb/gadget/function/storage_common.c
> @@ -211,6 +211,11 @@ int fsg_lun_open(struct fsg_lun *curlun, const
> char *filename)
> =C2=A0		goto out;
> =C2=A0	}
> =C2=A0
> +	if (file_is_pseudo(filp)) {
> +		LINFO(curlun, "file on a pseudo filesystem: %s\n",
> filename);
> +		goto out;
> +	}
> +
> =C2=A0	/*
> =C2=A0	 * If we can't read the file, it's no good.
> =C2=A0	 * If we can't write the file, use it read-only.
