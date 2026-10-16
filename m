Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDB02931C0
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166181; cv=pass; b=Ew1uE+/pdYcqZqfsoNlyGgTiDHG3hbrczuF/Lcyb2MneamdlbnCb8CQwBK71PSGco2yJcWW9ccfNWMAoHioFxLpTkcPGhDib+0GZ2gP0Yby+hGJYVuKhIWanzNM+1jNE7E4qR/PKS/+CBGS85j9fRbBIonn8ilmAxQElYwCAnLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166181; c=relaxed/simple;
	bh=g+1/ATvQ2ydMyObL1T4qezdyac6hIlA9Hpx1zeTa8Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urcURGOrFf7v3tLEl2qS73WbJzA4s+FQYydY4B0hSHrMxpZlZ3X3076Iyh6JrH+U88xubxG8P4g1jejek6iB5TntBnV1PrG3/pt3weV1hVrbiR43dVsfo+twfrMOExTi3JohgJuR1apT9S53GaYgH8HoAUUDW0KBn40VNFx9+gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mr+Qnp/o; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mr+Qnp/o"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5337c7b9937so364021cf.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:56:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792166178; cv=none;
        d=google.com; s=arc-20260327;
        b=PWo+T3DF/irECYESiUARWBVaY7UQI30q0iaQDZ9mUkFFK+uIsVudW2wVvoIpTFkYto
         CWHbdTCHoISP0EiW304lcZQy1R1uKzrVbisGP6ENf6GwMHNY8vZbvuQ33///yFzLu2+y
         /XGEniiD9uLPFalklZyzKDm/1htEuh0WkjMiiF1+lyy4U/f6zjMKYH8AIS45fV3/8Zf9
         QPW0way01w7YXbzdjFnXKXjv/qroWRd9bwMUFEwQ+8eDrevy85Q7vGgwXmuPJgfEiYb9
         T2ocOtobrsmfr8CSNWzMEZXxLV0XMhdbyjUHZ6/HW1Qaiv90Ul9LckzgPovPSioxMOLf
         MZ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=g+1/ATvQ2ydMyObL1T4qezdyac6hIlA9Hpx1zeTa8Yo=;
        fh=plSWhiMAuOfoR27xd+hdQ9iswJhYtUzrbU+DLy5wHrQ=;
        b=rRv76/ScVbvs1PE8U0irgraioyNjBBrDv+h7ceVseqpVvK6/+aLb+rHfCwLY7BaBvf
         b/+qm4f+DcsYV3Rn0iYogULyJvqpavtUK39anlqjqgzT/wTPZeb/2PJnU+AITtsWiMcU
         UiBsUeMWF4MumxkKyBFTl5RYBb7voAeaIJrY34URNRXZ5PTm0zPPMhzfK9TGfE+pUgav
         14Zlr6/0AUjaTC7EPikZhsNGkwt7MjOFerZi+AsklEyYh9SI0+jb2G9eYKXyZjNrbSkg
         4dzzcAhicXBcSsbRQLqsvzh9bwcWaPWJpq/essCpA+sRC5nPtOTTQvpqph2sXONvefls
         e5eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792166178; x=1792770978; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g+1/ATvQ2ydMyObL1T4qezdyac6hIlA9Hpx1zeTa8Yo=;
        b=Mr+Qnp/o702LUe629jbWo4tStodruAst8UfYYcRS+lWEltARGAqfceZ2JwlKstJzw0
         eg0bJAaiJOY9zLI5PwOh60nvDfq6jM15FFwu4MkhWDKL18Tz5aM+HMxiRc2C6Z8obIx4
         Oq1xLeZAbQUcrkhmdKKAuGsfC0wr6G6A9do8un/LLnJlGki8M4IEsCOhfCZDN3jWWywY
         /VgoCJ2gB2E9eBrdNu6Y5C96h/B6iQPrYvak39YJpD5ubzD2CVa9ox2t4bxE5WbUGvxv
         Dlmv6tCKddiQtJote9+I8ZX0PdlOdfHtcO3NY8GNCUjpAUZseIiNsFmDOd3uE86CnjDB
         Le3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166178; x=1792770978;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g+1/ATvQ2ydMyObL1T4qezdyac6hIlA9Hpx1zeTa8Yo=;
        b=wBOn0w3/alLAmQ1FgEm1KV+qYZmr9xKMcltfTba/Lf0ZtRUM1UJa2u72alkpW8JLf/
         /Qw3s6Leq5Wcr+DkSXGJqTjbUQCX3aFRFDYYqTOWLUC+Yp8JiXDNeZb03Gn51DnD9d2v
         YGuGhoK1Ypv+ut0b/mTo/kWdEwHSQQXjBV+8I71XD8thVhGl4F7LdnT0qsOIr6yqrGzl
         fcvB1nBgeGIn5Dkt0HK+McAomdu3ZPMaJ28A3MHs12dPVhFTKNy9+EJPw59qQ5eQpvJ0
         pz1rt8kGmoFOXZ9wKayCr9m8Zezin8UtNeIgFBS/VzoFkEzHxKZDTIJCJ0seBburuP+e
         MAYw==
