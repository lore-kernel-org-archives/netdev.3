Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A25402B8C
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342825; cv=none; b=n6b5YFf737x3vJ/f8s1kU1kuBsMDYllQl1jOgxceuRtenoD9DiawpS61dDPbk5C82Gu44774ENuEtsQoKqxup2i2vq8PoiXDLyQN8ThGq6fXp/kImOF00m9w4A22bciasrlFX29LoFvcoVd8cxFofeV4ym/akWMic3m/x7ZRWWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342825; c=relaxed/simple;
	bh=V4XJAAmWFKa5H9dSXfoVLcQGkCZ7PqLYpY9WNfeJFHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/EtpGLUg6TxnuN612MI6BsATUy+xhnmslpBEUfl7Un1kKVakjFfjSMYboMgli20p/w8Icd2lgzmdBjXLKpH7a1kmGNJ9JgZEmmTcTBHyXOOMBpkR91uOBFazPK1xpJ2vy4ifDDt+5Gd0lw8aGvXU6+yCTjaaWZ8pkv+bxzQC3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=V7dougaK; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="V7dougaK"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b2522so779702f8f.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 06:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1790342818; x=1790947618; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KY7gNdChZlD7fmZM+lhmcn5pbl4KxOHtcnqLYz3BHxc=;
        b=V7dougaKbcW2Z85ScV0V1X4ILS0NCWrweTB+bUKk3LeEh27G4NF7lF74aYuQQwgHOv
         OShD8sd3/OFcnXVYInZyovn0cgBgrzkIU8oo/RG+5d0zFhBdZrMozHqd6hP5vEr5LU8r
         1a1fJnabLalzZiBolFOb9dlJWHg1rsjqyoBiwKNyndMpGQpubVsjK5Z4k9U9n+nnS893
         qEkOu/3Mz8xmOC+YL3PFiZw/u7WtYLuBNAFp9tcP5DSPKuX1adIM2yhIwihM6KvNicLr
         /UfEcXQhh9asRR7oKyDAfuI21ps0osGvdHjpjQeSCSXFjBk5fkU/AbkPm7RMNbaL7j5G
         6THg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790342818; x=1790947618;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KY7gNdChZlD7fmZM+lhmcn5pbl4KxOHtcnqLYz3BHxc=;
        b=svw7KgtC2TJMRAPgww6MYf2eNHduHVMr/4lBzNCQbn8heVVS55sPQLmDAVZsOedAmk
         4Go6uIVA9OfcV0gaHxJL3u+7bGtNu0YWNqWHbQkERwwh+oMBtybcVufQUxU93/xxoyoK
         848ECUXVdFOc1a/QVlx1NWIISxYxYemR8Kg2Cy1D+qNCc7n1jR295Lrs7diTQW0owfvv
         X3pdJx7L02hS8gE0v6UHHm7+Bm77Z03GG2pyjsbyz4wwZIR3a95uYX1CD201UW15Rt2K
         zCED5FFhEd5zfTn1T4hzFfBXaRDWXj55fpE1tpyQjoTAyZUNKnXlquAmgW/WcOMjPNq2
         WWvA==
X-Gm-Message-State: AFuF++lFWywpza4h2UMR7Fe0/wh5Dlgucd7ejShWhppYZjG9i6pCw6/m
	5TtNnJSjEOKqd+TKns2/q2E5CVkpD9GfWUtErRG66Lf0WAldkQTXBgcyU0Bqmb++rx60Vcojsp4
	x7bH9PwcA5oszz4ZgE3NaDviLI47+KERiTVJzZ/ndJFgZOYkWOcIgxRyj8uPsgkhnMBc=
X-Gm-Gg: AYBFou1bmt8iPbatuVEOa8PEnmKuPiyDrNUXmI3ta6i3acf2MtJfMHjlkMn4NgnthI3
	kRhnmOkpov2uQubpL3iigE4Y25n0oCvZFurQnbv57S6RIp+sOeK8K9CB24Yihve8+Rat30MMgE9
	KoNeOHyWgJh4fq+mxuwhwDvMAdDlFrXLK6bCIwfYNsFxVoW7a1VD6eqt678p9HCslBy/ZK8cTCZ
	uwnLstSjwcDP0nE1XPwtE7Ue2mEC/H+OQigdnJ018HX+LgD86hAnAfZr0PNsEQllrF6/LVtMo+7
	d/g+rsyDq1Gjys8j0OMCwZD8YCDp8OL9hQe+HBbMcME9+TbK31/cvVdmxy9wKfwoVCRlZvoDxP/
	Em0rhUJ2yexry9aYNNea5oRCRvaoC4wOY3fay/qe116OBE/H0hHUpTN6HD5UA2+7RrI9DAAAczR
	s9vYIO8BPheNR4uiq6nsfWUEyDGAwvPo9Syeq60LgLJ93rO2ktLJEb/qlH9Fq+AXCYiL9AQCAj5
	7DisDJTNj4qLaOzeEOwoKEcIUnVyrEYVcnX
