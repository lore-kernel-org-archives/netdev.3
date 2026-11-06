Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958964;
	b=A72eMkKM4++eRdr+GVBf4Mrc1iIoXPh8Zm8jgCWKV7n8bvOijsnuPC0/gjQl3Lkwvb2C
	 +rmvjr+EW1DPd37iLHbbhwYmx9n073brFT6aqnLjzfALomLZGOFbiN5zxZ6zhjr09PAon
	 LiHAKmrIGTctE68lkVZrWa394pHa2d1Xd0zaXfklCWwGF1tyu6wI2/NaW102tkiD/t5WS
	 iUGjr0agCtPJGtmYJtsktLzq2ogUlrBlLayTYId7dIzl6FKMRS62WweTEnUr0sFvafVJS
	 zCjIFQgS4nqllHIfX29YZfUpz1j1HYfcax6SXXYNW8sBpRlk2byDwUMhgkg5QOUrBig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958964;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=IQAaNA5x2J6cR42Xyyfpudju4b6qQzyTPkfO1wBJwtM=;
	b=nqcknly1uLiLn5QDIGeL9kknzOgyuCqs9I8qot+tImWCRB4qXaaItkJIy4MEKwzlC0ub
	 a8dzekcOnAOxO99I5WMrrkSlc3q5CIo/ZLUgSDfSKV71VodV5h6Ysyf9ODxrjCW1ab9zM
	 4nskjt20xwovIu+BsZ19Mqm2w56E+LNuEZpiinPwQqdFwI3cd3bVLipjBMR2Qxp5vpaue
	 /Vjg8mKpkJcAPNEbKj7rnDTUPFig8lHJpf2ExBmUcbS6rnZnIVM48gg9C4CalTduWgb+9
	 j57Ke12S/+Avz+Sd9/sAAUncEHp6GSU8Ah8MJl9ADnVTgLByaae/rbuQLgbiDkkCUzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QsiBVCCz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E4B606A339
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QsiBVCCz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BBB1F0089F
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 09:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793958963;
	bh=IQAaNA5x2J6cR42Xyyfpudju4b6qQzyTPkfO1wBJwtM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QsiBVCCzxxo7kgtGRmXAQtdr5fTHGK9ezJgTvdNVbabLd+lgrohBMUmGKkeAqBqjS
	 BP5YtCaXFgieL4jtdFBt6Cji4i+1yyf9vXglfdbN7CmUyRd67RgmMExls3hqVK044E
	 TASuYApdkH0BK8zhjUG+KwzH1d53hrPJpIpKybkZAPk848UnnIr4CScYQEcLLqDYTH
	 +3RscKrVAxu8DOgBOKiaRm5Rm64EDfqrAsOSA8JopsKgMJRNCx+pL2bJ31poCwCuM2
	 hIdidx4XUUq7nvJsdEXSjIPpiTy14Mcmqc9FDx0lLCrGN2lN9iYnKr+ybow2rSNWue
	 DE5bXNl5GZWdw==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6f74f6b46abso225311eaf.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 01:56:03 -0800 (PST)
X-Gm-Message-State: APuU4Z+8+X2x5tZN34EedXyS0397CliZCjjlqwhqSm66fygb9B40BCW2
	6KodYUkxs5pjTJX5OmqKkJKZ/AZsVW/ESmQR9qPSvARH38S3i/6oM8ghvSwk3ikyn9PtU3zugmd
	afSQP0l0MskLeVrdWeZNQwmjg1zQo1lY=
X-Received: by 2002:a05:6820:628:b0:6b6:c0bc:365c with SMTP id
 006d021491bc7-716e78812f4mr1280505eaf.22.1793958960523; Fri, 06 Nov 2026
 01:56:00 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105115715.1466924-1-edumazet@kernel.org> <20261105115715.1466924-3-edumazet@kernel.org>
 <20261106042744-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261106042744-mutt-send-email-mst@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 6 Nov 2026 10:55:49 +0100
X-Gmail-Original-Message-ID: <CAL4WiirN0keZgyx6bP-+_96FEAsQAHnbkgJ0fC+DcFCY3zjXvQ@mail.gmail.com>
X-Gm-Features: AclHuK8ZDTLU4isi_dgkuIx-7_ncwrjPNhIMfW1viOX5kV74wv3XHkP7rOme_5c
Message-ID: <CAL4WiirN0keZgyx6bP-+_96FEAsQAHnbkgJ0fC+DcFCY3zjXvQ@mail.gmail.com>
Subject: Re: [PATCH net v3 2/8] net: virtio: do not use dev->type to find the
 outer L3 header
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Hassan Sultan <hassansultan@google.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 6 nov. 2026 =C3=A0 10:28, Michael S. Tsirkin <mst@redhat.com> a =C3=
=A9crit :
>
> On Thu, Nov 05, 2026 at 12:57:09PM +0100, Eric Dumazet wrote:
> > virtio_net_l3_start() decides from skb->dev->type whether the frame
> > starts with an Ethernet header. tun decides it from the IFF_TAP and
> > IFF_TUN flags, and TUNSETLINK can set the type of a down tun device
> > to any value, without changing the flags.
> >
> > On an IFF_TAP device set to ARPHRD_NONE, the outer protocol checks
> > look at the IP header at the network header (ETH_HLEN), and never read
> > the Ethernet header. eth_type_trans() then sets skb->protocol from an
> > unchecked h_proto, for instance ETH_P_NSH, and the packet can reach
> > the skb_under_panic() addressed by the previous patch.
> >
> > On an IFF_TUN device set to ARPHRD_ETHER, the checks validate an
> > Ethernet header that tun then treats as the start of the L3 header.
> >
> > Checking in tun that the device type matches the framing is not
> > enough: the type is read again later, and a concurrent TUNSETLINK can
> > change it in between, since tun_get_user() only drops packets of a
> > down device after these checks.
> >
> > Add a has_eth argument to virtio_net_hdr_tnl_to_skb(), passed down to
> > virtio_net_l3_start(), so the device type is no longer used:
> >
> > - virtio_net always receives Ethernet frames.
> > - tun_get_user() passes whether the device is IFF_TAP.
> > - tun_xdp_one() always calls eth_type_trans() on its frames.
> >
> > Fixes: 288f30435132 ("tun: enable gso over UDP tunnel support.")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/netdev/sashiko-outbox-198573@kernel.org=
/
> > Link: https://lore.kernel.org/netdev/179387332014.488856.91119564136101=
07951@kernel.org/
> > Signed-off-by: Eric Dumazet <edumazet@kernel.org>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Sorry, I saw this reply too late, I sent v4 without it.
