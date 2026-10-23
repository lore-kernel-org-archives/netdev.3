Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768827;
	b=Wem+o1rypUZAnEFqMeQSAVu8mrwNdQPgNKRsgxYDLGAC4edHNQq4wnMpT6HcLmkBORPo
	 WHusIuL6ejopyA2QR6fBYPkeS4P9OzDXu9MuPMqSFPB4V5Q1Lj9gw6NLbEhIvidvLXE7V
	 M2DaI7GpBWiBCe+QQXcxDe02payK8V2CQoHmOek5lN0SPqFIdyPN0/fuH28hBzgIwEgWC
	 NxxinMSWHrDU4fQwRCS5tEnN6P5pa7PyLA5x3F2NC/O9EyLw1wiA0HI+28/ZIE2+2juxa
	 uPGItKpJdNcXJeaJoz9Su+GBPyuOslWu6JXjo4M4QlARSPNReg0M12C42h3e7go5MXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768827;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=FAARwtoHudbbVFFGbBknOAzGmfSbQ4nLHprbLtRs1gk=;
	b=pSziO7lKjOSytMWJTrdYZ4aki6NRSejnjHqQkTQsNYef0id07mw2PMuG+OnC6EbO7z5A
	 K6tE5rpB9HNRTDTVz3Ym23AI1N7zcPGLuK8t+2SzLl7tk1PtIzmbDh5O+oSFJssSQjBIS
	 uFAdn0naFcZAvSu2dL0AxjazU0KxzhL+5GyxY6Dy634DzAELDF4Fnm3FC1/vq/g8Qp60H
	 Ld3CPiw1NC5IVhfFGgcbq+fptPNKIWVhXFGIPARr42D0MIzLBK3F7pM3D73ecM82gPjNs
	 Jogr7m7OvzAUnkjsQaI1j2KBxbVnOoMe2aaGPZSOedFNjb76IMvCcnfvzRI2ww1Yp1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvwV7sYC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A835A606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvwV7sYC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B301F01825
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792768827;
	bh=FAARwtoHudbbVFFGbBknOAzGmfSbQ4nLHprbLtRs1gk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=WvwV7sYCz01ixlRT/O905o08WMK+OnohN9uj5QJY5q/OAfWfwqXbLLsEdvV7fa2Dl
	 0QjT2vXF0BfssZxlLfGBtTWlr7OH1c4qcOUNXobqyGdC4lGjBiAQbzFsySPhSBE9E1
	 z7D1swhamJQLZ7jnLL6pOIgMEcH2rNWcGxitmVCmwcU0l3vtvI/pm9WhxPLx1ApJVh
	 XjnDKbmOfOUVjCiyjHKe2HLSABlX83dSlcjeKTXLVeOysSKVv6S9/n5GN1SYFnX89g
	 Z5QUmaTG5hpZbp0+gm0kDJSeQeymbFWdmR48mkMUx94rqPPFwkNbdfuni5joeUWnjR
	 Qj6y90SxgVUcA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 85CFFF40066;
	Fri, 23 Oct 2026 11:20:26 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 23 Oct 2026 11:20:26 -0400
X-ME-Sender: <xms:Onvbaq--Y7mJJOV4Cy6J708QP_Mqu9i0iuUKsn2xxEH8NC9jxgXimw>
    <xme:Onvbalg-rPMXmavG-Fj43iCI54vg63_fJ4FTZVGrq8VL9tunFAAuung5lEY6aWNon
    RrYtlhrjdeS2zLJgSMHGNZlm9vMCx0tvkCvujWe78FkrAr0_29mUIw>
X-ME-Proxy-Cause: dmFkZTFRTCSWXN6q21EGN+98GivsUWAa9L5SzjxGoGGMDES26WnpzPkLeJWbmUc8+89+pG
    eAxJC0gDYXy8dxKt8K2xfnvbhIpAGeA7QFG2iFfmaIXSQ0GgaUMmHPD7TWTXdH0OLE4eXR
    cDUNik0jsan5h67YP9rx6jXevY3QPkeFnD2M9I9PQmSxDqKV3C9sAQxemOYa0t4ZWoAqRH
    Rn60sSkOcXltjYOD0dzeu+eTzDc9K8Jdw3pSrg6f1mzZkwaQRJ5TKwu01atCbSU/cC1GFH
    DyaoPYq6OtcmzCD2ZnsDfkdsQmtlGzhCOqNVPYLYsLQ9iqACSId0IXsRfDl7Sm0vh/GlUU
    /wxz7HWEbUvnmtXqGVrTZpL52h9NsKKvMJpzrvC12BvRgvi/kWZCTPu1v9CJ6uvrQwnaUf
    hxIXVEocrE60RBpGtwke0eD0TgOb9OvLjLGXpHieOYU1rujUlCFHkb709OH3tkFGq/lvda
    a9N9LfligpxR5p+rhCpNdr7qf0AEFvx/E1aKwT2RCr7PUHHzsTSUdAwgdcbkXCKnDj5yVe
    fWHzR8JudfUVyViUYIgCVlwBCYoROvSJPHPhzGeUiw/BiGdpyoP7OvwtRKne50eEjxMlBY
    bAfV8yts+UERdGbEyuTC/gnPqq9mc+JuAjbfgaciebI9OpzSBCy33luA5hJQ
X-ME-Proxy: <xmx:Onvbau-etSTwN-c6rZmaYu-ThqvdoQSt2DeIggEI7Cy4MgUYaCqKHw>
    <xmx:OnvbasNIYQ6NGTF3bGa-11w5dft94j0WBB8RwUgwc276fKOMWoZftw>
    <xmx:OnvbamogVVK4EEHS7zD9OlO27Eg-SZwOAP4UxiRhi9ehhAyua6kTzQ>
    <xmx:Onvbar5WjR75sctfnZPTfCoZCYcqKUAU4_DXGPugpNrNFvu1Fa_HHQ>
    <xmx:OnvbamHqxOnkB9e_EpSrx3Fsmqkj__sL5TkbmbibOeF9tbbs55EYtTuQ>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 646D7782738; Fri, 23 Oct 2026 11:20:26 -0400 (EDT)
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
X-ThreadId: A0hz-OT0z3y-
Date: Fri, 23 Oct 2026 11:20:06 -0400
From: "Chuck Lever" <cel@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, davejwatson@fb.com,
 shuah@kernel.org, qingfang.deng@linux.dev, edumazet@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <7e917006-e2ca-4f07-b294-881c029ea22e@slotpi15m67>
In-Reply-To: <179269905793.1189532.10522541488678622443@kernel.org>
References: <20261019-tls-follow-on-v6-8-ab01c4ecca0c@kernel.org>
 <179269905793.1189532.10522541488678622443@kernel.org>
Subject: Re: [PATCH net-next v6 8/9] selftests: tls: Extend coverage for zero-length
 records
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026, netdev-bot+sashiko@kernel.org wrote:
> Would it make sense to fold that coverage into this patch, so the
> reproducer named by the fix is in place from the start?

The fixture and the nonblocking-socket variant are separate patches
so that the variant, which pins the behavior change in patch 3, can
be reviewed on its own. The fix and its reproducer are both in the
series, the fix preceding the test. I'd like to keep the series
organized as it is.


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)
