Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB7D490BE0
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685276; cv=pass; b=ky29MKUVWyhNkt1Pr1511MOspoTIX3bXBUD+8AKObvYhv0Ac5PlsQBBgX2IE6XGz2mdzjXzI4yV3+J4l32Fbw2a3UdqUsPFcRv1hsO70IJSuc6iP9felCP0colB0g8J+Wpwhr5b5PIPCypc5Eq2x6noFcqIjxQQDbVZUaFhMWkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685276; c=relaxed/simple;
	bh=n1H9CabcKbPZiNwLqArVcOUm9mYAEuL4r2RtjaWBSw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDPo/yTaF8CZyuN1rLg6KXcw8Ae0ZEETB8TxKyPvWCMOoZ0fq/2dbGaqV1QWlUvfTTqG7SipUrWg67QKO9AyazYeSH7ovG0H38a22qvD+C1C/zw6MtxasKnEcZLsS4v7+NlvdxhILCpjxw2+2UEWDs01vfIonpN/c/arX7+wmKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=3EaqK7dx; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="3EaqK7dx"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5c671456e25so124730e0c.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789685272; cv=none;
        d=google.com; s=arc-20260327;
        b=EMkO3bM30i7p9pbc5DQFL0ynJAClJK8yLJsHtVDA+8ScFPUQ6WIdjLafxGENgQKBPB
         /LKX9dn5/oCEwg9h7h3L2+WPUywuVD7Y2+zhkMmLSRIolPWxc/vMnvw02oYnLzaSiRCR
         a29ZyU/b4x+eYcdYHOaul2m5eq/qfbsjhLFM6YHyKmFJzXOxcy2pRi5J/OuzEtReKD1u
         tfPSA97+bFcBOTUTfSvOY/j/Sj+BbR7GSf35EoX8p8DOWwOvl78DZA8kmXC/3FCSSJg/
         c0vaMLcAig9Qecy/yEiOBzt4CHzA1whdKUbBhN9skkU8vhJJldytmZbwcGut56SbBCXZ
         lzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4z0abcM6GBsrn42q0U/9c4khs0MJrBujpW+sABB1Mtc=;
        fh=KDPEyLFrx0IaPdgkSonKsexwzLCh01ZOslfJI1v3q8w=;
        b=ARiMaQh5xJaGM9d7Ch/QPyPR6meo2nTVak9QzeL7F0tgIChfnSQpgwPHJcnavYrkFU
         zhIULQjyulxOt61iV+kthlDhuxg+VZiSZqIiOCex/t6HTdl//fG7ZUWhTpCkHLOuUeN3
         loxbDoAxBwCtk3ko9taal8D/0w9qBWelxImyx2fSlhlzdOL/APgtl2ne4XfRdbaM8Vtm
         v2TDrtQP28fQ7JRIzspmazggV0Rr1ZmCFzCm1BzheXDZXBkq2ReN3a8+0rcO9fLBLsls
         B4VJBwM2A/48a/8o0vtjZtElOmXX2PhXa5ASq4PfEfQUuP/odgdjCAMzOH24mL33yY1M
         hHVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1789685272; x=1790290072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4z0abcM6GBsrn42q0U/9c4khs0MJrBujpW+sABB1Mtc=;
        b=3EaqK7dx2ULViAHfTU2jTSJNLoff3e3iW8Ejf2ZNbdF9A0JSrnPKLAjECbgyADJx/h
         A9mQGzg+DXOcOp/QiKBKC/VFfZ236Jboh5Gx3iVie3QJca1COnVejS9pef2R1+05Tbwf
         aUYZJt9QItxbeWPBkleTjIU77mZIJC/2dFW3V0GS2KPZzVO5/5JQLYHFrPscwPcuX7m5
         V9ib5CuCAgb75L6uUeLLC2P8w34wTKaSTzUDmmZHvecMWvccALNLZf0zPhYzlTzpxqQB
         BJkpOZEM+jicjljZwDdp3S3FUr6Mbj3K6fVZjCNEu/pl4JiNE31eWXcCoEe4CwF74/jS
         azHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685272; x=1790290072;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4z0abcM6GBsrn42q0U/9c4khs0MJrBujpW+sABB1Mtc=;
        b=ZIlIjfJlkb4nv7cEwR4pkcO+7zsL1z46wf7e74b5i/8LKnsLspIPydloN5wR0pHtUm
         /ukBwHzkQE3kVbhFjXbiAa2c/qQrnQnJRo4wHgTs+wIrWeTVauunPF+dV7X3V19zfVak
         lafadia1BDaAUrk/Pp/a0tkEGUDeGgJH8cqPnAdJFrxb7aWjCcAStDkoRyaGaZ9FE+K1
         cRLHPFozZh+k39gWxTjqDPUvWykw2EDZFP7kda5TCxBOmU0PUsOahDPozk5wHSNK1vOA
         Re5RuuC1lcausRKcfvtXrRbym6wFzVPEDMvKlFxPsSZRM/PFETvgJU45SMmLdpNagsJN
         QQnQ==
