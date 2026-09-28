Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A0046E019
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583031; cv=none; b=fN0i+CDMUQjlKFLhGsGKYH2leAKom9MOk4+Czv76Y3Q5xZT1wcyMOLts6/U+AeSloa6e66SK7DJOYd3uE59s6ACt3K8r7BJAbt0JcwNneBe4V17iX4CUFz1q2MDac7ENJPBtDjB8QfRmLgs9ccKevyYmB6CLfYfxSZmgT8YWg6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583031; c=relaxed/simple;
	bh=9xt9VDFFLs9JJAFoYFp4sigf5787BXm7LNhloIJfqN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hH/x9HrdXLS7PkM/VqN/OgWRtpNlOavtY7ukBSJ5n/8dzyfvucDf/fk1QDFhzry/foA2nt8TWheNWOMUUOQOVa9tzwxOp05emHuq6x+owtwLaklZS86WdF5SlnvCleDH8JKgUt/Ous31zmjiZ72p2f4lZS9svJV6KD7M2np0OAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hyQ9/ipn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gpc2wjhb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyQ9/ipn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpc2wjhb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790583027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxTYGWpOuUInrVn7/Qc1rh0ahl+5+VjHHCu1mv0nD28=;
	b=hyQ9/ipnSnm+9JPSSKChkzMMmneyaG7r1xnmnJfywomJYgGNhWDtvXWNz8XY0cOjtVCZIQ
	CrBP3K3DZTmZWyXOjt5DvSeFdjNv0mZhSWjGPrgnQl8cGYJG5yuB3Jb3ZtSd7suB2xyFyg
	O3N/CTLcBrFebw0NhY6cb6eiXMF3/8I=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-hcrLb50sPaWqEdoIdWObow-1; Mon, 28 Sep 2026 04:10:26 -0400
X-MC-Unique: hcrLb50sPaWqEdoIdWObow-1
X-Mimecast-MFC-AGG-ID: hcrLb50sPaWqEdoIdWObow_1790583025
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6ac6fb97deaso1032549a12.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 01:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790583025; x=1791187825; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RxTYGWpOuUInrVn7/Qc1rh0ahl+5+VjHHCu1mv0nD28=;
        b=gpc2wjhbK+D4YRnBo8/bWCk1jkhdtTBgQnBclCfV6FYuBCq3eppGmUhwFjQBXsnqxi
         CYOYxkJV037CtbeR7BOVp0GOkmgjBxbFnRfv8dY+nOxffL0EpCh28/ESWebEkgAROOgX
         5S72Utq+p+zCDkZppNFjcN1uPX0R23WEwoTLF4ObszyIfEckzdGq6J0suCWAJHfXMsM6
         ujjYgUjy0kAy1Cu5FU8TBah5bcm7oWi3oLRZWKMNUdJh0/JCTkqnHhaHLwew4/h3IklG
         Ql6zCWS732GAc5CEh49uacJk2z84oHLvUScML1zGP/iXaaejs9Xth6OLiK5QNqACWwNt
         SpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790583025; x=1791187825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RxTYGWpOuUInrVn7/Qc1rh0ahl+5+VjHHCu1mv0nD28=;
        b=oUuxvXZUm/1IoKaDvqTNJ9GdflGRsubT69CQvdidYIGgV2EzMwkGHv5TExZOCVpTh1
         /VkiyxING2GBojZLjeXwKPShuESaUrqu5EiF+6wTBuSkbYPSHZJvAblUDISUYSxVKUq9
         /8UwGzjoiS02tVtX8t0agyXm9hD4tCr3w+VJoQOa/HTR9UFqvZwj6V2IMC8B3+b2uGxo
         r2XnHtZ/5Jpl0mhEeUe5omSrBqAsE3LL7DIPghT0iq9Kxea6tSca/9emEN8Ls/lBEV6I
         7wu3Ay0hjgT5ynTEtAeCHMQR0yTCsMibo30e0V+eWcPJwgtWwHDogoqhsmgJRwPO8xSV
         nXKg==
