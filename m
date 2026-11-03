Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710189;
	b=NrWlgo+89rY8zmQvC1tK9NQ7HDrl4PFXKbONUdR/rv+XqsqfRTtA8F7poGdCcB6PLQzc
	 OW0oNlrsIUlRhCPm8ejYQM4yycr3SZ/f7YistWVQoe/V5GYe7llY6bdxK7zFhQ/Rt1uI8
	 GQ+2vxvtoydBhVQIc8Pfic9g8joObPWhY7eMaTNLc6L+SgkRL4uuU1lmCcMvPBz/1O/P7
	 geUBpx3jDLjSedP32NZnwvLd8YQp/JYZCkpwXNGIMP5ULiy3Va+WOJZm7DQEC9zAdxEvn
	 jTgdWOpPKseRh5awQLfdYmNJ1CaCjA20yysV9nwIpyiYMg2jREWzx028+FIPxoSMdHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710189;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=myuQnKOqiP9L07B+scEBOciTR/Sw8p8F06G+sEEbi1w=;
	b=emFeewJzp9eDo5GAKB6wlc62kkE+GywzdrVHKttbBc5mSmKIylfIRXp8BA4Ux/NdXoXS
	 7gCrvuxSdYoiQiqdVSzrlC88mImsICL3jCj7ids1lmYvE86SHmy6z0XQev0WGCYpy9Xbm
	 EFCQwAfAhvHhX79UaqVuEblKnruOX1c0xoEWUpBZutDsOQegVzdEXpqlzpl3hW8frPd/1
	 l/Dl07ZEdgGwL7s9fnaOMkmQPpZcXbJh+QdSmN+VWUUw0gb441TU1LduICWLFk37DPfA2
	 294FkteVgVfz6RtytY7sOblksVZtjeleXJnidtNpywZeeFKQZJrfdST1ljcPwU0J3Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=goW1le5N;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Xww7JLoQ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9B2606D827
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C9B2606D827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=goW1le5N;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Xww7JLoQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793710188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myuQnKOqiP9L07B+scEBOciTR/Sw8p8F06G+sEEbi1w=;
	b=goW1le5NaWv5u0kf3qB9m8d3seBWw1jqiCSHfYyIJqnzffeBfmLJw9kBT7ttxrMdADDD4y
	m+7dNVgJjh274nOknKo4cwxHhZkwDBuQm0d+EY0Es3oC/batfarZP0NhA+OoR1utDFwL2k
	ba+3b/zSz+z1p5tEkLOhYIbk9jzU0kg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-KqhLklF0NKGNvlIfnIUMew-1; Tue, 03 Nov 2026 07:49:45 -0500
X-MC-Unique: KqhLklF0NKGNvlIfnIUMew-1
X-Mimecast-MFC-AGG-ID: KqhLklF0NKGNvlIfnIUMew_1793710184
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a9d51dc486so4604355e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793710184; x=1794314984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=myuQnKOqiP9L07B+scEBOciTR/Sw8p8F06G+sEEbi1w=;
        b=Xww7JLoQMeMT0Huf7Hi/NXKYvB12byum4d8AkaunCDsvtr1fiQ6OU8UVKa4Weoujoe
         FVWcwa+A9Tjf4Ihz2OAgsjh0ML09t1+i4kArRCa2ToN2uggyc14m1PCQt889XeS+OmSd
         ylhDzvW+16k/Vq0RHhjZGT/YROWPzWlvBJZbihCllk9h/Nb3yhdAsMCPUeGWkwe3GL5T
         9T8TvmlavoTkgdQQNr3SWdszdiiKn/NgsiXiMVE99OuMETWEKVb7gBImpDeQcfSYbrMe
         PxBCukwxgkqG7fdGRY/ttjFpBOd/Oux5DnG9ehYzZWu4KSR4aQ0L6wwKGA9/sBGjXPV7
         2thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793710184; x=1794314984;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=myuQnKOqiP9L07B+scEBOciTR/Sw8p8F06G+sEEbi1w=;
        b=ZYg5zYXjWi2tSXOqCWHWsRAsr2rcQW9sSIRHgWt2aURSiKiUhQOF0uJNyCpJMstom6
         bfju++S1dl+QW+1VN2fNIZCrE9qMd1WqYFPqG0dMEp5elorv35uioIBHCb7LmozCW6C9
         ySiMrNMLSiCi86Z8+0KQrq0kh4N6Tuqe6nixVH7eh/lDFbpbxU2k2MprR1ez6X+lA42D
         QtKGZN/Tt+Atzg4VP/rk2nphdgfLG13AkYTIAtI45O4X18E6k4ZC9cHYS8fR20wV4+F5
         mwF1vApVJUKLwR9x5EaRuxqewOTmxRNjewOCTjecj7KNZhRtDqNhGdN/4Kh9MQ8oJlV3
         GCEg==
