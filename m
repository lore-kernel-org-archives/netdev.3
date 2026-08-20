Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37949BA3D
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217465; cv=none; b=bDZtN+OBaBjIL83Lc7z+ysg95l6dXffWUtyqyIqXtjHKgB7jByC0XX4ufLz0vNP+jVnD2WPUkX7EdYlbloToVgM+tJQ6GJhBSc8OJL6VWIMc4K2OYWq3dSLRxbOePV+dJ0Or5XjLR+cMcCqtcgjdKcD+UIEPFYPgBJto1h1Isjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217465; c=relaxed/simple;
	bh=nPkFTOEtgZNq1DnQm57ec1O9IDgRP+zAD+5M9DAnY00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBOUryUb6vYFx8742cqibd9jma2FlZMvNxRpe0LEd123wutfmGiOOFq3FTKK7ERdYIWVPNeRUNNWVCv11pEsLX+x1vJTZcZOnYQixqsI5V5EI6xJSSBIXUWmCWGgMMgkeFVRIEIOS1b4TKc5tpr+V5NlxuoklfdEMZ6hxPMKgLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AoZOmTaR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLeTAyrT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoZOmTaR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLeTAyrT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787217461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6lDvs4PBwNh/pPGjCjR9S79ZeFLuFiB1QygAoYt1AWc=;
	b=AoZOmTaRFepP0+jVzgG1kOYBLkX9Vjuhb2Trivf755oGjI4OWU9pcittjFntatzhF+ttJ2
	4/nOUKsIzN2bB9IfIOt3tJ8K8KdmWWhGeAHLrtrPpW+39VV6l1hNPur3EGoUJ/yCwJJiCQ
	scWQ3SbcKZr2xuryLp3o2C/PVDPT0ak=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-1ooNTlMpNSuUp3CWpGsV1A-1; Thu, 20 Aug 2026 05:17:39 -0400
X-MC-Unique: 1ooNTlMpNSuUp3CWpGsV1A-1
X-Mimecast-MFC-AGG-ID: 1ooNTlMpNSuUp3CWpGsV1A_1787217459
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4954a93c565so11324905e9.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 02:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787217459; x=1787822259; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6lDvs4PBwNh/pPGjCjR9S79ZeFLuFiB1QygAoYt1AWc=;
        b=VLeTAyrT+M44Uw5/S0+lAaHrEasG8kf19YyMDQUgzTyOQMs6iw6kZT2ZIe3qOwk00H
         VubawUHbGxo0LxBbKr6nndc8xwPRak91Zh0PSvNzBXVNHrNSP5K+pY9hbnhGHf3NgI+t
         0WaJuopzOXOAj96bpNfENAIkJPdRlJeytQ/sVjWCUAB+gvaktnlhaCNfAIJR77eA/3QR
         qrKMMjUfYzUwMk64l8P6SkMm6+1eOd3PdtBjQ73/YLntO7unlUPTWESkhP+DVzt5lZrS
         69avmtUQN7090/GUA1NhjvRrBYqFMzpxchuaP0PWCXwOIcGvPnYhYoKKSWTSgNjUg5CQ
         te0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787217459; x=1787822259;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6lDvs4PBwNh/pPGjCjR9S79ZeFLuFiB1QygAoYt1AWc=;
        b=lnrDMZKCeKa9Zdt9caiKfOdD2vsvFIYcwB4o3PxLsc3z2Mg6f72chw/6U6EywGFhQm
         rJCy4snnHGBQf6ZCUx4gk3XWvIhjHDlyGiZpuraXLhvQuGKdJWl0njB0yIgYhetU8VuL
         wB+GGPmAzNZh6DMhEiebaPR8iQId6wD/ovEqyPQzaZK78TcLDyngd832kKA+XpLJRkas
         DnKUgAKUUvA96jpBzyOKxmgLdPikjvkNMWg7H9/kaw9FjRyZTMBD+sY4ua3ChJl56OPa
         v6D64hNCUJdhK4I55MgVJ8hmgohQ0PuNeIb+gfgxKD1H4QElMzXuKlRe6SyyCn03rTSn
         b3Eg==
