Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6290E33C1B4
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 04:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790310711; cv=none; b=pyOeMFuSQeAsaiTycAruPFVuf5o+3Nj0tOi0jw9eZM34QPQ9JrZJQ4CQ07rt7JlooLPS/HOuo+ib3orT0ErvYVdKodquovjZAdfcMVDSWmVxwnHj4l1kjzBBFEL1P9uCTnpoAzIqV2k45i1D5R9AqlN+hM5yL45bdUsZBsNPeto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790310711; c=relaxed/simple;
	bh=P0J4ble2L56KXd04+v46J0ATFShCSXuC/Yzq1CHQeX4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQWki5TbzdBTPITdifqiobiU3AIy/GwKh3rC3RaITWlPFYMylFd2wY3lbKZirbiSAhz1OAyNpYry7dYi42VT4ccsdREurmhmBdBoJgtZmIrCXCuLFgfX36gZ8qFuwQe4DqqB5QUL0v4L7gN9PXbjSht/1PrfQPqlDSoRzBBbtrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OSQ6sfCX; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OSQ6sfCX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1790310697; x=1790569897;
	bh=KrJm2qRa2pAQNvWZZnKsil01NcemRGee/i/UZWG3unk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OSQ6sfCXhCpRKRrG9+6k1n1AZUiwfkwDIkTWb7D2MajIc2+l3AUTemrP8jVQiJkKM
	 24Znx6mFZNCnEPxkI51P9DmMdKHVT1Y+w7xIGj4Tv7gHeuacGPcTTebflvW2s8zYaX
	 3A/Ymg6qx5iMFtIqD6mW2Zn8e004w2SznFd+6jw3DdDlZzOGxBetZJj7VOZNXtKRUT
	 AE9lINkeLKUvQNimmGOjuXVl+bhDhdIE3cWsH6xtCi491v4hpjBXE5SpVrgnZOZ0IU
	 LIYhNCrdVvlXooZCAEm39pCMuP41mqrg3AzcMWc6VF5v2XMUvxim7pEzaZnxUTalIf
	 u5jQp//+ww97Q==
Date: Fri, 25 Sep 2026 04:31:34 +0000
To: netdev-bot+sashiko@kernel.org
From: quanyeyang <quanyeyang@proton.me>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, matttbe@kernel.org, geliang@kernel.org, martineau@kernel.org, jiayuan.chen@linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] tcp: annotate lockless access to sk->sk_err
Message-ID: <4ay3lMhZJLAtV_FR5mQPspawlg9xuzFIChpfTjwfA36RVYyOLadNwDGW1Z4tKyO5lh7AhfOKXO-sIDxwL18W_Mxa90OxLGaV5ZkQJsPYU_U=@proton.me>
In-Reply-To: <178999981507.2160803.15037788484628952910@kernel.org>
References: <20260917-mptcp-sk-err-net-v4-1-1f04f52f2561@proton.me> <178999981507.2160803.15037788484628952910@kernel.org>
Feedback-ID: 206494642:user:proton
X-Pm-Message-ID: 2dcaa73224fe6832c67173a3b67c7439535cdb7c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, September 21st, 2026 at AM 7:10, netdev-bot+sashiko@kernel.org <=
netdev-bot+sashiko@kernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 (2) =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] Commit message does not describe the tcp_bpf_sendmsg() hunk.
>=20
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but the
>   annotated peeks are still followed by a second, independent read of=
=E2=80=A6
> - [Medium] This problem wasn't introduced by this patch, but
>   tcp_bpf_sendmsg() (net/ipv4/tcp_bpf.c) discards a failed iterator-copy=
=E2=80=A6
>=20
> --
>=20
> tcp: annotate lockless access to sk->sk_err
>=20
> This annotates the plain sk->sk_err loads on the TCP send, receive and
> splice paths with READ_ONCE(), since sock_error() clears sk_err with
> xchg() from do_recvmmsg() and getsockopt(SO_ERROR) without holding the
> socket lock. The tcp_bpf_sendmsg() site is also restructured while the
> other sites are annotated in place.
>=20
> Link: https://lore.kernel.org/netdev/8bbee583-6f21-4817-bfeb-2d60057380a3=
@linux.dev/
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/632
>=20
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 1c867a3024446..9e7fa7e397265 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -843,7 +843,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t=
 *ppos,
