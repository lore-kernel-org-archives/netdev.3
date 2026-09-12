Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBED91F1534
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789201533; cv=none; b=r+zud/OjVDJGO2Wf9mVMiwgeNlug5/SA/7meJygNX7+rE2/ZH71SQw/qF2Tgj/7nB4ORyPuxvKnKOqu7WzBJmSH+MHe56EzCgTZ+J/LSt+FpxkSIIJzw5uUI1YF80E00piGFCKPMgjUY/RH6HbS0XoRyMZ7ETaT4WbxJVrJop4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789201533; c=relaxed/simple;
	bh=1fZwNjFgiv1iwilnK3XMfsjBAKCokGbGyTYW29bcql8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZnwSOdrlD7QhePWWknD0+szE7lCqfR6UURZz2VnNORSQRwbZ3dHeDViIoKjzTWpNITFOn3n2imXvPdCx9nbg5V1y0F3yjdeh+wtd/JKu3zg/QNq54FztsGzQsRaadV5e3Ne42POkIGoZLXWB4FG9UvLIpgn6shuJBjx2+Qj3hus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E2SRJZDg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBTy3Xoj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2SRJZDg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBTy3Xoj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789201529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1fZwNjFgiv1iwilnK3XMfsjBAKCokGbGyTYW29bcql8=;
	b=E2SRJZDgOL88PYxlg9KboS3E4VFnJI+to43Meg3EVY0itVsPhpOBQcjerU6joYnCIkUifG
	9QPr8mIPm1VkDmFsbqWjTtw/mjdt5wmOvEekiaTULTCl/HwdTi43oeXZi3XFOLLPDaytw7
	DJjEyOIx3RPpsNGdbPL44DKDk2lps64=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-jxJH1s7cOLazYETwtWUI2w-1; Sat, 12 Sep 2026 04:25:27 -0400
X-MC-Unique: jxJH1s7cOLazYETwtWUI2w-1
X-Mimecast-MFC-AGG-ID: jxJH1s7cOLazYETwtWUI2w_1789201527
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e65ecd557so8595685e9.1
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 01:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789201527; x=1789806327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1fZwNjFgiv1iwilnK3XMfsjBAKCokGbGyTYW29bcql8=;
        b=fBTy3Xoj8rrGohZufZw+lscoAoxqTwmmv15C+YefjVczI/Ah1rjGcn012CceOLlWza
         yG7enn9Ec+jxhPj6pEizfr5ZzqV8utplHL/6bpKAUF6TQDnLVrPjG+PTPn3ZBvL63M2T
         NHvEnxzmjvCXoXiL7qVchvY3v6lcPpkwQxMrDvbPxIj3g6hy/6L+UMFaIjB36AFk0n8X
         2n6QZgFo6ACz0GOx3OnQ6yAiu7qWjNfmFpKMo8teXii/5H1lGrG5Sv9GKlQkyDPAmNix
         p77mZyzGNMSkzPG9eViZTfBmLshEJX5GJIUMPsm5dMEdKjqTb8xcrO8jHHAfecLL8U0H
         CyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789201527; x=1789806327;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fZwNjFgiv1iwilnK3XMfsjBAKCokGbGyTYW29bcql8=;
        b=TZOEnJVqNcoM6QcPwWHUY7GtOlmHdTuNca/6PegbylED5fHjQGby+cef31LebGsS+B
         PnO6USqxwFlT0du47yvH0KulBgqf5jdUGq865CDzaLnPhgXR7qcxElhkfj1gq67f7c0o
         hWcWvWerJrNBKVs29ZBpqi66kPfUYcnO7lEqzBIyPVORf+i/M2wDX/aTFx2gxBmQ00Kd
         krkcNcUEkdx54D2J/yUH/lBm+6g/qd6pxnCewlmQwXZGNWfz+enDFm3qDI08zSn8VYcz
         Xq5foRp/4vX4ItWV8OTTa2DiS8Gawce4yAOXHNAgNiswGDvV9f7oG0VV0eQwEWsLFJyc
         tSfg==
X-Forwarded-Encrypted: i=1; AKwUvBwFdDsxiPKp/DzysE3Ln7FGNWvGR+UEdy7+5IypihR2jidnJoGq57+ObtQ4pDYmD3ErsiyjLdE=@vger.kernel.org
X-Gm-Message-State: AFuF++nqRVEqCKBFQigKiU7N5QJefWa6f8GQzTHCHr4taGiV/evOVo4V
	COvclsdDrlJTanLbwUEO6OYWl/xPscGNSFFGmzbQvrOfqFqRV1JezeJrHvT/crYkE9VT/24jDJ0
	ZGOSo8rsXQMoz2ABD7FW1GiyQccqTr4G2t4kLchSVkYIBQlk9uKpdDklAlQ==
X-Gm-Gg: AYBFou1Nu5RFzPvoHt+GfhpY5GKqIH6htEzT8sizEiHAf4mfzmODPVz4LxUEN2fkoZz
	768GQZ3VXFDOLfbMybpig27kI8DMpMQg/KZHWhl7RZdNig2yLFWTCKRopa7BoVVqwI5RfsOE5DF
	/bwuHVkgO/Yvb3yp9poh+QxUyFVlfEHJ43+noa+sCcgxqNdYr2ITIN646RMXnb9zlXDcQ9HXYCt
	wH+JcPx0Oh6vJTZSYMHhd3y85Jvua0hJw2DR52bukZN7BiREOg6UFfp9Tyu9dCeUvOCmKRgAHLv
	J+tPjhZoQS9gyNhvwj289hLGa5DmdmW6ct3AYZ90q9zlKAKtHhHzO4TQ1K5Zab0AzK/u5gjg4Rr
	ZpcfHBhdljxmewzwizIeu4Hs+nFU=
X-Received: by 2002:a05:600c:4583:b0:49c:fc6e:8cbb with SMTP id 5b1f17b1804b1-49e619e148fmr89799145e9.31.1789201526775;
        Sat, 12 Sep 2026 01:25:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4583:b0:49c:fc6e:8cbb with SMTP id 5b1f17b1804b1-49e619e148fmr89799015e9.31.1789201526524;
        Sat, 12 Sep 2026 01:25:26 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6c0cb676sm46482905e9.14.2026.09.12.01.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 01:25:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 897FC9B9A96; Sat, 12 Sep 2026 10:25:24 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>, netdev@vger.kernel.org
Cc: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>, Jakub Kicinski
 <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Danielle
 Ratson <danieller@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jonas =?utf-8?Q?K=C3=B6ppeler?=
 <j.koeppeler@tu-berlin.de>, "Matthieu
 Baerts (NGI0)" <matttbe@kernel.org>
Subject: Re: [PATCH net-next 09/10] netlink: specs: tc: fix typo in cls-flags
In-Reply-To: <20260911214148.1184806-10-ast@fiberby.net>
References: <20260911214148.1184806-1-ast@fiberby.net>
 <20260911214148.1184806-10-ast@fiberby.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sat, 12 Sep 2026 10:25:24 +0200
Message-ID: <878q56dggb.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> Fix a typo in the naming of a cls-flags constant.
>
> The correct name for TCA_CLS_FLAGS_NOT_IN_HW is "not-in-hw",
> not "not-in-nw".
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
> CC: Jamal Hadi Salim <jhs@mojatatu.com>
> CC: "Jonas K=C3=B6ppeler" <j.koeppeler@tu-berlin.de>
> CC: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
> CC: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@redhat.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

