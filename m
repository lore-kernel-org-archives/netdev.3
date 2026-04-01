Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78E136922D;
	Wed,  1 Apr 2026 03:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013003; cv=none; b=pj0MTNZYEtAsc4iXGV1OZrZbisogdyL/z4do4gYkOk9kMZpVBRrNKZqmknKafaro3w8cQb4VOFdRUske+SnAMFw9quhcsIqmDM/feWm6CWTQfDD+3h7j0QR3slI01ohSA/MJSIeYnnJehe8jgkpBFF06STU/VRJ/7XETdnuiF7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013003; c=relaxed/simple;
	bh=OyeynUEfAgebILL4WR7IM+O9Fq6ddhT77LU+vrXkLlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XX22TA9qKezPGt1OlNtIABqeB4AjXVIQAbWsLFmv5N6wfk5d0VCUQXwTn9oUUvb065JDLkLM/DZvB6v60wwFYJVEuncH+2HbeSvhhhzZhHhPWFSrqP/h4Nq9h8OQ7JVqSrneph67o6oWYqvsk8r/OeBmKaIc8pc/N9vityZXqPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOPlYLoe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOPlYLoe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858F0C19423;
	Wed,  1 Apr 2026 03:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775013003;
	bh=OyeynUEfAgebILL4WR7IM+O9Fq6ddhT77LU+vrXkLlE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qOPlYLoex5kE9sewUeYgGgedPUX9pKmmyWlXel6FLJOlE7HmksSSK66xEyAtoCRiE
	 oSyxqwncYlsvJw/UoKMj2UfiP32OdMdJciEEiz9akxhFoM9GkvoLA3Ht+HAKQV0add
	 pq+OlhQzFnRX6x0U256cU9EE/NDPTUepKSdm3crd4yBmHuqbfa6UJ7qJIqr09u9f2f
	 k3qCEQXX/iQHxDPI4TSiDSLH0liRFVYAnsRL7J5dN0Z/nblWoOzzPjP2HM082iqeU1
	 4zklZC2whdZQYA5ekMi4yI9oVF1rdv+hdEYtAyJMIMf4aRyr0t99xugOuW3Ru2n4Dq
	 KXJyASNK/+70Q==
Date: Tue, 31 Mar 2026 20:10:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, Petr Oros
 <poros@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] dpll: add frequency monitoring callback
 ops
Message-ID: <20260331201001.03339bab@kernel.org>
In-Reply-To: <20260330105505.715099-3-ivecera@redhat.com>
References: <20260330105505.715099-1-ivecera@redhat.com>
	<20260330105505.715099-3-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 12:55:04 +0200 Ivan Vecera wrote:
> +dpll_msg_add_freq_monitor(struct sk_buff *msg, struct dpll_device *dpll,

> +	if (ops->freq_monitor_set && ops->freq_monitor_get) {
> +		ret = ops->freq_monitor_get(dpll, dpll_priv(dpll),
> +					    &state, extack);
> +		if (ret)
> +			return ret;
> +		if (nla_put_u32(msg, DPLL_A_FREQUENCY_MONITOR, state))
> +			return -EMSGSIZE;
> +	}
> +
> +	return 0;
> +}
> +
>  static int
>  dpll_msg_add_phase_offset_avg_factor(struct sk_buff *msg,
>  				     struct dpll_device *dpll,
> @@ -400,6 +420,38 @@ static int dpll_msg_add_ffo(struct sk_buff *msg, struct dpll_pin *pin,
>  			    ffo);
>  }
>  
> +static int dpll_msg_add_measured_freq(struct sk_buff *msg, struct dpll_pin *pin,
> +				      struct dpll_pin_ref *ref,
> +				    struct netlink_ext_ack *extack)
> +{
> +	const struct dpll_device_ops *dev_ops = dpll_device_ops(ref->dpll);
> +	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
> +	struct dpll_device *dpll = ref->dpll;
> +	enum dpll_feature_state state;
> +	u64 measured_freq;
> +	int ret;
> +
> +	if (!ops->measured_freq_get)
> +		return 0;
> +	if (dev_ops->freq_monitor_get) {

what are you trying to cater to by making freq_monitor_get optional
here? I thought maybe some devices would have it always enabled, but
then dpll_msg_add_freq_monitor() should presumably report enabled
if !freq_monitor_get && measured_freq_get ?

Maybe there's some precedent in surrounding code outside of the context
but the intention of the patch reads a bit off.

> +		ret = dev_ops->freq_monitor_get(dpll, dpll_priv(dpll),
> +						&state, extack);
> +		if (ret)
> +			return ret;
> +		if (state == DPLL_FEATURE_STATE_DISABLE)
> +			return 0;
> +	}
> +	ret = ops->measured_freq_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
> +				   dpll, dpll_priv(dpll), &measured_freq, extack);
