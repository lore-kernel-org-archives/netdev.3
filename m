Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792617256;
	b=T9ULlSSl1Cb85vPYykRRTXsn9zvVap9bpkK3q303PzWZ/JZjiL6eDdCK0PAFiBSey7wq
	 uJK2Wy1cvDFF+JKW0yUnNqa9FNngKiu6lTfzxCFa+h3CtRxm15A8zOrBPDQ84x2QO+uIf
	 FiSRgDesvBuTgU9c9L+cZhdlGDWozTlBlcgdzrIp50o0h2RIruPnHFDzJEr8pqPoC6huU
	 ctqaJJ1I6e97nKjbcd8B/S7SbdPI/WaPQHOwEqYgQv9vQjHPLB3CQ6TTs5x1plEdEx6pV
	 hRHwiu2jmZQU89Q/Z1WIss1bH9Y4R1LmAsoA7VVlZ9tHr3KxCXPVN9qmMj9j7OUTUJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792617256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=0/icIo4f2aB16mwMSloDvXdXVW78PPkw7b+c6qS/9gc=;
	b=C/MJBLH8eESi48ZIgImrqmT5zWp+72uNC0crKjbyQZjih9oNG7y2z0VwMARveMUiv3UX
	 pkviIhPdEzXA+7/qCsMbbUEwtu/22B9kzQsgnEhItWI8TxDxOlaOJrrz6toN1UvoVWrAw
	 T1pYuPIBWh9zDYgyw1nkOr/7G69e2ed1nZ/xKAWkKW5fJz1WiSrBQdW6SqXgz9yNtqgLT
	 15RGx/Ga2DMO1V48hAM3EnNva7pdVlm38Xt79GZV3hzdAamhnQU5uUHt1lES4wMHlcNj2
	 wj9m3ecK4aVwCyXDBAQt02gFwYihKiY0h+lmt9nwr8sydEVccex+BICQlQR3voSQwyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=OOLGkmTY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BCD606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 21:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45BCD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=OOLGkmTY
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a070b3f44aso439979b3a.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 14:14:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792617254; cv=none;
        d=google.com; s=arc-20260327;
        b=TTVVzPNVjUaXQW2y483zHkPBwe3ia0kiQOWjGyr6Okf6d+j/85sWwd6C0f5swsFyXr
         KSpixOu2SvRjj1RCUY4tfYS9vgsdiatznnfGQ2dfUh4jCXju3bBBC7tqM5EdJtHs/vc1
         pz9mumQV6D8b7aIvdtVwtAjztv+Oz79+4MEn+g00poBaMEbAMnIMwovFAn59XRSOgDlQ
         o0mxyX0JSShs2s2fKuKE99PI4KbgtEsvMG96ZxxAsIbLOOaCaMAo8nzjYVCVPuD+LkSg
         kA42LyrNO6l+DklDalK0cso2KYf0fSMQ6AhG3DQ6zRBVRQ0OY3K0FRsTp6deJjnBvrYj
         blCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0/icIo4f2aB16mwMSloDvXdXVW78PPkw7b+c6qS/9gc=;
        fh=Ui+AdauD7Y4tpW4IUFWGWXHdROhENvWEjUSa9A/kpeQ=;
        b=aeH8SV8AGK+3W7nhGJ+TryD/xVmj4j+RZpIpmpL6Ai7fz8sltVuMUxfH8qY+xqwaK9
         ZVcc2DxeHTyac7tx8JCyzi6RB2NiqAIT2NPy59r0DUUXsbn62J81aTEy47oaoArC6hjY
         OMYTvwetHf/R75WTvtD1jc6L97C5dzMh2K/xpGzW8NQuK8PPQQwmmc/pQ9e/J49I3vSN
         lH7PV5bRmz7Cg7rHCt3Vy9Bi4Ag5xTqt2TpXOSYTA8s2mVYdhmHhYhEVOa+VA/wT14EO
         WFnCs2Io6o7NqxLY+f+mfyloGYPQeA867prrwNRtqYDF8X53VAc6nTDnx2Y2HCiwMuuI
         Z5BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792617254; x=1793222054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0/icIo4f2aB16mwMSloDvXdXVW78PPkw7b+c6qS/9gc=;
        b=OOLGkmTYIRMrAGPGK9SQQqFrkXydjiyWb5b0wti0FWUgkfOA2ppON+2zkkH4IPQE2N
         X71H8hyod+cm4zlV9Wr6kLTiRnsM2PVF5GCKZJ85ck6vmuC5LfswdwGNiPI3X3gGTl3s
         5eascI0tXHl7T1A0g8n0+rvLh5WG7X164JVyAk7Dd3N0SOa+QVqpl/en2VtqlyQAUvFj
         HhQY3rLErBI74jtjCun7oOwJ/gZmIB8A0loSCX//SOtckOyJeiL8WZNUXiHF0WyLr0nG
         8e80mLfA3GfvrtvBxaoS7LqOQmp9+mHxE+Iw73+Sk+PmWDOZYyYeLGstr+/awq6OyIoO
         3n/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792617254; x=1793222054;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0/icIo4f2aB16mwMSloDvXdXVW78PPkw7b+c6qS/9gc=;
        b=2Vv0HL5DuO6rPPOvpTY3dzjYxM+Y0+oBA13nxVVn7AFp3RnKToemVdb7TluuunD+WQ
         iU1Sw97NJUmjQjjLP0nwdRA8bIqnWbDlKblweCnq5ce9XKFHFmCrtVQeNn8uqkvpOaHx
         +T/XwHsDNWRpSPBZWyA5BDU9L9k6c/2nV7Z36YEdo5aPra3CjEf8lMK8sL5GFDAjIi9j
         Yt/NcL8kom/JRZAufLLLkvprmoBAZq7jFrBn8E2dt9SPznJT+G0JX0rg9bCfJTKk9Lpl
         BSpvmr/arRD+Tsia9Zq3LRYqJuoNaxqNQTXpg9DR5GKWl7D10khyVvjourViPdozk/RH
         PxLQ==
