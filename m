Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CAD519922
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869060; cv=none; b=r+r/y/1DmZmmeYzEuOdGVVADf7H7jCaBQk3Jp+Ff0mmMoEck1YaenEuz5Y4K5lN1mNHhUpT17KJfFShTZ6jSrgfKs9IUW0HYPAF6QR5aNVjyuIY3bUVfj+d5UtXnG0HYQ6is7i0Woqqt64Mapo0+5aa3HgIQlI6kfe3YITztvkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869060; c=relaxed/simple;
	bh=ZV5k7XLNeQRvY2kL+aVAIvdviOxTBcUNWnKVwMThcc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGPX5Ym7CaHmPzxMEHzbk4TslzNG3jhe5zVOza36AAeqiedVgxYVMJ6lQxU6VVi4dHl5cIpmpgBfq/aeEatcL5DKfyzAHcp6hGnDnuxMCEjsM5iyHqv8fMZbnICoa+bZosswmJvYhSv5g5cjVoVxTVbdu2wiL0sX1nuJ7vFx04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on8Tmi/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on8Tmi/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00841F0089F
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 15:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790869058;
	bh=wqtp53NhoEXOE3A3uQ7lUOxV6++k6ilQB8Dm5sB59Cs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=on8Tmi/1cTvxNpYBgLIeqYwvaobQQg4Oeo9tgOzrQTMfFi91Y+en82uNLte+UVM5p
	 jHZwo8Pjj4WAPXvV/8yxrv/tvvExDWAh14TImEZJzH96TObSvoUyB4zVf/UlA5CHvU
	 nYYg34RoG2CSM1QM0WnRWbvNquNOFblolx0aY1uUsEXd9nWQtusPjbuiuGWU3pLdqv
	 1H4lJaOKGHTqWmkMPkgGBMP9ou5OPXS5x151KCAOcSBLClSgbXk6hTC4JOA2MDIn6m
	 tEyXWXcpOz2XGGD5lyKrnAXwXyUzR4yYFRoExZE5AUSHNKC8SzwThPbVLT6akkRp4Z
	 FQswmTw5Q35cg==
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-469fdb78b1cso3929370fac.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 08:37:38 -0700 (PDT)
X-Gm-Message-State: AFuF++kpNAdforyM40QaLSciJ2cRYEF9qXZy7Ry6hyRoOnfF8QwKPBnB
	wcW+8WzGW/XAehV0yWInr/TyToeDTjxGVbnscTHXiDQ0bUU53A3rjA9VRX+G18SrY/yQHeY6Nzg
	9z4x9YMA/LPsUjsCYmnigI9vhTVUd/wg=
X-Received: by 2002:a05:6870:209:b0:47c:f23c:31ff with SMTP id
 586e51a60fabf-49ddd5ce304mr5284347fac.11.1790869057994; Thu, 01 Oct 2026
 08:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001112948.322463-1-jiayuan.chen@linux.dev> <20261001112948.322463-4-jiayuan.chen@linux.dev>
In-Reply-To: <20261001112948.322463-4-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 1 Oct 2026 17:37:26 +0200
X-Gmail-Original-Message-ID: <CAL4WiioHiJz=Vn+ijB8=W2Da8Qd6TfPP3b-=rzBw8xmXprpZfw@mail.gmail.com>
X-Gm-Features: AclHuK_LDImheS2CWkYzJQy0gn8QaU8tQLJFwMsvfmQvUj66CC6f8_1c8eX6nzM
Message-ID: <CAL4WiioHiJz=Vn+ijB8=W2Da8Qd6TfPP3b-=rzBw8xmXprpZfw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] tcp_cubic: fix divide by zero and endless
 loop on bad module params
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 1:30=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> beta_scale and cube_factor are computed once at module init. They need
> 1024 - beta to be positive and bic_scale * 10 to neither be 0 nor
> overflow: beta =3D=3D 1024 or bic_scale =3D=3D 0 crash right there, and o=
ther
> out of range values give garbage. Negative beta can also make
> beta_scale 0. Reject them.
>
> A small beta also gives a small beta_scale, and (cwnd * beta_scale) >> 3
> truncates to 0 for a tiny cwnd, so the TCP friendliness loop never
> ends. Make sure beta_scale is at least 8 at init, so this is always
> >=3D 1 with cwnd >=3D 1 and the fast path is untouched.
> This also caps alpha_cubic at 1 for beta < 512, which only affects
> such unusual settings.
>
> Fixes: df3271f3361b ("[TCP] BIC: CUBIC window growth (2.0)")
> Suggested-by: Eric Dumazet <edumazet@kernel.org>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> Target net-next since it is not a big problem.
> ---
>  net/ipv4/tcp_cubic.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> index 119bf8cbb007c..33b383e1307fb 100644
> --- a/net/ipv4/tcp_cubic.c
> +++ b/net/ipv4/tcp_cubic.c
> @@ -504,12 +504,21 @@ static int __init cubictcp_register(void)
>
>         BUILD_BUG_ON(sizeof(struct bictcp) > ICSK_CA_PRIV_SIZE);
>

A READ_ONCE(beta) is needed to close a race when/if TCP_CONG_CUBIC is a mod=
ule.

This can be done later as a follow up, the window is extremely tiny
and most builds
have CONFIG_TCP_CONG_CUBIC=3Dy (and CONFIG_DEFAULT_CUBIC=3Dy)

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
