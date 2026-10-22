Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682814;
	b=HGl8I9FS25fntqUGUIgQyY10JrOEK8NaumWN6ajZEZilAlNcEsga2J+eIgd/mFd7wup0
	 m7wq1rI35Y7xXvjIWFMraga3Cu1k2VQlEL7ZnRFrAdqaQnFI5pdH2tIVPy+xtxJIPyog1
	 /cI71rSsNfSb16jeCamL+byeZhh8JHjHfA2r6MYVhafjlBd9qxlMA8AIhYi0KVL8NEJsm
	 aKJN0MKraK/7aYLPFXVPz98CMmPHucbjeEr6t4qGYzeL+D8J/e/PXBBWOwcfkIbDp5R/p
	 ndJBYCe3YJagqzv+crqGjEcx8dj0BXWo8yUzpO8h2B484xxj83QPtEhzzub4Q0FcrkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682814;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mnm90cT9fJ9yIzn1u2BOkgljm5HClP1epGLUsBPzh9w=;
	b=JbaCWRZPHwvyzt3XzUnIRhqqRdklIgnEpP7iiR4I6AHqR3GIN7qLLf8h4jRcFp6Kuudy
	 29hwr9pztj5hyoIctM2DP2gLwT8trtdXemyQihMS2IIOXo7LkCOcFtK11yqVfUTF+ogVI
	 oT3VeDYY2f9z6A5yamZC79mFjSlHST4ZxcFo3kxiUBG7PCPCS8kZ+n/aL+cPiAF6+I90t
	 kLIN56jYxajP3C88yNW4IsBpHNKf4a9xexr2FrgEyR0eU2eGiDDCZXyKEESNVKi/WH2BH
	 1jT0ve9hIOL3bwaR4ycQysNSbatzUdEide9aBaWe8TSbBOo724Hw9p2a5M3NRQKn0Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2SqXrhv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91162606A31B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2SqXrhv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4162F1F031E5
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682813;
	bh=mnm90cT9fJ9yIzn1u2BOkgljm5HClP1epGLUsBPzh9w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=g2SqXrhvkHcTy1RGQkIhWO0tEkf3+v8Cz7qZVL1CVdFMmFt+Qh8jCchOmUHf8widV
	 fXKUPKDE1a4rKIHfH69ZmlctoApdZkVP3SMmzOr+GVBSNwHxGFB6FlbMO6jq/fkbUA
	 pRd4xSvQ+y26F9iwMdJsYbxS/AQUoHXeqj7e5/zH89hje1MXiTda+bs7OCWy06rxqc
	 Is2+m0V0AQRDbtAV/E0aCtuY4/Do8I3ufGdIo+N6ChVqs0Gb6hOvE3sKfeiUUlk0Za
	 NT6A91HBB8kHPlf++rrCJXx6IF2oA+zLWy9Jm8nJxm39xDgGMR+oetAiuRT4XbRYde
	 p0KopnEwxPujw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a5a26c8412so20642701fa.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:26:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBySa4zGD9QwqcM3yZDKqvJytupiBsBxcC8hWOdZtFpp0UeoRRXpWsPDkBqQDNoS/8FGZoh4C4s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLlqA4iP1+Q6kcH+V9dE2QZ04VO+t8tDgb/PcjGPhw1rLxupz96
	tf7LI+TjEEYmLJOPsTG/jzLzMwdvL9aQypw1UmTfaxHMJ1LqYJSKB4fIH+2Vo44tJ2Mc9He+s7h
	MczV/QXaQ6R5MhwtWKMwcSM0mw44Rne8=
X-Received: by 2002:a2e:b889:0:b0:3a5:e792:2dc8 with SMTP id
 38308e7fff4ca-3ac4418feb1mr16883001fa.16.1792682811916; Thu, 22 Oct 2026
 08:26:51 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022144755.65025-1-shawnq1@163.com> <CAL4WiipjAy2M5kok3bkB1Ny=9ryJvrWkt1jz_awuSoPY3Nx_vQ@mail.gmail.com>
In-Reply-To: <CAL4WiipjAy2M5kok3bkB1Ny=9ryJvrWkt1jz_awuSoPY3Nx_vQ@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 22 Oct 2026 17:26:37 +0200
X-Gmail-Original-Message-ID: <CAL4WiiqAeS8p-UWhiZwAG9sDmsrqWT+yataW0QiomQ-63m0SVg@mail.gmail.com>
X-Gm-Features: AclHuK-atW4cgN6Ufa7vK0c8jno8uTekEFo8Aretgm_gWVP5hjCdSvfweoV_oPI
Message-ID: <CAL4WiiqAeS8p-UWhiZwAG9sDmsrqWT+yataW0QiomQ-63m0SVg@mail.gmail.com>
Subject: Re: [BUG] net/sched: malformed UFO GSO geometry can soft-lock DRR dequeue
To: shaos <shawnq1@163.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 22 oct. 2026 =C3=A0 16:57, Eric Dumazet <edumazet@kernel.org> a =C3=
=A9crit :
>
> Le jeu. 22 oct. 2026 =C3=A0 16:48, shaos <shawnq1@163.com> a =C3=A9crit :
> >
> > Hello,
> >
> > A PACKET_VNET_HDR AF_PACKET send supplies UFO GSO with gso_size=3D1 and=
 hdr_len=3D65532 for a 524275-byte frame. qdisc_pkt_len_segs_init() compute=
