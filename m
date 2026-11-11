Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411111;
	b=QYb4eX4pV/0gF1gD/tqpGoOdQz2HcOOg/JWgKBIJ06edgVALIbTZVIIl2qPNCducJQtS
	 ChHl8yDd93RX8WXUWnVgRjGxjaEgTlWHwOfBJcJZzBhro8jDxy9IuCb/kmpE7xTCPEgc+
	 Og4Xsvz8NjB3cI6ORlLfHYOqrwOTBNFezajNuAyPmKkIE7msuOYpitiryvVtZAbWNJorc
	 iCu6yatXRUytAue5x54290CwQ78FTIqV2ukCva/4/NZ7NPHWFEMcsPrPKy9WE5G1RHPGO
	 ws8oey5AMcqYRUdqjS4PR2sLdZ9PyB0MyOTU3nIYKy51ioUtGhH7AbY+tYxHGMohKhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411111;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=yEIA6Zmz02BTCzQZDjg7NRu0QFN0RHxgpEwj9oihF+4=;
	b=OotGGC7oHL7TpCdszj1cDxuV6Dq/s9+ZGO8ZbMWiTE04UUZn++rhQmdFiUYrUZeKcJ3z
	 +Xf8dQ/U8bBzVrzclCEX9jmTwiFSOO8Lafnt8e/YcUG9MGD/xN6sYQNWoozNhLBt0L3Xe
	 2p+wcSa4mKeS7vJIpzbFkaWobdz+AfrhzYwU5pC26yjokoRH0Hw89WnIOhtwFNHOfooPS
	 RaHjKHZvzfN3hgdGurc6JBGV2j3HNLpv5HclpWyBIgljFCU5YsNF1PqCGy4w1ssBQ9+bW
	 w67ll4GHl8zKbp5WVjqEX8Gv7SC2L7JCLDmuGblOSu0io1G2xB8aCiSO1JXH9849CrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dBZM5A4l;
	arc=none smtp.remote-ip=95.215.58.221
Received: from mta1.migadu.com (out-221.mta1.migadu.com [95.215.58.221])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177DA606A326
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 15:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 177DA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dBZM5A4l
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NjcZ2vs086wrkeO3l/vjfd5QbHjdbw8ASBFYAH9BBjE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794411107; v=1; x=1795015907;
 b=dBZM5A4lIIKKb7ticjEP2eL/HioI0Hp1LgmI4yAus5DfyRQ2BAewrMRWVlfwISZ0fmb5ZrnN
 vMNRzU8i3WB6GJV3ama9V+u83WeUZTapB9u0P6+zbS9LqJHyYmZlmd2Sk9adM6zZuot1RHI561Y
 H4C/KL00Vc2UzkOB9/croRyg=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 59aee4a50207fa8f;
	Wed, 11 Nov 2026 15:31:47 +0000
X-Mizu-Trace-ID: 59aee4a50207fa8f
X-Migadu-Flow: FLOW_OUT
Message-ID: <28d1e284-501f-47f8-b155-bbc2255f7a06@linux.dev>
Date: Wed, 11 Nov 2026 23:31:35 +0800
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
Subject: Re: [PATCH bpf-next 1/9] bpf: Add log support for tracing link_create
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 kpsingh@kernel.org, matt@bobrowski.net, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20261109140816.5196-2-leon.hwang@linux.dev>
 <5ed2ec09ce8a3ce5477a658b68c6315499ef67793014be27de18ee57ec968e12@mail.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <5ed2ec09ce8a3ce5477a658b68c6315499ef67793014be27de18ee57ec968e12@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/9 22:47, bot+bpf-ci@kernel.org wrote:
>> bpf: Add log support for tracing link_create
> 
> TL;DR: Logging is incomplete: the freplace max_ctx_offset check in
> bpf_tracing_prog_attach() still returns -EINVAL with an empty log, and the
> saved_dst type mismatch may too. No functional regression.
> 
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
> 
> [ ... ]
> 
>> @@ -3843,6 +3849,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>>  	 */
>>  	if (prog->type == BPF_PROG_TYPE_EXT &&
>>  	    prog->aux->kprobe_write_ctx != tgt_prog->aux->kprobe_write_ctx) {
>> +		bpf_log(log, "Invalid kprobe_write_ctx.\n");
>>  		err = -EINVAL;
>>  		goto out_unlock;
>>  	}
> 
> The check right after this one still returns -EINVAL without writing
> anything to the log:
> 
> 	if (prog->type == BPF_PROG_TYPE_EXT &&
> 	    (tgt_prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT ||
> 	     tgt_prog->type == BPF_PROG_TYPE_TRACEPOINT ||
> 	     tgt_prog->type == BPF_PROG_TYPE_SYSCALL) &&
> 	    prog->aux->max_ctx_offset > tgt_prog->aux->max_ctx_offset) {
> 		err = -EINVAL;
> 		goto out_unlock;
> 	}
> 
> An freplace program whose max_ctx_offset is larger than that of a
> RAW_TRACEPOINT, TRACEPOINT or SYSCALL target will get -EINVAL from
> link_create with an empty log and log_true_size of 0.  That is the same
> kind of invalid freplace target as the kprobe_write_ctx mismatch above,
> which now logs.  This isn't a functional regression, but was this check
> missed?
> 
> Would something like this cover it?
> 
> 	bpf_log(log, "Extension accesses more ctx than its target.\n");

Will add such log in the next revision.

> 
> Also, bpf_check_attach_target() still returns a bare -EINVAL for the
> saved_dst_prog_type / saved_dst_attach_type mismatch, which is the
> "freplace attachment to a new target" case the commit message mentions.
> That code is in verifier.c, so it is outside this patch, but is it intended
> to be left without a message?

It was intentional to avoid touching bpf_check_attach_target() code.

Thanks,
Leon

