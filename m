Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374512;
	b=PWKMyt4Tx75YM/bhRdQdLqqry/08vBUpQsgsKF+Mah0GXG12UPk9r6HNMoiBZHPFcDvs
	 Je91VEGjMDNYI9tjGruJ3w+b+DnkqKPcRIG6CHM9EneJMrNeAy1KnaXqJgE+gC+BUBulS
	 Dv+P/yAkJzJZnlxJURg91i+M1Lxuu3JKJC088HlYFaVpQKUvkuud478pW6EBE6DjTw9zC
	 5er/AsOGeZQUjlIV6C1Irp8sUKPlvzaGL5iIc5IIXr52THYtHK1IacPUypPo4oH+bBuB+
	 pQpgNLKzozt9mTMWl2J+3dHibIZA+8zkZuajFTfDA+egMlajRSP5ok2Uvi79ivCgmNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=bxBhehEVB7GhBTyrxNNIZW3iu/okUMlI0I+39Z3+sLw=;
	b=o8YCi5m57JGRh9D/N/7NUepnIWaRgKFa0getpEL8VAnHEypA4aCd1R5PioXjZ2x6baEV
	 xs+tGI7WrDWiOsoZFTwB0QcnWa12cOxEuq0vKzi94K1KYKenatB3u+YzJ1gDOUBnOEpkS
	 6FEv7O5SlwjkcNrW14B/SHDMUK66VbuLlmouYgVl0eMvMHA+FmOlYlWJRCZ2P5OUddB8n
	 Xl4I8Rl/2jZ9FIRy4jGqcDXCrODuzGy6JXr0GlSFpr9fqBEporz2csqfxTUPCRx7ZNetM
	 NSHKfS9nC1CqJJr8ceP0YCBHTZ3W40SnBuhbE6V5wXX6Omtd+I0TtaG8ObF84+Y5BEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pJSV5dg+;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECE9606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 05:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ECE9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pJSV5dg+
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2eced5a4cb9so28537125ad.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794374512; x=1794979312; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bxBhehEVB7GhBTyrxNNIZW3iu/okUMlI0I+39Z3+sLw=;
        b=pJSV5dg+mhaD50UdQfyywMAVAMQnMO1VJCg6UT42ganiTChwGMg2OKV3fXKN+oE8nd
         ZRlSOknDfevWqRUm8Byc7sESdXB4FhGqANthVSegZigbVRWaaNvdpXCnCFEjVSIy9u56
         AGaVtUGd9ifS0n6d8y9R9EB3nCTNdhM8EbUKxOtX4Z0voc1TM1sfkM3J4tTnyAAHgodF
         FuyjvRxBvj/0eOGRUyPyDMxHORSJr/KE3A9sZNNP3WKqhNYJL3DQltraYvEKaOPx2aHj
         M+golgNEpemm2Y+KzaN1VZl1wGc+Fjqq4aW8yPC91a5IUzMPp6eSCRsAqiO2a6hf5l/U
         ro6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374512; x=1794979312;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bxBhehEVB7GhBTyrxNNIZW3iu/okUMlI0I+39Z3+sLw=;
        b=VmLHyoc3WGH6faVAHOdoK9nbXBy5c7kUlimj0X91u7QfucGeO8o+US406HoEbuRkj7
         O+7Td5En0jC9rGB3OYOAjr5nCJOqgv5UrNv+e5k/EeZ6jSxNjEm7mclQzVcR3o7NpoxL
         SyzaCoLA0hJLq4tHsiMXlfI+tcjqb90xiD4e8WqUC9ewCKypnXCap1YkXxBxM5ED/Pbu
         930OyeiKa7xeSm2kDALuYKt20ttXJCh7VCMzGfQJJWvTBkvVoPT2u2VSL+5hjiIn7R4q
         UwTFkpKA4MyO3iGK/N5ApAl5N9ifgJW7DuO3bAgl4igFct2NMhdQXjgLdimZYv6VlxVR
         QD1g==
X-Forwarded-Encrypted: i=1; AL+hErG1WQgz1+ykFfrxgahyaPaLUc/khP2EKeitVuTseiTAdc8NiDvCrSSwjBkkHKkMEfGSXncCts8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wBizEhDYEf2BuBcoaJb40KJPYtqSsMg7lft566+T49InomlmO
	nVlsWVH9Dd+RPFrTsRNCyh6VghYrOhYZcDidxLR2+ryDh6RRTSxVDqKZGEu7d7JidU7i0SImlAW
	t3rfQrQ==
X-Received: from plrq9.prod.google.com ([2002:a17:902:b109:b0:2ed:b80d:bc91])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ecb:b0:2e3:1bb4:6121
 with SMTP id d9443c01a7336-2edd7bf156bmr15084625ad.49.1794374511503; Tue, 10
 Nov 2026 21:21:51 -0800 (PST)
Date: Wed, 11 Nov 2026 05:21:51 +0000
In-Reply-To: <2026-11-09-1-daily-reply-0039-af-unix-oob-5.15@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <179418529889.10436.12048717656065553331@auth.ink> <2026-11-09-1-daily-reply-0039-af-unix-oob-5.15@kernel.org>
Message-ID: <avP62mmu06rM5gaj@google.com>
Subject: Re: [PATCH v2 5.15.y] af_unix: Clear oob_skb in scan_inflight()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, lee@kernel.org, netdev@vger.kernel.org, 
	rodrigo.zaiden@canonical.com, Tamir Awad <tamir@auth.ink>
Content-Type: text/plain; charset="us-ascii"

On Mon, 09 Nov 2026 10:53:21 -0500, Sasha Levin wrote:
> > af_unix: Clear oob_skb in scan_inflight()
> 
> This v2 applies cleanly to 5.15 and looks right to me, but it is a stable-only
> fix to the old GC with no mainline equivalent, so I would like an Acked-by
> before queueing it.
> 
> Kuniyuki, could you ack v2?

Code-wise, looks good.

Not sure why the changelog was not used as is and some useful
info was dropped.
