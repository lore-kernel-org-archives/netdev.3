Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C52C2AE68
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 21:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584034; cv=none; b=j35unRXPTxZ7swNWVy5Xtb2Bs/y7F8iWwlImGXLdBurt2urLgyMz2CytMKQt3uuC2luadQ3XSb0GKJ35iSCjWcMEEPDlaFK7Kq8Him60R1kOhPjBYr0THQCS6LiEiwbDYLrk2dTiEIzMfW/4A27UTCDSkAtXRMEDqH3riqR15/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584034; c=relaxed/simple;
	bh=7gQY7AlbHewQtnIWDwf6xeKE5zm3O+CvGwbpF1ZE6m0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=NEEAsb7SNAg1k/DP9WsrZ0nuDNwfORJFlsPqMi2ygokSSxjIH09fHSiwmd1/cJZJ9TnuD/x3YRJmjEd8/Vww5c5hCBENQId0c761XMqgQTs07IvvTsPKM6E6knS103sUM4tDse2LoHSdpnNKKngdBQBuA3TA5Q8yu+YE7HJGOOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=VUYuMoJV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="VUYuMoJV"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8484f229529so4490814b3a.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 14:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784584031; x=1785188831; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SxhXZCE8F/8NLGo9T+1i7MwIlRVltbKl0w04IWFpO+Q=;
        b=VUYuMoJVcax288cUrIzGzE6cqIMGJyYkCaNuyVCVpUVJ74x5TgyfI+y1AXDIDvKuo1
         fT1hrbmp17tE/yAcT9Kd6mRTVqp5j8HwnJh5Y9eahW6bycElWxFmYXjnLgpg4i1BpCq3
         kG6e8pEyS0uSNveUSq0Ip3dTIAzb/5UHf7uaN/S8vEQXl2B9ztq/kcDA5BEJ16BakQwc
         J9UrfU/XCl26i0NLHnJBtpONs7G7uIe0yzFhR5E7FUhlCDY+hOWdGan6yIrCBLABd/6P
         sejUSKWjEhLqT0vhiW4JhOgIO74rw3ZVa16w0vBRlhtA0PC/Xw7SAAlCgpKTnGRj84m/
         ZXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784584031; x=1785188831;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SxhXZCE8F/8NLGo9T+1i7MwIlRVltbKl0w04IWFpO+Q=;
        b=eS11CYQylxep9Un6Ci8ev+Z8dWapC96RdmrfwaipkwJJEwnk7oaKC3SJBYQ9ulsHcS
         OjfODv/Vg7OSo36Q5Lt1Wo+QCbKikBzQ5Epv3uYcJzKKRllTzeZgRO3aC1d/OzmsoB7E
         fuRYuQ88toM38HL0FD4dEOUmozOM/pApzgnWztNbgYK8XnxrvXeqAl3WUT235dczbjcm
         jGValXAcH98u6AwNiiAW2J2bAs7udlpgeuzswiOs28A1hgvvPwdv7uwn4SfKHwThBoHG
         fV7FvjOKwFIIXfDdH0WgE6smxBwoJmyGvOOuz+uClGYa/18wkAgcpBzhjkp9JOn/zRTo
         AkuA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3CzcuWLRIAerPBAzrJs6MBwU8UvhpZJkXKYX15fPcWJjQcFle3EzXzxcFErPeM1yvhTHUUfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2mivdG7fOvVdtjZ4WOpaPC0Z5bDnQtb5fR8HbVjDGod84BFeL
	guvjSvZC8K9RPjQhcZ6vRGkD+oJKN2efjMN4jhOBxLaI7p4TJ7sF1Z9gxot+3YuRq0g=
