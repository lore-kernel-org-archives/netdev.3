Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBA53DC4B6
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787218568; cv=none; b=DKKWyqq5nQ+RmQYopOOpfK6f6USFJhiRHAr7iunYlMY5dXIYQEBM1OwscBik4UbwjB03IVcSi4IGFJqhGg/gR7SUSJ3wM2uSYIbiWd5EqX8S2E4Hkr4XJ4YqLyYD/4WP8krq7gJPeI4Q1CXbNWjLdevdkRyCdZLHvxCVDmvwrKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787218568; c=relaxed/simple;
	bh=kJ3cTYIYrtG7tlP3Fs01NISD4Xb/24ggyMndOowsHXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dr6I76G6A/1QMIkKTGD8clrxkASk5hqheZ3rCFBUg2+2FSTMyjizum2sA2Dg0+h9J4sZuWvSpTJSC8HwwAOamYM2BPS61Pgt75Ak7G7NpRBXV3BYZFOmWlyXHvzaQO3VJOxpsLRBKvfbnZVu72YKqaVWy0HUpGcXb7scSDK8XIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqsAp1wW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rn5i2yLn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqsAp1wW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rn5i2yLn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787218559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cihLxc2CBVpIep8pW98bFEf2PHfl2dA2RKm6Z1hhqi4=;
	b=dqsAp1wW+jvih1smRGMU/f0/bh6hzYiUtEmR242SXkb1n8B5YQFBF61k2ic9cZoWdYa3FL
	8pC/y+E9t6uydJ6EwlCovqgdUqpvGOtJmKjKmezb68hr8RNagtcb1LqWjxo0K/eeQoGE3U
	QMsfdfxd1u0gIJvH6sXGTZX+0ybSYso=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-FSmhMi_tOOGw0szwhtiZSA-1; Thu, 20 Aug 2026 05:35:57 -0400
X-MC-Unique: FSmhMi_tOOGw0szwhtiZSA-1
X-Mimecast-MFC-AGG-ID: FSmhMi_tOOGw0szwhtiZSA_1787218556
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4954dcd6131so22256595e9.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 02:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787218556; x=1787823356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cihLxc2CBVpIep8pW98bFEf2PHfl2dA2RKm6Z1hhqi4=;
        b=rn5i2yLnKVHBxurkYxocygugSCKOySqUP1nPJHN+SMk2ZOdK+hnXlHZt4O6rMifPU5
         YDQVOyPYCGdihxesUmbXWqFg8JxOxIlvWzFEdNunQo2V4e7Yh2sr/+JlqW6uKy84ysdK
         ShQj6oxF/Rxq3yXqqa448xsyMY475Zjemh1S3b6E17zX5zkPMTyZ0c1LoWVOFEWpf0WE
         W2ENksFhdDDkxUAYR3fTe98YtrzekBSGOY6AwJAuUo7tOOk2UIvCAMLbKVqThzOQI+fx
         b0VY4FOxECNk304rYfW8eAlpgqN7lEKLd8vL8Ylqkyj+48lXM7u+OXaQiCkmRITP+0a3
         dp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787218556; x=1787823356;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cihLxc2CBVpIep8pW98bFEf2PHfl2dA2RKm6Z1hhqi4=;
        b=C/+5b3wnkiPJPQoMwzu9J1E2SpJ5nc1h2gtswBVFK2uQ/YlV13nCXdyJIysEwbT5PR
         P8qtI78aneIog8TEY3WNzEdmVOv2fBu4cATtYW0U3eAi61vu26k7fkmqU4W/RWYoXzd7
         8eZWn6qAarGyWOax9gXuviZLZQOZqp07wxj7iGOBhOssxI4+jwj+AWN6QwN5OFAXIhSJ
         YzKC8qkRPE12FaBqlQbqgzieICcHi8QL5X/yinGs+NvgPDTXiMtLdFUvwzdT3TZ8pJVN
         9TFw3xHD3QdLc/1bT62U8EZwCYCdQLqU82jjBsMVp0dfbvzz7cEdIRoxdpkCA8JgI6l8
         RzqQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro4zxejRUoYn0NUp96i3dPibrWilWxr2gZdr+sVed4W3IeUfwAZyn8R/6c8LWFAAMSIDuXBj+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbm6OziYHZLLsL/IBmyiGWV2jpRvFKKX2QL+soZvJd+EIVMvKs
	4ADSB7NTfV3/xvyeyhfShxCKYUDBisCbslb17huSwN/ZSRsvYtlk+sYbQ/Pgqm7Bm/BGRZsGivl
	nUIjgO1XhcyqUMHlg86n8PulW+5xVTi4GRUazZZbuc4tVmAk5hM5rHjaCWw==
