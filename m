Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5803D3EA962
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699284; cv=pass; b=kngad0TbOPtFgIGWFw79Al31c9qWBv82t8WGoWjsveO32LTz/i8EPWbuVxo1MvIXiCO4iICJ0iUG6xSlDaodGvcf0+dfcETmM17MT3FHJfS7FwCTjvMcLRSr2QskdKusvam8zCKWooZXyK5z2yAmWmjPsDLQth6SCHzOS2Omm5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699284; c=relaxed/simple;
	bh=lXfmELO/7PZ7oBXe67A0EMQSp4+r63/OPxeRO1Ngv5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rh55crfue6xq+YZDYaigBz4HIKPSOqV//qnYQKjo5t1XEqv8lwOiOEaINwKsIZMbzUR1xIVup2OMkAVw+Xalt5UisTm8jAFWK19Z31HKY2r8tNinW6VSZAHyh8c7ERMK6OMa35zNaDQdT0o38aM3HB5f7MspY7ctJjsc6ZWslo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=REf0SQln; arc=pass smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="REf0SQln"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-936623c6dd3so109548785a.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 02:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786699282; cv=none;
        d=google.com; s=arc-20260327;
        b=GsAGgLlcEt6XZUOomMpghHeoClwR0favn99DjmI2xPzHtrdLVSIKpIBs4pNlIyIDMB
         vQAyZHfoa+swXG+JVuLrbijZ1cCZhYkZOQnne1YDwk77KOjUQ7qxjsZCc3JsCyuYyM9p
         wpmSTuObj6H3EZdhMJtkSnTHPzycv0wwJVkWaUh0/V/81ZCyjzsD9UC2psCKtsTiLqqT
         +qHTABRwnXGr85K2T8+urZbVJMWPM5anWzOtl83WcTAqFJxQoQufYhcC9+Y8TOuBlB9I
         gQXXOd2HCWAvcNkpnXEckHYphRbMkYJWt30x1lnPx1wNFeqZ/vgJAs9xdYz3awxetcR3
         rHsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rObNXmlTuhc+SL0meo9wZpwM61ekcfdlcH56//udPhQ=;
        fh=GWXFY8p0Z/ZpiLeMmy2yP3CU9cyaNffcGtDWJndzY8g=;
        b=C+dr/INCQ2wEN6B7kmnDKXzu8cIrawOf+C2O9/OcCXNUgmOopzmK0yLZTnRPu38vX0
         IT4Mp1pnaEKkCwAGLqDQ4w/TpSZkjWhusbLKaR9LmQ3px9p9TWcQNOWhPJ3bDMBLDGdr
         EtE0SyHpSrEcZP02353vqXLHfctlSArEwzMEA2vHif3kIlwP9KWdMs4oryykOmaB+2Eo
         /p+Oo6hs80w+JNsetfwoYnbTZ2znkQaksbPjzTBnadcMAyBNEZEAQClI8K8tDBup9ZYI
         lyTIDcltHQhA3flhFYvAt9SFnaXNZQVvpv3pxm9D9erjNhThKtQIVOJIWoIz9Wg8/j9F
         alpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786699282; x=1787304082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rObNXmlTuhc+SL0meo9wZpwM61ekcfdlcH56//udPhQ=;
        b=REf0SQlni5m8QWeWrPIRed39G4oXYmyX5G63+KzayrlHEe16pDqWp4ifrhMYiTrr8R
         qxQc7Dm7yzQiiMs68M01+Xe7aEOL584e4s0IxT2U/pYTwDu5qLTEch/adFVsdxG9LluZ
         2wWxoDmqwqRXdSDfHGJv8ewiwbGigdfKnuMGl/N0bJGA3esv44UrWizRID5/QjkKx681
         T9e7nCdYoETsy92Eno0woBmp9Cq0cTbM1PEt/hw3VDkJ83CFF8S+KadMlBRD56h5gsfr
         xE0hF949vUjaC1KbTOT03CbhHaVE9/kSx4cODCTTbrYOc1qWLW5nCUP36oo+c/2ENh/v
         9ISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786699282; x=1787304082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rObNXmlTuhc+SL0meo9wZpwM61ekcfdlcH56//udPhQ=;
        b=REdgi0e4zxr/CYa3IMPNOM5eE7tl6W7QFDk5aLom1glc6+LPz/ZCL/9RYqUeuemkVp
         C+CL/hj0zPKzY5JnerQ3vkudf4sxOy8yhFNMPlRzNJeisMP0z9nTY4lAPfKrSr60YNrS
         yNqQxDRFvJlQ5Jog2FqdEG4gRtkx8au9Vw5lgtnZPCr0vq9Wgx0gTFTj9Qoqrrnd+PV3
         YrNU4zGX3a7pkPbkteg5nOTI23PDMzygoyPWGTLDo02OzoHQ9BnArMeHDAMbKkmapBey
         ugxg0ErsUkLfuHcJK+UlH0zVLv7z4FREGJKS5xWEcV1/VHdKwxMGIY2SNTG9CzalqEx8
         buVw==
