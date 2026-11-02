Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793662688;
	b=NLytNHuT7PZ9YkWwzOCamldrGKWNhriESW08yCHLWhtneRPgwvbtIKKhsiSeEsPldaX3
	 XoCk7aKi/XYhj9MYjG8pYFQc3qddNdgS7dkkp5t0eAKiFuVBZmr+Jpe2qx4cpQvKCzOhK
	 PF5WMJog0x7P1y6i3UVLmil571ObaGUY90AsQlX9DhHGUK2dVd2yFGWT7HXmsmvK+bDOE
	 P2nJHmnb5U5X8P0/QTJW7rMbH+r4n+2BTSPOp6U0ybJlsBFAwoj1B6f6wxE6UYCZixwvF
	 aKD3ZqNKxT40ZpCNEVT6BqHWWLV8DPomu9UKiYR2OCYNJGJMMl48V+lT4gyzlqf0Mkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793662688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=VgQ+KN2VyFhEnUQIyYXKW6M1JeW0WUnB3l+NuZRm2I0=;
	b=xEbaLdcboX+w9A44MyE+T3ZbgRiAKObsVAUHYUiP0EmRmRaqROpGJiI0SaqFtdAkAYk7
	 MSMCkXKD5S8mdMnN1EVl+5ZHJ/HLw7RBwB+/FRhCllQg6LiNRvggjFlEYsfLZWo/ES7xw
	 pB7HyOMjlKa8PkksK+dJReEX7LbS++yG64mnouKSyc8o03VI3Q0z2ACow16Dcozz07256
	 Em89Lm9E9G8jS+DXJY9ah+XS1wK03kN1I3WPEOv0cXZyCTPoyB6QGzuZogDYIBoM0cRfW
	 095v08nB83aoLBwfNEqjlgvNt3A4u6v7gmCjJ+ajTSfuvbqAjjFF8FOqpBF5Zy+zBtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DwrWH4g5;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A57606A32E
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 23:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75A57606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DwrWH4g5
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-35dc2af1f2fso1468896eec.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 15:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793662687; x=1794267487; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VgQ+KN2VyFhEnUQIyYXKW6M1JeW0WUnB3l+NuZRm2I0=;
        b=DwrWH4g5a2ySoC+GOC6eDg0PYRp7kGP9JqdiDDKQU+vGcurm0exab5wPwxJ0QyOwWT
         2Fy1qABOHcYH4XtCS9N93PB3f5mLk9h1CqWwZKRqQOE0783eu+1pjl+5aBSA8aIDUT5y
         kRsrGrXLGooT2yuPKu1NHWCBJ8t8DbWXvJHSr8qpg7OenSVvzNivb3UVHBsv8XUuzv3d
         EFEs/jZg5QvPXc78m9V/s4lPqx8NYIz1h4wQ2paI/UL85bH2HHR5x0gwnKVWe5NepVeM
         npoBHLbHCq2DQ4oqarJVcLy1iMxKK3M4BZkpFG4cdgyiRfVDfKbEiy4SLaa+Z8J1JNQU
         F6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793662687; x=1794267487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VgQ+KN2VyFhEnUQIyYXKW6M1JeW0WUnB3l+NuZRm2I0=;
        b=y4PjjuNd1D8hOssGoIVXcLZYcV5ZOl0M0kIO4JoQ4z0xw2EW/mkSIwbxyzyoocnjlW
         g/RoGABshbgg7cvwiR2kBMJbpt92YzWS1DvzYbSCsWVEL2qEAsOanrEwTxKTRtBzvH7f
         cdX9JcqhaV+r+22xKRSyPo9dkhI+0GEqCeBBczAI6rwY6Sis6TzxQuF1K0K/5MYJwdic
         XmVGn3SnMJ4wkPaHZnaWI54wlZI6aGD7x09Dk0FNtRNeR4uwi5Q6CdySOq9BIuzEYXLB
         qP4GAKDihiBqofywVKoxcAQyNoVM+MDOkhwuNq2WTAGSvn/sI1VshSmDDPwvH7Qsj5DG
         uVXA==
