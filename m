Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2254C37EFEE
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222961; cv=pass; b=m6jzsAC7ayZzbgLg1K4FQFupDeZubt5SK2o0pgB3M5fwAwb6pJj3FGg+agyZg9+P1WncCl+9TK6dE3X0L9bLUqUiFznweuBSlwU03PrjTDAtLLWir/dRb0pXFo05UziB33GW3K2Mye+1mRK1rcLTVavxTF1M6biIuyMUgewxIC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222961; c=relaxed/simple;
	bh=NHSHblbJIJbBATKAn899WltRTzBJyssmIytVxQsfaTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBBh8bXHvJKWgaBjVg/CQM3snE+a/DZmp0C6hYaYDnDt1S7vYSBv1+8eMpmrreUgKMRrkVYqreVtk8T1U4I7UzmhcMomKi5P/CdgXyH9imD6P1J3KO7alRaeAOH7ZoQQkYSzRC1mLFZLCnoVQaMON1GXjz9LBovB34ItbJbHDMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/XZsHgY; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/XZsHgY"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8456005a6c4so2229521b3a.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 06:55:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782222959; cv=none;
        d=google.com; s=arc-20240605;
        b=GBg5Yvkxloar+GvV++D0tTHLGEGK7bcIdIZtIJsRUqIx51+tTDIOEFIV6yIObj30pj
         LpmYE4imSpHta5V1x89l98JXqaAvDqlL6MzrRlCxoMPJ7Ps+QHcMAw00G/8Ad084AR8Z
         P6vV7dqelDYc12LPp0kD8C72PjmUVFL8NaY1AN3fRklpjucCpjxYtz4ft8QxL+vV3MQz
         yWeJhFoVpfX1dv8y2yES8JTr6aKDW37Z78M2oewkUk3TE4j3iWgjuQCmrV7w+3YDDMNi
         tBl3f2oxBg3m+/q1Orlle0RN4KMC2od+FzgQUk9nidSzhopHPNY2fMJSvAs7xVU3/Rna
         suYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XVaXL97DlFwUPlSw3h4dPwDd4iREHsM9BtX2LGFmLms=;
        fh=5tVGLYgsCg8q2RaW0ZqQuXjdhhctajXqUAAnpyyyBfA=;
        b=F9HudP8uK4krUZqjQHFNxBiytb5jabYKfNE7KMivTUoZTyaXEukmpls91phaJzcoFt
         g0CR97qcFC6oyoShb46q3qX2rO+sRuEDsKUHwHO3jkFjsUlO2BKgdagWdkhSG9cH3C9v
         lXTKpzxFifIXorex8pbWXHifZ3GO/SX+/YX4BfkUJA2QoBqrKTsLQYZlSGGmjKcST3Vu
         f20bL3xRI1rbnm9ohE09H2x6KlGDbMZvU1DQ/8sK7pcSp9wu7WkdGfCZnL52GRwi78yO
         qC0Y89w6nagV5yQ2cgpHOYLa+ejT97kCfaK4++jN27JKdg5PPpeVDr03EfQ6tdKpRcxl
         iVMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782222959; x=1782827759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVaXL97DlFwUPlSw3h4dPwDd4iREHsM9BtX2LGFmLms=;
        b=q/XZsHgYd876xDhRZUs30Nj5e8Y+eoTDk5jT1fZhGrTYeAOQauqgZOykHLprR7/csu
         DNMcJQqVC5BbHAA/DxS04+k1Pfw866HoNU2ebqY0wiBFQXiDg734HGyfcKQm+Kf828bM
         lGIq/lErvithEA7fq2e6YqXwbpQB3GhNOoRJEjgTifcexXVfp3L/0kxfBucvo4t3Adjo
         FGxOmeNjBa0rMM5dM2zQw5NZm7OUh+Y2gpO+CEAp4BMMTV+h7MGNHupYJWabkjaUNneL
         dn84Sa8itsPIQW1jXuMWQ4UsZoDJnVOPUWhWW4vXxKVFYHIgLktXIc7aMZEgjhr3eOmL
         XhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782222959; x=1782827759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XVaXL97DlFwUPlSw3h4dPwDd4iREHsM9BtX2LGFmLms=;
        b=dqmMLTVF3OocntVv/SJLJiPmLOrSMvS2cG1n8AGgxScnU1yOmrgqkWWxJhT05KDJzb
         P3W3foC3nCCqyV8HZW3MO0WB8oi6ZMQrf+b7EnvaKuI1lKaDpaCzNo2Cv95R8EyYKkjy
         1Bw8P51GU0oLUACJwsXpKKX2bEmvTvzOpnoWhkoIhidCyYx9X0tT64XxKSWRN+sy2dFi
         1UuxPcn7ZL9WYzSLvYXFgVaSZ93EVLmOZSoIjyizbdEzZt2fR45QaUNdGP8yTy+X9mjg
         3fbzL2i9kxUHOn6SztCUv5ZaXZTl7CoSH1lvz63MFdRfcodu0eSOj1jt45EM+D5GhR8M
         VqVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dFuA9FuYcLkoEP+6YDibGTSHB61CF3UGLuIuuXb9aXm35d8F/+DWyyPlFr2qBZwfS0/04+U8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSn6XLxJDlkjB+Xd3J24XIzUxYzT967Z9DIobOqs/akSRQMN3J
	vdzaVh0YDY2ZMqeGmxW7IQDyMpVzygN8k+BBTKWp37huXyJpzxC/E3c4+L5M/8joTfo4mLsGMnZ
	gwAbNRQfuKRBHUknTB02+B5ciHxebU5Y=
