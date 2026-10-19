Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430351;
	b=4D1qN62vuPo1bR8/CJaalKGtJR4+ocXdn3Fj8RKMW+NYSj7ZDCrwtmaDfk9SHGDkhDqW
	 YZhZTFW8WovfJWJf9nRt/ORrh9KNZ4nFyTKnxTTMg8LXUKHg0vaAzi8sJu6jYia4Pn+dA
	 0FEJaiILi17DSxr7yZsQIL6IeZShvCd1PH111rIm6e8995Q0+B5rPUGg65tnY1eiLbeGp
	 yp9bcjzIgSZl/I8CWAzPHQ9kZ7WjvCIWkKyjKItstTM8otbsoXRSixhVUdXQIJD474N+6
	 lN0BaIU7B503lDN9QepYuVSbx/GE9ImsJClrQNU5ycaQxS2jEfqZRDiQKEnOjAFYN1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jba3iV2dXB3/kXchfQvlRKxAUIH1ypGrr1bYAqKOB4c=;
	b=N5yJ3IGyoo7eqYbJ6d+MOJEMrzBAR/48boyYHv3p9JT5alfFVfY+4XwCynUMkfVSc+60
	 OIMh2Oj/oyulg6zJYmI074cQXGaEAmEW4wm+9bfo6C7M8nybYTxA6nYp8N0fqPFWBUOBN
	 UpjCb19Pa7GKctKdn/7fDsyghFMeU9hq8yZ009EPI/9HqIyKZsL82Ysm8o0S+v6LIRuy8
	 LXo170tTuybvi9EivdtKNtaTF/GIgT3ArvvgLtRj20N08rZTGZggsuzJu9v9HWyTdruy+
	 syTkEMy5iXtBnoyiHJ4P4zCTSD8AwYNDjkbszo40JtOJcTY3IidWZm6RnALpaST2Uhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=S+G8q0oA;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467B1606A31A
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 467B1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=S+G8q0oA
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e8246b13cbso17988245ad.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792430350; x=1793035150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jba3iV2dXB3/kXchfQvlRKxAUIH1ypGrr1bYAqKOB4c=;
        b=S+G8q0oAUkKahBGJOeejH/6SWxUr+yZIa3wLWvf+jyvv+6AbnTAVGTpGlRE0yll68U
         0naxObJnXVihuNfCmh3qV+mPQbrni+UspHFg5pfCVGDY3/3t54tGdUy2Uspbu9mi6YPz
         IJyvGIGJJaBi37s5HE1unOtaB1m9ZtHOV+ouHxmVlsbghlotMUXQ41Jcd/1EW9NwQKez
         bZiLQL2fB5ST+0l0Q11ZwW16hXq7FPZVGKTHRCM2rl/nKUjN8UKgQKMn3MmpMt/eqf6g
         yGcSh0/G3PAT71/L/7kFBwDD9y/EbgryhKQomUeT1pkW6pBYgZwkMlpkywcQzTrSKwbW
         mpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792430350; x=1793035150;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jba3iV2dXB3/kXchfQvlRKxAUIH1ypGrr1bYAqKOB4c=;
        b=jK1MKCWIO7sqBCox3cjbUvzK6INleLCpT6mPgTjFdhvY/m9fSvD8ZuSDRBJi2k/PWz
         qZa7x7fejSAFeJkf2tEvnubnd6cxiWGAVS8E+wwg15fUw4PdX0n1/wPg9XuSAia15juX
         cqm1YyODqIRKetOj2ZgEYkp/QJj6roKc8NkNMi+ybabYUTNLhan5Zf4m2sDTaZsYax2w
         GDv625HX0BOz/WEfhiV+CmtOmjUwNSDxfn9kkeoXr74l/PQdd9L5L6pNbmjXRvYHBqGI
         zKjrvRLHT7+80vg5VvCcipSQoWVM2dHR2Gny2VlXSfnhpvsTyL8gXChe1w082/ASAV+w
         kd/Q==
X-Gm-Message-State: AFq9FYI01JUDKss3CtUYmiOpzZKvKDPNSSKBbC05dLtoa7cIEhwVfcfR
	fqqFdIbAD82nuAbEjLMsWAxMx86heiyKq/2SmdiBc8tRpFnhS8/OF0K5z6kOBrGYpH99r/kUkCL
	ORGCBfRM=
X-Gm-Gg: AYBFou14oZCjuP0vbCyCAT3S49SEAAp57jY3cOhVtLZFE1PmX3h3TC9aqs49XkVV5Ev
	qap3qyJHUq4agaNyrhDzpt0BsWzwh6uw08Lv2+0tkY4Uu2W6ItbggSpH7Zq6yBieTDYGjvcjjC+
	PgfFhr5/Ccla6hE4Cd4HCok/gPLTfD0UCv7OzfezWPRY1edt/zj3LVbyi2+TRoUxsKSasCUgOPV
	iBW77a+TYWGiEQyioYtFyzjlGoMLJ20teMa5r/IOjwPo8phHnYbE9Db0EVU3H/SOQfN5bIx1+9E
	onDqzI0mRMzw0sd08tKpzJGpAe1Mseda6EtHbypRZQNaFmgm5+aIvAXP2+ojTlcuzsjzHgKN7Ln
	1VOvwAFPrFaYpaSQJ/878CW9k9gOrYB2gpkNlOzA4M6OplbCI4tTCJS9ZV8wgfL6UeeQV/w0scg
	bP28WvvmvBjP2veySZ/TAqCRpcKpksj7hB/r9zKc2BAiqxgxFt34O1m/ZrTzqnCsdcSeR+fsmTC
	E27Bx5EkiWiOXEj6GDrvix21i0YHrCLqIDRS/fOCFYv0NZKV4TG
X-Received: by 2002:a17:90a:d007:b0:3ab:e789:ce84 with SMTP id 98e67ed59e1d1-3acef15a05cmr6743793a91.65.1792430350519;
        Mon, 19 Oct 2026 10:19:10 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d4004cbsm357642a91.3.2026.10.19.10.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:19:10 -0700 (PDT)
Date: Mon, 19 Oct 2026 10:19:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dave Seddon <dave.seddon.ca@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 3/3] testsuite: add bond slave LACP port state
 test
Message-ID: <20261019101906.6933fc2c@phoenix.local>
In-Reply-To: <20261011032906.1398174-4-dave.seddon.ca@gmail.com>
References: <20261011032906.1398174-1-dave.seddon.ca@gmail.com>
	<20261011032906.1398174-4-dave.seddon.ca@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Oct 2026 20:29:06 -0700
Dave Seddon <dave.seddon.ca@gmail.com> wrote:
> diff --git a/.gitignore b/.gitignore
> index e5234a3d..a16f6362 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -39,3 +39,4 @@ testsuite/results
>  testsuite/iproute2/iproute2-this
>  testsuite/tools/generate_nlmsg
>  testsuite/tests/ip/link/dev_wo_vf_rate.nl
> +testsuite/tests/ip/link/bond_slave_partner_*.nl

Just skip all .nl files there

testsuite/tests/ip/link/*.nl


> +
> +# IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE is a u16 on the wire; the
> +# actor state next to it is a u8. Each row decodes one blob written by
> +# tools/generate_nlmsg and checks the printed value.
> +#
> +# The synthetic 0x0100 state checks the full attribute width on either
> +# endian: a u8 reader returns 0 on little-endian and 1 on big-endian.
> +#
> +# row: file suffix | description | expected regex (!regex: must be absent)
> +while IFS='|' read -r suffix desc expect; do

That comment reads like it was AI generated. Wordy, awkward phrasing
and unnecessary.

