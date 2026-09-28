Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5646E3264C7
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 20:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790626946; cv=none; b=mS7ZTdtielImiCoVk8L04khk86ShSUBERYnOYhnAUUM/+tXrbWmMMesvRNVvcqhIXMvyc9NFHlP/VbmpFbIyVa5GnwfhnfXWx8sNHC/OY3m6RnwT+u3bko+wqk3xMeJi2jj3fbY8GQE0Rg2QcaplzZ302tpCktmdbHzADvQs+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790626946; c=relaxed/simple;
	bh=rj2dlgLEBuOpytzHI5wM5/hxtR3c+DHnPjDvftN2BW4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=nhJtPmlqHcwkADm8o4mMJ8LEQg7AK+Kcrjrna9IP5g/FnyHT+cRRwy5t8oKFV0zzy7wIUvZHGQIsgTa+chtNk3vXYFZm71GqOIZo+JEn1VXQzLW+4bX8yqkJ3CB2AqX9gnNU90Z5DvT0TmS3Ng18sZPMH4K1L8RjLXW0/FLiowo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlD/Fgik; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlD/Fgik"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-89666ee9b3bso26153097b3.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 13:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790626944; x=1791231744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LavvGF05LrUx2mjDIa0wySwJDHWA2NlYt6Sq2WNTH+4=;
        b=QlD/FgikCmSHDUgLTlMAMQpW9S4zgbluHGAADn6Qp1OzElRHVdrQ8+7ZpbzObBPXB9
         RuF6q3jIexCaPApYqdbXxRtOoNrm4pndOnBI2wIdwlbHWH6qwQsHwjLKA08vaxwlkGYZ
         bz9r/XpTB56FdBmsBXBiUBbgOg7wVnv6BXw/WgpJeLNi2skpMqnLfVyALtGk1hbas249
         UPGk+dpT0K5fpACMrQy9byQm4vYqskUrCEA0Kx8cXDNQaGcydzHqp18fwpt4vuty/KTW
         eQAOLfLYpK6AOEm/dW3oAmZAOXHApqf0mQ2LlT+LYFYcGJNx86GesQExBh22t4di+dM2
         J/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790626944; x=1791231744;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LavvGF05LrUx2mjDIa0wySwJDHWA2NlYt6Sq2WNTH+4=;
        b=yaDXvtGVTgPhnKl93sS9oBCwIqWHKOT2Jtu681XFkT+CrhaIOldcUMg/8tNfwiY1VD
         roUJscxKgzJNvgvFGtAJQcCQQ1+iUdyg8ppXCLNTcvg4DpbQTaVvVRZsCIeIGyoNsQRk
         clYrivnZou5/ucVv6x4YKQHoPHO+0wOiUAB/He4yXxF/EAkkr31eFuk8jUj5fIW4QsQf
         U/GrApgihqXSQOjZmHHMHbmtaOYlrzbh/doiBE89+hiZmaw58H+zKnctm2E31UtaxxpG
         yOSePC8T6CoLMdw/5wx3yASO3puTeIkV+2a7HLR9nbFIs2LQxXLme+uYttUxOkWeJPF3
         ZzoA==
X-Forwarded-Encrypted: i=1; AKwUvByKBYr1GQRr6X+zcCls2jIK6DXfBU4g1MlYmBErdKfLSqV3N0HNwHgTSmRtJlFGPdv71gBoNxw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKf2QUqDZMhWQIYL3nnWO7BySorK7JstABYOgWaFFpnqFqCo1I3
	2heOHP3VB/TQ9p19fAd3hZMOd8pHbg4VGG0ZqBureAo8P9vSzngECDZ3
X-Gm-Gg: AYBFou06mAB56bIq3qm+71MakEQsMFEfK/Iw72tKa2/ZY8sfhdsFG6BFwbFPI8N/LD3
	tGwt38CSmFNGrJPy3tdLs2zlwD2Qj4a7Dzs3Bb0CH37U9VZFHqs06IBp3kjI8ah7vkDG5sC6Sov
	iaFJi8iaQcL8mHo+usdlvJGLhRaEV9Xkyo26NnMBaX0WIKMLpj+L8b3csTMvZIH5q87Y9jjWMcn
	xtNxlvytwyUcDORfq/1aThXr6bw4pTjwJ3hAgT9P8AcRyJjtn6gnJ5blKQ+Ck67uAkxaFHySSfL
	5oGM09V4fBsYvJ10+Ev/qDm3TKgf5VSJTEq5n389TPg0ra8bxxK7rw/DZJvOyts5nYgVhAzyX1h
	5AE5qJnEYedVpXTlk9lsNqT0LHMYG+TakdiptZwGX1Oswn0fiKiTtAL6E+fM+4KKdQhDCCfX7Fb
	ZwKyjOifOh0YvX0o4XqeQbd9x4NPlr0wR9YcDCsSGZhcRtZoVh5pKVONDtOAXrk/FnJxPEJw917
	o8U0YqRqpxmoQxxDJTEJ0lkGvUHQ2h0OXmlLTDNADXEs3io3P3w
