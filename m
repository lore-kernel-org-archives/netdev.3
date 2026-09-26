Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A629539A06A
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790405040; cv=pass; b=fZErl/nkBFtqTi35aeVMyElZMxAF3zwi+Ku0x40t4W2LK3t3Kx5HGw0n9G4zH4NyLS98/zmDhGHrHYEC+dpVMJqOLsnawe4XZg95z5bNavIa4E+mHvUX+AR9rtGaxXCd3bSJ4K7kgWyNuxitY9PmL9k0UVAHTiWeaygUPGo96Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790405040; c=relaxed/simple;
	bh=L/x/MsSpsPMPwv6hmc9szKtWP8yzSBXJpWyuSwDuuXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dvtb74dLQUlzyTEX9Gy6Ycv5E43ZEdOOq1lriZq04miW2xA8j8HHygOj/tDy3ISEEmzfsZdzq4At3Ov8KAlsnc/AG3tvGrwzEcWtTPCZ5n67kPzSBcdSnHADsIqN1qAuLCt+cP2z+oBemgHP1tGeIqoi49Wh3ndiYMEC6vaOhl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jq6u1nQH; arc=pass smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jq6u1nQH"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2afd63c3e0so105585266b.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 23:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790405035; cv=none;
        d=google.com; s=arc-20260327;
        b=PIef61TevvlwhNJoziFOkayTuijRhv9ZvwJ3b/b24oGZ4B9nTJgxGcCVV9wE+FrUf9
         YMNjCb6DvfbRZLa/WsYbT9JzCK5AaPucSMNVA9GnPqLWtA6tY0QYyimlAhqYtb/IuZj+
         3zxZ1QvqlAM8ayUpyjMaIN1D5HoBq6KcCW+xKrmMb/UV2ZZn7GbIbNnuWiHidQQL5oKJ
         1QL1Pg6sVh8P8rOcXqkj3EWGktVrLNBaU5cbwbxypFzCDIqjGXFJwB+k/mIY5ffxOvCp
         S7NeF/2GYYVAtFsu0/bEPwaD76tGG8UmQKAGNKVFpyqqneXAhGHbQe2nUBQ792UK/oOp
         1fig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m19pIzxq/CLGg8+DYWn+q04ehTCniHZwasxO+AvM9gw=;
        fh=3dgGi2AwbRc8RCcBEmf6J2ddM6So3q5iNV0dhp6mSMo=;
        b=M0vt9VkhFUHKj16rjLDNN/5hl0DUkM1CuqvwOGBVmu2wUuRCupcH//qta7UzKxIwyj
         ysCYqYLN1p6edfzW+yDnSEacfSEUotcHrxAgyk9ZTOa5sWhNssQ7WPVfaXngspUb3JhW
         MBIqbf0saApPy5Q1hhkpsvdjWYlP2HAPCpKSMYbCBGuXhJ2F6gUqIEiFTSNzFVq3fj4/
         tQc0m4zpmgASPcYS15obk+ttZceh96BCDkgzld3GodIEvdVxkZHgBuDV1IJPhpEd6Mi4
         Zmho9F/nAhiNXGYn6QTZzGWWdmwriGUNTAOKG57/E0gnTO9GYuYrmrIDLlfStdLG+vLz
         LQiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790405035; x=1791009835; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m19pIzxq/CLGg8+DYWn+q04ehTCniHZwasxO+AvM9gw=;
        b=jq6u1nQHEYh8t9O/sL0lF53go1obYIzbU7c7HNlYeQH6JvuJRyEJSUrjEB/vOwo5qn
         uesatFnTPfnN9YvYFfBYym7F7JiJRFYkhGITALnNd7wAiRc05YDg4c2dm7GCqBh847BN
         y/exse6jDQyJdgVdzyMDoQu7q7oGTaFCqvoms74GWosmPkhj74h2bzkmK4xF9F6NvKqG
         GoMxX56VXXgRkRvvT3WP7p1PwjsPBmveAxnSTuBVUM3vPcfsLEPQrCulGfBQwlw/zIq3
         oUQjLs7hMkYMA6mxlhE1ypwRyDOfoyXnM0I7O63VKA41BHrDa6luVp51BfAEmALjmToN
         EPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790405035; x=1791009835;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m19pIzxq/CLGg8+DYWn+q04ehTCniHZwasxO+AvM9gw=;
        b=e5yU/tgInEl3h9UDwB6+/osPbVb+3rcTu1MjMRBijSbd2QB+M+3F2+ORPjP6KsVL+i
         rzvaRdX8vlFmJMMAAUS/EMV0fZs96La4INsX3kA0trTRglKX3Wddnx0w0JwayQC/bSks
         i/owQo29LKn+sdP3kfRoQQ3IbGmYqAhkJsj6SYU5LtRo+hm1l+F87D7G82TpFc58L0vL
         HFt0b0LdffgfqeFQcETTuyPS6QrND7IcZXgutVukMlrM5jKIARm2P/bKePNl1G2k831p
         1231bFJNPYqLgIndnSzcMJJvIGyQtXNV99QWPkCctY4kSUsx4HpKRMvvTxIFd09+E4uu
         +ohQ==