X-Received: by 2002:a05:6000:2f83:b0:487:27f9:843 with SMTP id ffacd0b85a97d-4887172a612mr10899036f8f.56.1790342817404;
        Fri, 25 Sep 2026 06:26:57 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:17bf:f08c:a73a:2578? ([2001:67c:2fbc:1:17bf:f08c:a73a:2578])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a74538asm7217554f8f.34.2026.09.25.06.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 06:26:56 -0700 (PDT)
Message-ID: <c464c718-1a96-42d1-9dd3-f09086d680ba@openvpn.net>
Date: Fri, 25 Sep 2026 15:26:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] selftests: ovpn: enable TCP_NODELAY on TCP
 sockets
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com
References: <20260922060852.2266148-5-antonio@openvpn.net>
 <179014615600.2160803.7961385447309763075@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
 ifS0+hzvnPVD9wXa9kdjO+0H
Organization: OpenVPN Inc.
In-Reply-To: <179014615600.2160803.7961385447309763075@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

a few of Sashiko's finding are correct and worth investigating faster.
I'll respin this PR after having addressed the concerns.

Thanks,

pw-bot: cr

On 23/09/2026 08:49, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] New helper ovpn_tcp_nodelay() in
>    tools/testing/selftests/net/ovpn/ovpn-cli.c references the TCP_NODELAY…
> - [Medium] In TCP mode the server-side data keys are installed by a
>    backgrounded subshell in ovpn_add_peer() ('(… ovpn-cli listen tun0 1…
> 
> --
> 
> selftests: ovpn: enable TCP_NODELAY on TCP sockets
> 
> This enables TCP_NODELAY on ovpn-cli's TCP sockets (both the accepted
> server side and the connected client side) and restricts the
> tcpdump-based peer ID capture check in the test script to UDP, since TCP
> does not preserve record boundaries.
> 
> Two questions below.
> 
> [ ... ]
> 
>> diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
>> index f4effa7580c0f..6b458a654a337 100644
>> --- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
>> +++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
>> @@ -470,6 +470,18 @@ static int ovpn_parse_key_direction(const char *dir, struct ovpn_ctx *ctx)
>>   	return 0;
>>   }
>>   
>> +static int ovpn_tcp_nodelay(int socket)
>> +{
>> +	int opt = 1;
>> +	int ret;
>> +
>> +	ret = setsockopt(socket, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(opt));
> 
> [Severity: Medium]
> Does ovpn-cli still compile with this?  TCP_NODELAY is used here for the
> first time in this file, but the include block at the top of ovpn-cli.c is:
> 
> 	#include <stdint.h>
> 	#include <stdio.h>
> 	#include <inttypes.h>
> 	#include <stdbool.h>
> 	#include <string.h>
> 	#include <errno.h>
> 	#include <unistd.h>
> 	#include <arpa/inet.h>
> 	#include <net/if.h>
> 	#include <netinet/in.h>
> 	#include <time.h>
> 	...
> 	#include <sys/socket.h>
> 
> netinet/in.h provides IPPROTO_TCP but not TCP_NODELAY, so unless one of the
> libnl or mbedtls headers happens to pull in netinet/tcp.h on the build host,
> this fails with "'TCP_NODELAY' undeclared (first use in this function)".
> 
> Other net selftests using the same setsockopt() call include both headers
> explicitly, for example fin_ack_lat.c:
> 
> 	#include <netinet/in.h>
> 	#include <netinet/tcp.h>
> 
> and txtimestamp.c does the same.
> 
> Since ovpn-cli is listed in TEST_GEN_FILES in
> tools/testing/selftests/net/ovpn/Makefile and every ovpn TEST_PROGS script
> invokes it, would a failure here take out the whole ovpn suite?  Would
> adding #include <netinet/tcp.h> be the fix?  It is still missing at the end
> of the series (bc56ca6a91b2).
> 
>> +	if (ret < 0)
>> +		perror("setsockopt for TCP_NODELAY");
>> +
>> +	return ret;
>> +}
>> +
> 
> [ ... ]
> 
>> diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
>> index 9b5610837032f..d744c1a97d5fc 100755
>> --- a/tools/testing/selftests/net/ovpn/test.sh
>> +++ b/tools/testing/selftests/net/ovpn/test.sh
>> @@ -67,35 +67,33 @@ ovpn_run_basic_traffic() {
>>   	local tcpdump_timeout="1.5s"
>>   
>>   	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
>> -		# The first part of the data packet header consists of:
>> -		# - TCP only: 2 bytes for the packet length
>> -		# - 5 bits for opcode ("9" for DATA_V2)
>> -		# - 3 bits for key-id ("0" at this point)
>> -		# - 12 bytes for peer-id:
>> -		#     - with asymmetric ID: "${p}" one way and "${p} + 9" the
>> -		#	other way
>> -		#     - with symmetric ID: "${p}" both ways
>> -		header1=$(printf "0x4800000%x" ${p})
>> -		header2=$(printf "0x4800000%x" $((p + OVPN_ID_OFFSET)))
>> -		raddr=""
>>   		if [ "${OVPN_PROTO}" == "UDP" ]; then
>> +			# The first part of the data packet header consists of:
>> +			# - 5 bits for opcode ("9" for DATA_V2)
>> +			# - 3 bits for key-id ("0" at this point)
>> +			# - 3 bytes for peer-id:
>> +			#     - with asymmetric ID: "${p}" one way and "${p} + 9" the
>> +			#	other way
>> +			#     - with symmetric ID: "${p}" both ways
>> +			header1=$(printf "0x4800000%x" ${p})
>> +			header2=$(printf "0x4800000%x" $((p + OVPN_ID_OFFSET)))
>>   			raddr=$(awk "NR == ${p} {print \$3}" \
>>   				"${OVPN_UDP_PEERS_FILE}")
>> +			peer_ns="ovpn_peer${p}"
>> +
>> +			timeout ${tcpdump_timeout} ip netns exec "${peer_ns}" \
>> +				tcpdump --immediate-mode -p -ni veth${p} -c 1 \
>> +				"$(ovpn_build_capture_filter "${header1}" "${raddr}")" \
>> +				>/dev/null 2>&1 &
>> +			tcpdump_pid1=$!
>> +			timeout ${tcpdump_timeout} ip netns exec "${peer_ns}" \
>> +				tcpdump --immediate-mode -p -ni veth${p} -c 1 \
>> +				"$(ovpn_build_capture_filter "${header2}" "${raddr}")" \
>> +				>/dev/null 2>&1 &
>> +			tcpdump_pid2=$!
>> +
>> +			sleep 0.3
>>   		fi
>> +		ovpn_cmd_ok "send baseline traffic to peer ${p}" \
>> +			ip netns exec ovpn_peer0 \
>> +			ping -qfc 100 -w 3 5.5.5.$((p + 1))
> 
> [Severity: Medium]
> Can moving "sleep 0.3" inside the UDP-only branch make the TCP variants
> flaky?  It was the only delay between peer setup and the first ping, and in
> TCP mode the server-side data keys are installed by a backgrounded subshell
> in ovpn_add_peer() whose PID is discarded:
> 
> tools/testing/selftests/net/ovpn/common.sh:ovpn_add_peer() {
> 	...
> 		(ip netns exec "${server_ns}" ${OVPN_CLI} listen tun0 \
> 			1 ${M_ID} ${OVPN_TCP_PEERS_FILE} && {
> 			for p in $(seq 1 ${OVPN_NUM_PEERS}); do
> 				ip netns exec "${server_ns}" \
> 					${OVPN_CLI} new_key tun0 ${p} \
> 					1 0 ${OVPN_ALG} 0 data64.key
> 			done
> 		}) &
> 	...
> }
> 
> The "listen" command returns as soon as all peers are accepted, because
> CMD_LISTEN ends in ovpn_waitbg() -> daemon(1, 1), so the new_key loop runs
> concurrently with the foreground script.  With the sleep now gone for TCP,
> ovpn_run_basic_traffic() starts "ping -qfc 100 -w 3 5.5.5.2" with no
> synchronization against that loop.
> 
> If "new_key tun0 1" has not landed yet, server to client packets for peer 1
> are dropped for lack of a key, and with -c 100 plus the -w 3 deadline ping
> exits non-zero, so ovpn_cmd_ok reports "run baseline data traffic" as
> failed.
> 
> Would recording the background setup PID and waiting for it (or polling
> get_key) before generating traffic be more robust than relying on the
> incidental sleep?
> 
>>   @@ -103,8 +101,10 @@ ovpn_run_basic_traffic() {
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

-- 
Antonio Quartulli
OpenVPN Inc.

