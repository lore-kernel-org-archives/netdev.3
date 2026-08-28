Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC3536A358
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932325; cv=pass; b=ZEovOIy+6Avc37Uuda4E2oevQr74NsyT/VdBf8CWcrmO93ZEmM37h6cMXyMv1iVGeVxAlskGaqYmFIJrCZfrkFdtSneijdSNMapfvwW9PHtpdWP7UeFS4O9kgmKxC6upRVSSx4kvsp6ZruUr+5qW5AR36tYjHdpUHh5+yygg0Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932325; c=relaxed/simple;
	bh=aoZCNrfhmX8pZEoM1qBu4ztXr1H/TOUytZpURwnLYPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mr3ZaeLSsbfzaWSB3gqVRi1MlhD0YMjjK+Goj4RiLIX6kdylMmwC2OUH0C0CULRBjfigjgiEQt2UBrTBDKaAHmMUeQUL5aPQtVryOCZoA62TLzGzf4HcAMQwwKfqfr9zgqqqW30KOVwgBprVcUZnGQe6weIYwUHUOLKBhREES7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QA/9z/EG; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QA/9z/EG"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5218927884fso13145321cf.3
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 08:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787932321; cv=none;
        d=google.com; s=arc-20260327;
        b=HKOnN8gB6fX3Cl9Zrkjixt6pPlgoiKfZgl/NRktZqfth+T4aXLdENO1+reN0Obf9OI
         FJfGx6/nndzmPgOlqXv0nNvhgas0lFIKlC8RGGJh8I+ppLlCOaLPexbje0IsNMDyD73L
         2nvUMZ2f3lZ1iIGtXaNnPau6Seyl78LnorSr/jNsXwqoE9UshZVIpBf0EGpIes6XpqVZ
         NlfSiF8wJs36OTOEibfxx1/+4S+iFM4mMTG8J3VGyAWpfFuTBUr6lXG9ruvSWJ+TyGVI
         KYuvNuH29/l25QkSH8ztsYKIZrEv9deF0OAklYDksKu/5ivCf17+ULwkFvTWrpUHVYKU
         l6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aoZCNrfhmX8pZEoM1qBu4ztXr1H/TOUytZpURwnLYPw=;
        fh=vcX8i3JV4Wdf8UBtwlljIr67OG9hpfk5x8tYF6Cgk48=;
        b=Pla/f+rB3qjyNE4pxMsWtNuS1FhRJkf928Wdn/W+kYY6mpRnZqpNyDca/JKFajGsrP
         JD5iF9/mhz+iZwZKO9pEVE8+9kX9V2kQ/tPkP4W/UDRPjXAspNNd/B/RfbnCKaOehzuJ
         2HgKlaxIVg99rmDjo2nSp4bfXarZsthxAaR4BfiutvfeYF1ZzG1xlihsyDble/10SqDL
         emT0TsONAc7NvzALliWo9UHfSx8X6Un5Bj6FVh0Elvpu86Lt/x6qvBWWL4QlgY/lIRBG
         GimD2qePtuomR47WRm3VhLOGpJ+Z6Bj6t179qp10e09AWRI7oLwIq/QhwJYzGdzV8EP4
         Wmpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787932321; x=1788537121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aoZCNrfhmX8pZEoM1qBu4ztXr1H/TOUytZpURwnLYPw=;
        b=QA/9z/EGmDm+xV0rAWn/nYFkL4wB5KbDc4lgTbYkW4cwA7w2JycS4eo6jPJMQ0iuQM
         I/l2QGEMi8iDm7ysfZYdLl5/yTO68lBqCXe8IADnK4rLtEvunhVlqmFsmN/Uer8bbc8m
         L3CaDSCMD6lvQeHmlO6fBLcNUChGiX4IAuT1X+IChmz0ObcnOgquVXn0ECQ/0MF7+EdT
         aB6Vj/V01EEQEfZTMTaihY3QXAZt/E0TE1UjS6U87jtuQOdvyucpHio8BhFwYjN9EyNc
         h2hXgjylpntiewt4OtdPRRSqv4iBvYaxQ/e+QDfpy0b29/FPPLV55KAQn9vjtU5zx1wX
         Gp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787932321; x=1788537121;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aoZCNrfhmX8pZEoM1qBu4ztXr1H/TOUytZpURwnLYPw=;
        b=TXbyRN0oqonrL8wRhGo+0zpOsyGCzh3GX5IRbb85rYWy+iEek4RDxNzI+mg4x2pkTU
         /jVv6kcHvmFIxEJ4vBdAbdJK9jrqvP3xVSldXqjTDMk2FbUZBlTLHeJ7/YHzSaw5UTvA
         6al/Q83kf299K+9ZFarAuJchYzc3MfNNPgj61AcKJPZdvrbehVwOEjA3PEw78FG9jGRr
         mYMKhhZypVkT4sfySCqoW/LIUEWrVIPVFUAiF35+XZxQ79YxE+zMVX7K3r+xfbIR4Wjd
         z8wDNH6v9Cosqg1SMZZJBVbw3/fkkDh5PZ5KJg7w0XYeeRRbWYLQNyr8umF0tefMHD09
         P67A==
