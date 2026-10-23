Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792766312;
	b=0nJPLS0eoAoGgTxsyL9sGK6ztF9zIdN/EYIE7Zd/nD7cO+Cf9jvmwn2KG8YS1ymtt94J
	 Nf/anibDuk0MucTmgl5m2PLXGtm5BNxgHDb2Jk7AS3p4peZ5gcEiEGIarK1AHyEb316Si
	 Kw87BhO/RV9AuX7GMSMOY1FqBG0W5seXojNtBoSBvmSiYZ81RlAhvW+8WwfC4jNi0caOG
	 I5Uxjb7RxImoLaPnHl0R4Oq2tPaR0pmpAktoazfwjeGaL8L6nXR5iGMFtPTuCFII+6Vnx
	 hBLw3AAAM50nFJk3P6/OD09Kz3sxUJq5j0A98NNL1R1r5ZoRGvuv5ZjSpqT8SXwowMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792766312;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=kQ5Euxh4eWKfjmf+VxO2FAHxL5iuRQRr7X7DBc2dmGo=;
	b=YwoUCU4zRZWE3zsAaqKrZxZ2xXoxfWX1dxtGayO8+BfXwm1DIAwrt7iTjffFpuvKMn7O
	 ZcgsFzpgfyNmSzvMY/46V+m+4LPTaEmM4Snjw2NiRwqf2sfrXPCnxNR7fU9g6SQ20MD1L
	 kzWrrro58gXY64KL6quWbWE7zYXPNPZPvZ32Vr1SSASCvWLtWeu0uHgvmZeRsMsSCyZeS
	 aFzaJ3wlXs+J4whFt3ZWc4HyHK4EdjMthAtLvc9JR7YjjxbEMfeTdSi41m2CxT4a6029t
	 APm183/61WhuIbJqaTHUbPZONYoXrHT+rIsH+INK0Xhx3nbWq8QefTAPEXYIWAfg/1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FsoU2OQ7;
	arc=none smtp.remote-ip=95.215.58.122
Received: from mta1.migadu.com (out-122.mta1.migadu.com [95.215.58.122])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F306606A320
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 14:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F306606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FsoU2OQ7
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=j8gJ27Gf/j7LIMrLxBBttSWL/fhFYRGB6DAMZu/2NvQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792766309; v=1; x=1793371109;
 b=FsoU2OQ72xj/oBQX3lx08Z/g80MwWHKlUATyo1RQQM8szwrqDeFdCFUB+6jA8/7Ll+Z3gGRA
 guZcutHZ4LTNOUIMzYE275z4rIfm/16ZD691pI0gdB+JcoUvIBQ557qMu5sMFenUpRAB8UZbBCE
 ThMoa+C638zPzK6CbrtY2YyU=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0b8dddf8b4a13adc;
	Fri, 23 Oct 2026 14:38:29 +0000
X-Mizu-Trace-ID: 0b8dddf8b4a13adc
X-Migadu-Flow: FLOW_OUT
Message-ID: <bda9e46d-9e70-495c-84e2-e887e707d70f@linux.dev>
Date: Fri, 23 Oct 2026 22:38:22 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/5] ipv4: fix shift-out-of-bounds in
 ip_rt_send_redirect()
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Joel Granados <joel.granados@kernel.org>,
 Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
 Wyatt Feng <bronzed_45_vested@icloud.com>, Yung Chih Su
 <yuuchihsu@gmail.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>,
 Flavio Leitner <fbl@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
References: <20261023091419.167088-1-jiayuan.chen@linux.dev>
 <20261023091419.167088-3-jiayuan.chen@linux.dev>
 <5dda588d-e6fa-420d-a73d-b5278094b59c@suse.de>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <5dda588d-e6fa-420d-a73d-b5278094b59c@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/23/26 10:11 PM, Fernando Fernandez Mancera wrote:
> On 10/23/26 11:13 AM, Jiayuan Chen wrote:
>> ip_rt_redirect_number is the max number of ICMP Redirects we send to one
>> endpoint; once we hit it we stop. Before that, ip_rt_redirect_load gives
>> the redirects an exponential backoff:
>>
>>     if (peer->n_redirects == 0 ||
>>         time_after(jiffies,
>>                (peer->rate_last +
>>             (ip_rt_redirect_load << peer->n_redirects)))) {
>>
>> n_redirects only stops growing when it reaches ip_rt_redirect_number, 
>> and
>> both redirect_number and redirect_load are plain proc_dointvec sysctls
>> with no upper bound. Set redirect_number past 32 and n_redirects climbs
>> past 31, so "ip_rt_redirect_load << peer->n_redirects" shifts a 32-bit
>> int by >= 32 bits, which is UB:
>>
>>    UBSAN: shift-out-of-bounds in net/ipv4/route.c:949:6
>>    shift exponent 32 is too large for 32-bit type 'int'
>>    CPU: 1 UID: 0 PID: 1845 Comm: ping Not tainted 7.3.0-rc7+ #364 
>> PREEMPT
>>    Call Trace:
>>     <IRQ>
>>     dump_stack_lvl+0xc1/0xf0
>>     dump_stack+0x10/0x20
>>     __ubsan_handle_shift_out_of_bounds+0x1d1/0x390
>>     ip_rt_send_redirect.cold+0x2c/0x146
>>     ip_forward+0x1ddc/0x2430
>>     ip_rcv+0x2b1/0x320
>>     __netif_receive_skb_one_core+0x16b/0x1c0
>>     __netif_receive_skb+0x21/0x150
>>     process_backlog+0x37e/0x1200
>>     __napi_poll.constprop.0+0xa5/0x5e0
>>     net_rx_action+0x4c0/0xf70
>>
>> Fixing this from the sysctl side would mean bounding both knobs, e.g.
>> redirect_load to [0, 65535] and redirect_number to [0, 16], which gets
>> in the way of users who legitimately do not want to cap ICMP redirects.
>> Instead compute the backoff in u64 with the shift count capped at 31,
>> which cannot overflow since ip_rt_redirect_load is an int, and clamp the
>> result to MAX_JIFFY_OFFSET.
>>
>
> I think we should cap redirect_load with a minimum valid value of 0 on 
> the sysctl. If the user want to disable ICMP redirects or do not cap 
> them, they should use 0 or -1 in redirect_number IMHO.
>
> What do you think?
>
>> The clamp also fixes 32-bit kernels, where the same expression goes
>> wrong long before the shift count reaches 32. With the default
>> ip_rt_redirect_load of 20, from n_redirects == 27 on the result is
>> either truncated or too large for time_after(), which then treats the
>> deadline as already passed, and from 30 on it is 0, so every forwarded
>> packet gets a redirect again until ip_rt_redirect_number is reached.
>> This needs a raised redirect_silence to be reachable, otherwise
>> n_redirects is reset long before. On 64-bit, ip_rt_redirect_load << 31
>> stays below MAX_JIFFY_OFFSET, so nothing changes there.
>>
>
> Isn't the same issue in 64-bit kernels too? In essence, it would be 
> (int << u32) which results in a negative value and that is later 
> sign-extended to a corrupted 64-bit value. Am I missing something here?
>

Thanks for pointing this out, agreed. A negative redirect_load never
meant anything: with the old int shift it just made the deadline land in
the past, i.e. no backoff at all, which is exactly what 0 gives. And once
converted to u64 it would turn into the maximum backoff instead, so it
should be rejected rather than silently mapped to something.


