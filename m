Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96BB298CBC
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 04:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773202861; cv=pass; b=XY2smUU89eNBxx/nU/cPRqFOqnbkquMf37FY/lxLPxDo6utf5bRcixaR2Sul+ajXukQc5C6XdgqGKwmjZgidjxKYsc4zX016JfS45zFQgR7a71zeWZ211faDfsKN86eZR/1KOCpeOxwr1dJGGRxWNbqRaka5ca9ywxo0aHaidxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773202861; c=relaxed/simple;
	bh=xgH3ZjiAnXgrRdXmE9LHH4loRj+g07x44/3KMtJNaj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTzDD29q0T6BmkYVgxW80vg1GC9lDkL37SoXnaARUcbnUGdwDmGUUYn3v0Y8pZz5xwuW+S2WfSGeEfH2MuWmvUQ4Zgp5Wdoa/IvNa6gV7dVBF1F3gZDeOepMkMFVb/zwjjeOz0NYHI1hWlde1NhTNndJjaOluHQFV9Pbjb7Wvrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NSrvKriS; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NSrvKriS"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12732165d1eso15365351c88.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773202860; cv=none;
        d=google.com; s=arc-20240605;
        b=HMA4dbzWcZpVM+miyP8yFjOSxL+kiMZuBHRj8JBhahQpr7VYCdnl2h3XyXt4VVFBBd
         ndTA8LqvyEnsU8FnbIKzVD23GKGE2+J+5kc6t1WsVzwpX8ChIXDYFvLV4ecDGhyR8Y70
         1+yB+UaTNZsXRkvT390VHJDCmD1CAJIGc/vAlI8LXDpl2yPbJWBvW3TKSSd2HAYh7Jv/
         Iy1qx0NDVb4yb2Q3iYwWCCRxYJN4WNMN6qhluo8FxnDsvIJCbApzpus+S5vC+Zr/7BPW
         gRRNJ5J0Pdn9ySdkcnbue1e/TjO6GnJKGuMC0OceIpr/03pXPVD0MxxcJiKi2Z6moQ8W
         lmpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wZckyy6tlTeskjEFHa5vU97RxjrL58hGBNwvj0lmNVA=;
        fh=jQK7bHBDfkhoB0FHnjN9HmeQq1ZMN0scHb8NQv6uAto=;
        b=fnOBx2SSvhPQCxttszGTGtKqgBSM5eJ7HEJZFkewrR7TvIvrnLkYkAL5oqjfMgdqkL
         jZy5pAdU+bNrYpHc5yuVSUqk/cXVNPSqb8bPGud5iJdMPdTMN5HhNLNtVebn80er9eyx
         H4SEw3KvXPdJ73rDU/S6DdbsFD/mU571KZ+jPjUgarIzJoqm9MnsaE8ZumCAHJ7ppmC5
         VvWib2Hj2Gs3usMlghXMBo6kM/2Fe6WTJciW0taHjiKg+kYq9hIN5M5KuG2lgxGcNOYK
         TJnQjE0vcJ74EC+PJE83swVfzpTQgEajsposSh2nhYf3YZyORD/LMaYmUESZOrofD8E3
         tDVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773202860; x=1773807660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZckyy6tlTeskjEFHa5vU97RxjrL58hGBNwvj0lmNVA=;
        b=NSrvKriSTXnmIA4o7LESA8/S4MEka/+AOD+sJRu3N1Yq4633EsUNM84F1ro0wkToCC
         go0h2IzqTi1/SBzhhsvihTf6OhuuUEa06Vl9ZHjhlnWfAEG32xA8+XLbHpqd40NC/bfm
         1l9LBKdpAfxq1es8PgkNK5ugBpq43gs3nh1eCeEAhmRYYerw3NqrSsFxrzyZOPj3KgXX
         oDin8aO5eL8UrC9CH9Rjz3SwmI65+tsoh/NO55BNdXX1pfLq27kwJwccX+uNgoSCKpdg
         ylWsJuCkmAFXrvSibywoIpKnq3DLW2WcB0b9RuGT9S8y/6N+Xt3v8yOXCtoL2LEgtbEW
         +zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773202860; x=1773807660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wZckyy6tlTeskjEFHa5vU97RxjrL58hGBNwvj0lmNVA=;
        b=GkWbPaevRa5liNmZ7BxccAt9r/xemN6+ybk0b5bsaQ/Lh2IjOBzaum513YtQqAj9FC
         koQoPaLB97lOxQ8VIOweTgiPgic5afdKp91Dm89zc+oRC7HZP3M+l8VTms/aai3p41le
         xym86F5/hUrfQKvyfwcoSeQQKYkSRSykH7dDGyVTN/WkPaSfU8Ba60+EEWxa77E5NmQ4
         VjxAJIFkbQAhxmn9ub6pkvsbF33yXOjpL9FU3z4a10fSo4VmM5943e8q5kxuEqA0UFJk
         0nOcBmWkY0+gnKVskatGVTjaYlfYEmeanquygJgBpH4W7fQWsHW6ILk00bLcLtEQDVcR
         2S/A==
