Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A102C2EEE8C
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791351246; cv=none; b=qrTsHBJNscMkgru+SjQ1kfA7foI444qKx+kRVrFSqLEfYrR14KL8daSoP837WaKgRGmZULQIDFZrEXzUEtZPtXcqqhFcN+kNeQu74xg7yQwJpLD77xPJaR0FuXc4Nq0u5pesYBF82RMGoNVGcHoJ7KZ06J245yhR2JuGeinT7Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791351246; c=relaxed/simple;
	bh=hM+mVkh6DUzaqlord+pHR4V4IOsuNvgQla3p6Gy7mJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikTUdnLvtegSH+/0cmPWIJNYcG4IovPTcSiHYg7YJuVegBFXZHGnLXK9U52MCZHvXf26maZMzko/9OvmpSygmmzp+WUg0tVae98MiIs+60NLyMsRFlTNzQ0KWT6cDAg+tlPB9HLSjSun8l2A99hu+Z8ZP3eTab2u+Nhid+bTswc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AsW67gp+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsW67gp+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791351243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hM+mVkh6DUzaqlord+pHR4V4IOsuNvgQla3p6Gy7mJI=;
	b=AsW67gp+vhfBBEfo+hEpjwmkYm/33gdNzUefsT1QJ+ZWcFLNzOcArGMKN0zliMAcav5Ou4
	JN5rAGRq/PpVDD7QWDRRJASgZ3OcmQ10u3MAJX89Xta5OebVLr6I8w4WWkKwSdtX++gtOw
	XLx5/2c+TmQ+DlDOctm3w3glgUzAN78=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-EKSvvjZpMYijab3Y5pu8bA-1; Wed,
 07 Oct 2026 01:33:59 -0400
X-MC-Unique: EKSvvjZpMYijab3Y5pu8bA-1
X-Mimecast-MFC-AGG-ID: EKSvvjZpMYijab3Y5pu8bA_1791351237
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53C551844BD9;
	Wed,  7 Oct 2026 05:33:57 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14D3E180057E;
	Wed,  7 Oct 2026 05:33:52 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jacob.e.keller@intel.com
Cc: aleksandr.loktionov@intel.com,
	andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	jtornosm@redhat.com,
	kuba@kernel.org,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	rafal.romanowski@intel.com,
	sdf@fomichev.me
Subject: Re: [PATCH net v2 1/3] i40e: skip unnecessary VF reset when setting trust
Date: Wed,  7 Oct 2026 07:33:49 +0200
Message-ID: <20261007053351.17571-1-jtornosm@redhat.com>
In-Reply-To: <e1d160d5-7f70-4e41-8632-8a749e356e9b@intel.com>
References: <e1d160d5-7f70-4e41-8632-8a749e356e9b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Jacob,

> Since the usual case is going to be a situation where we don't expect
> to exceed these limits, couldn't this check be expanded so we would
> still reset in the case where the filters need to be removed? I guess
> its overkill and maybe we accept the extra filters.

I think accepting the extra filters in this rare case is a reasonable
trade-off. In the usual case the VF will be well within the untrusted
limits (bonding setup typically adds 1-2 MAC filters). The reset adds
~10 second delay, so we only want it when truly necessary.

> This doesn't address the case where filters have MAC addresses
> different from the admin-set MAC? I am not sure if that still leaves
> a security hole or not.

The PF enforces the admin-set MAC restriction on every new add request
from an untrusted VF (i40e_check_vf_permission() rejects it). Existing
filters with different MACs remain in hardware, but the VF cannot add
new ones. I think this is not a security hole: the filters were
legitimately installed while the VF was trusted, and the VF cannot
escalate from this state.

> This is an intentional change that I think should at least be called
> out in the commit message. This *does* mean a VF which was previously
> trusted could remain exceeding its untrusted limit in perpetuity
> until it resets or self-removes the filters.
>
> That does mean the VF will technically violate the trusted boundary,
> but it can't get worse, and it was previously accepted while under
> trust. I think.
>
> I think this is acceptable, but we may want to clarify the
> functionally changed behavior here so that it is clear.

Agreed, this is an intentional trade-off that was considered during
development. As you say, the VF cannot make it worse, and the filters
were accepted while trusted. And of course, a VF reset cleans
everything up completely. If you think it would be helpful, I can send
a follow-up adding a comment in the code documenting this trade-off.

Thanks

Best regards
José Ignacio

