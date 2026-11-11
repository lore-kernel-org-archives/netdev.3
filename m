Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394412;
	b=0nxooTl8suRZcgO5Gu4k1kjgze8FvWuBIxXwvUgY4dSFOSdn3RpdUi3deyEEUfnfnvR4
	 t30+rOlA4AS2OQ4gDa1qbpplPPAduSaDu+RnT9/F04+v5Igv+q4DXersnZM6oXcv+csqU
	 t8bi/nyotzhEhtiO4rr9bGM40ArRWGjDED3cfoemCQN+0Vvfa8Qa4KygMnBzGwOA/nyIZ
	 y+nTaG0Nq5uVcOLhMviVktehid1SmHs7HZjJJkzWdORxjSuwpr+EzIkGBPZdAvgzSkhR4
	 spjF3zMklKyIN8BG0xGde9FPju7GDEPoPhIsreDUGOz+4o5Z6Og/aaIjrPFfVCfWt7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394412;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=8N7fypCJ/hoT+y3Nl5Cy8LcZBYe/io6SKN/QBhzDpOM=;
	b=sCBsM+DCnlq19v5j3LQloLXBLD2bE3xD8GWnOv7pqkA97h2WauZdcnYuDXk3OEsXEZGB
	 6FkO+VNFIksXJcYgntZLNn2Jk3dYt2vq83y9GnocNXhm/nUStsiGr2ZXj4ocK6lvrDUmO
	 H1mqBty6hKqCVmFTOZugf0GkuTH9jaQUhrI0DAd6z1dlJ7q1nRaX0SYaasF/A4qgqstpK
	 rrkLo43Wb55QCYp/v/NbOhnuS9Xyn/mAhuVs7/LFbxny31yY8TWs5rkywtLPfF1zfk1i8
	 VvKnsM56sBu6oWQl2hOFxlNESvZZH4BkHXIpc35e7z315Wskn4SSKbMAXCF0looJw3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uyc2E5RA;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59559606A331
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59559606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uyc2E5RA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794394411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8N7fypCJ/hoT+y3Nl5Cy8LcZBYe/io6SKN/QBhzDpOM=;
	b=Uyc2E5RAmsRPlmNfNZDdFE3+BbZvXKF3th4g14A0gEbTAJyzyYTk9qu3M3kQBhhZKqgoi6
	+Gqz0zIsjbJSD+SH2JYwqZ7yL8mtkBvu+WPwVylyYx396gWFHRfSyTcKTzyUwY9EuUj+aq
	8ruh9IdwWCH36s/4p5Q2G7tsHmeYEqI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-DxKuXwMGPSCoAX2zKEuwcg-1; Wed,
 11 Nov 2026 05:53:25 -0500
X-MC-Unique: DxKuXwMGPSCoAX2zKEuwcg-1
X-Mimecast-MFC-AGG-ID: DxKuXwMGPSCoAX2zKEuwcg_1794394402
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9591F1955F61;
	Wed, 11 Nov 2026 10:53:21 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45ED518004FC;
	Wed, 11 Nov 2026 10:53:14 +0000 (UTC)
Message-ID: <38365dce-f6a6-4fdb-8f76-8b697f64aeb3@redhat.com>
Date: Wed, 11 Nov 2026 11:53:12 +0100
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
Subject: Re: [PATCH net-next 06/10] dpll: add KUnit tests for core locking
To: netdev-bot+sashiko@kernel.org
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
References: <20261106121005.1327603-7-ivecera@redhat.com>
 <179433320676.994134.7049432410059447687@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179433320676.994134.7049432410059447687@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 11/10/26 18:53, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] In drivers/dpll/dpll_core_kunit.c, some tests set a blocking
>    flag before dt_req_start() has registered dt_req_release().
> 
> --
> 
> dpll: add KUnit tests for core locking
> 
> This adds KUnit tests for DPLL core locking. They use a mock driver with
> several domains to check domain sharing, which locks callbacks hold,
> independence and serialization of domains, atomicity of multi-attribute
> pin sets, and notification ordering. The netlink pre/post doit and set
> handlers are exported for KUnit so the tests can call them directly.
> 
>> diff --git a/drivers/dpll/dpll_core_kunit.c b/drivers/dpll/dpll_core_kunit.c
>> new file mode 100644
>> index 0000000000000..a58800eda5ff5
>> --- /dev/null
>> +++ b/drivers/dpll/dpll_core_kunit.c
>> @@ -0,0 +1,1471 @@
> 
> [ ... ]
> 
>> +static void dt_block(struct dt_dom *dom, bool *block)
>> +{
>> +	complete(&dom->entered);
>> +	wait_event(dom->ctx->wq, !READ_ONCE(*block));
>> +}
> 
> [ ... ]
> 
>> +static struct dt_req *dt_req_start(struct kunit *test, int (*fn)(void *arg),
>> +				   void *arg)
>> +{
>> +	struct task_struct *task;
>> +	struct dt_req *req;
>> +
>> +	req = kunit_kzalloc(test, sizeof(*req), GFP_KERNEL);
>> +	KUNIT_ASSERT_NOT_NULL(test, req);
>> +
>> +	req->ctx = test->priv;
>> +	req->fn = fn;
>> +	req->arg = arg;
>> +	init_completion(&req->done);
>> +
>> +	task = kthread_run(dt_req_thread, req, "dpll-test");
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, task);
>> +	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dt_req_release,
>> +							req), 0);
>> +
>> +	return req;
>> +}
> 
> [ ... ]
> 
>> +/* Blocks a request of @dom in a callback, which holds the domain lock */
>> +static struct dt_req *dt_block_in(struct kunit *test, struct dt_dom *dom,
>> +				  int (*fn)(void *arg), void *arg)
>> +{
>> +	struct dt_req *req;
>> +
>> +	WRITE_ONCE(dom->block, true);
>> +	req = dt_req_start(test, fn, arg);
> 
> [Severity: Medium]
> Can the teardown hang here if dt_req_start() fails one of its assertions?

Yes. It takes an allocation or kthread_run() failure in the test, but
then the cleanup blocks under dpll_lock for good.

[...]
> One option is to register a cleanup action that calls dt_unblock() from
> dt_init(), before any flag can be set. Another is to set the flags only
> after dt_req_release() has been registered. Would either of these work?

The objects of the foreign and on-pin tests are added by the tests after
dt_init(), and KUnit runs the actions in reverse order, so an action
registered in dt_init() would run after their release. v2 clears the
flags in an exit callback of the suite instead. KUnit runs it before any
cleanup action, so it also covers dt_test_stuck_foreign_device().

Thanks,
Ivan
---
pw-bot: cr

