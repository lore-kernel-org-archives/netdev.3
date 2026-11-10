Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313549;
	b=v9uCAI3ndEi060w1LvG31iXvBkDriPvhA1bHkNKt9GndPPILLLVWjsgTmlBKfcqZFN4v
	 YJv5S0JOesgoOb5ndWaSGXLZZo1Y4IAaAl24Ll3oKJzSOhVEsJNOv76qTwSvkCCQ94Hg0
	 FjI1/SEwGYr6gdpDBjByoVaEGkTksS4zCpm+j8pBO/ufiWiff5D5Z/biSMMLUIL3kIZ56
	 oa5tF4A4OkPIxZp+Qm5W/6us0icaPv/VQxjVPmLTNLYVxSUKv98fyGtBbpn7ePVi7zrgU
	 9iOk30OKdXocEaxlx3utBds9Ig1mRtHBOpgyjHyKvTfO4VARHUrjzh2Y54WJQ6csBDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313549;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=2z9Dq46PGzc1DYcTmA3bznslu78oudIXu01vR14qyUQ=;
	b=myiR14+vkCjihrBBRFfgzJ20kju9ijVk7m+d2DqpJkl9tbvKKRdYtTLOgFNyQbJkkcfl
	 xC0gQgbbs/1UAupUw8adXaN/tUs+6Yu/bcN+8fy1y3u7IQ88IKd860gUjBrXOvHgMWQd5
	 XXSDlIA647wAits8KIqJpdEujy8WZT2+8vuV9IaIhtstDD64y+/uNZO0two5bkgGbv0TS
	 A0gmbXbRJHtuBBhXGlyTPcs0Uu5QFAJbjrrec4nBgXA9fzqZ0A2iLBI4ZTfF3ZCirXN3R
	 VAPrAga4PTQ8QZMFs62sglEMjLCWXUhTqLFS7Lutg16b/fn6I1eMMXaEliNv/YK3+Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hIBLyuSZ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AfeKsHM6;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5590F606A337
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 12:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5590F606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hIBLyuSZ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AfeKsHM6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794313548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2z9Dq46PGzc1DYcTmA3bznslu78oudIXu01vR14qyUQ=;
	b=hIBLyuSZmBPf+Pv0AGd16NxIq9NSp5f9bxJSyqqxB7dF5aqZvBOI7MyQ0LugBpBe7KQdrE
	KtBWoeRukKyIMEdFYMCzUL3S4EeeQgSYh6Snr56D2XTjZLSPyVChQ4RfYKZyFNAclX9+5x
	Z5peaTxvr4U5iv0DXtohphJhUBq21i0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-J-C-lUMOMAK8qAmgNe97bg-1; Tue, 10 Nov 2026 07:25:46 -0500
X-MC-Unique: J-C-lUMOMAK8qAmgNe97bg-1
X-Mimecast-MFC-AGG-ID: J-C-lUMOMAK8qAmgNe97bg_1794313546
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48fbcf023dcso1189841f8f.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794313545; x=1794918345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2z9Dq46PGzc1DYcTmA3bznslu78oudIXu01vR14qyUQ=;
        b=AfeKsHM6C8MWJB45WMqPOmdAOipH1qlYxyu7+E3KKQXo8Wm7dSwjUfdntfy8cvUDaS
         bYIHd1LV6S2glpKy8TpYZJmUOfyHCv/HCfDc/RocUXtyTP91ZRqaAEVZuXBose98x8cD
         LCywM8hz0dOjX4qQJv3Lur07xIkvxMSzFNq+sBPS0645NZ4jSdQyu6UhqerhZFf9vUKo
         lV75BZjMvtX0se34MTeSbmeEmqODKkHAbsS4Hywwo+S2PmU6MqekKqn4yYbaJOEvCGqG
         7wk4Ee79ez8h+oaUfRuejOftkwdBtBBDb5TCkqoLXUVt3Y7m9D6UWpItVSG40LKWn3Yq
         EByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794313545; x=1794918345;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2z9Dq46PGzc1DYcTmA3bznslu78oudIXu01vR14qyUQ=;
        b=lza/CmDg2NTh9zPJcUdaBt26cEh6sQG8qGOSBtncM5DEmb9Q8VINVLJeMr839TPc8i
         fLR7Y52ATgKhwJTTJlu013EoZqNrKrMcj02/ln8UWbsklQO6FOT8t8TOTyqgoNh1VTBX
         aO1kWle047dihVe9uNl26XsvrWwncRAf4wCuGh2/RlF9wfrkbsgtEoWQU9941fccAqMN
         JMo2RGK+0+UwHKlwiIohAoKG64yIxDTZXmLiQU0QH/QmPt5lkeDGdKBVJJDVo51DDRui
         ELG//j6a7U0LlS8hHmPiDCG63xgKS+Uw8w19EFehrD+VYNmRWkCPsAcnmezDLyzoGjwW
         qF8Q==
