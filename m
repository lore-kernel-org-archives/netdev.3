Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9524C563292
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093789; cv=none; b=P/7VrlHOk7P0Fh0oU+11PLjnjOvfK1GnLLCeLzyJ2Gx+ioO/5rq0RBztIyuP8sMm4H3j66Qr8m/E5pRMiCTee1UxU2ZzhCv/ceLAoxRrPFZBtMjjbZQYeopbVWUBRit/18SwiwVirKqA6809LFXJYNXoYWwC80JayjpXakGatzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093789; c=relaxed/simple;
	bh=AbetqKbMWy45m++smcKdtoAGGLMNts8mPhtrrgvvx9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P32vutaIw/94jEFBrNISPcsjIVZFvJPvNXzcjtEDZgPbiXN9mpwf79gZN1IXM03Xtfe4orDn/VFi1Hy/2tEhZhYcaE5d5NF0nzD+YBDsrJ5QJ7rgdsiE0g07aec/Q65ZsWcw3bV3MjJ7sZ0QUrNUp/K9YQu1Mu87TvX3VbhQJFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDE2V7LE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l/GueQEK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDE2V7LE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l/GueQEK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790093786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jikweUPn9eHZFV+jN3/UdJJ0lBvQpXXsbVa6OqcmiPc=;
	b=CDE2V7LEMOyFKli9I8QkU07TSADdt1tBcrtfirij7rMOnX7F77oWlu5wx0xtEf6e4oUiuO
	VSGpijFyfW9cBBAEO+BomwRXPYrbm5nCRxdS4idBojAAgFD1/u84oYrIuhHdTaiXyNDnDd
	EkaWkmXBjAhGchmwmWdRUL0ihNjd8R4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-mWkIkOXbOwed3roWjSskTA-1; Tue, 22 Sep 2026 12:16:24 -0400
X-MC-Unique: mWkIkOXbOwed3roWjSskTA-1
X-Mimecast-MFC-AGG-ID: mWkIkOXbOwed3roWjSskTA_1790093783
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49e735659b7so34951885e9.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790093783; x=1790698583; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jikweUPn9eHZFV+jN3/UdJJ0lBvQpXXsbVa6OqcmiPc=;
        b=l/GueQEKJylBMxEbfDXhbIDOiKpCFcfKmZfR8dAXJddv6UPFVZUNk+CkfvH0o0tBnc
         K7CYNK9D7VB4rp1dwccQSfZCvdaNlqiu934k/ijJh8Dp6biNuu49IpReoaNptzznnACL
         wQsU8XpWxPsUJkX5A6RNzqq+bnl0PanB679RjD/O1LeFE9UVV8Qp7MjqYDBkT/cpDMPg
         NcTan/OySKgyU00rVquny0Fo9kRdhOs6rEWsqby0nYlzDIMod5sOjqLh28UK2cN6cOW4
         7ixYA6mLNHjXh2Ae11ZyB/FWdpjsrNsj8UgGUw0w7wb9vxXHmjq0pVvZfFBZrP1ZysE/
         I0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790093783; x=1790698583;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jikweUPn9eHZFV+jN3/UdJJ0lBvQpXXsbVa6OqcmiPc=;
        b=huxV67mq1Au5416UmEd3XTaYVfSau4AhUgMNb9gvpcc6k+h62dRHzitnuycgdhlND2
         +YgAYIC2w6EXIniokh6iQ3l+OcTabwXG/E2Ri5kap4Fy9FHtRzpMZf3KgXoa7riJ0vHS
         AynDmkoBUvKNsqK+eIwF2c27QHSZZeA6jhO/j+3Ke/6Y29fnU0ZVhgZ3BHpyD5myP74z
         PQ5Ei6g8C2Gwe09ujhwtvdvAXAjgCVkyd4eNB/Hjb/2G/K38p0sNNH6A6ySHZYmCL0j5
         GHD9YfarcgxhDWCM8SbzzF5C+gsF8AL8WQcjxOMkhDNFlw2+yULg5tyhkPwO17WZk5mE
         Iraw==
