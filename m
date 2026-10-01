Received: from mail-qk2-f38.google.com (mail-qk2-f38.google.com [74.125.230.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4757151B161
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790876043; cv=pass; b=Zw2vJ4ZQLkkdkpYFQX23SBB68ghH7ZXNC2WwdFqxdIE4qp1QNkgWgk/xjEnZP4VKjkyITyfqZ9xL0pyJX+hzfSTdKvrHD86SNs6NulBPkamRpR6MNlCvCVGV60VBi7U8hKSxShp9fB5dV1JnL8ygvieiSNlpcbX4s+N7hgaggm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790876043; c=relaxed/simple;
	bh=XTPHyNpkIg3intR2ToRuKta4v5mywdIHwxwZkfEGHcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2Ssof6/vbMvDzyn0bvI3rEWYank5+pvFZnp0cQR21WZxzJ0JmWANNTVBilCkqiuV/S4DEK4/C759Db9e95RDmzu7O5IhNMuRKgSyknD0ZhTPDf9uDxyIiuvJQ9gEEIfcPA3jDr8gUF+T3AyWj9CuEMFC+JXD/MtzOOWIghzN9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=igyt/Sj4; arc=pass smtp.client-ip=74.125.230.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="igyt/Sj4"
Received: by mail-qk2-f38.google.com with SMTP id d75a77b69052e-5333729ca3dso54246831cf.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 10:34:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790876039; cv=none;
        d=google.com; s=arc-20260327;
        b=M7OSzeULf/h4pH6Y/WaIssy6KpExlIYi03wEF5Any0dO73k6daJOyhBVfkqEasXgav
         iprYYDy4pLx9Z+WZjb+6vkCJ9cregK4j1HgdMr2gdrm+Fym0Xgm/9G0z/TUWvUA4vFe6
         /08tEaNbDXjliLgFwFUNa9KlF280lVo5vK/TAkxy13xHbMT6i/wJI/cJghBm4ttZDk4f
         wSU7SsIGSGUMTpIbU8z+1yEyLdRecEf14E+BcsdCxjaa7Ld+QWouwh9gA7pkW09i6sfc
         uy4R8PFIoznm8ITpQntVobDEC99QAH72yp2SxacyyAE8f7DLGM1B1AYbzWvIjy+pxMcN
         jlsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rZegayNvtB7RwxbTDi4gq3UQ0bAyEHxezk9umWpRSM8=;
        fh=Pe70YxA3AlJ9ZmdYN303qbX6sQrWBfk8mDG1NWhyL8k=;
        b=o/PZ6DqlJAiklDGrlreoMu0Iq7/3HIOW1qk0eVTq3CZYzIzUI5frSyx2XII4uaSHnR
         CptuR0ANomsR4pztHv70Ap/y0sITNOyWddzVseuFfNLlMinmJ77O/Z5e98UJDTrHFPN8
         se632bgGZ2s+l/oCBLhr+vVDjAN40NKMAKDBWc65ZyGf2GmPgM8JoNs3577lyJyYMIzH
         oWdMguXJwsQNTzj1d8/2tXe8tZRPDLwu/Tctr9dn8jOl02ODfAWAoYBsVO/PAHxIHd36
         dgXtrUzFpvrmXGjZAbzSgr7R8jzJfW77nTwOCfVkr1yECUFkd6KaSYmPOPMFaLIh4Yaq
         9XYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790876039; x=1791480839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rZegayNvtB7RwxbTDi4gq3UQ0bAyEHxezk9umWpRSM8=;
        b=igyt/Sj4UIsiTP31FxFMpELMGURCiaIcvHN4uBhm8E5xBEfGsO+UNPZkezljSzMQb0
         kKquHOpbanTwZdpK12C4Op6Def0JEIAhoVZ3A80IKUnpZwl1LJfjGrYYYthRBO/ITloT
         8aD2ikUIR1wTr+w43qtYS04qFoF7VynA+5iehLyDeMbrsmJcx+FNvUE5yBo5mWoXdjH8
         cdHzZjTNbgpS6CzuNJS0dqw3T2in6Epo41iRDPxkjcO86KZYdlA47s7bRgtbwQpkFU9b
         I7+iSO85cp8UwBGPYTzHrPCc8Qe7T4GdjswzkgBD7AAtu8jlTVniXg3HIBpNgrkX1efq
         LPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790876039; x=1791480839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rZegayNvtB7RwxbTDi4gq3UQ0bAyEHxezk9umWpRSM8=;
        b=RKNZ68++ycxKn9ORAcd0i/ucQopevKFPJza2kRidki63AIgTvLUwgt3ExqlMrcVnur
         Kqn/U7W90FFB4IYweqBalmdssjf4FzHK6cFwZ3IU6I9imkypnpY8048crvPm02UxVf9V
         5N2pD5qR8IAdJQMgS0fJNMgIxBo39tp7KQeMCypsi+nBb7gvIiWgebL0Ilaw52aH7RVu
         QOeZnhq6/EJ4Dt4MbvmA1Sa2Ir33Fjy1lIDmXkeXRkrmm2K781dyt7mkoTjoogCS+v5U
         qmrYzXciPKTfaOoUj9/9LIu5duWKn4HtClNyi/wbidCfBdWorCKlBtytwhH4AVuEnuJk
         iM3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwaEcEu7hwD6v/yyvatzpocfpLvgXRTY8dDxeEofhFP2nUl3b3e3opkqVZljhD+1yrbha+0Mbk=@vger.kernel.org
X-Gm-Message-State: AFuF++mHaKA4XacPdzEE7KmkjMgiB7lw6VVipnwvbPR7OCtXu16PSPjf
	xtNhfeZ83Nifc5XIJAcg5TOsQZRMl+I4GMYd6TV6JXGKLqT7iZLU3kFW+TDvsL5Sy+jbdBRgH/G
	7YGQ19L3y35WZvFY25+o+didnOL11+QqyU2V9JWv7
X-Gm-Gg: AYBFou30QwA4wRb1PR8hAEG0e21jmLOLlnAoA2AFJ5L1hw36LwPm4OAfdRgw9qkVKX9
	ZNP4aDPsH55Nh8uPq6mjCi5atXqiwgxV6nCfKdDPlDBv+qmp4jFyxjRAGVsyR3+gR1YMCsaS+UR
	wzayxafw0yufVa60MrB8s1dNKeIJ59Zc+ir9F5j/iple6Ak/uq7qXNUWdQvgoO9AqdbmLSEkuyp
	BqXBZDdWwAErhdpTphi57Z8SMdPNxEI4/xcOR17L6tkW69BK92qS/y4YxaFsMGMUcVOKVDZUL50
	8wYmrzG/axwUB3wlO4Ev6wCaJIN31Zmg51ICiNcHVI0SioMTK7PC8R9+z+HtqcpuIoyrYVGjLkH
	a+etwKU3IE+mYYU4H5zb+MRlUQqHZJNZdW+Vg4j4aaSVavAvTQnucw2QPUDsFPaRW7Wcl
X-Received: by 2002:a05:622a:48f:b0:532:465f:e55b with SMTP id
 d75a77b69052e-533742ccacemr106682251cf.5.1790876037401; Thu, 01 Oct 2026
 10:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001171016.88208-1-omar@blockcast.net> <20261001171016.88208-2-omar@blockcast.net>
In-Reply-To: <20261001171016.88208-2-omar@blockcast.net>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 1 Oct 2026 19:33:45 +0200
X-Gm-Features: AclHuK_oiEZTE99RbOt6tFGLxURDomBVmQyySDJXmfiM9o1zVNPn32IyRt2gr9k
Message-ID: <CANn89iKErdqHOGFpQLM_MAi-LcAaR6ZR2_rhdtZzv1TJc2L4RQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] amt: mark relay data as a UDP tunnel packet
 before sending it
To: Omar Ramadan <omar@blockcast.net>
Cc: Taehee Yoo <ap420073@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 7:10=E2=80=AFPM Omar Ramadan <omar@blockcast.net> wr=
ote:
>
> amt_send_multicast_data() copies the multicast packet, puts an AMT
> multicast data header and a UDP header in front of it, and sends it with
> udp_tunnel_xmit_skb(). Unlike the other UDP tunnels, it never calls
> udp_tunnel_handle_offloads(), so the copy has neither skb->encapsulation
> nor an SKB_GSO_UDP_TUNNEL* bit set. If the copy is a GSO skb, the lower
> layers see a plain UDP_L4 skb that has an outer UDP header in front of
> it.
>
> A GSO skb only reaches amt_dev_xmit() when tx checksum offload has been
> turned on for the amt device (it is off by default, in which case the
> core segments the packet before ndo_start_xmit), for example with a
> UDP_SEGMENT sender on the relay. The default configuration is not
> affected.
>
> Call udp_tunnel_handle_offloads() on the copy, as bareudp and geneve do.
> The AMT header and the UDP header are pushed after that. Two details
> need care:
>
>  - udp_csum is true, because udp_tunnel_xmit_skb() is called with
>    nocheck set to false. The GSO checksum of the outer UDP header is
>    then completed for every segment, which needs
>    SKB_GSO_UDP_TUNNEL_CSUM.
>
>  - amt is ARPHRD_ETHER (amt_link_setup() ends with ether_setup()), and
>    amt_dev_xmit() pulls the Ethernet header without moving the mac
>    header. skb_copy_expand() keeps the mac header relative to the data,
>    so, going by the code, in the copy it should sit 14 bytes before the
>    inner IP header. The tunnel segmentation derives the length of the
>    outer headers from inner_mac_header - transport_header, which would
>    then be negative. I did not measure either value; what was observed
>    is described below. Reset the mac header on the copy before the
>    inner headers are recorded, so that inner_mac_header is the inner IP
>    header, as it is for the other tunnels that have no link-layer
>    header.
>
> The call also changes what a plain, non-GSO datagram looks like when it
> leaves amt. iptunnel_handle_offloads() sets skb->encapsulation on every
> skb and clears it again only if ip_summed is not CHECKSUM_PARTIAL. A
> CHECKSUM_PARTIAL datagram, which is what the stack hands to the driver
> with tx checksum offload on, now has encapsulation set where it had
> none before, so netif_skb_features() limits the features available for
> it to those in hw_enc_features, and udp_set_csum() takes the local
> checksum offload branch, which leaves the inner checksum to the lower
> device. The other UDP tunnels do the same, but the selftest does not
> cover hardware checksumming of such a packet: the egress device in it
> has tx offload off, so skb_checksum_help() completes the checksum in
> software.
>
> This follows the suggestion made by Eric Dumazet on the earlier
> [PATCH net] "amt: do not offer software GSO on the amt device", which
> this replaces.
>
> The problem was found by an LLM-assisted code review of
> drivers/net/amt.c while developing an IPv6 outer transport for amt.
>
> Tested with the selftest in the next patch, in a KVM guest running
> net-next at commit eb0c18404c89 ("amt: pull the AMT header behind the
> transport header in amt_parse_type()"), x86_64, CONFIG_DEBUG_NET=3Dy, AMT
> built in, eleven runs per kernel of the final selftest (22 guest boots,
> two at a time on a busy host). See the next patch for how stable the
> selftest itself has been. The sender is a local UDP_SEGMENT burst
> of eight 1200-byte segments plus a 100-byte tail, 100 bursts, IPv4 and
> IPv6 inner traffic, with "ethtool -K <amt relay dev> tx on" and the
> relay's egress device doing its segmentation in software:
>
>  - Without this patch, every GSO skb (9728 bytes for IPv4, 9748 for
>    IPv6) reached amt_dev_xmit(), none of the 900 datagrams arrived at
>    the listener, the tx_dropped counter of the relay's egress device
>    went up by 100 (one per GSO skb), and nothing was put on the wire.
>    A function-graph trace of one run showed __skb_gso_segment() on that
>    device failing with -EINVAL, from __udp_gso_segment() under
>    udp4_ufo_fragment(), and the skb being freed in validate_xmit_skb().
>
>  - With this patch, all 900 datagrams arrived intact in every run, one
>    AMT message per segment was seen on the wire, none of them larger
>    than the MTU, tx_dropped did not move, and the gateway counted no UDP
>    checksum errors. The trace showed skb_udp_tunnel_segment() doing the
>    outer segmentation.
>
>  - With this patch minus the skb_reset_mac_header() call (two runs, with
>    an earlier version of the selftest), the packets were dropped in the
>    same way as without the patch, and DEBUG_NET warned in
>    skb_udp_tunnel_segment() (pskb_may_pull() with a length above
>    INT_MAX). That fits a negative header length, but the value itself
>    was not printed.
>
>  - With tx offload off (the default), and with non-GSO datagrams with tx
>    on, everything arrived with and without the patch.
>
>  - The existing tools/testing/selftests/net/amt.sh passes with the patch
>    (discovery, IPv4 and IPv6 forwarding, and both torture tests).
>
> Not tested: hardware that offloads UDP tunnel segmentation or the
> checksum of a CHECKSUM_PARTIAL packet, a forwarded UDP GRO packet as the
> GSO source, NETIF_F_GSO_FRAGLIST, KASAN, and the udp_csum=3Dfalse variant=
,
> so the choice of true rests on reading the code and on the patched runs
> above being clean, not on a failing false variant. sparse was not run,
> and the existing amt.sh was run only with the patch, not on the
> unpatched kernel. Only the IPv4 outer transport exists in this tree.
>
> Assisted-by: LLM
> Signed-off-by: Omar Ramadan <omar@blockcast.net>
> ---
>  drivers/net/amt.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 0277e4cac..1f0afc11e 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -1078,7 +1078,18 @@ static void amt_send_multicast_data(struct amt_dev=
 *amt,
>         if (!skb)
>                 return;
>
> +       /* amt_dev_xmit() pulled the Ethernet header without moving the m=
ac
> +        * header, so the copy's mac header sits 14 bytes before the inne=
r IP
> +        * header. Make it coincide with it, as the inner segmentation co=
de
> +        * expects for a device without a link-layer header.
> +        */
> +       skb_reset_mac_header(skb);
>         skb_reset_inner_headers(skb);
> +       if (udp_tunnel_handle_offloads(skb, true)) {
> +               kfree_skb(skb);
> +               return;
> +       }
> +

Okay, but the changelog is far far too long.

Changelogs are for humans (LLM do not care much) and should be shorter.
Also note the use of the 'Suggested-by:' tag.

Something like:

amt_send_multicast_data() encapsulates the multicast packet in
AMT + UDP + IP headers, but unlike other UDP tunnels it never calls
udp_tunnel_handle_offloads().

If tx checksum offload is enabled on the amt device (off by default),
GSO packets (e.g. from a UDP_SEGMENT sender) reach amt_dev_xmit()
unsegmented. They are then sent with neither skb->encapsulation nor
SKB_GSO_UDP_TUNNEL_CSUM set, and the lower device drops them:
__udp_gso_segment() fails because csum_start does not match the
(outer) transport header.

Call udp_tunnel_handle_offloads(skb, true), as other UDP tunnels do.
udp_csum is true because udp_tunnel_xmit_skb() is called with
nocheck =3D=3D false.

Also reset the mac header of the copy before recording the inner
headers. amt_dev_xmit() pulled the Ethernet header without moving
mac_header, so inner_mac_header would point 14 bytes before the
inner IP header. That makes tnl_hlen negative in
__skb_udp_tunnel_segment().


Suggested-by: Eric Dumazet <edumazet@kernel.org>
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
Testing notes (selftest results, untested configurations, ...) go here.
