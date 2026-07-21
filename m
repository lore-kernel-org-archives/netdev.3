Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5862435E950
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620656; cv=none; b=Y47pM6BryA/YaOp/PWgOxOpYRj601JPAYdLWfCmumNMM1ePrInN3e7TOljD++li0mQoujFVxZVpk5xCKWaG/y8jTbxVzMLlbLU4jLSjKNktGlzsbbHPqFuwjKFhA4bPYvsbahCqXPE8AwV2QyiLJA6whauOmB9q+hLezs3w/WrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620656; c=relaxed/simple;
	bh=rDNXPIByxIrbjW3rhLiD1IqcU+b4atnr92EWo+jTYYA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=J+jxFOWkjlXxk8ALLpaiYDchPl5Q18HQO4vNwEiDyRRBGxABqbSGgfc6mZNFzaJYpO36/OT9M6WAZSH7hqQFhy7n5WGuvJOQ+CAcHPFXZ+3CpPF/iKxvvH8lWp65uf95Xg58Yv+5+kaR4OWzBsp5Ma95oEH5jBATSmgfhokTdIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Im/3Yq8Y; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im/3Yq8Y"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81ea0b7d137so90476197b3.2
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 00:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784620654; x=1785225454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rDNXPIByxIrbjW3rhLiD1IqcU+b4atnr92EWo+jTYYA=;
        b=Im/3Yq8YNgjN3+jJAPjCb+1ItOBAXQ+LCWCnbAG9W+jY/f7F35kTZ7aqIWsJRtZZBk
         sOujkOyjCfe5tRMzjHnNKBF82doodcB9Hj6xDTyRCooqGhLprg5tN+sJrrjFob3P1o3+
         iklmZJz4GWeNQ4a6G3zZyNqgGTZOtU28sMiVpcIAYveB1Zz5bTIQC3nNyPgV5SvSNd04
         6w4oY8wJNqvxcroifDteUAUGUQGe2kXuQcpaKvwXwHgG9mIR1x2AmKgXo+S5bEbODMp4
         bjB8nFU74gwl0PAeMqmzf23+HQV0cvMiPsMEgbfBV3OcS9XqLmle6Xe8+MLvOV+KqL9e
         mC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784620654; x=1785225454;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rDNXPIByxIrbjW3rhLiD1IqcU+b4atnr92EWo+jTYYA=;
        b=BFi0fZsW2WhkLmgxWkeWHW5szX40lLaokLCL88vtA09JAj0MnjaVcIaSPYspXCW5Qo
         IMDikjfstH4OVu+Nu6UmdkANAw16c5/emteymqNE48oAPAhzgya3wRcqyE8l4Ji2/QtL
         1Ohcdv/2d+m73uxb4evCwgXdYGBvNno+550kwsvUwpVo0Qq0fdivZdDmGE2zLjZ19S6Y
         oW1lWA/HLk9vKU41q0Pt+9FP/0VbDh6E5GHWaqC3aG6rAbLFii8U4srpV0pEdK0DsiwG
         ttN/d2C4BbVcbsHCvRhT/V3JYwFO24wIPij5mRa1J30bGSn75hyXJmiQ1y9dXVLiDDDe
         jU0A==
X-Gm-Message-State: AOJu0YzD2efqr+P9n4PpX+7bfridG/kBDgC9pk3xcdX46BHmW9evrB9S
	uzm7on1eVgpdJHwJEl3bNOrHv/WFqxKXbk6XWRVWjLWkgt6Nx7javNKw
X-Gm-Gg: AR+sD10P/vePJiitG3LV/CKXi1lRH2br2CU2+f00jLSO7jAeua3uTt6G5RIc8KyQDet
	qzCwsDdByWsXve+IBnFXK/JO7rE5TAdM7/0M6nwq1/gRWnxKqq0FnPWl3IV5nuvCNRctfAuE1W4
	Zr3VInQ4IHYIAobyg2N+96u+qv8GmPbqSW2NkTQ5SlBdmWFsABaKxjIdtkZoraDEBEn+TfMFRiZ
	chw2EUWMGqrBQeVzAA6dWFkWcxZSdqs8KOfYQ9cP9oB2PIcFBKigkiMnYSnZCTZ81QPSYhfRhNb
	Jjh0N5+zCISxGVVYkkTndbxk3hMN9HC8MUiX87+8wYlCUK9ZsI4fK6mMr1Q5+PeJCA7UGIgmWRp
	yRiXmsrhdkWK1IP4RCc4yfXYQWeeQ2KJ3hgJw290XrHiiWRTGQkY17ez822FTfVdqJK92/Uv74K
	zZcJa0VT9R6uT3yjkn/DX4KeO68MOktr4oaF6hOYTDZUj+ZgqXRllV1iiQDDVlwt4W2w==