X-Gm-Gg: AfdE7cmzEoUC1Fvnv3Up+zyVS03LpWnNyti1I5U0Oy1xgZrAIHRv8oY8HnSow8Vkiiz
	uB799J7c9ma0dj9hVTvOFhJ0Czvk3uRcvj6ZqehL/3oJPe3vsZYwLYFcLbJq2g7I8Yv9jfJ7aMz
	O10u2wYmY1Dx0XJUdnPP6Ic9DFKxaJGdFSeCJirww7DgK+XrzrIMnHMQDMPSMMIpcE6J/a+Vukz
	UEp/45xvrDigVk1MnU+5Wt16GqEeyFYRvybdnKYowVO4ZhN5lqXv+xsNF8o+bWny0NANwmtY4ak
	XGfcHsZWOLa9isj8LeYSuazocxiVuF1OeE01PmDGyW55r/YkRDF6ozB55u0L3BaeDbbdXyPct/i
	OKLFV8X6pIhFXtR9EmOx6wXdnNia90WrGtbXLZQpgnYen1JGIkubFyhSkqmxprdbWH5vgkxXKSs
	j3NJbfWNuih3XRTYgeHVWK9zsIPHwYWTw=
X-Received: by 2002:a05:6a00:4ace:b0:848:48e7:437b with SMTP id d2e1a72fcca58-84c294c5fe9mr14998819b3a.69.1784584030880;
        Mon, 20 Jul 2026 14:47:10 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adcaa0bsm6322022b3a.20.2026.07.20.14.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 14:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 17:47:09 -0400
Message-Id: <DK3Q8PFVGNAV.GZNZC89346A9@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Nnamdi Onyeyiri" <nnamdio@gmail.com>
Cc: <bpf@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <horms@kernel.org>, <jakub@cloudflare.com>, <jiayuan.chen@linux.dev>,
 <john.fastabend@gmail.com>, <kuba@kernel.org>, <kuniyu@google.com>,
 <ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <sashiko-reviews@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] selftests/bpf: add sockmap recvfrom EAGAIN
 selftest
X-Mailer: aerc 0.20.1
References: <20260720171535.67867-1-nnamdio@gmail.com>
 <20260720171535.67867-3-nnamdio@gmail.com>
In-Reply-To: <20260720171535.67867-3-nnamdio@gmail.com>

On Mon Jul 20, 2026 at 1:15 PM EDT, Nnamdi Onyeyiri wrote:
> These selftests exercise the tcp_bpf_recvmsg() and tcp_bpf_recvmsg_parser=
()
> functions, to ensure that they are properly handling spurious wakeups in
> tcp_msg_wait_data().
>
> The expected behaviour is that recvfrom() does not return an EAGAIN
> error.  If the spurious wakeups are incorrectly handled, this assertion
> will fail.
>
> Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>

The test looks fine, even if slightly flaky. Running with only patch 2/2
still passes sometimes on my box. Can we handle this somehow, e.g., do
more attempts?

There's also a couple magic numbers in the tests that may need some
explanation (noted below).