X-Forwarded-Encrypted: i=1; AKwUvBxpgjiFIVaUDcZPpQ3y5Q8OhuN8RRI9wZc2YGEmVcdUwOz2oSAWWfa/fKGfJghu3wgrl1eGEvs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEr4BbxOdjYpu42Lg/8CSnfN1voh/LhRbhPiAqvGJ+ey81Unvb
	4YhWijblm1MuPeMOM8k5VZkLcM3X7053MgHr37Yy4epJcP7mJX7m6zId/14QkHESo8S+tdRtvIE
	vr6eCGmoMyHOFRt7asrdUevJxniwrJRQmC8yPztyI
X-Gm-Gg: AYBFou0MSPXf0JsSO3+Evyd4adnAOmptKVwCtF8vWA/PobLluZ9SoTPOwF44OwLJ4Km
	pt5gGuxT1UGR9Oeep1Q6b3OjEheWyVyGdZXaX4WfVUDQwF8sMD/UUc+ZdP1o06mryjzG9a+93XT
	7Bd0iP4Dsva99c1sele+vmio0cP2Bay31RXk/ClflRnwxHoxV95qALisw+7NdTWZoGWKnr/hdMD
	ITDW5zVixTjQQOyPuCZ6R69pRZ9KzORFBbaKdJUCyCn1mF8FrAoJ5LkBPhiklpVgpLNJKs/AY22
	kCq+IWJfGMn73zkW6F4WR8z2tGCZ+W5y6/s5cm7gRX0EwMHuvIBv97qWl3iDbILT6Abgh/lozmN
	kk992o1elY4s0AuETaGZKGYL7+aqhPWuSu2gaOJyjGUF7HDsRrwNCeG09vg==
X-Received: by 2002:a05:622a:8449:10b0:536:353e:8d2a with SMTP id
 d75a77b69052e-536353e98f0mr9412491cf.1.1792166176813; Fri, 16 Oct 2026
 08:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016084802.2725187-1-edumazet@kernel.org>
In-Reply-To: <20261016084802.2725187-1-edumazet@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 16 Oct 2026 11:55:58 -0400
X-Gm-Features: AclHuK-ozu-By7W0Dbx5g2EXOieegN2sdw-KxfhyQntROIKAV7yNHLXj9viRR5c
Message-ID: <CADVnQynq30ROV3jndQevAWWpk-1iWn+dizW6zwTaO1gdpOZMyw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: tcp_metrics: use the socket netns, not the dst
 device netns
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000005a25ed065df734ea"

--0000000000005a25ed065df734ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 4:48=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> tcp_get_metrics(), __tcp_get_metrics_req() and tcpm_new() look up and
> create metrics entries in the netns of the cached dst device rather than
> in the netns of the socket.
>
> These usually match, but not after the device has been moved to another
> netns or unregistered: a socket can keep a stale dst in sk_dst_cache
> until it is checked again, and tcp_update_metrics() reads it with
> __sk_dst_get() without any dst_check(). Once dst_dev_put() has run, the
> dst device is blackhole_netdev and the entry is created in init_net.
> Before that, for instance for routes through nexthop objects whose
> cached dsts are released from a nested RCU callback, it is the netns the
> device has just been moved to.
>
> A TCP socket of netns A that enters TIME_WAIT in that window then
> creates or updates an entry carrying A's addresses and RTT in another
> netns, where TCP_METRICS_CMD_GET can dump it and where new connections
> to the same peer inherit those metrics.
>
> The metrics belong to the netns of the socket, so use sock_net() for
> full sockets and request sockets, and pass it to tcpm_new().
>
> Kernel sockets that do not hold a netns reference can still reach
> tcp_time_wait() after tcp_net_metrics_exit_batch() has flushed the
> entries of their dismantling netns, and an entry created then would
> never be flushed and would keep a dangling tcpm_net. Make tcpm_new()
> refuse to create entries when check_net() fails. Its callers are in
> an RCU read-side section, and cleanup_net() waits for a grace period
> between the refcount reaching zero and the flush, so an entry added
> after a successful check is always seen by the flush.
>
> Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Cc: Qiliang Yuan <odys.yuan@gmail.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>
Tested-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

