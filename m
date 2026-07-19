Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858987261A
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784479791; cv=pass; b=pMbLyoQjhjo97XDOoEgZazSl97X37oT1F7HkjrDUaVfY0d3RYBS4yLc0ESZ/tujMuY2mipVm6xpCeLeLDxzeul3L79gW9k6RY6NYTjSn/tIoLuc1ATr96YEivbVVG8PeVwfnQ5QsYkD/f07bTaeha3qCWVLfQV7asPeXEg932y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784479791; c=relaxed/simple;
	bh=dupElG73/zi+gT7uX9Zc+s8ooEUhUt29dpG7ZO5yb+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfN6+zImmZn/iw7zAbo1P4Ftkhf2KtKe7SoIj/pKHg8PIVwVHI9pDnIoB3o53W6ylGtInhJem2bBrFal+iIJcHmpHkEk631SRwTCV+RKuthH6XvdIkesNqJcrnB5Wb8Ld8xAZU9p6lzRqMSEe686cOG/pvM8S7anF5GYvjlL1Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOy0Fi2S; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOy0Fi2S"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso7165553a34.3
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 09:49:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784479788; cv=none;
        d=google.com; s=arc-20260327;
        b=lbcnw5jb28SAk4VS1nAgJVZpDghQrY1JI8HEAMQ6CXk1WfETMvBfP8LOV9J2GJdIoA
         DTqTdYmlYVykeeCT0Ik+rJjhwKw0tLFQOdIF+Hr22bc/z4Je9IumreA3mnXITaHAR8YS
         d5hRDFnq46vS2Ruk4uYbL6dGcYG7kOpyac9vmdIuD1up0ZWesn7pjEVXPZJX8ABoPTq+
         9C83y+4LbijtktQP+gawa2Mk8+vZtgU5wCl02EK/rV/eMgWQ3QXCshBhaUfGLRiNx8nd
         VKS4CO60pu7RYjQYJ0x+bplf6BpeTfnEckk6YM39GXEtDM8FbQzifnu++VhCkOytCQAg
         94Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=slqNQvFTUPFtsaXrNMsOi5guuNkDMJxc6si127cTBRI=;
        fh=YbOR8P/R0JgS9olVdkyZY1Eyx1Bl/KU+MZTBNldTS9U=;
        b=p0lDfq5gB3Ne3ilg4LyxzMowrFvJBLv0SLUQDjYnFVMFsBRIoGeBaQPCjplbk4Ymwo
         L7rTBSO0Pu6wOAMJXvgw1YOKX0GOPXMXyXSqP5DFMXWjLaXrxSjb+3vKhKUroJHJLfx1
         sPYeIr5K1ftTroPvQfMXzkxKsaKh6iEhFp0RAUYuBVOdfGirmWD2o1ZnsJulIKUtWkBR
         A2sapncmgYNxxkE2WLnIfkZiJj/0x0TWHNDhPSANFStYcxeU2qZSEcXdoJowPH9lfMSG
         WR+nxwT+zFUfq979B1zopxyG/5iAWSazTBNckD9CgIHD3K47GjU3emERkai1XLvepQH4
         9dQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784479788; x=1785084588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=slqNQvFTUPFtsaXrNMsOi5guuNkDMJxc6si127cTBRI=;
        b=SOy0Fi2SWcF6Rb2ZUbS8EGVGfF7KTufmjgKEGbqL5eKC6KyCAVFRv859ayy8GRRo+w
         Dkqe0jHt3fANMiIz4xLLKG+3hmSDa5LtkmQzgzTJ3MGcZC2TlnGN/SXdb1kYAIdNMYHD
         pEBmeVbgIsW5FtkckwdTfnVC+nOG1jxmaQG0F7w11KIMWpk3RkLeJ6C/KbeuZ6KTk68C
         Wxtw52pwvcN1rmkdsCCRsGmGHRH93Jb/cfRfVX5/dwumYip7XNCRHiIzQyRMM0/vEp1l
         T3dMN/IegCR7B9IAGD24w+5I788DDtbT/ha9BiAW+lKf0MeGf4Wf92HchJtcw8BRMzy6
         NCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784479788; x=1785084588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=slqNQvFTUPFtsaXrNMsOi5guuNkDMJxc6si127cTBRI=;
        b=fhK0QEoPgbNRCCRSevax7DDgGE+ckCVYumj1ENqVj1IW3fmusWTPmZuYycMVpdxoEF
         vOhbpBBsiByTmx0akhFrQ4P585hav1BDeBDyKKIxucNpdSPwI64pXU8wwZlf+QXL0peR
         yEMZwwyPJtFhjpVq5ZTtgyA3jh0W23zxH6/Eg6sU/U7mwhQzP4VtTsvukPq4rk9ZrnJ5
         uXRuoRonAdmYBgVjEy2qhS1ZE7nwfW9p01wMtfDveeWZUpI6wpG+3Lm42UX5fJMqGSic
         V1owCICSJHJlv3GupqZtzEWhos2Q5eqQ/m9nmFshVLa1hivUmYOFRIPYoWTIlkNjFxnp
         9KvA==
