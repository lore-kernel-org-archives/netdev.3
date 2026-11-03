Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729883;
	b=UCv5XR+4/CsEACqqwfw+w/oSiqBSxJBoblk3m+av+KPoe0GJV+Tl+v6W65OxhmX4tF/E
	 7+XInWKKbxN6lTVVV8wKl8il9NcFJ7Ucl26UZO6glhX1LkrWwoN9oKgDhGQHhN+OVJNls
	 BxtCkHiPAeT9nc9YAN1fDnSNv9me5AV55WPX7Vr8vAER5cPSPFkjVGeb12iTAU7wCgpwK
	 b8tez+gfxJU7V4Cr38MX8F0tjaTjYlVMXNxlG8FpLmWWO1bNAx3aVz7xzVA2wSHNnKR2O
	 AEj1VQwDCdJWqMOUIf3/wjQrnSQzyvzsekH4rOLUjITX6zlkRRj3miZ8HwFAhsxlTtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=UTXYGVplWAO8VvUr57iHtg64uySoLqOFfaNXV4F6AE0=;
	b=ZHKR9F7lUAR7cSNbhQPQyGpEdLXyxoTtH3JQ0j2CpcGpvZABwKRN6XNDDi3PjJ0N/E5H
	 bQgaV89qqan3Dd9CTqfxZeW0TRX/2tjr8/Ero7eqyB7lIuLhoN92/n/ARaLReA3KEG60i
	 1lPi01oBYSrIdj9BLC0B+R0wD52GCyUi8cCVT5krDPOJ07b26VwEIh/fxBrYSASx89yzw
	 BaVtIPUWUv2XHNpvWOzIl+qf739UxyOL7lxhumB2FiQelkdk7myJDxQSKWzdjD3dlsETH
	 Kc7pQINnh2Llq4QdubMvSeAypGratPLEIU6C57RzsoC86QWWhmf8Nh1MAmpvkoD+Pbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pouAy1+o;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E0C606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 18:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4E0C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pouAy1+o
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso456737a91.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 10:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793729882; x=1794334682; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UTXYGVplWAO8VvUr57iHtg64uySoLqOFfaNXV4F6AE0=;
        b=pouAy1+ok7smtwkWcvXNMyZ+av0YOdP0F2CTGZJOdo1h+iagn9OJO5sfsRkmcddUsw
         /Z/npUVUN5GPnT/E9FigiZbxl74IB5Nuz4RC0yOOKHHfGNW6zJA8m7jbSQTn9U4irWsj
         XvNRItPUfHKulRKzdu7VGzij4llfxI7+zx9vvw2DKTps7MupL8YztsuLMMzNdSrZEzFr
         /IUbp8dxpt71AtJmpe6ZsnL443v1SzH45RkK7sWebng/CrGRt8kY2q5neiOxe+MUZpIS
         YYtsSyTn8Sz432BXUbsql1oJYhZP7lhawuqZnQYPO6fV/Da3R5YdqFW213nIgnI6zwsU
         AfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793729882; x=1794334682;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UTXYGVplWAO8VvUr57iHtg64uySoLqOFfaNXV4F6AE0=;
        b=F1L7n4495KKgl6+XBJGz6lx71OEKQULFRT2uq8NvfX4xs0HW60rtngMe882fkVT4zw
         WxpjomjwqPoyvYCZ9DokInr3EBuFulkY2LwXFP8L4Yjkura0mD4n8RIwuvyHpa8qa3GQ
         nNGWLSqohEePypaS51LEBRUVLUW8mRbSYbUPRkUW0Jtn6Fc4oJgFRroKKUfd7+I4tytJ
         l6GZoSn7f36Ej6CDS6EU56DViLcK89gT5A+cXlW4nlGdq/w6jkL5aAISN7WyaQOAjvwO
         0inDIlN+mtbRwfoXk7JSIqFfhJfIBmlCIzXhcLS3Zl2LW4ZOr31oJECq8AcyFnF4q5L9
         B7Zg==
X-Forwarded-Encrypted: i=1; AKwUvBwoMWUuc/W9AdRQSCcKxlk1EO8cIW7yKBDzr6bDd1RZ1WXuHqfqppMMAsWXThFZgpFa/IIHt7Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dxo3Kbw3XN6oXNcZIjLVwQTagufo4YNWBPAq5m0nBMgdckKwk
	/SYD66RCcq+TSNAt5QAPEaW+hswbxVKSK7n142iYCQfM3B3Wq5U94yoH
