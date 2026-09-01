Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D5C2C027F
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262698; cv=none; b=fxhyiawQmizkP7Oa+tIHDuX7SvK3elEzhZC1myBpLYhLOxLVUCtF5SiAh1xCVioARwIVKD7cSBimxnfY2+yHx7Mjf+u5phPgxkOv6Z3xvw3o/ekVjKCbo+AEO5kR3Btw1dqea9RYw30ZrMk6tSVvjTxa0MvpKTeFnwvkpktnV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262698; c=relaxed/simple;
	bh=0LPJ3gNCUMhazWYgfM/tuASrVOq7Dvtjc39aXza18FE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l5QcUbUAI8vCUq99EUUQs98Mj2hxjIurtie6wFFi+r3SFcXeql1DsRbmz9Su/b5Vo+9Tp38vcla1dQAwo2pZxNMSzlYnF6dEwwAp1UUB9hLlG+g42FzxsoUCVujo/eI5OI5nISu11yInCq29oHI3eYhvuBKqKcsk3vfgHW4LFok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Grux3S2P; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Grux3S2P"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2531f453eeso709955166b.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 04:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1788262695; x=1788867495; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rSI92hHTRfmyBMxAiMEFkgT8B8UyDSnNTgFwgpfOkB8=;
        b=Grux3S2PJ2wb3W7EJnRcO78h2iaS1vxeAbr2k06+rz/p/+JOv4Xp5puNWb9ujr4ZZJ
         YoB1lU6kwiX/0FAjVKtF5s8sPfxYYzWDfu3Xt54h9gcY245tC/1/zP6D4AMiEQiQI+ph
         Ntb4fIgSgQTQz2OSCyJhpfU4BsUoOlXsBU1NMSIKLqVGib0he1/kLc89sjL5emYAAimJ
         KZHBupxjYL4aM//0xPOEWWdS+3PnY0JynOqlcOSWT1S5Dv92oFCp/gQdao5Sfb+Xi7/P
         21JiiytVXKAV2w5fkl5R1KtKHq4tKM4FQ4BK1GQMpwTpnkFqKUKBSqOrOLFhHVtzkQUn
         G6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788262695; x=1788867495;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rSI92hHTRfmyBMxAiMEFkgT8B8UyDSnNTgFwgpfOkB8=;
        b=QMiDKlkEKBNFzV4jjTN/CDddj5qgHFcTIY75hvPHOpjlWmt3H794G4sMiUpiTaZHfT
         X8YVj1501Pg6Imogp/RpQRmPtS7EuYz5zmzaCdombfkRGlLleWgQ8jVM97NAWnHn3eD7
         WfOPChwkJHezAiBRyVYGVyCZrsPHUQ34lPus5b6O7h8xSJc201tC+ZC7KlqyMpJjVKCU
         zn3337yBMvowWOlh9f9WoUWTcHOkhJi4+Qsr3qkU4QKrOKZbJq21CyFcvTQsAFBppIyE
         ald06fZURMJIP9KUET7JIJywHWelVeEMPNOof8+CgrwPQ29OzKQjRX2nHjqNewExO3Xp
         iaMQ==
X-Forwarded-Encrypted: i=1; AHgh+RpPT19ipW0WtBRJGB+U6LA1H3aHtlcYynsRAHmgaASbC4t0XipZyrzCnUD2lYOlvWemDdWp3J4=@vger.kernel.org
X-Gm-Message-State: AFuF++klX53Z9hDnYs2c/utaLdro4b4+C+1M4f78gdCIpSH7goQyWeqR
	Ot6jvjx4DHUG8bOfKhqEGXNxuG/1kMOuiSCq5I8xQ0iWoDpJtk2Y9oYXyV35itHCCSY=
X-Gm-Gg: AR+sD133oVEsCZ+Q9LdiBOlLjM6Ej8LwgNPsmp8Rnld7pXsY+StFMusv0cNM89qyVzU
	dRUtOmQNm0wvcClph8WCN99pe2hvsXXLahVAPzGBG4/WN4AYqOwbBzNkbIo/p/sOUAeVQual9LC
	Y/74YBf9yF+nyo9th2km++YKh7LBZEAYJ+sTge8DMXg8y8eH/bIjXwTxFqzK2PpMcfXsBRAOy6a
	sv26BCewrZgktdcOeWirrAxoN4LcpLNDlNtDHyLtpyIb43Bh2lHnmT+5/a4KhIYA81V09Pe32Zg
	lMGW5IrUby5PxY8WoHD9xNU7LIGX1XN7Oyd7X7ns1zPJSYOkkqOs+6dJw/QwjNng/MjRDancIje
	4wXSPfSVS0B2hpVF70XWw3KM5lLVgzRzKOS+3vi+IfThuE/4XrKy9Qmvcvzz5kEQCEQ4To+06vq
	foLWRYXLpHKGtWKud7KUM2u45WX40nG/5pS1KtOk9JBk27ibyYR3vC+mGhOLnUZQ==
