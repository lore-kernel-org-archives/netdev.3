Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793254526;
	b=W1tOkLLFiD+wEuPv1r3HJvBc56Y1h7gP3V0HVfFupTijSZUqMK9maFOyUslj1WU51xVY
	 krVc8BkoOINmaTWFs6kleLZesgPREIpmrbbaEfo+1jZJlTuXrOLTuxjCPUzrxa06mgvCC
	 FGGHKeunOYg5yXblMSj/it4LdEPp/8USbGlJFuHIrh54yejve4y9x9N3shO2w/CXkBEEd
	 dDM/7hgDomCzSQXH14dvRM5YoQz93+TjGR39y27SQEIJe9caX8DikbGmVmp+gOv8V3OXq
	 nsScPAQZ5wPRKgKFZwnRvgNlk4OWe0sVRsj+X11+rxwY004RgEo0sH6kt0LpVd+TKyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254526;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=hlXUlmAZeFecvuV1q2DBRLavuFogYcD1E34+IOZTiQk=;
	b=WWr8EOXHkyhZxVn9lJ2joijZZpukuGONM+NFFs1l/JHLKoQQctjux47CjQOSgl1CvpQr
	 VSS5xT/HzqpOtHxH5EQd3urDZGpMSA3Mmz0ZpLHYTBh02+Qyy+WMFLs+fHMB6E0fcRd3p
	 xLP2ZEdoj5i3LeA0YIqouSjWruKfBM5E/8rdIF6eihU0bFPoO+fCQJnXt5gZnIUCFlky6
	 ZBVi+pieIhNKMmuhHFVhuLuK9H3G6V3axucYfL6nPP0r+NWNdaN/yy3fMcfSiEdE/Oa2t
	 bSmpD7W8+XN3hKewM7Ovhnsj68KNuu4bESsQaQpWM5GO2Zmjy70p88Gxl6QQFgqzwnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="yM4Tw/Qg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63965606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 06:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63965606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yM4Tw/Qg
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-843a4ca671eso886266a34.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 23:15:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793254524; cv=none;
        d=google.com; s=arc-20260327;
        b=rCo+f9/h7pNH1svoRMhU/2tDs6aD+dvZpihs6a/eDqcSVGoeY/0kvk3hG2mREcpIq0
         UgNxklmji0ubAnM2A4Zz0EZrE4yOBIyZdqXowLZadjRQcg/56W1qWJcl9I/lRAs3Zjq3
         dNwMDVqnMmUDfEybYd9+73c0mjZPSuJqVJGSbSSsHBsyAR49ChE7+o7PCREFPAmBPCrR
         NYvTWRG1JaHAHznJINL0Pt0gUOwxHQeJGyKWbg6SdQh7exPVx0FVZihXmDxj0+n4oI+U
         Lv1A9FShY3/G8gv3ytq9tRzzrAYBSeCPqeT6Sgw9T4+efh9KbgDCQg/5nbDV5DL1rG80
         SAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hlXUlmAZeFecvuV1q2DBRLavuFogYcD1E34+IOZTiQk=;
        fh=GVsdUoYSse6pUoYNgSphPv48tmYpzrNB980NPLA8DUg=;
        b=GVsh2zXw2JCeBFh7jccUYpaOPCjdER9o0X97XANYSALfgDKlH7+oZ/b2gr7/PC4/2d
         n2iyq+qBWmwEfZFmvIyBttj8rjACQBZFxue2XVINDA0FALn6zLdVETdWcrh2IQTgI9Ii
         IgOETOPkIvmzF4AuAnRAVjjTqPqp0P9MTxcGiW/4SK/knfp+MNkKHXVyPYI0Z7iKyeev
         AnP0nwZ+x0axs+AEG3ZyLylYzrOEDlXd+o/5a4T1MOs9cervgKE8GdhKTL9x8QyJaJW1
         WYdaGajAY65tVI4njn7H0vYBkVCA+i88Be+UYHgpLVVaeKcmQy0cO4pL5QCxjnfWMduv
         162g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793254524; x=1793859324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hlXUlmAZeFecvuV1q2DBRLavuFogYcD1E34+IOZTiQk=;
        b=yM4Tw/Qg+QfURwW6xCFnuUpnN+JQhclCM1J1OOhO+rWOCX9nQjBCpCKfrm/xxM9ddZ
         lAuVGxGIBs3Yb+2NvQzEBaU5RJ53WWBF2TWS1GdWvj5HQZp+5d6iLr3whIjOWCzspY6e
         6BKC6IjHpxN1nFwd7F9dJw37mYjw9XkWhU6K2bV+0feV35fvQO/d/dUJ717JhT6rg28R
         sEYGcR89awtDJIkFdY9wLRcpeqidijlF5UXxB93g5bBCowzEzbzuSHvBPqK7UM+K7wyB
         Fb9zrWmfL/cgMjoO7+xYFozQMl2gAjE0l6UlCpk8DM3Plqfj4KchvC4kpjeMl6sQpJ6Z
         Rknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793254524; x=1793859324;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hlXUlmAZeFecvuV1q2DBRLavuFogYcD1E34+IOZTiQk=;
        b=Nk7VVqwkwj0Tnr8/GnE9ICRNprnrBgBZ3VYxL3SFF8K51X/IXaqna6EL/oPUMVSnn2
         +PJAY9faxfX3XzRL6zNjW2LUtj78hCCpiz660Jc9KQMW0xswPglhHzrVNoqcYz2c9j22
         dBT4fdd9WbAZhpvO3NROJrkBrwZ0umz9q0dDSS8prTLkszEwNlyikv1sa/BD0moK84eN
         hbcfEIpc+/f1CM91njuWa5FnaROVPNFqoBtOmzYYGS64W8FmH9CeI3CNqsz3UsLDiwCY
         fARzdLDP0O1PPsi8fbXXbtXvcSweaCr42J83q3AdUUgjYhZDhUwI2mEi+vWBYzLuo/zc
         0fmw==
