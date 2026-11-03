Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793682202;
	b=EHB/dnagSAoti2u08QD6FKjl4qxSaHwSRmD0E+gDhtQOKDLV9b0ioHFyBbpkh40XEV2r
	 /KMWu3cPFcDnfPDMYrkZUbCNKrr1uHTwdK5L83Cel66meoqcmjPAsmOrUmGEn6VMaTmpS
	 PoGb2Dov+DmSsPNuyg30wpC8xSMhxas3+TRzHoZ36W/vLxH5nOVDH/XZb266ldb7WfoRq
	 YUST+/KEikhtX/Ngeg9UNvCgHvbClbCKDd0DMNwKBBHrI5vrT5leJQgcWtR5f/UqFs4/j
	 Ky3JsZ8HwcYcvVi/fkMWjTEPlOk3crIPg08vGkOv+vmE5tsTgQ/OI/n1Uo55vY8KXNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793682202;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Cmm9TjBM15fgNhkDtsmSTasJ4YzCWckmM89Ah4ebytw=;
	b=Lwh8ZG7DG2hWLGw6zEfMwihm600dThZDrKa9j+hfpwLiArjyZIVhBdI5eTcbBjLJWu+k
	 WD+lnKuB4uI+1S2WDKDYlBrSEXGdluCnIzffCUGEaCdC8eAA6zJmAhPD7WbtR80aci4t8
	 HhNjgO3mT+HH+tTzvFTB6GE15eV/WchVOB0rB53I571j2es2tq3xRcpJhNu4mm7b1bjT5
	 4MPZYld5RfpZV/Ne4bv9ylkzEoGjJsDtoWM0mtbaLY2fGemIiwK9IZ8O5j2B3Y0E0KVqE
	 utUnpcsDVLI3d8ajIWDKSz16k0PtoHRCsGoib/xY6NRj4LZW6I1o6+Uwdhba703jOig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eko2jo8z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261B606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 05:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eko2jo8z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67BA1F000C1;
	Tue,  3 Nov 2026 05:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793682202;
	bh=Cmm9TjBM15fgNhkDtsmSTasJ4YzCWckmM89Ah4ebytw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=eko2jo8zYVhQ5UuDBBtfdtlNYK+Wnp2cv2IIadNkk5nQ5ty75ATlpKCx7u6TzZFCG
	 eU2zTqE7hImwwaONSzL5Ed41xRKmLKZrM8U6Xus3gMVUwV6dLJ+FNZD7C04Kmr3fhO
	 GgsYWq3TGdBN2beBDJR0I7gNn9910ND0ZOgEHgmvaiFTESDoCMXqdqx4WYcb0uPHrv
	 CIVKVPULHIc6oZJ6m9CNcmoST1fXPj+lSe+No+a6nG33N7yu2ZyPhWzWDVcvB24SQJ
	 puQ+wdXNDk0Ar4B9Moc7FlXQSKcbxryYqcRR0WC9Q/f4z5jKcyXKcEDBq4EeLObIHX
	 yg/VDn/VjhPfg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v3 3/4] selftests: drv-net: add a kperf runner
In-Reply-To: <20261102190827.989117-4-sdf@fomichev.me>
References: <20261102190827.989117-1-sdf@fomichev.me>
 <20261102190827.989117-4-sdf@fomichev.me>
Date: Tue, 03 Nov 2026 06:03:21 +0100
Message-ID: <871p924icm.fsf@all.your.base.are.belong.to.us>
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
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev <sdf.kernel@gmail.com> writes:

> Add a helper to manage kperf servers, run the client, and return the
> aggregate throughput of both ends. Use a random control port and a unique
> PID file per server, as the hosts may share /tmp, and report server clean=
up
> failures. Stopping the servers waits for their sessions to exit, as they
> may still be releasing devmem and RX steering, which the next test needs.=
 A
> server which can log does so to a file next to its PID file, and the end =
of
> both logs is printed when the client fails, as the client can only tell
> that a server went away.
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
