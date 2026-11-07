Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794038906;
	b=V1moCjjLpv+qiPBGUMFfPd8S4q1flo4UYuvWfi8gQslNCDmy1loT8wsBABmE4oxgdNp0
	 j3YtirN7HCA2f15/MCJQxwuRnF5z5ypuF4TWDPoHQNZmqOhoAzABSS2ORZ+d2kwvkCCCz
	 bmt1NaK3KQKX5W/hWpkLT4QOfLeMKlALMZMWZjyhNEde39cSs9LoPUqPRVDnu6DC9cPW7
	 aD7ZZAqOEwjVhTW6NFzmmbOCVi2BoPsKn5FmSChExI+gAVsORKYmQ3e1AfXj2eTFA5Owe
	 Q7kDbzKGneh3EyXaPpRc3P06S0ezRTjYyvfTbXfYzi2WZQMjlXZ5gSKn1mDEhb5CuyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794038906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ezL4r4ua1RBFqrJXqddrPEFW/yvPOGvhTPdO31bBmUg=;
	b=Ft4fhYHj7pYp7KKn5T9cHNJtWIjIJxlJx4WWKHFWrVDCRHU4PRgFDvodYBKixh5/6APg
	 Xa16AczOjRepXatmtGQn/EtJafNhBWSIcx/gcph4Lk2ldjcvVBznXmBouuP7FytTSO3xG
	 s+CEaSxclJZ6XJDlNvVvwUdkEeQJp0zKJx6uMukwbRnBqruJm4pW5YWEAJPW3lpWo8VCt
	 28dN+753H+vJhKIqy7N//YAX2wVKOHWnTx1UlWwgjWC3WKZQ+/qLNB8COgUVdpa3DxcuP
	 ieNGHx+8HKwVj5ZqSorIvgGBFC4N9Q2N+hRW3r4flUhxO5t0e+Nwx2HFbajF8KE++lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="VE/wXq0Z";
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04F0606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 08:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E04F0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VE/wXq0Z
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a59717b0c0so960551b3a.3
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 00:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794038905; x=1794643705; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ezL4r4ua1RBFqrJXqddrPEFW/yvPOGvhTPdO31bBmUg=;
        b=VE/wXq0ZVwPv54UL4lC9s8hULEmpup18q2VZe/7rDzgYDYPXuz0kATpJ2ES3yvotp4
         mHFlY3HkRHEKHh7KPu7AtAvhxZko5Z7ZSnts7+Njo3jaKwvhxLuOaUVOmKhReZeCVh6h
         m8ZLyDoPzSziLhxtspbC74w6yWxMcFxv/QUp9i0HUtTX5urp18aUPKwLZkerhTlBV9Ur
         XVHTKWyU/yUWGR3fVjDYRetqz2By6TKyWyt0cNFhKP2Q0fbkLdD1Cp4/DsBsHb441GK+
         t48PHH/QDxthjUJQSD+aqaYFv6qg26VWAORqjkbBxCJSu0QWf/BYSPuocdON7ALFdiqE
         uulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794038905; x=1794643705;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ezL4r4ua1RBFqrJXqddrPEFW/yvPOGvhTPdO31bBmUg=;
        b=xj1yF1vtlOCrbFmhu1d+VPwA31quURdF5L7l0hU8H64FFWRZ01NMmVUKoWz5ilwLtu
         CvSIjxKqgWtIWF1nnjMxFvSxC+Fl1cvt1cEvuTJze32yvfbrsd/A+iBTvmTIqFmbKoKK
         hlVsMDfnTbHhNktCAajAi6tvuALgbL/qqACEihgnsS+KrgXf9gZKbfVMHy7bRvEKGuhp
         EU/5RscGDR0s62mbkXZpjqyktuROI1MGxhzE8pBdbuCyjZr2xfKTdScqrwrPyLzACGBv
         GNYXDHdwnOpH2A34ePMq3nUiLAyXZLY0knFmIvWXmjxq5Eh72bQ4NkVLALnT5jiEUBiX
         IIJQ==
X-Forwarded-Encrypted: i=1; AL+hErEAnKQ+UqeCFBbG5vsVU2RvgveGyvkB86oPBjtCS2W3BA/h+V6iFDhWnM3fhphGiNVmB3hB10s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+txRSR4FikSyFqjPYElNWgdkMW3cyE4Jv4DaGeJ3bXTL/Lxxz
	EvmnTkztDdA1sSkM20/6k4iPzTsYTGUH21UUYqKHZXdsVjQy4azBByA4uHgZ6wl2rpRxPaRimAw
	600Y+/Q==
X-Received: from pffh14-n2.prod.google.com ([2002:a05:6a00:c24e:20b0:891:240a:3bb3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:180a:b0:882:2b16:c314
 with SMTP id d2e1a72fcca58-8b37c52ff35mr4860050b3a.52.1794038904784; Sat, 07
 Nov 2026 00:08:24 -0800 (PST)
Date: Sat, 7 Nov 2026 08:08:24 +0000
In-Reply-To: <20261106201822.1734-1-lirongqing@baidu.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106201822.1734-1-lirongqing@baidu.com>
Message-ID: <au7bGHqwhXXttXH_@google.com>
Subject: Re: [PATCH] af_unix: Fix wrong socket tested in the symmetric half of unix_state_lock_cmp_fn().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: lirongqing <lirongqing@baidu.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

> [PATCH] af_unix: Fix wrong socket tested in the symmetric half

This is net-next material, so it should be

  [PATCH net-next vX] af_unix: ...

see Documentation/process/maintainer-netdev.rst.


On Sat, 07 Nov 2026 04:18:22 +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> The second half of unix_state_lock_cmp_fn() is meant to mirror the
> first one with the roles of a and b swapped, but it switches on b's
> state again:
> 
> 	if (b->sk.sk_state == TCP_LISTEN) {
> 		switch (b->sk.sk_state) {
> 		case TCP_CLOSE:
> 		case TCP_ESTABLISHED:
> 			return 1;
> 
> The enclosing if already established that b is TCP_LISTEN, so the
> switch can only reach the default label and the branch always returns
> 0, "no order known", instead of the intended 1.
> 
> Test a's state, as the first half does.  The code is only compiled with
> CONFIG_PROVE_LOCKING, so there is no runtime memory-safety impact; the
> effect is that lockdep cannot validate this nesting order of
> unix_state_lock().
> 
> Fixes: 98f706de445b ("af_unix: Define locking order for U_LOCK_SECOND in unix_stream_connect().")

Please drop the tag.

As commented, the branch never hits and no real issue exists,
not worth backporting.


> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  net/unix/af_unix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index e7a0582..501e693 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -163,7 +163,7 @@ static int unix_state_lock_cmp_fn(const struct lockdep_map *_a,
>  
>  	/* Should never happen.  Just to be symmetric. */
>  	if (b->sk.sk_state == TCP_LISTEN) {
> -		switch (b->sk.sk_state) {
> +		switch (a->sk.sk_state) {
>  		case TCP_CLOSE:
>  		case TCP_ESTABLISHED:
>  			return 1;
> -- 
> 2.9.4
> 
