Received: from mta0.migadu.com (out-142.mta0.migadu.com [91.218.175.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354CA4825BC
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042546; cv=none; b=e4r5zP0T3PDpTXZBIobJqsfQR5M29/ooUzveTWF7d8v4OVWfXYdLIw97yZfI95c1fTvWXhvIvxpvQe0/RyPuV9nHCurXxauyX5JGKh+A7/tJpJ9IGKVyR9eLi6+DrMG3I9IhPcnWLmNioNunDyVLCVUdhYJlV7lUeXj5gvSaL2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042546; c=relaxed/simple;
	bh=sHK07o4ZNtPtjY+nN7nBwsM5doAvUH1ZVu4hBnEZvkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiNbWeyXtaLvb1xoeWFcVQdTgwkneEpAzWW+TbqOBA5FtfIc4+XTL5VOXgiBCke6D+aiunRDzfmrkrbn8eIBsxCSBEXRbE6Jz7iq5qZq5VmCH0Zs8FLib/qdo507Tmms31y70gipxHvvrVMPm7DTz9fft4Bc24n0Z0fVjt55y9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vZGetiml; arc=none smtp.client-ip=91.218.175.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vZGetiml"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sHK07o4ZNtPtjY+nN7nBwsM5doAvUH1ZVu4hBnEZvkQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789042534; v=1; x=1789647334;
 b=vZGetimlbdIETNjCrT5rtG8o2ruHTik9UzUUQt3hMaDH0Gmq3SlKlQfUHgFv5mtUr+yBsej/
 Rdtjxhoi12+jAsSPzJR3ghwQUlJtesM/cbu9EGqJQ6omuls3bN7raXMNI3u+cfP3lB/36DwJBkW
 R4TNJzNrzHPg46aA77ufsw1A=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a1d0e7034e635d35;
	Thu, 10 Sep 2026 12:15:23 +0000
X-Mizu-Trace-ID: a1d0e7034e635d35
X-Migadu-Flow: FLOW_OUT
Message-ID: <f8028773-9ed6-4a34-9fd4-68150a459cfb@linux.dev>
Date: Thu, 10 Sep 2026 20:15:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tcp: fastopen: check rsk_drop_req() in
 tcp_fastopen_create_child()
To: Matthieu Baerts <matttbe@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 Kimi Security Team <bug-report@moonshot.ai>,
 Yilin Zhang <yilinzhang@moonshot.ai>, Mat Martineau <martineau@kernel.org>
References: <20260903094010.4066892-1-yilinzhang@moonshot.ai>
 <c95bc6f8-b8da-426f-a056-1c692559d14f@redhat.com>
 <cd7d7f5e-d729-475e-b772-e201a2ab37be@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <cd7d7f5e-d729-475e-b772-e201a2ab37be@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/10/26 6:13 PM, Matthieu Baerts wrote:
> Hi Paolo,
>
> Thank you for having checked!
>
> On 10/09/2026 10:12, Paolo Abeni wrote:
>> On 9/3/26 11:40 AM, Yilin Zhang wrote:
>>> subflow_syn_recv_sock() sets drop_req when an MP_JOIN SYN takes the fatal
>>> fallback and destroys the cloned child. tcp_fastopen_create_child()
>>> ignored the flag and could queue the destroyed child.
>>>
>>> With an MPTCP listener using server-side Fast Open, a valid-cookie
>>> MP_JOIN SYN could then expose the freed child through accept().
>>>
>>> Release the locked child and drop the request before tcp_conn_request()
>>> sends a SYN-ACK. Initialize drop_req when allocating the request so the
>>> check cannot observe stale state after request-socket reuse.
>>>
>>> Changes in v2:
>>> - unlock the child before dropping its reference
>>> - drop the request instead of sending a SYN-ACK after the MPTCP reset,
>>>    as suggested by Jiayuan Chen
>>>
>>> Fixes: 90bf45134d55 ("mptcp: add new sock flag to deal with join subflows")
>>> Reported-by: Kimi Security Team <bug-report@moonshot.ai>
>>> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>>> Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
>> This looks like the wrong fix. IIRC fastopen is not compatible with MPJ
>> - as the latter must accept data only after the 4way handshake completion.
>>
>> @Mat(s): could you please double check the above ^^^ statement???
>>
>> If so mptcp should reject entirely MPJ + fastopen and no addtional code
>> required on the TCP side.
> I didn't check in details, but when I try with this packetdrill repro...
>
>   https://lore.kernel.org/20260903070649.3965366-1-yilinzhang@moonshot.ai
>
> ... it looks like the kernel replies with an MP_RST, but also a SYN+ACK,
> and a WARN:
>
>    refcount_t: underflow; use-after-free.
>    (...)
>    inet_csk_listen_stop (net/ipv4/inet_connection_sock.c:1533)
>    ? mptcp_subflow_queue_clean (net/mptcp/subflow.c:1925)
>    mptcp_check_listen_stop.part.0 (include/net/sock.h:1486
>                                    net/mptcp/protocol.c:3482)
>    __mptcp_close (net/mptcp/protocol.c:3534)
>    mptcp_close (net/mptcp/protocol.c:3572)
>    inet_release (net/ipv4/af_inet.c:425)
>
> With this v2, I don't see the SYN+ACK, only the RST.
>
>
> If I'm not mistaken, with TFO, syn_recv_sock will be called first
> (tcp_conn_request -> tcp_fastopen_create_child -> subflow_syn_recv_sock)
> then MPTCP will only check TFO when the SYN+ACK is being sent
> (tcp_conn_request -> subflow_v(46)_send_synack).
>
> In subflow_syn_recv_sock(), I don't think we have a strong indicator


You inspired me. Maybe we can use such code:

     if (subflow_req->mp_join &&
         (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN))
             return NULL;


We now skip RST and SYN+ACK also can be sent by tcp_conn_request().




> that the caller is TFO. It looks like we would also need to change the
> TCP stack to pass this info, no?