X-Forwarded-Encrypted: i=1; AHgh+RrTPWeTYMbqmKpLQm5J1P1rRadwYhiQ4zCj+UzMZAk3oaDgKT30iigXg8n1Q+gWQj4dk2jYeqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLv73hELoZXfvyxaYlj1Lc7Gs8/eIx7pWxQcbzPeP2amUbS0Mw
	UJN3RA2fQc1akOledJ1yagPJf8Cy08YJOM5/9r3iXRkbHbXH/K5FoqFgXBzBOkTgqaangAKgCR+
	FRte6aDQLUKVoqYeCNs26ohyS8WC9MlwCEDT0+RiEiWq64wzWesbObls6PQ==
X-Gm-Gg: AR+sD12PoJQpAszYZgvm6jCY5F9k+ImTivOMVMQg7YZ0mjrTBZZxjN1ZnTcKtYLJ/pH
	XRMiwnYSayTuHJB9HKJ7KXeNGd8Ep4xIWE+ydYF8r5hMusnXs9j42fxQ+fqE9JUY2C+7oTOhMXS
	BC4LV1oP84CpkaYr91vwn+J8HXQ1KsEq0nmDmnWeLtNCcqAfdVkDLJmAxHbmAWMKSSkw+emySsO
	0+IbMG6K4bqcnsadSI+AzBiKXaEN96rIeZ4Kv7plUpBfCnfZE9dDdCLuEulKbRfAggISPJx0Rrv
	QLg/c0S5tqIjFgs4nl0ij79IYxxKVWfFCLeofIY9oh6clpPpfpUu6iivpxgnvLikh/RdfJsaddX
	4SJtXBRJFxby2oXff21HV28LLQ6t9HSV1LdauLDQ8FCPkjqhL6BLQIUxdF0IAv4KVO2AuwRHRSU
	o=
X-Received: by 2002:a05:600c:354b:b0:499:872b:abd4 with SMTP id 5b1f17b1804b1-499aa1a1f2bmr173636545e9.6.1787217458581;
        Thu, 20 Aug 2026 02:17:38 -0700 (PDT)
X-Received: by 2002:a05:600c:354b:b0:499:872b:abd4 with SMTP id 5b1f17b1804b1-499aa1a1f2bmr173635675e9.6.1787217458140;
        Thu, 20 Aug 2026 02:17:38 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b2b35386sm25640585e9.4.2026.08.20.02.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 02:17:37 -0700 (PDT)
Message-ID: <3f078f41-b971-424c-9258-b309a7d5d223@redhat.com>
Date: Thu, 20 Aug 2026 11:17:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/3] net: wwan: support DTR/RTS on AT ports
 via MHI IP_CTRL
To: Peter Hunt <peter.hunt@opengear.com>, loic.poulain@oss.qualcomm.com,
 mani@kernel.org, ryazanov.s.a@gmail.com
Cc: johannes@sipsolutions.net, netdev@vger.kernel.org, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260819224927.2274790-1-peter.hunt@opengear.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260819224927.2274790-1-peter.hunt@opengear.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/26 12:49 AM, Peter Hunt wrote:
> Qualcomm/Sierra SDX55/SDX65 modems (e.g. EM9291) withhold unsolicited AT
> result codes until the host asserts DTR.  The in-tree mhi_wwan_ctrl driver
> exposed AT ports but never signalled DTR, so URCs never reached userspace.
> 
> Patch 1 extends the wwan core with an optional ->dtr_rts(port, mdmbits) port
> op.  The TIOCM bitmask state is tracked entirely in the wwan core; drivers
> receive the full bitmask so they can drive DTR and RTS independently.  The
> core raises DTR/RTS on first open of any AT port whose driver implements
> ->dtr_rts and drops them on last close, mirroring TTY semantics.  In the
> ioctl path mdmbits is re-read under data_lock inside ops_lock so the value
> passed always reflects the committed state and concurrent ioctls are
> correctly ordered.  wwan_remove_port() also de-asserts on hot-unplug.
> 
> Patch 2 enables the IP_CTRL MHI channel in the Sierra PCI table so that
> the IP_CTRL driver (patch 3) is actually bound on those controllers.
> 
> Patch 3 adds a second mhi_driver that binds the IP_CTRL channel and
> registers a ->dtr_rts op so that the wwan core's open/close DTR raise/drop
> and userspace TIOCMSET calls both reach the modem.  A single recycled sink
> buffer keeps the IP_CTRL DL ring live so the modem's transmit path does not
> stall.  The existing AT/QMI/MBIM data path is untouched.
## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.3,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

