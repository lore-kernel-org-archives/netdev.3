Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6133F406822
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948076; cv=pass; b=oaHFbiXyp6zcpqMA7r5V4YVb71HGqzbL7c2SPlf7+ZtfNF6WHtceQktvQsZDfKIXtvtjG54trI1eqeM/pMmNFKS1bxXXq8l4is4hvnwfcQYGHPRFRCVbMz/mkFWb92dr5iLbC8RUHzye39d2M9DJWyD5+21xBHgvQGvx0zSEWYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948076; c=relaxed/simple;
	bh=yqM8/JJN+TMh09dbJ080hACMRCJv/LJI5aHCbHF0rAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0wisYRGnj4kCzm5uaUs6Tai94jmlWYmJw8sNvxfgWhZcaWTBtDz/c6dpw8qSdGSGEL992A/eq3O+2adcX35j1AZzOD0UmeW2zqwaHAKohkm3lwn1llnz91Hl17PGYS66pTpOXJic56YBzLOCv9iiTWlmV/x/pWruIrxcTyuTn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=JY8pBvAh; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="JY8pBvAh"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8557c3f270eso3775174b3a.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 03:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788948073; cv=none;
        d=google.com; s=arc-20260327;
        b=qGoVb1bfWRP6zbDvAWKlo4isLVwTYhSk8JYDoDbCw6iEmVoBsh+6bojuKWK9lW2Q0E
         CBzMEaJSu69qOB5XYA9RWQ0s+PJoyU1MW6pZWhk6SEV9gF0fyE68OuLhYRXNyDQw+d4m
         vsdPykNIrScCdSYvP+zwBhel6LaScMIt1MRL8u3IfGZOz5euZCOr9ZJe/dRJ7d70nSgz
         kVoy+zmhhUdUJ4oOKEKdMP1n3gd95dH8xg6dtEJvFUxb2QdIB/cVAkshgc90bZACLeBK
         PIyfCdyFgH0j0o5b/q0rRkyHuouCKa373SWMWrngJecKvtUyA9xASBfm0hR8BPol3OA1
         b6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RuwmPg0I3XqJf+YLYZj9hXGAosc0Co0HZXYre8jKsu8=;
        fh=nob3nCkRMcCXvMrK/1oEL/YnZtpWxKVSqN90v210dtk=;
        b=MLjwOSS7g64PWkQ0nMX62TgxrrUewsC0jkULiJv94YyxUQqoKocYtpcG7ZT2KqN5WP
         6FyTPjFFdqtmnTvkmQAluQrsUUcx4oGJIil1w4S9Hok0Xe6AxPziwqkBKvA1srltaHTe
         6cLyl7SXEJYMY4lY4Knqu5fGGIJRdcRUe7hZ44AAoNKgOk2DH7tMuGYkC0qe/rse/PAJ
         RLD9qtVpUSlbkiABeVPqZRo4RNIqjuJ8ulFwWJdWbKLDWmFrkKu8m+lmUq0ivZ8bvZVg
         X1Udrqv2oNyIGserfggYULtmP9JYandUvc6qp1jzomkhoeOLu2FtBZ7mFvdgioDp+ReC
         MiEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788948073; x=1789552873; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RuwmPg0I3XqJf+YLYZj9hXGAosc0Co0HZXYre8jKsu8=;
        b=JY8pBvAhtO/ZI2jTkXPejg/UXD7TLWa0H30S8VmSob1XYmoTTMeMXCxGLdHAqNTQkL
         +dpulVMK7V3HKEXas3kNnvQmdHS8Baf0VD+W12yCKeU4kjwW207PeduWbxJ6hunvavRT
         AGdz/zQ57t58Kj1i4gbZgHu7bg/JC2szFginY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788948073; x=1789552873;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RuwmPg0I3XqJf+YLYZj9hXGAosc0Co0HZXYre8jKsu8=;
        b=YDrJ8PEh1CKYJG29z5c+a9ruLfsLexJMksXPoNxJAI4ZYSlk8ag4s3K/V5Mlay2QTf
         8FUbDGjblXvOy8PXbHKXYNa0BLzxjiAm7qOLLKy3N0JOIAcpobiCGcRPgamTWFNZfvcU
         OYEcn211RGjwkLCJ/7IsSaTOV2tZXZBiMhrZOqUdlqL7BHGdMipZZO0xUrwxlrVAIn40
         XlNc+qm8Z4jxoEcJ55xLXfWNdIVjlcT05lzHBbK6Yp+Yvu61LD/NqYT06K6N1+7yvhbh
         OFzBo8vEtJ0+1zLm+Tuq5t8urBgLUyy9e4nG0AHnE3NibN/WcGlO2+wahR092COS0I2C
         YOGw==
X-Forwarded-Encrypted: i=1; AKwUvBw9zuvVRv6f2KjJlW669SG956Q14q60mVwzrcDpOA4nGRb02CGSmgb9fojq6Su2VSXqQlAdt/M=@vger.kernel.org
X-Gm-Message-State: AFuF++mOHuDdj1QJoQqcPUHQ4oCI/rDJS4417DaIqn9qJnP19WsfwBXO
	RIxurSC9EsYXBJ2Dqk10L6raP+H1xTiikI8yDtvw/RzTCE/ZictuL7V0jmHnkmo6wFIKZebe3Wp
	mvYvIm3pylmOsLdoGgXCSp9sycU0BbRVBThcBUyHT
