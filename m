Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193832;
	b=18R7o9HMtAIY/rxnT9u8FnCIuJlqO3kGmZt7kuI0xzl0tHbdHsr2q1mPlserAFgvf0E5
	 LLVNKLlf7SsTXLGFlZsrC3ixbIO6lW+GaV0pQWoEKA1lYaVHXtXGqfRXzybFneGOUORKn
	 TeRPoTMemZ5Xboc4MPG4GbRHxwMcP2a7/2GKI145V5ED1sDTcvmG+AV/LlhMpaeSWiEf/
	 QLtCeGsrK/KSAJ/zHnnfy9fYkP0U/G704gGq1u1njSrF6kigdLh+8PVND7EVaaFyqgrHi
	 TcZZAlbbvTbDDScTZ/REhY6kBeBEmouHrcjz/EOsqbw1eL/Zd/gDeW7B9w/gQ0Zp1HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=harov6bGKXNbIaXbn3EkhNugTypkiw1014DpITyDDfw=;
	b=ZdYOdDvIn3exlhAEUCvwkpZBzpQF7W9tW1BEFHwhwZ+ilj5j/e65g0DkkJiSqenaXLOw
	 uok8zhZj1d9YMACtIL6AsS9bjtP129B6epqZfVixZryuOr6etxMRp5YNqS2B2tnym6KIo
	 ctkb+F+Xd7EAk8a7MCihuFWfKq3CKZL7jf9S/r8A/PUR23cCxFSC0IdxVwPwefW7EYa8t
	 svopmN30Qi6SWmpizQY3T7myQMY2BIPXbqRg+NMmZtwNDIKo2yqlOyu1gungjhelOaFM6
	 kTFYTzlviOjleQBE8qYt/+JtjkM0k2uhpDio8qWRYVyJuYQXawSgfCc8M/if+TMuEew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gWKBiOBL;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E44F606A320
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 03:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E44F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gWKBiOBL
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so227370a91.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 19:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794193831; x=1794798631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=harov6bGKXNbIaXbn3EkhNugTypkiw1014DpITyDDfw=;
        b=gWKBiOBLd+HgFioVhnby8UJUd18CiLBS9iamoSTg9OzvWUVgK7QlJbHnK3gVYFOjjh
         eyn9XeCWbHaoyIAjE3E6Bi8CIsrCaggKiD8/edGVeGY25Vd9Hz1/+Yp1fB1KJ2W0UnP6
         NuDkMbFePSGNMeB0m7fdBDlBCShT4VdvND7UQr8kb7zM9PBS7HEJzm3rOw6D04dv5n0W
         S2oSMKWKRujcr197v8rthfAzKZ5DRcD7u1IsBmQTrktulIybpejCRPKmfR3BgeIM7dZ1
         rXsI2gmkW0F65K2j3Zdwl/O6BnjflVuNGLKL3bGsiGHVhstynmy/n45Si/+37gT0yi0p
         /3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794193831; x=1794798631;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=harov6bGKXNbIaXbn3EkhNugTypkiw1014DpITyDDfw=;
        b=Zb2eLwmPX31/d1FxIOA4b01KOWuhhzuiMMAmWYi7bGZtaXlKYZYgRNqxladVaKU8M2
         bIG3tIz23dIGlaOavM9sRrH2V0QAgeuI9c+pkDI9+G75d6mnng/w9SqcbqGduOrR4HNX
         HYsIuqDSZBDSHhhU5wO+0bQiQgliCNaqsa8KrFgkqIwdYRCfJ/tjCp3hb0T7xtACGaZN
         GIGm6eSCKdCiJGDp6WJ5FDovY2yIlu8ohwmnZ8dtldFOXb2Iztt5JNtpF1Afrse0Wx55
         4ywkquwq0yPqs04TdRtC+cxLrptxeSt4IRG77Nmbj28MOOfy2Z2ImEvJ8x497JKwAAyP
         xhAQ==
X-Gm-Message-State: APuU4Z9ibNtVfpuODGBixXVpIklowpnkLWNwimFqYoNQIuegdgZIzqEs
	SU28LFllyBzKmPCsVFmmVc/391Cx/qAtRf+kdP9AmT1Sgq1eU3Kn+gBdBcIBtwq5HJbE4FRkB2k
	oiYesg8o=
