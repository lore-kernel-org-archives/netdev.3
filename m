Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515533;
	b=VBD3HElwow3aGAAsvZdxGjCeyB9QpJTexH7U1EB5GacMhFsT4j+JEWrTWRHW1P8mZvhe
	 tp6Kp++JkiiHfddCRaocQ4zi0wulGtyRsjqi9UD97XqaixmgblFPsS6IkPdZr/tG9xgfs
	 tcALkJhuqXpIhTNsr1krj8E9KLXPHXbv0yDmUS31y+r/ISeE2YjXE5UgR83VhIiMy7OFy
	 gspCOjQcCJsJDYXUbMXPMh+EHvynb/tiCQPaALDd/lPTC7LCQqvqhB9DGhhrn15O8uBND
	 nuYWCVIIpbhiDowoPbVESVpOTuiicwly1E3owxw68eeb+B92JzvQkXA+3hehd//9EBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515533;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DoT1gWlNcywXL51XhC1dosze2pdAAQJ9HM9HWYdCkOA=;
	b=mh3hgYEWzlrFxxV3O5tgJi0BWs6JVUoeJ/58G4v5opqm1Da+p4K3KR8/lMne7Topfzo7
	 2rDW0gAnM1jNtU7q/CakGpNd6UqNl6qCtP30BQNEx4hUrKDvrlpCOErCtuFN98In7eWsi
	 DlSsDvNolF8ojmsL9qLeYSArSfS8wkrfbo+57UEJatcFEOBZ/HjNNz8O/GjLdGmYTwHXe
	 29KXVNMFRcuO0axwnDUw/2+pN6Soz0zILqqurBAU9wv1m/Bk3nCxDmlNjYdrNi6s0YUGS
	 Tsrtf4ryv4QlrkkcKyYr1p3XHYz4+1YewSwPz879FLneYMadHjPz9IiJJtgoTV338+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJAu0nJ9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE38A606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJAu0nJ9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A6D1F000C4
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794515533;
	bh=DoT1gWlNcywXL51XhC1dosze2pdAAQJ9HM9HWYdCkOA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eJAu0nJ9x7Ljub3U0UxNVpfisYlKjovUyXgwUNhOORuyWvt4YrfJisx84Cis3VKsU
	 3kLt7xy1tPVpDsbMrGl/wu2F9rslDQKiXFhSSokOPkq7sbAyOaj5pBD7v71s+W//tk
	 olkEroLcktV8MPzd4o1Tx1eVCfDOWPWz9oOQGiCgoTcp+PQrcy6E+66CwD0NC0W8We
	 DR10yq+R61qyn/8TfUUTYf3TPAxRhs3xaKbU0zK3ZW3LyiC1vNNZw5bD1oDPYCRspB
	 VO+dpI/dGdcYnCjoFjb15Otb2NyZU7YTOWIrUKRKwKUBYyc0/ALJqdaos2OKkaI4BJ
	 nuxTqow48O6Hw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ab3b29a298so1687241fa.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:32:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFuvG5SQn5NqBrQv+Eme8u/H/elOqo+mh7spXqS43bT9M0YkV8XW/xTOxptbsiS9/Xd/l+ByuQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CWnr21c+lLxzKSxjSWJBTQcYgdJOENRaUZrtyvVuuIUCF0RnA
	H5YcqEWlRUNF/M759r7s94aD9IbJtBFHlA4H10fYQkck9ynep0bATX/qDVAlVbfjr6rql+K/1gW
	HOY9UeKauWXBT7PjM9KhSDFrA4v8CWlg=
X-Received: by 2002:a05:6512:1192:b0:5bf:dfd0:27 with SMTP id
 2adb3069b0e04-5c17079a53cmr156941e87.20.1794515532233; Thu, 12 Nov 2026
 12:32:12 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-rtl8365mb-dcb-ingress-v2-0-f8e6fbdf8c99@pengutronix.de> <20261112-rtl8365mb-dcb-ingress-v2-7-f8e6fbdf8c99@pengutronix.de>
In-Reply-To: <20261112-rtl8365mb-dcb-ingress-v2-7-f8e6fbdf8c99@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 21:31:58 +0100
X-Gmail-Original-Message-ID: <CAD++jL=k8qb+Z3gpvbAZdf7sSqeV3QKZ+vgY-Qxj__vxrX3cfw@mail.gmail.com>
X-Gm-Features: AclHuK9Hf8g52Xh-gfYzwcqfX3g9r9Q2Fj2fZZ5tW4iPcLqaLOZ91aQWc2W5bkU
Message-ID: <CAD++jL=k8qb+Z3gpvbAZdf7sSqeV3QKZ+vgY-Qxj__vxrX3cfw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 07/10] net: dsa: realtek: rtl8365mb: add QoS
 baseline and DCB default prio
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 9:37=E2=80=AFAM Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:

> Add a shared rtl83xx-qos.c layer and the rtl8365mb backend behind it.
> The backend programs the QoS classification tables and one
> priority-to-queue table at setup instead of leaving them at their reset
> state, and offloads the DCB default priority.
>
> The switch classifies traffic by the port default, by PCP and by DSCP.
> Each source numbers its values on its own scale. Use the IEEE 802.1Q
> traffic types as the meaning of the switch's 3-bit internal priority,
> and map every source onto them. Best Effort then outranks Background,
> instead of following the raw PCP number.
>
> Keep the driver-independent dcbnl handling and the ieee8021q priority
> conversions in rtl83xx-qos.c. That layer programs the chip only through t=
he
> realtek_ops qos_* callbacks, so other realtek DSA backends can share one
> dcbnl implementation and only program their own chip registers.
>
> The baseline trusts only the port default. PCP and DSCP stay untrusted;
> classification by PCP or DSCP starts only once the port trusts it
> through dcb apptrust, offloaded by "net: dsa: realtek: rtl8365mb:
> offload DCB apptrust".
>
> Every port in use defaults to Best Effort, so all classified traffic
> takes one egress queue.
>
> Select NET_IEEE8021Q_HELPERS from NET_DSA_REALTEK, but not DCB. The new
> code calls no DCB-core function, and DSA installs the dcbnl ops only
> when CONFIG_DCB is set. The QoS baseline is programmed either way.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>


It's a nice patch!

> Q: Luiz, Linus: should the driver select DCB, as the Microchip KSZ
> driver does, or have it enabled by default?
> A: No. The QoS baseline is built and programmed without DCB on purpose.
> The code calls no DCB-core function, and only the dcbnl hookup in DSA
> depends on CONFIG_DCB. Whether DCB is enabled stays a choice of the
> kernel configuration.

OK!

> Q: Linus: can the port queue-number field and the priority-to-queue
> table use one index, as in the RTL8370 code?
> A: No. Measured on RTL8365MB-VC for every field value, the port field
> picks one of eight priority-to-queue tables: value v picks table v - 1,
> and 0 picks table 7. One shared index would make the port read another
> table than the one programmed. A field value of 1 did not limit the port
> to one queue, so the field is not a queue count. The driver programs
> table 7 only and points every port in use at it.

Thanks for looking into this, much appreciated!

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
