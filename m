Received: from mta0.migadu.com (out-220.mta0.migadu.com [91.218.175.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832FD3FCC
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244639; cv=none; b=jbNDVqArkEUULomE4utE1oLLHoLyAGFSBaq9+atj72IDM9D3+SiI4ORCTvwJwyoQ5sPj55XWQbS9mBgwZRCFqMtLj5vCzYCXP8/ks2bSCtr0fCkrxPWzM8FYcI6FeU+qszsPPq79QluX5p6DFrfRcxZGk67swyiqmYBp/RTUZjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244639; c=relaxed/simple;
	bh=ofSqdcwXgCRt+zdux/vTEdF8pWvPqi8/CFgklbAc2sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRbyu6EePm7HGUCAKSpG0oncCbO48G5IOl2Qs6f9ffoPW/38joG0OsM+h3LNUR6bSmhkWZeGsm6Ccl8svNVBl3EeOlZ6zK10gaRT3G4FKyecx5c/1dHMSlbQBfNTRWphid19khcPm+rIw9FbgDlBWWPhKTuuSW0dkQyO72tNjjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tF2A4lH8; arc=none smtp.client-ip=91.218.175.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tF2A4lH8"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ofSqdcwXgCRt+zdux/vTEdF8pWvPqi8/CFgklbAc2sM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788244635; v=1; x=1788849435;
 b=tF2A4lH8UQmddosIc+Gzgclh6BZgBtOgW9RvE9t7pTyK0cC6sMKAO1bp33A09HBsKVx6xeaw
 65e3Y6OtGpebnSLhusiwbcoK0QniuGJA9ty5ExMRvv4GSoN4YPJmoY1luTZ2zE9dqPKR8RLxx7a
 zuCplKB8WsspvtbPQ/EmErzo=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fdc2348df12fdb54;
	Tue, 01 Sep 2026 06:37:15 +0000
X-Mizu-Trace-ID: fdc2348df12fdb54
X-Migadu-Flow: FLOW_OUT
Message-ID: <f777c2f2-3bf8-44e4-be5e-81dee14d445f@linux.dev>
Date: Tue, 1 Sep 2026 14:37:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tls: fix TX context confusion in the max payload size
 setsockopt
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, sd@queasysnail.net,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, wilfred.mallawa@wdc.com, linux-kernel@vger.kernel.org
References: <20260831025607.62927-1-jiayuan.chen@linux.dev>
 <20260901031931.1636980-1-kuba@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260901031931.1636980-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


on 9/1/26 11:19 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
>      tls: fix TX context confusion in the max payload size setsockopt
>
> The patch replaces the unchecked tls_sw_ctx_tx() dereference in
> do_tls_setsockopt_tx_payload_len() with a new helper,
> tls_tx_record_is_open(), that dispatches on ctx->tx_conf so the TLS_HW
> path looks at tls_offload_ctx_tx(ctx)->open_record instead of a field of
> the wrong structure.  The rest of the option handling is unchanged.
>
>> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
>> index fbb274287aa5..e4f288c1fa34 100644
>> --- a/net/tls/tls_main.c
>> +++ b/net/tls/tls_main.c
>> @@ -833,15 +833,29 @@ static int do_tls_setsockopt_no_pad(struct sock *sk, sockptr_t optval,
>>   	return rc;
>>   }
>>
>> +/* priv_ctx_tx holds a different structure on each TX path, so tx_conf has to
>> + * say which open record to look at.
>> + */
>> +static bool tls_tx_record_is_open(struct tls_context *ctx)
>> +{
>> +	switch (ctx->tx_conf) {
>> +	case TLS_SW:
>> +		return !!tls_sw_ctx_tx(ctx)->open_rec;
>> +	case TLS_HW:
>> +		return !!tls_offload_ctx_tx(ctx)->open_record;
>> +	default:
>> +		return false;
>> +	}
>> +}
>> +
>>   static int do_tls_setsockopt_tx_payload_len(struct sock *sk, sockptr_t optval,
>>   					    unsigned int optlen)
>>   {
>>   	struct tls_context *ctx = tls_get_ctx(sk);
>> -	struct tls_sw_context_tx *sw_ctx = tls_sw_ctx_tx(ctx);
>>   	u16 value;
>>   	bool tls_13 = ctx->prot_info.version == TLS_1_3_VERSION;
>>
>> -	if (sw_ctx && sw_ctx->open_rec)
>> +	if (tls_tx_record_is_open(ctx))
>>   		return -EBUSY;
> [Severity: High]
> For the TLS_HW arm, is open_record enough to tell that no record is being
> built?  do_tls_setsockopt() calls this helper with only the socket lock
> held:
>
> net/tls/tls_main.c:do_tls_setsockopt() {
> 	case TLS_TX_MAX_PAYLOAD_LEN:
> 		lock_sock(sk);
> 		rc = do_tls_setsockopt_tx_payload_len(sk, optval, optlen);
> 		release_sock(sk);
> }
>
> but the offload TX path is serialized by ctx->tx_lock, and it drops the
> socket lock at a point where open_record is already NULL:
>
> net/tls/tls_device.c:tls_push_record() {
> 	offload_ctx->open_record = NULL;
> 	...
> 	return tls_push_sg(sk, ctx, offload_ctx->sg_tx_data, 0, flags);
> }
>
> tls_push_sg() calls tcp_sendmsg_locked(), which for a blocking sendmsg()
> with a full send buffer waits in sk_stream_wait_memory() and releases the
> socket lock there.  tls_push_data() has a second such wait on the
> tls_do_allocation() failure path.
>
> So can a concurrent setsockopt() see open_record == NULL, take the "not
> open" branch and publish a smaller ctx->tx_max_payload_len while a sender
> is parked mid-sendmsg holding tx_lock?


Yes, this window exists, but it seems to be a pre-existing issue. I 
think I can fix it by taking tx_lock.

> If so, does the offload path then keep using the old limit for the rest of
> that sendmsg?  tls_push_data() latches it once, before the loop, and never
> refreshes it:
>
> net/tls/tls_device.c:tls_push_data() {
> 	max_open_record_len = tls_ctx->tx_max_payload_len +
> 			      prot->prepend_size;
> 	do {
> 		...
> 		copy = min_t(size_t, size, max_open_record_len - record->len);
> }
>
> That would mean setsockopt returns 0 while records larger than the new
> limit continue to go out, which does not match what
> Documentation/networking/tls.rst says about TLS_TX_MAX_PAYLOAD_LEN ("the
> kernel enforces the specified limit on all outgoing TLS records.  No
> plaintext fragment will exceed this size").
>
> There is a follow-on question about the next call.  If the sender leaves a
> record open across the syscall (MSG_MORE with record->num_frags <
> MAX_SKB_FRAGS - 1), the next tls_push_data() latches the new, smaller
> max_open_record_len while record->len is still the old, larger value.
> max_open_record_len is u32 and record->len is int, so does
>
> 	copy = min_t(size_t, size, max_open_record_len - record->len);
>
> wrap around here and drop the record-size clamp entirely, letting
> tls_append_frag() grow the record past the 2^14 plaintext maximum before
> "record->len >= max_open_record_len" closes it?
>
> Note that tls_sw_sendmsg_locked() re-reads the limit on every iteration:
>
> net/tls/tls_sw.c:tls_sw_sendmsg_locked() {
> 		record_room = tls_ctx->tx_max_payload_len - msg_pl->sg.size;
> }
>
> so the latched offload value looks like the odd one out.
>
> Would it be better to serialize the check and the store against the lock
> that actually protects record building?  Since tls_device_sendmsg() takes
> tx_lock before lock_sock:
>
> net/tls/tls_device.c:tls_device_sendmsg() {
> 	mutex_lock(&tls_ctx->tx_lock);
> 	lock_sock(sk);
> }
>
> tx_lock is the outer lock, so taking it inside the already socket-locked
> helper is not an option; the acquisition in do_tls_setsockopt() would have
> to be reordered (or the helper made to wait for in-flight senders, as
> tls_sk_proto_cleanup() does on sk_write_pending).
>
> One smaller point: the plain read of tls_ctx->tx_max_payload_len in
> tls_push_data() against the plain write in
> do_tls_setsockopt_tx_payload_len() is an unannotated data race that KCSAN
> would flag.

I don't think so: all tls_push_data() callers hold the socket lock, and the

write is under the socket lock too, so the accesses are serialized.

