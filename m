Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794252162;
	b=0an2uikhZpj4yOxIQbkgj/wR26/yd9Q+ayHMgvzwhmHWw92P1RLnqgTb0PfBeuIkqDtc
	 8haEjlNkT/lNxAOsFiQEULYW3FGEmCb5f16siZFx8GWhmOhu55m5SkExJvvum9G2Wl3lx
	 6/qVLm10ZluI1HXwH8HECZbb8kjlldcivSSVCBnij/6GJZ9gxWCtoqDkun094ovkNYjb7
	 6Axvxi5mkaj8tN7Z01KcK879fQWKoFTRCloLvLsV/AVfzE3hHOprwU/pGx4XEze1GXuUW
	 SVo6hzE0FvWa33sUciKLVYgNJPBJ0SUIlOVkQH2NhyBItbwkwXJ2Z+J31iH8g62Elow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LLao974SFbGrAFOc9ZItbe9BnZuev5xDOa9+ftx6B9Q=;
	b=jgrEJOx0JU/1TKe1FLiumzsNilgp+VDc9lI0u3jFJmjDuarrSUgEwTQgYSa8wdMa+p1g
	 eyuKuVq8bx6vWyzESYwX9OhEbIioxJVEpZljQgO0lDzpFTREdI0TkiDBtUVnaBLDx0Vzh
	 PsYggw0iyMJJ6m4HAD00bl3zUwGzM58dOqhKOqxJ0rXTVuQqQZDUqDv3qlueZ2X7hJd4I
	 7O5JA013umyeR49QYvTTzEQZRvKxuTimaeIfxOdlNVxo7ciUgKDi0GynJAwfgEC3Cfk9h
	 13VqkruxWIlIP16SSi4OonGtx5P8ER1wpWTnv41WQNkQSBBiug01jih9DIsniRo8DtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q7W6CbW2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48978606A326
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 19:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48978606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q7W6CbW2
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2eb0a52d605so8695ad.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 11:22:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794252162; cv=none;
        d=google.com; s=arc-20260327;
        b=A+6wh8kxxSjKKquTwJ3J0eNnv2XBZDBYWSWf2xgcuzwwb/AmohbmPP/U8z8sexR9KA
         XqOnVV6YmNjK04zOtX9QheqVJ/24/uNBOD2XUZjaqUkLfq6xTaU5hLsaDd+Y+jY3o3LZ
         +E6eolIHvYqgAxdrBCQ8bzI/AI5d1OOUFw+7ubg1G9IxnPjgz7C2JFTLpXcWcrrGh3Tl
         n/kMQFmwmjRES7VEYpTsktTdQsOdeQD7NYlFxBT7n3Tzl/xfYUw8vgYxHwhXvGhjqhXS
         etxRMxNVDJYlX433+74suzRtBtvZSlErSZDLI8SYR9QxKX4eDV0LZLgqggC5/A9dOZ+2
         XB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LLao974SFbGrAFOc9ZItbe9BnZuev5xDOa9+ftx6B9Q=;
        fh=YtyPaM6Gko8OXJxKWKDjOHPpHV3aDxp15JL2iE9ryBE=;
        b=GMM0F90zJNk3URXu2mPVpsh/jI8WNsaAknaOQJfnSpPAqIacL02ajLaV7h11E6gKwJ
         MlY9bcH6ptnaRZ+RDV4qnFQd6gyIq+WZ5NDB3D2MZWdb+MmLwDed0iqJwpAZ11H+9xUf
         iBl18EAgMs4uFPsqjN621NvQa0L1FbMY0TVMnqYgu0N+NQcNpkosCLYbC1CLmsDDEku0
         nAeCm4rAf0wIe7AEtU6f8YPjtCaakvy5X6WC/NUDnsAwRH+QZBRDaRTH/NF6ukZDWof+
         VWZAwBbovBjggF/gbPvG7MlvPL7rglJKoAqXmmqFwOdMfxD57MpWdbzcrV9u48J0fo95
         SB2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794252162; x=1794856962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LLao974SFbGrAFOc9ZItbe9BnZuev5xDOa9+ftx6B9Q=;
        b=Q7W6CbW2DnMmN8nOmW0oV5cTwDlZWqZv46jbh2BGl5piP5k0dPOvNu6QGatCKYTqav
         4Jpo7Pc0hCxzIrF/9fjFYDSJ2Cbhc+N8EFLc5CM52PxkXSDxG9hWOlg90UTA1OBnJc3y
         lNiQkq4AamASV5/qd/Z/tlbVmSAOOsQ1xUeyEefy2P8t3DS4q9F6skjUEqCrb4cOcUeZ
         XfvARrykJfhdjsmhygS0DbDFVqDkYfVLOeHkiifyTLlS0JZUONWBpHh3txgzXVxOWj1r
         TCu38lBlOgRroxC2XrHOfajBfBkpFJcnsGXJSsLKFIhHZy7RyqoX3Iam+m4CjX5V3Ovl
         wpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794252162; x=1794856962;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LLao974SFbGrAFOc9ZItbe9BnZuev5xDOa9+ftx6B9Q=;
        b=HoBtmk3wGXFtAjVoNXUTGMtaH5vj6243HQkg/m9El3QOnqoUKkRgfgbQ7XXr4SHa9l
         6uOQmebl/Uk/UW15/KrH12JxeO3UaD0aIkrELvEZhsIiaeGcHvdiWSlnDSjTX4NrL0PA
         FnK7Ri6j8DDBOrWXC+Wt7kuwLPkMoE9En+46w778XlYi/QzncZT+Ks/Yz6h1/yp6I7b0
         HHXdQqZycs/8J0VLZphWZSEDnfPAoAT81ha6AF2oqEhkPaQuiNNyb3rBzkdbWpUjOhss
         wIl4ZEgujGeGMPKl6eHON/c1ECCMXTqoCg9toA0gG7wZUg6ncqA1dJYSVS+EGnqy+iho
         NRVQ==
