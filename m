Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211673559E1
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786299191; cv=none; b=sWg06EyFJbS6XTBfSnQ7kd0A72l+Ku/8T/d2rINgPY1Hjj/GMz8Rjonwm9ATj5HHugCum2EMtmRMbRSNHJxwqYCosOmZqX7VtuCUr1j69+9iebTFf6ys5DCsdNaaepXHTo4CN9gFHzf18Ccx5nLaUHyPfpwrFN2JQAG4dLJ8Xjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786299191; c=relaxed/simple;
	bh=C/W7wOWNrlRT+JcD2OV2qFK3TxuVDUS4saNwYQXWIx4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jp8izB5LLsryp1RJe4oHAywgIJqt5rHxwtLfc9//+9AmLiEyjpqt+IIMdlA8JPxJVoPFhUNJy5ac62mlI7CbdyMctCQ3eKkJdHlZiSXaiEo1qJFryd7UVKPffWidg8hF4pf/1BjaegQqPOc+Y85pngeCAGL4opOx+cEN0zM4uos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cl790t21; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cl790t21"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786299189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/W7wOWNrlRT+JcD2OV2qFK3TxuVDUS4saNwYQXWIx4=;
	b=Cl790t21gJ6jk7s2DeP1tySg8KcPVynxS7ByLElzg9k4RpsJDzV1XBFb7EN3EzCDdJ5uoT
	FqpjFXIDSgCidw53AEEK6NIRo+IgHs1qYXG56lZE7ZEvI83THadgnWzXHX2pLAgBe0g0Pw
	qF/yOfzt/SrbbuGWK10QE6PoAdoJDt8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-Ekk__YeoPAaiAKZ5b6WNTQ-1; Sun,
 09 Aug 2026 14:12:59 -0400
X-MC-Unique: Ekk__YeoPAaiAKZ5b6WNTQ-1
X-Mimecast-MFC-AGG-ID: Ekk__YeoPAaiAKZ5b6WNTQ_1786299177
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56FDE1800471;
	Sun,  9 Aug 2026 18:12:57 +0000 (UTC)
Received: from [10.44.32.36] (unknown [10.44.32.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D247930001A2;
	Sun,  9 Aug 2026 18:12:52 +0000 (UTC)
Message-ID: <e8cdf843-3b86-4e35-b4e7-80751f71f996@redhat.com>
Date: Sun, 9 Aug 2026 20:12:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] dpll: zl3073x: update all DPLL channels
 on ref_sync_set
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Min Li <min.li@microchip.com>, Paolo Abeni <pabeni@redhat.com>,
 Petr Oros <poros@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-doc@vger.kernel.org
References: <20260807095926.386923-1-ivecera@redhat.com>
 <20260807095926.386923-2-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260807095926.386923-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Sahisko findings and my replies...

 > Is the loss of the error return here intentional?
 > ...
 > isn't the pair being already armed exactly the reason the sync input
 > must not stay selectable?

Yes, this is intentional. The ref sync pair is configured by the
preceding zl3073x_ref_state_set() call and is fully functional at
that point - the priority exclusion is a separate, advisory step
recommended by the datasheet. It prevents the automatic selection
algorithm from picking the sync source as a clock reference, which
would be counterproductive but does not affect the sync pair itself.

A failure in zl3073x_chan_state_set() here means a mailbox or bus
error, which is highly unlikely during normal operation and would
indicate a serious hardware problem that surfaces through other
error paths as well. Propagating it to userspace would falsely
suggest that the ref sync pair was not configured, when in fact it
was. The dev_warn is sufficient to flag the condition for debugging.

The old code propagated the error only because it was a single
return statement at the end of the function - not because the
priority update was considered essential for the operation to
succeed.

Ivan

