Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9903A38BDC7
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006470; cv=none; b=QT+zCuFualx+ctD+A59wkui1dFXOxWxI4fx19fEkb6rHLvE18nZXdKdgzWvhICX9+sgVQMtcGJRDE0QieTxTEnchYqpFchvsg04si8GFGrPMma3VqSRTXda3v585n0902hFq+5wHj1osV4ceV6mDSEA4qQYvudPnUEos/S5lnQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006470; c=relaxed/simple;
	bh=rwTBfOmv3TsyqCAMfxc10gpQoi3l0ILMzmyE1jv8NcA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lLkCbCnvIf8hqD3BvB9Tv96DXaJU7ibC311AY3n27tQWAFzzbeRUNFAyLHITOWnax4UbX4YpjEUtjY+L1VSDAbVTsUhCaom1Cy7NR+KoJrsCzhNEkRczQKoNIHHHepoMF7dRQ2+XZK6rMwKo5zbKornwJ4teceSGEdcxfCVC+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liYHgqFu; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liYHgqFu"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6493937c342so2413197d50.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 06:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769006467; x=1769611267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QhEJeO6VAAT1PZbRU+MPc9wELPLdoIH0o3vvoREGUw=;
        b=liYHgqFu6zaVrOed8Wo4gzeVMyqhgh2ou/lXkm442srFwPTMqj/JIoQ+Gc73z4Y4lI
         nt93NC/z8CPozL65UpGcP0vxJmMr4u9L5PuDQLM6QzIzCO91ELwjLqYHCa3/IgzEUTUe
         mR0uT8YxscFe1cgugWbfny2DAMDbucLPFPrnlC0qXpKS/J9X3vC+n+bFT6t412RVNVfp
         dTa9cqGKUnmTSfJ6sPCKb/fO3If+i5W8ZTsUxs/j1p7hnRpEZoRPoNoLkcmjEpmvm1GF
         T/o/zBD4KkZG38AXMboeXbk3m5YwuzWNd4Y1kpJxtAVHj3vTw0jjzFr4XQPUwq7bltt7
         YnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769006467; x=1769611267;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1QhEJeO6VAAT1PZbRU+MPc9wELPLdoIH0o3vvoREGUw=;
        b=NDi4EySnI91PIAfS9o69PhUaNXytxgMREkxMd4dv8JXqr6/z4M4saQw6zVSbiPD5W2
         qEsgNupSzF/mnsHcpWO3vq/NusGh7UeZJOF1jkbgFfrZdUolDuvr4p58BcizoDjmH4C3
         LHZi+qajXtHP/BIIZnguj9OIZe7lMIbHn4iWOT7Zp64qIdtrc0xpAkgOC++YhpCEcTjA
         WTZi4gk2DmJypUoSWtxK/7nMDuiXktFRep/4NcVSQcBk2se4dWPFxC1sdzN3aPL4wqqA
         luE39R2sFHcfOK7df/7GbhmyNMVrHFkkLglRBw00l8wUZ1bR0bj+sUP/18wnHIppDJ31
         hNAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX64tgPxxh0PsKyTEj01/bmaNwYNAID1vRVUpVOKocspzHvWtWN/Cr6E/NFwNp+Yt12eaUZ4RA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPRfnetTnsr/RV1f8yMVEU6ijDlW4Ljwxz+zRn3A5/++1hdnXl
	+sdbEJ4C4tE1OVm1WoUaEJ6rZ4j1AC1Z9nC/yuB6S+GN5Wv8YQXbFJlQ
