Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FFE1B142D;
	Sat, 18 Jul 2026 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.149.7.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784387204; cv=none; b=fN2s6VJSjmE1TrBwNdrsHYhn0jyB3JJv1obg6NyZPK10OVQzNKvQ4fp1MF131vQQ6pFJvy+c3dj7pKo8sO5fOtK/xEHY6zUmtyOznjTdMpVtPtQk8TnZoL2ov/NmdvXQ7ToyFsa36GU8XlQPzTuDUONXsaW1+zoN30yVtln0VS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784387204; c=relaxed/simple;
	bh=hAazbtLbGPvg68/QEWdZIog3RJ0Qta6iB47bnxY5B4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=stItpzFydBGJWHzRNVSOy7Lq1rGBeU5z68BB89v33+aiF3z87V9O/0Zs4NGCZGLVrWNcknLW0aVw5CmjXCYQShFAl6XekD7BP2p+ND0zGKz+ss/d6oQCfC/euyqOIyKaxUj0i4LBStvRBSOqe8dVB6j5WhfkDiaCGzuF67LOVfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de; spf=pass smtp.mailfrom=tu-berlin.de; dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b=ZM8z6a8m; arc=none smtp.client-ip=130.149.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b="ZM8z6a8m"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
  d=tu-berlin.de; s=dkim-tub26; t=1784387200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lrHGpb4MGAOGEcAN0C6vTEWtRmFxRuxO7XqicIm2G+4=;
  b=ZM8z6a8m4qvZBjEwzp8sfulQ43ILFnYg1zE72TmJMq34xObq7ZgYC711
   GoLtxvSkan52/hY8J+ouMbPbDIlGsCAjJDnKJSIPLr+IU/gNejWjoek5b
   bNyaRTc25owgirGTVGTuM9Wi87Y8tci7uVaeT0wgHITp98G8PW063xMTW
   8ZIoMURrMHYppmqdyayxFjXuKnTLvtWeD8wppOWO6tK02DWier5HHFnOM
   JLb0c4SxLLRxmjSPdeUI1sk8qa/Mi66igaPLPbNrWy3Wh1mkCEMrNI63b
   1kap2aK7E3/UevFwnORiq9zZ1SXkEtwsaSPIWwwQDY1OlHgL56kO1ESm9
   g==;
X-CSE-ConnectionGUID: nitGZflbRE2zT8Cu6J5MmA==
X-CSE-MsgGUID: Rg37fanBSlGbdO3HoeOJ6w==
X-IronPort-AV: E=Sophos;i="6.25,171,1779141600"; 
   d="scan'208";a="50146831"
Received: from mail.tu-berlin.de ([141.23.12.141])
  by mailrelay.tu-berlin.de with ESMTP; 18 Jul 2026 17:06:31 +0200
Message-ID: <431c1b00-1fd3-41e1-8e8e-9cc1738ae387@tu-berlin.de>
Date: Sat, 18 Jul 2026 17:06:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/sched: sch_cake: skip clearing unused tins
 during rate adjustment
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: <cake@lists.bufferbloat.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mike Pham <mikepham4321@gmail.com>
References: <20260716-sch_cake-skip-clearing-tins-v1-1-d9787df20c28@tu-berlin.de>
 <87wluuj9ue.fsf@toke.dk>