X-Gm-Message-State: AFq9FYIHUQ3FUB19nUB5TDi9Ntq70UFRVnzVBXTXSPGcEDE7TeQR4/WU
	rlXJ1B8TnAHcIcc1UUOAofMELl3OC8DnXfdPgcCD5Gb5wyPldjgWINPN4I+KheywSH8oeZgqXVf
	f9tis9IIKqrQMu6yXSTTDRPVMKzLyxh/X2T/PFHBY
X-Gm-Gg: AYBFou0gbKgO+NDG3vpXxLpSJSeZgHGWKnEsHfZKYfYuG3Ew2lSKPV+RvjodsbWNsY1
	9t48dwAsowYRggdK0yvuvVyDaux6bT6xtyCc4+ShIKu4Fr/2QtnuC9cY1wgnD782J88ZhSfQ683
	rnPTA1KcNW1HxjX42kFRmd5W4zFJ9UY2jRd75CGIdInOy0KSLfloDIiTcu9BPl3mPCpQ/RAVHw1
	o/lGKGkarcNKBXCjGoB3nbEsLi3+hDD99/yYDhwdAslC8/W9cBWKL0B4Hs6P5SuCKG/9Wt8FAuS
	eNtSV+0B2dnNWRPmtla3g47AoyenhIkGDWaE+9ewKTjRjZ/Fu6/JTyZlejNIsTV7gcoXCf4YD/q
	ykY0XVAiY/J2E/sGDbw+1kNAmMZRoxA0xtFeHKjbUXNaPRzYRQp4ArBpg+PGCTXYGQFe6
X-Received: by 2002:a05:6a00:4213:b0:882:1b4d:1840 with SMTP id
 d2e1a72fcca58-8a089e40a63mr2386630b3a.24.1792617254517; Wed, 21 Oct 2026
 14:14:14 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CBLsHx48w8Bn1k_Xg6kJFliLNkxLCqi8SnkifapxYYpVtll4w-W_2JJePtbk9ssIS701IFJvi0Q2n5l-2GFFe8hNHU9Y_CgD_sdzcAbILVA=@proton.me>
