Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794244953;
	b=yvUZxthrPyj9Ebt296ixSe8NHcrxfHdkV52RGnJ6sN86ZlBhEHtbx3CQHRN2IwfC4DUb
	 ytukYuWIdLtxYEk572KeHnf4GlbY0AjoYd+Rwthu2H/RCEB/bVQehojvOSbC9OyaKPIVb
	 GrvyAcb0g4VEgVrCJzFkIIBKwi24OtNWcb62ZodnQzehPKPA9n7c63ZTQJDfW67t6rnzD
	 7YPjA2m4Q4VtDeRelifb/sBRfPKCv3FMp4jeE1HkZuvlaW0trYQsx11ZcZzl+VeRJsSWo
	 vbn6xrm8EkOumHjwx2824LOV6wa13cb0RCcFoeZgcyEpBpFIAg04K5ERZ6MdzeSMBSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vxIEo7GZ1sBSn6ZN0R3292yPNxYqlIT/6wxl14tijMY=;
	b=QGd5pzzQc45y9lHxdZo1SdYzRJ8XHxMtzS1KynzPeDb1VK29A+1zpT6d8c5niSXooiF2
	 I2u5Sf8buC9VWS3/ij5EcfZWINIHKdU8I6tzubQLYEHGi0+piEybM1RAixDBljaxQ+hCC
	 N5XZVYrDbZTpQHMULV61mNH5ziyXTMmGap/1M75MTOwmh+4tHw+LqJzu5sgWYzRk3TzNN
	 WNx0MXaDIt5bsWHFg43eTe6Mym7ncm5QYBIVZWObG5AUzsZPt4lC7A539QGHCq3ocuB59
	 eJTP+ZP62qsYjaKxiuuE9RbUXe+l/YGmwJTP6FdFSXJPVaWVoEP14wjE6EG29xtrc7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Sm7Rk9+J;
	arc=fail smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973C0606A330
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 17:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 973C0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Sm7Rk9+J
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a06e79e152so574682b3a.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 09:22:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794244952; cv=none;
        d=google.com; s=arc-20260327;
        b=LYvRHsoR1uR984/PD7L9Baum3eni02vAU/cR5q/+/Lrwz5kBmf8UdtBc2Jg5dx7w7K
         hYF3PLs5pPLY3EmWjgTNEJyzFzDVwZ5WL5Y7E7grSREgYjefJJYSjkGbRTaZRqm2qoeH
         eDawg+ROmFICLhQnAqBSdU1lMXx8qhrgzbjipj7frDRuf7ooba+2iKyy9qiH3TC7vayz
         tQY5Mnuxg5h3dLvbC45IIOAP/8SoUgfGoKhBHxUNrmOZL+OpWwY2S01JTHC7eC4ipL0H
         5M/WKCyAnhArDQ89no7YHyOi01Hg07b1ovj1lmfiJzSNZxC4eDsetpnvQcJtTC6wVmgu
         97rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vxIEo7GZ1sBSn6ZN0R3292yPNxYqlIT/6wxl14tijMY=;
        fh=III7a06IMwbCl8OQcuL++N9MjR46N09mMNt8Q1jZVJk=;
        b=sgrUAmlxB8BFhyVtWeRSgQbK9/GslkbNZ/2Fd7RB7RvQxKaaY8Bgw0Mv8htSHsz/EP
         9Ddc23V/OPzo9IMEDpMvrpNnQUtj6nuZCxgT5sBFS7lrmFlbyy6Jpuh+k68Vf2C4XIxN
         Dms+sPQgTZwHFhDALLzvGE2P1T92BKCmMfxy5hsEEaZDvILLC9J55wM94UEn97C96vb+
         ANORIluSvotLo9I4af0TpNBhL9VAhNXHFwuWPL5T5K38rwP4Z7phlC3hbDrBrt+bWbI5
         9qVLjutzt3LJ44U5EiwkMuzMRphNWpU2vHk9tVjd/V8PYoMsTa6Bq7Ws7FOT3Dzp5yYf
         FQoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794244952; x=1794849752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vxIEo7GZ1sBSn6ZN0R3292yPNxYqlIT/6wxl14tijMY=;
        b=Sm7Rk9+J4m/YKUdhk23HeJHT5bUi0sZ+hzyzDixTt4OqEm6FmFA7Uai8+CiOdEqgot
         AkeS7VzEcOQvMIpKca5vtv/DQunRG5CtSOq9grUcaLpY/UevR+HPgbQL1/tPwz19drL/
         iTl3d7jN/9KWXdiAHL74d/jAlpx0OejImxWKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794244952; x=1794849752;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vxIEo7GZ1sBSn6ZN0R3292yPNxYqlIT/6wxl14tijMY=;
        b=t2Ygf/fAOjgjZ6ZuKifGKtu1sX5ZF9Nf8KwcCGMQK9FiyLBspjEYLXaqbOFauBhP+2
         kFpUPX5IqZqyLf56YoH9JIIck0PymLBJxtAS7InjbZ0yvJ5/fX3WFPsMHz3SvqgB1ccj
         oiNiFVpFg0SN96wkLMlMxuIVFzGlo92gTTcQEQT/w7SkAH5qrPiqp0vJdxtFxykMsYfO
         711WP2+W8FAEZ8XIPuPZ/4ghp6aiXZLj5Z2jlLpLQbLifeRKUPV09eF4kNllZYr6/yvf
         ki9XounC/nVdFS7g9wUrgXJGXwKlyiH9IPQLMp3WS17e5+zSfuaRk6ACr698V3rbcyS7
         7rMw==
