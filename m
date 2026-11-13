Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564960;
	b=rH+muGPUl53t1CLd9K/jT9Yz2TRI3bMAs4Cp/4OZLisT5BcBzkKqmEXhvy2hYQyKsdYm
	 1nSwPrpHsHPklJTHXQcXdyG8YuUmVp3k7Q6nZjj2B7UxK2PHNrzAEg2EcaGpSsFjrr6YQ
	 8Z6K/ED8hri7bPBdljcQzcJyKnmEUS1Bbum1cysI+eNu3XilBnCAzKRKSFlLsCw1/TeSV
	 I0/eemb1G/ozgBjzOAA437PyLIZWHsglhMvYMBFcsUepijpkIJuM5Mi/0gTmmVPVap1vK
	 Lm3erTx7zD2doyg1WjSo08ko9RrWT70j8+/C2Odw2CYwBIl21QrIEX8pKpQ7YQFsFIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=PfCz/38ILdxPmJBY1NDzDaIsiECcLTMyKpoKPJStEV0=;
	b=22oK5CqXuauaZJQa05W3jSykTM/nlHl0dAOl5jxcbNK1lubOKxwrkTUC+RdnhtsBJkTQ
	 o1BYoAo9fc6lH9mchc+R3KwHNKW9OKheWWIoX+iuAkBY0RWnkFie0lV5KgRhTGOPzYWPR
	 ujLwCd7GhVk17ZYnp4YukzSDINlTTR32EPQ+Igq0R2dcKGWpVgBZozODxluCJ/koU4UP8
	 WD3XSrhH+PL5h1DfuQW9f7y9zpTyO9wscc+Nf1DWj6F4C0Oo5iFrc+NjOlR+H6V4iyO8d
	 OENoPvl52KbO6mMObmB0KWMI9QXwA/nJ0Q7Y676J/YWlljd0YyUe3oT9ESNwyNP2t/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lkMNxDps;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF79606B105
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEF79606B105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lkMNxDps
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c506094fd93so151136966b.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564958; x=1795169758; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PfCz/38ILdxPmJBY1NDzDaIsiECcLTMyKpoKPJStEV0=;
        b=lkMNxDpsxePjk96S0ywzwnWUXxYio8wx2cNNe0nC6j26qPYCKZTFlNU+9IrTfafYUJ
         vVJYUkmMgC1UbEefAlU1yHOjVK+ZyaavdAq5vDpOrqfNUQTfZSYOp+z5MtAN0fGM0C/g
         WKoVDnfAgRrvHWrOgLujvGV7IRsdQm2D1xIiTvFC1PPHHAhefB4+1EzNQGHJZGVEqqG3
         mRj5HPfDo3Do87jK8wkSwQeESRRW3NHA44wwS7GSfUWi+U+GxhbfTaI9vHs9ExXVB/2E
         aEkBTT5WDqLpZOCj3LhS4i2xxQF422KmjG442iJAtFRLE9RsLg4/ErcRXtOWPDB+ahLm
         /22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564958; x=1795169758;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PfCz/38ILdxPmJBY1NDzDaIsiECcLTMyKpoKPJStEV0=;
        b=VcBZS63lU3QYUqBpMAy7ENElCMk3OLnlrCP+qPvsObEHipJGQlrgEIHNSiZ7CtTyQd
         PMnHQTP/JsaWmDwVcBT2X+D3OzZKaQ0DDIpH8KIKDR42PJAX6BrPRTmdyQkV1QPDc35n
         +aBKFh+Yd1o3Of10EqJq+v2w4n3uh7TcOsOKzhPhuGpksLixRZQbRo7wrXdHoW1+SsJj
         bzWKANDl2sFR/Cq88Ovn9bqo6+Wu7QtwM7/+VMM+FY3mYjtpLXB6kcS4jy4nYEGF7E+t
         85vFc9sbVl7CvNWzuyolXF/+ikhlqQPk5hHeR/rDqMD25U1d51nZ7mGlkyt/2J6NSC0O
         +lIA==
X-Forwarded-Encrypted: i=1; AL+hErEfCaM+h7VH07BWsKNVLGLK+nFoZpA/BYlsjuHXtN+xbCmcKaNKi4kCa1NNd05SnpNCBqcYhsk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dVgXCQhBTZWJueDFR4DEHmvRqMz/fxBT3Qsvl47EC8snaWfRg
	kmAHr3ya+UxnCe9+ZSzk7Ic4BtJiKZdEUvM1naFB14Og6pdP3bLIl+djw/oXI5Dajfl4
X-Gm-Gg: AYBFou1944QCOu1DSqVcVxGMfrV+Wp0jqbf+mItARhyS7/vzCURXkVxw3r90vgOk5BI
	wzF1Mff4LEQgDiGmWJ6bphQyLRdjlx1Qa4HICt37RWr3TGnfJe8nJ58wXqaxxr+xJ8dpKi4xMxA
	8PPrIIIYq6Vyv9nnVJXzvPkUCuCZXI6g9IiKMHbSzwFFPo5azpzyKoEdrvr3+2qEpA7ixNAHJMr
	4tKymXXGCJGGMSL0+F9Xl5UrJBbDA/SzcwNjzY31bZjzq8seQb7n+5sSLy5WO0Luhseky8YIepi
	/TzBorGM7gjsdfBYk3L5uFop+ovNXNlMJiR5R7LJPBTEWXjFzqxsdXJ63aOzOeOsZiwpUAviVk+
	g/8xOkr2zv8yF2ryg3nCtc6uzO0bfrK3RuaIdPIwlh1PlFoKyVtLdFWyunRdvv7tQ3iDDs5sZ9N
	g+ACVIPuGi8mhWlQfNgIJI3QfYn9xfjblqbdX5LzQZZ3TR7uJxGlCFjYRzbTbcKua3bu52Uj7fV
	NO31ehKAwF77DOSV+zAqAOGyZpSdA+ChclEGdcPf1tSt6XSYJUBWu9GNhzbUwB0nuokLJc4tR/2
	n6rGU/pD24QxVQzfIZNVNI2guhgFgIbQdEuQIiZDct4VH1GZH3AuuMjAcikYuS4=
X-Received: by 2002:a17:906:f59c:b0:c42:102f:15f0 with SMTP id a640c23a62f3a-c509614d4c1mr171873666b.3.1794564958075;
        Fri, 13 Nov 2026 02:15:58 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b7d1b7sm75606066b.74.2026.11.13.02.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:15:57 -0800 (PST)
Message-ID: <c5a694991af7e9182fd475a20bf4cfd73a13e395.camel@amutable.com>
Subject: Re: [PATCH RFC 34/41] loop: refuse files on pseudo filesystems as
 backing files
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
Date: Fri, 13 Nov 2026 11:15:56 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-34-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-34-4c998976c6c7@kernel.org>
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
> Currently loop accepts any regular file that implements ->read_iter()
> as
> a backing file and any that also implements ->write_iter() as a
> writable
> one. That includes files on procfs, sysfs and other pseudo
> filesystems.
> For example, /proc/kcore attaches read-only as a loop device the size
> of
> the kernel's virtual address space, 64 PiB with 5-level paging. sysfs
> attributes attach read-write as 4096 byte loop devices. Writing a
> block
> to the loop device of /sys/kernel/mm/transparent_hugepage/enabled
> changes the THP setting.
>=20
> That's not just nonsensical, it can be abused. Loop calls -
> >read_iter()
> and ->write_iter() of the backing file directly from its worker which
> runs with kernel credentials. But pseudo files enforce part of their
> access rules at read and write time against current. Dozens of sysfs
> ->show() and ->store() methods call capable(). Behind a loop device
> all
> of these checks are done against the loop worker instead of the task
> that opened the file. And setting up a loop device requires no
> capabilities, only access to the device nodes. So on v7.4-rc1:
>=20
> - uid 0 without any capabilities can't write to
> /sys/kernel/reboot/mode
> =C2=A0 as mode_store() requires CAP_SYS_BOOT. Writing "warm" through a
> loop
> =C2=A0 device works.
>=20
> - uid 0 without any capabilities can't read the files in
> =C2=A0 /sys/firmware/dmi/entries/*/ as dmi_sysfs_attr_show() requires
> =C2=A0 CAP_SYS_ADMIN. Reading them through a loop device works.
>=20
> - An unprivileged container that was handed a loop device can't
> change
> =C2=A0 gro_flush_timeout of its own network devices as
> =C2=A0 gro_flush_timeout_store() requires CAP_NET_ADMIN in the initial
> user
> =C2=A0 namespace. Writing it through a loop device works.
>=20
> The same goes for hard_offline_page, the md and sd attributes, rfkill
> and others.
>=20
> Refuse files on pseudo filesystems as loop backing files. Note that
> file_is_pseudo() looks through overlayfs so stacking overlayfs on top
> of
> sysfs doesn't get around this.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/block/loop.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index c96e35c3ef42..1482580a1979 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -537,6 +537,9 @@ static int loop_check_backing_file(struct file
> *file)
> =C2=A0	if ((file->f_mode & FMODE_WRITE) && !file->f_op->write_iter)
> =C2=A0		return -EINVAL;
> =C2=A0
> +	if (file_is_pseudo(file))
> +		return -EINVAL;
> +
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
