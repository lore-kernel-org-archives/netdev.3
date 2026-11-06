Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962312;
	b=xhHat6DnGDD3+O8sL5SaeIVQTYlBx11f3/D6c30c1RqP5nXk7PgRmXGVHaP9/etkQDkP
	 lKug9l/p0YP+y/ub8r5DSlMNuvsPR5xIHCeIkRUotvCubN/Qg//wb6Q8sThZYiLc/bHdc
	 BfvhCIDxXRCCdt6oGOhsjub8G53f1d1O3OdPEaGT5Mfzx1RJ5EWmjpeEFzMulYE05Sgaj
	 P+f7wqFjL5Q5UD9sbZrB5trphDUh9r/bPT3cXLu6vt5JZ6Zofz+7ZievKCl2N2C+5seCh
	 UlLZmObX55gQJHV96bjW9qmWFHkEtAFRhi9knJiTfatGxI2+OCLU7bur3FCbu+MvPMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962312;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=3Zmh3zIeYQk1GlD5GX6rApJtvlUpIPOfF5SABfuGreY=;
	b=nKWUwHgfNu3J1Twhf4wPMfFzUZcOh+2Xh7cdZdLd167NJ42MiGxoBLFxvmT6Q8amSBzT
	 1sB7u4hlL+Gxif4T//Z2YSTYJCu4g8AKPOozgoJp9b/9GO7Yb09IDzF7l/z0WlzwAt0fp
	 cFMtlaI4hXnAEepO6WdHpQc7RBYx+Klt8H8nVPu8LjJC3LlSTPAvd0ghr3tEEOipg6QjF
	 bMJqCxwDFPtl1zur+7c+Kpd6r3xfCxSsCu1F/+lxDg3v8pC5qITwKdxfA2xtBenwp4z4X
	 5By06bw+7AlndNIQuk4z6bEI9JSi4t7TTEsORHIcYXf4uFLu/rVeLB8zeFdeqIPzP5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Af09+jWi;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDFF606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 10:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EDFF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Af09+jWi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793962310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Zmh3zIeYQk1GlD5GX6rApJtvlUpIPOfF5SABfuGreY=;
	b=Af09+jWiatuxD0PoBoGeJPMHGDP8PDXIaj4Vri95awC5erfcSpZOXTFPVvgIq9Xi8UAxP5
	sw1Mwj5b0CdZrZ0Wki5S92wA6DjnqXOdWnx7fX93IvXDlwh4NEbfqqgxcmBza4O4Jp/S7P
	BdVxxEMf+tCrFbPSIG32sflEGEoKH6c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-zgb1n4B6PGuYR7Q19CQRLw-1; Fri,
 06 Nov 2026 05:51:47 -0500
X-MC-Unique: zgb1n4B6PGuYR7Q19CQRLw-1
X-Mimecast-MFC-AGG-ID: zgb1n4B6PGuYR7Q19CQRLw_1793962305
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1ED0F1956051;
	Fri,  6 Nov 2026 10:51:45 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C5D661800480;
	Fri,  6 Nov 2026 10:51:40 +0000 (UTC)
Message-ID: <f3329ded-852c-489e-b585-db75a767f20f@redhat.com>
Date: Fri, 6 Nov 2026 11:51:39 +0100
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
Subject: Re: [PATCH net-next v2 12/14] selftests: dpll: add pin phase adjust
 test
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
 <20261105151852.1844305-13-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261105151852.1844305-13-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 11/5/26 16:18, Petr Oros wrote:
> Add a test that reads the phase adjustment range and granularity a
> pin advertises, picks the largest multiple of the granularity inside
> the range, or the smallest one when that is already the current value,
> sets it, reads it back and restores the original value. It skips when
> the dpll tool lacks the phase-adjust keyword of pin set and when the
> range is too narrow to pick a different value. A pin that reports no
> phase adjustment or no range is a skip on a device provided by the user
> and a failure on the device the script created, whose pins report
> both.
> 
> The core refuses a value that is not a multiple of the granularity a
> driver reports, the current value included, so a pin that sits at such
> a value could not be put back. The test bails out on that before it
> schedules the restore, which is deferred right after so that an
> interrupted run restores the value too.
> 
> The granularity is only reported by drivers that have the core enforce
> one. Without it the target is computed with a granularity of 1, and a
> driver may refuse it for a granularity of its own or for any other
> constraint the interface does not advertise. A refused set is therefore
> a skip on a device provided by the user, with the reason the tool
> reported, and a failure on the device the script created, whose
> simulator accepts every value its range and granularity allow. The
> test ends there, a value that was not set has nothing to read back.
> 
> Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Ivan Vecera <ivecera@redhat.com>

