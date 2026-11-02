Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647068;
	b=2re+OwCmCuegMUT+2LjAPXUat0ncsacSGkWbv0CnxxRz8hTMQqeIvd6+WfygXBL/R4U/
	 tZ2E0as84btg8hIrDDQug8TfbNyWYfVZFy9BhduL9JSChELiXHgkrwbuEKG15zoZkS47U
	 pUGk/YGyEbKDiUxH/xO+rxubFQI4ee4OHag4sbeFhbjcKzVDrQ3KTLCOe10oE6MttMyYh
	 uNYjOIGCeTPWs5Ir59X1+k+PeM2ONuzyCUdi1NtN+aRjFXGmWg3Wxo68aYqwK3yuRlM6A
	 BVW935H6bfRXVRQI/RXZkIglhOLk+b9Zd9q1vRZrvlTQWGpWZUOg5iKBFrVd/FuhY5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:User-Agent:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=d4HU1ZMjQSDjg4zY71Jjjfa2oalRN5eFdZ16rR5uBtk=;
	b=EciHjOIXFitPn/kcgQCyszTjXmFl+Orq2VIv5aaR+llH2Pj/dudolWn99KJKV1ll1DAJ
	 vwdOnDwuUUd4buJlwDlmBH7IR3AGGkxJ73PwjW6FuqMk2cfjcPCy1J/EbGvCjgIdaND51
	 k7p9qaXTp1TOgLATu4620WtYgtTiVtxUN02cyVbCIdTWw8LmIId5W/9zJ8WtOeyID+ZcU
	 Cy9qh9A7LlArn/J85iDfMwXpVdhoUH6PxY/97mTmWsE38N+mNww+3BaIx3qlVDAYe5Vjm
	 +lbhnbllRBzavnjp5YktCbnRdJK9k8D5rkBwhJH4Vp2aQJQiSy8C80+lzg9PSNN8n/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yJaSOX2f;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A030606A330
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A030606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yJaSOX2f
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e985106c0cso31962545ad.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793647067; x=1794251867; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=d4HU1ZMjQSDjg4zY71Jjjfa2oalRN5eFdZ16rR5uBtk=;
        b=yJaSOX2fHm9Juwmq4JUqoq2YUiIBtyUVoOmlcmVoBrELsNCPbLTMw9rO4vLs0MhZMG
         HTvB/tLqyscvajIJjgD6/cPDUx/LkVkZPpVEfVxgXmXIlft+0McDPvdaqF6XZOLXacyH
         Ang6zqa1IQfCrYrT8Md40UVXLxx/Bf/lF4+5eI96hHQ2A4o81YQyVR9/6aST0pq6Gwwl
         8ozlggmL8sw+3up/7ETIfUKIjVuQlGOuwk+S2+X2nPzSOqDegfLQHFHzkV4iAC02s7WG
         Fk8JIVPjWmrs3FU2mmVvS4Sy74pzkJgosxvGuJzW3pF40R7QywgdD8b2hRupemNnX/Uw
         n5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647067; x=1794251867;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d4HU1ZMjQSDjg4zY71Jjjfa2oalRN5eFdZ16rR5uBtk=;
        b=OYsf1zaZ9Pi00Z9Ni/MHtInVsf2TKmaXetVYX+ZyDUt+9gsNCcumeOHM2bJqd2pN8Y
         sBYoua81V4lvsIoz5IirwDLJZ6NOWqkeo+uu8FIFuBOdod7SfmOh+GhtnLVEXX7mFxGB
         RzL/s/oFwStpTic+UbPidbk8wFFEurKo9u2y+Kyo21DDmxMHsitum5g7FWtQxedL90Cg
         HcQqeCSYjYBIHBSrn5c4mSE5JzLz7zUrThQPzDAKWcNiWchS8u4aw7cZ/KEZbkmnb2JP
         WrI+F4ZHgxGlbKrzvBOxYgN+TWnSpiKjh7JmzFWjnJmOBqoC6TsoSDXebz7+/quSf42h
         7w+A==
X-Forwarded-Encrypted: i=1; AKwUvBy+p5MONAOZ6Trb7IJFHyQem7R/xh+K1NVgmfHyeU9RF5avwqSx9kERprHO+ckPIC2R1AJ9nu8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/KqFZP2N+Qrr7mflFdlh1rQxHiYNGlKgg7eReQFH9UzvGTYHr
	KwcjPsCPmyireb6tu2ilTgjv9DG874o6WglmTgnskYIh2Sq2terurrOF
