Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E537D544894
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922682; cv=none; b=NQqgko855nMFgviAA8ylfcacSjznUGjm6UwQkUkLLpg4T30RxSNxoKHZ7zL65gRLFDDf/yvjM3Pm15vMbl99x73qDcEgOgUO3cBoDd4J/eYyMJuf9kTJ6Vgg4iK2ClB0Ub8TEG0x9Jc08ZVGea5RyuPGF9mHD2YnlcnMOhHZoy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922682; c=relaxed/simple;
	bh=0zxX8nxTy+LtbVbky6fezopQAaCJzSA1iX50vK2mbQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIyhOuayBCwbiAvVWGXmtrP9ip+EnRy1Y4Bei1Voig1KqzokDZR3Y4gcAl9LsRqSoxrVq8f9Z37nbP6yxsNGxK//sKMM0xAYBmDBz6Gl5LAKGEQnnPZCy9xUcpJgmiOlFRbFAQml6d0nuneLHanEsdtOor9whkFccgin2dsCzQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=b2mIQNR3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="b2mIQNR3"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1880e1bf1so2741025e9.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1791922678; x=1792527478; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NXYLE3w9G/fWrKKrl+Rv+H1HKBurhTT1kSe5t3amnKA=;
        b=b2mIQNR3S07Uy1dKvLXm+QeFVul9bWG/GvnnEgNYlxF0EFTim7ilAnetzIPIEwXEU4
         SFTRxfItJiVvJgT0bQY6zj6RiXHXHTLkgO8KHQUestRhjJS0o3+I2fYVzKDKDPGkxZRb
         D3/1Od4P2ga2gCXahKyOmAYMuSf6cEQ81sciArbuReDmayPnbGbKhoMCwUornMuB1q3Q
         jzogZp8/Wb4L6X67KUYn8jXhJE1C7VJxLeIp1F+DzLAWaXHQ13iPja8PXkOjxRXXjCHP
         7QJ8oigo8CpRgavIiin5LDPChWq22bMpmuzXHeeF8xCcKvF1qAo/tRg0wI16uzRzNQkY
         f9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922678; x=1792527478;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NXYLE3w9G/fWrKKrl+Rv+H1HKBurhTT1kSe5t3amnKA=;
        b=sxqQZzYE5w3jVutaWj8MMOHs+iIaePimmWAKo/iqPB+HHXJXAiqYLu4tzR4ZnWAlih
         D1wsyHJcqxQvDJvFS7PqUPzAyE7gjhEAzpOWFptWGoYT3hTOo5r+KmnAm+Q+EJQLwdk+
         kmswOwbZzwsX6iZsDUWBpPhXl7vZmcAYRT39p5DMpmubd4yzVI+oRjP0QxsXVBX8NtWd
         IMCK7TrFE+R1ur496GHNaCc2z/1Ke9ZySTNBJZRPMWUg4MRMSgn7Kx2jc5P4S19CJq1G
         8qhh+6FA2wKSI/fkOmMKFQlzgL2JY8vui1eIwxnPLSVvBx2aIzqtMAVJM+L2twCrVqJu
         gN9A==
X-Gm-Message-State: AFq9FYLH9a+uMMPjQxDpzzR2ViyeIZ6KqN0H8Rg+3YOzdatO9Obyy2K/
	Gm6lOQCGjSweUYSj2im3x0BtgcNpDNiCDLDLcaw1SrTIf8zE0mIdC6fhFQ9ZX8bULQ7LBZqRZQ3
	ii8ApA3qFoNjmrvZBrwLxT+E/xnjxlPLlMik9SrPH5vA/WS01rqI=
X-Gm-Gg: AYBFou3A7OMEf8tAfRh4LceBIAxJHpaQPkxbqCv22Bk35VNdSr4foqVjjmSlno/Eefd
	1DvOx4fsZorFOeWx11S2NOz8YP1wZGW2NbO50R3ZBAQ3shscY18OxD9bv10KwKHPr4TB464Boh3
	+X/TWfXZSlsFTeCCceHS1zQUQQRKByBwC+i6D6xvh+FMSRCEHHHwBwOXe7iOJp24sz2ofFFBC7I
	PatZ5zjrYtuuA17ZitgSPG3q8D6zMD/WIRHNBXM/QoOCZmoBe7VqynHdvcddGgP64qUFYQhQlBo
	1YNACbMoEa31JoowdTeWm+Xd6e0hkkhCqgi8gmsbLVeX6ThCEX93TKVBnqkh9OrUPiiVQ5DT0nc
	idKcEZSFjJsiFo5SDMcFEgdXreEAaLW3Ex1Fi47QmGtoKFM64S1l/9uuE5qPqc36dCIfwCIEocJ
	8L/hBJLUh6qvEOaPvJZetuYi1DRlGzFCg+MhowE2S+tKgt3iZem8I/3qmz4Ywe1mcD5vX1/6ZOx
	uZE8FT2BTTAoWP+Xqjz2HYulT5SWTZD7RiR