X-Gm-Message-State: AFq9FYLAU2SzMXoCGYc7tL+ZjRac00E+C3Nuig0cQgW4fJjfFba1O3e6
	LyhSZdtsEmTGJ0MI2CfwT0gK5bxLZMTkO/dUrMguv4+2INkLk9L8tbBXxhw22443rNcAEqfasAu
	Mm6vJK2XBr9LgNcCxsLA09TWRC+XY+f8=
X-Gm-Gg: AYBFou0LlzQDEoxnZnkHQZTzM2U1n47dYexrIRCUfoYg+xEz+a3d2G1doJVGYb4khdm
	Qk2yG6CvgmqaobuoTKVvpipIERj+/J29wcd0MHyXpApkoRyEhyN168g/twkcF8m29gEhdfrSpet
	2WYYJVGqeroCGOrUUrkJbnyoHn+RUJWKwq+J+NOGObDC6ziwvI3gaE/pGigetYYL+9TjvAiHClP
	nN2S7XhwU5UjjBmfesUgNiPqW0ujmDmgtGT9irxiUimW4gKFU7yPuSg7PGEH2T2IasLt6WBSode
	tEG1nakhbG4oK+oGvOGEW1aFNnWn7808nxCldkYP1NKGsgYmVplk17TKq0qglTcm/j6dM/v/7eV
	3YvF3nCZOBpx0D03SJyxFSH0b2gpr5vIgVJ45
X-Received: by 2002:a05:6808:1918:b0:4d6:90d4:6bc with SMTP id
 5614622812f47-56383495f89mr3760479b6e.46.1793254524218; Wed, 28 Oct 2026
 23:15:24 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CALf2hKvp0NPVLwr=a3+jUHtPohxbra8gox+aYAfWathJnn-J+Q@mail.gmail.com>
 <CAL4WiiqFJpmcV4=TWRpukCq6q=-729658FwGvieNcPXe97kLvQ@mail.gmail.com>
In-Reply-To: <CAL4WiiqFJpmcV4=TWRpukCq6q=-729658FwGvieNcPXe97kLvQ@mail.gmail.com>
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Date: Thu, 29 Oct 2026 14:15:11 +0800
X-Gm-Features: AclHuK_edMmHQ1epZd7QAIVCRjGbDwsmwxm0gSBxIVJbhVsndxR3jop-YBD9VB0
Message-ID: <CALf2hKtiCaiabDQGpm+jzy7VKgMr78eQTKGsN10aXp0JfaOhLA@mail.gmail.com>
Subject: Re: [BUG] tcp: cross-family IPv4 option echo stack overwrite
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	dsahern@kernel.org, idosch@nvidia.com, brauner@kernel.org, 
	dhowells@redhat.com, security@kernel.org, lyutoon@gmail.com, 
	tpluszz77@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric, Kuniyuki,

