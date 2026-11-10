Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313455;
	b=OvpQqFDW9I8yImpZHUrpEZ32ZOQbBCRN2wHPvyELDaZBJ7+Goskwzmz+/tfAlw70TN5i
	 mYstL8UEGI168jteSB983gqFbvmccY0oWkwUT5wmAb++BOWCpq3GaGmNeIadUfA9/QQED
	 D6n+ki3j4tIAE1dxpVviE19Zx4VY7D5mvJd7UY6WDMI5x/28wHl5YfedwINP0yyGRszgo
	 pfRf7j+ddO/TQdB4TlYyITYkNUdn7hbqNyDUvy27aOWRjOxJCiFdLtWD75BfG07rpvzbh
	 lwwMBOQb33lvirAa7CLD71Bk2rOGWo9qjzH6RWaDwVU0J9xRqW0XJPbNNOvmWNWqiiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313455;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=yeAOOGb1lxkAjyxfUQEssqvLvFA7bPwutUunMyT967U=;
	b=aqckmcsC0A1b69L5u2bPG8P3I9pYn4R//EtoXEmhZEvGLDUqiWWRr0yF0AmkxHHzxJYg
	 MvjCmWlWlwm/XfkvMLm37a6A8Xbjpm+XlieEzPP2jGdP4VTrRDQ5mVuYLXA3Bn+JEszeg
	 5iEh+Mw0dujYHskjfY6QbcE3zMidq4pzvhDQFcBwPUOel6rjelD3W8UDhDpwXUiUBBOnZ
	 yWtp2zOGRKzAtH+QPtkhLxpnLxzTyn5diX7FL+YUKScGWVhNfxflVy3RfNohhACWogaDb
	 xIbxNFDUxK+Hs2G0clyL9VCMT94AU0QpRY9nkE/+n1/6vJMTizMetfMzNOiHPAtvVjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Ct/xz2tH";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=blX26+WP;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AC9606A32E
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 12:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0AC9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ct/xz2tH;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=blX26+WP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794313452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yeAOOGb1lxkAjyxfUQEssqvLvFA7bPwutUunMyT967U=;
	b=Ct/xz2tHIgD10iPk6TcPy6WdPpFSWySW332vmT4aoBs3HzQ1dSIX44C4efxzwkNIqjKyvC
	oZfCUYzdSctZxHmGmruwk4EjnqurYsYswYZokutI7e7CwKrIDNj8sRBTwXStvz22gx+zl6
	zDPQqX9Kl1YEnn/jwhqF2f1zDzQ+GkA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-qWendMbHMqGn19EhwOkYpw-1; Tue, 10 Nov 2026 07:24:10 -0500
X-MC-Unique: qWendMbHMqGn19EhwOkYpw-1
X-Mimecast-MFC-AGG-ID: qWendMbHMqGn19EhwOkYpw_1794313449
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e1d839ddaso1290258f8f.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794313449; x=1794918249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yeAOOGb1lxkAjyxfUQEssqvLvFA7bPwutUunMyT967U=;
        b=blX26+WPrgAgJw2SPlnV/wivT45gf1Dm0hJmfBK+mQWBdCb8Frl7c3trgQafA/e+4I
         Z/YE1Weqwc5GS8pYPJjRAbPBrg9lUWMx4dh+56VZ4JxRR2JXBdzFkoIbBznONP8JYVre
         Qs7ir4IFZ0IiwjWt6J50jBbHpRhGtEw/6tn9UVRxzKJzg3wY0dUnbr2ZJy11h1O7q5/R
         LpFQkEirZeiLCxQli5wrwAvUz5ozazZ9NgiPFmNi0uT9De+zn5x2DgGUQyxfHVxa/08v
         tpsVNGVo3QKysudzKy0Vqa1ZPf//XbXTQvMoYpJtVSQcakS5J8Bl9be/uIbAWiH0xjd/
         iDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794313449; x=1794918249;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yeAOOGb1lxkAjyxfUQEssqvLvFA7bPwutUunMyT967U=;
        b=GjDz2awLreMSx/tOXjpAuZuKZCNLvVNMRxBHmRSYJsWA/oPCzdTvuYgbVKVuuDGg9D
         JtxXjf14rTV0JMVnzwUEXQLyd8CPKYrA/ql38kAQgSrLKuV97EndYG8erUF0qyKUlC7Q
         BYvtgpxEN6oxISdlni+6IFfDhHm5WKOqz5ZNZVNDYL3jXG9E/4xdsqAnWBF/GhQprXUO
         pBRaVjJe7ZAuozSmHMk0kurCZ67dY5dmh+0Xnei+2flidcMVgY1Wo3+31IzgUvKZurTj
         RKO5B8zNBiBDwtUzJHdmGGXY04JY4DD8+y9iu4oKzUjbafyntqV0SdM5Y2Vi/R2GK6JS
         1FVA==