X-Gm-Message-State: AOJu0YxFsofrRyz0gE+bIzZizIxPe9xUfrr7YKXufUowtuo8l7RO12Co
	WvQrebjQECAJRQCFuWEhNZXHkIx+xCWNrtt0ZTFKQDH851sROCO74HGiBI/fgPH1kQaHRVG+nrv
	WAVPo1SME+s96gjvZhOC7/WnP3GuCOKBhepXVSzgc
X-Gm-Gg: AR+sD10pIgy2Isa8CSY7inYv6LTl0J8E60Fg2t/Xe0JQ1qB41d+pnI2+cjwPDyl720R
	zBG+bOZxVwS2Dd1M6MrY8HQYDdjbdCrAHtAyK4WhTPBrdGY3xOcoZbwQtTi3KktjcB6K4EUKPzm
	HemrH+yPjHInQZAC9agd2adPyjBoawEDzAR+I5g9TGtlI24A9R46xHtU8D1nODWdjzWgJ5iAVEf
	Ui3CCm7VsZ5Kn5geXWaLtN3wZ4TqODO0s89Z7OlHtQZIAjUFrYZL8vdcJ2rbDThrWgijeCLv2qk
	zaHEtzEOdCQ4uLInco3IYXcsIfaCDybuys3rhHgXO2LsuU0UvaWhccbrf07ZT2f3HLKtBvnrtF+
	QKGGT9PjPCHPXhnWv7vjcDwe9q55/Pd7CLj6QXrak4+FNCPdg1CaK83G1pnMbXs6fFZX8GUdvq/
	D/p29DgLpVYdYG3b8=
X-Received: by 2002:a05:622a:1b0a:b0:521:103d:9f98 with SMTP id
 d75a77b69052e-52d850ce28cmr46441141cf.19.1786699281238; Fri, 14 Aug 2026
 02:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814063545.225896-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260814063545.225896-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Aug 2026 11:21:09 +0200
X-Gm-Features: AUfX_mw0Ojuncyiog0XDrkAZjw6T_PDVv47fixWZUbEgokQ9gmLxkLk5ylhJuLY
Message-ID: <CANn89iJ-2Z5eFZKRAWS_MxVosr8Xe76k-P2djBX+JVfsH57heA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: advertise TCP MSS from the configured MTU,
 not the learned PMTU
To: Jiayuan Chen <jiayuan.chen@linux.dev>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 8:36=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> The MSS a host puts in its SYN tells the peer how big a segment it may
> send us. Right now we can shrink it with a PMTU we learned on our own
> send path, which is the wrong direction entirely.
>
> On asymmetric paths this bites - think DSR load balancers, where the
> request side goes through a smaller-MTU overlay. We learn a small PMTU
> going out, then advertise a small MSS, and the peer stays capped for the
> whole connection even though its path back to us is wide. MSS only shows
> up in the SYN and never grows back.
>
> On symmetric paths we lose nothing by dropping it either: the peer runs
> its own PMTU discovery and usually already knows the real path MTU.
>
> So work out the advertised MSS from the configured route or device MTU
> and ignore the learned PMTU. Our send side is unchanged, still clamped by
> tcp_current_mss(). Add ip_dst_mtu_configured()/ip6_dst_mtu_configured()
> and use them from the two default_advmss() paths.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>


LGTM, but this probably needs Fixes: tags and should be sent to net tree.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 164a5e7ad531 ("ipv4: ipv4_default_advmss() should use route mtu")
Cc: stable@vger.kernel.org

I added the following packetdrill test, please add it in a series.

commit f0c619ca446b669c48b5c2e2c78e23af1a0850b6
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri Aug 14 08:12:32 2026 +0000

    selftests: net: packetdrill: add tests for advertised MSS with
PMTU exceptions

    Add packetdrill tests for IPv4 and IPv6 to verify that the advertised
    MSS in SYN-ACK is derived from the configured interface/route MTU,
    and is not shrunk by learned Path MTU exceptions from previous
    outbound connections.

    Signed-off-by: Eric Dumazet <edumazet@google.com>

