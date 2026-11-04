Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805454;
	b=sYEjEJ/PZw/AMF8YAsj3UBfP9nuyn+ydDwlyToRXzmG1mFaOI6Q/uDgbFmbafz4cnJP7
	 IKQYZjSixWuQYHePNX6SxmU3KDEa6ZKHe9LshjN4b5SnWMRWN6LI6OelJWeEfaobeEZ7P
	 DGeRiigKacggTgZ8hihEBxuytB54oiqxtjgLJ8YT/tz1U33OGVxeIPH7TzHVUbzHEzRh/
	 13CwafFlaBAcHacLMUsbP4W9mP6UQ8zmi2qzMU16WxYsvIf2iVAi58oJ+DsC9wfIwXBrW
	 /nFQjoOpnlF/+VB0mfqmOHBOcN8Q3XgaJUujVlFSg/LNFiMuQEG5VT7MYCLTiHkTEGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=nvhHnUzlcZUczhYTg/v2fPLBpOLZ61h48TU8KHeiVn8=;
	b=Yb898x8swOnpciZ14YdAG+413FlwjGowTvKUSxH/HiECpiLqaZcN78cJxBUOt/XQzp7z
	 S9Aga0HkTWuGI43shaHs1TxCn7N0Oyb17RuKJsPFxp69XUclYuyG9MtQsHRl9RKHn5cWZ
	 N12YKZ9uMKhbi1eqI8yq+NGChzsizfxTwrKNc+turJMJeOWk7maA3kAvOQI69FV/nPWcF
	 QbJ4XhAAd0EojtPJ8LazXs7uDFBMZ5YcQk/0Nvm5i6OpbjjYeiQxr2j5yHIJFfIhhd4PB
	 9KUONJTOBhI10PichgxbJj1luhqLit6CcjP9uUIunljv36tb4VFg5X6WDA2/V8ne91g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y8VWdJi8;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13476606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13476606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y8VWdJi8
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f3c616c84so76514185a.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 07:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793805453; x=1794410253; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nvhHnUzlcZUczhYTg/v2fPLBpOLZ61h48TU8KHeiVn8=;
        b=y8VWdJi8w19RHnscyCPKs6dX/Hf5BsGea33ym1Q2L3fH57oQ0zF0pWQMPsLXCOJO+Z
         lekMV7t+/bSlKG8Gzmwc4IWVjDNc1VWE6ELEP2XYbNe/Xnv/+ryJNDPbRNnjMxpy/y2X
         5qE/ZqPqrLg+q1vus2P+hmsXEHeML9poyemDs8WgH9t5EYi4SHHJWu0b6bUT2giif2GC
         pqNKgK9TLUViHoqKsP1Gh8+g0SetnU6bVSL0lu2nBjmtaY7R+WbrvqraDo/3K0XZ74ai
         +ma1Av1d3yVE3N717+l6PspoqJI/PT3JnznFQ6yyMXuuAyKkGzX3Oii9qqNL1SRY10cB
         VsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793805453; x=1794410253;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nvhHnUzlcZUczhYTg/v2fPLBpOLZ61h48TU8KHeiVn8=;
        b=dNdOewjc4AxTK14MxSBFPbAdnaS1ahAdw3+W5Tlt3yHleFn8jdr9y/6pBXDsabp7dC
         4fOjDlHgp5tCp1QGpEvd7DLF7aRjNarqQ+TOkXEm3vvplVsywtfo+3eaPROcKF6PUwhO
         ct2NSHDU19bbIf/AnBXeSErtajbOcBBcsq067kLcRS0PgPUzuljw71ClVtE67wMNjSZI
         Bkwc+nyx/+yOePC/i1l8a0UuQzMCK5XhtfvHmwsCIe2j2J28yAgp9H0Ni8KmQQlIbwlr
         PVse0gfkvIFBE215lhXPGoBdOrfiEE3sATUyJFiDhv/B1hMog88IB1q97gORDN+LWDtv
         ev6A==
X-Forwarded-Encrypted: i=1; AKwUvByniR5DVZ3S+sgJHtaiUCSIUSgofPsOux/NrtClWMPfo+iwDpEaCP8DeUW4VCO7GJzGb7F8WXE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BTX+bBGlUdI6bVgV+xoe6gkFATQJ0WFdZ5s2ZJr+2iU838cVo
	b2EM4TABfDNWr1rlD4ge4+FDENpdS4sUrdyTuuz+6Nwrt/nxQmxvz8MT
