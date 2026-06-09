Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C734183B3
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012424; cv=none; b=Lliyy480086zmLdxV+cV+D063Ox+HURbwiQABmIaNA8OI8BhfZXkQxApKpsU9XptNI9kIjlzWA/Yhghh4XotCWa75VfqFOQ6zAlkCej1vk3xv+NmB9Cg6jLo/UUTzPJgRebouhge750pGAuLhPibpVSIZGZhV3YpFKakWOkl0jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012424; c=relaxed/simple;
	bh=wtjPJAnglYI9Dj7GB9EESnje7qeI4+zON/gDJ4GXSSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aE5CIWukbPCNcCekenfgrbrv9CtPijtoIHiqO8p77PS+44g1ObM2O6O5XuMvm9T+98mkwXpYNmEXBR1CdLB0TgCNhEw26e59p/ZUEUKhaBtx7M0oXNjnsR4W2KdZdYVfS6muGyIC7BFALk7jzhRFMHGYGwlnMU0wnYcYc4DpgOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FmmnDPqt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bWmDiR65; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FmmnDPqt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWmDiR65"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781012421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=midNIA+cjqOgSDgw/FW1wAANg34nkC9zllETKh3Fse0=;
	b=FmmnDPqtPrQRhm7+72NeH2vH+ap0BywnGm4gNwtTwQED3ag+TVRfWFfsHr50A3rxrAS6/0
	2dYU/f1yhaL73+5ztDlHovULoUnimAY7W+EB4LCwphcnQgBztfuABBKZ1pAm21vPxiVcFJ
	hbmUX/oZIQXIHpAe2GzVaiQZVIPT4yw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-rdUgGUZIOSaNaxnPSJQVBQ-1; Tue, 09 Jun 2026 09:39:38 -0400
X-MC-Unique: rdUgGUZIOSaNaxnPSJQVBQ-1
X-Mimecast-MFC-AGG-ID: rdUgGUZIOSaNaxnPSJQVBQ_1781012377
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45efa2f7009so3533867f8f.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 06:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781012377; x=1781617177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=midNIA+cjqOgSDgw/FW1wAANg34nkC9zllETKh3Fse0=;
        b=bWmDiR65oxjrzYfYB9/K6Cgwjn/lGEhXG+AGZD2LGMnkPoh86/qlSAxVs6DOGJfHLd
         gSwRryUxlZj1Nx3zVXbESQ6nph9YIfRxGnjJNWWNvnQcDrjdk5hYnlE9PbrBaP+nDTEj
         RSqsYV8ewQ3AGJ35JmaEGcT0HP4qQLe/jvCWSZJDYZH5S4A6Cvsv+aGufSpPKTh/cmcj
         6k8M/YVqYUguE9OMZicIj2rMJ36KiAe+WBWEp/it1gTlyeUsNGjozIuKmZGL0KvmwTVM
         CPUyx2ZW5Qx+iwqZEyNr5GyEZtHI/lWNV39zcAxaz+4P28fYvPieXnkbSf8FnwRaVWOy
         aRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781012377; x=1781617177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=midNIA+cjqOgSDgw/FW1wAANg34nkC9zllETKh3Fse0=;
        b=fkO8gvzRwx4jZOzimwoco/vAutfM91qlCO5RgD6ZkNUcfIqIgTVlajjHV3HPhNklQo
         XA344WYEG4KUBOgbfAyt/TgGsNfUdZnrTZ4XkR8oDKHrbwojhUKUNwF/Up6M+FLbZ69v
         F81C93oH055hPRuF3T4nqRyV+2fVTKVWkcfdXDYuIffe9QpyS6k0JJdCXh2yZ/f9DQHD
         NxrG+ficMq3hFeizKYR0Ry5/kBDjpORAMHhr1ISODGOhZYAQgIBcAs2GF2csfB+PhtaE
         DGHe14b9Tn6s86ZKPfE/xNDiRTcKe4GTHB9HkbF4yWUfGXhpHSlswU1Y1b+U76/+gZ27
         fvFA==
