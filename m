Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.229.134
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792841735;
	b=qks4cmqFQJoD3SeDng2/eAVslbUxnuOEeQhY1v47lH4ZyZ4t+hO1CoXK8tVmsFXt8KlB
	 lY2n6PfPh7+hBC9qDRtd8pzPYxlt7vfmKsKBA6USu3y5nvfZWWDg2Bcu/6DgXHaTTOv9Q
	 wuaE5Wz4iadbNtRZAVDc2/pAOnSh/EVsWKhNk7DdcjiPVGF+jNTTkN9BPi9Y8inNDf4NI
	 qmZD5rXwW1spvDKbNI/5MTl2qttiMLSHC61r/0L5VcDCYbyCKr5HMHSLmP4kahw0rnfc7
	 +kJRLFVtC0d/WIUCo2SRSGZ2eqaG/Vkm/A4ot+Qibt/VDcjGkWNlkDELWIV9NCux5Cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792841735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4Sv2Ckx2zgnf0FNK273cchWmqdaiROeR0BuSXmJ+PR0=;
	b=PgJwwGXP2d5Vj0sO9zlhuW5QvmNj5xfJcoP1NCiOJ1ABKkhSHqpb/AP3Eol4tWtppDXc
	 i1H7Zm6USf7DOm9rtM7VvI3ajgGqKN21AzlbSb/1o8PhPgBjCgyXnFzEJLqQzy3MONwDp
	 d3GlZ1B/hXSdHI+2gpFxEd64xxaFKSdEHh70ruhUDcEAq2cFnba9jsi2BkUWddmObj/pm
	 0b8Uug0Fx4Uxs97lLhqghFRQEZqDkCo+DwbRobKIiZzpvlFMU26YP1R4jsezVKvbB7bHs
	 YAD5DOBppvw++0m3W9CSzo4aWeHIyfs7TGfAVXPQbYSwSYhHBs/pgiu/f/sKOr0S9nw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UDpQHhjO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.229.134