diff --git a/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv4.p=
kt
b/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv4.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..f2ef931b77a1c50e77b7568c7f0=
3d10002be4152
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv4.pkt
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Test that IPv4 advertised MSS in SYN-ACK is derived from the configured
+// interface MTU (1500 -> MSS 1460), not the ICMP-learned Path MTU.
+
+--ip_version=3Dipv4
+
+`./defaults.sh
+ethtool -K tun0 tso off
+`
+
+//
+// Connection 1: Learn PMTU exception (MTU 1200 -> MSS 1160)
+//
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
+   +0 bind(3, ..., ...) =3D 0
+   +0 listen(3, 1) =3D 0
+
+   +0 < S 0:0(0) win 65535 <mss 1460,sackOK,nop,nop,nop,wscale 8>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) =3D 4
+
+// Send a full 1460-byte segment
+   +0 write(4, ..., 1460) =3D 1460
+   +0 > P. 1:1461(1460) ack 1
+
+// ICMP Fragmentation Needed arrives indicating next-hop MTU 1200
+   +0 < icmp unreachable frag_needed mtu 1200 [1:1461(1460)]
+
+// Local host retransmits using the learned MTU 1200 (MSS =3D 1200 - 40 =
=3D 1160)
+   +0 > . 1:1161(1160) ack 1
+   +0 > P. 1161:1461(300) ack 1
+   +0 < R 1:1(0) ack 1461 win 0
+
+// Close connection 1 and listener
+   +0 close(4) =3D 0
+   +0 close(3) =3D 0
+
+//
+// Connection 2: New connection from the same peer
+//
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
+   +0 bind(3, ..., ...) =3D 0
+   +0 listen(3, 1) =3D 0
+
+   +0 < S 0:0(0) win 65535 <mss 1460,sackOK,nop,nop,nop,wscale 8>
+
+// Verify: SYN-ACK MUST advertise configured MSS 1460, NOT the
learned PMTU MSS 1160
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) =3D 4
+
+// Verify: Outgoing transmit MSS is still constrained by the learned PMTU =
1200
+   +0 write(4, ..., 1460) =3D 1460
+   +0 > . 1:1161(1160) ack 1
+   +0 > P. 1161:1461(300) ack 1
+   +0 < . 1:1(0) ack 1461 win 257
+
+// Clean up
+   +0 close(4) =3D 0
+   +0 > F. 1461:1461(0) ack 1
+   +0 < F. 1:1(0) ack 1462 win 257
+   +0 > . 1462:1462(0) ack 2
+   +0 close(3) =3D 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv6.p=
kt
b/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv6.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..c7638b11a815b20f70c08a894fe=
d9a65f12327f4
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv6.pkt
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Test that IPv6 advertised MSS in SYN-ACK is derived from the configured
+// interface MTU (1520 -> MSS 1460), not the ICMPv6-learned Path MTU.
+
+--ip_version=3Dipv6
+
+`./defaults.sh
+ethtool -K tun0 tso off
+`
+
+//
+// Connection 1: Learn PMTU exception (MTU 1280 -> MSS 1220)
+//
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
+   +0 bind(3, ..., ...) =3D 0
+   +0 listen(3, 1) =3D 0
+
+   +0 < S 0:0(0) win 65535 <mss 1460,sackOK,nop,nop,nop,wscale 8>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) =3D 4
+
+// Send a full 1460-byte segment
+   +0 write(4, ..., 1460) =3D 1460
+   +0 > P. 1:1461(1460) ack 1
+
+// ICMPv6 Packet Too Big arrives indicating next-hop MTU 1280
+   +0 < icmp packet_too_big mtu 1280 [1:1461(1460)]
+
+// Local host retransmits using the learned MTU 1280 (MSS =3D 1280 - 40
- 20 =3D 1220)
+   +0 > . 1:1221(1220) ack 1
+   +0 > P. 1221:1461(240) ack 1
+   +0 < R 1:1(0) ack 1461 win 0
+
+// Close connection 1 and listener
+   +0 close(4) =3D 0
+   +0 close(3) =3D 0
+
+//
+// Connection 2: New connection from the same peer
+//
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
+   +0 bind(3, ..., ...) =3D 0
+   +0 listen(3, 1) =3D 0
+
+   +0 < S 0:0(0) win 65535 <mss 1460,sackOK,nop,nop,nop,wscale 8>
+
+// Verify: SYN-ACK MUST advertise configured MSS 1460, NOT the
learned PMTU MSS 1220
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) =3D 4
+
+// Verify: Outgoing transmit MSS is still constrained by the learned PMTU =
1280
+   +0 write(4, ..., 1460) =3D 1460
+   +0 > . 1:1221(1220) ack 1
+   +0 > P. 1221:1461(240) ack 1
+   +0 < . 1:1(0) ack 1461 win 257
+
+// Clean up
+   +0 close(4) =3D 0
+   +0 > F. 1461:1461(0) ack 1
+   +0 < F. 1:1(0) ack 1462 win 257
+   +0 > . 1462:1462(0) ack 2
+   +0 close(3) =3D 0
