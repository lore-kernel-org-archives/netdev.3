Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793542248;
	b=yAKGXDsPD7saQoZg6w2peDQ7V3WjrUbl6Udm+NSeU9a6aMGZjWi64nEC8l1MlF1KFU5m
	 88Bvoq8eO1W6Sp/EPaet3jI/jqkqojNrhNhm/2Q/1BruOCVB5KrsA2YzE9ACScA2gsz2h
	 tmEn6s8De58DsToXU4PGbLLfFu0W54OvhnVTPNfRXGcNLy9bJEecKflWQoy8XjrpkLWVs
	 GxSG9wjAMzRijBgo6prB3U/bfdqAfYMmfxxZZa3p4TtboPhFxNFBi05n5rAnU4mHDRjCm
	 OnM5fQ2xxuQDr9kwZObbcmWTxNK0yDLw+RBcde/fi1gghVOZYl+j3ZStJUVlMyGeJGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793542248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=JZh0dtB7kEzQ8t1Ji8gaTvjeVLTDeZZWpW+cXbA/soM=;
	b=3PBxyX4ampz7LJbWupkMIHS+F1mv7hOebLGz3acJAYsCOxvzZ3T0QW/La6kHLv49pabZ
	 jyh6Q2OyOtl9idt1TEdsie+G7atFe7e5YatY2+4raQ4uCQUAoBVmNi7TyVTxaQ4HofkX1
	 T1IqipTE2t2LvHpoIDeaDAgaENaOiWPVPNPdbN7gGoWPGlpM3JmnwYNZbqEVeCdFJ9slH
	 81/SgzztIq/tej10TLYPQD0XfJqtos466YJIuTVbbvRbHFjvYHdJUIVI8VR0oFJN/STnM
	 /gmIPi5hzmd3SjBdInJqjTXiRS2F7zBMnR66pCaBSCfpv9DFPQ9AwaMpgJYD/zUaOkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LaP+YbmJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CDC606A325
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 14:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02CDC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LaP+YbmJ
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e8ad5b2f61so4887305ad.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 06:10:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793542247; cv=none;
        d=google.com; s=arc-20260327;
        b=S8+wEB0P0NpJp66yGJNcZV4VluLAyd0/rK6Dzu3UdKtSQDtcYPbvR6PHrfnfTSSIYU
         4Ff9mOe8Vd4u08dayR7ieulpsjtu7Z9yMSIRuId1ifa7RjoNyiyiwm0m4m/CZfbZg0YT
         +CeFYNftPWFJLlGuUREiIlpP1GasRyIwmwjIgGxpBXDvI9yQ/4VELF4dyItVIJ6yuXrb
         ApvEV3p6YMV2qxLuEyqdeyYXgkFYm+7tyiXoYvL/lMSM0RMc0htgGaeh5lBoRwU60qA9
         z9wnIaf6cotj8AdOzHTorK+wGNsY1g3Lu2db+xdLKfhl+sWDKo7OEChuVzo6d0oNiIoL
         dr5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JZh0dtB7kEzQ8t1Ji8gaTvjeVLTDeZZWpW+cXbA/soM=;
        fh=lTaJyk/5vWWkiycioiES0QO5Bfznbxh0zqCZv2IG3T0=;
        b=NIXtw0iz7iMQsl2jTODF69C3RQp1Po3qO5RWTz0eagWOuyRvTdgJnmnwpw+/BnAG7T
         cnYY6GVbY3chu3TMzKuGko3gzctbv/pdvwuZ050nTUqWNzi5mq21q/kXVb1QxECLpDTH
         ldwMUNBbc5t1yjIe1cuYKHliKb7tBaQT0Sqe1oFXAyEIQeDr8jFbqVI1Io3og4uZukk2
         LXd5Uuq9qiPaPOYVk/SNoLDuGI+B3IjFDXXXtF65uoGvqd+wEjfDf2soeet10hrKvGcX
         sduTij3wlAkrdWd/N4NSDGI+UbQljtgMfbjMlHw64dwhppKTnOgzBwHcPDQpH9zH8wFr
         hQWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793542247; x=1794147047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JZh0dtB7kEzQ8t1Ji8gaTvjeVLTDeZZWpW+cXbA/soM=;
        b=LaP+YbmJ+d7ZL7RAB/xZ4Gr8/NqdeGEpalT9pkPsP3BbxkgnbfywM4i13gRyzyrh5p
         qGLcDRdKsYzTzRAwREzWCzZeUCl1JCjETt70UHuL13AoN/+SAAixYcoTu2X+XUabGwnN
         k6Y+8yRax0qrezjt/pHm0kACHTUhSctTFBTPURmUbuMWaW/BWtY5RnWeZ+yDSGhA6RPp
         pAwthZhJZJ1Vp8RPnHxeIn4eJFj49yxktPt2WVJ4ZdZuH9dWCQvCb6S/xaglr3FCh5Oy
         XJueE8R1QfX+tiJDllV4f8XKfce5p+zQ9DT5ql44O5cT9uUYSW/2ZxwnjhCPAFVHRPZ4
         1YNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793542247; x=1794147047;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JZh0dtB7kEzQ8t1Ji8gaTvjeVLTDeZZWpW+cXbA/soM=;
        b=Du9J3+BdVM0lAzDJUAMKEBN70yO010agYMS/gYlzoeqm61L22J6FMkHU/7ERLLNThg
         m3qSh5aQCi9kp9jx5zImcyqgb24DWT0U8U32gEuIKgyLu5tLVyjR+8q3lHYutwkU3MPY
         5X4WSUy8FjqGO7cNDrhqwcGLwFeHBvqS6FwUyROwLECQR8/4hNFIr7STEtwvirtIpWd6
         7xGgjsZYzv9DEgJfThJSRFc/y2W4qxeMt+muzWL6mxJv6xMDuR6LiluuIxyV/fjJpKi+
         /cEMkPL8g2LQTFcJfn1tcmWIggeYyHwLdjLd5aOp8e5ycON0K4ZQzf3g/z1/UnnHutxD
         3lUA==