X-Forwarded-Encrypted: i=1; AHgh+RrEMyiuRvtFr3X1XyWX/MD/kdBjTcaHx6luLF+Pqi+rFS9nl+SWrqmqF9W6dFEoHd+KF4UeXO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbFWP5c+3ww0pNIpdUHBe2VlQO+5quqYtL74Lub/WoboEQOnvI
	oFFMjTy0IVWAb+zUZUuoGhj4d8ZwtAMVnXh+Ax9FGuo2+dDLBJnofioTTw/mynp4XKJyPb/YzXr
	vQaveBa2wXLoMWYcQ4TRTNa217OFakP55lA==
X-Gm-Gg: AfdE7cn+qSdKTli7WPQ8v/jgWiG9QgrFQ4f0wFvpxUxkLkR3D5yJL+um0cggdvzeyM7
	X4WKwt4lwZR2BRbJ5q5IZTTiQky1+UeucT4bQImiJXxc/P6xbmNjiEzieFShKIyagnpDVR2CSPA
	mop76GHU29/VjxRzOtDsGNpl7Iad9cs3U+J9bOaas+kyTbnhIERwcKVgpuveKHOAEUQH5/ArDLJ
	DiZ+4wSimp+P2UodjN6lb4hADjCcLi7gO4IfjVFlz1L6brBsUBz2KIOTXbhcQ==
X-Received: by 2002:a05:6820:1889:b0:6a3:955b:846e with SMTP id
 006d021491bc7-6a53684a6bcmr5407008eaf.34.1784479788157; Sun, 19 Jul 2026
 09:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717110118.251866-1-pablo@netfilter.org>
In-Reply-To: <20260717110118.251866-1-pablo@netfilter.org>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Sun, 19 Jul 2026 09:49:35 -0700
X-Gm-Features: AUfX_mxGh9D6BFbiBhEW_mo8Uoec5kg6sJ6kyGp7ZnyK7cyIzNqk8EfSkGozqq4
Message-ID: <CAHsH6Gtk0iuhQX4PEjA44Y12KecrXoXOt98700_Evcy78dd67A@mail.gmail.com>
Subject: Re: [PATCH net-next,v3] xfrm: allow to enable udp encapsulation
 without userspace socket
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: devel@lists.linux-ipsec.org, netdev@vger.kernel.org, tobias@strongswan.org, 
	antony@phenome.org, steffen.klassert@secunet.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 17, 2026 at 4:01=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
