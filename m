Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793161209;
	b=em97dLiu5gBIj2AtW+5ScHqfYRWblbP4630gasDSftNQ4gvP5hzBjIijc8XP+BUp5RpF
	 bXBAUO0gEf+ZPmZoB5F6CxL+M5tHRn7EqL34ZdBpuLhN5IH/ubDs2Iw1ZbxonqO11Kkty
	 c9C6/f7VdKOL/FjHMKN//GgA9x85U9S89CSHJzBp7O9eEzBuCTu0GcHCBAd43TqGEwhzK
	 MrZ201IUWTiRV/Z192M0ox7gNEG+gEJXx+rLwaBWwiCtyHr4NY/SPMwr+Vvh24MBbQlTn
	 4cDJQjDz+/EwKF9ntm7asjCUZoVhYKQwcp4TbIbWTV87NJ7biVSDI3nKF50vfH6C6uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793161209;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=PBfTcptKL7ZV7GFYsN4j65oeFCNvwQ6dD7ynScjA2Hc=;
	b=jSoz18hrzodTOXO2JAya9wQX956fPoEyA2YbyB8z106SRfS4MGc/sRabfhNJ87rNE2Q3
	 tnw906+y7X14iB/57nWvUui/Hqo8A4P3qPYHEzfYhIAhjmI87eJ9o7qSiN+LBgWWlRIeq
	 Mx9WT8kQXrQcqd0usAdGwCHQ4kqlIhZyt2Hlu/l2qmavllCwhc9iOEXSWJfEVtSsDlCdo
	 FWD/aeT0sy8d6vjm7nPa6l+K644azpNVsBWbxxUNv8p2mtG/XLVOw3Ptuo0KQ5WVmk0w3
	 Ctzu9HEq2QKus7rciJQuBZyxzAUwqQYvxjEc8sBDiHCzh6YbfiNrmSlTA/x7kcyJMug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f1T3inZ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A27606A31F
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 04:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1T3inZ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C05B1F01828
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 04:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793161208;
	bh=PBfTcptKL7ZV7GFYsN4j65oeFCNvwQ6dD7ynScjA2Hc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=f1T3inZ/bh5i+mEPRCSuQdukppUm3k7Fkf5cq3ahZQGoi4nmnU1MDPZNbseE1vNbB
	 OBI5UwF8g8qcrXtkuqgh+vgsJwm5fPvvBVYzKj/BA//eBVy3/I8am3BCkVWo3VbFCT
	 WFNC1c8XI9FuxuTo5RHmqBij8SSAKUDjvaVMUkL3exDLh7G9X5E3mRCexrTG14pj4M
	 rr8V3e649H5FYmH3cOEpa8SCqj6HWVJteYk8d4LCEQwt+409t2cpTDpc5qspnKaA6M
	 qYdcizgqsuubIvDOgTw8sRm+4beWJX++kg8THAqGHlAszE61/5J2/BMc2xq7HAnszD
	 jthjV1kOPjOJw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-49ddddefadbso258700fac.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 21:20:08 -0700 (PDT)
X-Gm-Message-State: AFq9FYLpNe64FcZtabozbGVvwomQkYPSspo9fbaaEUFMzdggub2+Z78t
	w4yKbHfroovPSNUww5ALqhXmpbBdhVsyVAM8MvMvFao1WDtg8SPMGd7Z99cjpmKskWOCg7YxMaz
	R6ZIgqYLRGPW0didpoSuhlropOxl91PA=
X-Received: by 2002:a05:6870:65ab:b0:4a7:4ac3:882a with SMTP id
 586e51a60fabf-4a8bb1964a7mr1171647fac.6.1793161207923; Tue, 27 Oct 2026
 21:20:07 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <tencent_8E712A089353754DE5DB35DD0BAAB0AB9606@qq.com>
In-Reply-To: <tencent_8E712A089353754DE5DB35DD0BAAB0AB9606@qq.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 28 Oct 2026 05:19:57 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiqg-NnJ1Rz6=ZbdDoe6vZj9VBtBpD0jy576aE8BKj1j7w@mail.gmail.com>
X-Gm-Features: AclHuK9fiqOkbP2JrxQlMkT9Qz_-0ptMydfVgETJ500iTDPKPZ22wbbanhu96pA
Message-ID: <CAL4Wiiqg-NnJ1Rz6=ZbdDoe6vZj9VBtBpD0jy576aE8BKj1j7w@mail.gmail.com>
Subject: Re: Subject: [PATCH net] ip_tunnel: reload inner IP header after ip_tunnel_encap()
To: bo cao <treebacker@foxmail.com>
Cc: netdev <netdev@vger.kernel.org>, davem <davem@davemloft.net>, kuba <kuba@kernel.org>, 
	pabeni <pabeni@redhat.com>, dsahern <dsahern@kernel.org>, horms <horms@kernel.org>, 
	idosch <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 28 oct. 2026 =C3=A0 04:21, bo cao <treebacker@foxmail.com> a =C3=A9=
crit :
>
> ip_tunnel_xmit() and ip_md_tunnel_xmit() cache the inner IP header
> pointer at function entry and continue using it after
> ip_tunnel_encap().
>
> For GSO skbs over a FOU or GUE encap, ip_tunnel_encap() calls
> iptunnel_handle_offloads(), which calls skb_header_unclone(); when
> the skb header is cloned, that calls pskb_expand_head() and moves
> the skb head.

This can not happen.

All callers of ip_tunnel_xmit() and ip_md_tunnel_xmit() already call
iptunnel_handle_offloads() (ipip_tunnel_xmit(), sit_tunnel_xmit__())
or gre_handle_offloads() (all ip_gre.c paths) before entering
ip_tunnel.c. For GSO packets, this performs skb_header_unclone()
before inner_iph is read.

Nothing clones the skb between this point and ip_tunnel_encap(), so the
second skb_header_unclone() done from fou_build_header() or
gue_build_header() is a nop, and pskb_expand_head() is not called.

The SIT bug fixed in f0e42f0c4337 was different: ipip6_tunnel_xmit()
was reading iph6 _before_ its own iptunnel_handle_offloads() call.

> A kprobe on pskb_expand_head() with stack traces recorded 74019 hits
> in 8 seconds of flooding, every one with the tunnel xmit path in the
> stack (frames: pskb_expand_head <- ipip_tunnel_xmit <-
> dev_hard_start_xmit <- __dev_queue_xmit <- ip_finish_output2 <- ...
> <- udp_sendmsg).

These are the expected pskb_expand_head() calls from
iptunnel_handle_offloads() in ipip_tunnel_xmit(), unsharing the clone
made by your AF_PACKET tap. This happens before ip_tunnel_xmit()
is called. If the head were moved from ip_tunnel_encap(), you would
see fou_build_header() and ip_tunnel_xmit() in these stacks.

Unless you can show a path where the header is cloned between
the caller's offload handling and ip_tunnel_encap(), or provide
a KASAN report, this patch is not fixing a bug.

Also, please avoid "Subject: Subject:" and base64 encoded mails;
see Documentation/process/email-clients.rst

pw-bot: reject