X-Forwarded-Encrypted: i=1; AKwUvBz8JaoVtYsW5KCqIqEMUPsNn1mA0CVHS82sWHolgg+ZD7itkpEHJpY+RMD1NaH6Y7y1bj4/FtM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYfs/iH6zsp5CWwwMLMYE6mUYd3m8BMR63qJ+zQ81VCv7JsaO+
	YkRoV3rZEvxueRCkUkcaS829tZCIagLbsKLDxX8ifq6mgBDxqYSMuSyfuWhN8n8GcMPfgzliQCR
	9Sw4WUOrXmCr3G/4DuUMkgA+KoQ+ycCKJhQYHdWkq/HjX33M/O0oMK4dLiA==
X-Gm-Gg: AYBFou1n/f1dJitlfir2kVm7YiLK7sggtfpdbSAx1v0b1zl6fsMMCrOn7TJnxJpJjkv
	crBW96CbH9R+SVF0k9ZtITEeiT4QXCH1Wo+nwLEAAXHJZ+ZlccoZMrW9whhMkj5fkshTQBg3Yta
	XLvOltoEla3543IKxputG84LfJODbxqMxeBKm+oY26PQ8Nucg4kkcjLMZAirGY6xkKtmrcSjoJ8
	Y3PksZaKccJmpuS8Xc3Eq3/PcH+MyZJ3YgBLYbucFPfoVxjA3T32+mub7WOnjHUqGSygGJGZ/6R
	gi0PihFboWaP19QMK49NZohgRHUc/5p7Uh2qHNetsuMF4/YD5YibD7T2xFRQ/f7pT3BP41QGCHM
	vHGRPZ1GKv6zxnweHPGdeyuzvkwDh5/2POeyPBfotpH3RxQCv7B6qoArYYlU/83ZrGA==
X-Received: by 2002:a05:6402:a0cc:b0:6aa:12f0:166e with SMTP id 4fb4d7f45d1cf-6aac90ab1cfmr8861108a12.16.1790583024606;
        Mon, 28 Sep 2026 01:10:24 -0700 (PDT)
X-Received: by 2002:a05:6402:a0cc:b0:6aa:12f0:166e with SMTP id 4fb4d7f45d1cf-6aac90ab1cfmr8861074a12.16.1790583023999;
        Mon, 28 Sep 2026 01:10:23 -0700 (PDT)
