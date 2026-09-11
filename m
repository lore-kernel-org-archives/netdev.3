Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1874364038
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139419; cv=none; b=Fnb7VyicdBUrXQYpCtG+UykAUNWBXoemMu6YDu2B4QhMRPsfKbgbAkCLk1wA+DpShONiSwq1ctXX8DtEeLB4vfmU3Y19i48MJrf3V/9yHy5twbveNZOFwkLIKHMovXVOH/rJOan71sRPj2Vc5QqBtP/sO9H6ZBGNe2nBxbyqbXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139419; c=relaxed/simple;
	bh=mqiwDcKpOaRNus8j/Fg3j0JoEM5rH/wkoPe7vyjGseA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+dx/ZkJzUP7Y2T5sE6rSfjHmks2EtrtjD8MNNBAVH6GmaerN0YgLNGZlOhNw0b+2u2mubu3FqD3rFx36lBiMV37lkMyO8+uAQgQAbY8VBlpb/IV0JMD/KbAnsEpm5e9HBAXdPSBl8logJH8UAS4vj0nrm1h+CXO9MsgYgIdQc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=kK4G/F9w; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="kK4G/F9w"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7f4f0cfb33cso740181a34.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789139415; x=1789744215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cMKSvjVBgJtd6CjrRqlh3dJgvYQUN3eoWH2kuKct2qs=;
        b=kK4G/F9wPPusW8S1G4rXbeFmBv+/IN48Euc/NhlP+M7DENbx5tgQNCT9J3oNAowLsx
         ugow5y7Oiez1bisxwk6MJ2UIRxoPG5gZPnQYO5mCqAAwB5ZjhTKjRtSJs92RM0yZ+yt1
         CJq1uT7goVyNFuQ15NS/hMr4b4T6bt3YCeoRlMJFQ7IEqkHbZ4NJhB6NMfJqRVLD1Czk
         9QzeEZ4YV7Q7JCuFCRVKamzfNym6sf3Y8yL7V3kKj5ns7po0oiAUVN2UIcw6SXz8dO9C
         3U3VoEuO9qcaMhml2ivm5wRn5w9ISrpjEa5184/d9LUBlicwmSuLk0s6OT0CZ7OZ/T/e
         9zNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789139415; x=1789744215;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cMKSvjVBgJtd6CjrRqlh3dJgvYQUN3eoWH2kuKct2qs=;
        b=LUmoHAD81O3NQsi0CsMlrPWZA3fAe42vbQDC0TXcWSoQGf84RJVdFMrICI0005E09K
         9NFDhROuNI9zKiIqYU0LFnId9Xy3JnVbJ18eHx+vRfWc7f2Fb9Rwapz1uXAsRhHSUVg8
         3x55SnrC4FLYwc5jWOqCQnsCnWy5kOcq+6J2jmUSUeuiSvejfFBWf/Lca1n9VzIzDFcQ
         pavlOWC9qmv2vIdg8nFh1FQEiWlewvpWQCss8fYOhK4ZfvL6fmY92QRUBEaW8PfL/pEx
         glTWZVhrgMjGsergfpJxPCkqxfqiGW7UMXx/IlKyvPOsnF1Y43xe+bwdwJ6VyxZB93HA
         VetA==
X-Forwarded-Encrypted: i=1; AKwUvBzuzeCDRFrRC5+R4QwDWzcc4twocDj7o2wjCCWG2Qmqzdz24JxY56iJHsi4tVIU3KijRTSyDzQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mGlZjMTJ+aQUXRWd3EmnhGFAl5uQQE3YvBTqTQwJYvUxgGFn5/
	BQS8cM3CljS1txNFUBQJe3wT1jS7PIeMpt4Ul1Z7a1CRsKBv+kvFNSiKvPIJrEE9++o=
X-Gm-Gg: AYBFou17hb2eAPhm0cKo1AH4UUTI51JOEutLuB8ioK/deAmE5N3GRHG0/Va3TjEY3Zg
	WMHMzs+k2KTkHsjm2g2QXlQzMZj7+3vWtKEJR1Hlk/fSP3YIewGhsAkWS9DCfjEwKLRZD5yasCQ
	v5tNLITewFQc/28yGDuYYWX+9KaH1BrPebc4IEDYPTVFTyOzy21DMbFB3K7Puoig7649ftG7Fyj
	aa9Agf1ceoSaLq5246U05Qfzf1KnUlsAYPx55OqsYhNvaUZGDouUJOryWqH4WLbMT3bU+cxanwX
	BkeP3X2nCjlGzyBSr5CQ4RWO1WcpcVDblTK4fUCcxY8zDVz40BuAfylDdYVM8OGhB62G/qe2Ql4
	A/Mvi/gdXsWBkqfcY6yzzqRMur+Dr90PbSVF2/QMasIktHNI20t98NHYdMEbXLOyGwJGouEczqp
	YA7K5V+tZg4rTExbpStSalOE4JKS5UMQD483o9YsGCZvJV9hpO9pNTtba5AY6eT9OP8SsfI2sHY
	NEkn2ylTUf5E8C5wazD9U+TBMvkdw+ZLO0NTFp28opHTHqY8HwcRSct
X-Received: by 2002:a05:6830:82c3:b0:7f6:ec23:7956 with SMTP id 46e09a7af769-803fe1bd730mr7936240a34.2.1789139414671;
        Fri, 11 Sep 2026 08:10:14 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f6d1875csm2548656a34.22.2026.09.11.08.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 08:10:14 -0700 (PDT)
Message-ID: <258d93cd-a18d-4860-bab7-2c9c7d43a015@kernel.dk>
Date: Fri, 11 Sep 2026 09:10:12 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] block: Include error-injection.h for
 ALLOW_ERROR_INJECTION()
To: Petr Pavlu <petr.pavlu@suse.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Simon Horman <horms@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Francois Dugast
 <francois.dugast@intel.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, linux-block@vger.kernel.org,
 netdev@vger.kernel.org, linux-api@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260911-module-include-error_injection-v1-0-5da895d8c84d@suse.com>
 <20260911-module-include-error_injection-v1-1-5da895d8c84d@suse.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260911-module-include-error_injection-v1-1-5da895d8c84d@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/26 9:04 AM, Petr Pavlu wrote:
> block/blk-core.c uses ALLOW_ERROR_INJECTION(), which is defined in
> asm-generic/error-injection.h. It currently relies on this header being
> included indirectly through linux/module.h -> linux/error-injection.h.
> 
> Add the missing include in preparation for removing the
> linux/error-injection.h include from linux/module.h.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

if you want to shove this upstream somewhere else.

-- 
Jens Axboe

