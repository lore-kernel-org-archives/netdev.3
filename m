Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3433CB563
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787898934; cv=none; b=tJlZZAg1+Sn5sQceMxKywAk5upks/KdyqU4Nx6BF7GKZPYFLBPHgbURfnXd/jFRTqgvTmTfohJ1tAKfSaWZUqxVnNvVXnRXqjynM37xA3nLaTt+yif8cMkaQql3eiqqeGAHHZ1V70ULbHxZSO8zslen8soPYiPYyPEVSXyq3v1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787898934; c=relaxed/simple;
	bh=ZkqaU6xjYMnZhXnFuAmYd8Re5rQFMtuRWq9X6Kyik9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILBHO0HBnuBxBqzTCfWUaZtBTkIbxYtlhxIv7DGjEwprEfMtbvMJEEclhvHgccLNm9oXHnRxOmIduQaSVMx/ZbYFIA9CR3r0+rrg3OT0gwcgXH6DKGGlYI1yqg5qXpPR+2oicGw+VspOrUfy4itccK/tenM9i9NYV5py1UTNm0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bfx5HOQ8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s25v6zFY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfx5HOQ8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s25v6zFY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787898932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wo3JmG3c3pYLBvFD0UAUF1R4n71rrMwTKBDqsXXXpWI=;
	b=bfx5HOQ8S9Jq2HLffj/UUBwuChJ77WX385pNtpO3JQgghURvquCrw7srB/J2k/ITS9Ungi
	mgMwazrSpouEB4dPFdgGPBlssEg19DwrnSiFc5NIx86VR9cpUsMr+CokFDECQwj8faa6eP
	CPgbn2+JwfzOuHuHC36QLmS3R/4k1u0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-ZZg92S4lNNq_VBSX21wjag-1; Fri, 28 Aug 2026 02:35:28 -0400
X-MC-Unique: ZZg92S4lNNq_VBSX21wjag-1
X-Mimecast-MFC-AGG-ID: ZZg92S4lNNq_VBSX21wjag_1787898927
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4994cf6cdb9so3709295e9.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 23:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787898927; x=1788503727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wo3JmG3c3pYLBvFD0UAUF1R4n71rrMwTKBDqsXXXpWI=;
        b=s25v6zFY3/jFz/5fYZj7mgVV3CircYk/1ZYpneDLQwhyOJqy0M69QjjEWDxe92SEp7
         lDRPKGzmrLcPFt357vNTuyatQtY5j01NkWpmS0ifnPJv7n4LV2dl5KJRiqa9q7EqwQu1
         jTn1aFXQqVLY+Sw2B5jDaVDmw3b5T1Jr3i1/AgUqBaC/G8ql4P3DDghdlJSpO6LEPcQg
         qrM76EVEnXCcQEKjXUtFgcbzL8qoMQqyz4zGeIT9cvUsjvo2NiwvE3t59lNragNXzv7A
         iSnLR9qFjaVyHCQPxJYAVSNBPS5y5pTLvBQczLUiBrQzKPgdajcQs1CHPjo88A+baTW0
         L8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787898927; x=1788503727;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wo3JmG3c3pYLBvFD0UAUF1R4n71rrMwTKBDqsXXXpWI=;
        b=QOB1vYnSez2/e2xCeRtn5dAv5qiJl64XcFF3ZZf/UZ6RDUJ50Sv/5vTHfqqJBDI6QR
         ZjlLlYoaXAKLz9j6/bfK1bEJXZwOMLZWHXF4MLn1K2fQPelVgGatvJH1dg6KLcHHjF7m
         GK+t9iVOPvEmFp/5nt6eINkyY5u0Te7lrZlrnvJB9E7L7mdS3JLvlu0QixAeDrIsIgkQ
         24cmHXgjx+5lMx+QjL6QXBFEoQOBWUxyn0ce5heGaSwnZJ7B+EiCiqWE0XGPqZL8UUlh
         o2r9KCE3uQX97I0A0ACCF8hgOqnRInnw0S9JNJKIAWhCLuu7txBuPqFh9jP2zb5jQ9du
         2+5g==
X-Forwarded-Encrypted: i=1; AHgh+Rq50yWMsO6dDmVMcQF2w5J0O06FDcts23rJDkEk2pbpsdyBtBa0jcDNvbnbh3rxcejH3oq+T1w=@vger.kernel.org
X-Gm-Message-State: AFuF++ndH+jWQMcgRIqZ0JmUsKut7LbMQlqSjtBoXgKPWiFf0j1TCvC5
	dIJSUigTXbZlq6sYLX7rf+2PLwCJbKGiF+eqi+Aylc8v5Imrs4I3ehCzuEKXEhDFYz4WZFTDd2b
	dNkY5qOgsZhSp8xLszIP4xb6p9Xlao2eDIT+HsOJXYwdSZD/mVCJRSCSaaQ==