X-Forwarded-Encrypted: i=1; AFNElJ/bSXizHv+zgJ+i3H08913PYElN05+syp/7EI/+yagmH+YEfO2J2INWKMm7TaXjFmUgjxNmP9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YykaJcb611x/0ZxVRaI09fe68tR8nN/B8P6BYntuFFkbye/N+6B
	GL1y/SfIt0qbZhBzZB7fc9CLUbNimaHADCiRhfkk7elVwbxCJWAO0U9SM+Uy0WwnAR5K8sX5/dx
	mLS82S8M8N01H+dVRuEeCYMSG9SbiBw75LYUXj9b4SU26vA3yXPJu+GEEHw==
X-Gm-Gg: Acq92OENvqKXEX/isPR5PvLMakRXi6CAR7S6BqiVZlBQvXXJB6ZKTgYETX4wLf8ZH+0
	1fnhrbH0BERxCemUAZ2xyv1vi+nQ+RBbPlpOnvOJ3T83bYHMhyhYOkeR9w38cDp6ceHj3T/A/cd
	0YJfVliZAHP2YTNr0QLZsg9fKem9mAlZjH2zmFFj5ZeYogOx6wv6P5y7o4v06BMn/ijzekub7KF
	Q7H+UjI4LYqEGpJW9IG6yOl6Yr7uAiqhHSe6QRJkBdx4KoMPiA9qUA9IhODKkg9M9OVLehLte8y
	6unmTRkH3JKwNSMNRPI8lMu0biC5NA/5EUwNJSyZG6XoS+o8ZvepJp/3pgdH1y4OppGItHm8OwA
	jHLv3xzUo0St/5X5E54LIuoqbQQSmVwR7U1eEWp5gB4TJIVSHRoE6gCSY1GmUlV80LQ==
X-Received: by 2002:a5d:5270:0:b0:460:edd:ca89 with SMTP id ffacd0b85a97d-460306091e6mr24183878f8f.26.1781012377319;
        Tue, 09 Jun 2026 06:39:37 -0700 (PDT)
X-Received: by 2002:a5d:5270:0:b0:460:edd:ca89 with SMTP id ffacd0b85a97d-460306091e6mr24183842f8f.26.1781012376909;
        Tue, 09 Jun 2026 06:39:36 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344762sm67110899f8f.23.2026.06.09.06.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 06:39:36 -0700 (PDT)
Message-ID: <c6eb816c-3f2d-4705-82ea-8c2c0ad70ded@redhat.com>
Date: Tue, 9 Jun 2026 15:39:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/devlink: Use strscpy() to copy strings into
 arrays
To: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>
References: <20260608095523.2606-13-david.laight.linux@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260608095523.2606-13-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/8/26 11:54 AM, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Replacing strcpy() with strscpy() ensures that overflow of the target
> buffer cannot happen.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
> 
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
> 
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
> 
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
> 
> Note that all the changes are only compile tested.
> 
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
> 
> All the patches are being sent individually to avoid very long cc lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)
> 
>  net/devlink/port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/devlink/port.c b/net/devlink/port.c
> index 485029d43428..108926d3f899 100644
> --- a/net/devlink/port.c
> +++ b/net/devlink/port.c
> @@ -1222,7 +1222,7 @@ static void __devlink_port_type_set(struct devlink_port *devlink_port,
>  			devlink_port->type_eth.ifindex = netdev->ifindex;
>  			BUILD_BUG_ON(sizeof(devlink_port->type_eth.ifname) !=
>  				     sizeof(netdev->name));
> -			strcpy(devlink_port->type_eth.ifname, netdev->name);
> +			strscpy(devlink_port->type_eth.ifname, netdev->name);

Given the above BUILD_BUG, I don't see how this change can help?!?

Generally speaking, I suggest restricting this kind of tool-assisted
changes to real problems (if any).

Thanks,

Paolo