In-Reply-To: <CBLsHx48w8Bn1k_Xg6kJFliLNkxLCqi8SnkifapxYYpVtll4w-W_2JJePtbk9ssIS701IFJvi0Q2n5l-2GFFe8hNHU9Y_CgD_sdzcAbILVA=@proton.me>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Oct 2026 17:14:02 -0400
X-Gm-Features: AclHuK9rMW6uO1yfRDrk-4vV3jn-Pk-pAdSd2vzdHzOXiT1zxlVEh1F4H82l2fo
Message-ID: <CAHC9VhQDbtQp76ZwH1SzfSz-LU8=eD-OoMsMAjG0G8YdhuaBmA@mail.gmail.com>
Subject: Re: [PATCH net] cipso_v4: fail the walk on malformed options
To: omniameasunt@proton.me
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 5:35=E2=80=AFAM <omniameasunt@proton.me> wrote:
>
> cipso_v4_get_actual_opt_len() walks a compacted IP option buffer with no
> validation of the option it is standing on: it reads data[iter + 1]
> without checking that the length byte is inside the buffer, it accepts a
> zero length byte (spinning forever), and it never clamps the walked
> offset to len, so the returned length can exceed the 40-byte MAX_IPOPTLEN
> bound that every caller assumes.
>
> After cipso_v4_delopt() memmove-compacts a socket's options, the bytes
> past the compacted region are stale and attacker-controlled via
> setsockopt(IP_OPTIONS).  An unprivileged user (CAP_NET_RAW in a user
> namespace, CIPSO labeling configured) can trigger the walk with
> connect(AF_UNSPEC), which reaches cipso_v4_sock_delattr() through the
> SELinux NetLabel hook.  The poisoned optlen is later used in
> do_ip_getsockopt(), where it causes
>
>   * an out-of-bounds read of the adjacent heap object copied back to
>     userspace (kernel pointer disclosure, KASLR defeat), and
>   * a stack buffer overflow when optlen exceeds the 56-byte scratch
>     buffer (return-address overwrite; exploitable for privilege
>     escalation on kernels built without stack protector).
>
> The same helper is also called from cipso_v4_skbuff_delattr() when a
> label is removed from output or forwarded packets; the option bytes there
> have already been validated by ip_options_compile(), so the new checks
> are defensive for that caller.
>
> Fix the defects by making the walk fail with -EINVAL as soon as an
> option header is truncated or malformed (length byte missing, zero, or
> one) or an option would run past len.  cipso_v4_delopt() then drops the
> socket's entire option set (reusing the existing branch that frees the
> ip_options_rcu when CIPSO was the only option), and
> cipso_v4_skbuff_delattr() leaves a malformed packet unchanged instead
> of rewriting its header based on untrustworthy bytes.
>
> Well-formed option streams are unaffected: a socket whose options
> survive the compaction intact keeps them; only malformed streams now
> lose all options instead of carrying a partially parsed set.
>
> Fixes: 014ab19a69c3 ("selinux: Set socket NetLabel based on connection en=
dpoint")
> Signed-off-by: Lucas Dupr=C3=A9--Rabinovici <omniameasunt@proton.me>
>
> ---
>  net/ipv4/cipso_ipv4.c | 22 +++++++++++++++--------
>  1 file changed, 18 insertions(+), 4 deletions(-)

Thanks Lucas!

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -1824,7 +1824,11 @@
>                 } else if (data[iter] =3D=3D IPOPT_NOP) {
>                         iter++;
>                 } else {
> +                       if (iter + 1 >=3D len || data[iter + 1] < 2)
> +                               return -EINVAL;
>                         iter +=3D data[iter + 1];
> +                       if (iter > len)
> +                               return -EINVAL;
>                         optlen =3D iter;
>                 }
>         }
> @@ -2028,6 +2032,13 @@
>
>                 optlen_new =3D cipso_v4_get_actual_opt_len(opt->opt.__dat=
a,
>                                                          opt->opt.optlen)=
;
> +               if (optlen_new < 0) {
> +                       /* malformed option stream, drop all the options =
*/
> +                       *opt_ptr =3D NULL;
> +                       hdr_delta =3D opt->opt.optlen;
> +                       kfree_rcu(opt, rcu);
> +                       return hdr_delta;
> +               }

Future work could, and likely should, find a way to combine the error
handling above with the CIPSO-only code path in the same function, but
the separate approach taken above should make backporting easier.

>                 hdr_delta =3D opt->opt.optlen;
>                 opt->opt.optlen =3D (optlen_new + 3) & ~3;
>                 hdr_delta -=3D opt->opt.optlen;
> @@ -2249,7 +2260,7 @@
>  int cipso_v4_skbuff_delattr(struct sk_buff *skb)
>  {
>         int ret_val, cipso_len, hdr_len_actual, new_hdr_len_actual, new_h=
dr_len,
> -           hdr_len_delta;
> +           hdr_len_delta, optlen;
>         struct iphdr *iph;
>         struct ip_options *opt =3D &IPCB(skb)->opt;
>         unsigned char *cipso_ptr;
> @@ -2266,9 +2277,12 @@
>         cipso_ptr =3D (unsigned char *)iph + opt->cipso;
>         cipso_len =3D cipso_ptr[1];
>
> -       hdr_len_actual =3D sizeof(struct iphdr) +
> -                        cipso_v4_get_actual_opt_len((unsigned char *)(ip=
h + 1),
> -                                                    opt->optlen);
> +       optlen =3D cipso_v4_get_actual_opt_len((unsigned char *)(iph + 1)=
,
> +                                            opt->optlen);
> +       /* malformed option stream, leave the packet unchanged */
> +       if (optlen < 0)
> +               return -EINVAL;
> +       hdr_len_actual =3D sizeof(struct iphdr) + optlen;
>         new_hdr_len_actual =3D hdr_len_actual - cipso_len;
>         new_hdr_len =3D (new_hdr_len_actual + 3) & ~3;
>         hdr_len_delta =3D (iph->ihl << 2) - new_hdr_len;
>

--=20
paul-moore.com
