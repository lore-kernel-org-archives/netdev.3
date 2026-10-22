Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661290;
	b=bhJx1EkeGvz5bAWMjSoGWTCDCwMn+eAm5v2SjPCwwu7Z/tQTnMWIYssScei9GQT2T9oN
	 z0ThXgFyB0ZGLy8UlzXkM4zAAnp3oOzHy291ecwRmiKKZFBzv5u3rY3W6LY2PgFEQIzJ6
	 QWTCsAbhCW2lC6kPtanUZCKUYQ9yH05JhtBgwSCCdMtTKrPPnGSl6o9LWzolwmcdq7N0L
	 OLaHaCfeYfHUZloC7q61M7okGF0gbI0q//ci7KaUCmOkAhGZtyfbRJUHQvIe7jKP3xQgS
	 qP9BnpCLFBRo6Gmik7SZj4u8EKf3WL4HtPCemVefnQNyX+mQfICjT/sjW1aDtiKsEYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661290;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=b16AqzWrmx6PCjjmVkdtVIc26QQOCuhEY/Lbc4sfw0A=;
	b=5tB+qpMqT6dNqlN/QFmK/hE43L5VIZK0ErlajBai7oz0BUVHla1PLjMPHbSWElYtJPcg
	 GaUqcRVo/3jh/VNSos/xhANryPnn7LCIlUc+drd1SCs3G15TURZ0djcU5zHdejgCNe5e9
	 7H/2bS7i7eQrNK4/8TRS2f3aOmKdqKyqW0k06U/kJOy9C0zzu1Tl5lIf9w/+clxDRB3Ls
	 IUZUH0Ye/DJ2WGsX0QMr/UNE/8jAYdeSOZNZ5fY8ESkqZI6e1ZD99rDQQWO3xdeaTNQHi
	 cISVV6Z5SrblZThqcBUZmZ+AArZ2t/rH0or25YU1FK7v0eOuITa8AgjyjpvYZUp4Lbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dTGPpB2y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1EC606A324
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dTGPpB2y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A891F000C2
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792661290;
	bh=b16AqzWrmx6PCjjmVkdtVIc26QQOCuhEY/Lbc4sfw0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dTGPpB2yuOtIRTiVRcSqefJbTmZDIzw2DXMa/Te82wylzlryq+uHX6Dw6UGlNUrB1
	 o2k8VB0bGsLf1c0WpRuCEv50CCKqa64IEkYw3RpQ3IA1mAuqnrN0VYZjpytvK/sxor
	 C5zVoJd4M48lVV48WCX8f5wBSeo5rk878wPUYGsYqEeINlKaFGKLv9O9J31OcrTcLE
	 GqUm6YAESSVuRG+WY6SWKQTaFztUbMNq5TcJvfaRghhk+aTgd8aBWIjtxt45MHteEw
	 nSiRN2EO8tcaDwR8XqvwM63yZOUT83MS5xZZUL8yRHeHI9e2H1p4dkibZ8siY18+ql
	 cmjnbDaMgXifQ==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-48e2d5a69c4so846021fac.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:28:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy62a9cPaTUNJyaWe1HjJU6nq9CM6PWZsxUZTkzHv/IYlP/OajFXMwJgw6/sXN+ofgOW1xIJqo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKesgot8+ClHWWYSOWGEfDv+8y9LK44hqmTVLCjbmFNMrJMsJjo
	kgaINOTeKv/e6e9wYoDnKmLrUSvE0sW2eJvGTglLaeqYKlWAUh0E87bTpb2m596WAuKSaQEe1iD
	ZCcfRjvZr/NHESP0kXS34DMWCzGMsTLU=
X-Received: by 2002:a05:6871:6681:b0:49d:c3f6:4191 with SMTP id
 586e51a60fabf-4a7dc15cb9emr2583880fac.18.1792661289186; Thu, 22 Oct 2026
 02:28:09 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022090431.3641707-1-teel4res@gmail.com>
In-Reply-To: <20261022090431.3641707-1-teel4res@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 22 Oct 2026 11:27:57 +0200
X-Gmail-Original-Message-ID: <CAL4Wiip9-oGNjrgQV-VSkDR_hfq35d_+ymX_itYk29u9scY=Mg@mail.gmail.com>
X-Gm-Features: AclHuK-mJUESD7RYwjo_wmXzNyLsWvwMRTYfXqXRI4IDUC_o01XXw1PdqN8O9Bg
Message-ID: <CAL4Wiip9-oGNjrgQV-VSkDR_hfq35d_+ymX_itYk29u9scY=Mg@mail.gmail.com>
Subject: Re: [BUG] net: bridge: late FDB learning can outlive an MRP port
To: Cheng Yongkang <teel4res@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, bridge@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 22 oct. 2026 =C3=A0 11:04, Cheng Yongkang <teel4res@gmail.com> a =
=C3=A9crit :
>
> Hi all,
>
> An MRP-aware bridge port can remain in BR_STATE_FORWARDING during
> del_nbp().  The terminal br_fdb_delete_by_port() runs before
> netdev_rx_handler_unregister(), so a frame received in that window can
> learn a new FDB entry whose dst is the port being deleted.  No second
> FDB sweep follows.  The port is then RCU-freed, leaving the FDB entry
> with a stale net_bridge_port pointer.
>
> Observed on Linux v7.3, commit
> 08ab31164c55f20c7a2653de3186ae333470e2c1, with KASAN+UBSAN:
>
>   BUG: KASAN: slab-use-after-free in br_forward+0x55/0x3c0
>   Read of size 8
>     br_forward
>     br_handle_frame_finish
>     br_handle_frame
>   Allocated by:
>     new_nbp
>     br_add_if
>   Freed by:
>     kfree
>     kobject_put
>     rcu_core
>
> The failing sequence is:
>
>   br_stp_disable_port() leaves the MRP-aware port forwarding
>   br_mrp_del_impl() restores BR_STATE_FORWARDING
>   br_fdb_delete_by_port()
>   ... late ingress frame learns fdb->dst =3D=3D p ...
>   netdev_rx_handler_unregister()
>   call_rcu(&p->rcu, destroy_nbp_rcu)
>   later frame -> br_forward(stale dst)
>
> This reproduced in three independent VM boots.  The target bridge code
> was unchanged.  Because the test VM has no driver that accepts
> SWITCHDEV_OBJ_ID_MRP, a small diagnostic switchdev endpoint claimed the
> MRP object and widened the already-existing post-FDB-flush/pre-unregister
> window.  It did not replace bridge logic, modify FDB entries, or alter
> net_bridge_port lifetime.
>
> The deletion path should stop new RX processing before the final FDB
> sweep, or drain the deferred/FDB state after the RX handler is
> unregistered and before queueing the port for RCU free.
>
> I found no matching upstream fix.  Candidate BR-007, BR-040 and BR-058
> are consequences of this same root cause.  BR-040 gives the forwarding
> window; BR-058 independently describes the stale-FDB lifetime.
>
> The reproducer, module source, and complete serial logs are available
> on request.
>
> This was found with AI-assisted source analysis and fuzzing; the kernel
> behavior above was reproduced under KASAN.
>
> Thanks,
> Cheng Yongkang

I suggest you stop sending these emails, we all have LLM you know.

What is the point, if you do not send patches?