s an accounted length of 4,294,574,091 bytes. With DRR quantum 256, the deq=
ueue path needs about 16.8 million deficit refills before it can dequeue th=
e skb, keeping the CPU in the qdisc path long enough to trigger the soft-lo=
ckup watchdog.
> >
> > HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
> > git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
> > source version: Linux 7.3.0, local master
> > compiler:       gcc 11.4.0, GNU ld 2.38
> >
> > console output:
> > https://gist.githubusercontent.com/shaos26/8a4f7f445aa23601bfe8e04f9c6a=
5202/raw/f4ca89881f7b8163ddea72fbc54b204385142bb8/console-output.txt
> > user-namespace positive output:
> > https://gist.githubusercontent.com/shaos26/8a4f7f445aa23601bfe8e04f9c6a=
5202/raw/14de8e3a06e7e73c540ebf408e73d301bae3922d/userns-positive.log
> > kernel config:
> > https://gist.githubusercontent.com/shaos26/8a4f7f445aa23601bfe8e04f9c6a=
5202/raw/6ea0e3da68f1e239d565c64f7906d0f9c73bf784/kernel-config.txt
> > reproducer sources:
> > https://gist.githubusercontent.com/shaos26/e2add470a38b7aab41f2b79ef021=
accf/raw/7153646b9233fa53aca81c9af879d48e8f95dd80/poc.c
> > https://gist.githubusercontent.com/shaos26/e2add470a38b7aab41f2b79ef021=
accf/raw/e8acddd986023c10a43b5106b4734a456a063deb/drop_priv.c
> >
> > Build the tested kernel with the attached configuration and boot a disp=
osable QEMU guest. Compile the linked userspace reproducer and privilege-dr=
op helper, then run the AF_PACKET/VNET_HDR test from a fresh user/network n=
amespace.
> >
> > Impact and prerequisites:
> > A process with only namespace-scoped CAP_NET_ADMIN and CAP_NET_RAW can =
keep a CPU in the DRR dequeue path long enough to trigger a host soft-locku=
p. With softlockup_panic=3D1, as used in the test configuration, the watchd=
og panics the kernel. This is a local denial-of-service issue; no memory co=
rruption or privilege escalation is demonstrated.
> >
> > Validation: Two fresh positives reproduced the soft lockup, including o=
ne run from an unprivileged UID mapped to namespace UID 0. The same-frame n=
on-GSO control completed in milliseconds.
> >
> > Thanks,
> >
>
> Related recent work:
>
> commit 8f735d64382dcf162f4276d6699d03ad2f859c0b
> Author: Jamal Hadi Salim <jhs@mojatatu.com>
> Date:   Tue Aug 25 04:14:03 2026 -0400
>
>     net/sched: bound qdisc_pkt_len to prevent qdisc soft lockup

Something like:

commit b30c29ab2b07fa54bf9f3e73984f441f4151ba87
Author: Eric Dumazet <edumazet@kernel.org>
Date:   Thu Oct 22 17:19:07 2026 +0200

    net: harden qdisc_pkt_len_segs_init() against malicious GSO packets

    An SKB_GSO_DODGY packet can carry untrusted gso_size and headers.

    For instance, gso_size=3D1 and hdr_len=3D65532 for a 524275-byte frame
    makes qdisc_pkt_len_segs_init() compute an accounted length of
    about 4,294,574,091 bytes (after gso_segs silently wrapped in a u16).

    With DRR quantum 256, the dequeue path then needs ~16.8 million
    deficit refills before it can dequeue the skb, keeping the CPU in
    the qdisc path long enough to trigger the soft-lockup watchdog.

    Commit 8f735d64382d ("net/sched: bound qdisc_pkt_len to prevent
    qdisc soft lockup") added QDISC_PKT_LEN_MAX to bound size table
    amplification. Use the same bound for DODGY packets:

    - Make gso_segs a u32 and drop packets whose segment count does
      not fit GSO_MAX_SEGS, instead of silently truncating it.

    - Drop packets whose estimated qdisc_pkt_len() would exceed
      QDISC_PKT_LEN_MAX.

    Fixes: 15e5a0307164 ("net_sched: better precise estimation on
packet length for untrusted packets")
    Reported-by: shawnq1@163.com
    Closes: https://lore.kernel.org/netdev/20261022144755.65025-1-shawnq1@1=
63.com/
    Signed-off-by: Eric Dumazet <edumazet@kernel.org>

diff --git a/net/core/dev.c b/net/core/dev.c
index e76762e29360ea87ade0846e4a4f9016dca587d6..573bcc9d67b1b1e21e844f054f0=
b51a172713a90
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4175,7 +4175,7 @@ static enum skb_drop_reason
qdisc_pkt_len_segs_init(struct sk_buff *skb)
 {
        struct skb_shared_info *shinfo =3D skb_shinfo(skb);
        unsigned int hdr_len, tlen;
-       u16 gso_segs;
+       u32 gso_segs;

        qdisc_skb_cb(skb)->pkt_len =3D skb->len;
        if (!shinfo->gso_size) {
@@ -4226,6 +4226,15 @@ static enum skb_drop_reason
qdisc_pkt_len_segs_init(struct sk_buff *skb)
                if (payload <=3D 0)
                        return SKB_DROP_REASON_SKB_BAD_GSO;
                gso_segs =3D DIV_ROUND_UP(payload, shinfo->gso_size);
+               /* shinfo->gso_segs is a 16bit field.
+                * Also make sure untrusted gso_size/hdr_len can not inflat=
e
+                * qdisc_pkt_len() beyond QDISC_PKT_LEN_MAX, or deficit
+                * schedulers could spin in their refill loops.
+                */
+               if (unlikely(gso_segs > GSO_MAX_SEGS ||
+                            skb->len + (u64)(gso_segs - 1) * hdr_len >
+                            QDISC_PKT_LEN_MAX))
+                       return SKB_DROP_REASON_SKB_BAD_GSO;
                shinfo->gso_segs =3D gso_segs;
                qdisc_skb_cb(skb)->pkt_segs =3D gso_segs;
        }
