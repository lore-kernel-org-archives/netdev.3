Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9D023D7FF
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786280381; cv=pass; b=oEi0oFyfdGuAU3Bhh5nTOuRTDbbox9Q6OzLv8lCSOAVjb+mWjU8i73EMKXbmiNQPdyCqepxyxe69B2TcD5R2nig1t0tktf372t/Scd6LLIoc2lfWmhcH+nZq4fojMfU7fhMpAGUWwIOKE2t4meokPskvRJtWKrpl6p1gcsS31eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786280381; c=relaxed/simple;
	bh=3L0ZF/7dfxXcSJbU5aV3faHbKcMpb9CkQ8sDpRdANBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNNXJGJXi7AelaMFWki7c4WbvsluDv8quvX8UbEq/ugocdMGfiEzwpdJfnuxJB8ALC9byl+5xq219Wl42e/57Ho9KQSS1nrgZ7VmXtsjhaI3sxHQQyb3CpZ2VjkFXDHFD2BDT8sk4DpxVVo18BI8blMY4XTRGpDLmVJl6EhjRCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ib7IejpC; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ib7IejpC"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-45133d2974fso596827fac.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 05:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786280378; cv=none;
        d=google.com; s=arc-20260327;
        b=bRSoZpGGL7WECFP5VGuesWIXi4BCR2TQmjvOhTG0q6Jh4vxItiovYkcZ8TWvUzcWjd
         PTL5G9/JYuxX6iaHdxDx9W1n+zZKZdukcoSZCHWcsFmI9urNVKIM/jfE73adIWbhlDK6
         u8uQKim537vFfSfkhqs3DH9NS7KiIQroUXbHAAcDKXlXfGijQELbzt/DgrLQz887wwFl
         /WbQCCJ3pVyHaEKwr+xsqC0p3qFpUhyaEc3jsr5v/+R0/Wys+Tix0h2hwh7TcnxFDklf
         wCKCNHWqQOYfX3wfhJIw3nGafkDN1XEvOjcTgmL4ABieLpmWeeGt7/zGh0nRV3w7o77I
         qN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dD5DXGYtjcqP9wY75fVsWhx+gPCCNV7US4H4nIQJ0fg=;
        fh=+n5Hn/Rzd/w9PSE31ZMQCFUqwrTi9IE+sYtH2t3vX1o=;
        b=qhtrfWyyo/9+XNsB4uR8ipQ3uRQeb5RJgZ2s2wJZJbIM+baxGquuB9fXEBpHuYaKtf
         0buz2LPBR34GdVDhBhBn1KMgQEakGK0MfsxDhs1W85LtQ/ShRWfr4CT6fsBAq4/TxgsS
         O50Ex9TvnyGhPTC7Tt7ZF1O5eCoRP2IkOcBW5QoYbTvKzxtQGhRSNRE8DJIX8xATpBhq
         IZZ4s6dYNBpc71cdOScERJYh+n4ZgSJQR2N8Og/OtlZIxa46UKSBmkN8yfg0twtDbLtX
         AQnEH4+7/00+mMUsGkob+bkwpf3xWyHUD5jc9w/8PFYJ+mzaCvY+5pyrSHzvWS2o2hzf
         B9MA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786280378; x=1786885178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dD5DXGYtjcqP9wY75fVsWhx+gPCCNV7US4H4nIQJ0fg=;
        b=ib7IejpCWPElKpOGP3O3SMrWCHyJp6khBkz/UImfbnsDPcSyBsnPs79SaBX6ff7jpn
         NCB+VgKox68EM3sspFG87SFgyCZUy9kqMgZWUIaZ3EH6KifRseu9Cx9WvnNPEs86c1sr
         EkoprGI096DCxKs6U2tGJcd6/BPnYyFIvOguDR7KBcTjUZ7l4GPCXzJIFlkYTzY2akR5
         HHVGWfj2j1fBB1oLOMkr2DkZDlshtkOBxgvCWPLLq3nJw4ER+cE4WgseMsfJdwwxEajZ
         QwkvEPBgweZcsnJrv7BBizqU5iHspBa42QGetO2epPCNR8pCa+eyaTlaf+CcjBFhc7m2
         jAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786280378; x=1786885178;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dD5DXGYtjcqP9wY75fVsWhx+gPCCNV7US4H4nIQJ0fg=;
        b=BvwTsV1h+d0Se3/Ped3PlCNLKRY83B8EyEQsvARcBAmykO9f4RIDyW1Y03A4HIN6L0
         oMVBQrGDJfx8kZJHpp8UKI7AGa6i+zpUM79xJCp2YvRmG8Gydbfi37WhcIe1BT0Aq4Ge
         d6Wc3RKe3q9HwmiCvwNJ4Fua+Q0MTgo3+dHKqnNob0ujQrXM8b07xQ+y4S9sVTFpOKqf
         fzXJ8n48VRKFgW+dIBbZ91vOfrEqfjgpV0YxVLjaOtz5Y4wLU78Svsw4DTq25OrZYeOH
         UluCU3dFynDUbsT865tikyMxzlvIbDD64MXx0Id0sg+c2TFJzu6E0WfrwpVDNUahegNF
         VyRQ==
