Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A389F3B14CE
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180639; cv=none; b=V53qK/LS2sreIy15m+drwv1yQvj2xBduLaxSp0lOZ2MpI7KiNETeV+8yLOaXBEyyAGn/DpCahVZDjXHSZDcx4s1eozwimml1+5lrrIDgpcuMiCnsUmLXsbFwvR0yQZaxHUmfmEJat5ZtmtTS63UzKze5HPvO2aOWpLzwOw14NXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180639; c=relaxed/simple;
	bh=PTcjz8vWjW3jDHeCpGXvTJCVPvV/cxE5ojeq7AV01H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPDyoSI8UJNbY1V/wFxw2w5E+T/zrZCnqbxXhN6Ue9BlyjlvzE8epiTJnXLZyQRJC3D+xKa8kJA4buA+OpO6y/ATyIU4nmp6xQxU0+qxtKavwpiSSKKRM/mTWpGJwIFEiWQaXYsZHLAT0sNBVh/ji/ih18Iv0kDyXYp4qAW6m1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKDJImcL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKDJImcL"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso27783595e9.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 05:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788180632; x=1788785432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=On4Yq5Dt/UWJCtp6KX2D5rROxyHdIygBzOFkrwM0we4=;
        b=NKDJImcLynS6EHZpMMsNCbHDybA+KiEFnfLgySRGPPu86lr+nENhH2mEuTJ3IqDLUO
         wtQGSQb5KLFjJ/jkanKxJLpSDn7j7A9iCq18e2DEGyyNwwwEwPFySemnaE/EHQIGroha
         CFWtC+sSGK9tCwkElYYpUXosMijtECRsI4UUNOoC7+zku3x1wl5FpUclwdrTNrMTIlUD
         c+XZ9vfgImmaj7X6Io7R/Z7m2P/Slzssv1+TR6yVCx2rB5VhCe1L+NNLLQEKX2jpCARv
         XxVRKHzmx1ARBXxf/A+pDC1/hUcIwxaJm0IVOQzjD+VPhpv9wphZVd7A/cu+n9rr2Coh
         AsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788180632; x=1788785432;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=On4Yq5Dt/UWJCtp6KX2D5rROxyHdIygBzOFkrwM0we4=;
        b=ZvfwsZeEObu4iE+36DaIHpceD6jlA3aIvGKeUEwLqzx+5EnIyENoX4Ck/22sPErNFI
         ZfZ92psBW2eB3zYXv4KtTvIy+uLVOTdlH4C5mBqw1PRiO1MQspph7NhYZD95pvDkHfTU
         hsmuJMSa18FZY00ZU25C3saXin2WhUqjrBGeiJUSTB4oBcr27loOv6Hj6t9ziLYhrVZT
         7in84hwrhzpQnL+zUrfNJGjZbUa/8Y+EasdCtz44vj/GNuODguuqAZvS6fN9HIznsKfZ
         7Gn3sHWA4Cr5lpA5mj7/+iPGctGTXX73blCwEeR6toegihe9DxxFOWe/9HSJTfQFyO4C
         /7PA==
X-Forwarded-Encrypted: i=1; AHgh+Rquju/9Jsj/4k9CwAU+DiXc1OuPbIth5KW0StyN2xWH6605sI0SxSJ49W991bYPd4riW9YM5e8=@vger.kernel.org
X-Gm-Message-State: AFuF++ky3vuL+e5MISgnfMemcGgkWgKELLRQnlkTCheEsHjfC+eUzyQp
	2Zqlf7I6cJqPz1l6OZhemL9pQmSoACS5UXSvTMR/h5iJFSV+cXYBJEz3
