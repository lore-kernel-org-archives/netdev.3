Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED45448388
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786618739; cv=none; b=qNod7oWTTPHpBGSMYl6RuBUrO+/HQ5z0X22wyc7Q3x22W1l/mZpsnaugmTo5xET9zL2DXXdmgaUG2ofvnYNx3dLALHIG1aB1Nrlvg/JpEvHkARmCwC9LldP/7up3ofvEy7Z6oS5eU6m6jBtFkzXndH0siTF5TIxfPudU6FprpqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786618739; c=relaxed/simple;
	bh=Fqzrf0c2oHZqHvAErMmb00W5PvWM9c8tM/DAUJZyZLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d55TDJCvNQn09dL53hMsx0cqArKejFphjf/Z45DRAazGdzkf/vDIFwonVyrw0mb8fRlo+W6D8ImxrU3eLk15h7f/oQBjvJ5NUPJYGz9W0ACvOGq7r0IwACxFS9KMU3jjVNk4E1PKDSwi+yoa35mstnhMuibqoy2dTpvQqXtR7x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuQVPvsY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuQVPvsY"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49553515a8bso28151635e9.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 03:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786618734; x=1787223534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zF7uWzlZDW/sG73C3vYL1MwLDbuHk+pWvcN9523/eB4=;
        b=OuQVPvsYNIbhqIxi522jJye2vTZeggGfPO/WH2NrvCfEwIojPFHh9UUSTDpvny50ae
         f0IWbsrDwbnuNOUZIF+WL0YTNpF6Ehf0zpIbRipH/q/hG+LCB9KwFSm+k8nkeq8b+O6Z
         ujC7H78x2LO+am3kTjfdLAQ9Mlh5rQamAceM5y+eg3ciEZ8RW0khAK0pbkbJXFkKetuR
         RrxqKclC005qEI6yGiXM/g6yUZShuAv1yNMW4idpWpdP7LDCTulXdVAY+YX9WrflGDN2
         M9MuTuvAXdUKAHETFJqrK4WJGkQDZXcc17K26Bu4pxaU/J/pvuUi7vKbdIgo12vK3Wbc
         cEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786618734; x=1787223534;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zF7uWzlZDW/sG73C3vYL1MwLDbuHk+pWvcN9523/eB4=;
        b=HIagok9yS0JPsLe+USJt6wGiqn/1H6Zd5s7DCy3j+XnwPr3xIoqAXt5opW52VxEs7Q
         kjLoKhMtyucFJCG/C6Rs95/McjurfVJoJOYPczN8lR+8xxX7pfQjoPqoOYAV3I+zyM0M
         lA7P90ONRMqbZMfPwo7hK7pzJQM1QqHQepFUUIH8OV5clwMtJ5xtepCZfmK0m6H9R4/I
         8KjKkENaVkpaRe+JEyvaHNpq4jwM/3MqkVlbwkIpaEP7TeLdfzxYEOrWQrzl/5WP1tUH
         3W+WtQirBFTRW3lWDXuSYHLTgY66rTPcQ11Nte+Mifw/nxsfh2R9GHzgGy/lgG0Zq9qL
         MKGw==
X-Forwarded-Encrypted: i=1; AHgh+RrPU/GVRBEqwvlw/CGLVgBdQK9gOTPRw73GYvyC9OgHRx9QAhiyO/L5bhbApyejh2L+4jl/iQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7kd2VsgFWga+zanIOWckABJrUwS1XoVTH4g+xwlL47i5D7PI
	ob/wz68UviU4klOsd1Vibi7iVKFpMIEQEAgXriLV1wloTk1PfFQ5GOFK
X-Gm-Gg: AR+sD10hMzOYC11Bm0OOlEq35jAIbx9jXORrSDiY5q5/i7wwVhIe85rZSRXKbFA7e7z
	DZmMth6bIJzBUYPWCj6jqBB9r9DTw4QDX+Y1Zn3cpTYl48l+XEw+Ne6y3JsQOqb+AjKUs/FVS3g
	rl+hGqKAT2O5F305BbIuPtzygOpKM6e0jEJ8tPFBaIXhQHjeasnJfIkzkBCC7IYVpc6UzVwrOim
	BQ7SqGt+nk3og2Gt15WrCZwP+mK5axRdne6NSmCL1fkaJCIpgAcXs70Hp56IOger4f/C8QwUWmW
	DDjsPfUdlFcA6qi6FP9ZKHFyVfjH0RkGFbciqTMGbXYOECU1cAKhedoQXDAY6zUPYCV2AfPxcDf
	PLy8iSeP+zJHV+klQiGpBsAttWjhneX20o3WeTO8LUE5fPtJH0/noK7uBayje3ihR3mwZDpP6y3
	mBWoEuGW9+YxYqHTcEAE0humCddATe2oscvBoMIJnZVJRSn6Uy+xY776iJ/njsqSF2CUVH6Vafb
	z2zBnSsJWF0YSmfn3sY
