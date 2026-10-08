Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9502131E844
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 22:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791498357; cv=none; b=lP1JSG0Juo8dilVSTYpzH9tqkPUAjc6XYVrh/Xix97VT4RtYuk2khYzHoiRZit5aAeC6sjB+lPykLl8vBrLy6oTtWBYrGR/8VAKGVeLg56MPgV6LOkl7IYzbfp0vFIuEqRzis35zU6uCkm2oPGkZGGbsbExoaPqU9ZWQFkZaIfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791498357; c=relaxed/simple;
	bh=v7jCTOP21fM8TbfufNOoo0v+XJZybctSDJDiHhW4LQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEbXLmaGae41oDZBHgE1v4Fs8RO/7GQCCi7SPjIOZQ/WwrMyIRPOd7WhBeZHkXeliNRhYEIiYkdLOdl3Up8N6m5F1hHaP9BdSUSph/Q+AWhBVmMrBM1xuaD3u0NKTi7fAGw33Ex784M+kmy75Pl9X1jZ1bTjYcjDq21/5eJ1EeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xejc3279; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xejc3279"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562471F0089D
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 22:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791498355;
	bh=573ZxgVmxHKNqjvqYAD1cEWj1kPoV8KHOVbPKb8u1X4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Xejc3279MW1KrbTZc6c2+IazzNJx499ow8L1HwePTRzrXPGEUXJ+voEZtGc+46SO1
	 jnkKBEaOVCqNqqEbiUGkeJu/dCYbR3bjmx7AxHwSZvPqj5z5WulGJs6Sk76q3hgtPU
	 OvvJmIYOIJs8Ac95Wv6tC4KaBf8PPKiTm9M73qGtMwagLdMH6CUMisxd8djf5jgSlr
	 SnetK1g4c0GnuVxtIzWbqjBid3nyyQLz/bAUsmDCN1CnpvMM7VKv+0mhkp5J/b7mny
	 0du3Rs/Lh154HhLRPjXqe6CH5paLMm7vfJgK41f1JVu/7WdTxgMj++tI+iq1H75F0P
	 ShtVyt3NfMBRw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-483c607ccb4so3137995fac.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 15:25:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwcFW4wJOuid4dhpI2uHVhDftBeXEmHKmDyVRDMRedYmmcJbiNpAlzB96fur7kcBrJVaIoRRSE=@vger.kernel.org
X-Gm-Message-State: AFuF++n0P8rAunVpsT06ElWvX3oxkEfl/wkZqVhVGp9+aDALjJKnmBrb
	WYp4/DuGaMpx4AhQ5oY5ZSd+SNccAqUsfB7KMe96kzF0mgXso5aYXzfmat61tdQOFSinMUQQ7dT
	faSPbowwyZF9wfquLq0Q9B1NL2rLOENs=
X-Received: by 2002:a05:6871:722:b0:48f:e0f6:bd5f with SMTP id
 586e51a60fabf-4a2a8b0964amr171183fac.48.1791498354611; Thu, 08 Oct 2026
 15:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008-fib-trie-nospec-v1-1-fa18726d485e@nvidia.com>
In-Reply-To: <20261008-fib-trie-nospec-v1-1-fa18726d485e@nvidia.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 9 Oct 2026 00:25:43 +0200
X-Gmail-Original-Message-ID: <CAL4WiiqO2C0cVQBdDJWrGYCczB0JRMXJUjsUq7uYPjfNL34q7g@mail.gmail.com>
X-Gm-Features: AclHuK-tNpsKPdnN-MtKQlMjm1BRfKtF2bY401bZ3gBya-JyqT9iMLlo75c3aT4
Message-ID: <CAL4WiiqO2C0cVQBdDJWrGYCczB0JRMXJUjsUq7uYPjfNL34q7g@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: fib_trie: prevent speculative out-of-bounds
 child access