X-Gm-Message-State: APuU4Z+F2wC0GXhxDCGVBqetw57GIEmDTZVqoZMH3S84UII5n/nq32Bn
	tzOEWimaGh4t0AoIrsZ9bc8R5QR1wwyO7rrCTuIq3YiQs1GtlLhhdSjVXTa3bjDTmNLFzgzkHJx
	V8rHUOzhHMbW297jNkPoPZD+dzwBwrEmDnF4rcLzpH7uw/XFuljX9Wt/3Cg==
X-Gm-Gg: AYBFou20wEItvfkQxE/ElyaCxCWd5wCGuHUdLxsodrsdhWFoF5i7RoBcvJPb6NmGu7Z
	y484YOlZR7z+u3XhvN8y9ICIG0qHrUN1rzqFZkgZK5AD+ERfvMbMw1iKPguXr3CwWlKG4RpfHPD
	AN6raz48ypbyJnUrShQ9i/GiU7NxNWLInD189HowzQHhK4kbHbdMpOes6HyCOFXZZlSdaXloDqi
	//6Gb54qFodvznG/FWTUugiwt9SuT3Q+3aO2J2QoHa1HroBnxRI3CB3ghZx/jvSXCGIofQB9172
	GvStBvfVxY2rzmpQTzA8VE6602Ul5Jr8H4p3b/wChQlxJ+UnU+HLWTCk5oJn/9kHosOmEMPBPhz
	wnia5zP7NyV3lY64ruqILRLWSShzdeUQ3/XKqziDwyRBAtw==
X-Received: by 2002:a05:600c:848c:b0:4a3:5da2:38ae with SMTP id 5b1f17b1804b1-4ac17a3628emr299088115e9.14.1793710183978;
        Tue, 03 Nov 2026 04:49:43 -0800 (PST)
X-Received: by 2002:a05:600c:848c:b0:4a3:5da2:38ae with SMTP id 5b1f17b1804b1-4ac17a3628emr299087755e9.14.1793710183537;
        Tue, 03 Nov 2026 04:49:43 -0800 (PST)
Received: from [192.168.2.75] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abebe33e79sm247611225e9.2.2026.11.03.04.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 04:49:41 -0800 (PST)
Message-ID: <cc1e3d99-a96f-4589-8541-5c8b9fb509b7@redhat.com>
Date: Tue, 3 Nov 2026 13:49:40 +0100
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
Subject: Re: [PATCH net-next 00/14] dpll: add a simulated DPLL device driver
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20261103093910.596225-1-poros@redhat.com>
 <aunT5wlkgVJ9xyTb@FV6GYCPJ69>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <aunT5wlkgVJ9xyTb@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/3/26 1:31 PM, Jiri Pirko wrote:
> Tue, Nov 03, 2026 at 10:38:56AM +0100, poros@redhat.com wrote:
>> The DPLL subsystem has no in-tree driver that can run without real
>> hardware, so core changes and userspace tooling are hard to exercise in
>> CI, and the pin-on-pin and reference sync paths see almost no coverage
>> outside the vendors' labs. This series adds dpllsim, a simulated DPLL
>> device driver, together with selftests that run against it.
>>
>> The driver is controlled through configfs, following gpio-sim. Writing a
> 
> Why not debugfs? Works good for netdevsim.
> 

I did consider debugfs, but it does not fit what the simulator
needs. The key difference is who creates the objects. In debugfs the
kernel builds the directory tree and userspace can only read and
write the files in it; there is no mkdir or rmdir. In configfs
userspace creates and removes the items itself, which is exactly
what dpllsim is about: you mkdir a device, mkdir its pins, set a few
attributes and flip it live. configfs also gives me
configfs_depend_item(), so a pin cannot be removed under a live
device. Doing the same over debugfs would mean inventing a little
command language in a couple of files and parsing it in the driver,
plus handling object lifetimes by hand.

netdevsim gets away with debugfs because it creates devices through
a sysfs bus file and debugfs only carries knobs on top of the object
model devlink already has. DPLL has no equivalent, there is no
netlink command to create a device. gpio-sim went through the same
decision and ended up on configfs as the replacement for the module
parameter and debugfs based gpio-mockup; usb gadget, pci-epf and the
target subsystem use it for the same purpose.

> [..]

