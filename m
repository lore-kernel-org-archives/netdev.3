Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792513398;
	b=YOOWbBuDvJAB/2Cys+Z9QT4SkyTMaoCVoaAPl9IbSQmhXbn3LhLBJXjr+yFQd57ABmIE
	 83sj9CUxAGRn1hE+Oyd7W9TRD8uWOIavnk0XKUkH8ge8XxVp4ryjYQ/25rcksW3ajMDIF
	 jDCMHCGwKI5PTG7YHQ84uLwbBII0MmLZRnJxcZpwWBGuZ7mHaVOMod0e1//PmPsiRAyqK
	 fxU42ByE8TaRbl/CKyUtHYZfgr0kr6HCnzLEIWZd9Gi9P1A086yNTs1U6BxY02XieVtKW
	 I1nao3vr9u7wjs+w9eSQnVQQeLItpLRuHnwxaiY0lzKc81xqGh/QAcb1wfDuz0vCIRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=0jCj2axNyxSFURiXpH7V4N8DE8GNJe9dPnJmhT9P0cA=;
	b=g/ILAu2FNz+FsuLWZlED0tsLj13ikSDQhRsg0WFryNg2NoZgj7oZeFUPTNkvWgPMt9U1
	 XWfI6h/uolKwYDvPrgGn6ESBhEiO4XZGMc6anEF8D20TKVvPxya8HY4baWI6TvZpFAgLL
	 3e7wR2Wy9DigaebFqN8ZIefv18YPLnkfwSNrXgIBdh+z+7Y0Okxs6i5UePZ/lvx30STq/
	 bk6r+d/se8+rwMaTk8vaNIVg0Vw/9rtplrgZM6XxS2pXqd12Ks4km8hu0DrabLgZEiv4Z
	 qyxm76ol4SYs5SPyH1q4GtyBFIK4y4GcotlHbigSf9Yvy3LO26VFknHjmTrB/c+4tJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Xua+F94x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC1606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCCC1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Xua+F94x
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso12399a12.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792513396; cv=none;
        d=google.com; s=arc-20260327;
        b=hyfjZiT4RLhyxj3ZbjhWYRguX5mDYqoFbMX/83Ix/nobaTw6AKwsQ/ltdtzLSO+0D+
         In6vM85Tq7HidWM3YZa3eUhEUUb/rHcIGHapxxSpLofkUB64lnvnerOU7/UGRFqzYM8Z
         qEXfpTPLMLhvEIraP71eC08GceAKOFtO5oVYr+THjyyZVM67CI8bWCeHDy9oqXg+cEKo
         Pk7sW2P8ew3og8qMFkI2W28zW8ZLxPKBILkWXz3sz3hZWI+mATpZqeXZyqmmk6As9T02
         J+q1by9BFgr1ss7DyTVN+psqY/e/hg4TtqXjl1NQ91yadJ0WXPGMOXpqPxbqmZhSQTJD
         aQlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0jCj2axNyxSFURiXpH7V4N8DE8GNJe9dPnJmhT9P0cA=;
        fh=nzVPgTPDdsR9bs02eOG+1Bu/RN8PbI1g0NAWakHpSvM=;
        b=dco4ZJj+z7YjU462U8t1/YyDuPCCFM8xe8t30ERms56tFMyawLxdj2j7dnWkjro3Q2
         7jDbdX8QlvIapxzbsGNRH8nalVH0BXVspHy4UP2cDSuumIt+QKI80R/6Q1aHC0586unX
         PcNwKhXDz2iBrJSezLE81/MD3jrJaG0x0Q5gY12VMj1Zcac1HyzrzF07+Hhl5S1hlazc
         aQSP4eX9nM2NezWHQPZkkb1nIgc7UzXuVzrPkr37jLO+FC/BZeFpDOUzemyTY/vNPxZo
         vFpiwj70Q4gAa/2AkaouIx3iMUsPMqbrJFmjypArmk6A4WQGFXLu59B3BClwG6mMSN6r
         02Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792513396; x=1793118196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0jCj2axNyxSFURiXpH7V4N8DE8GNJe9dPnJmhT9P0cA=;
        b=Xua+F94xPs4SLRFvPHZvf8ENdD6xQkEFYVjamT9EZRzYSfJtvS7XDtwmZyz1gTEJ0Z
         /WkxlqQ5rxEvkZKLXwDC4ALxhuuf3lvKENwOAe2FrlDflythScAJ0Tn5Atp7/sUdwsFJ
         E5biZmC8UmGgW0KNyTHjULGeLnoa0QbAm6UUD7R5xj70LVhv4dsixEwE51Pjds0Owm/s
         yh4EPRS7zc5XwowJlsvmHsNHogBe1Cs3eCTy7l+wjYHJVHHx8KQKzvWnrNZKclhTNIQm
         ckqTqXGWGJiMJjLhtJ75lQ1ZbkeOSru9OrP82Q8PUanZ2j0r8yLVhiS2BLjqoKfeus8q
         kXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792513396; x=1793118196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0jCj2axNyxSFURiXpH7V4N8DE8GNJe9dPnJmhT9P0cA=;
        b=SDqRSHtiIm0ewI973FRr9ncwkDC/em1pOTJKWdRdlbewpZ428FjDuTj1yt11SBz/x+
         5Qzst4PSGPhgVo7wdI6Kq9g/kQ71yWKAEGxoCw57d5OvdbkygoxggMaTTeJUVwOnrf5F
         AgE63LSM1KqRjCk4nUpe/lRRJ1m+XJNR2JOKtUGNfbSoFagmmObgg8Kt+rIjPLQo8Cjy
         s+YyBnpjtAs4oy7EUibfI6IzNXqT8AqGfOly3q2yqPq6vAUAHRbFh0XlUGDivtKPRCzn
         Z1GzXlhpXJO3jWEDC+bTtdsiFhL0U5PYEEhvJeleBVfFR4BPb5LU9UaqAmrvda7b1SIy
         xw9g==