X-Gm-Message-State: AFuF++ntBxza1/13ArLL846pday6X88b0BdELSDvZd9lcpLxd5IkghrR
	Fmg5ygRmbIlvNTMiS1RjDRHCaZA454F5dl4ZN3UiqRG6mnu1V7Syw9kdHsgJeZriiAtdALfvQrB
	LES11Z/keR2MAn4RvdG6kKUFKkpmcaw50yV43Rqoo9WuWeft8gaIx+83R
X-Gm-Gg: AR+sD10CN6j5MGwPlqkYTFI1lPafJZ7ZrBAgBoQH06UlEZTDMCfJdVt2aT2RmLr8QgD
	Y+a3I4qMzyzblwoGJmknu6uNyOYlcqqP2ZltwmoQ1tz97/hIe+uoqW1UMPGufhZiE6BOksinHHK
	Zo/7BchD9d7e39RM8C6CmFWkXviGP/wVyBZM33gaguG1/T12GfC6vqwf0LuytyGb/2v+KBM+yNv
	oPBuaO77Y4fhZgY5rCcdaFvRRHBMZFb0Z4haE3TDqGqwnm/qSdm5a5QDlFWw334jevxCk7v277j
	5S5a5bB+6g15lLAbOIYYAL0uhIsvBrOEr/8Zue1PmAYBGxWfLDXuErdrQMpGZgePETktnE4SwMn
	lX8CX1yzos+D6oHKJs6TXIu1H8F4nU9VF7VEU4gN2MvSf/McBNA7slVc5D6k=
X-Received: by 2002:ac8:590d:0:b0:52f:ae2b:da0b with SMTP id
 d75a77b69052e-52fb942d67bmr92898081cf.16.1787932320576; Fri, 28 Aug 2026
 08:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828012918.1461-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260828012918.1461-1-xuanqiang.luo@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 28 Aug 2026 17:51:48 +0200
X-Gm-Features: AcwNN1WNUfRz0c38YPkdkzESErlfZuBvnROhijzV7VpnpSfwkeHLO6YNKkbnH8Q
Message-ID: <CANn89iLvTQXe=nOdp+VNfi1jpeupkknNLhtm=_uo7MVxKV6JAw@mail.gmail.com>
Subject: Re: [PATCH net v1] raw: annotate disconnect-side IPv4 match writers
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, kuniyu@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, runyu.xiao@seu.edu.cn, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, Jackie Liu <liuyun01@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 3:29=E2=80=AFAM Xuanqiang Luo <xuanqiang.luo@linux.=
dev> wrote:
>
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> raw_v4_match() reads inet_daddr, inet_rcv_saddr and
> sk_bound_dev_if locklessly under RCU. Bind and connect writers are
> annotated, but __udp_disconnect() still clears the same fields using
> plain stores.
>
> Commit 18f116931f52e ("raw: annotate lockless match fields in
> raw_v4_match()") added the lockless readers and annotated the raw bind
> and datagram connect writers. Its v4 revision intentionally left the
> shared disconnect-side IPv4 writers for follow-up cleanup.
>
> Complete that follow-up by using WRITE_ONCE() for the disconnect-side
> stores, including the inet_rcv_saddr reset in inet_reset_saddr(), to
> pair with the lockless raw socket matcher.
>
> Fixes: 0daf07e52709 ("raw: convert raw sockets to RCU")
> Link: https://lore.kernel.org/netdev/20260716142958.3064224-1-runyu.xiao@=
seu.edu.cn/
> Suggested-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Eric Dumazet <edumazet@google.com>
