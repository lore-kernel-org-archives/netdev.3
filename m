Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4AF35C6B4
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973681; cv=pass; b=i2hDhJoOqjJqwqeeaJXWcXyHDDjCZ2ZD8OpDeJetmcEROGhfLRVuv8n/Qu/+ZAmk0r0sk6sTJRLdNxqZ4NFUnYF+Z41tU+eSRUjfOYvmLJW5AG588oR4h1XXfgcRVOOcfc25fN3D6Lss7dX+JaWPIxJeGIc+jcG49eAAx72hpFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973681; c=relaxed/simple;
	bh=bzrElJCwL4G7roTrTT2sArSldH7To7o0gXq+eDk1Tr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJV7ZYVtAtk3PjQFUv3hmTWzEQZYu0KuZ2vzYaqylBeuUIsh7P70vcQ+YtbKIaBqhLvpnGHKEubs3SQkmIev10NAtlh25914D8mhSxGJZZIXMc887tQ1tDK+m/3tsCvcPu75kzB6XG1mzJ5ahr+F4Zi0IadJJVSUOcjs8Cf4Q6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=tcBl4ykK; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="tcBl4ykK"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f38so12430725ad.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 10:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788973676; cv=none;
        d=google.com; s=arc-20260327;
        b=QrhYsN329qHb/fWTYKZb7RGTx6W3dma+djGMbN3RAuLpSfZ2eI5tc/nNhM91trqYbJ
         tq3vYuYc6ld/sAAn6MqmNo/N17qK06sEG6hqHV+A0o7kJOw40+OnawMEcUOSjQYmI9Ak
         EL40wcQbojJNZl1joeFe6OJNNMAjWJn0mGCSl05mPvwxzqpBCp0zuIc1ScUzQpjoqMfp
         ZDCDV/hLVLrhMoT2iy1JviCZmGcZW4IJd/Jjbe4eNY40y9xrA97IX7fbTM3Gu8dl7Z6v
         9BwF+R9hQ5fUg1xOwoUNalacLC9vJexDOLmgVCjDMO+xWIQGIE3vhKVe+EtKT/W85Hm/
         iuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vpiZKdH9/3gtM/46eDiyEezUXTTA7RsQdyhkG7qhBOc=;
        fh=5NSk+hn0qOBEtp8aeQYxVmuLPrOJMxMLWdEv8zoa0G8=;
        b=N+WO4OvCMeb8KTfHWGnR/98Dak6W80gIqQmTCsSWwbRaXP2cdMOJofaJt4KhPz5ViZ
         jzqWbzRIMtk9aJ2N2LGS1JIGpShE4n32EeJFlPSxw2MNfteiTpu05rrJZTbCbxKggw2S
         O2IN3HidoZ9ZOEfuCu1/1AL9DEtlIdVI3CkJ6KCFzN+QlvgMvDUhF4TlrlouaJaA9yCi
         NAn6gGeoYWj8eaBgjo9itLqzdSA9LL3s6hOaYtn+FBGxBWu1Liq1uhU03w0oWBam0CUm
         NRQqIAk3bOwX2cs6iQJSGC8FcifCaykdQUg9J0NYXeNF3dCM23raAsgpaK/X5mBRB2Y+
         Os8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1788973676; x=1789578476; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vpiZKdH9/3gtM/46eDiyEezUXTTA7RsQdyhkG7qhBOc=;
        b=tcBl4ykKHD3fq+vKP8kZretQgPH4tXHLyRqFNL2TVF9e/uaiwMbl/PkKuG6Yvk0tSf
         UQYIaeV7QDaROeUyRVVI+xxYSd6qx//2JDYGZLtmXVhQAtRR+CeDhZzCKWuHakyYMeaf
         LKL0KRqlTOO1eabNCBRR5nR6kZERwv0O4VNSVsnRIsXBEnQ66s88PePwacA2vVnNzcsh
         fieXos3zz6Ry0kOWy9MybIxSd8foL/GCghFRt84aK7eS3lIxjF8T72Ku0j34S26Kv4EC
         eNLzmtQ/bm8UjLIVluZzHUBtjRuK2anUO39yE+cE9HrVcFwv68G/r4QzWxNOwoY3gHI2
         3WcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788973676; x=1789578476;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vpiZKdH9/3gtM/46eDiyEezUXTTA7RsQdyhkG7qhBOc=;
        b=EZRlIuG4dVVfZI2kduASBHUxzgcOcUJzUG9U6LTZJVEH5Vz0p5W5hbMSUBFKjsDzVl
         Y1y19xwrWAR6/6FkSPeYt4tWZeikdzz1HyX7hhn7HkM9Arne4gJqL9g+2b4u4NRVF4od
         a8ZFE8R+nlE54va0Zhknx8Hmb6TGIoUxAb4AFXnmENT8rhD4yWDl8Py3XBqHJgCFWBox
         7bVGGYjf08AKgnv+MK/uPo0yVQ/LCzQKUJBujWfNO/Kc39Arn0RHFO2VcPyLc8TcCXC4
         gnIUpOtwTpwLWBh2HzkVUrc1g6sF/PClNhpwBv+Bt7nQnf7su3orKtdPJIfNC5KaYzQI
         XOoQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6MhSFXtv4UNbnvnYzi32dSY3lpCnFxUJYDW3u4oPPN1MLs6qI/pOyJoRKRQdOQOjv9mnShB4=@vger.kernel.org