X-Received: by 2002:a05:600c:3f0f:b0:49c:ffab:551f with SMTP id 5b1f17b1804b1-4a18e4cd231mr274976125e9.22.1791922677775;
        Tue, 13 Oct 2026 13:17:57 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:b7f3:a9ab:4b66:f7c6? ([2001:67c:2fbc:1:b7f3:a9ab:4b66:f7c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc51c1sm7101213f8f.46.2026.10.13.13.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 13:17:57 -0700 (PDT)
Message-ID: <ab62a47a-0690-4cea-bf64-62bdbd1bd21f@openvpn.net>
Date: Tue, 13 Oct 2026 22:17:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/6] selftests: ovpn: enable TCP_NODELAY on TCP
 sockets
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, sd@queasysnail.net, ralf@mandelbit.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com
References: <20261012133809.2477063-5-antonio@openvpn.net>
 <179190238850.434549.6180086091448145830@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
 ifS0+hzvnPVD9wXa9kdjO+0H
Organization: OpenVPN Inc.
In-Reply-To: <179190238850.434549.6180086091448145830@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 13/10/2026 16:39, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] After this patch, no TCP selftest checks the TX peer-ID that
>    goes out on the wire.
> 
> --
> 
> selftests: ovpn: enable TCP_NODELAY on TCP sockets
> 
> This commit makes ovpn-cli set TCP_NODELAY on its TCP sockets by default.
> Setting OVPN_TCP_NODELAY=0 turns it off, and the new test-tcp-nagle.sh
> uses that to keep running the TCP suite with Nagle enabled. It also limits
> the tcpdump-based peer ID check in ovpn_run_basic_traffic() to UDP.
> 
>> diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
>> index 392109d5e14e2..e2e6ffdd29bb0 100755
>> --- a/tools/testing/selftests/net/ovpn/test.sh
>> +++ b/tools/testing/selftests/net/ovpn/test.sh
>> @@ -137,35 +137,33 @@ ovpn_run_basic_traffic() {
>>   	local tcpdump_timeout="1.5s"
>>   
>>   	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
> 
> [ ... ]
> 
>>   		if [ "${OVPN_PROTO}" == "UDP" ]; then
> 
> [ ... ]
> 
>> @@ -173,8 +171,10 @@ ovpn_run_basic_traffic() {
>>   			ip netns exec ovpn_peer0 \
>>   			ping -qfc 100 -s 3000 -w 3 5.5.5.$((p + 1))
>>   
>> -		wait "${tcpdump_pid1}" || return 1
>> -		wait "${tcpdump_pid2}" || return 1
>> +		if [ "${OVPN_PROTO}" == "UDP" ]; then
>> +			wait "${tcpdump_pid1}" || return 1
>> +			wait "${tcpdump_pid2}" || return 1
>> +		fi
>>   	done
>>   }
> 
> [Severity: Medium]
> This patch removes the TCP branch of ovpn_build_capture_filter() and makes
> these waits UDP-only. After that, does any TCP selftest still check the
> peer-id that goes out on the wire?
> 
> The capture was added by commit 367f4b163a8c ("selftests: ovpn: check
> asymmetric peer-id"). Its purpose was to check the peer-id in the data
> packet headers for every connection, TCP included.
> 
> On the kernel side, the TCP receive path never reads the peer-id from the
> packet. It takes the peer that is bound to the socket:
> 
> drivers/net/ovpn/tcp.c:ovpn_tcp_rcv() {
>      ...
> 	ovpn_recv(peer, skb);
>      ...
> }
> 
> So if a TCP peer had the wrong tx_id here, traffic would still flow:
> 
> drivers/net/ovpn/crypto_aead.c:ovpn_aead_encrypt() {
>      ...
> 	op = ovpn_opcode_compose(OVPN_DATA_V2, ks->key_id, peer->tx_id);
>      ...
> }
> 
> The JSON expectations in the selftest directory don't compare tx-id
> either. With this change, test-tcp.sh, test-symmetric-id-tcp.sh and the new
> test-tcp-nagle.sh would all pass with an incorrect TCP tx_id.
> 
> The later patch in the series ("selftests: ovpn: wait for the TCP server
> key setup before traffic") does not bring the TCP check back.
> 
> Could these TCP variants keep some form of peer-id check that does not
> depend on TCP segment boundaries?
> 

Testing tx-peer-id with TCP_NODELAY enabled is extremely challenging 
because we'd need to (almost) re-implement an OpenVPN TCP stream parser 
in the selftest.

Since the rest of the selftests already ensures that packets are well 
formed and that the ovpn TCP state machine works as expected, we decided 
to simply give up on this specific on-wire test.
We don't think to be losing coverage by doing so.

Hence this decision was deliberate.

Regards,



-- 
Antonio Quartulli
OpenVPN Inc.

