Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530014EA37B
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791972180; cv=pass; b=eqJ4/12t+nBKa11sds5lZf2UHOa7nnyDk8AuPJVhT+SohAWYUU+bkMEasyr06++BZQz5ojyNcDno+AGrkqU0betoBskIdwBSGXrCQgNz4dRBXP3fzXaOQ+s+FbZXRsLCjRMHW3mwL2bf595rH0HztYsiMaIY8co+1mUA8EsW5LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791972180; c=relaxed/simple;
	bh=4/XyayOHDRiLNGYPeeSA0Tk68l1jO5a9bJjfyvrkK7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gbx4V+uiauK8aQ75qJSUEHoyyDmoDJCmBnBn34edV11/rlxwrZghCNcIaz30r+wPMCPn5CYR0sNREn/MH1rqSWbQImtV8/fs1VG94iqo2OGZtAYAMd6FKqkPUKfmslRpPlYohxn7sNvgkfirU14wBKjSBPZoldAHz2/sqqvOn9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=cBc39ErF; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="cBc39ErF"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-88834d30002so1872023b3a.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 03:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791972177; cv=none;
        d=google.com; s=arc-20260327;
        b=ZRgC8hEaU9zIiKrPMN7OLyltRoaI7ksXwkrKighH2hh4N6Ey1rOS96920O4ZnF4xmz
         4xAEXTQGeOvbLK6h5kKrkBwUBzJRvnbUE56MOmbB0kQk+ahh9QGj/8ImN8oasXE8edC/
         8Czygeq2P1EguI+C1PqskbF7i0tmos9QNTIldAlv9uMKGP62iCzAMOYLkxCDYcFoxMsg
         /ZiL3wg1q3hOKoQhdO+ve+bzWF/67UpZKHeBJnbBXuJ/fmDX97NLhJN5cA3r5c7utGkM
         nHuwN3Fs8w25FDrUvRPaVnK3kbBkyH1Q/3+D4g0oLRnhkRXlHwV4y76k1NP1dC3aXV5N
         J78w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AE0HN+fFvA2udY0NoWO2S7SaNrvjPqbhVXYmeMDtfk8=;
        fh=MPnvnwOm34hiEvEPfx7qF9zN9L7c9r2UxLMadf15Td4=;
        b=Aip30zYjS4qAZgJ9hbg0hb4FC0CZeRCaD3xm39momoN3Qfl6GmMlW1261MQoEXQX//
         fLapb/K9cT5cHB1eTEykjIcQO5vIciq0zDldCwRJdRTNBGXQxJ0cHCRdGFnyDr6K6v/+
         m/6PMneLZQlS6Vf5opHAITIiYgw6byDv1cuNJs4L1pMVRfxqtEHnphbVn5ecronzwZSR
         WkGDtbejRFZgX/zR8J9i9GmxS96CpB4SBd16BC31RONKxNVN3x5TeJSsiJE4cD/G9tL+
         48ZBg4oVzAp3WZz3DxfrX9Pl3wP8YYZFHAdZPmQjk8JbAPZ0qrrn3WWcxY78Kf/q8hl6
         1FLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791972177; x=1792576977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AE0HN+fFvA2udY0NoWO2S7SaNrvjPqbhVXYmeMDtfk8=;
        b=cBc39ErF9Fcr4i6RfkcOSjDiHOF2udUv8XURBcMFqtToituLa4bIcDcp7vXdL038l1
         72jD0cYbfjtCADk1YjEz5upCkdzuzFr7oVbA5AMspzZj0p2l+hLjRzlupS5ySDCLjUHX
         SCQ7ZpUyHGjhkZ0Xvhrufr/lAwX3NXe5s3d7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791972177; x=1792576977;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AE0HN+fFvA2udY0NoWO2S7SaNrvjPqbhVXYmeMDtfk8=;
        b=P0db8VIPacfjQMlLX+H15YwOH8hfacYdvH6REhdQn2NPDGi6VJt6mS60RDYvs2ccpA
         XMI9CYxpKOv2STJw/5bsS84c1BegoOpB5obj1+49p8BPK1dw6BVxoD3ELlr52W02fMis
         wYlteDCldI2N4Fkoq+obsHP+vxD9NE7Rg25n/rU2F2ETENTNiGzlFEEaEUNzux3IxiWd
         54zVQKwi7SLhMQg+Hoj7XSVvL7zLrpNocAsVMp1BMVprieHjbRo7uC9dkDqoVqmn2m6j
         YCOd8IpFRV1c6WYFuL0JA8hX3mffhywgI8uHkeiNfYsqjv7CjhKf9p/OWXkzUs1ra/g/
         lcQw==