X-Gm-Message-State: AFuF++lV2T3eYRb1VjqcOnxM0YxUV0tCJkN5a8G6P5DdYRUqF81k9q0R
	3BJzfPa4dB3aqVNiR3xus2g6GZUi+YIfBVGfWjMDXRSWbZSt8mpDxpb4tVWlQHFVvRGrBfhpP3G
	DgrswoEQaZlVTahT/fmqxPFB+T+wjTUJbqelZTU5a
X-Gm-Gg: AYBFou09LeQ6yG9zZTkTDMwTAbnMiO7e3nkBuVr2or2UuEOkgOaz7/OXe90DBrdTjqM
	Q0qEgZBih8KyB6H2RdHDRgut7NqiopwJLvzXsw1ZToXOZc9lklDa3pti9TTTncDfL/vbyOHybSF
	tRFZfbBJmIOXeAEyRdMt07Kfwy28Twsm9qjYgOj0qcYSwqGyC+iUTd0VpblS6T8W7eVu/PJ+e5V
	b4e0+Tm+8KgAJj+SjU2Xrctp0IGp86A8+G9rp2gyJPRnYJy7csa1AN4MtZ7Mn2p8Du6Yb6xWHkF
	iIxmNVZ42M3QFwoIJfVrXmb47W2Qg/EpCqqQOKND5RuJkHizh7LO1Ltannnl9HXDQxX+08Sg4My
	+yBZLLtcAp0BZVN3WAuWBkpQdaAkn8L4qv/kWp8GS8+ECdQ7kbZc=
X-Received: by 2002:a17:902:f78f:b0:2d8:d4cc:be62 with SMTP id
 d9443c01a7336-2db8de9b5e0mr97047485ad.15.1788973674079; Wed, 09 Sep 2026
 10:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+0ovCgforg-XzdODxh9axazFP8M+hFj1wk=XE05oSGz9B2Zzw@mail.gmail.com>
 <CAEAWyHfU-yo+H6Ss_wXPSzMnsU+bd9EP8Jz7bPJ17xvj2Kc6Yw@mail.gmail.com>
In-Reply-To: <CAEAWyHfU-yo+H6Ss_wXPSzMnsU+bd9EP8Jz7bPJ17xvj2Kc6Yw@mail.gmail.com>
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Wed, 9 Sep 2026 10:07:40 -0700
X-Gm-Features: AcwNN1WNc2HaR-arU8CToz5M3pkc38CE7sE3jOaPreBSKGxiN-dhXdR6eM_6xS4
Message-ID: <CA+0ovCjyMrHOtOSQ9xHzsTz=iO3MVr8RcsgxNVBmge5yczpURg@mail.gmail.com>
Subject: Re: [BUG] gve_adminq_release -- unbounded reset-wait loop, WARNs then
 spins forever
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: Joshua Washington <joshwash@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005c0f6d065b0fe48c"

