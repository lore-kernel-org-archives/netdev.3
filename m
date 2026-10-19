Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422663;
	b=Qsy5FIfqot/YM/ByeZXCKJKLaRnxk588GyyCzlkD9ysBWJpVE4PcJis7/hAQWqneGO01
	 UrGEVt1NcckZYjuOwPt8NMmB8Bup7ZgLHC+ctcIh19PuUFUPrEXcZzMQSLswwHrarXCZy
	 ECvpDrZcETMpxByQS6i3CFtwr+Cwy8czVGQNv0o/UzfBc9GgAVd53YsFki43LKr+xkhrl
	 pRHQWvwl5HBtDNibs5lSAslr03keUYI+1by8edXMvBIATsQvOUDnPurNIMH8ofgCRqiEY
	 ayiZ0Cu+cr1/lynkYuX2HMEh87MItCyrtasVXIz2Cg0lYlgQXKAKBnbItaX3ondbU7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422663;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=fEZDTifdhLcn6FE40PiPwUAHX7KfqbCNmtOKaENRH2Q=;
	b=1i1TRGIyi1AhpBSjTb+VykxJzHWWUx3o84A4oi4XxCZ0oa1+TJrfWvU5KK/bu3AjvR4u
	 HQYyR9kzqwH3jyYuiB/L5V2t85d+/F7FUVGf9Vb4FWnjYYIcbnI7FBT9bMbQu7WQIJTpC
	 MT7du9bM4ODgH5Hehr2+BgMs2F4Jnh+ndvWbK2s/Dm4bO2l21FGJz+41L9ohTffflOSJ3
	 seCEc+h6mdxQ4olJjEePheT2MPSwxosnzbL6Us34+OKXbVeo4Gdey4p/dzyk7Eav9QcT4
	 /OB8P6C8UvCUHlID1xIMyLo1bL7Dj2baFYjRge0ZnAjLg2FwOPf1EE+svq/taIkA7qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MIb8WBZw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE31C60892DB
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MIb8WBZw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AD11F000C6;
	Mon, 19 Oct 2026 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422662;
	bh=fEZDTifdhLcn6FE40PiPwUAHX7KfqbCNmtOKaENRH2Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=MIb8WBZwDutGr3N8pKdKykYa2Ky+WRUWdvONXM137NPnQn3MavxDCmaArMwENEk9L
	 ZWTu4R+weZzSwq9Ouyz9atfjyHvfutch7pkhTJyq1PYeJf0bv9DjMggUhzNV5JJn2B
	 68KPLstfdaHqvD2pVh2iQCnTNkMR88UfHz4T49VNgDHmpMMoZAW+6R9P3/KUT9qd1k
	 8yt7nam12tVl6DSmGZdPR9szmi5LPmV6Tc3+lzFLloGx9qF9fDvX96lrsMnlluHQWy
	 4XxIyr8NseDqBqf9B+w/sc8bklniB16u2+D0ePNKTU3gglxNx9AHZyeYbOaDSLa/ZC
	 C+pZRkCmfeBQw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 645C2F40066;
	Mon, 19 Oct 2026 11:11:01 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 19 Oct 2026 11:11:01 -0400
X-ME-Sender: <xms:BTPWamxIeo0H_oTj2sBGmTkv4fslQQSzKI8NEuAvswGV5VNl3fgxpA>
    <xme:BTPWatGxQGG09KLSV0-U2MwH5J_QAFXL_Pd6OQ3NsABc4a0PrSV-5Uw6xOLbqcSSt
    K1rNE2EmWYJY1UFwIu0AtU-DjX870Exw2cvWwRt9Sr33ycWCLdVPEFu>
X-ME-Proxy-Cause: dmFkZTEdEDAniK+weQVIZ1l1HDd8KGWZLGLVNdKToWuh6sIbSIQOo5SVQv280pKVFx1as8
    BemCxPZn7hZx5ym0HJd/hRpkHxCRwHhRo7kbwK76mgPcEyInLmKnztI+RNzHNa50/lQ+/8
    en2+kncIwLVyB4mC2NE+JnEfSoIl0KATLsilco1zBbQaaD13c3LwG3mp2MqMl6EFd2g2ed
    CdU/9cpzBBGqZ/algTEBCHXEEM632zxyBnqV2u/8Vx82jpXuMYC19ybCSCIiLCziEcDm9k
    F1Nii6maGfsDsyygfSehxhkFM80n1yXTKt4rvrpGFJ3QtLrKcgOLeYC2vJlZIMENf2NuPq
    8+Nv7Y8wg6ltI4BZsXjZkVYE69Mxyw1SmIZP217QwtkGgrowNeZplndTU/+EU8u5wDO/gd
    sX4hSrJ2DTBcRHl6BlUZEL3y4b72r/ucUQuXSKmhmwMrg94x+2IoWZavipKOHx79Wb+gHI
    /+vqkjkhnwtlzBdh2PINLsdxxxm+lrLaKObnnajiY/DWIDIv/ViZ0M4r6XtUhaAuSXlY1L
    IVd7iog5l1I7tKKSo7j782hno2lvdDhpHITcjefWqPQrECdnH6ExcG0+pSj1zfPn9TtQFG
    RM+QzP4WsfB2kQNDchQxU/a1c5l6tOpdt3lDUErnQtJAJWSAw/gsZ0o5UPlA
X-ME-Proxy: <xmx:BTPWajkM2yXkoNDOlkXVohp7VLOO0IRDS2p_m7BmK-KUfm7TNVcbDQ>
    <xmx:BTPWaji2datVtOjxAR-tztLvjwdzQm3q6OXOVnvDdsa6Utz1KnsRhQ>
    <xmx:BTPWatjIYshkhfl0v24T1uHewzRD79SQC28aD8Zr256Am4up6GANpA>
    <xmx:BTPWaluHZyc_M3ZoHttFCsMWcyEmJ-6W0D0ZewYDbSteiMb3Yk860A>
    <xmx:BTPWaluxC0T1Ld3oR9OsJX7cMbnj-7Q16hmldBLApB9_KpWmcAbutiS_>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3ED1C78273D; Mon, 19 Oct 2026 11:11:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: A4NGtdkzv69R
Date: Mon, 19 Oct 2026 11:10:41 -0400
From: "Chuck Lever" <cel@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, davejwatson@fb.com,
 shuah@kernel.org, qingfang.deng@linux.dev, edumazet@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <145fa607-0fb4-4acc-a983-8699d6a35169@slotpi15m67>
In-Reply-To: <179235137784.3135.3581519897998654848@kernel.org>
References: <20261014-tls-follow-on-v5-4-e76c301d4f05@kernel.org>
 <179235137784.3135.3581519897998654848@kernel.org>
Subject: Re: [PATCH net-next v5 04/10] tls: Consume empty data records in
 tls_sw_splice_read()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026, at 3:23 PM, netdev-bot+sashiko@kernel.org wrote:
> - [Medium] tls_sw_splice_read() (net/tls/tls_sw.c) now returns -EAGAIN
>   from a blocking splice(2) or sendfile(2) once TLS_RX_NODATA_LIMIT (1=
6)=E2=80=A6

Agreed. v6 will drop the cap and the selftest variant that reached
it, keeping the signal check. tls_sw_splice_read() then reads empty
records for as long as they arrive, as tls_sw_recvmsg() does, and
the description will state that.


--=20
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)
