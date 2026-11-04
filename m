Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815745;
	b=UlhwXKrgDQc1hvGDDSyDCG+tqHGBI9VoXjDr6dBKnaRFaXJn7aSegoWqgyHUsO/+zTLw
	 Kzi6F9Sap4pxLzhskmLXIFjGEDfIO/h3ELzp4IziZSaVxZYbU1myIhrKoEOwdfqjD5JH3
	 Rro1dFwVJtawHXVseiZvlgySVW35Iun1C0WxZwHsiKNCtlisZXZy3juQuUmxYNzYfWwzW
	 eY39RotHN9IoIKI6L71LAUxrQ2ocEJlIT3eihZXG+dvR9hzjzjO3U0YTxqgcUypvrwNn/
	 9esNqkhhxNfsU7gIQGirI0VpaV2TLkdPqTsMqc8UMiGA7pAVQYLdPFfVb38xX4sjHZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815745;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CVsLTmxNWfxUI2tna4xY+A80o8Oxx2HIRrZYrtR1B4I=;
	b=uHI9gXSUgbCSVvE/kLMkt2DPvEu8/kxEyX4eMxPOQ/XfLnM6HqLAHzVpeDU5+RY2tvan
	 JrQPpvBb5a8+KNFHYxc51DSb+JYpDIa98I8vGwkk2hF7uHdcotfqNmBSX+uY/iYPpBfZQ
	 fMfNSlsGjdmwGOrnMw4ztiqRSQJpzv40aheFG/K3UBczmXjc+6+Wd+BdL5tniSnh/uCcp
	 SbEXHWgy3nxAY4qwuIiuEGyFnwd5NgVXRzfztFwz1+UCUZH3BmX4QBdldWIBSJPJ1tz96
	 XNt2xjmDp7V/ujaXu6h4AKzrklISA5v8RdDGR/UMSlZ/S3IV2omP/vaZnZwwx74reAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eNVoCqqg;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gLGXZISn;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4872A606A7EE
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4872A606A7EE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eNVoCqqg;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gLGXZISn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793815744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVsLTmxNWfxUI2tna4xY+A80o8Oxx2HIRrZYrtR1B4I=;
	b=eNVoCqqgoEOrPDMBKfnclhyXNh9QnEoWpK8/9s8ZhPuRlpjydNKtDrsWqtrWprMubgP1w9
	dqNNleMOSU2ECJcLSmP77z7sWn1lpYpRY0Cd5LHIZdY8XqEZscYRfheq9g7rWNjJzNDAJ6
	q0zO86vEHF7A8E/mCv+ky6MBtr5+Q7M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17--XPdgc__O2arxIm4upaDqw-1; Wed, 04 Nov 2026 13:09:00 -0500
X-MC-Unique: -XPdgc__O2arxIm4upaDqw-1
X-Mimecast-MFC-AGG-ID: -XPdgc__O2arxIm4upaDqw_1793815740
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a359b714f8so8011875e9.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793815739; x=1794420539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CVsLTmxNWfxUI2tna4xY+A80o8Oxx2HIRrZYrtR1B4I=;
        b=gLGXZISn1+kwWvX8eRNdotsXcBNA8ij7HAxNesYBTl1YtBzTyLCzmVUoElEU8sFZfS
         s2Z8dPs55FiKCUAS0LIP2n9wSPRa1HTLA/zKppb6G5CqlC0eKxpHU69r+nKcKkjutQhl
         Bo1PnkoKy8rs50T8W6OPvcORQVFV0ZenlkRrbzFPe/wRSqrKSYACvydJAx3bWGosfzjr
         aG9PJOZyS7sao4EksbVNThAbU8CO55NO/hUQZg//4AFh021VF0XS7IpqGVMzhzeJH1GI
         N5Ew93Mbi262kwj6uSC++BY5GIejf/gPXQegeFOrQR8Qr8/fUyfmQOdmdScz0SYRAhiQ
         ed/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815739; x=1794420539;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CVsLTmxNWfxUI2tna4xY+A80o8Oxx2HIRrZYrtR1B4I=;
        b=XdJNHnYt9QpXPzpHxDhBcLzDA2DrsXd08CjCj5RkIRWpF3loCgtaf3NJaV7xjXKgrI
         bASN6VPfE9k4sj5gEttcf/jt9eqnBWihrDnx2KsSeltAnqyOi21SfihUfo1o08AMibGk
         utTUYULkFYcEEhO7RIurpfQ0xxE/EZyWMH7QBsj+0g10E0BQs90F/veCTB7dC1IwZjye
         qkG6zRdkIVCSLs6cMr36R+Iw5tvF/45+Vr20WZYBTh7DtbJDJi0iQD3Gl5CQVAkBxr5O
         q1kLQR3I45h5wBd/633bwIdt68IholHK/IEmzmDEmdyfHV8Mq5LaSmK0IH/ZI7KthA12
         l05Q==