> >  =09=09=09=09break;
> >  =09=09=09if (sock_flag(sk, SOCK_DONE))
> >  =09=09=09=09break;
> > -=09=09=09if (sk->sk_err) {
> > +=09=09=09if (READ_ONCE(sk->sk_err)) {
> >  =09=09=09=09ret =3D sock_error(sk);
> >  =09=09=09=09break;
> >  =09=09=09}
>=20
> [ ... ]
>=20
> > @@ -2760,7 +2760,7 @@ static int tcp_recvmsg_locked(struct sock *sk, st=
ruct msghdr *msg, size_t len,
> >  =09=09=09if (sock_flag(sk, SOCK_DONE))
> >  =09=09=09=09break;
> >
> > -=09=09=09if (sk->sk_err) {
> > +=09=09=09if (READ_ONCE(sk->sk_err)) {
> >  =09=09=09=09copied =3D sock_error(sk);
> >  =09=09=09=09break;
> >  =09=09=09}
>=20
> [Severity: Medium]
> This isn't a bug introduced by this patch, but the annotated peek is
> still followed by a second, independent read of sk_err inside
> sock_error(), so the value can be gone by the time it is consumed.
>=20
> include/net/sock.h:sock_error() {
> =09if (likely(data_race(!sk->sk_err)))
> =09=09return 0;
>=20
> =09err =3D xchg(&sk->sk_err, 0);
> =09return -err;
> }
>=20
> sock_error() is reachable without the socket lock from do_recvmmsg() and
> from getsockopt(SO_ERROR), which is the same writer named in the splat:
>=20
> CPU0 (socket lock held, tcp_recvmsg_locked())
> =09if (READ_ONCE(sk->sk_err))=09/* sees 0x6b, enters branch */
>=20
> CPU1 (no socket lock, do_recvmmsg() -> sock_error())
> =09err =3D xchg(&sk->sk_err, 0);=09/* consumes the error */
>=20
> CPU0 continues:
> =09=09copied =3D sock_error(sk);=09/* now returns 0 */
> =09=09break;
>=20
> Since the break is unconditional, does recvmsg() then return 0 rather
> than falling through to the RCV_SHUTDOWN / TCP_CLOSE / !timeo / signal
> checks?  For a nonblocking receive on an open, empty socket the expected
> result would be -EAGAIN, and userspace reads 0 as an orderly shutdown.
>=20
> The same shape exists in tcp_splice_read(), where ret =3D sock_error(sk)
> followed by "if (spliced) return spliced; return ret;" returns 0, and in
> tcp_bpf_recvmsg_parser(), where copied =3D sock_error(sk) is followed by
> goto out.
>=20
> The changelog does say "the check-then-sock_error() TOCTOU on the
> no-data paths is a separate issue".  Would consuming the value once
> (copied =3D sock_error(sk); if (copied) break;) close both the data race
> and this window in one step?
>=20
> One related note: once these loads are marked, KCSAN will no longer
> report these sites, so the signal that produced this report goes away
> while the check-then-consume window stays.
>=20
> > diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> > index 2e234d155b5e6..a96323e65758e 100644
> > --- a/net/ipv4/tcp_bpf.c
> > +++ b/net/ipv4/tcp_bpf.c
> > @@ -286,7 +286,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
> >  =09=09if (sock_flag(sk, SOCK_DONE))
> >  =09=09=09goto out;
> >
> > -=09=09if (sk->sk_err) {
> > +=09=09if (READ_ONCE(sk->sk_err)) {
> >  =09=09=09copied =3D sock_error(sk);
> >  =09=09=09goto out;
> >  =09=09}
> > @@ -553,10 +553,9 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct=
 msghdr *msg, size_t size)
> >  =09=09bool enospc =3D false;
> >  =09=09u32 copy, osize;
> >
> > -=09=09if (sk->sk_err) {
> > -=09=09=09err =3D -sk->sk_err;
> > +=09=09err =3D -READ_ONCE(sk->sk_err);
> > +=09=09if (err)
> >  =09=09=09goto out_err;
> > -=09=09}
>=20
> [Severity: Medium]
> Could the changelog cover this hunk?  It describes the patch as a pure
> annotation:
>=20
>   "Annotate those peeks with READ_ONCE(). No extra ordering is needed:
>    the value is only used to decide whether I/O should stop. This does
>    not consume sk_err"
>=20
> In tcp_bpf_sendmsg() the value is not only used to decide whether I/O
> stops, it becomes the errno handed back to userspace:
>=20
> net/ipv4/tcp_bpf.c:tcp_bpf_sendmsg() {
> =09...
> out_err:
> =09if (err < 0)
> =09=09err =3D sk_stream_error(sk, msg->msg_flags, err);
> =09release_sock(sk);
> =09sk_psock_put(sk, psock);
> =09return copied > 0 ? copied : err;
> }
>=20
> The rewrite also looks like it changes behaviour beyond annotation.  The
> old form read sk->sk_err twice:
>=20
> =09=09if (sk->sk_err) {
> =09=09=09err =3D -sk->sk_err;
>=20
> If the lockless sock_error() consumer cleared sk_err between those two
> reads, err became 0 while control still jumped to out_err, where
> "if (err < 0)" is false and the function returned
> "copied > 0 ? copied : 0", i.e. a zero-byte success instead of the
> pending error.  The new single READ_ONCE() closes that.  Should this be
> called out in the changelog, with a Fixes: tag, or split into its own
> patch so the remaining five hunks stay mechanical?
>=20
> Also, err is now assigned on every loop iteration rather than only when
> sk_err is set.  Every later use of err in the loop is preceded by its
> own assignment from sk_msg_alloc(), tcp_bpf_send_verdict() or
> sk_stream_wait_memory(), so this looks behaviour preserving, but it is
> unexplained restructuring in an annotation-only patch.
>=20
> [Severity: Medium]
> This is a pre-existing issue, but while looking at the same loop in
> tcp_bpf_sendmsg(): can a failed copy from the user buffer be reported as
> a zero-byte send?
>=20
> The copy result goes into ret, not err, and out_err returns err:
>=20
> net/ipv4/tcp_bpf.c:tcp_bpf_sendmsg() {
> =09...
> =09=09err =3D sk_msg_alloc(sk, msg_tx, msg_tx->sg.size + copy, msg_tx->sg=
.end - 1);
> =09=09if (err) {
> =09=09=09if (err !=3D -ENOSPC)
> =09=09=09=09goto wait_for_memory;
> =09=09=09enospc =3D true;
> =09=09=09copy =3D msg_tx->sg.size - osize;
> =09=09}
>=20
> =09=09ret =3D sk_msg_memcopy_from_iter(sk, &msg->msg_iter, msg_tx,
> =09=09=09=09=09       copy);
> =09=09if (ret < 0) {
> =09=09=09sk_msg_trim(sk, msg_tx, osize);
> =09=09=09goto out_err;
> =09=09}
> =09...
> }
>=20
> sk_msg_memcopy_from_iter() returns -EFAULT on a short copy:
>=20
> net/core/skmsg.c:sk_msg_memcopy_from_iter() {
> =09...
> =09=09if (ret !=3D copy) {
> =09=09=09ret =3D -EFAULT;
> =09=09=09goto out;
> =09=09}
> =09...
> }
>=20
> On the first iteration a successful sk_msg_alloc() leaves err =3D=3D 0, s=
o
> out_err skips sk_stream_error() and, with copied =3D=3D 0, sendmsg() retu=
rns
> 0 rather than -EFAULT.  If sk_msg_alloc() had returned the tolerated
> -ENOSPC, the stale -ENOSPC is reported instead of the copy failure.
> Would "err =3D ret;" before the goto preserve the real failure?
>=20
> Reproducing this needs a sockmap/psock attached to the socket, then a
> sendmsg() with a partially unmapped user buffer.
>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260917-mptcp-sk-err-net-v4-0-1f04f52f2561%40proton.me
>=20

Thanks for the review.

The tcp_bpf_sendmsg() changelog gap is fair. That site still only
peeks: the two unmarked loads are folded into one READ_ONCE() and
the value is also used as the returned errno. I will mention that
in the TCP commit. This stays an annotation; no Fixes tag, and I
will not split that hunk out.

The check-then-sock_error() window is the pre-existing TOCTOU
already called out in the changelog. READ_ONCE() only marks the
KCSAN load. Consuming once belongs in a separate series; I will
not mix it into this annotation.

The sk_msg_memcopy_from_iter() path returning 0 / a stale -ENOSPC
is also pre-existing and unrelated to sk_err. I will not address
it here.

I will send a v5 with the commit-message update.

