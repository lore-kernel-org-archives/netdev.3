Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7763F3AA187
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 01:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791856116; cv=pass; b=VTdKwlgPxBzyw5KMAsqFT1wb53qD0ZemiK+Nz+4OX0oY9SiHXnUkJ7M6YZs1kNbx9NfayeIH9O6G+Z7v/rxQ8OdDN8s8YwhfTieNQRdBUPQssFkRNcnm7hHvxLAJI6CT3J1usha6Op3vmIcTrLEH1Hp8g9SDA0D11WrHpgytD6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791856116; c=relaxed/simple;
	bh=4IHJ1f+F6bVSBaQKkLY11km9Ol9pfEn82bJjAdkF4dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIEi+8JWJVKUdkdX7D1aM1/CHW16XHERMoMFgTt+I7gORXVJkW93wVAKF5m7DfzrMCxSTZ5VpYNZikQzSGz3JXj5vVrgSlXekWtvySeX8t+gMqy10gIOqvbAEz+JP6ssipuClIwj9lbJemmEgylM0RGR/Fp59PYrdTY5F6jg0pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MvM89sZJ; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MvM89sZJ"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-16079d54c17so2933921c88.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791856114; cv=none;
        d=google.com; s=arc-20260327;
        b=UvCxyFNC5RdeJXuCeJLzPcpjSnLNDt02IjVioWo9PUh2Xjx9vGe2ZgQxKAXVad/dAI
         olpEzkoicLLZBLQIwvbN+kEaP+OOJwLKhRYC9ai2QcpkxVgohGAhbBgkFdOgQ9l9rKTx
         4Fbm2jmFhmKcJKspnKosGW3W5RneJtmN7c87lYSGtbd5nsBltzE6KfJOsiHiqOCpZ4qt
         x4T91anX8zFH0jWKOE52+rflwkiZR/R1C6odhV1jEJUu4Dmy7kLVgx5/cg0GP8R4Rnco
         EGGchjMu7A04BqkvBuz2XwAanrB+FDzG/CeU9Gj++Fm9PLkgnFP0kepzjxPuddWcvsLM
         X/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WwlGR1wR036AjYZy2y39FgAVhGwuJlmWocX1B+EQ2FQ=;
        fh=vLt4gsmOPx0cxrhDmb27e40E5A6NJOGNdNXjNiI5K8Y=;
        b=cZPGl0LvLoHHqBOMX4WsN7Yb0Z+clemSvxvz09y0pkdR6opek5AKDGzeFB5tucTB9V
         lg3L2hcWlm2acLBMPJwTZio9+JSyi6hbUD8GA6k+cjjmhMY11MOx3Ldzy7BggsY8R9DA
         QNNnzRVOEWMSFFUukJFn73gb+WhGfWfujUEjXHgmk0m60KYjCqj9KUi67AjeS8bloOUe
         9wHLDXTmLlva6HYMi5LmB+p2OmdRKlI6b8zQZWkw5bdE2Aj9Po1JUIIBSxe8pLtGSh04
         ClLOadfHU3vfcz4H56OrnemGfJXIUxq7d/TjC94rjw4ow9Pfi5oyYhv+uYq8+h6KC+5e
         UtHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791856114; x=1792460914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WwlGR1wR036AjYZy2y39FgAVhGwuJlmWocX1B+EQ2FQ=;
        b=MvM89sZJa6BPwTI0BYetYfOTERIGMOEFZq5Xcx0Fz7tOOex+/ita6aS327I5mKXZtx
         jI7fmaGLy7oL341IW+cGbY4eeZkFCccdw+n6FJZByD/JZ7PJ2XCxu2IUAY3R7V+idBLS
         EOLWid+ZBgbovTR59jtrcnGyUyMVB02zZrJyk/mnveMPSoQtcfXYOK/WJmmmJfEpXZX4
         Sd0TbeK8qJB9oCQgwcQiXNwwuOAkvd/ukTpDl/Gy6Xz5I9GVU6zorUZxxU0l9L1ZZ7qN
         O39+DMFUD9jgtAoYCGB+4RGTeiODIw+17r9ZC2LlQt+/9b9bvjMvcFzGTB2mjShXNjAo
         503Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791856114; x=1792460914;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WwlGR1wR036AjYZy2y39FgAVhGwuJlmWocX1B+EQ2FQ=;
        b=XFXpQ4zaxySTIPRlMJItkpdbmrC67Vw3n0XG4Ay8gZu0k3aOOSajzAZH5NNFPstl3Y
         IomcvubQrzeZyMxK6Z+Mn31TbLcjKp+vSnl3jCY3q5pmx60v+DhmxfLhrUIRRJiDazFu
         2ybFWeURAlsxGoeKqq3EmWRFoOCksLdgGthRIBDLUw+oegH2YC8m11qy9UyDNaoxepH4
         UlNIFphehxqnlDDoZ7NnF0MK1eN11YKtRX+yq9Tmjx0UGsrjqiP0sQMH8Wktli1zCqkJ
         A7xPzYrmYjVCihIafX8B/VZo4+j6Ws5FZA6Jr4sAjlAYTLUNxHbmVrHCNDxpnGwuOM6S
         W55Q==
