Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17E453446B
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220791; cv=pass; b=YoYmPc9HlC0fKs4ov+9wyIzyFJ1kmRSyrlVZEH35AT4FcySRvTuAsEg8MULa/GL9cgmPeuvMC/QTaQr+OGGK9y91pf91OFqe82U/LDe37nFzDopZ5TyYwa96ufCtQFWGkjz0uyu3GLEjlscDMXTx2lWuxbxLtFV3r8vLYOdN+qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220791; c=relaxed/simple;
	bh=Iyy/EbW0PV9CgJFXeNSzqijmw9jKbQl0yvOdKn8dVN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOrZ2jBszJMjSy2Z3ghovZuSoyBF/cPIMlgKaFAnwz2Q4+GiL9B6FRH8FlfWXzv2vlCKFvL/YvGj2sGeQAAEG6OsGp4lWYcwxmaVhAVrFP9dL+DTbDyMgKyp3wlsR3n7t7otX87VLWld6Y0Krfl5Dkbw+PDYG6C++o62ZjDCnMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gE8JLIr7; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gE8JLIr7"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4c7fab7b6so1383424a12.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 10:19:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791220789; cv=none;
        d=google.com; s=arc-20260327;
        b=Wx2XNZhy3uPI+oyeDZkKFlVo+VQkCtAJhHFZlsslBRFMrePgw8/CwgRQbxkzqlf8GB
         apYJCtaq2/gu59GJztrEX1KYcldDt/F3yaD7pJDqkqy8g4G1KAhazeyGfA97wjiQgPPU
         /uvCdVdyjIt8Tavc1KLVEHWjISxJMLXwsT69YuahBiChNQmTWFbusMrWcxHk5skP0wYh
         luMxNpJ0yZkZ8HUHkmjW8U0ToMfA9muenecJ0/ltk2CmTJUKG5TVHPWx+AXd9z6KRfiw
         JGbhCKJajbhD4q1fyqmYW+be1bulefFjCadLnXc4smv01C/uKncaM7HH8u6EwJQ+OURE
         bwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kZaUwiZFto6aopJ87je3gAd8sYajiTqXcqFYb3kLz6E=;
        fh=ltj18lgIlKjk3hYeW4yRsaaeAtUoazjRYsGVLUCzUyY=;
        b=sXt4PyhwUwvc/fvfmZwGSjCSIaQF3cAWFf8osMGAZRr1PePRHkMI26XJWAzLOjyMtR
         gXzeiWZ5lyo+YdKMJaO+PjAGk/VwBB2euwVdZR8SuX2VbXxlffFBgnuA0+AHWxltuVoe
         dBoes58yNVgObJzyUeUBVxiW8eJlbuF/L7jT5y4F3vOHIWBYpw8eNcgPXjXiTszs1MEv
         xlwg1P6xp3NjCOBE5OpP0KTYpTHCr691RzHvuTCW1yC3ZwvC4dscqhVGZKVl06BHCaPe
         ISkn/ZCmg48suo/+AfaRDS+6dE9VLE53DG6jsl5N798sSzgRW8kEQQPgAso/4u0Mmeqn
         hP/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791220789; x=1791825589; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kZaUwiZFto6aopJ87je3gAd8sYajiTqXcqFYb3kLz6E=;
        b=gE8JLIr7W6DAIA2P/MDRVo2hmbxwnbtXbOE3gq2W5rAmpUVaJBoVaVt94axWAYNIrw
         x90UBYGBiEorg40G5/vkF3/Ui2+UEFjI5rsIlrBBcPFU/DCVKvLb3lCXf0FjRZbutzA4
         Rnv8+MKrtnkziCBFsmFRkAnq/FrDGrr4d7bxmnuGfATx6pj076+7qVqdw56HcC16t2WB
         I+eNJr3ikBf5QaXFPSxcTjFSKfjeu8ks1VVeut3gYUjnwVFgSUrV0rI18/ifY2rLt/MK
         MrZpuQpB85gJJdBs50UXgW0rOj3j78mzHK5jNGxKDgUDroqFwfN+RLAi+Tg/tb4mtDeU
         oM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791220789; x=1791825589;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kZaUwiZFto6aopJ87je3gAd8sYajiTqXcqFYb3kLz6E=;
        b=h1/Ovtmn9NjrxJwzl40+lMcmO3IUmSCu/FtNkztTAnf/y7f1ygOfyfcL0Llys8j0Am
         yL8dBtbnNWgCTjsAIctu+qUM4n+bkbFRIiQ1lpCvhunAUR8RvaC546gOrJmOJcG+WjwT
         sNFPtP5+lBECiE/OLo2wxFIG7X+VzeUEcvLS8PUZ4NIaI+h0EcGhNIpJxs1f0F380GAe
         pFoeXN5BTJHlrpN/Sal/rCBWVLEx6muimeDAYzfuK8y7dKKuXZeTbmRIwoNq1xhRozfF
         b4DldcAT+bPyjwUJ+NimNaYg7dwMWMllyomlFUMUwZOEDD634bkSFYqyzxsP1haQeduh
         mF3g==