X-Gm-Message-State: AFuF++l86MVA/SGF989+Ipi0r092ACWDGkBxtUFgdQuQTNtC48nzZYHb
	cJ66SKzvkFa/k8dDKN27WcZBm7oD86qe27V7myyq2Yi2uRAxMcZLfy0OTYKlOdpSrUqjX8pbxtQ
	QRaPPWhjIosXt/54jvybgKRoGkpW6ufsipPSlQbupkA==
X-Gm-Gg: AYBFou0vYmwqbLuzd1fRpCInckCdMgIqvptC05rZnF7Ci6qHoTfRAnwJz7wgZOqrXk/
	UyxtSunNcYKhUjM4TNIwbldGs0TDTCl1vsa/dKXzeU5XjM/p7B2qoi6JwsbUfJHDQqBBRnBqdTn
	yECaAr9oU0ImcFQSbaUdXyvr8pVh08LoxjN8r3C08LZeE1dOClR90Yjg0SmKV7Kx0H1de6aNxPB
	t99NRAQnYiU2Z5DXlHi5uiseZN+hqG5YM1MINy1fxW8Rm6g0fzMaupVH0zyvp9bc3sDb2tQ3P0g
	2/ImnUpRXTyViezUNRLORdeRbAkk40CVQmvLiMCVi3j5RVQInfOzajXGNxUncfNKJID09nMOY/P
	gof7Yye/XCEw9wu9aaesI/Paqt90NYhWpmB1bW3tchUt3dSCLq3AgOZaWXaVw3IwEvoBUnChJhz
	d4leLqoJgXyFfbpgg4I61oXPSJFGZu7391QSGjNNh6L6nml3KXNN0=
X-Received: by 2002:a05:6122:6d02:b0:5c7:dcaa:980d with SMTP id
 71dfb90a1353d-5c9a559bbdamr1503780e0c.1.1789685271851; Thu, 17 Sep 2026
 15:47:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807183853.2288959-11-rjethwani@purestorage.com> <20260817221148.3666558-1-kuba@kernel.org>
