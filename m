Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395265;
	b=nSi2Np02qFV5BsJd5Nx3JtKDM5hvrnjSmOVE5cmojnwRFS0tSqvgKU2fxe2HWOcUCE79
	 Nt2Jm4kQTIfKzWIFGxyP+rkRAEQaz5pe1+GIT8ScghQW9RA1VGq+CUhdwa8QA+Xp0aUyj
	 4G5jd43RE/nFSmuNedK29FYNHNb+GayWuMnUR2Z45bYUX32C3hmIP86vzWleNvYyLSsui
	 7dhapHVCgCUK8gnf86BpI9pOOI4dIraYnzSQQbKGedkARa4D1IMMzCjKc2lR6ofVA7t4R
	 xGdC5472RHw8PG4keDLNIRca/PHaVKJA8Wlkq0b1fVE1nLikifx6pfiksPNMh5cHMhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395265;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=qg3J6V8yVsrpDP4IPe5+8PWSFroLKLf+tnGolm3Dn0o=;
	b=2je1HToZgbFj5PhMXHdnGSr8DMr35uz2k0aZm55Q3VXTTkngqCmSubF+cDo8410xJT8N
	 gh6C/DP8O+v19Xk9dV4yRXhHbR4twRT+sTljFt5iL1wGPcu2ktouJ2J1aIOSW/5NkholJ
	 j7edUXNZbEzFX89HbawABYY4HoR2+IQWGTq+bd4AOLdLV+DZsx+BYy+r+56XE0gBYLF89
	 U6L/k7R8aAzfoRI3EeK0cT2BCjtQLl3CjbOwIDLNdLLF5ojD2UgcrkSzppYl/gVNfv7s5
	 xjGm4EYYPY29Kbn5tYpfWzCp9/t3nWhfNMekP7RsZS0V2qXpnYfj33wrwQ2DMVauVDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mrzgs+3Q;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F15B606A337
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 11:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F15B606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mrzgs+3Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794395263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qg3J6V8yVsrpDP4IPe5+8PWSFroLKLf+tnGolm3Dn0o=;
	b=Mrzgs+3QSnGwQ5PFVKRAQKsfBfim5DHfAwihn50cumkqsjnWutcP3jhGzWCPOFoGo6a8oD
	gq9+C1Y/Ky8LoE5L6m+eMPlnx/JLK18ktNHLSjjzGWBEqr61v4H9PHa1VEsBrf1Vz4X3Q4
	8WztauzoOOj4bBJC6sounHeRZXRIpdk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-J2onJeQLMJ27aPHD_IZPJw-1; Wed,
 11 Nov 2026 06:07:42 -0500
X-MC-Unique: J2onJeQLMJ27aPHD_IZPJw-1
X-Mimecast-MFC-AGG-ID: J2onJeQLMJ27aPHD_IZPJw_1794395259
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E581218005BA;
	Wed, 11 Nov 2026 11:07:38 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 98DE31956087;
	Wed, 11 Nov 2026 11:07:32 +0000 (UTC)
Message-ID: <10769f32-0570-484b-a518-144fd3bdd4b7@redhat.com>
Date: Wed, 11 Nov 2026 12:07:31 +0100
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
Subject: Re: [PATCH net-next 10/10] dpll: document locking rules
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
References: <20261106121005.1327603-11-ivecera@redhat.com>
 <179433321053.994134.15233379643090486121@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179433321053.994134.15233379643090486121@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11/10/26 18:53, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The new Locking section in Documentation/driver-api/dpll.rst
>    covers three cases where a pin callback reaches private data owned by…
> - [Low] The new driver rule in Documentation/driver-api/dpll.rst (lines
>    716-718) says notifications for objects outside the callback's domain…
> 
> --
> 
> dpll: document locking rules
> 
> This commit adds a Locking section to the dpll driver API documentation.
> The section describes the dpll_lock and per-domain lock levels, the domain
> each driver callback runs under, and the rules drivers have to follow. It
> also adds matching notes to the kernel-doc of dpll_pin_register() and
> dpll_pin_on_pin_register().
> 
>> diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
>> index 7c117ae37cc1b..40d5037ff3bb0 100644
>> --- a/Documentation/driver-api/dpll.rst
>> +++ b/Documentation/driver-api/dpll.rst
>> @@ -675,6 +675,50 @@ In the error path we have to rewind every allocation in the reverse order:
> 
> [ ... ]
> 
>> +Callbacks of a dpll device run under the domain of the device. Callbacks of a
>> +pin run under the domain of the pin, whichever driver registered them:
>> +
>> +- A driver registering a pin of another driver with its dpll device has these
>> +  callbacks serialized with the driver that created the pin, not with the other
>> +  callbacks of its device, so it has to protect the state they share by itself.
>> +  A callback stuck in such a registration stops the domain of the pin.
>> +- The parent pin of a pin registered with dpll_pin_on_pin_register() and its
>> +  dpll devices can belong to another driver, so the callback must not
>> +  dereference their private data.
>> +- The frequency monitor belongs to the dpll device, so only callbacks of a pin
>> +  of the same domain registered with dpll_pin_register() can include
>> +  ``.measured_freq_get``.
> 
> [Severity: Low]
> Should reference-sync pairs be in this list too?

[...]
> Could the documentation say whether a ref-sync pair may cross domains, and
> whether ref_sync_pin_priv may be dereferenced? The parent pin case in the
> dpll_pin_on_pin_register() bullet already has an explicit rule like this.

Yes. zl3073x and ice pair only their own input pins, so no in-tree pair
crosses domains. v2 will add a rule that both pins of a reference sync pair
have to belong to one domain, as the ref-sync callbacks of a pin get the
private data of the other one.

[...]

> [Severity: Low]
> Can a driver follow the work item suggestion safely without two more rules?

[...]

> Here the writer waits for the callback's read hold. The work's down_read()
> blocks behind the queued writer, and the callback waits for the work.

Right, and if the work notifies an object of the same domain, it also
waits for the domain lock. v2 will extend the rules to waiting for a work
item that makes these calls.

[...]
> The second rule is about lifetime. The text does not say that the work has
> to be cancelled or flushed before the target pin or device is unregistered
> and released with dpll_pin_put() or dpll_device_put(). __dpll_device_put()
> ends in kfree(dpll). A work item that keeps a struct dpll_device or struct
> dpll_pin pointer and runs after the final put would touch freed memory.

This holds for any work item that keeps a pointer to a refcounted object
and is not about locking, so I would leave it out of this section.

Thanks,
Ivan

