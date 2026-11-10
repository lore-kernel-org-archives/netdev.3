Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324363;
	b=GU0P2YNMoTBhIeXETwlEYqUPoqDfD2bQjGlRmI2fkiw2JtVSMzUrT535WxwVuPbtkgR5
	 bysi4ezZO6VH3+dtk2qifdLLzeQm1NghsACTtYNqPL5bPEm8uSqkbQ+DGvwhBM0RC3GF/
	 VVOBxaSH0m5E6gAq7CM14ekUiqrPoufxfit97SjQhildULd6Q20MYfFlqscW7+4PO334+
	 TBhb7wk7B/GpGZtzrBXNkgWqK9QrqPCYPezYe2Uqx+DoThqqeAdfhAEpUEE6yftAcn6Sp
	 E9LW3u3hGQhPq2CA7IVmctT7DQAhg5Bg8dh0mVSPhGchtOGYvwoz4FQu5WNfTdrxz1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324363;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZtndkHAk1bvYJbBuKV5N1mcI+hl9IGHF+CaWL7eypxA=;
	b=iEyZfOZDmQRuKKfDaz80nt7NcxtOkM8jseJZPsp/4q9uyhuzCh5kuXvjlwn/931TAtNl
	 +pKW96nHPWSa2vwVdwEWX5EQ+n3XIJb29TxdS1kji//RagTdyP1Lq4iM9GD4IborL0mON
	 9Jm9bruf7Eqp93Gw/RPhOxZ6/RKXgMo8/V3I1+K0h9/fTUGn3X+VySwtu3R31wUT7ktLn
	 9V/J6AgaTiWe/4SOYXPM/PUuFIJ32/1+Dz7Op9/+D4llYi44UWT0OJOVa3IxsXDXKDh++
	 +1I4clCfKBh+GITGqRACmR+x2aCZdiN6yqK6HaH5IRDNZRmxmH0KbwKCc3EiKkDyHLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cUMB1SHx;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=L4Rs3Ouo;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DBD606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78DBD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cUMB1SHx;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=L4Rs3Ouo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794324361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtndkHAk1bvYJbBuKV5N1mcI+hl9IGHF+CaWL7eypxA=;
	b=cUMB1SHxe9+Z6pbSpK2EqAF/MLPGRF12G+KlLvcCo3kNesFEyOPaA1sF1otxp2vhSXXRHY
	crSuAVRdgY9fAYAgk3kkob9vJxU+UB0Ef5k+xdofoCMadSpKy6+eHKT0/zA2yZLsE0dSBv
	wmlDEEEwXsRuyo3NzUUAHtKxpJQ2dIY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-MYSQoei3PauHs7Q_Yig3bA-1; Tue, 10 Nov 2026 10:25:59 -0500
X-MC-Unique: MYSQoei3PauHs7Q_Yig3bA-1
X-Mimecast-MFC-AGG-ID: MYSQoei3PauHs7Q_Yig3bA_1794324358
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-49323e268aeso1700011f8f.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794324358; x=1794929158; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZtndkHAk1bvYJbBuKV5N1mcI+hl9IGHF+CaWL7eypxA=;
        b=L4Rs3OuoXE9XIAvPnSU74JssR8pR6dLQW0UmTeE/TcxiGahMTQZBUTIcaBlgxIKQdJ
         o9T//zE/b8/v4aOgiCrk7WyqVNk9KfyYwpU6ZUcNaK3/WkIWf8OA8a/OzUc26xaWQcsm
         JiIMwhAkDYoIGIoBhMnHHUmOHkcPsHRmVZHi7jUXQmgwNI6XJIAY4KaXBtyjLodJT6pv
         rqsWifSaJmRE6uskfRxU9S8VBeyJqNWkglRWAONhR9c/RCSdPqGIpGrjRSfbf0boW6Hn
         X67oNAk9lB5l0Cpy9Hb99Mr/4yffnVM9zo439ch6ovPO1B4NeclU7vGF+1p083gnzON8
         TBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794324358; x=1794929158;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZtndkHAk1bvYJbBuKV5N1mcI+hl9IGHF+CaWL7eypxA=;
        b=roCABz0S4q6nU2tBw05krbrUCn5pgnOZf3CXE1GPRGRfWgzv47k5su609h7cybZvza
         xouFZkHitPUGzLIW/8AKYawZ2YehgU99Ln4lWG8BRREJ+wEmJ3QmaEg8bnigGoHVr68W
         Oobsbhmnu4YcZ9okuDxwWXDLOiKp8OiIG7WbUpgIZ5ixgL78lAk0fjw375lyG2HlYjGg
         EAS0btSocuCVHhD5QQi1vqATITlL6BibzCz/S+twTm/vCNkWqiGaB3qT4Joe62vLULJV
         m/0iKe+WQGvwZAusa7esGsedhJ5LJIBDZgCztNFTCZqk/ZNFrBNzFUJ6NugRqDVkyULW
         tb+w==
