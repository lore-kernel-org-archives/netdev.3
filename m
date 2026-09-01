Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFC63ACF1D
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 03:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231761; cv=none; b=BQp053Ql1VBRn/VwUEIBQHKURgmIIROSaXIWOtzT7+e1peefgNGkcdFhurH7av0OerOmLcJRsMkDGbDm1jzdu+0EFj1PNoTHgQwPG22ih9YbN4IQp9Apcw9SYfQeHxuQWVS99mQz1ZzZ7CJDbc0+q4MG5KVpaNz6fbUAf/RklIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231761; c=relaxed/simple;
	bh=ArDpOCf+E4mBR0SMtxM4WSiZdRIZqs2ntZuYIW7YmhY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZNk/V/6vvTaDv9J19kA9DlGB0CL6nsRRHyHRAFlojIwbVOYjJX/2/AaHOqtdnPyDjpjf6fvHutH02H9mvaJlavnhnlCjytp4OJKmdpbQAIwjWBGdcVL0XdX+aVo0cXRITYRYVH5dngRMSNlrytcr4No5rClCxOCbYv0hdftB7QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPt176SL; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPt176SL"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81f36179d72so49596637b3.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 20:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788231755; x=1788836555; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=14D0j1GkvdeJVIp3hOiK/Hee6MT34LdqRKsw7jOuS3I=;
        b=TPt176SLTC77jv5zekiQv95LAx73uUBUgiBVtFPXAX0Ka9jPUGoSgFMcWgAN+bz0sr
         IiY9LEeZ0FRXYTAj9x1QL0JmbH5bw/xJaejMcr6SSKcp5iC2R1BrLchi3E82LV8YqOLb
         GJ9W6IwYn+LY/tvQChhxdNoCU67Ia2zkqyQ0aTU6gRkj44nOKMidVVNxHmh9XsYzobWp
         0/Qy/v3L0ZQ8LI0M0bCokZDT/19+pCTaMAK7khJ2+Y5btPuqA1ZcDVF8+SqGBmNRAx+l
         j2iq2pPostruWM/tirZYOHGd4oimKGcOwprLyU4eLdlXBroMrYtQxzaXkoWJoZIy6bQk
         Y1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788231755; x=1788836555;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=14D0j1GkvdeJVIp3hOiK/Hee6MT34LdqRKsw7jOuS3I=;
        b=FIEhOCahhYntcM0VxAVuPNuIQmmo+YqDPuZ+3VJInbVRDV+ddtfntrvdu1oL4ibncc
         Yby5cB21LxnJfmYTxiXT+qiTgh/GTQMWSqRtVWbYxa8bOEzLUzLYH/v3kuUJ0z10VDXc
         DJ5t/QeyaZzUQ/yu10+fUGG/tgnWqFS3NNV4QzJLq00kNGYw+i1f/l506bTgtvvlMmrT
         WpH+sPLH2V2ObPiLc4k74r0/l1NN7whXyh3RDDHR94ING3H2yAC/CCrqVnZ9Qu8AdMdv
         ACwrbaj3mrDsbEgJw7CZstgWhLX/kwHgSikEwm/1ovtX5CtBHZHHBgv35FacRozTb6R6
         w1qw==
X-Forwarded-Encrypted: i=1; AKwUvBzcLMAsT7Bm2Dhjg8dI/9vL4dZEBt+lE3Ya0E/Oth3zLEqfxflLLExbbViSMua9WU+19owUEMA=@vger.kernel.org
X-Gm-Message-State: AFuF++l+5fes1Ou5o68+3PgiE76CLwdGLJ82WKqCKqnCiAj9AwlnBAlc
	1i5UccysbLBPz9Wjhr5QOw0WzOpOqWLKA0EE29Gqe8gSReQxkjssq9Lu
X-Gm-Gg: AYBFou2hpTzYvgcT99+K8ansbLqluKE05Qdhz07LSr306zP76yG4euJ+ZXgGXOzZhEa
	lJi6V5MESGwrdOcCrNF9oWq9Lad3NFuemN9MBLOtZWoLYdGB2vuAwRvdsMxbWXpukR95/CKYDXf
	2tG0pI7fBV5rLBGUgtA89+tRtMTEOz9b6aHsUWbOx++munisn8m5S/tBtXH1/cBgnCM98ywedCv
	jl2GhMqsWjw92QKewfmzGfnQS27pFIUeO3lFIWN7+LvXVoYp6ugXjgkWWvjFdspOGW43tij+SzZ
	aXCPyYtyVKvoShYILq9Lb+b5ovlPlkFKR26fv9Vs8WgQlxDrGKIj/XhQLHMh0qo3Eq3zTpJPNdM
	MFMJe0NkkzODjMZomyXAv4qvTjvKKHrkMjreZ1M42eWs5xXwIxp0TtF6p5KGC125zAbWiJ/SlB+
	cVfOCQ3vpPLFTBVbAuxlId0QEg2/J4D1Nuwk0Lr73O6FOCCpnYp5B7pwRFfq3rdXFakX97fuSpo
	AuikzhiCunlKO2O6AO8O5EFW0sPKWQwg7nXe0Llkuwu4vQMyyEl