X-Gm-Message-State: APuU4Z/D32Ogrhib7FVzkUexOY5Fw9X/I2+m6JFEUL9xjX+AwknIzDyK
	TJigH/Vk7K/i9QAfRlKZmaiAuTP/Zt0SrwbMpi+RBUnKy3nCYcMdmqJdsvdTGsby6tfbtsK0AIb
	mp+w/VSmH0Die7ECNXSsE5k0olsyFHLw=
X-Gm-Gg: AYBFou3dWIalh/+POKrrVhviK/DClrwCRJ0ytGH0wsX/rPVtMy/0iqFgYYDxgS1kdeC
	LeUtAA3sh9QCxrLlUdgOJO+ZM2hJLLSZob8mAFsk94a38YAYU62sfBQPjuM6rkVrMPc/rJk3MWa
	ZvHmng+kweiTYwiBooplOAT/0GoviKVBefRDQ1/s2ibpNnwjwTf8Ol5ypgl1KjM7Brw7kZyz85A
	LEz3yttRv8bLONdaRfy/MOnqhYNX8SYMfAWDzuFAIU60EDjYzFKo5mfNS8lcIirnXwKkocf65oD
	dL+vyolXLxuShIWoMjZ1Gf4nMFLSgEH0u5W/jykPGz0kWdy2ZuQroXxHZ8xjU9imFHgNgyv+LFH
	uIcBr9mhO7ncXBrdz7UsBCq7L+WjYbEpChXph1OM+g1KzAn7RA7YKX8z8gd70TNrwn++P8A==
X-Received: by 2002:a17:903:2341:b0:2e9:53b1:a3c8 with SMTP id
 d9443c01a7336-2eb36335149mr116070385ad.0.1793542247147; Sun, 01 Nov 2026
 06:10:47 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029033942.3644-1-q.h.hack.winter@gmail.com>
 <CAHC9VhRQ8E7zysipt3Kt44oC9m-eUc78mR5ipR3YQOwuBXAV5g@mail.gmail.com> <CAH78GvvgG0GpuR9bvM7fDDz-mpakfBuvC418-nEBUrA9pR8suw@mail.gmail.com>
In-Reply-To: <CAH78GvvgG0GpuR9bvM7fDDz-mpakfBuvC418-nEBUrA9pR8suw@mail.gmail.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Sun, 1 Nov 2026 22:10:36 +0800
X-Gm-Features: AclHuK9N0FJ5UQy90T4KGShYVLXixh_gSNnYfvcP7CZvWoUeBSlsdGZgU1GhS-E
Message-ID: <CAH78GvsS+G8DkiZ=kuchsOp9E5FQMWc45eoBZvRDO3_Y5wvXag@mail.gmail.com>
Subject: Re: [PATCH net v4] cipso: fix optlen corruption in cipso_v4_delopt()
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	=?UTF-8?B?THVjYXMgRHVwcsOpLS1SYWJpbm92aWNp?= <omniameasunt@proton.me>, 
	kuba@kernel.org, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding the net maintainers to Cc for visibility.

No changes to the patch.

On Sat, Oct 31, 2026 at 3:22=E2=80=AFPM Qihang <q.h.hack.winter@gmail.com> =
wrote:
>
> Adding the net maintainers to Cc for visibility.
>
> No changes to the patch.
>
> Paul Moore <paul@paul-moore.com> =E4=BA=8E 2026=E5=B9=B410=E6=9C=8829=E6=
=97=A5=E5=91=A8=E5=9B=9B 21:55=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Wed, Oct 28, 2026 at 11:39=E2=80=AFPM Qihang <q.h.hack.winter@gmail.c=
om> wrote:
>> >
>> > cipso_v4_delopt() recomputes the option length by walking the option
>> > buffer after the CIPSO option has been moved out.  The walk then reads
>> > the stale bytes at the tail of the buffer as option data, and a crafte=
d
>> > setsockopt(IP_OPTIONS) buffer can make it treat one of them as an opti=
on
>> > length, increasing opt->opt.optlen beyond the valid option data.
>> >
>> > The corrupted length stays on the socket and is later used as the copy
>> > length by getsockopt(IP_OPTIONS) and by the udp/raw/ping sendmsg paths=
,
>> > where it exceeds the size of the buffers they copy into.
>> >
>> > Compute the new length from the intact options before the move and
>> > subtract the CIPSO length, and fill the padding with IPOPT_END.
>> >
>> > Assisted-by: LLM
>> > Fixes: 014ab19a69c32 ("selinux: Set socket NetLabel based on connectio=
n endpoint")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
>> > ---
>> > v4:
>> >  - rebased onto net (fcc00b15cb21a)
>> >  - reworded the impact paragraph only, no functional change
>> >  - first public posting (v1-v3 were reviewed privately)
>> >
>> >  net/ipv4/cipso_ipv4.c | 9 +++++++--
>> >  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> Thanks!
>>
>> Acked-by: Paul Moore <paul@paul-moore.com>
>>
>> --
>> paul-moore.com