X-Received: by 2002:a05:690c:c501:b0:8a9:9f40:24e0 with SMTP id 00721157ae682-8a99f4029dfmr32958567b3.14.1790626944148;
        Mon, 28 Sep 2026 13:22:24 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a85ec40be3sm50315077b3.0.2026.09.28.13.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:22:23 -0700 (PDT)
Date: Mon, 28 Sep 2026 16:22:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.100d5c1377db@gmail.com>
In-Reply-To: <CAL4Wiip8iSAYT0NgFgEidvk4TD35aemRNfFVUjAnUoVaqips9g@mail.gmail.com>
References: <20260928144254.3361044-1-edumazet@kernel.org>
 <20260928144254.3361044-3-edumazet@kernel.org>
 <willemdebruijn.kernel.293b4851be048@gmail.com>
 <CAL4Wiip8iSAYT0NgFgEidvk4TD35aemRNfFVUjAnUoVaqips9g@mail.gmail.com>
Subject: Re: [PATCH v2 net 2/2] selftests: net: tun: add test for VLAN-tagged
 GSO without NEEDS_CSUM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Mon, Sep 28, 2026 at 9:17=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Eric Dumazet wrote:
> > > Add a selftest in tun.c verifying that a VLAN-tagged (802.1Q) TCPv4=
 GSO
> > > packet without VIRTIO_NET_HDR_F_NEEDS_CSUM (both flags =3D 0 and
> > > flags =3D VIRTIO_NET_HDR_F_DATA_VALID) is accepted when written to =
a TAP
> > > device (/dev/net/tun with IFF_TAP | IFF_NO_PI | IFF_VNET_HDR).
> > >
> > > Also verify that mismatched GSO types (e.g. VIRTIO_NET_HDR_GSO_TCPV=
6 on
> > > a VLAN-tagged IPv4 packet) and truncated headers without NEEDS_CSUM=
 are