I kept Eric's tcp_ipv6.c change unchanged and added the missing MPTCP
coverage. Two MPTCP paths called tcp_disconnect() directly, bypassing the
protocol-specific disconnect callback. The changes below route them through
ssk->sk_prot->disconnect(), so IPv6 subflows run tcp_v6_disconnect() as
well.

I tested the combined change on net.git at 94cea342e891 with both TCP and
MPTCP by reconnecting an AF_INET6 socket from a v4-mapped peer to a native
IPv6 peer after connect(AF_UNSPEC).

The related watch_queue report and patch are:

Report: https://lore.kernel.org/lkml/CALf2hKveij_sHgANY9Aktm1dPa4wfKjKNkHyp=
9yPbjORWFXagA@mail.gmail.com/
Patch: https://lore.kernel.org/lkml/20261029054136.1174216-1-zhiyuzhang999@=
gmail.com/

I have not posted a standalone [PATCH net] to avoid duplicating Kuniyuki's
work. If you would like me to submit this completed version, I can send it
right away:

From ffa42bc88b0221619f6eadb3a7f5c38328a258cb Mon Sep 17 00:00:00 2001
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Date: Thu, 29 Oct 2026 01:58:37 -0400
Subject: [PATCH] tcp: restore IPv6 af_ops on disconnect of a v4-mapped sock=
et

A successful connect() of an IPv6 socket to a v4-mapped address switches
icsk_af_ops, sk_backlog_rcv and af_specific to their IPv4-mapped variants.
These are only restored if the connect() fails.

After connect(AF_UNSPEC), the socket can be reused for listen() or for a
native IPv6 connect while still using the mapped handlers. IPv6 packets
processed from the socket backlog are then handled by tcp_v4_do_rcv().
tcp_v4_send_reset() and tcp_v4_send_ack() interpret
TCP_SKB_CB(skb)->header.h6 as IPv4 options, and __ip_options_echo() can
overflow its 40-byte destination buffer.

Commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between ehash
and lhash2.") prevents listen() after connect(AF_UNSPEC), but a native IPv6
connect is still allowed.

Add tcp_v6_disconnect() to restore the IPv6 handlers when a v4-mapped
socket is disconnected, and use the same helper in the connect error path.

MPTCP subflows override sk_prot, and two teardown paths call
tcp_disconnect() directly. Route those calls through the protocol-specific
disconnect operation so IPv6 MPTCP subflows receive the same restoration.

Tested with TCP and MPTCP by reconnecting an AF_INET6 socket from a
v4-mapped peer to a native IPv6 peer after connect(AF_UNSPEC).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Tong Liu <lyutoon@gmail.com>
Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Closes: https://lore.kernel.org/netdev/CALf2hKvp0NPVLwr=3Da3+jUHtPohxbra8go=
x+aYAfWathJnn-J+Q@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CAL4WiiqFJpmcV4=3DTWRpukCq6q=3D-729658=
FwGvieNcPXe97kLvQ@mail.gmail.com/
Link: https://lore.kernel.org/lkml/20261029054136.1174216-1-zhiyuzhang999@g=
mail.com/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Co-developed-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
---
 net/ipv6/tcp_ipv6.c  | 37 ++++++++++++++++++++++++++++---------
 net/mptcp/protocol.c |  4 ++--
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e006a30360ea..a93410aab66e 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -130,6 +130,19 @@ static int tcp_v6_pre_connect(struct sock *sk,
struct sockaddr_unsized *uaddr,
        return BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, &addr_len);
 }

