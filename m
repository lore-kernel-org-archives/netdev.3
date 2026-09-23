Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA0C37F32F;
	Wed, 23 Sep 2026 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790203574; cv=none; b=n78BA56a4r7if/ywYGHEqA/L3+FWsliP18OpBTXteR8lC/ibPh96SxmhzYkcEmAksI0o566hpGLLre/xztQ1pC0dmDSZYFJtD4BN0blH4hUVooAmB0CC4aHkEpsKdKw3LOq/MSJhrUkAYtZNlR77i9CV99tBdE6+cOPDJ9Kb5xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790203574; c=relaxed/simple;
	bh=YAe9XMW4pqLH7Do3yMUjb/O1tzFN45n4tLgLRzDFMCE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lcp6W33/J3I1yx8cQK4aVlalUdd0loirC3DAeigWk0c+nzGBLBG4s0oRVo0eeHTTluzjpV2D0vchRw7nkecl+2goCuQKvrkby1M63YuWv54Nue7cK3/4cendGRktM0eRoRf8JvH80H2lr136F5mA9+joVGWXn+O7UHt9ZefJRE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEdbSWYL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEdbSWYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A2A1F000FF;
	Wed, 23 Sep 2026 22:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790203572;
	bh=JdiL4SkBw2PLAJuYIJ/U9LwiSiyqKTizon6ltYFdP5k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UEdbSWYLTRJdbtyNo/Ra38/0cX+5uYnKcZEFFubCiG00OXdt8yDu2f/VF96Nb+KaE
	 R0bS/HO2v/uvnX56VxOsi8xmW55sxl4SV1Z6c11PV+DC4szMU4KUWAVQTfQzbz40hf
	 8QhIM0ir9sPdpfPC6vIlLzE9RDrAwcCOkgrKjHSfhfHGFAp9Aivf5ekk58WOyvxTot
	 oxX0vjltV8iUILVnz4Hr/plu0ueVioLU7WFWJ/Ucq3NZVy+qXIbh3v5qfhswvcuqFx
	 8a8FD11N2oMsgul2O+06fnjAiiis4HGVfEVu+kU1VrFYMPNjouPVAlmTomdPdPDQvb
	 PTe69mVOW360A==
Subject: Re: [PATCH] net: qrtr: use u32 for port in qrtr_port_assign() and
 __qrtr_bind()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: mani@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 22:46:11 +0000
Message-ID: <179020357170.2160803.3542692686118112530@kernel.org>
In-Reply-To: <20260919212847.3239934-1-benquike@gmail.com>
References: <20260919212847.3239934-1-benquike@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net/qrtr/af_qrtr.c:795 — changing `qrtr_port_assign()`'s
  parameter from `int *port` to `u32 *port` silently converts the…
- [High] The signedness conversion was applied only to the insertion
  side, breaking the xarray key convention on 64-bit kernels.
- [Medium] The commit message argues from code that does not exist in the
  tree being patched.

--

net: qrtr: use u32 for port in qrtr_port_assign() and __qrtr_bind()

This changes the port parameter of qrtr_port_assign() and the local port
variable in __qrtr_bind() from int to u32 so they match sq_port in struct
sockaddr_qrtr. A couple of questions below about the resulting behaviour
change and about the rationale in the changelog.

Starting with the changelog itself:

> 1. The privileged port check *port < QRTR_MIN_EPH_SOCKET (0x4000)
>    evaluates to true for any negative int, requiring CAP_NET_ADMIN,
>    or conversely in idr_alloc_u32(&qrtr_ports, ipc, port, *port,
>    GFP_ATOMIC), passing a int * cast to u32 * risks signed/unsigned
>    mismatch.
> 2. Changing port in __qrtr_bind() and qrtr_port_assign() from
>    int to u32 matches struct sockaddr_qrtr's u32 sq_port and
>    idr_alloc_u32()'s u32 * parameter.

[Severity: Medium]
Does this describe the code being patched?  net/qrtr/af_qrtr.c uses an
XArray, not an IDR:

	static DEFINE_XARRAY_ALLOC(qrtr_ports);

and qrtr_port_assign() allocates with:

		rc = xa_alloc(&qrtr_ports, port, ipc, QRTR_EPH_PORT_RANGE,
				GFP_KERNEL);

There is no idr_alloc_u32() and no GFP_ATOMIC in net/qrtr at all, so the
cited call does not exist in this tree.

The actual pre-existing type mismatch appears to be passing int *port to
the u32 *id parameter of xa_alloc().  Could the changelog name that
instead, and also describe the user-visible effect of the type change
(the CAP_NET_ADMIN comparison changing from signed to unsigned), which is
not mentioned at all?

> diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
> index 78347c937af7..cae7af5b9229 100644
> --- a/net/qrtr/af_qrtr.c
> +++ b/net/qrtr/af_qrtr.c
> @@ -785,7 +785,7 @@ static void qrtr_port_remove(struct qrtr_sock *ipc)
>   *   <QRTR_MIN_EPH_SOCKET: Specified; requires CAP_NET_ADMIN
>   *   >QRTR_MIN_EPH_SOCKET: Specified; available to all
>   */
> -static int qrtr_port_assign(struct qrtr_sock *ipc, int *port)
> +static int qrtr_port_assign(struct qrtr_sock *ipc, u32 *port)
>  {
>  	int rc;
>  

[Severity: High]
Does this drop the CAP_NET_ADMIN gate for the upper half of the port
space?  The only privilege check in the bind path is in the body of
qrtr_port_assign():

	} else if (*port < QRTR_MIN_EPH_SOCKET && !capable(CAP_NET_ADMIN)) {
		rc = -EACCES;
	} else if (*port == QRTR_PORT_CTRL) {
		rc = xa_insert(&qrtr_ports, 0, ipc, GFP_KERNEL);

QRTR_MIN_EPH_SOCKET is the int constant 0x4000, so with int *port every
sq_port >= 0x80000000 was negative, compared less than 0x4000, and
returned -EACCES without CAP_NET_ADMIN.  With u32 *port the comparison is
unsigned and 0x80000000..0xffffffff all compare greater than 0x4000, so
they skip the capable() branch entirely.

That includes QRTR_PORT_CTRL, which is 0xfffffffeu in
include/uapi/linux/qrtr.h, so the control-port branch is now reachable
with no capability check.  If the xarray index 0 is free, __qrtr_bind()
then does:

	/* Notify all open ports about the new controller */
	if (port == QRTR_PORT_CTRL)
		qrtr_reset_ports();

which sets sk_err = ENETRESET on every other QRTR socket, and
qrtr_sendmsg() subsequently treats that socket's payload as a QRTR
control command.

Index 0 is normally taken by the in-kernel name server, but qrtr_ns_init()
binds QRTR_PORT_CTRL only after sock_register() in qrtr_proto_init(), so
there is a window where an unprivileged bind can win it.  Independently of
that window, the bypass for 0x80000000..0xfffffffd looks unconditional.

Would it make sense to keep an explicit CAP_NET_ADMIN test for
QRTR_PORT_CTRL and for the high port range alongside the type change?

[Severity: High]
Does changing only the insertion side leave the xarray keys inconsistent
on 64-bit kernels?  qrtr_port_assign() now inserts with a u32:

		rc = xa_insert(&qrtr_ports, *port, ipc, GFP_KERNEL);

xa_insert(), xa_load() and xa_erase() all take an unsigned long index, so
port 0x80000000 is zero-extended and stored at index 0x0000000080000000.

The lookup and removal sides still use int, and were not changed:

	static struct qrtr_sock *qrtr_port_lookup(int port)
	{
		...
		ipc = xa_load(&qrtr_ports, port);

	static void qrtr_port_remove(struct qrtr_sock *ipc)
	{
		...
		int port = ipc->us.sq_port;
		...
		xa_erase(&qrtr_ports, port);

Those sign-extend to 0xffffffff80000000, which can never match the key
used at insert time.  For a socket bound in 0x80000000..0xfffffffd that
seems to give three effects:

- qrtr_port_lookup() never finds it, so qrtr_local_enqueue() and
  qrtr_endpoint_post() return -ENODEV for a port that bound
  successfully.

- At close, xa_erase() removes nothing, but qrtr_port_remove() still
  drops the reference taken by qrtr_port_assign():

	xa_erase(&qrtr_ports, port);
	...
	__sock_put(&ipc->sk);

  so the port stays -EADDRINUSE forever and the stale entry holds a
  dangling struct qrtr_sock * after qrtr_release() drops the last
  reference.

- qrtr_reset_ports() is the only iterator of qrtr_ports and would then
  touch that freed object:

	xa_for_each_start(&qrtr_ports, index, ipc, 1) {
		sock_hold(&ipc->sk);
		ipc->sk.sk_err = ENETRESET;
		sk_error_report(&ipc->sk);

Before the patch, insert, load and erase all sign-extended the same int,
so the keys agreed.  Should qrtr_port_lookup() and the local in
qrtr_port_remove() be widened to u32 in the same change?

> @@ -835,7 +835,7 @@ static int __qrtr_bind(struct socket *sock,
>  {
>  	struct qrtr_sock *ipc = qrtr_sk(sock->sk);
>  	struct sock *sk = sock->sk;
> -	int port;
> +	u32 port;
>  	int rc;
>  
>  	/* rebinding ok */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919212847.3239934-1-benquike%40gmail.com