X-Forwarded-Encrypted: i=1; AHgh+RrORiX24YJBv8ApNZ4V1IVUww8wianPNOzpui4Bi5xc6rrifTZt2xmBO5J3K9HacoJMH17OM5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YygA9otJFwdzmii2LVUA2EV8MXU73eP6ZMQUWRBF6/KHnt0ritu
	cAR1be14yXz+FjW0y20v0SIxPbaWZf8/MCoeEAepwKYIHr504RiMSwKssk0dGE7YZKn29LBRTKa
	x/bhaaiH5d6FRBvrvJvzbbqPQ2W4J2Gs=
X-Gm-Gg: AR+sD10cJECETYthbHvGhDiuCfRHJymeDIZnbM2pjngnPSylKbxt0d0RvYwoNI8UFxl
	vifwoe+z+slAGtrZIKs1gKUh8Gup3vlSl/Hl7bbqMDxWORwpo8yEOkXktVE5o7t03f5V3pbDR6u
	6XZMeZ0bY0YiwSwIHsDYTgrDtnFqyAxFTMZCpSUhbrq+1lKYntbkrdUy4mvcdocQF/Gkg7ipvkh
	He1hiwz0PPeQap1dzlWSFzQCuz9qCfcTCgo3A3VCwkOw/yjQHCqzT6+u+lNK7qVwdXf8ijDfszF
	Wpm70AmSc0gdc2Aon1k7TsrxHJPyZUOYl54551Fk7mExp8j552aFr9s8nw==
X-Received: by 2002:a05:6808:1984:b0:4ab:32ea:95f6 with SMTP id
 5614622812f47-4afae09eff9mr22790743b6e.13.1786280378503; Sun, 09 Aug 2026
 05:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807020326.2519445-1-kuniyu@google.com>
In-Reply-To: <20260807020326.2519445-1-kuniyu@google.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sun, 9 Aug 2026 21:59:26 +0900
X-Gm-Features: AUfX_mybovaPH7hdCY7ZczSB_6jKLgrSO-Q4aDy7YBjU6la9lHyQLBhNC1CBZTA
Message-ID: <CAMArcTWHRtRVi0HthfsytpCLfC-E5UdoaR1DuzgcdZhDyKcfLA@mail.gmail.com>
Subject: Re: [PATCH v1 net] amt: Don't support cross-netns setup.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 11:03=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>

Hi Kuniyuki,
Thanks a lot for your work!

