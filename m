Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3B138E126
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 22:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791413009; cv=pass; b=ROcGjCIYYUzCOsoU1l0217ZnPHVw8xhwGMy5QKNMZUhq3PwxCBKg0y8Ot7aRERVtIZL6GEByBkRmr1iuoO2Oc+ggO0dcQZzb43awkT3MwNsWsHZM4Hk2iqI+YX6WU1H5h6MMdnzdiZfrYLxaeQwHaUlZeto7eLzb33K6ZcesYLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791413009; c=relaxed/simple;
	bh=vDZ3cTwxqjGw1b4UnPK3GokiygaHb1AoW5HXC6qbtc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKfR+PN4OtOlkjxogxzacRErbZwO3nAnfwjf3mEYEtvBJNumfvMyT3FKiRKbWOeTw36SkgowkQliXVR0ujIj56wO1zoZE0iLk01G8ohsrvL5yZYmi0VVxm72EWcNW0sMU3Zrs9C05VptZy24ASmuY93d/m3zK8BxZKRIN7DlFFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OigA+zYz; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OigA+zYz"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4911df1e196so2271193fac.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 15:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791413007; cv=none;
        d=google.com; s=arc-20260327;
        b=Qct+1NrKMVbfUIsd5SS7zOs7bbBeEYFdBAr/TSQfe/34s2pio07ZkqhWREpL9R9TP3
         LkhtfEiNmU8T5EgIXY4LEOvTjm9YU0qDBmo7uAda00kgXuvvQwK0aZpYSkjI4yNjxkTH
         XjV5avDpm7cMMsr65iZBCiNMCq0klfDHDPAobvXOA7ZSYO+2R3gxgdRkGzK4BQUYuUyL
         U9ZNw3Gi6ta4Si0S+8hHgGltpljuVX9YQU4f+zsqkgfhv9dKU1XdqID7TYUakGPhW4Y3
         QEvpX32oaYl0CUeqKR7G+PPlrOVAKUQhUr5vmUvMVfPZTQqKXNPCHpICh2wY6s/KU3vx
         48vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vDZ3cTwxqjGw1b4UnPK3GokiygaHb1AoW5HXC6qbtc4=;
        fh=7xoxsJye0dfTNfzmlHtjaUzLp5vGFUkKBz/h76CPQNQ=;
        b=IMJbRQKXiyrqiLIidvvw7Vs+001XxRHxWVE71a6YiPJ/aC7JhMWrwm4BWmMUoKLqGb
         4kREwXpKW1peXKqEgPrJRTBkDUmRIpyTG6RbIHJzIe9zQPQTACt0BYGJPW8YenhEGv6c
         VP7+Ku+1CeAfTcQasUNHxjB7dVY1m9/HJyDSzFSmVDgEhlwwoRlRvCVE0V+jJ3NN3B+E
         j44ouRVKeGBgwFjhy717D3X/Iif2rGAQPZRxiJnwx4cwxSfaRgP6VkvswWs9gidEQ8b6
         3jdcbAAO+rO9Md90fTAVcaMw2nV4T3pNJ23zEyvqsDWg3ALKhdBHDqUxcO6St4Zg9fQY
         axiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791413007; x=1792017807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vDZ3cTwxqjGw1b4UnPK3GokiygaHb1AoW5HXC6qbtc4=;
        b=OigA+zYz+K9chR+C+fYBjK+k+r8ANl9R33JEU6TO5foZlA2hWZTAs1up1Vn8JmzHgk
         P6EX5FhHcKj/wpo7NdK3KOKIxPOWBBg6l6e7xnAYFllrFWwbH+sIYClZmhw4njy4VOEs
         mZ8ssXJ6FbuztDpKYv4+tqZ0QdqJGF4t2hTuDjAujm9YXQucyM02isJdwOZmFcAbMBXp
         62oES8fA5y7IIao8ULV6QTVp7dFHZlx2iNOANugOr/gAKY83udSm6ttv96tmXlzZ60Ig
         zD+NW2PcmVQLCRll16B5N3m5KjgM4xHDq4d3o6gRYC6tfhFmvWaSHGcB0oeim9NxGIEs
         86zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791413007; x=1792017807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vDZ3cTwxqjGw1b4UnPK3GokiygaHb1AoW5HXC6qbtc4=;
        b=oegGAFzUdQOmWUW4grRjbXVjN1Gjpyn8ha9zLybNyft7ml/mh7nLSTBcYqaE8tNvlg
         IdmOIbC4ad/CuOKOSxvpV68hAN6fOhtmdG/zrwaTryDV76buConWn1pDelkf3XNORPMV
         EsaiE+6jbtZXKgk+WxnaGVCP+lhQ2fKtHNEWBnBTgVEoDhfa5qcEV3WeSKXOGhok//BL
         qjrq5jlgtz0rf6eNqwGEF0/Whfb/lPpvssXEbkrvzNtwpz4kiuMyGARtzOZOe1KfOSg8
         MwJV7GJK3BJMe7E2u28XrhTXHGDe5qNHfKKii4bWlH9UMezEa12PtIkxC0GYpFkaN0Kz
         GiuA==