Received: from mail-dl2-f6.google.com (mail-dl2-f6.google.com [74.125.229.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73784606A31D
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 11:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73784606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UDpQHhjO
Received: by mail-dl2-f6.google.com with SMTP id a92af1059eb24-14b4e009173so39641c88.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 04:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792841734; cv=none;
        d=google.com; s=arc-20260327;
        b=gfXRsj+ndk6XZ6lRjAgK2BiOAgV6aosYs8qOUOYgZE89ytWeb3KdBk6iEVsPYK+Wxc
         MkPbV6cyWNdOLgBktebs6/KrVXTQ/NYIEVeb9zPB4DJU4+6lRTwiFHREg9fGSbVbUD61
         9DU2MauFC7zLUJKgaBYMIauTId7rFPiPns5VGWTB1fgLBgJaAN71sZzGzJ+IQ7xvNwlK
         jwskvgLdJLkZHHMtn3D16NMxbgk/fiEbQ8En1Aohy25cTb+9z76h7K7o+tuYFyvcWWm1
         xXEnIr/PJLURtyy78+7w5eFudOXisWmsmThdJS3dRt2s90NMIBpbmzjqllapMTKyU1a7
         mX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Sv2Ckx2zgnf0FNK273cchWmqdaiROeR0BuSXmJ+PR0=;
        fh=vqgnRkAR2vm9KfsOn0E5TBDBgrv3a/v9hHqEDdGAGoY=;
        b=iqjU0UEv1u8oKOm9T7/eLZ/kXqhHZkaq+0L7GsIpxDG23xj7zuvVcdC0rLUocj+XiH
         mitpFRgX7ZaD1pIQbUiVQMjKtVFgPQjG2ZesFifA7H9PX8xRaH2mnKRRqCxu9jnkrqSJ
         yse8XDxr9W8gBpBSxOpN5mfY+vX011iCouCXPd60HSuvlEHJTu+Qa2dOtEyh6DnEuw8r
         MNYmEJvXG3VfeTtZlPeZq7fBOzDc3bWzMQVKrmjtdWoLkuF6fGE5Yz3YDXyT4eHPvQcm
         OXQa77ZJFAHqrhn+p/rYEV+igOcNWIPx0b8yGqf1iGrUg9jGEfF4M4P1hYhhZ/fISCZu
         bjlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792841734; x=1793446534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Sv2Ckx2zgnf0FNK273cchWmqdaiROeR0BuSXmJ+PR0=;
        b=UDpQHhjOOpLeAQ+UqfGehYdrCjlB46HMjQ/EW8qK/18tiEejR8MvCMHJZhZB+Dbz/R
         dlwWzTaBw3JbXtV9nAmMH4d5UVrTFgJjvvWCWj7LbKp1N3xectQvJaecfiHJLA21W20l
         7w/xMA/SQT8Gal2+9D+D+DseL0QDgJV7lt7CumiG/qpIqXC+iBRyhwCNtB6BUNvK1sr1
         LwwNEEA6NFQCQ3XVX3bwmopi/vLJ5SGeDu29X3N1Voy4LUcY5wdbaHfgJLuT/xnLpz5U
         ShjTjQbba90lUXadzxqleOieNVGfH3S0VWRDy20FCfKTz+Q2OA2QKNQEDOiXChyGYpRM
         uOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792841734; x=1793446534;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Sv2Ckx2zgnf0FNK273cchWmqdaiROeR0BuSXmJ+PR0=;
        b=spP0ywqQ224YOA8rX9Tue9S1BzHxJpOn3Fl/4R/TxklD/y3GecpceNBBtsR11xLVs4
         aPCJip4siEB5QiYGLliG4sEiovHqxEaKSmKbEwobC4TeugIIj9n2JFgF9HeWpGuYeY1n
         +LDZIArBgQgPca9Uiu5ZkL/iT4dSQEC40v9U2a94TEAFfqxcy/wthgOy6xaR9bifysdE
         ANJVntm1ympMxsTj0DnTcaJbFka2FttAM+I9nn2M810+bI+ebeqcaX1vwIuchDOiLMU3
         e/33yipFtcx46pmpR4lGYZ4lxUwdqcZaAEQHdG6I/dJCOLf9853cJJZxjwf8awPXXzZc
         XLEw==
X-Forwarded-Encrypted: i=1; AKwUvBwYW6lwmelk/+vZBdL60W8MCVGnqVqnGc7OQuVB9BnZHx4QLCmg06Uep3f1FSa0nyEdiZs/fhs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIzQ0QUWlLWazxtCsWzgqsUKgE0+cJKTBQj8zypsZDO4VH427OK
	MJvsreLCcJZxhU3eNgdCTg8FmhrAdMuF1WcCkrHk27IrscfZR+mXgmhnaDq1AIpKf0pqdw5NFVR
	6ubKa/gU+wklr+qWesrmTVw/4mR5Coj8=
X-Gm-Gg: AYBFou1YZG1rKewrTMNwKsZqjS1/MHrGlJ1j9qIXtWD7ptX33TOdf5YleqFHHtUcAVe
	7KB60s1OWjJTckmgBYYJc1/vtJlNaIEM0doGonOh1x36rJogxB/y/SGolJGrTcGmcijXTPivqZP
	ZNNifyXt+H6TCzxfdpTPNoQzxJZez3mb5T/BjMzzPbm8WYuhzT7pl1KHE7xoZEPNEIXDrFItfp1
	qVDKgaH/zqtiRfHxrtndB/g3UcKZ6kOq6WJJL21H25CG5GKiZxtNa388tVCzk87qt93w9oGlhM7
	5rlaAoyVc6XqCSJRbJdS9G5aNmT0KizMzvzHJxi3djwcsHSXLHD6u2Wq5RSNAyOcTEKhSVkHYrJ
	GB+Stvaiy7jSO5zguZG04dTk+6If9PeAfcs4=
X-Received: by 2002:a05:7023:906:b0:192:a481:361 with SMTP id
 a92af1059eb24-1994d8b9822mr2570217c88.7.1792841734448; Sat, 24 Oct 2026
 04:35:34 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024091256.17918-1-testwrzwrz@gmail.com> <179283334099.3327.11706883238489839470@kernel.org>
In-Reply-To: <179283334099.3327.11706883238489839470@kernel.org>
From: =?UTF-8?B?546L6I2j5bOl?= <testwrzwrz@gmail.com>
Date: Sat, 24 Oct 2026 19:35:22 +0800
X-Gm-Features: AclHuK9pxstbMYf0EyqcMH-TBmz-g6K5xQuClbbepH1SlLVllcKyJtSHElNXP04
Message-ID: <CAKg18mkvJVPgYTr8ie2K6_q+rBAHfvCnxgbb9i+3Wh_v-cBXow@mail.gmail.com>
Subject: Re: [PATCH net] xsk: defer software checksum until the skb is complete
To: netdev-bot+sinfo@kernel.org
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I found this while studying the AF_XDP kernel implementation and running my
own multi-buffer TX tests. When I enabled XDP_UMEM_TX_SW_CSUM and sent a UD=
P
packet as two descriptors, the checksum on the wire did not match the
expected value; the same packet as a single descriptor was correct. I then
traced it to xsk_skb_metadata() calling skb_checksum_help() before the
remaining fragments were added.

This was not a production or syzbot report. I reproduced it with a standalo=
ne
AF_XDP TAP test and extended the kernel selftest: the unpatched kernel give=
s
actual 8817 vs expected 52507, while the patched kernel gives the same
correct checksum for both single- and multi-buffer TX.

Thanks,
Rongzheng


<netdev-bot+sinfo@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8824=E6=97=A5=
=E5=91=A8=E5=85=AD 17:15=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