X-Forwarded-Encrypted: i=1; AKwUvByXxVD4XGdlCTcP1AtYv57AL0G5CzS3tex0JpwXr1ydmNsOnZ37HANK6UjJr6mGcJQ76nJu7wA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dddMMQ0QMGfegK864lu51GTLcEmv87Z6mZ+QpQR29iRCwn6sw
	f4+VkoxB39z6wDfYA26FOlaeWR4/ffzjip2Y1EiflT7OPuFaluyYQcPEcXNt0bYUqW1Tq0aK6kP
	jLoNWSB5XuGQhHBdIwlFtqaLRfkHeMVvpPhTkCEnlqMLY/vnUpIBvz12LZQ==
X-Gm-Gg: AYBFou1awRnaNCYvBdZ8AiqGqS5D+NniJAvS7E4ZClZBGiN0KNY98cukKUWpoZY9mZ1
	NXoJz716WXz6N5lnvcGD9hWaSaDbvGC1Ee0oMFOOr+ivlUG83WWuJDZAKg+HPYCa+9VKi5qTK39
	2W/VFRQlhim2Dx4CxuUm1MbC2b2sluMAjrapi5xlTxHdOgQUA7z0BW+mW1Qg1poICUOI1JAWn3u
	+2Fah2rzTgJZntWlKd/HcWLuemy8xZuDuTJZPwC+MGbVfK1eRIcHNJtzKE3mz7XBEh74Bj5iVcQ
	rBSASUHzsqUIYRF/p7rZXfA1oiSw65YSBnsVnf0UY5xVwsCbUJz60M1r7cV/AmBRBXxdT/kSRMp
	w5Z1Sd9HzMjAbG+fQ3yXv8fXZBbGivvtoRvDpfA0lwjhCA8o27Ox7tCPvhYHY7Liu23czWKoa3Z
	qxpiswaFwslQEN5Lny853GXhN8Hg==
X-Received: by 2002:a05:600c:3d05:b0:4a1:faa1:3813 with SMTP id 5b1f17b1804b1-4ac187a6960mr382690265e9.27.1793815739717;
        Wed, 04 Nov 2026 10:08:59 -0800 (PST)
X-Received: by 2002:a05:600c:3d05:b0:4a1:faa1:3813 with SMTP id 5b1f17b1804b1-4ac187a6960mr382689845e9.27.1793815739327;
        Wed, 04 Nov 2026 10:08:59 -0800 (PST)
Received: from debian (2a01cb05923c9a00ac19e47fa8c3a9d7.ipv6.abo.wanadoo.fr. [2a01:cb05:923c:9a00:ac19:e47f:a8c3:a9d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e2ae73csm2041325e9.1.2026.11.04.10.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:08:57 -0800 (PST)
Date: Wed, 4 Nov 2026 19:08:55 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
	jchapman@katalix.com, tparkin@katalix.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] l2tp: only return sessions of the given tunnel in
 l2tp_session_get()
Message-ID: <aut0txiHZnAZjad8@debian>
References: <20261030032617.4065353-1-hengyul@cs.unc.edu>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030032617.4065353-1-hengyul@cs.unc.edu>

On Thu, Oct 29, 2026 at 11:26:17PM -0400, Hengyu Liang wrote:
> Commit 5f77c18ea556 ("l2tp: use IDR for all session lookups") made
> pppol2tp_connect() and the netlink session commands find sessions with
> l2tp_session_get(), passing the socket of the tunnel they name.
> 
> L2TPv3 session IDs are unique per network namespace, except that
> sessions carried over UDP are only unique per UDP socket, the socket of
> their tunnel. However, l2tp_v3_session_get() only checks the socket when
> another session has the same session ID. Otherwise it returns the
> session, whichever tunnel it belongs to. As of now, a session command
> that names the wrong tunnel acts on a session of another tunnel, and a
> PPPoL2TP socket for a second L2TPv3 tunnel fails with EEXIST, because it
> finds session 0 of the first tunnel.
> 
> The issue can be reproduced with:
> 
>     ip l2tp add tunnel tunnel_id 3 peer_tunnel_id 3 encap udp \
>         local 127.0.0.1 remote 127.0.0.1 udp_sport 5003 udp_dport 6003
>     ip l2tp add tunnel tunnel_id 4 peer_tunnel_id 4 encap udp \
>         local 127.0.0.1 remote 127.0.0.1 udp_sport 5004 udp_dport 6004
>     ip l2tp add session tunnel_id 3 session_id 7 peer_session_id 7
>     ip l2tp del session tunnel_id 4 session_id 7
>     ip l2tp show session
> 
> Before that commit, the delete fails with "No such device", and session
> 7 of tunnel 3 is still listed. After that commit, the delete succeeds,
> and session 7 of tunnel 3 is gone.
> 
> This patch will make l2tp_session_get() return NULL when the L2TPv3
> session it finds does not belong to the given socket. The receive path
> calls l2tp_v3_session_get() directly and is not changed.
> 

Acked-by: Guillaume Nault <gnault@redhat.com>

