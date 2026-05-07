Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE7F222597
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 06:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778134339; cv=none; b=p8DacGX0yQSKvdbR/hIODjF2OlAx1r++3t6eOM9zClohuVrAfNcYgVEfNxDbgSx7oPxe8uHWl47/3fUqCkT9b4HGhEkdEiIOBOnJ79nPRByI6+hyeO4CCVKWyauLbYyFzqQ6F5TtWHkCaMBE7PpB/G9jzUL7k39W0ZP6lPTBeM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778134339; c=relaxed/simple;
	bh=1zyYR98aRtky49y+0ToQ6v4Qbh4/TzygLpF1ZcyWWaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ruZ5Jvvw0HK/a5BeZ4ozBG2JPlp3LQ7nZ63PlGOkQqholAt0jvED1HvQCRRtgE2auq1md6m72nrJGndinjm78Alk7wL7isHEHuhDKu+EmA9qA80UYgt+PGGA1MwnoHgN34C+yWWc3/5iUVTXZ43KY2/mMVA0AqNkX/MZGCfP9m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gj5J/LnS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gj5J/LnS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778134336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+7yZVAPKgBe5zd8mBYO+jhWo6nMd/MCriq7JgRzg1k=;
	b=gj5J/LnShPd3GDIGPpMZoQ8OVU3JtMWxdDBo4zPpVEf23QU0Nb5oYvvb2/TQmvS3lfKH7j
	s16Ln60CB1t6flJu3Y3GKQwIviTJMGN9hFnQd6xC5JSzAbTYcNvvc8cXw0TH3Oi1Ed/DqR
	fIyJBQdHNcu4ob8Q+cnoQia8Y++xdX8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-BtlojZnwMyiT6rXL9Gd5bA-1; Thu,
 07 May 2026 02:12:12 -0400
X-MC-Unique: BtlojZnwMyiT6rXL9Gd5bA-1
X-Mimecast-MFC-AGG-ID: BtlojZnwMyiT6rXL9Gd5bA_1778134330
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D41218002E9;
	Thu,  7 May 2026 06:12:09 +0000 (UTC)
Received: from [10.44.32.223] (unknown [10.44.32.223])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDA93300019F;
	Thu,  7 May 2026 06:12:02 +0000 (UTC)
Message-ID: <541f767d-222b-4dfa-a95a-19a5ed7a46bf@redhat.com>
Date: Thu, 7 May 2026 08:12:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] dpll: add fractional frequency offset to
 pin-parent-device
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Michal Schmidt <mschmidt@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>,
 Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260504155340.411063-1-ivecera@redhat.com>
 <20260504155340.411063-2-ivecera@redhat.com>
 <20260506183342.767b5fbc@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260506183342.767b5fbc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 5/7/26 3:33 AM, Jakub Kicinski wrote:
> On Mon,  4 May 2026 17:53:39 +0200 Ivan Vecera wrote:
>> +          At top level this represents the RX vs TX symbol rate
>> +          offset on the media associated with the pin.
> 
> Isn't this a hacky hack? I'd think that pin is in or out.
> Having a freq offset between two pins or pin and parent's
> ref lock makes sense. This new interpretation sounds like
> we are trying to shove a difference between two pins into one?

The "RX vs TX symbol rate offset" description is not something I
introduced — it is the original documentation of the
fractional-frequency-offset attribute as defined by Jiri. The -ppt
variant was added later purely for higher precision. This patch just
unifies the documentation of both attributes.

I'm not sure I fully understand what the original "RX vs TX" semantics
were meant to capture. Jiri, could you clarify what you had in mind
and whether we should keep or change that description?

>> @@ -299,6 +299,10 @@ zl3073x_dpll_input_pin_ffo_get(const struct dpll_pin *dpll_pin, void *pin_priv,
>>   {
>>   	struct zl3073x_dpll_pin *pin = pin_priv;
>>   
>> +	/* Only rx vs tx symbol rate FFO is supported */
>> +	if (dpll)
>> +		return -ENODATA;
>> +
>>   	*ffo = pin->freq_offset;
> 
> It's easy for driver authors to forget this sort of validation.
> We should fail close, so it's better to have some "capability"
> bits or something for the driver to opt into getting given format
> of the call.

Regarding the fail-close concern — I agree that relying on drivers
to check dpll==NULL is fragile. A capability bit alone wouldn't help
though, since the driver still needs to distinguish which FFO context
is being requested.

I can think of two approaches:
1. An explicit bool parameter (e.g. `bool per_parent`) instead of
    overloading the dpll pointer for context distinction.
2. Separate callbacks for each FFO context (e.g. ffo_get for the
    top-level and ffo_parent_get for the per-parent).

Do you have a preference, or something else in mind?

Thanks,
Ivan

