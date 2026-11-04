Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752190;
	b=ZiilKpUm8OC1r99R35pllBD8D3dMVMBdjw9BZ1BDgEw3sS3JUt9BVXY7wHeC4vq7QToN
	 +HahOsgw6m8oyELpmNj9jdZknA5WnpwaKzMNJQO6PAk8/uh/lR0SdGqzu7mYPtNqr5hdf
	 VOHrUG3g1ihJ3jE6py40qWFoxhaWlNY1JllUWEi4QNBm/kkxGlL9ZnaX6F9VtHDGkrsyD
	 pNYxBobzUwardk0IqdnkFTapjRx3KGG/8W6qGaRGpwrZ7SQ94RKMgn4WPbMix0Yt5dE9J
	 upXM0bZKq1vZxmOvU4JnjJvrQjkfoKqkTb7BZuqBK5wI7tBfAT1e2RyfpCEN+r2E/+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=gLFQSHxO4gGr22ybqjiMEW9byafCmVvekiJO/cKrO1Q=;
	b=G7/69UgVPiH/p5JlxhGqD/UZYqBr8HNmKaPGg5tDbWRyQ5rlx/kc+iDNiSOiyf7GQFgg
	 yJRPQDJKXfu0NEN4F/4oK9d6bIoBRS7eW9Rt5hmVqRiNW54OjfrJObHyl23fgYueJ7wH1
	 RP89hHBJue+MRo6ggXzrXauLtKlabX8zudxrOMT9yfHathy83LNfT+rabPyfuqVpSurtt
	 CYpkviEWllb1kk//wa+fky8XPRCCWg5ew9PRpfVDmFJixbD33eGwocJ8cDdw6gDzAPOfU
	 aviI/2DJWUyLgQ8/ld9hdy8KTEovOGU31jTeXm3y3xIc8ovWLWNNWCAeGuwZ2zNJubg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xjX00fYx;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15915606A324
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 00:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15915606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xjX00fYx
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so116664a91.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 16:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793752189; x=1794356989; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gLFQSHxO4gGr22ybqjiMEW9byafCmVvekiJO/cKrO1Q=;
        b=xjX00fYxVz0C5LjLk+NtFhJOKKqfjNjgWARkozAxE3Xnti9OROsLwpnCuQkHhGg/WA
         V4PLR2qbe+yp82UmUbpn1REbcLOlVUogKhCHbKEulXXIDMrT8XM/MtgEfJlnQ5rJDwQh
         D9NNsz1RoI0NVuIFfpIFlqiLrNiqV+4U8oZc/Nd5M0Z4yiVeGEvyk+5lHeuU1f/jr3Fd
         7g1F6H5/YS1dkgcmfOKrEwzwhdBuRgOZjfI3r7ozz3BZp3Ts78ePkvLoCfIDCIC0iAqp
         6LH/xd/KrpDWT7oE9VrL1rnd0EeEQvZ/RynACvOC1G9VFtptzPCZK+I+FGxP9hkhKsSx
         EGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752189; x=1794356989;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gLFQSHxO4gGr22ybqjiMEW9byafCmVvekiJO/cKrO1Q=;
        b=EYl6ME/NGN8puCOxBEqM9ySAVZVw7QLjPK/31AHd6OVz+/GSzWzcmDJ49fb39cu8N3
         3W47X6IEeDdkFp5shlMHpG6ZipnxIkKPHOJM4CzzbC9BA8AJI+yqMfoleUSPibJZZyUc
         y95Sgfwo0hTRvj/EYjyQ7qgK8v5CuTcWwupmPM9ixGLEEL6DCBdh1yMJY/VNJoI9inGQ
         jVAjmVIaxj863tdD11+kCsfPxIk91NouqMyP1H9H/GKbYjRczMY2qfWnQWfLhZfpNx1j
         2p63hxo+QuIcZBV+l7TybjPf+Iw2eegPtCUFRtZBI9clck1OYNhh5AGEn0R6d3PKpme0
         TmVQ==
X-Forwarded-Encrypted: i=1; AKwUvByJ+NwPS7FtILIHsd4PSVmkqwPwo5O0LljGgwDo3qK7HJIZAcvjQipE9GHkukN4odweBAxTlQ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HkIJODyIsn0OnX3/zJDbN8ZgIoQqQIYppYROiaCVfKUB/fO3y
	YjdUb2YPZGiDpeoA6JXtv7fW/kfDRzHZJy3ZIg3htv1J7ZyTWoi3eOSi
X-Gm-Gg: AYBFou0fNKg5YcSXYpbQ/qxf7A5Qk7VRPQTxIy/lF6UuSCEEGa12X9TuxinBekeyv/u
	MIcYa5gE/NAWAaOBJTgwSZDkYiZO/YyVS2Jd5TdnK0FHMMOptfxuyc4YxXTq236AiUYzX/J10qb
	oi4CcinIMx34NpHtl6h/6DJtcDfj9OCEuh9m6mGoxOpoGC1RzU69wxdaAgzduXw1eevbyqVF7mB
	VeJYUjscU9f6oyCcekAMZys5FC6jJwgsS+pCZLtEqTSoBk3xu44+WZDc8pIhmC92Pz1fb92QCYU
	XzoXDUaIuYW5n5jd4lB1PnkyCk2sU2qg1iPtmGocDYi37BmAm8G3DPrQlNbOUTzC4t63yWPRdWI
	h1MFCAvwcoIb81xjmjYmBzDOwOeh5Kg6eSjOyPpzn13i3cQOZQBT3vW0Z4sUqLxat7/Ms/iefrR
	Qg3HbHuQAZ5aMOf+OIOH9uieFZPqKhcEiwSWZeSWNF9Gp6Iz+36hk11SYGcG9PDg35dxQRX8tUU
	+g8u6b99TTjHzTgbXLXGCbIUkTClTu0hZx24/lAaSjFTQ8K9x4U1TL4x6Q48F3Bj7EsQ8wc00ys
	v/T0Iq+IYMvz2Q34ifl1fmOBIKBAP/tSiaIIsNEzFvwV7atY1zZfuSTTzUvAhAhapaJ8bJEdSbI
	tpqf8O8sypy8NAj9KiKNJ9Oo1uo26FlsB7Q==
X-Received: by 2002:a17:90b:2006:b0:3b0:9310:b252 with SMTP id 98e67ed59e1d1-3b09310d1e7mr631008a91.30.1793752189425;
        Tue, 03 Nov 2026 16:29:49 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944ea360sm1208878a91.14.2026.11.03.16.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:29:48 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 00:29:48 +0000
Message-Id: <DMM02ZEK63KB.3KNTQTKEJD0G3@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kuniyu@google.com>, <willemb@google.com>, <matttbe@kernel.org>,
 <mptcp@lists.linux.dev>, <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 09/15] bpf, sockmap: Check the TCP state in
 recvmsg()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
In-Reply-To: <179374188255.488855.9131092470801455035@kernel.org>
References: <20261102072112.4160195-10-alexei.starovoitov@gmail.com> <179374188255.488855.9131092470801455035@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 01:38 PM netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org> wrote:
> Would it help to mention this path, and that TCP_LISTEN is covered as
> well, in the commit message?

Not worth a respin.

> Should data that arrived on an earlier connection be kept out of the
> copied_seq update too, and not only out of __tcp_cleanup_rbuf()?

yeah. It's an old bug, not from this patch.
msg->sk == sk says that the data is from this socket. It doesn't say
from which connection.
To hit it the app has to call connect(AF_UNSPEC) and connect() with
unread data on the psock.
