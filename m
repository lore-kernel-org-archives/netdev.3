Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962170;
	b=ijAhyOMgArrTL06si7p96W7W+vUgq3vJHuBFNDvgc7fKi3x9RF/4lO2VTts8m8B0iI8P
	 JWJU1TDuMnjcmzhz1P1MIrP7DYjmnuOXV8NVYkiEzVx6FeTa8qjbvn/Tb3YAmEoc8qrrF
	 Xyf/HpMdka0pHh0YFLcQN7I+CxbgdFKI9pO9nNVPwL6bd0auVMalKkWkYmDRQRWkyBT1G
	 dODNcPlKBhI+j6fuX0hhdu/EZaY0ytdCdfemk7wlq6kazCTxbweyK8dfE94gCvv07zD20
	 V8Vree7ZelpBs0bxAeCOgA/n8u7Fu96CputCwHy9lz/5jCVfrbPnmoYInklOqHbxVOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962170;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=8JKWuexccA6BFXNilr1htSwlQxoOPuIv3awSa5Dwgpw=;
	b=oi6OXqoUwdIxOvRI0FM8tbtfxZrIWEMYS8kITjqI40E8uiiwDQyKGP1vsEGdkf1gvSKB
	 cjNL+YnUMqAHJsEZWJA0LM1mKPGC2I0bpfzt0cEc4tReLpaD1L7ZyM5qDKS6IP0sLJxmB
	 rPInxvesjAbCnK+NY3cDG/xKKl9y5N+5E0+gn5qL07zAQ9pZsuTXHaXj/8IdiTwuZm/jf
	 QP4Og7ZQYj2uskdXAWcAw2XCPgkKGzsnorSxn1TbnkjFHx/uBvwmPD0CheF36J9Yir1sS
	 hR6ogNkj+4c/OcdMVOFP8w4FqCO8/ai0xqeq/3BH63AaHLg2Bkd5b3oQRk1sWfo+JxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UXZSXbei;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A65606D811
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 10:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26A65606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UXZSXbei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793962168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8JKWuexccA6BFXNilr1htSwlQxoOPuIv3awSa5Dwgpw=;
	b=UXZSXbeiFRdDRgcGmaJhz36zMEArs1EvmWQOI1sAg9siulM2Z4KiptWRy/Y4QJycTWKBf+
	2X4/PmKCGs5zBVEolAiFXANrl+TZyGDvaLTAnQPkWQR6XBPe5ZFFoDhlckxaYeVXpsJN2a
	kPTiX6Q8gJ2Elozcsrzd8wptiKs5Tm0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-eUGb9oCONyq46v7mn-krmA-1; Fri,
 06 Nov 2026 05:49:23 -0500
X-MC-Unique: eUGb9oCONyq46v7mn-krmA-1
X-Mimecast-MFC-AGG-ID: eUGb9oCONyq46v7mn-krmA_1793962161
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 516E218004DF;
	Fri,  6 Nov 2026 10:49:21 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D7DC447;
	Fri,  6 Nov 2026 10:49:17 +0000 (UTC)
Message-ID: <b0bd368b-6c63-4269-98ee-34f3e1638be6@redhat.com>
Date: Fri, 6 Nov 2026 11:49:16 +0100
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
Subject: Re: [PATCH net-next v2 06/14] selftests: dpll: add pin state tests
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Jani Nikula <jani.nikula@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20261105151852.1844305-1-poros@redhat.com>
 <20261105151852.1844305-7-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261105151852.1844305-7-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 11/5/26 16:18, Petr Oros wrote:
> Add dpll_features.sh, a script that exercises individual device and pin
> callbacks with get/set roundtrips over netlink. It creates a dpllsim
> device with the standard pin layout by default or runs against the
> device named by DPLL_DEV_ID, and picks the pin to reconfigure up front,
> the first input pin that is not connected on the device, so that no
> test touches the reference the device is locked to. The first test
> moves that pin between the disconnected and selectable states, reads
> the state back after each step and restores the original state at the
> end. It never connects the pin, which could make it the reference.
> 
> A driver may refuse a state the capability promises, for a constraint
> the interface does not tell. That is a skip on a device provided by
> the user, with the reason the tool reported, and a failure on the
> device the script created, whose simulator accepts both states. The
> restore is deferred right after the original state is read, and the
> cleanup handler of every script that defers runs the pending restores
> before it removes the devices the script created, so that an
> interrupted run puts the device back as well.
> 
> The stress script gains a test that floods one input pin of a fresh
> device with state changes. The library gains the state setter both
> use, which keeps the extack line of the tool in DPLL_LAST_ERR so that
> a test can tell a refusal from a failure, and a check whether the pin
> set usage of the tool knows a keyword, so that a test skips on a tool
> too old for it rather than every script requiring a newer tool.
> 
> Signed-off-by: Petr Oros<poros@redhat.com>

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