X-Gm-Gg: AR+sD11QIWw//uodgs/YAYdPQ3bxSvdUSd8XhwYJ2gbsJ/NnTPfy4TxyPZb5H9arbdy
	XD6SLs3UnmVNRmH/gKqFEWQS4qoqs/jvs/1dHfeFCDsibsyprgQJ8KEgHcHjPNKRRtuvwUC62L9
	9mYrTK3lYv547Hkz/H625IFpaqki4CYffUshYussMxN0vzoysxl3TvF421Ln3TQktgb9DuJDvKG
	vgOCi4I4hJgbTsGID5IoqNlB+MB1W0KfFFnFJutUOCD7g/SbJKBiSubSEWHh110HmXaTQK192md
	W18aK5WCVHXiYC23cJ5h+I3cJO8dFCBJmuFji4ur8ZCLENpbciUzxlmlTJHGg6G2tONxd3AKkFB
	jRqpcqA+CpoYpTBwzAqGCafgUt8uR1/VM+9YUbW9iRGRkq49ViDcwTseG2iHtizxv6CmfO/w=
X-Received: by 2002:a05:600c:81ca:b0:49b:47b3:d6d with SMTP id 5b1f17b1804b1-49b91c3b7c4mr67056965e9.10.1787898927533;
        Thu, 27 Aug 2026 23:35:27 -0700 (PDT)
X-Received: by 2002:a05:600c:81ca:b0:49b:47b3:d6d with SMTP id 5b1f17b1804b1-49b91c3b7c4mr67056195e9.10.1787898927015;
        Thu, 27 Aug 2026 23:35:27 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c5790csm34858195e9.0.2026.08.27.23.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 23:35:26 -0700 (PDT)
Message-ID: <e0a35a2f-bb1c-44f6-877b-09230d40fdd4@redhat.com>
Date: Fri, 28 Aug 2026 08:35:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 01/14] mptcp: do not reschedule the RTX timer for
 fallback sockets
To: Jakub Kicinski <kuba@kernel.org>, matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-1-a92309d121ca@kernel.org>
 <20260827190723.3998185-1-kuba@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260827190723.3998185-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/26 9:07 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> mptcp: do not reschedule the RTX timer for fallback sockets
