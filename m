Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6234E310620
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 20:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001359; cv=none; b=Qski1ep7eOShDICKMk2eTtpAVL/yQREINk6MERP+spIw+aAaHHAcD2pI+qOiAjvzqdDeh6cXMw+m7r2Nd99c2/rYTvk3l2uCBFI4X70J4ZwcLN4JaIveir2mlSPSjYAykj9Ruj9vwoEJ0dX5+IMp5hHs4AS1o9QaOf78l31tFO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001359; c=relaxed/simple;
	bh=ymfnpNknNGu+8+OhRFokfIa6c0wD/acKjITHF8BCjK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwymMlW9x0Q5TRw4v9VamoAQf7iIQN172xl0eubXMR4A1EbfjlzxCXgsG680kCEKeIo8u1UV2iuasX8SKz7H4/D8XKiPxGFV+aCySzhuf0nTQ9ZiP+WhdVlB0nBaPAv7se2+Go4+ODqTY58xFWP7NcuRKJA5+Efpkf6u0kp/5VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WP29sENN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WP29sENN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397941F00A3A;
	Thu, 28 May 2026 20:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780001358;
	bh=Nnn87YmuEEKoyQUq0thGK6Bwr5sEvpFopsea+M7Ir7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WP29sENNGVJ4nk2jJDa/oTJXxzXptDh+mukmlrVTPGgh+YxNWDw4hQRn1VYC5TTQq
	 ah7uxAPgwV6RTbfuqsA5UJl8hqDQkGUlEemkUFV9JSN3wj2hotDa8Mjlu+EVx5Up8o
	 Z15MRU+LEalkuKXc7WeJC9MuL8VsJxPxGrrO1JZoPODOmJCvufXiDaJ/uAv7QHdgng
	 6oki78lBy+26Rq3/vhP4n3ecSusllDMAjV/fimhKb0GK6BngHVmvZ3PES3SKPyVAPQ
	 469v0J27L7aYRYHOZpWFeLer+16MlHs9vK5dG4JUewKGcBTDBL+hyepCK4EyLkJwWI
	 RvTq1HkiOGaDw==
From: Simon Horman <horms@kernel.org>
To: kipreyyy@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	3chas3@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] atm: skip driver close callback when device is already removed
Date: Thu, 28 May 2026 21:45:15 +0100
Message-ID: <20260528204512.2742131-4-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526103659.86519-1-kipreyyy@gmail.com>
References: <20260526103659.86519-1-kipreyyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev

Simon says: Although the first two issues are appear to be being pre-existing
            the do seem to effect the functionality of this patch.
	    So I think all three issues flagged by AI should
	    be considered in the context of this patch.
---
atm: skip driver close callback when device is already removed

This commit skips the ATM device driver close callback when ATM_DF_REMOVED
is set on the device. It attempts to prevent a use-after-free when the
driver has already freed its private resources during deregistration.

> diff --git a/net/atm/common.c b/net/atm/common.c
> index fe77f51f6ce18..cbb87b9c10d2f 100644
> --- a/net/atm/common.c
> +++ b/net/atm/common.c
> @@ -177,7 +177,8 @@ static void vcc_destroy_socket(struct sock *sk)
>  
>  	set_bit(ATM_VF_CLOSE, &vcc->flags);
>  	clear_bit(ATM_VF_READY, &vcc->flags);
> -	if (vcc->dev && vcc->dev->ops->close)
> +	if (vcc->dev && vcc->dev->ops->close &&
> +	    !test_bit(ATM_DF_REMOVED, &vcc->dev->flags))
>  		vcc->dev->ops->close(vcc);

[Severity: Critical]
Does this lockless check introduce a Time-Of-Check to Time-Of-Use
(TOCTOU) regression that could still trigger the use-after-free?

If a thread executing vcc_destroy_socket() checks the ATM_DF_REMOVED flag
and finds it false, it might be preempted. Another thread could then
handle device removal, call atm_dev_deregister() (which sets ATM_DF_REMOVED
and locklessly removes VCCs via atm_dev_release_vccs()), and return.

The ATM driver, like solos-pci, could then complete its unbind process
and free its private device data in vcc->dev->dev_data.

When the first thread resumes, it would execute vcc->dev->ops->close(vcc)
without any locks synchronizing against deregistration, dereferencing the
newly freed driver data.

Since vcc_destroy_socket() only holds lock_sock() and lacks the
vcc_sklist_lock protection used in __vcc_connect(), can this memory
corruption race still occur?

[Severity: Medium]
Will skipping the ops->close callback cause a memory leak regression
for compliant ATM drivers on device hot-unplug?

Drivers like usbatm allocate per-VCC private state in their ops->open
callback and rely entirely on ops->close to free it.

By skipping the close callback for removed devices, won't the core ATM
code permanently leak these per-VCC software resources if a device is
deregistered while sockets are still open?

>  	if (vcc->push)
>  		vcc->push(vcc, NULL); /* atmarpd has no push */
