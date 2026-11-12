Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472429;
	b=JMuYeqTfn5Pk8z9gY2QunxWnmPTFx7difa5UCLjA8PQisXyYdxW/OYEXkBe7kBG00Wq3
	 pDZj/VJZRn0Kf7dWKU2c0Mdau8MT9vDBbNp5ZoK2vRI+ybM6MHFJnpk77FuxTnc2NnPHU
	 ggAV8dKH18HTyZkeG+NWhtH0HEI9B+m1muyxN6Tlgu1eVFHgtIHsQ0/JAE8wXVDrMozZ2
	 jEp0LKMbGwKuqPbxkEUrcOLHjFQ3QGFlfHMtj23wA+/ss+6B12aA2nE2XffPpyPt5EzQp
	 GPBTVzKlH7EaJhepTScfIEiQvf61SJXwyOOMGEl66fdo3059GXApyqbg3TFg+fMPVcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=uOYvxf+M0Ap4noHF2nmW81cSBmYvF6P+PnsYCByXef8=;
	b=xxQnoj8LZ08LQw577wYJzhJQYq2zfTYKr4w8g36hcM9uq4g0GcXPThjQFMgnLgmlCuCn
	 ongQQW9VuUlEFfTa2TDm0Ilof7v3kj3XlSLs3lW2YOFwTAEqn1oSqOzk4VZjbPCFl6G4a
	 PxJXRq2Yas1HpUGsFgyjctYXp3407m8Vigxt9lpun6uY1T0lpNPVIE3uezA7OPyoO7HcO
	 J3a7u9q3OKDLMSmq21tzeXmIxL2dWqqCBDuir+oasqAVlHhXT8gnMvuztIKElzz8D7VVm
	 wChmKUFO2FyCNvE0ngfP1WwaQaz530Yp+g2UawTq8s4Aume94YbxnaaZU9APCzMhscw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oi8b8PLn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D75606A8B6
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70D75606A8B6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oi8b8PLn
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-717080a2d50so2837726eaf.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 00:33:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794472428; cv=none;
        d=google.com; s=arc-20260327;
        b=dVCVepoi+XDCICeko8o2dDs37DKz3TVcma+Eb+ADPWc3wSMBp7LsSCdDUXv1Wtin0p
         8F9ihOFFLAISXE6wpS0OScJzJum7QCHD2X5brlYgRS52NMXTxiB4f4doevppBiodc9Uy
         nuC7LyLFkw3chlSK9Vt3CVloDOd5OCLs5+ldWpnNHZa1Os6+1s/MyQkpIPq/EuhMj/9L
         OYgyao2IdfWKkp+/S1g+qARmv2/Xbr3oLLCsGPG3Lyx5N3s1KmkRaXnkXLjggS1a1Kg5
         p3wBD/5r0l7W7uLhhlpMlTL26T677lL/0GegZIkvunAn7BJM7ZNW+7UsjVwUgiePErAq
         rcfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uOYvxf+M0Ap4noHF2nmW81cSBmYvF6P+PnsYCByXef8=;
        fh=vUIVsb692bL7iFV/YXcaUNmIAbH5pBPSkcA2U4E3XsA=;
        b=Lay7WC5MeyQZ1ylrm81VvCkVG/qlttUiQN9xHztB6QTAEoXQA7JkkZmTiPdil3diJu
         VbsQ1/CJarhmGv7mhImt4H2LMFSSlMwgE4M1st1p+ny8hzCR5ScBWo2qiF/zg6W8hASY
         C6pbraqxnREBk3Cz+e+w2kFWguB+dGHMdngzDFd3Nu8Y228WZQRDEb1jvthLrtv47tSk
         m1jox7N0VR2ucQeFk9sKWxHKVaIOqeAR19/SjItq+1eH16Sd+qC/eiy0/TSyhNmr0JzL
         dGfYOK2OHmozhtg8eR9c5n6BjSRohPPdprJ5CAUCICj2I53D6X2A0AX6cVkSuZXJB//U
         Vg/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794472428; x=1795077228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uOYvxf+M0Ap4noHF2nmW81cSBmYvF6P+PnsYCByXef8=;
        b=Oi8b8PLnrmaQ64bFFPurb/0NRJSzOTgERT3w52aHLchDiGE24NvNc053MGzsM+qWdL
         ab6xBre0Y27SWz0NmrywKH21t/466fyW7knd2Doyzxy9qhiNmu8hkmno4/lsE2WZxlzH
         22p9C4gSoYQpEuV2L4h42JiLHb7tpw27dm67IQiaIuePmeBEJg6W/XbL5OHHBuPAlJCI
         tu8qeYoLlHJf4HiWDS3uu5OIG+pmyFXb+l1gKtpZgQdPdyaeJLe6UZf8HBUW6dA3vAfS
         gdzKhEwM4a7ocp3W88w62eMBgYlyvTCne/5bB0mwVJwyZ0Rx5kM1dCLfo8OxSdQh7aZp
         ba2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794472428; x=1795077228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uOYvxf+M0Ap4noHF2nmW81cSBmYvF6P+PnsYCByXef8=;
        b=fj+6j+Qz5687ISnMxW7C8ktGnBMX8yZ1WEt2Z/8TpbT6QnMfzwasMOMxQPaME7H/Yq
         wqGuQa6E/ZE1XhYMWGZNKIYdAXkcuTSMllnNF2sDgzpU9FyXLMCpivDYUS8BtZfCUpeU
         Prsp7LwJeXV52RrV6VBjrpYEBmgt06D2yESt9f8P9wNqw9yBCSJ8n3YSfiHIXeHbrVfq
         6WwrWADMuU4y97gaJfZ8W3goTWVUYeHjP6NklmqzotURmuS4zrR9f3BP95qPlfQhNVUi
         ZYrGjKBLnzvqDo6Hq5sB8JTgi2Cji5WW6AbcC2iMN1DlL8PnyZsKYxLze4Y/2b7oRM3G
         2IRQ==