I got an LLM to write and run a repro that verifies the bug and
validates the fix. The script and its outputs are attached. In the
control case, both kernels put the entry in netns A. In the three
trigger cases, the base kernel puts the entry in init_net and the
patched kernel puts it in netns A.


neal

--0000000000005a25ed065df734ea
Content-Type: text/plain; charset="US-ASCII"; name="output.txt"
Content-Disposition: attachment; filename="output.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mvb5fdi61>
X-Attachment-Id: f_mvb5fdi61

Ck91dHB1dDoKCiMgQmFzZTogdW5wYXRjaGVkIG5ldC9tYWluICgxOTFhYTQxNTQ4YjIpCikgdGlt
ZSB2bmcgLS1ydW4gL3RtcC9iekltYWdlLmJhc2UgLS1kaXNhYmxlLWt2bSAtLWNwdXMgMiAtLW1l
bW9yeSAyRyAtLXVzZXIgcm9vdCAtLWV4ZWMgInB5dGhvbjMgJFJFUFJPIgprZXJuZWw6IDcuMy4w
LXJjNysKPT09IHY0IG5vbmUgKGNvbnRyb2wpOiAidHJ1ZSIgKGNsaWVudCBzdGF0ZSBiZWZvcmUg
Y2xvc2U6IEZJTi1XQUlULTIpCiAgaW5pdF9uZXQgICAgICAgICAgOiAobm9uZSkKICBuZXRucyBB
IChzb2NrZXQpICA6IDEwLjkuMC4yIGFnZSAwLjQ3MHNlYyBjd25kIDEwIHJ0dCA1OTAwdXMgcnR0
dmFyIDExMjAwdXMgc291cmNlIDEwLjkuMC4xCiAgbmV0bnMgQiAgICAgICAgICAgOiAobm9uZSkK
PT09IHY0IG1vdmUtZGV2LXRvLW5ldG5zLUI6ICJpcCAtbiBBIGxpbmsgc2V0IHZBIG5ldG5zIEIi
IChjbGllbnQgc3RhdGUgYmVmb3JlIGNsb3NlOiBGSU4tV0FJVC0yKQogIGluaXRfbmV0ICAgICAg
ICAgIDogMTAuOS4wLjIgYWdlIDAuMzg0c2VjIGN3bmQgMTAgcnR0IDUxNjR1cyBydHR2YXIgMTAx
ODh1cyBzb3VyY2UgMTAuOS4wLjEKICBuZXRucyBBIChzb2NrZXQpICA6IChub25lKQogIG5ldG5z
IEIgICAgICAgICAgIDogKG5vbmUpCj09PSB2NCBkZWxldGUtZGV2OiAiaXAgLW4gQSBsaW5rIGRl
bCB2QSIgKGNsaWVudCBzdGF0ZSBiZWZvcmUgY2xvc2U6IEZJTi1XQUlULTIpCiAgaW5pdF9uZXQg
ICAgICAgICAgOiAxMC45LjAuMiBhZ2UgMC4zNzlzZWMgY3duZCAxMCBydHQgNTE2NHVzIHJ0dHZh
ciAxMDE2MXVzIHNvdXJjZSAxMC45LjAuMQogIG5ldG5zIEEgKHNvY2tldCkgIDogKG5vbmUpCiAg
bmV0bnMgQiAgICAgICAgICAgOiAobm9uZSkKPT09IHY0IGRlbGV0ZS1hZGRyOiAiaXAgLW4gQSBh
ZGRyIGRlbCAxMC45LjAuMS8yNCBkZXYgdkEiIChjbGllbnQgc3RhdGUgYmVmb3JlIGNsb3NlOiBG
SU4tV0FJVC0yKQogIGluaXRfbmV0ICAgICAgICAgIDogMTAuOS4wLjIgYWdlIDAuMzc5c2VjIGN3
bmQgMTAgcnR0IDUyMDd1cyBydHR2YXIgMTAyNjh1cyBzb3VyY2UgMTAuOS4wLjEKICBuZXRucyBB
IChzb2NrZXQpICA6IChub25lKQogIG5ldG5zIEIgICAgICAgICAgIDogKG5vbmUpCj09PSB2NiBu
b25lIChjb250cm9sKTogInRydWUiIChjbGllbnQgc3RhdGUgYmVmb3JlIGNsb3NlOiBGSU4tV0FJ
VC0yKQogIGluaXRfbmV0ICAgICAgICAgIDogKG5vbmUpCiAgbmV0bnMgQSAoc29ja2V0KSAgOiBm
ZDAwOjk6OjIgYWdlIDAuNDU3c2VjIGN3bmQgMTAgcnR0IDY5Mjg5dXMgcnR0dmFyIDExMzEyMHVz
IHNvdXJjZSBmZDAwOjk6OjEKICBuZXRucyBCICAgICAgICAgICA6IChub25lKQo9PT0gdjYgbW92
ZS1kZXYtdG8tbmV0bnMtQjogImlwIC1uIEEgbGluayBzZXQgdkEgbmV0bnMgQiIgKGNsaWVudCBz
dGF0ZSBiZWZvcmUgY2xvc2U6IEZJTi1XQUlULTIpCiAgaW5pdF9uZXQgICAgICAgICAgOiBmZDAw
Ojk6OjIgYWdlIDAuMzgyc2VjIGN3bmQgMTAgcnR0IDY5MTM0dXMgcnR0dmFyIDExMjk0OHVzIHNv
dXJjZSBmZDAwOjk6OjEKICBuZXRucyBBIChzb2NrZXQpICA6IChub25lKQogIG5ldG5zIEIgICAg
ICAgICAgIDogKG5vbmUpCj09PSB2NiBkZWxldGUtZGV2OiAiaXAgLW4gQSBsaW5rIGRlbCB2QSIg
KGNsaWVudCBzdGF0ZSBiZWZvcmUgY2xvc2U6IEZJTi1XQUlULTIpCiAgaW5pdF9uZXQgICAgICAg
ICAgOiBmZDAwOjk6OjIgYWdlIDAuMzc5c2VjIGN3bmQgMTAgcnR0IDY2NDkydXMgcnR0dmFyIDEw
NzU3OXVzIHNvdXJjZSBmZDAwOjk6OjEKICBuZXRucyBBIChzb2NrZXQpICA6IChub25lKQogIG5l
dG5zIEIgICAgICAgICAgIDogKG5vbmUpCj09PSB2NiBkZWxldGUtYWRkcjogImlwIC1uIEEgLTYg
YWRkciBkZWwgZmQwMDo5OjoxLzY0IGRldiB2QSIgKGNsaWVudCBzdGF0ZSBiZWZvcmUgY2xvc2U6
IEZJTi1XQUlULTIpCiAgaW5pdF9uZXQgICAgICAgICAgOiBmZDAwOjk6OjIgYWdlIDAuMzc2c2Vj
IGN3bmQgMTAgcnR0IDY5MTcydXMgcnR0dmFyIDExMjk0NXVzIHNvdXJjZSBmZDAwOjk6OjEKICBu
ZXRucyBBIChzb2NrZXQpICA6IChub25lKQogIG5ldG5zIEIgICAgICAgICAgIDogKG5vbmUpCgpy
ZWFsICAgIDFtMTIuODYycwp1c2VyICAgIDBtNTYuOTQxcwpzeXMgICAgIDBtMTkuNDcwcwoKIyBQ
YXRjaGVkOiBuZXQvbWFpbiArIEVyaWMncyBwYXRjaAopIHRpbWUgdm5nIC0tcnVuIC90bXAvYnpJ
bWFnZS5wYXRjaGVkIC0tZGlzYWJsZS1rdm0gLS1jcHVzIDIgLS1tZW1vcnkgMkcgLS11c2VyIHJv
b3QgLS1leGVjICJweXRob24zICRSRVBSTyIgOyB4dGVybQprZXJuZWw6IDcuMy4wLXJjNysKPT09
IHY0IG5vbmUgKGNvbnRyb2wpOiAidHJ1ZSIgKGNsaWVudCBzdGF0ZSBiZWZvcmUgY2xvc2U6IEZJ
Ti1XQUlULTIpCiAgaW5pdF9uZXQgICAgICAgICAgOiAobm9uZSkKICBuZXRucyBBIChzb2NrZXQp
ICA6IDEwLjkuMC4yIGFnZSAwLjQ3N3NlYyBjd25kIDEwIHJ0dCA1ODk1dXMgcnR0dmFyIDExMTc0
dXMgc291cmNlIDEwLjkuMC4xCiAgbmV0bnMgQiAgICAgICAgICAgOiAobm9uZSkKPT09IHY0IG1v
dmUtZGV2LXRvLW5ldG5zLUI6ICJpcCAtbiBBIGxpbmsgc2V0IHZBIG5ldG5zIEIiIChjbGllbnQg
c3RhdGUgYmVmb3JlIGNsb3NlOiBGSU4tV0FJVC0yKQogIGluaXRfbmV0ICAgICAgICAgIDogKG5v
bmUpCiAgbmV0bnMgQSAoc29ja2V0KSAgOiAxMC45LjAuMiBhZ2UgMC40ODlzZWMgY3duZCAxMCBy
dHQgNTE1M3VzIHJ0dHZhciAxMDE1MnVzIHNvdXJjZSAxMC45LjAuMQogIG5ldG5zIEIgICAgICAg
ICAgIDogKG5vbmUpCj09PSB2NCBkZWxldGUtZGV2OiAiaXAgLW4gQSBsaW5rIGRlbCB2QSIgKGNs
aWVudCBzdGF0ZSBiZWZvcmUgY2xvc2U6IEZJTi1XQUlULTIpCiAgaW5pdF9uZXQgICAgICAgICAg
OiAobm9uZSkKICBuZXRucyBBIChzb2NrZXQpICA6IDEwLjkuMC4yIGFnZSAwLjQ4NnNlYyBjd25k
IDEwIHJ0dCA1MTQ3dXMgcnR0dmFyIDEwMTUwdXMgc291cmNlIDEwLjkuMC4xCiAgbmV0bnMgQiAg
ICAgICAgICAgOiAobm9uZSkKPT09IHY0IGRlbGV0ZS1hZGRyOiAiaXAgLW4gQSBhZGRyIGRlbCAx
MC45LjAuMS8yNCBkZXYgdkEiIChjbGllbnQgc3RhdGUgYmVmb3JlIGNsb3NlOiBGSU4tV0FJVC0y
KQogIGluaXRfbmV0ICAgICAgICAgIDogKG5vbmUpCiAgbmV0bnMgQSAoc29ja2V0KSAgOiAxMC45
LjAuMiBhZ2UgMC40OTlzZWMgY3duZCAxMCBydHQgNTE0OHVzIHJ0dHZhciAxMDE0NHVzIHNvdXJj
ZSAxMC45LjAuMQogIG5ldG5zIEIgICAgICAgICAgIDogKG5vbmUpCj09PSB2NiBub25lIChjb250
cm9sKTogInRydWUiIChjbGllbnQgc3RhdGUgYmVmb3JlIGNsb3NlOiBGSU4tV0FJVC0yKQogIGlu
aXRfbmV0ICAgICAgICAgIDogKG5vbmUpCiAgbmV0bnMgQSAoc29ja2V0KSAgOiBmZDAwOjk6OjIg
YWdlIDAuNDkwc2VjIGN3bmQgMTAgcnR0IDY3NDMzdXMgcnR0dmFyIDEwOTI3NHVzIHNvdXJjZSBm
ZDAwOjk6OjEKICBuZXRucyBCICAgICAgICAgICA6IChub25lKQo9PT0gdjYgbW92ZS1kZXYtdG8t
bmV0bnMtQjogImlwIC1uIEEgbGluayBzZXQgdkEgbmV0bnMgQiIgKGNsaWVudCBzdGF0ZSBiZWZv
cmUgY2xvc2U6IEZJTi1XQUlULTIpCiAgaW5pdF9uZXQgICAgICAgICAgOiAobm9uZSkKICBuZXRu
cyBBIChzb2NrZXQpICA6IGZkMDA6OTo6MiBhZ2UgMC40ODZzZWMgY3duZCAxMCBydHQgNjgwMTB1
cyBydHR2YXIgMTEwNjI3dXMgc291cmNlIGZkMDA6OTo6MQogIG5ldG5zIEIgICAgICAgICAgIDog
KG5vbmUpCj09PSB2NiBkZWxldGUtZGV2OiAiaXAgLW4gQSBsaW5rIGRlbCB2QSIgKGNsaWVudCBz
dGF0ZSBiZWZvcmUgY2xvc2U6IEZJTi1XQUlULTIpCiAgaW5pdF9uZXQgICAgICAgICAgOiAobm9u
ZSkKICBuZXRucyBBIChzb2NrZXQpICA6IGZkMDA6OTo6MiBhZ2UgMC40OThzZWMgY3duZCAxMCBy
dHQgNjcxNTJ1cyBydHR2YXIgMTA5MTAwdXMgc291cmNlIGZkMDA6OTo6MQogIG5ldG5zIEIgICAg
ICAgICAgIDogKG5vbmUpCj09PSB2NiBkZWxldGUtYWRkcjogImlwIC1uIEEgLTYgYWRkciBkZWwg
ZmQwMDo5OjoxLzY0IGRldiB2QSIgKGNsaWVudCBzdGF0ZSBiZWZvcmUgY2xvc2U6IEZJTi1XQUlU
LTIpCiAgaW5pdF9uZXQgICAgICAgICAgOiAobm9uZSkKICBuZXRucyBBIChzb2NrZXQpICA6IGZk
MDA6OTo6MiBhZ2UgMC40NzZzZWMgY3duZCAxMCBydHQgNjkzODR1cyBydHR2YXIgMTEzMjIwdXMg
c291cmNlIGZkMDA6OTo6MQogIG5ldG5zIEIgICAgICAgICAgIDogKG5vbmUpCgpyZWFsICAgIDFt
MTcuODQ4cwp1c2VyICAgIDBtNTMuOTM3cwpzeXMgICAgIDBtMzAuMDIzcwo=
--0000000000005a25ed065df734ea
Content-Type: text/x-python; charset="US-ASCII"; name="tcpm_netns_repro.py"
Content-Disposition: attachment; filename="tcpm_netns_repro.py"
Content-Transfer-Encoding: base64
Content-ID: <f_mvb5dz970>
X-Attachment-Id: f_mvb5dz970