X-Received: by 2002:a05:690c:e0c:b0:81e:6a1c:e30b with SMTP id 00721157ae682-81ef28da7b0mr55091677b3.67.1784620654359;
        Tue, 21 Jul 2026 00:57:34 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef4018658sm60555887b3.10.2026.07.21.00.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 00:57:33 -0700 (PDT)
Date: Tue, 21 Jul 2026 03:57:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.e6569ba76bb@gmail.com>
In-Reply-To: <CANn89i+YuuBJ1J8CGD0Eo3JKeNjEd=5tT-3h=6stE5QoYczYXw@mail.gmail.com>
References: <20260721015824.45829-1-kylebot@openai.com>
 <CANn89i+YuuBJ1J8CGD0Eo3JKeNjEd=5tT-3h=6stE5QoYczYXw@mail.gmail.com>
Subject: Re: [PATCH net] net/packet: defer vmalloc TX_RING free until skbs
 finish
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Tue, Jul 21, 2026 at 3:58=E2=80=AFAM Kyle Zeng <kylebot@openai.com> =
wrote:
> >
> > AF_PACKET TX_RING skbs keep a raw pointer to their ring frame. The sk=
b
> > page references preserve page-backed ring blocks after pg_vec is free=
d,
> > but they do not preserve a vmalloc mapping.
> >
> > tpacket_destruct_skb() currently drops the pending reference before
> > writing the timestamp and TP_STATUS_AVAILABLE to the frame. Move the
> > decrement after those stores. The smp_wmb() in __packet_set_status()
> > orders the frame stores before the decrement.
> >
> > On socket close, scan every pg_vec entry because allocation can produ=
ce
> > a mixture of page-backed and vmalloc-backed blocks. If any block is
> > vmalloc-backed and TX skbs remain pending, defer the whole vector to
> > system_long_wq.
> >
> > After pg_vec is detached, a late destructor can skip the pending
> > decrement. Use socket write-memory accounting as the deferred lifetim=
e
> > gate instead: an skb remains charged through its final sock_wfree(),
> > after all ring-frame accesses. The delayed work retains a socket
> > reference and reschedules itself until no TX skbs remain. Fall back t=
o
> > a synchronous wait if the work allocation fails.
> >
> > Move pending_refcnt release to packet_sock_destruct() so late skb
> > destructors and deferred cleanup can safely use it after
> > packet_release(). Page-backed teardown remains synchronous, and no lo=
ck
> > is added to the TX completion hot path.
> >
> > Fixes: b013840810c2 ("packet: use percpu mmap tx frame pending refcou=
nt")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Assisted-by: Codex:gpt-5.6
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > ---
> =

> Hi Kyle,
> =

> Rather than doing kmalloc() inside free_pg_vec() during socket teardown=
/close,
> would it be better to pre-allocate the deferred work storage at ring se=
tup
> time (in alloc_pg_vec / packet_set_ring)?

Probably superfluous, but: only if vmalloc was used.

Neat secondary feature will be that the non-NULL status of that
pointer can be used to detect use of vmalloc at teardown, without
having to iterate over all the pgvec entries.
 =

> Pre-allocating at ring setup has a few advantages:
> =

> 1) If allocation fails, setsockopt(PACKET_TX_RING) fails early with -EN=
OMEM,
> avoiding allocation failures during socket close/teardown.
> =

> 2) Teardown becomes deterministic: free_pg_vec() is guaranteed to have
> the storage available to queue work.
> =

> 3) We can drop the extra fallback logic (packet_wait_for_tx_skbs(),
> po->skb_completion, and the 1-jiffy fallback polling loop).
> =

> You could embed a struct delayed_work (or a header struct) into the all=
ocation
> returned by alloc_pg_vec().
> =

> Thanks,


