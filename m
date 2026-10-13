Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6E23F39ED
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900283; cv=pass; b=AWJy7wStHHh5FFAZHbZsF1CHsDhicbOPs45P5a1I741/eD0MxcOkBXls1/7WIUWwLykRxS3jTEn5sseN0O6Ikl0jec+rx/eiZ8Ht7Gfc8xsSx1OWYqK+j5OoqvGk5oe/a38yWbjhczmqYCsdwWfDEP5aNtP2UaIM82+0WzSW0tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900283; c=relaxed/simple;
	bh=DzrcFEY1rgwWm3JFIyxQNMKW2PekoiwLPfU9/04RBt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=niX11Rn3x4qXrRBJh6QbDG24Mm22rYZNg6/IaRs2B/g/jvasfQCHpzvP6A43ZY9j0HmlioU165NoFbiWXeDf3hHeUfDRJ5VhuMpoK3M1r1/fpZNgBA3D6j9fRE2/wjEZsbT+1/gPGY9mMHLR2EeyqCSlp9bUT5iRAO0VMVY2CsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgBs7nM/; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgBs7nM/"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-888cbacf70eso35301057b3.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 07:04:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791900281; cv=none;
        d=google.com; s=arc-20260327;
        b=YtC0F1pzMC7o1z6T2kZOVis+pNY4NCeEMA0iZo3Mo5lEUuWTVrvRkrtnxFH57JTayb
         cnXy73QKZWJZi/4go3Q6OXuDVXPBwNycUtCPw9+sjP9ZrEkF7OLaikwk5bZlAVo4aNNN
         wjQKpAk5HyL+5rgWbTeLMHqzowJJ0A7sfryMBjlzUsz+tWppq6mPA8zUCfbu85v1DMcI
         iRfCHiYfRPxJacdK4h9x9Of1nKJ4AV0h3NhGGJUCkRonNAWrQCQl39kc+XWgqPHm753Z
         stU2LVqEJkWGc9FxAEN3DxxMCWFwa2Fp+SKQh4s0djHQG45AnDGeCa6vp/SNUFBIoANq
         XN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JOjVfbTHlQbpGLyJKUI687tyzNFy+QciAXgAHH6YLBI=;
        fh=EGashVSV7vEs/wSxuHnHTQbX11XQyM4A4cUF5ho0LVY=;
        b=Y5Xy5Zvwtytq8KxzD6Ow/EEhYZeN01nTRkeP1mOlW3fRql2g//NwlWipzA78SNLrsX
         F/qAeHKvr4DB4TFQUaFpAB4rXl61j9PXSxDxsmZy8MNDMDYfFaa/zitY1J6PAWsPb0P+
         /PJKyd1nE+VG4O3AK9Dp8xTLAGWnyUsbhbsxilZF8t5o07w4MRosdav6LKrMx+zBAU7l
         01XAtY6nEwNNgQR6geWB187gtIvYcMIS8AfaCL7UIJipm0njD4LFDzkvkJps3IUAsUNE
         gTE02obSubAw/SFf4F8981VAL4ShQ4liAvjMR+kpm1H9l//vXhU1yrHYxmoB50sjyACv
         v13w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791900281; x=1792505081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JOjVfbTHlQbpGLyJKUI687tyzNFy+QciAXgAHH6YLBI=;
        b=fgBs7nM/KN2MgMoXs2Mi34GLEr2d4sQ59SoMOKYOHGBVe17HwZcfQ9EVDUBbjoGHE8
         ukOl9Mv9/lm5dm07ykC7Y7WvXD0ymyWIxF87ApQd5bFyKdb4C5p4eDXs9qNSEolthiNg
         EY+J/Cg7qTagk5+YqqD6LFTevbsUcz+T246Y28Fnpu/NBb1dK3DJ8PJ3XjZyqhnDxcny
         YCkgDTtY77gQIqlXivCpdZOjhkX2P83iWt5wDGsnIZXv+Zv3PafS0xIN5D0txVCnxeey
         EnEHXmsWgUdVaLZBxK7vxFn7rAKz6rLZ8Atmp62lcPKBPLoC32IyQl4tu9vZTCTkEPgt
         ODFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900281; x=1792505081;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JOjVfbTHlQbpGLyJKUI687tyzNFy+QciAXgAHH6YLBI=;
        b=mIy/u3yC4YLAZuJ3LU6UZ94g/Degy2u7c1+9wHb8Nox3rTM2raaoq1BJKtcrR3knHt
         JCyE+4XnsL7sagODPafKZvA5XoR/AGcGVqnNKEQDyyEXDKJbZErx+ECc6W/Aa6Q2fo8z
         hbmQ2Mr0oEQQsH9GOMNZsSABAiLKnnoOUkpJKqVkmCDGrflATDCELPubNxJ/x62QdJE5
         uN7vInSIRTvyAUeqjhNgXtTsCjim/lpKUNURWCoqusrgr5mhkcsgpkfVk1rJnabqJKug
         squKjEVQa2YsNS/PNDlsRHE7QxMqumdDjlgaRQ4n4Xm+ZTzVJNJLgN5sGOu150gWLDV2
         uNjw==
