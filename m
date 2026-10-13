Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFA14D7D4D
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889444; cv=none; b=QnPiwIwHRJHYY2b6BZOy4wOteJImq3yIIk7193+zo7CPUISTGOYMKmn3zCBjF8ypIOoQhFP4ELtitM5px7j/SBT1dCvzzXp1JKukcB2ozh3k3ybQaOZTwXqCvmwU3K5mN0zyQHbzhQbfpVJbjvP8mqv2m3diECOyP9PW75ePd8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889444; c=relaxed/simple;
	bh=8GSkqv4QkypO8QEdwNJ18XjMvc3FQG9h1rQ/XxOiJzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXDWNx3MitTYeuW0sgA1OKZCMnw9pmUmMTOfDRV+68Ju1rGZS21Q1Ja1iniidvrrvivMmx+ebJqKLaE87deSzwaV3WtR2UF8IOV8zpWi8fu4FsZqsDXc8xPgwjApZmfqxGQIuGtZhRhbtyLlCTxGbKmN2SEq4McTHvKO3ydHCyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=df/QEOvb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="df/QEOvb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E1B1F008A4
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 11:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791889439;
	bh=OFGX5cEcAGBVSLbwo2maF4cGWaEpCppHx8j1Z1dAgsU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=df/QEOvbs4t983peDjJplnAehJS+fMIGucqMzKEPdXxnz/HoaZj6CfGdW2QkCbruP
	 wLRm2odoCoew55dk6ljH7IzoDl6uBCy0t7BXD0G333QUKz/RQzOZ5THLocDZINmO/H
	 6GAtbVic+iMSLIVRRH9WBe6vEhQjiKV+fmVvFda3qxxqssYPZiXEOzSC2jDOfhsfiP
	 6jCeZM3Pq7ds2OyNg5kW0vKWbyWiE++j1l2Clp5x+xUcmfrHIOS8c1c72N7LztPo//
	 C1X4lOimJufVnjPV4tnxJ5zIjZIBWTeci6jcxYXK0z2Vnr3LzAyTDbRn0p3AhwO5os
	 vXcQFtQCS9HMA==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6de1ca1b05aso1813351eaf.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 04:03:58 -0700 (PDT)
X-Gm-Message-State: AFq9FYLbBTH3JFjvvwm8ynUXg2/sPmQn/f6I5ft1UWxhoLYzvMPfBRBA
	9kgnDgbYN3rHuJmIHfjHAE59azzvNrTgIzhQR8BXQSlIrrp/LYiIWOAvv2mxJdGLtV6BCR8uLqZ
	Aq1/cZfAK7D+En7CZ2b7v9oAvCJaes3M=
X-Received: by 2002:a05:6820:2004:b0:6c9:80d8:a1ea with SMTP id
 006d021491bc7-6ef0eebcb40mr9815909eaf.39.1791889437993; Tue, 13 Oct 2026
 04:03:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013102453.3272620-1-her@sorah.jp>
In-Reply-To: <20261013102453.3272620-1-her@sorah.jp>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 13 Oct 2026 13:03:46 +0200
X-Gmail-Original-Message-ID: <CAL4WiirpDVzho606z1gt5=1=MFykgTC2CbqdAkxnngSvBYq_Qg@mail.gmail.com>
X-Gm-Features: AclHuK-WFlJ1I9lONTIdZBdj4iMjAgmdTOTDfsQ6amGBjyKepy2t-6ptu-IiQkg
Message-ID: <CAL4WiirpDVzho606z1gt5=1=MFykgTC2CbqdAkxnngSvBYq_Qg@mail.gmail.com>
Subject: Re: [PATCH] net: gro: don't chain linear parts larger than gso_size
 into frag_list
To: Sorah Fukumori <her@sorah.jp>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, lixiaoyan@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 13 oct. 2026 =C3=A0 12:25, Sorah Fukumori <her@sorah.jp> a =C3=A9cr=
it :
>
> skb_gro_receive() chains an skb into the frag_list of the held packet
> when its payload cannot be attached as page frags, i.e. when its head
> is not a page fragment and still holds payload.

>
> Fully linear GSO packets come from generic XDP. When the program does
> not support frags, netif_skb_check_for_xdp() linearizes any nonlinear
> skb with pskb_expand_head() and skb_linearize() and keeps its GSO
> metadata.

On Tue, Oct 13, 2026 at 12:24 PM Sorah Fukumori <her@sorah.jp> wrote:
>
> skb_gro_receive() chains an skb into the frag_list of the held packet
> when its payload cannot be attached as page frags, i.e. when its head
> is not a page fragment and still holds payload.

[...]

> Fully linear GSO packets come from generic XDP. When the program does
> not support frags, netif_skb_check_for_xdp() linearizes any nonlinear
> skb with pskb_expand_head() and skb_linearize() and keeps its GSO
> metadata.

I think the problem is a bit wider than what is described here.

skb_gro_receive() also reaches the merge: label from the head_frag
branch, when the frags do not fit:

if (nr_frags + 1 + skbinfo->nr_frags > MAX_SKB_FRAGS)
goto merge;

A GSO skb with a page frag head holding more than gso_size bytes of
payload is then chained in frag_list as well, and the BUG_ON() in
skb_segment() does not care about head_frag.

It seems an XDP program with frags support in generic mode could
get there: skb_pp_cow_data() builds a head_frag skb with up to
about one page of linear data, the rest in page frags, and
skb_copy_header() keeps the GSO metadata. Two such 64KB packets
can not share a single frags[] array.

Have you tried this variant with your reproducer ?

Your patch handles it anyway, since the check is done at the merge:
label, but the changelog should mention it.

>
> Fixes: 5eddb24901ee ("gro: add support of (hw)gro packets to gro stack")
> Cc: stable@vger.kernel.org
> Assisted-by: claude-opus-5-5
> Signed-off-by: Sorah Fukumori <her@sorah.jp>
> ---
>  net/core/gro.c | 4 ++++
>  1 file changed, 4 insertions(+)

Please use [PATCH net] in the subject for fixes.

The fix itself looks good to me, thanks.

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
