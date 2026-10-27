Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793113415;
	b=iqO7q/cNAnkFrLHllZwEmzcf/J8MhKsN3NHmqfNh/aFtj41FoVjFw0d45zbVJIAO+/Yy
	 Br0Db/l9zLUbuGyxDMLIcXUSzczmbdiQlqlt0lP6TnFkQYKBnnUwt+xVNkdbvuz7G/Vod
	 Tp3Z0KLQ9/9r4QghJw7qGchGyTSqfBMDt2ZRJGh9TVUQhEqj+Nkx/kHVWxgdWREHOxxj1
	 1hWwLOUPcbyXTmozZOAPLtZR7wESEz0F3eetcNZmVydqiVji5tvS8hJF6cwcIiPoqilI2
	 u2Z60EFGklR0Fr8iTMDWhQ4Hcgq8gCA9gEwz3zXzGz9SF7NNs53tWpI+xmLPyu4ppEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=q4yjzdXp7FCkLMermgzdi57SXBbbuDvC0SxPh7Oh9/M=;
	b=Kyom3x2rXmUnmCN4Hy7fOjEqW6N70OUg3IXoyfN9s2tveLZMNTwNln969kSM47/bOGaL
	 LpRKPDzUkVlhPe+8Je5flJD4DkhwGQeTZzUbJRj4VqqxEWjOR78OdC0y4Mosl4VCAMKtY
	 t0DCv8nwbObhlJt9wKT1itJYFoDAr5RwNE+jir2+g6WwsXfCtAhG6Q/NI/8R6+em/XSRB
	 h9fX8KGfAVc7iCrurq0YX/ia5C48LacECREiuf22TbmTHOYWnNTFrabxQeK6L+A9Hr5XV
	 8TUy89IqNYk1vfADYLUl/e2J7wKkECMFCrW3FQAuLSN7L0yPSZpiAydHBHtXNyRRqJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=WeYNsnTq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249F7606A323
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 249F7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=WeYNsnTq
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5ebf39def3aso1424501e0c.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:03:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793113409; cv=none;
        d=google.com; s=arc-20260327;
        b=qAQ8JH2pKG6S03N83QzZCzfr6zqNfYXVL1LECqyenFkE5Whv7geR9CcVwJdOKxLHYt
         N2opJiz9vCTmhwtNciAwsByS785QZ1ASrWzYcxSQLYIJ86NNvoiPzX6GL+S3qktXKrLI
         +a98eTuV4LE5scf6LUnOuUV+N2Z8Lkjo1yyEjjoxXAA5/P+BmYbAJFWqbiiLMM8zN5NI
         l9rdIl2183lmS4mBT+FTQ47oBLJzzlcHVHI/B59ugQ9pqfilJw8sUCogrPZP0B4DkuCc
         mms6RTS5Q4wm0bEqqkCAO5xzx46NEZNCSGAWLhzppqpUvQoR2VqGgLqB3ZMKbiTzeCo3
         GXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q4yjzdXp7FCkLMermgzdi57SXBbbuDvC0SxPh7Oh9/M=;
        fh=rInb3mPUX/3VJYdWHkamlI95bWOCWFbBTy21uJWBgH0=;
        b=Cx9SQG6iMvx5CBKSeXbELiLynwAYLDnhW7N11ajHGDt3hsrBTC44VG/Ebqry2ohwj3
         o0XijBCVRhti69jwLuycDUhbUXnijq656B2HikRTFSL1lYURYzS0fwXEkxRFpCSGfQj/
         +8i0i39xBUiLmsmJYsOMLvgzBPc8vluiBvePeVFvjdthafEVAD2PU7Zkb/v/3gGzSuRj
         HokgHtNahBp4S11bRZpT/64AuA4rtdpCR3a8tZ4Pv4beyP41jSHtnLWJlXCJdGyqgCfK
         Cd1Oqqh51fnnyo3zPmF9pWCo090dxFbF+kqiAfBnkNwf/RfaRADpXDKei53/+aQjnEp3
         8lBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1793113409; x=1793718209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q4yjzdXp7FCkLMermgzdi57SXBbbuDvC0SxPh7Oh9/M=;
        b=WeYNsnTqWZaF3xsNZX5JViJKmK7h4YyKeRJS3ghyg044jPC8aI4WLIowLZD/nrYXAE
         4TLAdMD+bPCnBgDqbi1tXwZA0LCgtiRKL/xKY5zG2j2tNUWVKYgmU/qkRT2w30jWjGbP
         3AojjbEL4Q2FuhYBvGWXnUK83eoevXqZCIs+g2Sq0kJ0i9wIgp1xGxIG01zsmygoFgJj
         buaIxfU5spY57qEtKPG94lYfIsX3NqOykWXO8l/z4kClTfs/fYLga35qF+KXHztHdMEw
         3KdFMbCQA1qqEXvrRvVdSX4a5TUmwHVkgIoBnbXdP7cMjCo+oJuXuRymj8LNc7AslSmo
         AD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793113409; x=1793718209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q4yjzdXp7FCkLMermgzdi57SXBbbuDvC0SxPh7Oh9/M=;
        b=E+n4001F2X5TEqWcH1K0h4rjuKc1ICuzTZWv1m0/m10YNPGjuDYAD05T6dMhdTjAx6
         nK1vMsoUMHYiQVMxAi72zLJJf3sykc71Zuzyf2L/VUtJRUbpUAEFmOlJs/xI7dNSNiGX
         iXYa6Lir8jO8vXMZcLHl7QmjSbjLEQF09Jn2MKg9HcCaoXcpXODHIza3Zp3+THOMk8i+
         8nR32J1DeDeHIo375XLVF8xIJ7R97vK5o3zZSmUkrx6y51hOFbb+dfZ14bKQBqNRcrYR
         I0mFB+zFGJuu90LpIVYTS7hQ53nyRhPcPX/dhgLzJ0oJsXPmnS4PMqoL9oSPsfCq199r
         fBnA==