X-Gm-Message-State: APuU4Z9BjJtiDpcwinaXPZzRJzcnKfTOSn6m7aPpM5sUORPzsuOk5Gwy
	LVKQlFzXesyFaay1E+LoWsZ+DGOS4zV1foyGZg5RMZ4MeYswCIRko310hAGJ9uJaG/4zwH4jrXw
	tHHZcMj7X39SmFV/S+4VLr5BS3TIgXkg=
X-Gm-Gg: AYBFou2j5n5FOjocwizfcM4mfEc5BhqkZd2ej9gVCXO0YIKttS89YT9iJHh/ufpgFhh
	+i+KCtUUtR6RE+ddi2PkhnUMyJKzbVhXsrWWHkSdySG6FgTp/cpAOgdnZAu6URjYgrxWxU0u7n7
	59yvXr0tJQxineWfpgMSzEaalQr2XlHVJ5EDb0f8NNC0JIcuRbzqHMNhnAqtIMG9iwoFMoUMZv6
	LJcBp4s7bEhSE5Cja5/Q/4DkH0v3Ns/5Kze1xDXSCaeXupieiMyq9VJ1S8czA8gHY4AQhl8NFeb
	0V9FM3HwTYx+HuQOslWFj0/lw5j6lENtty5qzwHfXlHcmN5hlKURt/W6fXtyJCLjdZvJABVbHh/
	skzJyHtoCCk/riuYeT8ZR9cLGzNukLoX54rBRjCPHIceUuOOX1bUN9D4Slyug6oPEjX3iNySZOI
	tA/z5mo07xt+b7fA==
X-Received: by 2002:a05:6820:8912:b0:70e:78ba:1193 with SMTP id
 006d021491bc7-71917852a66mr2642193eaf.27.1794472428165; Thu, 12 Nov 2026
 00:33:48 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109100437.331423-1-amaan.cheval@gmail.com>
 <20261109100437.331423-2-amaan.cheval@gmail.com> <CALuQH+Uee+=2NyhCXVmmESwXxSqDYKY3Foj70KM2qY6g5UsOXw@mail.gmail.com>
