Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.234
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608337;
	b=ntb0FNRR4YjwfV/+GJSIbdTF1+0/P6L0peWAIJ+YXwdMOREhsuvKLXAJDr83S9B5a/FA
	 gOngNc6oGXke2MDXytE+aKwEd2F1u6+27S5jkuZp5oCCG37rH8ShI/DIvIkrQQODqmvIH
	 SyGM5VU2AEBZqpHFkqNHolrQxyWU60RHbihyAL7s7CtcwDnSOV5zcY1NvcFy8nrlgQoIr
	 Frj/TTDH/gletnwT1KkA+KTXb9P23g7EgHW2G1op2XY1ZxHv+sT+OFNvtNI1scXD1yFr+
	 dbnmHFcgIrHtLY8FfW9h2Yw/98K60sl4fVio8XXDmNm/7LvCA5MAcyBhyLevMHxRVmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608337;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=IYreqHUz2HQR2AUBnBbZcSxaTUlKTzbRYKcUs5sJV1I=;
	b=xV4nkee6ZRfq9jCSlgZO4llG9mhmRvvSwxJ87ooZxtD7DpDqmcXyh4C3em/h+S9jwE20
	 mbKIA12JD4NmZpShs+aSsI+epZJxRhG71pRh1YkBRBlXa6Z3b83mCWoANQZYzu4b825km
	 wPcIL4SdV+XgAH8n6vzFe1EGumkjUZr9Pn+DFo+r3rW9jvyjg9TE0hw5gKnvF9W4P1/TL
	 k9XY3ZE5uZ5nPwYplezmCmgwu8BewerR81X5wFscdOjiekoVykfwGL02usHwAJ92w39Ro
	 by8o5SEp5MQBlQ0JPT6RG3a5bTQVaY+rxIQ3J+ClAaVFXQ6ssXWe91FNRxafDjswy0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ds6Fln3l;
	arc=none smtp.remote-ip=91.218.175.234
Received: from mta0.migadu.com (out-234.mta0.migadu.com [91.218.175.234])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A60C606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A60C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ds6Fln3l
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2P3ROvsM82yhJ2gGF+tSdLtq7UlfUDARI+FzX4vCWJI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793608335; v=1; x=1794213135;
 b=ds6Fln3lPjT2pVFkMVnpUW34VbSJu7/oKSYKMxWcrvJaNQo76xr+hiufxkXcSqUoTUEkMj8O
 ro0gdx7xJwPcmy9yAEmjqY2USKm8t0zf0IsIg4uTgtFu1jBg7/ScKiPTaD6og7gW1ZUZ70KwqwA
 IgpXOTJSHz7jNKictxCdyGtg=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 884a5ea4713e1463;
	Mon, 02 Nov 2026 08:32:15 +0000
X-Mizu-Trace-ID: 884a5ea4713e1463
X-Migadu-Flow: FLOW_OUT
Message-ID: <1d0cce30-28d8-43ee-b6b9-12e2660d4992@linux.dev>
Date: Mon, 2 Nov 2026 16:32:07 +0800
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
Subject: Re: [PATCH bpf v2 01/15] bpf, sockmap: Write sg.start when recvmsg()
 faults
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-2-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:20 PM, Alexei Starovoitov wrote:
> From: Josef Bacik <josef@toxicpanda.com>
>
> __sk_msg_recvmsg() copies an sk_msg to the user buffer and starts at
> sg.start. After a full copy of an element it calls put_page(), unless an
> skb owns the page. It handles 0 copied bytes as a fault. It writes the new
> sg.start after the loop, but not when copy_page_to_iter() faults.
>
>   element    0: length 0, put_page()   1: fault here   2: not copied
>   sg.start   ^ today                   ^ this patch
>
> Each subsequent call copies 0 bytes from element 0 and returns -EFAULT. The
> user cannot read the rest of the data. sk_msg_free() starts at sg.start
> too. It calls put_page() for element 0 again and can free a page in use.
>
> Write sg.start in the fault path too. The commit in the Fixes tag removed
> this write. Do not write it for MSG_PEEK, which changes no element.
>
> Fixes: c9c89dcd872e ("bpf, sockmap: Fix partial copy_page_to_iter so progress can still be made")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