X-Forwarded-Encrypted: i=1; AL+hErEPed+x8wSLVSipawrAll6GYUM1Yb2eUGAFsETd5oV7b/gNpENDeyjbAuqpb+UBgJ23m6APiCA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SPB3Jah6OdvU3zCKxnzVz1LrC9xvfOVlEUpUNBWlRJFiS9TgU
	YdjXQyGoe3AeXjrY+Z6rARpy7uTSahDa0VUg/WaxeNk63bbCc4pZdb4W1RJ9ADEE2lYqS2uF2nz
	P/Us8L5skhShoZMU8M5cLgIyg6BUXMy4GnHtIVZtC+rqS45Nzymi4ndev0w==
X-Gm-Gg: AYBFou2UZLmzDS1oKY5oIXE3838yQ4NL84c/SIKa/dN7mPNEensy/Gv5HibXHhM/8/4
	SB7/STxaOcoaucBHrCnAvsLXLAYqZ4nFSsWGmIxo35A7ChlPP45vApFTcql53gg7ig1isrPlt1w
	DgXzCNd3xF+6jl8dkN8/h7qK0N/Oqs/+Y4AK/PerJU5/t3FoukoTFMgRLzd/TOdzC6efH2SQ46h
	MCrqxYQLHIo8o1g/2r+y2unOSHF5IPBaDwHycCGAbbyWECGP0KIAdeNV0UqjxksV+l1d5cUdCpc
	jkm+KZYvScFAnpGWJ7l4CFBYr9Uu5ZqIjskEbK77PNI2dWkiOFSAK14m6Wi5an6Nn+9MsRY8GS5
	SWRXsj9bGkApNb/49QSJ0LEvP/6SyZZJHfG0=
X-Received: by 2002:a05:6000:22c6:b0:48d:f36e:fbcb with SMTP id ffacd0b85a97d-4982e82c1b2mr4754513f8f.14.1794313449324;
        Tue, 10 Nov 2026 04:24:09 -0800 (PST)
X-Received: by 2002:a05:6000:22c6:b0:48d:f36e:fbcb with SMTP id ffacd0b85a97d-4982e82c1b2mr4754440f8f.14.1794313448686;
        Tue, 10 Nov 2026 04:24:08 -0800 (PST)
Received: from [10.43.3.161] ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498362eb14asm4534584f8f.34.2026.11.10.04.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 04:24:07 -0800 (PST)
Message-ID: <7f51beca-9045-4e3d-a97d-43e7a8a7557d@redhat.com>
Date: Tue, 10 Nov 2026 13:24:06 +0100
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
Subject: Re: [PATCH net-next 05/10] dpll: convert dpll_lock to rwsem
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
 <20261106121005.1327603-6-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261106121005.1327603-6-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/6/26 1:10 PM, Ivan Vecera wrote:
> Driver callbacks are now serialized by domain locks, so dpll_lock only has
> to protect the topology and lifetime of devices and pins.
> 
> Convert it to an rwsem. Core functions changing the topology take it for
> write. Netlink requests, each part of a dump and change notifications take
> it for read, for their whole duration, so objects found by a lookup stay
> valid. This is the patch that lets callbacks of different domains run
> concurrently.
> 
> A callback running for long still blocks topology changes, and a waiting
> writer blocks new readers, so a stuck callback stalls the subsystem while
> a device is being probed or removed. This is no worse than the global
> serialization it replaces.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/dpll_core.c    | 93 +++++++++++++++++--------------------
>   drivers/dpll/dpll_core.h    |  3 +-
>   drivers/dpll/dpll_netlink.c | 32 ++++++-------
>   3 files changed, 61 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index dd09f528170994..8eb74682343156 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -19,8 +19,12 @@
>   #include "dpll_core.h"
>   #include "dpll_netlink.h"
>   
> -/* Mutex lock to protect DPLL subsystem devices and pins */
> -DEFINE_MUTEX(dpll_lock);
> +/* Protects the topology and lifetime of DPLL devices and pins. Taken for write
> + * to change them and for read for the whole netlink request, part of a dump or
> + * change notification that uses them. Driver callbacks are serialized by domain
> + * locks, which are only taken under this lock.
> + */
> +DECLARE_RWSEM(dpll_lock);
>   
>   DEFINE_XARRAY_FLAGS(dpll_device_xa, XA_FLAGS_ALLOC);
>   DEFINE_XARRAY_FLAGS(dpll_pin_xa, XA_FLAGS_ALLOC);
> @@ -459,7 +463,7 @@ dpll_device_get(u64 clock_id, u32 device_idx, struct module *module,
>   	struct dpll_device *dpll, *ret = NULL;
>   	unsigned long index;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	xa_for_each(&dpll_device_xa, index, dpll) {
>   		if (dpll->clock_id == clock_id &&
>   		    dpll->device_idx == device_idx &&
> @@ -475,7 +479,7 @@ dpll_device_get(u64 clock_id, u32 device_idx, struct module *module,
>   			dpll_device_tracker_alloc(ret, tracker);
>   	}
>   
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   
>   	return ret;
>   }
> @@ -492,9 +496,9 @@ EXPORT_SYMBOL_GPL(dpll_device_get);
>    */
>   void dpll_device_put(struct dpll_device *dpll, dpll_tracker *tracker)
>   {
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	__dpll_device_put(dpll, tracker);
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   }
>   EXPORT_SYMBOL_GPL(dpll_device_put);
>   
> @@ -540,16 +544,16 @@ int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
>   	if (WARN_ON(type < DPLL_TYPE_PPS || type > DPLL_TYPE_MAX))
>   		return -EINVAL;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	reg = dpll_device_registration_find(dpll, ops, priv);
>   	if (reg) {
> -		mutex_unlock(&dpll_lock);
> +		up_write(&dpll_lock);
>   		return -EEXIST;
>   	}
>   
>   	reg = kzalloc_obj(*reg);
>   	if (!reg) {
> -		mutex_unlock(&dpll_lock);
> +		up_write(&dpll_lock);
>   		return -ENOMEM;
>   	}
>   	reg->ops = ops;
> @@ -559,13 +563,13 @@ int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
>   	first_registration = list_empty(&dpll->registration_list);
>   	list_add_tail(&reg->list, &dpll->registration_list);
>   	if (!first_registration) {
> -		mutex_unlock(&dpll_lock);
> +		up_write(&dpll_lock);
>   		return 0;
>   	}
>   
>   	xa_set_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED);
>   	dpll_device_create_ntf(dpll);
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   
>   	return 0;
>   }
> @@ -586,12 +590,12 @@ void dpll_device_unregister(struct dpll_device *dpll,
>   {
>   	struct dpll_device_registration *reg;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	ASSERT_DPLL_REGISTERED(dpll);
>   	dpll_device_delete_ntf(dpll);
>   	reg = dpll_device_registration_find(dpll, ops, priv);
>   	if (WARN_ON(!reg)) {
> -		mutex_unlock(&dpll_lock);
> +		up_write(&dpll_lock);
>   		return;
>   	}
>   	list_del(&reg->list);
> @@ -599,11 +603,11 @@ void dpll_device_unregister(struct dpll_device *dpll,
>   	kfree(reg);
>   
>   	if (!list_empty(&dpll->registration_list)) {
> -		mutex_unlock(&dpll_lock);
> +		up_write(&dpll_lock);
>   		return;
>   	}
>   	xa_clear_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED);
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   }
>   EXPORT_SYMBOL_GPL(dpll_device_unregister);
>   
> @@ -771,9 +775,9 @@ int register_dpll_notifier(struct notifier_block *nb)
>   {
>   	int ret;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	ret = raw_notifier_chain_register(&dpll_notifier_chain, nb);
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(register_dpll_notifier);
> @@ -782,9 +786,9 @@ int unregister_dpll_notifier(struct notifier_block *nb)
>   {
>   	int ret;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	ret = raw_notifier_chain_unregister(&dpll_notifier_chain, nb);
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(unregister_dpll_notifier);
> @@ -812,7 +816,7 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
>   	struct dpll_pin *pos, *ret = NULL;
>   	unsigned long i;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	xa_for_each(&dpll_pin_xa, i, pos) {
>   		if (pos->clock_id == clock_id &&
>   		    pos->pin_idx == pin_idx &&
> @@ -827,7 +831,7 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
>   		if (!IS_ERR(ret))
>   			dpll_pin_tracker_alloc(ret, tracker);
>   	}
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   
>   	return ret;
>   }
> @@ -844,9 +848,9 @@ EXPORT_SYMBOL_GPL(dpll_pin_get);
>    */
>   void dpll_pin_put(struct dpll_pin *pin, dpll_tracker *tracker)
>   {
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	__dpll_pin_put(pin, tracker);
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   }
>   EXPORT_SYMBOL_GPL(dpll_pin_put);
>   
> @@ -859,10 +863,10 @@ EXPORT_SYMBOL_GPL(dpll_pin_put);
>    */
>   void dpll_pin_fwnode_set(struct dpll_pin *pin, struct fwnode_handle *fwnode)
>   {
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	fwnode_handle_put(pin->fwnode); /* Drop fwnode previously set */
>   	pin->fwnode = fwnode_handle_get(fwnode);
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   }
>   EXPORT_SYMBOL_GPL(dpll_pin_fwnode_set);
>   
> @@ -885,7 +889,7 @@ struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode,
>   	struct dpll_pin *pin, *ret = NULL;
>   	unsigned long index;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	xa_for_each(&dpll_pin_xa, index, pin) {
>   		if (pin->fwnode == fwnode) {
>   			__dpll_pin_hold(pin, tracker);
> @@ -893,7 +897,7 @@ struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode,
>   			break;
>   		}
>   	}
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   
>   	return ret;
>   }
> @@ -950,7 +954,7 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
>   		      DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE)))
>   		return -EINVAL;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   
>   	dev_ops = dpll_device_ops(dpll);
>   	if (WARN_ON(ops->measured_freq_get &&
> @@ -974,7 +978,7 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
>   
>   	ret = __dpll_pin_register(dpll, pin, ops, priv, NULL);
>   out_unlock:
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   
>   	return ret;
>   }
> @@ -1028,9 +1032,9 @@ void dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
>   	if (WARN_ON(!xa_empty(&pin->parent_refs)))
>   		return;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	__dpll_pin_unregister(dpll, pin, ops, priv, NULL);
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   }
>   EXPORT_SYMBOL_GPL(dpll_pin_unregister);
>   
> @@ -1064,7 +1068,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
>   	    WARN_ON(!ops->direction_get))
>   		return -EINVAL;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv, pin);
>   	if (ret)
>   		goto unlock;
> @@ -1076,7 +1080,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
>   		}
>   		dpll_pin_create_ntf(pin, parent->clock_id);
>   	}
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   
>   	return ret;
>   
> @@ -1089,7 +1093,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
>   		}
>   	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
>   unlock:
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(dpll_pin_on_pin_register);
> @@ -1111,7 +1115,7 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
>   	struct dpll_pin_ref *ref;
>   	unsigned long i;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	xa_for_each(&pin->dpll_refs, i, ref) {
>   		reg = dpll_pin_registration_find(ref, ops, priv, parent);
>   		if (!reg)
> @@ -1120,7 +1124,7 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
>   		__dpll_pin_unregister(ref->dpll, pin, ops, priv, parent);
>   	}
>   	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   }
>   EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
>   
> @@ -1141,13 +1145,13 @@ int dpll_pin_ref_sync_pair_add(struct dpll_pin *pin,
>   {
>   	int ret;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	ret = xa_insert(&pin->ref_sync_pins, ref_sync_pin->id,
>   			ref_sync_pin, GFP_KERNEL);
>   	mutex_lock(&pin->domain->lock);
>   	__dpll_pin_change_ntf(pin);
>   	mutex_unlock(&pin->domain->lock);
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   
>   	return ret;
>   }
> @@ -1254,23 +1258,12 @@ const struct dpll_pin_ops *dpll_pin_ops(struct dpll_pin_ref *ref)
>   
>   static int __init dpll_init(void)
>   {
> -	int ret;
> -
> -	ret = genl_register_family(&dpll_nl_family);
> -	if (ret)
> -		goto error;
> -
> -	return 0;
> -
> -error:
> -	mutex_destroy(&dpll_lock);
> -	return ret;
> +	return genl_register_family(&dpll_nl_family);
>   }
>   
>   static void __exit dpll_exit(void)
>   {
>   	genl_unregister_family(&dpll_nl_family);
> -	mutex_destroy(&dpll_lock);
>   }
>   
>   subsys_initcall(dpll_init);
> diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
> index 630c5a1ca572c2..e212e53528e33b 100644
> --- a/drivers/dpll/dpll_core.h
> +++ b/drivers/dpll/dpll_core.h
> @@ -12,6 +12,7 @@
>   #include <linux/mutex.h>
>   #include <linux/refcount.h>
>   #include <linux/ref_tracker.h>
> +#include <linux/rwsem.h>
>   #include "dpll_nl.h"
>   
>   #define DPLL_REGISTERED		XA_MARK_1
> @@ -129,7 +130,7 @@ const struct dpll_pin_ops *dpll_pin_ops(struct dpll_pin_ref *ref);
>   struct dpll_pin_ref *dpll_xa_ref_dpll_first(struct xarray *xa_refs);
>   extern struct xarray dpll_device_xa;
>   extern struct xarray dpll_pin_xa;
> -extern struct mutex dpll_lock;
> +extern struct rw_semaphore dpll_lock;
>   
>   void dpll_device_notify(struct dpll_device *dpll, unsigned long action);
>   void dpll_pin_notify(struct dpll_pin *pin, u64 src_clock_id,
> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> index 1b4e3a0166a744..9d8f5d1ce97248 100644
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c
> @@ -910,11 +910,11 @@ int dpll_device_change_ntf(struct dpll_device *dpll)
>   {
>   	int ret;
>   
> -	mutex_lock(&dpll_lock);
> +	down_read(&dpll_lock);
>   	mutex_lock(&dpll->domain->lock);
>   	ret = __dpll_device_change_ntf(dpll);
>   	mutex_unlock(&dpll->domain->lock);
> -	mutex_unlock(&dpll_lock);
> +	up_read(&dpll_lock);
>   
>   	return ret;
>   }
> @@ -1004,11 +1004,11 @@ int dpll_pin_change_ntf(struct dpll_pin *pin)
>   {
>   	int ret;
>   
> -	mutex_lock(&dpll_lock);
> +	down_read(&dpll_lock);
>   	mutex_lock(&pin->domain->lock);
>   	ret = __dpll_pin_change_ntf(pin);
>   	mutex_unlock(&pin->domain->lock);
> -	mutex_unlock(&dpll_lock);
> +	up_read(&dpll_lock);
>   
>   	return ret;
>   }
> @@ -1795,7 +1795,7 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   	unsigned long i;
>   	int ret = 0;
>   
> -	mutex_lock(&dpll_lock);
> +	down_read(&dpll_lock);
>   	xa_for_each_marked_start(&dpll_pin_xa, i, pin, DPLL_REGISTERED,
>   				 ctx->idx) {
>   		if (!dpll_pin_available(pin))
> @@ -1821,7 +1821,7 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   		}
>   		genlmsg_end(skb, hdr);
>   	}
> -	mutex_unlock(&dpll_lock);
> +	up_read(&dpll_lock);
>   
>   	if (ret == -EMSGSIZE) {
>   		ctx->idx = i;
> @@ -2019,7 +2019,7 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   	unsigned long i;
>   	int ret = 0;
>   
> -	mutex_lock(&dpll_lock);
> +	down_read(&dpll_lock);
>   	xa_for_each_marked_start(&dpll_device_xa, i, dpll, DPLL_REGISTERED,
>   				 ctx->idx) {
>   		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
> @@ -2038,7 +2038,7 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   		}
>   		genlmsg_end(skb, hdr);
>   	}
> -	mutex_unlock(&dpll_lock);
> +	up_read(&dpll_lock);
>   
>   	if (ret == -EMSGSIZE) {
>   		ctx->idx = i;
> @@ -2056,7 +2056,7 @@ int dpll_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   	if (GENL_REQ_ATTR_CHECK(info, DPLL_A_ID))
>   		return -EINVAL;
>   
> -	mutex_lock(&dpll_lock);
> +	down_read(&dpll_lock);
>   	id = nla_get_u32(info->attrs[DPLL_A_ID]);
>   	dpll = dpll_device_get_by_id(id);
>   	if (!dpll) {
> @@ -2067,7 +2067,7 @@ int dpll_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   	mutex_lock(&dpll->domain->lock);
>   	return 0;
>   unlock:
> -	mutex_unlock(&dpll_lock);
> +	up_read(&dpll_lock);
>   	return -ENODEV;
>   }
>   
> @@ -2077,14 +2077,14 @@ void dpll_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   	struct dpll_device *dpll = info->user_ptr[0];
>   
>   	mutex_unlock(&dpll->domain->lock);
> -	mutex_unlock(&dpll_lock);
> +	up_read(&dpll_lock);
>   }
>   
>   int
>   dpll_lock_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   	       struct genl_info *info)
>   {
> -	mutex_lock(&dpll_lock);
> +	down_read(&dpll_lock);
>   
>   	return 0;
>   }
> @@ -2093,7 +2093,7 @@ void
>   dpll_unlock_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   		 struct genl_info *info)
>   {
> -	mutex_unlock(&dpll_lock);
> +	up_read(&dpll_lock);
>   }
>   
>   int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
> @@ -2102,7 +2102,7 @@ int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   	struct dpll_pin *pin;
>   	int ret;
>   
> -	mutex_lock(&dpll_lock);
> +	down_read(&dpll_lock);
>   	if (GENL_REQ_ATTR_CHECK(info, DPLL_A_PIN_ID)) {
>   		ret = -EINVAL;
>   		goto unlock_dev;
> @@ -2119,7 +2119,7 @@ int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   	return 0;
>   
>   unlock_dev:
> -	mutex_unlock(&dpll_lock);
> +	up_read(&dpll_lock);
>   	return ret;
>   }
>   
> @@ -2129,5 +2129,5 @@ void dpll_pin_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   	struct dpll_pin *pin = info->user_ptr[0];
>   
>   	mutex_unlock(&pin->domain->lock);
> -	mutex_unlock(&dpll_lock);
> +	up_read(&dpll_lock);
>   }

Reviewed-by: Petr Oros <poros@redhat.com>

