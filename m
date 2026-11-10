Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313491;
	b=QlnqhgLn4WBhPswlnxNzcEVJFyp3JRmUWqAYTJyn6eXWG2xbRLpp9CSJdjZ4i5OIS1mP
	 n+HD1sAb6pHgiJKc9iYOQwPidtK6WUGHA4N4N4j0Gj+u+RcGvleiSupC7uf9nBuWU30E3
	 X4Y8TPn7x282J2jBiR27AP4kAvJoIiIXMi1t7jn4LyGa2TgUtoCsCe8cXOG7rLY/4wkYb
	 ztCzXEQ7GZwRXfQsE7HsDPHJnv1fjL+AHW0TaKWsvkYWUysXwn85s0l5WKI2Wd9/qIZ2w
	 ivuj4P8k0n7bKTbpUCOf20/YAillHDK77Okk2Z4a5Y9Ly4MM2Tx/efPiOtUERqVG+UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313491;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=oGxVOcOZKJdSVIhjkgYRwcfA8DhUPk7Xrs1pQVfHMK4=;
	b=qs3hTO+rqfAea0zhSjeZzE8qG+pliRuwmpgc/95/ZaGAPELWfMgADxb1+X2AvZcwwOvh
	 4A+l/qQIp+DHv06cFm+2HOYXismwk6xsTeBucrt/UeNht3h0AfZV00DtQui704idDAfq1
	 soIeM3luQjL3Y7epCtHVP3sNUfhQqEEznBjo5sp7cfZpDgQCQcX3XIqUgETq4dSfGDgX7
	 /y2rc2dlscUtg1qzka93kg/T3ujK79I0PFf+/PbaXUG+ljhFwDg3dX6bnkfhPj5cxgJNk
	 4QsDGrFTU6lCrD5YLu38fWAdT9xkPt29NUg0O4bBiug2g243LOLNxr4rmRV6FVpjQ3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UuOeUBwU;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Znbv1O2I;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F11F606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 12:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F11F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UuOeUBwU;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Znbv1O2I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794313489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGxVOcOZKJdSVIhjkgYRwcfA8DhUPk7Xrs1pQVfHMK4=;
	b=UuOeUBwUnkd6qK9Ri11iyNkkmnUnhvRKpEICPn5LpRlwiCMa/kOqzmqljLd3FjcY6ZrlEi
	NXdXhqYBBHxTAHLrpwhh/UtYTK27Tx5KrCP9KMfzNX/46bD7pIRNwXXDpwlS71ufNt98M/
	L8gqNnSiWkPAO02JC2FZ8wfNhhgmM0Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-QvnReI8NOIKc-nGHVny6sw-1; Tue, 10 Nov 2026 07:24:48 -0500
X-MC-Unique: QvnReI8NOIKc-nGHVny6sw-1
X-Mimecast-MFC-AGG-ID: QvnReI8NOIKc-nGHVny6sw_1794313487
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a4654add56so14524775e9.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794313487; x=1794918287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oGxVOcOZKJdSVIhjkgYRwcfA8DhUPk7Xrs1pQVfHMK4=;
        b=Znbv1O2Izs7LoHwe4uvM0TQYevCK3P91i6Nt28X4e6BvC8r1sY/wc333tDL7w+gHBi
         Qvb3ev6KEDKLo+/pwyV88U0TjB5epP1Rwrzk8o2+Kv1kKR3+fp9fph474pkfDM8bAZPU
         T/MZ83SCqBBZ3aX2ZaY+L2C+Rkxuswed3DN51iPOzGNeXGnMZfkDuw3Q5HLchp8Lmdn7
         Y7bY8jU49Jtj4WNTO2O4mlYmOErB8L6pF250gnp51HgB15FCsT0Rc7cW13iCSV1av6sp
         cEUrTE7fE3JNX/7tHA1Rb1wzEZ9jNfH2JIIn1Jq66pDvphPfPbUaCaeuyeK06h2lHvJI
         pARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794313487; x=1794918287;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oGxVOcOZKJdSVIhjkgYRwcfA8DhUPk7Xrs1pQVfHMK4=;
        b=qvZziXmqAiCrsYdReenenqGgleipkHQOHnbOqdObXL6nJmFEddrX8U4I63siJxb8sx
         7dzSGFowqnh+Lb05gPGb56uQ7tF1kHe1LlstrkJOclbgFLusGbZsYonbzt95Om2HLK0c
         ji5G8A3ZYLDk5bksUvhu89+pyl3sCAkRkrs0XR5+alSbPrKpIJjBBfww1wDJfIV+aJi+
         4YtQ9OpIRGicHf3+HwRBzTaYFJVaZlzZjDjJ+rR7dGfc4K+JptztAeiPl2TMLYP4Lw6K
         WOfRhdptHFWD6iQlxqIuaRY+Sc1ZxucZWPyJIEslgMpEp3RPBau1OMTYe6SnXO5xrAet
         O+Yw==