X-Received: by 2002:a05:600c:46ce:b0:495:779a:ed33 with SMTP id 5b1f17b1804b1-49982193132mr46948415e9.7.1786618733847;
        Thu, 13 Aug 2026 03:58:53 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b1063esm67637475e9.6.2026.08.13.03.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 03:58:53 -0700 (PDT)
Date: Thu, 13 Aug 2026 12:58:51 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	sdf.kernel@gmail.com, ameryhung@gmail.com, kuniyu@google.com,
	memxor@gmail.com, jiayuan.chen@linux.dev, sdf@fomichev.me,
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v6 3/5] selftests/bpf: Add ksock kfunc test
Message-ID: <an2ja1m_Bn09XpqC@gmail.com>
References: <20260812154328.72834-4-mahe.tardy@gmail.com>
 <389d7d5984e3995303dc4ac505c8629e5d486bef420ffa47d5ee2edf3761cec6@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <389d7d5984e3995303dc4ac505c8629e5d486bef420ffa47d5ee2edf3761cec6@mail.kernel.org>

On Wed, Aug 12, 2026 at 05:25:42PM +0000, bot+bpf-ci@kernel.org wrote:
> > Add a selftest that exercises the ksock kfuncs end-to-end. One syscall
> > bpf setup program creates a ksock context and connects the socket.
> > Another LSM sleepable bpf program looks up the context and send test
> > data. The userspace harness creates a network namespace and a new socket
> > on loopback, run the setup and send syscall bpf progs then check that
> > the userspace socket received the data from bpf.
> 
> The description says "run the setup and send syscall bpf progs" but the
> test adds only one SEC("syscall") program, ksock_setup:
> 
> tools/testing/selftests/bpf/progs/ksock_lsm.c:
>     SEC("syscall")
>     int ksock_setup(void *ctx)
>     { ... }
> 
> which the harness runs once:
> 
>     err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.ksock_setup), &opts);
> 
> The send doesn't happen in a syscall program at all. It happens in the
> sleepable LSM program ksock_socket_bind (SEC("lsm.s/socket_bind")), which
> the harness triggers indirectly:
> 
>     skel->links.ksock_socket_bind = bpf_program__attach_lsm(skel->progs.ksock_socket_bind);
>     ...
>     skel->bss->target_pid = getpid();
>     err = bind(tfd, (struct sockaddr *)&trigger_addr, sizeof(trigger_addr));
> 
> This also contradicts the preceding sentence which correctly states the
> sender is "Another LSM sleepable bpf program". Should this say "run the
> setup syscall bpf prog and trigger the LSM send hook" or similar?
> 
> Also in the same sentences: "looks up the context and send test data"
> (sends) and "The userspace harness ... run the setup" (runs).

Yeah this is from a earlier version of this, will fix it.

> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
> > new file mode 100644
> > index 0000000000000..30e89d34d388f
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
> > @@ -0,0 +1,127 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2026 Isovalent */
> > +
> > +#include <arpa/inet.h>
> > +
> > +#include "test_progs.h"
> > +#include "network_helpers.h"
> > +#include "ksock_lsm.skel.h"
> > +
> > +#define NS_TEST "ksock_lsm_ns"
> > +#define RECV_PORT 7777
> > +#define RECV_TIMEOUT_SEC 5
> > +
> > +struct ksock_test_env {
> > +	bool netns_created;
> > +	struct nstoken *nstoken;
> > +	int rfd;
> > +};
> > +
> > +static bool ksock_test_env_setup(struct ksock_test_env *env)
> > +{
> 
> [ ... ]
> 
> > +	memset(env, 0, sizeof(*env));
> > +	env->rfd = -1;
> > +
> > +	SYS(fail, "ip netns add %s", NS_TEST);
> > +	env->netns_created = true;
> > +	SYS(fail, "ip -net %s link set lo up", NS_TEST);
> 
> This isn't a bug, but the test hand-rolls network namespace setup that
> network_helpers.h (already included at the top) provides verbatim. Could
> ksock_test_env_setup() use make_netns() here?
> 
> make_netns() in tools/testing/selftests/bpf/network_helpers.c runs exactly
> those two commands:
> 
>     r = asprintf(&cmd, "ip netns add %s", name);
>     ...
>     r = asprintf(&cmd, "ip -n %s link set lo up", name);
> 
> and it also unwinds the namespace if bringing lo up fails, which the
> open-coded version does not do. The current path leaves the netns to be
> cleaned up by the caller's fail: label instead.
> 
> The teardown at the end of test_ksock_lsm():
> 
>     SYS_NOFAIL("ip netns del %s >/dev/null 2>&1", NS_TEST);
> 
> is also what remove_netns() does, and SYS_NOFAIL() already appends
> " >/dev/null 2>&1" (test_progs.h), so the explicit redirection is applied
> twice and the command ends up as
> "ip netns del ksock_lsm_ns >/dev/null 2>&1 >/dev/null 2>&1".
> 
> Using make_netns()/remove_netns() would remove the duplicated redirection,
> drop the env->netns_created bookkeeping field, and inherit the shared
> helper's teardown-on-partial-failure behaviour.

Good point.

> 
> > +
> > +	env->nstoken = open_netns(NS_TEST);
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31618864886