X-Gm-Gg: AYBFou1ASfSENlHKcAsS34UQYrg0c7SayvXnMCQ7JV3zj+a4d32JoYp/xjBdJZvJtU6
	puiePPrGixCbdw8Ke15CWZTolPj77Je1aVl40wKxxjh5OEE6/zAIVGOWzy34bpFt3UX2eeol6wv
	RJigBekJl/FH+1v5WFUtramcpIsvcFdp3QoaraEDsquJgUF4I+vlTebWFjQJGcQSRGKyRCebFEJ
	kbFLC8KOh7IU4nI9d0qumTseDgK535bm7fbtALPMt9gvzLA5odyv4VminIg/mVB/cW3rXV2baOI
	2LwBBlxNvuxjvpCEVn0GDuiPv/JFI/hcr+qkWGD0CerGZ/AJeIo8tWEmw6sA7QrdQ3a9P7QbLgo
	aVSdXpsnliBfO9l89lqlKR0p7TLJc7ds0ug==
X-Received: by 2002:a05:6a00:8015:b0:857:4dea:e2fe with SMTP id
 d2e1a72fcca58-8616b26f4a8mr49680345b3a.13.1788948072707; Wed, 09 Sep 2026
 03:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908205537.863484-1-kuniyu@google.com>
In-Reply-To: <20260908205537.863484-1-kuniyu@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 9 Sep 2026 06:01:01 -0400
X-Gm-Features: AcwNN1UWQjx_TDz7N1t07GUM1VuUSFgEfZYkDYM7O90m8JlqYfubkJNCW6GnotM
Message-ID: <CAM0EoMnFTMQPjy1kaSmgcaFzRsHHgZAH1zTGn4RvrrEzy62Qsw@mail.gmail.com>
Subject: Re: [PATCH v1 net] net/sched: cls_api: Don't replay RTM_GETCHAIN in tc_ctl_chain().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Taras Madan <tarasmadan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 4:55=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> If a netlink socket sends RTM_GETCHAIN requests repeatedly
> without recv()ing the responses, tc_ctl_chain() hogs CPU and
> triggers Hung Task splat. [0]
>
> As caught in the stack trace, netlink_attachskb() could confuse
> tc_ctl_chain() by returning -EAGAIN when the userspace netlink
> socket's receive buffer is full.
>
> The replay: label exists since commit 32a4f5ecd738 ("net: sched:
> introduce chain object to uapi") but was not used initially.
>
> Since commit 9f407f1768d3 ("net: sched: introduce chain templates"),
> the label is needed for RTM_NEWCHAIN because tcf_proto_lookup_ops()
> may release RTNL to call request_module().
>
> However, the replay logic is unnecessary for RTM_GETCHAIN.
>
> Let's apply the replay logic only for RTM_NEWCHAIN.
>

The patch looks sane.
Can you send me a reproducer please? We are automating and testing of
all tc submissions.

Reviewed-by: Jamal Hadi Salim

cheers,
jamal
> [0]:
> INFO: task repro:1018 is blocked on a mutex likely owned by task repro:10=
22.
> task:repro           state:R  running task     stack:14096 pid:1022  tgid=
:1014  ppid:961    task_flags:0x400040 flags:0x00080000
> Call Trace:
>  <TASK>
>  ? clockevents_program_event (kernel/time/clockevents.c:372)
>  ? pskb_expand_head (net/core/skbuff.c:615)
>  ? skb_release_data (net/core/skbuff.c:1122)
>  ? netlink_attachskb (./include/linux/skbuff.h:1323 ./include/linux/skbuf=
f.h:1332 net/netlink/af_netlink.c:1232)
>  ? __netlink_lookup (./include/linux/rcupdate.h:882 ./include/linux/rhash=
table.h:711 net/netlink/af_netlink.c:499)
>  ? tc_chain_notify (net/sched/cls_api.c:3045)
>  ? tc_chain_notify (./include/linux/skbuff.h:1384 net/sched/cls_api.c:304=
1)
>  ? netlink_unicast (net/netlink/af_netlink.c:1335)
>  ? rtnl_unicast (./include/net/netlink.h:1198 net/core/rtnetlink.c:985)
>  ? tc_ctl_chain (net/sched/cls_api.c:3242)
>  ? rtnetlink_rcv_msg (net/core/rtnetlink.c:7146)
>  ? netlink_unicast (net/netlink/af_netlink.c:1354)
>  ? __pfx_rtnetlink_rcv_msg (net/core/rtnetlink.c:7177)
>  ? netlink_rcv_skb (net/netlink/af_netlink.c:2556)
>  ? netlink_unicast (net/netlink/af_netlink.c:1319)
>  ? netlink_sendmsg (net/netlink/af_netlink.c:1900)
>  ? __sock_sendmsg (net/socket.c:800)
>  ? __sys_sendto (net/socket.c:2281)
>  ? __x64_sys_sendto (net/socket.c:2288 net/socket.c:2284 net/socket.c:228=
4)
>  ? do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_6=
4.c:84)
>  ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>  </TASK>
>
> Fixes: 2ed9db3074fc ("net: sched: cls_api: fix dead code in switch")
> Reported-by: Taras Madan <tarasmadan@google.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/sched/cls_api.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 9966766661d5..c47d2ee13641 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -3254,7 +3254,7 @@ static int tc_ctl_chain(struct sk_buff *skb, struct=
 nlmsghdr *n,
>         tcf_chain_put(chain);
>  errout_block:
>         tcf_block_release(q, block, true);
> -       if (err =3D=3D -EAGAIN)
> +       if (err =3D=3D -EAGAIN && n->nlmsg_type =3D=3D RTM_NEWCHAIN)
>                 /* Replay the request. */
>                 goto replay;
>         return err;
> --
> 2.55.0.979.g7e5102b832-goog
>
