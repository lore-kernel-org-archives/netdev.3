Received: from mail-ej2-f8.google.com (mail-ej2-f8.google.com [74.125.228.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DBC41DDF2
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206136; cv=none; b=KHMvWreRVkKBb7yF1tIPlWJlfSryA8505Gz0/rM9pUwgRA/2t7oYwvSyhueTpknJCd9cQwFQmiwqi1whqtT13r+OwKiqqd1PYILZJZNjfYSA2Qc77B27Eyv3kGwvTwQoj0bB+hgovwsaawnLVWKCqJ5cAHSaZNkn5Tl5fg5rhbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206136; c=relaxed/simple;
	bh=ip4sQxiLna/ToxCgOhvrUsXrGy8bJ+psRYf7SUIY//Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7QBWi5CrIjKhDnqyTxsnICSliogV4K8bphnDwgElIKuR6YelbCRoZBCPhcPn4jIVXIZjBxXpDboz3Tg3irAz0PTMDPNorQIfgJo8LQThBA+1gQ2o96GyWYSqiKpio8uEnaf+EfCillzH8k30j+XbB2KT9pJNgPvG2UtJgCBiL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsDzUHfc; arc=none smtp.client-ip=74.125.228.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsDzUHfc"
Received: by mail-ej2-f8.google.com with SMTP id a640c23a62f3a-c2e778eced8so4237766b.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 06:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791206133; x=1791810933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=APGEWYTdX5ekEad6u2mFpTvlpOIrqRfIQzKHzYJpg04=;
        b=lsDzUHfcD5zaqKNLrHO+U22UbN1MZ1c+Au3gZUIHvJRsMNJP76ze1dFgxR8N4sBXzX
         2L5nbnJfNWPxgStdmu0XNTlVv/YakbN7IJXj05RQNWWExDpzeJdiC6PoEYAFpTbNrMqs
         A9Ylo99xQLc9oBFc9an5SbJT4IZIzUPwZASMAAV38YtAoN6qLyS0ELIv65yK456U/+Jx
         wgz9geLvwUzVTIJOKwLcv8UTkoVSxozsk/K6ZZwi/8Ilvjydmxh2LAsImfqatqQCGIFU
         gUOBeIJc8ksHltNDhZ46PRlgPGflN1J7CDu6nYJdhnmx/tIPg3/dmIyuCbrWow2SPHbS
         iKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791206133; x=1791810933;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=APGEWYTdX5ekEad6u2mFpTvlpOIrqRfIQzKHzYJpg04=;
        b=UHGNRvr7jqMVxszhIR8xKnzg2B003H1rTzzjWmqLo4gPl0H3GBVru1siRFzjKVutfa
         yGvBlKHnDjJCHZRCCUNtNCUxffBJKnQ58DafIWJCSoe4Ls+Nc8eD5xFAwL9Hmsg9QreL
         SmGZT8MOR8Ec2a/Y83IokYYEJFWjq7+TSJhbgb8VtFiJfAeSgMGFpOXRpfBkFyyUB925
         sIDJcTcSYiYZc5RfJY6PWqBjF/Wg8uwieubshxTIZSpWPJTGeaIZ/NUEOAb82EbUNwhQ
         QsoaWB5wbg6vGRkGcE8WcM3eDfoWGjQTVBxbVfO213UCYJpDqOCQk6tHZu1N1XuB62kf
         eCFg==
X-Forwarded-Encrypted: i=1; AKwUvBzfdpAdPllCzX2crS14S4emnWQau+hCA0gvrD+AktDPpk5WEOCTnI2133U6HLfCjKilqvb4w6Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lFkP2uWUk8t7UbeVt7O7OWImGEO9Bz5jEmUiWU6vss8cNcZf11
	MmJnP8pC59gqgTAwJCqc/i6VN/W2NgeaKL40DQd2qsfsDvUpdTYlnb5M
X-Gm-Gg: AYBFou3510zjYB6OHryx6rO5GrgEIExqdf6wq3/MzROkMVn3EE2c4WNcLF7S0nEINxz
	wO821O2CBOWV4FhIteocWSYXfHMgnTmWV3mgE4ssvoFU2LUcvGwNhePemiaAa9XOC0/JRWSEOES
	J6Hnx9XgV8/0ROx5L5/22n8+S8cxHrF2uAj9uKoxPHnf09xRmyQ3wAclB/Rh3TY4aE2a8eU4FQe
	jodSmFswJV6+f4krmQF86I4VKXpuUxZjwTDXin2th6Bhn5LbffQZ8zqFMfc3O1GFpM9hMeybyLK
	W47maYerqGmpU2KDLBv4/R8Qf++P1IaYMOH64EN4bRY0f0CXKRO+6NVgsUIIYb+LlhdqeV7Y+5L
	iCdmHtH1RQKU+3KgJgm1islyANBCQZlbBuyPPKeSTjwwRitDIDagaRwXGRFBJE9FUVDkJkeynAB
	ugGEm0qrmI/xaPJq+FJA4ixe2F9RxfqoGlFWcifKEUIM+2rLJaZZVtc/DwVu3OlRP+STle
X-Received: by 2002:a17:907:d8e:b0:c2e:3698:dbba with SMTP id a640c23a62f3a-c2e4b20716emr996050266b.4.1791206132959;
        Mon, 05 Oct 2026 06:15:32 -0700 (PDT)
Received: from mariusz-msi ([149.102.244.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3156090469sm80050866b.8.2026.10.05.06.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 06:15:32 -0700 (PDT)
Message-ID: <0b7aadda-c768-45bb-a322-24df31f8f823@gmail.com>
Date: Mon, 5 Oct 2026 15:15:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/10] tcp: support non-GSO jumbograms
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, dsahern@kernel.org,
 idosch@nvidia.com, ncardwell@google.com, shuah@kernel.org,
 kuniyu@google.com, alice@isovalent.com, Jakub Kicinski <kuba@kernel.org>
References: <20260608130755.5626-1-maklimek97@gmail.com>
 <CANn89iLjG0krEoEE__3KUrcK+ZO+USZRC_2qZV5hAsxRpkTmhw@mail.gmail.com>
 <715cf429-9f2b-4898-84b4-15dfba4a9a8e@gmail.com>
 <20260609152704.2512ce9d@kernel.org>
 <85eaf82a-28bf-4d3d-958d-1225a7ae9608@gmail.com>
 <f926259d-4612-44d2-9711-4a408e41e7f6@redhat.com>
Content-Language: en-US
From: Mariusz Klimek <maklimek97@gmail.com>
In-Reply-To: <f926259d-4612-44d2-9711-4a408e41e7f6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/10/26 22:10, Paolo Abeni wrote:

> On 6/10/26 4:16 PM, Mariusz Klimek wrote:
>> On 6/10/26 00:27, Jakub Kicinski wrote:
>>> On Tue, 9 Jun 2026 19:01:02 +0200 Mariusz Klimek wrote:
>>>> I understand your concerns and they're reasonable. I would still like to
>>>> proceed with this series, though. What can I do for you to consider this
>>>> series? Would it help to submit a few less-significant patches first before
>>>> resubmitting this patch series? Should I resubmit it as an RFC?
>>> AI tools changed how much we value code, but they did not change much
>>> about how one joins a community.
>> OK, I'll start with smaller patches to establish myself more
>> in the community. I am still interested in eventually getting this
>> series through as it can speed up workloads relevant to our company.
>> Do you think this patch could potentially be considered down the line?
> If you are strongly motivated to do progresses in this area, one thing
> you could look at is the root cause of the performance difference
> between the veth jumbogram and the same size veth big tcp test: I'm
> quite surprised some delta is visible there.
>
> Possibly perf can outline some bottle-neck in the big tcp path that
> could be ironed-out.
>
> Also it could be interesting if some devices could do H/W GRO based big TCP.
>
> /P
>
Hi Paolo, it's been a long time.

After some research I found out why jumbograms outperform BIG TCP in the 
iperf3
over veth test: it's because Nagle splits BIG TCP packets but not 
jumbograms.

BIG TCP assumes packets will eventually be sent over the network, and so 
applies
the Nagle test over the real MSS of 1500 bytes. If a send occurs before the
last ACK is received, Nagle splits the BIG TCP packet into two packets: one
whose size is a multiple of the MSS, and one that contains the remainder
(tcp_mss_split_point and tso_fragment). The remainder packet is queued 
and is
only sent once the ACK is received.

In the jumbogram case, the jumbogram's size is already smaller than or equal
to the MSS size, so Nagle doesn't split the packet. The ~5% performance gain
comes from avoiding the packet being split in two and having one packet
traverse the network stack instead of two.

A simple way to prove the above is disabling Nagle with the 
`TCP_NODELAY` flag
and seeing that the performance gap resolves. I also ran iperf3 on a kernel
with the `limit >= max_segs * tp->mss_cache`, `limit >= chunk`, and
`limit > tcp_max_tso_deferred_mss(tp) tp->mss_cache` checks removed from
`tcp_tso_should_defer`, and it also resolved the performance gap. Perhaps
tcp_tso_should_defer should be fixed to so that these BIG TCP packets aren't
split?

While debugging this issue I tried restricting the iperf3 client and server
processes to one CPU. That reduced the number of packets that were split to
around 10% (from 60%), but surprisingly the throughput also increased
significantly and was much larger than the other tests. It appears that
restricting the iperf3 client and server to the same CPU fixes something 
else
and provides a 12% improvement over the base case and a ~7% improvement over
jumbograms. I can't explain this improvement yet, but the reduction in 
packet
splitting is likely due to less racy execution that makes the Nagle case 
happen
less frequently.

Measurements (output of a python wrapper around iperf3):

[ROUNDS=84 MTU=1500 GSO_SIZE=524280]
IPERF3 BITRATE: 241.35 [95.0% CI 239.81 - 242.91] ±7.17 Gbits/sec

SERVER RX PACKETS SZ=862:    406030.32 [95.0% CI 374158.02 - 437902.63] 
±144141.51
SERVER RX PACKETS SZ=511310: 401084.13 [95.0% CI 368103.20 - 434065.07] 
±150101.57
SERVER RX PACKETS SZ=512086: 197816.40 [95.0% CI 162980.59 - 232652.22] 
±160523.86

CLIENT RX PACKETS SZ=86:     647034.43 [95.0% CI 636767.16 - 657301.70] 
±47311.70

[ROUNDS=284 MTU=524280 GSO_OFF]
IPERF3 BITRATE: 252.56 [95.0% CI 251.67 - 253.44] ±7.55 Gbits/sec

SERVER RX PACKETS SZ=512094: 616549.29 [95.0% CI 614399.99 - 618698.58] 
±18401.15

CLIENT RX PACKETS SZ=86:     616754.45 [95.0% CI 614599.64 - 618909.26] 
±18448.43

[ROUNDS=84 MTU=1500 GSO_SIZE=524280 NODELAY]
IPERF3 BITRATE: 252.96 [95.0% CI 251.36 - 254.55] ±7.36 Gbits/sec

SERVER RX PACKETS SZ=512086: 617684.17 [95.0% CI 613782.72 - 621585.61] 
±17977.91

CLIENT RX PACKETS SZ=86:     617721.74 [95.0% CI 613817.65 - 621625.83] 
±17990.11

[ROUNDS=84 MTU=524280 GSO_OFF NODELAY]
IPERF3 BITRATE: 252.21 [95.0% CI 250.54 - 253.88] ±7.69 Gbits/sec

SERVER RX PACKETS SZ=512094: 615726.77 [95.0% CI 611620.41 - 619833.14] 
±18922.17

CLIENT RX PACKETS SZ=86:     615912.33 [95.0% CI 611836.51 - 619988.15] 
±18781.42

[ROUNDS=125 MTU=1500 GSO_SIZE=524280 NCPUS=1]
IPERF3 BITRATE: 272.80 [95.0% CI 272.37 - 273.23] ±2.42 Gbits/sec

SERVER RX PACKETS SZ=511310: 6074.89 [95.0% CI 5988.63 - 6161.14] ±487.24
SERVER RX PACKETS SZ=512086: 652866.16 [95.0% CI 651750.82 - 653981.50] 
±6300.23
SERVER RX PACKETS SZ=512738: 6454.82 [95.0% CI 6355.94 - 6553.71] ±558.58

CLIENT RX PACKETS SZ=86:     655050.50 [95.0% CI 653940.67 - 656160.32] 
±6269.06

[ROUNDS=64 MTU=1500 GSO_SIZE=524280 DELAY_PACKETS_UNTIL_ACK]
IPERF3 BITRATE: 251.64 [95.0% CI 250.45 - 252.83] ±4.78 Gbits/sec

SERVER RX PACKETS SZ=512086: 614318.41 [95.0% CI 611402.89 - 617233.93] 
±11671.76

CLIENT RX PACKETS SZ=86:     614633.78 [95.0% CI 611697.43 - 617570.13] 
±11755.14

-- 
Mariusz K.