Content-Language: en-US
From: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Autocrypt: addr=j.koeppeler@tu-berlin.de; keydata=
 xsFNBGKoX2oBEADALIAULJM44m9N+afmComnvXvE0htMn8fjTk5ht1lvR+YoGNvu+V011yGw
 BAs46yE35u4DyUF+YqQM95meSQZCJcV/sCjZi9qtOqnEAX+Ympz5JtRiG1SkWJ0S5X5tg1hH
 nQyI5MYfwDpefWpij79jyGAL72lgWBMZRHvCriGkt5/hRI4S4zyweeljqojaG2ZHDbgqW0TG
 uVAllHwCnEJ4NDqAMkMUU6Zt6NWBPspZKftGTGIBT21uBA8ttJgfQSvTPHmAytPq3C1+Cfka
 pBV7B1BaI0rbw6Kr3uDYwrNJ17ZEAEhg7OYIIkxueUjq+5fW1P7cccfNEhYWv/8FFUYCm98a
 NQmZns5wfq8C2KSSptpT8Yztpbsd292XUjZMAH3katujnzwnRq0QjexFZ4wQtSjZu7LR2+LC
 x2OrwAcLcPfWYfBsE2qOkGZU0q3X1IAjfoJ2LDw4RxyhNLcv/6zEddvU4Y1EGf7S75lxzNHo
 ttpz/dQ3toEEegq75MEz6ss1cYN4P5vxajvPZd5KMZKwrTEr1jNwzzuTCN3hKArRup9AHsxz
 g9U0dCtY+lxiSzDORLqKOZ4OLFDBau6vMF7IbNX1fs8HA3UnGgWKmRwI6wjic66JVlB4sGcL
 fL/sMdcoRTDvfnwrleHjLuKXYQ8yv8XUfnQxJkCQhfvdEHR2tQARAQABzSpKb25hcyBLw7Zw
 cGVsZXIgPGoua29lcHBlbGVyQHR1LWJlcmxpbi5kZT7CwYcEEwEIADEWIQTqFylTGDYSCHaY
 fE10M20hpTcQ9QUCaL7VWAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEHQzbSGlNxD1dpwQAKZT
 oHwBH7f5n9JFn2zHy8vIzyyhBFw7SVwJSEChXCVx47EEFmkiNSmBWUxNZZEyAbDFbeDrh/fO
 g7fUoQLsXJ0e1QWEXo4W6XhtFlx1TYSrPCIpCOAc9eetCksm/oO9/WJkCdk4PaJR0OJqoO5O
 yEZpb8PAwqIFvXfFkJn8nwY3lWVC1jdkE6dYMpjmC2T5rbf0KMDYH2uJV/opa6uvZUlQzmHN
 E88276ubWIFMuuYxIBdvTL1SrwGWRNwQDWOe6fBJ8/xReP3AVWHSehwzL2AyCyeBdVDCDoyz
 5k0tusI/UuZP9aco5+nyg+jRB5Jb0DYTZAm2KLA3bAls4p/AAa0bi+9bIdNgPeVAG4HnY67V
 fQDSlFhBO32rGn6GX72c2dzKw4nQ5HjtbuSszp4rH0rYPTOene6zpJ8dGsJ2Mc4agjIhYEB5
 BFDgeFGlsEI0lFWUMI77QuMZ59b8Zx6WXqrh7iKM2Oi4e91htyFVDCzCilaECM2kwUV1eavi
 vrsoGxczOc6rxNtTw56KYQCMHHVSlKt1b+zY9XdA6sVNulW7zsZaDTvG5Jbyw9cwpd7slNEK
 r8mbQ11TrRv1baUil9GKfdi8WhyLOUgYyUKSIXIFzeCutr4++2cqZW5B/GcBe40Vik8FTHSy
 1uwnTHW5fFV1cVhA+W103e1PxY8qlPlCzsFNBGKoX2wBEADFqdvGoBmerSMSa8SBElSt065u
 a3nkX8KQ33pFFF5uXAxhmie770dGnO80Nfd9O1fguq+atM0xjA+OWfInGtAJVfKauYS6lIMJ
 sONv2s76lmkO6WqJeMiiysjKV+0cSKWLeUTuIeJCy0WLUNUFJZelT0wJ3gj/2q+4K4IS79gs
 G72B0+pe5PyluG6CEhQc4Lo6OHNIllbREhFhl5xjycDtWWAEitdAPQ4Bt3oBBzNsQ496j0GE
 jqy0DKItEiF6QcojzVO3/PH9hxku2QqcEmyKbea2zcyIjUkuuaB8RVHTyuDaJJYhuXymObNB
 Bgimk2RAyg2tktGGv5r204WX+V4kWvH0ZLCCx+hVw/VRZofZMQYBkf87VsaYmQxFdbO8OnQx
 GVjO/Kc50h3QoVbXMwl85fExbFgsAKbwugnwEQpay/ongpzdMFROrcCSD+TZz/DQ/DlMUe4C
 YKax0IIA6mBa0mhcT8jXjpyabple9fNaHAaE2MdGhDw6UnQtAuTF3xWN75LDBNJjxTKTtVOY
 ye4JTnlqEDOa2I4IvZhMT2MX/nNJA7n9nsRHcFm2o9NTkPV5B8NyZCvgsy3SLnsOZTCxWSNG
 uw0Cdcm+uqgPUPJNimBxptrPT+4BciB1z81sKfyh5GoAitEZgFlntZ1JFk31YUmk5kIh2NNh
 /Lfh8Hr2hQARAQABwsF2BBgBCAAgFiEE6hcpUxg2Egh2mHxNdDNtIaU3EPUFAmi+1VgCGwwA
 CgkQdDNtIaU3EPWD4RAAo0fatobyXEHYTZx8QSR4qS0/53eY7iAerZs4IJ4w8qE1gAcq6Iej
 nX+tqzV5paqJTxRTalD38OAyglkJgCj2HSOusZZPlbeuBfbQzJida9TtRRC2EJzunVM8reu1
 VRisERIwlnfvPzXQBrwe/kudKmWOF0M/hvH7F7ME1GJUoFxxAjB4tqGbiCAo5Y4bxAz/AoPJ
 1pC7rr+qLIwfs7hVAymKmEswjUkDI0Ivq5wHSjwnKFVgZAHNsa7gfmJjZyyOFQwsGnWlCjiu
 dkrfYJvbcF3Qs5aqIfEoZduQJGOL3KZeCdfJNP/2p7SMKHs9zu73x0UKS/GFy64eCaHmTzIJ
 Lg8CMrYAaoX+8PmLTUjDrlAtISjaVkxrbDOus2c5r9LlMkOb3JT6UgLR7ga6/JHYZI5hY7G3
 chAdCroPnAhXD6ig1NxbpiP8yiIIMtJ2ETjlQn+BdQ3eXDR+5xg4NV7TWYMGTbNpjFOlWRGy
 b2JTUKogGs8gv+VHCsbTEX7OgGtcLCP6KYm+HR1ck1OgCR26TEx391l7GhKYqSuz6+W/2sPV
 CikGA/IZrRg3uRfoZhhPv8zgn9I7eUL3szWhj+QD0h2LBCAmAMAWcmfFQkevMq0O2Q5zgSkb
 wAlsQfDpMEv9+nJcdit2gRZimHjbfuZSHZnaJeWnwsKDBh278W8VHQM=