X-Gm-Gg: AYBFou2+Y64Aku0Tr5p8mf2HqZ30blxDTRuXfFbM0YitqgU1rDQ5pH8xYMVJkfyPIyc
	qnyybYL3Y3bfpFIFFb9ezaa9pPiv1eMsKsF5VulV9xteHHTGMhF0/CNfOb/zMgCbnqALCKs36Ep
	qJp4YhkMSKj1g7xsOw2k91Wyi0QaK6D+cBeInJmkU1I7cZBpsZ4diWrEHqABK/oFd+rzr9RDZbP
	FnnVfgCBJqfKx0f9Pqiq+s7vMvYvFwZymX0GDNU2ASyFsVdiO6qqVN15Bnnd80ugH/xHSr1a+JA
	G7OsaVWySv7E0+ne4k7F2Ub8cGSTizawRHxCoNeUsnNMBRWNXHXcT9ECGoMl+EH/PLCSYlUcGyT
	fJD8zFsW4Hv6kBuLQDHxpznbtz0FQgYF07o+4GMkVwBbfwBN/O3ePCYW8JOT3/YGQyjefO6nV1Y
	PUZzmUAC8XzDGmn/rSZWtMRs9shPit60QyFcS720ky2P+7WVD5pZAO+M01OvrnSgYYSV88CMjyo
	Yh1CN6hRfyablOHGJsDQajBFq+bcMf9VBYDH1jK0JJXW0pxffmmumqKfvSK3ponLF04Jh1kDv5F
	rIe/jR+bmf9N/d0kKBpycx+SoJhmcGDXpCz9S68mddS//bAI0lXDU61ehHsydVidI1+eUiYm
X-Received: by 2002:a17:90b:1652:b0:3a7:e11c:4e6e with SMTP id 98e67ed59e1d1-3b12d5d4b51mr2627336a91.59.1794193830814;
        Sun, 08 Nov 2026 19:10:30 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1278d1191sm5284479a91.8.2026.11.08.19.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 19:10:30 -0800 (PST)
Date: Sun, 8 Nov 2026 19:10:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: RZ Z <zrzluck99@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [TCP] Severe CUBIC single-flow throughput degradation over a
 WAN path with Linux 6.8
Message-ID: <20261108191029.51572dfd@phoenix.local>
In-Reply-To: <CAGjTmwaxHE2acYOoDsCJGSmmfBdHm35Dc2EM5RCXX9+9R+6vdw@mail.gmail.com>
References: <CAGjTmwaxHE2acYOoDsCJGSmmfBdHm35Dc2EM5RCXX9+9R+6vdw@mail.gmail.com>
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

On Mon, 9 Nov 2026 05:41:51 +0800
RZ Z <zrzluck99@gmail.com> wrote:

> Hi,
> 
> I've been investigating a TCP throughput issue on a VPS running Ubuntu
> 6.8.0-31-generic.
> 
> With CUBIC, a single TCP connection only achieves around 3-6 Mbps,
> while four parallel CUBIC connections reach approximately 192-204 Mbps
> combined. Switching to BBR brings single-flow throughput up to around
> 200 Mbps.
> 
> I first noticed this while using Xray (VLESS + REALITY), but
> reproduced the slowdown with plain iperf3, so the issue doesn't appear
> to be specific to Xray.
> 
> The tests were in the VPS-to-client direction, with the VPS acting as
> the TCP sender.
> 
> Here are the main results:
> 
> CUBIC, 1 flow:    ~3-6 Mbps
> CUBIC, 4 flows:   ~192-204 Mbps aggregate
> BBR, 1 flow:      ~200 Mbps
> 
> One CUBIC run achieved 4.25 Mbps with 107 retransmissions. I also
> observed cwnd values around 2-9 segments under CUBIC, compared with
> around 539-666 under BBR in separate high-throughput tests.
> 
> The VPS configuration:
> 
> Kernel:           6.8.0-31-generic (Ubuntu)
> iperf3:           3.16
> Default CC:       bbr (changed from cubic)
> Available CC:     reno cubic bbr
> Egress qdisc:     pfifo_fast (enp1s0)
> TCP ECN:          2
> TCP SACK:         1
> TCP timestamps:   1
> 
> After switching to BBR, I also checked TCP statistics and noticed
> considerable reordering-related activity.
> 
> For example, one long-lived TCP connection reported:
> 
> rtt:          83.675 ms
> cwnd:         8
> retrans:      0/29
> reordering:   114
> reord_seen:   428246
> rcv_ooopack:  94147
> 
> These statistics came from a different connection, not the original
> iperf3 test, so I'm not sure whether the reordering activity is
> related to the throughput issue.
> 
> I also encountered a similar problem on another server with a
> different configuration and an entirely independent client network.
> Switching to BBR helped there too, although I haven't collected
> equivalent plain-TCP iperf3 results from that setup.
> 
> Could packet reordering or TCP loss recovery explain why CUBIC
> performs so poorly here? I'm also wondering whether any relevant
> changes have been made since Linux 6.8.
> 
> I understand that CUBIC can be sensitive to packet loss, but the
> difference between single-flow CUBIC and both parallel CUBIC and
> single-flow BBR seems unusually large.
> 
> Any suggestions on what to investigate next would be appreciated.
> 
> Thanks!

Is this a regression, was it always this way? 
It would also help to look at pcap traces and/or TCP statistics.
