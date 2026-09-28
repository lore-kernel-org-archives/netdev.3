Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13A44EB87D
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612959; cv=pass; b=OwIwRC8NUoD/YIyD62G6nZRdttMZaepb2Odm1dmn6iTkSXseMF1fHkO/TSXybwoMya7CqzXapdmnj5ZTIsMyfBxnQ/L5Gcn/x4Z314WLMp2fHgJypIDAAwNXBUSJ2FXrToDLo9AnIleepgerxZTNDll/St3ksfl4WGkBAIDTg98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612959; c=relaxed/simple;
	bh=5ZpDSiHzrTaSbkIF2sxZryRiGeETjGD1f2Aqdfapuh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TP98BjCRiRSNxgu5obVZ+J6CCnrD3HeN781ZSK1l+unS8c7iwubSqdMoZivq/LGJAy1Nd+9UIv0UBlzgKolCy5UQ1AKBRFMYrvO2vIXbpLamwi/umVX4GeKlog+K5Kqubo+oas3U4qZnTmJgzjAxjmdiYjV2gqhU7FbvNEYPEOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXXRejpe; arc=pass smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXXRejpe"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aaf2ab41bbso403537a12.2
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612956; cv=none;
        d=google.com; s=arc-20260327;
        b=Zfa/CUZtVukd4qCT05h6FeN9qY2UHJ3iLG412QdzAuj/dFtHSCsstTD6Gkj7s3BCyp
         VFoTfK9EoefJ3Nosvq9zMJnBCF/uIKwU+6ldMEtXrqfwpNA0PPTXAq8+UhiuvSvOaV5X
         uwtLkhznLylZfrCmgUnutFGv1alPP6cgRwWFV/3k8xB5K6Wl9iu8N27hil+HDj5uipXw
         Ce7IWjjw+2KiCE8gL/DROP3DaBFFsJQVIXwfZ5KldG3vkz6dMqBDlRI+fpVYIdNBfn/l
         E+CBzfk4RYCI5Xsylo7Qn0V0RgAIc8xvMDJHgaipnlVZ7Ug9sWxkB58v0IJvOB0RXCC0
         aShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7u/ahGnkjID4qDxOKcLNpzkE3Z5UyJkWp4xOghr9HIQ=;
        fh=7DCiy4+ZjLRiIU8BgyzcgwgvOrh1K/f79CsymrIk4FM=;
        b=olglVWv6M7OqJmuojr9qEla6QZqOojFbTDNoyjHwG92XoqETog+n3tZ7FVTQVUjXdj
         NiPirVw/QCw1iRorYkVhS8Q4tDNeK5Ief266g7ItgdYsBMMjyJYFgG9CArRVUkVEoujK
         jd5wt/gIl7PC18AMaZlHRmyxBY0yOkPP/BxLQf5ede2qtHH7/aGE9m/jLnPA3Pjs0UGg
         W1l82ldQaxzfAAs8910KWozm0WZnQmtxxYKQN29he+B3cghvsd+hACJZtTF6B/Y+TFbM
         3I0JlfCXJ+h/q9rbm47CFhmpHHNDTbT/X6m1WuLRMX99UwUVxBtGv8bmHzJzmYr8w1Yh
         uAmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790612956; x=1791217756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7u/ahGnkjID4qDxOKcLNpzkE3Z5UyJkWp4xOghr9HIQ=;
        b=fXXRejpeGUC+lY85LXuepgy4Kaz4eLdKAPBbj7y99OsDAho9h+j2hFkf82620ml7Xq
         JmqAbYlqJA2aDtwLeI9Ed5O8KwKS3piBsRH5qJhcGS61RYJnskfUUjzyBYi9QMbHOP+P
         j/OvSCd4Y+/RMx9sywI44JfdFh5zM/SYepG+88+IB14PUt9dT/3N5qkCCWX4d9tIEtW4
         79h4ACH33bPfuG0A7/IRsn8Je0v5wjsEh0m5lk7WJYipnEFXPEpdH1Ii3t7nERVuSfHE
         8pAA4YITA5cV9QVNCkaau4WWwg6ysDPW1QglxWvscMEWck/kDEJfrCV402q5CiBcSnhc
         pjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612956; x=1791217756;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7u/ahGnkjID4qDxOKcLNpzkE3Z5UyJkWp4xOghr9HIQ=;
        b=jxWdQ79h6YIcpAgcAx1SP1MRrkoHtRbgr3gm8tw8ZDqn+NnxdQYyVeKR8WMSW2jS14
         5dCSYo5j04Fc6823dBRx9fm8HFR5D6eIiH/+hKrDX7aSEiV9rPVD35QbyUTEUwvSB93z
         SKRqwrRJ7C6hXpXtETrKeEaRG51B8iHjBtrCEO7RFMwDmoWAZreoD2jf3JgWELdPMTof
         F8ZRxe9qCIWShbNKlOebZVEEUQ+Sh7ulPB9x6q5i1CfcC1a2uP7lZin69YNIty7Usrcr
         H2h0m+ECT2i1gRX46Ksm3JAgGfNpFgBwkOy2pO8SelfNgSdSfxRvAdsccvqUQtz+CThd
         rIZg==
