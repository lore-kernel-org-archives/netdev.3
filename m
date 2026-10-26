Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792992474;
	b=Re0vchBcCe8aAzdMSJsHGfbeM6Z44VjvUlCoN8r+tlmO6wLA3EtADltDLgI/1qpAfEFF
	 +W3F3Zb2AMGf/jUBATV2SvT93btBxlPUPXDQLWWq1FXVMNVeLO5ZlkIiqHL3we74M0vy3
	 txn3u1vPQ4AVjIm6KD5fZ4yoLwlMNr9NGEstvmRfux7zA7XhhXYoJkLsczd3hKZaYQDnN
	 KdbRGQ5hC3jx0j1j1QwRUqF9rulUwOyelor5E0HxC53S5HoasWE/KjIQfhaL/5fYm7Qwk
	 6vKNi5M8hTAqU0yn4pi3OGPB/YN4fCI9e2A2+NpHxCGebYFRoKTQBJdqOwJOS9I/uJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792992474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=c2vVLfr5r23oMNsvxAvIsVWSucEEuXtAs0YtxOnot1U=;
	b=vpxbNHoJEMglOs1tuUdLEZ8TX6xhF9O/j3mEjhApy5TU8mtizfw3ATM7NzZYJvlkTb/t
	 qi5eXls0RHsaRHMLfpdPOPJES/EP1cStkgGZj5V6F11BAF9Luzi/3qpblNCsF4xtMJXs/
	 7VbzDZZzCnucxMYkHcyo+/sHMsf/gOXjMZxefdWf/hmq783ULPCa/XPoXAN7uGZ+DSI34
	 fbumkLdF/sEY5x1NOn32z/fiTIe5WxocOhfaQe8KFyW6n5t0rIM5AB+xn6C6Gj2iF8yj1
	 vrLUBHaCBrXOO5R4bJwZs6XlGrIoVpxGD+pAUqk3EqVdMs3OfmIw5DEAZFAC5O/NopQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="jMP/3eHG";
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FADA606A32C
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 05:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FADA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jMP/3eHG
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-157fe9d771bso3099665c88.0
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 22:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792992473; x=1793597273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c2vVLfr5r23oMNsvxAvIsVWSucEEuXtAs0YtxOnot1U=;
        b=jMP/3eHG+EcjoJUjkHbgDNSNscVw1lpaVMGVmlUpSZzj8OH+U3b1U1M2BhE2Mv8I9+
         vqrrRNa5OA9HhlhBVpqgpBpk+jw8d9HwWsf/blISembtKeT6gaD0G3HT7EacBY1BhFNA
         QazbKzpgew+ACfErhewIOJ3thbxuc2XrD5GfdKyk8zl6bM+EIWPMksj6qQ3oBrXZOzwC
         mpWCSIUiPObAEG/CqyHrzXy7Fa4E05tF/kJHXvIHnKYcNxDDGyyKgG36WcNdxV5hs+0E
         rXurmLsgyIVpwv09sjXTYPzp89m0LKWKukArbhcO9O1hgvfCJNbxYu4tl3umhJy8fGfi
         dynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792992473; x=1793597273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c2vVLfr5r23oMNsvxAvIsVWSucEEuXtAs0YtxOnot1U=;
        b=zmmA1Lsu9jFnGluXAkWRAMCYOWB486I3ixr1XMwJY10f58kOjxwV4M43IENrpx3jof
         hyA9iKzh5qws6C0dh7L7SuHhkYkVp5JTQHm6cZyD1EDj3YdkRVFjMujQ4pqZW5RxWnqE
         JAOAHUMd0bzf3X/i7N3VbSzMfnkrXKYW1c+pdqSyY5sFmLCkVokR4z6wDFUgefWWz5WL
         wPj7IcmVMxnDeE3vOEi6n66mnkEMZjOJVsTNjNjOBojMTIgEsMkbdcg6zOxol7tADhnr
         R4Twm7H5VTcwvelsnE5t4eaxaKb1o8D5D/+asFkRXEvHQK7ow7QVmwVN0GnEHVjMNeV1
         B4KA==
X-Gm-Message-State: AFq9FYL9aC5MTb0isTYM2h8Fb0FckWz2t6Xhspvt6QFK6NC6GoBcOBKZ
	K/kGXIeKis/92b8qo/TpsENlXJ3eQ/dB1n2W77a54HpjDkOH1filAsFA
