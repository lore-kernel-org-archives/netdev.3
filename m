Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C14C57D239
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970626; cv=none; b=BIWb72MLZ5N1graiXhWKlbwc1W3eSx4pvAYPwFT1rO5dplYL7EIOE2jpUYYROqIunIB+nI8mna5HPkaAzoaJWlhKoEpUzn56q/n3mv5XjTgYoIfyJEvtVZSOpZcqMp9x9iQ3MpD7idnPStzmyiSiywLlCxkE96ppPT80wobEI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970626; c=relaxed/simple;
	bh=eFHDOCUvG6RJkKxnP7GoyTwndFgmCvaMrkqn3U9uemE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUvExnj3da4QTaCnv09LoCy8BmrfUJxcV3GiOIKZLrdB/vuIpKIxC/vuypD/RNWyPBDKoKK1NIIiHErz0zLWFPhvkloIuAzTTO89AQnIqnwNHxrX/VvlBQGinqrOp/n0/9qcUgA+G3p4aaaFN25OibKe/BcJWUeT72HFuC8DDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1whdm1Z; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1whdm1Z"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4b333de9451so5276224b6e.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 09:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788970623; x=1789575423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fshKvEEVhGFc5VFLl5TyLUM9DH0VS/1zTeCkHq9ANIQ=;
        b=K1whdm1ZS+gonRbBoAHFC94DNJfuOZqjjRn9l5S9ut3rEPZWEHf8apT56NeHM6X7sn
         HFAwomhnpw/VOedeIYsIQ3VYzYv8EYdT86Xrt8HOMH/7BLAEgHUN6WTFLoRn1Frl6+fi
         aZb+h7/qu7glTMZ3SVu7j2Eeh60kck1ezT0mtmwIx6IArkegZT/rW3/IcMLHpZsm7oOJ
         dQXCU+Gn84Aq00YwUlgNFrQ452ih1Yn88z7DG2UjwF6laHUFOWhRRzeNXNf1uuN2vhat
         RjABQJitvE7lwcdSOujeJshyA5AQhHNRKrDnVpEBjVvAkmMXd8+gLpsdDZJDi3KqDIHl
         SBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788970623; x=1789575423;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fshKvEEVhGFc5VFLl5TyLUM9DH0VS/1zTeCkHq9ANIQ=;
        b=sbF8hjmEP3GZBn5+6TEy1EpMp2FnkzO7+mZQZnEQpdu4gTFSjXpji5/L0jlo5WoSmC
         PDby/JR1UrfqlR1ow0y+vGcolZBzQiI9XNmsgJb4d2D6KGJbSoHIeESX0y82r2eqgYqa
         MY1IKuDkHV0Vnc1B0q6F4DSVoGak1a/SqP3TrFpJXzoGU+8cfj3AkdV8jiz/7HsBhGAP
         IHFoz/GQeDFswszBhlAV0soBqK286Ta4EAXOwYMvoPbpHXNnuXvJvSlR4b5cysmSKjy+
         5zeH+Zp7ROS1173sEYmKytU76a5e/MRn/TylE8EOISOoWJXyCndCzwttfDrIgLCRFzga
         PUew==
X-Forwarded-Encrypted: i=1; AKwUvByHJohnY6FxKfah9un7Q25whilf4PjzNHZytvoRlvQan7CvYELRiQJpMAaIj51e2kM8VZ195AI=@vger.kernel.org
X-Gm-Message-State: AFuF++nBaFMpGzc4U0nj9ESqnVexQnhFwPXKXqRZ9cFHWAQeOOxQYpGP
	VrtEY3+gzH30Y8Pz5tWhdCTQA8HHLjB3O2ptm+AcS/Nr6evjfSK1mZ5LX5B/fA==
X-Gm-Gg: AYBFou3ImFRe2Nc62sIcMzWwW88iZkBDSMamj7/CqfWImWm3c6L3EVJpszvSoO2x2l9
	8pamG4K3GP7R+4w5JNBrtsg9drXd2q+J/BR+uqLKEzdhBJFthuXWImUwWluMohq2WMuxe3kB7ef
	GgRjMpLWCNYYXUR8LgH0cB9rDTv5mUKkV6TZ00fJ5ibmMJxE120EGIJYJah3KDgyxWRWbdK/rh+
	TkBvPbMcId8VzytU531kIjT1zKJs9/7kOjCF3A4OgVTVNi1jWxHCf8yjsmXTKpwcDNUFaXNREDO
	MD2+3fflNL9tdLUVldHlSp5KaMjfrQ2p86yYPlBx79+4kIXy7fG7jrxodRMbiRrGU6aTMzs3Hgq
	9NXjs4hISApmcbvFDgRePo1POd+OhLaNRXV5/WP6DLRF1jY8F/q3SMo587aXaDcJ/K2+/uvVfV2
	h5cZkdRq8P7UVftf+aqLvCIvVMHhk8oxbosV4XRLruRSvvNrb3U32rjFSlC/RxYzplUr2PbrbKk
	72ddrerfzZ82ojOdnF3
