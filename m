Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515263;
	b=A6ZlZ1Yn9zgeJi04YiPIwf2YGFIGnwa7O40DlbIcLFDIiUShwdTGZtraOHwCN+FrwJsH
	 pzIsrBHH/gWmLWVUtxPUkUEe91i1g5eKDMYYChLtgk1uEH0wuQU6s5mBPJgeEfHcqtBMh
	 0vmyENLWeG0ldI/HM/WPsB0DPEOUvlPUqa0U8/+xJOkf72RdkF4gta7OnRMvHj7Ua4NJv
	 PRQ+mqbPGrsQKFQVgBKwOhe+xp50FxhlHI/XrIK8d1a+GFFAxdooNKM8Zo4TfPEmeyUQ1
	 jM1u/IwfMxahSnJ3VtuWVuTDUTqG6mvK7NcC0JJzcC5ymqV8lq0pCMc3dsPCjxE1Atw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=y7pJWX6mRQI0TWb4dnXe4N95Ebe0/SB4aAlZ0+60zH0=;
	b=mdbYWwoA3SchvZZP2IZz71sK41yxOqS7107dElwdnwLbS1panAZ/0gwVqbeGJP1QgYV/
	 H6nw0ZDM5f0EHK+4A4nDlkX/QK7pLOPUw/mPjOAOX3LBv9+v01WxewUy4rAOtNa6Cvp90
	 71Xa2Hczh+8+nVN270+9UNvcsa2a2a71wwaVmfwI3dwKacyRSDO2LaEA+cG7hIWVJuH/E
	 0zRTV5UyYKZ1bB6o9bZaPtX+xsW2rr2uTNv1tYojy0V53l+GYE6Z0v5kOMwGuh+d9ZH1n
	 R9Eiwf9UpTns+Escv/ibUhEGvBMC7tveVeaUyWCptqXSRh6sZrPvNYixZY7sgVltDlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Odl7PJRO;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78A1606A33D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C78A1606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Odl7PJRO
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2e934c6c1c8so10881185ad.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792515262; x=1793120062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y7pJWX6mRQI0TWb4dnXe4N95Ebe0/SB4aAlZ0+60zH0=;
        b=Odl7PJROQh4Q61IEQ8CPcx6DqKGqhKlac1t0A9z6v5r8e9IgP5bUmSn2zR38CCYcnQ
         4Wez/O0AVyYFuJ7V7sk8Pqk5xC+5A1RwilN+EGNiLxVRsqJrd6qtOTU68u1d5vtFOJ4x
         dw7p1HOzu5Jrz6ZU34Exk9IqCCo8FhomjBimuNTRSR5QbxYwZbjnfcPlxeA6Us693U0L
         KbCTJ84aHNF7b4hCM7wjKlW9Z0CWM4Sjj/2hrhSvZVch1ekc8MhuYc9eSmXzcplS6SO9
         p1grSv3PBGRuIVbkI0zuFBt5rJASh4w2OPSHlC+cYr0i4Rqiqh3w9U7ZQ3MsOvjwyAvq
         hkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792515262; x=1793120062;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y7pJWX6mRQI0TWb4dnXe4N95Ebe0/SB4aAlZ0+60zH0=;
        b=Vk9Ta3zErmSDQ2no7IhkxM/rUUjAVGHw9PLFG2/FuoGJM3zhnv6jAyemNjTsEvkWm+
         0qI0jN+fGIXLOGCEigJQIE+jc9zGK9vopC8kgpsXZ54bWQQAWATxjfQUANmS2KyNvtmw
         SqDIisTWVIxIuh8dm/PsyJiwvOM3iqXs2rM/6Offqdi9OB1z1v9Ti9bjy4fUJGsHqZp9
         Giy56Y/MQ2kxKqOUzXReTGJ2gLcRZkzDYgqMY/2eGXwYsywrEkoqZ+XwmEl1HFlvo/GJ
         v4DutBUN5oLX6M3mRfDBecYKPYB1Ju6cAbkt83gzcRcUpqwVuBb7R54P1g0oXLAYAyc0
         xF9w==
X-Gm-Message-State: AFq9FYL/Js/bx5omF41jEL0bJTxS1q5O51zeg8jqB8AtS1jrDY9cJ/bI
	uVs7BKpr6zDQnVW3ozgu/290i8/D51GmajzaI3O2SlfECdeVElqvbR4L
