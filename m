Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA233264F9
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790863868; cv=none; b=GaVCQLPsI77b/EIU3MFtqZ1pgOGza372uiZ/+uIhTnO1Ug/3+fsXLXBLq3ZKleVGFtpwvhRwcCCDKwehAZ9X+E9G8bglX2S+rzwjJLsJl+m6GoUMBHOV6rCtn2OTXtw91yeYSpJGXVMViIf2jySp1Wmfcvng8SowcyB0jfan59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790863868; c=relaxed/simple;
	bh=URHAkVKmP2LBDaoK9MhFzHL5kI0csHW7hcwgmIueC1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g9alZPoAKjsZzo+6JaTbCWNASc76MeimQiqxuxSkEosW+KWGbXBz7ZH4GFpjuo9E7+MWY2s8uE7XeOa+ye250D7Oswc/np2x4e5l7hqx3kcLVpX/mQ9pYQi9SPde5CovqEJ28uB+2NidgUTttGLr2j8/Rgv/GEX34l4aLHAdQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPMuK2pp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPMuK2pp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790863865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJruJCipbz37Cj86mOljr9fVoJaP+MPTZdcnqyXn5k0=;
	b=RPMuK2ppEWxhWqNR59iuGbp/NShAuUvQLst9h0yZK+u09Ww4DWzLqnGBJ/r25ttsIvE+nC
	ju/TAQ6YgJjWEGwkzwiyi8sSp5xceG/xqIQDrV2KeLoi1kJ+uuTtoQz6YVVHQ0Zl51Rr9k
	YH39+ZlkUo3ID2mUadRVmdm6vtT6Zr0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-Y2eM0s2HNj2sdb7jc5GJ0g-1; Thu,
 01 Oct 2026 10:10:56 -0400
X-MC-Unique: Y2eM0s2HNj2sdb7jc5GJ0g-1
X-Mimecast-MFC-AGG-ID: Y2eM0s2HNj2sdb7jc5GJ0g_1790863846
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB9E318F6558;
	Thu,  1 Oct 2026 14:10:41 +0000 (UTC)
Received: from [100.90.87.156] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B566E1800352;
	Thu,  1 Oct 2026 14:10:38 +0000 (UTC)
Message-ID: <3c4e8106-83d0-4c1c-a3bd-8d9343d2d557@redhat.com>
Date: Thu, 1 Oct 2026 16:10:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] dpll: zl3073x: fix output pin esync and sibling
 notifications
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Min Li <min.li@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20261001080648.1424172-1-ivecera@redhat.com>
 <179084215284.31693.16414064063107147164@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179084215284.31693.16414064063107147164@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 10/1/26 10:09 AM, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.
> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Hi,

thanks, here is the missing information for both patches.

Both issues were found while developing and testing.

Patch 1 fixes a bug that was actually triggered. After changing an
output pin's frequency the embedded sync output stopped working
correctly, which I confirmed on an oscilloscope - the embedded sync ran
at the wrong frequency and duty cycle because its period and width still
matched the previous carrier. In addition, when the new carrier was
1 Hz, esync_get() returned -EOPNOTSUPP, so the stale eSync mode became
invisible and could no longer be disabled.

Patch 2 was found by code inspection rather than triggered at runtime.
Both pins of an output pair drive the same HW output, so changing e.g.
the esync configuration or phase adjustment through one pin also changes
the sibling pin's effective configuration. A dpll pin-get on the sibling
pin returns the correct current values, but because no change
notification is emitted for it, userspace is never told that the
configuration changed asynchronously through the other pin.

Regards,
Ivan

