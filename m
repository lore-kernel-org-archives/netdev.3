Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F5A3CCFD8
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 00:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785804413; cv=pass; b=tSvJg9Y6IZJWg8shVsOWUi1O6Ju8Rz061zynac31ZBYIKT1Tkcnj/mrZmfARzobYyA9VQPErjia1j2cCYWEDrIhyjRzuzqGhN+qI8lciAk+NS93DBaghWX1wI73CbpUWCvAengQcvZLOdtADqsZyYo0edkDC4VgGQds/2Fux5ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785804413; c=relaxed/simple;
	bh=1NkUq7TWLc84Qi1s1urgas5g/whY5pae7lykYpvFsj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqzS3slucV93i/F6xeNtcNN42sPY2sZA19mrEJfu9bALLjjJ1i2fOu4GGNMjwr9FjjXp8MMhueTFYio7smWaIGdMbwDmYpf1lMwqOHxZao/kS/VPkcUjfNlIbFkafHpl9gY2e+qqK3utHk9MSYM601iwDx43f7Xkpr2Rz+kP4f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iWiUaaoN; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iWiUaaoN"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so3415321b3a.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 17:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785804409; cv=none;
        d=google.com; s=arc-20260327;
        b=XL4EHFCd8uGZmjZEyaFUcA4qg6soLigTyhoZ8wdwOa27Q9q+pKcUG0enMUHzAuWnDZ
         WFRxdSHRuipb/+Wt3taItqrf3MqHt+rDkfaGgw2Qq12wvAbdgVKBNJvJj4PZLPnWUzp3
         fDz8vU8D42Et+4Amgmtzjgx2ilNb/9nppDpsN4ofwsHZ5Re1av5FwEMHy4s6wa2CRvkK
         A7KsKb9NPblF+DCg00jej3F3fuPC7o/B9QsiGPNnIZz4vihqRVSLp4d7DUz7kBxyllPq
         qyTlfp45ANjgQzrL/MDof5wQZj+4sBLSAMXMIGOwWRRQh1cxPj9sn0CxdOW4nolSDLeL
         DfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ziIEjB85MzXCH0+ymyUAxcycKjDkK5v9hdXGmukJ14g=;
        fh=JJUlCdFES67gd7xHxsBbIrp3H0F2mZ4MI9DyUAwaqpQ=;
        b=MB5sSV+0N/BmjqNSROR5Q1QbsugCaioaKLuWk3drbUby+Lw5rRP6rsi/UUsdiejva+
         NZd6w715LFsMaZw+ZvFbep4YQuKI9ZrQlwePnx3rtMKRGfLaaqB4RIm9L059K6GSb/rF
         qIpg+vpgazbWkIMlrKmNugo+8QXxh//YnqqtdLi8Snx+vkhPV7m+bCWj7CxIsaNYzAM6
         PD7qEbgoWVlouBh8RRk8WZPOQocTaqQn4xz88o+wfIigfEhUWTEJtBsmv6aSi5toXWyF
         3ZH78wf3yHNjI2xO+19IpGpKor7nlIDp7VUzEhfAveEVN1zfEpScrtfgRjFkWfjCWAJF
         75DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785804409; x=1786409209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ziIEjB85MzXCH0+ymyUAxcycKjDkK5v9hdXGmukJ14g=;
        b=iWiUaaoNNdVGGafSs3WLqTaLbAjrQ73iP2TEEUSy0IfmmojY0j1Wp4nVekOFzCj3m5
         S9PFOclAb9djXyEeTA0lgp46WxOseJlvZIRgnJmBXj7BeJ4picSNzxr7wt/6xShoxwKS
         wNJNo4N5J6znqhbTVPV1h9eNvWFS4UefOaYoP2vxxdUWoPc5645wdeJXgzdyaKad3FKS
         Nz5Fam9z9UzgVy3kJdj/ukHemcu9bRvYRXuR3Ky0q/Tx2H8hn8zpmnR8iNZtz+UFxDCE
         5MAn2AJEjGC2C5lP1jVyzxahTaMlhCxacWOvWNy0hFY4MpL4hzqzDOzdIKmOcTdGgqps
         9AXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785804409; x=1786409209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ziIEjB85MzXCH0+ymyUAxcycKjDkK5v9hdXGmukJ14g=;
        b=IMkZjf6SIl33sXirMwEzGWCivj8C8OK7Sfl/HZIH0vNAadM3oIHzr+fWqg35h7P9zG
         wZ2xvf2VwhAEN12YbzXOEDQre9/x7DaF4n6NoJPSWmCr2yN3dBB297NP0YFt4MNM5xPR
         v7RNlfMdg4mSyiiomYB9z4xcakX9rRl+suxL769ONM56u2CuS3syZXsH5LZ4e3tt+2AI
         oVQlH4wbW3K4gfxn4cEUCQl/CDJ4NwxnINKK87ig3ppeasrxtCNbQAvQMVCRpGZ96yO5
         093IJHdvjwQ7BHT5WZBxeH6dw4/gznxItHJIwgh4n9lXC8VLpE5uQ/FVX9F6I5qP0sIZ
         ya8g==