X-Forwarded-Encrypted: i=1; AL+hErFBO9z5sUYAZ2+9vQ1qKPb2aD5Vm8SzU2MwICxXOkSA6UUTomaY8YXLFpFe2T3sL4mXL9Xx8DM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xuYHGXesKaCpbEc+wqf82ez6OZ2bsdLD1J4EuWNcPj7t8+RDF
	vju1kk3qtMvN7Bi15XF2QrUTMij8tpJ3EQAVymUAPircXb4yBoYsIffPeXvIAIZMXqIhK2/xNjN
	xKlDTdGkj5f1wK51J0VARFy9MFePfDj/ZuRfCkiMXyA/cj5914N1/StvABg==
X-Gm-Gg: AYBFou1ZE+wAU/CCa67erJuXM7s2j7WhaJE1RSSXq1SYGtxi/oOBo8SZ4KK/XxFOTkJ
	qv076LY7aV7mD6agDXAEvBZ9wqoAJiHZy51N0bAWQkfOcilb1C6q2Oy7yoNmKyH8LATAtwMVEKU
	uOKT9a8UJqB1Fc8rw5ggUn8kx64m2PZ23wBFOCQkp+1bh/W6mUVI3+GJ/KBtNilg3cE9yNFf1tI
	sWVewyWIo01IFZlUnmSNcLOB1xr3PHQiWSc6p186CD0CPxp/WVhQV2dJTTF0rNRlVZqJh1NAVu1
	WQboXrtVPGHUsLHaJ+OcV7RGHPR/UeQ4i38+Zv2dKe5Gv5LUKph69k9t0zDPcvIlUjy35fY39Va
	qoY1UTnWiZwhDz/FuRscLVsFBTgvTRD42V8E=
X-Received: by 2002:a05:6000:4555:b0:48d:f160:efad with SMTP id ffacd0b85a97d-49830b97cbdmr4156321f8f.30.1794324357975;
        Tue, 10 Nov 2026 07:25:57 -0800 (PST)
X-Received: by 2002:a05:6000:4555:b0:48d:f160:efad with SMTP id ffacd0b85a97d-49830b97cbdmr4156255f8f.30.1794324357353;
        Tue, 10 Nov 2026 07:25:57 -0800 (PST)
Received: from [10.43.3.161] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365cbbe5sm6123261f8f.42.2026.11.10.07.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:25:56 -0800 (PST)
Message-ID: <c4b7421f-be84-49b8-8d42-9a4b3050ee28@redhat.com>
Date: Tue, 10 Nov 2026 16:25:55 +0100
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
Subject: Re: [PATCH net 2/2] dpll: report dumps interrupted by topology
 changes
Content-Language: en-US
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Milena Olech <milena.olech@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Michal Michalik <michal.michalik@intel.com>, linux-kernel@vger.kernel.org
References: <20261105131145.1010406-1-ivecera@redhat.com>
 <20261105131145.1010406-3-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261105131145.1010406-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/5/26 2:11 PM, Ivan Vecera wrote:
> Pin and device dumps release dpll_lock between parts and resume from the
> id saved by the previous part. An object registered in between is missed
> if its id is below that one, as is the case for an object allocated
> before the dump started. User space gets an incomplete dump and has no
> way to tell.
> 
> Count registrations and unregistrations in a generation counter and pass
> it to genl_dump_check_consistent() to set NLM_F_DUMP_INTR. Check it only
> after a message is built, a cancelled message would consume the change.
> 
> Found by code review. Reproduced with a test module registering a device
> or a pin with a low id between parts of a raw netlink dump: the object was
> missing and no message had the flag set. With this patch the flag is set
> when an object is registered or unregistered during a dump, and is not
> set on dumps without such a change. Tested in QEMU and on a ZL30732A
> board, where unbinding the driver during a dump sets the flag as well.
> 
> Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/dpll_core.c    | 19 +++++++++++++++++++
>   drivers/dpll/dpll_core.h    |  1 +
>   drivers/dpll/dpll_netlink.c |  4 ++++
>   3 files changed, 24 insertions(+)
> 
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index 277692d12d3d1e..a68e8f5b609db8 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -22,6 +22,12 @@
>   /* Mutex lock to protect DPLL subsystem devices and pins */
>   DEFINE_MUTEX(dpll_lock);
>   
> +/* Changes with the topology of devices and pins, so that netlink dumps can
> + * detect it. Never 0, as netlink takes that for no sequence. Protected by
> + * dpll_lock.
> + */
> +unsigned int dpll_generation = 1;
> +
>   DEFINE_XARRAY_FLAGS(dpll_device_xa, XA_FLAGS_ALLOC);
>   DEFINE_XARRAY_FLAGS(dpll_pin_xa, XA_FLAGS_ALLOC);
>   
> @@ -53,6 +59,13 @@ struct dpll_pin_registration {
>   	dpll_tracker tracker;
>   };
>   
> +static void dpll_generation_inc(void)
> +{
> +	lockdep_assert_held(&dpll_lock);
> +	while (++dpll_generation == 0)
> +		;
> +}
> +
>   static int call_dpll_notifiers(unsigned long action, void *info)
>   {
>   	lockdep_assert_held(&dpll_lock);
> @@ -510,6 +523,7 @@ int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
>   	}
>   
>   	xa_set_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED);
> +	dpll_generation_inc();
>   	dpll_device_create_ntf(dpll);
>   	mutex_unlock(&dpll_lock);
>   
> @@ -549,6 +563,7 @@ void dpll_device_unregister(struct dpll_device *dpll,
>   		return;
>   	}
>   	xa_clear_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED);
> +	dpll_generation_inc();
>   	mutex_unlock(&dpll_lock);
>   }
>   EXPORT_SYMBOL_GPL(dpll_device_unregister);
> @@ -851,6 +866,7 @@ __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
>   	if (ret)
>   		goto ref_pin_del;
>   	xa_set_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED);
> +	dpll_generation_inc();
>   	dpll_pin_create_ntf(pin, dpll->clock_id);
>   
>   	return ret;
> @@ -941,6 +957,7 @@ __dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
>   	dpll_pin_delete_ntf(pin, dpll->clock_id);
>   	dpll_xa_ref_pin_del(&dpll->pin_refs, pin, ops, priv, cookie);
>   	dpll_xa_ref_dpll_del(&pin->dpll_refs, dpll, ops, priv, cookie);
> +	dpll_generation_inc();
>   	if (xa_empty(&pin->dpll_refs)) {
>   		dpll_pin_ref_sync_pair_del(pin->id);
>   		xa_clear_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED);
> @@ -1005,6 +1022,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
>   	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv, pin);
>   	if (ret)
>   		goto unlock;
> +	dpll_generation_inc();
>   	xa_for_each(&parent->dpll_refs, i, ref) {
>   		ret = __dpll_pin_register(ref->dpll, pin, ops, priv, parent);
>   		if (ret) {
> @@ -1057,6 +1075,7 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
>   		__dpll_pin_unregister(ref->dpll, pin, ops, priv, parent);
>   	}
>   	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
> +	dpll_generation_inc();
>   	mutex_unlock(&dpll_lock);
>   }
>   EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
> diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
> index da8a369556ed11..c2ed0926de1b95 100644
> --- a/drivers/dpll/dpll_core.h
> +++ b/drivers/dpll/dpll_core.h
> @@ -99,6 +99,7 @@ struct dpll_pin_ref *dpll_xa_ref_dpll_first(struct xarray *xa_refs);
>   extern struct xarray dpll_device_xa;
>   extern struct xarray dpll_pin_xa;
>   extern struct mutex dpll_lock;
> +extern unsigned int dpll_generation;
>   
>   void dpll_device_notify(struct dpll_device *dpll, unsigned long action);
>   void dpll_pin_notify(struct dpll_pin *pin, u64 src_clock_id,
> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> index e5380d95f238b3..87c8caef0f574b 100644
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c
> @@ -1768,6 +1768,7 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   	int ret = 0;
>   
>   	mutex_lock(&dpll_lock);
> +	cb->seq = dpll_generation;
>   	xa_for_each_marked_start(&dpll_pin_xa, i, pin, DPLL_REGISTERED,
>   				 ctx->idx) {
>   		if (!dpll_pin_available(pin))
> @@ -1789,6 +1790,7 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   			}
>   			break;
>   		}
> +		genl_dump_check_consistent(cb, hdr);
>   		genlmsg_end(skb, hdr);
>   	}
>   	mutex_unlock(&dpll_lock);
> @@ -1990,6 +1992,7 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   	int ret = 0;
>   
>   	mutex_lock(&dpll_lock);
> +	cb->seq = dpll_generation;
>   	xa_for_each_marked_start(&dpll_device_xa, i, dpll, DPLL_REGISTERED,
>   				 ctx->idx) {
>   		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
> @@ -2004,6 +2007,7 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   			genlmsg_cancel(skb, hdr);
>   			break;
>   		}
> +		genl_dump_check_consistent(cb, hdr);
>   		genlmsg_end(skb, hdr);
>   	}
>   	mutex_unlock(&dpll_lock);
Reviewed-by: Petr Oros <poros@redhat.com>

