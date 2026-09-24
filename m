Received: from mail-oa2-f39.google.com (mail-oa2-f39.google.com [74.125.231.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08232EC0B0
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209470; cv=none; b=oLRTBNMCZHlrclDNlicIRGaoZcqjMMnKrWy9wWpiz7B7kLBswgfzsLrZcSA7TcsrJf0RL7FbetWLA9lmMldqHL1X3o+zhkhHiC7nqCkxGKPvnq2lYZSfgfUWgsB7bvc/xtJ9yrNvUqYQdSWeERPp2Dg/BBx4eKzWR9nA9NenXBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209470; c=relaxed/simple;
	bh=O1qzz4udeaHiCBtWLNhPqgQhh0np6y2v1Qblzap4ubo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8oxIrgQ9C8yMEzWQnXnAH7LO5HszFf9B9UD17dxmyAxQDY6Zh12c7Bc8zPpRTmQ8vOiIrsBvdq0dVyAtJk9mlH1H+j3lzEmmYNK/4eb5cYUCKYRC7uK2KsWdmeSMOM61k7qRZWJB4su1KbNcZotsGsSdvXe5qwA+T9vSXeXapg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tLKAduNk; arc=none smtp.client-ip=74.125.231.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLKAduNk"
Received: by mail-oa2-f39.google.com with SMTP id 586e51a60fabf-47b5043f191so897947fac.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 17:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790209467; x=1790814267; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VaNhGxWDXoFu7JrvArFM0xuuSaYLknf+AiNAGeHpOlc=;
        b=tLKAduNk74m4FZjjhHyzJ7fyOjIvZHucIau8VQ5rD/nN4RbPwE2KwfNNPDW9tAwSF8
         DFyZUHBaAS3+7eJL6drUNF+dTQAKK32oP3dSuSFObyw9kyP8ETaDSPr2Qn9rjc9LNN7I
         k09EwSLr72mZSIqxmv3/OI4v5K0k7hDz7aNhxwUf6lKAspHuzzuYkoW9M1FFKOYsN/Ih
         BIk3pf2N/phxsZlKSXQrvj4scX7TZRrfaE5lbSvf9mH/DeKwh0Z/IKG/hz8c4IzdbE9Q
         bCUbvaODcmTGNAiAOdOrXtD5IIbaNtv9u/WlOn5X7q+Ngs17BSusJ2QLjhHOFEPerAW3
         qi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790209467; x=1790814267;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VaNhGxWDXoFu7JrvArFM0xuuSaYLknf+AiNAGeHpOlc=;
        b=2PMsiyutb5fT6DoyYe2JpUhNRwxgZpRXoGV/o+K8giv2jkna3Q7RWICtASTpjCE7ya
         9iCIJl02/Mmi1izq/uJHcuQ3MM0gsMnqkAADOhdIdtOJd3E8WJwzwZ9ZNG/GGgM8lO5H
         jfQJGdA1CN8V4yr5FJ2RK3BcM9go3ROpLh8OjkC2/nRVzgN9HHVU2Pibz7JgmmABC22J
         LW+6kBjXXheZvSze7yqb94sNrkUtjoKkkmeyzfbedySKvnDt7wu891llJAoIQQMvcteF
         FFVLM+l085PEHOmr28KY1gmxIJd6xgGmoyo+RBPyczPbXP1mF+yKR89kF70ttLDX4rjp
         PzrQ==
X-Forwarded-Encrypted: i=1; AKwUvByvtORGwWRXTkrQ1vMwLFvpbuGZ/Nf7daqg8mb3YEe7xE6rxud4LMIsckd1KGjn0BQKz/h+YKs=@vger.kernel.org
X-Gm-Message-State: AFuF++kcLzhK4At9YQRemjVWDsCH2tk30j8DtCGs8xSFu9dQYwW3sQyd
	ODee3dMu7+H8j8L+ajuR3akih6pPMio41eo9OoQhttAgP2Xosww16LcG
X-Gm-Gg: AYBFou3lu/84gE1uucoKPgiVVnSVJzf3dmCRddvVWkUXr3eJ9n8uj77r/CN7LIzUfQz
	4JEDWGPEdqlXf370MkNstnQMy9Bj2RIGJsJ+Fdpj3HIf7YQvMIMdQLP8Sbs/yYZF/nrvDI4Awod
	YbAQngWibkucOKV1mueW76/LouDXDi6UmsfZrCeryrpREEMiaR6tdOayXHX7lGPTlxkhSXA4wzS
	abUfBSjlndSBjw0nUCEVDeRmoDIqiiMJB9UoNAxytVyAQVuH4LSLYF6+5ZOR/mNh47yeK4RmDZl
	RH3GRPtMd1hw6a87qBuylLdE/hovr843Hf8s8LhYFILCbWiXlrKDWQ0HF4sOCAuv9TdpPpMHxfd
	UDCjfPh4nhTWKBurgzBjOjnyL6mxWkukhCeEe4dzioeisKCYfbf9JG/1jPreSOJzL8v70j5bAJl
	ctLLpyszrQYZBxM8b6vANxZ2OBNEETraWy24cnLc09GfEraw6qEvqFfNPOSmjL5luCl3o+OvtEA
	fM+dPNlzbypPSnn85w=
X-Received: by 2002:a05:6808:1994:b0:4d6:9355:7543 with SMTP id 5614622812f47-4d731545ff8mr956682b6e.62.1790209466617;
        Wed, 23 Sep 2026 17:24:26 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:f::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d5c1b305b8sm3689133b6e.1.2026.09.23.17.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 17:24:25 -0700 (PDT)
Date: Wed, 23 Sep 2026 17:24:21 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, skhan@linuxfoundation.org, stefanha@redhat.com,
	mst@redhat.com, jasowangio@gmail.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shuah@kernel.org, rdunlap@infradead.org,
	donald.hunter@gmail.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com,
	sdf.kernel@gmail.com, bobbyeshleman@meta.com
Subject: Re: [PATCH net-next v2 6/6] selftests/vsock: test the netns assign
 privilege checks
Message-ID: <arRttf9k4yKahe4R@devvm29614.prn0.facebook.com>
References: <20260921-vsock-guest-ns-v2-6-693bd78fde9e@meta.com>
 <179019126776.2160803.16648507383433583043@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179019126776.2160803.16648507383433583043@kernel.org>

On Wed, Sep 23, 2026 at 07:21:07PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] Both new selftests
>   (`test_ns_guest_assign_g2h_netns_no_cap_net_admin_fails`,…
> - [Low] The two new shared-VM tests omit the `vm_reset_g2h()` cleanup
>   that every other ns_guest_assign_g2h_netns_* test in USE_SHARED_VM…
> 
> --
> 
> selftests/vsock: test the netns assign privilege checks
> 
> Adds two vmtest.sh cases that attempt VSOCK_CMD_DEV_NETNS_SET without
> CAP_NET_ADMIN and from an unprivileged user namespace, and enables
> CONFIG_USER_NS in the vsock selftest config.
> 
> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > index e94cc2fd90ccd..4f42bcdac3f6c 100755
> > --- a/tools/testing/selftests/vsock/vmtest.sh
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> 
> [ ... ]
> 
> > @@ -187,6 +195,8 @@ readonly TEST_DESCS=(
> >  	ns_guest_assign_g2h_netns_host_connect_ok
> >  	ns_guest_assign_g2h_netns_reset_on_ns_delete_ok
> >  	ns_guest_assign_g2h_netns_old_conn_send_fails
> > +	ns_guest_assign_g2h_netns_no_cap_net_admin_fails
> > +	ns_guest_assign_g2h_netns_unpriv_user_ns_fails
> >  )
> >  readonly NS_MODES=("local" "global")
> 
> [Severity: Low]
> Both new tests are added to USE_SHARED_VM but neither calls
> vm_reset_g2h() on any exit path, unlike every other
> ns_guest_assign_g2h_netns_* test in that list.
> 
> Should these follow the sibling pattern?  If the privilege check under
> test is broken, the assign succeeds and the guest's single g2h device is
> left owned by the transient namespace created by unshare, while the
> harness moves on to the next test in the same VM.
> 
> The kernel does restore this by itself once that namespace is reaped:
> 
> net/vmw_vsock/af_vsock.c:vsock_g2h_net_reset() {
> 	if (likely(rcu_access_pointer(vsock_g2h_net) != net))
> 		return;
> 
> 	mutex_lock(&vsock_register_mutex);
> 	if (rcu_access_pointer(vsock_g2h_net) == net)
> 		rcu_assign_pointer(vsock_g2h_net, &init_net);
> 	...
> }
> 
> registered as .pre_exit in vsock_pernet_ops, and the next test's
> vm_ns_assign_g2h() overwrites the pointer anyway.  The residual window is
> the asynchronous teardown that ..._reset_on_ns_delete_ok already documents
> ("the namespace itself is dismantled from a workqueue, so the device does
> not come back the same instant").  Since the new tests are appended last
> in TEST_NAMES and USE_SHARED_VM, a default run is unaffected; this only
> shows up with selective or reordered invocation.

Yes, these tests should call it regardless. Relying on cleanup makes the
pass/fail race-y.

> 
> [ ... ]
> 
> > @@ -1832,6 +1842,48 @@ test_ns_guest_assign_g2h_netns_reset_on_ns_delete_ok() {
> >  	return "${KSFT_PASS}"
> >  }
> >  
> > +test_ns_guest_assign_g2h_netns_no_cap_net_admin_fails() {
> > +	local cmd="unshare -n setpriv --bounding-set=-net_admin"
> > +	local rc
> > +
> > +	vm_ssh "init_ns" -- "${cmd}" python3 /root/ynl/cli.py --no-schema \
> > +		--spec /root/ynl/vsock.yaml --do dev-netns-set &>/dev/null
> > +	rc=$?
> > +
> > +	if [[ "${rc}" -eq 0 ]]; then
> > +		log_host "assign unexpectedly succeeded without CAP_NET_ADMIN"
> > +		return "${KSFT_FAIL}"
> > +	fi
> > +
> > +	return "${KSFT_PASS}"
> > +}
> 
> [Severity: Medium]
> Can this test pass without the capability check ever being reached?  The
> only assertion is rc -eq 0 => FAIL, output is discarded with &>/dev/null,
> and there is no positive control, so any nonzero status reads as
> KSFT_PASS.
> 
> A few concrete sources of a nonzero status that are not -EPERM:
> 
> net/vmw_vsock/af_vsock.c:vsock_nl_dev_netns_set_doit() {
> 	int err = vsock_g2h_net_assign(genl_info_net(info));
> 
> 	if (err == -ENODEV)
> 		NL_SET_ERR_MSG(info->extack,
> 			       "no guest-to-host transport is loaded");
> 	else if (err == -EOPNOTSUPP)
> 	...
> }
> 
> and cli.py collapses all of those to the same status as -EPERM:
> 
> tools/net/ynl/pyynl/cli.py:main() {
>     except NlError as e:
>         print(e)
>         sys.exit(1)
> }
> 
> vm_ssh() also returns ssh's own status, so a transport failure (255) or a
> remote shell failure (127, e.g. an installed util-linux that does not
> accept setpriv --bounding-set=-net_admin) is indistinguishable from the
> expected refusal.  A python-side failure such as a missing
> /root/ynl/vsock.yaml exits 1 too.
> 
> Would it be worth asserting the privileged case succeeds first?  The file
> already has the helper the sibling tests use as a precondition:
> 
> vm_ns_assign_g2h() {
> 	local ns=$1
> 	local nspid=$2
> 
> 	vm_ns_exec "${ns}" "${nspid}" "python3 /root/ynl/cli.py --no-schema \
> 		--spec /root/ynl/vsock.yaml --do dev-netns-set"
> }
> 
> On the changelog note "ynl's cli.py does not report the errno": is that
> accurate?  NlError.__str__() in tools/net/ynl/pyynl/lib/ynl.py does:
> 
>         msg += os.strerror(self.error)
> 
> so the error string is printed and the test could match "Operation not
> permitted" instead of sending everything to /dev/null.

I considered this but felt like grepping stderr/stdout is somewhat
unnatural. My plan was to later propose that cli.py returns the err via
exit code, and then update these tests.

First checking the privileged assign sounds like a reasonable middle
ground to rule out the other error states.

> 
> > +
> > +test_ns_guest_assign_g2h_netns_unpriv_user_ns_fails() {
> > +	local unpriv_uid=65534
> > +	local unpriv
> > +	local rc
> > +
> > +	unpriv="setpriv --reuid=${unpriv_uid} --regid=${unpriv_uid}"
> > +	unpriv="${unpriv} --clear-groups"
> > +
> > +	if ! vm_ssh "init_ns" -- "${unpriv} unshare -U true"; then
> > +		log_host "unprivileged user namespaces unavailable, skipping"
> > +		return "${KSFT_SKIP}"
> > +	fi
> > +
> > +	vm_ssh "init_ns" -- "${unpriv} unshare -Urn" \
> > +		python3 /root/ynl/cli.py --no-schema \
> > +		--spec /root/ynl/vsock.yaml --do dev-netns-set &>/dev/null
> > +	rc=$?
> > +
> > +	if [[ "${rc}" -eq 0 ]]; then
> > +		log_host "assign unexpectedly succeeded for unprivileged user"
> > +		return "${KSFT_FAIL}"
> > +	fi
> > +
> > +	return "${KSFT_PASS}"
> > +}
> 
> [Severity: Medium]
> Same rc != 0 => KSFT_PASS inference here, plus the availability probe is
> not the command being measured:
> 
> 	probe:    ${unpriv} unshare -U true
> 	measured: ${unpriv} unshare -Urn python3 /root/ynl/cli.py ...
> 
> If the extra -r/-n setup or the python startup under uid 65534 fails, the
> result is KSFT_PASS rather than KSFT_SKIP or KSFT_FAIL, and the child user
> namespace never actually holds CAP_NET_ADMIN, which is the condition the
> commit message says is being tested:
> 
>     the other confirms that CAP_NET_ADMIN in an unprivileged user ns
>     alone is insufficient.
> 
> Would checking the reported error string, or asserting the privileged
> assign works in the same test, make these two cases fail if
> GENL_ADMIN_PERM is ever dropped from VSOCK_CMD_DEV_NETNS_SET?

Yep, can follow the same approach as above.