X-Gm-Gg: AZuq6aLx6dDBhB0njGtmiIfAdWHj/bn8F0pZ6dGSmG0HKVbuk9+1mabJ6FnNBZEx+pV
	hlW9eJfwBaBseT7PrAIAhghsHXcdobtQCJ5JJK1GXKwyEYbCyrxvyh9ucUCYgn/uy6Qh9oNhpN0
	lbefmSG7iAZKsDC+0H7KGkaP4XfSH/CH2BS1eEa12CHG+R5DmSOcdftUlmXI1dlP5xY+pPguxt3
	TYAtaDzMzIikAThjfw6ww/JykNvOx36gX7USzlYxSjH7yAioc90XGO997tgBqk9lYTwFy98uQBg
	OV7au/8q+Az2/LK4j/msySTXI8ozL0LikfzZGr7VeccGPr8wt39B1C0+gvRHISUzkxOpnLgE2jF
	9A8Gb0efzePGCW7VxAqrIQWTEX01aZdAZbnkYdGxcVNtLcSR72CGfvXHTVMXkqkcBAEo7yCzetV
	rjZWB7HTYxH/D2gfTGyluC9Sbv/EBbhFms3FCQBKiP0P+9kJfUZiAb1ZG7feq7CvLvFnBUlA==
X-Received: by 2002:a05:690e:4104:b0:649:393c:86cc with SMTP id 956f58d0204a3-649393c8e91mr5799523d50.4.1769006467401;
        Wed, 21 Jan 2026 06:41:07 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64916ffc035sm8029614d50.3.2026.01.21.06.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:41:06 -0800 (PST)
Date: Wed, 21 Jan 2026 09:41:06 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Danielle Ratson <danieller@nvidia.com>, 
 netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 shuah@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 idosch@nvidia.com, 
 mlxsw@nvidia.com, 
 Danielle Ratson <danieller@nvidia.com>