In-Reply-To: <87wluuj9ue.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 7/17/26 10:31, Toke Høiland-Jørgensen wrote:
> Jonas Köppeler <j.koeppeler@tu-berlin.de> writes:
> 
>> When cake_configure_rates() is called from the dequeue path with
>> rate_adjust=true, it only needs to update the rate parameters. The
>> loop that clears the unused tins is both unnecessary and harmful in
>> this path:
>>
>>   - cake_clear_tin() overwrites q->cur_tin and q->cur_flow, which are
>>     actively used by cake_dequeue(), corrupting the dequeue state.
>>   - iterating over the unused tins and their internal queues to purge
>>     packets adds needless overhead to the hot path.
>>
>> Skip the entire loop when rate_adjust is set, as neither
>> cake_clear_tin() nor the mtu_time update are needed when only the
>> rate changes.
>>
>> Fixes: 15c2715a5264 ("net/sched: sch_cake: fixup cake_mq rate adjustment for diffserv config")
>> Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
>> Tested-by: Mike Pham <mikepham4321@gmail.com>
> 
> Do you have any performance numbers to show the impact of this?
Yes, the table below shows results from a test setup using vng with
2 network namespaces, with cake/cake_mq attached in one of them:

     ns1 -> cake/cake_mq -> ns2

- veth devices are configured with 8 rx/tx queues.
- cake/cake_mq is configured with a 2 Gbit rate limit.
- Running flent's rrul and tcp_nup tests with 32 TCP upstreams:

legend: qdisc mq = cake_mq; mode be = besteffort, ds3 = diffserv3
         test nup = tcp_nup; base/load = idle/loaded RTT (ms); tput = Mbit/s

