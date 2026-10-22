Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635087;
	b=huU+JXy2iAuKhOS63fXmCBrEsJmFLjB9ZgyMYX1qjIVgQHpSwiZpVb6RED1WzsD7ICf4
	 tSTwcmauZsBREriAvGr9Ak5moFCzTWaimC3DKouZFziFX4dVdetvDKd5GPNUoDtQ0JEdO
	 NP7fmOf85iUCh4AcHd2oH9AnC3oRj9v+lROGKYpu+po9lEKngiivAo4TVT6gTs6cXHuoO
	 M+Cz3rJKMdbqoEOHsdSMvKT8lcxAfAe4YOKlonH0ZniTdqxRAhvXt6XwAYLfONFBZOolJ
	 AliuKNU9LSseO2ELHeyYBQyZAPM2PrEmWCKjEQ6ua2EE+W3L6Bgf7od4ljm8UFJHuJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635087;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=UhL0eGZLhzYFlt8HLWhJWkfpVMd7qMCv+gQwIzAte+0=;
	b=Ep3mjPhYqb6+OkaBUvuWC5UMlSJfDXYwz8Ecfp8wGw1QfbVVy6yiuhzdpmRFmdU2/aMA
	 GEKSTMirSCHup+6QEYppgUhWbGbBFSyDC+fNwbAZ0p5sHuxmIBxIf/xEUFLxzN5wywkXe
	 5kipZxrwftWVrkR9PPwvUeN7kCA+Wb23vqPvfVe7E6+Be2Nj2D86d+iBYn4qzAw/oYffR
	 GSeuOywdc5YsVingDYDfEhxHeAxulMKYECpt3wB1HTSugU05k457et6TuS8pbKwksZz+j
	 EXV8RNqpKsgSJQgMp5IK7n86of/HnJBjOHEx3NRVU/eoz3oTjjXmED7FyNNKgBn7Dxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FbGAkh36;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEAD606A31B;
	Thu, 22 Oct 2026 02:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FbGAkh36
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039791F000C3;
	Thu, 22 Oct 2026 02:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792635086;
	bh=UhL0eGZLhzYFlt8HLWhJWkfpVMd7qMCv+gQwIzAte+0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FbGAkh36sQJ4F8hBrZ6BiZUSTqaXeVQavbKnT1t88YHAr1yQV7F8rnz5cA0kfWLMv
	 SiztHX2dGRBQdzvHHQRuXnIifEudIGbMZTo1fiCtmsXYLQTrAZmb6eXRCWygGH/Z6n
	 +phTOylwgNnXkljA2R6pJ9ckipO0BfeYpiZuNUA8qfwh68M0mtd/PGpOSl82/5+5hf
	 DUJZPxR2x/UqDDsJKtDrb1kd3cpNOdIgbmSNOSRxZjsW3wxxeO3nbCroXZTvgsMOIy
	 hSILnF68nHPZDwFSZq9+0zQkY33VJ39PdT3o/YDw3LIpuy033XfmKxo2JGMtlPWxpI
	 EX4wFtfRjDAfw==
Subject: Re: [PATCH net-next v16 4/5] net: dsa: tag_yt922x: add support for
 Motorcomm YT922x tags
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Thu, 22 Oct 2026 02:11:25 +0000
Message-ID: <179263508556.3135.4675535380942875850@kernel.org>
In-Reply-To: <20261020111115.3072180-5-kyle.switch@motor-comm.com>
References: <20261020111115.3072180-5-kyle.switch@motor-comm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The layout comment in net/dsa/tag_yt922x.c does not match what
  yt922x_tag_xmit() puts on the wire, even though the commit message…
- [Low] Concern: yt922x_tag_rcv() never calls
  dsa_default_offload_fwd_mark(), unlike yt921x_tag_rcv(), so the…

--

net: dsa: tag_yt922x: add support for Motorcomm YT922x tags

This commit adds a DSA tag driver for Motorcomm YT922x switches. They use
the same ETH_P_YT921X EtherType and 8-byte tag length as YT921x, but a
different tag layout. The commit also adds a co-maintainer and the new
file to the Motorcomm MAINTAINERS entry.

> diff --git a/net/dsa/tag_yt922x.c b/net/dsa/tag_yt922x.c
> new file mode 100644
> index 0000000000000..b6146a9af98b3
> --- /dev/null
> +++ b/net/dsa/tag_yt922x.c
> @@ -0,0 +1,122 @@

[ ... ]

> +#define YT922X_TAG_LEN 8
> +
> +/*
> + * To define the from cpu tag format 8 bytes.
> + *
> + * To-CPU (RX) tag format, 8 bytes:
> + *
> + *   tag[0]: TPID (default: 0x9988)
> + *   tag[1]: VID lookup
> + *   tag[2]: bit 5:2  - RX source port
> + *
> + * From-CPU (TX) tag format, 8 bytes:
> + *
> + *   tag[0]: TPID (default: 0x9988)
> + *   tag[1]: bit 8:0 - Dst port mask
> + *   tag[2]: bit 15  - Dst port 0
> + *
> + */

[Severity: Low]
This isn't a bug, but does this From-CPU layout match what
yt922x_tag_xmit() puts on the wire? The commit message says "The new
driver documents both the to-CPU and from-CPU tag layouts".

>From the comment, tag[1] bit 0 would be port 0. The code shifts the mask
by one, though:

    ctrl = YT922X_TAG_PRIO(skb->priority) | YT922X_TAG_FORCE_DST |
           YT922X_TAG_PORTS(ports >> 1);

So tag[1] bit n is port n+1, and port 0 goes in tag[2] bit 15.

On every frame, tag[1] also carries YT922X_TAG_FORCE_DST (bit 9),
YT922X_TAG_PRIO_M (bits 12:10) and YT922X_TAG_PRIO_EN (bit 13), and
tag[3] is written as zero. None of these are in the comment.

Could the comment describe the shifted mask and these extra fields?

Also, the block starts with "To define the from cpu tag format 8 bytes."
but then describes the To-CPU layout first.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020111115.3072180-1-kyle.switch%40motor-comm.com
