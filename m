Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0432F12CE
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787644012; cv=pass; b=NYhnBA2qCS6IiobBI8NTLhtBfYiBWzC0W0QE4fCTGdFHQXlrbbfLr7VNt1+HPhJSZREKtsQDLCcDAmuPkoTy5yeR4CENNvXjU29OoKiimDHfiD+k2wqV5P5MBtJKv8bNMJDzV6ulIJb777Un+vhRRIVlk86RDBvN+/JPOYNIqiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787644012; c=relaxed/simple;
	bh=ttxtJzAnZ23ah23t+GTv0gffKT+rgBXkbjdDED4PoMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4lR1yUPxKJdzjerA9AYyPZnCoas/1506HOM66c9lsTcRtrOhOVQsrTy/kbPmdkQq1wVT0EVk+u6KRPOYVgWF1HiqVx1kKH119gQrb0Sf0eVU57aHlSaAIPk7p0F6iA6FIwr/ljUuUx3OjE0NsxIkgVgWa84AA2bBwBsAq/S7/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VEqW8x8j; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VEqW8x8j"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c4436d02cso23426421cf.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 00:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787644010; cv=none;
        d=google.com; s=arc-20260327;
        b=EJ1nQfCvyMWvtBZsTQqB75RX2+SqhOe/GPYHj4Lx6mYhyj7RCnYnmFZiaLqzoz4dV+
         VnzgfwouE4L1yoe/zLay401VzY+7c0LPKireW4ltHiMw+c64wZFtOlwUOt5jO9uTTA31
         Wkv8JaBEVcjlajF7velAAecjtkf1csRC9fj102W5LnMfI/+YPQxGQUOAVZydfGHU9T/t
         zdvm4hulYe3l7g6a21abKtCgjFk1KM+rCpTTWEScvErgl2lTvKaHFxU5FXYs7svxG+RI
         iTUf3hJB17Si14vBDFQMQ0WKmFPG1N7fwMmCuQaT9WbUPTUTMxIuw+qVgsKG6d4l0aDZ
         Yq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ttxtJzAnZ23ah23t+GTv0gffKT+rgBXkbjdDED4PoMI=;
        fh=zrpTQTG/ql6ZmcFrGczv713GT3L8maXQxocegSbXyDY=;
        b=gqdzDmeOwb9K2NWmlenVc/lCNdXLnjleZidONhEBareY1LHHsj8zXtJ/jmbnO/6M1q
         /oXZ+/Z630A+fiY+E6Wfc0AsVUkMein5nfAZik0W/wLNGWgwOihDS1VCNeS4J38fBaa2
         JxmFZUg/7V7CKL3Bo8wPakcA9bjIWlbl36mozvm6hRxCroI2ApHnlJrE0bluNABAzQA3
         eHVlq4AFicUz5R+JhCfg7fAQmM3lBP3xTq5MvqYkQrHtwJ6Lj4onuWGbrKkSgIrBSBA9
         1KMOlg2U8zrQ7RDJdN6aYApcW9sBmbBpiA6OFXhrsC2PsXH6OLS0m3lKckwvt8Enh2LS
         a0OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787644010; x=1788248810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ttxtJzAnZ23ah23t+GTv0gffKT+rgBXkbjdDED4PoMI=;
        b=VEqW8x8jA/2jl2ZE6VPkhkx9TgbfKwAStvxp7/rQSV8TuGPkwxTfXtq7h18R7tcPUn
         2wGWzvd9/k6ZHRYLEoeiaTL/o0dqPIt7nHQKPfYZelUmOL3gYyZcqxpowxFqbj60d8RI
         LmqkmY3rnpDMMgZfzTjJOPZiepVaCAWCw/4EfJxKZCO3RXv6MsM5dHx3WYOVmu4CDfV8
         VePkA+U64Cnb+4NwhCMbKs2LHHfmtz39W4OVQ2siO/76owm1tyXDe8kKwE5JiIyJllER
         wlc37LyLj85LUeU7kwCnttNVoszoQ3zSaap6InfESlYgsfrubWcf563PfHF7xE65svCY
         JQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787644010; x=1788248810;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ttxtJzAnZ23ah23t+GTv0gffKT+rgBXkbjdDED4PoMI=;
        b=OrdXJX8zs4uTDpd4l5e1dw1+mOxJYDxv/AgLvpdswVCmyINB1s8u4MRmacAv/wnB2/
         Wiy2i5EVedOUwpeL/J7KHv/PnVKgOA4Qsnv+b4B8JxtaSX3FCwRqaIvcPMc75mBNcFu5
         fibVWVnVc3Xmi/w2prXP93yznkGs3eGlsb0ZWP2Q3KQMAAQVLiDtUx9myqTMTjP1cL40
         gpD1d3MzBztkzLNGgLlGgCTLNJbvBTwtE25u9Vi9Igzz3mqdsAzuypErAhe/2zIbmh+/
         MkWe8XQVDL600G/BRvYbAlcw5MFGrj+Yaax77BwAR3r555gfy21ltsDbaUZ3W5I5u8Ht
         XxKw==