X-Gm-Message-State: AFq9FYJz6mg9bdXGtJhZi5Y7V/YdyouQ0ioisnkOeuUz2wWr/C1QCztF
	UOpKtBu7DQvrqGZXtM4UyoYSYTwYvjntpVdKGXKdqISDzXtNBKU7e35FnAJOmK8CPoZY7EApEgK
	dfU4WW5QYe/puygLFKYNqr1W1hroUrloM/UjdXNNd
X-Gm-Gg: AYBFou3OpQWis+c0VpIDcVMci+hyet0zdVe+G2y9Fr/OQutKaedbXNB/L/wEjEFiAGV
	jITR5RlRaQh+ACL41aOZx8i9FqxIxqz0i4bbPtY8PrCRT265K3Gd16dLJ9BgyPvsgIP8P/IGY7T
	HA4uqK4HuviPSr3FZtAUElZBWctpQEcOZcs/4MFrYoY4Nex2vMKYlLdL6YQNq0RJLsHF7W/6Ftx
	6RJkYm9vV1IhRj13Y4oFlpdzyH3p4kQyZw4G7Fmc+4yad0Nhz0EMJ7OwZMvF/cfEU0aaKF2vxN+
	iDKC4f58pckUhvHHM8leSohU8zTKsYohZmg6x3stkyFBGNU0OP6dYcAz55IGfDYr0BEEi9V7F2U
	8tp7rSMt6LpYIn/iPqoi30p5YRklRT/3YuQ==
X-Received: by 2002:a05:6300:6d93:20b0:3e1:73d6:6932 with SMTP id
 adf61e73a8af0-3e173d67534mr7370477637.79.1791972177472; Wed, 14 Oct 2026
 03:02:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-H19Z.v3.r0.20261012193813-5@mojatatu.com> <179196934366.434549.16677487229407143890@kernel.org>
In-Reply-To: <179196934366.434549.16677487229407143890@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 14 Oct 2026 06:02:46 -0400
X-Gm-Features: AclHuK8StpvJM4uG8WzP41Ya8StQaTFXp8VlAXPbuSDUD4TGpgKBY4uJQ8Dd7qc
Message-ID: <CAM0EoMkiAH_qnPARiXx9en-r=x2=w2sxNO2TWSmyG_LKJKx2cA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/5] net/sched: act_api: report an oversized
 action dump instead of silently truncating it
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	victor@mojatatu.com, p@1g4.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 5:15=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] The patch has no Fixes: tag for the old silent-truncation path in
>   tcf_dump_walker() (`index--; nlmsg_trim; goto done; return n_i`).
> - [Low] The new comment above `return n_i ?: err;` in tcf_dump_walker()
>   (net/sched/act_api.c:625-630) does not match the code or af_netlink's=
=E2=80=A6
>

Since all feedback on patches 1-5 are nitpicks on commit log or
comment I will not be making any changes unless something substantial
shows up.