X-Forwarded-Encrypted: i=1; AKwUvBwoI8xMeU+hZNMlmXyjJugT5pPgSMdOLYF4tTCiYa3ejA6Fk9ok0voc7hPPACqiY+J7zeVZzK0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRmskreRE68ATL+ROWAFo7e7KucTTS5IKGvZcc7XemZLsHSYwa
	RjhVNu+h7Kmw/aKImQUxjr7islADlQCSAsjc5pb7Mg5SSeEL+HE1i05l5QyRPWTzedTGaBbjKSx
	tpYcSHo3HvEb0oij4rx9xGdAqv4kU/6X1akW95uuFhPFccRZHPX5FM2Y3YSdRPw==
X-Gm-Gg: AYBFou0DG9vDQc6MB3bpomi22Og68ojgueL+hyLgqUUzObQUCh/LWFrPfO5coyqfaMq
	X61GVvQDsANej7ThoqI2+eIYzloEzCNEtLbRQTmYicO0GC57/uphd4QzQHlqOMj6kdw5M5s0MV2
	Ey6LW2RSCNbEiEXcwfAyoR66lW45zMx/wqgVtjYIAKk60yJxU0yq0NrpquN7Wsb0X0xSTCMIIQI
	LDjSngmb+1BNLevRWV5rRjfYt8WDlK0bQSXWxU5HPUYtU5uhIUaln4OywzvsAxSFuJdMBxYeZdg
	3gy81J8r5VGuxLvLmQs6VuBHtz+MiSfPPhgcbgBc2ZTWLa7YCWcLY0n+/iajObJgFndkYaUpwtS
	cVCn2GiFoGobipiVou0kCQYuXUqh4rQmXtrf48NsvF9sv9Fskj3NbdKHYnCScZOnnzQSGfNLuk3
	aNK6z5ty6vvC6uz9q7kbws8Ux/epTpzPP97OjB
X-Received: by 2002:a05:701b:2605:b0:13e:5a50:1e17 with SMTP id
 a92af1059eb24-16a55487e53mr17102214c88.3.1791856113584; Mon, 12 Oct 2026
 18:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008124423.11543-1-parri.andrea@gmail.com>
In-Reply-To: <20261008124423.11543-1-parri.andrea@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 12 Oct 2026 18:48:22 -0700
X-Gm-Features: AclHuK-7HoCf50g6EjGDuv8XPNEzQqvRnf7ogcg-czX0LK7BftACZiwFnu503kM
Message-ID: <CAAVpQUAd4QzUDK1wZYpuHJbMSg+PwAGCcaTzayR40DTNkXdwQA@mail.gmail.com>
Subject: Re: [PATCH net-next] rtnetlink: comment the RCU and SRCU waits in
 unregister paths
To: Andrea Parri <parri.andrea@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 5:44=E2=80=AFAM Andrea Parri <parri.andrea@gmail.com=
> wrote:
>
> rtnl_link_unregister(), rtnl_af_unregister() and rtnl_unregister_all()
> wait for readers before tearing down what those readers use, but most
> of these waits do not say which readers they are waiting for.
>
> A missing wait is then easy to overlook: rtnl_link_unregister() lacked
> its synchronize_rcu() until commit 3b70edea393d ("rtnetlink: wait for
> RCU readers in rtnl_link_unregister()"). Add a comment to each wait
> that lacks one, naming the readers it waits for.
>
> Suggested-by: Eric Dumazet <edumazet@kernel.org>
> Link: https://lore.kernel.org/CAL4WiioFMQN4troVjQjCmE6Z9kwwb95SnoEupjD=3D=
PPSK6Q5f6w@mail.gmail.com
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  net/core/rtnetlink.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 15bffafbf0a9c..80f8577816760 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -526,6 +526,9 @@ void rtnl_unregister_all(int protocol)
>         }
>         rtnl_unlock();
>
> +       /* Wait for rtnl_get_link() callers under RCU that may still
> +        * dereference tab.
> +        */
>         synchronize_net();

More specifically, this only applies to callers before try_module_get().

>
>         kfree(tab);
> @@ -711,6 +714,7 @@ void rtnl_link_unregister(struct rtnl_link_ops *ops)
>          * not yet taken ops->srcu.
>          */
>         synchronize_rcu();
> +       /* Wait for rtnl_link_ops_get() callers to call rtnl_link_ops_put=
(). */
>         synchronize_srcu(&ops->srcu);

I think we don't need comment for srcu as the relation is
clear via the argument.

>         cleanup_srcu_struct(&ops->srcu);
>
> @@ -843,7 +847,11 @@ void rtnl_af_unregister(struct rtnl_af_ops *ops)
>         list_del_rcu(&ops->list);
>         spin_unlock(&rtnl_af_ops_lock);
>
> +       /* Wait for RCU walkers of rtnl_af_ops, including rtnl_af_lookup(=
)
> +        * readers that found ops but have not yet taken ops->srcu.
> +        */

this can be simply /* see rtnl_link_unregister() */ instead of duplicating
comments.

>         synchronize_rcu();
> +       /* Wait for rtnl_af_lookup() callers to call rtnl_af_put(). */

ditto.

>         synchronize_srcu(&ops->srcu);
>         cleanup_srcu_struct(&ops->srcu);
>  }
> --
> 2.53.0
>