X-Gm-Message-State: AFuF++kSs4+sEeBefuU0zzYfzoWydBPPnlatVGIf/pI7oGWfOO21fuiM
	+Ijft0rTh5K4twLJWk8+iw6DJ+xP7qbdj+iC56pEQfSsXfr5dIndhWPDJ4IcoFYqVRIHnxOe+J6
	1P1D760D0YxZFSz6OyKKjEUNtXcmL4bsxYVjE7x8e
X-Gm-Gg: AR+sD11QIyWlbZv3c3LXjNPPLRpo7tSg/S8EbQCqDXOMoveWvsXnleEdse8eo/YPBzm
	/nGk12l6jfPuCIu3i3jmN9hB+uurKnBbMwXfBjkz6tpYIWh6c6MJ1cDKg6MmGi4Qj7IEumP1nYg
	ko7UrDLkO7sMeW7/VKK4taYDveOAjh3zfdHj8HvfQcDNd93dOobZ6hGeQ7t4oJXiOjDgNItAS88
	9OBT1zis/CCImKwE+OcWNgnGWvs3jIN/0tNFQ/nRnkMjN5x88yzOEd49G8Ja4UhFlR5i/ncog5L
	uhuyozgpLm+e0NXlUi6mC6gEmktqG5uL3nDbeDyrHg2U9KcUreFsLM5hMZdnbG2oqrMwJq83cg6
	1tMDrQgaRS2+09JM7YDPr3wbgZzfY1qZXa4FBtDTLxbDSUVdJ0IQSc3Ze
X-Received: by 2002:ac8:5d53:0:b0:52d:4f43:d5b0 with SMTP id
 d75a77b69052e-52e2f127d41mr46851271cf.22.1787644009638; Tue, 25 Aug 2026
 00:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825073906.336072-1-junjie.cao@intel.com>
In-Reply-To: <20260825073906.336072-1-junjie.cao@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Aug 2026 09:46:38 +0200
X-Gm-Features: AcwNN1XiLbiOvHuA3q6xV8JUEzswX2XPmVf7AnoIH9VKzNo5sG77hMVOJSW990A
Message-ID: <CANn89iJgKaJHmhG9f2UVV2VbQLaLE50VEpu03xSdEY-OucrgeA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dropreason: add SKB_DROP_REASON_IP_TTL_EXCEEDED
To: Junjie Cao <junjie.cao@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 9:39=E2=80=AFAM Junjie Cao <junjie.cao@intel.com> w=
rote:
>
> The forwarding paths report an expired TTL or hop limit as
> SKB_DROP_REASON_IP_INHDR, the reason otherwise used for a header that is
> malformed (ip_input.c, exthdrs.c, br_netfilter). Nothing else in the drop
> path separates the two: IPSTATS_MIB_INHDRERRORS covers both, and the TTL
> check runs before NF_INET_FORWARD, so netfilter tracing stops at
> PREROUTING and never sees the drop.
>
> The Fedora bug linked below shows how that reads in practice. The
> reporter took kfree_skb(reason=3DIP_INHDR, loc=3Dip_forward) to mean the
> software header checksum check had failed, and worked through RX checksum
> offload, tc csum actions and both libvirt firewall backends before the
> drops turned out to be replies arriving with TTL 1. ip_forward() never
> verifies the header checksum; that runs earlier, in ip_rcv_core(), and
> reports IP_CSUM.
>
> TTL expiry is not a corner case -- every traceroute through a Linux
> router goes through too_many_hops.
>
> The three loopback hop limit checks in exthdrs.c drop with no reason at
> all; give them the new one.
>
> IPSTATS_MIB_INHDRERRORS stays as it is: RFC 1213 counts time-to-live
> exceeded under ipInHdrErrors. The drop reason has no such constraint.
>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2517131
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>

## Form letter - net-next-closed

net-next pull request for v7.3 has already been merged, and therefore
the net-next tree is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#de=
velopment-cycle
--
pw-bot: defer
pv-bot: closed