X-Forwarded-Encrypted: i=1; AKwUvByIgiAUYSnwlwM56ln0X3nCgcXqry3KdYppewfCGuib3erh2oMyCM8MiN4WrvkX7QAvT517FwQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l/ANksspWmhJETKV8G/ff5IGuRVd4AYaRO6g3lBLElJuDAp2P3
	P07bWT0u3uN21zMTWLrzJAQujcwbuXfvcadhs3ODisaiKlyn55EhWMj/S6YkCPoZWDftyWAwWAO
	8Bohb084QtozQiM7knaiGs/TvoT5fU7E=
X-Gm-Gg: AYBFou3LOARABJthmKw3tW8RHakOoGh4/crQM2/ClgM2Hu4/Von1vRY1P6X1Fc8KHax
	pjh58CEa/8LYsxp5LLJyRmfE9c1NkAKn5oEjTzMH56S9uhkKcJ3hdlwq5Ikmz2yggPbzlvho7Vl
	YaH4DXnLwjJseBzFowYS1fK8DKz5/TWRdscd31zJgdxYpi7/A/TvETZ4Ajx3387R7T2FUZR/zyv
	HwVxCuQ0sHDQktPqWBJIlsj6KwGhXswgtpnZQs4a/ycNsLTVf4mqOaO2nkS/HvAT+nrC+OMbr/U
	isqDQ4qM6kO8mPWToJWzd2UJsimx5WFWNM1FXBSkXto8ym6qozQ/lk44w6oKVKZJqfB0+P/YKLm
	gngtuD8+G/CXB30iOOdV6o3I=
X-Received: by 2002:a17:907:d408:b0:c29:3821:ae6c with SMTP id
 a640c23a62f3a-c2ac2606943mr702009466b.37.1790405034922; Fri, 25 Sep 2026
 23:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922122955.69433-1-fangxy@xiaopeng.com> <20260922122955.69433-3-fangxy@xiaopeng.com>
