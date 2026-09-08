Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B0E45090A
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901211; cv=pass; b=s+U4NXT3dHGDlU59Z3Vf3jUxjoz60/uS5vLbNduzxoYkzmNhEKnjDDN1QqfPGV44ryAWvvShja1Ri4HWsPPrdKwn4u0+DHEdAc1LZ/CFAqqVIiUUIH8mdphfosUM0dx1ZKBMbZZwuZqrEz0my29pmw1q7z+MXe7Bx+2TDqI3oSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901211; c=relaxed/simple;
	bh=rWQPOX2rN4fPlWhJiE5JCzH6fz7W6t38/10QBhgrqqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvZkIkA/wTt4OEarA9FAHc1fMX7jdFMx/2WgnFY3Djo2RNjxN3ywrUQUby87Sg+D9HCxuso5BKCF8T4XAA8WM31r6eWFIHzzFyCqQQf+kEd32jaKRPuXsDnuPhBAUTinNpvNoM0RV6wtfK8S5XOapPsBGZj2GhNSAFvNc4IdFkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwZI9Z10; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwZI9Z10"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-855a66e5b5dso41928647b3.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 14:00:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788901207; cv=none;
        d=google.com; s=arc-20260327;
        b=s0x65V3Oqa/23sVlor0CNUW2a2MaDgE3ee7fiRfMlRO1G0Te1U/hEYVpWiblgCUKcZ
         4JkWp1r1/qdSY9uuE5PMQT4Gp2PAIV66lKF6XSCt3OmGYIgCjsSbzDUA2qu+4eb//dLA
         YGksTA86vUQoFYSoBAxaB5/eC2nxjUYEzTX0kmAMc4zmeqlonzyxZGAow3Uf0351sMIh
         MTfUDvX8ufWzDv6kbIGz9pDmxVDvnVfTvOGIEaoYDFb+c/o+cTb+p8XqNWs73tCTGxxa
         zqiqxTH55aVF/eKR9/hXcvcgDH4IOGHt0Om2xn3GpltfeuxH7kXyPALNsnA74gvAmupu
         3ibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r03JHVqatUaUPMmsv4urfr2IsvkiMywhjIlOj6S9eWU=;
        fh=UQ5JcCDZAyAH9AHowek0FhlD5hszFbAcZNiuRRf3rIc=;
        b=spEsvsjC9Upja+bGFdUSpKG3s+456rsuChFDPPmIlOvlRgubn0JUbpVUu2D0VIKYqD
         NlI9Ykj6WHhZwNinJ2K9K3c3GlZGprkbUsrtiCrIKZBOU/3/QNPq8Hz6Lkwf7tGW+YAW
         oiUbB5pVzsaNNw1yIooy/ATCJSgM5gguqGW5cecx/bvf+agTQ/QQij9qDpXV+PHgVoWE
         MZgcGD6dsO9Gz3RkoDXrh5k16sOwYqICQtuNgr73lmOsnGulgGxpoEqHsWc7VPNQCr6p
         tiS7HK4MP8p1pm01JfobaO7SdutSO+B+t8HB4B/xPoHrE3EC+7ozQPLLampAQY4nrcST
         bXEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788901207; x=1789506007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r03JHVqatUaUPMmsv4urfr2IsvkiMywhjIlOj6S9eWU=;
        b=YwZI9Z10cyNcrjK1YbuuKAb9yu2Hc5hN5KzUSbNzvoXbLLYWxs62dPjOyLdx/GjChD
         dJZCLZdGaVSdU+FG9N/zJvinzQKW2P55/FjN7gEjsFo+2HlpZzTPqeH7+flU8OgOx0l5
         DSICeKrLJArJ8nrk1eJPhiZ+J72u2UnbFbYAht0/3WX70OgrPA9F2ZXbyEXJGqMsj7/8
         Vks5O0IRxwqdNKh3+/YzmpC60vcmoUdAKtVtx+cF4LWVsmsbhYAuowV0qVyDyR6AAT2s
         elD2WxYtbBlKVx8Fz8RJFl7LnvOaYL6kxiGqJyVcb38Xr8WW3FMNru/SWcsfgOaaZpx0
         KwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788901207; x=1789506007;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r03JHVqatUaUPMmsv4urfr2IsvkiMywhjIlOj6S9eWU=;
        b=jWUPaWK4FoxvzFDqyVIJqgYisihfNBbZwxGfZgIUpvXevCftcgnlVhnv4SnV19GlVv
         u1MQu1rfrMn+79fv7t2FL7OMkNDzDG30Me5pXI4UgUEHo6KMzxtz/627BsCF379cj+NH
         OZQMrzSZPgh160p2CUp7Z9gwsnbvFuMF98/1YpF2feHP4DH18T8huPPM3sgClRBIGEw2
         w7hl+/fT9BWMqIPlBUNPaH+5CuyiwFNZjTxw+BCe+EB2uwe3pTT2JW35s14WP1zVlFNf
         5KC1A7KvBBXk3S4wtLiLMM9CJ30ekKXTvNuKW36U2I1Q7k9ZLduO20RsFKBsrQNaGMX7
         nmxA==
