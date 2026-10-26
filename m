Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004570;
	b=QYFFMIofdCSdoITT2eTXfzmTTYK5VAQX0HSZtejtSL+bcrdmYYQF0xjwhMJY81KzRtrv
	 qSOx+bLoqdr+yRyzFzC8yZMaS38GiGa/jO/Oherp6iu4xdlfjxzfxVRgnGWl/v/NQKlqj
	 g0ywKLTfvQWAW0VOudrQQXA/gQk/MzMacbudO9Cege7TMu+TZ9YKcUEzvBYf6Hwkw3+tw
	 VvHhUCrqTRifNIKdR31b+WB/80O6CXK/5rReF+BwkFDP336hYS0iudTJpJZot9vkUi5CJ
	 AWRoEMzh86Mx9d/LNcAZQhG9XKEGQuixhi1hQq/HGSsSoIEmfSugYmnOmT3PvRymVmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004570;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hEUhlXYmOnvIx32pUMr9YOGu/KYKt6iMeMoyJb1Rp3I=;
	b=JHSkEhYnaYAe4Y7IoVbTm+CllkV7lTM4PoLtlBg2VYzH9RtQlcWMeT7EygIo2WcDM98b
	 xoRRvuhxhst9tj+dUzIjtyy3FczsDv/pexyVN/MDcBRzdElp2NJmK0FG07z5ksDdBRNAg
	 CC/iWMonyn1O7h/2JhDJptZezy9G5MeEU1gcHyDrzqmFBYlnYh2Htek3R5oCemcdFMDcE
	 eS+vM8PpnRG8IqWWTwLEnQtORDrHfCD8+7hJt02rzje6cjUzdAIPow0SY2/y0SP1bOHqT
	 n/pXsYLBJzq4liATKW4GeGsHR1vAhIUsmxg2le8L8K0ba1lBj1VA/vlG9SEF2umU+0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vnl0om8K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3375D606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vnl0om8K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1123A1F031E1
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 08:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004570;
	bh=hEUhlXYmOnvIx32pUMr9YOGu/KYKt6iMeMoyJb1Rp3I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Vnl0om8KVDS7hqHj+udnO7hkLlBn+sitgsxLsJXTL8ZebdSwEijKyVFP8cHTzFLI5
	 mapK67swQ1z4PlG9lrl2WvfzNI8wON+74huoK/rS09Sh0QI8+ePuAGlqxDtvQb27sc
	 fiO0QlrNTu+xJk+szl6euNFxFL2PE1kUS9P3a/WEXAbDSGvhJtc5dxhRSCpDA0Zo+r
	 FNYYfJ6nvAVxmOFJ60IKbZnTJxhN+EFRcQfkWsd3g6cLbmy58Z8WK/MD39ZyRAhl6d
	 ThbUEugoBHqYIXXqJ6b7GCVFd/Ed1apAYcbb1jlJPxg+1q+2shlfnsttLjuj35fMdZ
	 OOP897kamzxrg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-49429181ce9so1533196fac.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 01:49:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxtMVQPIc1mn1akKfTlN3kIV6n/mU4oa1/HcZ7hofOzlgsSn7ftekRUvnjwIQ1n/XvwlMVPg1M=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWDbG/SpIeH2iMW4qITTpukEf02w81Ax4/6OaiSKjx6S8gOiva
	01tOEE/a/l/pKsuowyzqNUL0ED5UmMAZOwnWswtc43uawzy/8sSkw9Nf80sLz8r0mKiSDckHnFq
	ggq0dGkOHcSPuxK3YpfWIYNhnn/u0yZs=
X-Received: by 2002:a05:6870:638b:b0:4a7:5256:4643 with SMTP id
 586e51a60fabf-4a83f1cb6b4mr4108141fac.3.1793004569380; Mon, 26 Oct 2026
 01:49:29 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026082035.335770-1-edumazet@kernel.org> <179300318428.3327.13029076428746317520@kernel.org>
In-Reply-To: <179300318428.3327.13029076428746317520@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 26 Oct 2026 09:49:18 +0100
X-Gmail-Original-Message-ID: <CAL4WiiobBKAoqcyEu1P7GkUFJe0=w0hH2NFz2Tf2V=oWCC=hAA@mail.gmail.com>
X-Gm-Features: AclHuK-kCs5qDDd7Sd5Jz3gus2y-tEzXAz5O5Yd5Te4LMxEQpTSZWeyvvIGCESM
Message-ID: <CAL4WiiobBKAoqcyEu1P7GkUFJe0=w0hH2NFz2Tf2V=oWCC=hAA@mail.gmail.com>
Subject: Re: [PATCH net] ixgbe: reserve TX timestamp after skb preparation
To: netdev-bot+sinfo@kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, stable@vger.kernel.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 26 oct. 2026 =C3=A0 09:26, <netdev-bot+sinfo@kernel.org> a =C3=A9cr=
it :
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>

Manual code inspection, coming from Paul Moses discovery for igc (with
a reproducer)

Several Intel drivers share the same defect.
A similar patch for igb is also needed.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