X-Forwarded-Encrypted: i=1; AL+hErHdQjacsjpu4kR4PQ+dPlxRqq1VHQMRvEhgfr1TB91UDqzQR24Io8tpG0XadXQFJnZPv260X/s=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kFei0g0nCUrdiqxx1NvV7gVeHwpdSzY38FNHv63vKoqUqXOpJ
	jKQo4qOvU287WY32Hs5/BPTEx3vH3K5VkxLFusPM+BLPYRWElCjtHejsWxCIHbQcihyvf1tAYNs
	14Tm6trWC058z2/o1/aqAPvj4uMtwmg03tgEI0sNi
X-Gm-Gg: AYBFou1TPVoudPimsW8eHGJyyEJurrKMD/IYUtKEGlOmUb0KRyZhjDRGTtqdg6j58rk
	ulyJVUiVjRaZRyTabuK0Km3+BhQbgMrux/JF0krcbSvqvUqOXPGYw7zEwWjEZhiYErN9Qj3DgWh
	jVMMeKBc4fu2VBl/WuN9kQHmz9UXGyjdvKd0muoGKJX6bdhEe2PeGcVWynKV1DPE9OwwEtxveVS
	Ef8aofLdfD4zCvwqneIBSijx/oXjG6pEDbz0bWtgkKcIw4GHSqp1bhVZtYSiDHe1wbxchZp8EGh
	s0lZUhSDVuuix8A7uT/zUHFSkNIsmToNIc0NrsXwEhHdRCjQ+twwX8AxhCh7xUKXvqDWtAX0RYp
	tGT17FvMh0Oj0K1KXyNfX0Pp+7DTYkGaBydk4fWwoqPbjyP/3ayhY6l8flpNoIV8veCok7S+C5I
	SBUvaYqu9Kwz/olGc+h0foOYvXe7BwAsvWeJwPzg==
X-Received: by 2002:a17:902:d50b:b0:2c7:f0cc:dafa with SMTP id
 d9443c01a7336-2edb818a98amr440015ad.5.1794252160963; Mon, 09 Nov 2026
 11:22:40 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104061329.1881388-1-yhlee@isslab.korea.ac.kr>