>
> It is currently not possible to enable UDP encapsulation in xfrm without
> a userspace process that listens on the specified UDP listener port in
> the SA.
>
> People have work around this by creating dummy userspace daemons such as
> the one in the smallish perl program (see the script at the bottom of
> this link):
>
> http://techblog.newsnow.co.uk/2011/11/simple-udp-esp-encapsulation-nat-t-=
for.html
>
> This patch adds XFRM_SA_XFLAG_UDP_ENCAP_SOCK to create the UDP socket
> from the kernel.
>
> Use a hole in net->xfrm to place the new encap_socket list.
>
> The following example shows how to enable the standalone UDP
> encapsulation:
>
>     ip xfrm state add src 192.168.10.10 dst 192.168.10.11 proto esp spi 1=
 \
>             encap espinudp 9999 9999 0.0.0.0 \
>             if_id 0x1 reqid 1 replay-window 0 mode tunnel aead 'rfc4106(g=
cm(aes))' \
>             0x1111111111111111111111111111111111111111 96 \
>             sel src 10.141.10.0/24 dst 10.141.11.0/24 dir out
>
> and the receiving side uses 'extra-flag udp-encap-sock':
>
>     ip xfrm state add src 192.168.10.11 dst 192.168.10.10 proto esp spi 2=
 \
>             encap espinudp 9999 0 0.0.0.0 extra-flag udp-encap-sock \
>             if_id 0x1 reqid 2 replay-window 10 mode tunnel aead 'rfc4106(=
gcm(aes))' \
>             0x2222222222222222222222222222222222222222 96 dir in
>
> This allows for multiple SAs using the same listener udp port.
>
> This is useful for testing scenarios where UDP encapsulation is
> required.
>
> Note this patch exports xfrm6_udp_encap_rcv() just like
> xfrm4_udp_encap_rcv() otherwise linker complains due to unreachable
> symbol.
>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

LGTM. Thanks!

Reviewed-by: Eyal Birger <eyal.birger@gmail.com>



> ---
> v3: - Use x->id.daddr.a{4,6} instead of encap_oa, as suggested by Eyal an=
d Tobias.
>     - Fix several SA using same udp encapsulation configuration.
>
> This is a follow up to:
> https://lists.linux-ipsec.org/archives/list/devel@lists.linux-ipsec.org/t=
hread/F4IOY2DKFDX3E45UUFQHUZKTHV7AD6G4/
>
> NOTE for netdev maintainers:
> Targetting net-next so sashiko kicks in for review, ipsec-devel still has=
 no such service yet.