X-Gm-Message-State: AFq9FYK6fiTNKUcuZRUm3SZXi/ld+AFqRhk1HK+HuhbkssQh4QyppdP3
	X3UVRHMS4joVGYfiqmgqSdf5rU5qgtoKWJpmnJsv7zB1hgrZ/sVVQpNF3H72h9LP6Ana2sRXA3O
	lg2lbcb/EQjRITwW/S08qizxjYGIevk1/DkcmjsSKYw==
X-Gm-Gg: AYBFou0aB4OkFJKioDiyQTAVhc/ByVMGqXrX06rnpwqvSxU1gR/6a2L/H+ypigrtIEG
	UESQFAowPqyahRHjWK3sBtVkQZN/WC5Wt0IthccYI8n3ELOwMisjItQwwnLQ01WhYtkUm30GW2d
	hDPgk4QpSw+ohRJdgl8XPNGS79klcCiy/vzYRmBdmeV8uf1/XBZ719GIYB1QGMHYHqWxdb2DvJp
	CTF/LRXpVr8cNDX6uKT74kGlSfXaSmSbOwMacIkYMds9U8AEbjhW1534oGITh0hnNcEQp5AFfOc
	FLeGCiXLWYUSrZCgZoG91RC2ZyY7Dd8JptCKd1Yu0sUyGtExyqr9IODq5tcAi8o1H9NPSPvgSdk
	sF08S4Tv1NesbHY6/ckoTwhtjTSiKzgNJa/JbewoL58uHKF/E0VNcpw5bj9hVnReulsMhn6LHJ3
	uU9Dt/ACAiB3mwTU68E1ps+KbQ3CTLi7Q1jdZ64PxCtwkynX1XDlsgPPBUDMHW+pDSncOzr4o0k
	PTO1hAQ0QxhDXFeI0apnAKD
X-Received: by 2002:a05:6122:20ac:b0:5ce:ab22:1749 with SMTP id
 71dfb90a1353d-5ec23091f23mr3869101e0c.1.1793113408876; Tue, 27 Oct 2026
 08:03:28 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020181147.939575-2-rjethwani@purestorage.com> <179287171668.3134.17927231522917764342@kernel.org>
