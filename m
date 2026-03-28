Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100241C862D
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 06:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774679028; cv=pass; b=FljYKi0QWQKxxOnH8k75L9Bo1szBOUlE1vUa4XDbi4O4oRmh/zLZ9r/8Bpke1AmeytWg3MhBoEcBfayLR401q/aux+9/PY3k8XfUiAJcPv6t1nLsH5wwNmGfdPEpr952WRXhSdWrCj7T45dDE3h7I42gsRznr+6ROGQhxihHJwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774679028; c=relaxed/simple;
	bh=mGrMw4MiJplVaIj0CCi1OYNWT4Z3Rp1BfJNazbAf/Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbfNWghpAYeRGx6CXGZr/YAJYFFX88GP27XFjSEsG1zG9ZPOzMDOxwIVKbCKflrtd4ajUWcprsGvf/+DfogGp+iGbLsz+mOPCeM01V8xsUcskdCzatNTs0/FqREXXgqI4YXY4KJnnRfsNTQTQLZl/OlvPMI9w5mfNYdwasd1Ftg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=fuUU1Hkn; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="fuUU1Hkn"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35c1107d4b7so2300278a91.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 23:23:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774679026; cv=none;
        d=google.com; s=arc-20240605;
        b=cKcvKl2MZ2sSKc+Kj6SIKLOpKIWd75AijT2/zy9I5YAUrE1a5rsz4boHCLzsxtOsjw
         GtgEW0g8/w/BMg2E+nM6I/elsnCpQeF9kvjnjgyiZOb6N/7WxXTk86eIerpyfewgvlwS
         So8QdYfyIDe9v0GuJ/eqRL0fZBWvS9avK8VkFdpF0MhVE+6ltucHAd5iys0gqeQRRfVT
         cR0y5GSkrcJZn1NWlSaeVUnRwdeeVyW3Mxeo+hcB93qJvgYrXzPaRTRcqE8kFbgVuU2h
         PZnH1puFapQ3wVqFn13gBcARDwRhoPjxkz7TX8a3N0ls56p9IBwtOjyquB/xqPSP2pWO
         uVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mGrMw4MiJplVaIj0CCi1OYNWT4Z3Rp1BfJNazbAf/Zg=;
        fh=GH26JttvQMCfy5Hc2pzkeWwfS+/4rbImGyBo2ogzwEM=;
        b=Vq3CRZtd0/Bg4c2rvLlbl0NBmXmthLxHJcz0POfB9cjquKOajffrGVdRrrAbvJHaUG
         2ARkGINR60T408gBI0+yMh6eFW5naOeRWI606nmISQ/3VBWDQF2ukBi1B/FPYOp9usFu
         1bWkqhE3KyMehOjPe/hyCj5UV0e49NRrV8ZiQ0jKEqV8JFchT+lUDjkksyHMO0WVhhTw
         kk5Br/fc6Wjyw2kSfgm6MY7Bk/cW/nv7OM4gUdWTDTmeUwG8I7OQxdSdTTQQOEmHmK1b
         KDUEeZZJIYhLFG2kS7/19x5Z0v+VEij2qdTc7W9yeqLElPDzTl+kn+Ww8Ve70005Q8Ru
         1Q6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774679026; x=1775283826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGrMw4MiJplVaIj0CCi1OYNWT4Z3Rp1BfJNazbAf/Zg=;
        b=fuUU1HknMt8cu3I2PolBWgZ2wWYMUZKbayEHAQS9leFFGVdS3SB4uRS3alpqXoMY5F
         UdN9KRwsbYZw0c4ecHIOfy6/qA1abU1wXdZjaNz4fhlWMscEw8AZ3O8eKjl3FLBiusXr
         nh0HnHO2wu7LbSHPw9chl9R+Vs9fbpAdE9nbafJfdwBL/ss/ysx8gxZp3Yz1NaTj1Raf
         5Nn3u1CEirLtSHgCA83nQNZkkU2uBKijr+aK3In3ETjfsH4mSVAMsR7eePhrenkrrKWW
         Nat8wzpjP64QPyXtyN6zSqUD/tbfNDkd/usFQCVu7DSSne79h/Q+R/OgfsfGxvc5WDw+
         xxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774679026; x=1775283826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mGrMw4MiJplVaIj0CCi1OYNWT4Z3Rp1BfJNazbAf/Zg=;
        b=jr1x9igOnTH2wrZ4kKRNiuaANAfh89xAEjPZturRIeaRjQ8bvNOlivWS3kVjzkA2m1
         p+lAOARG1ZGz2HYEzsaelYFFhYLVrFeopLfLLYYtcbTEm9vjIs/OFxaF8gSVjz3z1aeW
         hyDitw5ZMCzutzv6RLpmgMEoW4IzD7F4A/3PZzEetwYO6H82U9achPDGyh7CyVFz9X05
         GtKTrghg2rzbqWEmn4/TxS1hZh7bla+Jik+If3DhlVH5A+ZpFhs377WePPrfHsyZclsa
         wd9hLIY/K3zer34YbeKczIESyi5EspKASKwgPj4MNuWBEhMPeweoUjsVizvGBPvk2AFQ
         yd8w==
