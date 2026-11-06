Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961704;
	b=mY+DYaSmzn+yotqJVRKraECfeAWiPLk7ccYXnmdLKOnbsCyQbiBoI88Q1t1WwqfHFntq
	 Ms1dGhvO1L41/K0pgWQgT4LqZUDm0a6hil6fiHzBqennvEgW7Pd9j5RmIFnWoxz43r+ES
	 qlyJzGWkRAIagHZmV6XH25IoQQcsKwSYFYL9sGLX0ZIV54Vq5KKgP47izRg6KS0UpUSr4
	 iuthESpLBVC9JDp08AbbeMxJI6RoKJttoq4gyD2fzHEk8Augmf6UzeLsL+exLCTG5yBuO
	 LEmvkV/Ef7Yfdk12xKVoAFYfcPeyprCRNYiGU74XZS0CgX72B0Pyf+SVPzIpOCOOlbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961704;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=48kbfMmF1DBLzILk4zDW1A3oIaLkRb6C5LUr4+SlxNY=;
	b=DnQ0ppjIk2z30WApqEZ5nJedZ76QeJlZeqnvjzUMvv+ttFaEj2fr4EeF8NYjP1cbVTGo
	 nZ8Z4u8JDNMTqJtcWuTUTivedU4EsKuqqMD8hX834ygTo6+B5Jskldlpm+PbyS7KstHR/
	 yzCAIjpy6j0R40V1ejNWG1Rjhw9CDtRDo24pn/8NLDBa3AZl6t0XnFbQTVO5ofedrwlAE
	 oGulfYvyYYKOzZZ5rX/aOJLjDu0bPyCEsm9c8JlRLGCjXz6KbdCWvz9CKS4kjdBKLqWAQ
	 xPdPzUoE0EMOIHYaWxH5EieyOrEKcgaGsqbLnSjPDPn+JuyxeW/0t5bwBPWnzEXyN4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HoP8hkVd;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F77606A32C
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 10:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67F77606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HoP8hkVd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793961702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48kbfMmF1DBLzILk4zDW1A3oIaLkRb6C5LUr4+SlxNY=;
	b=HoP8hkVdMAscFTF76L4nxr5LcmUtuSo93JQbNMkJc4Des1zejCMwXoRoEhL+HnR7b5OIaQ
	Yu8atS92clAAZRQFIl9dS51SZgEnx4mnEUUrl8wVU6E8Ysnwkxo0UjzYT7a7rddFjL1Swf
	jew52CSJlBl0RGJVUtwpM2nWKSRuI8s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-VPPX5bDRP_KLO3nismGbdA-1; Fri,
 06 Nov 2026 05:41:39 -0500
X-MC-Unique: VPPX5bDRP_KLO3nismGbdA-1
X-Mimecast-MFC-AGG-ID: VPPX5bDRP_KLO3nismGbdA_1793961697
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4232E1955F3C;
	Fri,  6 Nov 2026 10:41:36 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B6BA30000E3;
	Fri,  6 Nov 2026 10:41:31 +0000 (UTC)
Message-ID: <588acb18-7a42-4c92-9898-46ee4160e1a2@redhat.com>
Date: Fri, 6 Nov 2026 11:41:29 +0100
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
Subject: Re: [PATCH net-next v2 05/14] dpll: dpllsim: Add support to set input
 pin state
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Jani Nikula <jani.nikula@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20261105151852.1844305-1-poros@redhat.com>
 <20261105151852.1844305-6-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261105151852.1844305-6-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/5/26 16:18, Petr Oros wrote:
> Add support for setting the state of input pins on the device.
> Implement the state_on_dpll_set callback for input pins and advertise
> the state-can-change capability for them, so that userspace can move a
> pin between connected, disconnected and selectable. The driver stores
> the requested state and reports it back unchanged, it does not act on it
> yet. Output pins keep reporting their state only.
> 
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   drivers/dpll/dpllsim/dpll.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/dpll/dpllsim/dpll.c b/drivers/dpll/dpllsim/dpll.c
> index a1d5921fb8d017..2b0c053a7b6087 100644
> --- a/drivers/dpll/dpllsim/dpll.c
> +++ b/drivers/dpll/dpllsim/dpll.c
> @@ -104,10 +104,23 @@ static int dpllsim_pin_state_get(const struct dpll_pin *pin, void *pin_priv,
>   	return 0;
>   }
>   
> +static int dpllsim_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
> +				 const struct dpll_device *dpll,
> +				 void *dpll_priv, enum dpll_pin_state state,
> +				 struct netlink_ext_ack *extack)
> +{
> +	struct dpllsim_pin *sim_pin = pin_priv;
> +
> +	guard(mutex)(&sim_pin->dev->lock);
> +	sim_pin->state = state;
> +	return 0;
> +}

Should DPLL_PIN_STATE_CONNECTED be accepted here?

The device always reports automatic mode, which dpllsim_make_group() sets
and nothing changes:

	sim->mode = DPLL_MODE_AUTOMATIC;

Documentation/driver-api/dpll.rst limits what a user can request in that
mode:

     In automatic mode (``DPLL_MODE_AUTOMATIC``) the user can request one of
     following pin states:

     - ``DPLL_PIN_STATE_SELECTABLE`` - the pin shall be considered as valid
       input for automatic selection algorithm
     - ``DPLL_PIN_STATE_DISCONNECTED`` - the pin shall be not considered as
       a valid input for automatic selection algorithm

     Pins that have the ``DPLL_PIN_CAPABILITIES_STATE_CONNECTED_OVERRIDE``
     capability can additionally be set to ``DPLL_PIN_STATE_CONNECTED`` in
     automatic mode, overriding the active input selection.

dpll_pin_state_set() in the core only checks state-can-change, so the
driver has to refuse the state. zl3073x does that for its automatic mode
in zl3073x_dpll_input_pin_state_on_dpll_set():

	case ZL_DPLL_MODE_REFSEL_MODE_AUTO:
		if (state == DPLL_PIN_STATE_SELECTABLE) {
			...
		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
			...
		} else {
			goto invalid_state;
		}

[ ... ]
> @@ -149,6 +162,12 @@ static void dpllsim_pin_props(struct dpllsim_pin *pin,
>   		prop->freq_supported_num = ARRAY_SIZE(dpllsim_freq_ext);
>   		break;
>   	}
> +
> +	/* Capabilities follow the ops the pin is served by */
> +	if (dpllsim_pin_select_ops(pin) == &dpllsim_input_pin_ops)
> +		prop->capabilities = DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
> +	else
> +		prop->capabilities = 0;
>   }
The input pins advertise state-can-change only. If connected is meant to
be settable on this automatic-only device, should
DPLL_PIN_CAPABILITIES_STATE_CONNECTED_OVERRIDE be advertised here as well?

If not, should dpllsim_pin_state_set() return -EINVAL with an extack
message for it?

The commit message says "so that userspace can move a pin between
connected, disconnected and selectable", and the stress test added by the
next patch, 70a4dcf52b9c ("selftests: dpll: add pin state tests"), relies
on it. test_pin_state_flooding() cycles through

	local states=(connected disconnected selectable)

and fails when one of the sets is refused.

Thanks,
Ivan