X-Gm-Gg: AYBFou02e4WXIz0vXrLytvcGsHrwQrXhwEQBqmh/RiqvX9zuJADW6LlCQoQwRar6Ur+
	9/1A/Ml5IGqnSK5Y1kmW+76qOGSdDbZLoTrqcA303hd67uW7JbbVAazXHMz472n1o1tUFkHv6t3
	ej2Qqw4zwQeWIYeNQPD4ZHgcdjmzPsMiKsEdJipZPkyCykn1IpAuCQEDuc7HYIkEC4z+uogxhIL
	+ah4N73GdYAfB+zdGmj1jvo91zeBdk+X4Wzt0iCgR9haDw+5Jjo64MX9K4ffIpaCfYAQ5bHN/Up
	xH+dffjYHCfIaI0rIYof114wMzfg+G9AH9iY6lZGoOdKkljwM5eOPMxdoYXE+OWm5dLqAw5YHKf
	6R/WdW7QPuIkMn7mGuxVsjp0aB+BQBASgzxn3yfObVopEV9pTUheA/y1KR/lNZ1bhqbN7WLALbp
	HObvTNGIy4jAV8xV1jo43JvCcAVIsiU619xEksd02zLosS9Gdwf+Tis5ouUKV+E0Dr+T3n4cWT3
	aACl4iVtoiM+RtHq/fUJRtxO0lgIjoONO5q+ycNNZX9MjrAzydz7o0xLKUhkOR68c2mv4ADxNET
	cowF7GdmSKaGbXKuL0WhVmfz/kN5ZmAwxtsdQ/3sdyEVMxDTicxwNc1A96sAOcpBHWCr
X-Received: by 2002:a17:903:1b2c:b0:2ea:a2ea:5f62 with SMTP id d9443c01a7336-2eb364b8c96mr101881445ad.24.1793647066596;
        Mon, 02 Nov 2026 11:17:46 -0800 (PST)
Received: from meli-email.org ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39231422sm32617295ad.23.2026.11.02.11.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:17:46 -0800 (PST)
Date: Mon, 02 Nov 2026 12:16:49 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mptcp@lists.linux.dev, Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH bpf v2 05/15] bpf, sockmap: Clear the resume state of a stopped psock
User-Agent: meli/0.9.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-6-alexei.starovoitov@gmail.com> <9d399d69-1dfd-4848-bd55-be099b6dd792@linux.dev>
In-Reply-To: <9d399d69-1dfd-4848-bd55-be099b6dd792@linux.dev>
Message-ID: <tnw2xl.1p1r2tdvgc3bg@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

On Mon, 02 Nov 2026 04:40, Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>
>On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
>> From: Josef Bacik <josef@toxicpanda.com>
>>
>> sk_psock_backlog() passes the skbs of psock->ingress_skb to the socket of
>> the psock. When the socket has no room, the function saves the length and
>> offset of the remaining data in psock->work_state. A later run continues at
>> this offset and clears the state when the skb is complete.
>>
>> sk_psock_skb_state() saves and clears the state, but only while
>> SK_PSOCK_TX_ENABLED is set. sk_psock_backlog() does not test this flag for
>> each skb. If the socket closes during the loop, sk_psock_stop() clears the
>> flag. The loop continues, but the state of the completed skb stays. The
>> loop uses this state for all subsequent skbs and sends only part of their
>> data. A closing socket may lose the end of a stream, but not the middle.
>>
>> The state belongs to the skb at the head of ingress_skb. Always clear the
>> state when this skb is complete. A stopped psock still saves no new state.
>>
>> Fixes: 3b4f14b79428 ("bpf, sockmap: fix duplicated data transmission")
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> ---
>>  net/core/skmsg.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
>> index f03519468ad1..a5d498982848 100644
>> --- a/net/core/skmsg.c
>> +++ b/net/core/skmsg.c
>> @@ -664,7 +664,8 @@ static void sk_psock_skb_state(struct sk_psock *psock,
>>  			       int len, int off)
>>  {
>>  	spin_lock_bh(&psock->ingress_lock);
>> -	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
>> +	/* No new state once the psock is stopped, but never keep an old one */
>> +	if (!len || sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
>>  		state->len = len;
>>  		state->off = off;
>>  	}
>
>
>Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
