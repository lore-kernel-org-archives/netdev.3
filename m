Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793763337;
	b=MXbXZc54n2h6QvbkuYqK27Ydd4k3/Aj8lqlo+tBdshCX4vIR8bkILF2jCcgCTlHLFrYo
	 6L44cjwqxqgH4KvZZEIvw5BT8fvr7iCKkF/Rd8s63jm8QDv965y9usrOU6hEWC9wFphyB
	 +1TMdXqEtBVafHSgpR0K4wZN+rogNcnRmBilSt76bq5R7D27aiejRfnDHY31EXF8RLSvI
	 OWih9CX9LEGOlu7xYH+mehNQBWlGQ8udB8BEndxxsYidR6rB3yT2hwCtsV2wuho9Sih10
	 JO70IIaM9yI0v5tTfanqtn+r6qW6lgj07UqR5HS8ZFx7irRCElHo2Ljpwm5GsK+umMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=T2FWaVlgG8DlrEVsmGNjQ+m7wefa9FtjIViJ89iIUCc=;
	b=ia1bDqH9fGe7ryJNkyLdhZeeI9ydVvQbyHdtlK5Dh5cLFxEZ/oqZuQBDhPBh5+PlBVAO
	 pHIvAZIhIGISdi1aMVyQMPqNBIMxRv6PHBGKSYd5cPzhDcv4959M3B5THJPXr1LePoJHm
	 iMs3rpAx8mgQ67IYBQzcGffNpo5VaJKAm6hm/iJ/ebv2ibL92N+FsTw6ksxsM760XBvMh
	 b+myQuTDQOZzjOtzrUAlryO1IPgU7+idDir3sjTsWXgxINhoWklpJW9B1Mqw3sWKAbFys
	 RB5gufw5t89m17PuIIWKU+GuYt+K4yDY7/pDI/EL0nNO88ls6o0EaxXGe75pYYoNHSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZM+Bo/NL";
	arc=fail smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F8F606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 03:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3F8F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZM+Bo/NL
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c468bd799ecso35402266b.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 19:35:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793763335; cv=none;
        d=google.com; s=arc-20260327;
        b=Y0a2CnTW59PhxddQ00OszUBBiWC6qs9fNF3FATsslO54VKuhoGH747KU20C27ygSer
         40LFKtsQ+qZposm6B7XTYy7B9nFI5blCsM+qPY2XwHytEAF6I7jLL7x7M+OGX2WTmony
         jFfzGlawW9Kufbz6UATAVdsJex4LqGRyq0obADX7cprWiiXo9oMBQ62jiSY2hwJSwoBj
         ldVU+LNokloTdeaDXHwmjKJP4mpj65J/wTX3P9vZAQRlXR5JacPMt6ruLD7MHTRzYOpS
         /aJoCax4Hv+/nky6bJNsIocuV5EBrZTydg/RIq/HvnhEVMpxfKqLbcguLRLNLSrt8V3S
         HQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T2FWaVlgG8DlrEVsmGNjQ+m7wefa9FtjIViJ89iIUCc=;
        fh=XFP2NZnayxaCWgDviBcMGM0gqMmU0iNNTQj2DzPDbGk=;
        b=M7noahlTmIS763BJuvElCWG9aUiGSj1BeqtMGCG2ZE0WL2AQPQpLXRWSBPKk0z5cSX
         Rb5NREloPtGOh1pemRdBqmFhpeqo5jImLb9GCOv/iBzzN689L+A4GH+H8zPhyqpLTQ2+
         bUA1hJQ7DSK9IAzSb7HoiwibjFGov2DzxxiNxlIUr2b8GE5n0XBkMmPHmiZW/V4L+hE5
         AI9GVj15TpfnDJ0LqZtw0agemFsH5xk6DfQkK5W29TCnVhdrQ9+PuNH9JxpEmYz2FLB8
         y0d3B7tAEMXxvttgZnrZqIllIeuqB4UkLSE8fdTFnM4rXArZzAsA/PcR9JCNGX6crV3l
         IVYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793763335; x=1794368135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T2FWaVlgG8DlrEVsmGNjQ+m7wefa9FtjIViJ89iIUCc=;
        b=ZM+Bo/NLHVAIGud/SRt1S82BHSV4Dy3O/1v/XhWAygF4W6LC8LJ4zz5tAHv0DKZISK
         y99m2Vzu9GwsILtdlsp1jaTwouR/2MYaZmRoQEYGjyc1l9qj+unLS29lF5agI8+M5HLG
         0zc9jcPKe0IbDIAMcl9xB1IndX3PyX1CtpGmg1HJxmIsKGflGof4vnHMxAw55W1f/Wcy
         TbkSyTfpug2hmzKDyMDSQkiLuVmmUM8//uoc5GY4fuYPaFwMt86KGBfg6K5Vec6Rgfxj
         N6E6our0/WG7Rd0Xd5gyJ6hair+/K9LSmfSxXKasKFEs4nwWUykQmzxp5ANZSCoa5RCb
         IoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793763335; x=1794368135;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T2FWaVlgG8DlrEVsmGNjQ+m7wefa9FtjIViJ89iIUCc=;
        b=XiP2aDX+PcMIRN7/9FCXRAOPCazAImH6qDc1+j5H7l/aUJeHVuBlqEMB9E+sWNUMc7
         twaO39B3+V8qo40r1ixzGgAxBZn/bRAsJzgxIuWe3bplLWKpdCOINR37XfmtzGOKgJkO
         2F2RvLlSCep782O+4VvkBD6opYIDQ7L849MzrggAW1+S+99Ic5iowQTb9KHEZv1czFf0
         lQTebA9rBvWCkuHql2bXwfHZb66vhxm3/Qn7LWuxjpIImODAot/mLjoy+/GsUynB6xOK
         uqMESH/SXCrwneDRDw8J4LYPVdpmdWEgQsQ8T+TMFkEa5vXbnf1OJvSXlpqkPS/PvifU
         arBg==
