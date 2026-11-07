Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794038893;
	b=4UplGIITUpBoXOTrI4X2xLUUTZHrPCYJC7ZroC3uKnTbhNIk1ke06Yc4BEdie979qBXb
	 E3eGQlIeFrAYlRw8vneHvOQbEasg8gwkmgOGdyP7h4+2XEB+/9jZ17u3QggrMzrVXjGwj
	 owVwquq4uiW0XBqqol7TjG85k18pOvVvMN2GJh8YRBArzSczprNWUUnZXzeWbpv+UEqpj
	 sY+2EFeW7BHzvHS7U0D91WV14610tANHmSAMpTpMkBlw8ObP6XkAiYO8cTjSlyvXLCRzN
	 YnP2p42iScpiMuyisJOvOJXAR/tdm7IpWIfe2Rnyk/eGzdLwaX5plLPFU6CyIZhbosA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794038893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Fu3COQCAPmOwpJB4SS2FVTvXTR/NXj3quXMf5G+9+Gc=;
	b=LKhC0D58ywV6jQrNKu9oxap6oRi94lI+o6XxXEN/kEz1yA5kdFH26qxqgbK0w1NR8wHG
	 Kx6dGOEvXtNlJKYUUeqr+zjOIqM7Lziv0GDx+KvVYDJN7nqVGn9TB3JlGAy4MKaGd/QAe
	 wP+hO9S/QA1KyIOSXIzRI0UVDNO3Xcb47dv9KZkzyiv1nKgh0ZEY0QuOT85PJGPxFLDZ0
	 BaZram2WXFy19WYjNi4/j2mrAREsFIqfmbUaU+jtG3N9QigguQOOaGsXlx7W0srblbI1Z
	 b6fiowUPW94fY00lArBRqY3amA6hkelhMXBr/YaQC00XTrS/SQYWN5TC+6BpnDUrlSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gjR3O+Ln;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D703606A32D
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 08:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D703606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gjR3O+Ln
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e946155442so11328465ad.3
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 00:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794038892; x=1794643692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Fu3COQCAPmOwpJB4SS2FVTvXTR/NXj3quXMf5G+9+Gc=;
        b=gjR3O+LnbqWxSywMeqbqw+2tekOwfmC3a5BDhu60zh3iUcZ0Y3Mzu7GPeI9zhL+aHG
         eZWl1skwP1Q/ll1e+lKt8scG8ma7mqFE2WWCEWpcHSYAqqqLl3NSj92XPwBjFcUwPDIS
         l2MVQZyp8nPW6H4lH7sAHbUnWKOctaRelZL2/8faw9SdV7hAOI1FIueSB6ylCXggbLe7
         JfxANvcupt3AxNkyuaiwncgHCpq1yxBDSLkCP49P6ePE8BAobSbK4noUzkekAp73VY9e
         SDcZvO8bll/JwGA4InjCk6mETFBPB52IlyvUXmM1kkKc2+Y7KooJs5ZauCtp6HNd8+p3
         IxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794038892; x=1794643692;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fu3COQCAPmOwpJB4SS2FVTvXTR/NXj3quXMf5G+9+Gc=;
        b=xMjhUlxd7t3uMahpLmWIZLMsj3mfcOrnEps59OkASJzCByvt5NwcROd2Yyjtyxug7B
         OZ0pkgrGmWBkR3ZoGaVX3aMZ5EgdPVcCqKZWlvXc/ogB4tfJVqiTADf/fF1HyfPg408p
         Tw31+w4rni7y2E6vRUo8+laIkMRi3FQN/6F4Rh4nBotJZWs7hQZBhIlOx8lcWtzjk59z
         5fACj11yamAxwrNVeaPLZt71JI5qhPH2hwMJSsa8rXCd0zKNAlcrLNlOMuaXgx6jxbxV
         GUTNxdNjM1eHFBnYvddRiASuPoKPzLfp5J16BYOwSLPTMC+l23QopVyhV+gbVUJOJcEd
         R0+w==
X-Forwarded-Encrypted: i=1; AL+hErGpSovTW9b3f0+Gn67GTiDNhevUW0BQjD1HWH/xgWRtvBopl/zE9+3j+1oyKwzmTMmKYbBUEPg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cWcbiHM43JFSgI3f5tdeb75jtP26KNVHA44gr7nhiHirjq3Hm
	YC1H6xmNcA7ZhmqNXnjmUmhjKpo9YCM4Leg2UuRmlfn85QyQsmPaE5tL
X-Gm-Gg: AYBFou0m1YNq/LCrosKmOZ88IFBf5l/WDhjAR8Qlw3uzMTJsUmIlpq+eHmiml8Opxo3
	BjMRLXfnv7JBHRY+drklzf3cnyqMmPFITpzqIKui6ugK9l6ci1kpbceVnyRhm7bfXU511N7COTc
	OUpUksIwy65cJ60uh3+/C0S6092beIu4RLWjYitlO9piHJVnGPAuu2SZKWJPtYg3T/lPt4HcF9/
	raGt3EU8CDB2/LZQ9+XPB8lo19GIbSMYM81Zo+K0kQkTnE12bw+SLRXMkxrpCniFORoUvEcNHjW
	HJ93Z2pslOlhVBhdpOQPPhYUTbwXwiT0N1N9bniyfgpGYou/1TIR2ndgQY8Rn+S/LXFc4kEK49N
	Uu12byo7HpRygVYWpeTec73yEx6IQSLGAj4kIXROZ+nuNKRGNLnmseizdjzH6sdOtNfe/8uOg82
	r8TRy0l5kC5+nJ0Z8PBpjM33Lk9YX7ZH5LobvQNI5WRyji4jfmgZyiv9pcdnFC73X47iQax2OUK
	oSTNW9AGLoQin2yrDmYtxgQGRoX5HDa2RgZtVbUeW1xiZBMOF3sIF9vGlYiJ3/OhDFDt0StQHW4
	IYyXXH1rrB7irHFKYZqjrL8NhGqTUgD4rzJQRllNCQrH7fx5Cgct68OR