X-Gm-Message-State: AFq9FYLnx6jqZavrZFkbJ4nx62NNFVq6WeLHOo789Rihfnl9I1VryfVZ
	x7REFSGWvohhaGikpgXqioDAlYywOBrUfIoLL6tuFht4CeFM+uHj9+OtAdkd9/gO7nQwIbnIj+U
	jWq6lz9ezjzyYamSRA5dJmIB7kb94a1ITekYchpa6
X-Gm-Gg: AYBFou0EvajIjtWi7Sv/dOY9ON4DgcoBdgtjAAdlA16lQdmbI09SrXMm1b1dqDTBscY
	ITjtaxEMi7JlOQISLOGCaR8SAckvAn4WNPaW+pA+Njxbj6rfHEIxxekDUJWSHTkKqs31gnvQB3h
	Eriz3/7OBNp8nIo+1ai6fX/OFuJ9SnFtQHahyzWSQ0wX2eZqRZBHz9dNNt5MP9YkT0VFRbm7Xr9
	aD1SB8vi5HjJMTToGFPuUHKqIM8ZNlmkknxaWV3XGsUHNaaaf3POv0aFcp6A7+rWOulUV4+fRCq
	bZ0JfO8d7F7uHFfyZle3HSP8Ub/FnJ56Y6U57Vmj2ntop6rQDX1p
X-Received: by 2002:a05:6402:a593:10b0:6aa:babf:adeb with SMTP id
 4fb4d7f45d1cf-6b3e59e5999mr68410a12.4.1792513395686; Tue, 20 Oct 2026
 09:23:15 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014173945.373295-1-almasrymina@google.com> <179249101026.3632927.6502845375265155678.git-patchwork-notify@kernel.org>
In-Reply-To: <179249101026.3632927.6502845375265155678.git-patchwork-notify@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 20 Oct 2026 09:23:03 -0700
X-Gm-Features: AclHuK98NB_XkoOPCMHRm8iUlfrFJ_YYRk69JLvIRXvJ8G4hhuCyWlkE4iWtFOw
Message-ID: <CAHS8izMRSU3AyVf+sP5uXShiSKuLumZwT=fsgW+bhJz47UoPRQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/6] net: unify symmetric netmem and page_pool refcounting
To: patchwork-bot+netdevbpf@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, ayush.sawal@chelsio.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, tariqt@nvidia.com, horms@kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	ncardwell@google.com, kuniyu@google.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, ebiggers@kernel.org, kees@kernel.org, 
	aleksandr.loktionov@intel.com, petrm@nvidia.com, u.kleine-koenig@baylibre.com, 
	j.raczynski@samsung.com, wang.zhan@smartx.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 3:10=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to netdev/net-next.git (main)
> by Paolo Abeni <pabeni@redhat.com>:
>
> On Wed, 14 Oct 2026 17:37:14 +0000 you wrote:
> > netmems (pages and net_iovs) have two independent refcounts: a non-pp
> > refcount (page._refcount or binding->ref) governing backing memory
> > lifetime, and pp_ref_count governing recycling within a page_pool while
> > page_pool holds a single backing non-pp reference. SKBs with
> > pp_recycle=3D1 own pp_ref_count references on page_pool fragments; SKBs
> > with pp_recycle=3D0 own non-pp references.
> >
> > [...]
>
> Here is the summary with links:
>   - [net-next,v3,1/6] netmem: rename __get/__put_netmem() to get/put_net_=
iov()
>     https://git.kernel.org/netdev/net-next/c/a868720467d9
>   - [net-next,v3,2/6] net: skbuff: add napi_pp_get_page() and use it in t=
cp_recvmsg_dmabuf()
>     https://git.kernel.org/netdev/net-next/c/729a47b803b5
>   - [net-next,v3,3/6] net: skbuff: replace skb_page_unref() and __skb_fra=
g_unref() with skb_netmem_unref()
>     https://git.kernel.org/netdev/net-next/c/4d688084070e
>   - [net-next,v3,4/6] net: skbuff: replace __skb_frag_ref() with symmetri=
c skb_netmem_ref()
>     https://git.kernel.org/netdev/net-next/c/1f6f88105e1d
>   - [net-next,v3,5/6] net: skbuff: use skb_frag_ref() in skb_try_coalesce=
()
>     https://git.kernel.org/netdev/net-next/c/447f58db3505
>   - [net-next,v3,6/6] net: kunit: test netmem, page_pool, and skb frag re=
fcounting
>     https://git.kernel.org/netdev/net-next/c/2285346afc99
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>

This is awesome. For years the skb refcounting annoyed the hell out of
me. I couldn't fix it on my own; there were too many edge cases I
didn't thoroughly understand and could break. LLMs made this possible.
Thanks!

--
Thanks,
Mina