X-Forwarded-Encrypted: i=1; AJvYcCV9oc/4CBDEiIU273mHCQLQY5hLl/F0HrrqrBaW7dvO4EZrgqxBX2JCN+3Pz3Dv+raMlHCSUyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyRM9SKcI/zSlseVQgTkfSXx7QNoB6GMkVMa1IOl5FvwQwotmA
	PljMqj3MqbjqZxIXCnrS2b7rRHF+oGTPVmphhxNNo9U8RZKFdGHEypyqNx0ccLk1Bf5f9qyPVXi
	8bwcb85eCsKQMDhUhTtAhSbXS2MfMLLAKHwCGAhRh
X-Gm-Gg: ATEYQzzZJJWVT5bEni4ZMT85j+FSyHmR0UnV+ewNsByjbQV++IhzwjTXXpLCgRGMF/K
	xJrXuuOIwfoT86834vsk38sYXjtpZOCgNeJMyr6IlUhJZG1+6rPaXV619iV8RKpSr4M1Vhn/Qt2
	ByjdpTqxbbRZSMaWBW9gKcQLaeaXncH026KlsR1hEHH5aKddNhm5JUtbyVMifkPJYUA1t6ol0lu
	z2mQUAXJtcQ+RNraG9mPRWb+8o+96vE1iHky/pYXZC3eLAuExF0GkeUov5jNIflo1mz59xi4M8B
	vsQT0bdaluMDniPPOSONpl2EkjHJnWVdd8LxayN3LQYmHTOPsf+0NU8sz/vmhtJHL/KLm1759p2
	JiHnnwA==
X-Received: by 2002:a05:7022:1283:b0:119:e56b:989b with SMTP id
 a92af1059eb24-128e7793d9amr569638c88.2.1773202859067; Tue, 10 Mar 2026
 21:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310124451.2280968-1-edumazet@google.com>
In-Reply-To: <20260310124451.2280968-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 10 Mar 2026 21:20:48 -0700
X-Gm-Features: AaiRm50PpaPHqiQgWP--r0Dfxyq9eO8hRPgifzXhtjVazpNTIh10Ix-j1nZfsmE
Message-ID: <CAAVpQUCnyc9TYn-RNfFCNt3-7rigT1h5nBz9==9yiGppJgPrmw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add tcp_release_cb_cond() helper
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 5:44=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Majority of tcp_release_cb() calls do nothing at all.
>
> Provide tcp_release_cb_cond() helper so that release_sock()
> can avoid these calls.
>
> Also hint the compiler thar __release_sock() and wake_up()
> are rarely called.
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-77 (-77)
> Function                                     old     new   delta
> release_sock                                 258     181     -77
> Total: Before=3D25235790, After=3D25235713, chg -0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