X-Forwarded-Encrypted: i=1; AL+hErGPJI0uirQRYP+Hr6lEVGIMxyFXnlSuccztJtktNrSxaOU3yFxZP20RU5hFaBbQBN46ZdCZ2bY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VuIsiuLWKScsJahJBKHmx0bIH/Ogp/JXc46sdJNbLUU5dhrph
	jnkIr0xvcfRR97u6KI8Vv6N+INeGgkrhn3yun3RAZFpHMa1zg30S4KmpOyV8mQTmANi65oQj+eD
	2Uof8vE0GjSt006X/oVQWrksQkapJkWe2JHM7Qk5nfo7QxZKt7bALI2dqyg==
X-Gm-Gg: AYBFou24BmnyCyxL3OHzcbwxhGx48pvy5CSr7I3jdjtKmZyF9tC7Gfv96vni4sBCXJ0
	Z+NdBmA66ahN9WyvJSQY4TQfaYobmatKBQbHIUA2sMmi5yztSJGEUaGn2XiNA9/gPAxGYLr01z7
	H3jfPPQOib2D5lKNhwJ0MjU2Dyb8ti1wPrnO7JKoMSwYM7hT4FaLPNNZjTtDyG5QRnsWSBw/Poz
	twTbGZ/pdoPsHN4om8OMFY4bkknS/cbQufu+812XJ9ajTkTqsPpN8wV2iK3nbLkSKFhjbm2JT2D
	P9SfIZtfazmfCKcvK9zw+n+OvtAIINQH9bAyGfvoi+FvgGPwip+BRTROdVQWkk4KPNd0520GjCz
	7vfn634Y8gzal/L4FsC4kZIIqM8j9TFhOCkk=
X-Received: by 2002:a05:6000:29d2:b0:498:88f:14c8 with SMTP id ffacd0b85a97d-4982fb52546mr2653556f8f.9.1794313545486;
        Tue, 10 Nov 2026 04:25:45 -0800 (PST)
X-Received: by 2002:a05:6000:29d2:b0:498:88f:14c8 with SMTP id ffacd0b85a97d-4982fb52546mr2653511f8f.9.1794313545005;
        Tue, 10 Nov 2026 04:25:45 -0800 (PST)
Received: from [10.43.3.161] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4989a2a505asm3264342f8f.13.2026.11.10.04.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 04:25:43 -0800 (PST)
Message-ID: <f73146cb-fcbb-4263-90d9-b5378faf30f7@redhat.com>
Date: Tue, 10 Nov 2026 13:25:41 +0100
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
Subject: Re: [PATCH net-next 10/10] dpll: document locking rules
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
 <20261106121005.1327603-11-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261106121005.1327603-11-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/6/26 1:10 PM, Ivan Vecera wrote:
> Describe the lock levels of the subsystem, which domain a callback runs
> under and the rules device drivers have to follow.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   Documentation/driver-api/dpll.rst | 44 +++++++++++++++++++++++++++++++
>   drivers/dpll/dpll_core.c          |  9 +++++++
>   2 files changed, 53 insertions(+)
> 
> diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
> index 7c117ae37cc1bc..40d5037ff3bb0f 100644
> --- a/Documentation/driver-api/dpll.rst
> +++ b/Documentation/driver-api/dpll.rst
> @@ -675,6 +675,50 @@ In the error path we have to rewind every allocation in the reverse order:
>   
>   More complex example can be found in Intel's ICE driver or nVidia's mlx5 driver.
>   
> +Locking
> +=======
> +
> +The subsystem uses two levels of locks, always taken in this order:
> +
> +- ``dpll_lock`` protects the topology of dpll devices and pins and their
> +  lifetime. Functions changing the topology, for example dpll_pin_register(),
> +  take it for write and send the create and delete notifications under it.
> +  Netlink requests, each part of a dump and change notifications take it for
> +  read for their whole duration.
> +- A domain lock serializes driver callbacks. All dpll devices and pins created
> +  with the same module and ``clock_id`` belong to one domain, in practice to
> +  one chip or card.
> +
> +A netlink request addressing a device or a pin by its ID holds the domain lock
> +of that object from start to end. A notification holds it while its message is
> +built and sent, so messages of one object are sent in the order they were
> +built. Only one domain lock is held at a time, so domains have no lock order,
> +and callbacks of different domains can run concurrently.
> +
> +Callbacks of a dpll device run under the domain of the device. Callbacks of a
> +pin run under the domain of the pin, whichever driver registered them:
> +
> +- A driver registering a pin of another driver with its dpll device has these
> +  callbacks serialized with the driver that created the pin, not with the other
> +  callbacks of its device, so it has to protect the state they share by itself.
> +  A callback stuck in such a registration stops the domain of the pin.
> +- The parent pin of a pin registered with dpll_pin_on_pin_register() and its
> +  dpll devices can belong to another driver, so the callback must not
> +  dereference their private data.
> +- The frequency monitor belongs to the dpll device, so only callbacks of a pin
> +  of the same domain registered with dpll_pin_register() can include
> +  ``.measured_freq_get``.
> +
> +Device drivers have to follow these rules:
> +
> +- A callback must not call dpll_device_change_ntf(), dpll_pin_change_ntf() or
> +  any function changing the topology.
> +- A callback notifies about objects of the domain it runs under with
> +  __dpll_device_change_ntf() or __dpll_pin_change_ntf(). Other objects have to
> +  be notified from a context that holds no domain lock, for example a work item.
> +- A driver must not call dpll_device_change_ntf(), dpll_pin_change_ntf() or any
> +  function changing the topology while holding a lock that its callbacks take.
> +
>   SyncE enablement
>   ================
>   For SyncE enablement it is required to allow control over dpll device
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index 84377f8ba16036..6ad40fb9eee855 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -932,6 +932,10 @@ __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
>    * @ops: ops for a dpll pin ops
>    * @priv: pointer to private information of owner
>    *
> + * The callbacks run under the domain of @pin. If @pin belongs to another domain
> + * than @dpll, they are not serialized with the callbacks of @dpll and @ops must
> + * not include .measured_freq_get.
> + *
>    * Context: Acquires dpll_lock and domain locks
>    * Return:
>    * * 0 on success
> @@ -1049,6 +1053,11 @@ EXPORT_SYMBOL_GPL(dpll_pin_unregister);
>    * Register a pin with a parent pin, create references between them and
>    * between newly registered pin and dplls connected with a parent pin.
>    *
> + * The callbacks run under the domain of @pin. The parent pin and its dplls can
> + * belong to another driver, so @ops must not dereference their private data.
> + * The frequency monitor belongs to a dpll, so @ops must not include
> + * .measured_freq_get.
> + *
>    * Context: Acquires dpll_lock and domain locks
>    * Return:
>    * * 0 on success
Reviewed-by: Petr Oros <poros@redhat.com>

