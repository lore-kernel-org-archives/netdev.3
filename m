Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794023310;
	b=Z1diDI9UWNa0bIyJqZARJub2S8f9uYMumcvS9zr4cKmDedqCpUqkosn5+l0JQR04Su4H
	 8PUxgcL+8A7XxvM79kdjnVRZu/j6MlMXnElUc3v039s1aPOdJX574C9xgbGyjFSJhT7D3
	 nmNXsUrRRtqu8ArmAf+zkVgoZ/MHhShimsDeCLWfGQ1z895AIMRb+6Ei9DHYYBMeJuddr
	 2gwuLxQ7GQ3PAX+8s2yOd1FgvSKlvNwO5cj5vh5/JaBuMJmTMNE0tADXH9N/EB44xBnba
	 OLZ3yiUiSS/TAtPZuD+cAMOAj6HDjJVbC1qVamEaDx2Y17kuOoxRlqonPm0m97ZfPDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794023310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=M0kvWzVPt9dqAIcBOKT+ImaOQTRBLwvr5wS2ERBlrm8=;
	b=mscbft/emcJ7B/irgea3/JIaH1clipInr2JqArnLurrd75jX7VhpnPB6zh6JyyT86Xrv
	 zcki/zeH+nGLcWTnYwGQwjHTlYrvGOoQ7nsyM1Jn24uSuLvsJgAkx0Ds8W5bqa14P+bVl
	 yBKNZY8KCIkBdy9208a2xyFvH9JaYbTPMH7RXY/R9lDy4C1xr3eIYdYFbcf1F7czhdTSw
	 QzT9yF5OWuPctPs3pFeLZB/NjRZyAG6pwTYC5hHcKWeYAs1sPb2aYsy2/eQdZB+HyZsJG
	 eQfFBPnIayf7dXkC9rcfHHtq1tc13ihMAGq9qiymCdp5IJVDllrmPZKdZZKuMXnwheA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=fD2Rd3pA;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EEE606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 03:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29EEE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=fD2Rd3pA
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b65d69f5c2so1588151a12.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 19:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794023308; x=1794628108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M0kvWzVPt9dqAIcBOKT+ImaOQTRBLwvr5wS2ERBlrm8=;
        b=fD2Rd3pAF9CRqTBvuDPxxbuq4cH1nOT4tUgN7Q+33GvcdyJmWYe2tXi1GqLioPOwJB
         C0ub90N3wc7pRwcKQYYeOmCQet+iXcKZLQ7Iko8OO8+5Q9sPb440ciuzJBo6LQEeoowm
         m7ss4fClYpVhfnyaFKRSoM6tHlgOwpWy4uEgUR1ae7s4pviaqVNKkooXr5cRsbOhamQe
         EgOxNvz5VxCSHYO1KSjyK/+E3fNWBvVHKtv1O0wMQ+lLA4Hcc3LIEpOKP+FpUiB1VPlF
         I6SHm7onDjdBVpFHwR2kI3yjBY2CAttW3om2h8HWv6dihUoS3/M0oZX0s1CUzxWmtDd0
         Sgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794023308; x=1794628108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M0kvWzVPt9dqAIcBOKT+ImaOQTRBLwvr5wS2ERBlrm8=;
        b=cqTyc7+FFni1Bqa0NCquNjxDZM/tRAFzHmqQQr5LY/BdwT7ZyhS+rjrVpnkoqZo1TG
         ZH7kvomtDUqOIblizSoXEOQR4LiMkxSx+tmfaoe7eKdo1OeKmYdxQlgYGgkP9dbG3Dsz
         /X78zkJJKozQUSDm893hCJSJav+zBxB8NNrjkyn2HDZhgq2jFSPEt/0Oaoh74A2Hb22F
         7pWd8dZJk/hT3kK+p85VUG0NPMdM/0U77ZgB5yeIVYfFghB9s6i2cqsvQhenEklej6HE
         d4VhZxykHkQTozhCEsXwn19MbvnCxBaomU2t/5IEZp53LkPHQEwSyMbCCNgiu3OeUtJa
         7eeA==
X-Gm-Message-State: APuU4Z8XOVTcK0EhKdEISQUcfks2eBT3a+dc6CL6xrGU1WyA7eOiHiFk
	bHO+vsgrE/7iWpclNwNx2ChycoceQTRor3XwGdIy8uMjlevael84+7j9TFMaD0lBBYEhreNhyKv
	tsZEYqMw=
X-Gm-Gg: AYBFou1/yHJMJNfM+tNlfPOiPHMqY9GE9JLo7VIKkBl/18pB+tqG6SfxmjLCsczxWuv
	wbEKth9zvQjCtrLV3Ul4lnjP1qve8Sw5xywv8eT5ZxizCq58eLt0SKjurfQjc3j/5SUjI5NQHQt
	Jgo2stTY4ImRA8bOTb1HazHCfn3fH2FQhbFk+cTziaOKU3KLGAiwsf7S+kVQm27E07vBmDhqoUV
	O+HkYjbT+NprhBjOYEZvj6Yiw3Iggzz/0gfItgAbbXnHco1GJE/NB4N7NjO8hIg0uqQ+MW0VYBg
	5PflDVf3H7aOOdD/Itui82A4QH7GIP4zXwyEbW4uUyshKa25RqZeZXhtzMgHEuxPryqKfXjAE50
	wNwi1asCLzZ1toMflyAHdsHQV1JHBtUYJ8cHe/Y3UuNWjH3wT5W/G7NEHHvrVZWLQeTGbqDY72Z
	qL3I8u8sMURLdaID6CcwJ7f8Xt+zBIlU8Zgf+X4WHiMhMgMEFV8dyIshqxeyK5R5B7+9YmDB2Cu
	4OVyqye0UcLpy7CeZOma3MSKTTekxa8YwSuQf/xgbVSVeL1lF75pTNUtu7hsawvCaf2OyMuJH2M
	sB7Iug6668oe6Dd9Jt5I1PRVwC7uynmlsXo6jqdPmtD7oJQtKF+oaMMGT87ECNaQBuehaYF2KFU
	iwTnWGsx2
X-Received: by 2002:a05:6402:270a:b0:6b3:fc71:fc29 with SMTP id 4fb4d7f45d1cf-6b597524c7emr3524795a12.6.1794023308615;
        Fri, 06 Nov 2026 19:48:28 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664afe901sm1403428a12.24.2026.11.06.19.48.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 19:48:27 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Keogh <dkeogh@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	kernel-team@cloudflare.com,
	nh-open-source@amazon.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH iproute2-next 0/2] iplink: add tx_extra_headroom
Date: Sat,  7 Nov 2026 03:48:18 +0000
Message-ID: <cover.1794022936.git.tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
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

Add support for IFLA_TX_EXTRA_HEADROOM, which the net-next series "net:
configurable extra TX headroom for local egress" adds:
https://lore.kernel.org/netdev/cover.1794020868.git.tianyi@cloudflare.com/

Patch 1 updates if_link.h so that the series builds. Please drop it after
the headers are synced with the kernel series.
Patch 2 adds the tx_extra_headroom option to ip link.

Tianyi Gao (2):
  uapi: add IFLA_TX_EXTRA_HEADROOM
  iplink: add tx_extra_headroom attribute

 include/uapi/linux/if_link.h |  1 +
 ip/ipaddress.c               |  6 ++++++
 ip/iplink.c                  | 10 ++++++++++
 man/man8/ip-link.8.in        | 13 +++++++++++++
 4 files changed, 30 insertions(+)


base-commit: 204a721033556114c81c47d00375f2d52e98e463
-- 
2.56.0

