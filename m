Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204560;
	b=dBSS2ZFXB4WTz/JT+gN5Jn1rr37qpsQmQdWSVUanSWZHLpwegHJLaHRlXetMSznxXoxh
	 L+2AqMVEcwR9sgDptQdRaL/4vtSgNTmG+pBABHxF6ZXpAEDNMalZzXkROSBM1WSifibRA
	 awYCxUEhDag32U/OO/OlQnODAL5Kpl1nkMZjBA2DNNxWCwZa8wAqpyX8kBgFgNuh8/QBU
	 wCu3LEdRZLViPK6crtfu39EX0D6IViO8I8XXN+cYDGR5StdE4cC3oLAQfECbuiLbwpFVE
	 0ACWzh73nZzfoq3zzKSr0smXw4U+YwZhvMk3hqLQzPP3crRItHuWxOXXbdf+XOWL6RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204560;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=LPnEsZ87SQg7JuBssg3knDigJumxWAPQLrNmp7RbkGU=;
	b=iyYyPjY02CeNyr/GsJDL7iC9Qmit5d2ovXl4toScDDn+u+uat4gy+otpfFL+ImPzvuMc
	 lDafti96KZgVcN4217mFP8Y1mzsRRv/SrUXELmuvlCXjbLPXL0S0YAjE+TUQ/XbDt+4J7
	 T/OiE3l3EdLztJZ2cr4/jvk1mvAVJtb/mzCZDDIQp1QmnEGqIDQ5loE9HZiHf1eo+sb+h
	 ZpneQLN2VUJmqNtGsUqZigxWQv3KnpEHcJFDDjNpdc0RBT9EW7SHs5I48mJMptPLbEOOr
	 8hd6kgKseHdgcs+uMeaeQ7Ow4PugLBEBkbKByB9z139swpk1BJISrpFClZZgkmZX6pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3XCKkFg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B257606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3XCKkFg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4CE1F01825
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793204558;
	bh=LPnEsZ87SQg7JuBssg3knDigJumxWAPQLrNmp7RbkGU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Q3XCKkFgPHPKp6gqmQKsJwRqQJuSfwVNKgMJw929jSWeA3EeDHYgisCRIepBEMPXt
	 z/wAJH9jCTH6WxqPx3Z5G/pdCB5Cz5i2ma8z9R/EpRUHtsuUWAFWbJozYHoSixDAmu
	 IsTVUvNO5gQgHsVzET0rEW0c+dgdoDZ8NmMbdGFcRwyM0FguLQkhYO9/OaE+M8RXuH
	 YPqpfgszyqeDJ6vOFNwydL2edVQ6+xF/dCncrhGFqv/fMS24Csz7YMiwzRsC83vdtb
	 mGRn0T7Wp25MKwSS7rpDV4qYIIxExX0WrOuTmJbSu8y6BjGMiZ4w3v/DEYFufMW06M
	 AYl9JNASNYKLg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4a6f2825dd6so347185fac.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:22:38 -0700 (PDT)
X-Gm-Message-State: AFq9FYIBee+CzIaq5i83XhWfxZhbk5FCQ4QJsmtcGicJntbNO2UhCNdM
	5YlP+nNDrT0hvu89ta4qekMxBWTeQRloiMA8oKeWfgUymNq3Z75iKYRPHWw1pc+6Mj3LOPpapsW
	VLZvMI5MqKGZvaofDlqi6HLQof7HOEaA=
X-Received: by 2002:a05:6870:1410:b0:48f:e21e:1e7b with SMTP id
 586e51a60fabf-4a8bb5cd6bbmr1938619fac.59.1793204558218; Wed, 28 Oct 2026
 09:22:38 -0700 (PDT)
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
In-Reply-To: <CALf2hKvp0NPVLwr=a3+jUHtPohxbra8gox+aYAfWathJnn-J+Q@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 28 Oct 2026 17:22:26 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqFJpmcV4=TWRpukCq6q=-729658FwGvieNcPXe97kLvQ@mail.gmail.com>
X-Gm-Features: AclHuK9Ib5neXJt_tER1R8PJmj4tWIK_9yLZR_Pwu3If9gy_DONTRjPsPWsSK5s
Message-ID: <CAL4WiiqFJpmcV4=TWRpukCq6q=-729658FwGvieNcPXe97kLvQ@mail.gmail.com>
Subject: Re: [BUG] tcp: cross-family IPv4 option echo stack overwrite
To: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	dsahern@kernel.org, idosch@nvidia.com, brauner@kernel.org, 
	dhowells@redhat.com, security@kernel.org, lyutoon@gmail.com, 
	tpluszz77@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 28 oct. 2026 =C3=A0 16:31, Zhiyu Zhang <zhiyuzhang999@gmail.com> a =