X-Forwarded-Encrypted: i=1; AL+hErEgRMIxZsZ/mGm/68jsw0dl2vE16PSc+3U3INUcgM5sN0vFW3/4Z68a69m7rjoGr7BRWDhQJnQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z98RZNR/mtV9oKsgjC6umRgkwC2zwimo2+o+hOJSd2e1jUtxgLt
	ZUvkIlVQ8B98dS0lU3ZFWSx0nQK1lQflzakBE6KhjKAHgoI99qnbcCei5ad7ZmCRfU+Xxj18hgC
	HKrp9J5D0rXnyp9I9d2i9IZ6GnDSnvNfz/ftlEaLZGThrbb6FHaU=
X-Gm-Gg: AYBFou0QQPdJ0AioWOvQKFVPKaY07CMAifVH55ffDqbR4i95dQNA2dBUO59kv74Q0Be
	Qw0//VaWM71pE3qxrahzLO9Rf5LsPE9cYWggdqfn/51E7zRi2MWr9/sFsrVvGhDKGv7BO5gkIQX
	dvDVe6aTnfqUNUz2kMpwIoFHKNh1xNIp/atfY3y0C2OG0S4GS2S9WhPL26uE3p/9Cv0Lq0/r9Ss
	FLcVtnNLNjzIkSqVN/U1/thk4P3idrOj6vmw4GRON14CsclqCUK79/s2tdKvittL5457LgCBytU
	mEJC9U0CxfdfnH+zV3vhwxv/mG4GVT2TcdAolg+baD2FyV7yMRwSuTp6TsxMEfip5IfYxT9kmJ/
	kr3X3HT4U/C5ZltfX9Z7bhbsrx6fROKwyGYu8RIYcw1QqvIyjRJHw0wc/T029TW2ms+pe1/FLl6
	41zWyiY+tMcD5jZKA=
X-Received: by 2002:a05:6a00:6c91:b0:874:705d:f63d with SMTP id
 d2e1a72fcca58-8ba88c91098mr264109b3a.31.1794244951929; Mon, 09 Nov 2026
 09:22:31 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6f0ee3c4-32b7-4422-b69d-c879c94262a7@kernel.org>
 <20261106092441.00cf9765@kernel.org> <CAM0EoM=4fNFXaFUV1kh-H9Bdrt_K0yDsbOMJHWpgON2bG-GyEA@mail.gmail.com>
 <ef3ca6c4-57f4-44a7-b44e-f34e06dfb3dc@kernel.org>
In-Reply-To: <ef3ca6c4-57f4-44a7-b44e-f34e06dfb3dc@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 9 Nov 2026 12:22:20 -0500
X-Gm-Features: AclHuK_UHq7oUn6W7ikdlHBYM0xzY3q6rKDE-s9xcUZeiu0yP48E1Zq-fPK-eAI
Message-ID: <CAM0EoM=GofsOkOdLv_-xRMRK8u5_E5BSgnqUCUcReZDrKuUEHQ@mail.gmail.com>
Subject: Re: NIPA: TDC: delay the start
To: Matthieu Baerts <matttbe@kernel.org>, Victor Nogueira <victor@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Pedro Tammela <pctammela@mojatatu.com>, 
	Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 11:58=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Jamal,
>
> Thank you for your reply!
>
> On 06/11/2026 22:39, Jamal Hadi Salim wrote:
> > ,
> >
> > On Fri, Nov 6, 2026 at 12:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> >>
> >> On Thu, 5 Nov 2026 11:43:27 +0100 Matthieu Baerts wrote:
> >>> Hi Pedro,
> >>>
> >>> I hope you are doing well.
> >>>
> >>> I'm helping the netdev maintainers with the CI (NIPA), and lately, I
> >>> noticed the 'tdc' runners were often marked as either "timeout" or
> >>> "pending". It looks like this is because it missed the creation of th=
e
> >>> branch which can take more than 2 minutes for various reasons: PW acc=
ess
> >>> is slow, git push needs to be retried in a few seconds, etc.
> >>>
> >>> I opened a PR to delay the start:
> >>>
> >>>   https://github.com/p4tc-dev/tc-executor/pull/2
> >>>
> >>> Another solution is to let the tdc* services running and doing the
> >>> monitoring themselves. In other words, you need to remove
> >>> "single_shot=3Dtrue" from the config file. It might require you to up=
date
> >>> the NIPA repo you are using to get access to a bunch of fixes.
> >>
> >> Keeps happening, I dropped TDC from required runners for now.
> >
> > This was an issue related to the indeterminate time it takes for the
> > branch to show up after creation.
>
> Just to put a bit more context, having no results from a runner means
> the CI cannot validate whether the batch being tested was passing all
> the tests or not. So we need to wait 3 more hours to get results. It's
> not dramatic, but here it happens regularly, and it should be easy to fix=
.
>

Agreed - we should have caught this sooner. We basically claim
"nothing to see here" because the branch update hasnt fully propagated
(although some of the time we catch the branch propagation)

> > Matthieu, Victor responded to you; the overall proposal you made looks
> > good. I don't know how we can fix this, but since Pedro is currently
> > away we saw this mention by pure luck: Can we change the contact email
> > address to hybris@mojatatu.ai? That way if you send an email there,
> > one of several people will see it and respond.
>
> Good idea, I just changed that!
>
> Please ping me when it is fixed, so I can re-enable the runner on NIPA's
> side.

@Victor Nogueira  is the one fixing it..

cheers,
jamal