--0000000000005c0f6d065b0fe48c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attaching the reproducer; thanks!

On Fri, Aug 28, 2026 at 1:53=E2=80=AFPM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> On Thu, Aug 27, 2026 at 9:23=E2=80=AFPM Farhad Alemi <farhad.alemi@berkel=
ey.edu> wrote:
> >
> > Hello,
> >
> > As part of the kernel research at ASU's SEFCOM
> > lab, we hit the crash below. Crash reports can be found here:
> >
> >   https://github.com/farhad-alemi/public_bug_reports/tree/main/129-gve-=
adminq-release-unbounded-reset-wait/
> >
> >   Unrecoverable platform error!
> >   WARNING: drivers/net/ethernet/google/gve/gve_adminq.c:378 at
> > gve_adminq_release+0xff/0x260
> > drivers/net/ethernet/google/gve/gve_adminq.c:378, CPU#1:
> > syz.0.63/11869
> >   Call Trace:
> >    gve_adminq_release+0xff/0x260
> > drivers/net/ethernet/google/gve/gve_adminq.c:378
> >    gve_adminq_free+0x78/0x140 drivers/net/ethernet/google/gve/gve_admin=
q.c:392
> >    gve_init_priv+0x2a8a/0x3450 drivers/net/ethernet/google/gve/gve_main=
.c:2509
> >    gve_probe+0x61f/0x970 drivers/net/ethernet/google/gve/gve_main.c:289=
2
> >    pci_device_probe+0x461/0xa50 drivers/pci/pci-driver.c:489
> >    really_probe+0x267/0xaf0 drivers/base/dd.c:709
> >    device_driver_attach+0xdc/0x1d0 drivers/base/dd.c:1206
> >    bind_store+0x1d0/0x220 drivers/base/bus.c:267
> >    kernfs_fop_write_iter+0x2fa/0x480 fs/kernfs/file.c:352
> >
> > Our reproducer.c is available upon request.
>
> Hi,
>
> Thanks for the report. Could you please share the reproducer too?
>
> It's a good catch. The driver shouldn't spin infinitely if the
> hypervisor is unresponsive/misbehaving. I will send out a patch to fix
> this. Would be great if you could help test it also.
> >
> > Happy to test a patch if that would help.
> >
> > Regards,