In-Reply-To: <179287171668.3134.17927231522917764342@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Tue, 27 Oct 2026 08:03:17 -0700
X-Gm-Features: AclHuK9yL4WWAq3mrPn8b4cfVf3joHDTYv2MvTxMA1PYLKyDQCOolR3KWG6ODwQ
Message-ID: <CAKaoeS2Gj86TpdD6_BY=emw0eaDZ5Yp9LuHoBBYjxP1sg5mxow@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] selftests: net: add TLS 1.2 hardware offload tests
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, john.fastabend@gmail.com, 
	kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, aviadye@mellanox.com, ilyal@mellanox.com, 
	borisp@mellanox.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 12:55=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] test_tls_offload() in
>   tools/testing/selftests/drivers/net/hw/tls_hw_offload.py skips the=E2=
=80=A6
> - [Medium] main() in tls_hw_offload.py raises KsftSkipEx outside
>   ksft_run().
> - [Low] The comment on HW_NIC_COUNTERS says '*_packets increment once per
>   packet the NIC actually encrypted or decrypted ... so they prove the=E2=
=80=A6
>
> --
>
> selftests: net: add TLS 1.2 hardware offload tests
>
> This adds a two-node kTLS hardware offload selftest. A C helper installs
> fixed AES-GCM keys on both endpoints, and a Python harness runs echo
> traffic over IPv4/IPv6 with different payload sizes, checking the TLS MIB
> and NIC ethtool counters to confirm HW offload in each enabled DUT
> direction. It also adds handshake and alert record-type regression cases
> for the push_pending_record fix.
>
> > diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py b=
/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> > new file mode 100755
> > index 0000000000000..37f26e21a7b78
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> > @@ -0,0 +1,402 @@
>
> [ ... ]
>
> > +# TlsTxDevice/TlsRxDevice in /proc/net/tls_stat only prove tls_dev_add=
()
> > +# accepted the offload:
> > +#  - *_packets increment once per packet the NIC actually encrypted or
> > +#    decrypted (mlx5 counts gso_segs, not records), so they prove the =
HW
> > +#    crypto path was exercised.
>
> [Severity: Low]
> Is this description accurate for the TX side? Documentation/networking/
> tls-offload.rst defines the counter as:
>
>   tx_tls_encrypted_packets - number of TX packets passed to the device
>   for encryption of their TLS payload.
>
> mlx5 increments it in the driver xmit path while it builds the
> descriptor. It does not wait for a hardware completion:
>
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c:mlx5e_ktls_han=
dle_tx_skb() {
>     ...
>     stats->tls_encrypted_packets +=3D skb_is_gso(skb) ? skb_shinfo(skb)->=
gso_segs : 1;
>     ...
> }
>
> So the ksft_ge() on tx_tls_encrypted_packets in check_hw_crypto() shows
> that the driver handed TLS packets to the offload path. It does not show
> that the NIC encrypted them. A broken HW encrypt would most likely still
> be caught by the peer's TlsDecryptError check or the echo memcmp(). The
> gap is only in what this comment and the "NIC reported no HW crypto"
> message claim.
>
> Could the comment be reworded to match the documented semantics?
>
> > +#  - *_ctx increment once per tls_dev_add().
> > +# Missing NIC crypto counters remain optional.
>
> [ ... ]
>
> > +# Drivers whose tls_dev_add() accepts only AES-GCM-128: nfp
> > +# (nfp_net_cipher_supported()), cxgb4 (chcr_ktls), funeth.
> > +GCM128_ONLY_DRIVERS =3D {"nfp", "nfp_netvf", "cxgb4", "funeth"}
>
> [ ... ]
>
> > +def test_tls_offload(cfg, cipher, tls_version, ipver):
> > +    """Cipher/version matrix over the HW offload data path."""
> > +    # The tls-hw-{tx,rx}-offload feature bits do not advertise cipher
> > +    # support, and there is no uAPI to query it. Skip AES-GCM-256 on d=
rivers
> > +    # whose tls_dev_add() accepts only AES-GCM-128; keep the HW assert=
ions
> > +    # for every other driver/cipher pair.
> > +    if tls_version =3D=3D "1.2" and cipher =3D=3D "256":
> > +        info =3D cmd(f"ethtool -i {cfg.ifname}", fail=3DFalse).stdout
> > +        for line in info.splitlines():
> > +            name, _, value =3D line.partition(':')
> > +            driver =3D value.strip()
> > +            if name.strip() =3D=3D 'driver' and driver in GCM128_ONLY_=
DRIVERS:
> > +                raise KsftSkipEx(f"{driver} TLS offload supports only =
AES-GCM-128")
> > +
> > +    run_tls_test(cfg, cipher=3Dcipher, tls_version=3Dtls_version, ipve=
r=3Dipver)
>
> [Severity: Medium]
> Can the tls12_aes256 variant report a false failure on mlx5 devices that
> lack the AES-GCM-256 capability?
>
> On mlx5, AES-GCM-256 support is a per-device capability bit, not a
> property of the driver. mlx5e_is_ktls_device() turns on the tls-hw
> offload features when the device reports either tls_1_2_aes_gcm_128 or
> tls_1_2_aes_gcm_256. mlx5e_ktls_add() then rejects any cipher the device
> lacks:
>
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h:mlx5e_ktls_type_c=
heck() {
>     ...
>     case TLS_CIPHER_AES_GCM_256:
>         if (crypto_info->version =3D=3D TLS_1_2_VERSION)
>             return MLX5_CAP_TLS(mdev,  tls_1_2_aes_gcm_256);
>     ...
> }
>
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c:mlx5e_ktls_add() =
{
>     ...
>     if (!mlx5e_ktls_type_check(mdev, crypto_info))
>         return -EOPNOTSUPP;
>     ...
> }
>
> When that happens, do_tls_setsockopt_conf() in net/tls/tls_main.c falls
> back to tls_set_sw_offload() and bumps TlsTxSw/TlsRxSw. setsockopt()
> still succeeds, so the C helper sees no error.
>
> mlx5_core is not in GCM128_ONLY_DRIVERS, so check_path() with
> require_hw=3DTrue then fails with "HW offload not engaged", even though t=
he
> device is behaving as designed.
>
> Would it be more robust to detect this cipher-specific SW fallback
> (Device delta of 0, Sw delta of at least 1, no TlsDecryptError) and raise
> KsftSkipEx, rather than relying on a list of driver names?
>
> [ ... ]
>
> > +def main() -> None:
> > +    """Set up the DUT/peer environment and run the offload test suites=
."""
> > +    with NetDrvEpEnv(__file__, nsim_test=3DFalse) as cfg:
> > +        cfg.bin_local =3D cfg.test_dir / "tls_hw_offload"
> > +        if not cfg.bin_local.exists():
> > +            raise KsftSkipEx(f"tls_hw_offload binary not found at {cfg=
.bin_local}")
> > +        cfg.bin_remote =3D cfg.remote.deploy(cfg.bin_local)
> > +        check_tls_support(cfg)
> > +        cfg.cleanup_failed =3D False
> > +
> > +        ksft_run([test_tls_offload, test_tls_offload_sizes,
> > +                  test_tls_offload_record_type], args=3D(cfg, ))
> > +    ksft_exit()
>
> [Severity: Medium]
> Does raising KsftSkipEx here, outside ksft_run(), turn the expected skip
> cases into failures?
>
> The missing-binary check raises directly. check_tls_support() also
> raises KsftSkipEx when /proc/net/tls_stat is missing on either host, when
> ethtool -k fails, or when the DUT has neither tls-hw-tx-offload nor
> tls-hw-rx-offload enabled.
>
> KsftSkipEx only becomes a SKIP result inside the per-case loop of
> ksft_run():
>
> tools/testing/selftests/net/lib/py/ksft.py:ksft_run() {
>     ...
>         except KsftSkipEx as e:
>             comment =3D "SKIP " + str(e)
>             cnt_key =3D 'skip'
>     ...
> }
>
> NetDrvEnvBase.__exit__() only calls self.__del__() and returns None, so
> the exception reaches the interpreter. The result is a traceback, exit
> status 1 and no KTAP output, and ksft_exit() is never reached.
>
> Most NICs have no kTLS HW offload, and on all of them the kselftest
> runner would record this test as FAIL instead of SKIP.
>
> Could these checks move into the test cases? Alternatively, main() could
> catch KsftSkipEx and exit with KSFT_SKIP (4).
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261020181147.939575-1-rjethwani%40purestorage.com

pw-bot: cr
