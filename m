Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328467;
	b=c8TCwvu/2o5IS5Ia1K0Q2FGJ8cN3fOoso1q7l2zAxSWn+8poVYhtxvUM/mNtSipGlp6F
	 BQ9OSZiGd3brRCrLfYW5Rhyl2ahclaV6zVnqFuJV6/tqOPsowferoPf4rjnDqgYRVu0Ur
	 yRXrjkIuqoV0uLd/d5I7pw1sENZnDw2y7Cd5l32IwbKOQBPGr0ezTyyuoowsxpv0CIlP8
	 GiLtRzMqWhtoMUkBNwdHgPhkcGMlloVhbzRSRTOOKOa3AYwDIc8SdVwKDrABUNmueUG+R
	 CU6Ix/GpphRKMCyf/Jv2NkB1QChv2GG0Vz+Nikwx4Es/IJf/5XVZF8lFI2We/blnXeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=y+V2JxIlVOChITFgo1z9lTreH4E5kp3RpfFu+UewLVo=;
	b=u5BtI41BQnWHYL3c2VmKOyYuhbarCGQRlIGRFIgZcnd62KlMza49QK6RpmvlU4seoeMa
	 iqjOjpUFjL2EpVDQCWhCHfBBTQGcPR1MF+GosBcRFVPRfDbCZJXu/aJ9bN9YDAreWOeAj
	 l9ZFD4XlbkkDS7uHhf/QWww8im6BK7C1eVHO9mWu5v5E9buso1cYTUTvi4aSMRvsCNphD
	 66tE7WATmK+mMeUYVPjQU5GrD5iOicCgSxOFv3lO43JiNnhMwk5GMjyRkbiL5JliG21ks
	 ItHrqxmORyf7guW3lRbpaV3+r/S09PX6YJJ688iG3XG9XxU3ozn/ROjsdyBBrUOJB/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fSy8tcC5;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CB7606A227
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52CB7606A227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fSy8tcC5
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7d2ca055399so716853137.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328466; x=1794933266; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y+V2JxIlVOChITFgo1z9lTreH4E5kp3RpfFu+UewLVo=;
        b=fSy8tcC5IqRPJ8T9YRj22z1qFAkPgpRi2kcT3apWfgMEplaE1W0onrcdvaL/BL/ywE
         rOSS0ydfaat3r8gteyf5+yftpLD+2I78ebj6isd5tSmAO9uXKA6drfZE2fPbEDLgB8tv
         4nj5eU6BbFuMME+jx7QiJhMbdOwnH56XkB3/HT/fr1ZGQooLEtuVaD6KLZUnJ4xbTN5H
         VkTk3pY/yOZ/w9fPvBKK5wNUDrb1f6zcpKrwD0C4hM87Oys5nnQ81EVXkI7GaiyDb9rK
         5iOj/aarsL/qQFbE1WK3Ho0Kl6BxOfVqScOWNlF4Xqlcyi87wAdVUnIdMg2NDVulzXnv
         hkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328466; x=1794933266;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y+V2JxIlVOChITFgo1z9lTreH4E5kp3RpfFu+UewLVo=;
        b=MAERsZI6QL/KzW8dFeCI8xpAdXC2SP5F/JaYe/Fe8KBXANfJYG8fc4GkH2N2NeRmiX
         Om46buG3RRybSzqQizfFYD8caz2noJwyFR0V5spldX4XAV47YyDW78TQGHpoam5vhGyp
         H9PP/fBQNxDlgIuDaW6SHvEVQw40VePbepz51rU1tyc3giFhq+/M58cN7rqNiX+oo9lQ
         qAmPhguOqKRglRG5ysKhjwFLY4uQ3KuTaFjBF8K586W3r8ujsy1HOBOqn52yF3cZnaxV
         24NY0Yqsqr0CJVTqj8USFFDCXk8G4lCOfA6LiBUfM6mSd+fFiuLHL/8b3xb88e/jV09n
         XBgQ==
X-Forwarded-Encrypted: i=1; AL+hErE9fkvxvn893YZiXZwlYcadAISh4lnwallEAQiII03Kc+tS5761kNlErPpMSUOo15JJtIsDFG8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eZAqn9DwQvzv53cGhF0taQdQ9uYHetZN4dw6jJKyZ0rCU0WRX
	lXwjrKZgbZ6tIbmXRRy/LP71xXjNDRXlGFMPBYN+xXQL1j2RvX5/pNhw
X-Gm-Gg: AYBFou34FF6LZsXwiSBm4XMzqilbo/6bj/Felhs0Vv3BPWGY+rVi58yIiir8FI0s4ym
	Ro9ElCPmlyLvUUX2BGyPXpZfQ3j0JholIbFS6XckRlUar4rmBomcp2pwItX+6ngComg6pLJyenl
	2URSem+eWcguLZ0+lEwGU7RPlo8l2AyKsmQm4EiPdA68oQaUWmYO0mi5FZ8tRNqX2DcGAbwWtPC
	WKt9ofjJhNpSiQoiK9LGaUFpk/CPAnQ9Fo4QaFNx+sCOVawQS+/OVUmHFvvyL446unToKO8p1Pb
	M8TF2xUAIjV048Nku3FnJMyX5sBhqSxKSWoI9smIAmg7Dq4TjhXqx1nVI5O5M/Cg9dSfPJ0vA5d
	hAitinOfF4q0BiEeUUH2ulVIuA1ovGwEJ+eVklxs9XAC/5dbFDpJS1sMRCiw2KcSChU5suCV17A
	1PcX2dO+R2FYo4u9k6FgXtv6j5KnyItd8OyQqZFr3bmCnn/2sGtVFjx0tBDl/atlujtEwWMneIA
	xYAFSEALSNjKvDO84agWn9dT+WUS7JmcVa2Mq/ocSWRNucvewTwsmabkJ/awF4RL6a50wvlETLy
	c6qEiH4ZepRVb9R70Re1zbfYx4F2f6U7NrTPs3EBgx2DS8NmOBKHYwISyRKpO8mJufRuNpAjX8b
	S6Ain4uxCjK62f3/00Z4tAcvqrxTpxeKjDG+Dwg7te3guPg5paaVMiRDFccU2RQUTpubnJr5Ia/
	N7eZlZPFN0BojgD3nQ
X-Received: by 2002:a05:6102:c54:b0:7b5:7cd5:2a1b with SMTP id ada2fe7eead31-7d301b9d79fmr866580137.10.1794328466169;
        Tue, 10 Nov 2026 08:34:26 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200838f0sm2147394241.9.2026.11.10.08.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:34:25 -0800 (PST)
Date: Tue, 10 Nov 2026 11:34:25 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 kuba@kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Eric Dumazet <edumazet@kernel.org>, 
 virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 kvm@vger.kernel.org, 
 namangulati@google.com
Message-ID: <willemdebruijn.kernel.4096b48e9e59@gmail.com>
In-Reply-To: <874ido29iy.fsf@pengutronix.de>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
 <willemdebruijn.kernel.1d6388f036c46@gmail.com>
 <874ido29iy.fsf@pengutronix.de>
Subject: Re: [PATCH RFC v4 0/6] virtio-net: add receive timestamp support
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Steffen Trumtrar wrote:
> 
> Hi Willem,
> 
> On 2026-11-01 at 09:57 -05, Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> 
> > Steffen Trumtrar wrote:
> > > This series picks up Willem de Bruijn's work on a virtio-net receive
> > > timestamp. The device puts the time of arrival (TAI, ns) into the
> > > virtio-net header so the guest can use it for PTP and RTT estimation
> > > without taking the timestamp itself after the host-to-guest latency.
> > > 
> > > The series is an RFC. I am mostly interested in feedback on the
> > > approach and on the wire format:
> > 
> > At a high level +1 from me.
> 
> Thanks!
> 
> > 
> > Some comments inline.
> > > 
> > >  - The timestamp is a new field at the end of virtio_net_common_hdr
> > >    after outer_nh_offset and ipsec, offset 32 (see virtio spec),
> > >    negotiated with VIRTIO_NET_F_RX_TSTAMP (bit 49). Header size now 40
> > >    bytes.
> > >    Willem noted on v3 that virtio_net_common_hdr was not meant to be
> > >    extended this way; I kept it as the simplest approach, but a
> > >    separate struct for the timestamp header is an option.
> > >  - Timestamping is enabled at runtime with SIOCSHWTSTAMP; all
> > >    supported rx filters behave the same for now.
> > >  - XDP programs can read the timestamp with
> > >    bpf_xdp_metadata_rx_timestamp().
> > >  - vhost-net passes the feature through; the timestamp itself is
> > >    written by tun. The tun patch is only meant as a reference
> > >    implementation for the device side.
> > >  - The timestamp is in TAI.
> > 
> > Is this a requirement? It is common for PHCs to be synced to TAI,
> > but not 100% the case. Does virtio need to specify this.
> >
> 
> No, I don't think it has to be TAI. TAI is only what the tun reference
> implementation does (ktime_get_clocktai_ns()). What the guest really
> needs is to know which clock the timestamp comes from, so it can compare
> it with something.
> 
> One idea for the spec change: don't fix the time base in virtio-net at
> all, only say the timestamp is in nanoseconds of some device clock, and
> let the device tell the driver which clock that is. virtio_rtc already
> has clock ids with a type (UTC, TAI, monotonic, ...), and the Linux
> driver registers a PHC for each of them (with VIRTIO_RTC_PTP).
> virtio-net could carry the virtio_rtc clock id in its config space, and
> the driver reports the index of that PHC in get_ts_info. That would also
> fix the phc_index == -1 problem you pointed out in 2/6.
> 
> What I don't like about it: virtio-net then depends on a second device
> being there, and with more than one virtio_rtc device the clock id alone
> is not enough to find the right one. Without virtio_rtc the driver would
> not offer hardware timestamps at all.
> 
> The alternative is a PHC in virtio-net itself (gettime over the control
> vq), which is a lot more spec for one timestamp field.
> 
> Do you think the virtio_rtc way is reasonable, or is there something
> simpler I'm missing?

I don't have an obvious answer. This needs consensus.

Hardcoding clock base to TAI is definitely easiest.

Outside of virtio, the relationship between PHY RX timestamps and PHC
is well understood. It would make some sense for virtio to follow that
model.

But indeed when having multiple NICs and multiple PHCs, how to map them
I think is an unresolved issue in general? Of course, aslo moot if they
are all synced, which I think may be an implicit assumption especially
in the world of spec compliant PTP.

And, if virtualizing anyway, it is feasible to do the clock conversion
in the software device, not having to bother with all this complexity
inside the VM. Though maybe not for direct HW virtio-net queues.