X-Forwarded-Encrypted: i=1; AKwUvBz2bAVVNjSEEME30bF4WFJc8Ot2gkaR7IJ+HZPO8W2LPXQ4PSsgaPTWsxzHSvkiCGzk9YDWww8=@vger.kernel.org
X-Gm-Message-State: AFuF++n1oteWUwFjrrpt/vwekbISDLuEC+I9AdJD3ROvwCmoLEA2sa5B
	ETHN4w3EGjs80yXrjtPuXBaXZJ3SrAxuRraH8tIfH/algT8EeV5Aj1ZOtjnKcwk0TXH+nInd2xr
	ynjrw0eqZnPVUmkalP7zmzEuBNdt3IWc=
X-Gm-Gg: AYBFou1Ee848k9mOmO5vZRgqU9ruWVN7dPqtAHx82QJcABLsGPNEYQ7ygtZvY5lZ9Oe
	WuHa/0vWTSCUjcGlrr5hjM4tfVA8sNMZ7xz/hPzXCmJLe3r09IqNWGCWHn9wwDs5pMbvrp74WNz
	CpOo6v78n858Ad6SnF2stJ8XpBq8eQTo5eW5a1FYrC1jaZ7MfrU0OrvP7RIMdKqSRd3JjI6QSFA
	6ehjJzMSBPR5mVW8wblW6JHQSVTzDNO5rMxtHVBf1CiLy8PyDfKdVmcAyY8nDDzxe7+e+q5iesT
	ENqNia2kWbfWooeazNqAbrzzjDRr7tmmSx+Np59rVj0LXR980/xVZoInInnZGGk5gMvNBve81YY
	IYOfTAmzBJhg+WCQ5hFrjyrHF5w9N/qY=
X-Received: by 2002:a05:690c:e64e:b0:863:82c1:b161 with SMTP id
 00721157ae682-871263cf533mr89991517b3.10.1788901206968; Tue, 08 Sep 2026
 14:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907172648.457103-1-luiz.dentz@gmail.com> <20260908135708.552fcead@kernel.org>
In-Reply-To: <20260908135708.552fcead@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Sep 2026 16:59:54 -0400
X-Gm-Features: AcwNN1WuAAHTkwK73g9kYNmbdnD0_ziuS50YK58JF2Zh8xNx0-nW4cfl2Wdo7sk
Message-ID: <CABBYNZKsDJHUiG8exN1R699BC6w3sC39qfT+jVQOe8nHf-RQtQ@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-09-07
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Tue, Sep 8, 2026 at 4:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  7 Sep 2026 13:26:48 -0400 Luiz Augusto von Dentz wrote:
> > bluetooth pull request for net:
> >
> > Core:
> >
> >  - hci_sysfs: Fix NULL pointer dereference in device_del()
> >  - hci_sync: Fix not setting CE length properly
> >  - btqcomsmd: destroy RPMsg endpoints before freeing hci_dev
> >
> > Drivers:
> >
> >  - btmtk: Declare MT7920 (MT7961 1a) Bluetooth firmware
> >  - btusb: mediatek: Fix leaked runtime PM reference in reset
> >  - btusb: Fix leaked runtime PM reference in btusb_reset
> >  - btusb: Fix UAF of btusb_data by rx_work
> >  - btusb: Properly disable remote wakeup for MT7922/MT7925 on Ryzen pla=
tform
> >  - btintel_pcie: validate packet_len before skb_put_data
> >  - btintel_pcie: fix tx_handle bounds off-by-one
> >  - btrtl: Don't leak return code when parsing firmware format v2
>
> You're missing a bunch of your own sign-off tags.

Yeah, I will respin it in a moment.

--=20
Luiz Augusto von Dentz