In-Reply-To: <20261104061329.1881388-1-yhlee@isslab.korea.ac.kr>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Mon, 9 Nov 2026 11:22:29 -0800
X-Gm-Features: AclHuK-dSXSOZJcdql0F-e1NjY7WlxygjqtWsM5ArXziTxSc4EqUQRQSgcxZ4fo
Message-ID: <CAEAWyHdJNjhV4biOFR+cw0MWNMZHUT638+AT9Q83s9G7wyBsgw@mail.gmail.com>
Subject: Re: [PATCH net] gve: bound the device reported rule count in the flow
 rules query
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Joshua Washington <joshwash@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jeroen de Borst <jeroendb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 10:13=E2=80=AFPM Yehyeong Lee <yhlee@isslab.korea.ac=
.kr> wrote:
>
> gve_adminq_process_flow_rules_query() turns num_queried_rules, which the
> device wrote into the admin queue buffer, into a copy length:
>
>         num_queried_rules =3D be32_to_cpu(descriptor->num_queried_rules);
>         rule_info =3D (void *)(descriptor + 1);
>         ...
>         rule_info_len =3D num_queried_rules *
>                         sizeof(*flow_rules_cache->rules_cache);
>         if (sizeof(*descriptor) + rule_info_len !=3D total_memory_len) {
>                 dev_err(&priv->dev->dev, "flow rules query is out of memo=
ry.\n");
>                 return -ENOMEM;
>         }
>
>         memcpy(flow_rules_cache->rules_cache, rule_info, rule_info_len);
>
> Nothing bounds that length.  The test above does not, because
> total_memory_len is descriptor->total_length and the same device wrote it=
,
> so it only asks the device to agree with itself.
>
> There are two consequences.  For GVE_FLOW_RULE_QUERY_RULES the copy runs
> past the cache: at 47 rules it writes 4136 bytes into the 4048 byte
> rules_cache, and rules_cache_num is then set to that count for the ethtoo=
l
> paths to walk.  For GVE_FLOW_RULE_QUERY_IDS the destination is large
> enough, but the descriptor and the rule array share one
> GVE_ADMINQ_BUFFER_SIZE block and the array starts after the descriptor, s=
o
> counts of 1021 to 1024 read past that 4096 byte block.  Those words reach
> userspace through ETHTOOL_GRXCLSRLALL, which needs no CAP_NET_ADMIN
> because net/ethtool/ioctl.c exempts it, and gve_get_flow_rule_ids() asks
> the device again on every call.
>
> Bound the count by the space the array actually has, the admin queue
> buffer less the descriptor, before the multiply that cannot then overflow
> either.  That is 46 rules and 1020 ids, and it is never larger than the
> destination cache.  The total_length test stays, since it still catches a
> descriptor whose payload was truncated.
>
> Reproduced with a KUnit harness that injects the device reply and is not
> part of this patch.  Unpatched, 47 rules gave the report below, and 1021

gve, like other drivers, trusts device responses per
Documentation/process/threat-model.rst ('Non-conforming devices and
media') documented at
https://docs.kernel.org/process/threat-model.html.

The driver already communicates an 'available_length' field to the
device as part of gve_adminq_query_flow_rules() and no real device
would violate that. We don't harden against arbitrary devices. This
should be dropped.

> and 1024 ids copied 4084 and 4096 bytes from the descriptor's end, 4 and
> 16 bytes past the block.  With the patch all three are rejected with
> -EINVAL, and 46 rules and 1020 ids still work.
>
>   BUG: KASAN: slab-out-of-bounds in gve_adminq_process_flow_rules_query+0=
xe7/0x390
>   Write of size 4136 at addr ffff8880027ae000 by task kunit_try_catch/33
>
>   CPU: 0 UID: 0 PID: 33 Comm: kunit_try_catch Tainted: G                 =
N  7.3.0-dirty #8 PREEMPT(lazy)
>   Tainted: [N]=3DTEST
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x3f/0x50
>    print_report+0xcd/0x620
>    ? gve_adminq_process_flow_rules_query+0xe7/0x390
>    kasan_report+0xde/0x110
>    ? gve_adminq_process_flow_rules_query+0xe7/0x390
>    kasan_check_range+0x105/0x1b0
>    __asan_memcpy+0x3c/0x60
>    gve_adminq_process_flow_rules_query+0xe7/0x390
>    gve_fr_rules_overflow_test+0xc9/0x430
>    ? __pfx_gve_fr_rules_overflow_test+0x10/0x10
>    ? __pfx___set_cpus_allowed_ptr+0x10/0x10
>    ? __pfx_read_tsc+0x10/0x10
>    ? ktime_get_ts64+0x192/0x250
>    kunit_try_run_case+0x1ca/0x4b0
>    ? __pfx_kunit_try_run_case+0x10/0x10
>    ? kthread_affine_node+0x247/0x360
>    ? __pfx_kthread_affine_node+0x10/0x10
>    ? __pfx_kunit_try_run_case+0x10/0x10
>    ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
>    kunit_generic_run_threadfn_adapter+0x7b/0xe0
>    kthread+0x36a/0x4f0
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork+0x34d/0x620
>    ? __pfx_ret_from_fork+0x10/0x10
>    ? __switch_to+0x22/0xde0
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork_asm+0x19/0x30
>    </TASK>
>
>   Allocated by task 33:
>    kasan_save_stack+0x33/0x60
>    kasan_save_track+0x14/0x30
>    __kasan_kmalloc+0x8f/0xa0
>    __kvmalloc_node_noprof+0x1e8/0x4e0
>    gve_fr_ctx_init+0x24d/0x920
>    gve_fr_rules_overflow_test+0xae/0x430
>    kunit_try_run_case+0x1ca/0x4b0
>    kunit_generic_run_threadfn_adapter+0x7b/0xe0
>    kthread+0x36a/0x4f0
>    ret_from_fork+0x34d/0x620
>    ret_from_fork_asm+0x19/0x30
>
>   The buggy address belongs to the object at ffff8880027ae000
>    which belongs to the cache kmalloc-4k of size 4096
>   The buggy address is located 0 bytes inside of
>    allocated 4048-byte region [ffff8880027ae000, ffff8880027aefd0)
>
>   The buggy address belongs to the physical page:
>   page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27=
a8
>   head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>   flags: 0x4000000000000040(head|zone=3D1)
>   page_type: f5(slab)
>   raw: 4000000000000040 ffff888001042140 dead000000000122 000000000000000=
0
>   raw: 0000000000000000 0000000000040004 00000000f5000000 000000000000000=
0
>   head: 4000000000000040 ffff888001042140 dead000000000122 00000000000000=
00
>   head: 0000000000000000 0000000000040004 00000000f5000000 00000000000000=
00
>   head: 4000000000000003 ffffea000009ea01 00000000ffffffff 00000000ffffff=
ff
>   head: 0000000000000000 0000000000000000 00000000ffffffff 00000000000000=
00
>   page dumped because: kasan: bad access detected
>
>   Memory state around the buggy address:
>    ffff8880027aee80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    ffff8880027aef00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   >ffff8880027aef80: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
>                                                    ^
>    ffff8880027af000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>    ffff8880027af080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>
> Fixes: 57718b60df9b ("gve: Add flow steering adminq commands")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
> ---
>  drivers/net/ethernet/google/gve/gve_adminq.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index 8b215fca9c1b63..02c1f398f6e395 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -1542,14 +1542,20 @@ static int gve_adminq_process_flow_rules_query(st=
ruct gve_priv *priv, u16 query_
>  {
>         struct gve_flow_rules_cache *flow_rules_cache =3D &priv->flow_rul=
es_cache;
>         u32 num_queried_rules, total_memory_len, rule_info_len;
> +       u32 rule_info_max_len;
>         void *rule_info;
>
>         total_memory_len =3D be32_to_cpu(descriptor->total_length);
>         num_queried_rules =3D be32_to_cpu(descriptor->num_queried_rules);
>         rule_info =3D (void *)(descriptor + 1);
> +       rule_info_max_len =3D GVE_ADMINQ_BUFFER_SIZE - sizeof(*descriptor=
);
>
>         switch (query_opcode) {
>         case GVE_FLOW_RULE_QUERY_RULES:
> +               if (num_queried_rules >
> +                   rule_info_max_len / sizeof(*flow_rules_cache->rules_c=
ache))
> +                       return -EINVAL;
> +
>                 rule_info_len =3D num_queried_rules * sizeof(*flow_rules_=
cache->rules_cache);
>                 if (sizeof(*descriptor) + rule_info_len !=3D total_memory=
_len) {
>                         dev_err(&priv->dev->dev, "flow rules query is out=
 of memory.\n");
> @@ -1560,6 +1566,10 @@ static int gve_adminq_process_flow_rules_query(str=
uct gve_priv *priv, u16 query_
>                 flow_rules_cache->rules_cache_num =3D num_queried_rules;
>                 break;
>         case GVE_FLOW_RULE_QUERY_IDS:
> +               if (num_queried_rules >
> +                   rule_info_max_len / sizeof(*flow_rules_cache->rule_id=
s_cache))
> +                       return -EINVAL;
> +
>                 rule_info_len =3D num_queried_rules * sizeof(*flow_rules_=
cache->rule_ids_cache);
>                 if (sizeof(*descriptor) + rule_info_len !=3D total_memory=
_len) {
>                         dev_err(&priv->dev->dev, "flow rule ids query is =
out of memory.\n");
>
> base-commit: 787268686c64be60023743b527645a907e38ccca
> --
> 2.43.0
>