X-Gm-Gg: AYBFou2tJttE9LHSBgVI0icbuCPQgiWIPp8LTNgaaRHB763MNKJ4netukGoSvLppP+F
	pVYlKkCYqiUCFr+Xhb5riH9SD8EZytFEqsLQ91n1xrc+T4qSmjHZoDwpaUGsML92ooJxT+w23q3
	DmbS3Dm4zXTs6I0flu3m7p8E9m7PjXTiJ2h7lOU/RAfbU0ITuS/ztNMWADJE1ALJPxToFpyYO2K
	Wb0pzVsAMfA3kRRne94rkC6HC2zOqXui1Vf1PLX1QkfttAYltafSpNkJnRoM/uqwHMhi6Ztm1nx
	D7vRlKmtAZqrv6rSMC5iO9LMBW2W9ilMeBnD7Tb5r/na/RdC3xm3oObJX29Wdo+rKnGA1C1wJh8
	J9//lMhU04Z+fu72HibM+TpdtKaGFk0YlMVY7WLfBoIbpFaRsNITDsJDcGuV8+1yV3PlnP3KOF5
	SZY1N0LqOZzmqFVfJgYyfuvwPoXwfApwlxCTejR28QZ7gTJHhb5EzbPUnIUYoBKQ+NMSRD+MCA4
	ioPAoR3ev4DK0KYe/kRUUMrGQiQNe/G859M/xkryIgoHvvDzVlneS33uVWn71/1TVD3IlluUOvI
	jYX4y47/UcqOy6rxKjC6BXmcWyiHMyfblsqVYjAAflzIOuEWJ1Fz1wzsck+2bh/DFCyS6KWv1Up
	lG2RVyRydlMLw3fBpO/62hilek6N3vsv5xkhlTUKFazf8x0F1JIF5vYo=
X-Received: by 2002:a17:90b:3d4e:b0:3ad:1841:6f8b with SMTP id 98e67ed59e1d1-3ae8981e41fmr10183965a91.37.1793729881831;
        Tue, 03 Nov 2026 10:18:01 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c7e087csm5445702a91.4.2026.11.03.10.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 10:18:01 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 18:18:00 +0000
Message-Id: <DMLS6BDLXMCV.1C0EN486O4XLV@gmail.com>
Cc: "Jamal Hadi Salim" <jhs@mojatatu.com>, "Jiri Pirko" <jiri@resnulli.us>,
 "Martin KaFai Lau" <martin.lau@kernel.org>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: net_sched: reject bpf_throw() in qdisc teardown
 callbacks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "shaos" <shawnq1@163.com>, "Amery Hung" <amery.hung@bytedance.com>
In-Reply-To: <6AEA1AAD.2E7977.08739@m16.mail.163.com>
References: <6AEA1AAD.2E7977.08739@m16.mail.163.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 09:32 AM shaos <shawnq1@163.com> wrote:
> A BPF qdisc's generated reset/destroy epilogue cancels its watchdog
> timer.  bpf_throw() unwinds directly to the exception callback and
> skips that epilogue.

That's a bug in the verifier. bpf_qdisc.c is the wrong place to fix it.
gen_epilogue() is a contract: the epilogue runs before the prog returns.
bpf_convert_ctx_accesses() puts the epilogue in place of BPF_EXIT
in the main prog only. The exception callback is a subprog.
So bpf_throw() breaks the contract for every gen_epilogue() user,
bpf_testmod included. Fix it there.
Then bpf_qdisc.c doesn't need to know about bpf_throw: no BTF id,
no QDISC_OPS_KF_TEARDOWN, no forward declaration.

Like:

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index ead7871..5363e88 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -909,6 +909,11 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			verifier_bug(env, "epilogue is too long");
 			return -EFAULT;
 		} else if (epilogue_cnt) {
+			/* bpf_throw() leaves via the exception callback */
+			if (env->seen_exception) {
+				verbose(env, "bpf_throw would skip the epilogue of the program\n");
+				return -EINVAL;
+			}
 			/* Save the ARG_PTR_TO_CTX for the epilogue to use */
 			subprogs[0].stack_depth += 8;
 			insn_buf[0] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1,


> Fixes: 7a2dafda950b ("bpf: net_sched: Add a qdisc watchdog timer")

With the fix in the verifier it's
Fixes: 169c31761c8d ("bpf: Add gen_epilogue to bpf_verifier_ops")

Pls add a selftest as patch 2. bpf_testmod_st_ops has gen_epilogue().
A test_epilogue prog that calls bpf_throw(), with __failure and __msg(),
is enough. See progs/epilogue_exit.c.

Pls target bpf-next and cc ameryhung@gmail.com on respin.

pw-bot: cr
