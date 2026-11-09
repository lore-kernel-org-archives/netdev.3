Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794255125;
	b=sNq4W71mgoCXuTOI/Mr7PizXmd7kxEHnkg3+aNv3PekCtTNpSrLyMA++/HBxGmCkcoN8
	 9LLkG6F8P5qDKZLMDYkT3FQVNi+8fJTAGL4qYuSO5Q50okvwNqQ1uP7mXkVptjUEPSDDH
	 j7SjKL4P+CdjKCtAF6yaJpK/aA9H2Ud5iOwh5+CGWdNi/BICcYUhLI5QWkxxCPvDMMHLh
	 mHcVBxbz67zA+l3otxfUaYTj2zQF62HqR71ANqpXZ8cCM29BgfD6D2hI4Wpzj5lec2Wvi
	 eWW3Y0oNJYzZ2yju1MkdgNjUX2Jt5E5BPs266xubfdJNBH+FBT7D51DSHtI0rm4EzkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:Mail-Followup-To:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=292T8O0aYQmW1UA5e/QuA2F7Fm+KQFHNlKPM8I6UjFs=;
	b=XimCRSL7wIy824JyweYS8IOsCDhXaUT01QVB3hN7ZfeIBslRlAvLdxQCavxy7al1pLh3
	 H1XHurdDWzsGkHgfhbiGmDhd9iG/vhJtFXs72HK0LDlI93u8nhzg9BA1RTxlN4ewBbN/d
	 DQ1RbKjzphUnk8RfI2UgxjPGkEbIXYJgQIU27g2uaFnolT+qHaa4ptd8lq9FNv4ztyxOP
	 YRjPpl0md7x8/Fq6pOaXrGFa1rBqLFC7qrmiQuFNSdv8ULj4xGUUXbcTnfh0YPKhOGWkw
	 pfuTGIJE4WbU7Chv+HN/Fgn61p2Mj/FC/jUeWBuzkvppsNlA5CN+Q85R1RckydBAsVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Ip8+iMcH;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CF0606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 20:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88CF0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Ip8+iMcH
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdba1bbde0bso459520a12.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 12:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1794255124; x=1794859924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=292T8O0aYQmW1UA5e/QuA2F7Fm+KQFHNlKPM8I6UjFs=;
        b=Ip8+iMcHvKrY9zFOYypIviny/5cFym2x9yoAPmDDC/trN/zTVtZ3Y6KFEbImBGAzr8
         d77ZFlCo1lr4hxIOKdtTTGH6w5JmYn0vplbDm2XbqLUAhJ8neXrnB+NJeSuKgNLO6u8d
         W6wqtBbfw+e3zJLU101XOWq7oMybWBRKbDvhkxIbYc/0uIhoAecYTArBfiOfSUNq2scN
         sTsJpI1UNH8FovGNkAWkCyCJysaFs3KiXEl5knV7KiyniUuoctuo+8C1uB8jqOFGl/4S
         zCPqNKNUZB/RX4+khtR4NgZJmV0Iygb9l1gYHuVNIe1ojV5WRudu6JhtX61gIEi6AXfY
         aU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794255124; x=1794859924;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=292T8O0aYQmW1UA5e/QuA2F7Fm+KQFHNlKPM8I6UjFs=;
        b=D+iv4yVhWiQOlS93Y8Ol+Jc4pdYFZuWzWBvrSkXCcVcTjy6VcdYRK3x/PRONQ7WMNZ
         fpfK4dMStdfYV6S7ND+zLw9i39YQlli8mpo8FY9SAtmy0NFh+C02KQn1+YgbR49QrCiY
         27zMjPHjbYnIVEEUoDvShESNDEoy+paDZGtR0qu2Sg/BQFsyWNO/2fitXF80ho87v7ZM
         mj5kfimyh3bZg3oVj04h4g2hvxpXz4y9GLH+qv3fvOM+vNupW2moTDqgPQ8OtGFjskc0
         /rfGUQoxEMiGynE5i6WdTkQKuOylba+ahYgKZ7RvjkCURv4Y+XauiD8FveR+cXXK6D11
         KBkA==
X-Gm-Message-State: APuU4Z+1wIO3nxtIeNMMqSodwhG7+LUT7mqRz1dFDXq8pgdORSk+bBpS
	foJW0kBgOt87S1OADl7h1FK2wIkgyLs1Omu59ZFZzfsWAG5pqt7VUgkM55bgXV41dsgvnn9I4Vz
	I9OyI