In-Reply-To: <20260922122955.69433-3-fangxy@xiaopeng.com>
From: Jason Wang <jasowangio@gmail.com>
Date: Sat, 26 Sep 2026 14:43:42 +0800
X-Gm-Features: AclHuK8xFsvc4j73hXtI-ilJ3XzgO5FqQXk1LCo83q1Fcp__nagIQq7skCOkqq4
Message-ID: <CAAf7B_NbjMu-9CEPwN2HD8+P=L4Nkk=tYO7Ga5-dHq=CVneBwg@mail.gmail.com>
Subject: Re: [PATCH 2/2] vringh: add regression test for cyclic indirect descriptor
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xie Yongji <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	stable@vger.kernel.org, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 8:30=E2=80=AFPM Fang Xieyan <fangxy@xiaopeng.com> w=
rote:
>
> Add a case to tools/virtio/vringh_test.c that builds a top-level
> indirect descriptor whose NEXT points back at itself and checks that
> vringh_getdesc_user() rejects it with -ELOOP.
>
> Without the preceding fix, the walk re-enters the same top-level
> descriptor without making forward progress: count stays flat, so the
> traversal limit is never reached and -ELOOP is never returned. With the
> fix, the top-level count advances on each re-entry and
> vringh_getdesc_user() returns -ELOOP once the traversal limit is reached.
>
> Use index 1 rather than 0 for the self-cycle, since returning from an
> indirect table is only performed for a positive up_next value. A
> self-cycle at index 0 would instead terminate the walk and would not
> reproduce the bug.
>
> Assisted-by: Hawkeye:GLM-5.3-flash
> Assisted-by: Qoder:Qwen3.8-Max
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
> ---
>  tools/virtio/vringh_test.c | 41 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
> index 84961b9..2a5d7f7 100644
> --- a/tools/virtio/vringh_test.c
> +++ b/tools/virtio/vringh_test.c
> @@ -458,6 +458,8 @@ int main(int argc, char *argv[])
>         int err;
>         unsigned i;
>         void *ret;
> +       struct vring_desc *ind;
> +       char *data;
>         bool (*getrange)(struct vringh *vrh, u64 addr, struct vringh_rang=
e *r);
>         bool fast_vringh =3D false, parallel =3D false;
>
> @@ -755,6 +757,45 @@ int main(int argc, char *argv[])
>                 vringh_iov_cleanup(&riov);
>         }
>
> +       /*
> +        * Regression test: a top-level indirect descriptor whose NEXT
> +        * points back to itself must be rejected with -ELOOP instead of
> +        * looping forever. Use index 1 rather than 0 so that returning
> +        * from the indirect table re-enters the same top-level descripto=
r.
> +        */
> +       ind =3D __user_addr_max - USER_MEM/2;
> +       data =3D __user_addr_max - USER_MEM/4;
> +
> +       /* Fresh ring and host state; resets last_avail_idx to 0. */
> +       vring_init(&vrh.vring, RINGSIZE, __user_addr_min, ALIGN);
> +       vringh_init_user(&vrh, vdev.features, RINGSIZE, true,
> +                        vrh.vring.desc, vrh.vring.avail, vrh.vring.used)=
;
> +
> +       /* Single-entry indirect table pointing at valid data. */
> +       ind[0].addr =3D (unsigned long)data;
> +       ind[0].len =3D 1;
> +       ind[0].flags =3D 0;
> +
> +       /* Top-level desc[1]: INDIRECT, and NEXT loops back to itself. */
> +       vrh.vring.desc[1].addr =3D (unsigned long)ind;
> +       vrh.vring.desc[1].len =3D sizeof(*ind);
> +       vrh.vring.desc[1].flags =3D VRING_DESC_F_INDIRECT | VRING_DESC_F_=
NEXT;
> +       vrh.vring.desc[1].next =3D 1;
> +
> +       /* Publish head 1 on the avail ring. */
> +       vrh.vring.avail->ring[0] =3D 1;
> +       vrh.vring.avail->idx =3D 1;
> +
> +       vringh_iov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
> +       vringh_iov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
> +
> +       err =3D vringh_getdesc_user(&vrh, &riov, &wiov, getrange, &head);
> +       if (err !=3D -ELOOP)
> +               errx(1, "self-referential indirect: %i not -ELOOP", err);
> +
> +       vringh_iov_cleanup(&riov);
> +       vringh_iov_cleanup(&wiov);
> +
>         /* Don't leak memory... */
>         vring_del_virtqueue(vq);
>         free(__user_addr_min);
> --
> 2.50.1
>

Acked-by: Jason Wang <jasowangio@gmail.com>

Thanks