> ---
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 124 ++++++++++++++++++
>  1 file changed, 124 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index cb3229711f93..d18faf46fac0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -1373,6 +1373,126 @@ static void test_sockmap_multi_channels(int sotyp=
e)
>  	test_sockmap_pass_prog__destroy(skel);
>  }
> =20
> +static void *test_sockmap_recvfrom_eagain_thread(void *arg)
> +{
> +	int fd =3D *(int *)arg;
> +	char buf[1024];
> +	void *result =3D NULL;
> +
> +	while (true) {
> +		ssize_t len =3D recvfrom(fd, buf, sizeof(buf), 0, NULL, NULL);
> +
> +		if (len =3D=3D -1) {
> +			if (errno =3D=3D EINTR)
> +				continue;
> +			result =3D (void *)1;
> +			break;
> +		}
> +
> +		if (!len || buf[len - 1] =3D=3D 'e')
> +			break;
> +	}
> +
> +	send(fd, "test", 4, MSG_NOSIGNAL);
> +
> +	close(fd);
> +
> +	return result;
> +}
> +
> +static void test_sockmap_recvfrom_eagain(bool with_verdict)
> +{
> +	struct test_sockmap_pass_prog *skel =3D NULL;
> +	struct bpf_program *prog =3D NULL;
> +	size_t buflen =3D 1024 * 1024 * 25;

Here

> +	char *buf =3D NULL;
> +	int map, err;
> +
> +	skel =3D test_sockmap_pass_prog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	map =3D bpf_map__fd(skel->maps.sock_map_msg);
> +
> +	if (with_verdict) {
> +		prog =3D skel->progs.prog_skb_verdict;
> +		err =3D bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_SKB_STREAM_=
VERDICT, 0);
> +		if (!ASSERT_OK(err, "bpf_prog_attach verdict"))
> +			goto cleanup;
> +	}
> +
> +	buf =3D malloc(buflen);
> +	if (!ASSERT_OK_PTR(buf, "malloc buf"))
> +		goto cleanup;
> +	memset(buf, 0, buflen);
> +	buf[buflen - 1] =3D 'e';
> +
> +	for (int i =3D 0; i < 200; ++i) {

Also here. Why 200 iterations specifically? Can we at least name the
defaults to make it clearer that we've chosen those numbers because
that's how we trigger the bug?

> +		ssize_t sent;
> +		char ignored[128];
> +		pthread_t thread;
> +		bool thread_created =3D false;
> +		size_t rem =3D buflen;
> +		int c =3D -1, p =3D -1, zero =3D 0;
> +		bool success =3D false;
> +
> +		err =3D create_pair(AF_INET, SOCK_STREAM, &c, &p);
> +		if (!ASSERT_OK(err, "create_pair"))
> +			goto end_attempt;
> +
> +		err =3D pthread_create(&thread, NULL, &test_sockmap_recvfrom_eagain_th=
read, &p);
> +		if (!ASSERT_OK(err, "pthread_create"))
> +			goto end_attempt;
> +		thread_created =3D true;
> +
> +		err =3D bpf_map_update_elem(map, &zero, &c, BPF_ANY);
> +		if (!ASSERT_OK(err, "bpf_map_update_elem"))
> +			goto end_attempt;
> +
> +		while (rem) {
> +			sent =3D xsend(c, buf + (buflen - rem), rem, 0);
> +			if (sent =3D=3D -1)
> +				goto end_attempt;
> +			rem -=3D sent;
> +		}
> +
> +		/* we cannot use recv_timeout(), otherwise EAGAIN would be an expected=
 errno. */
> +		err =3D recvfrom(c, ignored, sizeof(ignored), 0, NULL, NULL);
> +
> +		/*
> +		 * we are checking for the invalid return of EAGAIN, any other return =
is considered
> +		 * successful for the purposes of this test.
> +		 */
> +		if (err < 0 && !ASSERT_NEQ(errno, EAGAIN, "recvfrom eagain"))
> +			goto end_attempt;
> +
> +		success =3D true;
> +
> +end_attempt:
> +		if (c >=3D 0)
> +			close(c);
> +
> +		if (thread_created) {
> +			void *retval =3D NULL;
> +
> +			pthread_join(thread, &retval);
> +			if (!ASSERT_NULL(retval, "retval"))
> +				success =3D false;
> +		}
> +
> +		if (!thread_created && p >=3D 0)
> +			close(p);
> +		if (!success)
> +			break;
> +	}
> +
> +cleanup:
> +	if (buf)
> +		free(buf);
> +
> +	test_sockmap_pass_prog__destroy(skel);
> +}
> +
>  void test_sockmap_basic(void)
>  {
>  	if (test__start_subtest("sockmap create_update_free"))
> @@ -1451,4 +1571,8 @@ void test_sockmap_basic(void)
>  		test_sockmap_multi_channels(SOCK_STREAM);
>  	if (test__start_subtest("sockmap udp multi channels"))
>  		test_sockmap_multi_channels(SOCK_DGRAM);
> +	if (test__start_subtest("sockmap recvfrom eagain"))
> +		test_sockmap_recvfrom_eagain(false);
> +	if (test__start_subtest("sockmap recvfrom eagain with verdict"))
> +		test_sockmap_recvfrom_eagain(true);
>  }