cheers,
jamal
> --
>
> net/sched: act_api: report an oversized action dump instead of silently t=
runcating it
>
> When an action does not fit even into an empty dump skb, tcf_dump_walker(=
)
> now returns -EMSGSIZE with an extack instead of 0. tc_dump_action() now
> passes the walker's error up instead of returning skb->len. Before this
> change, "tc actions ls" silently left out that action and every action
> after it.
>
> Closes: https://lore.kernel.org/netdev/vPFrhbkwAui8zFPcGQTUDazQfsFDlr5GYu=
aYQ5BxJcrDiT6x1EljEze4cYadHqbeUW2ivLdpa8eC_cXC6ceACswgb-lW47aSVkHvHjhn_X8=
=3D@1g4.org/
>
> > That case is reachable inside the gate entry cap this series adds: a ga=
te
> > entry serializes to 36 bytes (40 with the gate-open flag) while a dump =
skb
> > is clamped to SKB_WITH_OVERHEAD(32768) by netlink_recvmsg()/netlink_dum=
p(),
> > so the top of the range the cap admits installs but cannot be dumped -
> > and, before this change, fails silently.
>
> [ ... ]
>
> > This is a long-standing silent failure, not a regression, so it
> > is net-next hardening.
>
> [Severity: Low]
> Would a Fixes: tag for the old silent truncation path in tcf_dump_walker(=
)
> be useful here, even though this goes to net-next?
>
> The commit message ties the trigger to the gate entry cap in this series.
> The same truncation can also be hit without the series. act_bpf_policy in
> net/sched/act_bpf.c allows:
>
>         [TCA_ACT_BPF_OPS]       =3D { .type =3D NLA_BINARY,
>                                     .len =3D sizeof(struct sock_filter) *=
 BPF_MAXINSNS },
>
> That is 32768 bytes of ops, which is more than SKB_WITH_OVERHEAD(32768).
> So a single classic bpf action can already be too large for the dump skb.
>
> Leaving out Fixes: may be on purpose, because the patch turns a silent
> success into an error and is kept out of stable. If so, could the commit
> message say that the problem is not limited to the gate series?
>
> > diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> > index fd7f60e0f62ba..33dba34364541 100644
> > --- a/net/sched/act_api.c
> > +++ b/net/sched/act_api.c
>
> [ ... ]
>
> > @@ -626,10 +621,21 @@ static int tcf_dump_walker(struct tcf_idrinfo *id=
rinfo, struct sk_buff *skb,
> >               if (act_flags & TCA_ACT_FLAG_LARGE_DUMP_ON)
> >                       cb->args[1] =3D n_i;
> >       }
> > -     return n_i;
> > +
> > +     /* A positive count means the skb filled up before this action wa=
s
> > +      * complete, so netlink retries it in a fresh skb. An action that
> > +      * does not fit even in an empty dump skb (nothing dumped) must b=
e
> > +      * reported as -EMSGSIZE by netlink instead of ending the dump.
> > +      */
> > +     return n_i ?: err;
>
> [Severity: Low]
> Is this comment right for every path that reaches this return in
> tcf_dump_walker()?
>
> A positive n_i also comes back when the idr walk finishes after dumping
> every action. It also comes back when the loop stops here:
>
>                 if (!(act_flags & TCA_ACT_FLAG_LARGE_DUMP_ON) &&
>                     n_i >=3D TCA_ACT_MAX_PRIO)
>                         goto done;
>
> The skb did not fill up in either case. After a normal finish there is
> also nothing left to retry.
>
> The second sentence says -EMSGSIZE is reported "instead of ending the
> dump". In netlink_dump() in net/netlink/af_netlink.c, a negative return
> with an empty skb fails this check:
>
>         if (nlk->dump_done_errno > 0 ||
>             skb_tailroom(skb) < nlmsg_total_size(sizeof(nlk->dump_done_er=
rno))) {
>
> It then goes on to netlink_dump_done(), which sends NLMSG_DONE with the
> error and extack, and the dump ends. So the dump still ends, but now with
> an error instead of silently.
>
> Could the comment be reworded to match the return contract that
> tc_dump_action() now relies on?
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-H19Z.v3.r0.20261012193813%40mojatatu.com