X-Gm-Gg: AR+sD11R4AcPslq9DIHPjDP+zZgWuBMSQ6IYI9Y1PVfwUss31dzJJkEJt4Qq7Q0H+iv
	KgDscDukoUhvSv38Uc7OxR6sfMCDKsEAI/e7DRqZ9MHYT+z1efAj8RcCLOGMbWp0jYn2mGo6Lu9
	u692r2w57fekquRtmiy4kRZHlwFZnPrRqMNrRnDF5TEo8aGC9s+gqd9XQC3EDSR588JdcfnG32O
	XMk/gEk3PcAyEDme6CRUlPEPqLRGBLyVocBlrCArv+70D6xAQ8FnJkQlEWS63Zr1M/bARWSHqC3
	A3cDOuQCIVODqAxiNeTeOuBMbV2Aww+gygDYFHurF5BpmL6haGYYlMPsm/90vYncAy1mS3aOOlJ
	SQkmJKY41lMhwBBU4MKnmkgevDSGHJ4D0JgSbIJ+zAxHzxsUpcA2Vov0z8y71IYdVCyDJDMXi9D
	7wfO2BjPcKGPAqGmhf7Jj2UsOaF+xmIu67uowpWTO1cnzc7Kep+gn5BsUGX0y5QluvPdOD
X-Received: by 2002:a05:600c:8b63:b0:49c:ced9:ab7f with SMTP id 5b1f17b1804b1-49cd53c438bmr128613105e9.8.1788180631771;
        Mon, 31 Aug 2026 05:50:31 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd775dae8sm127044535e9.9.2026.08.31.05.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 05:50:31 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:01:12 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	kpsingh@kernel.org, matt@bobrowski.net, john.fastabend@gmail.com,
	brauner@kernel.org, paul@paul-moore.com,
	torvalds@linux-foundation.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, martin.lau@kernel.org, yonghong.song@linux.dev,
	mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 6/7] selftests/bpf: Add tests for the generic
 netlink BPF hook
Message-ID: <apV7GDEUQV0B3beD@mail.gmail.com>
References: <20260831110934.241898-7-a.s.protopopov@gmail.com>
 <8872f8c265628c401291f2921919eb96e1169eef2a4e5d0b1d8dfb5e80bced6a@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8872f8c265628c401291f2921919eb96e1169eef2a4e5d0b1d8dfb5e80bced6a@mail.kernel.org>

On 26/08/31 12:07PM, bot+bpf-ci@kernel.org wrote:
> > Add a few tests for the new generic netlink BPF hook.
> > Policies only apply themselves to the "nlctrl" family.
> > The following tests are being added:
> >   * doit: allow or deny CTRL_CMD_GETFAMILY
> >   * dump: allow or deny CTRL_CMD_GETPOLICY, nlmsg_flags |= NLM_F_DUMP
> >   * nlmsg_flags: allow or deny a command based on nlmsg_flags
> >   * other_family: check that other families still pass
> 
> The enumeration lists four subtests but the patch registers five. The
> "netns" subtest is missing from this list:
> 
>     if (test__start_subtest("doit"))          test_doit(skel, fd);
>     if (test__start_subtest("dump"))          test_dump(skel, fd);
>     if (test__start_subtest("nlmsg_flags"))   test_nlmsg_flags(skel, fd);
>     if (test__start_subtest("other_family"))  test_other_family(skel, fd, other_id);
>     if (test__start_subtest("netns"))         test_netns(skel, fd);
> 
> The netns subtest is the only one exercising the net argument of
> bpf_lsm_genl_family_rcv_msg(), and it introduces target_netns_inum plus
> a filter in the BPF program, netns_new()/open_netns(), a second socket,
> and the netns_inum() helper - roughly 45 of the 242 added lines. Since
> the netns filtering path is the least obvious part of the hook contract,
> would it make sense to add a fifth bullet, for example "* netns: deny a
> command only inside a target netns, allow it elsewhere"?

Sure, thanks, will add. It was added later than first four.

> > diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> > index 08c6e8a4e..6ca0b083a 100644
> > --- a/tools/testing/selftests/bpf/config
> > +++ b/tools/testing/selftests/bpf/config
> > @@ -30,6 +30,7 @@ CONFIG_DYNAMIC_FTRACE=y
> >  CONFIG_FPROBE=y
> >  CONFIG_FUNCTION_TRACER=y
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/genl_lsm.c b/tools/testing/selftests/bpf/prog_tests/genl_lsm.c
> > new file mode 100644
> > index 000000000..9f866c4c6
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/genl_lsm.c
> 
> [ ... ]
> 
> > +static void test_nlmsg_flags(struct genl_lsm *skel, int fd)
> > +{
> > +	int err;
> > +
> > +	/* ensure denying works */
> > +	skel->bss->target_cmd = CTRL_CMD_GETFAMILY;
> > +	skel->bss->target_flags = NLM_F_REQUEST | NLM_F_DUMP;
> > +	skel->bss->allow = false;
> > +
> > +	err = nlctrl_request(fd, CTRL_CMD_GETFAMILY, false);
> > +	ASSERT_OK(err, "doit_flags_not_matched");
> > +
> > +	err = nlctrl_request(fd, CTRL_CMD_GETFAMILY, true);
> > +	ASSERT_EQ(err, -TEST_ERRNO, "deny_dump_flags");
> > +
> > +	/* now, the other way around */
> > +	skel->bss->target_flags = NLM_F_REQUEST;
> > +
> > +	err = nlctrl_request(fd, CTRL_CMD_GETFAMILY, true);
> > +	ASSERT_OK(err, "doit_flags_not_matched");
> > +
> > +	err = nlctrl_request(fd, CTRL_CMD_GETFAMILY, false);
> > +	ASSERT_EQ(err, -TEST_ERRNO, "deny_dump_flags");
> > +}
> 
> The second half reuses the assertion tags from the first half, but they
> name the opposite case. The dump request gets "doit_flags_not_matched"
> and the doit request gets "deny_dump_flags". The test logic is correct
> but when test_progs prints only the tag and __func__, a CI failure
> reporting "genl_lsm:FAIL:deny_dump_flags" cannot be attributed to either
> of the two assertions with that name, and whichever one it is, the tag
> names the wrong netlink operation. Would four distinct tags - for example
> "deny_dump_flags_matched", "allow_doit_flags_unmatched",
> "allow_dump_flags_unmatched", "deny_doit_flags_matched" - remove the
> ambiguity?

Yes, thanks.

> [ ... ]
> 
> > +void test_genl_lsm(void)
> > +{
> > +	struct genl_lsm *skel = NULL;
> > +	int fd = -1;
> > +	int err, other_id;
> > +
> > +	skel = genl_lsm__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "genl_lsm__open_and_load"))
> > +		return;
> > +
> > +	fd = genl_open(0);
> > +	if (!ASSERT_OK_FD(fd, "genl_open"))
> > +		goto cleanup;
> > +
> > +	/* do this before attaching our hook, just in case */
> > +	other_id = genl_resolve_family(fd, OTHER_FAMILY_NAME);
> > +	if (other_id == -ENOENT) {
> > +		test__skip();
> > +		goto cleanup;
> > +	}
> 
> A subsystem pattern flags this as potentially concerning: when
> CONFIG_ETHTOOL_NETLINK is absent, genl_resolve_family() returns -ENOENT
> and the test skips with no printed reason. A reader of the TAP output
> sees "#N genl_lsm:SKIP" with nothing indicating the missing prerequisite
> was the ethtool genl family, so a silently-skipped test looks identical
> to a deliberately-disabled one. All five subtests are skipped this way,
> including the four (doit, dump, nlmsg_flags, netns) that do not need
> ethtool - only test_other_family() consumes other_id.
> 
> This pattern is common in bpf selftests (e.g. aggregate_ret.c:52,
> arena_spin_lock.c:57 and :66 all do exactly this), and the config hunk
> in this same patch adds CONFIG_ETHTOOL_NETLINK so the skip path should
> not be taken in a properly configured CI run. Would a one-line printf
> plus optionally deferring the ethtool resolution into test_other_family()
> so the other four subtests still run be worth addressing?

In fact, this is probably better to omit this check.
I've tried to do the same for CONFIG_SECURITY=n, but then figured out
that selftests won't even build for this case (not due to this patch).
So given I add ETHOOL, it's ok to expect that it is on.

> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/progs/genl_lsm.c b/tools/testing/selftests/bpf/progs/genl_lsm.c
> > new file mode 100644
> > index 000000000..c4d8b4d23
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/genl_lsm.c
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33386073074