+/* Undo the v4-mapped setup done by tcp_v6_connect(). */
+static void tcp_v6_restore_af_ops(struct sock *sk)
+{
+       /* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
+       WRITE_ONCE(inet_csk(sk)->icsk_af_ops, &ipv6_specific);
+       if (sk_is_mptcp(sk))
+               mptcpv6_handle_mapped(sk, false);
+       sk->sk_backlog_rcv =3D tcp_v6_do_rcv;
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
+       tcp_sk(sk)->af_specific =3D &tcp_sock_ipv6_specific;
+#endif
+}
+
 static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
                          int addr_len)
 {
@@ -243,14 +256,7 @@ static int tcp_v6_connect(struct sock *sk, struct
sockaddr_unsized *uaddr,

                if (err) {
                        icsk->icsk_ext_hdr_len =3D exthdrlen;
-                       /* Paired with READ_ONCE() in tcp_(get|set)sockopt(=
) */
-                       WRITE_ONCE(icsk->icsk_af_ops, &ipv6_specific);
-                       if (sk_is_mptcp(sk))
-                               mptcpv6_handle_mapped(sk, false);
-                       sk->sk_backlog_rcv =3D tcp_v6_do_rcv;
-#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
-                       tp->af_specific =3D &tcp_sock_ipv6_specific;
-#endif
+                       tcp_v6_restore_af_ops(sk);
                        goto failure;
                }
                np->saddr =3D sk->sk_v6_rcv_saddr;
@@ -2093,6 +2099,19 @@ static int tcp_v6_init_sock(struct sock *sk)
        return 0;
 }

