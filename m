Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF0F471272
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726788; cv=none; b=Gh2D5UTDfgnwXp7DMDtffOPfSmQA7+7xcumabsg5OqF4hbJDDWCu6aRhqBOAPTFQ8BCd7/weXAuZ9QEExNiuAaIo1v4MgWsgRX3aAbcLQxDgwIpJp0eVuXkSCgec6VgmviIpGDg33kGkpq2QIf0HFXWk2ZTbBi1sAjiVcvUddCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726788; c=relaxed/simple;
	bh=1PqIw4epZOGIIJV7RJGfIeIHMNFUs+JTBGWYkw5VN+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4wb7lmmGneNhmLtKYEQzUWewIWr8pu43aicJYgCCQLnyGbv0WdrLWmbxoUq7qhwYm/xV23b9dp0Mu2FZ8PLN+Ar5MjC2DE8lBJkzaQF1phL4eoRyer4qFz9o/qE1+E/Le0wn38gooeIG0cGUzVzkH2IjJApaolGUhFzm825DO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddEdNDOP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddEdNDOP"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f703a9d05so898255f8f.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786726785; x=1787331585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+DARaqjHQu8C0ACnwB7eY0dFI8JI2hJdhLIuRy/qFUs=;
        b=ddEdNDOPkJJAmaHcaBKTgUP06x/8lx3dl62V2oLfmihv7l/MYVGmuLBxZb4ZrM+xEx
         Qyl2c0CzEY3MhrsFe6D2STFl/B4FOTd9zg8j60NqqMNhdWNnQQYmHEPU0ORf1IS23xCd
         OUH9tS3ceMsEa3/vCRuvL2ljXB422XTGOXHdm+Dh1O5/FkMONjeu1M1Fg+G5TIPzaCyv
         K33/0eKVJ67CRzKmlL8uSfXzNjaezJze0jgjgI7WLyJgDAsoQSGb4ARN1QJSISwdRVmT
         CqLTzz+5o9ojzIek2So7f4lNrZ2e9b+YPCXqUIUYQzb+rdpSzgp6Sa34pbTHkbyHVV2m
         oq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786726785; x=1787331585;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+DARaqjHQu8C0ACnwB7eY0dFI8JI2hJdhLIuRy/qFUs=;
        b=dmsVVlWvLsSAKMiOczMFJkhBXj8eTJlOZXgABVQMffgSloPEQjA/pzKEUi9QdylG5c
         K8xyz81h2rGdrey9DFB7mxs7m0lpTUAoNTbpZcw88ggTsENxnp6WT/cIp1ROp/izMuUR
         TGjRjRwNj0CyE0YrHqtAnNQuqM+IU4CgCrsO01Zp8B+sHIQWfC8hFQzukMIkD1rbBepO
         c3Zb9KtROU8ussfBzsAbf60qIYNWEDSrj1tbnTGxFJlOJUuPboqw1lcm9zUsNoJOdqs8
         RPnnZuqjrmrftFVFNkVd2mbu7YwH4i6h6+c/jPv6/Plyn3/gr1qZwaa9kUmVbXUX7SSy
         vPRQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr5C4QJ4Vrn5rSUF4vl+5+jWbn4sFAQSjdJeXjtUhh4SlJ/Gzi21KG5FtKwA/1JW+PglCWDbqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOL8QC5UBOkv3N+8FLPW3xMWS99Ob3Mou0U6CSKVz4iq9/5tsM
	RtujXc3PLE7gK4ck1o9RgzBwZTquc8oDUEFlGMzYaDC8NhvgBKiCJw3M