X-Forwarded-Encrypted: i=1; AHgh+Rqu2P91APUF2KuZHSQcY5mE1HJLDGODkLhk/NIu4kuUIWMipGelT1UQIRZzesHs4SWj5WjC1ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzitIKZxJdh9VjvENlFkHOKNm49f8Wigk4x+vZgnkr+wJ8FzQ+P
	Ht2bJwchbNiYej4TgxaZDDWhddVm4+zkWYh9wKarnz3yFTBpQG/WAAnLxEHy9MoFgypX2mBYMzV
	nBGSHAw2kHX4t50vL8itDrYUvjm3IIApeyW96MbQY
X-Gm-Gg: AR+sD13W9U0ErIGoD0GzcoiFe+ZBHqikCQgwRoKShEumgEx0cN5yb6/rYbsyKp8oqu2
	ed/SUGKKMyaOfdbNY/eOD7kEIX6PT+jeAqtVs8pCtd+VmNUMgm4NnPHZI5CJe9CAM35FNuUnjXQ
	wAr8pDIlrh6aOnUe+18ntK3LeQTf11fSvUMVleN5uizO1ORnOCnGqZIag0BqbmUuXovRhBquFOo
	07rw4Dq07NKIde0w4fDcnV8kGkVKmLigyVPWqobjdu08JhABAtQI95dyAymB1P0e6u/bN5JQOTH
	/L67unzIlk+BKZMLkNyTlqrTXktCj3012PyLh0ezXfbdY2YB27/jK5CzrwipzfrJcWmLGfzDA7a
	3sHe3cyfuF3hiCqXHOyqLJKSihC4iHnZ6WYgyd17nIK7DB/qIHpGpqGokgN4mI6pBSrYlHy9goL
	nP3+4D5aC3Qkat5AZqBcs18kE=
X-Received: by 2002:a05:6a21:7002:b0:3bf:7ab7:98a4 with SMTP id
 adf61e73a8af0-3c92a833c05mr12569575637.27.1785804408390; Mon, 03 Aug 2026
 17:46:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804002155.2233594-1-kuniyu@google.com>
In-Reply-To: <20260804002155.2233594-1-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 3 Aug 2026 17:46:37 -0700
X-Gm-Features: AUfX_myZJhP8nI5gAqfXfCQw_U_mEgP4XsWtyOhzURWgVeLZI0JHnxTJ0CBE2BI
Message-ID: <CAAVpQUAnR+7W6fXgWo4AzABSn08YAZL0P3ipzkO2FS1B9Q6X_A@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] af_unix: Unlink scc_entry in unix_del_edge().
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Kyle Zeng <kylebot@openai.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> [PATCH v1 net-next] af_unix: Unlink scc_entry in unix_del_edge().

Sorry, this is for net.git.


On Mon, Aug 3, 2026 at 5:21=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> Kyle Zeng reported that GC could free a dead SCC partially.
>
> The scenario is as follows:
>
>    1) Create two SCCs:
>
>        X -.   A <-> B
>        ^--'
>
>    2) Run the following concurrently:
>
>       2-1) send() sk-B to sk-B from sk-X
>       2-2) close() both A and B
>
> At 2-1), there is a small window where unix_add_edges()
> publishes a new edge (B <-> B) to GC but its skb is not queued
> by skb_queue_tail().
>
> If 2-2) completes before skb_queue_tail() and GC is triggered,
> it judges A <-> B as dead, but B is not freed because GC cannot
> collect the not-yet-queued skb holding the B <-> B edge.
>
>        X -.   A <-> B -. This edge is visible
>        ^--'         ^..'  but skb is not
>
> This itself is not a problem since the next GC run will judge
> B as dead as well and free it finally.
>
>        X -.   A <.> B -.
>        ^--'         ^--'
>
> However, X's SCC forces the next GC to call unix_walk_scc_fast(),
> and it iterates over A through B's scc_entry.
>
> Let's unlink scc_entry before freeing the vertex in unix_del_edge().
>
> Fixes: 4090fa373f0e ("af_unix: Replace garbage collection algorithm.")
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/unix/garbage.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 0783555e2526..9fcaaf55cba5 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -186,6 +186,7 @@ static void unix_del_edge(struct scm_fp_list *fpl, st=
ruct unix_edge *edge)
>         if (!vertex->out_degree) {
>                 edge->predecessor->vertex =3D NULL;
>                 list_move_tail(&vertex->entry, &fpl->vertices);
> +               list_del(&vertex->scc_entry);
>         }
>  }
>
> --
> 2.55.0.571.g244d577d93-goog
>
