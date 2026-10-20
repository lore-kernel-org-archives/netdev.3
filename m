Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494497;
	b=yEsUxKimKc1ZhWJ13p87N1JJ88z6cm6qAhMWtn+Op/V/u2xYxZ5vXOTw8++Qir28uqEP
	 1IYM0fUAM6Wvenv/q1WxSrPdrajL83LF3JyLWC0//xq56PY8NOtfGNjVexeXQch6R7kH6
	 odxH70SJnEjT7IBb8pQvmYcyBB+yLMeONiZhbZximtEIkZwbmZPD6uSkrJVwl/n/SBNcl
	 NShB50TrLKlt54CygfxQ52guMPQSQzLY5Us7uDScAwRZkbWo+9sMCbgZ/tFW4mLNXzTDW
	 1S10YVN1OX2aefaXktJ/02zSCdieB2fio8kOT8P1+76JHaEBrP9h087SDFnpMgCESoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494497;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=+MPvARj47HCVGhjUnIZjgzZG31iUhRgTte5+8aYlMzs=;
	b=1NRzgithlMs3/A/to3vLyEk2rl4K+idJoasA0iirtWaHw1WyLJ9tCbVXRqKn2uiTUtyB
	 knyyQPd4jSFpJGzq0XJseVl2K+V7TSZf1uyCW5xWN1stUXZGZijC/HAyeRfyqOJ3Dk0H5
	 /KZqmvjq6KnmsNRXoTLByAgF4rlccW8qrLLhiFjzCyODXQDO1YLbpvTv/om0ZqSmLTgQk
	 gg2JLVPSvc/PhN6KM/kEBKzUQU6k93SzL8ZI0P89ZMiAP43DjQlwm5tFxdkXepACytMC+
	 7LL24KE80zC6fCi64o62tjVRNcyIicWRNGUVs+VT+UweDM/mWByrfnVYvD6v+7SuxPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Wj/3XTeR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F67E606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wj/3XTeR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CE01F000CC
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 11:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792494496;
	bh=+MPvARj47HCVGhjUnIZjgzZG31iUhRgTte5+8aYlMzs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Wj/3XTeRqxS0dDNL2uU0rRlNC8xqIFZSlncoHvRWymtSIOfM9jXACNmb5sEhBeCX7
	 DlPhlWTyhgqZh2+lnwzEYWUgUJZkLiSF8M6svL9aVk1OxC4KdIwOFMO8iKUJMvsRkC
	 dD2XXRHige879lbI3+q/dNPDdtv+Hvqfbd1O4P5NS1jTPhH2ksz4OIlsktoXAlx+xc
	 iyG66wRT7vxnGV1Y/u0oSTosTeAkV/eKHauLtn0uVlffP9npzLFl/c9acHQAka3/Le
	 DRUSSVHHzuW977orftmj94MPVaEYI6xY1hFLy7w5epiugch1NjB3BdQGoQ8K0hmGLb
	 osAsktNAQaoGw==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-704597ef1d8so910868eaf.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 04:08:16 -0700 (PDT)
X-Gm-Message-State: AFq9FYKHjb51L0MGxORfxzER/lxnD0QGghd+K+PfHOxVcrdj55HStSsL
	LF7cI0mUwBS1nbUMmW+9ccHWzNB8GbLbZXFAQvXwg2gGxKGF6vwyquJc4zYtsEWJ/7T8hK3EV9F
	D8Oz2cfITUxUR1nuqCcckTeSOCTMXnig=
X-Received: by 2002:a05:6820:83c9:10b0:700:dac:ba64 with SMTP id
 006d021491bc7-7035749a792mr5044552eaf.71.1792494496133; Tue, 20 Oct 2026
 04:08:16 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020104852.90350-1-tung.quang.nguyen@est.tech>
In-Reply-To: <20261020104852.90350-1-tung.quang.nguyen@est.tech>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 20 Oct 2026 13:08:04 +0200
X-Gmail-Original-Message-ID: <CAL4WiirCHqF4ihcvQud-e_FYj_75zOsQ1tQDLpA6Ua3FTQPfDA@mail.gmail.com>
X-Gm-Features: AclHuK8mnxg0rdW_vqGV07mfQR95vj72bOrF9erH1bBFnWmX-acyz9HxkNbjds4
Message-ID: <CAL4WiirCHqF4ihcvQud-e_FYj_75zOsQ1tQDLpA6Ua3FTQPfDA@mail.gmail.com>
Subject: Re: [PATCH net v2] tipc: fix refcount panic in tipc_rcv() when
 receiving shared skb
To: Tung Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, jmaloy@redhat.com, horms@kernel.org, 
	tipc-discussion@lists.sourceforge.net, 
	syzbot+0017742620a9d06f06ef@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 20 oct. 2026 =C3=A0 12:49, Tung Nguyen <tung.quang.nguyen@est.tech>=
 a =C3=A9crit :
>
> TIPC assumes that the received skb is not shared with other users.
> However, syzbot reports a bug triggered by receiving a shared skb:
>
> ...
> RIP: 0010:pskb_expand_head+0x135a/0x13a0 net/core/skbuff.c:2308
> __pskb_pull_tail+0x111/0x1870 net/core/skbuff.c:2890
> skb_cow_data+0x2ed/0xc50 net/core/skbuff.c:5398
> tipc_aead_decrypt net/tipc/crypto.c:892 [inline]
> tipc_crypto_rcv+0x346/0x23d0 net/tipc/crypto.c:1843
> tipc_rcv+0x4b7/0x1040 net/tipc/node.c:2119
> tipc_l2_rcv_msg+0x2d9/0x470 net/tipc/bearer.c:669
> deliver_ptype_list_skb net/core/dev.c:2533 [inline]
> ...
>
> The root cause is that local delivery hooks in the kernel (e.g.,
> deliver_skb()) may increment the skb's reference count (`users`) before
> TIPC processes it on ingress.
>
> Fix this by copying the shared or cloned skb to ensure exclusive ownershi=
p
> before passing it to tipc_rcv(), as TIPC needs to modify the skb's data.
>
> Reported-by: syzbot+0017742620a9d06f06ef@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D0017742620a9d06f06ef
> Closes: https://lore.kernel.org/all/20261018145928.58317-1-ngocthang2710.=
1999@gmail.com/T/
> Fixes: 6e967adf798a ("tipc: relocate common functions from media to beare=
r")
> Fixes: d0f91938bede ("tipc: add ip/udp media type")
> Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
> ---
> v2: Fix typo in function comment of tipc_skb_unshare() and call
>     skb_cloned() to ensure exclusive ownership as sashiko's feedback
> v1: https://lore.kernel.org/all/20261019050648.287309-1-tung.quang.nguyen=
@est.tech/T/

skb_share_check() is the right fix here, as in Nguyen Ngoc Thang=E2=80=99s =
patch.
The BUG is BUG_ON(skb_shared(skb)) in pskb_expand_head(); a clone has
users =3D=3D 1. skb_cow_data() already handles cloned skbs: it pulls
everything into a private head when skb_cloned() is true, which is how
ESP works.

UDP skbs are never shared: ip_rcv()/ipv6_rcv() already call
skb_share_check(). So the udp_media.c change is not needed.

Testing skb_cloned() and calling skb_copy() makes TIPC copy every
packet while a packet tap (tcpdump) is running, or on multicast UDP
delivery.
That is a big regression for no gain.

If some TIPC rx path writes headers in place on a cloned skb
(tipc_msg_lookup_dest() looks like one), that path should call
skb_ensure_writable() or skb_unclone() itself.

pw-bot: cr
