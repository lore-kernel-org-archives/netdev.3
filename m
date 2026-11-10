Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333209;
	b=4fYjhTaCxP6tzTdhAsRh/NYO2QQLDowWuSxJlhCxvYo3WPBvQQ/pHS7V4W5ivZBMuBBf
	 mZbDqGJxgvWBDRcKRn6QShiWsmc9lPR13D5gduXEjhSFxZI7LZB+gxPVcQ/NTzFw6JivT
	 IJMC1oQj10WElbUIH73bDe1nk/iiufpOsIH7BNTdaKT+q8JTZnmZgo6KGB+T/0xEGfE/i
	 x+dDd6XR7ptp1SZBsLVppExCEUMPYCLxZFTmkIBimYT9AECDDNUI0rEVgLkiyyNd3btLK
	 5yhqSTTa/fqt1jAS/hSZnWfyE7GylqRkmaBXAmb2J+qa2FCpLH4VqzHriDfQKvWZ0OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333209;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=H4LlDob9KtsWjhJ6bgkzIx99XQ1EqBXecgkfD3zBoZ8=;
	b=ntres9qhO3R4mvEtABXGb7tgnR6WJIYy9mpODpLIPMwG0RgKuqjg4gJfB7LNTmgeitLj
	 5i6bAsbSRJIXaayjgosRAcGy3+5Yg3M1DoEiKBxSe+8tWczUT2YWB8d1IUw6mEpaKSk3J
	 /VxQ+5ydrMzGgfv6/iIGHDVP4HBORRmyaJsj3gWJZyTXcpOOuPW1CoEwFmg08WZRiNeLJ
	 OpStPsabG/Lezhjs0cCg2XnMEn7ZJkeCyQarJiPxg/SmKlW+yszUjwRlFi64pnIOz79pn
	 jxLCbLGDAZox8KTEQTZLhrC7ZL3hh6aU3acVON4Dr+DH3GvXA4kPQioVO6uFygFCdaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OaXb93M2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D493E60A3812;
	Tue, 10 Nov 2026 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OaXb93M2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9CE1F008A2;
	Tue, 10 Nov 2026 17:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333208;
	bh=H4LlDob9KtsWjhJ6bgkzIx99XQ1EqBXecgkfD3zBoZ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OaXb93M2qPN1jKc+CLbMNVqJHa6R2KifUhQQIXEM6mdwv23em48/HN7gKtNRh+D3N
	 1zNSYtv4VxMnxEH1uYz0N9Cp3R1oGn4E3ion1nKZbPa7b96Uhg2+67Ixja/duVb9uE
	 ctObYjhphhiHbZlFwgK86sd1iRnp3oggu4W1JullH2zWTAt7UEmgstbldbaw1T/T9j
	 GVsMW90tWiEptCrU900jKzOJYux3WZAmXrglRkEb7ysZhBLiJIWQNYulWEhenwi0RL
	 8Dec667jrXNrZ1o8gWKDRio1s6qW9vdyoIcYsK68kge4V6/wJAwNIP6cwmfL0wZ21+
	 QDAko4JCtTKtA==
Subject: Re: [PATCH net-next 06/10] dpll: add KUnit tests for core locking
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, min.li@microchip.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, grzegorz.nitka@intel.com,
 karol.kolacinski@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 poros@redhat.com
Date: Tue, 10 Nov 2026 17:53:26 +0000
Message-ID: <179433320676.994134.7049432410059447687@kernel.org>
In-Reply-To: <20261106121005.1327603-7-ivecera@redhat.com>
References: <20261106121005.1327603-7-ivecera@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In drivers/dpll/dpll_core_kunit.c, some tests set a blocking
  flag before dt_req_start() has registered dt_req_release().

--

dpll: add KUnit tests for core locking

This adds KUnit tests for DPLL core locking. They use a mock driver with
several domains to check domain sharing, which locks callbacks hold,
independence and serialization of domains, atomicity of multi-attribute
pin sets, and notification ordering. The netlink pre/post doit and set
handlers are exported for KUnit so the tests can call them directly.

> diff --git a/drivers/dpll/dpll_core_kunit.c b/drivers/dpll/dpll_core_kunit.c
> new file mode 100644
> index 0000000000000..a58800eda5ff5
> --- /dev/null
> +++ b/drivers/dpll/dpll_core_kunit.c
> @@ -0,0 +1,1471 @@

[ ... ]

> +static void dt_block(struct dt_dom *dom, bool *block)
> +{
> +	complete(&dom->entered);
> +	wait_event(dom->ctx->wq, !READ_ONCE(*block));
> +}

[ ... ]

> +static struct dt_req *dt_req_start(struct kunit *test, int (*fn)(void *arg),
> +				   void *arg)
> +{
> +	struct task_struct *task;
> +	struct dt_req *req;
> +
> +	req = kunit_kzalloc(test, sizeof(*req), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, req);
> +
> +	req->ctx = test->priv;
> +	req->fn = fn;
> +	req->arg = arg;
> +	init_completion(&req->done);
> +
> +	task = kthread_run(dt_req_thread, req, "dpll-test");
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, task);
> +	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dt_req_release,
> +							req), 0);
> +
> +	return req;
> +}

[ ... ]

> +/* Blocks a request of @dom in a callback, which holds the domain lock */
> +static struct dt_req *dt_block_in(struct kunit *test, struct dt_dom *dom,
> +				  int (*fn)(void *arg), void *arg)
> +{
> +	struct dt_req *req;
> +
> +	WRITE_ONCE(dom->block, true);
> +	req = dt_req_start(test, fn, arg);

[Severity: Medium]
Can the teardown hang here if dt_req_start() fails one of its assertions?

dom->block is set before dt_req_start() registers dt_req_release(), and
dt_req_release() is the only cleanup action that calls dt_unblock(). If
kunit_kzalloc() or kthread_run() in dt_req_start() fails, the
KUNIT_ASSERT_NOT_NULL() or KUNIT_ASSERT_NOT_ERR_OR_NULL() check aborts the
test and the flag stays set.

The cleanup actions that were already registered then run, for example:

dt_reg_release()
  dpll_pin_unregister()
    down_write(&dpll_lock)
    __dpll_pin_unregister()
      dpll_pin_delete_ntf()
        mutex_lock(&pin->domain->lock)
        dpll_pin_event_send()
          dpll_cmd_pin_get_one()
            pin get callbacks
              dt_pin_enter()->dt_enter()->dt_block()

dt_block() then waits with:

    wait_event(dom->ctx->wq, !READ_ONCE(*block));

Nothing is left that can clear the flag. The KUnit cleanup thread would
sleep uninterruptibly while holding dpll_lock for write and a domain
mutex. Every other DPLL user in the system would then block behind it.

dt_test_stuck_foreign_device() has the same problem:

    WRITE_ONCE(ctx->f0.block, true);
    blocked = dt_req_start(test, dt_device_ntf, &ctx->f0);

There, dt_dev_release()->dpll_device_unregister()->dpll_device_delete_ntf()
->dpll_device_get_one()->dt_mode_get()->dt_dev_enter() would reach
dt_block() on f0.block.

One option is to register a cleanup action that calls dt_unblock() from
dt_init(), before any flag can be set. Another is to set the flags only
after dt_req_release() has been registered. Would either of these work?

Setting block_prio_set early looks harmless, since no teardown path calls
prio_set.

> +	KUNIT_ASSERT_TRUE(test, wait_for_completion_timeout(&dom->entered,
> +							    DT_TIMEOUT));
> +
> +	return req;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106121005.1327603-1-ivecera%40redhat.com
