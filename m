Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422628;
	b=nLWkPDt3SDFXCFhXTp2RwQu21XI/mprinAVqFlXbREb3RudECYC3ZQ+Z4h/h1z17SIv7
	 I8Rf7y7Pm6J4s6xWsgn9JBljjxp4mng84CemXlg2ugMcnfYYREczoxq3npsSSsplXQU+m
	 b58sxITawgF6jiZK/CmQOylRT9SLRFgteO8LgW137EIzF6cbfd51cxn2ad9PqlXJxuNrh
	 wDhfIJloYLb0jVc2DNF+SVbldOLvfocgtkrBFu2zT0vxznoHr2XRtBNp2OgDfCLswhyJA
	 JPO2rauArs2KnDtQdn0ZiwoXvCnOc7kj2Q29coMAiq1pt7GXBNzHdknpA092Ohet9Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422628;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=470ounRv8iiyZZXFKRGG6Lf+2x2OhKg2U1x/Qa08+Kc=;
	b=B2O9fVfIKfZo0dfrTyEwr0ZGvAxrPim1Ynxq1aR5C0VHmqCmPCSNL3wEM9b8REusakFP
	 QZYQ77eQVJM2gFtCP7w4nIIW6BkvsV2p8AWILeVcCZ2YEnHcjEtzYIxr9v2p8Kp8T7ESK
	 o7nhQBBTx2IdvwcdUXK1NPpS0ooTPnf51vWeM7gL1MwtJRSreFsvfaJpTJQitJZikkdNA
	 B5dIX+i8trNMOqbzLiHrvnqrXvwHQhhHAFvLXDnc1gsp0Q1OEWmHg89ZgaKUvHTEQwWbd
	 4XywIShJP+g5Mwe7KS7fJ/MSPfRhYhRMc89hQcPmoG+i7qgGUt2+VZxEvrtl9BUCoJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E4PmokOH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69D60882A7
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E4PmokOH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D027D1F000C5;
	Mon, 19 Oct 2026 15:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422628;
	bh=470ounRv8iiyZZXFKRGG6Lf+2x2OhKg2U1x/Qa08+Kc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=E4PmokOHisZ9UPXMATWOgkjTZMn32+0U/L6VeLMsvHR+tNWWpTgAS7cw58IXPJcqz
	 ydeWAtHtPkY0rTlrr2LE0hws7RtuxsltNYP6Iadk3u/Kvuh3DAtMI2PIfbDHEB4WD9
	 T0RwrnxFzrTsBBhq4fJwB5av18bZT5ur7ngLuQXTAeRxI3WnXA5aEmY/m3fQeDt4lu
	 iGuzc0MDH2AiA+tWRKViG1LmHMQzczEDn0mQ51NlTsaUn3aQUEMm5UDT2qDrwXrA5N
	 ZiYk2psg9o3npmnr6Ii6Zj87hYZ0TTRx7yNYX2DMUVs4r/VCdWDX7Gg8yKzMl1/yxr
	 LPKuHHn9JZHFw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3C6A9F40066;
	Mon, 19 Oct 2026 11:10:27 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 19 Oct 2026 11:10:27 -0400
X-ME-Sender: <xms:4zLWaqlFwCHWBANJqcbZlR8Pnx9rYQzUdeBNH-AMELNYSayZpHDadw>
    <xme:4zLWaspSzr7b7oBuLmQT70PzcxPcjwjqkftX0F4eqiF_aN-_KzGzKRpddRmG5mrTM
    ExayTeEz-arndpirEqN4Q7A_MJaPvUdn3E9AqGyDUyYloB-TDotM4_r>
X-ME-Proxy-Cause: dmFkZTGDUnAZDq4exKfFP6eghadm+GGoQquBfH9rmdXgtdZeH0voi2KLWx6aBFxCfaFED/
    jjZNRYypZXVAcCfaY8LVGjhKZZaC6AAJo0jGV+kdkqQqDgOWV2X0Oujo75f9n3EQZBL1SA
    /pwwFe4wuJSrZIpbe7dq6vPlrblBiFcIjtUL/YHlB3k1BvFoBRsarBe9oVqLCTka2qPv+B
    /ZDRgmWFFDLu82NmfiOgH7PKq5PJAV7r51YMZ64iykuggiTT/dHvBh3zIgnoHGm4gHHslQ
    MNverw9GaGj586TTI49WzkWQv0N43ySID/oFNb8mL26ZAQTV87J/EsX2GkbeLvg79l94lg
    0rdwBRxvFChGP/sQnMSLO0ytjR0Rde02bRO1Ga3bS9JR9Hvw4dxQqKX1o9YU0DPYNLSDec
    wKlFWBzF+jUrK/8xaZEF5Kgkjswlk93qnde6jKjl5+jj3uFaTP/mFeERjjy3gXrbclSn/w
    oLKS6SRclO3unjz4gg1oj9u6lCwDohI+yKKMppk4NSkdb+gStIXmxBnk4+mS/Rh9f46toc
    xrlhduAgthNTf8ALHtZvCgcgLdK7HMvhvK0CbKRXM3feaikImDuJHg5e3ZnkcnoA++oYR8
    WMX+YL2LOGITF9hsVgTBhNi/wIPi1m52EDCAef9RLZez1I6S6yPqfbXmZ6Hw
X-ME-Proxy: <xmx:4zLWaoYyHozn7ZZagpEQHHx_jg0mqZGz3--A-Cw9cNSZ2YzaGFM-Og>
    <xmx:4zLWagEzcp-fIDoVa4bkn3PxlenPGeloDUP_pX1S6bR3kzOd2eaWFw>
    <xmx:4zLWam2ATNq1znydY1C5CCBjQascvHHCJqErZXtvHrMc_Nhk9cUEZw>
    <xmx:4zLWasyPNjZPic2KHxB3vP-D-6UfIInYQEFpAGXtvoUynxy1LVieNg>
    <xmx:4zLWanjP81n5J6TjXFoMZsLorxUh6qZN3NDrTJWvXkYjegvAbuz5vHBM>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1BB8678273B; Mon, 19 Oct 2026 11:10:27 -0400 (EDT)
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
X-ThreadId: AWlQ4TQ0Yepo
Date: Mon, 19 Oct 2026 11:10:06 -0400
From: "Chuck Lever" <cel@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, davejwatson@fb.com,
 shuah@kernel.org, qingfang.deng@linux.dev, edumazet@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <63f2e3f9-4756-4edb-869d-d47b3eb979a0@slotpi15m67>
In-Reply-To: <179235137663.3135.14281539217109085008@kernel.org>
References: <20261014-tls-follow-on-v5-3-e76c301d4f05@kernel.org>
 <179235137663.3135.14281539217109085008@kernel.org>
Subject: Re: [PATCH net-next v5 03/10] tls: Honor O_NONBLOCK in tls_sw_splice_read()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026, at 3:22 PM, netdev-bot+sashiko@kernel.org wrote:
> - [Low] Concern: the commit message for "tls: Honor O_NONBLOCK in
>   tls_sw_splice_read()" justifies the patch partly with an event-loop=E2=
=80=A6

v6 will state that the stall scenario and the zero_len_splice
reference depend on later patches in the series.


--=20
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)
