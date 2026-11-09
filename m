Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232625;
	b=lD5rPkW/elAyx5Dbmlw376SRcwSF43gyWNoUp49p3v+M2DL0CWSKRalS7aI1at12Yk8p
	 J2NenVt14am7ienzANw4TJVYTYeqtp/lBoagXQDHr4bXvqlEK0T7DJtg44gNWaHtdTlXS
	 Uz6JKccIzuTZN0V84tnPTlv6ItHnUV/iCcGephAFecxCyPBlLHIrkOkO3aCy61CSFEUU7
	 FqD+f6XNIFThB+R64wU3SAzrvARsW5YtCapxZHGktKdY11BlsEtyaL3OfB2Oc5R9/BfXM
	 97zAJ9ylT7GOF10nmR7VzuVfVtgEtyDf0racBJ25xw3ZIFfnq6xOWbq+csxIhaetIRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232625;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=+Zlx9UXTcVUvxZSzHHlcX8ufFirWkBP9ER+pKSktKjY=;
	b=hMZxoi1sC/ap2n7pAjV+D4cSlvrdksb2BZ373GiN6bUaMqMWM+DlxuBRLfb3oIyKv+hZ
	 ZFjAIjnDt35aMvxIwvUYtSSxhWittJp5UDOdLEVI2TWACXvqx4wJuLjVFDyQGpIL9Ah1C
	 TuS9Z1V4BoG8mXhPu4+w9PBRgrZNt67+o/Xno5HX2OZm8mVYwPrHmhGSOBbGttkAZ7AyK
	 y4iivTa+eyjNSvvbpkIBNDfsFuAYfjpmDUlUkU2pqZWhJU5D5h2A/MTaK93vvXYpIbqH3
	 NCIoQXbMiXvLeCFuFlhB0f8o24HZcq8hYQfZznCO8c631+P6bOX4KnXehZRFOYd/5Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b4+PhXR0;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014C1606A32A
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 13:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 014C1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b4+PhXR0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794232623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Zlx9UXTcVUvxZSzHHlcX8ufFirWkBP9ER+pKSktKjY=;
	b=b4+PhXR0qtQGrKdVBKDvbXVZd+F2RiskVUWFZrbYZDLzMyys4lYr3z8dutU1X62eCDZfsr
	dh1AqSkMz4AYT+fmFMf9Arm6nAuEkodmAlhpZ2r1m2TGIo0ouZ72tKH9ELhcxqoj5Vvz/Y
	unQdyv8t93F93vOV5eKK+l+uMuSXP0E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-NdtykzX0Mjm6uDMm8botRQ-1; Mon,
 09 Nov 2026 08:56:58 -0500
X-MC-Unique: NdtykzX0Mjm6uDMm8botRQ-1
X-Mimecast-MFC-AGG-ID: NdtykzX0Mjm6uDMm8botRQ_1794232616
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDBE71956062;
	Mon,  9 Nov 2026 13:56:55 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F49B1956087;
	Mon,  9 Nov 2026 13:56:50 +0000 (UTC)
Message-ID: <1337732c-865c-474a-9d3d-456bee396449@redhat.com>
Date: Mon, 9 Nov 2026 14:56:49 +0100
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
Subject: Re: [PATCH net-next v3 02/14] selftests: dpll: add test library and
 device lifecycle tests
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
References: <20261109093523.931201-1-poros@redhat.com>
 <20261109093523.931201-3-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261109093523.931201-3-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 11/9/26 10:35, Petr Oros wrote:
> Add a shell library for DPLL selftests with wrappers around the iproute2
> dpll tool and around the dpllsim configfs interface, and the first two
> test scripts built on it. The library resolves devices by the clock ID
> chosen at creation time, since netlink ids depend on what else exists
> on the system, and the dpllsim helpers restrict the lookup to their
> module, so that a device of another driver with the same clock ID is
> never picked up. Every query runs the tool first and jq on what it
> printed, so that a failed query is told apart from a missing attribute.
> The library mounts configfs when nothing else did, and the exit trap of
> each script undoes that, removes the devices the script created and
> runs on INT and TERM as well, so that a timeout imposed by the harness
> still cleans up.
> 
> Two runs of scripts that create dpllsim devices would share the one
> dpllsim directory and could draw the same clock IDs, so every such
> script takes a lock before it mounts or creates anything and skips when
> another run holds it. The lock file lives under /run rather than in
> /tmp, since the scripts run as root and open the file for writing, and
> a symlink planted in the world-writable /tmp would redirect that open.
> 
> dpll_basic.sh checks that a device reports the mandatory attributes
> over netlink. It runs against the device named by DPLL_DEV_ID, the
> first device of the driver named by DPLL_DRIVER, or the first device
> that is not a dpllsim one, and creates a dpllsim device when there is
> none or when DPLL_DRIVER asks for dpllsim, so the same script serves
> the simulator and real drivers and picks one of several drivers on a
> host. dpll_stress.sh is simulator only and exercises the lifecycle
> paths of the core by creating and deleting devices in a loop and by
> cycling one device through repeated register and unregister
> transitions. The dpllsim MAINTAINERS entry covers the new directory.
> 
> Signed-off-by: Petr Oros<poros@redhat.com>
> ---
> v3:
> - move the selftests to tools/testing/selftests/drivers/dpll, next to
>    where the drivers live, with the library in that directory as a
>    TEST_FILES entry; the TARGETS and MAINTAINERS entries follow
> - add DPLL_DRIVER, which picks the first device of the named driver
>    or, as dpllsim, a created simulated device on a system that has
>    hardware DPLL devices
> - the Reviewed-by and Acked-by of v2 are not carried over, the
>    device selection changed

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