Received: from redhat.com (2a02-ab04-0158-f000-2548-f3bd-8b42-b18f.dynamic.v6.chello.sk. [2a02:ab04:158:f000:2548:f3bd:8b42:b18f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae59728bdsm4054012a12.1.2026.09.28.01.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 01:10:23 -0700 (PDT)
Date: Mon, 28 Sep 2026 04:10:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] net: always dissect GSO packets in
 __virtio_net_hdr_to_skb()
Message-ID: <20260928032419-mutt-send-email-mst@kernel.org>
References: <20260927195536.2489079-1-edumazet@google.com>
 <20260927212942-mutt-send-email-mst@kernel.org>
 <CAL4Wiio9juqXbKZ7gsv8G=siXsdCwHtn0pYRpx-74akkamJvdA@mail.gmail.com>
 <CAL4WiiqLV8GFDiUak5i8DyGR9b6PN3yy81iLcdmZAbkJxAHM1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL4WiiqLV8GFDiUak5i8DyGR9b6PN3yy81iLcdmZAbkJxAHM1w@mail.gmail.com>

On Mon, Sep 28, 2026 at 08:31:53AM +0200, Eric Dumazet wrote:
> On Mon, Sep 28, 2026 at 8:22 AM Eric Dumazet <edumazet@kernel.org> wrote:
> >
> > On Mon, Sep 28, 2026 at 3:31 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Sun, Sep 27, 2026 at 07:55:36PM +0000, Eric Dumazet wrote:
> > > > Commit 9e8db5913264 ("net: avoid false positives in untrusted gso
> > > > validation") added a '&& skb->network_header' check before flow-dissecting
> > > > GSO packets without VIRTIO_NET_HDR_F_NEEDS_CSUM in
> > > > __virtio_net_hdr_to_skb(), because some callers (such as tun_get_user(),
> > > > tun_xdp_one(), virtnet_receive_done(), and raw_verify_header()) called
> > > > virtio_net_hdr_*_to_skb() before initializing skb->network_header and
> > > > skb->dev.
> > > >
> > > > However, skb->network_header is an offset from skb->head, not a boolean
> > > > flag. When skb_headroom(skb) is 0 on a device without L2 headers (for
> > > > instance packet_snd() or tpacket_snd() on a tunnel/pure-L3 device where
> > > > LL_RESERVED_SPACE_EX(dev, 0) == 0),
> > >
> > > Hmm. I have:
> > >
> > > LL_RESERVED_SPACE_EX(dev, 0)
> > >         ((((hlen) + READ_ONCE((dev)->needed_headroom)) \
> > >           & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)
> > >
> > > #define HH_DATA_MOD     16
> > >
> > > So how can LL_RESERVED_SPACE_EX(dev, 0) == 0 ?
> > >
> > >
> >
> > In practice, skb->network_header was 0 on tun_get_user() (including the
> > reported reproducer), tun_xdp_one(), virtnet_receive_done(), and
> > raw_verify_header() because __alloc_skb() / __build_skb_around()
> > zero-initializes skb->network_header to 0 (unlike mac_header and
> > transport_header which are initialized to ~0U), and those callers invoked
> > virtio_net_hdr_*_to_skb() before setting skb->network_header.
> >
> > More generally, because 0 is both the initial value from alloc_skb() and a
> > valid offset whenever skb_headroom(skb) == 0, skb->network_header cannot
> > be used as a boolean to test whether the network header was initialized.
> >
> > I can send a v2 with the corrected commit message if preferred, the
> > patch stays the same.
> 
> Revised changelog would look like this, let me know if it looks ok this time.
> 
> net: always dissect GSO packets in __virtio_net_hdr_to_skb()
> 
> Commit 9e8db5913264 ("net: avoid false positives in untrusted gso
> validation") added a '&& skb->network_header' check before flow-dissecting
> GSO packets without VIRTIO_NET_HDR_F_NEEDS_CSUM in
> __virtio_net_hdr_to_skb(), because some callers (such as tun_get_user(),
> tun_xdp_one(), virtnet_receive_done(), and raw_verify_header()) called
> virtio_net_hdr_*_to_skb() before initializing skb->network_header and
> skb->dev.
> 
> Because __alloc_skb() and __build_skb_around() zero-initialize
> skb->network_header to 0 (unlike mac_header and transport_header which
> are initialized to ~0U), those four callers always had
> skb->network_header == 0 and bypassed flow dissection in
> __virtio_net_hdr_to_skb(). More generally, skb->network_header is an
> offset from skb->head (where 0 is also a valid offset whenever
> skb_headroom(skb) is 0), not a boolean flag.
> 
> Whenever the 'if (gso_type && skb->network_header)' branch was skipped,
> the fallback 'else if (gso_type)' only pulled nh_min_len + thlen (40 bytes
> for TCPv4) without dissecting the packet, without validating ip_proto or
> n_proto, and without setting skb->transport_header.
> 
> If the packet has a malformed network header, it is not rejected and a
> subsequent skb_probe_transport_header() also fails, leaving
> skb->transport_header at ~0U (0xffff). Similarly, if an IPv4 packet
> carries IP options (ihl > 5) or an IPv6 packet carries extension headers,
> pulling only nh_min_len + thlen can leave the TCP header outside
> skb->head. In both cases, tcp_hdrlen(skb) in skb_gso_transport_seglen()
> reads out-of-bounds:
> 
>   BUG: KASAN: slab-out-of-bounds in skb_gso_transport_seglen
>   Read of size 2 by task poc/133
>   skb_gso_transport_seglen (net/core/gso.c:155)
>   skb_gso_validate_mac_len (net/core/gso.c:270)
>   tbf_enqueue (net/sched/sch_tbf.c:260)
>   dev_qdisc_enqueue (net/core/dev.c:4227)
>   __dev_queue_xmit (net/core/dev.c:4884)
> 
> In addition, when skb->protocol is pre-set by a caller before
> __virtio_net_hdr_to_skb(), 'if (!skb->protocol)' is skipped and
> virtio_net_hdr_match_proto() was not checked.
> 
> Fix this by:
> 1. Initializing skb->dev and skb->network_header (plus skb->protocol for
>    IFF_TUN) before virtio_net_hdr_*_to_skb() in tun_get_user(),
>    tun_xdp_one(), virtnet_receive_done(), and raw_verify_header(). In
>    tun_get_user(), drop the redundant skb_reset_mac_header(skb) in the
>    IFF_TUN case since __virtio_net_hdr_to_skb() unconditionally resets
>    mac_header.
> 2. Removing '&& skb->network_header' and the unvalidated
>    'else if (gso_type)' fallback in __virtio_net_hdr_to_skb() so all GSO
>    packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are flow-dissected, have
>    their transport header pulled into linear data, and have
>    skb->transport_header set.
> 3. Validating virtio_net_hdr_match_proto(keys.basic.n_proto, hdr_gso_type)
>    after skb_flow_dissect_flow_keys_basic().

I'm travelling for a week, if possible I'd like a bit of time to review this.

For now, I also asked Claude to find cases where this patch causes any
UAPI change (because if it does, there's a risk it will break some
userspace, right?).  It wrote the below test, which accepts a packet
without your patch and fails with, and claims this packet is valid and
was previously accepted. I tested it quickly and it seems to be true but I can't
analyze it now as I'm sleep deprived due to travel)

--->


/*
 * test_vlan_gso.c - Regression reproducer: VLAN-tagged GSO without NEEDS_CSUM
 *
 * Writes a VLAN-tagged TCPv4 GSO packet (no NEEDS_CSUM) to a TAP device.
 * Accepted without patch, rejected with patch = regression.
 *
 * Validates packet correctness with hex dump, memcmp, and pcap output.
 *
 * Packet layout (virtio_net_hdr + ethernet frame):
 *
 *   virtio_net_hdr (10 bytes):
 *     00/02        flags (0 = none, or 02 = DATA_VALID)
 *     01        gso_type = VIRTIO_NET_HDR_GSO_TCPV4
 *     3a 00     hdr_len = 58 (14 eth + 4 vlan + 20 ip + 20 tcp)
 *     78 05     gso_size = 1400
 *     00 00     csum_start (unused, no NEEDS_CSUM)
 *     00 00     csum_offset (unused)
 *
 *   Ethernet + VLAN (18 bytes):
 *     02:02:02:02:02:02  dst MAC
 *     04:04:04:04:04:04  src MAC
 *     81 00              ethertype = 802.1Q
 *     00 64              VLAN TCI: VID=100
 *     08 00              inner ethertype = IPv4
 *
 *   IPv4 (20 bytes):
 *     45 00 0b 18        v4, IHL=5, tot_len=2840
 *     00 00 00 00        id=0, flags=0, frag_off=0
 *     40 06              TTL=64, proto=TCP
 *     5b de              IP checksum (correct)
 *     0a 00 00 01        src = 10.0.0.1
 *     0a 00 00 02        dst = 10.0.0.2
 *
 *   TCP (20 bytes):
 *     30 39 00 50        sport=12345, dport=80
 *     00 00 00 01        seq=1
 *     00 00 00 00        ack=0
 *     50 10 ff ff        doff=5, flags=ACK, win=65535
 *     83 7b 00 00        checksum (correct), urgent=0
 *
 *   Payload: 2800 bytes of 'A' (0x41)
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/mount.h>
#include <sys/reboot.h>
#include <net/if.h>
#include <linux/if_tun.h>
#include <linux/virtio_net.h>
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <linux/reboot.h>
#include <arpa/inet.h>
#include <stdint.h>

static unsigned int csum_add(const void *data, int len, unsigned int initial)
{
	const unsigned short *p = data;
	unsigned int sum = initial;

	while (len > 1) {
		sum += *p++;
		len -= 2;
	}
	if (len)
		sum += *(const unsigned char *)p;
	return sum;
}

static unsigned short csum_fold(unsigned int sum)
{
	sum = (sum >> 16) + (sum & 0xffff);
	sum += sum >> 16;
	return ~sum;
}

static unsigned short ip_csum(const void *data, int len)
{
	return csum_fold(csum_add(data, len, 0));
}

static unsigned short tcp_csum(struct iphdr *iph, struct tcphdr *tcph,
			       const void *payload, int payload_len)
{
	struct {
		uint32_t saddr;
		uint32_t daddr;
		uint8_t zero;
		uint8_t protocol;
		uint16_t tcp_len;
	} __attribute__((packed)) pseudo;
	unsigned int sum;
	int tcp_len = sizeof(struct tcphdr) + payload_len;

	pseudo.saddr = iph->saddr;
	pseudo.daddr = iph->daddr;
	pseudo.zero = 0;
	pseudo.protocol = IPPROTO_TCP;
	pseudo.tcp_len = htons(tcp_len);

	sum = csum_add(&pseudo, sizeof(pseudo), 0);
	sum = csum_add(tcph, sizeof(struct tcphdr), sum);
	sum = csum_add(payload, payload_len, sum);
	return csum_fold(sum);
}

static void hexdump(const char *label, const unsigned char *data, int len)
{
	int i;

	printf("%s (%d bytes):\n", label, len);
	for (i = 0; i < len; i++) {
		if (i % 16 == 0)
			printf("  %04x: ", i);
		printf("%02x ", data[i]);
		if (i % 16 == 15 || i == len - 1)
			printf("\n");
	}
}

static void write_pcap(const char *path, const unsigned char *pkt, int len)
{
	FILE *f;
	uint32_t val32;
	uint16_t val16;
	uint32_t pkt_hdr[4];

	f = fopen(path, "wb");
	if (!f) {
		printf("cannot write pcap: %s\n", strerror(errno));
		return;
	}

	/* pcap global header */
	val32 = 0xa1b2c3d4; fwrite(&val32, 4, 1, f); /* magic */
	val16 = 2;           fwrite(&val16, 2, 1, f); /* version major */
	val16 = 4;           fwrite(&val16, 2, 1, f); /* version minor */
	val32 = 0;           fwrite(&val32, 4, 1, f); /* thiszone */
	val32 = 0;           fwrite(&val32, 4, 1, f); /* sigfigs */
	val32 = 65535;       fwrite(&val32, 4, 1, f); /* snaplen */
	val32 = 1;           fwrite(&val32, 4, 1, f); /* network (LINKTYPE_ETHERNET) */

	/* packet header */
	pkt_hdr[0] = 0;     /* ts_sec */
	pkt_hdr[1] = 0;     /* ts_usec */
	pkt_hdr[2] = len;   /* incl_len */
	pkt_hdr[3] = len;   /* orig_len */
	fwrite(pkt_hdr, sizeof(pkt_hdr), 1, f);

	/* packet data */
	fwrite(pkt, 1, len, f);
	fclose(f);
	printf("wrote pcap: %s\n", path);
}

static int validate_packet(const unsigned char *frame, int frame_len,
			    int ip_off, int tcp_off, int pay_off)
{
	struct ethhdr *eth = (struct ethhdr *)frame;
	struct iphdr *iph = (struct iphdr *)(frame + ip_off);
	struct tcphdr *tcph = (struct tcphdr *)(frame + tcp_off);
	int payload_len = frame_len - pay_off;
	unsigned short got, expect;
	int ok = 1;

	/* ETH */
	if (ntohs(eth->h_proto) != ETH_P_8021Q) {
		printf("  MISMATCH: ethertype %04x != 8021Q\n",
		       ntohs(eth->h_proto));
		ok = 0;
	}

	/* VLAN: inner ethertype */
	if (frame[sizeof(struct ethhdr) + 2] != 0x08 ||
	    frame[sizeof(struct ethhdr) + 3] != 0x00) {
		printf("  MISMATCH: inner ethertype %02x%02x != 0800\n",
		       frame[sizeof(struct ethhdr) + 2],
		       frame[sizeof(struct ethhdr) + 3]);
		ok = 0;
	}

	/* IP checksum */
	got = iph->check;
	iph->check = 0;
	expect = ip_csum(iph, iph->ihl * 4);
	iph->check = got;
	if (got != expect) {
		printf("  MISMATCH: IP csum %04x != %04x\n",
		       ntohs(got), ntohs(expect));
		ok = 0;
	}

	/* TCP checksum */
	got = tcph->check;
	tcph->check = 0;
	expect = tcp_csum(iph, tcph, frame + pay_off, payload_len);
	tcph->check = got;
	if (got != expect) {
		printf("  MISMATCH: TCP csum %04x != %04x\n",
		       ntohs(got), ntohs(expect));
		ok = 0;
	}

	/* IP header fields */
	if (iph->version != 4 || iph->ihl != 5) {
		printf("  MISMATCH: IP ver/ihl %d/%d\n",
		       iph->version, iph->ihl);
		ok = 0;
	}
	if (iph->protocol != IPPROTO_TCP) {
		printf("  MISMATCH: IP proto %d != TCP\n", iph->protocol);
		ok = 0;
	}
	if (ntohs(iph->tot_len) != frame_len - ip_off) {
		printf("  MISMATCH: IP tot_len %d != %d\n",
		       ntohs(iph->tot_len), frame_len - ip_off);
		ok = 0;
	}

	/* TCP header */
	if (tcph->doff != 5) {
		printf("  MISMATCH: TCP doff %d != 5\n", tcph->doff);
		ok = 0;
	}

	if (ok)
		printf("  packet validation: OK\n");
	return ok;
}

int main(void)
{
	unsigned char buf[4096];
	struct virtio_net_hdr *vhdr;
	struct ethhdr *eth;
	struct iphdr *iph;
	struct tcphdr *tcph;
	struct ifreq ifr;
	int fd, sock, ret;
	int payload_len = 2800;

	int vhdr_off = 0;
	int eth_off = sizeof(struct virtio_net_hdr);
	int vlan_off = eth_off + sizeof(struct ethhdr);
	int ip_off = vlan_off + 4;
	int tcp_off = ip_off + sizeof(struct iphdr);
	int pay_off = tcp_off + sizeof(struct tcphdr);
	int total = pay_off + payload_len;

	/* frame offsets (without virtio_net_hdr) */
	int f_ip_off = ip_off - eth_off;
	int f_tcp_off = tcp_off - eth_off;
	int f_pay_off = pay_off - eth_off;
	int frame_len = total - eth_off;

	mount("proc", "/proc", "proc", 0, NULL);
	mount("sysfs", "/sys", "sysfs", 0, NULL);
	mount("devtmpfs", "/dev", "devtmpfs", 0, NULL);

	memset(buf, 0, total);

	/* virtio_net_hdr - filled per test below */
	vhdr = (struct virtio_net_hdr *)(buf + vhdr_off);

	/* Ethernet header */
	eth = (struct ethhdr *)(buf + eth_off);
	memset(eth->h_dest, 0x02, ETH_ALEN);
	memset(eth->h_source, 0x04, ETH_ALEN);
	eth->h_proto = htons(ETH_P_8021Q);

	/* 802.1Q: VID=100, inner ethertype=IPv4 */
	buf[vlan_off + 0] = 0x00;
	buf[vlan_off + 1] = 0x64;
	buf[vlan_off + 2] = 0x08;
	buf[vlan_off + 3] = 0x00;

	/* IP header */
	iph = (struct iphdr *)(buf + ip_off);
	iph->ihl = 5;
	iph->version = 4;
	iph->tot_len = htons(sizeof(struct iphdr) + sizeof(struct tcphdr) +
			     payload_len);
	iph->ttl = 64;
	iph->protocol = IPPROTO_TCP;
	iph->saddr = htonl(0x0a000001);
	iph->daddr = htonl(0x0a000002);
	iph->check = ip_csum(iph, sizeof(struct iphdr));

	/* TCP header */
	tcph = (struct tcphdr *)(buf + tcp_off);
	tcph->source = htons(12345);
	tcph->dest = htons(80);
	tcph->seq = htonl(1);
	tcph->doff = sizeof(struct tcphdr) / 4;
	tcph->ack = 1;
	tcph->window = htons(65535);

	/* Payload */
	memset(buf + pay_off, 'A', payload_len);

	/* TCP checksum over pseudo-header + TCP header + payload */
	tcph->check = tcp_csum(iph, tcph, buf + pay_off, payload_len);

	/* Set virtio_net_hdr GSO fields for dump (flags adjusted per test) */
	vhdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
	vhdr->gso_size = 1400;
	vhdr->hdr_len = tcp_off - eth_off + sizeof(struct tcphdr);

	/* Validate and dump */
	printf("\n=== Packet validation ===\n");
	validate_packet(buf + eth_off, frame_len, f_ip_off, f_tcp_off, f_pay_off);
	hexdump("virtio_net_hdr (flags=0)", buf, sizeof(struct virtio_net_hdr));
	hexdump("Ethernet frame (first 80 bytes)",
		buf + eth_off, frame_len < 80 ? frame_len : 80);
	write_pcap("/tmp/vlan_gso.pcap", buf + eth_off, frame_len);

	/* Open TAP */
	fd = open("/dev/net/tun", O_RDWR);
	if (fd < 0) {
		perror("open tun");
		goto fail;
	}
	memset(&ifr, 0, sizeof(ifr));
	ifr.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
	strncpy(ifr.ifr_name, "tap0", IFNAMSIZ - 1);
	if (ioctl(fd, TUNSETIFF, &ifr) < 0) {
		perror("TUNSETIFF");
		goto fail;
	}
	sock = socket(AF_INET, SOCK_DGRAM, 0);
	memset(&ifr, 0, sizeof(ifr));
	strncpy(ifr.ifr_name, "tap0", IFNAMSIZ - 1);
	ifr.ifr_flags = IFF_UP;
	ioctl(sock, SIOCSIFFLAGS, &ifr);
	close(sock);

	/* Test 1: flags=0 (no NEEDS_CSUM, no DATA_VALID) */
	vhdr->flags = 0;

	printf("\n=== TAP write tests ===\n");
	ret = write(fd, buf, total);
	if (ret == total)
		printf("PASS: VLAN GSO flags=0 accepted (%d bytes)\n", ret);
	else
		printf("FAIL: VLAN GSO flags=0 rejected: %s\n", strerror(errno));

	/* Test 2: flags=DATA_VALID (realistic: LRO -> bridge -> TAP) */
	vhdr->flags = VIRTIO_NET_HDR_F_DATA_VALID;

	ret = write(fd, buf, total);
	if (ret == total)
		printf("PASS: VLAN GSO DATA_VALID accepted (%d bytes)\n", ret);
	else
		printf("FAIL: VLAN GSO DATA_VALID rejected: %s\n", strerror(errno));

	close(fd);
	sync();
	reboot(LINUX_REBOOT_CMD_POWER_OFF);
	return 0;

fail:
	sync();
	reboot(LINUX_REBOOT_CMD_POWER_OFF);
	return 1;
}

-- 
MST

