Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D64C439346
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536093; cv=pass; b=IczPvAt8VtCOfLvjT0II9ZipvNxmzSXbthTkhL9GR/zLhw9eaAzJ86H7zli+cEehFczEvnxUEZxCksJRfySLqrKPs4U0xzpB848my4Y26F5EmoetIHW7Ug/a9cEQOXJF+SwSO2LDjyqV/1SEvVbYwXK28LEz3P9sChGkKebMVY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536093; c=relaxed/simple;
	bh=D7kEfX+CI2RqSJkgfysboNExrgMP90EA7UnWjJT1PY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5QzsRiPtR0smveUDI1VuUyVnVfY9ddQlfeKbI3jE3h1LVy44yDdNwaj2ffNwjjQbQk5b6zQrmH6dnJjTA17WPPaOlNW81RBF+eJiYT3kvu253rWuQPdexm5rZ9AO7WbqX6jYUsBFeQPoFdEfihxcWn+R9ZJfg3gRPTzXxeeKE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cW4MkwPZ; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cW4MkwPZ"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-934944f2d22so61769785a.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 05:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786536091; cv=none;
        d=google.com; s=arc-20260327;
        b=FmhZ852dLk4Xb5RduNe5WAgYojwaMIT8EPuux9UWw+gBjZBWgytDk/Mw5UlM4s1TqS
         9gHrg11WDs2gwvZoaiyF4I/KbLy8/DjrGb7hNk/5l4m1c05TbwWgab4NriDcGtyjp6Am
         6jSFMiTamyaCOq0wPDalViP+pdphHqTtEvmj/A3tTciMyFm9iIxpgwEGBS2AMCXseV48
         zQbf3mz4OUgobb+RuRQyPqzD+AhaMoyA7TWY2FRfpbHe9cqBVuOcFArW+3pME4ThHWe9
         CJL+zFs9c/J7oc49cVlOnGWDOzFq51yEiJlNwrQ02DuPTyJ49Het3Et8+jKfen/CyOKR
         z9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cvf99OK4rBI6XZDfh37Cy8Z/E6HsnQMat1Bf8688DNI=;
        fh=eL94fSb/nqqm3kJjC1knKUO9G1BgCEcBb86k68wbxOw=;
        b=MGWY2ytbuCrU/uu6fn7LIDKJLbhts4YLQiYQEqcURN1JcNMoqpu2+EO61ZC3Hx78/Y
         NML5z+K9Kk/Jcbk3KH6qxgkd0tJZsrdWEkFM/b5e7X2qybMtbEMkURpb33ql09p1FD9u
         n55LnwuvQybIlPE+HAB4qcBhNCMWdWm3gyk81cvDGqm3cts2aQxOa7CUMzpjoeRKNGxM
         TRoabo6kwhgCXXmAU4o/jDCT653sy0j6FdTsCt3WcoC5pxLUIwMYD38iYf77DfoxBeoQ
         1+7LsljQnZZSxdiiSUYAb1Lynqxr9nWXDZ1xRj2cHOF8adzeRv5h4iJQtEtf1UzQGltq
         GllA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786536091; x=1787140891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cvf99OK4rBI6XZDfh37Cy8Z/E6HsnQMat1Bf8688DNI=;
        b=cW4MkwPZ9qWDrJ5aVs3c12qUQGCcuCPFwmUTcftkZfp3tT4uCmn4MMtS/4ncj3Oc5R
         v9D4sZBBtP4HKjmhjVez32sCU45d3HdhXZmlUVTIU2QammidYYPzV/7hIFCLv1d3m9od
         YbUnnbBJH6PTIVRuz39yRGRriKIR3kDGScq/3YACZjp8Cgk9yT2KcYmjV2hDEy9N7ZbN
         mFGzg334THg1nWFrrObTYnNq7uvpq56xMS0c/k2sH6SEMlpx91yrzFgfJUJK5TNI+rgA
         1d/fAn2FumZt+ASDXo+tKed6xEbqCgsyjVOEoX5/wRwRt4trcGjjW8/alY2u2KgSy5Ut
         dAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786536091; x=1787140891;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cvf99OK4rBI6XZDfh37Cy8Z/E6HsnQMat1Bf8688DNI=;
        b=B2po3jYyZUKJ1b3gJQ8VcsV95SdUroTIwcuRHrJXExp7S9M+EA/bQZKR8/dFkPrKM8
         3cCG92gko1GxkOQ351XWQBGjRA+mNM4u1ESkD7TA70igThw5ue1hkkjh8x0UwEY6oYZa
         YVeddptxpGgl/2YkIWlMVAPTZHfCgR/maDbwW7ypNgZIhQrdxOTHxNQZhhL8RSHO6elJ
         w45mTK2E2l39tV/EYTKS9yfPXo99m8cuuGWrsu9FGeENiapM8NMQB65Rm6Lu0sViBwqF
         pg81LsU7gSv+PlH/qBM84JjDiIDvcr/Vep5wXBlta2ftuYZEKdvz9hSarJOd5s0oCqEC
         rgRg==
