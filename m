Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609039;
	b=d+9BhdAt50fODpJ8KOXWGde4yPEvlWyM+tSuXoWQohrPVaRokTAjCC79VugGvEqjSvPI
	 IwHGut0o1cGm8i6mWZ5mRggWqSZ9a16iS14lGqqvDP/QfIuMpnEhbb//U+y7IkBtZnyJW
	 7rl9cmI7wBan+tWlqygKAOXR3G3FTWEHB4ZyZtUJ2MEu4M6SruAFaUBa1WhTAZlYtl613
	 DcZvtf1HKid2hxaE15sJy7GR0kAc38DHKb5JzIg+TBK6DVId/g6prh+KNfNyu+ktaAiWV
	 ptemsy/myVNVmkprn02RzK5QQiwViohf4uW2b22FYq+p2DK903bofoJtTAYiJVPRJgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tI/n7i8YUulS5nmMk231Om3hhflnA13FHGA5mnNrpuY=;
	b=tBvEm7oWF2dCRT2Gf3CwBD3NKM7FWYgN49JSeAZNH6QQ9V0gOYJWO/c06hwM3mxj+qbx
	 YD09MhQCwtaP0Jgy7H1xQDApTAIfJFVleB69LLIXgvfT5QD7zxQwA10x493zG3/YBGUIt
	 ehz3MjNLZT8AYApBcGODSLRWT+tWPH/Y0+JkdFG1emeWDHlsT7rBMiVoqY9/0Y2d8tNzP
	 LxlbOK5+m/jZhac1pcPRoTSweJanHcdOcF3LlVq4GQrE2k1b+Ztio+FaBrolla74aEtIx
	 d/p4FMPPyT1ZbxPWfYAwwoEz8x+pnokghGMR3puLiZYxqOg30YVEgqRnH4KUw+n4dXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=sMdTfLuT;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B54E606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 18:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B54E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=sMdTfLuT
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-188406bb948so605365c88.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 11:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792609038; x=1793213838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tI/n7i8YUulS5nmMk231Om3hhflnA13FHGA5mnNrpuY=;
        b=sMdTfLuTKJULS0Py84zcJG7gxVbaoZFLk0uy6tq+akLRbz8GTm24Ytky15ywyNE14U
         WIJshEp4jqB/NVXmTMwR10O5nwI9GMJZCcvHjT189KTkAYM5rdXSzQzxBwLc6XIY+iRX
         Dpw14ZhPgTGQt/zlwEmzAEANGQyzCbdGl7/NdDTeUvYgRjR5jX3YPZddOAFUaQvsbSFV
         ej37O/De8wCgGfMMpA3/TX+ztzYN/K/tjBUgc0WpSeA+YfKdKJ8vPylM6MSDxakMzykJ
         DAZkcGIMkx3YYJPm4plCpixnJA4FSv6HNxW0DUnfe1n+wWb0xeZoiasOMHMQRsUAwz1J
         GIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792609038; x=1793213838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tI/n7i8YUulS5nmMk231Om3hhflnA13FHGA5mnNrpuY=;
        b=reGc8UAhCjUfiR7DcLhrBfKNsg4umMyxhwzYDLDMwZ5MG7/xxbJJevbmkRuCcViakZ
         7l3WDX0niNbCT5pc3l2wZQFO89Zl0OGxJT2adLoK7jypdpJ1aah1linZDGCBKGFcgiVd
         73mSuN0Dd/fDc8LnXh/K9hSr92n48w9IWzjgPoZ+yGeFeSYNzTYWZWpuyH5cQ7R49v0R
         WZDePh5e3hePDxZ7KqokkK9nGGPkzhxDwvF3zhfCod62Lyr7GiefY2P6Wz9jybXmXk0W
         0iCnXjt7pprDKnaWpyL2ePeL+FqdOKxHB5LOvtyalSYTyzAEBf75ijXjLFcVP5OZDGCh
         tk5w==
X-Gm-Message-State: AFq9FYIE3Q5MJmJlNvcvSpbpJpma3TGKKHZFXRo9Vzv8D2IQsobIhqf+
	/8iOisceGl8YmP+ovrW20vUBUAmv7XgvTFacpcHwIlCokZBg4+iKwvQJe563cCmApX5fmAMNQVK
	SJuSlil+K
X-Gm-Gg: AYBFou0Is1fvi12LFJBvVMyhoal7i/7JOEW8vde8EfVa+4hTU2pX2FfB5d4QYDtm4+s
	1hkQmlmT6M76Z7QNBx2tmv2azpRI1fyepqGNMzjtTD8gjcuYb/YOfSzt5/Ru5TRBhqvCga0bRzE
	CL4SIHeUcQk1tqR8vr4EteTrBV+X5d8OtUyeQ/dKRxvATqXxA4DH24KY4GDoIZenREDoghPCNe6
	MhEBmZYdxwOx6iVTWT8AVKmco8EHlZ9Tro93IULwbCX8dt6Cn7Bur0nVcJV7HedLXtHExzvwMPO
	cjzpJbcFCUEOcSgSm/ABf3qktIXAfxvFRn9S08ATNTyenOiB/0yggSlXfCEzD7/O3n94XD+ysEL
	ysh4IZtuyWi9Pr69W/B8Hh2jbAcYhh5VhheBzP8rWk00+nDhcTAbL0gmKUVSe9jgeOKWoz/4o3F
	Xqg6fVsdRGwQD2StBeduH1ZOuIXzbmqks6hzvlh5HSwLl1s36r/ghhuOoNzJGXjgRBLoltIIe1A
	Y/LNZ53QPy2cjCy67sZJEFR3EjD8idZYA6wOoRKKEvgZkTAOUbsnQ+ymC0VudJnqR6xXFU=
X-Received: by 2002:a05:7022:387:b0:154:fa0b:6df1 with SMTP id a92af1059eb24-190a6fa9d37mr4175396c88.37.1792609037603;
        Wed, 21 Oct 2026 11:57:17 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([203.175.14.58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a180b9esm12553346c88.4.2026.10.21.11.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:57:17 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	jonathon.reinhart@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] tcp: release congestion control reference on rejection
Date: Thu, 22 Oct 2026 02:57:01 +0800
Message-ID: <2773af2572ff59055933e407a135b39bca537381.1792607608.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792607608.git.zhilinz@nebusec.ai>
References: <cover.1792607608.git.zhilinz@nebusec.ai>
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

tcp_set_default_congestion_control() takes a reference to the selected
algorithm before checking whether a non-init netns may select a
restricted algorithm. When the check fails, the function returns -EPERM
without dropping the reference.

For BPF struct_ops algorithms this keeps the struct_ops map and its
programs alive. For module-backed algorithms it leaks the module
reference as well. A network namespace administrator can repeatedly
trigger the rejected request after the algorithm has been loaded.

Drop the reference on the rejection path.

Fixes: 8d432592f30f ("net: Only allow init netns to set default tcp cong to a restricted algo")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/ipv4/tcp_cong.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index 8e83ef81fc187..907c63af14785 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -293,6 +293,7 @@ int tcp_set_default_congestion_control(struct net *net, const char *name)
 	} else if (!net_eq(net, &init_net) &&
 			!(ca->flags & TCP_CONG_NON_RESTRICTED)) {
 		/* Only init netns can set default to a restricted algorithm */
+		bpf_module_put(ca, ca->owner);
 		ret = -EPERM;
 	} else {
 		prev = xchg(&net->ipv4.tcp_congestion_control, ca);
