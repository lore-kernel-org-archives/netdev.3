Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792937245;
	b=oY2fg05Lrr/x7RjHdIyFHkodIeuQmRogKaypXUH9OrquGd2jqN1jNJZPzym8W1tMtScy
	 b0Xiskt0kORuWRluRUvpvbwVJXpFE82qUth4flm97NnynvohbcwG2SROe/4Us8BrHOI1R
	 R/9uF7SvYhlm0Z0c0WaOsnFZkRW2F1WH+s/Fc7YPOOJrjlBPs8i2tEiM9HCS6kFEzWZ7b
	 /3QcbD43JkvHL4gsut6GPdC6xjbTqTDvGDgPZUF63LisFbHXbpwt25xjQhPB8Q8zFEahk
	 cjCP7YfUVcvH/kOc95imkNF04F/MUae7yTuC7CkbLezCM28iW7p1BQ29ajOii1Yi2mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792937245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/WofT0yh3KpmHARnSgrS9AsbIBrE6V8uNY4po8M3XK0=;
	b=KcRdHY+oJwH6zsr8wRwx7hKZckwFJQwo6zoYXLsoUNlKb6dfNwrDa8QIWQPO38IFiFZ2
	 4V6PW2Io4u/uPtD183WZMKl4i94wKffStCMlBYSvdOtTt272O0kGKodhPwsazfNXHRZ+1
	 Y0nlUO/Rtybz3tQ6XYTn5iN20EfdhkUgR+lkASZo3u9yLtBY/8b7chlPdnYiS24ddlpgC
	 5l3NsCOVZREUWAGVVHkCbmJ2BeIf7RstdovSDaVz0xtZFpKEsIhcVle9qMsbxfk330p90
	 9Lwd90KZCGTAr0dl/HTYs4fjZDKNVPu8X4OFiw5T2tNGR1yUf+C21pEtq7Nm/5H4fwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1635606A31D
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 14:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1635606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e9f6a16aedso14133845ad.2
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 07:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792937239; x=1793542039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/WofT0yh3KpmHARnSgrS9AsbIBrE6V8uNY4po8M3XK0=;
        b=oqeADfQV64ONsHXyegylGm2pBiC9f1WfKiwdma+Qh6bk/8LF8EUBep9hjXbRXwUhXI
         md9BJk/WWbsdXUibnsyyggsFwTBOSuGquKwk1Aed5mBJ3FKGhmW2XOcCz0a4KNTtopOs
         atERMRjzhZxrLPhNWjaEl8UaI6IOIA14/333ftk1ZGml90HC5Y1oo66n2iPuacrpj/mE
         Px1wuvQa6HIHkEO1uWnNSbQb/JDwQIhKu/x7dwdnsf1M8LtJF9rioMlUWyPu58Xmcodn
         YRrD1ef8FxrDFpPePRxsTICuMZ56buZBQWmJNmSHjSVwQSlx4ofuSnDVTbxGk8+NHjnk
         4/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792937239; x=1793542039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/WofT0yh3KpmHARnSgrS9AsbIBrE6V8uNY4po8M3XK0=;
        b=rLXwKq4msZt8E3zHdKpvGph4iIkqlrQ3HhznXxBgBX9A+dRnvmmBVjqK4MsKrIlYnJ
         di3pzA7UDO8bN5fIlPoXnEuo7BFqu+Jzw362lziGx2cFo92XMLKKLQihtVl6qW8c2uGv
         LkNZRhFqSwk9IKA2tPSB01oSJ8d/5N3J8tB9gJz2ujTQgeodV+O4VV9+WXwF5iUOyTfs
         asIHHhHza61RPdFPwp/NWsM4bxgtd+H076DwhUNYVNMx8setT9B2nX211zSLQSz/w3I/
         pOb9fNys8f23YCOMDAvHiiNwFC158ibyUi9l2vn7RHAG8FIfzlxIyBThxsrgfeOo4Jzj
         TGQA==
X-Forwarded-Encrypted: i=1; AKwUvBzr13eXWFapPm1hFC5ZDC4SF4RZZS6B1ZquCqiFBJlwlHUFmVr2T/q8KnVxK71ZOgM25fYoZl4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI36wMG8Js/Dnxkx5sOX67wO4s8/KF+r6TLy9LvZOmEf3E9WNeJ
	H6DxC02YQrl+TGQ07IpdtsMqJfQhk/o8aJealGzi5azIo8TT9bwQidE44XJetqwmR7I=
