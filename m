Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114865;
	b=NxO1Opzz8+9SVSG+1HRCBxsE/RfFHt/LppmBmbgi2MC/g/4xGznYzsmCvRxsi78UJ1h4
	 uftC/sxhDFJgo+TA64jZIxiFrAIbV4dktlIcsDaJiaVWRSBF7zdOtik5jNVFLLOPIw/Yx
	 zUKkAVjtqMxpS/i6RH99YKrOJgPvMj4rF8rFttvWvXrFVe5FkmqgXXVCYh8c332dUJfhK
	 X0VXDbEUnmhN/UpMQP9lGXL80H9pNIDHpNihQn6zmxvIcmibG5fmX9PUjjNz5+2vSx0P6
	 a9XPV1645BIDNKYjyFOZSBd6do0XA1bAehAJ7CWCWqFuSKZnBCJpWLKIR4uRUHsnMGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=uqwtnNOMKZ62ohb4pCxSL5wBGLnxx/MLeyk7MYe67bc=;
	b=pzAS+jrUKjULYa7lcSN4wjxuv2Yo/N5fj/GLZ1KfceDXwqsZsBwjbGYqxrOEb/nnK/hi
	 iFnb4j130r+NEb6y9J5dh6t/gy671hpjBR34miMsGOe9gxYQwm3YwERAEpK0EgfktF4aY
	 b/A4CJW/a7DWMzZqUuhfdsAdALU4MAGd6ecAoZZ+xyzhwxJi+/X2SBpy/1APoqhixNFyc
	 1UGvBfxJ3s8sOZcHGRpFn1ZIaQyLfrN4H8VKf7GE53/I9MVWganwvqSllhgWZo0+iwN85
	 Sa6yblJH3pVZa3AQBsXjykp0Z40Q6yi2Z+guXGhPqhN2/sMzfzPPZg5VmBkzBWgZXpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zx1yak+H;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF973606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF973606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zx1yak+H
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91c76540d0bso289276d6.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793114864; x=1793719664; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uqwtnNOMKZ62ohb4pCxSL5wBGLnxx/MLeyk7MYe67bc=;
        b=Zx1yak+HP4vRh1a7K2NP1uGeEoVYSv5PWBRg8nmWiinXpO6HtYk19YC0TO2GKJUQpG
         AbHXCPy5c9GRnlxzBNGwoNDkjI8KfLr1z/1gO1G+XNPdZAw8/IG1XwI30jKNNg4ldjOy
         sh+rPdeZbxz03X42r07RMAnnLSDscRiB92jAOrtz1RZ00JROwLooZP3BvYRFfgusczZr
         n/Et6gNKJv8yxxssxKLyODZIDYq9IquF9P6ip0XYT9P33OlaM/utbO0z/HHvNmqt0iXa
         wJa8DegfBACV2xpO+Lnsn7vCgEhJ6k9a4/7Beoa+fbbcHKsihGspDNfqO112CHzj8A0v
         kZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793114864; x=1793719664;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uqwtnNOMKZ62ohb4pCxSL5wBGLnxx/MLeyk7MYe67bc=;
        b=sYMf9XSq4ib+tzWE+GrxrHseabo5xg6yXQ82en5BNgodwJYqeAjKV7uNUMgjDoOead
         8HTv8Kv7Te8tSEDSDsYm2Wx2S9EIUSSK+EKnDi039xX8wROcVrOZ6ayVo0rA85nYvoUA
         SGry9/sLEWI4lrERw8T8NG29vDBRnva5/lozwilxUmlSBahOEPgE0PtYm7bOvvT2uUXW
         Fz4//gv8cvXL2RqNe8m4eC91KRXnaECMhCdYKEDSvfKBlBGqjNJj9Z7K+ZAfYv2N/qTH
         en51KIvbgXCkbCEgJTRsXxRvu7b81p5ty6Qa8nF6keb8X3N+wknye8hZcFVCeQI4/lYL
         6SKg==
X-Gm-Message-State: AFq9FYKQjDMmEu8Zo4tZoRRJS6ufhkiN/jN8wZxIaV0LsUhMoY2RZ2iX
	GyUaF2f+P91SGMEuO+reRBojbGOHI1AvOH8EaVqMbNl8Kxwfer+/n5cL
