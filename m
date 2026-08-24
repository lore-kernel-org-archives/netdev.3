Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEF83A450C
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567065; cv=none; b=j1Q4WhJAIzZ3Fl5G7IDjxEj/MWIRVl5pIl4sPQlU/lwqg1cMIs/VtDsXDbhQL3yFOjz4s8ThknAfb60gCFVho+clTiqBCro0Q2Lm0+u+CNi2834hI6I+oNbfzDdqVBsHkceoINmVb2d53waCgwuJztaQ/MnYQ6YF2YFnmPi14EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567065; c=relaxed/simple;
	bh=hK7rux6N0iIt+halku1q3Bl60yvEov2mmXE1eiDHWVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mA0eJSNi3LeMmqM9pf3mgQGNaRF/0PheH8yPQ02CyRz9Re6PlVNlGLDRinQQpAwFAXjF2scIcyxOJN26ejjl7LI6bJ7dn2G4SwNHkDeTapDpd0mn4CqclMQVY520eiA/aTsG0Fox+2oTnqUbMccIXla4li+vFh90o2WqwXNBi5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dnim.dev; spf=pass smtp.mailfrom=dnim.dev; dkim=pass (2048-bit key) header.d=dnim.dev header.i=@dnim.dev header.b=mOxlazhe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HlPLZqLV; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dnim.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dnim.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dnim.dev header.i=@dnim.dev header.b="mOxlazhe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HlPLZqLV"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id A9E9EEC010E;
	Mon, 24 Aug 2026 06:24:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 24 Aug 2026 06:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dnim.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787567062;
	 x=1787653462; bh=hK7rux6N0iIt+halku1q3Bl60yvEov2mmXE1eiDHWVc=; b=
	mOxlazheBeQ5I/UfpMlDnp8srdu44SrPDRQGYscFxBt1U3uWmjXIn7IfHSdZBTVp
	3gwStQ45UebQdka4rA6Db1nOvUbHLUJ4JcZ1iCfQfyMCPyRtyiEzKfAsfVO71AQH
	dD+49hA4xgaRL+DDY2710zwHH+2hnnNKaby5VHOBmBXGqPLfBcVTedOpOSryNRHf
	WQYJIiHjKVBeWQanQ98Z7k28mGnVVhHeH1MHYkg8tYuQnKwD4TJ+WMwPsWaCYJ3k
	U41H23o1fFSlH8ekNdr5oR11ZbTiwsJE8oI3o+etSocWIChSDk+qW0qxa82J2qio
	NQo9c+hD8kgVYiqu51ZHoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787567062; x=
	1787653462; bh=hK7rux6N0iIt+halku1q3Bl60yvEov2mmXE1eiDHWVc=; b=H
	lPLZqLVlVr8IG4Zy1A3P33d1vHogg4oGi9jTImzKV78EG6o3kFVY98kI9kBTiQif
	EtRdN1IveOFCC4UkApO6/8kb3lW0bLinoHSz8wWmmZz5+/2b3YMTF9wdiDpS5zUC
	kH2H0CB4lWYnRtRcP7yj67f18hpRKSDAWsYM09imYTnGsEGYeQXKG4v3JtobMz90
	Jd6unNCUY4D5x9iXt/YNkSr2pH/a78AONVJJUvk9yQ1PTm80qvgYGDNblKYbJJUb
	16pyZqbxYB05ox7zx9nQkeGoQnRzXryMFiBqD3RZuIQnRHclLreb362is3DehAvF
	EuaeaEoioY+DLkZtDNQYA==
X-ME-Sender: <xms:1huMatL0D919FZ1s3s8lWhqRDJtSD3rDUSd9cCEOTqO3LZm4M5E6aA>
    <xme:1huMao2r0sy6omImzp-QP7KoW7MoA9boFPb_3lXNyk1Y77DrQGFlm6_zSQzZI6AVw
    LQKGi6l61koKIDprmILzwK3iZwYDkSTGJzfRpS4VNcjd5QvWmiUfYLJ>