X-Gm-Message-State: APuU4Z/BPuQ3r3QSIJkFMVT4+EWcfxL2DhALk2RoFDoSBZIGiJKEphsl
	4UYB5xXX7VtXg75/wvDYTvvpIwjSqzT6bSSUAwcsI5B36jVwciaCMpYy
X-Gm-Gg: AYBFou262ifFeThLfrbEC2k3Dh9rt1X3Q1YOxDOGWyMUowL393GIj5Z+t6ahPI3f82D
	zXMCUF6co7Ac+3UhX2DQoJEqu73a9tpttGuAkadyBfC7R30+VXo2tWZOBfwoGNb7cj5xECovU+t
	eEM/LYExSg4J/muP84sO7X+g5um4bAPvIUdxq5YxPmR7c9hkT2Fqv6XXu2H1dT7cGODrf3SXywl
	BLP3yLnqSLTBFuSURvf3PQqIRdHstphObNik3whr5CJa6J22V0VFFuVNsI/iztDNBnrjLwCncub
	28KBsRR3PLvcQzU+Vr4cO60j5uZnw9apt7EpsX6QjTisheupD2Q7XvIjSL4NNvxP8EBqkkPkbgo
	1PI2dpwaX0n8FcrT0SmXvfTOoPmJJtUNmKmXMTam7vFr0B016bHuuStHOfRxHLhM6yj7IXmLZjK
	GpxwtXsEoiaTs/VwpJhhQDIcIoWZKVagimQuh7hqCOXBwsIFKvKq4Zpy2iG0sjIwGfRD3p0+u+e
	5MMe9ASjwWcc9AYi49711oWy+ZpHGN0MKAhOTxVRPyn4DyEU4ce5Tt2s3EcDqUxOMz+fs7EKcdP
	Qkl4kW5C9lZwEENf38RUnQ==
X-Received: by 2002:a05:7300:c7cb:b0:36a:214f:169e with SMTP id 5a478bee46e88-36a4238426cmr18543511eec.21.1793662686396;
        Mon, 02 Nov 2026 15:38:06 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:41::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4239ca83sm1701518eec.0.2026.11.02.15.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:38:06 -0800 (PST)
Date: Mon, 2 Nov 2026 15:27:23 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@kernel.org, 
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, sdf@fomichev.me, 
	bobbyeshleman@meta.com, asml.silence@gmail.com, daniel@iogearbox.net, 
	razor@blackwall.org, leitao@debian.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 4/7] net: devmem: add a per-device netmem TX
 frag size limit
Message-ID: <aukb2qxV5Y0b3H0N@devvm16445.scu0.facebook.com>
References: <20261102191438.1059771-1-sdf@fomichev.me>
 <20261102191438.1059771-5-sdf@fomichev.me>
 <CAHS8izP6BmNJLUdKR0DpqieOVXreR7ycKWmVbtbBtP-kHy7HOg@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izP6BmNJLUdKR0DpqieOVXreR7ycKWmVbtbBtP-kHy7HOg@mail.gmail.com>

On 11/02, Mina Almasry wrote:
> On Mon, Nov 2, 2026 at 11:14 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > Devmem TX frags are bounded only by the net_iov size, which is about
> > to grow up to 2MB, more than some devices can describe in a single TX
> > descriptor.
> >
> > Add netmem_tx_max_frag_size, U32_MAX by default, and cap devmem TX
> > frags to the limit of the device the binding is attached to.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Abstractly LGTM but I'm not sure why this is TX-specific. Didn't we
> add non-PAGE_SIZE rx net-iovs? This should have been a problem then.
> Either you know what you're doing (maybe document in the commit
> message) or we need some more alignment on RX and TX.
> 
> TBH I was dissapointed when LLMs started reporting that
> binding->vdev/dev are treated very differently for RX and TX and I
> have to write a cleanup that consolidates this:
> 
> https://github.com/mina/linux/compare/devmem-teardown-v4...devmem-lease-bind-map-dev
> 
> I think maybe my reviews and yours maybe should be more mindful about
> keeping these memory things consolidated and as much as possible not
> RX/TX specific.

This patch is mostly a bandaid for bnxt which can't express sizes
longer than 2^16-1 in its tx descriptors. And rx is even more restricted
I think? Up to 32K HW GRO aggregated?