X-Received: by 2002:a05:690c:c4fa:b0:81e:eebb:8e4a with SMTP id 00721157ae682-85d684bed50mr109638597b3.12.1788231755320;
        Mon, 31 Aug 2026 20:02:35 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e68ae126bsm67293157b3.9.2026.08.31.20.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 20:02:34 -0700 (PDT)
Date: Mon, 31 Aug 2026 23:02:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 Willem de Bruijn <willemb@google.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Joshua A Hay <joshua.a.hay@intel.com>
Message-ID: <willemdebruijn.kernel.8de9480d62e6@gmail.com>
In-Reply-To: <20260831213221.1370774-4-willemdebruijn.kernel@gmail.com>
References: <20260831213221.1370774-1-willemdebruijn.kernel@gmail.com>
 <20260831213221.1370774-4-willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v7 3/6] idpf: support pacing offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> If skb->tstamp is in the future, program this future delivery txtime
> in the transmit descriptor.
> 
> TCP pacing offload is only offloaded if SK_PACING_FQ is negotiated and
> the FQ offload_horizon is configured. But device support for pacing
> offload must be more robust: it can also be reached through SO_TXTIME.
> 
> Bounds check txtime. Only packets with timestamp between now and the
> horizon (pacing_offload_horizon) are offloaded.
> 
> Negotiate the feature with the device using virtchnl. Support is
> conditional on
> - splitq mode, where tx and tx completion queues are separate, so
>   completions can be returned out of order.
> - flow scheduling mode, where completions can arrive out of order.
> - PTP to ensure the NIC clock is synced to CLOCK_TAI.
> 
> These features are negotiated per adapter, but expect all vports to
> uniformly request splitq (req_[rt]x_splitq) and flow scheduling
> (flow_sch_en) when available.
> 
> Do not explicitly check all preconditions. Trust the firmware to
> only advertise EDT when all are met. In general, firmware response is
> trusted to be correct. If not, EDT would be the least of the worries.
> In particular, granularity is trusted to be a power of two. And
> time_horizon_ns is a range expressible given the chosen granularity.
> 
> Packets beyond the horizon are sent immediately with the overflow bit
> set.
> 
> On device reset, dev->pacing_offload_horizon, fq offload_horizon and
> granularity are not re-negotiated. It is safe to assume that firmware
> does not change these EDT capabilities across resets.
> 
> Must not be called from netpoll due to ktime_get. But netpoll does not
> generate packets with EDT, so no explicit test is needed.
> 
> Do not fail device initialization on EDT init error. Log an error, but
> continue without EDT, similar to PTP.
> 
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Joshua A Hay <joshua.a.hay@intel.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> ---
> 
> Changes
>   v6 -> v7
>     - rebase onto libie changes: adjust idpf_send_get_edt_caps_msg
>     - only set horizon if splitq with flow scheduling
>     - fail on illegal granularity 0, rather than use hardcoded default
>     - zero edt_caps on negotation error, in case of call after reset
>     - cache ts_gran_pow2 in idpf_tx_queue to be in hot cache line
>     - similar to FQ, add offload slack to avoid pacing < 400ns of now
>     - remove now superfluous include netpoll.h
>     - reverse xmas tree (1x)

> +static void idpf_tx_splitq_set_txtime(const struct sk_buff *skb,
> +				      const struct idpf_tx_queue *tx_q,
> +				      struct idpf_tx_splitq_params *tx_params)
> +{
> +	const int offload_slack_ns = 400;
> +	struct idpf_netdev_priv *np = netdev_priv(skb->dev);

Unused variable after latest refactor. Will remove.

No longer needed after introducing tx_q->ts_gran_pow2.

> +	u64 ts, now, horizon;
> +
> +	horizon = READ_ONCE(skb->dev->pacing_offload_horizon);
> +	if (!horizon)
> +		return;
> +
> +	switch (skb->tstamp_type) {
> +	case SKB_CLOCK_REALTIME:
> +		ts = ktime_to_ns(ktime_add(skb->tstamp,
> +					   ktime_mono_to_any(0, TK_OFFS_TAI) -
> +					   ktime_mono_to_any(0, TK_OFFS_REAL)));
> +		break;
> +	case SKB_CLOCK_MONOTONIC:
> +		ts = ktime_to_ns(ktime_mono_to_any(skb->tstamp, TK_OFFS_TAI));
> +		break;
> +	case SKB_CLOCK_TAI:
> +		ts = ktime_to_ns(skb->tstamp);
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return;
> +	}
> +
> +	now = ktime_get_clocktai_ns();
> +	if (ts < now + offload_slack_ns)
> +		return;
> +
> +	/* beyond offload horizon? set overflow bit only */
> +	if (ts > now + horizon) {
> +		tx_params->offload.desc_ts[2] =
> +			IDPF_TXD_FLOW_SCH_HORIZON_OVERFLOW_M;
> +		return;
> +	}
> +
> +	ts >>= tx_q->ts_gran_pow2;
> +
> +	/* 0 is valid 23b timestamp, but also means field unset.
> +	 * Increase by one to avoid this case
> +	 */
> +	if ((ts & 0x7fffff) == 0) {
> +		tx_params->offload.desc_ts[0] = 1;
> +		return;
> +	}
> +
> +	tx_params->offload.desc_ts[0] = ts & 0xff;
> +	tx_params->offload.desc_ts[1] = (ts >> 8) & 0xff;
> +	tx_params->offload.desc_ts[2] = ((ts >> 16) & 0x7f);
> +}
