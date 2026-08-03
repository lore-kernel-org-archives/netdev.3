Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486FA34027B
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751878; cv=none; b=oKXu7F6ksaWM2cfxW3Z5Sfklh9umk6k3SRBbDhLR4lZdT7pdqaGVdJWYoNiJ7pc9gqqVwwft05bhBJAS6XcKpMQrcb5weT/vbpeuwq9anOC65r0BHIXY9wWZzPbZC4B33qXDfNpT9ligr7bKhQbeucCG6iqHmiN9aJ6743o0cyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751878; c=relaxed/simple;
	bh=wjYb188Rx8IYnwQbaHrKq8avlii+CfKl/xtZ6SJm190=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cr052EDyvA4h/JSj88/V5PoN8fd1R5K3vUfmUnxo5kZl/yUvbofGGwHOWIJEMMCdpji84H9nol5t8MDNgAdQLAaCxJgHibhAMlBLBKA2MsQFACktqMfD0PI5jcrd/R2AS51/r8VCxMLeDIPJ1r8XD+dT7ae842bPtTdyptQx9lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OsvgdL8e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsvgdL8e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785751876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LVIDOGFcCa6nk+XulEkUJYXm+pWKfz25I6RlpHxIe0s=;
	b=OsvgdL8eZOij7YgwSgN4fXsKUg6rpv+yeo4PfZSnXGfRAcmvqAVAo0m5Q1OwJz0ewEghNN
	LKsaRCZICDOOAukLTGq9hlT3Jtj//FfxPPfG9ts/S84M7MjtlU/x0qwcAjdKVKWVSGvFI0
	4ggdbbaXm5tRRBxzJP4tBii6ssY9brk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-HXc-3yg_O2WC4VONSXy4lA-1; Mon,
 03 Aug 2026 06:11:13 -0400
X-MC-Unique: HXc-3yg_O2WC4VONSXy4lA-1
X-Mimecast-MFC-AGG-ID: HXc-3yg_O2WC4VONSXy4lA_1785751871
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98CDA1800350;
	Mon,  3 Aug 2026 10:11:11 +0000 (UTC)
Received: from [10.44.33.235] (unknown [10.44.33.235])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 797C61800480;
	Mon,  3 Aug 2026 10:11:09 +0000 (UTC)
Message-ID: <ed4deffe-1c0d-4f3a-8a78-80b6c41571fd@redhat.com>
Date: Mon, 3 Aug 2026 12:11:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dpll: use pin owner's dpll ref for pin-level
 attribute setting
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Richard Cochran <richardcochran@gmail.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260731141146.1119147-1-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260731141146.1119147-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Reply to Sashiko findings:

 > dpll_pin_is_freq_supported() reads a u64:
 >     u64 freq = nla_get_u64(a), old_freq;
 > while the validator takes a u32:
 >     static bool dpll_pin_is_freq_supported(struct dpll_pin *pin, u32 
freq)
 > ...
 > Would widening the helper parameter to u64 be worth folding in here?

Good catch. This is a pre-existing issue unrelated to the owner-ref
simplification. I'd prefer to fix it in a separate follow-up patch
rather than mixing it in.

 > Should Documentation/driver-api/dpll.rst be updated in the same patch?
 > ...
 > Could both changes be mentioned in the commit message, which currently
 > describes the patch only as removing "duplicate HW writes"?

Wull address in v2. Both dpll.rst sections ("Shared pins" and "SET
commands format") are updated. The commit message will describe the
-EOPNOTSUPP validation change (from scanning all owner-matching refs to
checking the single owner ref returned by dpll_pin_own_dpll_ref_first()).

 > Is the ref_sync_set callback really DPLL-independent for zl3073x?
 > ...
 > does this leave the sync reference still armed as a selectable
 > candidate in the priority tables of every other channel?
 > ...
 > If ref_sync_set does need per-registration invocation, should it keep
 > the xa_for_each() fan-out while the other three setters move to the
 > owner ref?

This is correct finding. zl3073x_dpll_input_pin_ref_sync_set() performs
a per-channel priority write that would only reach the first channel
after this simplification.

Rather than keeping xa_for_each() in the core for this one callback,
v2 will split the fix into a preparation patch (1/2) where the driver
itself iterates all DPLL channels via list_for_each_entry() and sets
priority to NONE on each one.

Ivan