X-Forwarded-Encrypted: i=1; AHgh+RriLX70R3d+m/zrDAzREZTvDaNgQymPPrwSRHkMYM+q2DDfQmud0dgpA8Lq/obWIjQX7TU7nD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuFZv7bbuWf6ZBOjnXFqIi7/JW1iJWEdFh/2xTu7j16+3pWF28
	otMnBt0f7Mm1VkNQXT7S1PJch8/Z3YqUgquvb181flFrYFNC2ypNjUNc3u2Ypek9RNG+yQJ24iO
	ffpCAa3qyrzf9PIKv68FzpvfG7WUAXdlutAYbQGFi
X-Gm-Gg: AR+sD11bCYkva/z2o2idw1erSGBcg4rgcSYyILCzJDvvaBw00FbZkR7QwZEGDr9Zc5S
	TI1XZMKyZ6X8M4RftrajXgM6Zo0Hn2waLu01pnMFI94B1178ptbGgIg+9PVqBBfZy4hEdSO0E3e
	CTyZCQ/8GG/0xHrMD//iAtD7rBMn417E0OisRsMOGyrvAtFdrBCOyfAP9OmQtQpi+qb+ISWMzuj
	e+HcHB9erMGy77f0Yeh6B3yMfIyhhLXx87oEpbZ4kuFXhvvZ/GWl4ndog3AWvqPA8GY5QtFPhK9
	4kzrYal7raO6jqIvFkzN2i0ou28jLyc2NrVvpDpxtTRHsSkEiPJCj0u2Co2V7XuNvZf5ovf0aZE
	J5kW0pAKDA6umxdVoCnGCP4c8mNGEFnzEVWi5HCZRQKtmZykQC5XclpOt16b6HKf8EDM5lmeU2v
	djUkEdIoysuyhtI40WHjaRm4+AB7o3Lts=
X-Received: by 2002:ac8:5a84:0:b0:51c:1e69:bcc9 with SMTP id
 d75a77b69052e-52d6471a403mr36706331cf.12.1786536090346; Wed, 12 Aug 2026
 05:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811195405.3979177-1-almasrymina@google.com> <20260811195405.3979177-2-almasrymina@google.com>
In-Reply-To: <20260811195405.3979177-2-almasrymina@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Aug 2026 14:01:14 +0200
X-Gm-Features: AUfX_mz7QZg_MXfNPlHeaggI6iIPiI9ZV-uzSis-gDFX8kzcAPhT2PwlsYdsuuE
Message-ID: <CANn89iJ=CAaqT94xGWgaxcZHhcMVQmy7=0B3fmW4mjKUz1DjoQ@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] net: tcp: block standard payload injection
 into devmem skbs
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dev@openvswitch.org, 
	"David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Florian Westphal <fw@strlen.de>, Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 9:54=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> Protect tcp_sendmsg_locked() from mistakenly appending non-zerocopy
> page fragments to unreadable devmem skbs. Create a new segment instead.
>
> Fixes: bd61848900bff ("net: devmem: Implement TX path")
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  net/ipv4/tcp.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 455441f1b6949..186a36c698798 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1278,6 +1278,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct msg=
hdr *msg, size_t size)
>                 if (copy > msg_data_left(msg))
>                         copy =3D msg_data_left(msg);
>
> +               if (zc !=3D MSG_ZEROCOPY && unlikely(!skb_frags_readable(=
skb))) {

This seems wrong, as @binding could be NULL or not ?
Also testing the condition right after a fresh skb was allocated is
adding unecessary cost.

> +                       tcp_mark_push(tp, skb);
> +                       goto new_segment;
> +               }
> +
>                 if (zc =3D=3D 0) {
>                         bool merge =3D true;
>                         int i =3D skb_shinfo(skb)->nr_frags;
> --
> 2.55.0.679.g6767b8d81c-goog
>

What about instead:

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 455441f1b694904172cfa1d8e7bac7076b60cb24..b4237d0e994d6f9d754d2167023=
e3981a40b58f4
100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1240,7 +1240,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct
msghdr *msg, size_t size)

                trace_tcp_sendmsg_locked(sk, msg, skb, size_goal);

-               if (copy <=3D 0 || !tcp_skb_can_collapse_to(skb)) {
+               if (copy <=3D 0 || !tcp_skb_can_collapse_to(skb) ||
+                   unlikely(skb_frags_readable(skb) !=3D !binding)) {
                        bool first_skb;

 new_segment:
