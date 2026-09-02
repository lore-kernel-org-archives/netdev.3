Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E2B40F732
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343733; cv=pass; b=PxS4u92hOKnEk+cbAKQK+LWtmTWilYN5MDjF25sLND5AYXPHj8osized+fdWdZc1aPXQ1taPxdpwzOfDKiNmboCsNH5TalXT5fzMaOdS9110wkXnjdCOA18vz/I1IecqfY2GoxDBfz8uuk7kEkkMAJPMM2/46NS5JGn7gcVQI8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343733; c=relaxed/simple;
	bh=e22SUgGgIJ3poJkGI8HTllTE/j2hDqd/FF+MOcjqrxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YyzTPq6D0IXmZcOZOweLXOxc0xW8TSnRDvc3Nb7dEqWpU5g8+fYehzSYIqeBgzUExuUDdd2PpKBDlgy3mR9iXH5SjfypozkqsQ9Q2nGoqdSDQj1vUbTUFGd/glHpLdEwb7qvsATtxzmNSEO8HXiWL4f2rW+61TxvQijDeYfqKMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dfL+csT0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nMnUnst2; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfL+csT0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nMnUnst2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788343730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e22SUgGgIJ3poJkGI8HTllTE/j2hDqd/FF+MOcjqrxQ=;
	b=dfL+csT0Nr7xjunVMrWBZlNCiQt7UH7K6PChQBnNvuEuySRDckDlJ6slanlDe6FfbOf1WG
	78itl4bxceY85d3W8oPm10HVAdyTciIwX6j7zoi3tgt1m2OvVDv+2/shiuKCGQ4svhYPtf
	xh9S8YZvYeJq+V7NubwuiFxdRO1l56M=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-PCBOwjn8Nt6Wa86WPQmCZQ-1; Wed, 02 Sept 2026 06:08:49 -0400
X-MC-Unique: PCBOwjn8Nt6Wa86WPQmCZQ-1
X-Mimecast-MFC-AGG-ID: PCBOwjn8Nt6Wa86WPQmCZQ_1788343727
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5b15484404cso555962e87.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 03:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788343727; cv=none;
        d=google.com; s=arc-20260327;
        b=qc1EN3j/mMqCqmBlohm8/B/fudb0RJ9l6XVIvoMvIp6fHW1YdFQBNhfWcx/lLYYAuQ
         B5EfWLfr7NBVGqcPLA1wx+kZLV0kpaLFQ8I4KQL661m2IH02Xw91Ic8Nn9qh5gh4xy0P
         Oma3s1p7pQZlIscHtJVSMH5lyYggLiywQA3hAWxMOV0vhOWNRiYZEOY9WnuJ8yvn2/y9
         o8MSr0aHJZi8kXcFm4fUnhvKkzItiUfnMZab8p5CDJhUwURhT9h4BLBoEJQDqMw95oC4
         RpOfck+nUAjkQPax6s6XdS/CVdue9PFxy3rfvzISKy5LVrsKAUb7POXxej1KpZZkIuL2
         Jsuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e22SUgGgIJ3poJkGI8HTllTE/j2hDqd/FF+MOcjqrxQ=;
        fh=YYuAsTm8mom/dJ9HIYH44hutfMW5v+U8cqQpoMfmqNE=;
        b=kqrgpm0RP9j/8+zW+PSrNAckFx8u9BErMSo1Z5laOM8+fxf4QbqzYj/muziRWbH6QH
         +6s0QbbbPLELrD3T8oJR7DMsNohA0Ioqpp/8mOHhecfNqRQKfT9s3OOkohy+4j18jlWY
         PjGcpyWHjaXd+OpMAIDnjUUh3SEtrPJuJ+n4ubYIR66yJWHtx2+OD1M1KZpo6SDmXdzE
         o6dbsUsLLiuTYgAk7pXiCbM4CFQqXVvO7sU7etuIw3i88XbSnWU03stlzzO/H3E1iUPo
         maVhKdBBbil8PpT7jgIg5U77V3LlvQ19AB8cCY6Zz28Lad46Z3iPBlQrVm9QtC6RCjJf
         QzqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788343727; x=1788948527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e22SUgGgIJ3poJkGI8HTllTE/j2hDqd/FF+MOcjqrxQ=;
        b=nMnUnst2Yx0Msk7zIwj8FUlVvIvyw9uUohHRoadFQgmiUybQVvU7oCdIqVzEYZXI/M
         R9PlX28mc7pvtT/9xfKJzMhgP0PTJpjgWFFOywPEKu8Wb8D1RLWLQMuylGXcXThU9cLa
         3zMR9vPguuUufi079763jqFqQvHkCgS0lt0zKRclnvLZwruKDfQJ0Z+4SYN9kf1rH3vJ
         fHPqbyRlbodTVHZ1FEX5+98uxyF7o6UIKWqghYBjO+vL+AbAYkwLX4grefGEwnJmWfwT
         ufVM2IAtguMhAV95KRuQPNcoyC8LAhXss087Rf4EYTqhnLqxjE8+J+9dLI9Lei5Mzg1a
         hO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788343727; x=1788948527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e22SUgGgIJ3poJkGI8HTllTE/j2hDqd/FF+MOcjqrxQ=;
        b=Z+0yJGM9X4vrqcqIKxYBsrQCBPekzZrESTHxttWWDXdjVmZw7c6l9SQyGJFbp2VrME
         KljvSj6E+AcKG1irGR7JJha68gWjeycDLTemtXYoEbuJYkBywLLHsvDkeVboBO7JPYAj
         ojrSwlkZD23V00PVv5VMJgiqveBNqfxF/fZR/dks3ZjlCE1o+IlJxhIvYWI+Z3v5DjjE
         DvLlaC9n5EuZZIU8P9cAyW15uuEfI+ZLsUET2i6ABxx2pLyi4ni3luL04G4JzES46Uqb
         h225DSWalY4GHLXbdGEnHizYpIqqtOUAk0Zqm4h/F9d+il80zdx2ZAjqIU8Q8dztqVJz
         Riug==
