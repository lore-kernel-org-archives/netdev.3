Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452852;
	b=fkQhoypXvmNPh2eQycwgMgn+7JnpYorY5Hl9SF37jiLt7LKP7coNteKzKDlkb1IBWZQg
	 8WocOmMTxnD/VqDhoi7cYsClLoz2GPVOG4l2BtCHrRS/pNpJq0yuKK1lvIU5PV37Vh6CI
	 X7aqQyuD/5W2/DJPDeNvCumWAeKbmXkDYU6jTVOuwxSQZ+iqT1jKRmHUm+NlPil8quWYv
	 AGwtccTEQRpGnc7/wK/1TIqa7Lb/tTnPKGm3nKvBUlzcThxDK/eKpqA2KV79Z1+QsqrkR
	 KOklbj9lZv16zEcUnL8vZ3oHW31zRoLVrDqwMorN4xCpktKwtuqACxkkkKswr+vUoJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452852;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YEkzbUxPinYIAAi/13un/eqrNvQ94xo0XZSpt+GcyqM=;
	b=DAAPGW+Req/0oDvxAE7uFcTH7Z36otNg2em1zwfXk7RYDJwqbtZxDh/191WUCjmVkvTn
	 x9/iF6LrEFby8kzcZsgqpt0gyowVZlr8QQNvMvtBKrp7kNIvzNmsgs0DzBvS7Saz4V/Zq
	 /1o2b80IXaHiFgVjshoSig/hDdcI47ROPqlM6QlfFl2vDqXHx5M95W72bapuPbUV2vpLu
	 uaqhGNBkA1Vlzsn/yImKB1H2C9fOXFiBovMVwnCvFf2SNJos1ZztvZxkdmvPhQ2N38sEr
	 5UDgV9l3nnfCl/Tdier528FN2Zm+OTHRAcewiKptyPmQ9UygSY0fLhg4FNQlPH5zjhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=fryer.io;
	spf=pass smtp.mailfrom=fryer.io;
	dkim=pass header.d=fryer.io header.i=@fryer.io header.a=rsa-sha256 header.s=fm2 header.b=CB4hmqPz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=CDDHJqiI;
	arc=none smtp.remote-ip=103.168.172.137
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56B3606A324
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 03:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E56B3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fryer.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fryer.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fryer.io header.i=@fryer.io header.a=rsa-sha256 header.s=fm2 header.b=CB4hmqPz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=CDDHJqiI
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 025161380F30
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:07:31 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 22:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fryer.io; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1794452850; x=1794460050; bh=YEkzbUxPinYIAAi/13un/
	eqrNvQ94xo0XZSpt+GcyqM=; b=CB4hmqPzOPYOhQjZ3caPkulP2sRB6hwoheGBh
	4N/YmNdjlH+3tD/zNOfD+RwmD5de1wDGYyMbB87EdM7fdOGtNqEfxf7Fo/xZNqks
	7jsVBwnDLsVWx4EXv3Lsh0R+d7YKaRX4yR0KW/tz7wIyE0jOlLqBhK/ASiAIaGP8
	bI3+fHYq4M6ywpfie32FI2CMN758pVLWRq80kFHiERsqVxWXcDANvyxZKbfFMonn
	/Vj67zLPKR3koPHWUSqgj+CH/fPkrN6Elg/igYlEISDcBma6u4c8Jp5Bz83RQf+e
	ietls6Azr9paPYGoKBQYmsWTmeHxyPw4TLj/okBlwR4UVUmIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794452850; x=1794460050; bh=YEkzbUxPinYIAAi/13un/eqrNvQ94xo0XZS
	pt+GcyqM=; b=CDDHJqiIZC1ntNr4DNFyiNQzvSUyEskKXEJCNV8yZAcF37PCLQY
	jdBfNm9Y0hfWXdCly19RnlCu9UanLcB7FMhr2X6z2c1fpw2W32D0eezRr7QiLM1W
	IBgsaH9RF5IfWI4DxxkJyoPL3xgWJA1pO0eAOuidmm9Q93ZbRmMgcFPH6hoc9lQ/
	h+EjMBEBBwnL25e4FSDNV8xgU5mtv/Q5YxLGEGV0nKL5t8sYl09NoFM4j9ml+ioW
	zoDeZJFnnzaKFTs4Zh1ILt/8WqBc8jOBbS2TzK1VfkMqiHBHNwHMJ2+arbhz1GMt
	pLwOSYQ2Pi9oSxAhI2GZAfXJkHMt+rgvLdA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fryer.io a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794452850; d=fryer.io;
	mf=PGJyeW9uQGZyeWVyLmlvPg==;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:kzEwMXEAjHhulRi1GOLO7nbaDcKCfkib3TtTDQepgI+zFfD
	ckZkP/TY+2TGTnuJrsCo4HFzk2wUbw3X5VhbqkZhiAy4Rda4CdzVuhdEqYGUBalQ
	uy7cyg/YKOpTxJrElbk/OeT65giLPndu0USd/aDQpBzvAiKBj2T0T32brU5UTi5D
	Xo1ledhdIP9YSKFq33nsOvh4QoweWuuqL/5fbqWoKTipL7nmR7baSkA4OYxdMeyl
	1Zcps5QdD6YpuAqj6kV4PES2mzRa/BniFpTr5h5xMqR4PeL2YDCNzOOBDfj3ebO8
	QM5nGgmEEAbbtr1IZaBfuDFdxslYWaFx/RhfXjA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:z6TV82j9Vrd0Cjcla/1e+sg1lMtn9yPTSOSuG3wqbPY=:HlBUGDpmoKyj4SxZSGl9hCRFNBMYU7TLF2NEU9Ji9Ec=;
