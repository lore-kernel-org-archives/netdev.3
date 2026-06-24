Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B6E367B72
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334631; cv=none; b=RNLmwQSU9K4H4AKNxX89G6Jqj6whm9R9M0X0a61rhREB6WIdWiicHeyrnTEXm8WXiqIf6A15AJIcuJ6iU/n9Scwcoh11e2ijLi4xqKcBE8NnJoMtc4R+VtWHlNBPHfXNFtALLKD1eymmbC51nhbfwUqsdJuX3YOJ9e9Nk9aKHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334631; c=relaxed/simple;
	bh=E1kSn3zA/cIoJ7ipzjSb5l55z352jUSBjqBw1lqnOFI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YnBKBEmZw7Dlz3642BPN0sef8lA7/GmbabbEYlbXIiWvbTMdiQbJuytMPhOI0KuYvoD3E8pwEOvmUs/RC4YnWGALxVPJLUIubDiyc7gUfzse4QVQPbh1//vB7wP5pHu2RQqLZG+Um7qI5kxt8vWk4uEmdxBxXodDoLLKL1rbGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKBrZOQN; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKBrZOQN"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-43bf9548df4so1075853fac.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782334629; x=1782939429; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1kSn3zA/cIoJ7ipzjSb5l55z352jUSBjqBw1lqnOFI=;
        b=XKBrZOQNHHOUfyCUySLyjBci1OrA/cmKd+bvJNK0wZl7lsowOA2eQfjYEIibwwKEPC
         D/sBHnockiW9bRhIu+2+WigdCU3apn7/UUvZKC5n5rCKVG7axPNM2H5p/pnkyyxKmruO
         usw88e3C0wgOyq3KhdQN1UvSkOx7BAQXJbPeWGUWAfL1qe2GseV/isQUBeOtDb0BrpFW
         VHSpKvPO/yvjBtOjEFPJog7nCaOLBK5Tu7hPD666Z3Gxh2EVEb/mI8N4LhMQPT10CRI1
         +cCbouRt+ZEZdibi36xP2pLTEVpi7ljdezlc0/zma8F+gd00A7YDoD7wD24xq9e2/gqS
         o6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782334629; x=1782939429;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E1kSn3zA/cIoJ7ipzjSb5l55z352jUSBjqBw1lqnOFI=;
        b=SOib9CndknxoNBVEKYyzDUvi2DvkVkfBySP3IoLuIyBJVLusltQPCcouy/66IsYBIs
         IyJDFaw7eBEN7TovBVFXAoxXQSqANNj+Hnf98rfbYOZaI3OYLkOnP1t3awHyx1fOrMn+
         jnpZ3KmvBLONMfOYRRahJb87GRCceTRrtoD1qIW171B0ywIP9OAOONepaoOs8/BVJtoV
         OuEbKO1/LI8fRT/YkYSjTL3GdQWNKkIifBAqp+pAi0t0MZg0A7EFIkUxOuqZgrkHIT1P
         aDXA6+OGFm6Ke/dMIG0waeSuS1khlSEGG/+XViunTH4fGYveBpUEloNNra4/tpafe0GO
         SVvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+o2EsGy7f/WFd1wNQf+ds7RkkQDZZo37H1gtyw0A+LpzFsI9Jdc4dQ/QuxcowpPG1oTPi7dGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgnX34ZBVnxtJhU59Ttlwa/0CYSSuX9hT/FE/+jSPpoW0qUfDD
	e5PhQbMP4siA8mAegYuOfqGHIR27ISfmLgPLXfSht+jsIBY/IEBa+RdI
X-Gm-Gg: AfdE7cmSs6GlVuQDYr5mDgh54Lr/yTKYHyFlsEDqOmIhqnO6bT2foqxPQ4PQ1dqZXnk
	5x97kdkFnvhM69oxXSQZENIluijc2y4E+elk5VNzShzjMjlr5D8PPjqHzlg6hhZOXNya9BTfzIu
	9GUi5MCvmk5Byk9bouFQIkO7kOtAg0oOmo8YyoSPiskbTC9wnTjqJyRCzRvpbP8AyykQtkngw13
	Nyg30lfiMmVxFiRiZyw1VLjSBVwFyBe1LH7/0fToc0IGs3DP+XZaK3q167uJj0lHr1gGc17w/mt
	UCAcgK8PuWcoYwtts3jyKw1sPZtAYATcubkyYhQPcFb1aJI1n8vJMQB8s/BR/kwR5VDdsenVflG
	AgIropEVPT9HlDEgaNneVsq/Wmu3sbPDPLw+qKtIQenjAGNWF2cWpfDU4wlezUoWrfpplp/23ar
	lUrxMl7nK0I7i85u7UENNZB7GFPKEIuZJsPg9grW5mmm0GTejaB5JroY1bmr3lcMgdgd9Qc3TU8
	1t63VE=
X-Received: by 2002:a05:6871:c8cc:b0:43d:2efa:77ee with SMTP id 586e51a60fabf-447b5e1b862mr6429226fac.21.1782334629398;
        Wed, 24 Jun 2026 13:57:09 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f04236fsm10151743fac.14.2026.06.24.13.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 13:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 13:57:07 -0700
Message-Id: <DJHKW8E1F6PI.P3WUIG9DZE1K@gmail.com>
Cc: "Amery Hung" <ameryhung@gmail.com>, "Kuniyuki Iwashima"
 <kuniyu@google.com>, "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Network Development" <netdev@vger.kernel.org>, "kernel-team"
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code
 behind CONFIG_NET_SOCK_MSG
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, "Jakub Sitnicki"
 <jakub@cloudflare.com>
X-Mailer: aerc
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com> <CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com> <87v7b9ysep.fsf@cloudflare.com> <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com> <CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com> <87mrwlyqg4.fsf@cloudflare.com> <CAMB2axMVhJJpP5HZtDFyQLLbKoRxhW08rj1zGRtWtgDkfYaVNA@mail.gmail.com> <878q85yoy5.fsf@cloudflare.com> <CAADnVQKr1XisnigNsBw7CsXxY3Xn5KOGtX_YDdXmNMZyJy4_Cw@mail.gmail.com> <a50cef70-d8fe-4f42-a89b-2c63c33a72ef@linux.dev>
In-Reply-To: <a50cef70-d8fe-4f42-a89b-2c63c33a72ef@linux.dev>

On Tue Jun 23, 2026 at 6:32 PM PDT, Jiayuan Chen wrote:
>
> Hi Alexei and Jakub,
>
> skmsg is actually still pretty useful for gateways.
> I started with bpf by integrating skmsg into nginx as a module and envoy=
=20
> has something similar.
> The usual setup is cgroup/sk for L4 bypass (reject SYN), and skmsg for=20
> L7, redirecting
> between local apps by looking at the payload. So there are real users.

...

> Agree, just like we remove skmsg from KTLS which is rarely used.

...

> Hope not have skmsg disabled by default.

I wasn't suggesting to delete the whole skmsg,
but to disable combinations that are causing issues.
Like what was done for skmsg and ktls.
I'd allow plain tcp and udp sockets only.
Allowing unix sockets was fishy. I think we should reject it too.