X-Forwarded-Encrypted: i=1; AKwUvBwyDLB2OdNdzM2PQVqr2N/hzuklmgtvEhBXpz6YXl4D5X+0SX89RrPlmPy6JEs9fvPqGDklHaQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZI+a7LakLg+v9Vq8FOZqkSQL4ILD9h7Sf3FcURJTci6wyINL3
	NCUvAEVbnX5Lz58C7dCWbpmwKDTSBtaJFVLNr+fjYHd3uamemVgWt+KhqfuHTyB8TRrT9Krd1DW
	UeZTpgNQlxg7oUE3I9L2ZBzjagghljzw=
X-Gm-Gg: AYBFou2R9ZCbMkm6/MOvq2RUjfjphHnZ2nJdFy4cu2YuZ+hQMw8svLV8kM4ha6eFIZs
	EbEi0Mso5Wp451tM8N3LsShhxcU3E7HFueob2W+imT49TJohv0wo7pCzUM607jGJTm7nQK2fovZ
	7Y4XK/DJtlc2TRT8LJI43hGL3EdCChKIb5kB10pXJsu+18gvJaqtKUBuwOz8eJMJF38/BEVn5Yq
	9YUZa4NSgwclCzNEgikFmmu1SoHh/mUUBDsF8v1G3MBGlo+7FAgoJhydZCcA4R6oDTpK/RkQhaF
	vxznppWfO9QXfro+Tm4/4sHLuR0Ymfg9uMiuRIQtMDyukO0ldkrZNenJbTWBTSrWDGcIbiaqIs1
	hcqCyfyL/nsM=
X-Received: by 2002:a05:6402:84c:b0:6aa:a78a:6a05 with SMTP id
 4fb4d7f45d1cf-6aae1a75d8amr9224034a12.0.1790612955949; Mon, 28 Sep 2026
 09:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927071051.3693368-1-nicoyip.dev@gmail.com> <20260928123411.GA440063@shredder>
In-Reply-To: <20260928123411.GA440063@shredder>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Tue, 29 Sep 2026 00:29:04 +0800
X-Gm-Features: AclHuK9xxQE8kN3osXvIimBgpn5r9tT9LreAd5Hk603-O6WYi3sMJEJIxrsqcoo
Message-ID: <CAAo+4rU5h6Nr2Biq4WrpfCA4f_OfNabg-D=Pv3Rigu3amZdx3Q@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: Fix device use-after-free in ip_skb_dst_mtu()
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, John Heffner <jheffner@psc.edu>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 8:34=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Sun, Sep 27, 2026 at 03:10:51PM +0800, Chengfeng Ye wrote:
> > When a socket ignores the path MTU, ip_skb_dst_mtu() reads the device
> > MTU without RCU protection. The multicast and broadcast output path
> > through ip_mc_output() can reach this helper without an RCU read lock.
> > Netfilter releases its internal read lock before calling
> > ip_finish_output().
> >
> > A sender can load dst->dev and then be preempted before reading dev->mt=
u.
> > Concurrent device unregistration replaces dst->dev with blackhole_netde=
v
> > and drops the old device reference. After the grace period and remainin=
g
> > references drain, the device can be freed before the sender resumes and
> > reads its MTU, causing a use-after-free.
> >
> > KASAN reported:
> >
> >   BUG: KASAN: slab-use-after-free in ip_skb_dst_mtu+0x634/0x740
> >   Read of size 4 at addr ffff88810921c038 by task poc/98
> >   Call Trace:
> >    ip_skb_dst_mtu+0x634/0x740
> >    __ip_finish_output.part.0+0x22/0x2c0
> >    ip_mc_output+0x287/0x930
> >    ip_send_skb+0x11d/0x150
> >    udp_send_skb+0x63e/0xdf0
> >    udp_sendmsg+0x1235/0x1da0
> >    __sys_sendto+0x32c/0x3a0
> >
> >   Allocated by task 97:
> >    __kvmalloc_node_noprof+0x1d4/0x620
> >    alloc_netdev_mqs+0x81/0x12c0
> >    rtnl_create_link+0xaa3/0xe30
> >    rtnl_newlink+0xabc/0x1f70
> >
> >   Freed by task 99:
> >    kfree+0x131/0x3c0
> >    device_release+0xc8/0x240
> >    kobject_put+0x14d/0x280
> >    netdev_run_todo+0x4cb/0xc70
> >    rtnl_dellink+0x362/0xa90
> >
> > Protect the device lookup and MTU read with RCU and use dst_dev_rcu() t=
o
> > access the device pointer. Keep the MTU limit and headroom calculation
> > unchanged.
>
> This still leaves other potential UAFs in the ip_mc_output() path.
> Better to fix it by adding an RCU read-side critical section in
> ip_mc_output() in a similar fashion to its unicast counterpart. See
> commit 1dbf1d590d10 ("net: Add locking to protect skb->dev access in
> ip_output"). You can blame 4a6ce2b6f2ec ("net: introduce a new function
> dst_dev_put()").

Thanks for the reviews. The v2 patch has just been sent by applying
the method of 1dbf1d590d10 to ip_mc_output().

Best regards,
Chengfeng