--0000000000005c0f6d065b0fe48c
Content-Type: application/octet-stream; name="reproducer.c"
Content-Disposition: attachment; filename="reproducer.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mtucp8sx0>
X-Attachment-Id: f_mtucp8sx0

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8ZGlyZW50Lmg+CiNpbmNsdWRlIDxmY250bC5o
PgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RyaW5n
Lmg+CiNpbmNsdWRlIDxzeXMvbW1hbi5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CgojZGVmaW5lIFBD
SV9ERVZJQ0VTCSIvc3lzL2J1cy9wY2kvZGV2aWNlcyIKI2RlZmluZSBHVkVfRFJJVkVSCSIvc3lz
L2J1cy9wY2kvZHJpdmVycy9ndmUiCiNkZWZpbmUgSU9SRVNPVVJDRV9NRU0JMHgyMDAKCnN0YXRp
YyBpbnQgcmVhZF9zeXNmcyhjb25zdCBjaGFyICpwYXRoLCBjaGFyICpvdXQsIHNpemVfdCBsZW4p
CnsKCWludCBmZCA9IG9wZW4ocGF0aCwgT19SRE9OTFkpOwoJc3NpemVfdCBuOwoKCWlmIChmZCA8
IDApCgkJcmV0dXJuIC0xOwoJbiA9IHJlYWQoZmQsIG91dCwgbGVuIC0gMSk7CgljbG9zZShmZCk7
CglpZiAobiA8IDApCgkJcmV0dXJuIC0xOwoJb3V0W25dID0gMDsKCXJldHVybiAwOwp9CgpzdGF0
aWMgaW50IHdyaXRlX3N5c2ZzKGNvbnN0IGNoYXIgKnBhdGgsIGNvbnN0IGNoYXIgKnZhbHVlKQp7
CglpbnQgZmQgPSBvcGVuKHBhdGgsIE9fV1JPTkxZKTsKCXNzaXplX3QgbjsKCglpZiAoZmQgPCAw
KQoJCXJldHVybiAtMTsKCW4gPSB3cml0ZShmZCwgdmFsdWUsIHN0cmxlbih2YWx1ZSkpOwoJY2xv
c2UoZmQpOwoJcmV0dXJuIG4gPCAwID8gLTEgOiAwOwp9CgpzdGF0aWMgdW5zaWduZWQgbG9uZyBy
ZWFkX3BjaV9hdHRyX2hleChjb25zdCBjaGFyICpiZGYsIGNvbnN0IGNoYXIgKmF0dHIpCnsKCWNo
YXIgcGF0aFsyNTZdLCBidWZbNjRdOwoKCXNucHJpbnRmKHBhdGgsIHNpemVvZihwYXRoKSwgUENJ
X0RFVklDRVMgIi8lcy8lcyIsIGJkZiwgYXR0cik7CglpZiAocmVhZF9zeXNmcyhwYXRoLCBidWYs
IHNpemVvZihidWYpKSkKCQlyZXR1cm4gMDsKCXJldHVybiBzdHJ0b3VsKGJ1ZiwgTlVMTCwgMTYp
Owp9CgovKiBCQVIwIG11c3QgYmUgbWVtb3J5IGFuZCBhdCBsZWFzdCB0aGUgc2l6ZSBvZiBzdHJ1
Y3QgZ3ZlX3JlZ2lzdGVyczsgZ3ZlIGFsc28KICogbWFwcyBCQVIyIGFzIGl0cyBkb29yYmVsbCBy
ZWdpb24sIHNvIHRoYXQgaGFzIHRvIGJlIG1lbW9yeSB0b28uICovCnN0YXRpYyBpbnQgaGFzX3Vz
YWJsZV9ndmVfYmFycyhjb25zdCBjaGFyICpiZGYpCnsKCWNoYXIgcGF0aFsyNTZdLCBidWZbNDA5
Nl0sICpsaW5lLCAqc2F2ZSA9IE5VTEw7Cgl1bnNpZ25lZCBsb25nIHN0YXJ0LCBlbmQsIGZsYWdz
OwoJaW50IGJhciA9IDAsIGJhcjBfb2sgPSAwLCBiYXIyX29rID0gMDsKCglzbnByaW50ZihwYXRo
LCBzaXplb2YocGF0aCksIFBDSV9ERVZJQ0VTICIvJXMvcmVzb3VyY2UiLCBiZGYpOwoJaWYgKHJl
YWRfc3lzZnMocGF0aCwgYnVmLCBzaXplb2YoYnVmKSkpCgkJcmV0dXJuIDA7Cglmb3IgKGxpbmUg
PSBzdHJ0b2tfcihidWYsICJcbiIsICZzYXZlKTsgbGluZSAmJiBiYXIgPCA2OwoJICAgICBsaW5l
ID0gc3RydG9rX3IoTlVMTCwgIlxuIiwgJnNhdmUpLCBiYXIrKykgewoJCWlmIChzc2NhbmYobGlu
ZSwgIiVseCAlbHggJWx4IiwgJnN0YXJ0LCAmZW5kLCAmZmxhZ3MpICE9IDMpCgkJCWNvbnRpbnVl
OwoJCWlmICghc3RhcnQgfHwgIShmbGFncyAmIElPUkVTT1VSQ0VfTUVNKSkKCQkJY29udGludWU7
CgkJaWYgKGJhciA9PSAwICYmIGVuZCAtIHN0YXJ0ICsgMSA+PSA2NCkKCQkJYmFyMF9vayA9IDE7
CgkJaWYgKGJhciA9PSAyICYmIGVuZCAtIHN0YXJ0ICsgMSA+PSA4KQoJCQliYXIyX29rID0gMTsK
CX0KCXJldHVybiBiYXIwX29rICYmIGJhcjJfb2s7Cn0KCi8qIFRoZSByb290ZnMgZ3VhcmQuIEtl
ZXAgdGhpcyBhaGVhZCBvZiBldmVyeSB3cml0ZSB0byB0aGUgZnVuY3Rpb24uICovCnN0YXRpYyBp
bnQgaXNfc2FmZV92aWN0aW0oY29uc3QgY2hhciAqYmRmKQp7Cgl1bnNpZ25lZCBsb25nIGNsYXNz
ID0gcmVhZF9wY2lfYXR0cl9oZXgoYmRmLCAiY2xhc3MiKTsKCXVuc2lnbmVkIGJhc2VfY2xhc3Mg
PSAoY2xhc3MgPj4gMTYpICYgMHhmZjsKCglpZiAoYmFzZV9jbGFzcyA9PSAweDAxKQkJCS8qIG1h
c3Mgc3RvcmFnZTogdGhlIHJvb3QgZGlzayAqLwoJCXJldHVybiAwOwoJaWYgKGJhc2VfY2xhc3Mg
PT0gMHgwNikJCQkvKiBicmlkZ2UgKi8KCQlyZXR1cm4gMDsKCWlmIChzdHJzdHIoYmRmLCAiOjFm
LiIpKQkJLyogTFBDL0FIQ0kgZnVuY3Rpb24gb2YgdGhlIElDSDkgKi8KCQlyZXR1cm4gMDsKCXJl
dHVybiByZWFkX3BjaV9hdHRyX2hleChiZGYsICJyZXZpc2lvbiIpID49IDEgJiYgaGFzX3VzYWJs
ZV9ndmVfYmFycyhiZGYpOwp9CgpzdGF0aWMgdm9pZCB1bmJpbmRfY3VycmVudF9kcml2ZXIoY29u
c3QgY2hhciAqYmRmKQp7CgljaGFyIHBhdGhbMjU2XSwgbGlua1sxMjhdLCAqZHJpdmVyOwoJc3Np
emVfdCBuOwoKCXNucHJpbnRmKHBhdGgsIHNpemVvZihwYXRoKSwgUENJX0RFVklDRVMgIi8lcy9k
cml2ZXIiLCBiZGYpOwoJbiA9IHJlYWRsaW5rKHBhdGgsIGxpbmssIHNpemVvZihsaW5rKSAtIDEp
OwoJaWYgKG4gPD0gMCkKCQlyZXR1cm47CglsaW5rW25dID0gMDsKCWRyaXZlciA9IHN0cnJjaHIo
bGluaywgJy8nKTsKCWRyaXZlciA9IGRyaXZlciA/IGRyaXZlciArIDEgOiBsaW5rOwoJc25wcmlu
dGYocGF0aCwgc2l6ZW9mKHBhdGgpLCAiL3N5cy9idXMvcGNpL2RyaXZlcnMvJXMvdW5iaW5kIiwg
ZHJpdmVyKTsKCXdyaXRlX3N5c2ZzKHBhdGgsIGJkZik7Cn0KCnN0YXRpYyB2b2lkIHB1dF9iZTMy
KHZvbGF0aWxlIHVuc2lnbmVkIGNoYXIgKnAsIHVuc2lnbmVkIGludCB2KQp7CglwWzBdID0gdiA+
PiAyNDsgcFsxXSA9IHYgPj4gMTY7IHBbMl0gPSB2ID4+IDg7IHBbM10gPSB2Owp9CgpzdGF0aWMg
aW50IHNlZWRfZ3ZlX3JlZ2lzdGVycyhjb25zdCBjaGFyICpiZGYpCnsKCWNoYXIgcGF0aFsyNTZd
OwoJdm9sYXRpbGUgdW5zaWduZWQgY2hhciAqYmFyMDsKCWludCBmZDsKCglzbnByaW50ZihwYXRo
LCBzaXplb2YocGF0aCksIFBDSV9ERVZJQ0VTICIvJXMvcmVzb3VyY2UwIiwgYmRmKTsKCWZkID0g
b3BlbihwYXRoLCBPX1JEV1IgfCBPX1NZTkMpOwoJaWYgKGZkIDwgMCkKCQlyZXR1cm4gLTE7Cgli
YXIwID0gbW1hcChOVUxMLCA0MDk2LCBQUk9UX1JFQUQgfCBQUk9UX1dSSVRFLCBNQVBfU0hBUkVE
LCBmZCwgMCk7CgljbG9zZShmZCk7CglpZiAoYmFyMCA9PSBNQVBfRkFJTEVEKQoJCXJldHVybiAt
MTsKCgltZW1zZXQoKHZvaWQgKiliYXIwLCAwLCA2NCk7CglwdXRfYmUzMihiYXIwICsgMCwgMCk7
CQkvKiBkZXZpY2Vfc3RhdHVzOiBERVZJQ0VfSVNfUkVTRVQgY2xlYXIgKi8KCXB1dF9iZTMyKGJh
cjAgKyA0LCAwKTsJCS8qIGRyaXZlcl9zdGF0dXMgKi8KCXB1dF9iZTMyKGJhcjAgKyA4LCAxKTsJ
CS8qIG1heF90eF9xdWV1ZXMgKi8KCXB1dF9iZTMyKGJhcjAgKyAxMiwgMSk7CQkvKiBtYXhfcnhf
cXVldWVzICovCglwdXRfYmUzMihiYXIwICsgMTYsIDApOwkJLyogYWRtaW5xX3BmbiAqLwoJcHV0
X2JlMzIoYmFyMCArIDIwLCAwKTsJCS8qIGFkbWlucV9kb29yYmVsbCAqLwoJcHV0X2JlMzIoYmFy
MCArIDI0LCAwKTsJCS8qIGFkbWlucV9ldmVudF9jb3VudGVyICovCgltdW5tYXAoKHZvaWQgKili
YXIwLCA0MDk2KTsKCXJldHVybiAwOwp9CgppbnQgbWFpbih2b2lkKQp7CgljaGFyIHBhdGhbNTEy
XTsKCXN0cnVjdCBkaXJlbnQgKmVudHJ5OwoJRElSICpkaXI7CglpbnQgdHJpZWQgPSAwOwoKCWlm
IChhY2Nlc3MoR1ZFX0RSSVZFUiwgRl9PSykpCgkJcmV0dXJuIDE7CglkaXIgPSBvcGVuZGlyKFBD
SV9ERVZJQ0VTKTsKCWlmICghZGlyKQoJCXJldHVybiAxOwoKCXdoaWxlICgoZW50cnkgPSByZWFk
ZGlyKGRpcikpICYmIHRyaWVkIDwgMykgewoJCWNvbnN0IGNoYXIgKmJkZiA9IGVudHJ5LT5kX25h
bWU7CgoJCWlmIChiZGZbMF0gPT0gJy4nIHx8ICFpc19zYWZlX3ZpY3RpbShiZGYpKQoJCQljb250
aW51ZTsKCgkJdW5iaW5kX2N1cnJlbnRfZHJpdmVyKGJkZik7CgkJaWYgKHNlZWRfZ3ZlX3JlZ2lz
dGVycyhiZGYpKQoJCQljb250aW51ZTsKCgkJLyogZHJpdmVyX292ZXJyaWRlIG1ha2VzIHBjaV9t
YXRjaF9kZXZpY2UoKSByZXR1cm4gdGhlIGR1bW15IGlkLAoJCSAqIHNvIHRoZSBiaW5kIHdyaXRl
IGFsb25lIGRyaXZlcyB0aGUgcHJvYmUgdGhyb3VnaCBiaW5kX3N0b3JlLiAqLwoJCXNucHJpbnRm
KHBhdGgsIHNpemVvZihwYXRoKSwgUENJX0RFVklDRVMgIi8lcy9kcml2ZXJfb3ZlcnJpZGUiLCBi
ZGYpOwoJCXdyaXRlX3N5c2ZzKHBhdGgsICJndmUiKTsKCQl3cml0ZV9zeXNmcyhHVkVfRFJJVkVS
ICIvYmluZCIsIGJkZik7CgkJdHJpZWQrKzsKCX0KCWNsb3NlZGlyKGRpcik7CglyZXR1cm4gMDsK
fQo=
--0000000000005c0f6d065b0fe48c--
