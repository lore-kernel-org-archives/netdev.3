Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792797876;
	b=vnJlsLTfIS8i+n6eMZAbGW+G+gzKYVEU1c0v3n9vfCyonMLyNw62ZnLpaxWct/Ws96p+
	 DzAy8cgOT1ipN2K4+GMMsK3UuzSflLIUKmoKjXaJDA7TWYbseeH0jfcYOsY4cY6wWfI/t
	 r2WStnoVSGF6QeS+JJRvBgYXBRlObwGVDaj5EM+6OoScI1bqY5CufFBifS8MobFQDWHn4
	 VwyrWYkfFJQE9Go9I5bbwI1pmZyDMxMKH8g+cdbvXaYaRdH85bjWkSkTm9dNETSswxkDq
	 rOg+gDkvrede/L/mqeHwM8NP5ZGdjevPiiyrc+1FznO1kfZQRoIwCb4NORsOtx8LpmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792797876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=qctrEjDPRvksa3AQ4KXVPQGZIrVdTyfkgfyBHLBiYsg=;
	b=0Y77epDWPvmbGZLee+lC02B7Sqfd7UibufByA/2Q3OunURZ3VfCD9mSvpSWtfcbFQ0Al
	 m6kaBKysQmZfLMc42nwLsWTOJZ8EGaw9w2Ii67VKpSezPX0nPA0a0hYqLe8+WTU6iZmKy
	 Ny6hLkbL0Wsshkap0Y/i3Nb2kiwMYpIN8EWN5riNMT3JMnBWDpG1Q9mrJbn3dmrd+HG5W
	 1WmbjYjlkv2VVhGNXGlJN43kyeguvn6f+nkaxHCe6pOA115xGknxIMaskZtQUYJY4s10i
	 u/qkS/gByeAQzQjM35z1Xv4qzVgN068ShaFOGP9BJkAAlCCyGKtNXggeB4jzG80v5tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GXwK61Sc;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB0C606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 23:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBB0C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GXwK61Sc
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eaf34452a9so1148668e0c.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 16:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792797875; x=1793402675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qctrEjDPRvksa3AQ4KXVPQGZIrVdTyfkgfyBHLBiYsg=;
        b=GXwK61SctjOOsjiufYWVOfoV93GiISGLiAKK/sikeLtakMu37g19i4wX5g8DVndbD/
         VGlGUTKtfmg3r2tBS4KMsgcEZRxlwLQTLnvQ0U20ZUWSvBeo2b/S2rD0EFlAovXmV4kh
         9dMGBgE2kNZf++/aLQZFGu5fYzy7wurS2hBBmFncuc5to98Dr7XEcDuD1TPa09Vr+upn
         j9XpbY9G+hNWVIEpcg2qUsnrB+sVgfsfBfn/sBw14EieDr7G2MFLqOKH7yd8YrDgksX8
         EEueQOY7RmiMuN22ihgdSkcofcScEJarwicP3iKEqHu2wrVdtzOphJWU+8q7GqlexZz4
         fCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792797875; x=1793402675;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qctrEjDPRvksa3AQ4KXVPQGZIrVdTyfkgfyBHLBiYsg=;
        b=PDKONiM/26CH58CrCDeINijpKZXUnCGGbP5ylRm3gmhrcLG6+aAxldJVgJFHMoM8D0
         bou7mLje5NXX68Zpn7b19jofZRWky7fPtLAviRBAZI3ZPOiRRag9cVvx3+GaqUdjpYNL
         4zyDsUym0GGwHxNT+7FwMD0ROTL7TCs/wFHxgXmBC39+BEQIg/Wg7bTdYqpX03sap3Up
         mo1KPq4mzmFp2hhh+HhhTL6FUXc+YYHMBxiVx9v+8RjJyA8ymUz3knqTvlbMsPh9Mvwk
         nYQKre8IZMCbsXLLB+9QrT/pDWTvELdcV5NfOvKDsXgmE2ip/B2c0QjjZHKs4EbEE9WJ
         MZng==
X-Forwarded-Encrypted: i=1; AKwUvBx0+eTJEl9oV+hutNH+p4T6GMXQZk+FF51vH8ZZN71fFCNyqcG189UTePUQmDDKpFPtehMRrfY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKBIliSFmGTPP8FVPAdw3OW3eMvEsRO2e7JDMyks6LWIbd1D9g
	7kORwTCIPWgWnS6/Y86MaYocPrrolT1sSb4y4VYUBHMiNY7G0wyHw36e