X-Forwarded-Encrypted: i=1; AJvYcCWFungL0XnO+oPR02YPt5TtVRdOZpDy33lWV2CzfKCZWWU1W/f107qCm/SFmA5ta+UNtnzCenY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCW7rQztHaKhKBx7pG/i416tUG6jrf1WB7IxUmwk9oFWF5YSdw
	LZzXERwQWbFWrKwqNkW6B4LQVRsp+SDX/LGnCvyH1nBTkClOHZb2C/N6OKFieML9T5Mxm5KLSBE
	0rVMiQth9Z43pTvk2l/SKqMmxq7ctijWTtj7qPiHM
X-Gm-Gg: ATEYQzwuQorT+b6r3v+pNA/Ct6of2vA6oaHsrxq+yHyOxa+gu6qZqJmI2PakSRkFHDo
	w/Ne81yJNXdHTuSJ4NjymTyIIEdeOJuPVRzXGZXBSBte6WiFVTLkQtGMTHbJnSDhHkr2+cRMj0q
	/3RbQ1lhrOtocvMKNVv4yMKKJayqtccWIlL7iq2qneNEXcWWX4oV6puMpGkCB0bnkENsAgLrc2S
	9t13QftImsCahtqGVgE9grd8IiElL3khw128fBYa2o+8He2tU7uPCI6RZwUmG8HNPgbPhseMSDi
	L0pnjS3C
X-Received: by 2002:a17:90a:e705:b0:353:5595:3247 with SMTP id
 98e67ed59e1d1-35c2ff618edmr5113370a91.12.1774679026308; Fri, 27 Mar 2026
 23:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326032438.3307549-1-xmei5@asu.edu> <20260327113412.GD567789@horms.kernel.org>
 <f7fea291-bde9-4f95-8a59-1b209407ee27@blackwall.org> <20260327171917.7575d715@kernel.org>
In-Reply-To: <20260327171917.7575d715@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Fri, 27 Mar 2026 23:23:35 -0700
X-Gm-Features: AQROBzDsd7uTa4Y8C1u6puTZAJ7JTHkpQpXfmYuMWfXq0kecoUQ_Yx7IUQh2sm4
Message-ID: <CAPpSM+SHL8VQU2jfzbs8vEVhdHiV=VQb3Dx-9iwryQEFK-QkSw@mail.gmail.com>
Subject: Re: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM panic
To: Jakub Kicinski <kuba@kernel.org>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	bridge@lists.linux.dev, idosch@nvidia.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your review. interval=3D1 works fine even in the case when we
use netem to delay the consumer. I'll correct the fix tag and send a
v2.

On Fri, Mar 27, 2026 at 5:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 27 Mar 2026 13:46:39 +0200 Nikolay Aleksandrov wrote:
> > On 27/03/2026 13:34, Simon Horman wrote:
> > > On Wed, Mar 25, 2026 at 08:24:38PM -0700, Xiang Mei wrote:
> > >> br_mrp_start_test() and br_mrp_start_in_test() accept the user-suppl=
ied
> > >> interval value from netlink without validation. When interval is 0,
> > >> usecs_to_jiffies(0) yields 0, causing the delayed work
> > >> (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedu=
le
> > >> itself with zero delay. This creates a tight loop on system_percpu_w=
q
> > >> that allocates and transmits MRP test frames at maximum rate, exhaus=
ting
> > >> all system memory and causing a kernel panic via OOM deadlock.
> > >
> > > I would suspect the primary outcome of this problem is high CPU consu=
mption
> > > rather than memory exhaustion. Is there a reason to expect that
> > > the transmitted fames can't be consumed as fast as they are created?
> >
> > +1
> > More so with CAP_NET_ADMIN you can cause all sorts of OOM and high-cpu =
usage
> > conditions. This is a configuration error and OOM doesn't lead to panic=
 unless
> > instructed to. I don't think this is worth changing at all.
>
> Then again if there's no practical use for 0 we should consider
> the risk of getting this sort of submission over and over again?
> Dunno..