Message-ID: <willemdebruijn.kernel.be3e9734c8a5@gmail.com>
In-Reply-To: <20260121114644.2863640-1-danieller@nvidia.com>
References: <20260121114644.2863640-1-danieller@nvidia.com>
Subject: Re: [PATCH net-next v2] selftests: net: Add kernel selftest for RFC
 4884
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Danielle Ratson wrote:
> RFC 4884 extended certain ICMP messages with a length attribute that
> encodes the length of the "original datagram" field. This is needed so
> that new information could be appended to these messages without
> applications thinking that it is part of the "original datagram" field.
> 
> In version 5.9, the kernel was extended with two new socket options
> (SOL_IP/IP_RECVERR_4884 and SOL_IPV6/IPV6_RECVERR_RFC4884) that allow
> user space to retrieve this length which is basically the offset to the
> ICMP Extension Structure at the end of the ICMP message. This is
> required by user space applications that need to parse the information
> contained in the ICMP Extension Structure. For example, the RFC 5837
> extension for tracepath.
> 
> Add a selftest that verifies correct handling of the RFC 4884 length
> field for both IPv4 and IPv6, with and without extension structures,
> and validates that malformed extensions are correctly reported as invalid.
> 
> For each address family, the test creates:
>   - a raw socket used to send locally crafted ICMP error packets to the
>     loopback address, and
>   - a datagram socket used to receive the encapsulated original datagram
>     and associated error metadata from the kernel error queue.
> 
> ICMP packets are constructed entirely in user space rather than relying
> on kernel-generated errors. This allows the test to exercise invalid
> scenarios (such as corrupted checksums and incorrect length fields) and
> verify that the SO_EE_RFC4884_FLAG_INVALID flag is set as expected.
> 
> Output Example:
> 
> $ ./icmp_rfc4884
> Starting 18 tests from 18 test cases.
>   RUN           rfc4884.ipv4_ext_small_payload.rfc4884 ...
>             OK  rfc4884.ipv4_ext_small_payload.rfc4884
> ok 1 rfc4884.ipv4_ext_small_payload.rfc4884
>   RUN           rfc4884.ipv4_ext.rfc4884 ...
>             OK  rfc4884.ipv4_ext.rfc4884
> ok 2 rfc4884.ipv4_ext.rfc4884
>   RUN           rfc4884.ipv4_ext_large_payload.rfc4884 ...
>             OK  rfc4884.ipv4_ext_large_payload.rfc4884
> ok 3 rfc4884.ipv4_ext_large_payload.rfc4884
>   RUN           rfc4884.ipv4_no_ext_small_payload.rfc4884 ...
>             OK  rfc4884.ipv4_no_ext_small_payload.rfc4884
> ok 4 rfc4884.ipv4_no_ext_small_payload.rfc4884
>   RUN           rfc4884.ipv4_no_ext_min_payload.rfc4884 ...
>             OK  rfc4884.ipv4_no_ext_min_payload.rfc4884
> ok 5 rfc4884.ipv4_no_ext_min_payload.rfc4884
>   RUN           rfc4884.ipv4_no_ext_large_payload.rfc4884 ...
>             OK  rfc4884.ipv4_no_ext_large_payload.rfc4884
> ok 6 rfc4884.ipv4_no_ext_large_payload.rfc4884
>   RUN           rfc4884.ipv4_invalid_ext_checksum.rfc4884 ...
>             OK  rfc4884.ipv4_invalid_ext_checksum.rfc4884
> ok 7 rfc4884.ipv4_invalid_ext_checksum.rfc4884
>   RUN           rfc4884.ipv4_invalid_ext_length_small.rfc4884 ...
>             OK  rfc4884.ipv4_invalid_ext_length_small.rfc4884
> ok 8 rfc4884.ipv4_invalid_ext_length_small.rfc4884
>   RUN           rfc4884.ipv4_invalid_ext_length_large.rfc4884 ...
>             OK  rfc4884.ipv4_invalid_ext_length_large.rfc4884
> ok 9 rfc4884.ipv4_invalid_ext_length_large.rfc4884
>   RUN           rfc4884.ipv6_ext_small_payload.rfc4884 ...
>             OK  rfc4884.ipv6_ext_small_payload.rfc4884
> ok 10 rfc4884.ipv6_ext_small_payload.rfc4884
>   RUN           rfc4884.ipv6_ext.rfc4884 ...
>             OK  rfc4884.ipv6_ext.rfc4884
> ok 11 rfc4884.ipv6_ext.rfc4884
>   RUN           rfc4884.ipv6_ext_large_payload.rfc4884 ...
>             OK  rfc4884.ipv6_ext_large_payload.rfc4884
> ok 12 rfc4884.ipv6_ext_large_payload.rfc4884
>   RUN           rfc4884.ipv6_no_ext_small_payload.rfc4884 ...
>             OK  rfc4884.ipv6_no_ext_small_payload.rfc4884
> ok 13 rfc4884.ipv6_no_ext_small_payload.rfc4884
>   RUN           rfc4884.ipv6_no_ext_min_payload.rfc4884 ...
>             OK  rfc4884.ipv6_no_ext_min_payload.rfc4884
> ok 14 rfc4884.ipv6_no_ext_min_payload.rfc4884
>   RUN           rfc4884.ipv6_no_ext_large_payload.rfc4884 ...
>             OK  rfc4884.ipv6_no_ext_large_payload.rfc4884
> ok 15 rfc4884.ipv6_no_ext_large_payload.rfc4884
>   RUN           rfc4884.ipv6_invalid_ext_checksum.rfc4884 ...
>             OK  rfc4884.ipv6_invalid_ext_checksum.rfc4884
> ok 16 rfc4884.ipv6_invalid_ext_checksum.rfc4884
>   RUN           rfc4884.ipv6_invalid_ext_length_small.rfc4884 ...
>             OK  rfc4884.ipv6_invalid_ext_length_small.rfc4884
> ok 17 rfc4884.ipv6_invalid_ext_length_small.rfc4884
>   RUN           rfc4884.ipv6_invalid_ext_length_large.rfc4884 ...
>             OK  rfc4884.ipv6_invalid_ext_length_large.rfc4884
> ok 18 rfc4884.ipv6_invalid_ext_length_large.rfc4884
>  PASSED: 18 / 18 tests passed.
>  Totals: pass:18 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks!