In-Reply-To: <CALuQH+Uee+=2NyhCXVmmESwXxSqDYKY3Foj70KM2qY6g5UsOXw@mail.gmail.com>
From: Amaan Cheval <amaan.cheval@gmail.com>
Date: Thu, 12 Nov 2026 14:03:36 +0530
X-Gm-Features: AclHuK8jw0nrbYX6MTsSZqQlwj6_5UHh4mClUVm7LQtL7_VDZNXktjTz3rcpg6s
Message-ID: <CAG+wEg1fWbnaWmEBeCA0RcwYvMDrAcacX4qCO++bsNK98FS=Vw@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] gve: refuse XDP on queue formats without XDP support
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	bcf@google.com, jordanrhee@google.com, przemyslaw.kitszel@intel.com, 
	maciej.fijalkowski@intel.com, pkaligineedi@google.com, maolson@google.com, 
	csully@google.com, willemb@google.com, yangchun@google.com, npl@google.com, 
	awogbemila@google.com, shailend@google.com, nktgrg@google.com, 
	maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 1:16=E2=80=AFAM Joshua Washington <joshwash@google.=
com> wrote:
>
> On Mon, Nov 9, 2026 at 2:05=E2=80=AFAM Amaan Cheval <amaan.cheval@gmail.c=
om> wrote:
> >
> > Commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
> > RDA") enabled XDP on DQO-RDA by dropping the queue_format check from
> > verify_xdp_configuration(), which until then refused every format but
> > GQI-QPL. Nothing replaced it: gve_set_netdev_xdp_features() advertises
> > no XDP features for DQO-QPL and gve_xdp_xmit() rejects it, but the core
> > only checks that ndo_bpf exists, so a native XDP program, and an AF_XDP
> > socket on top of it, can still be attached on a queue format the driver
> > does not support.
> >
> > The DQO-QPL RX path was never written for that. Its page accounting
> > assumes the driver keeps a reference of its own across every handoff:
> > gve_xdp_done_dqo() passes the buffer to xdp_do_redirect() and then
> > recycles it with gve_reuse_buffer(), so a redirect target that releases
> > the buffer synchronously, such as an AF_XDP socket in copy mode, can
> > drop the page's last reference when pagecnt_bias runs out. The page is
> > then freed while it is still DMA-mapped and registered in the QPL, and
> > the driver posts it back to the device.
> >
> > Refuse XDP setup in gve_verify_xdp_configuration() whenever the driver
> > advertises no XDP features for the current queue format, which today
> > means DQO-QPL. A zero-copy XSK pool bind is already refused by the core
> > for the same reason, and a copy-mode bind never reaches the driver and
> > is harmless without a program.
> >
> > Fixes: d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ R=
DA")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
> Reviewed-by: Joshua Washington <joshwash@google.com>

Thank you for the review and guidance!


>
> > ---
> > v5:
> >  - Check dev->xdp_features instead of queue_format, and reword the
> >    subject and message around that (Joshua).
> > v4: https://lore.kernel.org/netdev/20261106114551.212675-2-amaan.cheval=
@gmail.com/
> >
> >  drivers/net/ethernet/google/gve/gve_main.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 2437cd8ba633..fe560f5c5408 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct n=
et_device *dev,
> >         struct gve_priv *priv =3D netdev_priv(dev);
> >         u16 max_xdp_mtu;
> >
> > +       if (!(dev->xdp_features & NETDEV_XDP_ACT_BASIC)) {
> > +               NL_SET_ERR_MSG_MOD(extack,
> > +                                  "XDP is not supported on this queue =
format.");
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> >         if (dev->features & NETIF_F_GRO_HW) {
> >                 NL_SET_ERR_MSG_MOD(extack,
> >                                    "XDP is not supported when HW-GRO is=
 on.");
> > --
> > 2.47.3
> >
>
> Thanks!