X-ME-Sender: <xms:ci31aiEv6MpJ-izVNqvcAkQxJG6rrEFTLptqSF5x14CRXsoYK4j2BQ>
    <xme:ci31avOJhAZUpodw-MJAKjBDnOdo5BJP8zOianQEhJCG4vB-qOUq9_Jho8ZXGyATm
    NWFq2156laUSAIpAoQVhLqSNalnIxGr2Yw1bR0VOjtEz6B7xofktEAV>
X-ME-Received: <xmr:ci31apIpLpAtB1ESqf78eRKFL_g5-iXIFbj58gRdvI9diGpyUaXoS4jKDdVGesgTuq1-h3Io4iSNXCcNqfiyz8NWsRWW3MvAJmGbo4JbFrT-8A>
X-ME-Proxy-Cause: dmFkZTEYVUo/hdKlkZzj/IqrVqdQkKlqwG7Kasle3c+PqXU73W4ZHoHL0ACW1kbXMxXhum
    DulWODMmuuour6CsyTHLxDvx9rx5fhpokmFoqS/83iUURE3YCJ4+BW7qQtqu9blnP6ms9M
    tzuFKrrbAyJ6lgmcTT3HXkLitXoVQEtosxRzbi6ljq2r0NawG8FSOUHoT+cko3ebaVPnIw
    nSlfON9YGHdLZIt46IAKbWJe3dKPGanv6KBlCUajdHUC+yOI8vcTfrPA7YCVKYhKi0sqBF
    0/TA+gEUAkK5U4anCY8W142zODS7QVzlSWmrcydkABpgRT4YUjZiMF9UI5RutbT0fu9ipQ
    L1DJg3v+68g+Qux5vDstgDD9N+AP0LMTWn4lS8zlkYHnt6EH+oZY9tbKvGap2p+FRg7WJB
    D5P6LzyNztvbLnWieWmXpQYss0y7efOejE58hhvgYR4VABXE6dqdY/uLatQY5sse3i2KtG
    HMoi29rx6DPNASQqpX4tRGXeezIjoWO1yQJiepuTDogkBA59b0U6hzI+4ir64YRSB+csoI
    77hihNXL8e+b9zqGzRgcTiZTrqpAU6vfv1pbEh5TD/ALPh0zTwviUpC5VluZyNda1ibGWm
    pNvBgDnINWeo7inoMe1JprZO10Re1gL8LMkJokDZFFQtLqWgG609kNk192rg
X-ME-Proxy: <xmx:ci31ag9KyoimmLrXzggxNq5Pu-ql3xx-35vjP2_q6V0u8-dVmpG2Yw>
    <xmx:ci31atE70AxrKGTeQmtiHI4OB3EGmFh8sga8hT8O-YUb7IytpYz1Hw>
    <xmx:ci31aj57wR8u5-V5Mx7ksqBpiWGAeXF8XZbFxGeEywLD0YhMiAxNDA>
    <xmx:ci31aubDzQGxcPe44Gjzr-kZJ-F74f_mBkPM9ctbhmHWHNP9BYW-1w>
    <xmx:ci31apNUPTzbYB8x4tfAfqyvNcD7NpGEYtsl2eV4LEeKkp8O6gt9xhgy>
Feedback-ID: if1c946a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 22:07:30 -0500 (EST)
From: Bryon Fryer <bryon@fryer.io>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	jasowangio@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Subject: [PATCH net 0/2] udp: preserve outer transport header after tunnel GRO
Date: Wed, 11 Nov 2026 22:07:06 -0500
Message-ID: <20261112030708.1915665-1-bryon@fryer.io>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UDP tunnel GRO can leave the inner TCP header in skb->transport_header.
The virtio tunnel exporter uses that field as the outer UDP offset,
producing descriptors which the receiving decoder rejects.

Patch 1 restores the parsed outer UDP position after successful tunnel
GRO completion. Patch 2 adds a focused regression to the existing TUN
selftest, including a GRO-off control.

This series is based on net 8d5ce4751fad. Before/after virtme-ng/KVM runs
on that base reproduced and corrected the exported offset for VXLAN,
VXLAN-GPE and Geneve, with clean GRO-off and prebuilt-GSO controls.
The complete extended TUN suite had only the added regression fail
before the fix and no unexpected failures afterward; its 12 expected
failures were unchanged. Selected UDP GSO tests passed on both variants.
Bulk TCP delivery checks also completed, with the receiving TAP rejecting
aggregates before the fix and accepting them afterward. The separate
VXLAN-GPE raw-path segmentation rejection remains outside this series.

Full x86-64 allyesconfig and allmodconfig bzImage/modules builds completed
before and after the fix with Clang/LLVM 19 and W=1. Existing baseline
warnings required KCFLAGS=-Wno-error; the fix introduced no new warnings.
The runtime kernel pair used GCC 14 with matching configurations.

The detailed timing table in patch 1 comes from three paired virtme-ng
runs. Median 32 MiB TCP transfer times fell from 69.8s to 0.15s for
VXLAN and from 70.8s to 0.16s for Geneve. Receiver rejections and
retransmissions fell to zero, all payload bytes were verified, and
GRO-off controls were clean.

Bryon Fryer (2):
  udp: restore outer transport header after tunnel GRO
  selftests: net: check UDP tunnel GRO virtio offsets

 net/ipv4/udp_offload.c            |   2 +
 tools/testing/selftests/net/tun.c | 292 ++++++++++++++++++++++++++++++
 2 files changed, 294 insertions(+)


base-commit: 8d5ce4751fad9499ea408163af7f410f18a85782
-- 
2.47.3