X-Gm-Gg: AYBFou33UnTHiAPjCVgBugMLSYjREa9oghWZ3rrCqLXBhR5H1+O2c3st9zMQFgosPNX
	tdWS3a6iAERJUoE6ZaGSy0HItrh862BuTGBKsd2HhaI2pNF8nwDsjDeU15LmqAjeY+DiKaYdZbt
	qsGkBgVFC++A8+ST84bkpkOCsbKARuXwl/mBHgQVVUlsZHukLgxsHKs4J1Qat/83AhOYdrM5rZB
	iu9Td1pvJ6h5QlqJVguIEtAZYnjdZXqTaTjY8+MEBJe8yEI6jpt/aGIVqEUvUc3rtTEmzJCUyBK
	tfrl3V7Mel2cpQ1Ax1222YAsWBDwaAO750pDAsduCgadG4U+0rb6L2+4kQyR0JmQxZqSaeKdLCL
	l3S+J5wEeEuAruA4LOyUl1H/MbcpLvLbGisfGDvNGGtzpoY+XGU08/MlM/o9h53bzNWMrjK1C1D
	TzLx2IA1UnN3xWsZIxM8sigjLg6GX2PWlMWPUEL5RqiIJibzdFDfddfj7zfZNYDLsaAnh/oFqJo
	AUI8jh2fDLOOsu0hO6SCCtuyaXRICW9EMItrNnLbWoZ1uCaYKhO04IrW0NFpx73o7BGfXJI/rZ1
	Ew==
X-Received: by 2002:a17:90b:3c41:b0:3ac:a203:e0a1 with SMTP id 98e67ed59e1d1-3adead03898mr3797971a91.37.1792937238796;
        Sun, 25 Oct 2026 07:07:18 -0700 (PDT)
Received: from gmail.com ([240e:469:849:35a9:20c:29ff:feb3:e631])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebaddd45sm3776443a91.2.2026.10.25.07.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 07:07:17 -0700 (PDT)
From: Xue Boyang <fuchen.dust@gmail.com>
To: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Xue Boyang <fuchen.dust@gmail.com>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Phil Sutter" <phil@nwl.cc>
Subject: Re: [PATCH nf] netfilter: ipset: fix double free on kernel-side delete during resize
Date: Sun, 25 Oct 2026 09:07:06 -0500
Message-ID: <20261025090609.v2reply.4093.fuchen.dust@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8b1c4c41-d371-1901-0f85-f3d0a1dfd033@blackhole.kfki.hu>
References: <20261012163353.4093-1-fuchen.dust@gmail.com> <8b1c4c41-d371-1901-0f85-f3d0a1dfd033@blackhole.kfki.hu>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jozsef,

thanks for looking at the patch!

> Thank you for your patch! Could you address the issues sashiko raised at
> https://sashiko.dev/#/patchset/20261012163353.4093-1-fuchen.dust%40gmail.com
> about it?

Sure - v2 follows right after this mail, quoting the findings and what I
did about each of them:

> Can a memory allocation failure bypass the backlog cleanup block and leak
> the deferred operations? [Medium]

The exact path claimed cannot: every early exit is taken before the table
is marked resizing, so the backlog is still empty there. The leak is real
one retry later though: on -EAGAIN the cleanup path jumps to the retry
before draining the backlog, and an early failure of the next attempt
(its own allocation failures are again before the mark) strands it - and
with the deferred delete being the only record of the delete, the
elements would stay in the set while the packet path believes them
deleted. v2 drains the backlog on all failure exits, replaying it
against the original table.

> Does the backlog replay ordering during resize incorrectly resurrect
> deleted elements? [High]

Yes, it does - the list_add() prepend of deferred deletes predates this
patch. Since the fix now relies on the backlog order, v2 queues the
deferred deletes with list_add_tail() as well, so the whole backlog
replays in arrival order, on the failure paths too.

> Does this skip clear_bit(i, n->used) and leave the element fully active
> in the original table? If a subsequent ADD for the same element occurs
> before the resize completes, will mtype_add() incorrectly see the
> element as still existing, return -IPSET_ERR_EXIST, and fail to queue
> its own operation to the backlog? [High]

Exactly, and fixed the other way around: clearing the used bit is not an
option, the extension of an element the resize copy loop has not reached
yet would never be freed (the old table is destroyed with
ext_destroy=false to protect the extensions shared with the copied
elements). v2 defers the kernel-side add of an element still present in
the current table instead, so the replay applies the del and the add in
arrival order and the add is no longer lost.

The remaining Medium concern (leak of the extensions of elements which
expired during the resize) is preexisting and not touched by v2 - I can
look at it separately. The five dismissed concerns look like false
positives to me, e.g. the lockless orig->ad walk after the table swap is
serialized by the synchronize_rcu().

Also included in v2: the deferred delete now reports -ENOMEM when its
backlog entry cannot be allocated, instead of returning success.

v2 was tested with the same reproducer as v1 (no double free in repeated
runs) plus a new ordering regression test: packet-path del-then-add
pairs race continuous resizes and the set membership is checked right
after a resize completes, with the traffic source frozen so nothing can
paper over the outcome. On v1 the element deleted and re-added during
the window comes out missing (the lost add); an instrumented v1 kernel
confirmed a single ~80ms resize window deferring 253 packet-path
deletes and dropping the corresponding adds with -EEXIST, replaying the
deletes in LIFO order. On v2 the element is present in every sampled
resize across repeated runs.

Best regards,
Xue Boyang