To: datrujillo@nvidia.com
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexander Duyck <alexander.h.duyck@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 9 oct. 2026 =C3=A0 00:10, Dani=C3=ABl Trujillo via B4 Relay
<devnull+datrujillo.nvidia.com@kernel.org> a =C3=A9crit :
>
> From: Dani=C3=ABl Trujillo <datrujillo@nvidia.com>
>
> fib_table_lookup() checks the child index against the bounds before
> passing it to get_child_rcu().
>
> The index is derived from the lookup key, which in turn is derived from
> flp->daddr. A userspace process can therefore influence the index by
> triggering lookups for chosen destination IPv4 addresses.
>
> If this bounds check is mispredicted as in-bounds, an out-of-bounds index
> can be transiently passed to get_child_rcu(). The value loaded beyond the
> child array is then treated as a node pointer. The next loop iteration
> dereferences that transient pointer through get_cindex(), causing a
> page-table walk whose cache footprint can leak (parts of) the pointer.

Has this been demonstrated, or is it the output of a static tool ?

key, pos and bits all live in the first 8 bytes of struct key_vector,
so the bound can not be made slow relative to the index by evicting
a cache line. The conditional branch should resolve a couple of cycles
after the out-of-bounds load is issued, before a dependent dereference
can start.

For a patch targeting net and stable, in the IPv4 lookup fast path,
we would like the changelog to say what was actually observed.

>
> Sanitize the index with array_index_nospec() before accessing the child
> array.
>
> Fixes: 9f9e636d4f89 ("fib_trie: Optimize fib_table_lookup to avoid wastin=
g time on loops/variables")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dani=C3=ABl Trujillo <datrujillo@nvidia.com>
> ---
>  net/ipv4/fib_trie.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> index 248514dce0cd..bd8a368c5502 100644
> --- a/net/ipv4/fib_trie.c
> +++ b/net/ipv4/fib_trie.c
> @@ -61,6 +61,7 @@
>  #include <linux/export.h>
>  #include <linux/vmalloc.h>
>  #include <linux/notifier.h>
> +#include <linux/nospec.h>
>  #include <net/net_namespace.h>
>  #include <net/inet_dscp.h>
>  #include <net/ip.h>
> @@ -1474,6 +1475,7 @@ int fib_table_lookup(struct fib_table *tb, const st=
ruct flowi4 *flp,
>                         cindex =3D index;
>                 }
>
> +               index =3D array_index_nospec(index, 1ul << n->bits);
>                 n =3D get_child_rcu(n, index);
>                 if (unlikely(!n))
>                         goto backtrace;


This is not complete.

cindex has been set from the unclamped index just above. If the
(!n) branch is predicted taken under the same mispredicted bounds
check, the backtrace path does :

cindex &=3D cindex - 1;
cptr =3D &pn->tnode[cindex];
...
n =3D rcu_dereference(*cptr);

and the result is dereferenced at the top of step 2
(prefix_mismatch(key, n), n->slen, n->pos).

This is the same pattern you describe : one out-of-bounds load, then
a dereference of the loaded value.

The clamp needs to be done before cindex is recorded, and can stay
after the IS_LEAF() test so that leaf hits do not pay for it :

@@ -1465,7 +1466,9 @@ int fib_table_lookup(struct fib_table *tb, const
struct flowi4 *flp,
  /* we have found a leaf. Prefixes have already been compared */
  if (IS_LEAF(n))
  goto found;

+ index =3D array_index_nospec(index, 1ul << n->bits);
+
  /* only record pn and cindex if we are going to be chopping
  * bits later.  Otherwise we are just wasting cycles.
  */

Also, fib_find_node() has the exact same construct (same bounds check,
then get_child_rcu(n, index) on the next iteration), and is called
with a user provided key from fib_table_insert() and fib_table_delete().
RTM_NEWROUTE / RTM_DELROUTE only need CAP_NET_ADMIN in the netns owner
user namespace. This runs under RTNL, there is no performance concern
there.

Please also take a look at leaf_walk_rcu() (cindex >> pn->bits), and
say in the changelog why it is or is not affected.

>
> ---
> base-commit: 37f12441f557468a56c1e27790413aa78c82afa2
> change-id: 20261008-fib-trie-nospec-5c76028c8e7c
>
> Best regards,
> --
> Dani=C3=ABl Trujillo <datrujillo@nvidia.com>
>
>