X-Forwarded-Encrypted: i=1; AL+hErECohdd/1VqP23LQyVnRt8cQAmg1qfNLhwn5Yg9TwJkGays4QIg0ftfUdwmjP3kiBziU8D/mQI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+f6d6kK7UaM+z1uSdVd9dkkFjVW1AIh9aP7v9mbYAw296QRSp1
	Ocra7/I2u6i6zCUnr33hmGYtJ2GxNHrqcyMqFGamdzL/LtI+tsCg3LM9Tuf8TXOftwlwrZO+Um6
	p0x3IOwxPWBFBxXV3zGYuH+DfBkW1ObKmveTpPzmyBwP9nzkFRiaNcUAbLg==
X-Gm-Gg: AYBFou02tCLpnV8j11a66CGfArdnvF+C+xlp51lcxPDwqJWKd9NrQBdPWMLbZfv5ovl
	y7QkRcYtz3UzcgiWTH2/UCRyB1o06Xv3Bt7g1UrxWIFGV6tfXEhRSds3VlClkHmEEko8OrBdqQz
	X1A85nbF6CyKKGixWpOEAkG6DmAGwfWC6ryXC1DUhG+ISWESUhFBa0dTbJlIGhfg1PbWS7DGsdR
	N4SPWecWBom8DUyi7+FOi86oCTR8neCJ7JiMEdkCOrTq+uqEcb3Zmy2/xuC82v7Yde33v7ZsAxr
	A7OXLGhF2w3WSNY0+1kp0IBIr+qEcW7VBKI2z/BMWXv4zmgmJc4oH2nKlfO/YPrzC+vVAiu671c
	BqCTtMs5bLZMI0ob6BESF3/1GByNpmg/R5co=
X-Received: by 2002:a05:600c:4e55:b0:4a7:6425:c274 with SMTP id 5b1f17b1804b1-4ba023052a8mr41188485e9.2.1794313487136;
        Tue, 10 Nov 2026 04:24:47 -0800 (PST)
X-Received: by 2002:a05:600c:4e55:b0:4a7:6425:c274 with SMTP id 5b1f17b1804b1-4ba023052a8mr41187875e9.2.1794313486647;
        Tue, 10 Nov 2026 04:24:46 -0800 (PST)
Received: from [10.43.3.161] ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0223c41csm62198205e9.14.2026.11.10.04.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 04:24:45 -0800 (PST)
Message-ID: <eea7b4ef-a514-4c2e-81c4-690cdeeb40c2@redhat.com>
Date: Tue, 10 Nov 2026 13:24:44 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/10] dpll: reject measured_freq_get for foreign
 and on-pin registrations
Content-Language: en-US
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Min Li <min.li@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20261106121005.1327603-1-ivecera@redhat.com>
 <20261106121005.1327603-8-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261106121005.1327603-8-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/6/26 1:10 PM, Ivan Vecera wrote:
> A message about a pin with .measured_freq_get calls .freq_monitor_get of
> a dpll of the pin. For a pin of another domain, this device callback
> would run outside the domain of the dpll, so dpll_pin_register() now
> rejects such ops.
> 
> dpll_pin_on_pin_register() checks nothing about them. The message would
> call .freq_monitor_get with no NULL check, on a dpll of the parent pin
> that can belong to another driver, so reject them there as well.
> 
> No in-tree driver passes such ops. Add KUnit tests: the ops work on a dpll
> of the domain of the pin, and are rejected on a dpll of another domain and
> under a parent pin.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/dpll_core.c       |   6 +-
>   drivers/dpll/dpll_core_kunit.c | 112 +++++++++++++++++++++++++++++++--
>   2 files changed, 111 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index 8eb74682343156..84377f8ba16036 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -958,7 +958,8 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
>   
>   	dev_ops = dpll_device_ops(dpll);
>   	if (WARN_ON(ops->measured_freq_get &&
> -		    (!dev_ops || !dev_ops->freq_monitor_get ||
> +		    (pin->domain != dpll->domain || !dev_ops ||
> +		     !dev_ops->freq_monitor_get ||
>   		     !dev_ops->freq_monitor_set))) {
>   		ret = -EINVAL;
>   		goto out_unlock;
> @@ -1065,7 +1066,8 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
>   
>   	if (WARN_ON(!ops) ||
>   	    WARN_ON(!ops->state_on_pin_get) ||
> -	    WARN_ON(!ops->direction_get))
> +	    WARN_ON(!ops->direction_get) ||
> +	    WARN_ON(ops->measured_freq_get))
>   		return -EINVAL;
>   
>   	down_write(&dpll_lock);
> diff --git a/drivers/dpll/dpll_core_kunit.c b/drivers/dpll/dpll_core_kunit.c
> index a58800eda5ff51..84c405f855d8cb 100644
> --- a/drivers/dpll/dpll_core_kunit.c
> +++ b/drivers/dpll/dpll_core_kunit.c
> @@ -87,6 +87,7 @@ struct dt_reg {
>   	struct dt_dev *dev;
>   	struct dt_pin *parent;
>   	struct dt_pin *notify;
> +	const struct dpll_pin_ops *ops;
>   	struct dpll_domain *forbid;
>   	enum dpll_pin_state state;
>   	enum dpll_pin_direction direction;
> @@ -276,11 +277,33 @@ static int dt_lock_status_get(const struct dpll_device *dpll, void *priv,
>   	return 0;
>   }
>   
> +static int dt_freq_monitor_set(const struct dpll_device *dpll, void *priv,
> +			       enum dpll_feature_state state,
> +			       struct netlink_ext_ack *extack)
> +{
> +	return 0;
> +}
> +
> +static int dt_freq_monitor_get(const struct dpll_device *dpll, void *priv,
> +			       enum dpll_feature_state *state,
> +			       struct netlink_ext_ack *extack)
> +{
> +	struct dt_dev *dev = priv;
> +
> +	dt_dev_enter(dev, dpll);
> +	*state = DPLL_FEATURE_STATE_ENABLE;
> +	dt_leave(dev->dom);
> +
> +	return 0;
> +}
> +
>   static const struct dpll_device_ops dt_dev_ops = {
>   	.mode_get = dt_mode_get,
>   	.mode_set = dt_mode_set,
>   	.supported_modes_get = dt_supported_modes_get,
>   	.lock_status_get = dt_lock_status_get,
> +	.freq_monitor_set = dt_freq_monitor_set,
> +	.freq_monitor_get = dt_freq_monitor_get,
>   };
>   
>   static int dt_frequency_get(const struct dpll_pin *pin, void *pin_priv,
> @@ -433,6 +456,21 @@ static int dt_ref_sync_get(const struct dpll_pin *pin, void *pin_priv,
>   	return 0;
>   }
>   
> +static int dt_measured_freq_get(const struct dpll_pin *pin, void *pin_priv,
> +				const struct dpll_device *dpll, void *dpll_priv,
> +				u64 *measured_freq,
> +				struct netlink_ext_ack *extack)
> +{
> +	struct dt_reg *reg = pin_priv;
> +
> +	dt_pin_enter(reg, pin);
> +	atomic_inc(&reg->freq_gets);
> +	*measured_freq = 1;
> +	dt_leave(reg->dom);
> +
> +	return 0;
> +}
> +
>   static const struct dpll_pin_ops dt_pin_ops = {
>   	.frequency_get = dt_frequency_get,
>   	.state_on_dpll_get = dt_state_on_dpll_get,
> @@ -446,6 +484,13 @@ static const struct dpll_pin_ops dt_pin_ops = {
>   	.ref_sync_get = dt_ref_sync_get,
>   };
>   
> +static const struct dpll_pin_ops dt_pin_ops_measured = {
> +	.measured_freq_get = dt_measured_freq_get,
> +	.state_on_dpll_get = dt_state_on_dpll_get,
> +	.state_on_pin_get = dt_state_on_pin_get,
> +	.direction_get = dt_direction_get,
> +};
> +
>   static const struct dpll_pin_properties dt_prop = {
>   	.type = DPLL_PIN_TYPE_EXT,
>   	.capabilities = DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE |
> @@ -570,9 +615,9 @@ static void dt_reg_release(void *data)
>   
>   	if (reg->parent)
>   		dpll_pin_on_pin_unregister(reg->parent->pin, reg->pin->pin,
> -					   &dt_pin_ops, reg);
> +					   reg->ops, reg);
>   	else
> -		dpll_pin_unregister(reg->dev->dpll, reg->pin->pin, &dt_pin_ops,
> +		dpll_pin_unregister(reg->dev->dpll, reg->pin->pin, reg->ops,
>   				    reg);
>   }
>   
> @@ -588,12 +633,14 @@ static void dt_reg_add(struct kunit *test, struct dt_reg *reg,
>   	reg->parent = parent;
>   	reg->state = DPLL_PIN_STATE_SELECTABLE;
>   	reg->direction = DPLL_PIN_DIRECTION_INPUT;
> +	if (!reg->ops)
> +		reg->ops = &dt_pin_ops;
>   
>   	if (parent)
> -		ret = dpll_pin_on_pin_register(parent->pin, pin->pin,
> -					       &dt_pin_ops, reg);
> +		ret = dpll_pin_on_pin_register(parent->pin, pin->pin, reg->ops,
> +					       reg);
>   	else
> -		ret = dpll_pin_register(dev->dpll, pin->pin, &dt_pin_ops, reg);
> +		ret = dpll_pin_register(dev->dpll, pin->pin, reg->ops, reg);
>   	KUNIT_ASSERT_EQ(test, ret, 0);
>   	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dt_reg_release,
>   							reg), 0);
> @@ -1432,6 +1479,59 @@ static void dt_test_ref_sync_pair(struct kunit *test)
>   	dt_expect_events(test, (void *[]){ ctx->p.pin }, 1);
>   }
>   
> +/* A pin with a measured frequency must be in the domain of its dpll */
> +static void dt_test_measured_freq_foreign(struct kunit *test)
> +{
> +	struct kunit_suppressed_warning *w;
> +	struct dt_ctx *ctx = test->priv;
> +	struct dt_reg *reg;
> +	int ret;
> +
> +	dt_dev_add(test, &ctx->e0, &ctx->dom_e, DT_CLOCK_ID_E, 0,
> +		   DPLL_TYPE_PPS);
> +	dt_dev_add(test, &ctx->f0, &ctx->dom_f, DT_CLOCK_ID_F, 0,
> +		   DPLL_TYPE_PPS);
> +	dt_fwnode_pin_add(test, &ctx->x, DT_CLOCK_ID_E, DT_PIN_IDX_X);
> +
> +	reg = &ctx->reg_x_e0;
> +	reg->ops = &dt_pin_ops_measured;
> +	dt_reg_add(test, reg, &ctx->dom_e, &ctx->x, &ctx->e0, NULL);
> +	atomic_set(&reg->freq_gets, 0);
> +	KUNIT_EXPECT_EQ(test, dt_run(test, dt_pin_ntf, &ctx->x), 0);
> +	KUNIT_EXPECT_GT(test, atomic_read(&reg->freq_gets), 0);
> +
> +	w = kunit_start_suppress_warning(test);
> +	ret = dpll_pin_register(ctx->f0.dpll, ctx->x.pin, reg->ops, reg);
> +	kunit_end_suppress_warning(test, w);
> +
> +	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
> +	if (!ret)
> +		dpll_pin_unregister(ctx->f0.dpll, ctx->x.pin, reg->ops, reg);
> +}
> +
> +/* A pin under a parent pin cannot have a measured frequency */
> +static void dt_test_measured_freq_on_pin(struct kunit *test)
> +{
> +	struct kunit_suppressed_warning *w;
> +	struct dt_ctx *ctx = test->priv;
> +	struct dt_reg *reg;
> +	int ret;
> +
> +	dt_on_pin_add(test);
> +	dt_pin_add(test, &ctx->y, DT_CLOCK_ID_G, DT_PIN_IDX_Y, &dt_prop);
> +	reg = &ctx->reg_c_m;
> +
> +	w = kunit_start_suppress_warning(test);
> +	ret = dpll_pin_on_pin_register(ctx->m.pin, ctx->y.pin,
> +				       &dt_pin_ops_measured, reg);
> +	kunit_end_suppress_warning(test, w);
> +
> +	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
> +	if (!ret)
> +		dpll_pin_on_pin_unregister(ctx->m.pin, ctx->y.pin,
> +					   &dt_pin_ops_measured, reg);
> +}
> +
>   static struct kunit_case dt_cases[] = {
>   	KUNIT_CASE(dt_test_domain_sharing),
>   	KUNIT_CASE(dt_test_domain_per_module),
> @@ -1456,6 +1556,8 @@ static struct kunit_case dt_cases[] = {
>   	KUNIT_CASE(dt_test_set_on_pin),
>   	KUNIT_CASE(dt_test_device_set_ntf),
>   	KUNIT_CASE(dt_test_ref_sync_pair),
> +	KUNIT_CASE(dt_test_measured_freq_foreign),
> +	KUNIT_CASE(dt_test_measured_freq_on_pin),
>   	{}
>   };
>   
Reviewed-by: Petr Oros <poros@redhat.com>