> > > rejected with -EINVAL.
> > >
> > > Based on a reproducer by Michael S. Tsirkin <mst@redhat.com>.
> > >
> > > Assisted-by: LLM
> > > Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> > > ---
> > >  tools/testing/selftests/net/tun.c | 107 ++++++++++++++++++++++++++=
++++
> > >  1 file changed, 107 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/self=
tests/net/tun.c
> > > index abe488bac50bb3b05df5c446836c1c3dfa9ea604..c6afafb7b957360e287=
3640e60a7d580c6564a66 100644
> > > --- a/tools/testing/selftests/net/tun.c
> > > +++ b/tools/testing/selftests/net/tun.c
> > > @@ -9,6 +9,7 @@
> > >  #include <string.h>
> > >  #include <unistd.h>
> > >  #include <linux/if_tun.h>
> > > +#include <netinet/tcp.h>
> > >  #include <sys/ioctl.h>
> > >  #include <sys/socket.h>
> > >
> > > @@ -542,6 +543,112 @@ TEST_F(tun, reattach_close_delete)
> > >       EXPECT_EQ(tun_delete(self->ifname), 0);
> > >  }
> > >
> > > +FIXTURE(tun_vnet_gso)
> > > +{
> > > +     char ifname[IFNAMSIZ];
> > > +     int fd;
> > > +};
> > > +
> > > +FIXTURE_SETUP(tun_vnet_gso)
> > > +{
> > > +     int flags =3D IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
> > > +
> > > +     memset(self->ifname, 0, sizeof(self->ifname));
> > > +     self->fd =3D tun_open(self->ifname, flags, 0, 0, NULL);
> > > +     ASSERT_GE(self->fd, 0);
> > > +}
> > > +
> > > +FIXTURE_TEARDOWN(tun_vnet_gso)
> > > +{
> > > +     if (self->fd >=3D 0)
> > > +             close(self->fd);
> > > +}
> > > +
> > > +static int build_vlan_tcpv4_gso_packet(uint8_t *buf, int payload_l=
en)
> > > +{
> > > +     uint16_t vlan_tag[2] =3D { htons(100), htons(ETH_P_IP) };
> > > +     uint8_t *cur =3D buf + sizeof(struct virtio_net_hdr);
> > > +     struct virtio_net_hdr vh =3D { 0 };
> > > +     struct tcphdr tcph =3D { 0 };
> > > +     uint32_t sum;
> > > +
> > > +     cur +=3D build_eth(cur, ETH_P_8021Q, param_hwaddr_outer_src,
> > > +                      param_hwaddr_outer_dst);
> > > +
> > > +     /* 802.1Q tag: VID=3D100, inner protocol=3DETH_P_IP */
> > > +     memcpy(cur, vlan_tag, sizeof(vlan_tag));
> > > +     cur +=3D sizeof(vlan_tag);
> > > +
> > > +     cur +=3D build_ipv4_header(cur, IPPROTO_TCP,
> > > +                              sizeof(tcph) + payload_len,
> > > +                              &param_ipaddr4_outer_src,
> > > +                              &param_ipaddr4_outer_dst);
> > > +
> > > +     tcph.source =3D htons(12345);
> > > +     tcph.dest =3D htons(80);
> > > +     tcph.seq =3D htonl(1);
> > > +     tcph.doff =3D sizeof(tcph) / 4;
> > > +     tcph.ack =3D 1;
> > > +     tcph.window =3D htons(65535);
> > > +     memcpy(cur, &tcph, sizeof(tcph));
> > > +     memset(cur + sizeof(tcph), PKT_DATA, payload_len);
> > > +
> > > +     sum =3D add_csum((const uint8_t *)&param_ipaddr4_outer_src,
> > > +                    sizeof(param_ipaddr4_outer_src));
> > > +     sum +=3D add_csum((const uint8_t *)&param_ipaddr4_outer_dst,
> > > +                     sizeof(param_ipaddr4_outer_dst));
> > > +     sum +=3D htons(IPPROTO_TCP) + htons(sizeof(tcph) + payload_le=
n);
> > > +     sum +=3D add_csum(cur, sizeof(tcph) + payload_len);
> > > +     tcph.check =3D finish_ip_csum(sum);
> > > +     memcpy(cur, &tcph, sizeof(tcph));
> > > +     cur +=3D sizeof(tcph) + payload_len;
> > > +
> > > +     vh.gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
> > > +     vh.gso_size =3D 1400;
> > > +     vh.hdr_len =3D (cur - buf) - sizeof(vh) - payload_len;
> > > +     memcpy(buf, &vh, sizeof(vh));
> > > +
> > > +     return cur - buf;
> > > +}
> > > +
> > > +TEST_F(tun_vnet_gso, vlan_tcpv4_gso_no_csum)
> > > +{
> > > +     struct virtio_net_hdr vh;
> > > +     uint8_t pkt[4096] =3D { 0 };
> > > +     int len, ret;
> > > +
> > > +     len =3D build_vlan_tcpv4_gso_packet(pkt, 2800);
> > > +     memcpy(&vh, pkt, sizeof(vh));
> > > +
> > > +     /* Valid VLAN-tagged TCPv4 GSO with flags =3D 0 (no NEEDS_CSU=
M) */
> >
> > This is not a GSO packet if no vh.gso_type
> >
> > > +     vh.flags =3D 0;
> > > +     memcpy(pkt, &vh, sizeof(vh));
> > > +     ret =3D write(self->fd, pkt, len);
> > > +     ASSERT_EQ(ret, len);
> > > +
> > > +     /* Valid VLAN-tagged TCPv4 GSO with flags =3D DATA_VALID */
> >
> > Same
> =

> build_vlan_tcpv4_gso_packet() already sets:
> =

> vh.gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
> vh.gso_size =3D 1400;
> vh.hdr_len =3D (cur - buf) - sizeof(vh) - payload_len;
> memcpy(buf, &vh, sizeof(vh));

Missed that, sorry. I was only looking at the top of the function.

> and vlan_tcpv4_gso_no_csum() copies it back into the local vh right
> afterwards:
> =

> len =3D build_vlan_tcpv4_gso_packet(pkt, 2800);
> memcpy(&vh, pkt, sizeof(vh));
> =

> so vh.gso_type is VIRTIO_NET_HDR_GSO_TCPV4 (and vh.gso_size is 1400) fo=
r
> both the flags =3D 0 and flags =3D VIRTIO_NET_HDR_F_DATA_VALID cases.