X-Gm-Gg: AYBFou2Bh3DOA1FL6Ka4P8UlKe87jXojCi9GTVN6aK5dGkBCXfrJG7QQiSDeyUVGAFg
	7t3rH248csFS9jfl4qyz/Jb6b8ZzZ47Fpwy4jk9i8HXLlm5P4Acpv/vCnCoPdCV0xuISOdLJGG9
	kvnYPoxCtSlUdBh3g1k/m4e06dtl3CimZP73GZYeGJ9suCNhn3zLmMwa5jxo+2GbfzkhP5IzIh5
	LLpyunKqKhO0LqVHJHrDS2pIO5BmFf+JmU/eP2JxEsx6RbTWhA7uz0blcrPlf01IY8VBf9evsle
	p/YO2LAa8jo8ZAogdL/zAO/12s15Lih4Qt1LRwnJVfRjdYFpD3/MTtWRBNQsefTMRfuqGmwva+a
	eQb/BmuEkNKbeOTgRrTOPH7c5SuE1VLBIwUn8f5EVnDH6eROSOnMXKE6v62Tf3cDG8y8x7qVJ7/
	TMEmPpE/G4NkDpyZ5S27lNxyZnc9ViSpXWnsbGx+6Mcsjtb6w8KNktTL034Rr1ym68L+reuWnYu
	6Z3R6gQK2bs0+3o+/7bAkt8szc85V7sw3k0n6yV5CbL3wVvMW3GPE3prua0VyuFiC4WCsaVFuid
	rgv/RMC59QWRSJZn4xkP/q0gf0cqQflmNozQMYbNMA==
X-Received: by 2002:a17:90b:37c8:b0:3a0:4668:4cb0 with SMTP id 98e67ed59e1d1-3b166d1efc2mr707172a91.47.1794255123838;
        Mon, 09 Nov 2026 12:12:03 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:57::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1676d83absm798172a91.7.2026.11.09.12.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 12:12:02 -0800 (PST)
Date: Mon, 9 Nov 2026 12:12:02 -0800
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 0/4] bnxt_en: Make RING FREE more robust
Message-ID: <avIpEpoCYvLHYl3j@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org
References: <20261106191423.4194081-1-joe@dama.to>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106191423.4194081-1-joe@dama.to>

On Fri, Nov 06, 2026 at 11:14:16AM -0800, Joe Damato wrote:
> Greetings:
> 
> This is a follow up to the previous RFC (linked below).
> 
> On two production systems, I saw the following dmesg pattern:
> 
>   NETDEV WATCHDOG: transmit queue 0 timed out 6073 ms
>   Resp cmpl intr err msg: 0x51                  x20
>   hwrm_ring_free type 1 failed                  x12
>   hwrm_ring_free type 2 failed                  x8
>   AMD-Vi: IO_PAGE_FAULT  x3
> 
> This suggests that, for some currently unknown reason, TX completions stall
> and the netdev watchdog fires. The driver asks FW to free the rings, this
> times out, but the driver ignores the possible failure and frees ring memory.
> Since the FW didn't respond to the ring free command, it is possible that the
> FW is still DMAing to the memory which was freed.

OK so Sashiko found a lot of random stuff and I thought it might be good to
summarize what I plan on addressing in the next revision in one place.

For v6:

Patch 1:
  - Fix commit message
  - Return the errno from hwrm_req_send().

Patch 2:
  - Only check the response for HWRM_RING_FREE. HWRM_SELFTEST_IRQ and
    HWRM_RING_RESET keep the existing behavior.
  - Read the valid byte with READ_ONCE(), then dma_rmb() before reading
    the rest of the response, including error_code.
  - Respect BNXT_HWRM_CTX_SILENT for the new warning.

Patch 3:
  - Count a ring as stuck only when no response arrived, not when the
    firmware replied with an error.
  - Don't stop DMA when BNXT_STATE_IN_FW_RESET or BNXT_STATE_FW_FATAL_COND is
    set.

Patch 4:
  - Make BNXT_NO_FW_ACCESS() also test BNXT_STATE_DMA_STOPPED.

Update commit messages as needed.

The Sashiko feedback that I think is real, but that I haven't seen in prod or
I think feels more like "new features" instead of bug fix and should be a
series for net-next:

  - Making the per queue paths more robust.
  - Completion and NQ failures are not counted as stuck.
  - The polling path in __hwrm_send() probably needs a dma_rmb between reading
    the valid byte and reading the rest of the message.
  - bnxt_resume, bnxt_fw_reset_task, and bnxt_io_slot_reset all call
    pci_set_master without checking the DMA bit.
  - Notifying bnxt_re when DMA is stopped.

If Broadcom or any of the maintainers disagrees and thinks some or all of this
should be part of this series please let me know.
