Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBB13BD241
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624641; cv=none; b=tAf0NSVASlR3WV8gH79wTHiESqr76zPPEIJHewy0C+xLUs6x7TUNLjXz5MF6tZJuXsfmjctxD1xv8SZ5zvqtBKqF7fvHy+yBz7uYnfHsANMokpQB00gzE6txWQEYHqKHhpcCEpJBEOoDnCS3QROLjN4bkaOPqFV1jbt4X3o/Upo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624641; c=relaxed/simple;
	bh=MQ/+8dYy2BguLWjAVAaxZMg5VNMBrKe8qs+P1yqDsHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGjqKClBGF5YqrKYTvIWQZ2R2B+WSjuiEnWUCJedkrAwxuzAjjPbKIhRDfOUv01RWrDrjY6Pn3gn7nQAbUoCemut3xYy1Y5vcGYKozvvyWRTFV/B4rtkBPmKM7UiWMQ0cu2zb1dCmflQBk/NE0LA8vNiMBrRxmBbYOXrW9MLnDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ix2fXZcT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ix2fXZcT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A123B1F0089D
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 19:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790624639;
	bh=rYohJFuKGr/80ObgTITrhIRr2Z+PW3uxKcdd3vRyqUg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ix2fXZcTsxw5tSmi084tBj6ble4pR6xxr1Eg4VIbNP6Uq+PcUmVPoaz1BBzwx/d+s
	 S88M+HkQeO2IpTmAv4Q1xchfj73+XTIzTzqN7SBCg5wDjISwQqquDrAwH5lWJsxP1u
	 B6DW83SlM7StsIwSM6t282zD5CyWL/TnMX8e/IN3eRefCqIvB6mfXdPrN7C1qxCK0Q
	 6ZOwUWo4oclr3OuAh0AOj3wHC1yKCa1WZsL2nLOegLjDuI64OUcd5gUt/78SO3U2LV
	 +zS7HtW6z1cnwDYUERSfYFn3zeT02Z2v/C7QUztrhmIAMmCQudh3EUrTu6uQl0Dox/
	 D2J1UkLlHe/hQ==
Received: by mail-oa2-f30.google.com with SMTP id 586e51a60fabf-483c65c2fa7so1969411fac.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:43:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxZU8RamD9uSIitb6wvSnW0IjEbHw5bGQYcCG02DYWEgINDHxfVOTIRT3XUQMR4rpR7VdSQBm4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIR5Wx4SFopktj2DaQM9Yybu9+AR7MrZME8lzt7SDF8NABgNk0u
	WNnmRAcp0/e4HLX3xDyIa1mjaUcYYULAVsYcGcqIaST/hXOwJ/J/iEewK/yNjmJAoVwnilz/tMG
	LoqbJd8MT8CYZN4Ej6+DKfhqevOmfV1E=
X-Received: by 2002:a05:6871:c962:b0:48f:e0e5:a1e5 with SMTP id
 586e51a60fabf-491eb8646b5mr13170513fac.42.1790624638853; Mon, 28 Sep 2026
 12:43:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928144254.3361044-1-edumazet@kernel.org> <20260928144254.3361044-3-edumazet@kernel.org>
 <willemdebruijn.kernel.293b4851be048@gmail.com>