X-Gm-Gg: AYBFou0FdTlPH2J7ybroGJf6cG40nMbVheR5YvdGmbW9j8+p16YXX9dHrtXus0s4x4i
	s+FplNh7Goxxu6oN84+tb1Uk+SJljVbYc5RJeW2UOTXgmPIn2nfhI0bPUUIuTlmHijHudk8+3oD
	HI+5stYn7CEEQrLMfegtLt0Oq2cntLmZQxisNM2UljDglPkVf71kwUn3OsDs6r2lekl9segCmHb
	ATDe2L5LLgcIJ4kWHHuowJrBxCoK29i+XB+BwxyhllvfWV9s1wgZt+FQf14WTd5aX9bJTUFNYSz
	b8JP7rToNV1qUR4u7CC8hCP9Qd+vrcqSMbTFeVpaDz1SkISNN/xmXdz7fpMEWn9/ir6UiXuWYAo
	wZJeYs2ka4pRshMtE93CZIAbt+ADEJBrn1GdqJ9WA0ItVulWe3CKuogv/UrLDOxSrrAOTOqRz3Y
	4JfyJljs1jXm6bnD14bN4NsnJMM8TB44RjniXAitE3goLfCQ072bYulZcvRTOzXIWyIF96tcI+/
	PlPcR3E9wSmaX3RoC5w75QJ5vOnEbeOd1YdBFvSeGK4mNVbNMxu/E7wOm5dAfW2lbTOzZupqZO1
	OSgOFRfFYocz3UcWbQOBpgdFsg==
X-Received: by 2002:a05:7022:b04b:10b0:164:4e36:f956 with SMTP id a92af1059eb24-19935905c52mr8981726c88.16.1792992473149;
        Sun, 25 Oct 2026 22:27:53 -0700 (PDT)
Received: from localhost.localdomain ([136.25.42.214])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0e8d700sm25064523c88.10.2026.10.25.22.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 22:27:52 -0700 (PDT)
From: Tim Budding <tim.budding@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	lucien.xin@gmail.com,
	marcelo.leitner@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 4/4] selftests: net: add SCTP I-FORWARD-TSN tests with message interleaving
Date: Sun, 25 Oct 2026 22:27:48 -0700
Message-Id: <20261026052748.187496-1-tim.budding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <179293012994.3134.15218902499880345860@kernel.org>
References: <20261024120627.837568-5-tim.budding@gmail.com> <179293012994.3134.15218902499880345860@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 25 Oct 2026 12:08:49 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Low]
> This isn't a bug, but the deadline check and the poll() timeout use two
> separate now_ms() samples. If end - now_ms() comes out negative, poll()
> blocks with no timeout.

Agreed, I'll fix it in v2.

> [Severity: Low]
> Does the reset case check that queued I-DATA is discarded on reset?

[...]

> The test does show that MIDs restart at 0, because the marker is
> delivered. Could the test leave stale fragments, or a message in partial
> delivery, pending on the server when the reset is issued?

Agreed. As it stands, the reset test only shows that the reset
completes and that MIDs start again from 0. A reset is only performed
when the data sender has nothing outstanding, so in v2 the pending data
will come from two PR-SCTP messages that the client abandons while nft
drops the I-FORWARD-TSN: one partly received on stream 0 and one in
partial delivery on stream 1. The reset is requested once by the server
and once by the client, so that both new abort_pd() calls are covered.
The test then checks for SCTP_PARTIAL_DELIVERY_ABORTED on stream 1,
that RX_QUEUE is 0, and that a new fragmented message on stream 0,
which reuses MID 0, is delivered intact.

> [Severity: Medium]
> Can the RX_QUEUE check fail on a correct kernel in the ordered and
> unordered tests?

[...]

> Should this poll assoc_rx_queue() until it reaches 0, with a timeout?
> Or wait for some sign on the server that the I-FORWARD-TSN was
> processed?

Yes, confirmed. Lowering net.core.wmem_default alone wasn't enough:
there were no failures in 140 runs between 212992 and 66000. small is
then sent after all of big, but Nagle holds the marker back until small
is abandoned, and it then goes out in the same packet as the
I-FORWARD-TSN, behind it. With SCTP_NODELAY on the client and
wmem_default=70000, the ordered and unordered tests fail 10 times out
of 10 with "2464 bytes left queued on the association": the marker
goes out right after small, and the I-FORWARD-TSN follows one RTO
(300 ms) later.

Rather than poll RX_QUEUE, v2 will have the client wait (with a
timeout) until all of its data has been acked, i.e. until SCTP_STATUS
sstat_unackdata is 0, and then check RX_QUEUE once. The server's
cumulative TSN can only move past the abandoned TSN once it has
processed the I-FORWARD-TSN, so the check no longer depends on timing.