X-Gm-Gg: AfdE7cnyc408q0VaSroh2KNr1urDVImKWnIGrzl8tkEYQAvcIharytitXtSwNYtIE8V
	KtYII78vsjXh28gRV1Wrr+HlNI039yV/JPbjzf0+/SWWj/qVYGdDRJXjHx566S3O6sV/ZrK8Yw/
	Cjmg6pKcQWjbQ3UMQDcSuIY4GiXcuzDfrOFRScow8mPGCejDNJ5ScDtOFcBFVUqly29MfO3YXxl
	pKjj2fS6qiq+Dv/oEhD2nPpwEr1bORH7mgjNyNcVaBkTnw+/Tq+Xcw3yuhSVQhGzDA16R9TJPC9
	w2pyxl8qdyutnfMER5kNdMIp6uqHhDJ9yKc7+bnqvbE0EmAU5hS3lI5pth0viO+C0j6DemE=
X-Received: by 2002:a05:6a00:1a87:b0:839:9ad:ee31 with SMTP id
 d2e1a72fcca58-8455078573emr20357714b3a.8.1782222959272; Tue, 23 Jun 2026
 06:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622171048.1626022-1-edumazet@google.com> <CADvbK_e_7184a_jm5ASjKafXrJqaOKFUKJF6V1wp7AnFxK596g@mail.gmail.com>
 <CANn89iKFj9vSS6B-=KAMnLyqFqY5edZ-eChfcq+SuGckU6T9yg@mail.gmail.com> <CANn89i+dkbrSAwvaWXW7yWMfcwUebuTBLG5T7AGZaZcpVYGyfQ@mail.gmail.com>
In-Reply-To: <CANn89i+dkbrSAwvaWXW7yWMfcwUebuTBLG5T7AGZaZcpVYGyfQ@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 23 Jun 2026 09:55:46 -0400
X-Gm-Features: AVVi8CcuwfCjbbQwyUkuTo_v4Lude8ZYwe6Us0Iluc3TMcR62VCbK3x5QlawjgY
Message-ID: <CADvbK_cMHtBFGb87P6CoqJN+DCasn_5=RwtNhymdZ6p1eFnjuQ@mail.gmail.com>
Subject: Re: [PATCH net] tipc: fix UAF in cleanup_bearer() due to premature dst_cache_destroy()
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com, 
	Jon Maloy <jon.maloy@ericsson.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 2:35=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Jun 22, 2026 at 10:37=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Mon, Jun 22, 2026 at 6:48=E2=80=AFPM Xin Long <lucien.xin@gmail.com>=
 wrote:
> > >
> >
> > > Could this corrupt the list for concurrent RCU readers?
> > > When list_del_rcu() is called, it intentionally leaves the next point=
er
> > > intact so concurrent readers can continue their traversal. However, t=
he
> > > immediate call to list_add() overwrites both the next and prev pointe=
rs
> > > to link the entry into private_list.
> > > If a concurrent reader is currently positioned at rcast, won't it fol=
low
> > > the newly clobbered next pointer and jump from the original RCU list
> > > directly into private_list?
> > > Because private_list is allocated on the local stack, the reader migh=
t
> > > interpret stack memory as a struct udp_replicast. Furthermore, the re=
ader
> > > would miss its loop termination condition because it expects to reach=
 the
> > > original list head, potentially resulting in an infinite loop or a cr=
ash.
> > > [ ... ]
> >
> > I think you are right.
> >
> > Considering there is already one rcu_head in udp_replicast I will use i=
t in V2.
>
> While looking at many syzbot reports with RTNL pressure. I found this
> gem in  tipc_exit_net()
>
> while (atomic_read(&tn->wq_count))
>       cond_resched();
>
> On some kernel builds cond_resched() can be a NOP, so we might loop
> here for a while :/
>
True, thanks for the report,

I think a cleanup_wq should be added for 'ub->work' instead of using system=
_wq,
and then do flush_workqueue(cleanup_wq) in tipc_init_net().

> Added in
>
> commit 04c26faa51d1e2fe71cf13c45791f5174c37f986    tipc: wait and exit
> until all work queues are done