In-Reply-To: <willemdebruijn.kernel.293b4851be048@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 28 Sep 2026 21:43:47 +0200
X-Gmail-Original-Message-ID: <CAL4Wiip8iSAYT0NgFgEidvk4TD35aemRNfFVUjAnUoVaqips9g@mail.gmail.com>
X-Gm-Features: AclHuK-00fo2pHiunvOQTgvTuXla_617JIXU1eG5ALbIvgklHchvansq7XPjQSI
Message-ID: <CAL4Wiip8iSAYT0NgFgEidvk4TD35aemRNfFVUjAnUoVaqips9g@mail.gmail.com>
Subject: Re: [PATCH v2 net 2/2] selftests: net: tun: add test for VLAN-tagged
 GSO without NEEDS_CSUM
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 9:17=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > Add a selftest in tun.c verifying that a VLAN-tagged (802.1Q) TCPv4 GSO
> > packet without VIRTIO_NET_HDR_F_NEEDS_CSUM (both flags =3D 0 and
> > flags =3D VIRTIO_NET_HDR_F_DATA_VALID) is accepted when written to a TA=
P
> > device (/dev/net/tun with IFF_TAP | IFF_NO_PI | IFF_VNET_HDR).
> >
> > Also verify that mismatched GSO types (e.g. VIRTIO_NET_HDR_GSO_TCPV6 on
> > a VLAN-tagged IPv4 packet) and truncated headers without NEEDS_CSUM are
> > rejected with -EINVAL.
> >
> > Based on a reproducer by Michael S. Tsirkin <mst@redhat.com>.
> >
> > Assisted-by: LLM
> > Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> > ---
> >  tools/testing/selftests/net/tun.c | 107 ++++++++++++++++++++++++++++++
> >  1 file changed, 107 insertions(+)
> >
> > diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftest=
s/net/tun.c
> > index abe488bac50bb3b05df5c446836c1c3dfa9ea604..c6afafb7b957360e2873640=
e60a7d580c6564a66 100644
> > --- a/tools/testing/selftests/net/tun.c
> > +++ b/tools/testing/selftests/net/tun.c
> > @@ -9,6 +9,7 @@
> >  #include <string.h>
> >  #include <unistd.h>
> >  #include <linux/if_tun.h>
> > +#include <netinet/tcp.h>
> >  #include <sys/ioctl.h>
> >  #include <sys/socket.h>
> >
> > @@ -542,6 +543,112 @@ TEST_F(tun, reattach_close_delete)
> >       EXPECT_EQ(tun_delete(self->ifname), 0);
> >  }
> >
> > +FIXTURE(tun_vnet_gso)
> > +{
> > +     char ifname[IFNAMSIZ];
> > +     int fd;
> > +};
> > +
> > +FIXTURE_SETUP(tun_vnet_gso)
> > +{
> > +     int flags =3D IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
> > +
> > +     memset(self->ifname, 0, sizeof(self->ifname));
> > +     self->fd =3D tun_open(self->ifname, flags, 0, 0, NULL);
> > +     ASSERT_GE(self->fd, 0);
> > +}
> > +
> > +FIXTURE_TEARDOWN(tun_vnet_gso)
> > +{
> > +     if (self->fd >=3D 0)
> > +             close(self->fd);
> > +}
> > +
> > +static int build_vlan_tcpv4_gso_packet(uint8_t *buf, int payload_len)
> > +{
> > +     uint16_t vlan_tag[2] =3D { htons(100), htons(ETH_P_IP) };
> > +     uint8_t *cur =3D buf + sizeof(struct virtio_net_hdr);
> > +     struct virtio_net_hdr vh =3D { 0 };
> > +     struct tcphdr tcph =3D { 0 };
> > +     uint32_t sum;
> > +
> > +     cur +=3D build_eth(cur, ETH_P_8021Q, param_hwaddr_outer_src,
> > +                      param_hwaddr_outer_dst);
> > +
> > +     /* 802.1Q tag: VID=3D100, inner protocol=3DETH_P_IP */
> > +     memcpy(cur, vlan_tag, sizeof(vlan_tag));
> > +     cur +=3D sizeof(vlan_tag);
> > +
> > +     cur +=3D build_ipv4_header(cur, IPPROTO_TCP,
> > +                              sizeof(tcph) + payload_len,
> > +                              &param_ipaddr4_outer_src,
> > +                              &param_ipaddr4_outer_dst);
> > +
> > +     tcph.source =3D htons(12345);
> > +     tcph.dest =3D htons(80);
> > +     tcph.seq =3D htonl(1);
> > +     tcph.doff =3D sizeof(tcph) / 4;
> > +     tcph.ack =3D 1;
> > +     tcph.window =3D htons(65535);
> > +     memcpy(cur, &tcph, sizeof(tcph));
> > +     memset(cur + sizeof(tcph), PKT_DATA, payload_len);
> > +
> > +     sum =3D add_csum((const uint8_t *)&param_ipaddr4_outer_src,
> > +                    sizeof(param_ipaddr4_outer_src));
> > +     sum +=3D add_csum((const uint8_t *)&param_ipaddr4_outer_dst,
> > +                     sizeof(param_ipaddr4_outer_dst));
> > +     sum +=3D htons(IPPROTO_TCP) + htons(sizeof(tcph) + payload_len);
> > +     sum +=3D add_csum(cur, sizeof(tcph) + payload_len);
> > +     tcph.check =3D finish_ip_csum(sum);
> > +     memcpy(cur, &tcph, sizeof(tcph));
> > +     cur +=3D sizeof(tcph) + payload_len;
> > +
> > +     vh.gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
> > +     vh.gso_size =3D 1400;
> > +     vh.hdr_len =3D (cur - buf) - sizeof(vh) - payload_len;
> > +     memcpy(buf, &vh, sizeof(vh));
> > +
> > +     return cur - buf;
> > +}
> > +
> > +TEST_F(tun_vnet_gso, vlan_tcpv4_gso_no_csum)
> > +{
> > +     struct virtio_net_hdr vh;
> > +     uint8_t pkt[4096] =3D { 0 };
> > +     int len, ret;
> > +
> > +     len =3D build_vlan_tcpv4_gso_packet(pkt, 2800);
> > +     memcpy(&vh, pkt, sizeof(vh));
> > +
> > +     /* Valid VLAN-tagged TCPv4 GSO with flags =3D 0 (no NEEDS_CSUM) *=
/
>
> This is not a GSO packet if no vh.gso_type
>
> > +     vh.flags =3D 0;
> > +     memcpy(pkt, &vh, sizeof(vh));
> > +     ret =3D write(self->fd, pkt, len);
> > +     ASSERT_EQ(ret, len);
> > +
> > +     /* Valid VLAN-tagged TCPv4 GSO with flags =3D DATA_VALID */
>
> Same

build_vlan_tcpv4_gso_packet() already sets:

vh.gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
vh.gso_size =3D 1400;
vh.hdr_len =3D (cur - buf) - sizeof(vh) - payload_len;
memcpy(buf, &vh, sizeof(vh));

and vlan_tcpv4_gso_no_csum() copies it back into the local vh right
afterwards:

len =3D build_vlan_tcpv4_gso_packet(pkt, 2800);
memcpy(&vh, pkt, sizeof(vh));

so vh.gso_type is VIRTIO_NET_HDR_GSO_TCPV4 (and vh.gso_size is 1400) for
both the flags =3D 0 and flags =3D VIRTIO_NET_HDR_F_DATA_VALID cases.