> 
> This replaces the TCP_CLOSE state test in mptcp_reset_rtx_timer() with a
> new MPTCP_RTX_DISABLED bit in msk->flags, set both on fallback in
> __mptcp_try_fallback() and on the transition to TCP_CLOSE in
> mptcp_set_state().
> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index b474d03620a75..23dde0b7144bb 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
> 
> [ ... ]
> 
>> @@ -1084,13 +1085,14 @@ static bool mptcp_rtx_timer_pending(struct sock *sk)
>>  
>>  static void mptcp_reset_rtx_timer(struct sock *sk)
>>  {
>> +	struct mptcp_sock *msk = mptcp_sk(sk);
>>  	unsigned long tout;
>>  
>> -	/* prevent rescheduling on close */
>> -	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
>> +	/* Prevent rescheduling on close and in case of fallback. */
>> +	if (test_bit(MPTCP_RTX_DISABLED, &msk->flags))
>>  		return;
> 
> [Severity: Medium]
> The new test depends on a flag that mptcp_disconnect() clears while the
> socket is still in TCP_CLOSE, and after mptcp_stop_rtx_timer() already ran.
> The order inside mptcp_disconnect() is:
> 
> 	mptcp_set_state(sk, TCP_CLOSE);    /* sets MPTCP_RTX_DISABLED */
> 	...
> 	mptcp_stop_rtx_timer(sk);          /* non-sync, timer_ival = 0 */
> 	...
> 	WRITE_ONCE(msk->flags, 0);         /* clears MPTCP_RTX_DISABLED */
> 	msk->cb_flags = 0;
> 
> Can the rtx timer be armed again after that point?
> 
> mptcp_stop_rtx_timer() uses sk_stop_timer() and therefore the non-sync
> timer_delete(), so an already-expired mptcp_retransmit_timer() can still be
> running on another CPU. It only takes bh_lock_sock(), and its
> __set_bit(MPTCP_RETRANSMIT, &msk->cb_flags) can land after the plain
> msk->cb_flags = 0 store above.
> 
> On the release_sock() that follows, mptcp_release_cb() calls
> __mptcp_retrans(sk) with no sk_state check, and that reaches
> __mptcp_clean_una():
> 
> out:
> 	if (snd_una == msk->snd_nxt && snd_una == msk->write_seq) {
> 		if (mptcp_rtx_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
> 			mptcp_stop_rtx_timer(sk);
> 	} else {
> 		mptcp_reset_rtx_timer(sk);
> 	}
> 
> mptcp_disconnect() does not reset snd_una/snd_nxt/write_seq, so for a socket
> disconnected with unacked data the else branch runs and arms the timer with
> timer_ival == 0 on a TCP_CLOSE socket whose timers were deliberately
> stopped. The previous inet_sk_state_load(sk) == TCP_CLOSE test returned
> early here.
> 
> When that immediately-expiring timer fires, mptcp_retransmit_timer() does
> test_and_set_bit(MPTCP_WORK_RTX, &msk->flags) and then calls
> mptcp_schedule_work(), which refuses to queue the worker for a closed
> socket without clearing the bit:
> 
> 	if (inet_sk_state_load(sk) == TCP_CLOSE)
> 		return false;
> 
> If the application then reuses the socket with a new connect(), does that
> leftover MPTCP_WORK_RTX bit keep mptcp_worker() from being scheduled on
> subsequent rtx expiries, until some other mptcp_schedule_work() caller lets
> the worker clear it?
> 
>>  
>> -	tout = mptcp_sk(sk)->timer_ival;
>> +	tout = msk->timer_ival;
>>  	sk_reset_timer(sk, &sk->mptcp_retransmit_timer, jiffies + tout);
>>  }
>>  
>> @@ -3324,6 +3326,9 @@ void mptcp_set_state(struct sock *sk, int state)
>>  		 * transition from TCP_SYN_RECV to TCP_CLOSE_WAIT.
>>  		 */
>>  		break;
>> +	case TCP_CLOSE:
>> +		set_bit(MPTCP_RTX_DISABLED, &mptcp_sk(sk)->flags);
>> +		fallthrough;
> 
> [Severity: High]
> This latches the bit on every transition to TCP_CLOSE, and there is no
> clear_bit(MPTCP_RTX_DISABLED) anywhere in the tree. The only site that
> resets the word is mptcp_disconnect():
> 
> 	WRITE_ONCE(msk->flags, 0);
> 
> Can this leave the bit set on a socket that afterwards carries a normal,
> non-fallback MPTCP connection?
> 
> First path, a failed connect() followed by a retry on the same fd. The
> error path of mptcp_connect() does:
> 
> 	if (unlikely(err)) {
> 		/* avoid leaving a dangling token in an unconnected socket */
> 		mptcp_token_destroy(msk);
> 		mptcp_set_state(sk, TCP_CLOSE);
> 		return err;
> 	}
> 
> For a negative return from sk->sk_prot->connect(), __inet_stream_connect()
> takes:
> 
> 		err = sk->sk_prot->connect(sk, uaddr, addr_len);
> 		if (err < 0)
> 			goto out;
> 
> so it never reaches the sock_error: label that calls ->disconnect(), and
> mptcp_disconnect() does not run. The socket stays SS_UNCONNECTED with
> sk_state TCP_CLOSE, which is exactly what __inet_stream_connect() requires
> to accept a second connect(), and __mptcp_nmpc_sk() also permits
> TCPF_CLOSE. The later mptcp_set_state(sk, TCP_SYN_SENT) and
> mptcp_set_state(sk, TCP_ESTABLISHED) do not clear the bit.
> 
> Second path, a failed listen() and inheritance by accepted sockets.
> mptcp_listen() unconditionally does:
> 
> 	err = __inet_listen_sk(ssk, backlog);
> 	release_sock(ssk);
> 	mptcp_set_state(sk, inet_sk_state_load(ssk));
> 
> which is TCP_CLOSE on failure, so the bit is latched on the listener; a
> later successful listen() only sets TCP_LISTEN. mptcp_sk_clone_init() then
> creates accepted sockets with sk_clone_lock(), which copies the whole
> struct mptcp_sock, msk->flags included, and __mptcp_init_sock() re-inits
> the lists, timers and allow_* fields but not msk->flags.
> 
> With the bit stuck, mptcp_reset_rtx_timer() is a permanent no-op.
> MPTCP_WORK_RTX and MPTCP_RETRANSMIT are set only by
> mptcp_retransmit_timer(), so does that mean __mptcp_retrans() can never run
> for such a socket, leaving data reinjected into msk->rtx_queue when a
> subflow stalls or dies unretransmitted, and DATA_FIN retransmission
> disabled, while the write side keeps its sndbuf pinned?
> 
> The previous guard read the live socket state, so it stopped applying on the
> next state transition. Would clearing the bit in __mptcp_init_sock(), and on
> the connect()/listen() retry paths, restore that property?
Both remarks here are a combo of pre-existing races and behaviour change
with this patch. Still I think they should be addresses within the same
scope. A new revision will be needed.

/P