X-Received: by 2002:a05:6808:bc4:b0:4a4:adaf:5570 with SMTP id 5614622812f47-4b95fb4f59bmr23974245b6e.4.1788970622954;
        Wed, 09 Sep 2026 09:17:02 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971240f68sm16753189b6e.8.2026.09.09.09.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 09:17:01 -0700 (PDT)
Date: Wed, 9 Sep 2026 09:16:58 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: juanlu@fastmail.com, dw@davidwei.uk, netdev@vger.kernel.org,
	io-uring@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, kuba@kernel.org,
	asml.silence@gmail.com, pabeni@redhat.com, shuah@kernel.org
Subject: Re: [net-next,v6,5/6] selftests: net: add multithread server support
 to iou-zcrx
Message-ID: <aqGGevrEG5+iZosZ@devvm29614.prn0.facebook.com>
References: <20260831-iou-zcrx-v6-5-02d1d012f0fd@fastmail.com>
 <178839229706.3394541.1555608492152892136@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178839229706.3394541.1555608492152892136@kernel.org>

On Wed, Sep 02, 2026 at 11:38:17PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider:
> 

[...]

> > @@ -356,29 +444,68 @@ static void run_server(void)
> >  	if (ret < 0)
> >  		error(1, 0, "bind()");
> >  
> > -	flags |= IORING_SETUP_COOP_TASKRUN;
> > -	flags |= IORING_SETUP_SINGLE_ISSUER;
> > -	flags |= IORING_SETUP_DEFER_TASKRUN;
> > -	flags |= IORING_SETUP_SUBMIT_ALL;
> > -	flags |= IORING_SETUP_CQE32;
> > +	pthread_barrier_init(&setup_done, NULL, cfg_num_threads + 1);
> > +	pthread_barrier_init(&dispatch_done, NULL, cfg_num_threads + 1);
> > +
> > +	for (i = 0; i < cfg_num_threads; i++) {
> > +		ctxs[i].queue_id = cfg_queue_id + i;
> > +		ctxs[i].setup_done = &setup_done;
> > +		ctxs[i].dispatch_done = &dispatch_done;
> > +	}
> >  
> > -	io_uring_queue_init(512, &ctx.ring, flags);
> > +	for (i = 0; i < cfg_num_threads; i++) {
> > +		ret = pthread_create(&threads[i], NULL,
> > +				     server_worker, &ctxs[i]);
> > +		if (ret)
> > +			error(1, ret, "pthread_create()");
> > +	}
> >  
> > -	setup_zcrx(&ctx);
> >  	if (cfg_dry_run)
> > -		return;
> > +		goto join;
> >  
> >  	if (listen(fd, 1024) < 0)
> >  		error(1, 0, "listen()");
> >  
> > -	add_accept(&ctx, fd);
> > +	pthread_barrier_wait(&setup_done);
> 
> [Severity: High]
> Is the listen() intentionally moved before the workers have registered
> their ifqs? The main thread creates the threads, calls listen(), and only
> then waits on setup_done, while the workers reach that barrier after
> io_uring_queue_init_params() plus setup_zcrx(), i.e. after
> io_uring_register_ifq() has restarted the device RX queue.
> 
> Before the patch the sequence was serialized in one thread:
> 
> 	io_uring_queue_init(512, &ctx.ring, flags);
> 	setup_zcrx(&ctx);
> 	...
> 	listen(fd, 1024);
> 
> so the port only became visible once the memory provider was installed.
> 
> Two existing tests depend on that ordering. wait_port_listen() in
> net/lib/py/utils.py polls every 5 ms, so it can now return while
> registration is still in flight:
> 
> iou-zcrx.py:test_zcrx_large_chunks() {
> 	wait_port_listen(cfg.port, proto="tcp")
> 
> 	check_iou_rx_buf_len(cfg, rx_buf_len)
> }
> 
> check_iou_rx_buf_len() raises "Expected 1 io-uring page pool, found 0",
> and nk_qlease.py:test_destroy() does queue_get() plus
> ksft_in("io-uring", queue_info) immediately after wait_port_listen() with
> no sleep.
> 
> Beyond the harness races, data delivered into the queue before the
> provider exists is serviced by the copy fallback rather than zero copy,
> and the queue restart during registration can drop in-flight frames.
> 
> Would moving listen() below pthread_barrier_wait(&setup_done) restore the
> previous guarantee?

Just a heads up that I tested this on BRCM and did find this listen()
ordering issue to cause genuine (but flaky) regression for
nk_qlease.test_destroy. Moving the listen() to after wait(setup_done)
indeed fixed it.

Best,
Bobby
