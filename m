Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792787541;
	b=ekX8KTIKPuGIOl14T0BNZZfBoezcz9yHkYpCpUhuHPMRCECA9ZTSP00e4U6AGrqkRIEt
	 syfWn2aUsVr9qhSsY0XRc3kk8LXFxM1ch1U+/wyhOKaKZ5D1MrnCZ968ljAapyJKDfAZn
	 2cYBsNE8jn7OFNjIcbyEH+v0EwV6BXjQaeeFl81CUhH2b1oFbk8byD6yZWCC7D6SeApOm
	 cgbYk0nZdK5b+aTGWKYHBI4N02ftXmsilFWWe0N5UukQYtZ9XNCEDgA5lg2aOs1y44vfV
	 Oa/cXvqIcPNY4cg8Uow8fIUUZq4x05676ky/QYtAqNjkpXnntMtSonLdiySy/SJmnLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792787541;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Subject:Date:X-OQ-MSGID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pKqSiY/SjVjkcj4S0t3i0Y/6kWNN2NNw+22QabU2nUs=;
	b=vC2av3AX0gTo7qHxyOMSh5Yku3QL5BzToPPN1wji3rQrHxWHSg7Q2WQEj2CxA3qqFm73
	 hcmptO41GHQO5e8TKO8dlVLD4vi6GlZjtWxjG5/QwgD4h3h/9qDpsgR30RsudbCYeDzza
	 V73zmGuqdRazrBFzdYNyQs6yRXIhTSx9vLWYa8UMqal4HbqImGtDwm1WzkFWfQd54zMRh
	 xVHOW6jt9IvzqSVVrf7UC9qfDtTuqYebGSjM7mAlW1G4wxkEBhujG94mj944CJC0NbR1K
	 P37fjIFHoj1g0QGVrmzb72BhA270xC5sTJmh0DW8D+e73zbNQJhXqW2sQncIyDb7z/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=nANevys+;
	arc=none smtp.remote-ip=162.62.57.87
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAD6606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 20:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BAD6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=nANevys+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1792787528;
	bh=pKqSiY/SjVjkcj4S0t3i0Y/6kWNN2NNw+22QabU2nUs=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=nANevys+YHtY2WW5VjTv3t21DL25ZsOyvyrDzzFq5r8+lZvP2hIydkDiOOUUnyzpf
	 i+blgF5R6A/hVuoFrewQg1Hq3mkZqwNDLeHJGP4MoHaWbWeKGUjEtI64jH8r8lXoMA
	 k5OeXananjJ1HMmA9Wj1X9NCj0vPW45zzdgg9lCQ=
Received: from localhost.localdomain ([180.165.29.111])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 806A0C29; Sat, 24 Oct 2026 04:32:06 +0800
X-QQ-mid: xmsmtpt1792787526tfn38jjnw
Message-ID: <tencent_C230526401C94D7F29DDACF76C712DA7330A@qq.com>
X-QQ-XMAILINFO: MqswyhUqVe0CWbQua6uJqLc2+kolNMjkjAvVHAjjny0ATdVuxfdANZ9OTIPfFw
	 df7R5lEHsaFe6lxFEKJwl0CcxbduNafOclOdV6NY5+FTDnjNTYwafL1+TOqVdGEuhl3SX3cmJlGL
	 qRKQNF0TXLFqWBaojtFW9KuwxZuPtrAKasyaMn/OhZNvOBeEH2+NGsd/f+SqhzWWFTabjwLL03Cv
	 72hMo/ZHq7df+goCWv7NIMy2jCOEHXOeb7okBzrrlgFiY+2hU1ZAAead9B75M85xDpznBhJaDlGV
	 nQ+wSkYpzXuQEyLFSuuxJc0M2gkKcUJp1i6EDNhDrKKw/j59DEmbaTJeTKcHMPFwJm7mwjKG0CNF
	 WYrAO6gCRD7daL46YCOgRNd3JIhST4t1Yq7NaXZwgc4ExVACihvXgB9IsWYwnN804vrmhADM2jIn
	 TjxIrb/ymy+lwxKbXPhDTrn/HCiCFlpombH/60qlApLvRr//ZsCz2UCGtU9QGWpV7qVZ2W1mVm2q
	 h6VMu9odf6Ys0tbnY7zcleX99zzUjDkPka8yyOqO9Ji4pjMcbYNl98d4FdwkUp2E/ADpsp4jry4p
	 bQpqerLlGa59p4FkFK1Uml6tmubiRAzF4ESxFaqqlPFsB7yV3NH/ttbnUmUnxhcEdkapzWq2R71H
	 MIeIteqgWHTPYGLFAbEquro08ptvEbak3F4RZBh4J1nzTcM5qdDgE55a+MiRvahQAz59pUO4x2Fh
	 pY/HSECf1Ui3Jg4jGYLUtKSZ+i320Fbpl38kHvIC3HMQ4sUMsMYTeQ+egWbpl33itMvGx5v2FfyR
	 hfUIdEWWYKD6L/YT4h6PhD5//2O9zxF2bogIvbE5YStm85xgtNlXRU+jDrwaLUUSAxVDd1V/uG4L
	 nyCzr8EHprD9ui7SjkLEcW+gR3iUovqxhrvycoy47UeCPwRBqC4nVlCtKuGXawV1V0VxlI+kcD6Q
	 vK1k9AJsmlvoGVnJ47+Jjlo0JeNMakS+uH0cUiZV+Odnh7l9CKDbk7KsY1DXFgqvNw/fxDoLiMk7
	 HThQ4gi/OXYUTVi8PVahDTdTX9Cgs=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: dsa: mxl862xx: bound FDB dump walk by table capacity
Date: Sat, 24 Oct 2026 04:32:06 +0800
X-OQ-MSGID: <20261023203206.24586-1-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <179278688436.3134.7157929929766878085@kernel.org>
References: <20261022200425.80147-1-memoriaru@foxmail.com> <179278688436.3134.7157929929766878085@kernel.org>
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

From: Zhang Hewei <memoriaru@foxmail.com>

Thanks -- reviewed both Medium findings against the tree. Planning a
v2; replies to each below.

[Medium] off-by-one in the capacity check: the fix is warranted, with
one nuance on the premise. The kernel-doc for @last says "Indicates
that the read operation returned last entry", which reads as last
being set on the response that carries the final entry -- under that
reading, a walk of exactly MXL862XX_MAC_TABLE_FDB_SIZE entries
completes before the check trips. If instead the terminal response
carries no entry (and still counts as a read), the current order
rejects a correctly ended full table. The public headers do not
settle which it is, so v2 moves the param.last test above the count
check and drops the protocol dependency entirely; the macro name and
the error message get reworded to "conservative upper bound" to match
the comment.

[Medium] is rejecting only bridge_id 0 enough: fair. INVALID_HANDLE
is referenced by the API docs but never defined or checked by the
driver, so if it is 0xffff (the MaxLinear GSW convention), a failed
allocation would currently be consumed as a FID. v2 rejects 0xffff as
well, and range-checks the id once the driver-side bridge limit is
confirmed. Duplicate-id detection: the cross-domain fdb_del
consequence you describe is real; I'll see how far validation can go
without inventing API facts that are absent from the public headers.

The Lows are accepted too: the comment hunk moves into patch 1, the
"growing kernel memory without bound" wording is dropped (reported
entries consume the fixed netlink dump skb and -EMSGSIZE aborts the
walk; the unbounded case is a device answering forever with entries
that are filtered out before the callback), Fixes: tags will be
added, and the self Reported-by trailer goes away.

pw-bot: cr

