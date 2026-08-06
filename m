Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ABB30E0E4
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021903; cv=none; b=Ubct3VPSfSR/wq44Fqs1lN9BjueJ6X9ZgPJGDbIpnDJ0uBhAwa4AfBfci71DIjONmqZdAigy9rghcsTfmVJTtq9Czfl+vlhRgNw9WgL/LsFQ/LRcw/e0lWiF50oozQwIYMsWUod47cBQiYdTyfwf1qIf1z04vraqcaZXJ1CwNzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021903; c=relaxed/simple;
	bh=5fskIXRbFLxJ0UP80pAbHCKoITJb30KuuN5kP/9OXko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJ731ZNji6/Dnc4nODnkK9PKvmcL4vZhdb2LuZ8J8YGFlYH9SwTp68SO3oeqM5ZU9FtLgCFhwPpXzRb21jEAw08b3ItT/eb1kBjmjt8G6kCEHVoCeWhvRFakPd8k86ovwU4JZLl2/pTElIWf92WqktdtLJOMAzdYuoXr2qDIiJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MOOAavss; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOOAavss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786021897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LYKuV+yX9KSdaQsXrdDzLXsNk3LC5IrpGCZvRdxdVZo=;
	b=MOOAavssZuKdFeQV/neaN88SCq+jChKw6wD8yvjV1Y27+NZMlq86sbnpW6E9ACLlfm/0oo
	5UuxP/fhSKT0jlfVvVpnDlBJ3Bo2+bHFYXv+K5GbHjfmFnsC4kumyJrv8edxrHfW3QHy32
	mJ1v9H7jIyWoacn8oJr+ZCv0TqO7D7o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-TV1-yDyLNfSyL4_JSJUMiQ-1; Thu,
 06 Aug 2026 09:11:34 -0400
X-MC-Unique: TV1-yDyLNfSyL4_JSJUMiQ-1
X-Mimecast-MFC-AGG-ID: TV1-yDyLNfSyL4_JSJUMiQ_1786021893
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D811F18001CD;
	Thu,  6 Aug 2026 13:11:32 +0000 (UTC)
Received: from [10.44.33.193] (unknown [10.44.33.193])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 101CB1956094;
	Thu,  6 Aug 2026 13:11:28 +0000 (UTC)
Message-ID: <be9db691-8fe9-481b-a413-c44b70149ed9@redhat.com>
Date: Thu, 6 Aug 2026 15:11:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] dpll: use pin owner's dpll ref for
 pin-level attribute setting
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
References: <20260803120245.56046-1-ivecera@redhat.com>
 <20260803120245.56046-3-ivecera@redhat.com>
 <8b498be8-8b5b-49b0-b20b-71ca8cc277cf@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <8b498be8-8b5b-49b0-b20b-71ca8cc277cf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 8/6/26 11:41 AM, Paolo Abeni wrote:
> On 8/3/26 2:02 PM, Ivan Vecera wrote:
>> ...
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>>   Documentation/driver-api/dpll.rst |  10 +-
>>   drivers/dpll/dpll_netlink.c       | 213 +++++++-----------------------
>>   2 files changed, 55 insertions(+), 168 deletions(-)
>>
>> diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
>> index f83150917814e2..6fb50e53475c09 100644
>> --- a/Documentation/driver-api/dpll.rst
>> +++ b/Documentation/driver-api/dpll.rst
>> @@ -116,8 +116,8 @@ Shared pins
>>   A single pin object can be attached to multiple dpll devices.
>>   Then there are two groups of configuration knobs:
>>   
>> -1) Set on a pin - the configuration affects all dpll devices pin is
>> -   registered to (i.e., ``DPLL_A_PIN_FREQUENCY``),
>> +1) Set on a pin - the configuration is performed through the pin owner's
>> +   dpll reference only (i.e., ``DPLL_A_PIN_FREQUENCY``),
> 
> I find the new text confusing; it seems to me that the pin configuration
> now affects a single DPLL.
> 
> Sashiko nipa has several comments, please have a look:
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260803120245.56046-1-ivecera%40redhat.com
> 
> and also please be aware of net-next commit c82ff94592fb.

Paolo, thanks for pointing out...

Regarding Sashiko's findings in this patch...

 > Should this list item keep describing the observable effect rather than
 > the kernel call path? ... The new text reads as if the frequency change
 > is scoped to a single dpll device, while the commit message argues the
 > opposite.

You are right. The documentation should describe the user-visible
behavior, not the implementation. The pin is one physical entity and
the frequency change is visible on every dpll the pin is registered
to. Will reword to keep the observable-effect perspective.

 > The removed sentence carried the reason why the attribute must not be
 > nested in DPLL_A_PIN_PARENT_DEVICE ... After the rewording the uAPI
 > requirement is stated without any rationale.

Good point. Will restore the rationale — the attribute is not nested
in DPLL_A_PIN_PARENT_DEVICE because it is a property of the pin
itself, not of a specific pin-dpll relationship.

 > Does the zl3073x implementation added by the preceding patch still
 > report errors here? ... the per-channel priority commit failure is
 > only warned about, and the function then falls through to return 0.

See the reply to the preceding patch. The ref sync pair configuration
(zl3073x_ref_state_set) is the essential part and its failure is
propagated. The per-channel priority exclusion is advisory per the
datasheet — a failure there does not invalidate the ref sync pair
and is reported via dev_warn. The old code propagated the error only
because it was a single-channel write that happened to be the last
statement.

Thanks,
Ivan