X-Gm-Gg: AYBFou1CvXwgEhbh5SCttum2CggL4F4S6dRwt4itK8Lx5iU6szmW1jRih1YPresylKy
	dJ9S2Jbijh/VpmPU/thZ4H+iGJAaaYMOUBAu7WqPbpzcwGno/TC4K23+sYV5btNRNJalGCyOe4O
	eWKYD7sz1BP5NTEeeaNQ9TXk91yoEV4eqJnsxfTZI/5SrCMWHsLE0SpHYJb/qbEPc4eOanFMEUi
	2D7FCFP7LhaPyBJk/aVMYpnHSKPlilNAnsIOEtiGue3EYdS10JYhV8RkMFKZs/yp9G+YBQ/2n1a
	GiQNWiUSC5ZZ5xuMx+vU1/GoEXK6QkV0OZ2tWvdwueCOzfJIcl8vD/xrPfATDpNsEr2lOTRKD80
	mb4lA1aTD3Xt3oa30jwl6LFS2/aCv7Jl/268C1kR7FxwcBLR5hJFAs97uRN0W1gG+acV6Pt1ZXU
	mHuuwEiMWCpfeCb/B/VnEzfNNvxojhEdNR9bTeUECZgqhDDww38X7oG+s8D0wr2UcL
X-Received: by 2002:a17:902:cec2:b0:2e8:3190:73a with SMTP id d9443c01a7336-2e9a7151518mr100280005ad.58.1792515262067;
        Tue, 20 Oct 2026 09:54:22 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:51::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b308afasm1724805ad.4.2026.10.20.09.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:54:21 -0700 (PDT)
Date: Tue, 20 Oct 2026 09:54:16 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kaifeng Wang <kaifengw@google.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com, 
	kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, asml.silence@gmail.com, almasrymina@google.com, 
	willemb@google.com, kaiyuanz@google.com, sdf@fomichev.me, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] tcp: reject devmem tx with fastopen and repair
Message-ID: <atecrKwmLG4aYsSB@devvm7509.cco0.facebook.com>
References: <20261019174522.55644-1-kaifengw@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019174522.55644-1-kaifengw@google.com>

On 10/19, Kaifeng Wang wrote:
> tcp_sendmsg_locked() enforces that devmem TX can only proceed if the
> zero-copy path is active and a valid dmabuf binding exists. However,
> subsequent branches in tcp_sendmsg_locked() can still intercept the
> message before it reaches the devmem zero-copy loop:
> 
> 1. TCP Fast Open (MSG_FASTOPEN or DEFER_CONNECT):
>    If TCP_FASTOPEN_CONNECT is set, the socket may have a valid dst with
>    NETIF_F_SG (so zc == MSG_ZEROCOPY and binding is present), but
>    tcp_sendmsg_fastopen() -> tcp_send_syn_data() will use
>    copy_page_from_iter() to byte-copy from the iterator. Since iov_base
>    represents dma-buf offsets rather than user virtual addresses, this
>    misinterprets offsets as user pointers and copies the caller's memory
>    at those addresses into the SYN packet.
> 
> 2. TCP repair mode:
>    If tp->repair is enabled with TCP_RECV_QUEUE, tcp_send_rcvq() similarly
>    calls skb_copy_datagram_from_iter(), byte-copying from the iterator.
> 
> Neither path supports or makes sense for devmem transmission. Reject
> devmem sends inside the Fast Open and TCP repair branches when a devmem
> binding is present. Checking inside the tp->repair branch also covers
> the case where repair mode is enabled while sk_stream_wait_connect()
> drops the socket lock.
> 
> Additionally, drop the !sockc_err gate from the devmem validation check
> and return sockc_err if set. Otherwise, if a valid SCM_DEVMEM_DMABUF is
> followed by a failing cmsg, sockc.dmabuf_id remains set while binding is
> not acquired, allowing the Fast Open and TCP_RECV_QUEUE repair paths to
> proceed and return before sockc_err is checked.
> 
> This pre-existing issue was identified by Sashiko AI review on commit
> 125755776bc6 ("tcp: reject non zerocopy devmem tx") and has not been
> hit in production.
> 
> Fixes: 125755776bc6 ("tcp: reject non zerocopy devmem tx")
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Kaifeng Wang <kaifengw@google.com>
> ---
> v1 -> v2:
> - Move the devmem rejection checks into the Fast Open and TCP repair
>   branches directly, also covering the case where tp->repair is enabled
>   while sk_stream_wait_connect() drops the socket lock.
> - Drop the !sockc_err gate from the devmem validation check and return
>   sockc_err if set, preventing a valid SCM_DEVMEM_DMABUF followed by a
>   failing cmsg from bypassing the check.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