> When a lower device is unregistered, amt_device_event() tries
> to unregister its upper AMT device, but it has two problems.
>
>   1. amt_lookup_upper_dev() looks up an upper device in the
>       lower device's netns only
>
>   2. amt_device_event() unregisters a single upper device only
>
> If AMT device is created on a lower device in another netns,
> removing the lower device triggers the splat below and gets
> stuck until all upper devices are removed. [0]
>
> The cross-netns setup seems unintentional considering 1. and
> the following points:
>
>   * amt_link_setup() sets dev->netns_immutable to true
>   * skb_scrub_packet() is not called in the fast path
>   * iproute2 binary fails to find cross-netns lower device via
>     link-netns:
>       # ip -n ns1 link add amt0 link-netns ns2 type amt dev veth1
>       Cannot find device "veth1"
>
> Instead of supporting it properly and preparing for per-netns
> netdev unreg, let's forbid cross-netns setup.
>
> Note that the problem 2. needs a separate fix.
>
> [0]:
> WARNING: net/core/dev.c:12518 at unregister_netdevice_many_notify+0x1cce/=
0x2250, CPU#48: ip/2031
> Modules linked in:
> CPU: 48 UID: 0 PID: 2031 Comm: ip Not tainted 7.2.0-rc5+ #27 PREEMPT(full=
)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian=
-1.17.0-1 04/01/2014
> RIP: 0010:unregister_netdevice_many_notify (net/core/dev.c:12518)
> Code: 89 ef e8 d5 52 ae fe e9 d0 f4 ff ff 48 8d 3d f9 3b 9c 02 48 c7 c6 c=
0 0b 63 84 ba ab 1f 00 00 67 48 0f b9 3a e9 65 ff ff ff 90 <0f> 0b 90 eb 81=
 48 8d 3d f6 3b 9c 02 48 c7 c6 c0 0b 63 84 ba e2 1f
> RSP: 0018:ffffc90004abf160 EFLAGS: 00010212
> RAX: ffff888104d38260 RBX: ffff88800b0911b8 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff85b9f880
> RBP: ffffc90004abf2d0 R08: ffffffff85b9f887 R09: 1ffffffff0b73f10
> R10: dffffc0000000000 R11: fffffbfff0b73f11 R12: ffff88800b091d08
> R13: ffff88800b091178 R14: dffffc0000000000 R15: ffff88800b091000
> FS:  00007f555b86c600(0000) GS:ffff8881942a0000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000562107d489c0 CR3: 0000000109a40002 CR4: 0000000000372ef0
> Call Trace:
>  <TASK>
>  rtnl_dellink (net/core/rtnetlink.c:3632 net/core/rtnetlink.c:3674)
>  rtnetlink_rcv_msg (net/core/rtnetlink.c:7112)
>  netlink_rcv_skb (net/netlink/af_netlink.c:2556)
>  netlink_unicast (net/netlink/af_netlink.c:1319)
>  netlink_sendmsg (net/netlink/af_netlink.c:1900)
>  ____sys_sendmsg (net/socket.c:775)
>  __sys_sendmsg (net/socket.c:2738)
>  do_syscall_64 (arch/x86/entry/syscall_64.c:63)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> ...
> unregister_netdevice: waiting for veth0 to become free. Usage count =3D 7
> ref_tracker: netdev@ffff88800d7496d8 has 3/3 users at
>      __netdev_adjacent_dev_insert (./include/linux/netdevice.h:4525 ./inc=
lude/linux/netdevice.h:4554 net/core/dev.c:8791)
>      __netdev_upper_dev_link (net/core/dev.c:8879 net/core/dev.c:8963)
>      netdev_upper_dev_link (net/core/dev.c:9009)
>      amt_newlink (drivers/net/amt.c:3321)
>

Reviewed-by: Taehee Yoo <ap420073@gmail.com>

Thanks a lot!
Taehee Yoo

> Fixes: b9022b53adad ("amt: add control plane of amt interface")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  drivers/net/amt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 182a41d59a75..7645ce3a29ad 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -3221,6 +3221,9 @@ static int amt_newlink(struct net_device *dev,
>         struct nlattr **tb =3D params->tb;
>         int err =3D -EINVAL;
>
> +       if (!net_eq(link_net, dev_net(dev)))
> +               return err;
> +
>         amt->net =3D link_net;
>         amt->mode =3D nla_get_u32(data[IFLA_AMT_MODE]);
>
> --
> 2.55.0.679.g6767b8d81c-goog
>