X-Gm-Gg: AYBFou0/lxnY+2/tOATK/TcWp0PvHEs058Ub3niTgk9eL5Dmkm0dB46GHv54/bPofWW
	C20TxLOiKJuSp8kBRk95mwfViIJk6paiKITxrqeQUM/CVtGVdYyeOaWBmP7DJFE5/ppt2od6mfS
	1RFjWjCSStxZsE0pwllvsAfS96T2NxLjL5ob6o23J3u1NEZlqHPSwHHFch/XTtBI+ELpGJoFYwh
	j/r7i3cx+SUlEmC77jNMene4Dix8tRojemzBhOTH3qyHWH9dsotNLUlQvZqcA+hUKmv30Tvoqyh
	nyKEDJVaL2eCuB05sfie8Rt4Fpr4bIcSpD/rsalQUH/sokM5aQUx8brRSBI6X9399JHZq8j/KRo
	of982D+kF0y8hhUAyKQS1hPAtb47rJlxwIl5bHrzRbliZ/zczE77u+ZCfd/gX2/FAWewIYUYugM
	GSKctJwMr/S34kOhAEP0qZkt228GaR3hsxpQ8m0UxW49Tc6AT2TZdHydv1am9iVN14EDvoSsxzI
	H2YgIzaaTExo5vVyclPcD+1/du52TtWynxKQj45jPE=
X-Received: by 2002:a05:6214:5093:b0:91c:7673:a417 with SMTP id 6a1803df08f44-91c7673a830mr20960306d6.50.1793114863756;
        Tue, 27 Oct 2026 08:27:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::4:1ee2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c6e20ba4fsm27571496d6.14.2026.10.27.08.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:27:43 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 11:27:42 -0400
Message-Id: <DMFQ63T8HLVV.3L1SY71TO7GHU@gmail.com>
Cc: <netdev@vger.kernel.org>, <borisp@nvidia.com>, <saeedm@nvidia.com>,
 <leon@kernel.org>, <tariqt@nvidia.com>, <mbloch@nvidia.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <daniel.zahka@gmail.com>,
 <willemdebruijn.kernel@gmail.com>, <horms@kernel.org>, <shuah@kernel.org>,
 <cratiu@nvidia.com>, <raeds@nvidia.com>, <rrameshbabu@nvidia.com>,
 <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <bjorn@kernel.org>,
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net v3 2/4] psp: support ipv6 extension headers in
 psp_dev_rcv() decap
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Todd Bert Freed" <toddfreed@meta.com>, <netdev-bot+sashiko@kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261023234640.1459291-3-toddfreed@meta.com>
 <179288570143.3134.8925369868949382653@kernel.org>
 <CADh2yMyYS-PWP4912En9D6B9up6Kz-hnCthNkWot+e7N8-q7ZA@mail.gmail.com>
In-Reply-To: <CADh2yMyYS-PWP4912En9D6B9up6Kz-hnCthNkWot+e7N8-q7ZA@mail.gmail.com>

On Mon Oct 26, 2026 at 6:05 PM EDT, Todd Bert Freed wrote:
>> [Severity: High]
>>
>> The PSP ICV doesn't cover the outer IPv6 header or its extension headers=
.
>> An on-path attacker could take a captured PSP packet, insert one of thes=
e
>> headers, and set saddr to an address they control. This assumes the
>> device authenticates such packets, which this patch's premise implies.
>>
>> Several of those handlers reply with an ICMPv6 error that quotes the
>> packet. With default sysctls, this happens for an unrecognized routing
>> header type (type 0, for example) with segments_left !=3D 0:
>>
>> Before this patch, all of these packets were dropped at the is_udp check=
.
>> Forwarding the decrypted skb itself looks blocked by
>> sk_validate_xmit_skb() ("unencrypted skb with no associated socket -
>> dropping"). That leaves the ICMP error path as the open channel.
>
> Agree with this finding.
>
> Ok, this puts me back in mind of the approach in v0 of this series ; just=
 drop
> packets with extension headers. Actual support for extension headers can =
be
> done separately from this fix.
>
> pw-bot: cr
>
> -Todd

Like Jakub points out, this equally could affect tls offload. We need to
be careful with any features that can result in device-decrypted data
being sent back onto the network. Another gap that exists currently is
xdp tx or redirect. That would also affect both PSP and TLS offload. I
think we should try and make these features work with crypto offload,
rather than building up more and more defensive checks.
