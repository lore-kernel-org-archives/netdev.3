Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962333;
	b=zT4C39Cx/AWJQg0ZsEJxyLrKfHgZvFb8gxxtx0wMBlCAu6jUt2gU6eM0GauznLQ2Zlep
	 qqGtAwfvf8B+NYhTlM1hhAmHsSz4YJwH2Z4SEWSDRU1Syd+hcxlPMRqhNlOruDkp1OFyp
	 Rk7crZct9ULME+HMUkrInbqgvdsHLYnTZHJJ+wwBxaycdpXSf+sYc1E+PpjitXewMBolg
	 5PSQdHPgUav1Cqn2Tm6d5MLKngXaWR1rBcIar83wUqYn7bzBeftjsOJsa0fLeHANnrYyt
	 W3xqsjWRQla+P3ojcqzQrODtM2OqD33Ss2sj0vRicvJy/urqNVfNefyAx3c5b5EcHeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962333;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=BjHfKACEWw1yT39SIoyzSXqMcGaGQJy4fXAp5Zhpq54=;
	b=EcGTU6p7lJGzQkn+7q2rJGXOeYnlY1K9fXGmLNEZdwuHF1KtWSE8xcj/tXXPy+2ebvt8
	 xBFqBfQajZzr7DYO/K3jUM9bTU5ATp2FucKMHK4ZVCBZ0DvAt7J7JyWNwKCCqmyL2VySv
	 kVQsJLDzVnAurDizEZxlHBkClUIiEpVx55mGFz5++em2yD8ReZnIVtNzIeszECYXuZcTF
	 CnTFqfOQEWKXbSoC2TnGfXLsFruDYUb7E9rLz7j7j3YIAz4B2/ww/Bk8yXatm/SZ0L/w0
	 /zClg/eyqtWEVrmGRzHLEZQB2tycaMzFjOBa8uuQ7ipD95nn+NFkVibVjVLl50ma+0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CcR2Uxkx;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE03A606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 10:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE03A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CcR2Uxkx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793962331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BjHfKACEWw1yT39SIoyzSXqMcGaGQJy4fXAp5Zhpq54=;
	b=CcR2UxkxqUv8tsY+qgnG20pmmEVgDuuMLLjHiw3inSsMtiFKce8JJKkDKozuwhxWU5eiAk
	/NMWEp1ENC941fh0ChxaAuglvRj7jv2izt8ZGYf37JEHJpOZDpqA0Dak/NPltKiXJtUkBJ
	xP8nhaDULawzlTHIkOPlEdNX7d+oF6c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-y7HnwtcQOgKp0V4Lpzfjdg-1; Fri,
 06 Nov 2026 05:52:08 -0500
X-MC-Unique: y7HnwtcQOgKp0V4Lpzfjdg-1
X-Mimecast-MFC-AGG-ID: y7HnwtcQOgKp0V4Lpzfjdg_1793962326
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 480871956068;
	Fri,  6 Nov 2026 10:52:06 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 30D64187C371;
	Fri,  6 Nov 2026 10:52:01 +0000 (UTC)
Message-ID: <5314bb81-f271-403a-b4cc-f2dd01750b3a@redhat.com>
Date: Fri, 6 Nov 2026 11:52:00 +0100
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
Subject: Re: [PATCH net-next v2 13/14] selftests: dpll: add concurrency stress
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
 <20261105151852.1844305-14-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261105151852.1844305-14-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 11/5/26 16:18, Petr Oros wrote:
> Extend the stress script with tests that register and unregister
> devices from several processes at once and that keep a number of
> devices with many pins live at the same time, checking that every one
> of them is visible on netlink.
> 
> The workers run in subshells, so the parent cannot track the device a
> worker has in flight. Each worker removes it from its own exit trap
> instead, and the parent reserves a range of clock IDs for every worker,
> so that the devices of a worker cannot collide with those of another
> worker or of the parent and whatever a killed worker left behind can
> be removed by name, at the end of the test and from the cleanup
> handler. The handler stops the recorded workers together with the jobs
> of the shell, gives them a few seconds to run their exit traps before
> forcing the survivors, and goes on without a worker that does not die,
> since one stuck in the kernel would hang the teardown. Deleting a
> device treats a part of it that is gone by the time its step runs as
> removed, so that a removal running concurrently with the one of a
> worker does not turn into a spurious failure. The workers inherit the
> open lock file of the library, so the lock is held until the script
> and every worker have exited.
> 
> Signed-off-by: Petr Oros<poros@redhat.com>

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