+---------------------+-------+------+------+-------+-------+---------+
| kernel              | qdisc | mode | test |  base |  load |    tput |
+---------------------+-------+------+------+-------+-------+---------+
| net-next            | cake  | be   | rrul | 0.075 |  4.76 | 1473.69 |
| net-next            | cake  | be   | nup  | 0.078 |  6.23 | 1550.79 |
| net-next            | cake  | ds3  | rrul | 0.063 |  5.81 | 1526.75 |
| net-next            | cake  | ds3  | nup  | 0.046 |  6.09 | 1761.45 |
+---------------------+-------+------+------+-------+-------+---------+
| net-next            | mq    | be   | rrul | 0.810 | 11.78 | 1469.67 |
| net-next            | mq    | be   | nup  | 0.637 | 85.71 | 1243.15 |
| net-next            | mq    | ds3  | rrul | 0.397 | 15.28 | 1770.06 |
| net-next            | mq    | ds3  | nup  | 0.351 | 15.98 | 1799.39 |
+---------------------+-------+------+------+-------+-------+---------+
| this patch          | mq    | be   | rrul | 0.092 |  0.56 | 1873.40 |
| this patch          | mq    | be   | nup  | 0.109 |  1.82 | 1869.12 |
| this patch          | mq    | ds3  | rrul | 0.097 |  0.98 | 1866.10 |
| this patch          | mq    | ds3  | nup  | 0.101 |  0.51 | 1861.79 |
+---------------------+-------+------+------+-------+-------+---------+
| before 15c2715a5264 | mq    | be   | rrul | 0.073 |  0.30 | 1895.45 |
| before 15c2715a5264 | mq    | be   | nup  | 0.076 |  0.49 | 1905.57 |
| before 15c2715a5264 | mq    | ds3  | rrul | 0.069 |  0.31 | 1896.59 |
| before 15c2715a5264 | mq    | ds3  | nup  | 0.058 |  0.86 | 1884.01 |
+---------------------+-------+------+------+-------+-------+---------+

Not only is p99 latency drastically reduced -- nearly matching
pre-15c2715a5264 results -- but on current upstream cake_mq,
throughput also increases as a cake mode uses more tins. This points
directly to cake_clear_tin() during reconfig as the cause, since it
clears (max_tins - cur_tins) tins each time. So the fewer tins the
current mode uses, the more get cleared on every reconfig.

Mike ran also some test on OpenWrt, on an IPQ8074A with 4 rx/tx
queues, and saw similar trends. cake_mq is configured with a 2.2 Gbit
rate limit.

Unfortunately, we only have data for 128 TCP upstreams on net-next,
and 64 TCP upstreams for 'this patch'.

+---------------------+-------+------+------+---------+----------+
| kernel              | qdisc | mode | test |    load |     tput |
+---------------------+-------+------+------+---------+----------+
| net-next            | mq    | be   | nup  |  468.50 |    50.90 |
| net-next            | mq    | ds3  | nup  |  355.22 |    98.21 |
| net-next            | mq    | ds4  | nup  |  268.28 |   255.84 |
| net-next            | mq    | ds8  | nup  |    7.48 |  2023.66 |
+---------------------+-------+------+------+---------+----------+
| this patch          | mq    | be   | nup  |    4.24 |   944.35 |
| this patch          | mq    | ds3  | nup  |    4.27 |   937.75 |
| this patch          | mq    | ds4  | nup  |    4.24 |   936.97 |
| this patch          | mq    | ds8  | nup  |    4.32 |   927.89 |
+---------------------+-------+------+------+---------+----------+

This again shows the same trend: throughput increases and latency
drops as cake_mq is configured with more tins. We're still looking
into why net-next+ds8 reaches close to 2 Gbit/s, while this patch
tops out around 928 Mbit/s.

That said, this patch doesn't solve every issue yet, but it does
remove the regression introduced by commit 15c2715a5264
("net/sched: sch_cake: fixup cake_mq rate adjustment for diffserv
config").

We're continuing to look into further improvements. Let us know if
you'd like to see additional tests :)

- Jonas

> 
> -Toke