X-Forwarded-Encrypted: i=1; AKwUvBwhow3yYXjC5LwSjXRwHO1d0ytS8tzniLrFptqVqykMiLWI3B1q2D7OqW2f1HIv+blY5eBg4NA=@vger.kernel.org
X-Gm-Message-State: AFuF++l8OTzz03H0Qipg03utSm/aRty6pV8NxHcqOgPItaID+XlouF0w
	AWqsQTs/GYxCq4TO9xYc9joqNQ6wMmN4tYrZkiZFttl4TdItAA9LEVarKXTO+gprcTm4ujSwEEi
	hIqtt2K97JTKvBtfdnap+dBfUa6XHMB4=
X-Gm-Gg: AYBFou3pCPMvFSJTcMX7AzjyLWWRYP+aGYLZ+g/hwq90m6DJpUxAkW11DMm63XO2pyO
	LvP5HfVhRcTnMaYQwgok3gNmVLem8WGtY36ktFdqqgSmucz1v4ckHGG9QhsJ2x1rpAiVwr3f1OI
	RnmzEkokr+cTF9zIGU3CLVRUJ0UQQJW0W3yRMtKEMdBRleaG4Hx9Zsg4v7iV4qYVyqNTec2bMSt
	eGy/yIk4/mk03GOdNryQqkt4AMltBA4HighuL9tuPKZqGYPsJwO4bBO3oOG69zmMejQNIoLXwy7
	/Yhoq6Rh5fqycbypWW27DkFdhvQGnuiMIb4ftYmEUoSOZQRhrF/cEBD8FnmusSP3Vn4WGpMfcxD
	/hirpKR+Ke8zSiRgt3+ox7FMYjRG+RSUwdmbKB4nc1PTJRm6gXgvSjhI=
X-Received: by 2002:a05:6a20:394a:b0:3dd:a197:edfb with SMTP id
 adf61e73a8af0-3e0d6cbdc69mr7529764637.74.1791220789033; Mon, 05 Oct 2026
 10:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930044611.204739-1-benquike@gmail.com> <20261005170632.GB83879@horms.kernel.org>
In-Reply-To: <20261005170632.GB83879@horms.kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 5 Oct 2026 13:19:37 -0400
X-Gm-Features: AclHuK-lyDkgT7D3dyZG9byu4tcMRkf70JRI3r14isoIqeQu9dgZ6L1lP-o_t_Y
Message-ID: <CADvbK_eAWQbGs7EUogG3kZDgpX_9bzrR-okU_6cAobcyp_SbtQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] sctp: copy zeroed stats to user in
 sctp_getsockopt_pr_streamstatus() when !streamoute
To: Simon Horman <horms@kernel.org>
Cc: Hui Peng <benquike@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vlad Yasevich <vyasevich@gmail.com>, Neil Horman <nhorman@tuxdriver.com>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 1:06=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Wed, Sep 30, 2026 at 04:46:11AM +0000, Hui Peng wrote:
> > When an SCTP stream output extension structure (streamoute) has not yet
> > been allocated, sctp_getsockopt_pr_streamstatus() sets the local stack
> > variables params.sprstat_abandoned_unsent =3D 0 and
> > params.sprstat_abandoned_sent =3D 0, but then immediately jumps to 'out=
:',
> > bypassing copy_to_user(). As a result, when an uninitialized user buffe=
r
> > is passed to getsockopt(SCTP_PR_STREAM_STATUS), the kernel returns
> > success (0) without copying the zeroed stats back to user space, leavin=
g
> > uninitialized data in the user buffer.
> >
> > Refactor the !streamoute check into an if-else chain so that when
> > streamoute is NULL, params is zeroed and falls through to copy_to_user(=
),
> > copying the zeroed stats to user space and setting retval =3D 0 once be=
fore
> > returning.
> >
> > Tested in QEMU against Linux 7.3.0-rc3 using an uninitialized
> > sctp_prstatus user struct passed to getsockopt(SCTP_PR_STREAM_STATUS) o=
n a
> > freshly created stream: on the unfixed kernel the user struct contains
> > uninitialized stack garbage; whereas with this fix applied, getsockopt(=
)
> > copies zeroed stats into user space and returns 0.
> >
> > Fixes: 28b7eab0f910 ("sctp: add SCTP_PR_STREAM_STATUS getsockopt")
>
> The hash cited above does not seem to exist.
> I suggest that the appropriate fixes tag is as you had for v1:
>
> Fixes: 28b7eab0f910 ("sctp: add SCTP_PR_STREAM_STATUS getsockopt")
>
> Also, the patch should probably be targeted at net, again as you had for =
v1.
> I realised that Paolo suggested net-next, without a Fixes tag. But I
> believe the premise of that suggestion was that he felt this was not a bu=
g fix.
> However, Xin responded stating he thought it was, and I expect that carri=
es,
> especially when combined with the updated patch description you have
> supplied in v2.
>
> Please treat the above as FYI at this point.
> I do not expect a repost is required at this time.
>
Thanks Simon,

Yes, the fixes tag should be the one in v1:

Fixes: f952be79cebd ("sctp: introduce struct sctp_stream_out_ext")

> > Cc: stable@vger.kernel.org
> > Reviewed-by: Xin Long <lucien.xin@gmail.com>
> > Assisted-by: LLM
> > Signed-off-by: Hui Peng <benquike@gmail.com>
> > ---
> > Changes in v2:
> > - Re-target subject tag to [PATCH net-next v2].
> > - Remove redundant retval =3D 0 assignment in !streamoute block and fal=
l
> >   through to copy_to_user() as suggested by Paolo Abeni and Xin Long.
>
> ...
