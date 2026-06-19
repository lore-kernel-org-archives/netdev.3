Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD18631E842
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781856206; cv=none; b=Egzp1kn6GzrGwOb6jdkZFso/sDWNdvE1vQqT2z9Mzsd41Scg9x0DReiCnd/Wei21zTDnHsucqisDXFDQQM5pbgz6JfBoyyF/rTKfFRRrpjoOuPCdKcZinezHiDbiYQzgoCOEsSRDz73YRxZXg5UEsfbBKMLgkvbtsFQV5xIN5Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781856206; c=relaxed/simple;
	bh=zB4TCxIDgStDFP1rlZaKRZHke2hrvj4RkhmGkk6WUC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sM0Bu/KODmu7z8KxwUmLwyXcJwT/pYXHGSvLhvC2jNDTu6oogKNSmnjZjjT8bEj1gjjCQcXxnq4snHN2Ns0KeAcvz8X5cm20mBaRbuKwoPDUaWaGniV14RO6psOn8hsXseZofqGQqOMGGrcCesSMAR6AtIeL3grzTIVX5BBTvY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n6+KcSfr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6+KcSfr"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-492329c5514so7396795e9.1
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 01:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781856203; x=1782461003; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kpJwL24GNas0k68J2nJFxWElqOxVpyI/1xu9RZENp00=;
        b=n6+KcSfraEgMTfhU1nMSD52t73wf191Fox8ivGsan2CAFJJyh9JoolTMEusK23HO/I
         lbT3xxPqErAZoARh39+fW6BZe5FK1LWAxy8jNJWCsB80dx1nxtIYTNeuiTdShj3NnYDz
         ms1z8rIPfzZBT3hQfMw94hwfCYuxFTwCh7AbnL0vvRrASxxxq4NccP4YcSweBZklSdxy
         muVGQVLMBHQhHfpumWoqVeTl/v+dkMbUxlPT7leVOKdzDTjDfzlZdQyBeJOQaKxfj35y
         9g+9ykIn1c68jILcHdzqXtcre7ZuVoSf2CvkDI9L3ILlwpp8Xnc3Xgz1Y0b/xuxA9lVX
         NKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781856203; x=1782461003;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpJwL24GNas0k68J2nJFxWElqOxVpyI/1xu9RZENp00=;
        b=aa0y83S3koSMCBAyMFt+vm2RyehZLoNqPESzhl1tGCSvdMJDbY5hCIgrVFedrLkHQz
         7a26jZMf37NnDH3ykZ1pHRvzoUxYRQsHgovw3DHtonXkniQGu+hxpBGRw1nKjCclr+BN
         X2sbIgSmWfUG3M4K2CFpkcgPfgiqEhBHKfJsNa8Yrs+/JAam8hxM9e6m6Gj0U4xFO6yI
         g7Q45cAWTD17DJxA7rnnqa//qxH0cW2sx8p81MR0Tff6Pp8w/5Hb+970N5r+zwbwd3Zw
         gO+ooMuxahcCZC0jp/4mtQTKJZC9tZVThOglr+ghNSu4ws/AZKS6qtCa9H7yYJjaILzW
         ntjw==
X-Forwarded-Encrypted: i=1; AFNElJ/4NJQvgujezRIUeNrlSiaE7dH0tUNaQrKlSEL5yQqucN20QIp+ChS/c8A+pX7PIhvfFXH3UsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR+lMqj4SltkjJz3h64ggbUFp1zHI3xtP/T6JI8XZSPWomcpMg
	s0/EAB9fTUp1RxGE1tkdspEYbLW4trTRW+jqE+ve1rAzbbOBmYA2nSHS
X-Gm-Gg: AfdE7clk29p3+PKepwhgLWJYwrix75LJsKV5Vfyi8gzkMXdYSkz1XophBbWCcfmQAeg
	KW54inOigylunbDcfuBzBfRdeIrJ5imYuezgrXHLlYe7EgR+sAhsqqwn6q1/jAZNX5aEpLywzNo
	3F6BSk+hZFkJMOsaIicxAHZp0YNIFmmAcqYOv3uTEt4oXFqeugQvX985AR1SATafgo8ODBsUM2v
	HOmly5ndiTmnD9JMKaYc/m5OejAmtXGe0rI3JybtxKuQPxf/eYJWfjmnrcF41vvVfaXQHUdj9wK
	181mOLLEdQkuQD2RgQqfTfyFJwYDkyLE2L2rjWHutFcazu641xJQ1Def1GUUbkHGc/f+ORvSGpV
	/w7La6L8umiQkJNCzyvV/D2o+Jn2UREs7kypjZSxLAUu/aOXcSDwTV17s22BveTfx9rMG3R5DSt
	Fv/Xsw/OHWcTXLWND5Zqo7UFTvJVvbTqmLtEhKXM2XOva/gRiYlTZnqxlhuPyIg2ZZlaSES1Z6K
	a3LybhOrfmY0yAUkGYDKXvJtqrpcDPrroyRD5SGU59pQpp7SGzTftfgDZhZio/8Yn+nTMYPLVtB
	3DDcXs+BmJ0JzACJmNOu0nubHw6O95X8