X-Gm-Gg: AYBFou2GLuQMYQtZYBTiYbtSqOvC0oVh3TUbepXdzyZXhbzh6T813S75AK+yhHbkzyo
	mEqwsOwV8fR878NEf+vS7WU7UQMqFdFSydjFLY+3dWyQ7q+oKgdUezKrq3Qu7kOtf20A+ijUeyn
	D5HTYqFbtKgBecS072EZHBBnKaf4WSZk/JdnK6g5ycZth+1sWa9MOYnPhamnDrsj1Ms9jc9NUCa
	N+/Lxeb/Af/Hx4Heo1TiDjXC/a/ceneb5av12Ef9xuMg1j5StBwgASdetPbE08nzMX/q+7RSQqJ
	Rd7SYKSltqI+6p9aTK4/5bJD8r/WVjuqw0smCy2DCfJQHrzMWeYTZTfweg3kMFYzsijy70nC55P
	gYPQ83ZTYTRt5sYaLL/v96kDX/KZZmgcwn7dBpyRb0ClwGhtqpJwJzz0FGzfqs3tcTKAgbWJFEU
	TZiJXf3ZiA5ah+TqCWPhBCyurC/kwFSNGVOBSgosYxSSpI4di0fx1RrAT4H5w1+Ey7gK5WRmT3Y
	TWbkFIA6qjuCHFilzDiWmUIjDO7rt39llbnqQYH/JdbJFhDtAlHO/4tkxaq33AGYIQi1aoL+twD
	cSPAlTwX8eD8BTlgWO25s0FmC83JQ8G8mexkbgxFmavf2KZXIFdRj3LmDXcMmGGii/dc7Ok/7Ig
	1d8DfjTl5oEZmmD/UiBVQXW/uU0bEAzGjjRHR6DYQ
X-Received: by 2002:a05:6122:2091:b0:5e9:6d96:a7cc with SMTP id 71dfb90a1353d-5ec235e8039mr93235e0c.9.1792797874653;
        Fri, 23 Oct 2026 16:24:34 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec232757bfsm466976e0c.2.2026.10.23.16.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 16:24:34 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:24:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Cheng Yongkang <teel4res@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Petar Penkov <peterpenkov96@gmail.com>
Message-ID: <willemdebruijn.kernel.2ec6aa9785f36@gmail.com>
In-Reply-To: <179268538303.70821.16548460883330758972@gmail.com>
References: <179268538303.70821.16548460883330758972@gmail.com>
Subject: Re: [PATCH net] net: tun: hold napi_mutex when deleting NAPI in
 tun_detach_all()
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Cheng Yongkang wrote:
> With IFF_NAPI_FRAGS, tun_get_user() takes tfile->napi_mutex, gets the
> skb from napi_get_frags() and copies the user data into it before it
> enters the RCU read-side section around napi_gro_frags().
> 
> tun_detach_all() waits with synchronize_net() and then calls
> tun_napi_del() without napi_mutex.  netif_napi_del() frees napi->skb
> through napi_free_frags().  A writer that is still copying has not yet
> entered its RCU section, so synchronize_net() does not wait for it, and
> deleting the device frees the skb while the writer is using it:
> 
>   BUG: KASAN: slab-use-after-free in skb_copy_datagram_from_iter+0x175/0x720
>   Read of size 8 at addr ffff888077def990 by task br029-poc/9406
>   Call Trace:
>    skb_copy_datagram_from_iter+0x175/0x720
>    tun_get_user+0xb42/0x3d00
>    tun_chr_write_iter+0x113/0x200
>   ...
>   Freed by task 9405:
>    kmem_cache_free+0x184/0x670
>    __netif_napi_del_locked+0x2bb/0x3c0
>    tun_net_uninit+0x566/0xa70
>    unregister_netdevice_many_notify+0x1a26/0x2090
>    rtnl_dellink+0x514/0x710
> 
> __tun_detach() also calls tun_napi_del() without the mutex, but only
> from tun_chr_close(), when no write on that file can be in flight.
> 
> Take napi_mutex around tun_napi_del() in tun_detach_all() for both
> attached and disabled queues.
> 
> Fixes: 90e33d459407 ("tun: enable napi_gro_frags() for TUN/TAP driver")
> Assisted-by: LLM
> Signed-off-by: Cheng Yongkang <teel4res@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
