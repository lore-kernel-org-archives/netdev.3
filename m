Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711745;
	b=SJsk9CGyExlkwT3I+hcdHG7unORQs/M2Ad5MB8LYi1mIEMwf0e3SJRsBr4EICZdgllSB
	 rpDt0oG8w5XjHd5nH6rGSOKkrFgVAeAoU2zR/O99KjJ2BK2VwLmkQX6IsVWo0/dzgI3Dm
	 FApOECiLp6CXo+UMyNyHI5v2cV8Ol2PYZWKPzetNhXRrejO0dopMvmnRyKlsss/Rqew6i
	 M7pQu542Ofi//6E+RALM6uNiOibEv/3RQvT3HB8eqXo+h0Z0Vub0jtcJ6CtLIXMJurfMU
	 S/4mNlMMO3WovDGcmh2ttBgJqwwwquXhvc8vDRzjCEG9IX72w5etUXq8YS+tNkdLKCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711745;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cEu6w7zc9xGGvYxDWD1Er5JrgHrkBwXwDSIR3F4m0hM=;
	b=XNMC2liXTcesVD0bQ6wFalE3IoaR47QjGmhauGI4/+O8CuNDNs8pITNiSgC4FczkhxCg
	 eaD6Lt8C2Y9N5i/dJl40VVPLJe8heb8bicN7J5WMR8bgK6yJEHgPL3eXjjzVggs/l9t2d
	 jTi3gzYzec/3cRCOUObGUIsiW6eZ2yDmf0fIUvfIYD0VVkm/dzR24oT5sNTjs33xme1yC
	 1SCWyF/NVNprM6tGcUPB3pJomATAtDO/7FanO/ls7Cnn/LHMe2DtVslW5V7e5/aNT8uwe
	 IObfGCP0EiZquesHDvlDxyQsylEIr7T24P+n9MuQJQ6iwjs4WaCQqwhzC68VitgL0Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1zhYdw7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AC9606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1zhYdw7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCA81F000C1
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 13:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793711745;
	bh=cEu6w7zc9xGGvYxDWD1Er5JrgHrkBwXwDSIR3F4m0hM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=f1zhYdw7G0DFKoEJMu2JdhTahA4X7F+lNt8oTUflBFnROSbXXQr6TbGzNO4Prboay
	 GtY9cDxaOGFRESEh347lCHAlrCvnE/6V1y2zU6xl6nP7TPn6SaCR0XanTIpmaOoxgt
	 q7ipuzHCcxwPkBwut2/3ZCTGJH05Ez1/7LYVb+UcHXmGMgGcQ64f9MbZM+52vDuzqR
	 0ES8gT68871HGTKBEt9S/CupCrh3k9Gk35wFrAgFez4Qox7R7uC1+d47TbHiaAJ6ne
	 +BXoH+HdqKacD+0m7bVqWtUD0s6se716WLDiS/aktJ30RGeeVcSY2ZRtGk/biISdoZ
	 dRPN0vpxGWp7A==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-48ed0b68895so2818355fac.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 05:15:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwWQdGHxttRXdufcjQNvolJ+/4xKP1uACFTPa0IfcHsbmlbXHQj3+CrwQiFQGWDxsqswNKPsBA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+EYo4hv3O6zCfh0ntMYaudFmEW/nmv/sYfPDiQsR9pS269f+jD
	3U1YIWs++zT8ZIsEw7Dj+pwzKOG5T7wh3Qs6Aj9w5GcAGAjLQj1LJcZGsAqJV10dzl30HTbiwzK
	6vReCvoceWswn3dWYCv01ZK1Ddg4ZL40=
X-Received: by 2002:a05:6871:ac03:b0:494:b8f4:9a42 with SMTP id
 586e51a60fabf-4a9072d3ed5mr7152581fac.8.1793711744462; Tue, 03 Nov 2026
 05:15:44 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792838740.git.julius@bairaktaris.de> <3733295a358d34df6220ea924d2b710ca537cf6d.1792838740.git.julius@bairaktaris.de>
 <20261103124438.GM865646@horms.kernel.org>
In-Reply-To: <20261103124438.GM865646@horms.kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 3 Nov 2026 14:15:33 +0100
X-Gmail-Original-Message-ID: <CAL4WiirPsc6e_j8eWZVQsrrxD7NN1sAq=D7NxCSzFEqD_2K3UQ@mail.gmail.com>
X-Gm-Features: AclHuK_2zNVn7Z2lHHOyUpXGKRKtOJ8o0wEl1ZUUg5R9TrhPykKJ2PymiNKDISs
Message-ID: <CAL4WiirPsc6e_j8eWZVQsrrxD7NN1sAq=D7NxCSzFEqD_2K3UQ@mail.gmail.com>
Subject: Re: [PATCH net v4 4/4] ipmr: do not drop GSO packets that fit the MTU
 after segmentation
To: Simon Horman <horms@kernel.org>
Cc: Julius Bairaktaris <julius@bairaktaris.de>, netdev@vger.kernel.org, dsahern@kernel.org, 
	idosch@nvidia.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	steffen.klassert@secunet.com, willemb@google.com, jiayuan.chen@linux.dev, 
	mfleming@cloudflare.com, almasrymina@google.com, bigeasy@linutronix.de, 
	richardbgobert@gmail.com, ecree.xilinx@gmail.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 3 nov. 2026 =C3=A0 13:44, Simon Horman <horms@kernel.org> a =C3=A9c=
rit :
>
> On Sun, Nov 01, 2026 at 05:42:32PM +0100, Julius Bairaktaris wrote:
> > ipmr_prepare_xmit() drops a packet with DF set when skb->len exceeds th=
e
> > route MTU, without checking whether it is a GSO packet. A UDP multicast
> > stream received with fraglist GRO or UDP GRO forwarding enabled is
> > aggregated into GSO packets, and every aggregate is dropped with
> > FragFails, while ip_forward() lets the same packets pass by checking
> > skb_gso_validate_network_len(). Do the same for multicast routing,
> > leaving room for the outer header on tunnel vifs. ip6mr has no such
> > check and leaves GSO packets to ip6_output().
> >
> > On an IPQ8074 router with fraglist GRO on, a 10 Mbit/s stream of
> > 1316-byte DF datagrams routed by igmpproxy loses 14.5 to 15.5% (n=3D3)
> > and 0% with this change.
> >
> > Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
> > Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