X-Received: by 2002:a05:600c:4583:b0:490:3cf0:8d81 with SMTP id 5b1f17b1804b1-49240a44b63mr31293065e9.13.1781856202842;
        Fri, 19 Jun 2026 01:03:22 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e002f165db642aa45e9.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:2f16:5db6:42aa:45e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1fe8esm55234915e9.13.2026.06.19.01.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 01:03:21 -0700 (PDT)
Date: Fri, 19 Jun 2026 10:03:19 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: sun jian <sun.jian.kdev@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	toke@redhat.com, lorenzo@kernel.org, martin.lau@kernel.org,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Cover partial copy of
 non-linear test_run output
Message-ID: <ajT3x2H0swzg4yhm@mail.gmail.com>
References: <20260617093557.63880-3-sun.jian.kdev@gmail.com>
 <2dad9b5c184fa101d7cffa1d8f5eea5b5df60f53533d98c68175c9e3ec5ee6ac@mail.kernel.org>
 <CABFUUZFeh18OjQ6EhjD17ZwQKb1aiVNkYKv-hAkVGrHhPpjE4Q@mail.gmail.com>
 <ajOv_oOd1zInaW1b@mail.gmail.com>
 <CABFUUZHCr=4kb7kSaaPGpc4nkyn32i-svD9v7ONF+TYrrQ-xaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABFUUZHCr=4kb7kSaaPGpc4nkyn32i-svD9v7ONF+TYrrQ-xaQ@mail.gmail.com>

On Thu, Jun 18, 2026 at 06:45:18PM +0800, sun jian wrote:
> On Thu, Jun 18, 2026 at 4:44 PM Paul Chaignon <paul.chaignon@gmail.com> wrote:
> >
> > On Wed, Jun 17, 2026 at 10:19:52PM +0800, sun jian wrote:
> > > On Wed, Jun 17, 2026 at 6:31 PM <bot+bpf-ci@kernel.org> wrote:

[...]

> > > I tried reusing pkt_v4 and the existing TC program, but they do not fit
> > > the skb case this test is trying to cover.
> > >
> > > For skb test_run, IPv4/IPv6 inputs with a too-short L3 header in the
> > > linear area are rejected before bpf_test_finish(). With pkt_v4 and a
> > > linear area of ETH_HLEN, the test fails with -EINVAL before reaching the
> > > partial copy-out path. If the linear area is increased enough to pass the
> > > IPv4 check, pkt_v4 is too small to both trigger the old
> > > copy_size - frag_size path and verify that the copied prefix spans the
> > > linear data and the first fragment. pkt_v6 has the same issue: after
> > > making the IPv6 header linear, only 20 bytes remain in frags.
> > >
> > > The existing test_pkt_access program has its own packet-access coverage
> > > goals and is not just a pass-through carrier. With such a short linear
> > > area or small packet fixture, it can fail before the test hits the
> > > bpf_test_finish()'s partial copy-out path. A pass-through TC program is
> > > therefore a better fit, because it keeps the test focused on the
> > > bpf_test_finish() copy-out semantics.
> >
> > If we're keeping tc_pass_prog() then can't we use pkt_v4 and get rid of
> > init_pkt?
> >
> 
> pkt_v4 is too small to construct a meaningful nonlinear skb with a stable
> linear/frag split while still exercising the partial copy-out boundary in
> bpf_test_finish().
> 
> With pkt_v4, we either do not reach a fragmented layout, or lose control over
> the linear/frag boundary needed to exercise the regression path.

I think I'm missing something. Why can't we use pkt_v4 with
tc_pass_prog() and a linear area of ETH_HLEN? That would leave 42 bytes
of non-linear area, so a SHORT_OUT_LEN of 30 should work to trigger the
bug, no?

> 
> This test uses a 9000B packet so it does not depend on small-packet
> allocation details. Smaller packets might work depending on allocation
> state, but 9000B reliably gives us a non-linear skb with page frags and a
> stable linear/frag boundary for the copy-out regression.
> 
> init_pkt() is needed to ensure deterministic byte content across both linear
> and fragmented regions so that the memcmp-based validation is stable.
> 
> Thanks,
> Sun Jian
> 
> 
> > >
> > > For XDP, this object does not have an existing xdp.frags pass-through
> > > program, so the small XDP frags program is needed to cover the other
> > > caller of the shared bpf_test_finish() path.
> > >
> > > Thanks,
> > > Sun Jian