X-Forwarded-Encrypted: i=1; AKwUvBxm1wvTzIoh/4ka+21/3KNzQ5F73pCRFEOX8lxKf5fuL1HKZDd/avaloOkdQd1ze72WkLf8H/Y=@vger.kernel.org
X-Gm-Message-State: AFuF++knPvFjptgXYkXaNJGv2L1fQpE0YFwKn63G3tzpsdZZ/CzDSN3o
	i3iB4gFmrw/ThlgsbYgT+HzHhimeR32GNV27KzhyDGZU32GMVd/JUgwlrhz+vqnJXQEaak3CweY
	rDD0NpZw3BcMHxxj4GmzdwCXXaiV3cMM=
X-Gm-Gg: AYBFou2who58igEdeQF9R0ooNh1vgIYdw2q7qFlykSxYjoxwmAvh93L0L/oVIKtmT5I
	IW2gxijLBocoyMhjo3Q5u+Dmfj+t1TXeMzU5C7MwSlZ0BvFHWNxTjSBpZh4bkZJqeBwzavtiLsF
	O6ZjZGF6QGMmkPU4q9IvuF5jxT1LkcFjAxJnBGuXQZgX1tGOwJNuCz5t80L1VvwuSevkYK5XK/A
	cQXPK7EJPtmlvgLhxYJiFerFhVH0rvZUxj/zDod9VuZWSXcl93Om6t9SLjW/doTmtp8wCcu1oju
	aooqAhfbwyKMAABl6/HjggM3zB26Sfn8HyNa3uzeQ+K60vYCyMek/tQ=
X-Received: by 2002:a05:6808:3091:b0:4d5:27da:a496 with SMTP id
 5614622812f47-4fc46578fc2mr3900133b6e.48.1791413006632; Wed, 07 Oct 2026
 15:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-9-kuniyu@google.com>
In-Reply-To: <20261006192601.1875100-9-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 7 Oct 2026 15:43:14 -0700
X-Gm-Features: AclHuK-zqLiAP0MMvI13NtkINGyxCDygzMNTg_OOEX6e6HDhK58LW_vHwrQA4lg
Message-ID: <CAMB2axPT7=34UkvddgK-dqvUsagpLWF5pkWp6Xom6PgHd3AP7A@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 08/10] bpf: mptcp: Don't support BPF_TCP_OPS_FLAG_RCVQ.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 12:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> The next patch exposes a new kfunc calling __tcp_set_rcvlowat()
> to bpf_tcp_ops.
>
> MPTCP has its own sock->ops->set_rcvlowat() / mptcp_set_rcvlowat(),
> so we should not allow calling __tcp_set_rcvlowat() on MPTCP
> subflows.
>
> Let's disable BPF_TCP_OPS_FLAG_RCVQ for MPTCP for now.
>
> If needed in the future, bpf_tcp_ops_set_rcvlowat() could be
> extended to properly support MPTCP.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