X-Forwarded-Encrypted: i=1; AKwUvBzx9gtMSFRdbZMSKTBcrbvwtUxwASKCIeemzy7O/XASAPR1EkMnnlJYbVL/vnXTmSF5RUHPw9c=@vger.kernel.org
X-Gm-Message-State: AFuF++keeGyf/DYnlmMDCwPUOnd3okSH/H0aWlJfLze8JsVJ48KzNBIG
	hxzaa4Cw97Af9uQgirF5WhpCDFcs7eG1i+kASs6uq98b4RohZdy3Uuyjb4w6vcwhX9HjSPmr1e0
	UtTTsNk12rl6WPSOkx2zkB1u3HuYYMTX3iMKfrhX/Wf88BUPRtD1UbuCM6g==
X-Gm-Gg: AYBFou2nr57g2/KuFd4m+DBOz89x8lrDFApqRqQEJwNRsGVK2qDTk2DJ3qtZbqO0P4c
	A+wUSHs2Uj+f1guu+ZuLaPC6lclKASFD8q51K2HkA1kIMs3qUSFWYDyI82ei+pHYZ+21nETA9AC
	nCKx58sJDe+ZLcT+FGdP8XLy/PsVn+7g1t9sLweAG/m11z01u39D64ENTweqARFGiL9vnvBO/td
	sYo5gbmHiH6qdvqz6Wdf+4y7ao9g7vs3uC/1bhpp5+ofE8tA33bS1oigW283jEA0UoM1aF+ufcO
	5WlSZsLfCadbW/i+aAbtdVJ6uGEOvVIlufDGuuFzaGan/OMkGrcgdHufDtF7t8IadJCVMElGafB
	tPrsJfbGT6/TPDrZLsR2AidixbQ2WPepmFOPCUodqEZUZ9npjstzybBgqA9mUFDP1ydSyIhNmKw
	==
X-Received: by 2002:a05:600c:4f44:b0:49f:ce73:7a9 with SMTP id 5b1f17b1804b1-49fce730888mr165830625e9.34.1790093783425;
        Tue, 22 Sep 2026 09:16:23 -0700 (PDT)
X-Received: by 2002:a05:600c:4f44:b0:49f:ce73:7a9 with SMTP id 5b1f17b1804b1-49fce730888mr165830135e9.34.1790093783016;
        Tue, 22 Sep 2026 09:16:23 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1acb91sm1173645e9.15.2026.09.22.09.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 09:16:22 -0700 (PDT)
Message-ID: <1e076df0-d343-4809-8354-a6166fc8237b@redhat.com>
Date: Tue, 22 Sep 2026 18:16:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 2/6] selftests: net: py: add metric policy output
To: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org
References: <20260916190409.1222272-1-sdf@fomichev.me>
 <20260916190409.1222272-3-sdf@fomichev.me>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260916190409.1222272-3-sdf@fomichev.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/26 21:04, Stanislav Fomichev wrote:
> +def ksft_metric_aggregate(name, summarize="total", *, aggregation=None,
> +                          transform=None, regression=None,
> +                          display_range=None, display_scale=None,
> +                          display_label=None):
> +    """Register processing and presentation metadata for a metric.
> +
> +    The policy applies to every observation with ``name`` in the current test
> +    case. It is emitted once as a ``ktap-metric-policy-json`` record before
> +    the matching ``ktap-metric-json`` observations, so a consumer can process
> +    the metric without recognizing its name. Register a policy before the
> +    first matching :func:`ksft_metric` call. Registering the same policy more
> +    than once is allowed; changing it or registering it after an observation
> +    is rejected.
> +
> +    Args:
> +        name: Metric name passed to :func:`ksft_metric`.
> +        summarize: Operation used to reduce the processed observations.
> +            Supported values are ``last``, ``total``, ``p50``, ``p90``,
> +            ``p99``, ``max``, and ``distribution``. ``distribution`` keeps
> +            ``last`` for one scalar observation and produces p50, p90, p99,
> +            and max for sampled observations. The default is ``total``.
> +        aggregation: Optional operation applied to each transformed
> +            observation before summarization. An aggregation may reduce a
> +            structured value, such as an array, to a scalar.
> +            ``busy-core-equivalents`` expects a CPU-indexed array and sums
> +            transformed per-CPU rates. Without a transform, it treats values
> +            as percentages and divides their sum by 100. The resulting series
> +            measures concurrently busy cores.
> +        transform: Optional operation applied before aggregation and summary.
> +            ``rate`` calculates ``(current - previous) / elapsed_time`` from
> +            timestamped cumulative observations. Counter decreases and
> +            intervals with nonpositive elapsed time do not produce a rate.

Very minor nit: I think sorting the above the arguments in the inverse
order would make understanding the doc easier (read order will match
data processing order).

/P