+static int tcp_v6_disconnect(struct sock *sk, int flags)
+{
+       int ret =3D tcp_disconnect(sk, flags);
+
+       /* A socket used for a v4-mapped connection must not keep IPv4
+        * handlers when it is reused for listen() or a native IPv6 connect=
().
+        */
+       if (sk->sk_backlog_rcv =3D=3D tcp_v4_do_rcv)
+               tcp_v6_restore_af_ops(sk);
+
+       return ret;
+}
+
 #ifdef CONFIG_PROC_FS
 /* Proc filesystem TCPv6 sock list dumping. */
 static void get_openreq6(struct seq_file *seq,
@@ -2283,7 +2302,7 @@ struct proto tcpv6_prot =3D {
        .close                  =3D tcp_close,
        .pre_connect            =3D tcp_v6_pre_connect,
        .connect                =3D tcp_v6_connect,
-       .disconnect             =3D tcp_disconnect,
+       .disconnect             =3D tcp_v6_disconnect,
        .accept                 =3D inet_csk_accept,
        .ioctl                  =3D tcp_ioctl,
        .init                   =3D tcp_v6_init_sock,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7a22e9388e0e..fdfbc7de2ec0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2608,7 +2608,7 @@ static void __mptcp_subflow_disconnect(struct sock *s=
sk,
                /* The MPTCP code never wait on the subflow sockets, TCP-le=
vel
                 * disconnect should never fail
                 */
-               WARN_ON_ONCE(tcp_disconnect(ssk, 0));
+               WARN_ON_ONCE(ssk->sk_prot->disconnect(ssk, 0));
                mptcp_subflow_ctx_reset(subflow);
        } else {
                tcp_shutdown(ssk, SEND_SHUTDOWN);
@@ -3287,7 +3287,7 @@ void mptcp_subflow_shutdown(struct sock *sk,
struct sock *ssk, int how)
                        break;
                fallthrough;
        case TCP_SYN_SENT:
-               WARN_ON_ONCE(tcp_disconnect(ssk, O_NONBLOCK));
+               WARN_ON_ONCE(ssk->sk_prot->disconnect(ssk, O_NONBLOCK));
                break;
        default:
                if (__mptcp_check_fallback(mptcp_sk(sk))) {
--
2.34.1

Thanks,
Zhiyu

Eric Dumazet <edumazet@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8829=E6=
=97=A5=E5=91=A8=E5=9B=9B 00:22=E5=86=99=E9=81=93=EF=BC=9A
>
> Le mer. 28 oct. 2026 =C3=A0 16:31, Zhiyu Zhang <zhiyuzhang999@gmail.com> =
a =C3=A9crit :
> >
> > Hello Linux Kernel Developers and Maintainers,
> >
> > We found a TCP address-family mismatch that lets an IPv6 packet reach a=
n IPv4
> > reply path. The IPv4 path interprets IPv6 skb control-block fields as I=
Pv4
> > options and copies a packet-controlled length into a 40-byte stack buff=
er. We
> > used it as the write primitive in a demonstrated unprivileged uid-to-ro=
ot
> > chain.
> >
> > The complete path is present in v7.3
> > (c03c1a14507dfaf8b856c2608f9ac216021fc222), where we reproduced the
> > privilege escalation with KASLR, STACKPROTECTOR_STRONG, PTI and IBT ena=
bled.
> > It is also present by inspection in v6.12.95. CONFIG_IPV6 is required.
> >
> > Current mainline d135ab453a7400a34930bdda1ef4bdc8acfac80e contains
> > 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between ehash and
> > lhash2."), which rejects the exact socket transition used by our reprod=
ucer.
> > We therefore do not claim that the complete chain works at that mainlin=
e
> > revision. The unsafe cross-family option handling and unbounded option =
echo
> > remain relevant to maintained trees without that transition restriction=
.
> >
> > Root cause:
> >
> > tcp_v6_connect() changes icsk_af_ops and sk_backlog_rcv to the mapped-I=
Pv4
> > implementations after a successful v4-mapped connect. On affected kerne=
ls,
> > connect(AF_UNSPEC) returns the socket to TCP_CLOSE without restoring th=
ose
> > pointers, and listen() reuses it. A pure-IPv6 accepted child can conseq=
uently
> > have IPv6 lookup state but tcp_v4_do_rcv as its backlog callback.
> >
> > For an [IPv6][DSTOPTS][TCP] packet, tcp_v6_fill_cb() stores inet6_skb_p=
arm in
> > TCP_SKB_CB(skb)->header.h6. If the packet is drained through tcp_v4_do_=
rcv(),
> > tcp_v4_send_reset() passes the same union bytes as header.h4.opt. The a=
liased
> > metadata directs __ip_options_echo() to read a packet-controlled option=
 length
> > and copy it into the 40-byte dopt->__data buffer. Our trigger produces =
a
> > 254-byte overwrite across the canary and return address in
> > ip_send_unicast_reply().
> >
> > The receiving process runs as uid 65534 without capabilities or a user
> > namespace. A root helper is used only to inject the crafted IPv6 packet=
 with
> > a raw socket inside our single-VM test; the packet may instead arrive f=
rom an
> > IPv6 peer.
> >
> > This is the memory-corruption half of the demonstrated privilege-escala=
tion
> > chain. A separately reported watch_queue disclosure supplies the same t=
ask's
> > stack canary and KASLR slide. We will reply with that report's Message-=
ID as
> > soon as it has been posted.
> >
> > Reproduction and fix:
> >
> > We have a source reproducer, exact config, QEMU instructions and a full=
-chain
> > exploit. In accordance with the kernel policy, we are not posting them =
publicly.
> > We can provide the source-only reproducer privately if a maintainer req=
uests it.
> >
> > Our build- and QEMU-tested fix has two layers: the IPv4 TCP reset and A=
CK paths
> > only pass IPv4 option state for ETH_P_IP skbs, and __ip_options_echo() =
validates
> > each option against the declared source area, the actual skb header are=
a and
> > the remaining destination space. We will post it separately as a mergea=
ble
> > [PATCH net] email and link that thread here.
> >
> > AI-agent tooling assisted in identifying and analyzing the issue, devel=
oping
> > the reproducer, and preparing the initial fix. The reporters reviewed t=
he
> > affected paths and reproduced the issue and the fixed result in QEMU.
> >
> > Reported-by: Tong Liu <lyutoon@gmail.com>
> > Reported-by: Qi Tang <tpluszz77@gmail.com>
> > Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> >
> > Best regards,
> > Zhiyu Zhang
>
> Worst report I got this week, and trust me I got many security reports
> in the last 3 days
>
> Why don't you ask your LLM to prepare a patch ?
>
> Why CCing security@ at all, since you made this report public ?
>
> Have you read Documentation/process/security-bugs.rst ?
>
> MPTCP is not yet covered in this untested WIP:
>
> Kuniyuki, can you take over, thanks.
>
> commit 5108a64604b6f2fad06383386d8d5bc44f0cf35b (HEAD -> net-4)
> Author: Eric Dumazet <edumazet@kernel.org>
> Date:   Wed Oct 28 17:14:04 2026 +0100
>
>     tcp: restore IPv6 af_ops on disconnect of a v4-mapped socket
>
>     A successful connect() of an IPv6 socket to a v4-mapped address
>     switches icsk_af_ops, sk_backlog_rcv and af_specific to their
>     IPv4-mapped variants. These are only restored if the connect() fails.
>
>     After connect(AF_UNSPEC), the socket can be reused for listen() or
>     for a native IPv6 connect(), while still using the mapped handlers.
>     IPv6 packets processed from the socket backlog are then handled by
>     tcp_v4_do_rcv(). tcp_v4_send_reset() and tcp_v4_send_ack() interpret
>     TCP_SKB_CB(skb)->header.h6 as IPv4 options, and __ip_options_echo()
>     can overflow its 40-byte destination buffer.
>
>     Commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between
>     ehash and lhash2.") prevents listen() after connect(AF_UNSPEC), but
>     a native IPv6 connect() is still allowed.
>
>     Add tcp_v6_disconnect() to restore the IPv6 handlers when a v4-mapped
>     socket is disconnected, and use the same helper in the connect()
>     error path.
>
>     Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>     Reported-by: Tong Liu <lyutoon@gmail.com>
>     Reported-by: Qi Tang <tpluszz77@gmail.com>
>     Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
>     Signed-off-by: Eric Dumazet <edumazet@kernel.org>
>
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index e006a30360eae1b43a4d53173b46b931ae668825..a93410aab66e6f441d70cf70c=
67e6d92fbb5fb26
> 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -130,6 +130,19 @@ static int tcp_v6_pre_connect(struct sock *sk,
> struct sockaddr_unsized *uaddr,
>         return BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, &addr_len);
>  }
>
> +/* Undo the v4-mapped setup done by tcp_v6_connect(). */
> +static void tcp_v6_restore_af_ops(struct sock *sk)
> +{
> +       /* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
> +       WRITE_ONCE(inet_csk(sk)->icsk_af_ops, &ipv6_specific);
> +       if (sk_is_mptcp(sk))
> +               mptcpv6_handle_mapped(sk, false);
> +       sk->sk_backlog_rcv =3D tcp_v6_do_rcv;
> +#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
> +       tcp_sk(sk)->af_specific =3D &tcp_sock_ipv6_specific;
> +#endif
> +}
> +
>  static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uadd=
r,
>                           int addr_len)
>  {
> @@ -243,14 +256,7 @@ static int tcp_v6_connect(struct sock *sk, struct
> sockaddr_unsized *uaddr,
>
>                 if (err) {
>                         icsk->icsk_ext_hdr_len =3D exthdrlen;
> -                       /* Paired with READ_ONCE() in tcp_(get|set)sockop=
t() */
> -                       WRITE_ONCE(icsk->icsk_af_ops, &ipv6_specific);
> -                       if (sk_is_mptcp(sk))
> -                               mptcpv6_handle_mapped(sk, false);
> -                       sk->sk_backlog_rcv =3D tcp_v6_do_rcv;
> -#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
> -                       tp->af_specific =3D &tcp_sock_ipv6_specific;
> -#endif
> +                       tcp_v6_restore_af_ops(sk);
>                         goto failure;
>                 }
>                 np->saddr =3D sk->sk_v6_rcv_saddr;
> @@ -2093,6 +2099,19 @@ static int tcp_v6_init_sock(struct sock *sk)
>         return 0;
>  }
>
> +static int tcp_v6_disconnect(struct sock *sk, int flags)
> +{
> +       int ret =3D tcp_disconnect(sk, flags);
> +
> +       /* A socket used for a v4-mapped connection must not keep IPv4
> +        * handlers when it is reused for listen() or a native IPv6 conne=
ct().
> +        */
> +       if (sk->sk_backlog_rcv =3D=3D tcp_v4_do_rcv)
> +               tcp_v6_restore_af_ops(sk);
> +
> +       return ret;
> +}
> +
>  #ifdef CONFIG_PROC_FS
>  /* Proc filesystem TCPv6 sock list dumping. */
>  static void get_openreq6(struct seq_file *seq,
> @@ -2283,7 +2302,7 @@ struct proto tcpv6_prot =3D {
>         .close                  =3D tcp_close,
>         .pre_connect            =3D tcp_v6_pre_connect,
>         .connect                =3D tcp_v6_connect,
> -       .disconnect             =3D tcp_disconnect,
> +       .disconnect             =3D tcp_v6_disconnect,
>         .accept                 =3D inet_csk_accept,
>         .ioctl                  =3D tcp_ioctl,
>         .init                   =3D tcp_v6_init_sock,