X-Forwarded-Encrypted: i=1; AKwUvBwB3l8Bgosq8t/95ue98UyatVmOViopy9RrRU36+bR7vE9nLrqWs95zDId7/njhWjWU9KhTcTw=@vger.kernel.org
X-Gm-Message-State: APuU4Z98ZUkWt1YwNEt8qOlJIiBax7DyXb96jUe9VYdHmZ3Dfzn4PrZC
	fATlMwyoT8P6AeaGU9lY5mH9OrW0hdVZScM44umGZ8au0c8d39v3wPKzphZeFX7f5FGb35VZ/Lq
	yLOPypd2VaiBRgsVzYrrRF5gSOWmw2Ck=
X-Gm-Gg: AYBFou0xcfJaSOwvQAdYm0Tth+VtxJRVvn/ipGziOqsRGXW1OLEb+T6w5p1d1roGuNW
	G7/2LZ1WtkIkliJH8LcKRFmvzaqzz8RtNuSCayHvOKqUtXvDnGt9Mlrvft32VV7i2FpIO3B4fZL
	fKbls1nHclg1W4i2QSGNZLujSLno/Qpg23rVb1om27RQ4UjwoAoawkcGRjv4lQnjwD8ammveEe3
	Yswfxo6wLZN/GmoMZnZGZD/IXnATmY1Jv0FNWhl/NKtzmM2gdQkhhe7aPc7RmLA6p/OJSkzpz2I
	3E8GzjZw+l5EyM7cLO8WXTjbCg/Cy4FYgBoU0AYkh46VQrYPYHbeUp0WSHqmCDmNCb7JyeTdIvC
	6uNW/ijqKc9VMW6t6hYvS9SCpLYgwPDwhl8aR0w7rBCX4jpK2iW0KSH6BGYKlTSA3Yf2P7A5wpp
	c=
X-Received: by 2002:a17:907:a890:b0:c46:9ca9:f522 with SMTP id
 a640c23a62f3a-c4ca7a69782mr1214812566b.26.1793763334986; Tue, 03 Nov 2026
 19:35:34 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179374297269.488856.7749172366095110113@kernel.org> <20261103225321.19288-1-federico@rimpianto.com>
In-Reply-To: <20261103225321.19288-1-federico@rimpianto.com>
From: Chris Snook <chris.snook@gmail.com>
Date: Tue, 3 Nov 2026 22:35:40 -0500
X-Gm-Features: AclHuK8pgXDdUe8VVPBSwoSm2Xv7dqRRsi3A56cCZ8EmMNgChDd3Wu0uj8DEEoU
Message-ID: <CAMXMK6uS4-4aq4A3pUMghkt5v3U+NekcCfDa7ytbjLD5ZwG+8g@mail.gmail.com>
Subject: Re: [PATCH net v2] net: atl1c: free the RX buffer when the descriptor
 reports an error
To: Federico Musto <federico@rimpianto.com>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 5:53=E2=80=AFPM Federico Musto <federico@rimpianto.c=
om> wrote:
>
> Thank you for the detailed review. The findings on endian decoding,
> multi-RFD error handling, stale RRDs after reset and missing error-path
> work accounting were valid and have been addressed in v3.
>
> The v3 now:
> - decodes rrs->word0 once in CPU byte order and passes the decoded RFD
>   index to both the unmap and cleanup paths;
> - unmaps, frees and recycles every RFD of an errored multi-RFD frame,
>   with ring wrap;
> - counts errored descriptors as work so the RX refill runs;
> - clears the RRD ring on reset, preventing stale error descriptors from
>   freeing newly reposted buffers.
>
> The memory-ordering and link-reset/NAPI issues are pre-existing and are
> left to separate patches rather than expanding this fix.
>
> Validation on netdev/net:
> - scripts/checkpatch.pl: 0 errors, 0 warnings, 0 checks;
> - baseline and patched W=3D1 + Sparse builds both succeeded;
> - no new warnings; three endian-related Sparse warnings removed;
> - git apply --check and git diff --check passed.
>
> The issues were found by code inspection; no hardware test has been
> performed.
>
> pw-bot: cr

I no longer have working test hardware for atl1c, so I'm unable to
test this on real hardware. The same is also true of atl1e. There have
been patches somewhat recently for atl1e that suggested some people
are still doing work on real hardware for that one, but as far as I
can tell no one has made new hardware for atl1, atl2, or atl1c in over
a decade. If anyone is willing to help test patches on this hardware,
please let me know.

- Chris