>
>  include/net/netns/xfrm.h  |   1 +
>  include/net/xfrm.h        |  11 ++++
>  include/uapi/linux/xfrm.h |   1 +
>  net/ipv6/xfrm6_input.c    |   1 +
>  net/xfrm/Kconfig          |   2 +
>  net/xfrm/xfrm_state.c     |  16 +++++
>  net/xfrm/xfrm_user.c      | 122 +++++++++++++++++++++++++++++++++++++-
>  7 files changed, 152 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
> index b73983a17e08..5091c07b1e46 100644
> --- a/include/net/netns/xfrm.h
> +++ b/include/net/netns/xfrm.h
> @@ -56,6 +56,7 @@ struct netns_xfrm {
>         unsigned int            policy_count[XFRM_POLICY_MAX * 2];
>         struct work_struct      policy_hash_work;
>         struct xfrm_policy_hthresh policy_hthresh;
> +       struct hlist_head       encap_socket;
>         struct list_head        inexact_bins;
>
>
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index a6d69aaa6cd2..99730a2fc8b9 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -25,6 +25,7 @@
>  #include <net/ipv6.h>
>  #include <net/ip6_fib.h>
>  #include <net/flow.h>
> +#include <net/udp_tunnel.h>
>  #include <net/gro_cells.h>
>
>  #include <linux/interrupt.h>
> @@ -169,6 +170,13 @@ struct xfrm_dev_offload {
>         u8                      flags : 2;
>  };
>
> +struct xfrm_encap_sock {
> +       struct hlist_node       list;
> +       struct udp_port_cfg     cfg;
> +       struct sock             *sk;
> +       refcount_t              refcnt;
> +};
> +
>  struct xfrm_mode {
>         u8 encap;
>         u8 family;
> @@ -249,6 +257,7 @@ struct xfrm_state {
>
>         /* Data for encapsulator */
>         struct xfrm_encap_tmpl  *encap;
> +       struct xfrm_encap_sock  *encap_sock;
>
>         /* NAT keepalive */
>         u32                     nat_keepalive_interval; /* seconds */
> @@ -2343,6 +2352,8 @@ static inline bool xfrm6_local_dontfrag(const struc=
t sock *sk)
>  }
>  #endif
>
> +int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb);
> +
>  #if (IS_BUILTIN(CONFIG_XFRM_INTERFACE) && IS_ENABLED(CONFIG_DEBUG_INFO_B=
TF)) || \
>      (IS_MODULE(CONFIG_XFRM_INTERFACE) && IS_ENABLED(CONFIG_DEBUG_INFO_BT=
F_MODULES))
>
> diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> index 051f8066efd1..28aa5c8ca317 100644
> --- a/include/uapi/linux/xfrm.h
> +++ b/include/uapi/linux/xfrm.h
> @@ -413,6 +413,7 @@ struct xfrm_usersa_info {
>
>  #define XFRM_SA_XFLAG_DONT_ENCAP_DSCP  1
>  #define XFRM_SA_XFLAG_OSEQ_MAY_WRAP    2
> +#define XFRM_SA_XFLAG_UDP_ENCAP_SOCK   4
>
>  struct xfrm_usersa_id {
>         xfrm_address_t                  daddr;
> diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
> index 89d0443b5307..2e3f7b9e5a4f 100644
> --- a/net/ipv6/xfrm6_input.c
> +++ b/net/ipv6/xfrm6_input.c
> @@ -173,6 +173,7 @@ int xfrm6_udp_encap_rcv(struct sock *sk, struct sk_bu=
ff *skb)
>
>         return ret;
>  }
> +EXPORT_SYMBOL(xfrm6_udp_encap_rcv);
>
>  struct sk_buff *xfrm6_gro_udp_encap_rcv(struct sock *sk, struct list_hea=
d *head,
>                                         struct sk_buff *skb)
> diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
> index 4a62817a88f8..fe42cfca9423 100644
> --- a/net/xfrm/Kconfig
> +++ b/net/xfrm/Kconfig
> @@ -7,6 +7,7 @@ config XFRM
>         depends on INET
>         select GRO_CELLS
>         select SKB_EXTENSIONS
> +       select NET_UDP_TUNNEL
>
>  config XFRM_OFFLOAD
>         bool
> @@ -23,6 +24,7 @@ if INET
>  config XFRM_USER
>         tristate "Transformation user configuration interface"
>         select XFRM_ALGO
> +       select NET_UDP_TUNNEL
>         help
>           Support for Transformation(XFRM) user configuration interface
>           like IPsec used by native Linux tools.
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 36a4f6793ede..c849e7ac750a 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -27,6 +27,7 @@
>  #include <linux/slab.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> +#include <net/udp_tunnel.h>
>
>  #include <crypto/aead.h>
>
> @@ -586,6 +587,16 @@ static const struct xfrm_mode_cbs *xfrm_get_mode_cbs=
(u8 mode)
>         return cbs;
>  }
>
> +static bool xfrm_socket_put(struct xfrm_encap_sock *encap_sock)
> +{
> +       if (refcount_dec_and_test(&encap_sock->refcnt)) {
> +               udp_tunnel_sock_release(encap_sock->sk);
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
>  void xfrm_state_free(struct xfrm_state *x)
>  {
>         kmem_cache_free(xfrm_state_cache, x);
> @@ -597,6 +608,10 @@ static void xfrm_state_gc_destroy(struct xfrm_state =
*x)
>  {
>         if (x->mode_cbs && x->mode_cbs->destroy_state)
>                 x->mode_cbs->destroy_state(x);
> +
> +       if (x->encap_sock && xfrm_socket_put(x->encap_sock))
> +               kfree(x->encap_sock);
> +
>         hrtimer_cancel(&x->mtimer);
>         timer_delete_sync(&x->rtimer);
>         kfree_sensitive(x->aead);
> @@ -3332,6 +3347,7 @@ int __net_init xfrm_state_init(struct net *net)
>                                               SLAB_HWCACHE_ALIGN | SLAB_P=
ANIC);
>
>         INIT_LIST_HEAD(&net->xfrm.state_all);
> +       INIT_HLIST_HEAD(&net->xfrm.encap_socket);
>
>         sz =3D sizeof(struct hlist_head) * 8;
>
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index d6db63304ba6..bc88581e51e8 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -29,6 +29,7 @@
>  #include <net/xfrm.h>
>  #include <net/netlink.h>
>  #include <net/ah.h>
> +#include <net/udp_tunnel.h>
>  #include <linux/uaccess.h>
>  #if IS_ENABLED(CONFIG_IPV6)
>  #include <linux/in6.h>
> @@ -484,6 +485,17 @@ static int verify_newsa_info(struct xfrm_usersa_info=
 *p,
>                         goto out;
>         }
>
> +       if (attrs[XFRMA_SA_EXTRA_FLAGS]) {
> +               u32 xflags =3D nla_get_u32(attrs[XFRMA_SA_EXTRA_FLAGS]);
> +
> +               if (xflags & XFRM_SA_XFLAG_UDP_ENCAP_SOCK &&
> +                   (!sa_dir || sa_dir =3D=3D XFRM_SA_DIR_OUT)) {
> +                       NL_SET_ERR_MSG(extack, "Flag UDP_ENCAP_SOCK can o=
nly be set on input SA");
> +                       err =3D -EINVAL;
> +                       goto out;
> +               }
> +       }
> +
>         if (sa_dir =3D=3D XFRM_SA_DIR_OUT) {
>                 if (p->flags & XFRM_STATE_DECAP_DSCP) {
>                         NL_SET_ERR_MSG(extack, "Flag DECAP_DSCP should no=
t be set for output SA");
> @@ -556,7 +568,6 @@ static int verify_newsa_info(struct xfrm_usersa_info =
*p,
>                                 err =3D -EINVAL;
>                                 goto out;
>                         }
> -
>                 }
>
>                 if (attrs[XFRMA_IPTFS_DONT_FRAG]) {
> @@ -932,9 +943,17 @@ static struct xfrm_state *xfrm_state_construct(struc=
t net *net,
>                         goto error;
>         }
>
> -       if (attrs[XFRMA_SA_EXTRA_FLAGS])
> +       if (attrs[XFRMA_SA_EXTRA_FLAGS]) {
>                 x->props.extra_flags =3D nla_get_u32(attrs[XFRMA_SA_EXTRA=
_FLAGS]);
>
> +               if (x->props.extra_flags & XFRM_SA_XFLAG_UDP_ENCAP_SOCK &=
&
> +                   x->encap && x->encap->encap_type !=3D UDP_ENCAP_ESPIN=
UDP) {
> +                       NL_SET_ERR_MSG(extack, "XFRM_SA_XFLAG_UDP_ENCAP_S=
OCK can only be set on UDP_ENCAP_ESPINUDP type");
> +                       err =3D -EOPNOTSUPP;
> +                       goto error;
> +               }
> +       }
> +
>         if ((err =3D attach_aead(x, attrs[XFRMA_ALG_AEAD], extack)))
>                 goto error;
>         if ((err =3D attach_auth_trunc(&x->aalg, &x->props.aalgo,
> @@ -1036,6 +1055,97 @@ static struct xfrm_state *xfrm_state_construct(str=
uct net *net,
>         return NULL;
>  }
>
> +static struct xfrm_encap_sock *
> +xfrm_socket_find_get(struct net *net, const struct udp_port_cfg *udp_con=
f)
> +{
> +       struct xfrm_encap_sock *listener;
> +
> +       hlist_for_each_entry(listener, &net->xfrm.encap_socket, list) {
> +               if (!memcmp(&listener->cfg, udp_conf, sizeof(*udp_conf)))=
 {
> +                       refcount_inc(&listener->refcnt);
> +                       return listener;
> +               }
> +       }
> +
> +       return NULL;
> +}
> +
> +static int xfrm_socket_encap_create(struct net *net, struct xfrm_state *=
x,
> +                                   struct udp_port_cfg *udp_conf,
> +                                   struct udp_tunnel_sock_cfg *tuncfg)
> +{
> +       struct xfrm_encap_sock *listener;
> +       struct socket *sock;
> +       int err;
> +
> +       listener =3D kzalloc_obj(*listener);
> +       if (!listener)
> +               return -ENOMEM;
> +
> +       err =3D udp_sock_create(net, udp_conf, &sock);
> +       if (err) {
> +               kfree(listener);
> +               return err;
> +       }
> +       setup_udp_tunnel_sock(net, sock->sk, tuncfg);
> +
> +       listener->sk =3D sock->sk;
> +       listener->cfg =3D *udp_conf;
> +       refcount_set(&listener->refcnt, 1);
> +       hlist_add_head(&listener->list, &net->xfrm.encap_socket);
> +
> +       x->encap_sock =3D listener;
> +
> +       return 0;
> +}
> +
> +static int xfrm_socket_setup(struct net *net, struct xfrm_state *x,
> +                            struct netlink_ext_ack *extack)
> +{
> +       struct udp_tunnel_sock_cfg tuncfg =3D {};
> +       struct xfrm_encap_sock *listener;
> +       struct udp_port_cfg udp_conf;
> +       int err;
> +
> +       if (!x->encap)
> +               return -EOPNOTSUPP;
> +
> +       memset(&udp_conf, 0, sizeof(udp_conf));
> +       udp_conf.family =3D x->props.family;
> +
> +       switch (x->props.family) {
> +       case AF_INET:
> +               udp_conf.local_ip.s_addr =3D x->id.daddr.a4;
> +               tuncfg.encap_rcv =3D xfrm4_udp_encap_rcv;
> +               break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +       case AF_INET6:
> +               udp_conf.local_ip6 =3D x->id.daddr.in6;
> +               tuncfg.encap_rcv =3D xfrm6_udp_encap_rcv;
> +               break;
> +#endif
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +       udp_conf.local_udp_port =3D x->encap->encap_sport;
> +
> +       listener =3D xfrm_socket_find_get(net, &udp_conf);
> +       if (listener) {
> +               x->encap_sock =3D listener;
> +               return 0;
> +       }
> +
> +       tuncfg.encap_type =3D UDP_ENCAP_ESPINUDP;
> +
> +       err =3D xfrm_socket_encap_create(net, x, &udp_conf, &tuncfg);
> +       if (err < 0) {
> +               NL_SET_ERR_MSG(extack, "Cannot initialize kernel UDP sock=
et");
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
>  static int xfrm_add_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
>                        struct nlattr **attrs, struct netlink_ext_ack *ext=
ack)
>  {
> @@ -1053,6 +1163,14 @@ static int xfrm_add_sa(struct sk_buff *skb, struct=
 nlmsghdr *nlh,
>         if (!x)
>                 return err;
>
> +       if (x->props.extra_flags & XFRM_SA_XFLAG_UDP_ENCAP_SOCK) {
> +               err =3D xfrm_socket_setup(net, x, extack);
> +               if (err < 0) {
> +                       x->km.state =3D XFRM_STATE_DEAD;
> +                       goto out;
> +               }
> +       }
> +
>         xfrm_state_hold(x);
>         if (nlh->nlmsg_type =3D=3D XFRM_MSG_NEWSA)
>                 err =3D xfrm_state_add(x);
> --
> 2.47.3
>