X-ME-Received: <xmr:1huMahU_SEobTvoifk2DxLJmrXBPNs4sUlkqJuAIdFk7oRRyHn6OlvDo65vBacQKN5naHZ_x8BliZZbos1R-A04nLq7PK-wjFrj9PYqZRmou5VCjd--9YhemzeqCjrfUpMDlKueHMpl-Jnw>
X-ME-Proxy-Cause: dmFkZTErul0IshWG0cEWt2AlQyqUKxpIhsGe2tkxJDZpwx0xNG7zD80p5TIQ01ijD6rPi0
    gV/LNYlnJWuxvMJ6LGEm+GE3uhTtzpQPUQNuszzxiYz95OZn9m0PA5SeDT/3zUreATpFe6
    as+43dYl7mc/k08KKHmcGauF0ZbO5lGaXzvwZQpvxqGChNIQ5dDE868mvzpDx2foDG6MuN
    CGBanZWeVfinoRKt6DjjSZgFURKXTLyS5UxoWbc9WS9zfLlDqFMYfoUiV3bpgnVnEpYUt8
    jUGISoYeUXLSoHpqWzDIqjnaLBvUimwlTiqFyOlVfQzZsIKllmLH69dJKCn6Okd4X+O7fr
    WD8hoqSkvuVBSRavtOtdxV+j25jXaKrq+xL8RuRAnTl81kS3lLy708QvcEVM6UheGTTExt
    8MtDPK5U9iqNiiX+rmKaPLaebn2njLg+CWTmD9X1y0Q/0PdGuvuZYWF+linl52Yc99E1Vx
    h85GfRqEKaFqnRsy3VHMkwb1geqaRpk6ADN9l+i5YiPVPOHtwgYkRSeOgf2fS7QulDYwYT
    s6+1CHaBCaFrWsKtYVtueQLxfRLw18q2q9IRrRY9NTjrGSSV9CXyO/8FI7pjSVxIJ1PqsG
    ijc88LsHfPLU6XRD5XHY+cpw03Hvh1CmPntMrCiS2uZaEysIb/zvRfbEjkXQ
X-ME-Proxy: <xmx:1huMaqP9Gd5lAckq4_7zBrWTHQszJCPh4KPF9bzwg4628X2rcdgQDQ>
    <xmx:1huMak1DGg5aS0A3hBcBVaRNiZ84ODdN3-jxK-Hda2mH4me3Zh-47w>
    <xmx:1huMauTwbDoyjsOu2pRxFi7WTQFmDKkgJ31eE8w3UErIpphdG2LXfw>
    <xmx:1huMavnTMEgwAG8Ebf_h2voeX446271PHd-rZ0eSB1kP2mhAmv8siA>
    <xmx:1huMavxrtc1rDfeEbRQU1MPB1XtYBidd-fMwtYGUjMO4O4d9ArBF_fNE>
Feedback-ID: i14ee4b4c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 06:24:21 -0400 (EDT)
From: JR Lanteigne <root@dnim.dev>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Miroslav Lichvar <mlichvar@redhat.com>, richardcochran@gmail.com
Subject: Re: [PATCH net] net: fall back to skb_iif for the timestamping
 pktinfo if_index
Date: Mon, 24 Aug 2026 07:24:21 -0300
Message-ID: <178756706164.4072964.5948114813697377372@dnim.dev>
In-Reply-To: <willemdebruijn.kernel.150ff949d6753@gmail.com>
References: <178746246095.3786864.2262454553798466512@dnim.dev>
 <willemdebruijn.kernel.150ff949d6753@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Willem de Bruijn wrote:
> I don't mind adding a fallback. As long as possibly passing an
> aggregate (or tunnel) device cannot cause regressions to existing
> users, notably chrony and linuxptp.

I checked both.

linuxptp does not use SCM_TIMESTAMPING_PKTINFO at all, and its event
sockets are opened per port and bound with SO_BINDTODEVICE, so
timestamps are attributed to an interface by socket, not by this
cmsg.

chrony matches the cmsg if_index only against interfaces listed in
its hwtimestamp directive, with the PHC resolved by its own
ETHTOOL_GET_TS_INFO on the configured name. An index it was not
configured for (an unconfigured aggregate) fails the lookup exactly
like the 0 it gets today, where it silently degrades to the kernel
software timestamp. If the user did configure the aggregate, the
value is nothing new either: on kernels without this cmsg (pre-4.13)
chrony already falls back to the IP_PKTINFO/IPV6_PKTINFO index,
which is the same aggregate device skb_iif holds, since
__netif_receive_skb_core() resets skb_iif after the bond/bridge
rx_handler rewrites skb->dev and inet_iif()/IP6CB(skb)->iif report
that device.

The fallback also only fires when the napi lookup already failed, so
the bonding configurations the referenced commit was added for,
where the napi id resolves to the physical slave, are unchanged.
