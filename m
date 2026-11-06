Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962043;
	b=tLuH2GhBXpFjfuuJsIElJGVDSiwsOFyOfbEDK4NsEvEQuEs5piPXnnAQFRmdUmKu//yd
	 uRHlwwas9UWlDrAUx6+ZwWzhRLotrOOz+3yumfojrfIyx2zpKE9sr3v39H5NX9NAcq0li
	 3vZoGXauwnGZsw3VNF1EylLPOCWKWj6ooLEi40tTvq7zAmNC7R2Y2QR/Aqyo5qWwYrOhT
	 hJp1VrEab9i76NyqX6PUkjQKIdN5coh905pFcH4KQdiywBxK5mc5NsMX/w/OSUiwlaR7Z
	 ohdG91UUVQrJx/C5XJHprp0Jt41mX0AxB+Gb8ObyNYiPLCWNPZpfQsEE1+7/D1VuXag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962043;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=7qFOdyeTWjgv8cvpgwW3ZlyKG1+w40IKueRFwRIEoGI=;
	b=cBPhzZo6RaS63DgylSr17zEfh9w/fNNNawB2IoNBGrY/3YuFL7aDHKfKoaD3N1f38j1o
	 cSDKWt/bNPx9j4bW6fhQB46jUB+nyWonzMXmfWy+D9MAollPtW3HE8KlcRvYvmuExpx2M
	 plByR0UNuD18RKlZR1zPWcFkfF7JdEWtCpLom/sRFLLo5kJCQl9sQ0PvFNZAXe3KmSR/l
	 PPp8QRXqNzGrIIB5fFLJMD7WktZHaGznZpgDCmqoK/bQTWzSJLouFedqH0QU/1SXP0x13
	 v2TNtSGefSVV2XpRHqyvt3Ybq2D4N9Ss7QXnrgkhjOfJl+43G7WEkExSW4ehw8pzv4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RLgNiyQ9;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CAA606D827
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 10:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69CAA606D827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RLgNiyQ9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793962041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7qFOdyeTWjgv8cvpgwW3ZlyKG1+w40IKueRFwRIEoGI=;
	b=RLgNiyQ9yNrH4RcRJqDevNAgfhZ9Outu3zKGm9nbKiLk4zUQZzbdVB+lCryOeKkduIqV6i
	Tb6kPWD8sUI/GWyeQUD5N+lBu+CmIM8aXZ39Ap+Vb5oHRVliSH7dE0eoYVd7AV3QMDJRFz
	GwnacGToy6TqI8W9rJnQ8Jg+/XB05K0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-HExB2PTUOU-p9cgwNp6QIg-1; Fri,
 06 Nov 2026 05:47:15 -0500
X-MC-Unique: HExB2PTUOU-p9cgwNp6QIg-1
X-Mimecast-MFC-AGG-ID: HExB2PTUOU-p9cgwNp6QIg_1793962033
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C34618005BA;
	Fri,  6 Nov 2026 10:47:12 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0BFEB1956047;
	Fri,  6 Nov 2026 10:47:06 +0000 (UTC)
Message-ID: <308681fb-2c07-472f-ac96-dcb70816285f@redhat.com>
Date: Fri, 6 Nov 2026 11:47:05 +0100
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
Subject: Re: [PATCH net-next v2 14/14] selftests: dpll: add reference leak
 tests
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
 <20261105151852.1844305-15-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261105151852.1844305-15-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 11/5/26 16:18, Petr Oros wrote:
> With CONFIG_DPLL_REFCNT_TRACKER the DPLL core keeps the stack traces of
> unreleased device and pin references in debugfs. The entries do not
> name their owner, so add library helpers that snapshot the entries
> present before a test creates its devices and fail when an entry that
> is not in the snapshot still holds references afterwards. An entry in
> the snapshot belongs to an object of another driver and is ignored
> even when its content changed, since other drivers take and drop
> references while the tests run. A concurrent dump holds references for
> a moment, so the check waits for the candidates to drain. Attributing
> by name means that a leak of an earlier run goes unnoticed and that an
> object reusing the address of a freed one from the snapshot can hide a
> leak, which is accepted, the entries carry nothing better to go by. A
> second run alongside would have its devices attributed to this one,
> which is one more reason for the lock every script takes.
> 
> Whether the tracker works is probed with a throwaway device, which has
> to show entries while it is live and to drain them once it is deleted,
> so that a kernel without the tracker is told apart from a broken
> simulator and from a leak. The probe runs as the first test of the
> stress script, which gains a final leak check, and of the new
> dpll_reftrack.sh, which registers a device, removes it and verifies
> that no reference survived. The snapshot file lives next to the lock
> file under /run, for the same reason the lock file does not live in
> /tmp. The library mounts debugfs when nothing else did, like it does
> for configfs, and the selftest config enables the tracker together
> with CONFIG_DEBUG_KERNEL, which it depends on, and debugfs.
> 
> Signed-off-by: Petr Oros <poros@redhat.com>

Which dump holds a reference here?

The references to a dpll_device or a dpll_pin are taken in
dpll_device_get(), dpll_device_register(), dpll_pin_get(),
fwnode_dpll_pin_find() and by the pin registration, in
dpll_xa_ref_pin_add() and dpll_xa_ref_dpll_add().

The netlink dump and doit handlers in drivers/dpll/dpll_netlink.c run
under dpll_lock and do not take one.

Could the sentence name what actually holds the references the check waits
for, or be dropped if nothing does? The same sentence is in the comment
above dpll_ref_tracker_check_leaks():

[...]

> diff --git a/tools/testing/selftests/drivers/net/lib/sh/dpll_lib.sh b/tools/testing/selftests/drivers/net/lib/sh/dpll_lib.sh
> index ada10ee4394fd5..d851237bdac440 100644
> --- a/tools/testing/selftests/drivers/net/lib/sh/dpll_lib.sh
> +++ b/tools/testing/selftests/drivers/net/lib/sh/dpll_lib.sh

[...]

> @@ -622,3 +639,212 @@ dpllsim_setup_standard_device()

[...]
> +# $1: snapshot file written by dpll_ref_tracker_snapshot before the
> +# objects under test were created. Return 0 when no reference to an
> +# object created since the snapshot is held any more. A concurrent dump
> +# holds references for a moment, so wait for the candidates to drain. A
> +# timeout means the references never drained, the candidates seen by the
> +# last check are then printed and count as leaked.
> +dpll_ref_tracker_check_leaks()
[...]

Thanks,
Ivan