In-Reply-To: <20260817221148.3666558-1-kuba@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Thu, 17 Sep 2026 15:47:39 -0700
X-Gm-Features: AcwNN1WecKQF2gIqrcHibEN6h9kgdF91fr08h3B2Y30DMfXP7SJo8BkBXEdt-5E
Message-ID: <CAKaoeS0goM2Hzq5oFPORHuVQX9eGO6fbAMK9s=u7KM8855zERg@mail.gmail.com>
Subject: Re: [PATCH v16 10/10] selftests: net: add TLS hardware offload test
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, leon@kernel.org, andrew.gospodarek@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 3:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> selftests: net: add TLS hardware offload test
>
> This adds a two-node kTLS hardware offload selftest: a C helper acts as
> either TLS client or server, and a Python harness drives it over
> NetDrvEpEnv and checks the /proc/net/tls_stat counters.  It covers TLS
> 1.2/1.3, AES-GCM-128/256, rekey with several buffer sizes, and burst
> variants that stress TX and RX rekey.
>
> A few questions about the helper and the harness below.
>
> > diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c b/=
tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
> > new file mode 100644
> > index 000000000000..1882e2f073ad
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
> > @@ -0,0 +1,975 @@
>
> [ ... ]
>
> > +static int do_client(void)
> > +{
>
> [ ... ]
>
> > +             n =3D send(csk, buf, this_size, 0);
> > +             if (n !=3D this_size) {
> > +                     printf("FAIL: send failed: %s\n", strerror(errno)=
);
> > +                     goto out;
> > +             }
> > +
> > +             if (!burst_mode) {
> > +                     printf("Sent %zd bytes (iteration %d)\n", n, i);
> > +                     if (client_recv_echo(csk, buf, echo_buf, n) < 0)
> > +                             goto out;
> > +             }
>
> [Severity: Medium]
> Can echo (non-burst) mode deadlock for large payloads?
>
> do_client() issues one blocking send() of the whole payload and only
> calls client_recv_echo() afterwards, so it does not read anything from
> the socket while the send is outstanding.
>
> On the other side, do_server() reads one record with recv_flags =3D=3D 0 =
and
> then blocks inside server_echo_send() before it returns to recv():
>
>         for (sent =3D 0; sent < n; sent +=3D ret) {
>                 ret =3D send(fd, buf + sent, n - sent, 0);
>
> Once the echo direction fills up (server send buffer plus client receive
> buffer, which cannot autotune because the client never copies data out),
> the server blocks in send() and stops draining the forward direction.
> The client then blocks in its own send().  Neither side sets
> SO_SNDTIMEO/SO_RCVTIMEO, uses non-blocking I/O, or has a second reader,
> so is there anything that breaks the cycle?

I'll  fix this by sizing the socket buffers so a full payload always
fits in the peer's receive window, the forward send() then completes
without requiring the peer to drain concurrently, and arming
SO_SNDTIMEO/SO_RCVTIMEO as a safety net so any future imbalance fails
loudly with EAGAIN instead of hanging.

> The large_buf rekey variant drives this path with 2 MiB per iteration:
>
>     KsftNamedVariant("large_buf", 10, 2097152),
>
> With initial tcp_wmem[1]/tcp_rmem[1] defaults only a few hundred KiB can
> be in flight per direction, well below 2 MiB.  The client cmd() then
> times out (cmd_timeout is 10 for non-burst runs) and the variant is
> reported as a TLS offload counter failure rather than as a hang.  Would
> a bounded per-iteration payload in echo mode, or a socket timeout, be
> preferable here?
>
> [Severity: Low]
> Should this send() loop over the remainder instead of treating a short
> count as fatal?  Every other transfer in this file loops:
> client_recv_echo() uses "while (total < len)" and server_echo_send()
> uses "for (sent =3D 0; sent < n; sent +=3D ret)".
>
> A blocking SOCK_STREAM send() can return a short count without setting
> errno, so "FAIL: send failed: %s" would print a stale strerror(errno)
> value.  In burst mode a short send also breaks the framing contract that
> the server's MSG_WAITALL recv() relies on, since server_verify_burst()
> expects exactly send_size bytes per iteration.

I'll hoist the loop into a shared send_all() used by both the client
payload send and the server echo; only a negative return will be
fatal.

> [ ... ]
>
> > diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py b=
/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> > new file mode 100755
> > index 000000000000..b8f5a3314030
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> > @@ -0,0 +1,295 @@
>
> [ ... ]
>
> > +# Burst variants push hundreds of MB and perform many rekeys; the
> > +# default cmd() timeout (5s) is too short.
> > +BURST_TIMEOUT_S =3D 180
>
> [Severity: Low]
> Is the "(5s)" in this comment correct?  tools/testing/selftests/net/lib/p=
y/utils.py
> declares the default as 20 s in both places:
>
>     def __init__(self, comm, shell=3DNone, fail=3DTrue, expect_fail=3DFal=
se, ns=3DNone,
>                  background=3DFalse, host=3DNone, timeout=3D20, ksft_read=
y=3DNone,
>                  ksft_wait=3DNone):
> ...
>     def process(self, terminate=3DTrue, fail=3DNone, expect_fail=3DFalse,=
 timeout=3D20):
>
> Following the 5 s premise, run_tls_test() sets "cmd_timeout =3D
> BURST_TIMEOUT_S if burst else 10", which lowers the non-burst client
> timeout below the library default.
>
> Also, BURST_TIMEOUT_S is only passed to the client cmd().  bkg takes no
> timeout argument and bkg.__exit__() calls self.process() without one, so
> the background server that handles the same "hundreds of MB" is drained
> with communicate(timeout=3D20).  If it needs longer after the client exit=
s,
> subprocess.TimeoutExpired escapes bkg.__exit__() rather than producing a
> test failure.

You're right that the (5s) was wrong; the library default is 20s. I've
fixed the comment and changed the non-burst client timeout from 10 to
20 to match the library default instead of undercutting it.

On the background server drain: the concern is valid but I don't think
the failure mode is reachable here, so I've left the bkg path as-is.
Reasoning:

BURST_TIMEOUT_S is only wired to the foreground client cmd(). The
server runs under bkg(..., exit_wait=3DTrue), and bkg takes no timeout,
on block exit, __exit__() calls self.process() with the default, so
the server is drained with communicate(timeout=3D20). So yes, the server
handling the same bulk transfer gets 20s, not BURST_TIMEOUT_S, and a
subprocess.TimeoutExpired there would escape as an unhandled exception
rather than a clean ksft failure.

However, the server is always on the receiving side of the burst
(DUT-as-server for burst_rx*, remote-as-server for burst_tx*). TCP
flow control means the client's cmd() can't return until the server
has been draining the socket, so by the time we leave the with bkg
block the server has already ingested the data and only needs to
finish its final read loop and exit, comfortably within 20s. It never
has to absorb hundreds of MB cold inside that window.

> > +def check_tls_support(cfg):
> > +    try:
> > +        cmd("test -f /proc/net/tls_stat")
> > +        cmd("test -f /proc/net/tls_stat", host=3Dcfg.remote)
> > +    except CmdExitFailure as e:
> > +        raise KsftSkipEx(f"kTLS not supported: {e}")
>
> [Severity: Medium]
> Does this check actually test for kTLS support, or only for the tls
> module already being loaded?
>
> /proc/net/tls_stat is created from the module's pernet registration path:
>
> net/tls/tls_proc.c:tls_proc_init() {
>         if (!proc_create_net_single("tls_stat", 0444, net->proc_net,
>         ...
> }
>
> reached via module_init(tls_register) -> register_pernet_subsys(&tls_proc=
_ops).
> With the common CONFIG_TLS=3Dm the module is autoloaded on the first
> TCP_ULP=3D"tls" setsockopt, so on a freshly booted DUT or peer the file
> does not exist yet and check_tls_support() raises KsftSkipEx("kTLS not
> supported") from main() before ksft_run(), skipping all variants on a
> machine that fully supports offload.
>
> Would a modprobe, or probing an actual TLS ULP socket first, be more
> reliable?

I'll fix by explicitly loading the module before probing.

> > +def read_tls_stats(host=3DNone):
> > +    stats =3D defaultdict(int)
> > +    output =3D cmd("cat /proc/net/tls_stat", host=3Dhost)
>
> [Severity: Low]
> These are per-netns counters (TLS_INC_STATS(sock_net(sk), ...) exposed
> through net->mib.tls_statistics), and these tests run in the host
> namespace on a real NIC via NetDrvEpEnv(__file__, nsim_test=3DFalse).  An=
y
> other kTLS user in the same namespace during the before/after window
> perturbs the deltas that check_eq_sum() and check_zero() require to
> match exactly.
>
> There is also a harness-internal path for this.  When
> cmd(client_cmd, timeout=3Dcmd_timeout) times out, utils.py does:
>
>         if terminate:
>             self.proc.terminate()
>         stdout, stderr =3D self.proc.communicate(timeout=3Dtimeout)
>
> For a foreground cmd() the child is not killed on TimeoutExpired, so the
> orphaned client keeps running and its eventual socket teardown can bump
> TlsTxRekeyAborted or TlsDecryptError inside a later variant's
> measurement window.  Can one timeout (for example the large_buf hang
> above) cascade into counter failures in unrelated variants?

I'll fix orphaned client bug by starting the client in the background
so we keep a handle, then reaping it in a finally, killing it within
this variant's window if it's still alive.

Regarding the per-netns counters: agreed, and it's the harder half.
The test needs the real NIC in the host namespace for HW offload, so I
can't easily isolate the counters in a fresh netns. The orphan was the
only self-inflicted source of interference, which the above removes;
genuinely concurrent kTLS in the same namespace remains an inherent
limitation of HW-offload selftesting on a shared host. I'll call that
assumption out in a comment near read_tls_stats().

> > +def check_path(before, after, direction, role, require_hw):
> > +    """On the DUT, require HW offload; on the remote, HW or SW is fine=
."""
> > +    dev =3D stat_diff(before, after, f'Tls{direction}Device')
> > +    sw =3D stat_diff(before, after, f'Tls{direction}Sw')
> > +    if require_hw:
> > +        if dev < 1:
> > +            ksft_pr(f"FAIL: {role} {direction}: HW offload not engaged=
 "
> > +                    f"(Device=3D{dev}, Sw=3D{sw})")
> > +            return 1
>
> [Severity: Low]
> Does a TlsTxDevice/TlsRxDevice delta of at least 1 show that the device
> actually performed record crypto?
>
> Those MIBs are bumped once per socket at setsockopt() time only:
>
> net/tls/tls_main.c:do_tls_setsockopt_conf() {
>                 if (!rc) {
>                         if (!update) {
>                                 TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLS=
TXDEVICE);
>                                 TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLS=
CURRTXDEVICE);
>                         }
>         ...
> }
>
> so they record that tls_dev_add() accepted the connection, not that any
> record was encrypted or decrypted in hardware.  A socket whose RX
> offload later degrades to software still satisfies dev >=3D 1, since
> TLS_RX_DEV_DEGRADED is set at runtime:
>
> net/tls/tls_device.c:tls_device_down() {
>                 /* Start skipping the RX resync logic completely. */
>                 set_bit(TLS_RX_DEV_DEGRADED, &ctx->flags);
>         ...
> }
>
> For the non-rekey variants (expected_rekeys =3D=3D 0) check_path() is the
> only assertion that runs, so is the central premise of a test placed
> under drivers/net/hw verified at all there?

I'll add a DUT-side check on the driver's per-record counters via
'ethtool -S', which increment once per record the NIC encrypts or decrypts.

> [ ... ]
>
> > +    if expected_rekeys > 0:
> > +        if with_tx:
>
> [ ... ]
>
> > +            errors +=3D check_eq_sum(stats_before, stats_after,
> > +                                   ['TlsTxRekeyOk', 'TlsTxRekeyAborted=
'],
> > +                                   expected_rekeys, role)
> > +            errors +=3D check_zero(stats_before, stats_after,
> > +                                 'TlsTxRekeyError', role)
> > +            errors +=3D check_zero(stats_before, stats_after,
> > +                                 'TlsTxRekeyFallback', role)
>
> [Severity: Medium]
> Should TlsTxRekeyFallback and TlsRxRekeyFallback be required to stay at
> zero?  Those counters are the kernel's accounting for intentional,
> graceful degradation to software when a device key (re)install fails,
> and the fallback path returns success:
>
> net/tls/tls_device.c:tls_device_complete_rekey() {
> rekey_fail:
>         ...
>         TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYFALLBACK);
>         TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
>         TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
>
>         return 0;
> }
>
> The RX side does the same on a failed rekey dev_add:
>
>         } else if (is_rekey) {
>                 set_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags);
>                 set_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags);
>                 TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYFALLBACK)=
;
>
> A NIC has a bounded pool of TLS contexts and a rekey needs a fresh one
> while the old is retired, and the burst variants rekey very aggressively
> on a single connection (burst_tx_rekey_every_1 does 50 rekeys, one per
> 64 KiB send; burst_rx_rekey_every_10 does 20 RX rekeys).  If a device
> falls back, check_zero('TlsTxRekeyFallback') fails and the exact
> check_eq_sum(Ok + Aborted =3D=3D N) fails at the same time, giving two
> failures with nothing to distinguish "device out of contexts" from a
> kernel rekey bug.  A TX fallback also leaves the socket in software for
> good, so one transient failure affects every remaining rekey on that
> connection.

You're right that Fallback is a legitimate success path, not a bug, so
asserting it to zero is wrong. I've fixed it.

One correction to the underlying model: a fallback isn't terminal. On
the next KeyUpdate the connection re-attempts HW offload,
tls_device_start_rekey() clears TLS_TX_REKEY_FAILED (RX clears
TLS_RX_DEV_DEGRADED/CLOSED in tls_device_dev_add_rx()), so it climbs
back onto HW. That means each KeyUpdate still produces exactly one
terminal outcome, and the exact invariant is just:

Ok + Aborted + Fallback =3D=3D N

So rather than dropping the strict accounting, I'll fold Fallback into
the check_eq_sum() and replaces check_zero(Fallback) with a NOTE.
TlsTxRekeyError/TlsRxRekeyError and the Curr* gauges stay strict at
zero. A fallback now yields one clear NOTE instead of two simultaneous
FAILs, while a real rekey-state-machine regression still fails via
Error or a sum mismatch.

> > +            errors +=3D check_zero(stats_before, stats_after,
> > +                                 'TlsTxRekeyInProgress', role)
> > +        if with_rx:
>
> [ ... ]
>
> > +            errors +=3D check_eq_sum(stats_before, stats_after,
> > +                                   ['TlsRxRekeyOk', 'TlsRxRekeyAborted=
'],
> > +                                   expected_rekeys, role)
> > +            errors +=3D check_min(stats_before, stats_after,
> > +                                'TlsRxRekeyReceived', expected_rekeys,=
 role)
>
> [Severity: Low]
> These strict rekey assertions also run for the remote peer
> (is_dut=3DFalse); only the hardware-vs-software path check is relaxed
> there.  Rekey support and the Tls*Rekey* MIB names are recent additions,
> and read_tls_stats() builds a defaultdict(int), so a peer kernel that
> does not export them yields 0 and produces a hard failure such as
> "expected =3D=3D 1, got 0" instead of a skip.  The only peer-side gate is
> the /proc/net/tls_stat existence check.
>
> This also does not match the run_tls_test() docstring, which says the
> remote "may run any kernel without HW offload".  Should the peer-side
> rekey checks be gated on the counters being present?
>
> [ ... ]

The docstring overclaims for the rekey variants. I'll fix it.

The failing window is narrow, though: the base rekey counters
(TlsRxRekeyReceived, Tls{Rx,Tx}RekeyOk) shipped with SW KeyUpdate in
v6.14, while the ones this series adds (Aborted/Fallback/Curr*Rekey)
only increment on the HW path in tls_device.c. So a v6.14 peer without
this series already passes, it's only missing device-only counters the
SW peer never bumps, and the defaultdict 0 is their correct value. The
"got 0" failure only hits a pre-v6.14 peer, which also can't follow
the rotation (breaks the data path anyway).

So rather than gate individual checks (dead code for the device MIBs,
masking real interop failures for the base ones), I added an up-front
probe: for rekey > 0, skip the variant with KsftSkipEx if the peer's
/proc/net/tls_stat lacks TlsRxRekeyReceived. That's a reliable "peer
predates KeyUpdate" probe and only affects the rekey/burst variants.
Docstring updated to note they need a v6.14+ peer.