X-Gm-Gg: AYBFou3nOxTXEhftoqq9bmab/V0tLG7azhPZyq5UNkrIwG63BSDxltpG8fCYZzz74b5
	RHsuyvZKrIH3bhHrXdV8XgZylzYgV217zH8xJrl4f1DMIEmwUi9M2fUWEpcRYRtAihkn2GB3PCj
	em3fAhoudfdMO7X233ljwBQxQ4v8YoVip2p3FZwLO+GrSqIlgcv6Q82cpntlKSYfJE7BF+46dlb
	Oz7b5C2ZqkzoauI5MxaKyW56xQCEPnPFb1xV3rroGS412n+LYP+wTkSH38PUaDv10rYPLnQxsr9
	+sKvuloWgThxi1PEN5jPMfs2bYKG5GDTltfKq8o8fpzpDqh8C0CxAyCmO/E0PWGPmIKNKgzjDs+
	yMf72d28IVEXFd3FtPFKbyPKLZmMoYf0fAegc9e22sbqGHK46zWpRAMBMzeqqJonfKSIkVCE+9y
	VIJt8YhAv//vPIEePCkN3jhHWgZdjjFuFWNvZ0lb12pqMFPjYoYenTkyr7btB8lpkyhAuRzC6HW
	92JzB0g3bVuE6B0TGJfG1iJBLrAIeedYoQ0F+qA1au83dJIeTC7TMo8visET4Xjocygz4vBWASZ
	19cr75ME+wfmP+hg
X-Received: by 2002:a05:620a:17a4:b0:92e:bc28:5479 with SMTP id af79cd13be357-944214d169fmr2878280885a.2.1793805452862;
        Wed, 04 Nov 2026 07:17:32 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::5:7adf])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d481f90bsm221328685a.22.2026.11.04.07.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 07:17:32 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 10:17:31 -0500
Message-Id: <DMMIYO3E9XF8.3JATGNVBKS9HE@gmail.com>
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>, "Eric Dumazet"
 <edumazet@kernel.org>, "Neal Cardwell" <ncardwell@google.com>, "Daniel
 Zahka" <daniel.zahka@gmail.com>, "Willem de Bruijn"
 <willemdebruijn.kernel@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>
Cc: "David Ahern" <dsahern@kernel.org>, "Ido Schimmel" <idosch@nvidia.com>,
 "Simon Horman" <horms@kernel.org>, "Thaison Phan" <thaisonphan@google.com>,
 "Kuniyuki Iwashima" <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 1/2] psp: Check pas->tx.spi in
 psp_sk_overhead().
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261103000712.658501-1-kuniyu@google.com>
 <20261103000712.658501-2-kuniyu@google.com>
In-Reply-To: <20261103000712.658501-2-kuniyu@google.com>

On Mon Nov 2, 2026 at 7:06 PM EST, Kuniyuki Iwashima wrote:
> The next patch moves psp_sk_overhead(sk) from icsk->icsk_ext_hdr_len
> to __tcp_mtu_to_mss() and tcp_mss_to_mtu(), which can be called
> between psp_sock_assoc_set_rx() and psp_sock_set_tx_key() while Tx
> packets are still sent in cleartext.
>
> Currently, psp_sk_overhead() only checks if sk->psp_assoc is set,
> and even without the next patch, if ipv6_update_options() is called
> between psp_sock_assoc_set_rx() and psp_sock_set_tx_key(),
> psp_sk_overhead(sk) is added to icsk->icsk_ext_hdr_len twice.
>
> Let's check pas->tx.spi in psp_sk_overhead().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> not worth backporting, no one does that, only theoretical issue.
> ---
>  include/net/psp/functions.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
> index b23c30898389..410adb6718c1 100644
> --- a/include/net/psp/functions.h
> +++ b/include/net/psp/functions.h
> @@ -145,9 +145,9 @@ static inline struct psp_assoc *psp_skb_get_assoc_rcu=
(struct sk_buff *skb)
>  static inline unsigned int psp_sk_overhead(const struct sock *sk)
>  {
>  	int psp_encap =3D sizeof(struct udphdr) + PSP_HDR_SIZE + PSP_TRL_SIZE;
> -	bool has_psp =3D rcu_access_pointer(sk->psp_assoc);
> +	struct psp_assoc *pas =3D psp_sk_assoc(sk);
> =20
> -	return has_psp ? psp_encap : 0;
> +	return pas && pas->tx.spi ? psp_encap : 0;
>  }
>  #else
>  static inline void psp_sk_assoc_free(struct sock *sk) { }

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