X-Received: by 2002:a17:907:7b94:b0:c25:376a:a16f with SMTP id a640c23a62f3a-c25b3bb8c28mr447928566b.5.1788262694794;
        Tue, 01 Sep 2026 04:38:14 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee2851csm577102366b.14.2026.09.01.04.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 04:38:14 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Geliang Tang <geliang@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Geliang Tang <tanggeliang@kylinos.cn>,
  netdev@vger.kernel.org,  bpf@vger.kernel.org
Subject: Re: [PATCH] bpf, sockmap: Fix self-redirect copied_seq double-counting
In-Reply-To: <b840c35fdfdf36e9fddedfa645b12699bc51aa34.1787968065.git.tanggeliang@kylinos.cn>
	(Geliang Tang's message of "Sat, 29 Aug 2026 10:00:12 +0800")
References: <b840c35fdfdf36e9fddedfa645b12699bc51aa34.1787968065.git.tanggeliang@kylinos.cn>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 01 Sep 2026 13:38:13 +0200
Message-ID: <87wlt52od6.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Aug 29, 2026 at 10:00 AM +08, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> When a BPF stream_verdict program redirects an skb back to the same
> socket (self-redirect with BPF_F_INGRESS), sk_psock_verdict_apply()
> calls tcp_eat_skb() which advances tcp_sk->copied_seq. However, the
> skb is then delivered to the socket's psock ingress queue and later
> read by tcp_bpf_recvmsg_parser(), which also advances copied_seq via
> the copied_from_self accounting path. This double-counting causes
> copied_seq to advance by 2x the actual data length, triggering:
>
>   TCP recvmsg seq # bug 2: copied BF2E806, seq BF2E7FD, \
> 			   rcvnxt BF2E806, fl 0
>   WARNING: net/ipv4/tcp.c:2745 at tcp_recvmsg_locked+0x72b/0x2640
>   Call Trace:
>    tcp_recvmsg+0x10a/0x500
>    sock_recvmsg+0x168/0x1d0
>    __sys_recvfrom+0x19a/0x2a0
>    __x64_sys_recvfrom+0xe4/0x1f0
>    do_syscall_64+0xf7/0x530
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>   cleanup rbuf bug: copied BF2E806 seq BF2E806 rcvnxt BF2E806
>   WARNING: net/ipv4/tcp.c:1609 at tcp_cleanup_rbuf+0xf2/0x1c0
>   Call Trace:
>    tcp_recvmsg_locked+0x8d1/0x2640
>    tcp_recvmsg+0x10a/0x500
>    sock_recvmsg+0x168/0x1d0
>    __sys_recvfrom+0x19a/0x2a0
>    __x64_sys_recvfrom+0xe4/0x1f0
>    do_syscall_64+0xf7/0x530
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fix this by checking if the redirect destination is the same socket.
> For self-redirect (dst == psock->sk), skip tcp_eat_skb() since the
> copied_seq will be advanced when the data is actually read from the
> ingress queue. For cross-socket redirects, tcp_eat_skb() is still
> needed to account for data leaving the source socket.
>
> Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> Hi,
>
> I encountered this while adding MPTCP BPF sockmap support. The existing
> TCP sockmap selftests don't cover self-redirect, but the MPTCP tests do,
> exposing this latent issue.
>
> With this fix, both TCP and MPTCP tests pass, validating self-redirect
> functionality.
> ---
>  net/core/skmsg.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 2521b643fa05..5fa7b9639eef 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1039,10 +1039,14 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
>  				goto out_free;
>  		}
>  		break;
> -	case __SK_REDIRECT:
> -		tcp_eat_skb(psock->sk, skb);
> +	case __SK_REDIRECT: {
> +		struct sock *dst = skb_bpf_redirect_fetch(skb);
> +
> +		if (dst != psock->sk)
> +			tcp_eat_skb(psock->sk, skb);
>  		err = sk_psock_skb_redirect(psock, skb);
>  		break;
> +	}
>  	case __SK_DROP:
>  	default:
>  out_free:

Isn't the source of problem on the read-side (tcp_bpf_recvmsg_parser)?

We should be advancing copied_seq only for skbs that we received from
the tcp stack. That's why we have the copied_from_self detection in
tcp_bpf_recvmsg_parser.

I think the problem is that we set msg->sk when we call
sk_psock_skb_ingress_self from sk_psock_skb_ingress, so on SK_REDIRECT
path, not the SK_PASS path.

REDIRECT-to-self should really be a PASS, see [1]. My suggestion - fixup
the verdict:

        if (verdict == __SK_REDIRECT && skb->sk == psock->sk)
                verdict = __SK_PASS;

Then we can remove the sk_psock_skb_ingress_self call from
sk_psock_skb_ingress, and kill take_ref param in
sk_psock_skb_ingress_enqueue.

John, Jiayuan, thoughts?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2443ca66676d50a4eb3305c236bccd84a9828ce2