IyEvdXNyL2Jpbi9lbnYgcHl0aG9uMwojIFJlcHJvZHVjZXIgZm9yOiAidGNwOiB0Y3BfbWV0cmlj
czogdXNlIHRoZSBzb2NrZXQgbmV0bnMsIG5vdCB0aGUgZHN0IGRldmljZSBuZXRucyIKIwojIEEg
VENQIGNsaWVudCBzb2NrZXQgaW4gbmV0bnMgQSBnb2VzIHRvIEZJTl9XQUlUMiAoc2h1dGRvd24o
U0hVVF9XUiksIEZJTiBBQ0tlZCksCiMgdGhlbiBpdHMgcm91dGUvZGV2aWNlIGdvZXMgYXdheSAo
ZGV2aWNlIG1vdmVkIHRvIG5ldG5zIEIsIGRldmljZSBkZWxldGVkLCBvcgojIGFkZHJlc3Mvcm91
dGUgZGVsZXRlZCkgd2hpbGUgdGhlIHNvY2tldCBrZWVwcyB0aGUgbm93LXN0YWxlIGRzdCBpbgoj
IHNrX2RzdF9jYWNoZS4gY2xvc2UoKSB0aGVuIHJ1bnMgdGNwX3RpbWVfd2FpdCgpIC0+IHRjcF91
cGRhdGVfbWV0cmljcygpCiMgc3luY2hyb25vdXNseSwgd2hpY2ggdXNlcyBfX3NrX2RzdF9nZXQo
KSB3aXRob3V0IGRzdF9jaGVjaygpLgojCiMgV2UgdGhlbiByZXBvcnQgaW4gd2hpY2ggbmV0bnMg
dGhlIHRjcF9tZXRyaWNzIGVudHJ5IGZvciB0aGUgcGVlciBzaG93cyB1cC4KIyBFeHBlY3RlZCB3
aXRob3V0IHRoZSBwYXRjaDogaW4gaW5pdF9uZXQgKGRzdC0+ZGV2ID09IGJsYWNraG9sZV9uZXRk
ZXYpLgojIEV4cGVjdGVkIHdpdGggdGhlIHBhdGNoOiAgICBpbiBuZXRucyBBICh0aGUgc29ja2V0
J3MgbmV0bnMpLgoKaW1wb3J0IG9zCmltcG9ydCBzb2NrZXQKaW1wb3J0IHN1YnByb2Nlc3MKaW1w
b3J0IHN5cwppbXBvcnQgdGltZQoKUk9PVF9OUyA9IG9zLm9wZW4oJy9wcm9jL3NlbGYvbnMvbmV0
Jywgb3MuT19SRE9OTFkpCgoKZGVmIHNoKGNtZCwgY2hlY2s9VHJ1ZSk6CiAgICByID0gc3VicHJv
Y2Vzcy5ydW4oY21kLCBzaGVsbD1UcnVlLCBjYXB0dXJlX291dHB1dD1UcnVlLCB0ZXh0PVRydWUp
CiAgICBpZiBjaGVjayBhbmQgci5yZXR1cm5jb2RlOgogICAgICAgIHByaW50KGYnQ01EIEZBSUxF
RDoge2NtZH1cbntyLnN0ZG91dH17ci5zdGRlcnJ9JywgZmx1c2g9VHJ1ZSkKICAgICAgICBzeXMu
ZXhpdCgxKQogICAgcmV0dXJuIHIuc3Rkb3V0CgoKZGVmIGVudGVyX25zKG5hbWUpOgogICAgZmQg
PSBvcy5vcGVuKGYnL3J1bi9uZXRucy97bmFtZX0nLCBvcy5PX1JET05MWSkKICAgIG9zLnNldG5z
KGZkLCBvcy5DTE9ORV9ORVdORVQpCiAgICBvcy5jbG9zZShmZCkKCgpkZWYgZW50ZXJfcm9vdCgp
OgogICAgb3Muc2V0bnMoUk9PVF9OUywgb3MuQ0xPTkVfTkVXTkVUKQoKCmRlZiBtZXRyaWNzKG5z
KToKICAgIHBmeCA9IGYnaXAgLW4ge25zfSAnIGlmIG5zIGVsc2UgJ2lwICcKICAgIG91dCA9IHNo
KHBmeCArICd0Y3BfbWV0cmljcyBzaG93JywgY2hlY2s9RmFsc2UpLnN0cmlwKCkKICAgIHJldHVy
biBvdXQgaWYgb3V0IGVsc2UgJyhub25lKScKCgpkZWYgcmVjdl9leGFjdChzLCBuKToKICAgIGJ1
ZiA9IGInJwogICAgd2hpbGUgbGVuKGJ1ZikgPCBuOgogICAgICAgIGNodW5rID0gcy5yZWN2KG4g
LSBsZW4oYnVmKSkKICAgICAgICBpZiBub3QgY2h1bms6CiAgICAgICAgICAgIHJhaXNlIFJ1bnRp
bWVFcnJvcigndW5leHBlY3RlZCBFT0YnKQogICAgICAgIGJ1ZiArPSBjaHVuawogICAgcmV0dXJu
IGJ1ZgoKCmRlZiBzZXR1cCgpOgogICAgZm9yIG5zIGluICgnQScsICdCJywgJ1MnKToKICAgICAg
ICBzaChmJ2lwIG5ldG5zIGRlbCB7bnN9JywgY2hlY2s9RmFsc2UpCiAgICBzaCgnaXAgdGNwX21l
dHJpY3MgZmx1c2ggYWxsJywgY2hlY2s9RmFsc2UpCiAgICBmb3IgbnMgaW4gKCdBJywgJ0InLCAn
UycpOgogICAgICAgIHNoKGYnaXAgbmV0bnMgYWRkIHtuc30nKQogICAgICAgIHNoKGYnaXAgLW4g
e25zfSBsaW5rIHNldCBsbyB1cCcpCiAgICBzaCgnaXAgbGluayBhZGQgdkEgbmV0bnMgQSB0eXBl
IHZldGggcGVlciBuYW1lIHZTIG5ldG5zIFMnKQogICAgc2goJ2lwIC1uIEEgYWRkciBhZGQgMTAu
OS4wLjEvMjQgZGV2IHZBJykKICAgIHNoKCdpcCAtbiBTIGFkZHIgYWRkIDEwLjkuMC4yLzI0IGRl
diB2UycpCiAgICBzaCgnaXAgLW4gQSAtNiBhZGRyIGFkZCBmZDAwOjk6OjEvNjQgZGV2IHZBIG5v
ZGFkJykKICAgIHNoKCdpcCAtbiBTIC02IGFkZHIgYWRkIGZkMDA6OTo6Mi82NCBkZXYgdlMgbm9k
YWQnKQogICAgc2goJ2lwIC1uIEEgbGluayBzZXQgdkEgdXAnKQogICAgc2goJ2lwIC1uIFMgbGlu
ayBzZXQgdlMgdXAnKQogICAgdGltZS5zbGVlcCgwLjMpCgoKVFJJR0dFUlMgPSB7CiAgICAnbm9u
ZSAoY29udHJvbCknOiAndHJ1ZScsCiAgICAnbW92ZS1kZXYtdG8tbmV0bnMtQic6ICdpcCAtbiBB
IGxpbmsgc2V0IHZBIG5ldG5zIEInLAogICAgJ2RlbGV0ZS1kZXYnOiAnaXAgLW4gQSBsaW5rIGRl
bCB2QScsCiAgICAnZGVsZXRlLWFkZHInOiBOb25lLCAgIyBmaWxsZWQgcGVyIGZhbWlseQp9CgoK
ZGVmIHJ1bl9jYXNlKGZhbWlseSwgdHJpZ2dlcik6CiAgICBzZXR1cCgpCiAgICBpZiBmYW1pbHkg
PT0gc29ja2V0LkFGX0lORVQ6CiAgICAgICAgcGVlciwgZmFtID0gJzEwLjkuMC4yJywgJ3Y0Jwog
ICAgICAgIGFkZHJkZWwgPSAnaXAgLW4gQSBhZGRyIGRlbCAxMC45LjAuMS8yNCBkZXYgdkEnCiAg
ICBlbHNlOgogICAgICAgIHBlZXIsIGZhbSA9ICdmZDAwOjk6OjInLCAndjYnCiAgICAgICAgYWRk
cmRlbCA9ICdpcCAtbiBBIC02IGFkZHIgZGVsIGZkMDA6OTo6MS82NCBkZXYgdkEnCiAgICBjbWQg
PSBUUklHR0VSU1t0cmlnZ2VyXSBvciBhZGRyZGVsCgogICAgZW50ZXJfbnMoJ1MnKQogICAgc3J2
ID0gc29ja2V0LnNvY2tldChmYW1pbHksIHNvY2tldC5TT0NLX1NUUkVBTSkKICAgIHNydi5zZXRz
b2Nrb3B0KHNvY2tldC5TT0xfU09DS0VULCBzb2NrZXQuU09fUkVVU0VBRERSLCAxKQogICAgc3J2
LmJpbmQoKHBlZXIsIDUwMDApKQogICAgc3J2Lmxpc3RlbigxKQogICAgZW50ZXJfbnMoJ0EnKQog
ICAgY2xpID0gc29ja2V0LnNvY2tldChmYW1pbHksIHNvY2tldC5TT0NLX1NUUkVBTSkKICAgIGVu
dGVyX3Jvb3QoKQoKICAgIGNsaS5jb25uZWN0KChwZWVyLCA1MDAwKSkKICAgIGNvbm4sIF8gPSBz
cnYuYWNjZXB0KCkKICAgIGZvciBfIGluIHJhbmdlKDIwKTogICMgZ2V0IGFuIFJUVCBzYW1wbGUK
ICAgICAgICBjbGkuc2VuZGFsbChiJ3gnICogMTAwMCkKICAgICAgICByZWN2X2V4YWN0KGNvbm4s
IDEwMDApCiAgICAgICAgY29ubi5zZW5kYWxsKGIneScgKiAxMDAwKQogICAgICAgIHJlY3ZfZXhh
Y3QoY2xpLCAxMDAwKQogICAgY2xpLnNodXRkb3duKHNvY2tldC5TSFVUX1dSKSAgIyBGSU4gLT4g
QUNLZWQgLT4gRklOX1dBSVQyCiAgICB0aW1lLnNsZWVwKDAuNSkKICAgIHN0YXRlID0gW2xuLnNw
bGl0KClbMF0gZm9yIGxuIGluCiAgICAgICAgICAgICBzaCgnaXAgbmV0bnMgZXhlYyBBIHNzIC1I
dGFuJywgY2hlY2s9RmFsc2UpLnNwbGl0bGluZXMoKQogICAgICAgICAgICAgaWYgJzo1MDAwJyBp
biBsbl0KICAgIHNoKGNtZCkKICAgIHRpbWUuc2xlZXAoMS4wKSAgIyBsZXQgUkNVIGNhbGxiYWNr
cyAoZHN0X2Rldl9wdXQoKSkgcnVuCiAgICBjbGkuY2xvc2UoKSAgIyBGSU5fV0FJVDIgLT4gdGNw
X3RpbWVfd2FpdCgpIC0+IHRjcF91cGRhdGVfbWV0cmljcygpCiAgICB0aW1lLnNsZWVwKDAuMykK
CiAgICBwcmludChmJz09PSB7ZmFtfSB7dHJpZ2dlcn06ICJ7Y21kfSIgKGNsaWVudCBzdGF0ZSBi
ZWZvcmUgY2xvc2U6ICcKICAgICAgICAgIGYne3N0YXRlWzBdIGlmIHN0YXRlIGVsc2UgIj8ifSkn
LCBmbHVzaD1UcnVlKQogICAgZm9yIG5zLCBsYWJlbCBpbiAoKE5vbmUsICdpbml0X25ldCcpLCAo
J0EnLCAnbmV0bnMgQSAoc29ja2V0KScpLAogICAgICAgICAgICAgICAgICAgICAgKCdCJywgJ25l
dG5zIEInKSk6CiAgICAgICAgcHJpbnQoZicgIHtsYWJlbDoxOHN9OiB7bWV0cmljcyhucyl9Jywg
Zmx1c2g9VHJ1ZSkKICAgIGNvbm4uY2xvc2UoKQogICAgc3J2LmNsb3NlKCkKCgpkZWYgbWFpbigp
OgogICAgcHJpbnQoJ2tlcm5lbDonLCBvcy51bmFtZSgpLnJlbGVhc2UsIGZsdXNoPVRydWUpCiAg
ICBmb3IgZmFtaWx5IGluIChzb2NrZXQuQUZfSU5FVCwgc29ja2V0LkFGX0lORVQ2KToKICAgICAg
ICBmb3IgdHJpZ2dlciBpbiBUUklHR0VSUzoKICAgICAgICAgICAgcnVuX2Nhc2UoZmFtaWx5LCB0
cmlnZ2VyKQoKCmlmIF9fbmFtZV9fID09ICdfX21haW5fXyc6CiAgICBtYWluKCkK
--0000000000005a25ed065df734ea--