=C3=A9crit :
>
> Hello Linux Kernel Developers and Maintainers,
>
> We found a TCP address-family mismatch that lets an IPv6 packet reach an =
IPv4
> reply path. The IPv4 path interprets IPv6 skb control-block fields as IPv=
4
> options and copies a packet-controlled length into a 40-byte stack buffer=
. We
> used it as the write primitive in a demonstrated unprivileged uid-to-root
> chain.
>
> The complete path is present in v7.3
> (c03c1a14507dfaf8b856c2608f9ac216021fc222), where we reproduced the
> privilege escalation with KASLR, STACKPROTECTOR_STRONG, PTI and IBT enabl=
ed.
> It is also present by inspection in v6.12.95. CONFIG_IPV6 is required.
>
> Current mainline d135ab453a7400a34930bdda1ef4bdc8acfac80e contains
> 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between ehash and
> lhash2."), which rejects the exact socket transition used by our reproduc=
er.
> We therefore do not claim that the complete chain works at that mainline
> revision. The unsafe cross-family option handling and unbounded option ec=
ho
> remain relevant to maintained trees without that transition restriction.
>
> Root cause:
>
> tcp_v6_connect() changes icsk_af_ops and sk_backlog_rcv to the mapped-IPv=
4
> implementations after a successful v4-mapped connect. On affected kernels=
,
> connect(AF_UNSPEC) returns the socket to TCP_CLOSE without restoring thos=
e
> pointers, and listen() reuses it. A pure-IPv6 accepted child can conseque=
ntly
> have IPv6 lookup state but tcp_v4_do_rcv as its backlog callback.
>
> For an [IPv6][DSTOPTS][TCP] packet, tcp_v6_fill_cb() stores inet6_skb_par=
m in
> TCP_SKB_CB(skb)->header.h6. If the packet is drained through tcp_v4_do_rc=
v(),
> tcp_v4_send_reset() passes the same union bytes as header.h4.opt. The ali=
ased
> metadata directs __ip_options_echo() to read a packet-controlled option l=
ength
> and copy it into the 40-byte dopt->__data buffer. Our trigger produces a
> 254-byte overwrite across the canary and return address in
> ip_send_unicast_reply().
>
> The receiving process runs as uid 65534 without capabilities or a user
> namespace. A root helper is used only to inject the crafted IPv6 packet w=
ith
> a raw socket inside our single-VM test; the packet may instead arrive fro=
m an
> IPv6 peer.
>
> This is the memory-corruption half of the demonstrated privilege-escalati=
on
> chain. A separately reported watch_queue disclosure supplies the same tas=
k's
> stack canary and KASLR slide. We will reply with that report's Message-ID=
 as
> soon as it has been posted.
>
> Reproduction and fix:
>
> We have a source reproducer, exact config, QEMU instructions and a full-c=
hain
> exploit. In accordance with the kernel policy, we are not posting them pu=
blicly.
> We can provide the source-only reproducer privately if a maintainer reque=
sts it.
>
> Our build- and QEMU-tested fix has two layers: the IPv4 TCP reset and ACK=
 paths
> only pass IPv4 option state for ETH_P_IP skbs, and __ip_options_echo() va=
lidates
> each option against the declared source area, the actual skb header area =
and
> the remaining destination space. We will post it separately as a mergeabl=
e
> [PATCH net] email and link that thread here.
>
> AI-agent tooling assisted in identifying and analyzing the issue, develop=
ing
> the reproducer, and preparing the initial fix. The reporters reviewed the
> affected paths and reproduced the issue and the fixed result in QEMU.
>
> Reported-by: Tong Liu <lyutoon@gmail.com>
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
>
> Best regards,
> Zhiyu Zhang

Worst report I got this week, and trust me I got many security reports
in the last 3 days

Why don't you ask your LLM to prepare a patch ?

Why CCing security@ at all, since you made this report public ?

Have you read Documentation/process/security-bugs.rst ?

MPTCP is not yet covered in this untested WIP:

Kuniyuki, can you take over, thanks.

commit 5108a64604b6f2fad06383386d8d5bc44f0cf35b (HEAD -> net-4)
Author: Eric Dumazet <edumazet@kernel.org>
Date:   Wed Oct 28 17:14:04 2026 +0100

    tcp: restore IPv6 af_ops on disconnect of a v4-mapped socket

    A successful connect() of an IPv6 socket to a v4-mapped address
    switches icsk_af_ops, sk_backlog_rcv and af_specific to their
    IPv4-mapped variants. These are only restored if the connect() fails.

    After connect(AF_UNSPEC), the socket can be reused for listen() or
    for a native IPv6 connect(), while still using the mapped handlers.
    IPv6 packets processed from the socket backlog are then handled by
    tcp_v4_do_rcv(). tcp_v4_send_reset() and tcp_v4_send_ack() interpret
    TCP_SKB_CB(skb)->header.h6 as IPv4 options, and __ip_options_echo()
    can overflow its 40-byte destination buffer.

    Commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between
    ehash and lhash2.") prevents listen() after connect(AF_UNSPEC), but
    a native IPv6 connect() is still allowed.

    Add tcp_v6_disconnect() to restore the IPv6 handlers when a v4-mapped
    socket is disconnected, and use the same helper in the connect()
    error path.

    Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
    Reported-by: Tong Liu <lyutoon@gmail.com>
    Reported-by: Qi Tang <tpluszz77@gmail.com>
    Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
    Signed-off-by: Eric Dumazet <edumazet@kernel.org>

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e006a30360eae1b43a4d53173b46b931ae668825..a93410aab66e6f441d70cf70c67=
e6d92fbb5fb26
100644
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