X-Forwarded-Encrypted: i=1; AKwUvBzs3rxJk+pLl+3bltmbRGUtZaMwsatXLKMazuGi+OplMF3UY3HDW90K0QT0wP2T+WIyS3rExH4=@vger.kernel.org
X-Gm-Message-State: AFuF++ms9hu+daF/EZl/9yl/8Yw1COn5q1tC4hbJmd0yEmPAkQqNKGmR
	/feYqdV23LBbbNp+uqeCFsRC5u16Iz6toZqBmF6B+Y10bKPRch155njsAnWN5lNR4TdxKCl5PjB
	+Uu2Pp/sqsFfWszKr88gljR9+UtXKNP7BkoDa/TLxGmUL7qV0pk4CNvmHqtCYZx8HasianosBGU
	cM7ToU4nERRIq3QaUmKsBku4hFC860pQ/F
X-Gm-Gg: AYBFou30h0/qC7xm/0He88I6j8RnxiL103u/YbbzEJgubt4DMHUPCmngDdpV8bU3mB1
	ddyv727grZu6zAKotM3cYvfIrscvHTsT0wJbTt4aWjvvmUjjVDrPGR4Gkh+jbnY7cOd4c+gxq3o
	luVZnDPavD3cITbc8xLfgOU6KT3zjMUxkhx9f7/5Ru6jeHa/8R5VTNFlVt
X-Received: by 2002:a05:6512:1252:b0:5ae:b0f0:c217 with SMTP id 2adb3069b0e04-5b60834b9bdmr1404123e87.9.1788343727397;
        Wed, 02 Sep 2026 03:08:47 -0700 (PDT)
X-Received: by 2002:a05:6512:1252:b0:5ae:b0f0:c217 with SMTP id
 2adb3069b0e04-5b60834b9bdmr1404086e87.9.1788343726954; Wed, 02 Sep 2026
 03:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901115021.50057-1-ihuguet@riseup.net> <3d8ef804-efc1-46c7-bbb4-f1a6c26fed8b@kernel.org>
In-Reply-To: <3d8ef804-efc1-46c7-bbb4-f1a6c26fed8b@kernel.org>
From: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date: Wed, 2 Sep 2026 12:08:34 +0200
X-Gm-Features: AcwNN1WWjJG56_BD-BZvMi7yD139IVOfUkEJ5Q53fMWfoLWzhUAroA5GHqaqbfc
Message-ID: <CACT4oueX-g20hKft6Z1Aj3rNK2Fi7MYHZz=LdBd3RKWu+YK-0A@mail.gmail.com>
Subject: Re: [PATCH net] net/ipv6: don't route packets with unknown source address
To: Matthieu Baerts <matttbe@kernel.org>
Cc: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@riseup.net>, 
	David Ahern <dsahern@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Phil Sutter <phil@nwl.cc>, Daniel Borkmann <daniel@iogearbox.net>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Alexei Starovoitov <ast@kernel.org>, Junseo Lim <zirajs7@gmail.com>, 
	Leon Hwang <leon.hwang@linux.dev>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>, 
	Willem de Bruijn <willemb@google.com>, Kees Cook <kees@kernel.org>, Qi Tang <tpluszz77@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, Joe Damato <joe@dama.to>, Breno Leitao <leitao@debian.org>, 
	Li RongQing <lirongqing@baidu.com>, "open list:VRF" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:NETFILTER" <netfilter-devel@vger.kernel.org>, 
	"open list:NETFILTER" <coreteam@netfilter.org>, 
	"open list:BPF [MISC] :Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 7:41=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
> Thank you for looking at this, but I think your patch is causing
> multiple KASAN warnings, e.g.
>
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-extra-dbg/results/8045=
84/24-connect-deny-ipv6/stderr
>
> And a few more, see:
>
> https://netdev.bots.linux.dev/branch_deltas/net-next-2026-09-01--15-01.ht=
ml

As far as I can see all the warnings are in the tcp_v6_send_response
function. I guess that sk may be a request socket there, so it's not
valid to treat it as a inet_sk in all cases. I will send a v2 with the
fix.

Thanks!


--=20
=C3=8D=C3=B1igo Huguet