X-Gm-Gg: AR+sD13kF8n6dMrT6n/6WZzrorc5prTJOb1wvtqvlU2bPY9TX1pOncLi7Ebv82lf5Gg
	djrrbVPjBT4W56TlaISIkRNHYTRktIujs8Rek+nJX4guTz8wKyrOM5hWyTH8ImU9Dpm67FL8E3R
	eoc+pj8g/BOaofZoHUpnzHBF89cp4C/56GMkffXQLQfajb4QFV1PB+EHFVbb12dkNuamKRDW3N/
	0rqpIMCzRf6rGcHoOs43RR1uIyeeDXAaXiHtajwoSM6WpnhOG8gck9KdAS92S+q9Juc3O39xqnL
	ukGjUr3GnzYIIQPznznty4w5l20F4NAuPGDiBSuUygt6E/Q2jGMPzl9a6hbphv91vnQFBYuvnV6
	BfWnepy0Vd1tJSJq7KsSftdqVifrAMaKsXggWtpHkGhLqvW6VQA9qsusuAZpyMzbRshEzzrBEQW
	G5MhLbg7CkHDVWkP5omaDxlVCobwltzTIU2V5IXTO8SEAvtU2mnbuFuuwLc8LDX7TQKokO/+YT4
	zvv+XHKCSV3U0BdLM5hw0chMg==
X-Received: by 2002:a5d:4386:0:b0:481:4ee4:e49 with SMTP id ffacd0b85a97d-481607a6a59mr8894213f8f.25.1786726784783;
        Fri, 14 Aug 2026 09:59:44 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f20058fsm11046431f8f.4.2026.08.14.09.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 09:59:44 -0700 (PDT)
Date: Fri, 14 Aug 2026 18:59:42 +0200
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
Subject: Re: [PATCH bpf-next v7 3/5] selftests/bpf: Add ksock kfunc test
Message-ID: <an9JfnuGUFifuQGB@gmail.com>
References: <20260813110540.103550-4-mahe.tardy@gmail.com>
 <b0f93b51174ba64b1ce220ea0ef67b1eced238efdd66ed4a5960f3b2966a70e9@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0f93b51174ba64b1ce220ea0ef67b1eced238efdd66ed4a5960f3b2966a70e9@mail.kernel.org>

On Thu, Aug 13, 2026 at 12:13:34PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
> > new file mode 100644
> > index 0000000000000..05d7b7424aee3
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
> > @@ -0,0 +1,124 @@
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
> 
> [ ... ]
> 
> > +static bool ksock_test_env_setup(struct ksock_test_env *env)
> > +{
> > +	struct sockaddr_in addr = {
> > +		.sin_family = AF_INET,
> > +		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
> > +		.sin_port = htons(RECV_PORT),
> > +	};
> > +	struct timeval tv = { .tv_sec = RECV_TIMEOUT_SEC };
> > +	int err;
> > +
> > +	memset(env, 0, sizeof(*env));
> > +	env->rfd = -1;
> > +
> > +	if (!ASSERT_OK(make_netns(NS_TEST), "make_netns"))
> > +		goto fail;
> > +
> > +	env->nstoken = open_netns(NS_TEST);
> > +	if (!ASSERT_OK_PTR(env->nstoken, "open_netns"))
> > +		goto fail;
> > +
> > +	env->rfd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
> > +	if (!ASSERT_OK_FD(env->rfd, "receiver socket"))
> > +		goto fail;
> > +
> > +	err = bind(env->rfd, (struct sockaddr *)&addr, sizeof(addr));
> > +	if (!ASSERT_OK(err, "bind receiver"))
> > +		goto fail;
> > +
> > +	err = setsockopt(env->rfd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
> > +	if (!ASSERT_OK(err, "set rcvtimeo"))
> > +		goto fail;
> 
> A subsystem pattern flags this socket setup sequence as potentially
> worth simplifying. The network_helpers.h header already provides
> start_server(family, type, addr, port, timeout_ms) which performs
> socket() + bind() + settimeo() for SOCK_DGRAM.
> 
> Other SOCK_DGRAM tests in prog_tests/ use start_server() for this:
> cg_storage_multi.c, connect_force_port.c, cgroup_getset_retval.c,
> sock_destroy.c, and tc_redirect.c. Could this be written as:
> 
>     env->rfd = start_server(AF_INET, SOCK_DGRAM, "127.0.0.1",
>                             RECV_PORT, RECV_TIMEOUT_SEC * 1000);
> 
> to drop the addr and tv locals and use the shared error logging?
> 
> That said, there is also precedent for the hand-rolled form in the same
> directory (cgroup_storage.c, udp_limit.c, xdp_metadata.c, and others),
> so this may just be a style choice.

Yeah unsure it's worth simplifying.

> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31694719067