X-Forwarded-Encrypted: i=1; AKwUvByaljAYelKUPPCabPijUFMfruGugEmHsngW/+4pWrcGpaAmyOKOVkcTXbjJaS3nCZFxvcvTbzY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZ6RCtiMRrz+j1Dx6kXAu1wG302gGCrWAfURs/otzHK9U8IDcl
	qVlxi30Q1cyzhRuEvogpR172grkh8bpHcBA0E+0IvxjhxAYRtSrMmecerZfBy4LiBzjCr01kksB
	8q1b6YATYRGJyY+AhnF41V8haozF7xK8=
X-Gm-Gg: AYBFou0fWV4SVfNhzO5b3Qq6dQanUxBr2l7CLmyQ9Y/HsqJjRjDPfVQSFW0ocmcuLFM
	ev9kC5sSNs33KK/u1tKOx3QWCyOqJCz5ve2MpJaIwIEKfJapu5NVjGD01Z0Hv+D0MPXtTq9U+N4
	1aBUU1PtDo5jB6uDyDLiLys48wEsnph6OuO6jSZ6BycJZY2rOwuWZjDMq94j7VdMq+/wShv3MEb
	C21mXjYNCn9qB+UbcLzLQQ9GhtNIj3IW1WjWnYPfWPiMROWX+sHxzquLEAMJZimRwM9b+ojTPOR
	GrbSJYNGbpbhQk2kioyJKBwsDEKNVOIrreGWsoLp5uE0YdHMAr9HCqzQgrCOz1WJnhbpOiVmVh/
	tsZ3Nutp6kpAPGXQh7TkILvVFP0hyf7MJvR4XJTUK/XM=
X-Received: by 2002:a05:690c:e68e:b0:8b0:6866:c58f with SMTP id
 00721157ae682-8b07ebf6118mr22092347b3.3.1791900280818; Tue, 13 Oct 2026
 07:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012210758.275556-1-luiz.dentz@gmail.com> <48d2ed02-c5b6-428f-b290-bb6bd92fe299@redhat.com>
In-Reply-To: <48d2ed02-c5b6-428f-b290-bb6bd92fe299@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 13 Oct 2026 10:04:27 -0400
X-Gm-Features: AclHuK8CwNefDVU2g9r8mUJAY4xvM3jSYTURNrAHjc7AUPLST2NnWSBIBIDU7Kk
Message-ID: <CABBYNZLogtjwKWe396jbm9zwGf8k32f8NgC2ynm-oFv7huEyEw@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-10-12
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Tue, Oct 13, 2026 at 5:25=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/12/26 23:07, Luiz Augusto von Dentz wrote:
> > The following changes since commit e32d80293a0e1a160d5e5101daa8c82148c0=
7510:
> >
> >    Bluetooth: ISO: Serialize concurrent connect calls (2026-10-05 13:10=
:47 -0400)
> >
> > are available in the Git repository at:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.gi=
t tags/for-net-2026-10-12
> >
> > for you to fetch changes up to 23ad91f6a21a830b67f5eee790caa0053bd6537d=
:
> >
> >    Bluetooth: MSFT: Serialize handle map cleanup with event processing =
(2026-10-12 16:27:16 -0400)
> >
> > ----------------------------------------------------------------
> > bluetooth pull request for net:
> >
> > Core:
> >
> >   - hci_core: Keep RCU protection through LTK filtering
> >   - hci_sync: Serialize devcoredump reset during device open
> >   - hci_sync: Protect IRK identity reads with RCU
> >   - hci_sync: fix mesh adv timeout units
> >   - hci_debugfs: Pin module for debugfs file operations
> >   - L2CAP: Hold the listener while notifying child teardown
> >   - ISO: Hold the listener during disconnect notification
> >   - MGMT: Reject quality report requests during unregister
> >   - MGMT: Fix advertising instances with Global Advertising
> >   - MGMT: Fix pending state of instances added without HCI traffic
> >   - MGMT: Fix leaking instance on Add Extended Advertising Parameters
> >   - MGMT: Allow connection rate request as peripheral
> >   - selftest: Pin module for selftest debugfs file operations
> >   - 6lowpan: Pin module for 6lowpan_control debugfs file
> >   - 6LoWPAN: Use RCU-safe device list removal
> >   - 6lowpan: Drain RCU readers on registration failure
> >   - msft: Lock failed probe cleanup against feature readers
> >   - MSFT: Serialize handle map cleanup with event processing
> >   - Add missing newline to bt_dev_{err,warn}_ratelimited()
> >   - Fix tracking of instances sharing handle 0x00
> >
> > Drivers:
> >
> >   - btintel: Zero version data before parsing TLVs
> >   - btmtk: fix skb double free on ISO padding failure
> >   - hci_vhci: Pin module for debugfs file operations
>
> Ouch, that quite a significant PR! Linus is pushing towards
> smaller RCs: he is not going to be happy. I must admit I
> would be slightly concerned by the size this late in the
> cycle even without additional pressure.
>
> Do you think anything of the above could be moved to next?
> Things broken since the beginning and/or required root access
> could be good candidates.

I'm fine either way, I will send the next PR later today and it should
contain everything including these fixes.

--=20
Luiz Augusto von Dentz