X-Gm-Gg: AR+sD13s6ctBzq/4CsuHG5yoCKP+C7JMRz7E4y9l/1IemS5Qmx08xA6nuJAwW56T+Wk
	GWFTm4cwBJtC+2Y9txGUIM5vm3CpsGru0P2ofjyVNzTm+PxPrygc09YsiCCPrjqh2LgtY1DtAU9
	UnKLBnbCAHpZAOu1I/oiy65sQBBLeoibvn2WschhAuMxpMK/CwipSAKmZuAdyd3Ebm/QLjVvZoP
	u37t6ztV2szkOK8xNdZjhkXyPp2kBVriKIXz8oTupVzgTY64myQoWJASEa5JYE0pFfeP85lMqDP
	CJE2rTFQb8necHxS1I2hI003vatoTF1j7+AedKGYKzHe0p4wiDmHuMuP7c2MblX4N+jdvFAbGWN
	Uo2Sh7giYRn0RB9c23BxQy3gBX982Fmb+Jmr56aDloo7osUk4IhBApjfSJvahuM25+fbX/dgsiy
	Y=
X-Received: by 2002:a05:600c:4e47:b0:499:a0f3:9d5c with SMTP id 5b1f17b1804b1-499aa14a711mr219190345e9.3.1787218556433;
        Thu, 20 Aug 2026 02:35:56 -0700 (PDT)
X-Received: by 2002:a05:600c:4e47:b0:499:a0f3:9d5c with SMTP id 5b1f17b1804b1-499aa14a711mr219189435e9.3.1787218555984;
        Thu, 20 Aug 2026 02:35:55 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b80a5sm12285701f8f.24.2026.08.20.02.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 02:35:55 -0700 (PDT)
Message-ID: <a602a1f6-e279-4c7c-86df-1bd0ef244fd0@redhat.com>
Date: Thu, 20 Aug 2026 11:35:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/4] selftests/xsk: improve shared-UMEM
 coverage
To: Tushar Vyavahare <tushar.vyavahare@intel.com>, netdev@vger.kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 stfomichev@gmail.com, kernelxing@tencent.com, davem@davemloft.net,
 kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 tirthendu.sarkar@intel.com, andrii@kernel.org
Cc: bpf@vger.kernel.org
References: <20260819024443.781764-1-tushar.vyavahare@intel.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260819024443.781764-1-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/26 4:44 AM, Tushar Vyavahare wrote:
> AF_XDP shared-UMEM support in the existing XSK selftests is limited to
> a small set of scenarios, while the supporting setup and cleanup paths
> become fragile as coverage expands.
> 
> This series improves shared-UMEM testing and infrastructure in four
> steps.
> 
> Patch 1 makes UMEM ownership explicit with refcounting and centralizes
> socket and UMEM teardown, keeping cleanup behavior consistent across
> normal completion and error paths. A UMEM that survives teardown now
> fails the test instead of leaking silently.
> 
> Patch 2 prevents TX setup when RX socket configuration has already
> failed. This avoids shared-UMEM TX setup relying on incomplete RX-side
> socket and UMEM state.
> 
> Patch 3 expands XSKMAP and test capacity to four sockets and adds a
> length-based XDP steering program. The classifier uses total
> XDP-visible packet length (data_end - data) and SHARED_UMEM_LEN_SPLIT.
> 
> Patch 4 adds the shared-UMEM callback runner and initial 4-socket,
> length-based steering, uneven-distribution, and unaligned-chunk test
> cases. The three packet-stream sequences share one transactional helper
> that stages replacement streams and publishes them into the socket
> arrays only after every allocation has succeeded.
> 
> Together, these patches strengthen shared-UMEM setup and cleanup and
> extend selftest coverage to multi-socket and packet-distribution
> scenarios.
## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.3,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