X-Received: by 2002:a17:90b:568e:b0:3ad:870b:b6d4 with SMTP id 98e67ed59e1d1-3b0db609836mr4788668a91.1.1794038891748;
        Sat, 07 Nov 2026 00:08:11 -0800 (PST)
Received: from [192.168.255.10] ([223.104.68.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc27e829sm1764509a91.0.2026.11.07.00.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2026 00:08:10 -0800 (PST)
Message-ID: <05e77224-7d3a-42d5-9e08-82c7257cba34@gmail.com>
Date: Sat, 7 Nov 2026 16:08:03 +0800
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
Subject: Re: [PATCH net] net: reuseport: avoid duplicate closed socket
 insertion
To: Jiayuan Chen <jiayuan.chen@linux.dev>, Eric Dumazet
 <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: TencentOS Corvus AI <corvus@tencent.com>, stable@vger.kernel.org,
 Lin Jiapeng <jiapenglin@tencent.com>
References: <20261106135841.418-1-ljp1205831794@gmail.com>
 <6cb5fe89-c6f0-4e84-b753-4425b1aebe1e@linux.dev>
From: Lin Jiapeng <ljp1205831794@gmail.com>
In-Reply-To: <6cb5fe89-c6f0-4e84-b753-4425b1aebe1e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2026-11-07 1:02 p.m., Jiayuan Chen wrote:
> 
> On 11/6/26 9:58 PM, Lin Jiapeng wrote:
>> Clearing SO_REUSEPORT on a TCP listener clears sk_reuseport but leaves
>> sk_reuseport_cb attached to its reuseport group. 
>> ...
>> Repeated connect(AF_UNSPEC)/listen() cycles therefore insert the same
>> socket until num_closed_socks exceeds max_socks. The next insertion
>> writes before socks[], overlapping prog on x86-64 and leading to type
>> confusion when a reuseport program is attached or detached.
> 
> 
> Is the issue same as Eric's patch ?
> 
> https://lore.kernel.org/netdev/20261106084300.2029567-1-edumazet@kernel.org/

These reports may be related, but analysis suggests that they seem
to have different root causes.

Eric's patch seems to prevent attaching a program to the same unhashed,
shutdown listener from resurrecting it into the listening section. My
patch addresses duplicate closed-section insertion after SO_REUSEPORT
is cleared, which may eventually make socks[-1] overwrite reuse->prog.

Eric's patch does not change reuseport_stop_listen_sock(). Also, my PoC
attaches the program on a separate, still-hashed anchor socket, so his
new check may not apply to this path.

I tested Eric's v2 patch with my unmodified PoC. His positive control
returned EINVAL, so the patch seems to be active. However, my PoC still
triggered the same UBSAN/KASAN failure. Since his patch did not stop my
reproducer, and the root causes appear to be different, I think these
may not be the same issue. The two fixes may therefore be complementary.

The following is the UBSAN/KASAN output with Eric's v2 patch applied:

[trigger] cycle 129/129 (vulnerable: socks[-1] overwrites prog)
[trigger] attaching CBPF after closed-region pump
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in 
/Users/m00nb1rd/WorkSpace/vul-findings/reuseport-closed-region-negative-index-bpfprog-as-sock/repro-upstream/linux-eric-v2/net/core/sock_reuseport.c:153:9
index -1 is out of range for type 'struct sock *[] 
__counted_by(max_socks)' (aka 'struct sock *[]')
CPU: 0 UID: 65534 PID: 22 Comm: poc Not tainted 7.4.0-rc1+ #1 PREEMPTLAZY
Call Trace:
  <TASK>
  dump_stack_lvl+0x23/0x30
  ubsan_epilogue+0x5/0x30
  __ubsan_handle_out_of_bounds+0x91/0xa0
  reuseport_stop_listen_sock+0x290/0x310
  ? reuseport_stop_listen_sock+0x43/0x310
  inet_unhash+0xd5/0x400
  tcp_set_state+0x125/0x260
  tcp_disconnect+0x47/0x1950
  __inet_stream_connect+0x2d0/0xab0
  ? do_iter_readv_writev+0x25b/0x350
  ? vfs_writev+0x2e0/0x3c0
  inet_stream_connect+0x57/0x90
  __sys_connect+0x14b/0x1a0
  __x64_sys_connect+0x71/0x80
  do_syscall_64+0x6c/0x1d0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x205560
...
...
  </TASK>
---[ end trace ]---
Oops: general protection fault, probably for non-canonical address 
0xdffffc000000008e: 0000 [#1] KASAN
KASAN: null-ptr-deref in range [0x0000000000000470-0x0000000000000477]
CPU: 0 UID: 65534 PID: 22 Comm: poc Not tainted 7.4.0-rc1+ #1 PREEMPTLAZY
RIP: 0010:call_rcu+0x10d/0x260
...
Call Trace:
  <TASK>
  ? reuseport_attach_prog+0x6c/0x250
  reuseport_attach_prog+0xdd/0x250
  sk_reuseport_attach_filter+0x97/0xf0
  sk_setsockopt+0x973/0x1cc0
  do_sock_setsockopt+0xa9/0x120
  __sys_setsockopt+0xaa/0xe0
  __x64_sys_setsockopt+0xac/0xc0
  do_syscall_64+0x6c/0x1d0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x202f22
...
  </TASK>
---[ end trace 0000000000000000 ]---

